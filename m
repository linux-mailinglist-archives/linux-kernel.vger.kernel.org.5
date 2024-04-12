Return-Path: <linux-kernel+bounces-142536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA998A2CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3200F1F21F20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69609502B0;
	Fri, 12 Apr 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQ+B7pdW"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A940C15
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919361; cv=none; b=BdJpRRxL2ZAfJyJJxDroewZB+hXSdKDt9sKAk49tqO/dzVqCBf6/0Rd5Y8ywJ8StrhYfTDe0WYo4kLdQMxVbUkxYC+FnWMvMl5AY3TPVBvB32hO7pY46BFPvYDyV2y1Au5yovPCp3ttTwW0G7Uk3guqVHEGEyEmVdZZ1GQm374c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919361; c=relaxed/simple;
	bh=5whlkPZbuuY6dV+m74XUpzk7gd2mVagag7ouF0AoZb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ6RymnuJtsdpqLHbZo1z1+AU87rX+R6LU5D4Uj1R9UsmO4o2Wb3x0Pl7uYCzRv3+0ETCIiGf9EcA1OnwPuw7ws8sTxDTBTKXlJohIfwz3uOzf2QxLGwvU8y6gadyUc4A2WXBHWFwDtceeUBPQOdL4TFQvwjb6sGqB+73ZN8O1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HQ+B7pdW; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4daa1be011dso321618e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712919359; x=1713524159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3EGTLIR5OVTb3E7mRYMzjSIGw18/H+l6c4Ynvz2kO0=;
        b=HQ+B7pdW5F8ebqartsJekcfYoatGkBPlSyUiVzoe1EzTjCOGudsvKkLgEu9wY0X3l3
         x5NYjHIertR2w2nN0b6xnajuN5Q9A2S1ufd6BJLD4xkaLS0IBspnM47tauK5gSUjo7P4
         3tzbcy755DDSuzvVuRZVPpWGLYM1u7yLQ6LB3Tju6qIxLXtO68sT3bWAxLzjIGncn9LZ
         50CPNWKL88vPK05aQeLRm0yf1aGco7O8xysfnoGa6E0wvle+5sMFMFMKAW0LpO23j7qR
         6SR2vIySw4Qjo9UdEit6eBTx9JOpJ2PrdiKqr32DQP83SICjWbO1auJU5iukPc5ntWzk
         HrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712919359; x=1713524159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3EGTLIR5OVTb3E7mRYMzjSIGw18/H+l6c4Ynvz2kO0=;
        b=TG+uyu6U65MCJS4RckK6RJg3PV495Yk2gZ6e98Bq0PbX9p/doK4vMtnYI0RIblQONJ
         ygh1hNSF/l0DFjGA3cEO/XHgMarzmFNZa369E/5zpArJ2jXmuY3npdA1I68DUiMGQlFU
         07Ob5/2QV+8HZWYmk8cAAYPIorz0y91dSOlGmFWee3XH1t66T6NBkkcuN1GQG8K8ny/U
         dVV0ET7eUOSXjn+6WUORacXnZEt7pJTEWbtn5yNRUJkS7tj/4RbgtRKSqHaeST83TtDY
         qkjw/n4HRXYsdY9IW8fgxN9uSStcYNfztM7JLwC7fQpjnpVjgYyRr2ERgpAaeO4AbnXn
         28lg==
X-Forwarded-Encrypted: i=1; AJvYcCXREQP8wWzlBeyWtlkksQuChnHgH44mWNHcLDC+BkNyCImRvpcF5J5Y00FNCL3sKGQ7MvZHXW+UirVjk6hLCWp7EHfneXWKhscF/XIb
X-Gm-Message-State: AOJu0YxaQYLEhbusz8eD/uuU7S6gy3LZSZJCoZOy8hvTzc9i7PvwaKB0
	KxooFihBEDioYGWomvVjrbZ4glqlSUytSATZHNdMbrfYfNyZDNoQ59D1Zs6qb9Z8hKGfJDZC26i
	5hHcjbrTZs5SrvlTRJAMQuw1tpUG5UjBCN2MlMA==
X-Google-Smtp-Source: AGHT+IHArFFDWYA5PGv0cHaA7Y9RyWZ+Omp0MmnDH9oGtj00laZjIblsjHAaMGU+fC2ydLPLphcuF7dLgKMLSl7li3k=
X-Received: by 2002:a05:6122:46a0:b0:4d8:690d:c02a with SMTP id
 di32-20020a05612246a000b004d8690dc02amr2421582vkb.6.1712919358949; Fri, 12
 Apr 2024 03:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095424.875421572@linuxfoundation.org>
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 16:25:47 +0530
Message-ID: <CA+G9fYs9ipnaJtizZ+rEj=Tns_a7T=E0oBWZ2DtxXmZmUSkFVA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
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

On Thu, 11 Apr 2024 at 15:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.274-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.274-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 82d3ef7640657b7e1fb7091841ba7a47a7a29ab4
* git describe: v5.4.273-216-g82d3ef764065
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
73-216-g82d3ef764065

## Test Regressions (compared to v5.4.273)

## Metric Regressions (compared to v5.4.273)

## Test Fixes (compared to v5.4.273)

## Metric Fixes (compared to v5.4.273)

## Test result summary
total: 102739, pass: 82092, fail: 2618, skip: 17956, xfail: 73

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 35 total, 33 passed, 2 failed
* i386: 23 total, 17 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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

