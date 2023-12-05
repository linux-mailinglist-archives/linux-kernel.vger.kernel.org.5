Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268448056AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjLEOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjLEOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:01:45 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED0C12C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:01:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58e1ddc68b2so2474572eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701784910; x=1702389710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2QEf/lBr77RbAJvG5vi7959AaVxlYnauTCXxwH58FY=;
        b=Q270t+wWTOsa27iGuMJaQxg1LAIu0xw6axB2ZD9pjPHL4db6aF5ggeXktK8xpceDQY
         22aqMsZaNueMH9HPzX4Pvj6lmCjZ9Qg5fU2XLTL2hPu8GTg+lZibUJO7rIwNyLz9r+zr
         mBPhuHOKop6pDq55qOodzrwuC0RGRps8bCIRqsNPdxgS2fBoNdepQiktyKtmws10wkKx
         uesE5Lx5u0YUkEefZRlyxBLUcIFllSnieTGN2ut6vDeIDblSCdKbqocttQ/KMs/o1X6h
         EZbYu9kWgQwsd9Nl3afrBUEkqW4QhIsPp8kWeuUIqpTHZ6ROoNfonQDSYlnMW8PEvA2L
         XT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784910; x=1702389710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2QEf/lBr77RbAJvG5vi7959AaVxlYnauTCXxwH58FY=;
        b=eFVaSH/hp5Gd6+3wZg62odi7h+Wnq48KJGXruYzUTLyOUrIPCscfrwwYQy04Fg36tZ
         /0NFhVYGRlHc+AuuB6ZPhd+uh4WCkehP1h8oC2rSn7ZPIdXqbFMrt9ynTnDDTjawMF1Q
         848BBTSKTZRIXzLnszeNZYR+ChuLPXIkcrCPM/P0ARnmQM+XtMlL2g3mdaHsmnp10qPH
         b2cDklKWP5s7kfTQ6YvkqqKk858oYsPR/Gq/vgif0lU2PSQxXd6yeLq/CJxN9F0AWFag
         WMN2AJHZ9TNSSt263Z1EdoL1lQW87GDnYc4JgIQoMbXeQKgEzXt+h2f5vj4fr0me33lR
         UVfA==
X-Gm-Message-State: AOJu0YxhjQjPwbqP1SWzXfEAHS4NzVE8c935pFt4qlEwdEYlAVa7tL0Q
        jLXS63AzByafROKRkjHYZB0DpbXsFvAqeVJOHJ68XQ==
X-Google-Smtp-Source: AGHT+IH2y23DiNViv19gr+3P2n07qqR3+HXI5Ll8OTrQ10bG9dd7fvVIWWaEEK3HDN+3LbzRokbZo1i9HVtKRs33mNc=
X-Received: by 2002:a05:6358:71cd:b0:170:3f9f:b367 with SMTP id
 u13-20020a05635871cd00b001703f9fb367mr2362102rwu.26.1701784909498; Tue, 05
 Dec 2023 06:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20231205031511.476698159@linuxfoundation.org>
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Dec 2023 19:31:38 +0530
Message-ID: <CA+G9fYuGmAStz97QEyPj+pg6Pu0zmffx1Y4NWpd76Kt=tH4t2A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/30] 4.14.332-rc1 review
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

On Tue, 5 Dec 2023 at 08:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.332 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.332-rc1.gz
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
* kernel: 4.14.332-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 4937f1b0d0b4f85ff80f69a662a98e03626a7005
* git describe: v4.14.331-31-g4937f1b0d0b4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.331-31-g4937f1b0d0b4

## Test Regressions (compared to v4.14.331)

## Metric Regressions (compared to v4.14.331)

## Test Fixes (compared to v4.14.331)

## Metric Fixes (compared to v4.14.331)

## Test result summary
total: 52878, pass: 44955, fail: 1219, skip: 6659, xfail: 45

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 103 passed, 5 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
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
