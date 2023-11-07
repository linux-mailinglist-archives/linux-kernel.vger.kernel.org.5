Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB87E47BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjKGSCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjKGSCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:02:49 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC2D8F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:02:46 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45d98cbe098so1319379137.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699380166; x=1699984966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGPMypc7UpB+pE/2j9HzBUQuEvEaIRrySoLUcthWhc8=;
        b=FvtFNtzhxf10vaE6/8vpeVGqfK/OByjbYnwYjf3N08gGJOoeFckE65VScGg/C4u7y8
         vP2/nGVqzdz9gx/3m50V0TJDNZkU0LnH4oPGWBt8tgq7OxjpXhLRJOy8OBFTKbSRfcup
         d/Zi1tVDGZtV6Sjz26FFlMZZAbKvpOrx8TyylqwXCSc0EPtdfzn66ZHj49Rm7HZFdqV+
         FHKmP621bbnscrcolokCjn7lckbbbHciM4fAITVSpb4DPdNbY+X+cqbr3CkUGOjR6s7S
         DHvvK7NA0rcxNArSDZxRfMtazKVdkzcJrUcvK2/pqB+/QZJ/laq1IRfZRvJFgm7N0Kw+
         HP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380166; x=1699984966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGPMypc7UpB+pE/2j9HzBUQuEvEaIRrySoLUcthWhc8=;
        b=WI5oiPY+r3g3xdF+lTwK2LAM3qYvVE67XHuNroOAlFg2BnlNr9LcYe09sCfki24BW0
         xiLoR1HeoVb3gKEC5Uw8tWzqWhyr/yXsiBrnipvgxeAzNdzkWpX4/xi7WbHCuZkYy8uT
         /ToLuEzDumU3NJegKWzHsH69B7IHdg5IWZbBOgVXNvol735DWBOYPdNL8jQkNxMK9aPU
         xx2fOkFzhM5R2O6E63B+qzde8R8T1wLjk5UJacVNgfceyALoNs+NAL+OtVgh1sBTquNq
         8xlp/cFbWB45b5a3j693b3WzG7WkE+EWIl7Uoet3xwDd1RJXkMdgRkdODmv+2tmGrsJt
         S14w==
X-Gm-Message-State: AOJu0YzLsVNY0jPpdL0xpVV7Q5j86Jk8ygwk0wMduijNy/1OCDGFm54O
        2I52hSqu4JCMcb7cLEHW3JQ8VEzWtLzKZEPver24xw==
X-Google-Smtp-Source: AGHT+IHeLsDY72gQ1wQhWZyN3K2+uxUoiakKIsoRzz332Rbb1klJO2s+21gBDMsTvNTEjJHb6dygDPdLES8TymTOkok=
X-Received: by 2002:a1f:9d56:0:b0:4ab:cdf0:b2c7 with SMTP id
 g83-20020a1f9d56000000b004abcdf0b2c7mr11888805vke.5.1699380165852; Tue, 07
 Nov 2023 10:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20231106130304.678610325@linuxfoundation.org>
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 23:32:34 +0530
Message-ID: <CA+G9fYt1-XkJvMnN3=_Nmr+2xV3QUQsn_k0G82QDyd8fDucoOg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
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

On Mon, 6 Nov 2023 at 19:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.200-rc1.gz
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
The riscv build regressions reported.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The riscv build failures already reported as others.

## Build
* kernel: 5.10.200-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: fed6441dbe524de2cf3a6a40d5d65c369bf583a0
* git describe: v5.10.199-96-gfed6441dbe52
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.199-96-gfed6441dbe52

## Test Regressions (compared to v5.10.199)

* riscv, build
  - clang-17-allnoconfig
  - clang-17-defconfig
  - clang-17-tinyconfig
  - gcc-12-allmodconfig
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allmodconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig
  - gcc-8-tinyconfig


## Metric Regressions (compared to v5.10.199)

## Test Fixes (compared to v5.10.199)

## Metric Fixes (compared to v5.10.199)

## Test result summary
total: 90579, pass: 71963, fail: 2500, skip: 16053, xfail: 63

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 116 total, 116 passed, 0 failed
* arm64: 42 total, 42 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 11 total, 0 passed, 11 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 9 total, 9 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
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
