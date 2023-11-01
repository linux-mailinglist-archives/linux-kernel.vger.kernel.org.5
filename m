Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886FB7DE221
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbjKAOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjKAN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:59:58 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6399102
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:59:52 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-457c25de456so2635506137.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698847192; x=1699451992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgR3nF6EZLqp/H8kxFE33E+SA9d5i66IyhQCWYiF368=;
        b=EujWtprud9yMrJv4kqSj1vZmlpvwoYbY1djYnuPVjZtLWtTLjF8sxs78Xbn0KAJhas
         r71XTVdg+i8lIoT4RHV95dujb3GRJ4oBUYnsXrWP9aRSJCnJ4WSUNX2tC92VDIAz4Jkr
         BGKsUu0WlL46ZKpXAEbJqv09cYVPrxJOSgsllCwRtiCRDJSmjkvnDd6r0jJsESfuPMLz
         M/5n/JtcgUCJ6J00wG9eWcpmxZly6Nphq6Svos5gn/M7Zlmwt/Y+dEg/3ypMbXbzl+O8
         biCaPINUsT4RO2Xs7pWnoOmxu5rfobuP1eCDjyKYM/8EI9vEScxYk4mErxWl6whttRAi
         9t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698847192; x=1699451992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgR3nF6EZLqp/H8kxFE33E+SA9d5i66IyhQCWYiF368=;
        b=b+EL+dq9b5oUwz+XksjXcRizBCPVN0xaXIIYpYIm1R63/qkz2zsu00Z4UNTDPP5YIV
         G9f8xNPsd/d6B2LT3TFmRprsbmdDNIMKiKkiA0LPYpnS3V6gm8ILHxJ+WsFYmn9j4IIt
         aYObKWspIQLubT7z1PhUyrV15vA+Dj3AYlKcfiG8fapDywMHjSBq3itfu97QAvCkEEDD
         96NDJhi8jHNkkO3w4rvlyLhPM6wpUXFvjRlFN6HBWYndjLz6F0ilDlU0gg5LqAGbr8Xd
         ugouZkZ/vxd9xvfcgjwT68P8QaCc12VO4Xn3gK3fB5RctSWVziQrD4kMCQGGUvO9e6xs
         58Sw==
X-Gm-Message-State: AOJu0Yx4L2Md7tToHSw0bw98TbzxyxuKprGvdwHC6x52lg9kfknOezSY
        Z1jnzKy89snZDV0yy1XoRozvIbJ8bDsG2XvGgFDodw==
X-Google-Smtp-Source: AGHT+IHW8V1lpNIY3CAfyhi0XQek+S8lZMVyeE6Df+lCTa+Lo5LiXqssWb20eDJxfDl2hfODwffDXgN+IOHOhSHe2FM=
X-Received: by 2002:a67:c083:0:b0:457:c17a:d34 with SMTP id
 x3-20020a67c083000000b00457c17a0d34mr10681087vsi.2.1698847191929; Wed, 01 Nov
 2023 06:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231031165918.608547597@linuxfoundation.org>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 19:29:40 +0530
Message-ID: <CA+G9fYs7JCie4Vb2=A2oAVVDHyo6KMv1szqqPzSrE7NS4k3XQg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 at 22:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.61-rc1.gz
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
* kernel: 6.1.61-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: d87fdfa71a8c82a481a41421b387544c7012b21e
* git describe: v6.1.60-87-gd87fdfa71a8c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
0-87-gd87fdfa71a8c

## Test Regressions (compared to v6.1.60)

## Metric Regressions (compared to v6.1.60)

## Test Fixes (compared to v6.1.60)

## Metric Fixes (compared to v6.1.60)

## Test result summary
total: 123155, pass: 104208, fail: 2398, skip: 16422, xfail: 127

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 147 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 37 total, 37 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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
* v4l2-complianciance

--
Linaro LKFT
https://lkft.linaro.org
