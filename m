Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2576805DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjLESgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjLERlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:41:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C68109
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:41:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77f0756a097so97713885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701798088; x=1702402888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlsdvKux8KBjo1yORhCzPi/wYEemn58vl14vutNt5b8=;
        b=e7iEbfnqfZa2hMoNJJGL+ivEQQJ4YJFxYdcjzHlaPBKrUS+A/y6ak+ruOC/DjunpEm
         j5e9GNeW7JGNGO5AHbVP7+/mUQS98ZbwXJYDVh0ZfkllbYkSrG4UnRRIurKOnC4IDhNK
         7BpqSBuyFYIepjKtOVCjXvedsK5F94Jig0n+YuNmf34Wgu3s9istVVGRnAgaPN2DYVHR
         kVed13tZzy24+zMIfHnwD9sQ46XU9iS/+I05jVRDwdKkPeLiOPmYPDYbFkLES0n+JUn6
         ZfnkS+bxtwX+jNYuWAQ6G44UqdlTyCHxBca5YuEQIwMUssLh43yUe6D/LIYDvXnBmE/f
         krww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798088; x=1702402888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlsdvKux8KBjo1yORhCzPi/wYEemn58vl14vutNt5b8=;
        b=vOTwYeDq8AX/GZBkgHEJmsSg8HFRLKW4RvDcmk8SC8ujJwHdqZz8Yu+xle7dskzphX
         /UUSVXa7XmmTBXNtfPsfXW37er21HWFCcA/X1TXY1rPgcWYh15CutkID2CZwoXWN2G6Y
         TJGvirc+zydTnz5YCZlnkpA/tGU2UW4gp7Ziex/Y4Bw5rLS7jp6mdSycuaN0tjiQgrPf
         goARSWS4faFswV5gw6gRXcbP3dSoATLDI9AWCvyDb3bQUfrcHpsuEcfcn3yXCNA6fvC5
         tS/0Ex1Q5N3IjSbnoFKr0xEfuTAZEyU5rXpAlsehh+yI7bJZjbNbFnHmQItlytUyBD9j
         +G5A==
X-Gm-Message-State: AOJu0Yw8bKIydeLjKvhIsD3eQMaB8e51buKzHWraP7Qc/8u43sExW8gJ
        flFUrRb7WPhFJ+FnzQKbX0GyQZtBa5WaJrFICI8b0cwR7ES+6FzNhOk=
X-Google-Smtp-Source: AGHT+IFxKRofhiHifghODSTOLmVOMB2G7Zc0olaleLmeblEItlygcVU8ag+EwNQUW29QQ8ODXdmcuIsP04W3EjkQWXg=
X-Received: by 2002:a05:620a:888f:b0:77d:795c:71f8 with SMTP id
 qk15-20020a05620a888f00b0077d795c71f8mr1229948qkn.19.1701798088473; Tue, 05
 Dec 2023 09:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20231205031535.163661217@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Dec 2023 23:11:16 +0530
Message-ID: <CA+G9fYsezgwb2W8ngoKELKxR7rxrOCzpxzixY3CojKrZSLkJ2g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
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

On Tue, 5 Dec 2023 at 08:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
x86_64: gcc-8-allmodconfig: FAILED
 - https://lore.kernel.org/stable/CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_Z=
UOhF9QRiOg@mail.gmail.com/
 - https://lore.kernel.org/r/202311301016.84D0010@keescook

## Build
* kernel: 6.6.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: b0b05ccdd77dde3d5f44e6849679a2af2f3af0e2
* git describe: v6.6.4-135-gb0b05ccdd77d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
-135-gb0b05ccdd77d

## Test Regressions (compared to v6.6.4)

## Metric Regressions (compared to v6.6.4)

## Test Fixes (compared to v6.6.4)

## Metric Fixes (compared to v6.6.4)

## Test result summary
total: 144804, pass: 124361, fail: 2511, skip: 17803, xfail: 129

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 124 passed, 21 failed
* arm64: 52 total, 44 passed, 8 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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
* kselftest-livepatch
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
