Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2FA75DAF6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGVIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:06:35 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C12733
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:06:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4468a772490so983281137.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690013192; x=1690617992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNkbbtsn9qr0Zhw1Ph3h1UXRvjDGkUtBXUzhMVwOQCM=;
        b=TCO5NuggBbo11qLwjwVJZx9BrZID22Pp1b+5WlEKD11C3dGvngvQG1bpfdu49mLWeg
         4xCRC61HmKHS1n819+7pCR6TJuJoj165tOkj/3dliSnE2D6Ju5vPxbalAZ9bYpd/198A
         6KqpCGY/oYD+uvU/bAibuKmd1U80v5OtfRjdqzPVRNDnxHeVpEW8e2Le+e50HrbRjEy2
         fxAOGwF0KVym4wY81s0Pp4xAa9QawOhejqeI2CuN5do1mbFY4C6tZXj8YYYtDjzJH4Pm
         hfBILOwD8HAy7DWRwptr6nu4mSxBBealZ1l9KDPrWatflCHxkm9GROPMmUwhy4JqGg2f
         Degg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690013192; x=1690617992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNkbbtsn9qr0Zhw1Ph3h1UXRvjDGkUtBXUzhMVwOQCM=;
        b=bpndvASBnmvDwwfvrcgiWaUH2m8+2j5xWpiMNtFE+Tlvz8of/6Wj44TLK5QW3IlFIj
         BFU6nHaVJAkxM4MI3crSPkkMsPDZiKJi2WOWffQrOZgE8oJU1mXy3tGxxpbnoOMBlAFv
         995uLML9tKHUVMfL9sX5t97MSe0cq7eVdNLxIoQL8OJzBJB9h8KcBbod16TV2jlz4V95
         Iu4F/DTJckEiPMmekNqJrHSZ1r4cyt3zYaLN3hdYGoIUH8YsL69j/TQ2F3G2VbamLtFK
         oAHTv0+u4FgPYeBv7/uIHq/ULDHx9FUq/BqdmdEKIwY1hL0nW+X2i2PrlFBNrZHZcJ7p
         tcWw==
X-Gm-Message-State: ABy/qLYVdczVKYtug8cd7TyoyWCogETM3QQtoavoWnELyFL7kWe5mAGp
        wouUcoSbQrnjkpvShGjPYxsPbM7Gr/VrFKbWlsaQzw==
X-Google-Smtp-Source: APBJJlF8UIHUxYpZE3PJohHSduJIA1z/bkGyIIZJ56buqxFu0dVgG+rd+XtLkGcn0dS5K5vk2WBEAZ9mLAo5bqDv8tI=
X-Received: by 2002:a1f:d945:0:b0:46e:7158:1cf0 with SMTP id
 q66-20020a1fd945000000b0046e71581cf0mr2170090vkg.10.1690013192242; Sat, 22
 Jul 2023 01:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230721160528.800311148@linuxfoundation.org>
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 22 Jul 2023 13:36:20 +0530
Message-ID: <CA+G9fYvgy22wiY=c3wLOrCM6o33636abhtEynXhJkqxJh4ca0A@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 21:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The following kernel warning was noticed while booting qemu-arm64
with these configs enabled on stable rc 6.4.5-rc1.

 CONFIG_ARM64_64K_PAGES=3Dy
 CONFIG_KFENCE=3Dy

This crash is not easily reproducible.

boot logs:
--------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.4.5-rc1 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT @1689957802
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
...
<6>[    0.006821] kfence: initialized - using 33554432 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
...
<4>[    7.726994] ------------[ cut here ]------------
<4>[    7.727704] WARNING: CPU: 1 PID: 1 at mm/kfence/core.c:1097
__kfence_free+0x84/0xc8
<4>[    7.730078] Modules linked in: ip_tables x_tables
<4>[    7.732637] CPU: 1 PID: 1 Comm: systemd Not tainted 6.4.5-rc1 #1
<4>[    7.733334] Hardware name: linux,dummy-virt (DT)
<4>[    7.734765] pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=3D--)
<4>[    7.735323] pc : __kfence_free+0x84/0xc8
<4>[    7.736036] lr : __slab_free+0x490/0x508
<4>[    7.736374] sp : ffff8000080afb40
<4>[    7.736657] x29: ffff8000080afb40 x28: ffffffc0003fa100 x27:
0000000000000000
<4>[    7.738294] x26: 0000000000000000 x25: 0000000000000001 x24:
0000000000000000
<4>[    7.739138] x23: ffffcd8ea7099000 x22: ffffcd8ea45cac38 x21:
ffff0000fe840000
<4>[    7.739961] x20: ffffcd8ea45cac38 x19: ffff0000c0012300 x18:
0000000000000000
<4>[    7.740778] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[    7.741636] x14: 0000000000000000 x13: 0000000000000000 x12:
0000000000000000
<4>[    7.742474] x11: 0000000000000000 x10: 0000000000000000 x9 :
ffffcd8ea45601e0
<4>[    7.743407] x8 : ffff8000080afc20 x7 : 0000000000000000 x6 :
0000000000009901
<4>[    7.744268] x5 : ffffcd8ea45cac38 x4 : ffffcd8ea7099000 x3 :
ffffcd8ea76e7aa0
<4>[    7.745093] x2 : ffff0000c162e000 x1 : ffffcd8ea76fa5b0 x0 :
ffff0000fe840000
<4>[    7.746478] Call trace:
<4>[    7.746776]  __kfence_free+0x84/0xc8
<4>[    7.747134]  __slab_free+0x490/0x508
<4>[    7.748063]  __kmem_cache_free+0x2b4/0x2d0
<4>[    7.748377]  kfree+0x78/0x140
<4>[    7.748638]  single_release+0x40/0x60
<4>[    7.750664]  __fput+0x78/0x260
<4>[    7.751065]  ____fput+0x18/0x30
<4>[    7.752086]  task_work_run+0x80/0xe0
<4>[    7.753122]  do_notify_resume+0x200/0x1398
<4>[    7.754292]  el0_svc+0xec/0x100
<4>[    7.754573]  el0t_64_sync_handler+0xf4/0x120
<4>[    7.755559]  el0t_64_sync+0x190/0x198
<4>[    7.756643] ---[ end trace 0000000000000000 ]---

Links
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.4-293-g4f44255da83d/testrun/18526234/suite/log-parser-boot/test/check-ker=
nel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.=
4.4-293-g4f44255da83d/testrun/18526234/suite/log-parser-boot/tests/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2StEPFnEfoD076PRu=
8fIxjexhnM/



## Build
* kernel: 6.4.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 4f44255da83d4e0d6c39114e6d90f43705c9159d
* git describe: v6.4.4-293-g4f44255da83d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.4=
-293-g4f44255da83d

## Test Regressions (compared to v6.4.4-150-g698271d38e0b)

## Metric Regressions (compared to v6.4.4-150-g698271d38e0b)

## Test Fixes (compared to v6.4.4-150-g698271d38e0b)

## Metric Fixes (compared to v6.4.4-150-g698271d38e0b)

## Test result summary
total: 165616, pass: 143054, fail: 2212, skip: 20190, xfail: 160

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 141 passed, 0 failed
* arm64: 50 total, 50 passed, 0 failed
* i386: 37 total, 37 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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
* kselftest-filesytems-epoll
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
* kselftest-livepatch
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
* kselftest-timers
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
