Return-Path: <linux-kernel+bounces-25762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09682D569
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD5B214D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA3C130;
	Mon, 15 Jan 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tnw5ofq7"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E5C123
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cc7bae27b5so2966817241.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705309044; x=1705913844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4v1AdI32Kp8Z1EODc0dmNDkAUnEI1s57YhrdMHhuH8=;
        b=Tnw5ofq7dMPkzIctKmJNqZ1GLMGCnqhhHnNmRYVERoTn7KFLVV5uIn9Qks8syrfKa8
         BRyXhV4gAgLsGobg5pCknH66rgDxuWzdu+K0oLg0dU/J35LRgI1bDXGtvIGMF6ozhNyj
         rTznATisC3AmT5PL3JyMFZDHMAsPxPnd5TkudVx7Xqb2w6FISqwMwDOGWUBDw3lwbdOi
         MYhnn7AxdHvdFXtP4u7jV0XPScHzlrzJLnvtU5bbiW5a7hSGgRYaaxJu/tH2XpwKJDTR
         llMvHEqtTbqT41FBESWgY2nj+Pg7yLGWbWqLhEwQfO9Q/zFJx53RL3EWHiRMf2cLv9n9
         XJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309044; x=1705913844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4v1AdI32Kp8Z1EODc0dmNDkAUnEI1s57YhrdMHhuH8=;
        b=dmFmgnuJCTp2/M0J+LCmHorfPsmMC9+K8JCdu0Rjv0ifFiFZZY2+7slc7gaP5c4bGJ
         72qg1n8bBJGLg3Ld448TD+NL6tG8ZhWdd2LVXV/qmZsyTJ5meARzAwFM46fj14RyDBIJ
         c/2TVHquB1xskokbvCeu8AC3Ftze8pIZQCFCMKnggMOCJeBDFGTQGkTllb69/p5kUIRO
         AhDT9h675bdJFmDUwCDnm+U04rs6UaiQieKybbEjc3n8flRrFNTbFzqlUp3jQu03Rx5F
         a67ybMwhrt+v310Rb1gRwA+3li0PgpJjLDNIFWAsrbwFyUvHKN/Rh6UOxPPvK/nxmsBF
         lS8w==
X-Gm-Message-State: AOJu0YwT82rxfyBwJVz8xeSeibu8o39MB6HnSGdU/e9J+VGWfqIzT3Zx
	/p1D4hE+SKhA7oMURT0Ffb2mP5zCYDhP/j0vcyCKr4y4sV8zRA==
X-Google-Smtp-Source: AGHT+IHMmYxzI3mAVJDcEJEplNVxfmygp9nd+wcU/5sYY2iOvEMAdLZZg203zoyPOGUGbPTazWIMJJ4PrLmYbvV5IGw=
X-Received: by 2002:a67:e9ce:0:b0:467:ed7d:27bb with SMTP id
 q14-20020a67e9ce000000b00467ed7d27bbmr3166740vso.14.1705309043703; Mon, 15
 Jan 2024 00:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094205.025407355@linuxfoundation.org>
In-Reply-To: <20240113094205.025407355@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jan 2024 14:27:12 +0530
Message-ID: <CA+G9fYv71kU78tJNO-gZ-SRf4aOSgYveudKuyffq8N3-5oFvAQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/25] 4.19.305-rc1 review
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
> This is the start of the stable review cycle for the 4.19.305 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.305-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.305-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: cb74230da5071e4cb54b342a0d079296ecc14a98
* git describe: v4.19.304-26-gcb74230da507
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
304-26-gcb74230da507

## Test Regressions (compared to v4.19.304)

## Metric Regressions (compared to v4.19.304)

## Test Fixes (compared to v4.19.304)

## Metric Fixes (compared to v4.19.304)

## Test result summary
total: 103058, pass: 89229, fail: 1698, skip: 12065, xfail: 66

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 216 total, 204 passed, 12 failed
* arm64: 65 total, 55 passed, 10 failed
* i386: 36 total, 30 passed, 6 failed
* mips: 40 total, 40 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 48 total, 48 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 54 total, 44 passed, 10 failed

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

