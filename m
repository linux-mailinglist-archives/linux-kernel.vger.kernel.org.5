Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F780F400
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjLLRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:05:48 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B99F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:05:55 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4b2d08747e7so1487575e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702400754; x=1703005554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVUABKJnbmOSs8hzbW3BwjC3WNYniAwiEC94aShqVUk=;
        b=CZnaI6slCuXnb2KTTY/SWvjFaxTC0xv223Kx1le0zaNLuoXamiOjo4+bsrzsHMnGqP
         LX4J9H8g5iDjqwEnRyV+yX/t3xAq8fAkbKtbD+TFlEYhLQxVjQcvZw6g7SNBPYWT+1aJ
         BpzBz5lr9m4qYQb7HKhI1YyzW1ycgwRkwQWug4BvAHl3ru/dW+0vW1ndf06tJyA3UBp6
         gGkP8MA8Yn05dpsP+VXY0S8e2YcTtRfTCBLy7BC70LxStFC7/1cMrvD54xsdtxi5cV8h
         fluc6u6qSNVdHBox7MqVM5SB1m8txEwK5x3dchlcAZ0S894DHmf5C42oPxxsFE6R/e0V
         yGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400754; x=1703005554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVUABKJnbmOSs8hzbW3BwjC3WNYniAwiEC94aShqVUk=;
        b=B+ohBMNEAgY8lThBt3P3tkIKNzVsbZOB6Wi2JEPFIaaBw7HMZqsezvrQUJ9Z7HLH7H
         +xSdHJLSd3bbaLKfeYCQC4j4jSu8GnQvEOgVpADT3k6DN9InsekRuWP1jYMm4zl20WqP
         E4xt9S2aTVkBmEGuaoO3Y6RL2AT9rK/7AzT1Ezs6Q2zCrRXgWhHM8w3FJ20sIOk2X6jy
         HsbrtWpfAluLvo9nEWV1fxwt662do5md2G/34jlHm+WvSUpu/i1tu+c8ZkoOJ+9Wxh8x
         kXyjXxk45PWrWnu7p05RWew9z7I01MZFVujfMmiGVUTPSWuAO/QBr7D4X+1YPOxJYd/+
         B/gw==
X-Gm-Message-State: AOJu0YxYtbWdpeECiT2Nj5c8pgD3k64gzzDRFpYSBuUczgoAygsG+drX
        kUaSc1YB3qNcm4PoWnDsXPXUOpyG8PGnzw8Mo0Wafz8JK49AwW/L2cQ=
X-Google-Smtp-Source: AGHT+IHBiISUg2Y9QZHx1rbNNItehJ/pakkybBK8JWivD6+77n9KarFXRbQMUh2xUKcZj4lfQ2bVW9V5z5Z4ODd0vBY=
X-Received: by 2002:a1f:f84d:0:b0:4b2:c554:ef02 with SMTP id
 w74-20020a1ff84d000000b004b2c554ef02mr4148071vkh.20.1702400753818; Tue, 12
 Dec 2023 09:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20231211182015.049134368@linuxfoundation.org>
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Dec 2023 22:35:42 +0530
Message-ID: <CA+G9fYs4OTxPPA7oQxHfF-NWvHEVYX_62yhTwwG3A2b5ZLKCWA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 00:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.264-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.264-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 852f04d9850582c3df740ac6f1d1c507cedd9134
* git describe: v5.4.263-68-g852f04d98505
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
63-68-g852f04d98505

## Test Regressions (compared to v5.4.263)

## Metric Regressions (compared to v5.4.263)

## Test Fixes (compared to v5.4.263)

## Metric Fixes (compared to v5.4.263)

## Test result summary
total: 91574, pass: 72218, fail: 2103, skip: 17206, xfail: 47

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* kselftest-sigaltstack
* kselftest-size
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
