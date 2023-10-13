Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945B7C8BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjJMQyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMQyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:54:00 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516CBB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:53:59 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45456121514so976673137.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697216038; x=1697820838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UenrsX5MbwRjyqhnHRV6P//x8KJwOJVev+tfBEoM2w8=;
        b=iJoaP0tvQ8QXVnxJf6RWYXj7LSEqJQS64gbefnJzh6Me8AlsOvKAoUZfnSZL+sqGUg
         1CtQMWSjbeBw7oFZlk33GBkoxJQOkcrtHAuGYdK+VsDzbYw3FooPoldVjtbbUwdM0ns9
         RUq7PEhGWRkeVMyvIpvvulXIJMyB5m77lAyhiyZQ4pnPpYBSblYV8YP31xW6OiQdego+
         YseA5xGrpfAKLlWqUosFcm+EZyYLK8qMwaI2Q7i+D16ZRBN1/ZPW9N0TNb78JPvEzxrd
         rnZuYjZ34tEtLPKuSkdJDE2R22NYuDj22D1IqTNY5IKC3Dr6Vg0P6GahKDqvHW4N5DwH
         JQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697216038; x=1697820838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UenrsX5MbwRjyqhnHRV6P//x8KJwOJVev+tfBEoM2w8=;
        b=vpc88Gy0S0zk0xI6ptWHAWpVmCjM6izK65p92WiS2wZN9FvvWCQWhfEJH//GXDFU27
         rA8HWKjP4Icftd1Gj/TZ5FFPaAxakAK9RHLWRN0iotRY6Mw3ZaIoroJ2MGFPQS1Mk/PX
         wm4srgAupgTftjU7hVqYUpRLpMVYzpK6vixyr9t3eKtt9ZQpe/3Uh9uv44IR0wPcZzYl
         0KYgmxVbj9jGk+YlGUALGngR8GAlqgNaLcNEXBQlvdikSZCC2V6NSMwW8LYxPfPB99qc
         G8t/yjXbb4f9WqaEo2Er0YQe86RlRkHy52mtkbYJq1W30HkyfPpnsnAtxuQ6Z7M+z8qG
         2nqA==
X-Gm-Message-State: AOJu0YwBIgSHsReenMfT+8pcEeuCPQTH8SXYFx1Mqntz+rc/N+JkiAcP
        hDxfLErDw2DAY5VyUg2cnu6YO+yxS6RxgbgXKqvdOA==
X-Google-Smtp-Source: AGHT+IGunW9nkr39/HMSnnqsy3zHfTPQi/WNUhGsD3vAyos6IbZ6NpeB21zhi0TQaHG1JoYaVVDh8N0ewI1x40B2jsE=
X-Received: by 2002:a67:e3ab:0:b0:452:5798:64bd with SMTP id
 j11-20020a67e3ab000000b00452579864bdmr21175205vsm.35.1697216038158; Fri, 13
 Oct 2023 09:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231012180030.112560642@linuxfoundation.org>
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Oct 2023 22:23:46 +0530
Message-ID: <CA+G9fYvB290Nt666yUC_CJi7_hfbfkFvpwhowtd9zawg41EYVg@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LTP List <ltp@lists.linux.it>
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

On Thu, 12 Oct 2023 at 23:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.58-rc1.gz
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
Following LTP dio and hugetlb test cases are back to PASS status.

Fixes compared with last release.
* bcm2711-rpi-4-b, ltp-dio
  - dio01
  - dio02
  - dio03
  - dio05
  - dio06
  - dio07
  - dio08
  - dio09
  - dio11

* bcm2711-rpi-4-b, ltp-hugetlb
  - hugemmap11


## Build
* kernel: 6.1.58-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 3fe61dd155ac48d1642f5cac17bd41a92ef585b7
* git describe: v6.1.57-7-g3fe61dd155ac
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.5=
7-7-g3fe61dd155ac

## Test Regressions (compared to v6.1.57)

## Metric Regressions (compared to v6.1.57)

## Test Fixes (compared to v6.1.57)
* bcm2711-rpi-4-b, ltp-dio
  - dio01
  - dio02
  - dio03
  - dio05
  - dio06
  - dio07
  - dio08
  - dio09
  - dio11

* bcm2711-rpi-4-b, ltp-hugetlb
  - hugemmap11

## Metric Fixes (compared to v6.1.57)

## Test result summary
total: 114725, pass: 97010, fail: 2320, skip: 15240, xfail: 155

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 149 total, 149 passed, 0 failed
* arm64: 53 total, 52 passed, 1 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
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
* v4l2-complianciance

--
Linaro LKFT
https://lkft.linaro.org
