Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22578FCCD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjIAMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjIAMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:00:16 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B0B5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:00:13 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a4efcdab54so676712241.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693569613; x=1694174413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHw6XaswM8esmLx/zeyirf/pGRYiAdZHmM1feVEP6W8=;
        b=AT+f4LyMYPwvAjwpVVaTom21jMZS6JwquMJu7YakjtR763lG+/4+Z4zDm6PZcAgotg
         nVTwIFkpFbJ+M+rIDmSRrwKgqBD1BhsG00iciQqTYSpCCHdY5jC6mu6CIXx4xtayDAWr
         ZUuTEQ18gvj2rldYbTmD0irAAhW1rNol53zndWzcdAjp+NYJZIGtPUxbk7F2WydYefpA
         fVqJS/HNrFKcRG0PZxCWWYkpsUUFGWCOVEUZKVn3pNrTKrXC6t5M5xRfk6d/Z19LZVfg
         xYNjt+Vw4fWMiJN0OiWSVUfCNXG/R0VvPLIfUi31oT/y8mCBUecbaB/H2oIOpffijYDi
         cPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569613; x=1694174413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHw6XaswM8esmLx/zeyirf/pGRYiAdZHmM1feVEP6W8=;
        b=OEw4pz9fKnyL4jXXiMg/nN1bZRJoNYoJVHEVRViIw41ZF4t3NHzm8hypWAsskEIibV
         BFBrUZGbFcS+MaL8YhEdM2eXa/SsW9skZL1AUO+FXqdHfwkRImlX303XsoQUS8CdY2F3
         O0gLuqepVsAS8V2DwEsGAfFQldpmPKq3WeIk/ErbdnWVOLdAnXH4x0K4KD+GYYPitAGL
         mPVjwozDX45GC/EBItk5nHTBZNblvvHSKX5z+3tYysxTR4OX02TSuD2+mu0A+g8C5uTK
         Ia0rKsZt11H9fQ0NDo76Dle8LkClveWFr5kCAGQ12hNX7DxOxRbOR60k5FOGena9UJ7x
         GcUw==
X-Gm-Message-State: AOJu0YymzuftaCDEvKOuKbBkhFJ5owiTq72j+X2F3W2xPCnqY1HeiKxo
        qFY20x3029rjRQFif5OmMXIypagzmi9xb2V3d+vckA==
X-Google-Smtp-Source: AGHT+IGhXJSN1UgVgDAZll/j1teCja74pG32QkE2Muh5/UofETl+DKWR0YQRsNVLQm2SPh/gTTGhLsPGLhQa7L0zghU=
X-Received: by 2002:a67:f955:0:b0:44d:44bb:1f60 with SMTP id
 u21-20020a67f955000000b0044d44bb1f60mr2017758vsq.19.1693569611481; Fri, 01
 Sep 2023 05:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110830.455765526@linuxfoundation.org>
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 17:29:58 +0530
Message-ID: <CA+G9fYu3ick7NcMgkVdQA=ujkLs0guAuWezWv7HcYF9rrtnYhg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
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

On Thu, 31 Aug 2023 at 16:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.194-rc1.gz
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
* kernel: 5.10.194-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: e25611a229ff9e907889923c2702d817003bc228
* git describe: v5.10.193-12-ge25611a229ff
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.193-12-ge25611a229ff

## Test Regressions (compared to v5.10.193)

## Metric Regressions (compared to v5.10.193)

## Test Fixes (compared to v5.10.193)

## Metric Fixes (compared to v5.10.193)

## Test result summary
total: 97983, pass: 79078, fail: 2772, skip: 16068, xfail: 65

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 112 total, 112 passed, 0 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 25 total, 24 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
