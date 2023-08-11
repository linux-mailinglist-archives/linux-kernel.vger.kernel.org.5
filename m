Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04DC7787B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjHKGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:55:30 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0866E7E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:55:29 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79ae250266cso581590241.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691736929; x=1692341729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jl9p+KNxoqOn1WZcsfVA9kXOhluoQxx4pHOLUhZQLg=;
        b=G+fDLAD15tJ3QtHYpj//HUHvjje/vA3uAVCJVl7Gg+6Kk3xfTFVMN/FlTArL5rDeYj
         kbXxsf/7mA6P4FBSp5CUACs9sn9beuPHlkoetLUr1HPiYaW/7oa9i0YV4O6Cm3u/q8Nj
         lWIJG3Y1u/29qJcVlG+c5vl8Wweapt19GEeUgDLelL8/RHJzvFzwbA40sfOlxYAsqNYV
         4UuPLQrj0NkgmIjpdPyuEZdUbpuJKszm2vg3Rz/NNWrG93x9CkodE5OuaQySuRrv77/I
         OXfdx9L1q08jxjg+mkEVBXQGScu81iJMBhZlo6G1KiVl0DVWNlq6r3FQ5fB+3Gc7gTJ+
         CETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736929; x=1692341729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jl9p+KNxoqOn1WZcsfVA9kXOhluoQxx4pHOLUhZQLg=;
        b=MnrevosrubIke6NADxg/wMj5ArvptSGDmGwqjkFuIYSvZmD/9y24bkuC60lYS4wwlj
         YCKV/vBah2tumybtKArdESsDa71uBVboLwD0TGMDXgxg1JK/LY0AHUzicV6xk4lAYEv3
         WVJPTe53d3syX06A4a0CKc6fdXHhYELubh2IdHa13EWaUc6uy6Z50e57BM/QWAqnUm7L
         alUWR7Wx5fgU4GujQbSLobioRxccDXOIvtxWlKmI/zVwULkSLAVKzffKODDGXFnA1P+F
         ZfnTFrwGiyQPWEmbrpggfU+14nHXVyBo2Vj9Cs7/k2AVJhOKUbTcx6A5Fo3WuBqJ5M+d
         /XsQ==
X-Gm-Message-State: AOJu0Yys4pclHXIPgIVb+yrll9mM93Ji2XYllH9Xn/rhr/RbueDwFv/7
        GuU1Jdt3OvkGJ9m0AwU7XF8ubVmrN4q8Fh2/rown/w==
X-Google-Smtp-Source: AGHT+IGgeT53zPrfyNp7tkWuSpmapHMuynAiAUznmB1FH7SdPvqcyy26XjxPJ+StldAlMA1MJxb31zTkoxB9UCHukmU=
X-Received: by 2002:a05:6102:a93:b0:447:8f16:4c71 with SMTP id
 n19-20020a0561020a9300b004478f164c71mr856897vsg.21.1691736928901; Thu, 10 Aug
 2023 23:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103636.887175326@linuxfoundation.org>
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Aug 2023 12:25:17 +0530
Message-ID: <CA+G9fYtpZ307=fdiHuYF6OZo0eQbzG_t_ynGfk1gdPkFVMem3A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/154] 5.4.253-rc1 review
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

On Wed, 9 Aug 2023 at 16:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.253 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.253-rc1.gz
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
* kernel: 5.4.253-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: b4a2489fa8b7c1e8a1c012020dc7bf2eeaaf5325
* git describe: v5.4.252-155-gb4a2489fa8b7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
52-155-gb4a2489fa8b7

## Test Regressions (compared to v5.4.252)

## Metric Regressions (compared to v5.4.252)

## Test Fixes (compared to v5.4.252)

## Metric Fixes (compared to v5.4.252)

## Test result summary
total: 125061, pass: 100749, fail: 2463, skip: 21758, xfail: 91

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 147 passed, 1 failed
* arm64: 48 total, 46 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
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
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
