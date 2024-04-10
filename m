Return-Path: <linux-kernel+bounces-138864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3362B89FB63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5840285308
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A016E87F;
	Wed, 10 Apr 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU1E3bze"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425416DEDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762521; cv=none; b=LsC7EF2vPmScWSUZl7Xinwgf2K7Hv+o50eTI1HX5gY0yRchkpo/0tgjO12ehXD8DmXypBnEaL6hFeNCU4KHGAWvT+XZgDrJHW7gN7fVAv479CpOAgCUzCFXDhsbe+QjHiyNl9oSBYIX8UMn8sKEJv/Lo27J+IDdvhgzSh7rrUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762521; c=relaxed/simple;
	bh=wBuC0Illl84xEqp/FbzFcOry0Ue7T9qc2B0qD8mOj9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua+OoI1DWBw3JJfANoEwz9G/5qaKX/7t/DwNsBxN92E2B0bic3AyddLcq9OSxMcHZYoNgU+vxCq6xPrXSbVZAEjlnv6qQ3eVZWo641pRYfBsTau8W1aBq9WkaS40u2r2fnpt3DKUn6KehF5IbLHGCLGae+x6gMVC69o0X5Uz900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DU1E3bze; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c6088df378so229875b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712762518; x=1713367318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh/+kENzI9+iNwdhm7uqEGlO03O1/nvUgo6PDioMQQE=;
        b=DU1E3bzeeQNfZFuTHvQIOThxVIcP+28X7jPPLhRTSWzMRA1hgRSoW0/nCUeG3QbXhz
         YeGfXIZKewo69wZOUTT3sLa1kNIH+U7m6WD6QVHwz5dAAT33lzKNVYZa/Zq2bGXTtHc9
         4Uq629pmvbcaa+ZspM+rREXzm3hXjRVx4p6FwPCsS3+qfmijujUy9oDYGx2eQv725Cd6
         R4iNaQSx+vjOnqboxuv5ZB5MqZZgB8UvWWAmhjZCSol5/V+0MdqJ66pFil0WHLRs5Rjm
         WP64pI+y/jyixVLYcXLpmpcw5BGSb1YdMYPxgP2pi8cgQpc5fFqINd9AjeY8ZAfrxfI0
         8IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762518; x=1713367318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh/+kENzI9+iNwdhm7uqEGlO03O1/nvUgo6PDioMQQE=;
        b=d16gz3O8k/5oG9SlDY/q+iLuAGSPbbZvLc++aNfsO+sLzcVNXgnI4wLds3VYLTc0JH
         IuAwhIjEq88FjeQIsseLbjl3ORL9gWjMMwWaZW61L04yDaMU4R3qJ+7xo1weRkVrl+zW
         TTKs6xm4UZgCFK+5vgwcI2Rwj8TGRhV6gLQobUNcGh4XmSj3MVrPnfewxYEtuJq1Qv01
         MIdlgXkF9r9o21ijA0hv/ImOcL3/OoYhEKqENUJPfUEYAlsjtxGT/5hd2LvnnKn76Kdf
         BPW5SG818EH+YWh2Y6s1WiQYUV4Za0ws03VAQk27Xs3mYLPigzf3/deB/tJt61F/Ff8N
         EWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyqtmm4hb5uFOaktuMgqFfSTF69tR9/ewPtO3NdnM4ZQWNzddhkV5wTXlDtp4e7YI72MJphIq33PWhPo+0pYsuM29klXEeSER4ocii
X-Gm-Message-State: AOJu0YwnaQacksLNh5kLHsJ3IcPs/lOuJe2DAxatgTNf6OhOZEdFjKwC
	mzfyqqVx67c1hi2O7s46dCjS+sQ1NF7/90dECjFyBhuQmHoSUf8SpOt3No6EzhiTSh0xOHTZvaP
	g/YMJcwM0YFkql3S8dYWjlTvhZJmfw/EpthdJAA==
X-Google-Smtp-Source: AGHT+IHs1rMwruPktCfgMf42wwout+1xiC6AIC+tzXJFoyH3OJnndfX/9PeFn8BiOrx62T7JXVLcseVgv5m84290LxQ=
X-Received: by 2002:a05:6808:2a67:b0:3c6:6c3:76e9 with SMTP id
 fu7-20020a0568082a6700b003c606c376e9mr2564860oib.50.1712762517818; Wed, 10
 Apr 2024 08:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173540.185904475@linuxfoundation.org>
In-Reply-To: <20240409173540.185904475@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 20:51:46 +0530
Message-ID: <CA+G9fYuYu=8ih7B++PxDhNar4Vkzdxj8PbO-VRNvk+EPVAd+vQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/255] 6.6.26-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 at 23:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.26-rc3.gz
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
* kernel: 6.6.26-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 63547075e080d3f850b89cf107e49946c3b7c4eb
* git describe: v6.6.25-256-g63547075e080
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2=
5-256-g63547075e080

## Test Regressions (compared to v6.6.25)

## Metric Regressions (compared to v6.6.25)

## Test Fixes (compared to v6.6.25)

## Metric Fixes (compared to v6.6.25)

## Test result summary
total: 173151, pass: 149294, fail: 2238, skip: 21459, xfail: 160

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

