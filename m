Return-Path: <linux-kernel+bounces-4938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B4818419
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414782835DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5512B92;
	Tue, 19 Dec 2023 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAeJj33/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAB12B80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4669ac6df36so425229137.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702976764; x=1703581564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvFnFUcuaIDVuSpyC6N0qpmWAkWo9W2n6TVb1t99Wl4=;
        b=PAeJj33/EHI5xO28FmxfSUaQ4UkmUBcJinXqmGweDBuMzdEcKug/Gl0ZFAMFv+FqII
         qSvX/i0HAh6rEcwOnBab2y3I7eN2booe+FtFCBwmaiEDfwQbb/nhR4Ky1SFpy6Jr+Ct7
         FcBJv7xwH76FsIgikeevJSrZooCXyIERjDXLGPuPzCM9DpOoB1J/TF3SBt1XuY/ggz2Z
         e6+E9OZzdcKTp80JEfhtsPfPVqzMd4ZCgmzySsJKCawdHiqW1uC00KJ2L+nqTSbGzsn1
         c/kXg4usEiM/ST09gsupztXwMDi1YGfipMtudl9u0I6JRC/I7pbeHlHJGArlqNPFH4LM
         2pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702976764; x=1703581564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvFnFUcuaIDVuSpyC6N0qpmWAkWo9W2n6TVb1t99Wl4=;
        b=oW36SoLkGB/P808zxPE4VArDWUEDL37dGDQ5MbH02zRmZtmOHTMzkLVb13eAoHlWu6
         Elh1GIW2Vz9LJDEXzMjaICxgs7qH8enEsy7O82ojCMf/nowopcagRJWDTBSkj/5D+xY3
         l0yQR3Pw8pTXd4nWHh186D1dqmmnERKqsiC/VZr8CsRBt4W1lUeIZmEliB7YI1HjBbnq
         kcr+WXQUjvx/xl0WGu+HQFm58h7OochyjpkXAgX24CEOKbp7FS2A+IUbnkkhZ5XV4HoU
         mBdZ8u8uj5vS/XZxVEdLbj4LPWPDycsrsKK5kbF09frvaho213WteoAEpo2Evo5Ne3KL
         erZA==
X-Gm-Message-State: AOJu0YxrG7UqnEl1I88hqXjgH/FbmehETkw+okiRP8P22/AP31xM1Vqd
	plHkm0wTPkss2rjKLby0q/ZSaO38P+Z56CgE+mCW1a8gOBkLnWg4T1Q=
X-Google-Smtp-Source: AGHT+IGGfiBu+4wwU9nWVoMHFYWVja3kU/4FSEALNwxCqhRTfXmdYh2aOpxgPHcsTM41HegGXvqtLeLI5/+cBnoN+uA=
X-Received: by 2002:a05:6102:3f45:b0:465:ecd1:47e0 with SMTP id
 l5-20020a0561023f4500b00465ecd147e0mr11949006vsv.19.1702976764162; Tue, 19
 Dec 2023 01:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218135049.738602288@linuxfoundation.org>
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Dec 2023 14:35:52 +0530
Message-ID: <CA+G9fYt+_VnLyK8B6OZf-JKw6+0GVYhByok-1JATb2S6R9W0uA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 at 19:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.144-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.144-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 2d628f368ca8aad32fc680e377c3bff3e508f47b
* git describe: v5.15.143-84-g2d628f368ca8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.143-84-g2d628f368ca8

## Test Regressions (compared to v5.15.143)

## Metric Regressions (compared to v5.15.143)

## Test Fixes (compared to v5.15.143)

## Metric Fixes (compared to v5.15.143)

## Test result summary
total: 97481, pass: 76793, fail: 2748, skip: 17874, xfail: 66

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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

