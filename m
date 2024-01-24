Return-Path: <linux-kernel+bounces-36852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1883A7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365E91C21A38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5D1AADC;
	Wed, 24 Jan 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gI46ybv6"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3431AAD4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095523; cv=none; b=BEr9JJIVf4Nlbt9DJeoEir8ri9I7pC2svsOk+OGJKr6mSf8n9aD3PGoY6TaCTthvSAdUDJsd0JVHW4C1NDCrJOIeqZUF7FUdtFjWD/+WOnrIIm05WIFx/01rnijg67fg9bj0kssXjNe1VROoqCqf6VwhWdTO2li6M5VqZR4Liok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095523; c=relaxed/simple;
	bh=Q/fSTePB+3gjdfutjWEwnj0KX3hxqkjjqVpjDkIE8t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riGg7cH+LCR+rn5W2/rV9qyQiR+26cxH3t7msSgaiASkk2cEqURVnSyvOinmadeaviyiS/h0xwMAfoXGIXPAOouXzHBt0dNqVK0ffEestKm/IeXPwjTMasatN3sdEd/qlO7VElbmLe0yXYcfcI40VPhsLl87kjwrlJ1CLS2ONy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gI46ybv6; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2dfa73a0bso1258431241.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706095520; x=1706700320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYsYwsp+NkgyZ5+EVTa7o9fxzZfD4HTv/4C7j2PIB9o=;
        b=gI46ybv60eEzdMliNbGVf1kElpf95/2F0pEyzQEd0U71sNwAYRLol82XLubAZfkSfv
         J6t7kxN6xPTgFv1DyJ7FoqO/bEp43C3QmEz5qXHQ/vgKbgvBBnYLIHpK9E3CwyLFRnE6
         14j/NZKOVAnveOsBMDCKqi7L6hcZapDR/hzisqfJDJzju2S7sJ4aR2BOwEIpFCdzCNmV
         jtUaWimFnQ82QkmGNfowEfHsRakc5egAamPdYidoD76k60o88JBlkyXYR7AYRvKXyr0C
         FD2tkZ+WzG2jQSKPFznj2IyzGH4KITBGj/PSLISJ/au2EKCZD2ya2vpO4+Q/LJbGa4qJ
         fIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095520; x=1706700320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYsYwsp+NkgyZ5+EVTa7o9fxzZfD4HTv/4C7j2PIB9o=;
        b=gA6s6yqles4I2gJjNfVS1R0K3TGKCXg9WGjXcA8mvVMaV8Uu/638UPz2aRvZg9a8jY
         kqfGDJPZhMGx56vgM3RMxIdZNHiUgH7FzxhkrlZirMtVwFsRqW9JESvHq/75QtC48h7j
         uUCd2Uwz/FBPCloq90Mn5AV08ew/Jy1WmU+vJJN2ISkmfJG3QvgpAG+oYqr82L3Fw3cB
         L2TZ96sxQryU1+3rMqNiPsj70PJg973FTPRmGZxqQWr2lzcGbnTLNEAg+lsYs65gnP5C
         s0kZ44CWe+l6SDGjLZ8il5gSFVpSQpaT7puGAgRitii6f2kdxnlzQpJ350EcvB9CX/NW
         4asg==
X-Gm-Message-State: AOJu0YxIjL2EdxMjk4moTKAzDLE7/8RbNk+PVmm6Hki3N+E8LngiMjce
	Je6IPgstcZFtu16Kq57XrHR4VNhPJfdo1SDnkW7S0AdfcieVXR5yOHZpy3HgiHLbKTRW0/IduY2
	i1lfauwCSHyCE7CSuSGTiD44OQaObTt1VNYnNWA==
X-Google-Smtp-Source: AGHT+IH+zPW1kXjwOmU6aKTrwoCCH2LCyOpmcVd4eYPgVGnBRq7xPsRdJYiffRebfw9EjAW6iZZo3MVPFbf5Bg7cw4I=
X-Received: by 2002:a1f:7c88:0:b0:4bd:4184:43c7 with SMTP id
 x130-20020a1f7c88000000b004bd418443c7mr858398vkc.29.1706095519744; Wed, 24
 Jan 2024 03:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235732.009174833@linuxfoundation.org>
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 16:55:08 +0530
Message-ID: <CA+G9fYsHg1GwoT0v+cTVymvxRUFAVexpTrVomRG2eHhiS2BLqA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 06:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.209 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.209-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.209-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 3c264a5f70c74960386987716dab9e042db1689b
* git describe: v5.10.208-287-g3c264a5f70c7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
208-287-g3c264a5f70c7

## Test Regressions (compared to v5.10.208)

## Metric Regressions (compared to v5.10.208)

## Test Fixes (compared to v5.10.208)

## Metric Fixes (compared to v5.10.208)

## Test result summary
total: 97987, pass: 74379, fail: 4011, skip: 19507, xfail: 90

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
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

