Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965480EE55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376437AbjLLOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376403AbjLLOFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:05:46 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB26107
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:05:52 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c5524f258aso3179007241.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702389951; x=1702994751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7OvG7f2fbkAHiV1C+DyWDQaFlk/Jc1a6xMCOYx9TeE=;
        b=JMXhQw70t3gBlXbYnbhtMd8sT+YMLYfQnpcXwIcTPerY+Rd8RLdwfgFJcOK/hE2P/Q
         sjfBbg+8VTN3OMXmu2rDnP2A1uGKR2MOIGnx/q/9X+0HGjw42NdHNETL1Z1FVwgoVEcl
         NWFCOCFuXsTr9SukmEY3ZEq9BRPXZJEab/WSKqI3kI93hHENHJ/8xNO6fZ1J8LXQ9liy
         SZBz2lBm4s9HLYR9p5gPUVwsHqdyNoG/RnTuj3g0uWPyQnAm/hNSyfP+VXCGpcjmMiBz
         kFAIN0SsuVaUM0QUsKyBkKkogUsS6D/dbn3nr4/wa/IxH1fplnmazQCfli2difWLJYb9
         NKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389951; x=1702994751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7OvG7f2fbkAHiV1C+DyWDQaFlk/Jc1a6xMCOYx9TeE=;
        b=hYoEc6bf20bqBHbpS4xxGYnJqsNgzwoK29NYpxKhQV8kD8sBrexJOnBJsGYhorCMNN
         q0VKTQXYZrA6lJ2JqYOjiUDtTvMSyhaOpY12yGsgas0J9FLiHRrzl1E+UhQugQtKWfYh
         oKhRswlDipF4ROa+GqWRTmFzVB8IYyyiQyF2rRIRW+ekM8aR44CdMOFODgQd/h4g4UfE
         kNLn+tMi9emnMG6ffmQFqSjJpDavMExszVCHMAVQP3aeF+DRE12a5vvdk9N3MpmaTGs/
         4/cQg6DHL5I7CeIs5Nhh4odyXzdahW7X0Z9NARy9SltzuvZCPvYsL75G1n5Fuw3//F3o
         NxYQ==
X-Gm-Message-State: AOJu0YxEeUOhyx/+6K6DYMBfvClCAcGCAO3t/oHSLm2E7yyP0ir/Zvaf
        AJI4fLMhzKXIcyDMTM+tydlDhcLs/GmNTxGJjYhZsg==
X-Google-Smtp-Source: AGHT+IHjL8RuvYBi5lCSVjhpl70n3kPkPo88eDYA9ZzAJSxm8dM5e8yvPzby7XDfhdt4oFYZC7H9kVG2s9jQJiDbOP8=
X-Received: by 2002:a05:6102:9a1:b0:464:91f9:d5d6 with SMTP id
 f1-20020a05610209a100b0046491f9d5d6mr4845488vsb.30.1702389951460; Tue, 12 Dec
 2023 06:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20231211182045.784881756@linuxfoundation.org>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Dec 2023 19:35:39 +0530
Message-ID: <CA+G9fYvN9xBZdiFgBSD5HuLm2j-Ny0AyTvCngh0E32mWWXB00A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
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

On Mon, 11 Dec 2023 at 23:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.7-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 4970875239e5185c5957f2eadd5b4caf546f2bc0
* git describe: v6.6.6-245-g4970875239e5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
-245-g4970875239e5

## Test Regressions (compared to v6.6.5)

## Metric Regressions (compared to v6.6.5)

## Test Fixes (compared to v6.6.5)

## Metric Fixes (compared to v6.6.5)

## Test result summary
total: 154499, pass: 132659, fail: 2462, skip: 19242, xfail: 136

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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
