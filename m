Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C078FDBC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjIAMtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbjIAMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:49:32 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D531730
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:49:03 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a52db1e4bbso780923241.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693572541; x=1694177341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZAs7VhAqmwUCso6UvdFSw8g4rQU2c3GRkXTqdKEPuI=;
        b=ytb7htLfrvWt41qfMkNUIZce3KVaGokwUd0FsIqIt5zwhUogAFDBrM3W2mceDiwbcx
         SrauAwV64OW/i5a5YuiIRWgWX2xaS/n2Zo8sc9a8qKxwzdaFi334IpsltWrnlr3F5pAj
         0TfILZIqGaA1wuGVS3kfHmy1QpTsuFmmLaWjY7+x/5KIQWfaiGywoRcR911t4X+/vfBP
         s777e9PYzN1rbDH/BVs35CqSCtjB3NeDUB5woVFpa/dEnx4PrumNZkHKbqvOaFzSb5OG
         WkoAQ1x49xirBQNjfMEEluhSIa8PGY70uG7GaHwKkQmQTp7fmiU3PsHHRX9hieOFki4R
         0W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572541; x=1694177341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZAs7VhAqmwUCso6UvdFSw8g4rQU2c3GRkXTqdKEPuI=;
        b=aSoY2cREhZPKfRcrZVD+BmH3dzA+Bso7xJstaVSeJlrSnv6ag0r9oKueJ4mtYj+Wly
         bpTQ6SkUm2NZ9ddtuMi07uQ8QUOyxD6YC60BxzMUqQ1FfZAYy2XitSrj7687ICJh6/5N
         K0ekHF9od8bssPMa9fawuaU1EHFg5GA6Ft1vMa2Z5kaFuH66zPEeXHrSFFTnH+P/XiIR
         pdZGcbtwg+MNnhhlf2E2+i4C6P1IQfaznLCd64Dxm2+5ZMAzAr8egLxLJZdVg1xcap9A
         FiUwIHQLW6csQkF0hfWPmxGSyK66f4WWOoy20Fx7cIq4MEm7JDTaWjYY7gBbt03nD2RV
         BuMQ==
X-Gm-Message-State: AOJu0YybloZZYw71GB940cgJKa7B9mvYpKW7yQ6QfDt9u7PqrOAbQhgL
        NR71EgNVzmRVKg3e+vE/MaeseU5ZrgxPjoTd1LGVnS6XuhopeFan35U=
X-Google-Smtp-Source: AGHT+IEB9jt0+K93uEZDGEfUQbqOftNhxXjcWPCxaJuZjUubR8A9yN+H/IaZ5UAnswWDbcYJp5W7kccv80ppkwSXq7A=
X-Received: by 2002:a67:efc6:0:b0:44e:fc88:9cc5 with SMTP id
 s6-20020a67efc6000000b0044efc889cc5mr2233124vsp.20.1693572540909; Fri, 01 Sep
 2023 05:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110828.874071888@linuxfoundation.org>
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 18:18:49 +0530
Message-ID: <CA+G9fYtnmbgfVUNx8wOtysxsw71poVddfQt53=Dm6GTz+8v7Cg@mail.gmail.com>
Subject: Re: [PATCH 5.4 0/3] 5.4.256-rc1 review
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

On Thu, 31 Aug 2023 at 16:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.256 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.256-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.256-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: dace6640c652718a3ef17226ac5cbe5a41040cf5
* git describe: v5.4.255-4-gdace6640c652
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
55-4-gdace6640c652

## Test Regressions (compared to v5.4.255)

## Metric Regressions (compared to v5.4.255)

## Test Fixes (compared to v5.4.255)

## Metric Fixes (compared to v5.4.255)

## Test result summary
total: 100280, pass: 81623, fail: 2238, skip: 16367, xfail: 52

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 142 total, 142 passed, 0 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 29 total, 24 passed, 5 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* kselftest-sigaltstack
* kselftest-size
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

--
Linaro LKFT
https://lkft.linaro.org
