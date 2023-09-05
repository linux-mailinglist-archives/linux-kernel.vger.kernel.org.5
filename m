Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF80C792B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjIEQqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353882AbjIEI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:28:47 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E13CCF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:28:43 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44e84fbaab9so960012137.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693902522; x=1694507322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLVlLYXm43et59ODiKK6ekSSR9heDIXhgIR04XcWgxo=;
        b=uQrEEXnxuoU2H1wi1LZ1zuholBNmIFo3tqKWertwgDjUHIhQQcqsZH/T9KWhxrkNOe
         g2f5l+fKiQiGjh5+Nj5GKDGwQgwo/pi3p4La7jWhLvYUqIc+SN3AYGkiLqPqkWMy6LDw
         6xURt7Uqe34FtIONJ4rckFDVxso4J3AFUn6AhWg7CYhP/SdmUCR4ZetU7ZquGmSk1f1q
         hHqM1PwTEelJhPtHbms6wLnAPkLtLeCxR0+Gvll9sBLAzC4fOuWST4ChzeYhkwznNXf3
         EoOrpXd1Yw+ovmsYxi8cnZVWFH0/PvUPBqeeCwS2otZOEtW6fogHTnc1neXuSxIhQYLN
         bk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902522; x=1694507322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLVlLYXm43et59ODiKK6ekSSR9heDIXhgIR04XcWgxo=;
        b=fq2NDP6gv2GctotAC3ELaeC2CgXmRVJDD2Dnt1C6QMg5a1lR5P2zARmlL4Pqm+d7jD
         CvutxfUAZImAyaUEY1jjxXW/2Fr7udS7O6Ezaq4KU58AsAxDvn+7jUrY6uPsiUQgVHAa
         YpHZC+4hAMBLLcJrdwooSksl1P8jBdnkOz+ZLW64J+BK50phzbjJLtpPzViGhKWZs42k
         X9JRlDkjd2RIJOqIgdE8jtjMtFBfnOfb/fjmvOrTECmgbtb6/NaG4YrMv1ZZCL7EeWs8
         cn2zf4C4exEqihcBq1spvuEpQYf5ETPZTPsx/jCZKLBaMWazGxQXo8dNBAG0+s7tL4Et
         tnGg==
X-Gm-Message-State: AOJu0Yy9TqcKkmQRyXSzxwX7ULVgeP08eSAutHJdoY/7anwvioFJeFEv
        qyREUofuTHRwgcJIexNR3xHW0Kx6SrSqzUqMemi0Sg==
X-Google-Smtp-Source: AGHT+IGL8pgqFDTwFbkEIpOfSyXCLO20l9z11J7mChyhzMGqbFg7zCWL1ivXwG5Mf6e7Mq08MS4vXaERVY/M67z3K6E=
X-Received: by 2002:a67:e9da:0:b0:44e:a558:5ec4 with SMTP id
 q26-20020a67e9da000000b0044ea5585ec4mr10817714vso.9.1693902522605; Tue, 05
 Sep 2023 01:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230904182947.899158313@linuxfoundation.org>
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Sep 2023 13:58:31 +0530
Message-ID: <CA+G9fYteSobTv4ASoYX=1Z=V1B4grPpeYSkJq+1WDFBeQP4nyg@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 00:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.15-rc1.gz
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

## Build
* kernel: 6.4.15-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 9d9f43e3652f3df0f5a4b81d201bbcc97b88c7d5
* git describe: v6.4.14-33-g9d9f43e3652f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1=
4-33-g9d9f43e3652f

## Test Regressions (compared to v6.4.14)

## Metric Regressions (compared to v6.4.14)

## Test Fixes (compared to v6.4.14)

## Metric Fixes (compared to v6.4.14)

## Test result summary
total: 142519, pass: 123130, fail: 2060, skip: 17149, xfail: 180

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 139 passed, 2 failed
* arm64: 53 total, 50 passed, 3 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 28 total, 26 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 44 total, 40 passed, 4 failed

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
