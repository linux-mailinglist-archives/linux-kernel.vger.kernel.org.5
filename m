Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5981800B88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378952AbjLANOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378922AbjLANOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:14:40 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7CA0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:14:46 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d84ddd642fso264687a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436485; x=1702041285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0W16F4lcpZ8yLA66z8Ns7cQEkaAJSZRgZlujODAFBjY=;
        b=Z4N7S12TIhIjHH/WEkMDl5I9O60qpLL9cSuzvzU7C1WWVdfP8+/I0k3Z7UhJJ9zzLs
         9VIXwU8wVaiDpV8lPHDwUd63py464PJCsj5FzKuBzWInbh1fTI9KIdZ0t2trc/0RMqeK
         EZm9TECSWZC/py5gLDxSSh4tioaPv9lcEZ0ONGOq34zaIga7+HG4XbiJDP741V0Vo31Q
         ebktrHaI86VaF/le0ReJ3KTrXdjNhHDbeK+sHceLf3WjV19gSHS8yM6pHk5DlwAzMCUw
         N/7KD8RuBKrE+7tpXJ1Jdi0iqU3eKx+2izV5RUF6XFv89ST9XkV3HgHgrlKAbY58bBS5
         2leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436485; x=1702041285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W16F4lcpZ8yLA66z8Ns7cQEkaAJSZRgZlujODAFBjY=;
        b=Te/jz6tKT6alEDZWFZynldpn2/HjVG2UerEY78CbK7L7Arga8r0KkdZg7XNC6SHSjK
         4PL6wXYRNf1Fc0QSTIYrPtva5qTv5nglPxxD8N//9pAonphzcEOvD3pUzAMopjuBvuFN
         2ilSnXgPUkopdQhdVP6cLDBxCU/UVgvEUnC72N9s+sgOR6dKdQBdO2FPOg2vNeVu7NgJ
         wASEjObgOD5lituECmwQxHsw7DruAxy3+1fVf2Ql8blBibWnyjd+km9vIdeLedRvLBsg
         rKCca2t+nFOtK2dyEtN+3HSd3FSlSZs+J3YPTzVNnpvxzABwCWJ0kEmMOyoZW5N3HppV
         Zz0g==
X-Gm-Message-State: AOJu0YxF4qUAZX3OpUFy0YBakOvM/LIEksD9EGYvR7t0xFDd5Y/yHa0B
        tykv6c+eg3bkUqaC8iU2BRj9nDRWFVOt7P9atfFUAg==
X-Google-Smtp-Source: AGHT+IFXeQf2TOaP+x86KeVNznhphAjy5NQ2X3ZGv+eAupqFUPllnCV4oSIRSe387vTiOXL/OxelT7sLz3tjjeaLbt8=
X-Received: by 2002:a05:6830:1011:b0:6d8:6c3f:50a2 with SMTP id
 a17-20020a056830101100b006d86c3f50a2mr1432559otp.6.1701436485512; Fri, 01 Dec
 2023 05:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20231130162140.298098091@linuxfoundation.org>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Dec 2023 18:44:33 +0530
Message-ID: <CA+G9fYuaN6uYzfKn1wc3-_9TFAQeRt8mTGi+WwB8WkH151P0FQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 at 21:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.4-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 6ed60a9257c16a5f571b2354c4c0178caa70fc71
* git describe: v6.6.3-113-g6ed60a9257c1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3-113-g6ed60a9257c1

## Test Regressions (compared to v6.6.3)

## Metric Regressions (compared to v6.6.3)

## Test Fixes (compared to v6.6.3)

## Metric Fixes (compared to v6.6.3)

## Test result summary
total: 154229, pass: 132702, fail: 2283, skip: 19120, xfail: 124

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
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
