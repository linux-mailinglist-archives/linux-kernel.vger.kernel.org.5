Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7B7A5162
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIRR5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIRR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:57:38 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C169F11A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:57:32 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-450f8f1368cso1656821137.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695059852; x=1695664652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAt5sHbrWgx4zzl6Pu9fZMLoH+lVEoE9WFINBvxYQ70=;
        b=Be4TwjqNjr9XPWtK4U3aOZVAchBkahBTqfk22uG46Qg+7EaGHD2tq8oaQQIzcFCfue
         Dn6nKtOJv5iENzQMtsI0HyYUhby2ZonsW0gOZ9Z3fjvAnBoIkJUvCqK3U2nsY6L5qPAj
         L9PS/JfMxstCskEshrfBoRqx7KhVmn7j0+FPjLAcMialk11BG8wEUEG5qc1q2HxsVEKc
         JDJOv4wl+Q85LluUDz3+6RZuxn70w1iNFZBprJv2GMqHRVwVoUcWLOVplcMLSgoMA098
         gcAN5yGqhFy1UbNKOwASe2ZLT1CDdRd4BYrj3JEk1+Vrzhw0+aF9ZUf8If4oiWLMCKV9
         ySxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059852; x=1695664652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAt5sHbrWgx4zzl6Pu9fZMLoH+lVEoE9WFINBvxYQ70=;
        b=QiOVg9Va3wsQlUr7oV0mxkfx1w0+smg/pD4zk5eujLvXUaWB+iB3PV21I4C+Rq8o9S
         A0qvDyU4cKl+yF5i9iYTxEnYD+vPqcGTrtwuGkFCBJNyo2pTMwIF5/I+pL8DKjLf5HvM
         5OI6PyVx1ek6apcUt+za0kVOfFLiNQIxXlX7pBeUtPYgxROIwkx8vfptD9ItHooxmmJP
         488tpcWXOP4IWoFLoFRWrzrsfXLBW3y4wFeRqDEINtSlE2Mke/D67/+E7j+uEB8JObuy
         9jLTD09QYVbKPsABpCf7mT1n855zQfQiNKZjL9hVmzp/nLPEWQXBEDcuQIgn8yTeTRyq
         wlzQ==
X-Gm-Message-State: AOJu0Ywwj44KgQd6ovnEMklO1Zp91y1W0wTJIjxlpqUwjvucPwGNoXf8
        JAB/YSv9WWmoR3ChosLg5CApVPdABYKFWK1+JSphY+37YGVLqtdlwHo1UpxS
X-Google-Smtp-Source: AGHT+IGE4a/5sYIMQ54j0tdNQXS5tUfdTizYlTAdElnrf8kFc1XkBAJ5OcfLDItMUFQbfeIbPBGDN4KUDHSK7miLsYg=
X-Received: by 2002:a05:6102:f94:b0:452:81b3:4b07 with SMTP id
 e20-20020a0561020f9400b0045281b34b07mr1345973vsv.17.1695059851588; Mon, 18
 Sep 2023 10:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191051.639202302@linuxfoundation.org>
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Sep 2023 23:27:20 +0530
Message-ID: <CA+G9fYv-YTGcnGEGpB9Pd5ZjhzuyFfPZPrwk7zax8ovovyQhjQ@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
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

On Mon, 18 Sept 2023 at 01:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.4-rc1.gz
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
* kernel: 6.5.4-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: e5d077fb1eae958bde2a55b3065972193e501b78
* git describe: v6.5.2-1016-ge5d077fb1eae
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.2=
-1016-ge5d077fb1eae

## Test Regressions (compared to v6.5.2-740-g7bfd1316ceae)

## Metric Regressions (compared to v6.5.2-740-g7bfd1316ceae)

## Test Fixes (compared to v6.5.2-740-g7bfd1316ceae)

## Metric Fixes (compared to v6.5.2-740-g7bfd1316ceae)

## Test result summary
total: 245581, pass: 211062, fail: 3143, skip: 31023, xfail: 353

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 278 total, 276 passed, 2 failed
* arm64: 94 total, 90 passed, 4 failed
* i386: 69 total, 69 passed, 0 failed
* mips: 59 total, 55 passed, 4 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 75 total, 71 passed, 4 failed
* riscv: 52 total, 48 passed, 4 failed
* s390: 32 total, 26 passed, 6 failed
* sh: 28 total, 24 passed, 4 failed
* sparc: 16 total, 16 passed, 0 failed
* x86_64: 81 total, 76 passed, 5 failed

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
