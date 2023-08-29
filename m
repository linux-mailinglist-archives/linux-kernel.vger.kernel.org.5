Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9D78C389
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjH2Lnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjH2LnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:43:10 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C61BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:42:55 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a50574dc0dso248422241.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693309375; x=1693914175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjXbT/a0xHRm9c9x7EvHrfCZN66X8G6z+25kkauygmk=;
        b=vW6VfetGzHK5OQ4USA5TAXpHGzjtiYvx3W7w7A3M84sJYBH1LG+ba4VCzIpCSEvuec
         x1UOPERyejBHAIfwkfiCFNZ62gZM/M70nAO57/qLdJog6wuOBTC3KiP0H6v2q9EtAdvO
         B1/X2bf6qnehTGwMXa7gWuo3VaVq+GK+TMXPRqJptpSWdxI7Se7EaZbm8EnOaGu6FdtB
         XFuyzgfoht92DXqLO4S9lziZ0JWU7cZcDnC2PSxO8C7DYOIH7XxUEAmMuaWdBLcM+L1t
         cpPX8EjTXJr19IvdamaLMAp+6Yq1O8poyY05hrNzNA8XGrYASblUcvQVoN+0qIi1HTZC
         ov4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309375; x=1693914175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjXbT/a0xHRm9c9x7EvHrfCZN66X8G6z+25kkauygmk=;
        b=bFt6SMcAoJUtS7pI+t1QsO1vu9ywXpC+mDz140/ciojbUIE0wfg/VT70RGg/vFPirZ
         ScFf3l8ogCxEehvk7mgN0Jg2kYvpM3XgIfF3MHPNFf93vnXIuMlB+SADVfuWWNe8gL0l
         mGkWfUD3CKLtkOFrkhMbStXSnD5+ltO5VjGc6T95Sc90vgv4GmoBINWRlbxINl+CWW1R
         D5thKBf4T/G3x6sQrLLkWutTJSMaHs9LIl+01SA1Z1sr605oKWofP5ikXkLNVN5sEdpt
         6+MexC/rGR6aC8wfSVRhDRotUVutlLbgvnz52TrmxFodHBaaoEtpyNziAfaoqR7kRMOa
         bXQA==
X-Gm-Message-State: AOJu0YyVnRBjS7tOpXoB6j7eWCSKRfMdFIInsOWJ8Vio1ItV5AoblLJj
        Vp9XutPfA2XlCiPAgwzeHLR8pBceLad9bHiBck1jxQ==
X-Google-Smtp-Source: AGHT+IEqwgF0DWSG6YZ9Tc02rmL3QOKlELSwvyU2H0JG+WFHKy5oPxVl+qtqdOxKpckIw+QwMGsC5RWepg+jz7kq8YU=
X-Received: by 2002:a67:f848:0:b0:446:9cc3:ccf with SMTP id
 b8-20020a67f848000000b004469cc30ccfmr16275407vsp.28.1693309374727; Tue, 29
 Aug 2023 04:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101157.322319621@linuxfoundation.org>
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Aug 2023 17:12:43 +0530
Message-ID: <CA+G9fYtTu6nfWQaazN=axeK+RFu-Tem3_SvpRfuz=dWdaz8wtQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 16:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.255-rc1.gz
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
* kernel: 5.4.255-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: f1f9b3b66b45473d0deff05b1506393d60f850bb
* git describe: v5.4.254-159-gf1f9b3b66b45
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
54-159-gf1f9b3b66b45

## Test Regressions (compared to v5.4.254)

## Metric Regressions (compared to v5.4.254)

## Test Fixes (compared to v5.4.254)

## Metric Fixes (compared to v5.4.254)

## Test result summary
total: 119930, pass: 97361, fail: 2421, skip: 20062, xfail: 86

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 143 total, 143 passed, 0 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 29 total, 24 passed, 5 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 33 total, 32 passed, 1 failed
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
