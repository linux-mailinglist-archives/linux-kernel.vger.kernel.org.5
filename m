Return-Path: <linux-kernel+bounces-142845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6B8A30C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9CA1F255E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBB13D615;
	Fri, 12 Apr 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZbbvnoH"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3713C9B9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932504; cv=none; b=senjR8fXf6PvmWIwz6Ax3i5naNcp9YqpGPo5YWCuLCDF56pSqfJt+SMcpEfXDerWKcV3hQAImiwbagZXQqY1sdek2M/Yhsbt4xEGOiIIGdt8oXDfOyHfg7zEOk+Ik2IRi+b3lqLZwt5wyrb+s5+95hYIB115UMMY3VJ3o7CdIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932504; c=relaxed/simple;
	bh=wUBzQHUwt6/ntRQQFcRF8kQGAiGeZ3n4cxtkIT5qrtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf1KWqWnl2hKWe/lSLQ/Lsp0vehYJFQczqusxI6nsZ3vNjQfr/eDpJJpHDn/CU2my03w/dVD9UvkiSFc+dCy0+fXNIUtXvxbHs2CXC4eh6mRfwTBHDNBaoOQtfeHJ6QiI7WXIG5etyt8K7+hO11pem4yh7gU3UMCEI/wfzX0zcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZbbvnoH; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61518d33293so10920307b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712932500; x=1713537300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgOXnMStIHN46Kz0NUk8tixwh+qg++oHVyRP48CyUG0=;
        b=iZbbvnoH0NKSiD1DwLDnt4J/0Ph+08TeSM3rlNCd7j/tmGpvKAdf4XS2rlKIiOOKK5
         ROyjs83tnF/82uOW8cUXhme94oQUkmYQp27QbroJ0v9rZFT1eDWeXACJMJLRwAaCF/dK
         WPsC+PXD1p/3C0gDt/yNJv0Unucs5yAjUAYF3zEd+lbrA28pufWqW/IOXqt065cGPUP0
         xyeSwmQQ0evxo1BNverkv3sVRu/nm4J0tLLshmMA7JCCK9nya2+22xYO/7zwOUCv8kBV
         c2wjoRhygLWIfJXMkKGunAVtRwIRQXy3nnG/NiOQBBScgPWuphhcEtEKw6TymetugwDf
         +zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932500; x=1713537300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgOXnMStIHN46Kz0NUk8tixwh+qg++oHVyRP48CyUG0=;
        b=ngGr+pgLl18lgWndD++Dg7JTLJ8u4sFAFYB/DCe1nCdlgiPHAkNLFhF1mlDPK2eYGb
         oQ+sVpvpgqj2lJcSxlIzOZPceqBaSKTjnpb7fLybUuxDt57RJV3gb8ar9R6kfKnFYV3r
         tqNeNYxZiU7/JjFkYzCO//74GQ9100Moq75n+uew2Mgfy12MMg0UaiVWZ0clmChIGg4i
         bTKzlpAPqr9mic//3D46mDHWhZaCDsr2h/zju/C8SU4kkSIahYke4M7wB6mgcaExwrtm
         Rsst8ChREkCnxWT19jltz9xBfmkadepqhxgETXh9Y6RUcAyXnW9Yv/JCSpTkzqRNKk3l
         s9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuhWTuZ/Tk5tqV5DGqc0zJNDc6c9TY+l7d4HpAg3aSjzIiv0WLnKziljyCBWU7L0UadBcCag4fL06j7rHXZVbKZ2hUWAaqu1Wyfwmh
X-Gm-Message-State: AOJu0YyoXeGFLue1YQKqxaYAvoCpl8bgdUn7QPemCIiXO4k9fl28LXAm
	Ll1jAka7nvb3n0KKtYfW3nUUyGfWeLFjJZpz8rVoHYFsZd7gHGrSazvxmAC/JCE8wTKknKQT4qe
	peV2xfjZTEzB1+lnwbsaUn1KtMVm1Gid9L8LNHA==
X-Google-Smtp-Source: AGHT+IGWgdpQEtJQGF8ZxvJHuaPU/CK4HM747qSvcp3vgE/92uXTsfu0SYh79YYQKRBfOo0jZ7dzfc9EO8OSYl+Z2go=
X-Received: by 2002:a0d:cbcf:0:b0:617:c543:35b3 with SMTP id
 n198-20020a0dcbcf000000b00617c54335b3mr2720478ywd.20.1712932500628; Fri, 12
 Apr 2024 07:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095416.853744210@linuxfoundation.org>
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 20:04:48 +0530
Message-ID: <CA+G9fYtSkL2ru64oDqd8FSDrDSe8sjWSF__S2usLq3nhricOpQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
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

On Thu, 11 Apr 2024 at 15:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.27-rc1.gz
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
* kernel: 6.6.27-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 3126167a036c76b2c9a53d19f7387cdcaf2ffd19
* git describe: v6.6.26-115-g3126167a036c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2=
6-115-g3126167a036c

## Test Regressions (compared to v6.6.26)

## Metric Regressions (compared to v6.6.26)

## Test Fixes (compared to v6.6.26)

## Metric Fixes (compared to v6.6.26)

## Test result summary
total: 242107, pass: 209368, fail: 2761, skip: 29712, xfail: 266

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 33 total, 32 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 35 passed, 2 failed

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

