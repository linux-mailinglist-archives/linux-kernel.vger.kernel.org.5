Return-Path: <linux-kernel+bounces-103428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33487BF38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B320B2062C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93071724;
	Thu, 14 Mar 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM0/JHWK"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675770CD0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427444; cv=none; b=W26wLUCH2hj4xgJ8fdVDoJ0yZJuNhoCJv6fQ+G2lc3i/zjz4sMaqo056uWaaWcaRF01SypoLuqo6zb4l5gxoBuiaY/0wdEWSSp/xBoeDM1J+n6dyJ3udFr3SN/JcIN5n/e+GD+sQpXIMpqK3geCpVnN4nTvqgyxknEexOoZbpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427444; c=relaxed/simple;
	bh=KaUZBuua3cHFQbB5Ar3/493ogtAjURGu62Zg++T1rT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePCTCBaYYkxNy00e8VVBGzg/tSYRQoDYDQ4vFi4WbeJmffv3Vhhn/zMv/2yWnWmiCvoPoENtIQZC5Husm/NMmkNyr0Y8JBvAWwgJPV+YXQ1ZhOXLeO0eKIdpD3sA6khjPWuw6mmXex/IusXNRvKCg18+VXB94hHDnitve6ITYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VM0/JHWK; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4765c38fbc0so46435137.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710427442; x=1711032242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ0vhyV53szTb7w9jaKeRoeaQJrtq9vkjVfIvYSP66s=;
        b=VM0/JHWKFsse4yFnhfn9re+/OB2NmIwD2a4pZdSrldOwFkLM4Vol9lU2JnB7PuUmCh
         ygm/5o5HlFfg40J4lBTXoUxuNJ4D7ClQ0lSwsLmEB8lt/ls+Oklniscff9mbg914wstl
         9tKplTQve+47F+UVAWIh6RGE2gaV/0dPELa+ENMZatpOxgYbvI1pwwBqG8OyEWMko4f/
         wdeHDnNXqa2bzHnPwvtahDRAgRTxBTMP29Qh06yjx2wWM7qm3kMH0gcSZAD5lviDMrVL
         GP6k4Jd9LYirceIDR6JxSJPvKfb3eNVhfO8imcsJ75UaieSvX0XNtMMULgLSg7ESq5Rj
         gXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427442; x=1711032242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ0vhyV53szTb7w9jaKeRoeaQJrtq9vkjVfIvYSP66s=;
        b=gxG1xD7oIqcnNiPJmSYEp3PSoXXeC77IY+c/I6Aw0pJZwMt3kV0TEWGWKBI9wib5CQ
         XDPpFiRCH4f4Y68qqEUINSdu4ofCg8ISRoyLo08J6Ke0+3ZMEne43WAAJ1XHZ1Jw/nh7
         ZlMDMvckdXkwmF/eMM3J62vZqH2CSk2+acKCyi9Yja+MWW3na+EcnCz95vGcZHRdoLTn
         7AIMcq0YkuZKMZZqkItIpgOBKE+oUgQuCx9m5vpuAxJVGC7LGhdGtievxljJHV0nP2wS
         D39WZ15l+xM0Nzvo1QxjM/2Xf3KbzL0NjHnyh4sBxjcYIdLe2zHjTPLBC9cHQaN7SNAY
         d1Ew==
X-Gm-Message-State: AOJu0Yy4Jqjf+xgDnwV9TJhKhGWQg//eolJgsQoYSox7shueYMvRpkmv
	n+ozi3VC4Kuw6PGBcvERxd0Dpim4l7fr5sknS/zGetY1XAHn3kGvR223deXFRUIOqI5c7JPVRTT
	GEdrCS+B4+unGwxhgLexN4WM6S9drHNk5Hk4jOg==
X-Google-Smtp-Source: AGHT+IHrDEmKBBSZm1UaOFIh4tK9joSM+T4Gukm59QEKWw5UvFiuPJmEyQrdMHtQjI6fYkqOr8KrxPSvl9VQyRckVlY=
X-Received: by 2002:a05:6102:21b2:b0:473:2686:3105 with SMTP id
 i18-20020a05610221b200b0047326863105mr2023283vsb.19.1710427441890; Thu, 14
 Mar 2024 07:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163957.615276-1-sashal@kernel.org>
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 20:13:50 +0530
Message-ID: <CA+G9fYuUWKU=T8DE7=v_h2GXBHnkfPArr5JSQnG_WonyCNWNxA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:10, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.1.82 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.1.y&id2=3Dv6.1.81
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
* kernel: 6.1.82-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 27d7d4053a11de9e6fbdbc6b6cc3f8f5937e4f2b
* git describe: v6.1.81-71-g27d7d4053a11
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
1-71-g27d7d4053a11

## Test Regressions (compared to v6.1.81)

## Metric Regressions (compared to v6.1.81)

## Test Fixes (compared to v6.1.81)

## Metric Fixes (compared to v6.1.81)

## Test result summary
total: 134217, pass: 114741, fail: 1989, skip: 17348, xfail: 139

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
* kselftest-kvm
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

