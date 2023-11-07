Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278DF7E48E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjKGTB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:01:56 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B42B10A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:01:54 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45f3b583ce9so3773137.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699383713; x=1699988513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isE66WVCXkq2MkT6/BYFzPqbqY6cbzaVkTvMt+ezmik=;
        b=bzpJxz17o58FeFZAnsHrtpkSgVz/CnBzY65CrE19YCCASB8rkOJlII3G393KGZif7T
         9aAWQ+7Vhxz9wbLLU/uI2zvYs+V4xog8KCg7FhbgeQ9yU/ZS1Vi9eDMqlmxiyasXB7vw
         NurA54I/uWLeJYj9DYwa7AgsA/wr7C6rL4A3p6duak2MrJYhCJx+XIbznoXL9Yg30ln0
         EJn2A15NdfdQV7q2na1rrSdzRTVEX7Yc0V9chzEoSmQBX3tdKleo1Jmp90X+tZtPnYnO
         zlh1J3bAcodECAIaeraliBMugHNBSYehHM35B5DYm1611em6feB9TU0npeKx0qIt8WEA
         WW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383713; x=1699988513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isE66WVCXkq2MkT6/BYFzPqbqY6cbzaVkTvMt+ezmik=;
        b=dueqXXF4H/jjGQKYREmKrB3Ox2FhAhwRoWTalh5WlBA+3ahqmohCo/j35HJKWF/cIY
         QyxqxJcpfULUvARAkWqWBp2zEIyHW0YfkA37Az5PbzmRqnBlBijSxreWHEbhIVNvV+RQ
         Ir+IvNeJ5vmTR0F70Ew2F/fxvKRYejpD3TdOl4yDwriAfZKVRo0OX172ul95nOxZGZ9U
         u11en2354m2aoSZvXWbCECNeRu/BAe3cs4pS7RrthyKbHJDMehc0s4SxjWiTrTOL8nOU
         V1SDChtTx6UQT8AMRcuvM8/T6hsHPOM9w0CGxwKrPk7d2IQd97dlTnbJGreQC1dRo9iY
         QxbA==
X-Gm-Message-State: AOJu0Yz40EddNh+91Jt6gV5OFYJ2zZF7RBbHBlovTuq6ej/cSkA1vPHM
        6j5fq+7Adozk0yDoslcGl8tCn6R8raJqZ8zLHTWObw==
X-Google-Smtp-Source: AGHT+IG/LigaURA8GmYiHoDiTGKtYnZ9zWQ2wGyPAYMO6QhSDmwkFqZP48b/cxG6Dyl3JzPEOEmOLSEraweDInLiytk=
X-Received: by 2002:a05:6102:c90:b0:45d:8c2a:f266 with SMTP id
 f16-20020a0561020c9000b0045d8c2af266mr2432820vst.17.1699383713250; Tue, 07
 Nov 2023 11:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20231106130257.862199836@linuxfoundation.org>
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Nov 2023 00:31:41 +0530
Message-ID: <CA+G9fYsP4cdcfrTSWN07qOO17cPkC3sQX5Xdj2bJWP+HzYmQmA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/48] 4.14.329-rc1 review
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

On Mon, 6 Nov 2023 at 18:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.329 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.329-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.329-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 081def1ede2f5d00fdf79793a6a9996bf9344737
* git describe: v4.14.328-49-g081def1ede2f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.328-49-g081def1ede2f

## Test Regressions (compared to v4.14.328)

## Metric Regressions (compared to v4.14.328)

## Test Fixes (compared to v4.14.328)

## Metric Fixes (compared to v4.14.328)

## Test result summary
total: 52442, pass: 43805, fail: 1588, skip: 7008, xfail: 41

## Build Summary
* arc: 9 total, 9 passed, 0 failed
* arm: 103 total, 98 passed, 5 failed
* arm64: 33 total, 29 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 9 total, 9 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
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
* kselftest-user
* kselftest-vm
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
