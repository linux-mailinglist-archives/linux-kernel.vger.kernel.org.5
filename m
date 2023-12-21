Return-Path: <linux-kernel+bounces-7900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06A81AEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D1E1C22C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D6BE4D;
	Thu, 21 Dec 2023 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Af9geF5u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED3BE49
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b6d201adf0so78237e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703141295; x=1703746095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9jf/aWqzdVJic9dbSLeO77joE90wgpTQub1AqUEogI=;
        b=Af9geF5uxHzwIuNuOjqKsAx6f6+rDc4b0fyPl5LZ05NHVUzzTLWgiKUhG3Ef23ITOD
         6ixhEfOCf1aHl2ADW1vgSruw5YNge8CjpZcvxBFBrJ4KUTpvrRs3vtpQ22lX/B64FUNy
         M8NEr9/0rGOU9ZP9dYkAjrm+X8+YqEbhEyOuAVr3FWsUKy9ZdvGAjsW8gruIfBHc1DCs
         dzqfapZXm5kwh+gr0Ml18J2UGXo/clvoVg8mBHv4fPtAlCIYjCzzGalPEuFlHAVU6huz
         JxSrqE3gbYhPJ9AB5dpxwbI9jZLyaHJ3bJkEfrIvpcvaviMrOrrTQeHa2Hh9CEgZksuh
         Pkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141295; x=1703746095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9jf/aWqzdVJic9dbSLeO77joE90wgpTQub1AqUEogI=;
        b=Oxn2TpW15fjx5eNQy2vvgMcQ8BjF0WTeMizSaKhMB8BBx+l42vwOMOAnlqKo/pv3q2
         wo4AzWTuzdOO6BcWz5hdxFiyVrATj+WJzioCrbbWoWpOFIfhjP40S86b8DmqDDeOyu6f
         G/yg8mA+m5U5nip1Vs5qcAJANuvXCB6fev369PyuwPA+PmlD0awvX73VLVpyjSK47piM
         cKgGqfyEKaiVgWkHpwQJNu17a2KXhZqA0YuWBakIaz4Y/Jd6UuTDqvNzelmfJA85cJlb
         lcFvlmIg1FMq72PSuBLHjiQhBlhLfPZgY4ES8H+zNmJ4ShcQeQ0m/wX1LrZCCXCJcIjg
         nK9Q==
X-Gm-Message-State: AOJu0YxqynwpbrSznA1Fly14gO9Kd76R14YjkkNOE3K/uDw2aQjDAOWy
	JXJuhVoWH9pyiszP9znM14LOnHPU9RPtXvnooev7ug==
X-Google-Smtp-Source: AGHT+IFoWkrT/yDYvY4Qu03ZI2dU6KyzH1f4HZG2nOJgTQs8/I065FWXXf13xD5wfMNEhFPN23L/irFowbzJSsBT0Vk=
X-Received: by 2002:a05:6122:4d0a:b0:4b6:c8ef:dd74 with SMTP id
 fi10-20020a0561224d0a00b004b6c8efdd74mr626733vkb.11.1703141295537; Wed, 20
 Dec 2023 22:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220160931.251686445@linuxfoundation.org>
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Dec 2023 12:18:04 +0530
Message-ID: <CA+G9fYtPr644KJ1168ndODXY+mtXa0kv3W-8Q4QS4n8PxJV4kQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/159] 5.15.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 at 21:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.145 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.145-rc1.gz
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
* kernel: 5.15.145-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: e7911feb56b718aa3149a2665b7c83a18b46efa7
* git describe: v5.15.143-243-ge7911feb56b7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.143-243-ge7911feb56b7

## Test Regressions (compared to v5.15.143)

## Metric Regressions (compared to v5.15.143)

## Test Fixes (compared to v5.15.143)

## Metric Fixes (compared to v5.15.143)

## Test result summary
total: 97654, pass: 77080, fail: 2684, skip: 17826, xfail: 64

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
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

