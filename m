Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BC763CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGZQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjGZQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:54:10 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC2626AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:54:08 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4813422f311so3977e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690390447; x=1690995247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1Ud4xqP5nkcbT5GKuYNAcPWbp+qIOEpFRn8TEyuTR4=;
        b=uAQJO9Y7aK/Xx14i40eQ12DBo4ncfbEYufIzV4tBGwMns0gBvVx13OxJQwokCn+LW+
         3JY4JxwVps3hWob17Cd/I960fxHow2OldIkyj9727U3m9nZy5KdJXeI59+sQPsaSwD3c
         Os2xh0ZCR6rrWmgZZcMBAUKzHH/YyhKYbych2csHZJahxDTKh+ft4rh7WrnKgB69x6Iv
         fpaeNj72u424cnrKtDbGxpBC12KWKBf5KhoqmT73enm9TnfEmW7JBlEbQCI8A7gA/slZ
         GmLgCbENar2x7KDg2+Tzxvv2r9hyCOIsizBdcWDrpHqLpxTu2btwxamJ1df0I3e1Ifo7
         hiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390447; x=1690995247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1Ud4xqP5nkcbT5GKuYNAcPWbp+qIOEpFRn8TEyuTR4=;
        b=V4MV0ZlQuTtRMABEdXR11b+t5SruQjZagcsdT7hC94tGe0G8JvmVo8pV0JTQ9XhITD
         V/ZeWqeYn/PxuCdv1+uudNCicnalMmzMMeiypnx2w0WHIfPB5zZNUYBBANOyUbO5GOgj
         7XHnFm2Q3z5F7Gx6hhlECUipzxAN34POEuNLGnTa2AaWCswq43omkMva+xMBkEJVDL1C
         J4i1fyZPrPxXeNshIhBrrg/MssKOa7Aq0D3SP16Z6sQOtFSwGystPVQ20cE4ZgkKj5+4
         uw5NGIIz9CDnrCR0O/5YCYpOIYgAoOnR29OEdo6SyNL2tqxE943t2aJrAK7PFegxWgkR
         PyWw==
X-Gm-Message-State: ABy/qLYTUbBmoWfNiwoy38MKnJTUTc2dN+6i1bdCD8lqz86dB8oKFoPt
        RERociIwaWmzo12mWCX8S/GmiCPoOerOLgVxhbjPGQ==
X-Google-Smtp-Source: APBJJlFaEX/3W3iFpn5QK5fhlrSRrfhlg42PFev+G3+gvgN+2bnEQiwgQCj3IvYw/kaVM+4pmC01br8Z9QPrsQYyurc=
X-Received: by 2002:a1f:600f:0:b0:486:4338:33ec with SMTP id
 u15-20020a1f600f000000b00486433833ecmr1863820vkb.11.1690390447618; Wed, 26
 Jul 2023 09:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230726045247.338066179@linuxfoundation.org>
In-Reply-To: <20230726045247.338066179@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jul 2023 22:23:56 +0530
Message-ID: <CA+G9fYvK5Zz4b2hh64SwZMh4YED=ssDYkbwTUrThP4wS8aSs6A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/310] 5.4.251-rc2 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 10:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 310 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Jul 2023 04:51:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.251-rc2.gz
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
* kernel: 5.4.251-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 25e11282f51e116ed3658f586a175a559364ab39
* git describe: v5.4.250-311-g25e11282f51e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
50-311-g25e11282f51e

## Test Regressions (compared to v5.4.249)

## Metric Regressions (compared to v5.4.249)

## Test Fixes (compared to v5.4.249)

## Metric Fixes (compared to v5.4.249)

## Test result summary
total: 104377, pass: 85830, fail: 1143, skip: 17339, xfail: 65

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 45 total, 41 passed, 4 failed
* i386: 28 total, 20 passed, 8 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
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
* kselftest-mincore
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
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
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
