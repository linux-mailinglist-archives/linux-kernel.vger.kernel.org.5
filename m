Return-Path: <linux-kernel+bounces-25740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93C82D52B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC6C1C2133B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441263AB;
	Mon, 15 Jan 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKdEtTCK"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BA2F25
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7cd03e3f8a3so2465419241.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705308147; x=1705912947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWklBxYj0tGpLnXSdFPOjTfuQ/CNbb5ajISFOFHW0CY=;
        b=OKdEtTCK8zi/2jiC0ilsynXCG9DYbXxNTKiTbZ0E7VI8Af8kMkjD8X/NHQPuTgqKkJ
         PTJ4LXGv9o3lIDud14M1iNX4EP7g6GMnLTcX5zt6WNIFeLIbAvHYMT3wtDQ1eseuObIh
         XeJy9a45l100K9wRP8zMSqzRiDwouVX0OS3BTmSbB6hkBlehjRPdzoPylUjhH+lTryvG
         O5DydFBqOnXY82O2TJg6RIU2q0BMf0pv8eTyQPUFoUhpp2iLBbM8+Lc6XtdQa/K2I78L
         qUbgsyZDEN9HwXIzsCA/UMbiSUBoZChcHwrTm8+HJXJCAplgT/izfdZO4rgHoCFj6w0Z
         T0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308147; x=1705912947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWklBxYj0tGpLnXSdFPOjTfuQ/CNbb5ajISFOFHW0CY=;
        b=KL3SiiR7Wi4RfqMK/k12mU9UBh92uFGa5Q1w9SBrtc9Y1StHL95HJXQNsiGDrD0QDG
         ylDQiWhsAuEM1qdz1gxfzQtSXRBuKivHNpISLJhkJ62ASn6LdmVH1jSb/UoYK4IIoaSI
         4lqa2dkiH+DizOmIIJumdgGNkR88fCAZhmyRbaiFDntEJmGu9U+ypiH6s8DRzMDfppdN
         DdOACLzypYPo2MPQCEOB1QZ1BsOBQvIJsGscww/3RUxCAD+bqX6mJNNwI5JPYuN8Jztx
         U4r3QzwQ4jpBqgcJ4UtpLxu6+fmJVseXFnmO8vcCt73wHhO/s9pF1mVp4ABWrSzE2oDL
         PwTg==
X-Gm-Message-State: AOJu0YxaLUZkIV/0h39fXvVjwLipSQjItdjIg/9v3q0ziKRL9aEW1gPj
	fdVnxoxWTy+ziJH7n7K1DyBIPkuXUk9EEJS3p9HO5r/3HyJ8Zg==
X-Google-Smtp-Source: AGHT+IHwy4X6eM6gN21Si2MfkEaDI1PJLsuWjZQ0ZFZw6Se66jnpJn4l5USsOBJ75/E6l6Z60Q5J8qPRpWSq+kTOTdM=
X-Received: by 2002:a05:6102:22d1:b0:469:554f:f8bc with SMTP id
 a17-20020a05610222d100b00469554ff8bcmr957065vsh.2.1705308147641; Mon, 15 Jan
 2024 00:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094204.275569789@linuxfoundation.org>
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jan 2024 14:12:16 +0530
Message-ID: <CA+G9fYvx6RcaLq3Gjc1_AJgmu+zxk7ZP8wWZgghmOSpFbYNTFQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 15:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.12-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: f44c56831910cb87cac2c18e1b03dfa59e3523ce
* git describe: v6.6.11-2-gf44c56831910
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
1-2-gf44c56831910/

## Test Regressions (compared to v6.6.10)

## Metric Regressions (compared to v6.6.10)

## Test Fixes (compared to v6.6.10)

## Metric Fixes (compared to v6.6.10)

## Test result summary
total: 284816, pass: 245629, fail: 3651, skip: 35205, xfail: 331

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
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

