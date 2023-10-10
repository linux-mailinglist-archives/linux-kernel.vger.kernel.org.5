Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A237C028D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjJJR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjJJR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:27:26 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668B297
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:27:22 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so1975252e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696958841; x=1697563641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/ryk5OUH4AM1D4cLx9s4u47FmouWQaJBw6IMdAQ1wA=;
        b=mlJ3UDweYGp3kJO3/fORmgscGaeJNwjd49EFXEO5ohxi2ccb/sgAy5iO8MNQrqZVzb
         h7p9IrJBnknH9NG9vsR31LmmXuxBs5K9gD6Jj5ss4Enj0z96CLsaj7nUsibEDRmGTJ1H
         RGR/j5Zp6KlzPcPotgq1t+PWk+S8okmKArHp7BhfekCUp8L0HsDiVmnHgjXgSJr7UNfK
         y/MI/4exwsPuCKjThsKGzlZer0bQZbzQ2ffgq/smslnVY8g6KufvDWCXs/m/tYoCyX63
         xQh5mHHKbpqoj+y+jAbh3hrOY3SkDjD0mOv2rhSu/Nx+xKPIGA9iP3fRhSXKf/JG7Zjx
         oA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696958841; x=1697563641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/ryk5OUH4AM1D4cLx9s4u47FmouWQaJBw6IMdAQ1wA=;
        b=xNB39XoHSBQX/oV8ycfkGJ/omZNM/LFdawnktHTqg3wDKAyVUr1YoB0XOmbJOEUcxN
         EXU0OmMANbL9qRpln5rzRSb/EkAMSDPnqSl4yGTJh8hDxgM6D1ZvmZeVxzgtavzGPtJw
         mS6CUTJ6sLBtiX8lriAH0nKtQEgJi94k1ld5g/wCaXMiLDEt8y5WAK0go13oyZw71/Lp
         bNH2b3wRIw78ETSfnzdZ7ST8+cDq+iAYQ8ZJvOsuG0Ny2oyVBqE5XXK83VUyHc6ytuP9
         w8lKYO0N5orTDc9ObBQ3F8W+SfzPhQwEqWtv0dtDcTUcVohtk1Ix96P2rpJ6Sh56HH97
         Lbqg==
X-Gm-Message-State: AOJu0YzASR8Bw5ZeXmPAnUTFxlNI/B4IbJeKEHiCtY8FNHHTauxyiSo1
        SrFxgRVVtLh46QshRcadzP5fBKRr93dsWcp7Xc+cdg==
X-Google-Smtp-Source: AGHT+IGQ7+ge5xOlOu9T4VQAyXg18tRYbKAMUD/SkIviX/U8Fa2CPfi0xJtpJo6ZSd8ytKLK7Rrzn9AGSl3GYgq/wS4=
X-Received: by 2002:a1f:4887:0:b0:493:3491:ce89 with SMTP id
 v129-20020a1f4887000000b004933491ce89mr11750079vka.14.1696958841249; Tue, 10
 Oct 2023 10:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130111.200710898@linuxfoundation.org>
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 10 Oct 2023 22:57:09 +0530
Message-ID: <CA+G9fYuVxDoSZG=hqYR=Jd=7VYP=7KwbuinB86TLj5H7jy-1EQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 at 18:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.135-rc1.gz
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

NOTE:
Following kernel warning noticed on qemu-arm64 with stable-rc 5.15.135-rc1.
This is hard to reproduce.

Same issue was reported on 6.4.5-rc1 and discussed in the thread,
 - https://lore.kernel.org/lkml/CA+G9fYvgy22wiY=3Dc3wLOrCM6o33636abhtEynXhJ=
kqxJh4ca0A@mail.gmail.com/

Warning log:
<4>[   14.987937] ------------[ cut here ]------------
<4>[   14.990732] WARNING: CPU: 1 PID: 195 at mm/kfence/core.c:936
__kfence_free+0x84/0xb4
<4>[   14.993264] Modules linked in: ip_tables x_tables
<4>[   14.995667] CPU: 1 PID: 195 Comm: mount Not tainted 5.15.135-rc1 #1
<4>[   14.996447] Hardware name: linux,dummy-virt (DT)
<4>[   14.997262] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=3D--)
<4>[   14.998008] pc : __kfence_free+0x84/0xb4
<4>[   14.998410] lr : __slab_free+0x468/0x4a0

Configs enabled:
CONFIG_HAVE_ARCH_KFENCE=3Dy
CONFIG_KFENCE=3Dy
CONFIG_KFENCE_SAMPLE_INTERVAL=3D100
CONFIG_KFENCE_NUM_OBJECTS=3D255
CONFIG_KFENCE_STRESS_TEST_FAULTS=3D0

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
.15.134-76-g6b29ebf84608/testrun/20386601/suite/log-parser-boot/test/check-=
kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5=
.15.134-76-g6b29ebf84608/testrun/20386601/suite/log-parser-boot/tests/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WWqfe5nx37NjiVzC=
Xq7ZjKeOtF/config

## Build
* kernel: 5.15.135-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 6b29ebf8460817018f98911286d0f8b8191d9c9c
* git describe: v5.15.134-76-g6b29ebf84608
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.134-76-g6b29ebf84608

## Test Regressions (compared to v5.15.134)

## Metric Regressions (compared to v5.15.134)

## Test Fixes (compared to v5.15.134)

## Metric Fixes (compared to v5.15.134)

## Test result summary
total: 89616, pass: 71074, fail: 2530, skip: 15928, xfail: 84

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 116 total, 116 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 34 passed, 1 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
