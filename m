Return-Path: <linux-kernel+bounces-65099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573298547C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB7B27E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441D18EA5;
	Wed, 14 Feb 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbQoxGpn"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B23171CC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908884; cv=none; b=X/zK0mkB8HyFiVpdIYyZqq4trI0jkDyiXfJIM/IVkbUKNHobkW5LsnKxGbRXsH8RX2W/VNathgjgPUkLXDtN0RmomN/6Lbw7LLXZMbGt2HROHtMXXIrcb2SJXWjIxTFHchZgNIOCOgKqP/nU0/eKZaute5iFv6e94jYPhwzO6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908884; c=relaxed/simple;
	bh=A3p6dvBkfrPe+QYcRYOO0BIOw+bilpkXrxJFPkswnJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6rqVp2tbAxT5dRs81z1oZil2CuWSqAhrxEPbH+1fnxITtqW5HB7ZO3VD9OfI3r2M/LggPQG2dzTbKA2fxTYc/75Mw6ndKl1puDwLjOueODEipyM4CgpzJqsQyJrL1tcFTrhHDDBZyIzwIS7vKqhy3H3+vs1weeuIuAQKRPjFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NbQoxGpn; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d6a772e08dso1690351241.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707908881; x=1708513681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72WvijmG/p/dIh/NSuC/Lvzmr8cJPzL16ZxCDMhhDUU=;
        b=NbQoxGpnf+sDvUEoMkrxNEZUkBNLdtbLczv6WzRHHoy7jsYX3u2F2zSQ6gE1FaKuZ7
         +42CMzri5ymNKl9X0orRmmJzlD0jKzsYvayrTGBLm5mCwsberOQImYRgqgruz4iv3qvk
         moJ8oYIdfjS4k9jjJfa45f3VQ53c/iUf18JiSwJlZmyE/qYve3+lcfkuZ/X4EF7yvi8u
         uPOoE19RzsnPlslEhHNKMVclbrJKW2QgvBoc65VG908i/EZNlT/5eW1coqDTohClPjLN
         kqguMSLuXPa6P1/yyoLQ2lVA8CYlR0qqMfC5Cj987Pd46gcDwaP+JITHixElaBRJ3NrI
         AzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908882; x=1708513682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72WvijmG/p/dIh/NSuC/Lvzmr8cJPzL16ZxCDMhhDUU=;
        b=oc2sMltFU8ip5dmXoEOQoF1ZSGYpSvk4H+/N00db4XLmbJv3F0eXyO3Zpn92PuGGmS
         DhogIvL7r06WO0mu/Zfz5kYYDKP2j7vTiR4xWBh29OVdwutYzTw5PatPDZA8sqJCdSHE
         9Zd6twzI4/QCQCsa9ik++dIUNDRWohWuoa43AMyWyWIaw8T5bBpV59CCIRDWrqkTvl3D
         90QVNHJKLx7P3rtu73ObyaGjo5kCzFj+x+3dnXXb1WR14cD06PNW4P/ZNSb5WykBODiM
         zSucXY5mp8cXxMB3DMotVVL4T6QjTkbyMs/PzRgtnNWyj7jBAWb5Kqb9C40q/K4nHTWK
         UHYw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYHCmNpsNRJIAWGS/41ZLjKV+94dOeJcqkejA5qmFwmEQ2YVSG2AzQ85fVBxbPySZwdFl2FmlhUpCI6UCnm2U/qTph/mbWfexig5q
X-Gm-Message-State: AOJu0YwudlCR/GyiSN8pnhCB0hNjrq9fPJygDooKCgNXOQjmLdyPgmHG
	DncHaLwGuruoZylcvJUt+BgeDeAMi+QueArzNZGg3LMhk1dRyaBUZwP4A//Ld13jri2UoxZ00o5
	aAqULniqKTNnxg+j92xOca+VPohpgUfgyl9yfug==
X-Google-Smtp-Source: AGHT+IEQ36E1X3jer9pbjUng+y7hZJGp3oEbnN68Y5/nwPhnD/gymeIRPC2uUIDzWpO9yfPCrh/JQu65JbsQVsdRi6Y=
X-Received: by 2002:a1f:de44:0:b0:4c0:d28:9557 with SMTP id
 v65-20020a1fde44000000b004c00d289557mr2020482vkg.1.1707908881598; Wed, 14 Feb
 2024 03:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171844.702064831@linuxfoundation.org>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Feb 2024 16:37:50 +0530
Message-ID: <CA+G9fYu1ycnmEymAuAWLwdRQLUL9gAnkw-zPAFoGDQH+YQShHA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 22:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.78-rc1.gz
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
* kernel: 6.1.78-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b29c5b14893f8c7e4ce99e7ee1c69848798a686f
* git describe: v6.1.77-65-gb29c5b14893f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
7-65-gb29c5b14893f

## Test Regressions (compared to v6.1.77)

## Metric Regressions (compared to v6.1.77)

## Test Fixes (compared to v6.1.77)

## Metric Fixes (compared to v6.1.77)

## Test result summary
total: 134243, pass: 114089, fail: 2705, skip: 17286, xfail: 163

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 135 passed, 16 failed
* arm64: 52 total, 47 passed, 5 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 15 passed, 1 failed
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

