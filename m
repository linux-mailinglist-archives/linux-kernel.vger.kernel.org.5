Return-Path: <linux-kernel+bounces-66441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1D855CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B86728812B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF913AC9;
	Thu, 15 Feb 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6gFcjhR"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68566134CC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986732; cv=none; b=s7O8w0GLi+QkMvWo1M/qntzu2KMJ6V9PLi4o0Wrk6PBoPkP3wcTOdAH7nyhFGWsBQZoPK03Dl8IcBfeQPMh/5EV+LKIK5UPjp9j2K9+qko8JbO3dlpZWdcJrySpdIiYPvo/arSy3c8uDF4OFX3XD7y613bTyAHotLXnqVfUuobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986732; c=relaxed/simple;
	bh=x0Tw6BNK11EGdmc5ZGxRfDLUmSeE8Z6xhgnpSMVoYtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZrs5Hvz0QXyAMvjgmX5DkRGhm+6DOrNn/50sBs7FtTjFS0G/hKVHy0PqEIL0hHwrLX0Jv2s+Xh+rSJEuWMtJrQLBwjVzoxJmCbjQhweSKNgZ+bDUEn2Tl/bCsqoBxONO+kLW4uxGWHZqoUoWZ6Tp3GENh0ggQlKPFxeXUvcHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6gFcjhR; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so337640241.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707986728; x=1708591528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x8+nXLLVCvqxzw2c9wjn6NCQJrdXn/C+WdlvHqn43s=;
        b=y6gFcjhR3ek62TDjgHkHCAPKcpUeHbFXy/SZRJEOJnhRvIyLGDFnNTWBjkzpkgqCF0
         YPtgWBbBgt95hPsdZHpLibypmHEZy08YyF2lM6wKMo1PGGZ11VH3TcsGU/3V2H9fLmWR
         BsAIOjj24BCwrhoQ4A/hsWoE0pDlX+eFYIdfY7eRTFTfWKX8wgqR4LVlZn6IeOBwf0rF
         W97HMjHVsvq13TqwbYdjDb5vFAPxgILrxuoPCPwrnGtfhsJRKzop/wge7Wu0EXqVZojE
         SgMNOo1vh68jOClryH5ZQzqik5BYKLSgbWEgxtMIwO3p2MRR8O25dCY9DpqO6AU7J/p0
         j9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986728; x=1708591528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x8+nXLLVCvqxzw2c9wjn6NCQJrdXn/C+WdlvHqn43s=;
        b=f9veqH67KvHnB0ZLasMU6Dck/gJhUCx9b5QcD8Sp+sZWIv5E8ehmvl2OjQAJU7GM/I
         iNBDiJVY5Co2nz/f0k4WdvssecxzF7UVoWFRm4GWtAvOtz8R3yAA+RySG+HoSDJsz5HT
         nYNVQmAXoHqDe72SvRLLQLFxfheYqbyz4pvSf+ANjvqRsDN6oV74hvVVQf9yEh8Fsh/R
         LTiGNQrtb8W/qCwUMa2cUbn25qFWterTKMKRs5+R+91Bjpd40rxPKdWju9i89mv9ramK
         OwITbxqmKSZXFjPuDOt4kaygg8xTkeegRmgyHj4cYp7MKUqslUqAMpgcjPaHZX0ppmq9
         qpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQ+4Zbg34wy09IYP04OXCxGTgpjGjXHfb9Sv5GNSPDyymjMmhyW5F8GwB8Miuwjp7mg7Q6kX0UkXvH3CQtb5Eg8rFUhyudJF+XKGu
X-Gm-Message-State: AOJu0YxoWPqWDX4EOPl/zj/F7fEJQFkV2lJ/UsLaIzF4MUlYHgj5HW1S
	TPHHPXPq2+z6EP0WepkiifRNQVrRqBAQywwJ+0sQdweifXXTaaLYsmVl+7L+zjBVPML8zEJqazq
	qSleJgvK+qbeLvfGoCuzhmOLSaD9uibLGFMBwAQ==
X-Google-Smtp-Source: AGHT+IFNWJdaAhQzckrGqOsKbWuM1nCexSm2uMnTOxJzkJyZSa1i/i1yEuc4m0ViYJU/94nEC61OEU899J5XPGpQ6/w=
X-Received: by 2002:a1f:ed01:0:b0:4c0:263e:bc8a with SMTP id
 l1-20020a1fed01000000b004c0263ebc8amr1035101vkh.10.1707986728180; Thu, 15 Feb
 2024 00:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142941.551330912@linuxfoundation.org>
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 Feb 2024 14:15:16 +0530
Message-ID: <CA+G9fYt92+z5kTh3LUYiu5rNgnMyMe=O6Mve68ZrfsQ6TR-y0A@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 20:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.78-rc2.gz
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
* kernel: 6.1.78-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: ea6a03790c420fec42790d8c5db2e81663954186
* git describe: v6.1.77-66-gea6a03790c42
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
7-66-gea6a03790c42

## Test Regressions (compared to v6.1.77)

## Metric Regressions (compared to v6.1.77)

## Test Fixes (compared to v6.1.77)

## Metric Fixes (compared to v6.1.77)

## Test result summary
total: 138874, pass: 117646, fail: 2876, skip: 18182, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 151 passed, 0 failed
* arm64: 52 total, 52 passed, 0 failed
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
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

