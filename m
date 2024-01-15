Return-Path: <linux-kernel+bounces-25845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC7882D6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE591F21B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3EF508;
	Mon, 15 Jan 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjeNwgA3"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF12BAE9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cc6c88fb12so4199122241.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705312896; x=1705917696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkEfzu4mMXddQZ/Sz0Ukt1X6OmhWIm+0FNHN20uxA2Y=;
        b=XjeNwgA3rrI/0VguGhOYXmk5md52FyV0LFzftmkzJwD7chRrTQdUB6etb38Pyphshn
         9eDEukLmHF6RFxUK73YyfAx8vNFC54No0SevzMrSYSLESZfoiyirfAlXOqZTracTkV+3
         aw6YhIdQFutss0hBpyBQe2fDH9Pn0H6Gx2tQZ7Y52Fp6XhJWIuL4k0QLc7sH6a18CLlV
         aSKAIFVQpN1ENLC0u7833BgfN66XSn0C7sN5ctEnDv04AJXMSK4TtTTROT6LPAgwRJce
         +1WOF49EKSLtJ2h27uc++FgdteFC8Xloa9Qz8gawE+SBKwqGRvooDV07mqYslPH33gvo
         pkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312896; x=1705917696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkEfzu4mMXddQZ/Sz0Ukt1X6OmhWIm+0FNHN20uxA2Y=;
        b=GHOmq2pM5of4vYz3il4b4BRONCrg14DQ+QVma+gRSvEdOl+d+kja1sr80QM6noVkXy
         u0w0+K8VRRD3XZUZkhCAqnQemmnepL2Q083tjFmgTj221Ab5j4y+QVUTLVcifJeIJPYd
         7l1fSs+1TDwaThKuuCwYU+O+xjeKlOg+giCfEBn5JS4eaVva3jgxfOtgep3YitTeQUHF
         m4Wajr8PE67H/1fHVMh5Hr/F4zllU1/HhyKfQaEhIq+A1/7UWyvmL6EQT0ljBhYNUKn7
         hWUaIJa5n3EIUnwyYPOj901YYH2vgLFMWQy+VjkLJkXYwdIF02WU5IwM+FZU9GpXMRrD
         k5Aw==
X-Gm-Message-State: AOJu0Ywt+2cNSSRJImsVfSLsdS8tHPfyxvSBJVnCU/+z+Xw+bSLQ2QHl
	Xh4vNqXgeYnMQfvJ6aC80BBZIgasuz1otGA1Z1OVbPvyvfgFSg==
X-Google-Smtp-Source: AGHT+IF8BFiFWm3ualWb7Gjmgs5qXXzN13P12cr22iMtnJAHgVarMnIPYedgeRVyuTIDHnhg9etA9Ii1k66yE6jG/Sc=
X-Received: by 2002:a05:6102:ac6:b0:467:efd0:f0b4 with SMTP id
 m6-20020a0561020ac600b00467efd0f0b4mr3999606vsh.23.1705312896039; Mon, 15 Jan
 2024 02:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094209.301672391@linuxfoundation.org>
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jan 2024 15:31:24 +0530
Message-ID: <CA+G9fYu9XP80HSzMBGZe2_2e-jjOb=Cbjw9QR7ajp8Ex0DEXEQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 15:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.147 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.147-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.147-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: f40fefd14722e8606bc4d5c3b52e22bc8d5ea362
* git describe: v5.15.146-60-gf40fefd14722
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
146-60-gf40fefd14722/

## Test Regressions (compared to v5.15.145)

## Metric Regressions (compared to v5.15.145)

## Test Fixes (compared to v5.15.145)

## Metric Fixes (compared to v5.15.145)

## Test result summary
total: 175918, pass: 139063, fail: 4306, skip: 32380, xfail: 169

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 33 total, 33 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
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

