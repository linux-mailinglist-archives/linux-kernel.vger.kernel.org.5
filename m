Return-Path: <linux-kernel+bounces-4756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897078181A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7838B23794
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18270882F;
	Tue, 19 Dec 2023 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYZN5Tx4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AD848D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b9e6262fccso2943506b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702967938; x=1703572738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GFqnfofMqxUzHZeJ+pdvAkPqe+C77/YREn/y9UKg0M=;
        b=WYZN5Tx4m/qdtiYmYdPvsL9nKTwFyysom/bAE5Pf6fZo4AUY82P3Q9eLagRKJfHV1W
         4n0sg30CX+9+hMDkeKVGqRCwZfKU3HuHbufC5MW9PjtY64aJdfkGm1VxuxP2FArhxlqu
         TnA0AbIAVVUs7WZ9sgu/5xAMg97CTA/bmJOzD8ANGOVjhHXDQC4tKT28LM4ZEUJOGKQP
         bw6DVCEA7usHQiw5Omoiw35V2dW1V0P2Jn9uAyRAHJfPEaRBBZMwRKsvSVDOXrmkGsuw
         8iHjXcyhEzo8WLu4WbKfdVrMZqvdDkkbhzw0zd0fsBkOr4d0HffF+4vZONqeoU84RFYP
         6dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702967938; x=1703572738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GFqnfofMqxUzHZeJ+pdvAkPqe+C77/YREn/y9UKg0M=;
        b=GM//FmSozRIb2zpb6Ex4fLEIKM1HqyYwMdkG5YM+/FVQfLBw2QuD6uBmyBTZnM+v05
         soNQC5GOjmt/XF/vTKYPcmHEIfGYdgV6YGVRJYj6o42zzqPfr4wFQs6SlxmQsN66I2o4
         mbkXei35meFeyLggDGwlBK7siF5ykVpZgz5RmYUXZQ0SiKAdOYc0Gkj7+H5XRnqWFWjw
         X+mE45jUmfwIS3cLD4lhfFsqutTEfm56CkkvSMqb/vI69dLjkz+gHNkE73qdxaUFVw1w
         UWLFq6Hyc3yAqVvwO0LppZt7tG2qlBbCGFSoSYP6TXy3K4drgbmG8TMfhQZAgBXSpHXg
         TNjA==
X-Gm-Message-State: AOJu0Yzfag5zUDp5apPSPCRWwLU0p1OPlTI58KCapAf1zTxaxlMOZl87
	7I0OFv1/qI6paQWmku9e1giFalfEaMSApfxgPjqQqZwMf8rgU6O7pfo=
X-Google-Smtp-Source: AGHT+IGq1UxOojvImxHns4aOiFYkbL1QZnk6+r52TQDjKdgbtWQcbSVJE7UyxDOo/83zPKJzsDjGtHh+8uuuIP/ePOM=
X-Received: by 2002:a05:6808:170b:b0:3b9:e21d:c6a1 with SMTP id
 bc11-20020a056808170b00b003b9e21dc6a1mr21264963oib.86.1702967937702; Mon, 18
 Dec 2023 22:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218135040.665690087@linuxfoundation.org>
In-Reply-To: <20231218135040.665690087@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Dec 2023 12:08:46 +0530
Message-ID: <CA+G9fYv9bTstRC944xodispw6dV7cjezAh9J_-XpQ=nVZUYgQQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/26] 4.14.334-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 at 19:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.334 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.334-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.334-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 2461d9a65af242d126575115a4f8fd0d26e737c6
* git describe: v4.14.333-27-g2461d9a65af2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.333-27-g2461d9a65af2

## Test Regressions (compared to v4.14.333)

## Metric Regressions (compared to v4.14.333)

## Test Fixes (compared to v4.14.333)

## Metric Fixes (compared to v4.14.333)

## Test result summary
total: 54491, pass: 45633, fail: 1624, skip: 7190, xfail: 44

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 103 passed, 5 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
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
* kselftest-user
* kselftest-vm
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

