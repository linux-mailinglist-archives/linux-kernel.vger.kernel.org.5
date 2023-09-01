Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7EC78FE17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349696AbjIANKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbjIANKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:10:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0FE7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:10:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58fae4a5285so20729167b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693573841; x=1694178641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI+f69Da0/ReHl5am5F0DBVWSgfDHFwlWTRWiRxoibc=;
        b=mrZx7AWSPHBioix0Vrk8gWnjYip/CPMgz5u4eAykmvketekga/31zyNyDckb/MfTGp
         dxm22KnK/g76StvmooxJKRN0yfWipPvFgbSYmZbLP48uHuX2wU0mT/ISOde3CSgBqQkU
         Va8BFN+imqUmK+ULcAZFilhPe+G6NecFJGIWPad7JaXWv9dfUzhaCACZ676RMNiQGA00
         RTOE44uYvSRnHzHalrIDDUNiWQNs9/U7RbuMouNfF9MiXfUtU5YA/z2Lpzc0LWKrbpl2
         XhvRbeRmOIDfdYy1L+m4MEwpvjfeRs4El7G5hcT9wwF1PD18CUaHUr8f89ZknYuF20eD
         7UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573841; x=1694178641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI+f69Da0/ReHl5am5F0DBVWSgfDHFwlWTRWiRxoibc=;
        b=dmcur3SjX0ZpEfzrwqxK/CWlfsYsSLjleybjSplBGXdhIqwmVpP01Orrnw93kzmLC8
         CZj1y0hU/qEiIse9m+cGO9TqtLbFBdGNnuan7GMaYUnueJHzDLTf+3ewQeS9bGmRY7fa
         N48ALoQmIs69HDH5HFrfHXsziGDT6VPRdrn49u+gfYk4dvX9JGvnXZDWu2LfzFLJG3Cv
         6zuiS0Yxh7AJdNVDi+ASE9UrZ4wfN8pXG4rOkbI4/uiB3c0/qH+Fs3tnhLLkbW5prAqg
         /OcwtTCsvdbSev7nXQX9cqPmei3Xt/J9GbangmBEZlV/zeG1Jxa5LnzveID1zu56ED0A
         REzQ==
X-Gm-Message-State: AOJu0YyhsxCq91xt3ghtEo4Gnc37aph0wywLg1Gc/kS4Dv0pF+FzmDl6
        raDZ7FWhLaYlTb/IYpFkortl1rl9DPgwzWw1pE4j3A==
X-Google-Smtp-Source: AGHT+IHnVRWDOWAqxI/WIpfjC6F74R6HnhkU4uKg3TUyMHBYq0LyhrGZeyaSJ37S9ZpOCnM7shhW8EZHJpyQFdiWnug=
X-Received: by 2002:a25:abc1:0:b0:d64:6cd9:29a4 with SMTP id
 v59-20020a25abc1000000b00d646cd929a4mr2592765ybi.61.1693573840777; Fri, 01
 Sep 2023 06:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110828.577111137@linuxfoundation.org>
In-Reply-To: <20230831110828.577111137@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 18:40:29 +0530
Message-ID: <CA+G9fYv_3cXagvCTPdgeVx8KNzd=Q1wfM4UiXFfMN=16W8+xdg@mail.gmail.com>
Subject: Re: [PATCH 4.14 0/2] 4.14.325-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 16:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.325 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.325-rc1.gz
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
* kernel: 4.14.325-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 9467395c02c9be2630558247a1ac6c7da38f81d9
* git describe: v4.14.324-3-g9467395c02c9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.324-3-g9467395c02c9

## Test Regressions (compared to v4.14.324)

## Metric Regressions (compared to v4.14.324)

## Test Fixes (compared to v4.14.324)

## Metric Fixes (compared to v4.14.324)

## Test result summary
total: 51160, pass: 43042, fail: 1506, skip: 6573, xfail: 39

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 107 total, 100 passed, 7 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
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
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
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
