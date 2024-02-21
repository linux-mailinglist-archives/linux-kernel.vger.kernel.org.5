Return-Path: <linux-kernel+bounces-74656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4685D759
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE0CB234CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212746420;
	Wed, 21 Feb 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjpqFHLx"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC413EA8B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516027; cv=none; b=jW9T/PeQCHeIRrBDTFgdpksWdFaJQ6GT0CGXQ+86gcS9t0jmF5zr4jKA3RFQUOEQqoereOBDRF8jhZrypIYJu5x3CnzRuLrWkOH9zDYxRMf5BbjxiNF1CadG4d/tEGyPNeBj3AVIHv5bbDjKNAlZnDoTKhogRjQ8/YyZnfwu29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516027; c=relaxed/simple;
	bh=FWdMoKjc5MLpmg8HeWz4u6EQMpgm5+6yYsUxzfXOOyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8t4asB4jR5uKnboDqkpEqIqasQcvhqZxIIU1rUW4KKEHKzTvNEBEozaiFhyM+yeKutoI8deExW6/lj4mjehreuKc9a9A7tnFqMvN6g+Ie5AgePqgibC1jpRkir8xhXemRIqLBwjusdxiOXE5x9eO2m9g9iaMVRLm8sr+KGTxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjpqFHLx; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so2858515241.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708516023; x=1709120823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNZUljjF/JkBMt+TrHAzZ5pIFVJVqIo7NOkfA+R583U=;
        b=bjpqFHLxz6yrupxb+DsoEZJJP/Ao6B/JwWAdikyPWgfWFIkQGbMK1ojdy72+tcNNtv
         LC5eM8CHQom9PYm+H8VQkDNBEv2dCDNo3m36HQFi+s3jSLdhPMW6B6EfbchkAhOd53cm
         mD/LGtGAUeMPB3nuI4/FyG5MysPcBDLTe8Fvo11slNreBUEMByMHXItwRUOiAIwvwu1b
         utvKB+jkf2Rrd+EGZE6hHjXny9dGJWVu2+x78Sisi/xc3V9OyYQFwDo/D/5t2gvoy1OO
         W8qeUp/Wd2WjGNYpEEuV5/0QMv68F+5gBlPcQLfpPQ9d13QGdEKWrHolCdPA3ioOH/8+
         wgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516023; x=1709120823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNZUljjF/JkBMt+TrHAzZ5pIFVJVqIo7NOkfA+R583U=;
        b=PltqQY+ULrPjk1KKBUYCJ91w6zt0X9hixNFMQtF3f5Odc0RfBN8msmSDTpashbIBN0
         cJoGHYPueyuEPzZsOsmiaU3SN5e7nYxVbTydKBpbU5GjRSGG9Rw5LWv0IDKixG0SQjZB
         +BazVxFlNkjilsmRMAtDzMPYxl+dXy1UjNqMAPx/P84Kt7o8N/Vj1fT/d2MzuCc8UIjF
         UmcNuDtcT2W5moCAK6WQ9ZhWpFkj8rfy98d25+tk69tZz69wfmS8ry8srvumHhWQ3PM5
         4zuGejJjlpFkreDfQnK7OSBRcAjMOMFRGTdymee2EwnkUxw1NU8NXL4cXAyxcMoX52UJ
         XIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoGNHG8Z9xaGos6Kw1gKTMQvHaCaONtttzIJwLBfOtbI3YWpL7jWlqfIvZQ0sRqtyC2pK/TpCOGc/nY4tZSEwTXeM+XsyNF+cl3eDa
X-Gm-Message-State: AOJu0Yz5HzITESPx+1PKf6RkTlZE3lMFTc8CBR4Ji3IHEjt4ZQrFFNzH
	SVZaScA/pTUefZ0DOQ/9ffP8lFYDyUbhlKbXn7x8z3Z8/JV/lkdv4MjgcRVypn9DmgsJQQ5u7Nt
	1c+qj5j2JajD0NlIycAIH6EpTznhCpUQ6r3x20w==
X-Google-Smtp-Source: AGHT+IHnD6ut4mdFu8GUqGoXoBNgpLaiZjv3AJvoUkNOuS/1MfekQhPQjlPllCV+S7OFskDQZnK7xdNpiymrDonZ2fE=
X-Received: by 2002:a1f:dd81:0:b0:4c9:98f8:83cc with SMTP id
 u123-20020a1fdd81000000b004c998f883ccmr8131187vkg.3.1708516022841; Wed, 21
 Feb 2024 03:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220205633.096363225@linuxfoundation.org>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Feb 2024 17:16:51 +0530
Message-ID: <CA+G9fYt6RVV=nySYQfk1XQDWjLdimcaKUX5qWTFOV6=+0H0CEw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 02:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.6-rc1.gz
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

## Build
* kernel: 6.7.6-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: c40c992a3e2ef2cd425dd1628140a318e9ec9b23
* git describe: v6.7.4-439-gc40c992a3e2e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.4=
-439-gc40c992a3e2e

## Test Regressions (compared to v6.7.4)

## Metric Regressions (compared to v6.7.4)

## Test Fixes (compared to v6.7.4)

## Metric Fixes (compared to v6.7.4)

## Test result summary
total: 252994, pass: 220458, fail: 2893, skip: 29351, xfail: 292

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 51 total, 50 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

