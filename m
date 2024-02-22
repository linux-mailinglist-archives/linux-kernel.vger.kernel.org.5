Return-Path: <linux-kernel+bounces-76401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9891785F6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2842829AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6340BEE;
	Thu, 22 Feb 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXnw2k1D"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124E208A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601091; cv=none; b=JM7T0KAijp5OXoWpjgk9wtFsjHPFH6gW7quLk4iiMsV5jmUcATAwnwZQQdMsEPRgckBVzmlwaw25IgrwUCNXepoGHHMt8KktZiTatdpZe6/6sAbonw+vrW+BIUNbZtKRc+WMwKMIUMCvz55GYJcm7o6ZhQPgm/N47jQhn2lVztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601091; c=relaxed/simple;
	bh=Xoz66ZnLQBbD3szTzDiV6Z+dB78Qn4Ttq5cK1iCbsWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8U/z34TcoqizgM/k3H3UuR/kMFMRY4AKSYZiOWRhol0FBmG8EI9PL2SYuo0MOGOzowXGgBm4tdbF2W1K4tcUFiySZ0RHp4+8BDNU/2SLd/7OlF7G2/WhPbOmEuTgQgbhabXn7UYQxuDfntCuJG470ZdOH0cP1aw7lhMwG7Q6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXnw2k1D; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4704c073becso415136137.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708601089; x=1709205889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiAWGn1x9YRhT+FJAFJSfVRs08+14Yiub1Es4TlGy6U=;
        b=bXnw2k1DI/O3Zq+Ye3oh38sHXrYKtLIaFHQazBouMQkMniIzZLz6DQSXfSoptNEsmd
         2N9e3/Lvzkqa/v+v0vg6VlYsD1dj6zbffoYiSM68+MVhUYp7e0DrnFHKtyBMTy9LU5DL
         I8q6SrAl15UF8HU7qhp0WV7wrged1ik4ngeDjvOMmUq5I0ifa8YYTYiyRh9i+e+edt6X
         fKcSHn3bY8AMvGBkIfmQDDKXPPeXVIxIt5DADGQMnk61qhujx0sR3w3Tqv4MMwvHFyFN
         L2lKT2l5BUzBi+UJPcEfyqGYAP6hEnvJRVL8iXBiKDXjmu2sXKcRnk/yGj5kl2eFwaTm
         dFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601089; x=1709205889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiAWGn1x9YRhT+FJAFJSfVRs08+14Yiub1Es4TlGy6U=;
        b=STrPgJCFv9VMORPxeLL6nVTRiuHGcSG7gv9CaG0tDYPFRTYsTtM4aTkeoQRP4TwPLh
         22wPKBWzHt23+IN2zWoBDlusiRg/lP64pprYoFpH8lSMDdKjkFvYqjPb10IhSaQDVI+4
         gvpQ1UJM4JVv+v0uh9Ox/0JrshGnL6+BLMvPy54ZfNM/M/rBrbkWQpt1MwLzEJ5my5VK
         F/eNRbrW/cUtTrfl06vrqidLiA69wJJrWO/3ZKKh/vQGvTdfpq6ukFKIgkD9pVyN7dac
         4BTNtXeLOjBgaSSey7zlFYgMcHRjvgl0RZ4bohvCYvcj99OH/RuuOjlQEWUhFdJ67nZ0
         rjUA==
X-Forwarded-Encrypted: i=1; AJvYcCU3MjXY6lqJmtVMi09lXfXdnydrpgf28T//hPb+L1b100o4ZWzNXbPFhManXwRcLAuYeDq8SizSAxacmu61/1Fz1g7KzfiisHODs+dt
X-Gm-Message-State: AOJu0YzvoQSGxLq4o0Ys5n6y/ZSmvWRqTDhdWp3rOUjw5xDOCgEg/qG6
	A8PROaNEyIFXaf+WoKjzEQ+z2gnS3vJgNoAzIXzWM9nsz6uDCqlNqO9Muy5NyZPRrbGFNPCJWdd
	EuQOFTp9Jg13bw0nS9ZxYGa+31CD/nP+QD6djKQ==
X-Google-Smtp-Source: AGHT+IF84OHokm7fFAzmyD+f0oXM+AwVxJ7Hn3QG/81nxJxFKr2eRnLqowU27o5dQZPEH439ofSxJoCmCTm3bjLAck8=
X-Received: by 2002:a05:6102:3566:b0:470:3f15:f1ae with SMTP id
 bh6-20020a056102356600b004703f15f1aemr17161493vsb.10.1708601088993; Thu, 22
 Feb 2024 03:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125951.434262489@linuxfoundation.org>
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 16:54:37 +0530
Message-ID: <CA+G9fYuP26S-mLjBqzT=y_C3gXQFhWbz36v8kBs-rf9yAKm0Fg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 18:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.6-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: 028924d29f01deaa6bfdb53b7e5408948c909d91
* git describe: v6.7.4-443-g028924d29f01
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.4=
-443-g028924d29f01

## Test Regressions (compared to v6.7.4)

## Metric Regressions (compared to v6.7.4)

## Test Fixes (compared to v6.7.4)

## Metric Fixes (compared to v6.7.4)

## Test result summary
total: 252135, pass: 219505, fail: 2961, skip: 29354, xfail: 315

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 51 total, 50 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
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
* kselftest-kvm
* kselftest-lib
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
* kvm-unit-tests
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

