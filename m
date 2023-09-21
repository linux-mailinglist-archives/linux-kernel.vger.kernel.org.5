Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8497A9833
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjIURce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjIURcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:32:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E1212454
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so210345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316013; x=1695920813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWoVfeJNWpYOw2AR5qsdHKnZ57Lj4md4yFa3lu+nPyw=;
        b=DtMNhBwBrehrriLrO8EhRhJdJtHFQLuvEiXNUrW0klZnwiRXOk5yAhU00LI+rP0Zlg
         Lj7UBGhHrgYNDy8ZaY90/zCgC88DOJGPwiVpRWEt11bq4IrD9rj8f5C5HDx1XvXa5gfv
         hppg8lysaIiW+Vo2SrutA08VLWpeVQdezcz5bLhg8T9k+wYadxPRJLX9wcdWsaQ5NNwr
         xuMa5w+nJHUlbadLPpKzuVMFccBQJGrWlXiEiT0ot2Y8j3bWN50vnI5ej6wtdgY6W+pl
         46vbROqZLLWkzyWU/YxVVkptHhWoPgkPQkWRdxiYVWX2yjfn78nqcGsvsNVnwg30gx3f
         sJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316013; x=1695920813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWoVfeJNWpYOw2AR5qsdHKnZ57Lj4md4yFa3lu+nPyw=;
        b=asZc6cjiTMSWFeb3rWTnBjmzjQyt3j9Nu+WfjuE4xoKxMXiVzszZsIJ/I4BrHmokyU
         Lt1dfH30n6a/Qn3Vmk2Yj1C3CRijxYK4uzfr0T9xsVbbifHyq1Ms69LuCGrlriYNQC8v
         U6GCe6Kv1fmAoGwrjObcwSR6GXMR5CXy5Hr5WV+C8zO4Gm9LBjkqnWBbJBx3S0er54Yt
         YzLsaVaVNIF32iB5E0Jjq/YapMRQs7iVGI5x5Kc7KF8gMAu0Ykn3CHfAk6gLjRmlRCai
         xbJYpVv186csqiMLvvWtIBwH50C3/ClsbS/vw6sgflmNWZtRR3eG0LxGApyv3XLpL4Xr
         8MFA==
X-Gm-Message-State: AOJu0YzxNzwT1SGpVhRgTO8y7InxEnT5edxK9Ya8ba4V2uP95/P/HRQ/
        AaJrGxJ6B5+jrO+uqiOymwQuLJ0/EZIbcrmYFaD05UiZtfJqes3kMNxAkw==
X-Google-Smtp-Source: AGHT+IGrMj0r3Fxh+1t0WRpllLzabcIz3dq7zkG6Iib/mVE6tHfrUn9CTqOH6oPsZenAPfuengSGbduErGKPoCw2+vU=
X-Received: by 2002:a05:6512:3e17:b0:500:bff5:54ec with SMTP id
 i23-20020a0565123e1700b00500bff554ecmr6164308lfv.3.1695306216685; Thu, 21 Sep
 2023 07:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112835.549467415@linuxfoundation.org>
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 16:23:24 +0200
Message-ID: <CA+G9fYtOEYip64iu00BPgx+cKbdhEAhzd36kO1GzQYCWKNbxoA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
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

On Wed, 20 Sept 2023 at 13:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.55-rc1.gz
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
* kernel: 6.1.55-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: d5ace918366ee2fcf06842d77abec8a170c759aa
* git describe: v6.1.54-140-gd5ace918366e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.5=
4-140-gd5ace918366e

## Test Regressions (compared to v6.1.54)

## Metric Regressions (compared to v6.1.54)

## Test Fixes (compared to v6.1.54)

## Metric Fixes (compared to v6.1.54)

## Test result summary
total: 125579, pass: 106421, fail: 2477, skip: 16508, xfail: 173

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 53 total, 51 passed, 2 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 16 total, 15 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 43 passed, 3 failed

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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
