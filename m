Return-Path: <linux-kernel+bounces-148030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6668A7CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF32D2825FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2F6A35D;
	Wed, 17 Apr 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5tcJ5OX"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905256A338
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337979; cv=none; b=hu6gKvyBka+BCGw/wnOXUdwT57ssaggIiDjKZ8UxkmqaJs03L41xpM6sy+fo6yEsdxvfldgU8Xl9D4nZBqvCIelNXRQSc9Z4FVTUptYTLnAyFCpD+2EGYLo8rsiRp6YnKW7t1J/cMiIlBpNv1HjBYFwxsZuR2bAB3w1MAvItdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337979; c=relaxed/simple;
	bh=SYQdtG0LIT+iAGtHjLvUG40aWiWwc7H2MuZk69JxuZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1oxJtiP6RrG0mNaOaxXo1NaSIQF36vrQJ9Q/k+G4Dvz1oecNv1OYEg4/A9u+DYq5YwDpGQiVdjeI4KuXYK83DMmYRji9ZN36YOl3mbyUI5OFyMF8niR54O23q4gitF0PXnQiE1Dlhwkd+xtX7R/atkSy6T9NziA3/W78jejWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y5tcJ5OX; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4dac6802e7aso1518869e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713337976; x=1713942776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPw4P3Q1CF6rdoVIFAgFiF3XVdMOQuWkW6/qOB/eLSs=;
        b=y5tcJ5OX1yOmX1vWEi2t/QMZ5pntaoevhcdyGSSOUoOn/gyP7h4JDdM+w1o+8XvTQI
         +RSyHltTdNCU4yfCv3wN9S546rvOgyM72/fNhzQJ5Vbh4yM07F9qXZxm6VZIBwip+aQt
         UMrkvAyDVyZXYp77GHOB0Sza+v38lmJg+HDzfK1arUG+AfXHQiiZ843Gr/o8CyFHmll5
         6qQ2GBlZfxeFJpXEysYP0BYa4DM3CQSXMdJKZI+mVqmxem0+ZdnJpVe9BE2oyajRzEy+
         ONVLu1NW5xGxkMu3ZIwmX9jGRyoBBylSqEfWG0/3UGGfy4FDWaCdSGrXK6DDovPI6Zsl
         ww1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713337976; x=1713942776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPw4P3Q1CF6rdoVIFAgFiF3XVdMOQuWkW6/qOB/eLSs=;
        b=i8S3xIoAyoDmNTUAZd6OZNEG8iLJjHldqBb06+vVnpGX8c0cN99/20KWLROSjMCRoV
         yFiPQxl15b/OC4SMhjmMleVrYR8ZQyC+9mtj3oNL8sQtRYEOZ1EtLbaCRHM7QVa+lin5
         8TA9OVPXHsPpZg4T63N2/ma/HMfbu4ZdqWTpTiWydJdRDY7Jf7a9qI/lMJDGmiZL4MlK
         bsws0Uo5L3diUU6TcPMbLz/vjNcdcuLX3gyYJzAg4yTjTQg9YCE4qfPSJvxCGuXDPUE6
         O+BA+ZpngzTNVkZij5suIgJPRqWYs+iqNx2nfQUjJGijX0x4bsRQdPzehWbrA1YME9SR
         RJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQBK7WuCK6Dw60QPHSNj7aBFErXcDspwJeaoZ0asFsLO4OHLBt27tJP8jZGL6Wk4EqJwmNmN0rvHu6U9Pik+aETCNxFZ+KNXREwqV
X-Gm-Message-State: AOJu0YyZM5uiyVDfkdXrkWQXYvpO1ByhGjUXveZwHSPLm8Ifcgm4VGnU
	+hs6aiW3EaMaId+KXzeuqZoQEIJDokeecAtXYygDWgay878/Pv6xwLpjka+Diw68vw7IMEsZ4Tb
	LI3ItNl4Wth1VKmrZy5Zdf4WOyTUWQgGoDTiueQ==
X-Google-Smtp-Source: AGHT+IFZS4Mr/Mn3u9ZIIH99b59sltM+L/4eXixp20bSI9MxLOGvk8dfcsiYvGKrrZbkGJmjmy65/eJJvzLVzv3xcSQ=
X-Received: by 2002:a05:6122:410d:b0:4d4:20fa:eb0c with SMTP id
 ce13-20020a056122410d00b004d420faeb0cmr12961881vkb.5.1713337976485; Wed, 17
 Apr 2024 00:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141942.235939111@linuxfoundation.org>
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Apr 2024 12:42:44 +0530
Message-ID: <CA+G9fYtgpsiHhhiqwqvN51NOSkS2FPdZsJG=CeyHoZ5U+3omqQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/45] 5.15.156-rc1 review
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

On Mon, 15 Apr 2024 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.156 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.156-rc1.gz
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

NOTE:
[my two cents]

The arm64 kernel boot log is getting new CPU features as kernel page table
isolation forced OFF by mitigations=3Doff on following devices / qemu / fvp=
.
  * bcm2711-rpi-4-b
  * fvp-aemva
  * Juno-r2
  * qemu-arm64
  * rk3399-rock-pi-4b

This cpu features message began with the latest stable-rc versions:
 * 6.8.7-rc1
 * 6.6.28-rc1
 * 6.1.87-rc1
 * 5.15.156-rc1

Boot log:
----
CPU features: kernel page table isolation forced OFF by mitigations=3Doff

Links:
-----
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
15.155-46-g8d83652ef6bf/testrun/23487067/suite/kselftest-arm64/test/arm64_=
hwcap_sigill_HBC/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
15.155-46-g8d83652ef6bf/testrun/23487067/suite/kselftest-arm64/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.=
8.6-173-g367141eaada2/testrun/23487170/suite/kselftest-arm64/test/arm64_za-=
fork/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.=
8.6-173-g367141eaada2/testrun/23487170/suite/kselftest-arm64/test/arm64_za-=
fork/log

## Build
* kernel: 5.15.156-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 8d83652ef6bf9df8e7203eb24389829ecb092c94
* git describe: v5.15.155-46-g8d83652ef6bf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
155-46-g8d83652ef6bf

## Test Regressions (compared to v5.15.155)

## Metric Regressions (compared to v5.15.155)

## Test Fixes (compared to v5.15.155)

## Metric Fixes (compared to v5.15.155)

## Test result summary
total: 93117, pass: 74945, fail: 2749, skip: 15356, xfail: 67

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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

