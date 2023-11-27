Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933687FA410
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjK0PHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjK0PHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:07:17 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0682C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:07:22 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fa0885e1c2so1680628fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701097642; x=1701702442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=617F3nRFGfW3UqBuyZB3u1rDTGABWEPSTQud8GzjBzk=;
        b=i9DzzgJSUp2niGRwrO651n74vzXzf86V82602pm/5MocItfgrNilo6nW8W/PfNBjDR
         oCs42y2lDkG+ehceaONvJeYjPvMmIeCuwaZ9FoPlm7gRtCOFXDhMAC8uSJNnwZog9KF5
         w8vzVZtfzBfGvkA70WsPKTgwiwHXDgu4niw9W67wQlvkSDWcjG3T8uWPrtkGjJR8B1Pr
         LQLvgWIK04/8tLgF3n/hYyRSr4rE9itZrtH4zkW3p8TmoiLBMGXemzcSJ2nbN9qU73IT
         hxkUZSi17Z8i3cGNTxp+XxXa0hyfxZUa9N+prdtaakxuUU8wOYc6on3bsvt3GiPchRAH
         0r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097642; x=1701702442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=617F3nRFGfW3UqBuyZB3u1rDTGABWEPSTQud8GzjBzk=;
        b=qQ3dAIn5rwEXsEJOfQX+VtkgHgWFnS/JDDXazGgZUg/G3GdDSTnvxhbGKTkWBpKcFZ
         HYCoXKGQ6IkkQ+ppVXOBSvC4H0s5QuHyumCLM/1pkku2S6r+THa0jTxGRZYA+2tDyUZH
         l9H8SoaR6nIBZAjZ27ybGOUb6ap8C3tNMoIGDagFlEmcP+NICTK9r+If2Js7vCSk3VhK
         VPkZ6bth4fgKVEkbL93jd+ZE0RdPCaCwNSTF8NakItf0H6wvFQbfLLr4Zxcj4VdDtBi+
         Ewa1uImx+0SaVOuqMWLrMn3ycyubGTX4IvtyUYjwXKhEVPWt8UFVyPOCgl33Fm4m3nKB
         LZbQ==
X-Gm-Message-State: AOJu0YzpTl8j/J82vAEnSU73J+rzxRTX+0Qe4jiCs1Xsa7na7RGmpl5Y
        qSm6L+KFn9S/FHuFyEs/kyOJhA4P8cEt/bV44AET9w==
X-Google-Smtp-Source: AGHT+IFvZrl7BIb5d3tTlFoJOASc2MpvQcgnwFTo1ywhOZENB3Nr/odyqW/Ttj/Xz/CbqfiMCY08+s467BmGTWxl2z8=
X-Received: by 2002:a05:6358:9194:b0:16e:292:2af2 with SMTP id
 j20-20020a056358919400b0016e02922af2mr11695350rwa.21.1701097635756; Mon, 27
 Nov 2023 07:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20231126154413.975493975@linuxfoundation.org>
In-Reply-To: <20231126154413.975493975@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Nov 2023 20:37:03 +0530
Message-ID: <CA+G9fYsUXnx4HWyBOGMi3Ko_jT6Y_ejp5ZhcsU+8+_8NUsd=vA@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/483] 6.5.13-rc4 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 at 21:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
The following regressions found on all arm64 devices.
Both the regressions are also seen on stable-rc linux-6.1.y.

1) selftests: seccomp: seccomp_bpf - fails on all arm64 devices.
2) Perf: PMU_events_subtest_1 / 2  - fails on all qemu-armv7 and TI x15.

Test log:
--------
1)
# selftests: seccomp: seccomp_bpf
<>
# #  RUN           global.user_notification_sync ...
# # seccomp_bpf.c:4294:user_notification_sync:Expected

ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
               SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0) (-1) == 0 (0)

# # user_notification_sync: Test terminated by assertion
# #          FAIL  global.user_notification_sync
# not ok 51 global.user_notification_sync
<>
# # FAILED: 95 / 96 tests passed.
# # Totals: pass:95 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=1

Links:
 - https://lkft.validation.linaro.org/scheduler/job/7056513#L2725
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.12-484-gecc37a3a8d33/testrun/21318788/suite/kselftest-seccomp/test/seccomp_seccomp_bpf/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.12-484-gecc37a3a8d33/testrun/21318263/suite/kselftest-seccomp/test/seccomp_seccomp_bpf/history/


2)
perf
  - PMU_events_subtest_1
  - PMU_events_subtest_2

 10.1: PMU event table sanity                           :
--- start ---
test child forked, pid 339
perf: Segmentation fault
Obtained 1 stack frames.
perf(+0xdfcd9) [0x571cd9]
test child interrupted
---- end ----
PMU events subtest 1: FAILED!
 10.2: PMU event map aliases                            :
--- start ---
test child forked, pid 340
perf: Segmentation fault
Obtained 1 stack frames.
perf(+0xdfcd9) [0x571cd9]
test child interrupted
---- end ----
PMU events subtest 2: FAILED!

Links:
 - https://lkft.validation.linaro.org/scheduler/job/7059997#L2905
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.12-486-g1c613200bbe4/testrun/21344368/suite/perf/test/PMU_events_subtest_1/details/

## Build
* kernel: 6.5.13-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: ecc37a3a8d335716260debdf063a278ea74379a4
* git describe: v6.5.12-484-gecc37a3a8d33
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.12-484-gecc37a3a8d33

## Test Regressions (compared to v6.5.12)

* bcm2711-rpi-4-b, kselftest-seccomp
  - seccomp_seccomp_bpf

* juno-r2, kselftest-seccomp
  - seccomp_seccomp_bpf

* dragonboard-410c, kselftest-seccomp
  - seccomp_seccomp_bpf

* qemu-armv7, perf
  - PMU_events_subtest_1
  - PMU_events_subtest_2

* x15, perf
  - PMU_events_subtest_1
  - PMU_events_subtest_2

## Metric Regressions (compared to v6.5.12)

## Test Fixes (compared to v6.5.12)

## Metric Fixes (compared to v6.5.12)

## Test result summary
total: 150231, pass: 128862, fail: 2428, skip: 18810, xfail: 131

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 146 total, 146 passed, 0 failed
* arm64: 53 total, 51 passed, 2 failed
* i386: 42 total, 42 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 47 total, 47 passed, 0 failed

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
