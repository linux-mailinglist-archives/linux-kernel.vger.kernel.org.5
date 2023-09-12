Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1279CB15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjILJGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjILJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:05:52 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803749CC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:03:47 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7a2785e34b6so2141677241.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694509426; x=1695114226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCayrQz/MwzUGFvp7TTSnIo8uy/DMXxnyvU93mXar1A=;
        b=ewOAgCx662q3f5mJRFfpq0C40aVMXMQD+xodqgEribVS00Bm8jgcNO4mUcFTORlmzW
         cJHL0jBqrhsJAe4RSTtbJpY6fWX5sY4ORp8L9XqZysBbEC9twGokTwoSQ6C1QrWBqX/9
         lL3kMwQunIeTBya4qxZ6soC8SeYDUt7u1anCn2DnCH6AAvfUv+CEG1wsQe3A2ZflC9+d
         S73UWp5/d3sq8yQBr3Q3sResq+vuBIzBdGgs0o/ziIkmzRzR2zxcGPDo9n5I5Gmzu2oK
         hbKb15wdbJqJrVzAu2sarwPBdmnbC9T9W4PIiZUs7dnWK+BT/fcXX4lcDNnzkeKWTZti
         qYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509426; x=1695114226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCayrQz/MwzUGFvp7TTSnIo8uy/DMXxnyvU93mXar1A=;
        b=v33uA57GkC/KBIFKFSFcMLojrdRdddS7FQSPqX33vk+sWjxHIdMP4IOvSBcqdN42Bx
         cQwRCQaCaqukRSErRC/pb2vMvRQM2VVhM0GxeK2TxVB65KCWkuLsROLR9xWNQjs77ene
         lDvml9NC1EoHE3o0iYoYrJUhm5NfrHMcy2Ir0Qp4dDS/dfk/DCwLnYi7Of3JVXUdltKt
         VVNVQu96DUwlN49qfOONC7Ie/ob1lgupQckfJ9FDEEpmnVf74c+T8T2GNyPjo06pSel4
         Ckt7LKAMollgyhKYMeAj8otownWf31hjTvqhPG3rojb5DVjZG6MLeLUGlNJhmwg1QGtD
         dQPA==
X-Gm-Message-State: AOJu0YzmR5MP/EJ8/WL+tWbwQopb874gMMaPP4krWCK/hGflSzPlb0/w
        8zXcleDmyFXN8J+LW+hiKIHdu4iHsk/ThqmBYSsLTw==
X-Google-Smtp-Source: AGHT+IFaMkMZwWT/cyO/jLK1QBza7jTQjqPfHN3bW+pqMp28W/ij9wk0k9Ynup6Hr81SFYrQipS4hDuxutGg4T3Siic=
X-Received: by 2002:a1f:4807:0:b0:48f:8533:3cda with SMTP id
 v7-20020a1f4807000000b0048f85333cdamr10298819vka.11.1694509426091; Tue, 12
 Sep 2023 02:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134633.619970489@linuxfoundation.org>
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Sep 2023 14:33:34 +0530
Message-ID: <CA+G9fYuBU1XfOBhHRuTQJL9vmUeMtPn7CsEzz-+-oQLhgM3tNw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
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

On Mon, 11 Sept 2023 at 20:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.53-rc1.gz
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
Reported build warnings with clang-17 on arm, powerpc and s390.

Link:
 - https://lore.kernel.org/stable/1ffe4f64-f238-859a-ab14-7559d03c4671@lina=
ro.org/

## Build
* kernel: 6.1.53-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 6e71673725ca14f97b45c5aeeceb462e3cafc16a
* git describe: v6.1.52-601-g6e71673725ca
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.5=
2-601-g6e71673725ca

## Test Regressions (compared to v6.1.52)

## Metric Regressions (compared to v6.1.52)

## Test Fixes (compared to v6.1.52)

## Metric Fixes (compared to v6.1.52)

## Test result summary
total: 134187, pass: 114492, fail: 2409, skip: 17116, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 146 total, 144 passed, 2 failed
* arm64: 53 total, 50 passed, 3 failed
* i386: 40 total, 38 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 37 total, 35 passed, 2 failed
* riscv: 15 total, 12 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 44 total, 40 passed, 4 failed

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
