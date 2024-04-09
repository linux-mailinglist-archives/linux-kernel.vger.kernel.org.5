Return-Path: <linux-kernel+bounces-137204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47489DED4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF7F1F2DDC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D47136E0C;
	Tue,  9 Apr 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2Kc+JvN"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285C12FF9C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676004; cv=none; b=PrF1YWD2v4/Jf27TEipLw/oldYj8sX7WfX9FKRQzMO6KMneH5tBoRB1oifiv8F2qQwKCnRlGywWYdBNm5fWiTF2bL+tm5V2EZU81zhyLlBaeEWKR2D3/q2Rc60VIKLoZp5nJCqQDwM4T+U+HY2/wpaXBAJDeUXVrmrcrm9w/hPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676004; c=relaxed/simple;
	bh=w7MuII56KC0l/QaxAt8QU+nRcQzqyGN/UzjQcR8OalE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0+GWLEUN4Yia86A5psiTzywu/vIB70/CtRGDrbumJrXC3kMLMxEF53vhIEzgySnkRpq6nJRp9sqUv993BfUqTE+u1vdZrjySUc+HfJvlnFL77clIyfcqzT0Nxeqfk/lXRAOACbp7IM4rCgXPH/jD9AhM8z8VZHcWyRQW65m60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2Kc+JvN; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea14841b04so468034a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676001; x=1713280801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zgd5TOBqXIkHIiprpxWQW1KnXD2wR1OrXXzWmsDxa0=;
        b=v2Kc+JvN7N4+j168VyVTUYLaJZLVVvRytodIBPqdeqekuaMHZCzP7f884HDG6r9hGA
         z9xtP+CfEZW6tD0ehD7fA2jpwebiwS/J435h1hSsZv1IHQ5vGN4V9YR9+yTjXaXyej0C
         u4+MpwON4GVocIZV6P+khFA3nKuM4+h+Y/e8dPTXfhAwBTzt/DYUBu3VVTYaKAb8tPpc
         QENuISY2Briipw4KZElKRLzdwlSOcyk/ISIaWJVarjkPkP3/q8aYI+VafNLjc00na0y7
         1gwwGDbByw9lCPYBHkwi3Rr6/h6pHJwM6owlpd7HmKJycEs1OPmX/+K2n9sULBoGtoZ2
         Qxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676001; x=1713280801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zgd5TOBqXIkHIiprpxWQW1KnXD2wR1OrXXzWmsDxa0=;
        b=FElJUTaxTjPdVCzxStLdPdgPc7o7I7VtjzTYRxWrv/ghG/Jrp+lhRw+lwpbksRfvFO
         qdMJP28mHVWB74puL8u7f0iAoH0rXSYD0TGJ7bxWfLPusnqFuy6FvdwsQ3l78lcXuhcp
         KAMYxfY8FUziBBBBxKQHdfyOmkxIuldlYY5VDc/0NosAra/75mQzYe+IEB+rFRbFF85I
         dWC/CgQZ+BsWZJGDCJVytyEEqUQmzQP6o407y64GA2D3yZcilk3vPxEMz06AOvMd7d/U
         Zp2emNMjeH8Pu8NIDSdYLJNK6nqAoX0ajBznG9GAo3mfgFZzmXy5McgmipNpUEuFhZPa
         EczQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ceTTJD2qFPkoI7zaCH1xX+TcPT8ERAH7DaADvadWQkQLv1O3g4zaJBnVnbnslUpG0gFq14htA4DiHteblhJK8OBw4IVkv1uLWJLO
X-Gm-Message-State: AOJu0Yw66NpHwX/Z/XVA6b5v8ucs+OZ8wqA0CGtHe0Q+n1cOHsUA+1rY
	lWOXInetsSNEREM42yvUYg461MVgUajfdscCb0tieI1V5A2jx1eIoAH1eaRjB74cjqJXIEYTp6h
	+3Fyne83Nbjfpsv0RXlYNRVlo1ZLHdi9jvjJGZQ==
X-Google-Smtp-Source: AGHT+IHKRpHG9aqg3EiqE7UWmS5TF1Qw8G9pqcFx4N4CGX2gg1iJ1IwAhNWZo4wswyDMmaLjPUjJowwHQpkrkt5BEUg=
X-Received: by 2002:a05:6830:18f4:b0:6ea:133a:8eed with SMTP id
 d20-20020a05683018f400b006ea133a8eedmr38112otf.36.1712676001063; Tue, 09 Apr
 2024 08:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125359.506372836@linuxfoundation.org>
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 9 Apr 2024 17:19:50 +0200
Message-ID: <CADYN=9Lzq62s+LpXyZhGHThtVpTntsZ+huB9pUxSjComPTj5EQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 15:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.154-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: bfeab055fa437e2ad39c8b6a2e464da144479566
* git describe: v5.15.153-691-gbfeab055fa43
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.153-691-gbfeab055fa43

## Test result summary
total: 90684, pass: 72346, fail: 2213, skip: 16060, xfail: 65

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

