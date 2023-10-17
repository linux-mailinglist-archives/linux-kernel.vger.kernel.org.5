Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266F7CBD59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjJQI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjJQI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:27:14 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA80B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:27:10 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457c2e44f20so1732169137.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697531230; x=1698136030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuNiW8MfdRFF1D3deaPPalmKQkTFGSC9U792SF6Xw3A=;
        b=o8LMU9dvIRI6x9A8t2Gr4rQshT5F/WyWA1i24wEI6h/Ebrse0kcsBxhl3Vf9vXH8+q
         4nyu+mx9EaGwFxp5SoLePXkVueVOmi5O0hOITb+MeucQy+HtCgJpW8IfT/+J+gWuNuyC
         8KVL8x+0ClIyTONuP3Ako9HA5rSl0SvqNwh843UkZSnvbrBsSW1Azv2nultDb66to44X
         eD8BdTmaUqVw/W3Q2qiNlQSKYr4vSC+6DCKdUAh5jBlNOsUMnbAqHtOEa2/tZ3FppoiY
         cXm8zWwk1q1i8HwQJhQei2R1EUOzjSYAOXs5R3xOPhFDI+SlBdEWFJmJ7bq1lDU6g0mB
         hr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531230; x=1698136030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuNiW8MfdRFF1D3deaPPalmKQkTFGSC9U792SF6Xw3A=;
        b=fAEqMEX0EV3MJ228LhiuHFp0WYXqpRPFbSTDV7NuHIhzMVphl039mlWaqrJPUYtLue
         2V6cZDqGwZrgc1LLUY0RMPpSi90W8qzzPUbiYSXjv679HVtjn/N6b6BSD/Fn1SlB7WoW
         PSlm8DHFynOsbRqJ/ej9dt0nQIfN+IcE/eBoCkMJuykJs6Sf6oiU+frZYpvSM87xlJmM
         RE7D50TnXwQg6wPcXgpq24wUVcRLFIMD8SR9JJSoU/SZpHUyTOQhFQdo/bNNrwJ5toCE
         e8amqYXRrBMc6GpJmErhsGSpEdQQ/eeG3LXykDSZPca8cinyAlLyZT7N0HyqpLAt1ahH
         TDgg==
X-Gm-Message-State: AOJu0YyI8O16t5n8ZS4kWXAC4PNP/7cwcvegRHIBP9zjSdBVKiW+ROFE
        qZ7YP0YRAl/LOAAjPYtkvewIbAcUCmnijnUCOwk8BA==
X-Google-Smtp-Source: AGHT+IGzrO6y8hkURRNu59Pc7wIj7tbcDb2448ALRYpVrL6ZUWjyr3ZA1F5KMEcUpAa2nHMNTHJCDR0ZsN6mHrydfNU=
X-Received: by 2002:a05:6102:4411:b0:452:6e5f:cf95 with SMTP id
 df17-20020a056102441100b004526e5fcf95mr1893419vsb.23.1697531229939; Tue, 17
 Oct 2023 01:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231016084000.050926073@linuxfoundation.org>
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Oct 2023 13:56:58 +0530
Message-ID: <CA+G9fYts+TEnV=fVipsEO4zGbHDNcj-x2m5Trpcye0ptiZBrZA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 14:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.59-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 9b707223d2e986b8728181d9fb2547d1bbf8c23a
* git describe: v6.1.58-132-g9b707223d2e9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.5=
8-132-g9b707223d2e9

## Test Regressions (compared to v6.1.58)

## Metric Regressions (compared to v6.1.58)

## Test Fixes (compared to v6.1.58)

## Metric Fixes (compared to v6.1.58)

## Test result summary
total: 235203, pass: 202563, fail: 4930, skip: 27365, xfail: 345

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 292 total, 292 passed, 0 failed
* arm64: 100 total, 99 passed, 1 failed
* i386: 73 total, 71 passed, 2 failed
* mips: 56 total, 54 passed, 2 failed
* parisc: 7 total, 7 passed, 0 failed
* powerpc: 71 total, 69 passed, 2 failed
* riscv: 27 total, 26 passed, 1 failed
* s390: 27 total, 27 passed, 0 failed
* sh: 24 total, 22 passed, 2 failed
* sparc: 13 total, 13 passed, 0 failed
* x86_64: 88 total, 88 passed, 0 failed

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
* v4l2-complianciance

--
Linaro LKFT
https://lkft.linaro.org
