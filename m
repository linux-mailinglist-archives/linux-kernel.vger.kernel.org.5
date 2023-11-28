Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836B7FB9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjK1MAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjK1MAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:00:04 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A0AC2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:00:10 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so1348078241.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701172809; x=1701777609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8mw1BBxaan41I9CSKaTQssL+4Iit3B3xfGkQ2tsLjQ=;
        b=bPowrISifx0CtGUe6Qid5AnT1qLi3pPNtvhN3x6QZ0D1hfGQ5ECVlfwfEyEHn6XWo1
         YSxuA7skJcQdOWnKP+mQwkaqkkusGoHMwCAqOE4LY9vL+X8HHBxDT938zELCNo8qQ91f
         FLB2CUzNVAN1YazZLn5m/3OkfLL8GAnaaMzSh5BXQ8afwgKK0e/cyP9zw+rs134R50Gd
         5P5D2obHfYVjk2jG7MW5LOf6g0TF1vLUCgecvTaS4Oue67N5ds4qiAeN1L+zDtJZH81S
         sCqy1mRnoAafiPZR0aB2Ih5/9N5XGuRiG4g0O/bOtx+3IDw+T8HPgJ7HIpNFElV637st
         5NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172809; x=1701777609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8mw1BBxaan41I9CSKaTQssL+4Iit3B3xfGkQ2tsLjQ=;
        b=oArImMoabq8BUm/NsonbzP+qaBEOJrEGgnrbbYOuUSfX6rlE0On6Ca7F1lVG8Grlax
         sVd8ABwdayJEIsxA9hLoYG8UPfRJt0PtvUyFMi8Wwo1bG/DRZ41w6Goj8J3/KTmhQmPQ
         VanF+OYSKtrjTCXtNqrOc2JNsx1/V2nrfO8WqZ4zjXPr3jzoHw35hoNq/e1k7nCsYPQ+
         omxo03SkEDqOuBmstiyU1UQdJw/IsRqaY4Xz0mwHOgXqB15z1qW4cpu7enQ4QVQUiW3e
         +8HQDwkzaql+HBI46Cif59MJScqkinpuBe4DMqoEk7KR5Gjz2dKsd4cMUpufVBckqWDr
         nhOw==
X-Gm-Message-State: AOJu0Yy+vDrqiuJxkeMRjB3Fkn35BlRC5T0L1L/D3Xy4DgNLvMUfQdIn
        DWcasBbILu9zYgyo6wq4O+rg2NllZ0Mnnx/rWGTj9Q==
X-Google-Smtp-Source: AGHT+IFfqgv/3Uaurmh33ezO33O76n9Jf80DJ8xYWK8+FGfFie2AFINkJF8CYB6v9LFf/UozfxTwG+pmSmxcxoxLciw=
X-Received: by 2002:a05:6102:34f1:b0:462:8d09:93d2 with SMTP id
 bi17-20020a05610234f100b004628d0993d2mr14651660vsb.3.1701172808970; Tue, 28
 Nov 2023 04:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20231126154348.824037389@linuxfoundation.org>
In-Reply-To: <20231126154348.824037389@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Nov 2023 17:29:48 +0530
Message-ID: <CA+G9fYveNT9jVqUSrugWQ9aRq2XrCGOdEnqxoieaSiSKE_vJiw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/292] 5.15.140-rc3 review
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

On Sun, 26 Nov 2023 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
1)
Perf: PMU_events_subtest_1 / 2  - fails on all qemu-armv7 and TI x15 device.
These perf failures are also noticed on mainline / vanila kernel on 32-bit arch.

## Build
* kernel: 5.15.140-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 659e621811001944973a85712a1f1ce31200daec
* git describe: v5.15.139-292-g659e62181100
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.139-292-g659e62181100

## Test Regressions (compared to v5.15.139)

## Metric Regressions (compared to v5.15.139)

## Test Fixes (compared to v5.15.139)

## Metric Fixes (compared to v5.15.139)

## Test result summary
total: 96041, pass: 75848, fail: 2597, skip: 17534, xfail: 62

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
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
* kselftest-x86
* kselftest-zram
* kunit
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
