Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF227E562D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbjKHMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:24:48 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EE19A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:24:46 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-45da062101bso2037894137.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699446286; x=1700051086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiOpIPoDsnfyvPjFEUKPnA5vH0+qMvf/QyeKJ8E4xVM=;
        b=C6DBwYCUYhOICDmJwwKPPZ7lnR4189dBCGJhmYK0oRZD6hsixAGWX8k2afD4Kg33cr
         TyfSMH+fXMocQmRqWN8LaubDEQwLCFiet3Z4Ds4ecd9Wzr6XQ7+Dsehy/SHnXsi+Pstl
         tJmGSpjUmLsNmTFLJi6y9+CI8GQucPTj+8zApAgmST9h4m/t7vRiDyWxUGNtpSRzEIav
         QMMs4e2KKefdAG4T/XsJFpgYPqkGpNFKxDsQvDJiypydtugV+3QNBSnAROSnMoYTapj3
         jENE1bbFVf+qaG7QbTUEHHVnQLmZ6/blY390hiKcudhDTwh5erJev8Es74DGrLiGTQ3m
         7CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699446286; x=1700051086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiOpIPoDsnfyvPjFEUKPnA5vH0+qMvf/QyeKJ8E4xVM=;
        b=v+r4FwBWnK/VD2nFpJA6tLP1lkctImBnWGaM3hwVzP+4iIimjw2RflhqjUT63AwfYc
         76iynokEun7TzFY64vV1+UnosHXYhm5sfCOLuty5VVbzNWMgmC5EFhNiqIztt1ZFR/KO
         W1z9D9/WsewZm130Qx+hS9cuQrqcs4/Cw3r+Z0pyUbYzs4ZmrpI91u3jOU1UIABXfQxC
         mk9b0LCN42l40qjsFByLsdDYTrhuXdg11lL2xkcuztJS/0bLuzKrfZVotuPHEPINNG/t
         GqRzC+hRkdF0IzowFdgxQOJ+Qgl4a+RW+gx8Ny6FoMkRpfgYbYD8ZtZ7tpO/6gjnk5Ul
         8taA==
X-Gm-Message-State: AOJu0YyW1lFgJCmn5LRexAZkU31iz/sWpulFLxXwMXA5zxRJDbPZAcad
        Ktz2Yjs3st5m8Zp96fWnYoRyH8axyzUr/3O8gZqsoQ==
X-Google-Smtp-Source: AGHT+IFd7GkvmqFIxpoIQDHg/JnC+ZA7xe9r52CaI9YuKxbc0XQzMnE2FSb0OyceIy1YEqOc/WAa0zrp6rTVMPZ+34g=
X-Received: by 2002:a67:e09b:0:b0:45f:8b65:28f0 with SMTP id
 f27-20020a67e09b000000b0045f8b6528f0mr1389594vsl.12.1699446285778; Wed, 08
 Nov 2023 04:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20231107202447.670990820@linuxfoundation.org>
In-Reply-To: <20231107202447.670990820@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Nov 2023 17:54:34 +0530
Message-ID: <CA+G9fYuZj2SVDKszZMsqU9HFqxaHJyTs8B7FCbECa+jNG6=WOA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/91] 5.10.200-rc2 review
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 at 01:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Nov 2023 20:24:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.200-rc2.gz
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
* kernel: 5.10.200-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: c4863380dfbff55489d2e3ba476730a03f0f2376
* git describe: v5.10.199-92-gc4863380dfbf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.199-92-gc4863380dfbf

## Test Regressions (compared to v5.10.199)

## Metric Regressions (compared to v5.10.199)

## Test Fixes (compared to v5.10.199)

## Metric Fixes (compared to v5.10.199)

## Test result summary
total: 91328, pass: 72188, fail: 2160, skip: 16922, xfail: 58

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
