Return-Path: <linux-kernel+bounces-16536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3770B823FDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03551F21A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222520B3F;
	Thu,  4 Jan 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qf0ksclY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524920DD2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-466fb179334so57671137.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704365382; x=1704970182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lSLAgF3yzZ+WL+iGneL5odyxIGJYYIwjdlJ0e++vws=;
        b=qf0ksclYaLxc53mRqhelWpW4cibgbU4Sbhz6fqaG5kGF2h+HPY9sc2EnMUiHTFDPTz
         +E++gJ4U9afDmzF6YtRyTURgKfcl82vE/RWHcQVR28BxXBxX9DCVuiz4ScIbPn+aEpuF
         2NhlULkAQ2ZYSRjKLqZRLVxoyZ04nPMMMgsBCqszzL4VBDhtI1Qfb0JFALAl8lslLlrG
         uejrIRT5JS8vvW+M32qVaafjPNo1FTdhJO5QQLb99oZq9rYDhWjYvqSZmqs9/A10p48q
         bEUmVSeXZbW7LrNF1rXqN8NRzcTQWJdxYFSThj+XIGJGgoG/9+OpNsZaxTN+3d7bjxE9
         xH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704365382; x=1704970182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lSLAgF3yzZ+WL+iGneL5odyxIGJYYIwjdlJ0e++vws=;
        b=MEQzc4BRwzwzh9JTUtYNfKTXgjMf9DYu3Y9SFbWANVXV9OgkNFw5gvmgwE20D44I+l
         FWjg+ypg2h30DxLkWsseKCZpXk6+kMULKN8kcXEg3o3/yOQZZx21/yKRaBRiHUXiH4A+
         usQg8LOfqDS3HZKwVXaA0wi1E/FYELVce1dvhy3NtkQcTNJFS1QzHmoYmYcdsBIFJZDl
         F0B+NRpGUAqF165Iwy75aYpIObOYG4jJr3aMUB56iXatBv304aFcnVacsf9QmPa6MDjI
         R8IZDLbyZ1xKtlOGbBQOZ5zxIDA8aiP3VwN0gi2j4qHLC5A1Vu8vTc+nSeqxGNPLDhU5
         Tt+Q==
X-Gm-Message-State: AOJu0YxtmBpMdYkJY0PblsZ2+RWk1phV+97kqsSKcBIRxw0artWvKPiK
	OUNQKHaA00HywPoPQle1VEZHa+Cj1L5EoB3kWDVnCRQlsEVSXw==
X-Google-Smtp-Source: AGHT+IElE9BQNCHr+NMpaysmcqMv4FPD0he8YGgzI2o6aRtB456DjHJJIAPJLVTyLJl4DWpI9fVmsbCU2bBmO+Lb3Z4=
X-Received: by 2002:a05:6102:15a8:b0:467:a64f:aa27 with SMTP id
 g40-20020a05610215a800b00467a64faa27mr217036vsv.15.1704365382054; Thu, 04 Jan
 2024 02:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164856.169912722@linuxfoundation.org>
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Jan 2024 16:19:30 +0530
Message-ID: <CA+G9fYsf1SDHMk+Aq=QZZAOOih1F2LoSb+abEXP0WQ6u8maxog@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jan 2024 at 22:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.71-rc1.gz
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
* kernel: 6.1.71-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 55d8c3a7d7448a75a541c078fd8e7b6abcbbac95
* git describe: v6.1.70-101-g55d8c3a7d744
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
0-101-g55d8c3a7d744

## Test Regressions (compared to v6.1.70)

## Metric Regressions (compared to v6.1.70)

## Test Fixes (compared to v6.1.70)

## Metric Fixes (compared to v6.1.70)

## Test result summary
total: 135389, pass: 114436, fail: 2678, skip: 18148, xfail: 127

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 37 total, 37 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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

