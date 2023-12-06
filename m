Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17418070BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378471AbjLFNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjLFNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:17:05 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC829E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:17:11 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1fb37f25399so1946213fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701868629; x=1702473429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nxVVrdBlmm59JQaj1tQrRYncz3o/xDnyNSt5IijI0ys=;
        b=EtlKUTUUQLxOT083tjP6ph35JZFUMBJnh72ffzpBqOdOD91Wfq9eNqqyjER7ZF2YrO
         YAK4uRZdCP0uCsuXjET92dA5jd5EZ0xis5syAh5w8QYfDUMiTUDX9CdYsRN3jz3GIPdK
         RO/R7q/kY717VD2sAO3PfjG+/QucZlnG59oUI6x5m+USJPjAXZGkveQY/ccylKsCPTFI
         cxHyBdgEKm8wKG1o0Iyb9mkYuGKL5ONhijB1EYElkjGOV767k/4z6wCLMFmWryvLZ8X5
         NZD+K6qTcgMkGiHGPnZUHshR9qF5aD/2QacUGp+xHmfXDhrOGiKWNo5QxjITPbTMSB9O
         m9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868629; x=1702473429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxVVrdBlmm59JQaj1tQrRYncz3o/xDnyNSt5IijI0ys=;
        b=Ng89piIWCSLvEtJyDyuvhrUSaw7bEGom2d6Ngb4vycOfZmZgCFIJTO1g6RiYBKUh7M
         GzyayeE0AfB7dsMujRCqUp86ZkAwygzdnFDH7T+c5T4zPLYFASUxsptDSAvjvYz+MCJS
         hkqDs1CesxZACUsVR55NGkOO+rwhD97Lyi6u35ImWtjW3fV1SpvG3FAiM+FMAep3hIV2
         8wFZ8oPnBY6Av/Pf5x939BIxdgqpDpKITHxb6kd9cdOMICvLHtiRNOlIRWyOnEDDgowj
         af6JS8NVowz/DIt4fU9tl7KcOwGK5l6nkw5ulc6JTp4t03y9sk8HmilkioJ7HYVFRn6X
         AZcQ==
X-Gm-Message-State: AOJu0YwygPJjj70wu9JtH2lmESHano3nOfxlZtvaLA/p9EnQBo6OvrxN
        QN7ncRB+Hzddt748yXArUp54MpRJYHHQQF2WbV/+Pw==
X-Google-Smtp-Source: AGHT+IEEMa1x8V2DyQnpeISuBHHmKLpaAiRXC7RZ+9Yn8EMDmGE8IlSDh5LMPNs8JlqfMe1L+cLaEP+jd11GHaSV8JM=
X-Received: by 2002:a05:6870:71cb:b0:1fa:f20f:de3e with SMTP id
 p11-20020a05687071cb00b001faf20fde3emr925186oag.54.1701868629446; Wed, 06 Dec
 2023 05:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20231205183236.587197010@linuxfoundation.org>
In-Reply-To: <20231205183236.587197010@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Dec 2023 18:46:58 +0530
Message-ID: <CA+G9fYt=B4NN=Qa5UcJKU7-wTj1xZHHgTOJcUU+0v=NYyF6Wdw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/63] 4.19.301-rc2 review
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
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.301-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.301-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 58069964f7aefef236c6f95ab212d0da19c7a4c1
* git describe: v4.19.300-64-g58069964f7ae
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.300-64-g58069964f7ae

## Test Regressions (compared to v4.19.300)

## Metric Regressions (compared to v4.19.300)

## Test Fixes (compared to v4.19.300)

## Metric Fixes (compared to v4.19.300)

## Test result summary
total: 55181, pass: 46377, fail: 1610, skip: 7162, xfail: 32

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
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
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
