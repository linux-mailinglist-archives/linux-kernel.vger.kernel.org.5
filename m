Return-Path: <linux-kernel+bounces-25790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24082D5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A7B281ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F54F9D7;
	Mon, 15 Jan 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPj0uVZI"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D67F9C6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cd42bc0f1dso2303036241.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705310660; x=1705915460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh+LNMWozo0J3aAZgCisR4oMBODsHlxEIqXU2tzebT8=;
        b=GPj0uVZI7UqNvkPenSbX6stVa/Ah9Cbc1Bz64PC1s69I9SncVxAsVj1UQdpMpD2cE2
         LN5kLGBaJIBSrkjW1XnMPpfp+UpBCpSyiFAP2zFR33nEdgxL57wqH1A2VU8EIaA5q9ab
         WYotdIrpw0Thrf92Iiso5VqmjBvSf/n0Rz6FQiGpMSP0PZxmMFvsrBhLhIWWiEJphBzX
         e3mJoRdGXm0rzX7avMnvSDZOQM2afFmMyG/05dI9eX1k+Pop27fpAjUBVFBO/DQIDiGP
         mqkvk8rqme6H7DHK5df4I66P26/RDVLoeF5EE/n1fG7Q3nYtC1O9oM2E8ZD7aF4vnbky
         aloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310660; x=1705915460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh+LNMWozo0J3aAZgCisR4oMBODsHlxEIqXU2tzebT8=;
        b=ODcKXTgxZbmOplMzrCx1yf7QAOeYZUZf3fK4+VDUosPx2TEiLMIljLDRUb7ykHJ4eM
         AIfPlSmJJM/KGYrCGiFCS70O8nTKL0QmTqgL5gY4nfY5zjMvVgVH7KG9c/3oJL+3xPgG
         tnktVv7Y3TV6lQsp+J1lawQR7v95YzgUH7xaYfPCUE7BhJY0zyGyk64MldCqJyDUCSOC
         kGaJZ3ZBPrM3ydA8Mt0CGfH4V7ejEnnh41dvy66BGOMIoCDBuIZbPJBABu01C8Et6Uq2
         AJPffg6cpic84/hjfS3vaSxF5C4DoEDRz/ouk+GGfw6rdTIeC36+3jH9XtTLZgqHZimh
         ud+A==
X-Gm-Message-State: AOJu0Ywj+/CJC6k4aM7wzg262Bxg6KpMOjw89wX/xEWEFlS4YmFRSW+k
	sxpnOcCHJpFLD+ZQOJ96drK9R2YpfQeah/uJzt4nNJKyf5CyPg==
X-Google-Smtp-Source: AGHT+IGTfBZ82YCdI7oc8T+p1JxA3rHRkpH5nuA8FLd5dC/vBpmXIkg7gkwgSvsrDaptlz8KQTrUhgjeNSVqriVRcsM=
X-Received: by 2002:a05:6102:21ba:b0:467:dd9a:b1f5 with SMTP id
 i26-20020a05610221ba00b00467dd9ab1f5mr3593591vsb.18.1705310659736; Mon, 15
 Jan 2024 01:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094206.455533180@linuxfoundation.org>
In-Reply-To: <20240113094206.455533180@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jan 2024 14:54:08 +0530
Message-ID: <CA+G9fYtjSMDFywbNMZMoc2ZaXQ0kg0aCeOHEW-xe627PLFkpNw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/38] 5.4.267-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 15:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.267 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.267-rc1.gz
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
* kernel: 5.4.267-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 86b133f1f903a253af84a135ff1afeec162143e7
* git describe: v5.4.266-39-g86b133f1f903
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
66-39-g86b133f1f903

## Test Regressions (compared to v5.4.266)

## Metric Regressions (compared to v5.4.266)

## Test Fixes (compared to v5.4.266)

## Metric Fixes (compared to v5.4.266)

## Test result summary
total: 176285, pass: 139633, fail: 3376, skip: 33179, xfail: 97

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 285 total, 285 passed, 0 failed
* arm64: 81 total, 77 passed, 4 failed
* i386: 51 total, 39 passed, 12 failed
* mips: 52 total, 52 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 62 total, 62 passed, 0 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 70 total, 70 passed, 0 failed

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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

