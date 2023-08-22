Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A288783CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjHVJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHVJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:19:26 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA8189
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:19:23 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-79414715edeso980692241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692695963; x=1693300763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nvpdjKXSBqBHYloPrbuamz5gPPZpwYPPdcO5Rimn7Y=;
        b=lIjIfbtmR2VfB302I98ZJVNqp8a2UmqgCeTfRrQHGpTBh1hkST42i+4CP7DQ7beo+a
         Vg9R122jgeKQ+Z54bDkkTzdqZ1/ktQTcuSqRs14YQuyJeAFMrQsYhGgWZ6QBs5j2/iYy
         nzG7XSTari2xKqVkqrwum0qKfE5H6wjG6NUcRC0zv1OegYgo9gLL8sXROClOtsS9ZaaQ
         f6Wg5tkDT9TyXptAlOG5D3Hk+nDkb2JZmdC6Wh7ipw1BkLaH/6YhYGLCl5nBqv8s3Br4
         oWTUEbs9V6aEdtBiqMs9rjUTutSjh9w0pgRqSef8CcYDfFSB8lpCERxAEtqZBadT1N1r
         yenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692695963; x=1693300763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nvpdjKXSBqBHYloPrbuamz5gPPZpwYPPdcO5Rimn7Y=;
        b=jiXfybJjgO/2M6XEDdtr3MqKW6UswGF83n7+8VWPWOozfBm3rVPQhUdEKQxk7Q/7DQ
         6y26WIaOaaVfDiZFPwDMv79UDriyJUcsyPiFx/of0kHUiX+ZZNC4qgExvxymNsgeIbQc
         pmR08/St4DgZ1gjSuIUKK8JhYe4MzO0+6TQ1aS3lv2gLpE0Z7bIfj1GLJt42EIgj6oXg
         BfMXEX7cq2YZ3tM8upjYxqq9dM2mNcR4f/wFVgp159P5AnJBfeW1ODcB23RarDNlpQTD
         +mAdK7RpczjvPjiWfw4mOaOCdZIFqcWnwT76RmDgdtgFpHil3NjOI3YalRLkb4Ox1KPm
         kcGQ==
X-Gm-Message-State: AOJu0Yz0Yrx0euAFt8eat0BMrBKYINpntbdP446c6iyqdakk8IpBsC4Z
        yQa9xPg9pElJjgEC59/OK0GVpIJHWZ5jy00bt2medA==
X-Google-Smtp-Source: AGHT+IFniA3ENsW+7fd9ZvvNB/PCzGmL1RKQj7BUmj8xkYjGOWdrte3GnZTJFLPiQlit6Yo34ynWmAN0u450b+Rt400=
X-Received: by 2002:a05:6102:2446:b0:44d:521b:8ec with SMTP id
 g6-20020a056102244600b0044d521b08ecmr3144126vss.20.1692695962948; Tue, 22 Aug
 2023 02:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194128.754601642@linuxfoundation.org>
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Aug 2023 14:49:11 +0530
Message-ID: <CA+G9fYsbpcnnN2O2eF0TJkz=9xdbtmpA1V9yKaPPrXC1izgPUA@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 01:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.12-rc1.gz
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
* kernel: 6.4.12-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 2a85de3fab437809a8c511762a7ef4d75db71585
* git describe: v6.4.11-235-g2a85de3fab43
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1=
1-235-g2a85de3fab43

## Test Regressions (compared to v6.4.11)

## Metric Regressions (compared to v6.4.11)

## Test Fixes (compared to v6.4.11)

## Metric Fixes (compared to v6.4.11)

## Test result summary
total: 153971, pass: 133147, fail: 1667, skip: 18988, xfail: 169

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 139 passed, 2 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 39 total, 37 passed, 2 failed
* mips: 28 total, 26 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 37 total, 35 passed, 2 failed
* riscv: 26 total, 23 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 44 passed, 2 failed

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
