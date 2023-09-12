Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD58B79C943
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjILIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjILIG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:06:28 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA32132
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:03:05 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49059b1ca83so1867629e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694505785; x=1695110585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcYYrVUsshmH5A6TR+yYvs3OB8iN1jYR1U1q6ihQM5s=;
        b=jBzLO36gN4u44O5Bf2mNkAT0KXJjyVZwqXpu7fqFp0euQqj6AY8LKtt17wLp+DUHJJ
         vhblh++uyn9Tq5vVpniKuZaDKP8jMwjcqqsQcngQVJDtFq55NpsaAt0HxgALyYPh+5mv
         cieoRmA5uDfOJrf9j+bcl6F20mo9KJGznrZdZ8VBbFs3TsOvxfhUZPIH2vXBQQ+1vPiX
         FYTb9YYX3+/pya7Dv0QrXMorvZAL3l/B7b7/wfJf0Lj6WV9jzZtGc1JB7EM1Rgl5x1+h
         J0jp5NN6DOsU/zAEdXhCKlIX8/kbRGlOac3omozH5nRTqCnT4lEpsf5KszVyctROZz5t
         Xluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505785; x=1695110585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcYYrVUsshmH5A6TR+yYvs3OB8iN1jYR1U1q6ihQM5s=;
        b=lYGogsOiihid+8t6ewn2zsp/vJie7dYumocKMjgTJP8jW2xxkrHkFJCXgE/IeX1vRV
         sywVKzCc2Q4W9CHgNfREY7lyCSpXMG1nyJkD1sNNsaLolOoR1fhsO5WD8ZGrvFvWZuxw
         9wpZyA4rUTdB7BsVmhRZT0Xj/jf9xNd4Lh6ipdwDWxtG39RHr2AVpc83hTXhgGK6fwZq
         dINEykfq6KRRZD2AtWhcE2y/mOQewFGXQH4vzv3XBVfdzg6Qka5fHMIVCZGLy7ezeEyD
         JZxjr88bzSqFtNVcJvEaZpepxjOrE5pLxmqUHePEJ5Yi5cwqd7NFz5ojJWsYLPJHX6+b
         PtdQ==
X-Gm-Message-State: AOJu0YzNGcilAI7DnLsrkHI4KmtE1amIa2IGwaDenWjbGtnKmr1FQzpJ
        IPA9V64aB01aSOkZ4m1dDeQodLI9GuPPkegHIsQPtw==
X-Google-Smtp-Source: AGHT+IFLm2Dmj+RMHkOiznh51B2T48mFLnh4UugXX6gsnZIP6rRqLe64+INTDKxRcRy4pjA9xUYD3jS0nlbs8Ah1t4g=
X-Received: by 2002:a1f:e6c3:0:b0:48f:e0c4:1a1 with SMTP id
 d186-20020a1fe6c3000000b0048fe0c401a1mr10652871vkh.12.1694505784949; Tue, 12
 Sep 2023 01:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.921299741@linuxfoundation.org>
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Sep 2023 13:32:53 +0530
Message-ID: <CA+G9fYv7PymkiagSGFU-BXG43gHm2NYDd2CNJw26C52EGhjpig@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
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

On Mon, 11 Sept 2023 at 19:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Kernel crash noticed on Linux stable-rc 6.5.3-rc1 on qemu-arm64 while
running LTP sched tests cases have been reported on other threads.
Since this crash is not always reproducible it is hard to bisect.
Link:
 - https://lore.kernel.org/ltp/CA+G9fYvHhiiGKhNd=3DL9+xYFVwv0Q8k6gUBeFQGWCW=
w1cWhb50Q@mail.gmail.com/T/#u

## Build
* kernel: 6.5.3-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: 7bfd1316ceae2dc3bf962695aafe5f1d0f5bb4a5
* git describe: v6.5.2-740-g7bfd1316ceae
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.2=
-740-g7bfd1316ceae

## Test Regressions (compared to v6.5.2)

## Metric Regressions (compared to v6.5.2)

## Test Fixes (compared to v6.5.2)

## Metric Fixes (compared to v6.5.2)

## Test result summary
total: 138096, pass: 119333, fail: 2020, skip: 16565, xfail: 178

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 142 total, 140 passed, 2 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 23 passed, 3 failed
* s390: 16 total, 13 passed, 3 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 45 total, 41 passed, 4 failed

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
