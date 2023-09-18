Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41E7A551C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjIRVeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:33:58 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D402111
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:33:52 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-452527dded1so908946137.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695072831; x=1695677631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIZx05JLJAmHOrZCr/hJJwUvmnsBDSO2CN/31nMnpSE=;
        b=EWTrKJf9bZhlNOhTR0dUnIBXFg+SJh61XYKjWMUgWXHsgklAyCP8oZEdAYBaRRN+7H
         ocKR+m8U22ilE+ONm9XMZods8rzZaeykVt2Q6/VUrpXsp7LT1UHrAXSN11MSYB9aDxH5
         kIpEro1fOYNIDReGN9UL9q/DlbtGdNY1bDBgVa+SV+VzhZ52Qio4LwbnyHG2xXGAOPOB
         pq8HK9fK8QHBuLN8NlYwmr1QXoTKuL6zQk4ZXsFFDHca+GjWA8BWP5//ljkHvmR5CUxq
         1VCvY7SxKLc+0xzy7wyjgFQg6lOJ+HMFyADvqHt68VsZ669btFmbXuhb9Yo7xDxJIGBa
         Rtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695072831; x=1695677631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIZx05JLJAmHOrZCr/hJJwUvmnsBDSO2CN/31nMnpSE=;
        b=hlfBkvy+fE/TqHcqXFaErIXe7MoBeGhhofU26pxALcoDsBECk5TP09DVqrjG7MPIeO
         LCIdutLLdsmYMC8/4+l/Gi63OEZgCu62WT6GR2vi/Dr1wBY8Sn0alxd50xw21+GErPNK
         k8m3rBe2xnNhtlkQovlIrgiR/DYUPosQAhHBJyHXoVibqdNBQfZIswrvSGpdjzXaMJMv
         xH31zMozmFfl67XtQJS2X92UCPn9Eax33I79sn5LoVx2sWoP84OfPeJtyJBP8h8Cfhul
         bJ5SKCDe3xUV/zL9oTJqVn6K1G7xzKyTYHY89SMoXfWceJr0kOOpt3l9R6PkYOC24YIm
         VmpQ==
X-Gm-Message-State: AOJu0YwwjGDCDNB6qV57YVCoKNqjB545wT6l1Zd6C7pIqCOA8XLgiZpQ
        rcaCjK8AkDqa9AFUa5yabv6ZNU6vv0kIgMYGiYUwRA==
X-Google-Smtp-Source: AGHT+IHLhrmXSQ/itj/VEMUQIBZOtJusuCdBSn4CNVSZXaoxsnWtZvBsp0tNfVwOHox+0EW+xxuoJynPshEkDR654JY=
X-Received: by 2002:a67:f6d3:0:b0:443:6deb:2b4 with SMTP id
 v19-20020a67f6d3000000b004436deb02b4mr8425927vso.2.1695072831407; Mon, 18 Sep
 2023 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110830.455765526@linuxfoundation.org>
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Sep 2023 03:03:40 +0530
Message-ID: <CA+G9fYv98+4vjxVswpLgx7PsFM7U8nRp2KM5O=_pTfSzFG_kGQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 16:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.194-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.195-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 95379666b7a68327e8f4c3a0dbf28ae0c479ab4c
* git describe: v5.10.194-407-g95379666b7a6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.194-407-g95379666b7a6

## Test Regressions (compared to v5.10.194)

## Metric Regressions (compared to v5.10.194)

## Test Fixes (compared to v5.10.194)

## Metric Fixes (compared to v5.10.194)

## Test result summary
total: 80823, pass: 63120, fail: 2111, skip: 15541, xfail: 51

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 111 total, 111 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 11 total, 11 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
