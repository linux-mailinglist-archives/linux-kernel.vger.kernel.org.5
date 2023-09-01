Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4DF78FC0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbjIALDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjIALDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:03:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E30D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:03:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a812843f0fso1058168b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693566209; x=1694171009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq1ZaWWf0e+kQmfjLlwO4x0N0Tvm+qnXrgEAdGFsh0Q=;
        b=tXUyx2VyMhOOsTxzurfvO4U1kdMD2hEwUN4JTjSzztD7n4ht33A/OxmBDcaKMPVzM1
         3m24PR7NHtPWUJmBGKDTHBCXIfXAD2O0Ava+2843xBl+U80z1dJcwwQ1fpfbDWREgDtZ
         Bh33FalLpeLIG2HX0i5mx/hqKjvkHjgsxpa4GywdgBaZk2Q3nMocfe45PRLBtruHKOvi
         PWKGaFfonkAJGH3jIroGXfwEnrOguy4HDyasbEDTBy9SbKmOln1KeO2Y23swEb9DtFwo
         /S52EwANBJJmGpAN2sTRCX5iTgJoOx/Jd9FNQMM+wOf+DUHwEjcbt71znkaIi3x94vd0
         zc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566209; x=1694171009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq1ZaWWf0e+kQmfjLlwO4x0N0Tvm+qnXrgEAdGFsh0Q=;
        b=GplxrksNHQ0St50dRpbEGC012RuAVFGkhtJrl42yhLmz/prwuovJ+odu2NgmezJXLP
         aky59TGF6XIA8a5en2J3a2FZ8G1o4Hc52Kyoh/jHjhEuzIgX6aq/4mIk0M6yCQ7fJQOg
         bsoUv48yWQndYP41UiReKbNGUJPVywM1qNiHYNVaABw3nGgT3AYfU1W8lTkr+mN4RL1C
         oXRm4mUvyOT/6U/IsS3ecTH+YkGR9lo0dCUvYZOciu8SMFDXe9vrNecAS5/fcy41Kjlc
         lA84etmPTm5suNwIBhJ8ybIzVJpKvv9bFAmMoZlDBOr5qlvo5oSJEVWxTACPaI8//CQs
         8ANQ==
X-Gm-Message-State: AOJu0YyVRVFXVsdJgm+fRjc/eipr0LkJFjWopLqQYqOBZ5y3BSHgmcQE
        6wKSc6BbasSco5Dcg7miLtG/a00lykSKxXCgwxdzQg==
X-Google-Smtp-Source: AGHT+IH+FF4GMpw1VoOqKIBZO2COOZg4+mIhgkTcIF/4QH3pFNYeRnK8MhX46khpI2kPHcg/XJO7aGlmHgcbZRxdDmI=
X-Received: by 2002:a05:6358:9182:b0:139:d4f9:b7a with SMTP id
 j2-20020a056358918200b00139d4f90b7amr1509836rwa.26.1693566208754; Fri, 01 Sep
 2023 04:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110830.039135096@linuxfoundation.org>
In-Reply-To: <20230831110830.039135096@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 16:33:17 +0530
Message-ID: <CA+G9fYvAny1qNkCBMRSLZCyy37Lr32CV1xs3V2mzV-0URDAHCg@mail.gmail.com>
Subject: Re: [PATCH 5.15 0/9] 5.15.130-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 16:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.130 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.130-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.130-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 46b26da4b8729ab6a0bd90326cf182a2535d938e
* git describe: v5.15.129-10-g46b26da4b872
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.129-10-g46b26da4b872

## Test Regressions (compared to v5.15.129)

## Metric Regressions (compared to v5.15.129)

## Test Fixes (compared to v5.15.129)

## Metric Fixes (compared to v5.15.129)

## Test result summary
total: 98073, pass: 79708, fail: 2412, skip: 15861, xfail: 92

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 113 passed, 1 failed
* arm64: 43 total, 42 passed, 1 failed
* i386: 34 total, 33 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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
