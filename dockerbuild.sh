#!/bin/sh
echo Building nodewebapp from Dockerfile.dev

docker build -t $CI_PROJECT_NAME:$CI_COMMIT_REF -f Dockerfile.dev .

echo Creating Conatiner Out of Image
docker container create --name extract $CI_PROJECT_NAME:$CI_COMMIT_REF
docker container cp extract:/usr/src/app/WebApp/dist ./dist
docker container rm -f extract

echo Building nodewebapp version 2

docker build --no-cache -t $CI_PROJECT_NAME:$CI_COMMIT_REF .
rm ./dist
