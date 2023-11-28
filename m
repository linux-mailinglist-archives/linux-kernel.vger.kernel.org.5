Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2F7FB5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjK1Jal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjK1Jai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:30:38 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980A109
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:30:43 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-460f623392fso1794311137.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701163842; x=1701768642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RysSL349wtX71+LB9aMToXkLSEollEFV5Ko+eyRvxOc=;
        b=Du8/im8OsTBF0QLxWEzV/gnUkiuFCeMhlCksHptJ/c3BN5wCjwFliHBMKXDlFJx65P
         awVVPx1FdCpkuC72KCfQ1jd0tEEqhvYj//QCJJIyVpu4mdTKFN9V/tydKayAaJF1LVI0
         GgewjTB3DrfE/bHoQoin7hizuHpi1FcUDdsInywV9Zb8CmPOP1omlJsP0HS4ZhJFAkvo
         IHo0vgLSxxvt+F91FkOVBNNnl2DQe0hbKzP/sRAp7cbV2Iz0nQUto19bEJr8KpjuE27L
         PsuuOpl8OJrCLbZyRA931Thr4n94ZMKoGDnDrRJDaTd3C3DX3l3f2+0ntK2EZNgC8f9i
         BeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163842; x=1701768642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RysSL349wtX71+LB9aMToXkLSEollEFV5Ko+eyRvxOc=;
        b=AtXmW71kP3p/Y5FLQBFEO52gEFcZw3mK0CRb4Q2qobc845BFtLbhMB+E+Grn1B3Trl
         uNHvz4JvA5x/HefNigmfWG9xd2X7zLXjLUONWJXTq2QLrL/IWgDphHpgP3gE/RqHZbGg
         NeSDQpV8sxZqZMg3NGACMnuiage8sWrlEBEhM1QhSU9xt4GZkZn0KblKSwp8BwvHEUZ9
         /sEQoi08H+/a4HWPsR5X9/PDRrJ+A6bdaD7r8yLJ7Jkax36Xi33ODMv8WMviVcJhXazP
         gTS/WRwc9Y6Z1cpkRrjlHJ1kikg2BLhK5bV7Zqx21OW6IYagGWtn8O6hX/ZkDqt64JNp
         dS3w==
X-Gm-Message-State: AOJu0YxUQuUQUpTE0KXQlwc3Gc1AOlvBYUSDou8VTKwkPOOVNIMrcxsK
        tUlovpWqjc6UEi14Yh7F2gJmGWNs06j2NmP3Kx7sKbNNRA65ly4sqUU=
X-Google-Smtp-Source: AGHT+IHkuIAtRcV8IkdzBUFavg/7wgDk43HoJLjLYNj3a9prWCPjkVLZE61la+uUUIFD1opUnJvdm9gXU5uNADwJ8ss=
X-Received: by 2002:a05:6102:54ac:b0:45f:3b30:9c9a with SMTP id
 bk44-20020a05610254ac00b0045f3b309c9amr15983484vsb.27.1701163842635; Tue, 28
 Nov 2023 01:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20231126154335.643804657@linuxfoundation.org>
In-Reply-To: <20231126154335.643804657@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Nov 2023 15:00:31 +0530
Message-ID: <CA+G9fYvmF=PVjePVE7m9-ZGW7EfKCv-9iwe-uwqdNqwVHGmNYA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 at 21:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.202 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.202-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
As others reported on gpio warning while booting arm and arm64 noticed.

[    0.466552] gpio gpiochip0: (1000000.pinctrl): not an immutable
chip, please consider fixing it!
[    4.741930] gpio gpiochip2: (200f000.spmi:pmic@0:gpios@c000): not
an immutable chip, please consider fixing it!

Links,
 - https://lkft.validation.linaro.org/scheduler/job/7060124#L2577

## Build
* kernel: 5.10.202-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 80dc4301c91e15c9c3cf12b393d70e0952bcd9ee
* git describe: v5.10.201-188-g80dc4301c91e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.201-188-g80dc4301c91e

## Test Regressions (compared to v5.10.201)

## Metric Regressions (compared to v5.10.201)

## Test Fixes (compared to v5.10.201)

## Metric Fixes (compared to v5.10.201)

## Test result summary
total: 88957, pass: 67831, fail: 3474, skip: 17604, xfail: 48

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
