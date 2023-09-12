Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F403A79C9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjILISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjILISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:18:35 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB7E7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:18:31 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44d38d91885so2517365137.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506711; x=1695111511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWXNYBL9b31oc1SggDkz4tlCDlhgG4dwgemXcdjOh2U=;
        b=pChUxCukWOytBQpbzo2/jXLsUcxjKMF+p20VVqYIF7xdv0yz61KTCzaf1A+DwOB8KG
         +aewmvcBpl+vjrSov2HgcC86IzoCen0x8vnJyRaloVCxg653DK0N030mfNTDYD8cgE0S
         dulCwtcSC/qGF/Jrs8cO/w70ByT8nMFT7vYEYvBRDQSzse5slDFSLBoONpqeixHxEdE+
         VbyBv1lzteCbKtSD9fqCl13Gxj9uQ5sFd+WS/qPrTW/snVwejC9BJGbpZfw72F53rg1P
         zLTYp8XH99T7W9WXezQX2U7/j+qfwnjHBl1BroIkNXpnrjK0L8yE1BB9uUJNnv/qtBx0
         bNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506711; x=1695111511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWXNYBL9b31oc1SggDkz4tlCDlhgG4dwgemXcdjOh2U=;
        b=Lmtgcf31+D/Uxr7LBo8xwCHvnb1ASiGdnUkDyRLbTucXetr4+f9U6ngnxt1xDbwB4l
         DKsct8eTgzwoa1F13ViMCwrvXJ9ldU+sDc1E7PAl9PY/dhoA9CYxtRKkmTDDuJlAy2I+
         rHRhqvtcGWXcJ/0Abg4yKqnApp/uuOF6l3fzXAhA69oBa5YqujcrhelVZd423LE7wxqO
         EBzxDjzuZjcr969dOJYuk3su0lGrD6aa8Fg/vrWoK4r+X8+NKIKcPM+O9fqQKfWfmI66
         pC77yY4XqvpoyRupEWaXZ9Aj1n0GDIMJPpfieI9KwTZdz8cdc0qbjVc4ga915dJa59kz
         jBig==
X-Gm-Message-State: AOJu0YyfKPN1Asdr1jt13tgBoRUzoUvLOS1iR/KOVaQq1Sk2wFcA1SQr
        BqdKobFA06NJoZd2VHOMZkSmyHGXsHXLhW7tinDbSPaCMBu/n3nLIqayPQ==
X-Google-Smtp-Source: AGHT+IEX6pcSZJvQvRgvyqsKyvnSAqViInvTbBSBqP12HNwDgj/I0laXg08nOh5hiOvEHo0S3ie9kKEYxcLpVH+QExQ=
X-Received: by 2002:a05:6102:3166:b0:44e:a2ee:8408 with SMTP id
 l6-20020a056102316600b0044ea2ee8408mr10634044vsm.23.1694506710926; Tue, 12
 Sep 2023 01:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.286315610@linuxfoundation.org>
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Sep 2023 13:48:19 +0530
Message-ID: <CA+G9fYvLsuHn2ckfwJRwFU5ZzYq4W_JgeC7LZvMYiQML5ygh+A@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
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

On Mon, 11 Sept 2023 at 19:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.4.16-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: c383978584827c8fe5480bc6c182183dba0e4b92
* git describe: v6.4.15-738-gc38397858482
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.1=
5-738-gc38397858482

## Test Regressions (compared to v6.4.15)

## Metric Regressions (compared to v6.4.15)

## Test Fixes (compared to v6.4.15)

## Metric Fixes (compared to v6.4.15)

## Test result summary
total: 145516, pass: 125575, fail: 1989, skip: 17770, xfail: 182

## Build Summary
* arc: 4 total, 4 passed, 0 failed
* arm: 140 total, 138 passed, 2 failed
* arm64: 51 total, 48 passed, 3 failed
* i386: 42 total, 40 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 37 total, 35 passed, 2 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 46 total, 42 passed, 4 failed

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
