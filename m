Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED37787AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHKGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHKGvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:51:52 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A126B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:51:51 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7919342c456so435075241.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691736711; x=1692341511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY/LzCXZ73iVJl7kNPvRER0zQHu8w/Xt+sR0t3XrrOg=;
        b=API77woK9RnaBcyNQdZiMv4bNKCIvxjpu/XKN6ahI7S7h8k1sURM9zlyWLjuRjAQ0h
         tvs5/p9SjoMo7RsHwjCGtkHSHU78UrxjrIcgunYNGIYFMMuqPtW7EGQOiywJQ1vTgwY3
         vzDmaDbdqATjbt90gUI70VLCR1H9PkyQHEk3SnAIiDhezM9mkfvL3hJtAwMKwo+PeU8P
         f2MIxTaDoLRE9pHoTKFx+6v7yPaeUaYyxN5mAroL52TSino30mvyC4JMwi+HTABNE4tm
         3sA5Ag5H25LNWmjkd6A9NNXksIzxWu5LHH6hQJWB0/2wA7rT1Gi6nmKdLtkeumj3jTUm
         fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736711; x=1692341511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY/LzCXZ73iVJl7kNPvRER0zQHu8w/Xt+sR0t3XrrOg=;
        b=GezJmf/reA0E/TZWuZNT7KsLAI9goMvlcD9sKg5N6R74wwmHbigah+s2Xo/8VtqR6C
         tiGC/gmBEPjBQxTQt04dHPKDpm1ImvJUp2ZAUET9tuEmi6jTjP862mZnyjOZpwGCfiEQ
         vsROg91AQG5rbWDLPoaUuEpx0JTVe76hkX5snu3+3OnSQ7HxJ/XqGFMP+HMTispUWxyU
         cXmGKqwWX0b4iYS7YcYSNiK+bDE/MnNaMAwRMU8VwXVBw4CYViiK4MLQx3cIsbU+XOKi
         SNDuvB0hKbkPZ6ZxJz0nyBKHdylaL7hLI/v+1L40zRP1g6PEdUHNxG5S7KsTZrH0MNj8
         A5lw==
X-Gm-Message-State: AOJu0YwTUl+WwtRj4mZDQt1fIb5E3VS8xRnofVnZMsYkwiMT3BFztUWC
        SyWzrZEar9k82uSYxhp6QFMl08cRCBGQFo58/3Cg8A==
X-Google-Smtp-Source: AGHT+IGT/Gmn/nKyP2s4Q2FmIvwk/ZvLbU4GeIcNNXR7OphP4nx2lg1D0mF5MvHg0XvmD8ZKHrlVbB+IDjWeWkE/nd4=
X-Received: by 2002:a67:ef9b:0:b0:447:68a0:a11a with SMTP id
 r27-20020a67ef9b000000b0044768a0a11amr320477vsp.2.1691736710984; Thu, 10 Aug
 2023 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103643.799166053@linuxfoundation.org>
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Aug 2023 12:21:39 +0530
Message-ID: <CA+G9fYudnukDs6CB_Y3CGfy8wR+8NMg9+VZQKNYcOPTdu3_pmQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/201] 5.10.190-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 17:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.190 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.190-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.190-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 0195dc1d1da1c3ea5afb2a07e66d1446ae278243
* git describe: v5.10.189-202-g0195dc1d1da1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.189-202-g0195dc1d1da1

## Test Regressions (compared to v5.10.189)

## Metric Regressions (compared to v5.10.189)

## Test Fixes (compared to v5.10.189)

## Metric Fixes (compared to v5.10.189)

## Test result summary
total: 116372, pass: 94296, fail: 2771, skip: 19188, xfail: 117

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 45 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 29 passed, 9 failed

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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
