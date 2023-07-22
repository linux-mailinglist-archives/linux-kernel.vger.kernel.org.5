Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB275DBCC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGVK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGVK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:57:37 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B3E64
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:57:35 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-460eb67244eso1170283e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690023455; x=1690628255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2wGJF9wFfobg+vF6u4qnpyWGtTXV20qhchnCIbOz4A=;
        b=PDKPDITECpPuUu0xGVlXOjnj4eN9+g6JcqkUngM9N8gyq7u2YUux+MBpDyPPAvw2ik
         zaETHHAuJs80jYfSL8WJ65EKXm+N/5D+4/upe0LUDPodhzjskAq5ksDUDob+mda3z5OX
         1wAPecJIOZda6iP/qdee2kN3jJh2HkEI1hFHiqyQcbqhE3gM35SJEItvVlVddQzSn1PL
         y1Aa6X6wF7NrUlNyYRtupE+6f8GqyT+Q3gyrRvZFSUoN0/3ETX9tP18mGyrvBPl9bx/V
         oX55DBcu7JCKRE09MVmHrAy9U9HXmcUvmbRVf+KYZ/Cky7ZQuFD4vyQlzoxfD5jLbFFf
         5lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690023455; x=1690628255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2wGJF9wFfobg+vF6u4qnpyWGtTXV20qhchnCIbOz4A=;
        b=LqXbct8ZodqofqHBKnCg0M7/O14Ej9qADRJ/9gOG6ZZrW9hi2q1pNDvAr1s2jJwp0D
         cDdk6jqCUn8jjqYtknQM2E98F7RnfWjR9ftF5P9TPiB85rvCX36xqEQZvNH6prLz+rIF
         Qrh9gFdet0dqVfDmEbQSehZbp6SP+b1puMLknCUFbB5Kkb/b4gm8ETP0ANBdJpmHCC/B
         OqaVZ5hi8AyZUUKQYyvEk/KXqtHEuLikL5eTIsQKaMUxTDLvsKZwmSdxxxfHzzjf+PGb
         uQxah6ozgYjGCcyMqUAZec6OHTT/UNcrDPKCVrx5xY10iwPlpNIsB+zvXTQ/tyv4Lgsb
         x6rA==
X-Gm-Message-State: ABy/qLaLsIm21uLlhAojlGNCgDhM2r42p++1tLudMNV/5hXqyhPihwt/
        6/PXZRkwlvPl73h6AryKUTnbcije5pFV1nNnYv7uVQ==
X-Google-Smtp-Source: APBJJlH4dPL16gkptTTXCJlyhdltEG4bhs4yZORHL01GMhiKavaQZQPkS23juOjPhrWvr69K2eHSf6QsWtnQFq+nKlg=
X-Received: by 2002:a1f:d345:0:b0:485:e984:779e with SMTP id
 k66-20020a1fd345000000b00485e984779emr259007vkg.2.1690023453359; Sat, 22 Jul
 2023 03:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230721160614.695323302@linuxfoundation.org>
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 22 Jul 2023 16:27:22 +0530
Message-ID: <CA+G9fYvAyQQMMFV8o2bV9kM5sVaNKPmbxGN55Bq6m-MLUZ0S+w@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/532] 5.15.121-rc1 review
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

On Sat, 22 Jul 2023 at 00:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.121 release.
> There are 532 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.121-rc1.gz
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
* kernel: 5.15.121-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 48958c96454b9acda1f1117b5206838864697de8
* git describe: v5.15.120-533-g48958c96454b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.120-533-g48958c96454b

## Test Regressions (compared to v5.15.120)

## Metric Regressions (compared to v5.15.120)

## Test Fixes (compared to v5.15.120)

## Metric Fixes (compared to v5.15.120)

## Test result summary
total: 92345, pass: 74734, fail: 2019, skip: 15525, xfail: 67

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 36 passed, 2 failed

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
* kselftest-filesytems-epoll
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
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
