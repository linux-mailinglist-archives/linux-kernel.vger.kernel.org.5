Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F47E490E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjKGTS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjKGTS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:18:28 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2610A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:18:26 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7bb44339bf7so812578241.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699384705; x=1699989505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvnZXUeCL8FhD/wSOV9xBez5fYmNyK+0yuVOgsEAsH4=;
        b=aJuLATG9ZP/C+5/wLye/plL1F3W9Z+3Qn4I74h+kKNZVXHISQTvedtA7LHnnDbFtDw
         BAENj7LWDHgT86vh0cEJcaKuN6Bia15LG3CKiE1Dsi5qMrIc29pSRgI7Dy/rPFjzUD8b
         ur3pGdXcgeI9q1BrrO7QUyQeMtj0w+ICLvacZU7BNaaKqhL22nE7IqCtoJz3o7pi7tag
         U8nN7Lb6x7PGAQwELnCicY5NiKtB5D6koAKpW7ERDa5sheSTJvC2jdVuvwXo0BcxBWLb
         POaQlrtbfbjiOJD+LVQmur+VyfHnV0/YBwPWKxdJpf7rH8GW56G7/BwuprVlaIPjtnlB
         wb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699384705; x=1699989505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvnZXUeCL8FhD/wSOV9xBez5fYmNyK+0yuVOgsEAsH4=;
        b=ELgIkECoZDPPdtb7k289/OKBx+fE5QvFwJCW/qvF+wBLjp0cB03I1AMWpOxPX7PgBv
         p5QMUGSjNi5tDUuiHnQGCmWZvDoLNooIJKk+99fNsZgaG50PgWdjgz4wqmdl1YVJL6UQ
         pDSB/d9tyCUg3gh41bebpNWOjJIGgxJgiFqzq9MNXKz+dxgecc3+FYhBK3vGWdkbPyAO
         YIvqeyt53tj42zl/ccxZVAbLoWJRu9fJIKVgfeQNw3h7AmKcw54sR6eunGAjt/b153i8
         XA6N57zu+RWEJeWk4TZc4DWtfTEZEjDW/Klt/gKw1oO5P+iT38y9ka1tX+xV6TvGmPAm
         bo/g==
X-Gm-Message-State: AOJu0Yzg8GVHOjt+07gZI1TvvIikTHoldqs9FoAtGCn6wVQZ3+ZfRLM4
        dasl8DXNY4mQtF2d8KgtaCmm75HciznqGdYXlcePOg==
X-Google-Smtp-Source: AGHT+IFoEKGD38ubwQjgEsqRGCuPvG0XEjqsXZTKxgTt8nqnMXUURC03MKkY+3DBZ4e23cufmAhVlSEGgsKE7bPcg+E=
X-Received: by 2002:a05:6102:3ecd:b0:45d:8b17:905b with SMTP id
 n13-20020a0561023ecd00b0045d8b17905bmr9722877vsv.26.1699384705515; Tue, 07
 Nov 2023 11:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20231106130257.903265688@linuxfoundation.org>
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Nov 2023 00:48:14 +0530
Message-ID: <CA+G9fYvh7PbjPGz6AdPTzZz6_evyUjX4tedoHFb0Je6sYsYWBw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 18:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.1-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: ac6cb619d608d66d3624368b33cf8435168b0008
* git describe: v6.6-31-gac6cb619d608
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6-3=
1-gac6cb619d608

## Test Regressions (compared to v6.6)

## Metric Regressions (compared to v6.6)

## Test Fixes (compared to v6.6)

## Metric Fixes (compared to v6.6)

## Test result summary
total: 140959, pass: 121301, fail: 2037, skip: 17621, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 36 total, 36 passed, 0 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* kselftest-livepatch
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
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
