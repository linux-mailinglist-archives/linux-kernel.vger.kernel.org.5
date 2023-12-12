Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75680ED4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjLLNWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjLLNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:21:39 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80F1992
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:21:21 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4b2c0ba26f1so3207741e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702387280; x=1702992080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaQdT2yLxO087BBqctciHEVHxUbwrhtqF6ffwVQnHig=;
        b=F1Fqs934IlZ9pFnS5WGycFZSH34QO9VokknVoEZCXTGRafi+mO0LZUSV8cjy49YGhj
         a1e3awjFi3yzXZ/SuVPrLKsJ2UP4c+RfTcZj+vGgFiPMV4K35r4xgeW/rUJcJPjkhh1b
         bIyprRV9JBOY0j/9ZEIOyUwjXRIqkkZkvU+dP9zw8jzSOLI4P5AlT69LazuRYe+OPv1d
         gWVofEx6XBlMKtWa8ND1LbUDBIQiSRr8RMC8M+F2stO2nKzwVZ5mJk2EyaNIU7A/hp+f
         jN6eLW5KGiDf5wabwz42G+gHp0WNnmtNvX0UKcNs7BIfgPdFi96ViLVH64OvgtVWW5Ad
         QyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387280; x=1702992080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaQdT2yLxO087BBqctciHEVHxUbwrhtqF6ffwVQnHig=;
        b=qd4h4cOA7Zcs26Rk9RGIH1jcPn5KtljVMAln9icrk9qnCY7vKuo1RQzsomS2ksZmem
         IbzWnDqglYQk6BTQs+Z4fH4JiFhU7MT2Q5Fh/ujMakVqvADS5ZKE7pVPid7AfjGwJsDn
         wPlS2DaxcDhsDEWnAee7R6MNiyZKEef0BRYBVPZHxsAz09cKDTqo57L6FDBQWrrCJap9
         6VUwsmAPqGAjdi2rkbGntjsmUBB54Guw2UJ+BUhjI1zfReaC7xyJGTH8WyI1a+iiqhKA
         8NoxChmFS8lnyjGWxsf1Mg0w9nmoK9PRiGUVVnwF9AcwBakpnAbboWgYmsU87ElAr2wf
         NJQA==
X-Gm-Message-State: AOJu0Yz+S5S0JdVHG1i2P+XEOwcE8+uRKscn3NSaghUVSrXWfrs1Y2nn
        I3imLLK1j4MpzO7ZNMHx25eLTc4ncYenscK/QG139A==
X-Google-Smtp-Source: AGHT+IEwA/cN9ZvhmumzcgBJXe7RBw5yeCOEZ/8RgMLaMWL2tk/2enFn97aBlzglNvfCpBBGmMLAKI9jX09lTYqWdxE=
X-Received: by 2002:a05:6122:360f:b0:4b2:c573:ed5d with SMTP id
 dt15-20020a056122360f00b004b2c573ed5dmr4659443vkb.15.1702387280095; Tue, 12
 Dec 2023 05:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20231211182036.606660304@linuxfoundation.org>
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Dec 2023 18:51:08 +0530
Message-ID: <CA+G9fYsa8=JLZUXFKSkCGNPqt+TwzTA-q7+5thugG_o0+s2nUA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 00:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.68-rc1.gz
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
* kernel: 6.1.68-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 807435a379b45e6eec975857b7daf5ac2b3fbf93
* git describe: v6.1.67-195-g807435a379b4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
7-195-g807435a379b4

## Test Regressions (compared to v6.1.66)

## Metric Regressions (compared to v6.1.66)

## Test Fixes (compared to v6.1.66)

## Metric Fixes (compared to v6.1.66)

## Test result summary
total: 136008, pass: 114767, fail: 2850, skip: 18250, xfail: 141

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 38 total, 38 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 35 total, 35 passed, 0 failed
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
* v4l2-complianciance

--
Linaro LKFT
https://lkft.linaro.org
