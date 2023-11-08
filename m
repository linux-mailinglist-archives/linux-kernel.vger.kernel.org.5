Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297687E5617
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjKHMSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjKHMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:18:49 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E553F1BCC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:18:46 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7bb4b7eb808so1027002241.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 04:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699445926; x=1700050726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtleK5+B+iSrGADJfvBkG6jHsi6KD2PrLC0HlWzUmbI=;
        b=twAmtZDEGGTQmKFaCGxLqdnRqlaSMMn9H+QvctK3yxbOmFAPPt7c2BiAQAVozw1WFR
         FFCXy3C3/yPRvQ5RG4rAaey3qTRh4y4U38vscrWQFlydcb0xE3F+IzSaurxeuBomwVo3
         BOnomRT8hTWkF5H/NUKk2beawOXlZ6wcsZ1WiUviwT4UkzJKNIdRTNcwC43XfmC5bAt7
         AUalAwu8lAH7YdBpNYkhM77hYMdlKs5PNS0BSo2rf83a24aoxHnp5I57qDlsCzesLl4N
         YF6cYHAda4FqEkneVg2m+jDZr7t5Jmq4ISJWUG0zGRwbkzTzkf8n6iBB4bnNsz1Yo9Yw
         YAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699445926; x=1700050726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtleK5+B+iSrGADJfvBkG6jHsi6KD2PrLC0HlWzUmbI=;
        b=WqGKlRJE3ZK0xiGvCvoi1KjQnvvFbwT2BG7tA8X4ONzaGFmRdpEAc01AGLw59rFGlg
         /QZuMnrI0js17Vl6waESUEBR4nZfwPTg2Yy7rkMoX3v26MkLiSY3pymaLiaUiPX0shsG
         S9iym7g4JOhQMmJSanRrcSk6tKxGA2A2nbylVUPw0qITteGiS+f8HDG1Olete3+dB2Bq
         BZc9VfjqfVW6P103IGbg2vv+EWppZhqqBiLPJGrPmnEEUTNXWnIiTrT7V/Jt9um2xTaI
         JdQrUcy2QwCL6Qf7SEJHXX9alh1jDpnYewpdPUzHw8YuYeH1kfLzQXD67+n0i5UELehM
         QajQ==
X-Gm-Message-State: AOJu0YzjzhfE8ssJsM2Qn4EBX9ykEVLjgJ40oueBrCBn/UfihhEmJmtr
        PtXKZ6bYheJ+fga2pPf4bIsVyihDtupnuJNp1M2++Q==
X-Google-Smtp-Source: AGHT+IHqU66uAC3lXdc4sKllRsYweIpdsltZ/i8A/zB8EvIJhiRjXgx+94NX2hrKqiHu8SVCcxUAv+Ep/J0zfypORRM=
X-Received: by 2002:a67:c182:0:b0:45d:92e7:76d9 with SMTP id
 h2-20020a67c182000000b0045d92e776d9mr1361581vsj.21.1699445925844; Wed, 08 Nov
 2023 04:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20231107202324.434534294@linuxfoundation.org>
In-Reply-To: <20231107202324.434534294@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Nov 2023 17:48:34 +0530
Message-ID: <CA+G9fYuOvAtZwtvyaUCA4P-pzdjop0=XqL13-f-ibSM_Eu3S+Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/125] 5.15.138-rc2 review
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 at 01:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Nov 2023 20:22:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.138-rc2.gz
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
* kernel: 5.15.138-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: f3efa02c9542a1de453a56c6ad9913f699a45737
* git describe: v5.15.137-126-gf3efa02c9542
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.137-126-gf3efa02c9542

## Test Regressions (compared to v5.15.137)

## Metric Regressions (compared to v5.15.137)

## Test Fixes (compared to v5.15.137)

## Metric Fixes (compared to v5.15.137)

## Test result summary
total: 93104, pass: 73581, fail: 2547, skip: 16923, xfail: 53

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
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
