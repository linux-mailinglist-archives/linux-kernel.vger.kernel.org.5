Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211D7DE55D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjKAR34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjKAR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:29:55 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0810F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:29:49 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4a40d304601so15520e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698859788; x=1699464588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/+KeCJBlIlbmFDBHYVaUeDP2EPvqFv8wldZntE6AM=;
        b=b6lW7Y1t4Q6IvpEEbGvyaIlzkKFb33Xv3IfHhBd3buABZsdcq2ZMwfWnT+XmNFPdhr
         jHa3X41W0O7Q3Y04zQta5DwV6975rWPOS7YMBLCSWC8zdLCWGqghFOJL+zZCW7X6bsdd
         9EGjosbo+NK417PSuEaxEOU3nl3bZm9wpCd43HqP0syg8VqheOYi0Kcb54xGZELYulbr
         mjbzIfBmdoiUfHC1ZDZOCc9m0WLX8TJXmmkRdFHD2ObRB0lpI2cl7PGXiE2uo1HgyFEb
         GRekwJZt/aTGUv2HBlHDZlEjB2tgyYdnpP/BDjr8tMPmUvEmjL/RrhPYTja4XXrh6iwn
         aRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859788; x=1699464588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA/+KeCJBlIlbmFDBHYVaUeDP2EPvqFv8wldZntE6AM=;
        b=FRBMXQinzVaw7NU/j4AvHHlLl3j4A79/RvD+lWSL85UvcltFRanl6DUnf0FOCnfopi
         pNck8CscPVJik4dhn/PA1/WNLJ84Q7PCcof1CI67zd7SR6pXvBY62XrefonZK7RcJPLy
         EOFhlZK6bBZtbsYpRRwnOl19mHBJiqPAdl+9x7kQ2v8BNL5ynbCz/39FXP/NWzMkUn2+
         hXDfqu9GWijms6+OG3UlACk8UpjTHMCZiIXRXoC5trHHHBUNUv7tb+TvUlHxOKhgWTC8
         LXG4vsk2BRkVBo6K5tRqaVTCUaE165jCuwmjeO4mAJMnhCZFr9RXSENmiU5CiyR7N/85
         oImg==
X-Gm-Message-State: AOJu0YwfAf4882780T45zXSiFh6t/aNAIYb/Gv0E9n6ZM+L8u1BAdAEN
        smC8LXB6NVFFMUqCCwhxVgZGVXr48FtJuykk7SqN+bDs/DpIKb/MwKhdvA==
X-Google-Smtp-Source: AGHT+IHPfCdUbOFuDUSF8U/w74yoOxpjhcLbjGN1thcCqeM3IP70B2YAavVsF5YXyM/F52jAkI2uWaET6xcikobleYo=
X-Received: by 2002:a67:e11c:0:b0:452:d9d4:a056 with SMTP id
 d28-20020a67e11c000000b00452d9d4a056mr14024960vsl.26.1698859787511; Wed, 01
 Nov 2023 10:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231101120147.190909952@linuxfoundation.org>
In-Reply-To: <20231101120147.190909952@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 22:59:36 +0530
Message-ID: <CA+G9fYufhkTp=hzJDmMx-74sHVDeZn=ttW+d1tB1p8N9GA4YbQ@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/111] 6.5.10-rc2 review
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

On Wed, 1 Nov 2023 at 17:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 03 Nov 2023 12:01:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.10-rc2.gz
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
* kernel: 6.5.10-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: b4d7fa7ca27816b453e17742b523f5ab9246317e
* git describe: v6.5.9-112-gb4d7fa7ca278
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.9=
-112-gb4d7fa7ca278

## Test Regressions (compared to v6.5.9)

## Metric Regressions (compared to v6.5.9)

## Test Fixes (compared to v6.5.9)

## Metric Fixes (compared to v6.5.9)

## Test result summary
total: 137840, pass: 118133, fail: 2091, skip: 17499, xfail: 117

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 144 total, 144 passed, 0 failed
* arm64: 53 total, 50 passed, 3 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 28 total, 28 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 45 total, 45 passed, 0 failed

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
