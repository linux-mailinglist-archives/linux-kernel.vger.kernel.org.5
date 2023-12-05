Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3ED805C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbjLEO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbjLEO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:59:07 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02DBF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:59:13 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c5a2b5e77bso867567241.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701788353; x=1702393153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8ly4PRrtbFhpvmMcAd/IAQqDN3hBgIZ/cSCffSAAOY=;
        b=Z21uFAYjL+KwqZAuLXvVpOHNQzTa0t8vqVVPApwNND7HOT2NIg1mReB/keeWBgM4o7
         dDrntGKFs9Tq3kd9aEwX5wmhuxrg1cXLmD0drMXwWzaFAM9LTMi0ZhbRHa3juFbxM+/C
         bL6t73/Ut13kCWdROzOY0ukApLWgk15Vyrca2YIBzXySwgMi+Cl79mV3/M4yFVYP0DvP
         T3sP47bJ/VKwqB+/mi/ZLYozSXWLXB0AL8MWU2flW2iZvU9tO3qKZRiSTO0W4HNZabqe
         HytE9+hxMguHm0cdgXpaEcJPH+/4Gowwv+6SvkthQCpM/C6BcmyQkIWgVwmRjbPn+IKq
         LvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701788353; x=1702393153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8ly4PRrtbFhpvmMcAd/IAQqDN3hBgIZ/cSCffSAAOY=;
        b=if1d4ey8KwDHCZwLixl3U6ZID1eQOQTw10afc3wBnEeKOvs3w2Dk+3c7X6sen6LpLn
         cBcj4aHenG4EFPhp2ZL378MOn299I4q2Z1TGlGNOWXpAXr1c2hTX97bhiRmsM7hJboBu
         4gA+bF24ITm0zR7p5kkntu3T01c1+jRoUzJ+nRwMP/ap9kto4EHo7CQnrPO32SZEoygk
         KDR917vxm5kKbi1x3NGFa7zYuDf0pSm7YLYbGirBx8TMeGyO8AuvmTajGxuY9xte+ZbD
         LCgdHV4N7eNh7Gcq7a8AfiPim62A9HMW4euHcN1qgK7aaukksXhR9DeP+iwBdwhFyk2k
         hphA==
X-Gm-Message-State: AOJu0Yxy/izpuJYYvcq8s736jpPMqyr466pfExCwaepQ5vz3N4yuN6VS
        I5rBUwuQhsePvjpOjYRaR8/OTz9WcWZlq9yLfwTkEtrIq+bHInUuznk=
X-Google-Smtp-Source: AGHT+IFFmj78JXPJcEQrLiGMwcKHkteXoPlhwfKxlDXUl0UR6JNMJeAsSWdEyzJb9Pm+DqpCXBVKKSuv9pY1Kfvwxjs=
X-Received: by 2002:a67:af0b:0:b0:464:7b6d:2efc with SMTP id
 v11-20020a67af0b000000b004647b6d2efcmr3614145vsl.34.1701788352287; Tue, 05
 Dec 2023 06:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20231205031517.859409664@linuxfoundation.org>
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Dec 2023 20:29:00 +0530
Message-ID: <CA+G9fYvZH1HhsznP1KxiBRoP7SbN-veMWKavdSoT4mGQ2_-2Kw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
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

On Tue, 5 Dec 2023 at 08:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.301-rc1.gz
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
* kernel: 4.19.301-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 82300ecbea435bee3c53b97f701e530cac79b81e
* git describe: v4.19.300-72-g82300ecbea43
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.300-72-g82300ecbea43

## Test Regressions (compared to v4.19.300)

## Metric Regressions (compared to v4.19.300)

## Test Fixes (compared to v4.19.300)

## Metric Fixes (compared to v4.19.300)

## Test result summary
total: 54948, pass: 46304, fail: 1597, skip: 7016, xfail: 31

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
