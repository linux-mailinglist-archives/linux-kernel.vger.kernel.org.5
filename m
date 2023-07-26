Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9857633EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjGZKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjGZKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:38:21 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D001BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:38:20 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-486519e5da0so109495e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690367899; x=1690972699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIVeVwbWTTFXz8sKxYfdejU59DP28K7TUiG752OJ1bY=;
        b=Ed63tR4hX3NLwkv4cNeMoZ609032VNzIKqHsRpb1aIY63hcX//qcems87u1uD9L9fC
         zoxYSzdfSG59svXE8wZiEH+Qo/RN2GmagjbqnpHzDVgLK8OOIHiHybfWcux/SAWrVvB3
         8F1c6an9aogB6fy877FrG+xjhrPtot8JRYdi1T2Do3Z20F+ojdQSaT84CCXQnRU/gVr9
         4VRL4IqH8dx4Z0ej7lE4VV1CsAFtDzuDT0Om72VU4uJqTuy+Wsuz2e3but/TaUkrTjGC
         Nlr5ETAivNCWbGKEveVeLSLlr7C1BQBnWKGo0V8Jni+5NhCcQoUSDkfW4neyp5Av52LK
         lEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690367899; x=1690972699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIVeVwbWTTFXz8sKxYfdejU59DP28K7TUiG752OJ1bY=;
        b=CWFyUokUyhxHwwaysv9MLaN2XI0uD+SmlJfDFP5k375UIeMGEeEp/slkaytwr1kVnz
         +DUtzyuHHHII2krNqSG2zmza2g9dLJh/aFkN9/NNtlj2Ww/vDnvPxYwZ2EEIVK49ONV6
         s1RVRobCZvoFssGDgFIYGRIysNj5HvL0o3oKvPy+U99ddnsRHWEu++rzEV9CJREtnDp0
         0mcepX9JyhQM4tb6g0Xljh0m42xG7ZyCJk7AaWbQe121+2LXWd0iT6ldiWRdEaoSM1lx
         PZcqFm0LrIRcdB/11YTaE1kxdAzlcxk423Q8NNpUMsQeChbMq0s6TpWwLgY3GcV6Kgw/
         OX1A==
X-Gm-Message-State: ABy/qLZIEB1ZnFH4ObAZQWkl4WMHQY6kgLymQ9+N4IHiavqXZ3TQOnkN
        19ib5IjnvK+PFE9O3Uh7XAGKsVEYV6O9IQCrqSUSeA==
X-Google-Smtp-Source: APBJJlH3BrgnoIR4LvzrfMDAoJXI9L+FHaF0gIVQa8oIDWDYLvD0mcPOHU29TnTlafzNfJuJmDSHpRKmA2JtI+sXY24=
X-Received: by 2002:a1f:c192:0:b0:486:4558:ed05 with SMTP id
 r140-20020a1fc192000000b004864558ed05mr558172vkf.4.1690367899581; Wed, 26 Jul
 2023 03:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104507.756981058@linuxfoundation.org>
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jul 2023 16:08:08 +0530
Message-ID: <CA+G9fYvF27q6PRJ=DQvOu6WGD4W7UzQ2_h+GwzzOvQdm6XcXTQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
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

On Tue, 25 Jul 2023 at 16:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.42-rc1.gz
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
* kernel: 6.1.42-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b3f8a9d2b13712777c36667183b782dd7efa5039
* git describe: v6.1.41-184-gb3f8a9d2b137
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.4=
1-184-gb3f8a9d2b137

## Test Regressions (compared to v6.1.40)

## Metric Regressions (compared to v6.1.40)

## Test Fixes (compared to v6.1.40)

## Metric Fixes (compared to v6.1.40)

## Test result summary
total: 129464, pass: 112241, fail: 1676, skip: 15398, xfail: 149

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 146 passed, 1 failed
* arm64: 50 total, 50 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
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
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
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
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
