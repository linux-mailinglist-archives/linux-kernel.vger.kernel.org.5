Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49478F9C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjIAISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIAISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:18:12 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86166D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:18:07 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-48d0bfd352eso652924e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693556286; x=1694161086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+KKL+WFIFHs2TSwkta4cDHNYwLWptckS2+uJrcQGO8=;
        b=aY8xm17NYuQJ6clYVKbwMvF/Uw2TvOe8CXDTXeoEUDpqHyngc0vCkIqqAA2WBP3tOx
         MIOAXJTP5qX5/N5rUa4QffyXgMlcfSV6JrfeIIdC0lv0uqc+cNtlKIpYWTuoUPOmEqIp
         /E2Mcj7TVnA6sfg1m63WXBwS33LE1BVXIiwc2lgcITUbLOfOMRlsKyTDd2EHI/f8RpoT
         toYn1laBsfzdfVO+SrW1JCUozitF/4DGKnckD8pJ5djt8W2rbFxKfpXuqvJ4uuY/rpRd
         ezla/HiBJZ0D82MLu8pSIKECP/VdGU7TAyFO2HJxVsV8o1ovl4iKivMw6zxXOCzKdqEX
         oPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693556286; x=1694161086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+KKL+WFIFHs2TSwkta4cDHNYwLWptckS2+uJrcQGO8=;
        b=dFBq9otLlWfj4PIeO75YkDLPdmtvUuvKzJMcV2P+iohyqK5owBFcEht5dhIGLSsNT5
         EbmraThQVACL1k0FsXR6F808oCSMavXOfcLUVEy0oIPiX/YJzBdwSr5SMd0E5v1w6fuM
         0fZyJRJ+R54sM2KcZCOiIuIIFXdrW5V0GbNWww1tTrGdZ2LbRi6pof2ZouvwR8+UPx5V
         +1zpN+/OCyjgpDrsjCeFVRBL9EPq/vh4a+XE0KwkqAT5RCRZcME5HILCrLyEqn7mZZ+v
         PPVO4/0f0gvEGzfR5JLHCOyEvGG9Z1VfcmvocgNFJswN/fvFfGMsazevy1YNnP9BvhBf
         Z0Og==
X-Gm-Message-State: AOJu0YxV0EX+F2nPh5o9kO1DicBRVN1K3BamJxXlL9tsCmr6mMR9GgHE
        q4MfzkWGImQO1BXfuX8ExzGhQp94vgwPtBexCQcJ0g==
X-Google-Smtp-Source: AGHT+IHFPQUKt9qsuwJKT3ZWlOx8dXC8j9SqrsOuIVXsAlDAhky/xIIJUVxlRG5/dxM2PISpB31qnwSzJUYjx+SW31g=
X-Received: by 2002:a1f:4a02:0:b0:48d:2bcf:f959 with SMTP id
 x2-20020a1f4a02000000b0048d2bcff959mr1902993vka.3.1693556286477; Fri, 01 Sep
 2023 01:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110831.079963475@linuxfoundation.org>
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 13:47:52 +0530
Message-ID: <CA+G9fYvNKR3eefurkQQGOjF_6xzsGQK1TWDaZuFgTdw28mdghQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 16:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.51-rc1.gz
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
* kernel: 6.1.51-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 1767553758a66ae5cc765f89bc22c22273b382a4
* git describe: v6.1.50-11-g1767553758a6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.5=
0-11-g1767553758a6

## Test Regressions (compared to v6.1.50)

## Metric Regressions (compared to v6.1.50)

## Test Fixes (compared to v6.1.50)

## Metric Fixes (compared to v6.1.50)

## Test result summary
total: 136400, pass: 115230, fail: 2624, skip: 18376, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 144 total, 142 passed, 2 failed
* arm64: 56 total, 53 passed, 3 failed
* i386: 37 total, 32 passed, 5 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 15 total, 12 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 45 total, 39 passed, 6 failed

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
