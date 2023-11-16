Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051A67EE6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbjKPSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345441AbjKPSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:23:19 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF61A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:23:15 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-460f623392fso390493137.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700158995; x=1700763795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJMcVGwV0ZhksPb/kb7ya6aQUsXCXgCzibgQas3bEBg=;
        b=q3r2uGE7x3Gbyu5ucExvbmYZgZSp5XWiBIkrilqhS5GseXy+Ohe5+CKdgBwoiJilsU
         MrL/OKxNwUAoCXv40C+tjZGR6st66EWn2fSu1rjdDNVr59uJgpUyPtudZjJ26iBIABcz
         yeaTJg0Mm0BqaraWJNKN/29/UAvpTMOfd4TASAducNQ0PWaPa9G/Xj30W+4GICYrEzJb
         PPQiPGHB+hVvcj5n5lSjsX61zOKfLCM0AafQC4wz8fd6ZondRXu+BnLd2cQO72jismQ5
         bpXxggwClvqU97DJJcwtlft11gLQKiD/3AMUOld6vGfoAretDKeAD5NTukw+cldCi6qU
         /yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158995; x=1700763795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJMcVGwV0ZhksPb/kb7ya6aQUsXCXgCzibgQas3bEBg=;
        b=H4HHfGAeDB4gCbTgHQpIwgqMol7SqDXsmkYXIfEh5np5dsr9tqn1LcSFKE1OqkDxOZ
         ibCrWCBZuPxjdNQEenkPBww4MQ6j1CGST9VpUDzcrd8sAadrS6Y9cIgV9YupPTSP+R1k
         ij5TfVcmLkwSXZSu2Svoazlv4LVNrM5qAVoejJwooNd3f3wkfe0mvM6sEnGrIuF7Vj+K
         PNmzrNjn3fiMignMoKdUU3qxW8ftlaeUSCsOr2jxDtcb4DCrGK+4H6+odFVRyUV9EdMF
         fh6W0m32HH6CU/cc8yF6Kmwk/oIY430t23KFqwn+7iZTyHywDumuirND2q/J5QRDGfXJ
         72MA==
X-Gm-Message-State: AOJu0YwWnjGllphe0VltoJ/vK0nPVpGHL+C36IInGpsAup82E0SasNJj
        jWd9mwUMqFPb1brvit+pUK5OLRGiC8MT99FIBp2L5g==
X-Google-Smtp-Source: AGHT+IEcMaXkeuHVRU3ZX/vb++TMtypZamKx9CSfQP8ESngpYGE22btaobl4qjxySaHBxzo5pYhEzgxe3DEwurxJIeA=
X-Received: by 2002:a67:c29a:0:b0:45f:9fd2:71e0 with SMTP id
 k26-20020a67c29a000000b0045f9fd271e0mr17352673vsj.30.1700158994973; Thu, 16
 Nov 2023 10:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20231115192645.143643130@linuxfoundation.org>
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 23:53:03 +0530
Message-ID: <CA+G9fYukdu+JryZd7yubwZYddrDNpDZyQXA772PisHiBvU77+A@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/379] 6.1.63-rc1 review
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 01:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.63 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.63-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.63-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 505b91175bcfcf16c4adc437901109bee0ab649f
* git describe: v6.1.62-380-g505b91175bcf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
2-380-g505b91175bcf

## Test Regressions (compared to v6.1.62)

## Metric Regressions (compared to v6.1.62)

## Test Fixes (compared to v6.1.62)

## Metric Fixes (compared to v6.1.62)

## Test result summary
total: 126938, pass: 108065, fail: 2482, skip: 16277, xfail: 114

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 147 passed, 0 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 37 total, 33 passed, 4 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
* riscv: 14 total, 14 passed, 0 failed
* s390: 16 total, 15 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

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
