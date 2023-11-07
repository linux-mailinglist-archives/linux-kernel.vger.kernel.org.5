Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4F7E47F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjKGSNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjKGSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:13:15 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557A126
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:13:12 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ba6fa81aabso2679416241.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699380792; x=1699985592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/J3DPeT6gSknOUUjeqQ13coAHAXpYME81QAKfIuh2I=;
        b=Fpwmh6VSW7AVaUoVxW9yDQYpD0Hk2V+GKngeH07PTuU0d5h/i0hQ8J4h1Jj+q6CUWU
         37KagAtSYkx5YQF6Jm0QN+LnXP6ozUtt+rkwPrfFaYvCfIdXlUH8id9LXMAr7EgVBUmA
         wBB34O22sUk2Wm7ZFfAT5e79/6l8NSBfKNu4hnxhn4+1aQDhG37vAnxD++a2A8OJ9I2i
         YPbehcnagw0PsMtMb8hm8lCbCZHEWsNY88qWphFj84efyg21VmUwVZ3ScP2EmO7rfxTY
         1itnOtCFdH50dJCh3CZCvGvB2TrcXIbg77DkmNiReQElw7nBCm4TFV9GqURRMTy7NDey
         PBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380792; x=1699985592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/J3DPeT6gSknOUUjeqQ13coAHAXpYME81QAKfIuh2I=;
        b=DKQFQTN4oAO8811kdWdfl/cO+FfKN0dc1gp4AanRQnpBYwNibcDd+pgWSJ05WwkxHW
         HGTjlGndXIgXMD3OGcLu4nFzcMyEPDAlMxtsK5BpyU90HTlfNGH+WXnXRuwA/27ohB35
         a4glfIcZOx66l11h8swcPhbnF4OQO3UINmCC0J+A8Nobvg3XHWoUbUNS+8hokzxRimU7
         FZ2tVBX9R41lOV8AMLRCIJ0NQdTzw4uXqw0i44P/1P4t7/7a7KGgU/qpoZetzzI/sSrZ
         JJryQEBYcKMnSOy1uyUdGBthinbql9kZtSN5hyQZKLFz18BWnZxPEXpkIuTj4wQ3PjIl
         G/WA==
X-Gm-Message-State: AOJu0YxKsA0lF+kvT+j+nl9TehcgsN9+1LEmeYyzxFq+1a08DLdFBIRR
        8pCpUm61lXAcCAs0e7GUpWE6tt22rOFfXD1Fp1wDKA==
X-Google-Smtp-Source: AGHT+IG72RlQd8VlToUeJ4plVUC5nSJ+pUOAjTQhU+hR/V3UsDULtiEUvo7/z7zFCvZ2W4TvM97IV2YVgq0d0eRnyOY=
X-Received: by 2002:a05:6102:20de:b0:45f:57b4:c20d with SMTP id
 i30-20020a05610220de00b0045f57b4c20dmr5177534vsr.2.1699380791958; Tue, 07 Nov
 2023 10:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20231106130259.573843228@linuxfoundation.org>
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 23:43:00 +0530
Message-ID: <CA+G9fYssB_C07q4rL4xqkLVtN3_6XUj_Pps4HaG0NAQx7Rfd8A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/61] 4.19.298-rc1 review
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 18:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.298 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.298-rc1.gz
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
* kernel: 4.19.298-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: cf4a4e22ca8be35b01101e3d8d6d1dc62d7d2412
* git describe: v4.19.297-62-gcf4a4e22ca8b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.297-62-gcf4a4e22ca8b

## Test Regressions (compared to v4.19.297)

## Metric Regressions (compared to v4.19.297)

## Test Fixes (compared to v4.19.297)

## Metric Fixes (compared to v4.19.297)

## Test result summary
total: 53428, pass: 45034, fail: 1563, skip: 6798, xfail: 33

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 110 total, 104 passed, 6 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 19 total, 16 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 4 total, 4 passed, 0 failed
* x86_64: 30 total, 25 passed, 5 failed

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
