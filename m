Return-Path: <linux-kernel+bounces-165129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2498B8867
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8D91F244DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA3524D7;
	Wed,  1 May 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niLiRkdo"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFE52F62
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558442; cv=none; b=adTOwyRakq2K7ei/fs6ylB3hC6mipURa5wOVIHM/lknu85c9PWY/A8FHOFmNOD3+24jToclAGLmZ3/iYfD7AoYWX5SPXGqLQlLNvwcYJGQYLE38CnPX5XYHI0fyHOc1cZh/a9gvvt6pETMOLqdTzqM+KT6xyIp4nnoKpG3M3x3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558442; c=relaxed/simple;
	bh=R4fmjy+8hfGHxDfrhgKhaTl+RpHiDKixsqP18LZW7AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7GJDEvn3fmKCV3Rvs2QOODgaePR7sp9JeLy4o73r4s/wnoo0+j7rUuDPpqRE3rKcPQ8XgdsOYBxJ/eBg4fKJq8rmSbeRxh6i8YM1Iq3uUnhZpyNZHLwA6zdkjWQV/iokcSFMyRnAXoM8FQWjKpk2IwJRh9+xx68dO6ZLT3Rs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niLiRkdo; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4dac5a3fbeaso2640070e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714558439; x=1715163239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbIjCKOEuz58/k1pZWu5FN3AtpqH/WknsKLnXxTqtW8=;
        b=niLiRkdooedgn2m6DgDsy3QuYbspmUovyfp6ciV5Bjtyg1nLolx4ab+C6MUqxeBFRg
         Ju5a0WIHMrJpsTLkVv/gNOM0eL2PDKjBSsm5F/oqO/xnHrCK43LqerD8Fd1FC8pec9BH
         CiEK8IjD/ExJx6JreEEWXvHWpcxXQ8ozCd9Az/jIlDeNiyCL5Dgc7eUAKtxLyle8/xSw
         J5kNFA/Hq7rEgJY1B9Mt9nH59E5uzBCxT6zPXVfqHFrLjub5NsO9RiD4R6wLycT6P31d
         3eS9xF9V0AEhvSTk72a0dQMaPig9rB/jV7533+6JK0mlQv3CQ1yUv54s8mZ2qnkZt7Xg
         D+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558439; x=1715163239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbIjCKOEuz58/k1pZWu5FN3AtpqH/WknsKLnXxTqtW8=;
        b=vFtYpgI1ZuQ0LL4WK9e+4WLw99Y2ZQhD7fIbUOzAiw2l//RZci0OVwRPTzLFUBHhNE
         vBhb7xtWNXRF24YtaHsx7R6GVXAh6Ve3dE2e42C5uvf7xnO5nQWskcvl6GnaFe4DaRlF
         nfeGwawGXyTObowe3Hw+kb0w+X5S65InsII8itloc+M1y3IZcz/kXuIgWBzXsECj+3au
         YFJYHu+PvsM4Jz5+TEZgYx08dZUXsB3OSRZonZD6rzf1bo6a6RNHWixuXcUMTYZeqvnT
         B7uWAGKuuMDWVCOzBi5JODYJ0JhaYsegwGtcYCLULBp92FTur8zjH3sM7VWeerapf3Dr
         xmXw==
X-Forwarded-Encrypted: i=1; AJvYcCUYn0UMxeZyCeohPh9R+ITZIoch2lNgXsA93yrpeMbdlJOl34ipAG9lgNvesKZW20FKBWCaPycbs7hjhKq4D5LDZ+wg9vy3MrgDnr5d
X-Gm-Message-State: AOJu0Yw7mZ17UwqF6NY2L1U4YKlUMDgLJmOdwNQ6FdhYRiPSqRp6WdKZ
	oj6mU23oCyoPRV3JZSWdPaam+KB53pAFQkFHRNCP+9KrJscYzgY3wKbILwFBhdXo9V8Oxo42ZzW
	FmIYtaiRx774/8bCBsbYkxQQppsYOsMDgSqzGg/IHZjCjKmZINWo=
X-Google-Smtp-Source: AGHT+IGPZVswxDsVKQ85QCYc6SsPa5oLux4hMYc+4nof+Quq002rktVnJ9FzL5fqHueqx254hm//pDt9M9EdnP1v8bg=
X-Received: by 2002:a05:6122:1695:b0:4da:a82e:95f5 with SMTP id
 21-20020a056122169500b004daa82e95f5mr2140942vkl.5.1714558439121; Wed, 01 May
 2024 03:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103047.561802595@linuxfoundation.org>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 15:43:47 +0530
Message-ID: <CA+G9fYu8cj_wEwWLeWwO5krCfnKbKbNZ=sgnZkAXSi-0XmbbXA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
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

On Tue, 30 Apr 2024 at 16:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.90-rc1.gz
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
* kernel: 6.1.90-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b3fba631803defe65cfb1653433902b510db9330
* git describe: v6.1.88-113-gb3fba631803d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
8-113-gb3fba631803d

## Test Regressions (compared to v6.1.87)

## Metric Regressions (compared to v6.1.87)

## Test Fixes (compared to v6.1.87)

## Metric Fixes (compared to v6.1.87)

## Test result summary
total: 142192, pass: 121440, fail: 2635, skip: 17971, xfail: 146

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

