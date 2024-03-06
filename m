Return-Path: <linux-kernel+bounces-94002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A72873825
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B00C1F25279
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D22132C1B;
	Wed,  6 Mar 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSyyu3pO"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8913249E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733130; cv=none; b=qv84AT9FR8WR/K7k7fo7O2O7evfgYxWVpbduSzet1TpnOpbw4lGDSzuXIL0uCtRbKkX9WB24g8Zy38LQDx2IWiH2Zp8peaaV5zZtf+QNksAlMR325J84qH8fFJ5pxKMxD2TfhsCnOrzf9DC2haJbFQrYQWORgIErKQqZiz0zNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733130; c=relaxed/simple;
	bh=DxD2l0TYNyX0nIo8X0aUdafi5RwApWasX/Fm+UM7f2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIUq48U7rG0Gi6DqBjSdFhqjh8slVIT83Q5Kwtn4k8FYyHQa0NTodmzX2a7YbiuhfOov3WUmPFPKrtpJ+W1oyOafP4DudvxgtP9LH0AFza2SMDu/0jbWX5K22eovwJB5aLq2NxjibpYO2JtWFntAb67KELTijB26fCaXOrYn1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSyyu3pO; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so4738152241.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709733127; x=1710337927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIv5f1kNqPYJFCk7U0R+MAUVSCh7feTHZ/Nse4z4iY4=;
        b=CSyyu3pOCI6EKXhSz2E0+jNIWWWD/UDIBmXgdnUjNA9+UF6qS//DStBp6kEh1rWon8
         OUUh5nz1BQjSe9G9qHKwcQuO0e1T7Ro09js7P80Se4vhFFmqKRCEmnbfNMOmSs0WzrxY
         hOpkB/9p4TOEAJQ0XNXDFkQ39k4Io5EPZHg8koGXEY+4BoQovXoYQjfBGkuZNG9meN88
         fVz4TWkikG20eDAKtxOABAWj8lqdRM/y3LMsll7CLPw+fUdwFDtGZmYUSo5LN12WXg/o
         MiBYKEmoVssOa+HROuoFKhv5gxoQZBLlC17KdSREWpo58/IQhID2I3RZ4oPm40bJMh/P
         MBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733127; x=1710337927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIv5f1kNqPYJFCk7U0R+MAUVSCh7feTHZ/Nse4z4iY4=;
        b=Umu30/QK4wPdHvRLlwsM4g560T6EvWO87toaW8xr3VT+ZCC8KoWQc8fHEG0fz46iaX
         ni4iwmqMcQ+ebPaehVAeAw/QFaGogPPsdi2uGA/8Y7b4NS9TybfFS4V5d2ws9VTGXb9z
         +4qsE0/Aqals5fcyrBZdcnDN9aEUKGdDiFPKTXGo74FiiVOMoG+HbkdmNkgQCudVpNnR
         dO+l4zYG7VWNneiZ+04v1PMfB5SN975sEeDdzgzyejLMGRfyWhDDTHXGOTnjlTQBxezg
         CXW/pkvCBA8xxs9nQuVFJ+NodWDAmWoFM1/dMb8qMgpQBJOMdo2bt8lU7n6J4OooALwp
         3Ksg==
X-Forwarded-Encrypted: i=1; AJvYcCWEOksGx0QvQQTeRzR32MPp/KNwQv1oTkx6sB9p03m8VynP0yXE9Ba1oSSw1kgUS3nOHrHtHPscT3UcyWRHxnTVSgiS1RLmT23+yjFn
X-Gm-Message-State: AOJu0YzE6ep8/Pe/VvbrJBdvW0I/nOYTDuQs7QiuceKtWKnDAhTeCPYz
	czWTTxyy/5U+J0EC1V7pRCcAnlnbhkQBt7kEHLcfj7lq64PhrmJwoFnwRtFW8fUiOTCx2hE0o+T
	Txin4daZrZQEWCsLRRPJ9EGH9PU2l8+bre3SIXA==
X-Google-Smtp-Source: AGHT+IHhkU275prC88a734xDgCRlafAyCScqUTRNlX3nQgmvhtdfhst4HZGyhvX8Gi1Gdr3G7TwSw2pUSMs4KDdr2fU=
X-Received: by 2002:a67:f408:0:b0:471:b9ab:7bad with SMTP id
 p8-20020a67f408000000b00471b9ab7badmr4148859vsn.29.1709733127093; Wed, 06 Mar
 2024 05:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305113119.020328586@linuxfoundation.org>
In-Reply-To: <20240305113119.020328586@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 19:21:56 +0530
Message-ID: <CA+G9fYtdu7zVnS0=Z12x_YLUbLaefpFL2F4CnmD0AHyP1p_j4A@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/41] 5.10.212-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 17:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:31:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.212-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.212-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 713b6af903ad5057407164571c78c1e307098b8e
* git describe: v5.10.210-165-g713b6af903ad
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
210-165-g713b6af903ad

## Test Regressions (compared to v5.10.210)

## Metric Regressions (compared to v5.10.210)

## Test Fixes (compared to v5.10.210)

## Metric Fixes (compared to v5.10.210)

## Test result summary
total: 92769, pass: 72680, fail: 3078, skip: 16948, xfail: 63

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 107 total, 107 passed, 0 failed
* arm64: 34 total, 34 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 30 total, 30 passed, 0 failed

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
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

