Return-Path: <linux-kernel+bounces-142977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A88A32D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6C71F221D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12814882F;
	Fri, 12 Apr 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TELDWgjK"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E31487F2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937066; cv=none; b=Zo3/w5gFYADbgWaGzgERuTivXKj+LGQlt6+GZq39R4+b1E/y7ptCoGxtiy7f9+/maH4MONrVJJR3l+orIskddEisnxRsuMQR7BM45DC/t8QU/93ErVkklhgD8vNYMXcfgFlzU4HB/V3oW1mbHblSww9IS75gInXdsYVLBCjd2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937066; c=relaxed/simple;
	bh=N2PKhKVj4vOuIqthZ0upvvRLqO7t9Ims4RxMuplTs4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXmdxWIO4WYupfdEJ/yUPXKNEA/npSSWdqMRn1flgwF4DmnpA6Cy+kNz25TjTtjzN35/Z/SJ4bhQGoi/G7jjgHnD1H6Sq/pgo2SQc1wey1zqoDg6AomOKZuwDYkCt73zThNw1c9DVwmj42coTnFtUD3HRcouDu94W5JxKYu7LZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TELDWgjK; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479edfd02e4so374956137.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712937063; x=1713541863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92R7Tt002+szgQqwlNMaYrd6FqA0RwfRXhl8UHoQOco=;
        b=TELDWgjKxeoPuBwtW0IdPjb1bG6wpDq/1cbMuniKikgmzkyf8dqlRL3wOUDPPEbIGU
         5T43CGmDpWEK1uteGhLOHRJkr3jpIYRMUpAbVowvND6bEjopTzbfVGHVt/QxASqTcFei
         V79GSpvVr8LZlirxgEz5NUFo7m3f54ZuY1w3QoVrN4UNa53HCmb1AwZmHdH8pEG3KSnA
         EYBliBhY/9rfKfiYb1uKVEjZvBbFEf7A5eDyl3JESRRXzZpB2pwiUmrqwWITAWjVbkMN
         T+EUzfW+v+TtF7iqX1ntK2ReTR12ReOju64nYSLFAPXjvTc60hpdQetuYSXPnRR6UKzf
         bV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937063; x=1713541863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92R7Tt002+szgQqwlNMaYrd6FqA0RwfRXhl8UHoQOco=;
        b=jGjKvrmBwANY7iJfb8wV4QBTFzvJiqDo+V+MoowHX95fjqNatfGYNDXqJkCPQKOBl/
         Y5Hfjg7XHe9HL39ordR3YuaQRxsaHvcRNncdmRLfrkZKfe60ImgGRrrywmNdbDW/ErJN
         sG6AAMFCY7idw3CKCTsJCtAePklj/xCxmHLebF3WH5E1rE9J4LJzgWYCQcveP8SzKLCS
         n+3DKvjx1q0WqxRD9Gl2aqRpNHeIb+Au5vOTPpEDSXoCQki2wHgwgGiy5H/JkYvzHLYf
         8eejRFoPnogk6NgA8Zr9LnCyDxRPzxLHsNOiHgJkPTWB17PGZpjEzkAGvkgyYS9rvFIB
         IK+w==
X-Forwarded-Encrypted: i=1; AJvYcCXpjfPzhVu0SaKLXiy4WZBkj/RNDM0FcvKCrGPNdRNKu6pGmGOxltKVExjCw7S6wT5Cgv7wBaxwJ+Qu1EfBg5QXJdvrgw1CtxLyS5L+
X-Gm-Message-State: AOJu0YwIgD/fHPqS65u1EEu3PLsC/1G2Eo1v9PUflArMl/MKLu0lcvjV
	2RnDR+dCIG+TbaIfY79eJN8UDe60osA0MWoctqOOA/U40OVsyX7GQCiRj1SRJ93nHCv5s6LWfxY
	dSFVX7n+DYPfrIDFimhBVg95BJGNdAqZrOQkOpg==
X-Google-Smtp-Source: AGHT+IE5gWWw3tzQD7rDayWyxRVTVHjRobGJko3lvmoSOOqVtUUWsz435Qtri/FpaqKsxh9mMM5R1F9iQ3Ac1+c45bo=
X-Received: by 2002:a05:6102:38cd:b0:47a:28d7:55ba with SMTP id
 k13-20020a05610238cd00b0047a28d755bamr3842878vst.0.1712937063266; Fri, 12 Apr
 2024 08:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095435.633465671@linuxfoundation.org>
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 21:20:51 +0530
Message-ID: <CA+G9fYt7okLBbGsSoA=Pyv2aVKmFEvttJywmJEUJ+FDp1SA7VQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
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

On Thu, 11 Apr 2024 at 16:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.215 release.
> There are 294 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.215-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.215-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 244ca117cb3cec4bb8f936b136312bb8482eeae3
* git describe: v5.10.214-295-g244ca117cb3c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
214-295-g244ca117cb3c

## Test Regressions (compared to v5.10.214)

## Metric Regressions (compared to v5.10.214)

## Test Fixes (compared to v5.10.214)

## Metric Fixes (compared to v5.10.214)

## Test result summary
total: 94495, pass: 74097, fail: 3307, skip: 17023, xfail: 68

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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

