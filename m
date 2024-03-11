Return-Path: <linux-kernel+bounces-98646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFD877D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE31C210EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC61A5A2;
	Mon, 11 Mar 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vmxo8BIx"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386622318;
	Mon, 11 Mar 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150383; cv=none; b=oX/2+qruMy3KpxfrK3ns9YWhMYATLWRipQjW6PNA/zksViHkINooyCn/h0HTEnkWtCPu0Lyw/7qrBeCSvxJaLodHJbj6dPQFoX5MW2Y6YCjkAFP9wzUKjNJoV6Ejfx7Vuu6+hp/FH9TDYJggADIJBapSzEo/wntWa4eYqRjWYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150383; c=relaxed/simple;
	bh=p2h+zgj9EHZP7pMJcvq6C/8BFAaJIZ0SmwzUxQdOytk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDIWSZFM2d9nCNk9mQSaU680ZY3XOA4L93ZVKqXJaMxuiPGFHq4jzY0ypsGExP03hcE3pRULk64C3CI7D48rSAogmoNPVr7wzmrcZw9vCBNbRg1zqnXT4Vm3RvHKZOyjnE8orHo9cn/uNcpkwV074hfIawjvxClw+lJj071BEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vmxo8BIx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2155135a12.2;
        Mon, 11 Mar 2024 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710150380; x=1710755180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNobwmR4CWQ7FX/nDuZga8fMukboiUrhAmGtHDBSvss=;
        b=Vmxo8BIxP+xFYQGEaxEnPJqNmKbn1XI6t8jd3lWFexuIfHyWmsxcw4fdS78B/Hppbb
         ApR5G7uTP5wV8n3tD/NKwAdR/qvyJdGF4GhvUe4uslBA7QdQy/itwgkWSCqfFAJG6dkJ
         +d8mp8YmSGc2LgxF2W4NDySv3vBEwsJwMcYayLMjuPAUNrUfzhH03Xwt5q7k18hNc/z+
         1Lqe8rb6GUFOfBPAmeB5UNibxq08smEPWIpWADETE8R8V81AJpfze80AA5dHEQ6QL6R2
         8jvTYeI5Dtm4Z8YI6FwiFCk5dRZtX1mBUHPaiC+7+gK9JcucF/J8yFCUpueMjCnCP49b
         OdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150380; x=1710755180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNobwmR4CWQ7FX/nDuZga8fMukboiUrhAmGtHDBSvss=;
        b=B5EbGm/sS5aaVNCCIB9QyYXoVkH8wqNBI7GadW7gbT9wJxQvMToQMO5Cn6UAfDC6fN
         ArZ45PlcfxI3HjUuSJ1dvamEWABc2qzuBhutl9mznexa1Cji+Z3bHa7pZoFPui29T5oD
         nXMr80lPzWjn7xMHjdTQpkC70Q++cAbtKO3XoP6ynD4Zr/QFuSOR90up3wEPR4Hgz8NQ
         KTnK7euK2D+hNY5zl/rm0C81xPz7hIkwskLZ18na7KH5zZsmKlU4XW2OJa7PaBcNkEZB
         5r+AhCM56IsMsrbmBzU1m9zeKuZ7VzH+K54EgjEBSHA3urPWnB7Y27v2qm3xcErpIOJH
         6y2g==
X-Forwarded-Encrypted: i=1; AJvYcCW6xpOIC1wnLF/glpLHhw0hGFWsl34Dk0xnuczKWl7uXP8GahCiW4+/vqg/Z29svjiTWUL+4C0cnGvATsqrMywUrbH8f6ihskepLgGkFM3EpySm+MybXintS6oepJx/1F3xiAeM
X-Gm-Message-State: AOJu0YxyuXDz/AbGOZTPB4XALhdFw1jXdyN8bzb29gzc+bhqEFgnta+U
	fVFRc/FPrXdQdEEUWBVMDfFosew2ipRr10tuqMfWK8uWv4Du/J/WplqTC3H4nlWcUz994coNPrY
	ULcJ1xqCOtWIPfFG4l1inboHPK84=
X-Google-Smtp-Source: AGHT+IGA+zHTrc0Y1QsYWaWJBqwu+JU8SCXIm1P4B+KurepXkw51/WEw1uHVtij4ZiPpfZwPiluJJ4b3enhBspzf5SU=
X-Received: by 2002:a17:90a:c406:b0:29b:b3fa:b7ac with SMTP id
 i6-20020a17090ac40600b0029bb3fab7acmr3427964pjt.10.1710150380556; Mon, 11 Mar
 2024 02:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef6a91ac20d8441bad9956c15caaafef@qianxin.com>
In-Reply-To: <ef6a91ac20d8441bad9956c15caaafef@qianxin.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 11 Mar 2024 17:46:09 +0800
Message-ID: <CALm+0cW8HutqzcrfxysLWoOVyzh70RT3G0gaALRbnS=8Lw2f=g@mail.gmail.com>
Subject: Re: memory leak in posix_clock_open
To: =?UTF-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
Cc: "richardcochran@gmail.com" <richardcochran@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, "secalert@redhat.com" <secalert@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>
> There is a memory leak in posix_clock_open,it was found by syzkaller when I tested it with linux-6.7(commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a).
>
> When the ptp_open function (in driver/ptp/ptp.chardev. c) is called in posix_clock_open and the ptp_open function returns an error, it appears to crash, posix_clock_release has not been called to free pccontext.
>
> Here is crash info:
>
> BUG: memory leak
> unreferenced object 0xffff8881065327c0 (size 16):
>   comm "syz-executor.7", pid 8994, jiffies 4295144661 (age 17.222s)
>   hex dump (first 16 bytes):
>     00 20 79 01 81 88 ff ff 00 00 00 00 00 00 00 00  . y.............
>   backtrace:
>     [<00000000fba736c4>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
>     [<00000000fba736c4>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<00000000fba736c4>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<00000000fba736c4>] __kmem_cache_alloc_node+0x1ee/0x250 mm/slub.c:3517
>     [<00000000f8fcb419>] kmalloc_trace+0x22/0xc0 mm/slab_common.c:1098
>     [<00000000afc910b4>] kmalloc include/linux/slab.h:600 [inline]
>     [<00000000afc910b4>] kzalloc include/linux/slab.h:721 [inline]
>     [<00000000afc910b4>] posix_clock_open+0xd3/0x250 kernel/time/posix-clock.c:126
>     [<00000000b1a43627>] chrdev_open+0x24b/0x6a0 fs/char_dev.c:414
>     [<00000000364febd5>] do_dentry_open+0x630/0x1580 fs/open.c:948
>     [<00000000ac62c8f4>] do_open fs/namei.c:3622 [inline]
>     [<00000000ac62c8f4>] path_openat+0x13f1/0x1c30 fs/namei.c:3779
>     [<0000000087bfc1bc>] do_filp_open+0x1c5/0x410 fs/namei.c:3809
>     [<0000000044db899a>] do_sys_openat2+0x139/0x190 fs/open.c:1437
>     [<00000000ee967f42>] do_sys_open fs/open.c:1452 [inline]
>     [<00000000ee967f42>] __do_sys_openat fs/open.c:1468 [inline]
>     [<00000000ee967f42>] __se_sys_openat fs/open.c:1463 [inline]
>     [<00000000ee967f42>] __x64_sys_openat+0x13d/0x1f0 fs/open.c:1463
>     [<000000004fad64b5>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     [<000000004fad64b5>] do_syscall_64+0x3e/0xf0 arch/x86/entry/common.c:83
>     [<00000000c2701c13>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> BUG: leak checking failed

Hi, jingfeng

Please try the following modifications:

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9de66bbbb3d1..71d9d8c394fa 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -137,6 +137,8 @@ static int posix_clock_open(struct inode *inode,
struct file *fp)

        if (!err) {
                get_device(clk->dev);
+       } else {
+               kfree(pccontext);
        }
 out:
        up_read(&clk->rwsem);

Thanks
Zqiang

>
>
>
>
> Here is the C code reproducer by syzkaller,It used inject fault to make ptp_open returns a error:
>
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>
> static void sleep_ms(uint64_t ms)
> {
>        usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
>        struct timespec ts;
>        if (clock_gettime(CLOCK_MONOTONIC, &ts))
>        exit(1);
>        return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static bool write_file(const char* file, const char* what, ...)
> {
>        char buf[1024];
>        va_list args;
>        va_start(args, what);
>        vsnprintf(buf, sizeof(buf), what, args);
>        va_end(args);
>        buf[sizeof(buf) - 1] = 0;
>        int len = strlen(buf);
>        int fd = open(file, O_WRONLY | O_CLOEXEC);
>        if (fd == -1)
>               return false;
>        if (write(fd, buf, len) != len) {
>               int err = errno;
>               close(fd);
>               errno = err;
>               return false;
>        }
>        close(fd);
>        return true;
> }
>
> static int inject_fault(int nth)
> {
>        int fd;
>        fd = open("/proc/thread-self/fail-nth", O_RDWR);
>        if (fd == -1)
>        exit(1);
>        char buf[16];
>        sprintf(buf, "%d", nth);
>        if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
>        exit(1);
>        return fd;
> }
>
> static void kill_and_wait(int pid, int* status)
> {
>        kill(-pid, SIGKILL);
>        kill(pid, SIGKILL);
>        for (int i = 0; i < 100; i++) {
>               if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>                      return;
>               usleep(1000);
>        }
>        DIR* dir = opendir("/sys/fs/fuse/connections");
>        if (dir) {
>               for (;;) {
>                      struct dirent* ent = readdir(dir);
>                      if (!ent)
>                             break;
>                      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>                             continue;
>                      char abort[300];
>                      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
>                      int fd = open(abort, O_WRONLY);
>                      if (fd == -1) {
>                             continue;
>                      }
>                      if (write(fd, abort, 1) < 0) {
>                      }
>                      close(fd);
>               }
>               closedir(dir);
>        } else {
>        }
>        while (waitpid(-1, status, __WALL) != pid) {
>        }
> }
>
> static void setup_test()
> {
>        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>        setpgrp();
>        write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void setup_fault()
> {
>        static struct {
>               const char* file;
>               const char* val;
>               bool fatal;
>        } files[] = {
>            {"/sys/kernel/debug/failslab/ignore-gfp-wait", "N", true},
>            {"/sys/kernel/debug/fail_futex/ignore-private", "N", false},
>           {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},
>            {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", false},
>            {"/sys/kernel/debug/fail_page_alloc/min-order", "0", false},
>        };
>        unsigned i;
>        for (i = 0; i < sizeof(files) / sizeof(files[0]); i++) {
>               if (!write_file(files[i].file, files[i].val)) {
>                      if (files[i].fatal)
>        exit(1);
>               }
>        }
> }
>
> #define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"
>
> static void setup_leak()
> {
>        if (!write_file(KMEMLEAK_FILE, "scan"))
>        exit(1);
>        sleep(5);
>        if (!write_file(KMEMLEAK_FILE, "scan"))
>        exit(1);
>        if (!write_file(KMEMLEAK_FILE, "clear"))
>        exit(1);
> }
>
> static void check_leaks(void)
> {
>        int fd = open(KMEMLEAK_FILE, O_RDWR);
>        if (fd == -1)
>        exit(1);
>        uint64_t start = current_time_ms();
>        if (write(fd, "scan", 4) != 4)
>        exit(1);
>        sleep(1);
>        while (current_time_ms() - start < 4 * 1000)
>               sleep(1);
>        if (write(fd, "scan", 4) != 4)
>        exit(1);
>        static char buf[128 << 10];
>        ssize_t n = read(fd, buf, sizeof(buf) - 1);
>        if (n < 0)
>        exit(1);
>        int nleaks = 0;
>        if (n != 0) {
>               sleep(1);
>               if (write(fd, "scan", 4) != 4)
>        exit(1);
>               if (lseek(fd, 0, SEEK_SET) < 0)
>        exit(1);
>               n = read(fd, buf, sizeof(buf) - 1);
>               if (n < 0)
>        exit(1);
>               buf[n] = 0;
>               char* pos = buf;
>               char* end = buf + n;
>               while (pos < end) {
>                      char* next = strstr(pos + 1, "unreferenced object");
>                      if (!next)
>                             next = end;
>                      char prev = *next;
>                      *next = 0;
>                      fprintf(stderr, "BUG: memory leak\n%s\n", pos);
>                      *next = prev;
>                      pos = next;
>                      nleaks++;
>               }
>        }
>        if (write(fd, "clear", 5) != 5)
>        exit(1);
>        close(fd);
>        if (nleaks)
>               exit(1);
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
>        int iter = 0;
>        for (;; iter++) {
>               int pid = fork();
>               if (pid < 0)
>        exit(1);
>               if (pid == 0) {
>                      setup_test();
>                      execute_one();
>                      exit(0);
>               }
>               int status = 0;
>               uint64_t start = current_time_ms();
>               for (;;) {
>                      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>                             break;
>                      sleep_ms(1);
>                      if (current_time_ms() - start < 5000)
>                             continue;
>                      kill_and_wait(pid, &status);
>                      break;
>               }
>               check_leaks();
>        }
> }
>
> void execute_one(void)
> {
> memcpy((void*)0x20001180, "/dev/ptp0\000", 10);
>        inject_fault(7);
>        syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x20001180ul, /*flags=*/0ul, /*mode=*/0ul);
>
> }
> int main(void)
> {
>               syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>        syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>        syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>        setup_leak();
>        setup_fault();
>                      loop();
>        return 0;
> }
>

