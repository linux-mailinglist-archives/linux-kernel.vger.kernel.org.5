Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF67CBD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjJQILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:11:34 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8EC93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:11:32 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49d0d90a7ddso1889572e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697530292; x=1698135092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwhdmZoboZYxQUEHCjJkidFw0OTKD3D55xEAaroQmr0=;
        b=nx3oIitgYYFbUjE+DbpC/wc6XPgLJ8VbZc0bDmy2cPXwykNplz9XkubH5emLustXmQ
         s8m03JAXvhcyJQF4VTJchTD3oQbvqKpaqmAfGASsAQRvk8abMdc1w5tQDG+nGxC7h4ul
         U7IvS80RPMzU6Q2Uh1nLx0+nWnMNCPreptV9uJCS9aigjlOV38e7DPUJZzKeA4GsA8ol
         iNacYoNwFu+qYc97zvYceCTgpXF0BSCzB+WGNFisUe061ZyiB+uNK98+HxckghVzbyoD
         e8mZ0S6nalMP3DaT+7c6knUHdjnPuG0HFRGboHjOrgClsvkpXcd+IOO8Zbomf5K4QDdK
         9PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697530292; x=1698135092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwhdmZoboZYxQUEHCjJkidFw0OTKD3D55xEAaroQmr0=;
        b=JuFMGud1a3nVttL8enSlv1Ne5hSQcbMPDMC/1oSOEfiiyB3/WB3lN+alKfb/2AWfhA
         QWqZJMdW8cdJgJahNCpOVY+9jZkZ/Ofuu52GjRkmJYJbTmN0xym3Gc0D7+Ja64oOYTHT
         /x2VSLcmh70PAbOwwrJrCFqRlb4RjccOK941qq6RENuy35LeEP3OWPm3XWqTr952tD7L
         kesm2HbexBOdMCTV9LYRPvdpIiXguWr3xBofdfT+YQjpIlaytQovaS49/Eld+GtD5T6j
         mU2ZYZ27y710PQAU6SKOgXI2J/jnks1ttcokzZ9VBt0sBoZD+AYAYvaDU6T6SE98HHHM
         zXhg==
X-Gm-Message-State: AOJu0YwOHuY3bvo+NYobU8vq7cC/LHK9zcBkxacKo3ymtM44+Vnii2BC
        IYNPbSdBVyiYuqq+93qRLxkT/edGx+mWhiJuwU96vA==
X-Google-Smtp-Source: AGHT+IHlZI6sNT/XNOy/gozixslsRF2nf0psq0DGT67oLm3hUpt2MiGFiteCDAooonykWLkljGmHedBnKhRzYqUEkJ0=
X-Received: by 2002:a1f:2f16:0:b0:499:e671:1682 with SMTP id
 v22-20020a1f2f16000000b00499e6711682mr1594511vkv.3.1697530291961; Tue, 17 Oct
 2023 01:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231016185002.371937173@linuxfoundation.org>
In-Reply-To: <20231016185002.371937173@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Oct 2023 13:41:20 +0530
Message-ID: <CA+G9fYuE6rLYQC6ngBVa7kBzAQbEZCG6mWh3s6Wu+Kbhycpzpw@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/190] 6.5.8-rc2 review
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

On Tue, 17 Oct 2023 at 01:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Oct 2023 18:48:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.8-rc2.gz
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
* kernel: 6.5.8-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: be4ec73708011c2c14720bfd9c94504d997827f1
* git describe: v6.5.7-191-gbe4ec7370801
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.7=
-191-gbe4ec7370801

## Test Regressions (compared to v6.5.7)

## Metric Regressions (compared to v6.5.7)

## Test Fixes (compared to v6.5.7)

## Metric Fixes (compared to v6.5.7)

## Test result summary
total: 138434, pass: 118450, fail: 2031, skip: 17760, xfail: 193

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 144 total, 144 passed, 0 failed
* arm64: 52 total, 51 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 13 passed, 3 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
