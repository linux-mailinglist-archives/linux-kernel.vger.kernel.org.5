Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F587638EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjGZOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjGZOUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:20:05 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD6E4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:20:04 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47ec8c9d7a0so2511254e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690381203; x=1690986003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuNc2mBif+BIOHURuwHXxEfwwUubFU0eTRxo/J2Xwpo=;
        b=NgAq6jTZRRUWgC9KwhgNd4VCGwpjlUXNLlWg3/b8GQcdidBn4j/KphpHayQVGb4Pas
         pjoRK0loIAm1WNcE2WhzIENBnygJgddqYQUZU7/Ewit4BolBS++Uk/wQeT0NhFAXNFe/
         2WirQoG+RKGmIU2+c2WqZEqhY02GAXwIrHhNINWNuLzOyJIEMwOmjI3CGb33mvvzZLfl
         6W+PCe7IRhII+crLls1eXvFyOGBknTST1hQIfNc0ZmVOobLm9Lada6jKMr99cyfJ7QbQ
         Ehd5dPNKuyaxRoy8TlaQPsjizsN/pZEgOj8S7Rx8bDtjSLdVqu/MWi5jMfZ5H/Ok8VX2
         qvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381203; x=1690986003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuNc2mBif+BIOHURuwHXxEfwwUubFU0eTRxo/J2Xwpo=;
        b=ax/sk3o4yGNhUgFfjgaynynCocmrGEKBKyvSapMSMu4eoYr/jExYmAD8l6m1Zv6cUH
         3WK9DTruTMDqyLuLghYDqpSrQDm4zMCAxBrceH55enz+W8ZLhvWtYjbYMEYL5Flpb5z0
         npaT22LjLy3ZgiPZoHwEnQwDuC0WC4O+WppKXUWZhdSIBZWihsaxcuRA6aebj9aNXgKG
         QU0bgBdaelKAhOMjbB1LuEJjZl5ZCWoh+MCciXvZx4MK+ToGJtSq8RwMgBV7QPeqB7zT
         6xnaIU8o7jhzjX+S9P5WavgUzKmZFlBrUPEmRX8kuWAwcK55TGro+UatJyBVGYI+XrCM
         HwtA==
X-Gm-Message-State: ABy/qLZ9hoWS3eeppIURdlQhV4uRXjUwCq+KcUndsLtXsNSh0kT+TdwU
        fkBLBFyuDQ9a8dc0sT6Hyc+x/468atqTt6xaL5Z1ng==
X-Google-Smtp-Source: APBJJlE3pdkBqKvbvyhlZC3z8P845HDU/BelwH4LpjEKE7V+540n769YZU7DhB1GE07skqLUqDBCTIlapB2gEGwv40I=
X-Received: by 2002:a1f:3d8b:0:b0:471:5427:39a5 with SMTP id
 k133-20020a1f3d8b000000b00471542739a5mr1460808vka.10.1690381203231; Wed, 26
 Jul 2023 07:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104451.275227789@linuxfoundation.org>
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jul 2023 19:49:51 +0530
Message-ID: <CA+G9fYvKc0eAvrt8oN7TY2UaEWxnM1Me16vaAjCpyR36gABw1Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.123-rc1 review
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 16:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.123 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.123-rc1.gz
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
* kernel: 5.15.123-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 3bef1500d246a00c075b244b6bb5849082569081
* git describe: v5.15.122-79-g3bef1500d246
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.122-79-g3bef1500d246

## Test Regressions (compared to v5.15.121)

## Metric Regressions (compared to v5.15.121)

## Test Fixes (compared to v5.15.121)

## Metric Fixes (compared to v5.15.121)

## Test result summary
total: 108059, pass: 88081, fail: 2274, skip: 17614, xfail: 90

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 113 passed, 1 failed
* arm64: 42 total, 40 passed, 2 failed
* i386: 32 total, 30 passed, 2 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 33 passed, 2 failed

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
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
