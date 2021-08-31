PROJECT="$(cut -d'/' -f5 <<<$PWD)"

NAME="$(cut -d'-' -f2 <<<$PROJECT)"

if [ $NAME = 'project' ]; then
  NAME="$(cut -d'-' -f1 <<<$PROJECT)"
fi

BACKEND="$NAME-backend"
FRONTEND="$NAME-frontend"

echo Backend directory: $BACKEND
echo Frontend directory: $FRONTEND

# Check for css dir, remove it, then move built css to backend
if [ -d "$BACKEND/public/css" ]; then
  rm -r "$BACKEND/public/css"
fi
cp -r "$FRONTEND/dist/css/" "$BACKEND/public/"
echo Moved CSS to backend.

# Check for js dir, remove it, then move built js to backend
if [ -d "$BACKEND/public/js" ]; then
  rm -r "$BACKEND/public/js"
fi
cp -r "$FRONTEND/dist/js/" "$BACKEND/public/"
echo Moved JS to backend.

# Moving favicon
rm "$BACKEND/public/favicon.ico"
cp "$FRONTEND/dist/favicon.ico" "$BACKEND/public/favicon.ico"
echo Moved favicon to backend.

if [ -f "$BACKEND/resources/views/index.blade.php" ]; then
    rm "$BACKEND/resources/views/index.blade.php"
fi
cp "$FRONTEND/dist/index.html" "$BACKEND/resources/views/index.blade.php"
echo Moved index to backend.

