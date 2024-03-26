Return-Path: <linux-kernel+bounces-119057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DE88C35F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05972E34E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC37442B;
	Tue, 26 Mar 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWooAFsu"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8A21A0D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459735; cv=none; b=bGNSWhnP6Eg6mK+qtTQMJV2jL1dHerL86uYs3AR3GefkdmhpTAUS3EesyT+tsmpTUdEh55BalhsHEadWemlz1OM3Cums6FdMAqWDwvG8B9AjdU/GKnJw7Y8tc5lYyCypJ0GeNSNZczwRQCUmkksluX4pICfD0BopA/fakPhnYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459735; c=relaxed/simple;
	bh=Swj/95wS2gUtQFGPSA7/zzcTtPt6bJNQghes3qZ27Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgXrL91RgruGj50qqAJWoPx5V3jftNZVwPcXpS+56Kx2VsMLshoIn19d923qDuJT6n1TYZZ/MVNDXf13pnp2ad4SZYq1mnTZ4Gj91XqvXBml0thD39sZo+5oWdbrOPadmKH11MAavKgLQcC+0lGhK14UmrBJpHDGPh06lkDRYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bWooAFsu; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d42d18bd63so1384732e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711459733; x=1712064533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjFwqu6+3f07g96CRPO03syfjozezYZEWTppALvkfKA=;
        b=bWooAFsuzUES+XIQnwM96jgqopbPOaLgjsM6hJkwLHtGDOhq1Vsjhn06GEdtJQnW+E
         S4xOzJqZgC+8Cj4W9k2XKkxU9DMBdAN5XCjrjtLEP8mff//6gwyswjO0wifeJt37ZB9i
         nJSkbXWSsTFM9FsTWOeGMpzYYseuOmOz5vrHhQV3tNdVBUKmazWjyRQ24tWwWL6Nw3cf
         dWx2l6+n7bBVZbqlF16gfUhiSaS2BnEO7z7lmJP1euLctcV3AUYVXo1mWXMNUp0XrhtK
         piaBfrsqO84iyAINNv6iJVDzLQEUEyj/YzHXw31H6tNr1iGsJYm5RivAHjTqGjjVp1qv
         tr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711459733; x=1712064533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjFwqu6+3f07g96CRPO03syfjozezYZEWTppALvkfKA=;
        b=naFJ5Ic9S3cCOkgB8cL9GkegqrHAaDHVpzM9uyn6SCXdNhR7bctdEQ9cz2mRz1kFK3
         MqozhT1cxeUGSvMxhFMaa+BqBils/DotzcnMoUUfHw44n5B4bXvkdCqRugQCY7YQKdau
         gNJsWMSANV907QnghqkD6KEOMyIj7Op1EVPp0hYdJUKkC3bMhe/wm9UMj+Ea7Exjeyqk
         5fDCkS1sHFqzPdIravYO55B0bsu7BBwuMKeuJzY/LPuJJgUOG2E3TKEh3bYQ84Jx6nSg
         FirejL84as45jr8Tzn6BwN6NRPCBKYKwJMiRVNgKATTFRBKdY7kmDgoKgxNi5S4AJfPE
         5Rrw==
X-Gm-Message-State: AOJu0YzEawu1LGTfL53RCltmXkyLGUMTU6tUeoVTPrT4WfAj2j0H0ylL
	sgHf4vxbFlNHut3CWbhh5kKw49Ro6r37pZW3/NNfYeh6lU/SSvIy13af6MCjuoFVtlim/5GhiLH
	RwDAONT8SW5HtbnPrTwEPVlW1kuHA/a9pA91XSg==
X-Google-Smtp-Source: AGHT+IHXCLqpoMAW9fF8qA/TBAvi3Oul8k2IEjY8WDO93+loax+v4Qjb7StP1j9MmJ88oJxPBV+gJySh09PiquEN2F4=
X-Received: by 2002:a05:6122:4c16:b0:4d4:19e9:db0 with SMTP id
 ff22-20020a0561224c1600b004d419e90db0mr6478355vkb.0.1711459732681; Tue, 26
 Mar 2024 06:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325115939.1766258-1-sashal@kernel.org>
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Mar 2024 18:58:40 +0530
Message-ID: <CA+G9fYtMXdJ_csKhi1VuxLByo0tXyLM-GaOORhmE_tNdJ+d8Yw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 17:29, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.1.y&id2=3Dv6.1.82
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.83-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: cfc80383a3dc406b53bfbbee423b2d623b17b6e2
* git describe: v6.1.82-444-gcfc80383a3dc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
2-444-gcfc80383a3dc

## Test Regressions (compared to v6.1.82)

## Metric Regressions (compared to v6.1.82)

## Test Fixes (compared to v6.1.82)

## Metric Fixes (compared to v6.1.82)

## Test result summary
total: 120554, pass: 103236, fail: 1870, skip: 15328, xfail: 120

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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

