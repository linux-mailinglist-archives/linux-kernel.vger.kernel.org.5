Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFB76DEC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjHCDNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHCDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:13:32 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08122685
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:13:29 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-78a5384a5daso167671241.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691032409; x=1691637209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74ywh7TvqUkDUEffoH+37MC/7CbUn0PXoEShSbC3XgA=;
        b=jvpKU1JeTnRH0lRPSpXd1hPuvjiNX1F+54F74lzkq1m0EYERB/GljY3mULiORAqP8O
         Aq4oYs1c+N3bjEVoCfdT35oD0B7EgHepRoX5GfQb+5esPFm1ij5FtteEDCEjacIMXuD4
         G8QunHFkHKX3MZshB7c/LYA3klh6U9qe7axqXXtlc03Zaz3eVa0JIsa3fYWjOLvxy5Wy
         bKHRtlJfpkqNA7wQhl4WciolMtcvAMQ6ZAgC04gcVpHo0zUuzGdEkxu5Rj8gL2oXt+lt
         HzKtqpFTe6qwjfV6+1GLjLz0pkeYwTo5MJ9VkqPfLk52fVQHDTAiZtGjKXfnm/Gv4s7v
         IPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032409; x=1691637209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74ywh7TvqUkDUEffoH+37MC/7CbUn0PXoEShSbC3XgA=;
        b=a2jDAeXh+xqw0D346Vh4YEl3doZj6twvGzHmyqy2SZqJJLxvnJAepE/IphYU2IIrje
         obUc96KkpyhAFgZV3vQhaUk1BGk0ZhtXvQSi1ucVU60uJP75naMvgxLGvKfg42WLb7NG
         n8l1rH89ed6VO6DhzjCIgLCJuJYunWbLWloEjy/kvZAC/UeNYWNzB/RUstjsBH/IDUn5
         UmNIafMnLHr4PUmx9IcFd9lIPTeXWg2eis6cjNKrNDT5bCDeAKxFWwCni7X6x4WswwdN
         izjGhxbs0gUgUi9FXgQeLD4pFakNM2g53F0/e2G21QB2r8v1B6HY5BCldIacsVZn5pLb
         BWbA==
X-Gm-Message-State: ABy/qLbnOWoBN4yPCWma2g7kZVCLiqlq+4W5R4JAAXenAWPMFBGD469s
        imlE52lXfoUlJktvuPC5HHrp6khoZv/tG1dYT229PrOC+nmv/joEZHo=
X-Google-Smtp-Source: APBJJlFBfKV7GNDntx7e8wPWkZ7Zgbif1EWmRezCv/jwPoMNWV+5E4mxofmELlIQtxIkm/cZm958RX9eOg23wFq8qv0=
X-Received: by 2002:a67:fb0c:0:b0:445:907:71e7 with SMTP id
 d12-20020a67fb0c000000b00445090771e7mr4169562vsr.33.1691032408720; Wed, 02
 Aug 2023 20:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065501.780725463@linuxfoundation.org>
In-Reply-To: <20230802065501.780725463@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Aug 2023 08:43:17 +0530
Message-ID: <CA+G9fYvg9jA6MXayVRVrwsvN3qZgoZ-Cm0xQLJ78fKOK=R1tWA@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/235] 6.4.8-rc2 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 13:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Aug 2023 06:54:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.8-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.4.8-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 6a44ac630b76f8e6456c466d95148be9a9d61d0b
* git describe: v6.4.7-236-g6a44ac630b76
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.7=
-236-g6a44ac630b76

## Test Regressions (compared to v6.4.7)

## Metric Regressions (compared to v6.4.7)

## Test Fixes (compared to v6.4.7)

## Metric Fixes (compared to v6.4.7)

## Test result summary
total: 169252, pass: 147093, fail: 2297, skip: 19700, xfail: 162

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
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
* kselftest-livepatch
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
* kselftest-timers
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
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
