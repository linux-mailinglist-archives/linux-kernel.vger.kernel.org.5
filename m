Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F12801146
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378214AbjLAQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:30:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA330A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:30:12 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce322b62aeso393360a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701448212; x=1702053012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s1IKxbEKchkGY10bHUOXRHh40Wu4gUJp6JDz6WOLnHc=;
        b=fghyTR8MjViVcLpRNOcaMwr8ppbVjHi/YEf1tOviGEgfT/+MCTh5sAmgScJjtShyfH
         NNjX3cSoMfVTp2Wnsmw4nVNV/VMU1px9Wy2ReiaO2J9eCTHdTVF6LtFAexoxjuGCqlRv
         +zcqSemXIGu+J8ZF183TfvbYS1vOqSRMWvj7Cp7hCbg2PcGiIJeBmLPjIOJDl2tXk702
         zRbbVfdNSwjGXsTBi+2l4WF+y4Ci2xppyjRJTB+UwVNeHOKTq39RctfdGSZZ4ruDK9d4
         beTJKcbzHgw552b5RNTv4nCSNSnnvu6x+JMkQQgF2QOsT1qe6zegswcF5doCwd+o+9ro
         labA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448212; x=1702053012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1IKxbEKchkGY10bHUOXRHh40Wu4gUJp6JDz6WOLnHc=;
        b=qCOItdyPi9mvtm8xozvUmzB6TpRUzbED1fu1aKZ80G/m0zkwTAQsSqi/97gjJrRZPJ
         A/XUDLCEWPIli+PdTJIR107IcZttx1ZrRgM8uCNdLFq5TxwWVv3wLNNua+ARDWfZd8oP
         9XSt5KPo0n8ge+EvZzsEaHdSviUau204LKWjY9uaD8q8m2uC5lahrN3UIClZ79PESD1s
         +uHW8Ml71rj047DlDyxmnWRfePeJDDac8hSTM6dNJ1h7zQTs+YESSfEy9y8IBEJ4Eaak
         f10Gsivu4pZFr/pa4s0yyTgzOTv2ljpoL1v5YnnATEUDmpZ4zccc0KcQFJGwpuYWBv1H
         xAFQ==
X-Gm-Message-State: AOJu0YyF7QVJsXvfSq4tr5rrwIwqwdgW37foykMfADKm4+0R8FwHG9b9
        VPOeSpT47XXIjcPgf0UaW8bCXuQDPRj4TIAuIGVyxQ==
X-Google-Smtp-Source: AGHT+IFX1vzfFj7K/cg97S6DjsFNL4lBnCxrlnYaZ8OqvBggz5dA/XjA/JyN1jjGB6r+U0Cplz/gNqwkrzZ1/ZQovPc=
X-Received: by 2002:a05:6808:144b:b0:3b8:5e09:8c40 with SMTP id
 x11-20020a056808144b00b003b85e098c40mr4232097oiv.2.1701448211817; Fri, 01 Dec
 2023 08:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20231201082345.123842367@linuxfoundation.org>
In-Reply-To: <20231201082345.123842367@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Dec 2023 22:00:00 +0530
Message-ID: <CA+G9fYtgTskS4Ar2caWymBrBSaiuoZ3zSOU_OwLPbcKyVEaPuA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/68] 5.15.141-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 13:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 03 Dec 2023 08:23:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.141-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: c66b1a8641b02e3543acc999034525d742f66f6e
* git describe: v5.15.140-69-gc66b1a8641b0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.140-69-gc66b1a8641b0

## Test Regressions (compared to v5.15.140)

## Metric Regressions (compared to v5.15.140)

## Test Fixes (compared to v5.15.140)

## Metric Fixes (compared to v5.15.140)

## Test result summary
total: 96752, pass: 76379, fail: 2787, skip: 17516, xfail: 70

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 114 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 32 total, 32 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
