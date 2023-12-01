Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA2800C63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379027AbjLANlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379013AbjLANlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:41:46 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D8193
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:41:51 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-464434e7804so743645137.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701438111; x=1702042911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud4MQNG0kpdoUboL30yQ6RvJpvRhcnzA03rhefBPilQ=;
        b=a6tggfkMG5C0Xzl6OW2T8qEhZHTvURpVg7LBX8h6YQSVglEZFjQ7frTeqEtatj3dy1
         HM5O/cQ0ogeTgGTNb2C/ZgKdNGax3+DJhRea4U8xp4IgsbSF1XLslIjNRM4MEVvsm+he
         PDocjFiV7pvK5QkAL4jM6R6LeQ11jcccwZ8SteZP8ijxq5octTjYTimb8iIdsc7I7CAw
         /VJNdgI77kpoBSn8RxOnzb37c28KmoPXGj4JOhOcOvWosjbcrlzMBOBIVxKTxvGRuI7T
         0sz7D8noqRvHjeypSM8pu8qZJdA5IDxkHggmcaFQqFJs+FvOgMaKlietc6xm8+0meSUp
         GmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438111; x=1702042911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud4MQNG0kpdoUboL30yQ6RvJpvRhcnzA03rhefBPilQ=;
        b=gYqG+xoxKeAcqapO8jrivzZKYwS31SBCyJUMIQ6r2Rb2yh5iemhftIUDEWIgirzCzM
         E7Dvda+JS3jCEdputU2saClyhYaiwN4wPfZYqzZDeHLfaHNTew1UYQRPFGrVkma5y5Nc
         JPFcNBOjVzE/NST5FD8TLUH8LwC+0WC2tdeLjZK8Djf7NBPnEnkdq2mPdJIDKE8jTtNX
         Ze9PWZeSXzIYL3w0g8pr2l6ZxbLvttDnV0MsarHSVHLzc/gkKh0LFNH5FT62ZOqikKrN
         fYoe6ryoGZbIE+0b186w7BJ1luVnmq8w1+ELzg0LYCA7hC/WFj1XPrjzmCOBZ5S2HTir
         mMCQ==
X-Gm-Message-State: AOJu0YxNBZ8rczQsguHNR9TUaytnq0rAmsROa4S/y8x+OiUZnO5GkHIh
        nyMWXwXVYZbZ6hZnrX/ZuTTlIf86QUuttQwjJsZc+w==
X-Google-Smtp-Source: AGHT+IEicy1qN87mEQef8NwvPqnYXdc2XJLVSSrclbSdSp2zf38QwwS0ohzKVUpQcnIM6g1p6MjherBnXenZzLzpYH0=
X-Received: by 2002:a05:6102:2a75:b0:464:5ca3:3655 with SMTP id
 hp21-20020a0561022a7500b004645ca33655mr4493569vsb.15.1701438110964; Fri, 01
 Dec 2023 05:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20231130162135.977485944@linuxfoundation.org>
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Dec 2023 19:11:39 +0530
Message-ID: <CA+G9fYvBUtFAid4ZK=XQtxM8AvUXuFwOrGV_UqCGnnvT9sNG=A@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 at 21:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
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

## Build
* kernel: 6.1.65-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 49ac60b65ef717d2d74b3b83ca97b61a011557de
* git describe: v6.1.64-83-g49ac60b65ef7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.64-83-g49ac60b65ef7

## Test Regressions (compared to v6.1.64)

## Metric Regressions (compared to v6.1.64)

## Test Fixes (compared to v6.1.64)

## Metric Fixes (compared to v6.1.64)

## Test result summary
total: 134263, pass: 113838, fail: 2710, skip: 17581, xfail: 134

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 52 total, 51 passed, 1 failed
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
