Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916D7EE2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345299AbjKPOYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjKPOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:24:06 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D441C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:24:02 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso330421241.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700144641; x=1700749441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KJkXeq1c0Mlv5gjaKW3vMtX+YJGSTJ76GSnkl3Srbw=;
        b=ixVqA6Jy5M4i9cOdbqGjQrExnadQQhnP/jgjvn4dxKCQJAKjCIWqvVemzDSdZsYj6D
         SRwhW4FlghP8UmxMUBtxSD9eLfc3JmLtCODtTme2VHdqZ5pyvl8EevvFOoHMkgXpSkTy
         Zqccru9/HH1J8C+2BrWyO0fS74L9IwPlrjqnXrb4poWETa9W3tt/WvHAJ3qlZTJX5907
         p4hirZZqkNmMAAjizxvYvO0RndMB8ZA7dBgm9/Bx91nTaJ18zxMV3D/bb5ra2jeKDRQq
         PE0egO4MT0QPlGXja/5M181YwTFz5lCqm4gMl4DPH//8ofl/GiyA015/BtPmwKrMQLUM
         2CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144641; x=1700749441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KJkXeq1c0Mlv5gjaKW3vMtX+YJGSTJ76GSnkl3Srbw=;
        b=eLfFNvr2jW2GlI9kEvhDwkzs8/09yYeZF1w0gblGAHc83GXdF+1yElxzRxT2OT1+dU
         m/+lntqPv18FfovZLwo6KWrwEAkuiuKipn1Vo+lXYbIXzuL35JP6M3QZ7NmH//MoRrde
         iAvH2pJ18U9w3IS1HcmMGMAMLEH+O0LpOnKO3QxBDw8o9XqirllhVxWaEy5QoO5aePA0
         XSjBpIIiYZTq2QMo+k3Gc7ldPwN6/LbwR408biNMF5EXP6ftcGnNBiO0iJZpPCG0OHLw
         rDBVgJAbGWD7L8KDD4Abrlhcubx+8+YAqDpZLHLWg+DwWcurilAidden9G+k09QQtenB
         DZwA==
X-Gm-Message-State: AOJu0YzrAgaA3AffTBTaWaJVHVhAUjo9KTLO+xO2mq3f215kMae1r/ok
        hIPYj4Zwh+XH0nMJPK2XijoPub71ZXK8XcHwCXjF3w==
X-Google-Smtp-Source: AGHT+IFZ+gmH9ee3C9+IKGOdCpJK4UhHwKPQ41ZEfQJqJ3vOizJMchMwJ+8sAu4LvbhUcv+nzBns2e4KA8t1gGTjGJs=
X-Received: by 2002:a1f:a084:0:b0:49b:289a:cc3f with SMTP id
 j126-20020a1fa084000000b0049b289acc3fmr15034872vke.3.1700144641588; Thu, 16
 Nov 2023 06:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20231115191613.097702445@linuxfoundation.org>
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 19:53:49 +0530
Message-ID: <CA+G9fYsS3r+mM1qQo4WHe4hp-xZBGhFsXyYWg2dLo-up_vzP8A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
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

On Thu, 16 Nov 2023 at 01:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.2-rc1.gz
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

NOTE:
Following kernel crash noticed while running selftests: ftrace on
arm64 Juno-r2 device running stable-rc linux-6.6.y.

Link:
 - https://lore.kernel.org/linux-trace-kernel/20231116123016.140576-1-nares=
h.kamboju@linaro.org/T/#u

## Build
* kernel: 6.6.2-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: df34d612fd4ef266814366c8101094b7f83b6a92
* git describe: v6.6.1-604-gdf34d612fd4e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
-604-gdf34d612fd4e

## Test Regressions (compared to v6.6.1)

## Metric Regressions (compared to v6.6.1)

## Test Fixes (compared to v6.6.1)

## Metric Fixes (compared to v6.6.1)

## Test result summary
total: 136854, pass: 118192, fail: 1765, skip: 16783, xfail: 114

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 142 total, 141 passed, 1 failed
* arm64: 50 total, 47 passed, 3 failed
* i386: 40 total, 35 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 44 total, 43 passed, 1 failed

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
