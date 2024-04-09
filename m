Return-Path: <linux-kernel+bounces-136913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6589C89D9C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76282B2164B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9012EBC9;
	Tue,  9 Apr 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbYmwGb4"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CF12E1E3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668058; cv=none; b=lm3vwnHaE6enP/Y56/8l5eSuuF5oONFGdvHWJB2IfS6JLx08ObxnIqINTjTZQeHqFHdHkKJB2QLxuGsm2EmgL1mAhU54Tz5SAqg4REu1mXFV+v6ukfa3Ly7YoglndVE+Jp/qig1MwWDHBmNTs3guYL6sxQjjr7ceOYpKPqWYAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668058; c=relaxed/simple;
	bh=G3jbVa1nPrSiku3hJVPy36PZnzjb2nMSty0D8FL1iGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8iNUEkpWkwUcMWnSnLSWSCc5dRsb03oFHWOyEnQYlKBn8/bBzGyIVNtyUnvdTUFL5MwyTUgmu7RCS914eSOXC2pnwvArhTmgQNdleBC4jJMaHCYEAhwuvqkarVRj/MDy28LyfYLeZclnaUBKUC2RWoJYnVhn8mEfXdwb6CzkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NbYmwGb4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b16b614d7so12156446d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712668056; x=1713272856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx6iswnEmfLHSA6533FOJGeKIsKx3ue2M+OGxVH6aHA=;
        b=NbYmwGb4UQ70+7VarrPVP3QXMLJD7RdVG8EzNqpwAccPXNyIwdnOipf1ZB9Lrc2po/
         zFGC6eajnVNr9/1Neo1xUwafive/QbhMc5nsrxOubbcOX2wSHyd7zE++BsTi+q3PvPcR
         ZxowMWIKvqt8Z31j8bk0e6Wa3lU9LcAvQbl8UGlqRM4Vy6Tk16dgNy7mGuLW8Qkokczz
         hviIXLK6l5w5L+NRL8u3ISrYJtWeAeWX85WEHdm7JmP1KsJ1FgO9Vj+AVbF1YPqvlpBE
         RyiQyP7o5+4T1os44WTCZN2hQUv1mVeiYFB2bZvo/ssz1bpFYlF1sUsrtFlrcKbpmjTT
         rw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712668056; x=1713272856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xx6iswnEmfLHSA6533FOJGeKIsKx3ue2M+OGxVH6aHA=;
        b=u24AvoA3YXnBcmEacURgDTCluMKVMGngrxb38U8SZP7J9w+of4bxHTkRAwWGhnuGCk
         JBP6Z3zkuXKxQ9LF+J6ZLHRWnk63f3r2OxxKQbVBul1EDMG522eLFr7507MVWI8LwqLX
         h5IEkzOzP8KXuwbAjqiRNiwW6/6a3/nZfK/RRZbaMFVZcxoDwg+P+VPmUKmciz7mN2ne
         SOXDSl/NFGvtvgDJOsF+rXBdx9MbRgyl8hLC4TZoXgjZ35q44+rOgkh+Bpr7V6SJDvTV
         vBJUH7vasXNuuEr7ZBZJDcZ2xYlFSyFtjjh12NGrdNw3QdAY31OPO4z2IhK69ltEtEpG
         cWpA==
X-Forwarded-Encrypted: i=1; AJvYcCW2GrG/GGo1z3TwT5KIjrIaqw44FBBK0FQnWesch86CWAk9otBZQLFRc1CuR+6QpwhozWO6smX6MXGFpKm1wJKYZwT6+MCLx1Hs1DMJ
X-Gm-Message-State: AOJu0YzT6yGh6PMPkD4E8+BfbCsxrySiL1BeeRY7NEJMwmdWtuZTMmJn
	/n2Uqfjya9rmhzUVfxHXNiXL5Djs0wDGnZok94KLj+/ulomNKAblKssTGk46AWi09G4lKzmz6xS
	sF7y1tCl0iMR/xCQ5jwixFZpdqewpdVG7/ntCAg==
X-Google-Smtp-Source: AGHT+IELKVLoxp4BdP2Pp63hR/9HZLVoc3REPE9/2r7IFJMyKZvh+BKa08KlhiCXdL3Nk+SwD4ToJ3np3su3u+WMsGk=
X-Received: by 2002:a05:6214:4106:b0:69b:247b:a4f9 with SMTP id
 kc6-20020a056214410600b0069b247ba4f9mr3745285qvb.6.1712668055704; Tue, 09 Apr
 2024 06:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125309.280181634@linuxfoundation.org>
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 9 Apr 2024 15:07:24 +0200
Message-ID: <CADYN=9KoZSBy_sbKR9ZTzcUXuUgA+PwdhAMuA5BEHP-BHjdnNg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, bvanassche@acm.org, 
	Alexander@wetzel-home.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 15:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
Regressions on x86_64, and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following kernel warnings have been noticed on  x86_64, qemu-x86_64 and
qemu-i386 while running LTP cve ioctl_sg01 tests the kernel with stable-rc
6.6.26-rc1 and 6.8.5-rc1.

Reverted this patch and I couldn't see the repoted warning.
scsi: sg: Avoid sg device teardown race
[ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]

This has been reported on stable-rc 6.8.3-rc1 [1].


tst_test.c:1709: TINFO: LTP version: 20240129
tst_test.c:1593: TINFO: Timeout per run is 1h 02m 30s
<4>[   47.841092] ------------[ cut here ]------------
<4>[   47.846033] WARNING: CPU: 1 PID: 23 at drivers/scsi/sg.c:2236
sg_remove_sfp_usercontext+0x146/0x150
<4>[   47.848749] Modules linked in:
<4>[   47.851081] CPU: 1 PID: 23 Comm: kworker/1:0 Not tainted 6.8.5-rc1 #1
<4>[   47.852690] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
<4>[   47.854570] Workqueue: events sg_remove_sfp_usercontext
<4>[   47.855851] RIP: 0010:sg_remove_sfp_usercontext+0x146/0x150

<trim>

<4>[   47.867679] Call Trace:
<4>[   47.868114]  <TASK>
<4>[   47.868608]  ? show_regs+0x69/0x80
<4>[   47.869035]  ? __warn+0x8d/0x150
<4>[   47.869454]  ? sg_remove_sfp_usercontext+0x146/0x150
<4>[   47.869882]  ? report_bug+0x171/0x1a0
<4>[   47.870386]  ? handle_bug+0x43/0x80
<4>[   47.870720]  ? exc_invalid_op+0x1c/0x80
<4>[   47.871046]  ? asm_exc_invalid_op+0x1f/0x30
<4>[   47.871537]  ? __call_rcu_common.constprop.0+0x281/0x3c0
<4>[   47.872033]  ? sg_remove_sfp_usercontext+0x146/0x150
<4>[   47.872643]  process_one_work+0x143/0x300
<4>[   47.873029]  worker_thread+0x2f6/0x440
<4>[   47.873507]  ? __pfx_worker_thread+0x10/0x10
<4>[   47.873855]  kthread+0xf4/0x120
<4>[   47.874274]  ? __pfx_kthread+0x10/0x10
<4>[   47.874612]  ret_from_fork+0x41/0x60
<4>[   47.874952]  ? __pfx_kthread+0x10/0x10
<4>[   47.875412]  ret_from_fork_asm+0x1b/0x30
<4>[   47.875865]  </TASK>
<4>[   47.876335] ---[ end trace 0000000000000000 ]---
ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked


[1]
 - https://lore.kernel.org/stable/CA+G9fYs5MZaPV+tTukfUbJtdztQMExfixo=ZwbBr1A6Oga+OLQ@mail.gmail.com/

[2]
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.4-274-g51d60edf2813/testrun/23350725/suite/log-parser-test/test/check-kernel-warning-baa412705664036587615ec565701ad300aa78b0e977d057b0a9de2be870cf86/log

## Build
* kernel: 6.8.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: 51d60edf281355bf4653c327050d7a5aeedb9b0d
* git describe: v6.8.4-274-g51d60edf2813
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.4-274-g51d60edf2813

## Test result summary
total: 173708, pass: 150838, fail: 2030, skip: 20672, xfail: 168

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 126 total, 126 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-sm[
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

