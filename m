Return-Path: <linux-kernel+bounces-51805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA86848F79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41523284F00
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1C241E5;
	Sun,  4 Feb 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKLx2qqn"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFED23753
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065886; cv=none; b=gqsgziqfwM/5UHfvFsxU9G6O+iyV4dL14BDjoRwOMsk3OHry+BPB6mIMJhMU/DTiNkKcpU1D7zb2ox7Adjw6paLTNk5wo1E3ge0dm+KM/CfneijpZFJGrj7flFx1wxxDvXV81dKCZ8ijHUETrlqKam6keqS2+l/vN2oCjyK2TLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065886; c=relaxed/simple;
	bh=IuTP+J3Y35zedBXGGOlbZsgbiGFUnU5q+tKuIf5u0v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAPkzH7bkSvkS7b82fJqdHAhUAHU2/dNCN5FX0rcaWHo7BjnR8iDyiLcrawhVu29lhqW0QB7ImyZqifL/3jNUYO+v1RV0n43vltAeW5WmZwT3n4nCpeUxUbuqfsT3ny9GE+J405QgLM2vClKI52FNVf0VYVZA3hkdpFgeNTwn88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKLx2qqn; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso1856388241.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707065884; x=1707670684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8XvHeWqXLXOzR1av0qUjRtuCxZWJXJt2cLmpLDy0zg=;
        b=rKLx2qqn5bThs3TF9ACodgF++WV2jXA5jSQl2FgN6tGzOEFtoOwsJXxdseBzCu1P0t
         ggMtTMyhdOLkL+JIbOOQSBMHw1v54m/x2vHw/kN2g5LmdXSWdaauE07a9EoSiY45NhNj
         qb2STjUyvYtMOajA6KYGKzLIGFandpkjAUm9KOJGR+1D3YuB6BksUe3AgAddsXQtKT0p
         0pYWGyFwgmyufmxRsjU0/YmQMSiLEN/OfopX2oKF4b7E1FMcHA+wjc3AbqB3seCfTfW6
         3zibCaTS0eUu9FKMyuauGA5y67oHnVlt3DR32lUes4lg1Z/Sp+efFdM6pR8LIcw1itWL
         Wo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707065884; x=1707670684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8XvHeWqXLXOzR1av0qUjRtuCxZWJXJt2cLmpLDy0zg=;
        b=ZqgFWF7VSyPd4dDR4yIbo7yFY3NZR0rJvgcjkCAp0rWyaqaoA1uKah4IOqja81eZh3
         HE1p1UpxqJGhngyzxJuy5ZE/0hvDjpGaWp7eEHHPDYqc0hpXCy3Xut0i0RvP6iVSrvrr
         MEjJNeLLnqzgRB6Q7GLvTuDcDNrRM7nfqi+qhTJPmc2WybKdRcH19cabqLW3Gnfe6CLW
         DIPrnVIBXzX7WsdEB3OQ/FrMcDIsxTVHJp+ignBIfr5LATJv+53lJLfzoer6epsJMtSD
         vjw8tR85SnUyk/5f+bx/N9xIT/r+Wxd4QR4TM3WV/prtaJXRQa/RSsuP4m+ntAJwBWWN
         meig==
X-Gm-Message-State: AOJu0YzMi8+jK+/ArGSZenrPXA8yfgp3nZxXj+IjusXJVFINWM78+UmT
	FzZ/soC1M/Lackw13Y0+p6mH2Wfp70LY6245qltEKfLpFW2dsmhHCRKSKeMiX/nGZYTkbSWhGoo
	MsSMUU/9+rozQaDnuhwvjwnsSmYWIk1IJEnycnA==
X-Google-Smtp-Source: AGHT+IHEsRB/Mqs/FoDCyqXrIjS1/UK0qIRnrPqn1MRy6XCPhqYEdBs7AUMEkpcSt6P8sei/I7o7vPk7kXgzFvNQ+K0=
X-Received: by 2002:a67:ad12:0:b0:46b:3a27:9895 with SMTP id
 t18-20020a67ad12000000b0046b3a279895mr12110278vsl.14.1707065883820; Sun, 04
 Feb 2024 08:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174756.358721205@linuxfoundation.org>
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 4 Feb 2024 22:27:52 +0530
Message-ID: <CA+G9fYt2je2FKwdgm31isfxF2xm+HAZ-+vfwmiXhS2SpdBGLFw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Feb 2024 at 23:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.77-rc2.gz
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

NOTE:
----
Following Powerpc defconfig clang nightly build errors noticed linux-6.7.y,
linux-6.6.y, linux-6.1.y and Linux next-20240201 tag.

  error: option '-msoft-float' cannot be specified with '-maltivec'
  make[5]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Err=
or 1

We may have to wait for the following clang fix patch to get accepted
into mainline
 - https://lore.kernel.org/llvm/20240127-ppc-xor_vmx-drop-msoft-float-v1-1-=
f24140e81376@kernel.org/


## Build
* kernel: 6.6.16-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 8e1719211b07ef9172b231100722f54ffc23ed27
* git describe: v6.6.15-327-g8e1719211b07
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
5-327-g8e1719211b07

## Test Regressions (compared to v6.6.15)

## Metric Regressions (compared to v6.6.15)

## Test Fixes (compared to v6.6.15)

## Metric Fixes (compared to v6.6.15)

## Test result summary
total: 155032, pass: 133733, fail: 2219, skip: 18908, xfail: 172

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 146 passed, 1 failed
* arm64: 53 total, 52 passed, 1 failed
* i386: 43 total, 42 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 48 total, 46 passed, 2 failed

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

