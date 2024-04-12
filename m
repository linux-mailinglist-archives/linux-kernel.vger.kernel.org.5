Return-Path: <linux-kernel+bounces-142922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E068A3211
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB12819FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473F1487E7;
	Fri, 12 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRIpeS3N"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2577147C61
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934873; cv=none; b=mTYQZ1fVfYUOMbTMRppSDKDLOpJGs32otSSgScznaBHgADgZ4q/Yyd8Fz0rLp3NfDMvJvL8TEKHsWDl8eau+0fEXZsq9V8turwqyd0qNrKzDNaV95Ohp9u1932qVzCrrLHYYzOMiWscRROSOrO671VNMzQbmXZYS3FOIrAOO56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934873; c=relaxed/simple;
	bh=brEje0cHPh78nWmZ49OAC1Q54MURkbmR/oXropLUQlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRACKhtTzAfFu3IEAQgV+laW487D/tIlAL7o/hWhap0TfqUx85TwLHenLYkHRYWr/hUYF9e7H4ehS+VrJiW/scxs0KzqnqgO71C0T2IY24XyasjZd2fzRvHRLde9Z44FlKso0kG28G/sNgrtw9Zfle8oIbYkr9/a/3ngayeZK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LRIpeS3N; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-617ddc988f5so11484477b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712934871; x=1713539671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLvO4O9yjxcuvv/qAn2Shyb8mUKKY44bwVC7r1AMAcM=;
        b=LRIpeS3NzedOks3PDgsh2sp5dijm6Jgp6sJe0ftpjyic6Jxjw/0dgw2oRzDnBbChlw
         Q/Wh0y0ZuhP57raoRbNhc+1mJ73IB9YQqe/MV/pH6wMQAGdhhHKhnFwia3zOVq6qqKas
         6RhNVkbG1yeugZvdS/2CFJbT3Fp6CtKGZDPLgd6CwhebhSBa2/O2O9i7PpXPcPdxh56/
         fL8KXiJZoRoOde/8+zHxGh4s8OgXIi0QvYOR/Os+LFz2TyaohwAh4TL6cTOTrsp/1jf0
         EVTmFgRDMGdcmfwFCz+AOJg5qQiHdPLf6Y3qgdTEWvwoRD4y9tb9NDbGp9L4ZDJIYD5H
         CVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934871; x=1713539671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLvO4O9yjxcuvv/qAn2Shyb8mUKKY44bwVC7r1AMAcM=;
        b=X8Xl0dvpDOEXNqG8lLu099eIlqOC8vJd64m+ZjTLmfhg1XKAD6E6duWgIlFhiFjlIM
         w8b1rS7vK0/RK5bIfZvM0L2kX4J9Cmn/I1/ZUqoHX7K1e8eiqCr/lLuEFMMJAU3SJSta
         r1F4QXt42apvNVr43QeW2BAssFDWfpLPv+Ms6k8MGSZnzPBItm8aGp2L0tCX6p4WfjTH
         mzTjwkljMKdOP8l2spfhekOSaSy2NdilynFv8DkMbG3bWqDVRJJZHo+u35ya30PDD5HZ
         VTsAdmkpQT0ewoQm230KJf744kQ8LZgHjgwmO6LcQoy8ogFat82bMkg94BN3S0wI4aYQ
         gvAg==
X-Forwarded-Encrypted: i=1; AJvYcCUqpUKKWMFWBCVR7kAxyJWsHlQ4eHZgYEVJrxEsqsb2ibhkUd1azMgjh1NXuIQ4WkeAxSONQ02h+rSlY7+zURn+xBOzOlYUOsRhA1oJ
X-Gm-Message-State: AOJu0YzPXJ+VSmNQVgkDhup9yXJs7rc8prZS3x/BbemidONtIxEvB3oI
	YMIe3nD/lHZemDxz3LdLNqVMeKlVi6LnjGz94cz92iQGTF07BIkBiYs6UEiJ5k95ahoboCFuv+4
	Rl9fGxIrdic1ZBfayfd6WQkrqMmUx1SMs/GTrbw==
X-Google-Smtp-Source: AGHT+IFLuEDQPZPdafjpLdhnG+r9Ye8iEmmGE6muHcR1tOSBTmu8a6ZSPp1/UImrPk4NjhvsWI0E09D8nDEHmcvlq2E=
X-Received: by 2002:a81:ac67:0:b0:618:66f3:818d with SMTP id
 z39-20020a81ac67000000b0061866f3818dmr2705737ywj.16.1712934870543; Fri, 12
 Apr 2024 08:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095412.671665933@linuxfoundation.org>
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 20:44:18 +0530
Message-ID: <CA+G9fYswXLb=gN9SUxqpctWKyDz52rsrXqynPWy=uUAPkKCUFw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
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

On Thu, 11 Apr 2024 at 16:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.86-rc1.gz
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
* kernel: 6.1.86-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 2cacd493e299f82c489b78ba1de45da451d02bb0
* git describe: v6.1.85-84-g2cacd493e299
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
5-84-g2cacd493e299

## Test Regressions (compared to v6.1.85)

## Metric Regressions (compared to v6.1.85)

## Test Fixes (compared to v6.1.85)

## Metric Fixes (compared to v6.1.85)

## Test result summary
total: 161977, pass: 138152, fail: 2686, skip: 20976, xfail: 163

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
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

