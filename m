Return-Path: <linux-kernel+bounces-18545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F64825F05
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F29028496F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B563C5;
	Sat,  6 Jan 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OObAYfDr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E163A8
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78314e00337so8230985a.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 01:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704533867; x=1705138667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R/NCLZ1G/4/Oo+PkhRK09jxtahsnTTNbgFR00sNUzI=;
        b=OObAYfDrGsVVdnPMtsIA3ORjRt+pHzjnahdH88sp/DbfaOTD7cn/vy0SUAvb1PZwPt
         AghrGlWWMSidPA33GcFgo0GjgiXaJzwDJBd4GjD1U5Jbm5RwbjJ0MPFtByrv2k1RjmID
         Z9PYRZl4IrFx2aXW3LoaITZ6wKVk2Di/ZXvu/DOFhJ2zwNQ2Bs1T0it6KkBSDwMp5UNY
         +f5Vk6HHCY/d/au8yrfiBWFgOrfv9uA6G5jBvO6dQJbs/UUSaXoRtqhCgSm5a6O8lwNG
         VCz1joMRyzoHdV/EzSVukX9pnqR2zGLwb1mcmVX4TcQgsj/nWG9KiDAiZmnJuUEL3DVe
         TJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704533867; x=1705138667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R/NCLZ1G/4/Oo+PkhRK09jxtahsnTTNbgFR00sNUzI=;
        b=q2rrxDwpcL6AI1RaOaA2GKEE40Wvw/XmuHlDLkMQP3m1FGvgSvu5Y3gk7IMlvWN3BU
         gnW5yYMtukAsVEl26Pp3XXbIakAHm0iBsw/xmZMs/4pwjcKzDPnNINOD6dZLkjUYBIJt
         EjmGQFzXlBi+n9cNZhzF33kIqToc4dazrm04aOU9VyRHbExl6SywY+WLwt9o0cCMCAje
         rx6N7Qd4wyRGHKCjFPmyKFTIZ3qVzuaKwrt23cVpTRLcWuqun/tYLEDcKxIGPpZAqZyR
         NBDoJFmzKq0eivYJl1fHj/uJJ/BstwgJezDxSA1sTfqCDiCOomXK2eF2RctEtxqiN33c
         EvBg==
X-Gm-Message-State: AOJu0YxxY7PvF8SExGJ/sShXD1NzcYM5DKvvJxQ3CAxjykMir0dxoVnt
	jnx0tsxDFnUVLMO8++c7PAU9J6J65VRMKOrY33jle7uCCAFFRA==
X-Google-Smtp-Source: AGHT+IEcm3ftG3NEuuYVf6CdkOH9cT3RZyUFa9FvQEWR+mUSiDhy4ZApeY+gCtI5FmZGyE4rkuPihRiIHhrvC+B9ZWQ=
X-Received: by 2002:a05:620a:17a3:b0:783:14fc:2e0e with SMTP id
 ay35-20020a05620a17a300b0078314fc2e0emr178638qkb.29.1704533867182; Sat, 06
 Jan 2024 01:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105143813.957669139@linuxfoundation.org>
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 6 Jan 2024 15:07:35 +0530
Message-ID: <CA+G9fYtN2Dqh48zRGZW1wQTQfrw6eaCMG0tA5Q4y__CwT-w5AA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/41] 4.19.304-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2024 at 20:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.304 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.304-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.304-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 3ddaf9daf2cf5540f0abc2fd86938b7a93e099c6
* git describe: v4.19.303-42-g3ddaf9daf2cf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.303-42-g3ddaf9daf2cf

## Test Regressions (compared to v4.19.302)

## Metric Regressions (compared to v4.19.302)

## Test Fixes (compared to v4.19.302)

## Metric Fixes (compared to v4.19.302)

## Test result summary
total: 55092, pass: 46334, fail: 1606, skip: 7118, xfail: 34

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
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
* kselftest-user
* kselftest-vm
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

