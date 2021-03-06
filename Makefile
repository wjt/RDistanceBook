HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd)) \
							$(patsubst %.md, %.html ,$(wildcard *.md))   \
							$(patsubst %.Rmd, %.html ,$(wildcard distance/*.Rmd)) \
							$(patsubst %.md, %.html ,$(wildcard distance/*.md)) \
							$(patsubst %.Rmd, %.html ,$(wildcard dsm/*.Rmd)) \
							$(patsubst %.md, %.html ,$(wildcard dsm/*.md))
graphics_dirs := $(wildcard distance/*_files) \
								 $(wildcard dsm/*_files)

all: html graphics

# build the HTML files and move them into the site directory
html: $(HTML_FILES)

%.html: %.Rmd
				R --vanilla --slave -e "rmarkdown::render('$<')"
#				mv $@ site/
				cp $@ site/

%.html: %.md
				R --vanilla --slave -e "rmarkdown::render('$<')"
#				mv $@ site/
				cp $@ site/

## move the folders with graphics
graphics: $(graphics_dirs)

%_files: %.html
				cp -R $@ site/

# need to do something with libs that has the css/styles
#libs: libs/*
#				mv libs site/


.PHONY: clean
clean:
				rm -rf site/*.html

