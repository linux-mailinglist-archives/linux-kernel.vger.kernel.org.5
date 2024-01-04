Return-Path: <linux-kernel+bounces-16584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB3824098
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DFF1F26D05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A82110E;
	Thu,  4 Jan 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5T35EMF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C421369
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46788b25f95so123907137.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704367719; x=1704972519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tweg/D/5XWVwQJcIsArKsHkePEu/CHILd8GCHNr9cnk=;
        b=c5T35EMFHwYjd+OxfWWrFPkGafWTvV1Nyngn6/TfCBUw+yD2YYU8pHhTB3vOVdT4hD
         Kcs0jYNwYLu5j/9j1Ummt7tac1F4l4dJQ5trVCmbJot9DIpW5sLZkQ0RwnWwneh5Pqqr
         LrZkuwbWgOJkIy8jCWzVrES3v1/kxn+QBVJFExrZq+jdowrZbhlGpAFxphKv0DrKScmE
         GnWY+jTMt2d++5DnEZVO4f1CyRSF84mDbkGqtMEvbTE0NOzwuZtDNry7ty3G8/fRf/xs
         Lbe8XBtPlgWkBjCb+iJ6oqnMffds6qXNq0bGvriAh0KpByAefDxN7K6QgP81f3cTQ661
         f0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367719; x=1704972519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tweg/D/5XWVwQJcIsArKsHkePEu/CHILd8GCHNr9cnk=;
        b=Pw5yu9D8JntAYpP22XVUFssNy4tEDIkNINU4AX7IEwmCels+gGu6TzwxahE2Bc++bQ
         wej41QcD2VxibG1xSahP2dPFuhD2YENq7vhP5zbFB7mAjdw5k5bQYmF5pF76M1As30uf
         ph5yz8M0e+ECqqtEav88qbfzi4uG87BCQqG0qvI9TxVOUM8SXiygyetEkNkc6AIvJ6Jb
         zMzoMmFnmKpVADbuUWaPXgXU1A735SPYORkhJJRuZa3TvSl8q35YLdTm6gN50eKb7wnt
         gbMpI9NUjajoepGtcR+W+CrYXiZS4ZgEmWJnQsESx42U5iB9ONwd1MsaaquhqnZYifqg
         gFSg==
X-Gm-Message-State: AOJu0YxibFntvdHy128qDmRdthSNcbm0NMRbTvw3Q8v3JxbNvZSzlsfn
	OnX5QvNkLERchd9bmzWcfRuGwQzlMT2UC+NOIpOL5wIzpNIx4Q==
X-Google-Smtp-Source: AGHT+IEU2rSSQg/onyItb6pGiOtsfeAw8aUXOzj0XpNDIE+pMquEBDh+i2TfRqP7hH6b2oqlUZZB8s95rgLwdJE51Ts=
X-Received: by 2002:a05:6102:3eca:b0:466:60a0:ca74 with SMTP id
 n10-20020a0561023eca00b0046660a0ca74mr374339vsv.10.1704367719386; Thu, 04 Jan
 2024 03:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164853.921194838@linuxfoundation.org>
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Jan 2024 16:58:27 +0530
Message-ID: <CA+G9fYvfo1Sr8fBYd=oDkG19Z0O5+z4mnonPvXyhNnhPBdbGUg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jan 2024 at 22:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.146-rc1.gz
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
* kernel: 5.15.146-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 927631a7bbf09d5c91bd27dc5c660eaff4c67b06
* git describe: v5.15.145-96-g927631a7bbf0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.145-96-g927631a7bbf0

## Test Regressions (compared to v5.15.145)

## Metric Regressions (compared to v5.15.145)

## Test Fixes (compared to v5.15.145)

## Metric Fixes (compared to v5.15.145)

## Test result summary
total: 96922, pass: 76690, fail: 2639, skip: 17532, xfail: 61

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

