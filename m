Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C5C78C0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjH2JGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjH2JFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:05:53 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A1B5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:05:51 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44ee3a547adso244203137.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693299950; x=1693904750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK33mQoDAtnqgnVp8fhJUScF7p7neaBjU5m5OZRwG84=;
        b=V+KdT24IHmaKsujT6kLT+VsEusOLH2azK18ASv7RQPGn+yQK0ut0w9cCAsW/h+KDIK
         BWP/K3REvkmn1COPzSVxUUae3wq8MLFlNmLS9HuhucccS164aO5U8cMr6LITLHFiMewf
         nu7vrm8v+sanKv397ABuDudEnyB3vC+z8heoumMXJliyLivb40l/ogjoSCPubWzW9Ees
         y+bWtqJtcURoER/v85dDKjmjgllM6jMpMSwhVA+M+cUBNgqVWhFbiOfrTirrCt8wf4Aj
         +lniP3NatObSJA/MbF84I90LupUuKSA3SyKUscmaDpp0pMH9w+exumos0R4+n9nL03SZ
         GyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693299950; x=1693904750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK33mQoDAtnqgnVp8fhJUScF7p7neaBjU5m5OZRwG84=;
        b=ccXSML1+Liz9mkjc7BPmf6naoVMsL0xyfaL+NwWnDorHIyPyfZ/AS+OKlUu3oapcCn
         175uXoV/hzFA7sWRkHue1rG6e47U+317FvaZE2/+Ku3/GnTkTV/edHswVwGy4D5AX0BF
         GUuexZSuZmUv3YJw8MhYOU7SDtQZfIJ2Fa6DpM55diJloBCRUlakIIb1rOXf+CLKXUIm
         8wouQ+NgWvPsaAfwU0tsLqSigRYihwH0Nvb/SfuUTNvY4jItrHgOCI0SFx6ef5oc5djb
         eDK1KaBY38MNdsjD/QzFunxSSgy1WHCXP+W1Qrqevg0S2PXHQ7gLIiPM1RtARQxYXC8b
         cgQQ==
X-Gm-Message-State: AOJu0Yw9CoGC5Yi+Xx3F8Pn9XxOb/9syaKLjs8o6Iw/opkXOyLKIQCPf
        Yc29A1D0G9cuQ9Qz08Jqz0dLlIDufQwRf5DM3Gn/SQ==
X-Google-Smtp-Source: AGHT+IHdbcI75ldWVcT0Eq6O+Oi80x4A/VVxMtAbbXLIiOJlwL88pmGnIKiyXcWpIYFYCQUFy3Eo+ZIAYVtnY14LtDo=
X-Received: by 2002:a67:ec55:0:b0:447:4c30:cb68 with SMTP id
 z21-20020a67ec55000000b004474c30cb68mr22960717vso.32.1693299950080; Tue, 29
 Aug 2023 02:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101150.163430842@linuxfoundation.org>
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Aug 2023 14:35:39 +0530
Message-ID: <CA+G9fYsrSC2JjXstuiYfLK2Q2ouv3icM_tX0u28BC3Kq_PCwHA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
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

On Mon, 28 Aug 2023 at 16:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.129-rc1.gz
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
* kernel: 5.15.129-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 948d61e1588b9442fe7390e694431478159553bc
* git describe: v5.15.128-90-g948d61e1588b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.128-90-g948d61e1588b

## Test Regressions (compared to v5.15.128)

## Metric Regressions (compared to v5.15.128)

## Test Fixes (compared to v5.15.128)

## Metric Fixes (compared to v5.15.128)

## Test result summary
total: 85285, pass: 69850, fail: 1587, skip: 13790, xfail: 58

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 111 total, 110 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
* i386: 34 total, 33 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 10 total, 9 passed, 1 failed
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
