Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5037883FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbjHYJlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjHYJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:41:10 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928341FD5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:41:07 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79dc53034a8so289579241.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692956466; x=1693561266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuiW0cpLI38vpQljciiL9mKllo+hJgUjvnHQr0VpHR0=;
        b=PmYiGn3ZIuVE2ywRDiqvXNkthjNWZAAn2Dmt15EhJRhDMjpYyNid6lVk2H6sT/4GZo
         yXRC6Bq2ABbGdGbfuYj/qncaHAzTG/J8oNORc6FRVkZBBD42GmvYW9pEsWLp4SP4oXj6
         3/DeRcQ4gXyA9hXAHcniQkcCO8JX/mEmrlYozwfmX1X5kc+6IooIuGNRJlELCBDlCTka
         5JMdNrAnn21hbAhTCUBRCi6kuF85vZFl2Vjm7AsY9f0ASphMJuvNEO9zKNkK9Xyql1Sk
         VzqfB+zHFDGkfXN2cQTMeqq9f3bE0/B6UAsZWzguxT71hwwWcVycUz9c+nTol31E0CER
         Nj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692956466; x=1693561266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuiW0cpLI38vpQljciiL9mKllo+hJgUjvnHQr0VpHR0=;
        b=ciml6CUbUBFy/EEZUjPs8P+ngDbEgNos28edIBFjnJdBmyQLYpWLv2NbnCiePqYBiF
         JxSO230XCwC+wS5Ylc2auVgBbmUlbj9c3Ga9u/A1Zy/Y244+B4R9PNVe5Cl1KLEzJV0g
         qjTphGbGvnnH6vYWUikRc+xjAvgk/kA6fxQ7+GB0WnTkzWNXhaNa+H1otfauzY8gr68n
         guXXA6ZHzeY/aZj+U6E8nD3xXRa9VjtaGbH0NyRkr1BkqiSeOR1unulxUmOvMWiHK0wc
         TtTfK2ILVXNGukl3zxuCnhqnVqlEcdSqf1ZRDAacYATXy3vVBm3Nj6oHRRai3Ghdd2If
         1v2A==
X-Gm-Message-State: AOJu0Yxm6cMZ5YyNtPEGLGRdF4ByANW7o0DiDQsbSl0ZO8ugOleU7m+y
        OX1Px8Z6B48hIhAI5e9sNsn7pt6matm66QRZFtVCHA==
X-Google-Smtp-Source: AGHT+IHw6FNcU3nnH/c3qs5eR1Aswt5YmnANEpF/U2gzaABBppQuM/RmZNqEmbhsEHsLCrW4yfMlKH3k0/WSBvWBtpY=
X-Received: by 2002:a67:ee59:0:b0:44e:8626:71f2 with SMTP id
 g25-20020a67ee59000000b0044e862671f2mr6114824vsp.13.1692956466611; Fri, 25
 Aug 2023 02:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org>
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Aug 2023 15:10:55 +0530
Message-ID: <CA+G9fYu9BK9Caqo6Mp0q-iGpKHDLQVPMYUhZFbvF_E-XDD6y8Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.48-rc1.gz
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

NOTE:
1)
LTP syscalls chown02 and fchown02 test failures on NFS mounted filesystem
on arm64 Rpi4 will be investigated further.

2)
While booting x86_64 we have been noticing this kernel warning
but the system is stable and running other test cases.

kernel warning on x86_64,
[    0.809960] missing return thunk:
__alt_instructions_end+0x2743/0x2770-srso_untrain_ret+0x0/0x2: e9 7e
fd 09 ff
[    0.811301] WARNING: CPU: 0 PID: 0 at
arch/x86/kernel/alternative.c:572 apply_returns+0x1d7/0x200
[    0.812587] Modules linked in:
[    0.813651] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.48-rc1 #1
[    0.814120] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.814120] RIP: 0010:apply_returns+0x1d7/0x200


## Build
* kernel: 6.1.48-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
* git describe: v6.1.47-16-gc079d0dd788a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.4=
7-16-gc079d0dd788a

## Test Regressions (compared to v6.1.46)

## Metric Regressions (compared to v6.1.46)

## Test Fixes (compared to v6.1.46)

## Metric Fixes (compared to v6.1.46)

## Test result summary
total: 165563, pass: 138512, fail: 5138, skip: 21721, xfail: 192

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 149 passed, 2 failed
* arm64: 56 total, 53 passed, 3 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 13 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 44 passed, 2 failed

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
