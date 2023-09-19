Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7534F7A5BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjISIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjISIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:04:16 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4B128
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:04:10 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-495f20c5832so2056266e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695110649; x=1695715449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuFWO6rzgX1s3gChdWOpfJDKyTHg4+js8bAIDqHiJ48=;
        b=gKfDa8Y4cACqUNfhoLVfBBEvOw5ebv7v4ZuGzSx2P2CAtSJrJ3x2mxvUgdBLfN1GQv
         DZCC4ls6b3zB/1yO0jLo3B1athM/tPn/BJycQhUqZGoAnWWRDcWuBqQVlgqQ1A7i2OWt
         RaehFIdG3vz3DxEH905SAssWXbkzPffGHCJSSHbMtVoI0ilsZN5yOrBO97VZUUx2z7vh
         GRAZmYVez2xX/7QIt5NwOuJvrg1YjxUfau26WbVj56hHpi0++7hvhWgeHsZV4d/do3W8
         iyRtl6J0pQ/xmU9QfQc8z15c1kSdeoSnvm+DMGHRmct329hhQcmb0J4ShDttRnCmvu8X
         IkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110649; x=1695715449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuFWO6rzgX1s3gChdWOpfJDKyTHg4+js8bAIDqHiJ48=;
        b=mbPO+jOQa8lxrgHAzsDxT1WgiXWrQ7zdwAvPGvCUzqV5O3WtJAhfdefGV845qOr9Og
         pgpF74T67Oko6aCQQj0CvwCzQ3Qa+NKzDrjLtemN54pgCqDt/wccWJJUMbFmjW5nLDD6
         LZ0VjiRHfSDi1B1JW8JqPtdYrsHWbWiTf5isIN19JAIr7N8cKndCyk8wotkrXyvjUB6f
         Jgfa5/M+6r/6BKHpOfKZ5HYG1jn+/zdnsPFO1oPXm37t8hVhCGCJGkuiHRb/xPWeze3J
         wbhLrw5vkALpDhhuGKs/4FR75g8Z7AIsRNUNk2wbNZepmyqsnhNHRi+UdqLOojHB+v6+
         3hJg==
X-Gm-Message-State: AOJu0YyfEVZJH9cwuwXPrV/sba80m6DGAJ5uCqTrgylLO12hlP/ykQ0Q
        yuHSdpz/IW2J6EqFyiKqtWzKJeSP2GuJctLnhXbZzA==
X-Google-Smtp-Source: AGHT+IGDBFMGxyTcoOVnr7mZvl5wT8T14ly3GuNATZX2sN28h5LeczRD2ewyC/HYEfhGzhTloSyhFtHrg5NRfkgQvM0=
X-Received: by 2002:a05:6122:1893:b0:496:a303:a321 with SMTP id
 bi19-20020a056122189300b00496a303a321mr4306110vkb.8.1695110649345; Tue, 19
 Sep 2023 01:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191101.035638219@linuxfoundation.org>
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Sep 2023 13:33:58 +0530
Message-ID: <CA+G9fYvQ2qpMujPNgCAUnVMGKUEH2Y4JYVSHgLN6TqDVvvZzsw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
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

On Mon, 18 Sept 2023 at 00:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.195-rc1.gz
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
* kernel: 5.10.195-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 95379666b7a68327e8f4c3a0dbf28ae0c479ab4c
* git describe: v5.10.194-407-g95379666b7a6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.194-407-g95379666b7a6

## Test Regressions (compared to v5.10.194)

## Metric Regressions (compared to v5.10.194)

## Test Fixes (compared to v5.10.194)

## Metric Fixes (compared to v5.10.194)

## Test result summary
total: 80823, pass: 63120, fail: 2111, skip: 15541, xfail: 51

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 111 total, 111 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 11 total, 11 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
