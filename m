Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F3763331
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjGZKLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGZKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:11:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C5BF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:11:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-443571eda4dso2519825137.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690366293; x=1690971093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cIYONskeFY/Zr8F2UTBpiZnXm3wAy4VLqacCh7iKGw=;
        b=RXqKh+MrWLmbalQc3sthGZcbHi4CiQd3VTRhTA3t4ETWsC969x2ZPKkKB64hGUiXZB
         nwGBUz76gheuQZho9TV1TrqiYodKzjPfchoIltkQH5aWeNVQmHAH87FmaldoC+ONksSb
         s9uIUYi48X4UHWfsWTbAESSaHOEKhTA/h2XBhjfhMGSEEuk47HzHd/LJVfth3te1p0dB
         D8yVBthtcXJAacC58NLti4CV7Bj55NlquYgk8cvHoplAFYQ7AxaivjXfQzCHAam40+iS
         tQgmFjhIcSrhs9paXP2nJVdUd/pL7s1BS6lyB6piq1kzUsgLpViQl3ikujZTIG9Y+0So
         f+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690366293; x=1690971093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cIYONskeFY/Zr8F2UTBpiZnXm3wAy4VLqacCh7iKGw=;
        b=F+Ttz/HaUjhIFGcRJh5ETkZfKISRCVR/0tg4Y18Tc+IqUUKWl+Xr/TEw8lt+SpRGAy
         Wbt31o+vCmXZec5S9/LD4HwUfUl8OsBtKaHSdq0TOCBPVdhG+F5vyvTa7Tr+ZCpPW7X1
         xLUHZLCcMpS5vwYBACCoGJ9m+1z/830SaXxIBdmDyg+0UQnFNTapAnJfrKymbihGjlR5
         tGWPvquc+eClxJTEVoIn23s/qe/JE96RAIo0JccAPYZLvXZr6hRAE0t4PaHP8Hnifjyh
         95CX+TA3Q4t5mOuzBsU1eaUHdxEDUBerCf7djZbhrB+zqyCU7JOpmnkP8RTBJzvr3Jcf
         BpEA==
X-Gm-Message-State: ABy/qLYtQXhiiZiCcFUbtSFjklvbuNqXJMh10mLlycyfBmjr0o5ZoH7q
        WpuH7IUgAwIRvnZVd8aPLY/+u3UR4CNMMxZrcXTpwg==
X-Google-Smtp-Source: APBJJlF04/ae1FD5JnQlPET+OZLiq0qn6yI2HKMttTasj0MR/7IPW7myfiPSP98Dux0X0FYU2hUy3Iw8TvzH+q72xV8=
X-Received: by 2002:a05:6102:282f:b0:445:1e73:3742 with SMTP id
 ba15-20020a056102282f00b004451e733742mr912535vsb.4.1690366293574; Wed, 26 Jul
 2023 03:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104514.821564989@linuxfoundation.org>
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jul 2023 15:41:22 +0530
Message-ID: <CA+G9fYv9ra=m+tQbHiMtGGDx8pKYX+V8tP61nzpivWiyaK+-vA@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 16:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.7-rc1.gz
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

## Build
* kernel: 6.4.7-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 3c19c5641cce21ec84a7d62be76d53f454531f48
* git describe: v6.4.6-228-g3c19c5641cce
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.6=
-228-g3c19c5641cce

## Test Regressions (compared to v6.4.5)

## Metric Regressions (compared to v6.4.5)

## Test Fixes (compared to v6.4.5)

## Metric Fixes (compared to v6.4.5)

## Test result summary
total: 166993, pass: 145128, fail: 2201, skip: 19509, xfail: 155

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
