Return-Path: <linux-kernel+bounces-131780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5A898BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EE4B234DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CE12AACB;
	Thu,  4 Apr 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcMDG/XI"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198A1D531
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246547; cv=none; b=H928ZSohs/d5vJ1Dntlqxpb5pmUgC9Xi0M1+1vLlTpsQyqAMAbKIG9UeTsj5tdhMN9k765BHKbuG9ID2+iNwKSdwP2WJA7GpK9vCLEljFTWq3T/BMbNPhufwXOUswDUgZcn+4ZYJ7VhyZB7DZ6T4FelI5PMizr7BoYdSH6biSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246547; c=relaxed/simple;
	bh=IDmK4uUx+wlhYuF9PhOMx4SNKC94RvhgZPZnyTimVd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt2A1NykDJPsAjFO6T3nPepaZ4aKCHXZc95yFh089th185bXQpsDYrsZzScHT4SeUhhwtVh2Gnn1w9pIaDvPxOegIkb4s6D//gLZ/ENoC/pM3Zpjl06FSUbgIBFd7gGJliN+Rg0FdSl3+8b1neFAbATi0tTmMYv/Nnzo7TzFtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcMDG/XI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c3ae53f662so698122b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712246545; x=1712851345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyg0hXO6E2q0WJvGCJ4GruXSk8RIFkv8agNThby4pB8=;
        b=AcMDG/XISKFoF1V2Ctwf7jxVoaY3qHUhLjEtGMGEjnw2LexCnSQGUiPa5W/gqmgx2+
         zPyBkFGUMgVDTP8ie6TSpnwfg0DFr1uEcV1aMD6IaP+LHt+vRfGsYjFe88DkU63vCnCF
         FJ8YVjgu1fWYauJSQYnMa+hTW3NLQTxi0FBUXhjVG3xjDFtj0qajB26C9/dNMGCZkhO1
         DkNoHH+nxjBTPkk91xDGq3IJCDvaAlO13uS9bvHoL7zWUk9dEkJA8JMyckl4w3764l2K
         t7HLlW+JDm9OBhpm6+72OLMJwPMSIlrOGJ1Woih2Si+pLbWKiAKKlBtdxrgL2zPt/vlw
         rxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246545; x=1712851345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyg0hXO6E2q0WJvGCJ4GruXSk8RIFkv8agNThby4pB8=;
        b=A65qElzGVn+VqnZPqvtrR15QmX9lFlpBNxxM94fG4EfbvML89aTYmvu145f7dKoFTC
         mRH+EzNz2IkCIrjB3tMPI/Mip56L8VY37lv84rYoTyJGtbGq4I9ypa0ZjELHBebZ0ynJ
         Lbm6txUrfpAlcZLEY3HtUs20ovW9Hh9JAMJzBE3ld4+c1bcuL25XSCzNnq36OE2OodDN
         Kza4per8gjxTMiAcP2Cbh4pcqiynaDuGWl9vNr3yX42oop9V/2SYR43jX2k5YARMWOLJ
         72AdM9RdUQCD9dokWLGv/3OCGMVMaTxFw4gm5YfesrGLXu66X+BLXOyxJO2FudcQA3hT
         s8eA==
X-Forwarded-Encrypted: i=1; AJvYcCW2JSBf+fr4BxbY9vPARFwVWUDDVCFmjNUYLQ2AV+jyGXtVQ1rOIhGqVe1I4stXOMFH2+0oR3/i10KS3Nk8JhOb7XRlRrREi+G4fS4Y
X-Gm-Message-State: AOJu0YxB8Lr5ZGK1BYX7YBEld+1W4a3Ry4d3H978xxrCedjud5UvDRfJ
	9gTx0UhlNlkrJkvS9Y+DRdHBwGx6Br4z89T2k+NaGct76zlehKu05diliDVxSpvylcFObJfh6Kq
	7Y8C2FrO6+RZWfa4Udg53JXV75hIjdbYvp4PBGg==
X-Google-Smtp-Source: AGHT+IETeM01LKgtRA5QxmngBY+AiGddknDgFaH6sHiUkiZ3j6NX5/O4k6goqx+540Q0XQLpdJ4lUYtOQQqMdbI+NaI=
X-Received: by 2002:a05:6808:14ce:b0:3c5:b4a9:41d2 with SMTP id
 f14-20020a05680814ce00b003c5b4a941d2mr3398838oiw.3.1712246545200; Thu, 04 Apr
 2024 09:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403175125.754099419@linuxfoundation.org>
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Apr 2024 21:32:13 +0530
Message-ID: <CA+G9fYvRA8N00SPa4nNMJybv7Z6WCVgS24AwKW7+2kOmqcm5Fg@mail.gmail.com>
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
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

On Wed, 3 Apr 2024 at 23:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.4-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: c4c57420c666b4ef4b77e6600f062bd5e631403d
* git describe: v6.8.3-12-gc4c57420c666
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.3=
-12-gc4c57420c666

## Test Regressions (compared to v6.8.2)

## Metric Regressions (compared to v6.8.2)

## Test Fixes (compared to v6.8.2)

## Metric Fixes (compared to v6.8.2)

## Test result summary
total: 148875, pass: 130376, fail: 1350, skip: 17015, xfail: 134

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
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

