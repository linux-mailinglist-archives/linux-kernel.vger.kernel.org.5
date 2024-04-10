Return-Path: <linux-kernel+bounces-138515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D01589F27A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400F41C21A73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA28BE8;
	Wed, 10 Apr 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixD4r6D6"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648E38393
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752731; cv=none; b=t6fyar7Yn4aPd63GLXvRJg5eOOhAIIJxuSKGLllTyWfkwM5A2Vi5VEubFhMIncmIqu1+862VOv5UEyhdPoVIm6DeDG9B50WpaYTyW3x6fb2CyRwfffTq27bOVdgzgE2XY8PCTwpaOzlD63YV7kJxKowY1fkhAl1j6j5UL6wZX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752731; c=relaxed/simple;
	bh=3yTKbpvVf/s+1knv6dgnitL9Vocg26mUcLvAPD0lXdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6/ZqJvy1sHT6UJqLF8c/Othy6SrOHzVrKtIYpuinxY+U2691oWNh2Db00z6QU9qHsAKV3j9BHgGbwM9Gxa64JpUSdl0tPdr+bvdE9i6RZ+wa5BXApn1diln47PTLDlLwi/gi2+x6dtPltmJttObtVRbartM3WymbCGac2pBhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixD4r6D6; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dad331b828so1181439e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712752728; x=1713357528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVxcRT7Lzw30y45VsmtK4BzB9fldSLT/uaJK59u+T08=;
        b=ixD4r6D6OSi4oEg3tS89LYUpHG0ZYbLCgnKxVpp/z5w6vtIVfJl3U7oiodpg4xV68E
         Oh9BOlIcP9OG4lPFR5mnkjpX6iV/Wwbi2DZHrxGCT3xDtnVqTSUKZVTL37exdxv0RZD1
         IRWmKpp2W3CTX2ZeoA90euJNZioaqHVJCN7trNJZ78FqALTdtfr0uZKKDZK1e6Ts6+AS
         qKfuK62OTxPJ0fbAvn6mgcDvvnP+dbiXwDrnkC+sn9p8rx9CWsDPzB4I4PZdHh330cSy
         EsAXdnGjwrHZ/2xAgQpkeASTSfrm2IrbPAtsIVwtzu1sV7Zp4JZ7uHVJxdabPjCkVo5A
         DecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752728; x=1713357528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVxcRT7Lzw30y45VsmtK4BzB9fldSLT/uaJK59u+T08=;
        b=CXbXfMaB6hb8J6DCZLEHS8SzlOzW4XaECW8lhf2vJZqEMkIE6T7u2t3te9WsvDVlny
         FPu/Cy1dSaS3V6QfQTR1EhXEBd82tp+dC6NwJDEzA7nc4ph5RHZYw5tGTYvQJkBeTkWl
         nXHYc5M9EAhhKDg4blk9M1fm5Y8aGQZtHxqu1dvQkrceqTnJpU+qX4WnT6wdN4zapJ9m
         3G0e/n4htPh6kglBpgrLJHhiwAdFUpYKMu1r4/HAHiYmLAPL8tSq3jtzLtYIePMTuuQV
         PJv+zhi5e0BcwFrLoIhtWkgrDJTAGyPuQb4TT4iMnLsAKCuDEXJD0oGuctTR5hy3aR4f
         gzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfJNWzEuxkJvOp8cd9ZEKLk4YGEX3B0N4cUMu+2pSIEB/F3ZW/ji6TzfRV/dRVYtgx3cynq85NmmGJ+y3v5jrzgjhBbS1wtbumDCa4
X-Gm-Message-State: AOJu0YzDdYhNj2Z7Xyp6TmdGEtSq4GCroDyYp5FOqK9F4w58mchNd2pH
	QZm6QmQDkMIwxCD1UIggB5ZKMK1hMWy92Y8wTEhfqLamK5i7wu1qauXj8Oa6WZ58S+AAyUZQh+n
	qI1TeJ6gN/V57E+b8X4JDXcfy/p1bMac0OkormA==
X-Google-Smtp-Source: AGHT+IH8Soae4l/U8nIkJuJIst/3/d3ollcdeT9RrOYIH29K741jYt5lXaX4gmeyiWJUUx9vFdiCPHAxmYu1GJTJFbU=
X-Received: by 2002:a05:6122:4584:b0:4da:9a90:a6f2 with SMTP id
 de4-20020a056122458400b004da9a90a6f2mr3185975vkb.10.1712752727993; Wed, 10
 Apr 2024 05:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173543.596615037@linuxfoundation.org>
In-Reply-To: <20240409173543.596615037@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 18:08:36 +0530
Message-ID: <CA+G9fYtq2yX0JeP+JKE0+UJNG2=2bYSvAOF4EqjyOFaFk=MaOg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/280] 6.8.5-rc3 review
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

On Tue, 9 Apr 2024 at 23:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.5-rc3.gz
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
* kernel: 6.8.5-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: 6d08df6c401e210cdf4959cc3249188ac6083489
* git describe: v6.8.4-281-g6d08df6c401e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.4=
-281-g6d08df6c401e

## Test Regressions (compared to v6.8.4)

## Metric Regressions (compared to v6.8.4)

## Test Fixes (compared to v6.8.4)

## Metric Fixes (compared to v6.8.4)

## Test result summary
total: 292298, pass: 253708, fail: 3764, skip: 34460, xfail: 366

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
* ltp-sy[
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

