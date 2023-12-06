Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2D8070B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378455AbjLFNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjLFNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:15:30 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80586AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:15:35 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4b2cdf382d9so1161357e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701868534; x=1702473334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39DggU9sTHpsnUoWZEmvwMwfR1yAMVP7JXWAH0X6msw=;
        b=ywDDwgjnWhxiqUqp7rC3rTFbMPbtnjBaIUONzH+D7a+Pu7/CenFHTZjnDEFOE1EInA
         wCCblupu+FbZhs4733xh+tNZ3CilG57sH1oZSSCfVIq55BVrF5S9CsdtIakoyS4jBMtV
         NwVNSAsPunkG8Y0yne7EcS2ff7O7xkUx1hT+htpdpLZg8y7V1ZnKLY6FDlqC5WedcYel
         jCr+E5KZQJVlyHkbNd/1sM5f7CG6Iw3OmESUkgLA4014k9mGRjE2dK/aJ28Wzt2R/r5D
         LmOZWlC8IGRxy+hTZ3yoZIb/nqXupfOiFRiaHJmOmxReaAExbLx4bhWbbSE+WGoP8yoL
         kqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868534; x=1702473334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39DggU9sTHpsnUoWZEmvwMwfR1yAMVP7JXWAH0X6msw=;
        b=QF5x0ypUhpdG6FCECMe2YFI5hsyXx4PTFk8mTDy5qixBMAx++pbpz4LKP0qUjEaQqY
         LX0nh3PbZTsgej4+GKgv+ilq1sFGfBnyYgo8Z5knnZS9rBbUedlUgLkiU1wyk8EBe0aX
         rSPoXKvjrTMjtmhsfvuzoT+VCdPLImZixjS0Uod00HXo3Q3M71u07EJZgd9UGfWjvRHH
         aVHP/DgdLJptJhn0u4866YhJxKDMEsvIAQxeII2248R2Og1EVJeE3/a0UBsNdpOEH5FN
         2c+d+SfKdFO5I72JldyW81IYXwrc1TlzKdbhCw8tCwdcPkcQtIn+96j+buqOKWI+jHgQ
         IbgA==
X-Gm-Message-State: AOJu0YzdJyjQcKJuMDL15tO1LONcou5aEukkkBE6j76IrY3uWsFkKA23
        kBI8QRuxOm/KcIARQkyJBBo25GE9b2s0w8FaMdXmCA==
X-Google-Smtp-Source: AGHT+IGx7fu4jijoKMqQ8y3ZfqwsaN43tRyxC36L7eMmwuNg36EnQrysFEpN8/HA5UKrzboEFzI7wVyWWNPTVvryF6w=
X-Received: by 2002:a05:6122:1782:b0:4b2:c554:fbb3 with SMTP id
 o2-20020a056122178200b004b2c554fbb3mr807554vkf.21.1701868534305; Wed, 06 Dec
 2023 05:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20231205183241.636315882@linuxfoundation.org>
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Dec 2023 18:45:23 +0530
Message-ID: <CA+G9fYsKJfHPS2NgRkg4o0acA82eGreFLRtm2ZuGZbi0A4TeUg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.263-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 97430ed51c915b4a8037655ac6656a644fd42e9e
* git describe: v5.4.262-91-g97430ed51c91
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.262-91-g97430ed51c91

## Test Regressions (compared to v5.4.262)

## Metric Regressions (compared to v5.4.262)

## Test Fixes (compared to v5.4.262)

## Metric Fixes (compared to v5.4.262)

## Test result summary
total: 90072, pass: 70700, fail: 2384, skip: 16945, xfail: 43

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 129 passed, 19 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
