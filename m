Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E7806D88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbjLFLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377964AbjLFLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:12:24 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09569181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:12:30 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c45fa55391so1998563241.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861149; x=1702465949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0UubSG//sobKoRD33O6F2nApl3ZVDUMYW81HNRkiEIo=;
        b=RAtLtfP6AT+g9UPBV5Xz8lq/6CB0Dr0YhY0vB06OVjB7mz+6AVGs+9vNJ/F+OiTPGY
         alvO2yOWmXULsK6htcb8EnjE6jro6ud3/kyipalwHLQMmxVWzORCP52yqznM0/k/ZkUP
         nD1gvjoztOIKbuZ2jNfFIUiANEqzngvtNAfJYna73tZwzSnd0APKCoNDpcRtXa3V4EV4
         4TmNZSyHifge7D7hD/Ry1wEQFoOfUUGfgbfDu74Fl2wDXdRbWimMsQQokLDVPV4Ped2O
         y/vNhNGxgR1+FtkL5vRtBzi9/f7tmS7F0R6jFJdraXrEVDmCpYnsDevs3U3Rulz20QR4
         c+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861149; x=1702465949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UubSG//sobKoRD33O6F2nApl3ZVDUMYW81HNRkiEIo=;
        b=Ut00oPTPttpN7qhVL1SAlpsP3cEWYBmjL4it0/7C3p3vF9Hlx4DB1ItUAnv8aCohsw
         irh2sxc/cGCoW/XzTnKjHrUd0QpkkcEI4pr8PQNDgM9ABtcebzipGJLorMc68SYdLqck
         GmZyxtmr94blLzlzAE13mm4zU7cey/Qomaeq5gEshbM8C6UB08cPDIynKRhSPX15w5CF
         dmBbKB2b8TNPbgKQy5vlD7RG+gcxZib5/xMBb83GobfjouCI9rU9Vt8ZpDABufYxlz4f
         rXZ2I3yxhAEvm2eNz+ko/JN9CfwEgk+wZ3PVZj6gwcHvNRgTlY0a6DhxNPwIy5IsURx6
         R7Ow==
X-Gm-Message-State: AOJu0YwjRHkttLmz+oLYwtuVCfXeCkFbKYDDm+//5s5W/vyJ0o4cMocu
        Dvu5BTFFai2JLTcXY0gfy61h0CUOPj/lcWjDgapTZQ==
X-Google-Smtp-Source: AGHT+IEHidwbwpgNXmJ6MjWYNBfa3WUcLMr01LVFkssVIxIj415CK0pHbZj8DOAExFJwLgoQHJSK+7fccH16ZKyb5sQ=
X-Received: by 2002:a05:6102:c87:b0:464:73d8:769a with SMTP id
 f7-20020a0561020c8700b0046473d8769amr692447vst.26.1701861148966; Wed, 06 Dec
 2023 03:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20231205183248.388576393@linuxfoundation.org>
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Dec 2023 16:42:17 +0530
Message-ID: <CA+G9fYsEnqEnPNsaV--Ugp9hAbrr7yDwdokJuZ=jpUBEgY9+EQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
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

On Wed, 6 Dec 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Following regressions from the previous round have been fixed now.
* ltp-syscalls
  - preadv03
  - preadv03_64

## Build
* kernel: 6.1.66-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b22b2d52d0a36cac86d9e27a0dd7bbcfb3b36fa9
* git describe: v6.1.65-106-gb22b2d52d0a3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-106-gb22b2d52d0a3

## Test Regressions (compared to v6.1.65)

## Metric Regressions (compared to v6.1.65)

## Test Fixes (compared to v6.1.65)
* ltp-syscalls - all devices
  - preadv03
  - preadv03_64

## Metric Fixes (compared to v6.1.65)

## Test result summary
total: 127405, pass: 107870, fail: 2806, skip: 16606, xfail: 123

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 130 passed, 21 failed
* arm64: 52 total, 46 passed, 6 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
