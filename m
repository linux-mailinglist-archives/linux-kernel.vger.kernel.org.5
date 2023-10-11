Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17CA7C4762
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjJKBkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbjJKBkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:40:22 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C9992
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:40:21 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4526b9078b2so1901490137.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696988420; x=1697593220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZUcgeMqW4j0qmYpGncXU307vj/5x4QTOabyiFdBv5Q=;
        b=FR5JcfRvGpNjE66Fm+yB4tVZJXQMYtfb6GFCkcqckc93lma09vXtEujfrqEBziFyu9
         3Q3ebFhsdCDoDwznh8DvgPH2PFx9Kxa53AbfEV99etV+TAxBObjp9I4WXjdKSZZY8GwM
         H8bRurGbPC5vbkaSU7RTWr5Ef7SZ0gNCO4Eb913nNcd/yw6KarQ0C4ZAitbN2bYFVEyv
         Ud9MmnuS3rAkHRSJsRwnkohOFbvWI1sL5kzL/UbK6mUKNHI/WOOozs7IidimtJn91vaH
         R8tzZgqPYPDq4A4mHowEnk58qqe5IlfhCmFZDdG/IpJEP1kJ901qO0BaDmootZM3HKVC
         EVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988420; x=1697593220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZUcgeMqW4j0qmYpGncXU307vj/5x4QTOabyiFdBv5Q=;
        b=NnppXKkF320XHs/mHveUS8NwsCBMDKV7ZYTshi+OSjb2tDMdPg1B8IM9fc6YH6kElD
         2k158JBT69bLyUXII6w3p0r6uQIuPvdSJQDF2JAFrgMqXKyzLpnTIfEJ4B4Rdgi9q0o+
         xJmnQLPRrcwtGo+G+ufcsUXo59mhBC3dcigRa3+1dxCC1C6TzWdbh9vhJoWplNlxjVgB
         fDimzxcug3Ne4mnNuuZLjQsR1ANTG0pgCZvzHpyrqVII7aJFiWh5/8PHz//9Sz0XNW+w
         BZMEJ86PNQfed4j9A2nDec1e69e4KHUrzbXQ2zYmPWElM6LafLCOi66Qcz33GQ6sku0U
         PMmg==
X-Gm-Message-State: AOJu0YwEZzSDMGiHOcuLU5VTN1CWAUcH8sHPSnCjliJy9CKPW+dVPmI/
        5qAEAcVbiqIKgJ/A/1rUw48HQHX+sM0zlsiJvwPNTw==
X-Google-Smtp-Source: AGHT+IF+HQ9gLlPAlSdTrM1vC6Ktp8o6WJGTzvACfha7LWwpG5A1F2kT3IPJCCDyf0XGjJnGSJ6+wR77xh91rnkIKmQ=
X-Received: by 2002:a05:6102:3175:b0:44e:9351:e4f0 with SMTP id
 l21-20020a056102317500b0044e9351e4f0mr14155105vsm.22.1696988419994; Tue, 10
 Oct 2023 18:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130126.697995596@linuxfoundation.org>
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Oct 2023 07:10:08 +0530
Message-ID: <CA+G9fYsQAMM9yntr1EQpJMGWvLWfegUrN0fZH2bpcVdGiOepVA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 at 19:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.198-rc1.gz
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
* kernel: 5.10.198-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 18c65c1b4996e3f6f8986a05eceaf427355a7a4f
* git describe: v5.10.197-227-g18c65c1b4996
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.197-227-g18c65c1b4996

## Test Regressions (compared to v5.10.197)

## Metric Regressions (compared to v5.10.197)

## Test Fixes (compared to v5.10.197)

## Metric Fixes (compared to v5.10.197)

## Test result summary
total: 92938, pass: 73992, fail: 2587, skip: 16291, xfail: 68

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 115 total, 115 passed, 0 failed
* arm64: 42 total, 42 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
