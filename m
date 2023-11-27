Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D067FAB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjK0UVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjK0UUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:20:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03F1BCD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:20:40 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b84478dd51so2817729b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701116440; x=1701721240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t2NzrYRK1cQA6Nbs9R7f/RggIIXUG+CxAVQnblSzuic=;
        b=JwZqqm7o/pFFfHDwJm52Z76UamhXy6Ax3KpHWh5/SZ1NJF7PfbvSoOV/vOieBY0ZNu
         9PqXbR2q3tmwPkbon14uzM0Axpucu0184Wz8YN5+XXt9ZLxqOiossIAZLsdwfNILrfQO
         EQ6yA1N9iCn8hFYnm/U/78zOjwwBzKhR/M7D60LDKECr/1GSnPpoZp5xZs04zGvjvU0y
         mfsz0xIz9xXqnqleU0ivmR/ooe7D0J40yxSHVzSE+ST2irwMWc2VFCWhmxErXhbMCmsG
         8jEsqVBdxB3WWptGv8nk2Kt9nTyrE3JIemeP3Zcw6d+qfQ3O9TvDTnIVFeS5kufl5mat
         e/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116440; x=1701721240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2NzrYRK1cQA6Nbs9R7f/RggIIXUG+CxAVQnblSzuic=;
        b=abpapLpbI5SV3pXnzn/HfA9h3Q1go30vqekmevjX7YJhRuquxVZswlHoXKTx5pr5kx
         NOxPiw0jwzq75R6/NcDq3TAMvch8fiCAALw1yyqDF3cETDLYY/cgqBCLKq7Yjp78zUoi
         EOK57DW97dMt7RwYKBa0lW2+xcgwZASDnXkVKgHUoAN0nayDFfZylek2Hqy4UsBNYitj
         En96qAZ1OJVAl+1WQliSmN1uye6K7YbmmQhBWKfWQ/DzNfuQ1YgsBN6jMRVvGrRIbdM6
         HrwXKKtXxAw5+insUi7a2vaII24DLI1QObuCyZzBGPVJCWTruTZ6Ed2dABi4nnHrqbYS
         JM0w==
X-Gm-Message-State: AOJu0YzcoF1mClX9aBYh7mS+B/0E4l7wrUGobnqFmoliONDaW2edskqx
        p60krq5DhVZTePLo2UhTBTQzm02cawVeCuZq0IOEjQ==
X-Google-Smtp-Source: AGHT+IGCPBUooJKVCZtpXckqJRhyldpmsmzNHObiJ7d5EWHZTZ3D4Yz+OG5FjDn4UO/qTEspQc7WDWbp+OX9rAfFaBU=
X-Received: by 2002:a05:6358:71cd:b0:16d:fb2b:d0e3 with SMTP id
 u13-20020a05635871cd00b0016dfb2bd0e3mr15576067rwu.1.1701116439646; Mon, 27
 Nov 2023 12:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20231126154323.146332656@linuxfoundation.org>
In-Reply-To: <20231126154323.146332656@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Nov 2023 01:50:28 +0530
Message-ID: <CA+G9fYtitr-n-H+q28LRBs0tpuS8aksVHNoD1L54M98=FedyZw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/92] 4.19.300-rc3 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.300 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.300-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: c66845304b4632f778a17e0056b8df432123907f
* git describe: v4.19.299-93-gc66845304b46
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.299-93-gc66845304b46

## Test Regressions (compared to v4.19.299)

## Metric Regressions (compared to v4.19.299)

## Test Fixes (compared to v4.19.299)

## Metric Fixes (compared to v4.19.299)

## Test result summary
total: 51623, pass: 44853, fail: 854, skip: 5883, xfail: 33

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
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
