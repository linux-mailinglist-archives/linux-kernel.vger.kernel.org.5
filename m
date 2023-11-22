Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AB7F3DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjKVGNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:13:52 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C417193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:13:48 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so4326963a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700633628; x=1701238428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=reTusWsUIx8agHNzjAWVCK5/S9p3W3ioOlw0F7uoITo=;
        b=gEsAehM5TwmbqNMGxpkxqRxOJwFNrETrtcv2JXsL38C3j6U8Wz7enWbldltQdpNnNw
         gKa4h20sQN8E9jPmhimhix9Jz4e/UtjvC2LJHbt0Cg9jUTLn3Q5iosWM2Mo1VMJZXCQI
         7VGP1WIX6osltGCluzUdatSNUDGBj68Lxl5Thj0zzC+4GXMlXwlni8jRTuphsQzdtnGD
         Hvr7F3VsuNNTx+aws+RqyC99EIDZkIdtEUZdqXq7ZGBJEQK6z3o2UMce/xcjnxxAH8d3
         Ww5Z8b8z+phucwZYXTzliiJ0S68EE0haP/gV4j3YUEelRMKvRFX0SqbSsdBWCKD19J+Z
         KqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700633628; x=1701238428;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reTusWsUIx8agHNzjAWVCK5/S9p3W3ioOlw0F7uoITo=;
        b=an8XAeVFa8/xa737zcB7vIqHHO647tXGaxGEAyGeCJSvC+McsmVvMzYspM+ZI3Wmas
         1yW5EW7Xaq/qdeba2L3cGged7wtKZnM+xiiZ7oRgggf3Yy88JBWMupIXlbkg4WH3CUR7
         +xUnG4Jwk7hxpzne/B/In2KDVEfe9MjHa0VT4ywx41kDiJO1ZzkSm3b3F998uDg7CYPE
         3ap3WpuDNV0b6brLwoDq4wRTL5TD4f+QNj1AYxkIwcqTzAqBSojy+gG9TFt1XdstFnk2
         Bi/ZlaYczhNP/H87dvmbus24KwAFxo6XxcNpBHpRqhBdqDCSwSceI4FzKbVCOtXlBDKM
         fclQ==
X-Gm-Message-State: AOJu0YxkjFfp95A+m4MRBFh5yzP3TG7FDwJNo1BqB5nTKNy8UQ5uSRuX
        T+G1/LbaGg86OM28ElPpYF6xSCWy/lARybLOqQ4=
X-Google-Smtp-Source: AGHT+IHxD8B5H+IXgsav1R2wvtVyrb6UO4u4dzCnMqJbvr5uuaaAkYYHHmw1MAY5qKdXZLLv3uLMvjfwb6/Laqr3W6k=
X-Received: by 2002:a05:6a20:72a5:b0:187:8bd4:e1ba with SMTP id
 o37-20020a056a2072a500b001878bd4e1bamr1363194pzk.37.1700633627643; Tue, 21
 Nov 2023 22:13:47 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Wed, 22 Nov 2023 14:13:36 +0800
Message-ID: <CABOYnLyY40dS4p2beHyEnXqSm4K_NuXAvsozOvz=cX9TnxXsYA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in kill_orphaned_pgrp
To:     "syzbot+50ef815ba3bcce06d409@syzkaller.appspotmail.com" 
        <syzbot+50ef815ba3bcce06d409@syzkaller.appspotmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I reproduce this bug.

Without analyzing deeply, I find the other bug titled "KASAN:
slab-use-after-free read in do_acct_process" or titled  "KASAN:
slab-use-after-free in release_task" may also be the same because with
the same reproducer.


repro.txt

r0 = creat(&(0x7f0000000280)='./file0\x00', 0xecf86c37d53049cc)

write$binfmt_elf32(r0, &(0x7f0000000440)={{0x7f, 0x45, 0x4c, 0x46,
0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x3e, 0x0, 0x0, 0x38, 0x0, 0x0, 0xeb0,
0x20, 0x2}, [{}], "", ['\x00', '\x00', '\x00', '\x00', '\x00', '\x00',
'\x00']}, 0x758)

close(r0)

r1 = openat$vnet(0xffffffffffffff9c, &(0x7f0000000000), 0x2, 0x0)

ioctl$int_in(r1, 0x40000000af01, 0x0)

execve(&(0x7f0000000400)='./file0\x00', 0x0, 0x0)



repro.c



#define _GNU_SOURCE



#include <dirent.h>

#include <endian.h>

#include <errno.h>

#include <fcntl.h>

#include <pthread.h>

#include <signal.h>

#include <stdarg.h>

#include <stdbool.h>

#include <stdint.h>

#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include <sys/prctl.h>

#include <sys/stat.h>

#include <sys/syscall.h>

#include <sys/types.h>

#include <sys/wait.h>

#include <time.h>

#include <unistd.h>



#include <linux/futex.h>



static void sleep_ms(uint64_t ms)

{

          usleep(ms * 1000);

}



static uint64_t current_time_ms(void)

{

          struct timespec ts;

          if (clock_gettime(CLOCK_MONOTONIC, &ts))

          exit(1);

          return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;

}



static void thread_start(void* (*fn)(void*), void* arg)

{

          pthread_t th;

          pthread_attr_t attr;

          pthread_attr_init(&attr);

          pthread_attr_setstacksize(&attr, 128 << 10);

          int i = 0;

          for (; i < 100; i++) {

                   if (pthread_create(&th, &attr, fn, arg) == 0) {

                             pthread_attr_destroy(&attr);

                             return;

                   }

                   if (errno == EAGAIN) {

                             usleep(50);

                             continue;

                   }

                   break;

          }

          exit(1);

}



typedef struct {

          int state;

} event_t;



static void event_init(event_t* ev)

{

          ev->state = 0;

}



static void event_reset(event_t* ev)

{

          ev->state = 0;

}



static void event_set(event_t* ev)

{

          if (ev->state)

          exit(1);

          __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);

          syscall(SYS_futex, &ev->state, FUTEX_WAKE |
FUTEX_PRIVATE_FLAG, 1000000);

}



static void event_wait(event_t* ev)

{

          while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))

                   syscall(SYS_futex, &ev->state, FUTEX_WAIT |
FUTEX_PRIVATE_FLAG, 0, 0);

}



static int event_isset(event_t* ev)

{

          return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);

}



static int event_timedwait(event_t* ev, uint64_t timeout)

{

          uint64_t start = current_time_ms();

          uint64_t now = start;

          for (;;) {

                   uint64_t remain = timeout - (now - start);

                   struct timespec ts;

                   ts.tv_sec = remain / 1000;

                   ts.tv_nsec = (remain % 1000) * 1000 * 1000;

                   syscall(SYS_futex, &ev->state, FUTEX_WAIT |
FUTEX_PRIVATE_FLAG, 0, &ts);

                   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))

                             return 1;

                   now = current_time_ms();

                   if (now - start > timeout)

                             return 0;

          }

}



static bool write_file(const char* file, const char* what, ...)

{

          char buf[1024];

          va_list args;

          va_start(args, what);

          vsnprintf(buf, sizeof(buf), what, args);

          va_end(args);

          buf[sizeof(buf) - 1] = 0;

          int len = strlen(buf);

          int fd = open(file, O_WRONLY | O_CLOEXEC);

          if (fd == -1)

                   return false;

          if (write(fd, buf, len) != len) {

                   int err = errno;

                   close(fd);

                   errno = err;

                   return false;

          }

          close(fd);

          return true;

}



static void kill_and_wait(int pid, int* status)

{

          kill(-pid, SIGKILL);

          kill(pid, SIGKILL);

          for (int i = 0; i < 100; i++) {

                   if (waitpid(-1, status, WNOHANG | __WALL) == pid)

                             return;

                   usleep(1000);

          }

          DIR* dir = opendir("/sys/fs/fuse/connections");

          if (dir) {

                   for (;;) {

                             struct dirent* ent = readdir(dir);

                             if (!ent)

                                      break;

                             if (strcmp(ent->d_name, ".") == 0 ||
strcmp(ent->d_name, "..") == 0)

                                      continue;

                             char abort[300];

                             snprintf(abort, sizeof(abort),
"/sys/fs/fuse/connections/%s/abort", ent->d_name);

                             int fd = open(abort, O_WRONLY);

                             if (fd == -1) {

                                      continue;

                             }

                             if (write(fd, abort, 1) < 0) {

                             }

                             close(fd);

                   }

                   closedir(dir);

          } else {

          }

          while (waitpid(-1, status, __WALL) != pid) {

          }

}



static void setup_test()

{

          prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);

          setpgrp();

          write_file("/proc/self/oom_score_adj", "1000");

}



struct thread_t {

          int created, call;

          event_t ready, done;

};



static struct thread_t threads[16];

static void execute_call(int call);

static int running;



static void* thr(void* arg)

{

          struct thread_t* th = (struct thread_t*)arg;

          for (;;) {

                   event_wait(&th->ready);

                   event_reset(&th->ready);

                   execute_call(th->call);

                   __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);

                   event_set(&th->done);

          }

          return 0;

}



static void execute_one(void)

{

          int i, call, thread;

          for (call = 0; call < 6; call++) {

                   for (thread = 0; thread < (int)(sizeof(threads) /
sizeof(threads[0])); thread++) {

                             struct thread_t* th = &threads[thread];

                             if (!th->created) {

                                      th->created = 1;

                                      event_init(&th->ready);

                                      event_init(&th->done);

                                      event_set(&th->done);

                                      thread_start(thr, th);

                             }

                             if (!event_isset(&th->done))

                                      continue;

                             event_reset(&th->done);

                             th->call = call;

                             __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);

                             event_set(&th->ready);

                             event_timedwait(&th->done, 50);

                             break;

                   }

          }

          for (i = 0; i < 100 && __atomic_load_n(&running,
__ATOMIC_RELAXED); i++)

                   sleep_ms(1);

}



static void execute_one(void);



#define WAIT_FLAGS __WALL



static void loop(void)

{

          int iter = 0;

          for (;; iter++) {

                   int pid = fork();

                   if (pid < 0)

          exit(1);

                   if (pid == 0) {

                             setup_test();

                             execute_one();

                             exit(0);

                   }

                   int status = 0;

                   uint64_t start = current_time_ms();

                   for (;;) {

                             if (waitpid(-1, &status, WNOHANG |
WAIT_FLAGS) == pid)

                                      break;

                             sleep_ms(1);

                             if (current_time_ms() - start < 5000)

                                      continue;

                             kill_and_wait(pid, &status);

                             break;

                   }

          }

}



uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};



void execute_call(int call)

{

                   intptr_t res = 0;

          switch (call) {

          case 0:

memcpy((void*)0x20000280, "./file0\000", 8);

                   res = syscall(__NR_creat, /*file=*/0x20000280ul,
/*mode=*/0xecf86c37d53049ccul);

                   if (res != -1)

                                      r[0] = res;

                   break;

          case 1:

*(uint8_t*)0x20000440 = 0x7f;

*(uint8_t*)0x20000441 = 0x45;

*(uint8_t*)0x20000442 = 0x4c;

*(uint8_t*)0x20000443 = 0x46;

*(uint8_t*)0x20000444 = 0;

*(uint8_t*)0x20000445 = 0;

*(uint8_t*)0x20000446 = 0;

*(uint8_t*)0x20000447 = 0;

*(uint64_t*)0x20000448 = 0;

*(uint16_t*)0x20000450 = 2;

*(uint16_t*)0x20000452 = 0x3e;

*(uint32_t*)0x20000454 = 0;

*(uint32_t*)0x20000458 = 0;

*(uint32_t*)0x2000045c = 0x38;

*(uint32_t*)0x20000460 = 0;

*(uint32_t*)0x20000464 = 0;

*(uint16_t*)0x20000468 = 0xeb0;

*(uint16_t*)0x2000046a = 0x20;

*(uint16_t*)0x2000046c = 2;

*(uint16_t*)0x2000046e = 0;

*(uint16_t*)0x20000470 = 0;

*(uint16_t*)0x20000472 = 0;

*(uint32_t*)0x20000478 = 0;

*(uint32_t*)0x2000047c = 0;

*(uint32_t*)0x20000480 = 0;

*(uint32_t*)0x20000484 = 0;

*(uint32_t*)0x20000488 = 0;

*(uint32_t*)0x2000048c = 0;

*(uint32_t*)0x20000490 = 0;

*(uint32_t*)0x20000494 = 0;

memset((void*)0x20000498, 0, 256);

memset((void*)0x20000598, 0, 256);

memset((void*)0x20000698, 0, 256);

memset((void*)0x20000798, 0, 256);

memset((void*)0x20000898, 0, 256);

memset((void*)0x20000998, 0, 256);

memset((void*)0x20000a98, 0, 256);

                   syscall(__NR_write, /*fd=*/r[0],
/*data=*/0x20000440ul, /*len=*/0x758ul);

                   break;

          case 2:

                   syscall(__NR_close, /*fd=*/r[0]);

                   break;

          case 3:

memcpy((void*)0x20000000, "/dev/vhost-net\000", 15);

                   res = syscall(__NR_openat,
/*fd=*/0xffffffffffffff9cul, /*file=*/0x20000000ul, /*flags=*/2ul,
/*mode=*/0ul);

                   if (res != -1)

                                      r[1] = res;

                   break;

          case 4:

                   syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0xaf01, /*v=*/0ul);

                   break;

          case 5:

memcpy((void*)0x20000400, "./file0\000", 8);

                   syscall(__NR_execve, /*file=*/0x20000400ul,
/*argv=*/0ul, /*envp=*/0ul);

                   break;

          }



}

int main(void)

{

                   syscall(__NR_mmap, /*addr=*/0x1ffff000ul,
/*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1,
/*offset=*/0ul);

          syscall(__NR_mmap, /*addr=*/0x20000000ul,
/*len=*/0x1000000ul, /*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1,
/*offset=*/0ul);

          syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);

                             loop();

          return 0;

}
