Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0E80DB31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjLKUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:00:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E20DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:00:21 -0800 (PST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95C834017D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702324819;
        bh=2PvMdbFlJOMbMf8mxqCbyra5SCLRGv+Awaul/fD1Fyg=;
        h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Type;
        b=qs8ZVithzvvWI1es0d8OUCPk/X+jZW+1l4nwFR+IGgCqhjh0JWyYaXRM7NbqwVHGL
         p4a2jdLArKek5tH0Hg4axTh04g99E9wq8WHHFIJeUomVbmK7Yg5AdnQpuDqnE4rivP
         dikQx0mX/MfvcytjQpdUlI/93i7cvEMHBaNIeR7TzYoZapMCy+bXPY0WkIOcPlZhJy
         pkZNzohI+zmU2STU2gLcXHiT9z8qZ6P1VnPmgZS+6GtyOaaKmBkNMkqhTuqsuN/WKv
         KP7dWxyh/A3ynO/QjfJgXnNORwpv6VzU2GPsc4C4zspSq4YCDsmmaS8IM7m49gB9Cs
         7RPcz040ZFYGA==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50c21a1733eso3947610e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324818; x=1702929618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PvMdbFlJOMbMf8mxqCbyra5SCLRGv+Awaul/fD1Fyg=;
        b=gUWIekDv3XMplXTQVDQ1tnjMuNz03U8I52lOQzSAmiHSVNmLPzDv+lVd1bl+azqw/I
         SMyYDCgiKONb4uv4ifYManHrEmlQ0rc3/Bpasv0ihzwD9iud58sAPEM19484gVNTXETY
         tJourAI8K/2REnTJCLeosa8ue2LappQq37uoBJY+lRNF5p16CXIRI12qZoWd/ZHKRdKz
         3/pTowzqml1pK9b3Ugv+rNmXp4LLXYtDE/6XxJWvyk31bPhm4VoNJkPGZXKZsN9X1nkP
         fOz3XPK+Io7cdj5Jf8w2ZveDzVcyELOb5bm75scR9JvcMFMnQ1zCNl8BK1h4+VQ9pQmS
         F2Sw==
X-Gm-Message-State: AOJu0Yyp9oh/0w74VbmCylGHMBSUEQ5f9VIkqgmGKP9OKDdWeYKk+6Gi
        j0jJ/vPHTVUGtR9ZuL4R/RTw3Cq1q4Oiilc4FOurR9Tc+CcUGwhjKj/Er3jr3nB/29Y3fcR5a1R
        0wO82Q+mboiIZFFP8YZZ9Q5GPC1u6EdcIc2KiWyQlCXLxzA+Yww==
X-Received: by 2002:ac2:561a:0:b0:50d:151d:db97 with SMTP id v26-20020ac2561a000000b0050d151ddb97mr1928309lfd.41.1702324818195;
        Mon, 11 Dec 2023 12:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMAp5PVvZH+o8BJ56ZGS5MjIiWyvZIECzhAgMtIcq8ROee7DCo1Jyri3d03cCO8+2MLy+NDA==
X-Received: by 2002:ac2:561a:0:b0:50d:151d:db97 with SMTP id v26-20020ac2561a000000b0050d151ddb97mr1928305lfd.41.1702324817843;
        Mon, 11 Dec 2023 12:00:17 -0800 (PST)
Received: from amikhalitsyn ([2a02:8109:8624:a300:8a21:8f36:2e85:27a6])
        by smtp.gmail.com with ESMTPSA id a30-20020a509b5e000000b0054c792ad4ecsm4098730edj.82.2023.12.11.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:00:17 -0800 (PST)
Date:   Mon, 11 Dec 2023 21:00:16 +0100
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     Andrei Vagin <avagin@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH 2/2] selftests/overlayfs: verify device and inode
 numbers in /proc/pid/maps
Message-Id: <20231211210016.c6bb5b6d8c88bfcc6e33c880@canonical.com>
In-Reply-To: <20231211193048.580691-2-avagin@google.com>
References: <20231211193048.580691-1-avagin@google.com>
        <20231211193048.580691-2-avagin@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 11:30:48 -0800
Andrei Vagin <avagin@google.com> wrote:

> When mapping a file on overlayfs, the file stored in ->vm_file is a
> backing file whose f_inode is on the underlying filesystem. We need to
> verify that /proc/pid/maps contains numbers of the overlayfs file, but
> not its backing file.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../filesystems/overlayfs/.gitignore          |   2 +
>  .../selftests/filesystems/overlayfs/Makefile  |   7 +
>  .../filesystems/overlayfs/dev_in_maps.c       | 182 ++++++++++++++++++
>  .../selftests/filesystems/overlayfs/log.h     |  26 +++
>  5 files changed, 218 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/.gitignore
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/log.h
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 3b2061d1c1a5..0939a40abb28 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -26,6 +26,7 @@ TARGETS += filesystems
>  TARGETS += filesystems/binderfs
>  TARGETS += filesystems/epoll
>  TARGETS += filesystems/fat
> +TARGETS += filesystems/overlayfs
>  TARGETS += firmware
>  TARGETS += fpu
>  TARGETS += ftrace
> diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/tools/testing/selftests/filesystems/overlayfs/.gitignore
> new file mode 100644
> index 000000000000..52ae618fdd98
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +dev_in_maps
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
> new file mode 100644
> index 000000000000..56b2b48a765b
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_GEN_PROGS := dev_in_maps
> +
> +CFLAGS := -Wall -Werror
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> new file mode 100644
> index 000000000000..08497c2e10a3
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +#include <linux/unistd.h>
> +#include <linux/types.h>
> +#include <linux/mount.h>
> +#include <sys/syscall.h>
> +#include <sys/stat.h>
> +#include <sys/mount.h>
> +#include <sys/mman.h>
> +#include <sched.h>
> +#include <fcntl.h>
> +
> +#include "../../kselftest.h"
> +#include "log.h"
> +
> +static int sys_fsopen(const char *fsname, unsigned int flags)
> +{
> +	return syscall(__NR_fsopen, fsname, flags);
> +}
> +
> +static int sys_fsconfig(int fd, unsigned int cmd, const char *key, const char *value, int aux)
> +{
> +	return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
> +}
> +
> +static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_flags)
> +{
> +	return syscall(__NR_fsmount, fd, flags, attr_flags);
> +}
> +
> +static int sys_move_mount(int from_dfd, const char *from_pathname,
> +			  int to_dfd, const char *to_pathname,
> +			  unsigned int flags)
> +{
> +	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
> +}
> +
> +static long get_file_dev_and_inode(void *addr, struct statx *stx)
> +{
> +	char buf[4096];
> +	FILE *mapf;
> +
> +	mapf = fopen("/proc/self/maps", "r");
> +	if (mapf == NULL)
> +		return pr_perror("fopen(/proc/self/maps)");
> +
> +	while (fgets(buf, sizeof(buf), mapf)) {
> +		unsigned long start, end;
> +		uint32_t maj, min;
> +		__u64 ino;
> +
> +		if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llx",
> +				&start, &end, &maj, &min, &ino) != 5)
> +			return pr_perror("unable to parse: %s", buf);
> +		if (start == (unsigned long)addr) {
> +			stx->stx_dev_major = maj;
> +			stx->stx_dev_minor = min;
> +			stx->stx_ino = ino;
> +			return 0;
> +		}
> +	}
> +
> +	return pr_err("unable to find the mapping");
> +}
> +
> +static int ovl_mount(void)
> +{
> +	int tmpfs, fsfd, ovl;
> +
> +	fsfd = sys_fsopen("tmpfs", 0);
> +	if (fsfd == -1)
> +		return pr_perror("fsopen(tmpfs)");
> +
> +	if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == -1)
> +		return pr_perror("FSCONFIG_CMD_CREATE");
> +
> +	tmpfs = sys_fsmount(fsfd, 0, 0);
> +	if (tmpfs == -1)
> +		return pr_perror("fsmount");
> +
> +	close(fsfd);
> +
> +	/* overlayfs can't be constructed on top of a detached mount. */
> +	if (sys_move_mount(tmpfs, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH))
> +		return pr_perror("move_mount");
> +	close(tmpfs);
> +
> +	if (mkdir("/tmp/w", 0755) == -1 ||
> +	    mkdir("/tmp/u", 0755) == -1 ||
> +	    mkdir("/tmp/l", 0755) == -1)
> +		return pr_perror("mkdir");
> +
> +	fsfd = sys_fsopen("overlay", 0);
> +	if (fsfd == -1)
> +		return pr_perror("fsopen(overlay)");
> +	if (sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0) == -1 ||
> +	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir", "/tmp/l", 0) == -1 ||
> +	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "upperdir", "/tmp/u", 0) == -1 ||
> +	    sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "workdir", "/tmp/w", 0) == -1)
> +		return pr_perror("fsconfig");
> +	if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == -1)
> +		return pr_perror("fsconfig");
> +	ovl = sys_fsmount(fsfd, 0, 0);
> +	if (ovl == -1)
> +		return pr_perror("fsmount");
> +
> +	return ovl;
> +}
> +
> +/*
> + * Check that the file device and inode shown in /proc/pid/maps match values
> + * returned by stat(2).
> + */
> +static int test(void)
> +{
> +	struct statx stx, mstx;
> +	int ovl, fd;
> +	void *addr;
> +
> +	ovl = ovl_mount();
> +	if (ovl == -1)
> +		return -1;
> +
> +	fd = openat(ovl, "test", O_RDWR | O_CREAT, 0644);
> +	if (fd == -1)
> +		return pr_perror("openat");
> +
> +	addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
> +	if (addr == MAP_FAILED)
> +		return pr_perror("mmap");
> +
> +	if (get_file_dev_and_inode(addr, &mstx))
> +		return -1;
> +	if (statx(fd, "", AT_EMPTY_PATH | AT_STATX_SYNC_AS_STAT, STATX_INO, &stx))
> +		return pr_perror("statx");
> +
> +	if (stx.stx_dev_major != mstx.stx_dev_major ||
> +	    stx.stx_dev_minor != mstx.stx_dev_minor ||
> +	    stx.stx_ino != mstx.stx_ino)
> +		return pr_fail("unmatched dev:ino %x:%x:%llx (expected %x:%x:%llx)\n",
> +			mstx.stx_dev_major, mstx.stx_dev_minor, mstx.stx_ino,
> +			stx.stx_dev_major, stx.stx_dev_minor, stx.stx_ino);
> +
> +	ksft_test_result_pass("devices are matched\n");
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fsfd;
> +
> +	fsfd = sys_fsopen("overlay", 0);
> +	if (fsfd == -1) {
> +		ksft_test_result_skip("unable to create overlay mount\n");
> +		return 1;
> +	}
> +	close(fsfd);
> +
> +	/* Create a new mount namespace to not care about cleaning test mounts. */
> +	if (unshare(CLONE_NEWNS) == -1) {
> +		ksft_test_result_skip("unable to create a new mount namespace\n");
> +		return 1;
> +	}
> +
> +	if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
> +		pr_perror("mount");
> +		return 1;
> +	}
> +
> +	ksft_set_plan(1);
> +
> +	if (test())
> +		return 1;
> +
> +	ksft_exit_pass();
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/filesystems/overlayfs/log.h b/tools/testing/selftests/filesystems/overlayfs/log.h
> new file mode 100644
> index 000000000000..db64df2a8483
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/log.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __SELFTEST_TIMENS_LOG_H__
> +#define __SELFTEST_TIMENS_LOG_H__
> +
> +#define pr_msg(fmt, lvl, ...)						\
> +	ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",			\
> +			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
> +
> +#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
> +
> +#define pr_err(fmt, ...)						\
> +	({								\
> +		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
> +		-1;							\
> +	})
> +
> +#define pr_fail(fmt, ...)					\
> +	({							\
> +		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
> +		-1;						\
> +	})
> +
> +#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
> +
> +#endif
> -- 
> 2.43.0.472.g3155946c3a-goog
> 


-- 
Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
