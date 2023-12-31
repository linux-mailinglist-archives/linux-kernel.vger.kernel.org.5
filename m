Return-Path: <linux-kernel+bounces-13675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2207820AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861DC1F21E10
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7623B1;
	Sun, 31 Dec 2023 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLRAknbW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F472184C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cc14b91230so5140172241.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704016157; x=1704620957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpJkWjQtcLPrrAUeSPsMgmPP9dcEbzNL6qUsGWeWy48=;
        b=iLRAknbWveoNJlpmSAcBpPdQ9UnbtB6gyyaIEziV0h8Ik/yqeL0KJA6SgFpH70FjEG
         WGwVs4z7wqGOd6OgCb/rz5nOkC+04sBgk5K/s8wi/GXIS0vmVfSs3fRTMKdPh1Ys9lw6
         baPy8AVJ52GqnEcGoBl+56SrzFRBJHseAGnGEMvoXyvNC8l4iL0fjrX5RozDkSfH5K7s
         3V9XhPnoSZeKYu/RYcNzzIgvtKbD84s+uWxqdIcMwCLKpDfbS+WonB7Bd3mlgowko29s
         wQezr+AVgkk8Msqlwdd9okZPcI5bqs2SeEaQKb69A6iWfbt8EEoI8cmT9zEWPuOIPXPK
         NQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704016157; x=1704620957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpJkWjQtcLPrrAUeSPsMgmPP9dcEbzNL6qUsGWeWy48=;
        b=sK+0A/CvnqvCOi6wJCZsd7B7ilYJiwJZ2AUWRBcVLuv39U0fTd+bLhCm5IRwwF+IKa
         JG+GJmgkrgypkSbyUaGuG62G8/+Z/h+XaXhPGe6p6hUd7dWE3LmN0tlPsVxSYITxD9WQ
         97jAEM3yDzjklgOIxcIth/FiUuN/aKlvtdJyAc0G3wsTVWyWk6nXge0IdFIzwwMQFAma
         TeWC/88ZbtEhU4WKZHjDulGn18tXy2/i5/Jbf6+VygnrZCSNswifusNCjN6Midig3FD8
         ngjXRgkUzLbGIQW5bdvINEt86zUkt5uKsRswmbgSz9Q573sidna57X6MBIfYDonaNVs+
         kIlw==
X-Gm-Message-State: AOJu0YwBKi8J3HeOpp2E+Clg16oFU+E6INbAOl5fWY11CLPvfiHAVXCV
	BsoR8jwFKH60kwuj3EqtUCTfjICUjohMIwt6TfmoBI97egyEsQ==
X-Google-Smtp-Source: AGHT+IHVkBnxKxoccj1aut9b24Yn4p0IaxJO51yYWmBK2spGAvo8qRlCRuQI1J1h9JWKrfLjtru10Jik4grazyftqOA=
X-Received: by 2002:a05:6102:159e:b0:466:255a:69fe with SMTP id
 g30-20020a056102159e00b00466255a69femr8633577vsv.35.1704016156956; Sun, 31
 Dec 2023 01:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230115806.714618407@linuxfoundation.org>
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 31 Dec 2023 15:19:05 +0530
Message-ID: <CA+G9fYtoMtSRzA8Wx4TCe=noeAamPXE04-gHUR+W1R5gpVy4gA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/112] 6.1.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 at 17:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.70 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.70-rc1.gz
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
* kernel: 6.1.68
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: ba6f5fb465114fcd48ddb2c7a7740915b2289d6b
* git describe: v6.1.68
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
8

## Test Regressions (compared to v6.1.67)

## Metric Regressions (compared to v6.1.67)

## Test Fixes (compared to v6.1.67)

## Metric Fixes (compared to v6.1.67)

## Test result summary
total: 135673, pass: 114774, fail: 2742, skip: 18024, xfail: 133

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
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
* v4l2-complianciance

--
Linaro LKFT
https://lkft.linaro.org

