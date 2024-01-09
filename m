Return-Path: <linux-kernel+bounces-20885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99688286F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544C8287198
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285438F95;
	Tue,  9 Jan 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UriL1/+z"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4C38DD8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4affeacaff9so466423e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704806293; x=1705411093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cif/3DajG4jtsQ0qTwaKjg0wOyQ3Etyfdm3e4dJoP9c=;
        b=UriL1/+zlWx+MTuDLhKbomTpr/0YInks1FP0L1PKUGhyItojuQ3jSAaiVy8qCWiT3I
         gaVGVbDn/oLcbfb7Bk92AODmux68OtZuGt+pfkxBvGRBmxqTP21DsWrMzPlcVX0J3Rll
         GdIHHcZffb1GOQi26MAfdTwqigQF7rKNNRZvbFkP9SrLuCbHlUnxb/0KU70kzwmHEqJt
         YuoZcyYPcq/LlV8FGzOEjiMWAcnqRcK+ssxm90wU1S8C+qc6SCNtMf9eiktYu14oVTD5
         lrtI1CTqnt/8oHc976ayt87ukjgaR73iCKZ6dOeky1SEUAmEkbkuoS+OZ60x+wP6mn6w
         IR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806293; x=1705411093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cif/3DajG4jtsQ0qTwaKjg0wOyQ3Etyfdm3e4dJoP9c=;
        b=OCjE2xx21YkS/VgC2VNJb9tzYp6VembVXcW1MlKemfDmKlz7SMOEbLLOglaVTo1KrG
         2UnaubryadQ++TJ4gzoURYkh2CQn8ciaPuCZk3br+1p9GwrKQQiNmZSt8gnurOzpN8vI
         qKhhHbAxQNBZl8K22vd+avpn1QCMchtpQ3xMc5bh4wasOkk+IHOZcnCdMkLOXgH9WRI7
         PEedLYEgiTxR445q18/ad/8OrQQ5m9nRa+qZfuGxGrn3TWuFcYZJ5RIY7swNbqZ+5+Qy
         W2fW4S+T89ox8PRg+REZzGtVBaNZx9ft0jSoVuyqgMEREMMk53njBW9+7/U3vAKPWhjG
         +FsA==
X-Gm-Message-State: AOJu0Yz5eaWdP2H1fgHIrgrjnIsRM+1GKCtWxMApVJxdScBTF1vChGOp
	VCVEvhQu/eb3KzkLO+1JISFhd2Qd5PubY574GIAfas1LJBrSeQ==
X-Google-Smtp-Source: AGHT+IH5LXt+Nh7II/R07B9c9R9Ins8knoOco8CgCxAlroEKiTrQaN+tk5l0f6ASdirWKUHoFJfummKBnPfXoDUKlc4=
X-Received: by 2002:a05:6122:2388:b0:4b8:ae46:f888 with SMTP id
 bu8-20020a056122238800b004b8ae46f888mr1511689vkb.23.1704806293244; Tue, 09
 Jan 2024 05:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108141854.158274814@linuxfoundation.org>
In-Reply-To: <20240108141854.158274814@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Jan 2024 18:48:01 +0530
Message-ID: <CA+G9fYs8d_tPjTFzZ3E6cb+dm9K=GkhusJkhpfWhR1jTa-mw7A@mail.gmail.com>
Subject: Re: [PATCH 4.14 0/7] 4.14.336-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 at 19:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> -------------------------------
> NOTE, this is the LAST 4.14.y-rc release cycle that is going to happen.
> After this release, this branch will be end-of-life.  You all should
> have moved to the 4.19.y branch at the very least by now, as this is it,
> time to stop using this one.
> -------------------------------
>
> This is the start of the stable review cycle for the 4.14.336 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 14:18:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.336-rc1.gz
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
* kernel: 4.14.336-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 2025e3e69905f3ce0f16202095e343fee09f613e
* git describe: v4.14.335-8-g2025e3e69905
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
335-8-g2025e3e69905

## Test Regressions (compared to v4.14.334)

## Metric Regressions (compared to v4.14.334)

## Test Fixes (compared to v4.14.334)

## Metric Fixes (compared to v4.14.334)

## Test result summary
total: 54261, pass: 45419, fail: 1544, skip: 7255, xfail: 43

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

