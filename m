Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A778B7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjH1TO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjH1TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:14:27 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD0107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:14:24 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44d4c3fa5beso1629099137.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250063; x=1693854863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i2oWpj9kBxGjCY/ZwiCBlJI8DBRhtSWorciWqT5HqU=;
        b=uen6ji+OWx/bIrx2zFM/2no/qs04Ie3pi/Gp54ouJfwDMnwmwBt9LDp6Cl7buyiR1m
         nfHCyNr3cZjBvNjoVaHwNVvOkSZuGANPer/LD7i++Q5V1ZVlveVKFsULnQRqQSZd3H7m
         1vjM8PZdn2zE0qRVavDWGRDu3TR8GkuPZDC81MR8Kuv7Bnmti/W63qMckhFdrs7At5DB
         tlcki41Vy+XqsqpcpmtOgu/Y6UQfd6grhDbAOLyX7Wb6qMy4Ax5DsT/jZOFB/W1I2v3k
         Qza6fAaLt+qbeQg90KmZUVpQcf64D4usbe9AZQhumu+SuIIS2vEwWrE+vaV+S9fVedKA
         0B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250063; x=1693854863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i2oWpj9kBxGjCY/ZwiCBlJI8DBRhtSWorciWqT5HqU=;
        b=DYo63T7rJi6YmoP2d2TEu64fdoCcIGE5Lgjm7CrGfSLM5H0mFKvAymBC85VZC6Jvt9
         tcLhG9RtwVlNBZQLdH4EvANf75gLx441oFuK1usMk+JPCu24XePtHe4aTjFSHs0+gq4S
         4CPTNXNtObbdDo32DjyU4VOmPPR6f3kgy8GNQx9Xl6y9Je1+lroVnMHK24iun53D7Xk5
         n/U4ZTq9TxZWKfgpEP25RuK2eP4n8KB5EmaGFEcMyvXVsvpq6K2M5mg9IiaLRQe8I9Di
         9oXd2p4wUUplen01pohhYQF9WuzXd8LGJb40z4YcuCSKhEjAsUJ13EV+ThyZGWZUaKB8
         54cQ==
X-Gm-Message-State: AOJu0YwylXyJG4ExrSFkbMqgxJLe1G8DGXhVwTqcoKaY2MTrlWwo1TP1
        BUtnfVGz+KEa/2oJF5GDnDcIkbfg5ln0PtxQL082lg==
X-Google-Smtp-Source: AGHT+IEfXXHa3lCNPEsTc3Y8D1f67cPvT9LaD5aRJnvpzigo76x8yh2eeD+5vojZrghNgbGuX9r4l6sBrzpKHbTEr2g=
X-Received: by 2002:a05:6102:284f:b0:44d:3bc0:f1bc with SMTP id
 az15-20020a056102284f00b0044d3bc0f1bcmr23319060vsb.18.1693250063582; Mon, 28
 Aug 2023 12:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101157.383363777@linuxfoundation.org>
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Aug 2023 00:44:12 +0530
Message-ID: <CA+G9fYvWMNgayO149P9Pk9JSDHOjzqmv8RSaxDy=19AkYvp7pw@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
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

On Mon, 28 Aug 2023 at 15:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.13-rc1.gz
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
* kernel: 6.4.13-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 8c2717f278c54f64673603d8157130144141d4c7
* git describe: v6.4.12-130-g8c2717f278c5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1=
2-130-g8c2717f278c5

## Test Regressions (compared to v6.4.12)

## Metric Regressions (compared to v6.4.12)

## Test Fixes (compared to v6.4.12)

## Metric Fixes (compared to v6.4.12)

## Test result summary
total: 157320, pass: 136320, fail: 1847, skip: 18983, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 139 passed, 2 failed
* arm64: 53 total, 50 passed, 3 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 26 total, 23 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 44 total, 40 passed, 4 failed

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
