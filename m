Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C97E483C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjKGS0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjKGS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:26:49 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00A184
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:26:47 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4abf80eab14so2020616e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699381606; x=1699986406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KXV1p3zsKYtWAQQYSZiCkScz7P33fi2+JtuHXVpT4Y=;
        b=H/9qxjeMYFN9R+I1MxkxneVs7TvmzBvcJ+Pln6kQWis22TxqFzDehCEfUJgT/bnUS5
         noKK3CAVk/UN8euIjofmm5WLB2xoS3nWShvUJXlK9MFEuDUxeE2lhLiPD8OnPmQHBzYy
         Zj+ORhdcB1Swtp5QCPyeYx4ov3fWzHVIr6BS8iXq2DTdaQPyssMA01TsgShzgTdX1IM2
         KCcsuts7S8ylmqDyDHmS9Fcvoyz226qUg83CDb3ZcuzlIL3PgfGXgwZtnLiGXIMCfFBf
         hNpzj//1XAIH3zuAxIyRK4IbJ5uL0gP1IgblKipVEaX2zo6gpRW6uEZrGqFfs2LR5JqI
         98yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381606; x=1699986406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KXV1p3zsKYtWAQQYSZiCkScz7P33fi2+JtuHXVpT4Y=;
        b=k6ak/FAzjT3IvEu0ZMcqxxvheTSs3EtO8SKoye9VPkCSFC4hIRAYssdIrNnNmn6CMv
         8Fsm/xoXyh3lbiBaIfJHD0HBsTTNiDUSkmd1DttyfWzNm0GQo1av8f0nxgYQlRJil/o3
         EFqMnb7RidmpgSWR2kYZMeY55L1zk6yvNKCpCJHAvbuDt3PnBlx8B3ho7lcORF7jmvm4
         N4FRvs4NoJw8KtVNqybAySLINDfgMBUyk02oHg257woq4qhrCfOFqaf3ftUKE27PQCt/
         NE5Nz2a8afKjhRnMnaKXToU6hMrYD1U23qy91WFIXK1Gp1IjLX3b2JAzNlmanHIHGxEd
         m6Bw==
X-Gm-Message-State: AOJu0YwdNmrRXslBWOm9fCUg+sn3mCnYuxOHR70Q9Fe41x59Obluxd0I
        EGu/W1k4N9iGca60nR5eb8N1c5Mk9Yi/+FtB8vqr9Q==
X-Google-Smtp-Source: AGHT+IHvAWUWkPDxuN5004b/0EeB57kSIgWAUM6P92bqaZVZjRDrF30NX/Wqmm0/cwN6Q8YZyNieb7M2NmxBn9Xgc9c=
X-Received: by 2002:a05:6102:5a:b0:45e:f983:7072 with SMTP id
 k26-20020a056102005a00b0045ef9837072mr8072949vsp.31.1699381606390; Tue, 07
 Nov 2023 10:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20231106130301.687882731@linuxfoundation.org>
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 23:56:35 +0530
Message-ID: <CA+G9fYueD6h+sijhY-tP2DDhTtkjF53cYpypFpeBpHr=fhnRXw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
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

On Mon, 6 Nov 2023 at 18:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.260-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.260-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: ca21f12ba7d859ae3203525ac055a1882383b1b9
* git describe: v5.4.259-75-gca21f12ba7d8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
59-75-gca21f12ba7d8

## Test Regressions (compared to v5.4.259)

## Metric Regressions (compared to v5.4.259)

## Test Fixes (compared to v5.4.259)

## Metric Fixes (compared to v5.4.259)

## Test result summary
total: 88180, pass: 69717, fail: 2382, skip: 16037, xfail: 44

## Build Summary
* arc: 4 total, 4 passed, 0 failed
* arm: 147 total, 147 passed, 0 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 29 total, 23 passed, 6 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 14 total, 14 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
