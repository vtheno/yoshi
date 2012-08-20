CC = gcc
FLAGS = -g -o $@
CFLAGS = -c -Wall -Werror -pedantic -std=c99 $(FLAGS)
LDFLAGS = $(FLAGS)

all : bin/yoshi

install : bin/yoshi
	cp bin/yoshi $(HOME)/bin/

bin/yoshi : main.o exp.o env.o err.o gc.o read.o interp.o builtin.o print.o strbuf.o
	$(CC) $(LDFLAGS) $^

main.o : main.c data.h exp.h env.h err.h gc.h read.h interp.h print.h builtin.h strbuf.h
	$(CC) $(CFLAGS) main.c

builtin.o : builtin.c builtin.h data.h exp.h env.h err.h gc.h
	$(CC) $(CFLAGS) builtin.c

gc.o : gc.c gc.h data.h
	$(CC) $(CFLAGS) gc.c

print.o : print.c print.h data.h exp.h
	$(CC) $(CFLAGS) print.c

interp.o : interp.c interp.h data.h exp.h env.h err.h gc.h
	$(CC) $(CFLAGS) interp.c

read.o : read.c read.h strbuf.h data.h exp.h err.h
	$(CC) $(CFLAGS) read.c

env.o : env.c env.h data.h err.h
	$(CC) $(CFLAGS) env.c

exp.o : exp.c data.h exp.h err.h gc.h strbuf.h
	$(CC) $(CFLAGS) exp.c

err.o : err.c err.h
	$(CC) $(CFLAGS) err.c

strbuf.o : strbuf.c strbuf.h
	$(CC) $(CFLAGS) strbuf.c

clobber : clean
	rm -f bin/yoshi || true

clean :
	rm -f *.o || true

.PHONY : all install clobber clean
