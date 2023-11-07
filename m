Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9607E47B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjKGR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjKGR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:58:55 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE08F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:58:53 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4ac20c41e82so1309527e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699379932; x=1699984732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wKYIjRk9u20OhZbZz7Pq1pTPus6RUsjTNPft428Eb0=;
        b=BjIULtE92E2zIWLRx7l8aR9tHneiwhC7ZwQ6Hiw4z+fUmxI+sOoSyPcYUxX9sDEWPk
         hoCZsKdkpEjs30MdgH+bVF6GcD/HJ6dhlwEspeg1xQN0b7bzE7XkV9Vp6D39KE7h0MKn
         WK4kjVsRY8bcAq1IWjfDffGMuQHjOq4x7HriChIczj9z1XrqNgWMNQ5i52hsZh9+syvt
         oGopRNckdzwmBhEtYsBYjJXosOE9Nnkvu08Dv35nh+zhyKukDXrDgA0b5gXC5ZpqJ+mf
         CyoUmXU8rxTVu36XeSqcT0ViFI6PyIjDTa5Ryv+Z8fePr1qD/dnUXEgILfBMCs+jFMEn
         z+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379932; x=1699984732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wKYIjRk9u20OhZbZz7Pq1pTPus6RUsjTNPft428Eb0=;
        b=bzG+3+t4SFbq8tWKZKOo2/MdoyQl4sMwPZE09L32Bdc7Olqi3olvkf2dU1wWKLGF1T
         ilQJVmb8hvFb6jF4rivExwb4NTmV8XytijVR+TmRyDW/np+DCR3WUUbQz7L+sz8xRXTF
         4s6PyRW0ScYpG/EeQVricTaQCp0FI2aB+9es0U5S7AIDXHwOW/0UAhV6yROc8E69vPE/
         r1JFDRKs0oJOOFGByjZyq3NzXZOMPYPA1rB/Vie2swRaGJerVz8s/uQ8uX2bonDWPwLg
         Vxm2vy11sOOyRXV6WL/tvT4D0eds+yR9AnJjxG8xdIcmxlV0K096GUxkE1Pt2fwlMIUn
         f/Fg==
X-Gm-Message-State: AOJu0YyT7UTgnphI5bQLn5g5FOGIjpS1JHZZgoez7j5YYcl4bGNpZF8J
        Dw8J2597qEVjHitUwyJCGsxv3F7NLA5BMjx6BPX0Qw==
X-Google-Smtp-Source: AGHT+IG5z26zY9vVz1AkbSL2orZlMYhnkYNGVSG4XHuqY9aiXHOzIeMDrxyV8LUdJIIQzoww6sJgQ71i7mUkiFxgGZQ=
X-Received: by 2002:a1f:2f57:0:b0:49b:289a:cc3f with SMTP id
 v84-20020a1f2f57000000b0049b289acc3fmr29050940vkv.3.1699379932606; Tue, 07
 Nov 2023 09:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20231106130309.112650042@linuxfoundation.org>
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 23:28:41 +0530
Message-ID: <CA+G9fYtp3fh-jrU3pta_PeVRTrLODdbWDtJE5ppxUZu+Ek6fDA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
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

On Mon, 6 Nov 2023 at 18:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.138-rc1.gz
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
* kernel: 5.15.138-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: ec134bfabca018727b246a05cbd7d2da66864974
* git describe: v5.15.137-129-gec134bfabca0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.137-129-gec134bfabca0

## Test Regressions (compared to v5.15.137)

## Metric Regressions (compared to v5.15.137)

## Test Fixes (compared to v5.15.137)

## Metric Fixes (compared to v5.15.137)

## Test result summary
total: 90364, pass: 72614, fail: 2502, skip: 15189, xfail: 59

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 111 total, 111 passed, 0 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 9 total, 9 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
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
