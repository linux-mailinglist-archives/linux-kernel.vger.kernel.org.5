Return-Path: <linux-kernel+bounces-20673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58086828355
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF653B221ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2F341A9;
	Tue,  9 Jan 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZTNeTd+"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DE3399D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-467d8906368so402500137.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704793072; x=1705397872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPps9fQJfqYekR0JiSwWXcOXuBKy/iLT3+xFGPb1+3I=;
        b=EZTNeTd+kmTfsuVVjk3pM9nJ7SKSuku9J9IDdUDfAjzjZ+ynqcQiRRhcBnXKfGhKWZ
         OQRp2UiJjOLPVma1MfCZ8aQB6f1IIpg/isvQf0yUyJGG42oqMx+e63dv6k5NSC0FTdtJ
         uMnIzCU2Wo4xAmwJDRWDV+dfQAhRvmIG45zIicxxcBriWqeOBT5BG4YRb5fO2MwRY87g
         n01WvA0SspLKFCf0AMQS3UwBv/MEUpNe/ubKaeeb9wRb3zTh9wVRMIdBRI0RBkjCeLcw
         y2pV3CiutD0MRR8zHjGTIUAmBJISUM8CRPTszLvoXuWEi/8EwVCyqZOVW9gNEh57dExO
         D3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704793072; x=1705397872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPps9fQJfqYekR0JiSwWXcOXuBKy/iLT3+xFGPb1+3I=;
        b=d/9ySmTio/crevqNYN+Xf66W/7J3V0L7UEGpSnGi5T40++ZD1vC6AFGWvdFItvsXIY
         nKwgijNlpUCINJdRnJ9cEDY0cIR3btAAu9VSoRWP2TM2ZXOxV+OXBiBf1wjeWpo6OiIO
         6h7vN90wFE49RL1pdygltOGu2Nh1VIKu+pUYu/EkoVtxFNJcDxmQGHtphUsYhV75JH6Q
         IOcBWVzeatIjhnZLeug3dYncL2uFN/rqRnqJcrI4QcjgW4g5EW71zYMTgLl+nKrNvTa/
         bqvyMOMDsa5ltdtxbe+Z8b2ricuvpPfMRVuMURKsQQNzJsFOgZQU92dVuPa6sxcSULc/
         IFQg==
X-Gm-Message-State: AOJu0YzrM1r1qJh/LDh/QpeHlrqwRTmV4X4+T11VZMBuhYeoMIHpshCh
	zUj0BiacohNcmfBPBfthC8dWN7287pMDMiUfbmJPHAvkvF69hw==
X-Google-Smtp-Source: AGHT+IHpuZXX1y0Vv8xOJwt5I7st9NydG0ZAw3LOuORXwYg8h+lco8Qa+qGXoYwHlETtmkwKrMCn1vJzX1nLuZoB5Jg=
X-Received: by 2002:a67:e70f:0:b0:466:eb74:5ae8 with SMTP id
 hw15-20020a67e70f000000b00466eb745ae8mr3282084vsb.34.1704793071716; Tue, 09
 Jan 2024 01:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108153511.214254205@linuxfoundation.org>
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Jan 2024 15:07:40 +0530
Message-ID: <CA+G9fYvkBKmg-CUz4OmSOAKVd-asqKaxPtc26H7BY2FF1P6dGA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 at 21:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.72-rc1.gz
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
* kernel: 6.1.72-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 28e6ce52ce1863adfe7e865ad3b12063bba539e1
* git describe: v6.1.71-151-g28e6ce52ce18
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
1-151-g28e6ce52ce18

## Test Regressions (compared to v6.1.70)

## Metric Regressions (compared to v6.1.70)

## Test Fixes (compared to v6.1.70)

## Metric Fixes (compared to v6.1.70)

## Test result summary
total: 136423, pass: 115293, fail: 2954, skip: 18021, xfail: 155

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
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

