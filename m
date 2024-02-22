Return-Path: <linux-kernel+bounces-76560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FE485F928
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE6C281B83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D711812EBD4;
	Thu, 22 Feb 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nS4hjxBv"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62812E1F2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607297; cv=none; b=bl9+MilZlgdN2w7SnZYh9U1ejo+91rjoMvh4ke77uDy9GjbmeydSepIlN4nqeuRx8kXU3iAW+2gZG1fuUP5s38tvNIST+psC/ReFeEuSYqEFxiPDdFKGM5Z8cQPIgPOzppn/hHJDOqtNTkU0a1u4xUgOaKwc+8vVunnPiKOwLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607297; c=relaxed/simple;
	bh=vBe2rH/5htWt8B1WCymGolQ5n51GQAmyO04V+UUcP04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GF9KYFnzgPoFL6RSsbHIr86iUvnwdzYZbH5H3rL7vMuQZSqlif2bXrrR/9l0bB39GcupYGgsss+b13tgeEsVY+n2qMhHgYzHQDNIPmP7EiBLwzRQ7c8nVsh3zl09GBiNfcHlpzQkdmk86+vsjDqUQPWGiqypj55+xmTrEnQjnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nS4hjxBv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c167d33fcbso773394b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708607294; x=1709212094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+/BhM9vk6uEEXg8M1FymefQ3xt758ktK2LzbdwL1LM=;
        b=nS4hjxBvuQuoxrbAkTecv4v7JwBruWCm+BeS3qJTO5CPsWmAeEItWcRu3AjgAbE8Qh
         /ecaWixdQJth+wbDy9WXDywmgjO2mrBQw/PjjL7tQ2Zn55ZOGSkkvZKd9zeVfN4q9HED
         u5o0PnSgw/BqW+euyAHRuTJx+bdnoyZ8SRpL6W3fosneiMkzE9p4vfLd0+ASDRhxaJ9N
         mAGm9jT1Z8SxTFsUBZBtKLxwl0/tG2V9svHyIJuOl+qQzk30dZpPxr37JymCQaJimghF
         Bdr5IPydjmhjlwf1qerNGH3TrZzr6zkP8BF7EWlz/7flqvo7clBBi9hHmdbyaN386GuJ
         tMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708607294; x=1709212094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+/BhM9vk6uEEXg8M1FymefQ3xt758ktK2LzbdwL1LM=;
        b=g0H33JSTGanqAYxCMB6aKEtdOZHEJi6E/twzd/aYoN4OgJxa0fumz2MYmjLIS8zpEt
         hBT84MWNIIWL7+Zw3A2zCnYDEbIxnmNiX64HtXASM0tc1YgTLpUrViNAQkSD3JJgpdWL
         M4uMfpQKROPaj9DztMVDPnvNI9LGTHGycLYepXm3tOCENktXlTdbtxhENanjKHXYgJWi
         7G5BYUsrBrcEIzknQQACHGTFY+hPCTW6F+evnit4SFz4n1NqwdlULNCZZgErID01SNz2
         DZGFluKmQNEYFt08EW3Ar1PmNMvGwgJpHPuVy8zXE3mMtPTwR51lvNLiXMFn8Goc98iH
         CO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVS5t9HoPujjRBfOF5uKSoq7GUqsfvHIzifiKeva4q7Ohcx94NcyS7To6YYNKz1+7NskIPRxB7q4Ut+kIgLwE1/xj4i0dP2+B1613/8
X-Gm-Message-State: AOJu0Yz27XT0KorJJVAciMszEWFM7uHCAEWfLzphQ7mmt5iV22NEwWAi
	1Hju5hcCjp8bS75dVnW6AHJsablyDeiviJFSVDJn6AZ0XYOzZtmXj/oVJook+l/CawtWKyidvxA
	Fu4Ih4WNXM2gLq8eR2txD88yfzkSW/65PNalufQ==
X-Google-Smtp-Source: AGHT+IGcaRd6sE0wNTf5brwqh6uEfsgcd2adqk5HR7foXa4cbi/H4XKc5uZpDYOBl5AnAeJDIwb0k8wasAhdoeEBCOU=
X-Received: by 2002:a05:6808:1642:b0:3be:d38b:9cf1 with SMTP id
 az2-20020a056808164200b003bed38b9cf1mr26437127oib.35.1708607294524; Thu, 22
 Feb 2024 05:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221130223.073542172@linuxfoundation.org>
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 18:38:02 +0530
Message-ID: <CA+G9fYuprTkbvETPN5_r3TnJrKz_1Zq2WsVY4V0eYw3GH-OUpw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 18:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.79-rc2.gz
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
* kernel: 6.1.79-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 64fdfe5f1a1d3801ddf7c85d510f9531f4d2f6b7
* git describe: v6.1.77-274-g64fdfe5f1a1d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
7-274-g64fdfe5f1a1d

## Test Regressions (compared to v6.1.77)

## Metric Regressions (compared to v6.1.77)

## Test Fixes (compared to v6.1.77)

## Metric Fixes (compared to v6.1.77)

## Test result summary
total: 144068, pass: 123402, fail: 2349, skip: 18165, xfail: 152

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 151 passed, 0 failed
* arm64: 51 total, 51 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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

