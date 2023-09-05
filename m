Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B666F792AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbjIEQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354212AbjIEKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:10:17 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52781AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:10:13 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d426d0e05so1014977137.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693908612; x=1694513412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1NVo9wK9uR6XB7OEqVjA5/FypKBWn8rSsF+XNP2y7I=;
        b=a72jylmkIoYnjXaDvFcKy0oR94ab7vefso8+72n1KVQv3ey8XA9jDeCQSDIIS9bKTR
         vpfWhlwWdXdQ5vn8do1cohTJanoTZSiM57cxIOmojT0Il7PoXI34fxCyQ7tg339ZpwxT
         12TSBWO0BQ2hQ4HvuQLvBUhe58Ve1hjcOa2aJFrFqCMAoVpAzbU3/Dd3pvBcpSqX3F4W
         YaEQCxvqXUvBU24Uerx9yW0b4MhgbSmqwK0F0a1ln6BdVQUC9vr0R85YF3XFKToRkEJm
         ErhwghiGEq/82KK+h95gjISYCAM82MTR8Ma2vctvn/j66VO1SKn2dPJxnJ/i2TlvwA8H
         uMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908612; x=1694513412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1NVo9wK9uR6XB7OEqVjA5/FypKBWn8rSsF+XNP2y7I=;
        b=g65Ifk3Rsc5HClET/TQXi/SL4bpkPS1yaphc2/g8Z43bfSEj1cECUROl6ggZVLSSN/
         M6GKYtTCAoq3wsrng7n1xLOL0iWLmE1CSHrUKThiuffr7oUyEWWkeZRcyhTE4mgMTnTR
         WzR4jPZ0/BK0qvTxAY2j9Y9HfCKijxrCnu2ZVt4vbzRr12/mSqHvdsYs9KQhAzmIdC1t
         L15dcZWyoalVGFJvGGqk3dp5BOqT5UzWtAkbE8qm7+M+xwzptrhGt4+ysjvDd+DQDzLx
         FB6z/Ly7/loXRDunWBJKB5pzijcrAF5uDgpO8PmdTJUi7Pkb0C48KQ9QI91PS/Tzo5US
         urrQ==
X-Gm-Message-State: AOJu0YycftizIBJ/6fbh7vmYSerIFBBzWup994/rqXxNs89/kOPOlnhG
        RFHPLKgdAEV0M2dFpGnh/W9k53WhQec5I09rn5wr3g==
X-Google-Smtp-Source: AGHT+IE1V6bh5Wpm7L8b3xz92pn+LrSd3K1fkSSS8XT9JUjoqIZlkLmMmgJwNcjHVjrcuXzyd/kx7ikhguuSfU0jKJI=
X-Received: by 2002:a05:6102:2454:b0:44e:d28f:e49c with SMTP id
 g20-20020a056102245400b0044ed28fe49cmr10435179vss.23.1693908612436; Tue, 05
 Sep 2023 03:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230904182945.178705038@linuxfoundation.org>
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Sep 2023 15:40:00 +0530
Message-ID: <CA+G9fYsXyPe92z8Urfn46vSypOd9EYYGh1Ei1YTkHWJdGmBUJw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
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

On Tue, 5 Sept 2023 at 00:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.131-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.131-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: bec292fb85c525832713d1aa73f07c39a477e2ab
* git describe: v5.15.130-29-gbec292fb85c5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.130-29-gbec292fb85c5

## Test Regressions (compared to v5.15.130)

## Metric Regressions (compared to v5.15.130)

## Test Fixes (compared to v5.15.130)

## Metric Fixes (compared to v5.15.130)

## Test result summary
total: 91910, pass: 75958, fail: 2130, skip: 13741, xfail: 81

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 112 total, 111 passed, 1 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 32 total, 31 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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
