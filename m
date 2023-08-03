Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBBC76DFFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHCGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:01:43 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583EB2102
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:01:42 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44768609e0bso277711137.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691042501; x=1691647301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTAvkzB4Ruit3rntKyDlDPed3Oi9TQUtJNoUU/ZhAl8=;
        b=PfVxs4+Xc213BkTNTnD6vTwb7WtfQmQp1O1Sh1fHubRexnp/gKMnDqrUuTCeamx+zr
         Lg0bsOkWTmiVSp/y49iF9SDjkA8qn4rMUOLm+ikuObl7raaGHWLLp2l2+uaWhfzAC37e
         gu8Ql+9vEuDqomrruBIEHquTXZDtYsXw0g5CifrqY8hQbGdMy39XsfnEFeY2F084/AW6
         8rIvK888cP3pGDgtDgxk2rszGfK3b6Ww+5jSLTXcUrPGp1y60tAcuQRFam9PIv/3dv4m
         jzH3EjzOAtdlJqLXs2/dTAXA8zaY4jei0Ne/oPLNU2LxmmBE4VMZe9NADKlft7UOTAww
         gm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691042501; x=1691647301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTAvkzB4Ruit3rntKyDlDPed3Oi9TQUtJNoUU/ZhAl8=;
        b=cW/sCtUAhpw9OI30kVRCUa6G/yCEMxiFbxBDpxc/yqhqLl1qPeoek60VGs9hJrrwXJ
         +0mrhHelvbZ5dN6XhPgLV/vpzDSYDTyyNt7xBn3QHPkMiNAT2r9XvR8LMo09Wcik8WMF
         MPfDFYQk8KNaT4fN/7IN5SdTtfhbOAAzUunWSHcVAWzcY5CR2S37hMkRkPMIZoLpN7ic
         YauvUrZx8Y1YKSDVHD3VDF+D/i0HpuTHY9ArKR9gk3d58j0O2OIezEz2vbgaDV+WbU5V
         VNbHd1+Gn4s3rg5K7cQCKo2NCT4vnqErHh2/yUacm+wd5SfMyPHaIPiluWa5eMQwlF+I
         1j8Q==
X-Gm-Message-State: ABy/qLYE1klnX7A+SjQq5PeNkL0wq/ATZdUAfUshY5swxCrV3LXadPNr
        WXN96/ya1+eiKUb0MUD4nqtm0BwKznzVH4TTJDIq6A==
X-Google-Smtp-Source: APBJJlFpEUe3y2CjvvROKYgqXdCQz3t9w1FcmBD7CKmNTkk4zKfssSQ2asisIONnGKAmaMOfKf6vtex9VmIgbDDNmJ0=
X-Received: by 2002:a67:fb09:0:b0:443:7bbc:e397 with SMTP id
 d9-20020a67fb09000000b004437bbce397mr5674059vsr.26.1691042501194; Wed, 02 Aug
 2023 23:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065510.869511253@linuxfoundation.org>
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 3 Aug 2023 11:31:30 +0530
Message-ID: <CA+G9fYt7d3Ogj7rXZboJ5RtXVTd-K0_0y5BDyfdSg-VXL_3QbA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 13:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.43-rc2.gz
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
* kernel: 6.1.43-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: bdcf4e82a088a0bc7c5557d08d0c86c67bbda149
* git describe: v6.1.42-226-gbdcf4e82a088
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build=
/v6.1.42-226-gbdcf4e82a088

## Test Regressions (compared to v6.1.42)

## Metric Regressions (compared to v6.1.42)

## Test Fixes (compared to v6.1.42)

## Metric Fixes (compared to v6.1.42)

## Test result summary
total: 157013, pass: 134713, fail: 2871, skip: 19242, xfail: 187

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
