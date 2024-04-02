Return-Path: <linux-kernel+bounces-127968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0B8953C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849791F22E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CBF77F15;
	Tue,  2 Apr 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkWzJ353"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD11DFD0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062033; cv=none; b=HUWCcde7VmfH4j+lr4aqAeolpRGDt/+09intLJZt+FEzk3LQOg+GY9r7y77NvjmrPGLCNfpxliJNW8lpbeTGuSZ5bMCrOqoflX99/ED/BmwBmkzSl3w9dH2pH0j27CbTSXBK7UIy5/mWDUrtx1Tzk95YQ79qnX26+gc353UMXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062033; c=relaxed/simple;
	bh=y7r81xGJhGvZo4UNu8tcAQh6Pm1cop4NxxV+9nrHJUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1171gZLkceW15Snas2gZfOQ96o+KCSSxLIsYVR/VVUFOIvxjDHKC7IBSk9LN3iG8rXyMndqobnVZ7KsqaTWNIZg0UsT9GhZoTyDsxQnMH4DS+QbbLMADSX7xPmHxujD3Wig8JsHVtEckBp1QvdfkODtJadGg9aHI8jpfFjXsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkWzJ353; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4765e6cf37aso1397979137.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712062030; x=1712666830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCvuoEY2B7r6zo9f6eT/+ISmVC7xlAWxrfabw7NgzmU=;
        b=wkWzJ353cfz1drPEsIjmvd2j2tlAynyMp6mbgnCFGQKlYXBo2kXERJdPKppe4MHG84
         8XmUwD0R3AhmXlxGyY25iL/Sv+IVHPfVVjSX+qiECC4ShUp5bS82rXwOvuq4+rNeMLJL
         SkWdS6spunuUqf3G2pr3WEwPqxKxssQ9DHdmITdoh3UbIYL8oPwGUuU4lDmmv1Rc6tyd
         uJTI83IfeqLKfb6u3WAAqryP2Tsbp/ggwoem4gkgJX6QFcdKLsUgENMQXJTzbKoV/UNb
         UbrWu+8XxhnI23wbGLCQDPYwCvtFQ0fBPdcHpojV91LYpmgfKpIy+dPeH3inB2oEx5Ce
         r6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062030; x=1712666830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCvuoEY2B7r6zo9f6eT/+ISmVC7xlAWxrfabw7NgzmU=;
        b=Eofap21MG6bh6K+mTT4c4p+HawWP2zHAbTh+iABLh05JC5/gvmgryIsyXxp+RjCLhG
         TZE8PJbmrrfqAj8QcXTK1YFa2cx+hbNjOTLp4bJD/wBniZGnxIG0PogBtwvKkRpNXa2m
         FGIwqOxnXYaLGm0zGhnl/93AsoudOqzkPjpYwwy/3FftCTCFIjeW8/DIlb2falCD7bwi
         8lVc0nGqVOBtozV5zop18LAsCP0kaE1T/jXXazrYBw+ypdgm3SJQFpT5E4dXhbIe/baz
         tAkfTaYSOBA1mzZhTtugn1d1Irn+ZFqZpY25n7PnVxB6UKRNsM5ci95ZpMGCQvVnjymY
         9+mg==
X-Forwarded-Encrypted: i=1; AJvYcCWKdWmXO9Q0uEQfMCSmfBZfBGNsvzk7GnRkTwewJmqyrg8fAlaAJXP1wtrYAOkM0M4OAGkpWl3pwGhFq1TtFcpXSxm023+OY+jC84CM
X-Gm-Message-State: AOJu0YwGATbwuWLIC012c8SYKjf64DBzptxKNN6sSTz1OP0kQ26aMyTI
	HKGZV45byTeAUvqErAdDnq2ux44Ly3OO5IYyE4jTlfrT3AJ40GNvvP1X2f4ylFD6ZqWYaUcHlaX
	dv312+lEyIAiP3m65pbePdbQNmIpNFVxnBtyG2g==
X-Google-Smtp-Source: AGHT+IER0olSgqW7huR3aO5YCPv6vu0CrtUUvbpJpH9rBf81cDKDA5UdfqUkMF3GdSGlM6Yl39uhsd8lOSxDgMt7MJo=
X-Received: by 2002:a05:6102:2ad0:b0:478:92a6:67d3 with SMTP id
 eh16-20020a0561022ad000b0047892a667d3mr915738vsb.14.1712062029047; Tue, 02
 Apr 2024 05:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152530.237785232@linuxfoundation.org>
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 18:16:57 +0530
Message-ID: <CA+G9fYvMX1=ueS0SRKK00JrXt_OrkBON1-+Mp3QS51Yeiu=U8g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
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

On Mon, 1 Apr 2024 at 22:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.84-rc1.gz
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
* kernel: 6.1.84-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: aa2042702765a33750c326a9e153901b313636ac
* git describe: v6.1.83-273-gaa2042702765
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
3-273-gaa2042702765

## Test Regressions (compared to v6.1.83)

## Metric Regressions (compared to v6.1.83)

## Test Fixes (compared to v6.1.83)

## Metric Fixes (compared to v6.1.83)

## Test result summary
total: 146089, pass: 124663, fail: 2421, skip: 18867, xfail: 138

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 138 passed, 0 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 30 total, 30 passed, 0 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 15 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 35 total, 34 passed, 1 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-drivers-dma-buf
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-lib
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
* kselftest-openat2
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

