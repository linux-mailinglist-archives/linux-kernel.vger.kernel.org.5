Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0AD78FE96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbjIANsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjIANs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:48:26 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EEEE7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:48:21 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44d426d0e05so933490137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693576101; x=1694180901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y1pJnlcxcr9aS7U0SXtwUU5OVorqSWQ8RDiJDyTRyQ=;
        b=G7fNuSDVLe0Ctnnt0YeS/nb5vDQfoLnPg8gJnf2ckwmj2TH+zgObOzP2OOs221Hpe9
         UqFLxpFSkTgW4OEVI0N+6I2yHR+luT46LmxVgKGWzXQTu9ckiRZN7yyla+rFpx3UregY
         +hucTyVTb3SLwB8LUtUJzcI0+W+e2PgQj+ZsKpoMGL/qHwcQJOhr1K+LXQIY6166UexH
         WGV1uTLGmHe54x8bIGMQOQNslB3tPCq8QU1M9o5b7AQ2PUrfJOtUuFQNe2XNNnR6Sr2B
         mqYVQ2hTCKjzSzbfjgIy7BCRPRG9ESeRpcos1JMbKk5gc10s4IMwhnw8HLnHz+lPcVjY
         FlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693576101; x=1694180901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y1pJnlcxcr9aS7U0SXtwUU5OVorqSWQ8RDiJDyTRyQ=;
        b=Y1WyLB1Ij9DFOyzGRzE/UioMKaPS7NbO6pvvKGbkmRD+tbQsH7YHXLQKWkbwgf4rfe
         x+YWu2BEW6K4sp1Et49SEjW/YrJParvelUcpLybAtvYOHyr2gUMN++QYhysqhtZdQssI
         CEwfh/xc4Yc1aGsz0keDtdM7WwdQHV3se+sFYhmJb32JPQdasfKc07zuHtzrIF0UGfY9
         1fgD25mj2WRCa4gOUtcom5YutGJXcsOCM5VftHeB9z9r7AQf6QjWCks1TyRtrBbutJLC
         Vlid0/oijyow7JqR/aP8iSsFFpj9oenjvP8zZarsCofogjaMjyEMtzXndjH4DJwmsvqJ
         whfQ==
X-Gm-Message-State: AOJu0YxapC8BRR+besD6O+NWXRT/MKZJz9VTtGv3l06aPiOOVk3jzIlD
        JVuSgXXhm5TKnCaHpMQKRNC4mC8uoIFCd+YfaKw5qA==
X-Google-Smtp-Source: AGHT+IGUhghSIkPH+ZrUUAwPdy2IjMzhegrl6FRcu2MomohR1tz66WYgyxNoVHKIoRNiKXIE/f4Pnv1UdDcmeUjM6ug=
X-Received: by 2002:a05:6102:391:b0:44e:b2a7:13ec with SMTP id
 m17-20020a056102039100b0044eb2a713ecmr2920433vsq.0.1693576100981; Fri, 01 Sep
 2023 06:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110830.817738361@linuxfoundation.org>
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 19:18:09 +0530
Message-ID: <CA+G9fYvdFwWNahpwKU44sSc6QV9OMdk8oxMESm1m2wxneZ7kUA@mail.gmail.com>
Subject: Re: [PATCH 6.5 0/8] 6.5.1-rc1 review
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
> This is the start of the stable review cycle for the 6.5.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.5.1-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: c2d4e2d6c14c0bff3286f251b99c8e443a586047
* git describe: v6.5-9-gc2d4e2d6c14c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5-9=
-gc2d4e2d6c14c/

## Test Regressions (compared to v6.5.0)

## Metric Regressions (compared to v6.5.0)

## Test Fixes (compared to v6.5.0)

## Metric Fixes (compared to v6.5.0)

## Test result summary
total: 207754, pass: 181885, fail: 1701, skip: 24168

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
