Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876867927A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbjIEQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353991AbjIEJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:03:18 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE2ACE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:03:15 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48d0dbf4ec5so422460e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693904594; x=1694509394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5qOg4HkZB7J4a0HNsI8RkNIcR0paBtfkrDWP5S65t4=;
        b=gWLW/kIcWVDaxlEKDwwaXM7G/fhi5f8ArNVqChI5o/TFfccNzp9B3NWj7aoDhfrZZq
         99dq9XZ/2kyz98oRmez8Nh7weB65aF/KRXgqyDfe/MxibDYyYim2dD1wX6+p8NV9pmc4
         7hvDS9lx4jjJJnLoPxYO/p+Eo3cgvGIpD50v1QoWRZW+HUDPxlsX4/wG/vKxIJf14FH/
         fDUwdQYO/oK7qpxO28IKbDSsU55GHNmAY6+DZhk4qdrtPeriKJv0Ym5XFb4gIbmYcP2o
         OcpGV/U+0ePYGMVQ6AtAc5Ue3lRam/iGmcVebiV2IyOMLtlD+8jyN2HNXz/89ulaQEHq
         sVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693904594; x=1694509394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5qOg4HkZB7J4a0HNsI8RkNIcR0paBtfkrDWP5S65t4=;
        b=dN3C10hetdcRK59QjqbgAUw+cHSATgxbZKB4paEpJ3bpU0xsZF/ndEVuf/TpoM7lI6
         hksTVcmfv7ExIzBEov/mrzJFLINdnfRLeE2uuozWfFXTzTdZuAJ8o+APq/tF5HbRpC/8
         T0z3UnM5zkLolUnAroGpufaczmHDuN3Xq6DjfvuQnl7+W4w4EAj2CTxB5jgAlkIQeFF7
         JZrmcsHp+15DO7Fg+XM0jXGjxyLFXRG6+1JzD/Axqh7NMExUZ4JPZu3Bf1WQdGp+xYzT
         hpbPLIY5zeXDknG+02XZg5M+6nYtlFrLGUHAQoJQ5lG8KlDfSa/dr0QabhyhwCV0svGy
         hDIA==
X-Gm-Message-State: AOJu0YyGnKcVUAqda8TAfbRcZLUqCRs92c5RyduuvticSjpuRtVkeqwq
        HjEmN6OrFmtCJRYKxyc6yjXMOIW8Plk6DkRC/wmOVog9wFiD86tAhQ4=
X-Google-Smtp-Source: AGHT+IE/JeKQpe2NYCRMXps9nPwUSyozHnjM8BHFtGiJZJvehyehLDv7iP4ytqnn/heiMGqrtQ38a31EpDrLueylcQ0=
X-Received: by 2002:a1f:4946:0:b0:48d:ae0:c53 with SMTP id w67-20020a1f4946000000b0048d0ae00c53mr6148810vka.10.1693904594042;
 Tue, 05 Sep 2023 02:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230904182946.999390199@linuxfoundation.org>
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Sep 2023 14:33:02 +0530
Message-ID: <CA+G9fYs9uetjpoAhVoTXPspGTs7x6BGoXWq8BuDKpx-06oHKLQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 00:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.52-rc1.gz
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
* kernel: 6.1.52-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: d0abe9b6003aae74696bf546c325193113e4b56e
* git describe: v6.1.51-32-gd0abe9b6003a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.5=
1-32-gd0abe9b6003a

## Test Regressions (compared to v6.1.51)

## Metric Regressions (compared to v6.1.51)

## Test Fixes (compared to v6.1.51)

## Metric Fixes (compared to v6.1.51)

## Test result summary
total: 123742, pass: 105963, fail: 2366, skip: 15262, xfail: 151

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 146 total, 144 passed, 2 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 40 total, 38 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 37 total, 35 passed, 2 failed
* riscv: 14 total, 12 passed, 2 failed
* s390: 15 total, 13 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 42 passed, 4 failed

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
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
