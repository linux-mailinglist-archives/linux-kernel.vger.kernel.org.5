Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76797BA873
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJERtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjJERtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:49:21 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20483
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:49:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-452c0d60616so847912137.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696528158; x=1697132958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVaWYb4+3M7dCJt2YIHPYSC631IOF/2aCSBRbGV8Xdc=;
        b=eYr/l7tMfULv1C9g5AzNSXyQl7C/vq65JEcKY1Jrf2kye3y9tue/pxrXMMGVNAyAXJ
         SuBvCRem+MG6H0mtabFqN0R3PhdOVbe7G7mjBoYuBmoxv19MS1ZrxJgj81aECTbFcesY
         W6r4XEbvP8irf3fOim2uAOk8J9FY2/NsumPirz448Ld+51L4AvZam+JQYFILElzPmGiY
         WiMoeXgPK540dihBPVuP0xAst+WtBc3Kh1XInfF1mUJYYTmGZitFd9MydsVwxKoqU82n
         IKC+iCZvM3gd5Pr1JU68V4ccdCpQDJ3HssW7oMc+HePt4TwR0mF3ggShNx/lN77DO5+O
         fWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528158; x=1697132958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVaWYb4+3M7dCJt2YIHPYSC631IOF/2aCSBRbGV8Xdc=;
        b=mEK/j/darV2wcoDRZCZKFeICkfLFYeN91SIqDnpeK+vC9xJgG4vO27orlxXHNV9N+E
         cdblZhv46DTDRc9lIg+6zbRQ4yh43/kdztpvHgUOzsDSQrjP+2wYP3Y4q/ymdH+Ots4T
         oNFzq0poLVzbUF0uuW5xSutmttWGEy1IFCnV/EROJoaPzkvwQr6U1fP9O/aGvpSFE5tk
         omyCgkQqAma07usvjvLIgBL66zhbsaaFitk6OIqlSoE0AjW9dVxBY3bhMNdzdRc6JEDM
         kZQCPj24aOvFzibTSri2Na6lriC+xMU4l4XQ5FlMw07cltMhyQKnUJ8wgBYdTBDjIq7E
         6Bnw==
X-Gm-Message-State: AOJu0YxHQZuI6ruHsWRqYBOeGr41fHfdjQRt/b5fsYc5r4w1+8m60qSr
        MzM/+4akBb2XMcq5mdI8IJNsF2SDuJZU37B3EketmA==
X-Google-Smtp-Source: AGHT+IGXQQ4J8RH++FstjXOPQ91TmHpsC85m+S5R7H656lvBcYH59aRKbKvcgmbKyXU3X9f2mkG72W/X6VI/bB6XNHg=
X-Received: by 2002:a05:6102:40b:b0:44d:42c4:f4bf with SMTP id
 d11-20020a056102040b00b0044d42c4f4bfmr2068013vsq.10.1696528158254; Thu, 05
 Oct 2023 10:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175203.943277832@linuxfoundation.org>
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Oct 2023 23:19:06 +0530
Message-ID: <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 23:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.134-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on x86.

Following kernel warning noticed on x86 while booting stable-rc 5.15.134-rc=
1
with selftest merge config built kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anyone noticed this kernel warning ?

This is always reproducible while booting x86 with a given config.

x86 boot log:
-----
[    0.000000] Linux version 5.15.134-rc1 (tuxmake@tuxmake)
(x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP @1696443178
...
[    1.480701] ------------[ cut here ]------------
[    1.481296] WARNING: CPU: 0 PID: 13 at kernel/rcu/tasks.h:958
trc_inspect_reader+0x80/0xb0
[    1.481296] Modules linked in:
[    1.481296] CPU: 0 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.134-rc=
1 #1
[    1.481296] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[    1.481296] RIP: 0010:trc_inspect_reader+0x80/0xb0
[    1.481296] Code: b6 83 45 04 00 00 84 c0 75 48 c6 83 45 04 00 00
01 b8 01 00 00 00 5b 41 5c 5d c3 cc cc cc cc 0f 94 c0 eb b4 f6 43 2c
02 75 02 <0f> 0b 48 83 05 36 f8 ee 02 01 b8 01 00 00 00 48 83 05 21 f8
ee 02
[    1.481296] RSP: 0000:ffffb25e000afd70 EFLAGS: 00010046
[    1.481296] RAX: 0000000000000000 RBX: ffff9b40c080d040 RCX: 00000000000=
00003
[    1.481296] RDX: ffff9b4427b80000 RSI: 0000000000000000 RDI: ffff9b40c08=
0d040
[    1.481296] RBP: ffffb25e000afd80 R08: e32db91cdfdc3bef R09: 00000000035=
b89d4
[    1.481296] R10: 000000006a495065 R11: 0000000000000030 R12: ffffffffae6=
92100
[    1.481296] R13: 0000000000000000 R14: ffff9b40c080d9a8 R15: 00000000000=
00000
[    1.481296] FS:  0000000000000000(0000) GS:ffff9b4427a00000(0000)
knlGS:0000000000000000
[    1.481296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.481296] CR2: ffff9b4297201000 CR3: 00000002d5e26001 CR4: 00000000003=
706f0
[    1.481296] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    1.481296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    1.481296] Call Trace:
[    1.481296]  <TASK>
[    1.481296]  ? show_regs.cold+0x1a/0x1f
[    1.481296]  ? __warn+0x88/0x120
[    1.481296]  ? trc_inspect_reader+0x80/0xb0
[    1.481296]  ? report_bug+0xa8/0xd0
[    1.481296]  ? handle_bug+0x40/0x70
[    1.481296]  ? exc_invalid_op+0x18/0x70
[    1.481296]  ? asm_exc_invalid_op+0x1b/0x20
[    1.481296]  ? rcu_tasks_kthread+0x250/0x250
[    1.481296]  ? trc_inspect_reader+0x80/0xb0
[    1.481296]  ? rcu_tasks_kthread+0x250/0x250
[    1.481296]  try_invoke_on_locked_down_task+0x109/0x120
[    1.481296]  trc_wait_for_one_reader.part.0+0x48/0x270
[    1.481296]  rcu_tasks_trace_postscan+0x76/0xb0
[    1.481296]  rcu_tasks_wait_gp+0x186/0x380
[    1.481296]  ? _raw_spin_unlock_irqrestore+0x35/0x50
[    1.481296]  rcu_tasks_kthread+0x145/0x250
[    1.481296]  ? do_wait_intr_irq+0xc0/0xc0
[    1.481296]  ? synchronize_rcu_tasks_rude+0x20/0x20
[    1.481296]  kthread+0x146/0x170
[    1.481296]  ? set_kthread_struct+0x50/0x50
[    1.481296]  ret_from_fork+0x1f/0x30
[    1.481296]  </TASK>
[    1.481296] irq event stamp: 132
[    1.481296] hardirqs last  enabled at (131): [<ffffffffaf7936a5>]
_raw_spin_unlock_irqrestore+0x35/0x50
[    1.481296] hardirqs last disabled at (132): [<ffffffffaf79345b>]
_raw_spin_lock_irqsave+0x5b/0x60
[    1.481296] softirqs last  enabled at (54): [<ffffffffae69201c>]
rcu_tasks_kthread+0x16c/0x250
[    1.481296] softirqs last disabled at (50): [<ffffffffae69201c>]
rcu_tasks_kthread+0x16c/0x250
[    1.481296] ---[ end trace 5a00c61d8412a9ac ]---


Links:
----
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
.15.133-184-g6f28ecf24aef/testrun/20260259/suite/log-parser-boot/test/check=
-kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
.15.133-184-g6f28ecf24aef/testrun/20260259/suite/log-parser-boot/tests/
 Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJFhcfqqG69=
pqj6LWuI14kVoP5/

steps to reproduce:
--------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJFhcfqqG69pqj6L=
WuI14kVoP5/tuxmake_reproducer.sh

## Build
* kernel: 5.15.134-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 6f28ecf24aef2896f4071dc6268d3fb5f8259c77
* git describe: v5.15.133-184-g6f28ecf24aef
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.133-184-g6f28ecf24aef

## Test Regressions (compared to v5.15.133)
* x86, log-parser-boot
  - check-kernel-exception
  - check-kernel-warning

* x86, log-parser-test
  - check-kernel-exception
  - check-kernel-warning


## Metric Regressions (compared to v5.15.133)

## Test Fixes (compared to v5.15.133)

## Metric Fixes (compared to v5.15.133)

## Test result summary
total: 90392, pass: 71514, fail: 2557, skip: 16224, xfail: 97

## Build Summary
* arc: 4 total, 4 passed, 0 failed
* arm: 114 total, 114 passed, 0 failed
* arm64: 42 total, 42 passed, 0 failed
* i386: 32 total, 31 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 13 total, 11 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
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
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
