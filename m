Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092C6810A06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378546AbjLMGML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjLMGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:12:10 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720309A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:12:16 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4649d22b78aso3670749137.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702447935; x=1703052735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e7SuwWSkPy5d+O+99K5FQ0FXWBJpq2eT9M5oPNmEik=;
        b=eQblFENhNu1WbJ1VPLysgfryBo0hlKC0LnBYeDDL9C2WoYRnKYFIPVsscESUeSmOoI
         WqSoLf89mGd69gB4lFG5Y7TfxU9A4cy8ztDjAssTWkP/K8Q39kzoeGMpeOnM/vWzIus/
         of0kvBshE51tByVFI4Zj5S5zszfvX2KWA/t2xBW4/qV7mXVNDuAgdKLuruuexu2JQqNR
         jPGcjAkA9Fgv5E5SLmxd3hRVG331QhxjU1KFXGf5fdl/Vw/3Ii1LGVXEsFk4PxR3wgxj
         LwWa7JGxnCxGc3a+GFQcFwnkfQT0mRh6qpksRR2RspZrnVe3kay/5AUfzUbSZ0Bn2I4k
         /SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447935; x=1703052735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e7SuwWSkPy5d+O+99K5FQ0FXWBJpq2eT9M5oPNmEik=;
        b=ctFO4OksJGX+kDrqoeqOTcW569cPoSr7QECHLhEGg13P4MxUJn17vcjJGu2XAyPjih
         Z5wn6wcJ8EggJGtpNcEo+9YokZZRPrkQzX2VrKFH4S4FoTpmT0Uprs8tUaWITvwdj9rm
         paUZeZr0wLeWg73DKuPH18Rw3ybUWr1+A9vhkzxH5KlJ5HvqUE+gG0bJpg6QZTdFDp0Z
         pXqmHmLHG0hhMwQVPN7A+lIEd0C3eHPeRe0JlOu1NHFxaYw1AkjUea16is5OpqCd0fGI
         CiUFV0S3CxhUXCg3XIFq8HoGKTr2NlMsEP7fegUt+41TPg+xyzDnOErm8pPWnT+OBPZg
         W2zw==
X-Gm-Message-State: AOJu0YznA3QkiH+/t19cvsDaGyzVyjiju6+/DP31Q5NsQgGqXrDLPpBE
        TP/I7+ToHx7RG8znTzAPCDENmB03HEx+s7EvyB3koA==
X-Google-Smtp-Source: AGHT+IERYbh4u2SMTvwZfr1Ma3Voh9+wFrLovJl22BLO3gSoCKuEYxExiPzH4V+h+9ENf+T+rbjMEApN2MFVsruDW8A=
X-Received: by 2002:a05:6102:6cf:b0:465:f182:c312 with SMTP id
 m15-20020a05610206cf00b00465f182c312mr5390083vsg.28.1702447935424; Tue, 12
 Dec 2023 22:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20231212120210.556388977@linuxfoundation.org>
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Dec 2023 11:42:04 +0530
Message-ID: <CA+G9fYupTF+iuBxQ_dZadnVcjMaMZDDnVXDp_pYKs-LUqWPSsg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
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
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.143-rc2.gz
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
* kernel: 5.15.143-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 58ec986ace5fb848c4bef206a848b461883867e7
* git describe: v5.15.142-140-g58ec986ace5f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.142-140-g58ec986ace5f

## Test Regressions (compared to v5.15.142)

## Metric Regressions (compared to v5.15.142)

## Test Fixes (compared to v5.15.142)

## Metric Fixes (compared to v5.15.142)

## Test result summary
total: 95978, pass: 75790, fail: 2770, skip: 17353, xfail: 65

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
