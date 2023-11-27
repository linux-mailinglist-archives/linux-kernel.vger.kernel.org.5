Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46DA7F9C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjK0JEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjK0JDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:03:24 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD48DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:03:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b27726369so27663265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701075791; x=1701680591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7EkbD15glXkvPAXP4QAmPlK/+EvihFKKdTZJJahcBI=;
        b=EF/K2s7iqylQnhtI+guczFDoIdqgvH2lTrZlPn1HukKVaFYLcIPksk06VNqOmnK+2e
         VpQxN4YZpRcutBnGXw3/ZCElypU1IWTZttiVbsvP4sEihYItlMnmhSANc0thM4hYWiQe
         cUwaNvRtMm594FBZH5Wg9ice4cKqWi/NQpEM5v4y13tEE5ODTuG2Qx9/7/Jpwx/Xz8Eo
         MOaM9hqJHil1tpfr0bEJZAOA+pc/xMo+XbRmZX8NtAYGjU9SaLrMuAUIl8Qu4vo4GBWX
         rLOgEtENQaInUtSMMU8pO9FjHf71DqoPlThXZF452vTRbt26KXH+sOqfp7NCaq56wWF2
         rODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075791; x=1701680591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7EkbD15glXkvPAXP4QAmPlK/+EvihFKKdTZJJahcBI=;
        b=NwYGfeVTNXQjcgtcNpWvT9fNTswPQ3Qt329fe6fILnrGlJgCX9rBvGouAYkN8fkn9i
         mQXcjg8iBR2/ue36sSLttj2rFi5GDxVG6WJHIOK4JsnXtdz0Hx6V7PYl12OYUasTfyl7
         dJTa+nXH3GA7jYppQcv2w7cChohc9poePTjoDpMDZnDn+wWw1LOPfsOw6au3LdSrNzoe
         YTJlG0QFggjTM0v1a5VefvYMaVToAgXeoB5K1SjVVZwPqsiOphB9ip7dVP2IN+N41Czp
         jyZjn8G6FWjWEBMjr+rDirJyBDAeOxCUSyfdju6z8chHHJjvEnjN9iyPxRG0KQG19Kdt
         YSZw==
X-Gm-Message-State: AOJu0YxdVfKuQpic52KNFD7LKpeVHCNkibGXQqPip4QVKNhJCwOSj3AQ
        wqE8DSi82w4xRWkmKOgnBQE=
X-Google-Smtp-Source: AGHT+IFZDr9FhFdbSEk9pl8JB1AMDnb1Yz0BNPSVu7IoYr/UTvc3dtKzOcNkGF2QNQe4VFoxm3DoLg==
X-Received: by 2002:a05:600c:1f82:b0:408:364e:34a2 with SMTP id je2-20020a05600c1f8200b00408364e34a2mr3841581wmb.10.1701075790530;
        Mon, 27 Nov 2023 01:03:10 -0800 (PST)
Received: from gmail.com (1F2EF5AE.nat.pool.telekom.hu. [31.46.245.174])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00405959469afsm13158525wms.3.2023.11.27.01.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:03:10 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 27 Nov 2023 10:03:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     syzbot+186b55175d8360728234@syzkaller.appspotmail.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
Message-ID: <ZWRbTP3GvohuKY3d@gmail.com>
References: <CABOYnLz3Keyn-bvwRcng_z3_-9zj3zXUAU7e7Vz3V4xACsqSVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLz3Keyn-bvwRcng_z3_-9zj3zXUAU7e7Vz3V4xACsqSVA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* xingwei lee <xrivendell7@gmail.com> wrote:

> Sorry for containing HTML subpart, I'll repeat this mail.
> Hi, I reproduce this bug with repro.c and repro.txt and confirmed crash.
> 
> repro.txt
> r0 = socket$alg(0x26, 0x5, 0x0)
> bind$alg(r0, &(0x7f0000000440)={0x26, 'skcipher\x00', 0x0, 0x0,
> 'ecb-cipher_null\x00'}, 0x58)
> r1 = accept$alg(r0, 0x0, 0x0)
> r2 = dup(r1)
> open(&(0x7f0000000140)='./file1\x00', 0x10f0c2, 0x0)
> r3 = dup(r1)
> mount$9p_fd(0x0, &(0x7f0000000000)='./file1\x00', &(0x7f0000000040),
> 0x0, &(0x7f0000000a40)=ANY=[@ANYBLOB='trans=fd,rfdno=', @ANYRESHEX=r3,
> @ANYBLOB=',wfdno=', @ANYRESHEX=r2])
> 
> repro.c
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
> usleep(ms * 1000);
> }
> 
> static uint64_t current_time_ms(void)
> {
> struct timespec ts;
> if (clock_gettime(CLOCK_MONOTONIC, &ts))
> exit(1);
> return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> static bool write_file(const char* file, const char* what, ...)
> {
> char buf[1024];
> va_list args;
> va_start(args, what);
> vsnprintf(buf, sizeof(buf), what, args);
> va_end(args);
> buf[sizeof(buf) - 1] = 0;
> int len = strlen(buf);
> int fd = open(file, O_WRONLY | O_CLOEXEC);
> if (fd == -1)
> return false;
> if (write(fd, buf, len) != len) {
> int err = errno;
> close(fd);
> errno = err;
> return false;

BTW., could you please run such autogenerated repro.c files through
"indent --linux-style"? See below, the code becomes much more readable.

Thanks,

	Ingo

============================>
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
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

static void sleep_ms(uint64_t ms)
{
	usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
	struct timespec ts;

	if (clock_gettime(CLOCK_MONOTONIC, &ts))
		exit(1);
	return (uint64_t) ts.tv_sec * 1000 + (uint64_t) ts.tv_nsec / 1000000;
}

static bool write_file(const char *file, const char *what, ...)
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

static void kill_and_wait(int pid, int *status)
{
	kill(-pid, SIGKILL);
	kill(pid, SIGKILL);
	for (int i = 0; i < 100; i++) {
		if (waitpid(-1, status, WNOHANG | __WALL) == pid)
			return;
		usleep(1000);
	}
	DIR *dir = opendir("/sys/fs/fuse/connections");

	if (dir) {
		for (;;) {
			struct dirent *ent = readdir(dir);

			if (!ent)
				break;
			if (strcmp(ent->d_name, ".") == 0
			    || strcmp(ent->d_name, "..") == 0)
				continue;
			char abort[300];

			snprintf(abort, sizeof(abort),
				 "/sys/fs/fuse/connections/%s/abort",
				 ent->d_name);
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
			if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
				break;
			sleep_ms(1);
			if (current_time_ms() - start < 5000)
				continue;
			kill_and_wait(pid, &status);
			break;
		}
	}
}

uint64_t r[4] = { 0xffffffffffffffff, 0xffffffffffffffff,
	0xffffffffffffffff, 0xffffffffffffffff
};

void execute_one(void)
{
	intptr_t res = 0;

	res = syscall(__NR_socket, /*domain= */ 0x26ul, /*type= */ 5ul,
		      /*proto= */ 0);
	if (res != -1)
		r[0] = res;
	*(uint16_t *) 0x20000440 = 0x26;
	memcpy((void *)0x20000442, "skcipher\000\000\000\000\000\000", 14);
	*(uint32_t *) 0x20000450 = 0;
	*(uint32_t *) 0x20000454 = 0;
	memcpy((void *)0x20000458,
	       "ecb-cipher_null\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
	       64);
	syscall(__NR_bind, /*fd= */ r[0], /*addr= */ 0x20000440ul,	/*addrlen= */
		0x58ul);
	res = syscall(__NR_accept, /*fd= */ r[0], /*peer= */ 0ul,	/*peerlen= */
		      0ul);
	if (res != -1)
		r[1] = res;
	res = syscall(__NR_dup, /*oldfd= */ r[1]);
	if (res != -1)
		r[2] = res;
	memcpy((void *)0x20000140, "./file1\000", 8);
	syscall(__NR_open, /*file= */ 0x20000140ul, /*flags= */ 0x10f0c2ul,
		/*mode= */ 0ul);
	res = syscall(__NR_dup, /*oldfd= */ r[1]);
	if (res != -1)
		r[3] = res;
	memcpy((void *)0x20000000, "./file1\000", 8);
	memcpy((void *)0x20000040, "9p\000", 3);
	memcpy((void *)0x20000a40, "trans=fd,rfdno=", 15);
	sprintf((char *)0x20000a4f, "0x%016llx", (long long)r[3]);
	memcpy((void *)0x20000a61, ",wfdno=", 7);
	sprintf((char *)0x20000a68, "0x%016llx", (long long)r[2]);
	syscall(__NR_mount, /*src= */ 0ul, /*dst= */ 0x20000000ul,
		/*type= */ 0x20000040ul, /*flags= */ 0ul,	/*opts= */
		0x20000a40ul);

}

int main(void)
{
	syscall(__NR_mmap, /*addr= */ 0x1ffff000ul, /*len= */ 0x1000ul,
		/*prot= */ 0ul, /*flags= */ 0x32ul, /*fd= */ -1,	/*offset= */
		0ul);
	syscall(__NR_mmap, /*addr= */ 0x20000000ul, /*len= */ 0x1000000ul,
		/*prot= */ 7ul, /*flags= */ 0x32ul, /*fd= */ -1,	/*offset= */
		0ul);
	syscall(__NR_mmap, /*addr= */ 0x21000000ul, /*len= */ 0x1000ul,
		/*prot= */ 0ul, /*flags= */ 0x32ul, /*fd= */ -1,	/*offset= */
		0ul);
	loop();
	return 0;
}
