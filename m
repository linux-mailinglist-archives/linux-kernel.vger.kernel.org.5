Return-Path: <linux-kernel+bounces-20780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684482851C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F741C23620
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBD36B1B;
	Tue,  9 Jan 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LP0DWELs"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66F36AFA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4670a58b118so526284137.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704799894; x=1705404694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6Wp2UNlh0Q2JLdp+psUnUSDYyfwqpeVTQT7FJ2KOsk=;
        b=LP0DWELsdV+Z9Uz7kI0MvAR6gDOVxEEMEgd9ZU5UJ5r6wb8gsqhtVIZiotLhfpbStc
         eIact3Aaqh4gdo54Hvkfz8/WtgLp13nlg/szRbVVzZFABRxNJ85SU96ZpQBYXN5NhbiF
         C0krRjtrGlyhytO8E80Shp+3tiUSXLc4lbx8dvky0iCvMAdUVi3SVF2RPIb+bdYWNQ9J
         W/LZU8hN1yRJCPJDv1TcF0qf36nYY5QcKkwxJoRkck1abbVk1CHh5TDodCLnWSkulBPz
         TNN9HEG9aNsmVf3SGiiYM0Emb8b/+GVqYdeZu32PN7WuO4w7Ue5SsSmJInKrx9uHU6yL
         hzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799894; x=1705404694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6Wp2UNlh0Q2JLdp+psUnUSDYyfwqpeVTQT7FJ2KOsk=;
        b=GLQqr5fYbNetG5cjE5NSng8FNEBwfSuvdoJ+hUfSrQV2Bdh+1gnEIU2WCEyTy515SD
         lPOSVIwQ/2No0UoFYOxbpxWdh0SrJhVPEubUTTST2WEm3Pw3cs/gJfiMxtusXJAgYazl
         zm+PlpWG2FFPxiKVD9UT+Rx32xDdCIfOcRkTPza0pYj37PYWyekkSCPHdO5axxJh17Ph
         Zss01vMNmDF6ZdzS2b1UOl07GKSYTxIXJEQ57PynH0C1Y0e6KVATbqeTbvEXOOq22+Gn
         5RQ/ReCVYQvx+y7sZlAcYbK3yxkpmU/LTGDkWuees6NnwKbB0hk7+qmFHHpo01ScS4bd
         /WJQ==
X-Gm-Message-State: AOJu0YwrRTuYFo0oSDrSqxiL8Ez1kRmHltAAmWYmCteYcLnRJPZH6Wye
	RALEd29wxwBy55kBkKwUBGmnNvo8Y4u6myA+LjtdDI9FSuH0gQ==
X-Google-Smtp-Source: AGHT+IFLtJJB1Yw27s7lF7Ckcwq/VMZCqLAc+JPwHEuYlOagxkuKcTmoLTgCF2QL0AWueN4Wfk09uuLL8MDc5uAnV4Q=
X-Received: by 2002:a05:6102:6690:b0:467:d91f:83a6 with SMTP id
 gw16-20020a056102669000b00467d91f83a6mr2533686vsb.0.1704799893451; Tue, 09
 Jan 2024 03:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108150602.976232871@linuxfoundation.org>
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Jan 2024 17:01:22 +0530
Message-ID: <CA+G9fYtojxHqvsiw2UsqpT=uvTo7B2q4F-LQ72_TvZERQmQgYQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 at 20:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.11-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: c52463eb66c8ae86cf354c700d80ae02fd9a1eda
* git describe: v6.6.10-125-gc52463eb66c8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
0-125-gc52463eb66c8

## Test Regressions (compared to v6.6.9)

## Metric Regressions (compared to v6.6.9)

## Test Fixes (compared to v6.6.9)

## Metric Fixes (compared to v6.6.9)

## Test result summary
total: 153932, pass: 132066, fail: 2439, skip: 19275, xfail: 152

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

