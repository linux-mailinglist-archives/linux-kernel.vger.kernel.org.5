Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3978678FBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348958AbjIAKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjIAKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:37:21 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6B10CE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:37:17 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44e86f3e4b6so716738137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693564637; x=1694169437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By22Tx+4MEV+7Of0ErWpRw96jGJ21LY7lv3lfDuB2xg=;
        b=XWjPs8cioxVoc0+G/Y3ICaiP8Ed7b0x9jfR9F3gG//BnzbWJ592+W6jBKljBHFBZoe
         w0700v7obPjc4gKQYDK3usdHzzHvUs9GXi32xkzkHeETZcw2wv5nrssWKxl/sEDfnYgi
         7FXekxAv6ZI5mYvsiNUjvEpOkZfPtRZJcMSrS6uCl2fC+z7A6Z00PfBDCDF1MdbhReCu
         jWSCwXiC6bdOnBKDsjyIpDY/eS5ne/YsvhGaDIleX6S/EC4GOa9T5LL1bylDNE67XQWq
         h3/W4glwo1v6Kxv6do98T2lil/MTcnphfdLi56NzJP8uHHW5t0HlXMAOsMJjKSqYfbbv
         x9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693564637; x=1694169437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By22Tx+4MEV+7Of0ErWpRw96jGJ21LY7lv3lfDuB2xg=;
        b=HInLWMzGGBESkTZkh3SqRqczJPhPDBouPUqXahxKEUwD7NEBTEehmeqTucqtauVFnK
         dni3STn6WMd0tJkgkM48x85G1f0XMhwytUsUfGk5j5Gt4AoBoowlKHbAUxoc4+46iPkY
         tiE0w2fz6s2IrZvM25MrjMDHcE0gVRiFeiR4U9cuMp8BHRLwb1xipqbGqe23Oizs7r7L
         ZwSY1yQckKSQe7b0w6PbBJkzT5nGu7/vz+xxzMH8B/CzLJs8LpHK8dXL9QWkDSNdI7bb
         qpckugQrsQGk7W4C0ZhmuLGzowG/CfabRnq78JwSzbd+9pcFXlLNqieGPAO1TlabxpR0
         uYrQ==
X-Gm-Message-State: AOJu0YwwD6HM+Gn+0ZY2GP+4YFzvpvsmfr/4haC8fszKFClvuPlLAbKk
        KxcrfFY/bOM4yKqvr91fdn2p0+oJWk+rkxluxk81RQ==
X-Google-Smtp-Source: AGHT+IE7lEyyDoV/RZpZXd6eJ+r8IZziAmZ+piOc6EX+epOQYcrFjKSeRhEc8lXGEEbQi5iPkRo0veUH97TDlLiO3qM=
X-Received: by 2002:a67:ee17:0:b0:44e:9afe:c5b9 with SMTP id
 f23-20020a67ee17000000b0044e9afec5b9mr1919784vsp.23.1693564636692; Fri, 01
 Sep 2023 03:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230831111127.667900990@linuxfoundation.org>
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 16:07:05 +0530
Message-ID: <CA+G9fYu--P1R-NZuJY+eyTaZhNSbAPr=n_+XUuDBO+O5jqmeaA@mail.gmail.com>
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
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

On Thu, 31 Aug 2023 at 16:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


NOTE:
Build warnings noticed from the previous round stabel rc review
of selftests builds.

selftest/mm/hmm-tests

hmm-tests.c: In function 'hmm_dmirror_cmd':
hmm-tests.c:187:20: warning: cast from pointer to integer of different
size [-Wpointer-to-int-cast]
  187 |         cmd.addr =3D (__u64)buffer->ptr;
      |                    ^
hmm-tests.c:188:19: warning: cast from pointer to integer of different
size [-Wpointer-to-int-cast]
  188 |         cmd.ptr =3D (__u64)buffer->mirror;
      |                   ^

gcc-13-lkftconfig-kselftest-warnings
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2UkQQWqmFIIBO5L1w=
qgonbqSDS0/

## Build
* kernel: 6.4.14-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 499afdc4a89911a65f5710838c78fbc857919b7e
* git describe: v6.4.13-10-g499afdc4a899
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1=
3-10-g499afdc4a899

## Test Regressions (compared to v6.4.13)

## Metric Regressions (compared to v6.4.13)

## Test Fixes (compared to v6.4.13)

## Metric Fixes (compared to v6.4.13)

## Test result summary
total: 138855, pass: 120145, fail: 1908, skip: 16631, xfail: 171

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 140 total, 138 passed, 2 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 39 total, 33 passed, 6 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 24 total, 21 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 45 total, 40 passed, 5 failed

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
* kvm-unit-tests
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
