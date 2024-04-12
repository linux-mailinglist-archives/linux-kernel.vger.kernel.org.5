Return-Path: <linux-kernel+bounces-143191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE028A3582
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A985D1C23F96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2314EC4E;
	Fri, 12 Apr 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8awwXEf"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2A14E2F4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946101; cv=none; b=ItjgsfUbkJ177kLbN3LBi5TJn6ATS0R8rtm0JfkPS64k+e/QCvZaaMsficFqitWx3DLE6RbLZBK6RDDM65ItXSisLL32AoCJVavWUVZuOUCE6XubKJkad2QEC3ADW8JJZ/2UFZaEq8qaju2liuNJNBQcEqDr9llI/HUeoDnXlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946101; c=relaxed/simple;
	bh=bJ51FuL6Co1Mvav9Tm57dra4xYpo9kkvA2sBvujP7t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3hVwAKVBeaakoB4NaCAdP83z3tdGxm2e+DPuOQVZY4ioKFP6DzjhH4GcZ7utHBWUBl9EmN/8xtFn6ljmfKzr++EOOOOMe1WY0Z3Do0IafS4B+JMnnZRs8G3C6fFwf/W8Z4cF1IkCTRKLnJKfEJZ+qXn2EmUfggBYvSzNeQ0FO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8awwXEf; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dac3cbc8fdso421595e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712946099; x=1713550899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbDPWThQzRq9g92/UgIi+4fZJEEp+6vDg7Jtw60BICE=;
        b=O8awwXEfFKatVuOOJbOKwmAPCgy+LQPACRLuhaGVTaqUuGX6bM/Wi+GNJtJJtUupZm
         4ZCind3vtEUHnX23jRWEOSqzVYePv+6M0XS2p8wfWm9q2FsUedWW7Y71WqPonkTtD6XK
         q6gvyF5RfOB0KSyz8rz6eTMXCq7NfpoHA7FGNhDjV2Ma26Q+zKfXEV5qDEGZLlJwllkU
         Ayj7GJhkULgF2io3uYHEGxJQwNtf8ZLH/6cA9tF2Bhh7ag3M8WGNgXdYVob2uo1sY0V/
         GpU5Q6zCWdRoQ93g2AXJ4kZ0GQPnjpm357tqqqn8A1XSVlgcjXA/yhj8ElJuwLmwwsqy
         DuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946099; x=1713550899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbDPWThQzRq9g92/UgIi+4fZJEEp+6vDg7Jtw60BICE=;
        b=KXX9nSkXDbgNcjaC9SwxGprb4yQqLCpwztNIztrVuNqxyrtWxBIuEmp7Kvc60xOuvl
         1pfT3gy9Ox6ejRN8sqQGmVzE6SUy6n+Nuegu00qRAaul77TJcNt9IuYsiaFYhF19AlWT
         0FY+BGX80Xn5muX9ltlIukKdB3Swd44iYZN1gOJ3Yy4F5+ZCQ84bLTf0OrfCQxWbEqyt
         nnamaxnluR8Jba8SDvnIz06f5zaVIXxtntDMg9V+tVynYnuaHdqsrHmV27S77WqH1qEq
         YtpX/6YXW3qJmBLTyWguHMPXe/GtC/zMeLJStMjhTYuKXLxBvCR+hs8f5DgdSbvgEkyN
         VxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWFieNhaIwnZYN9E+WG4Wod+WV7bzsvrLqtTKeDIQLiFBjFzYCpIWWIew1npHHQ9P3TuFvTRe6MfVbqVwzIOzSJN2NJY/aQYmAQZ2w
X-Gm-Message-State: AOJu0Yw7xVHQ6mZsrM8kkhEOGtxpAlnz5uikJKCy+BIiN3F4969oBuzw
	57KJwq+F0t49P2AYESnadcTktFUi4nR6pMdHBbFpW/YduOFPiL+kO9jOm6G/1A/jyoaRyGDc64r
	gN56XpgtrgLyZ/nguzSYajcRjUCfeMHX1effKFQ==
X-Google-Smtp-Source: AGHT+IEWTmexC1lyQyj8nblvpkomiMU21LR4uV66KPXALKUABBi3nl59v1u5AmJSfB2te1zXvgt/nYHZOk79N3+wErE=
X-Received: by 2002:a05:6122:91d:b0:4da:e6ee:5533 with SMTP id
 j29-20020a056122091d00b004dae6ee5533mr3632426vka.16.1712946098707; Fri, 12
 Apr 2024 11:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095420.903937140@linuxfoundation.org>
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 23:51:27 +0530
Message-ID: <CA+G9fYu-PyV0tgQyypQttEL-6k+jMVvVWVNAC9a=fu3VygJi5A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
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

On Thu, 11 Apr 2024 at 15:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.6-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: 1e41d76814ede65e1f73876f3316ea0f9e8aacdf
* git describe: v6.8.5-144-g1e41d76814ed
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.5=
-144-g1e41d76814ed

## Test Regressions (compared to v6.8.4)

## Metric Regressions (compared to v6.8.4)

## Test Fixes (compared to v6.8.4)

## Metric Fixes (compared to v6.8.4)

## Test result summary
total: 289169, pass: 251149, fail: 3767, skip: 33889, xfail: 364

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
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
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-co[
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

