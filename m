Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9C75811D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGRPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjGRPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:39:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271E1726
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:38:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso7980537a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689694731; x=1692286731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLioVgA1gUOrbornlU5isW1iy/mYKUMhb3XwnGxISqM=;
        b=BzugDmWybXG2LrJG1qrtQETWyKAh9ufRsq+N1Zj8JniX0fCV7aqopO/5FPQ2KWaa1R
         RK/H508Mym1XQBCtY0AEclIQ0hQJjA6OTMmtmbzfHkX6aNRkgaLbeEQvAHBUXSW0pyp8
         u/aE6Epy5RO5a7j9oVVUKHIsGPvzvyPaREFlESg255uL2gHCotlyyfO0gQbYwXjJD/jR
         htDUqhGhNAftoa6b5p5otcwcp/OQAaEju5qL9s3FKBsmNGchPaa3A9SZj2ZXvEqhYC/k
         pxckryTPgj7u4wwCrC6wQM2piqV5tY/BXXDJkbyawzI2F0wgnMNiB+AKP904nDuOPPej
         lsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694731; x=1692286731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLioVgA1gUOrbornlU5isW1iy/mYKUMhb3XwnGxISqM=;
        b=j9x6MSRjY+KRNvaooO3egudnQss4ZNP7lwgc9S90HogIxGj32Zs4n3mScHPJGRWryI
         Zgr0NZ04nALz7wEIUbGYoHtTsjYyqi6kl97aK5ofguxfEZz9k4/OSljTZHZvHL2lvsbi
         i66lAFAI70u7Fb3zLabDgbn2GOb/ByR6KeLFiNRV5W0iJn/PBaGA6WVzxhQewvmNiPP9
         a+Lj7JZ5UXarIaABodOAEa6Fv4qWOu3CHQnhrW5XOJr31lUPHSrInesGp8yHZoyOs/C5
         1LQlhmxP5i5Isdn/RF0aj4Uz6mfkAFNWoAGNu2pBYzgf77HUcL/c1JPERyqQxWpHvz+V
         OqfQ==
X-Gm-Message-State: ABy/qLZpogeqUpunCv5+zo20kaSX1g1pjlFAKzoothTzysnYf6MkU5kj
        eG+ITn9Dzxgktp+ETiOx1k0pX4xiz6FX8NyDfFvYcg==
X-Google-Smtp-Source: APBJJlEhaj4EMbuNXR+5V2FXW2eoMOaK2lG9dG/p2NP/RlQMJ2MU1iasTF1aYVc3PWjBSe6nvMN3ccShiGxt1LR6T5k=
X-Received: by 2002:a05:6402:882:b0:51f:e92a:62ba with SMTP id
 e2-20020a056402088200b0051fe92a62bamr269135edy.9.1689694730940; Tue, 18 Jul
 2023 08:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201608.814406187@linuxfoundation.org>
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jul 2023 21:08:38 +0530
Message-ID: <CA+G9fYs56L1OzJA=kmXmtTGXnhfjX0Va0bu5An-b5Fxcjnioqw@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
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

On Tue, 18 Jul 2023 at 02:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.4-rc3.gz
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
* kernel: 6.4.4-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 0e8d2fdfb18871a5de031927a37af3cacbaf1d16
* git describe: v6.4.3-802-g0e8d2fdfb188
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.3=
-802-g0e8d2fdfb188

## Test Regressions (compared to v6.4.1-22-g3e37df3ffd9a)

## Metric Regressions (compared to v6.4.1-22-g3e37df3ffd9a)

## Test Fixes (compared to v6.4.1-22-g3e37df3ffd9a)

## Metric Fixes (compared to v6.4.1-22-g3e37df3ffd9a)

## Test result summary
total: 175129, pass: 150209, fail: 2026, skip: 22723, xfail: 171

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
