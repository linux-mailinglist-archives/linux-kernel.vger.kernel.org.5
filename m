Return-Path: <linux-kernel+bounces-93634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73B87329D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25741C21BAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A85EE65;
	Wed,  6 Mar 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATwrGvrj"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BF5DF1F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717664; cv=none; b=loyvkURmXslXqKCKqWgl39C16z2/B+MLnYDoA6zOn/cgI98tJoPZI3WRoQAICOcnm0h0c6wXmZGF8IL1iGhu9EAK+Rxy3qiJ2onCOLwmZ7fkJ6ORuQbP4AwWuaiAuXw+LvRghcNHJo78AJbB2Lh2wI1iLoWcoXBI5mthQx0MtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717664; c=relaxed/simple;
	bh=eeZh91byZbYG0NLTOz3LS9US03+JS6hPT7Q+9TyertE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFZEw+D9ykooMzkv1EjpFvSDODDzviPh/YfhtGordMI4xyNuIcOUGXNavnAaoGWgToM0vjJctBb7D0+4VQCXbDsCN54iLYr8tutwy/wA+dnNsTS/vkh8vORHSS7xQbZ3tKAEnsqSXWGYm2My1daX4MUI6NwoRj2f6O8dYywxvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ATwrGvrj; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7da9bec3038so358861241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709717662; x=1710322462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAzCifh2gw9tE3jlAbWBQ3zu5cw+J57BEOmQzQr7QdA=;
        b=ATwrGvrjUWcbIy2qFhMEY7o3DTK2hoqiOE+RAm/tZCut4VBKcrZuEb4dni1OVUzx6o
         CF9f1NCj/JB+avSVgD2zZa4Hvw+LPlbA04lOVlQnt5Wq8FWnGFeghUvgsipPtL85CSs8
         GL3pTR8+D6+k3BKwUMuoK2MRq+kugw4cFY2stJeh2vbjIpUAACszbPrsfoHDRJq5sym4
         alEAy42Z+w/NDkSe7I1kAH9BIJvbfHF0VH9oTxB6P2dcoKoi7l++Y3u5HkEVU0d009/h
         E/kZXdwRNHWmOIjG67tEYX4l9gYTtSxnQoYKMmuA+mczGZL6fKP2+Vmyn2TLRBa89oBA
         NnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717662; x=1710322462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAzCifh2gw9tE3jlAbWBQ3zu5cw+J57BEOmQzQr7QdA=;
        b=cp8VT6rL5CFuuz8uzdqBSFX/9Q8GbUK2ydMcAqvUeawys1hFodsP3dhi76hfaYOFO+
         syIbETI/PMkif7Z7Glv8SjFUR7/qD3cdUvCdyDCtI8PyX+ANtpjqzAD3eYToOWcX5Fqs
         RdTMqiJUogmGMMfi6+JV9+/Obpb8TnMh0twVFE0vkTRKNNWfjLt1zKSTEDRVQmG/PU3p
         E/9ipYunjEpsSsX5OIetvgFTTN4+AQhes7LXnJ6vcbWjP2wHGQqmrPEV3lgSQFtmw4Eh
         t7jrBFwGz/311huihQ/DF2kgYg5mRp0IT5TdqYKk4hPiwVXdqbXXoUFUAabOssKbOcIS
         6Fpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhl4MyMuyuhiWM1iL9WA2mgKXxNlzaWplV518e05g3W3mQ4Hb1wufKUKEQ6MoL5aW2rr95b5bxWzyuDpMNM1BvYugGV/H0ZvVHMMW
X-Gm-Message-State: AOJu0YxjLlCl+5S2AiBciumk3RP0xL3nevlflG4BJ/Aa5+xSNvO02vju
	gYzEXLqZYhNvg5QUXmlYAmLN+E//t0ueCJkCQQZ2wgJoxcFbc4j7GWZlqu6M/LTM/OLcZvl86BS
	M+jPHR1RssVaQS4z5fkBDehCoy5I8jnCFa4IqvA==
X-Google-Smtp-Source: AGHT+IGdxQJNIoJqcFDFmbxBEQ4KTrPI4D4F/IqEFApyymFB+SCBvBmFHnOTDPuYclpfSsDpuYsS3/2oaBZ4JS4mEuo=
X-Received: by 2002:a05:6122:4a8c:b0:4c7:7760:8f14 with SMTP id
 fa12-20020a0561224a8c00b004c777608f14mr3582005vkb.7.1709717662008; Wed, 06
 Mar 2024 01:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305112824.448003471@linuxfoundation.org>
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 15:04:11 +0530
Message-ID: <CA+G9fYtw4VYLkJZA2EF_xxZ0x5tthrn8V1fP_+zVvMXq0xk3mg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 16:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.9-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The arm64 device rk3399-rock-pi-4b kernel panics while running LTP syscalls
fdatasync03 test case.
However, I am trying to reproduce this crash. If successful I will
report back with
more findings.

* rk3399-rock-pi-4b, log-parser-test
  - check-kernel-oops

Links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.=
7.6-498-gae550cce59f9/testrun/22969808/suite/log-parser-test/tests/

## Build
* kernel: 6.7.9-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: ae550cce59f9da57770876a612e77f062d6b7ee0
* git describe: v6.7.6-498-gae550cce59f9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.6=
-498-gae550cce59f9

## Test Regressions (compared to v6.7.6)

## Metric Regressions (compared to v6.7.6)

## Test Fixes (compared to v6.7.6)

## Metric Fixes (compared to v6.7.6)

## Test result summary
total: 239643, pass: 206259, fail: 3352, skip: 29782, xfail: 250

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 129 passed, 4 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 33 total, 28 passed, 5 failed
* mips: 26 total, 23 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 28 passed, 8 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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
* kvm-unit-tests
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
* ltp-cv[
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

