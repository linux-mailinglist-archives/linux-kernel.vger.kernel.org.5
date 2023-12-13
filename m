Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDA810A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjLMG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjLMG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:26:37 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A12A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:26:43 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7c5cb5eeab1so2202962241.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702448802; x=1703053602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryCEu48eUmxPP9GQqL9AHFaoE514bwONp0zHyCua5pk=;
        b=zZoQYcFfHnLLWKY/HGeqmE2tiMDdR0mbUB5XKN7Ia4KOeMYnLkk57Bqi1QRnDieF3w
         qxIjx+BYgToh9PzVCu6p8dCNNWLa0oXsr6AsrnBHqYcNNyDriAz/galpr3AByXzi6Pqd
         8N+SzXl+0De7BDuIfTi0eL6RzlEEiZycJpFaDZhN4WdXKXv+0rnPznrUsE/UNS3nCV5w
         W645phMCSOzYn0XFHjm36ksajmcp95fO2wDLoCawNSmWbrxG0COr8gNJ9gTLXxJ0CJVE
         oAhTJQ/CLyqQgBDBfGyovh1tygoTtSxI4DMhWdhkqjaTlbPeYJSMRIVNfix2D4hGRW3D
         jL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448802; x=1703053602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryCEu48eUmxPP9GQqL9AHFaoE514bwONp0zHyCua5pk=;
        b=NVHmAlscDkP+kZQBmCix1vHVnxGce0laXF1eH9yAIMRpHIwUZBUBO+6e+A+VowL1Uy
         8HRTmE27ifayC6wLiounbbMPq00yvZdbczwEAtEWURwJSUOB206vW2dl/EuftL2vvwJU
         HPUg7zyOPiWgfOIsu2xByxNPcgSCGEP7Mb21Ilgpvs09UvjwfYDww5OB9WCoZA67VRpu
         +Xz0QS7zhEYEqvSkd9jL+p1lDXDSH2WqVlTBZOQrrlu3bWoKrNB9I8GVPcCzaqQ1fboU
         LsWm3VZqgPW+08i4ZfodvDqlI4D7ux/7PUW4nw24YcLaZbmxPLzQnoBBHHKi1Y2AtBsI
         8Jzw==
X-Gm-Message-State: AOJu0Yy5Fq17bGIzOkdGbi9aviUrbFw5LMYfClImp1DAMFG+surmPj8y
        hXjhNlO6kN9LyIlZQD3WKutJTCihAOFhKjYYMA+u9w==
X-Google-Smtp-Source: AGHT+IE3A8Ed8eaDWU5zKh/jzWxbUFJO8WH0pwo+X34lGkKWDhF8k9z1qeRJ5iKHhBajzWLC1POJ7NRiZRinHLbkW0E=
X-Received: by 2002:a05:6102:510a:b0:462:8ca2:1bb0 with SMTP id
 bm10-20020a056102510a00b004628ca21bb0mr5336003vsb.20.1702448801091; Tue, 12
 Dec 2023 22:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20231212120154.063773918@linuxfoundation.org>
In-Reply-To: <20231212120154.063773918@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Dec 2023 11:56:30 +0530
Message-ID: <CA+G9fYsprWr-ZcSE_bAvuXA-sXbQwgjLJUcP0i-6QB5FGbKDVA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/53] 4.19.302-rc2 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.302 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.302-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.302-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: a7780f896379de16bc4e805ecf216959b5b876a4
* git describe: v4.19.301-54-ga7780f896379
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.301-54-ga7780f896379

## Test Regressions (compared to v4.19.301)

## Metric Regressions (compared to v4.19.301)

## Test Fixes (compared to v4.19.301)

## Metric Fixes (compared to v4.19.301)

## Test result summary
total: 55035, pass: 46309, fail: 1569, skip: 7122, xfail: 35

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
