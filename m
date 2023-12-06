Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83F806DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378157AbjLFLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377935AbjLFLXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:23:14 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFDDC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:23:20 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c5060a9e5bso1457131241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861799; x=1702466599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gliW0I2EfN36qnQKowmOwEBc+x7UD9fKDOIjdkW4NnA=;
        b=h0IoElf3Sicz56LW6nX/TqbVrT9AM2b67DFBVy0FGLKqOaPv/Iq+BiN2Yq3XRoP1HF
         744ePZB64UKlYpKPq3fsy0H3ZfIDF40FrtVRap5jXLkU+B09kZKxcmBMr/aJW8HvcMKi
         RowBnGQb6If1lgEoKKjSi9eGoaCwJXnXwEnVTCwlPuvirOpCzih42jBQlT+8aZ/0A+3x
         8i3cJlSc09PYMT6Y/x0a5cylIAMIwP8oezwPCfmC1BXaQ2+xXVccrO6122K28uzxe+GK
         atCFmIL3xYMTZEIDmIuI9kYDeu8ST1IYzWMBTWC8rmiD9V6KuveYLyHLkQKVCuZLpstH
         eR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861799; x=1702466599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gliW0I2EfN36qnQKowmOwEBc+x7UD9fKDOIjdkW4NnA=;
        b=SQTHKeevfOfaAXzWEOGUTt3OFR34faMTQTSF76/WG7GYJPQFYFOS3uN97ahFmeCvgX
         rMVmO8oUBgVERMVSO+LrPtQ4vb4qCw7B2gLdWBfExltYnoI/pk7674wnwUkjScadvVOw
         9rbpSuWIWOOeVxlJrBkZo+FkFyFEFiOifGuryCmUnKUOWBACEsVA2BsL5c6BYl4ONM7B
         dR5XzPQm3Afa5iHTkKdBzdWL+L3dSiiie1Ynk7wuIYLubz6aeKiNnVISR8Vrl9/9pdW6
         XPj4iZqVtmDZE3bQ7si7Af2crUBBrqwE08rf3prMs78v805z1w+fcpyxOGCPlb7/I8wB
         FGwQ==
X-Gm-Message-State: AOJu0YxwQGIIB8aO7mOCm3aYW6iDBljQB611N0d1nOtYHcSCcuP9GiDo
        KF/87zdq5lpUPQqFVj7jNd98RpFFklFqAgKJIxm5Qg==
X-Google-Smtp-Source: AGHT+IGSmBwVl6smCPmKLJnEE0Yg3TaWvcZySYJu9zhZ4JV3Rfz72PbzYymCZvFv9IJuwZeHm7TJQe6PgD3T6C3zGu0=
X-Received: by 2002:a05:6102:4404:b0:464:837e:2f84 with SMTP id
 df4-20020a056102440400b00464837e2f84mr837945vsb.6.1701861799590; Wed, 06 Dec
 2023 03:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20231205183238.954685317@linuxfoundation.org>
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Dec 2023 16:53:08 +0530
Message-ID: <CA+G9fYvPD35zcGHGZx8CrZ42C4sAxuA5-KnyYsD4XP6LUMfhLw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.142-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: fef113ea8057148a392215b58a5901786c11dbf7
* git describe: v5.15.141-65-gfef113ea8057
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.141-65-gfef113ea8057

## Test Regressions (compared to v5.15.141)

## Metric Regressions (compared to v5.15.141)

## Test Fixes (compared to v5.15.141)

## Metric Fixes (compared to v5.15.141)

## Test result summary
total: 92831, pass: 73975, fail: 2202, skip: 16582, xfail: 72

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
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
* network-basic-tests
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org
