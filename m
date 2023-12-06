Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6101806E25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377722AbjLFLiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjLFLiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:38:01 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B5D49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:38:06 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c55a04cd9eso2185546241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862685; x=1702467485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqiXsfY2To4PHI6eJQCHduTSebcEXd5uADmfhHEO5xo=;
        b=lR5weGfeGEsG+Gqj9mP9Z2cl5t+alFDxYQKdGX+HIZoX0aXDO52sETrUy5GW/DJ8Xp
         YjLjk+N3PVCv6puwUccKgFcRFAUeiEDY6B9jNKsz1Ul56JFNp/Y/3InyYNJI5xlM5ed0
         7KN/b3DQDxjLcyJMDxsNrVYO19RzbBWy8VWhtdpha0JlXjyuaeHbMfXSRvaBEKi7VOf7
         vE6QPMLthWj6C6Bw7zRiv3JZ+XJAKXhoE0lzL///6xJrR+L4QSRKEoCl/QnnsCWc7+2G
         b38IYVL2Q2WxZGzIi1Goz0RVeIO60Ix/4EHlZo5Tb6CjN93YB1MmkFO3r3EH5tnpKnBI
         Bgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862685; x=1702467485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqiXsfY2To4PHI6eJQCHduTSebcEXd5uADmfhHEO5xo=;
        b=jGR3TVs5e/N1AxsEkjtcp3xyeBlEmETy3ZA6UOr4Id9E/CI0vJlauCmHuMhgYwQNjd
         zFYJGgE0U7ZMUgASD/a9zwqPH0Pe14qhVDO9/ynRJ0QbE0T3QqMtUYWXDTwfx8ff9n1f
         eCWH6X8D+6iuLJ1ykeDLqncUdGIRVZd+vdbU9L0jMfxsbHWKsc5U4tFs/NTVV0YaJfh2
         K7g8bzryx8fpbTNkq2KvOAvkD6oBSN7Zjwt/fLuVF674Q8vDMYbjd0wcQ/1//37oMMdn
         FpJzN3PZUZPEMfDVt1JCUgVTuR7nv62zAShAI/nqFVxWR6UqFdk8VgbmMrNw38iUyC6n
         IC3Q==
X-Gm-Message-State: AOJu0Yw1YG7MVqbScuTJHgJjhiDHfPdZwUAZYHSnUwZVVQQUPZTDmLlm
        k28dwNoZenll7Zc4RWshxT3dlFo8+WGG/98Qgu/R+Q==
X-Google-Smtp-Source: AGHT+IHourNTb7WMH0K3D31guA9V35xLG/P7Tn9mTPPu0kJQ1+4eDDR2yXdz5EU4bC5uAzOSV87KWRPhW1gtjYwiyX8=
X-Received: by 2002:a67:ee1b:0:b0:464:7f57:b474 with SMTP id
 f27-20020a67ee1b000000b004647f57b474mr567721vsp.19.1701862685076; Wed, 06 Dec
 2023 03:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20231205183249.651714114@linuxfoundation.org>
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Dec 2023 17:07:53 +0530
Message-ID: <CA+G9fYsQLS9sksdRLphmSJ+K7bYDsdiq--xe+eivsOfAeM2Oxg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
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
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.203-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 3e5897d7b3637fe06435b1b778ed77c76ef7612d
* git describe: v5.10.202-132-g3e5897d7b363
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.202-132-g3e5897d7b363

## Test Regressions (compared to v5.10.202)

## Metric Regressions (compared to v5.10.202)

## Test Fixes (compared to v5.10.202)

## Metric Fixes (compared to v5.10.202)

## Test result summary
total: 86943, pass: 67634, fail: 3147, skip: 16110, xfail: 52

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
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
