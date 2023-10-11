Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053097C4765
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjJKBnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbjJKBnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:43:49 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:43:47 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b5fe8ab5f9so560241241.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696988627; x=1697593427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSiDNY1At9S23ErLXYjIIHPvj55pOXoepaXSEOsk/yk=;
        b=HzHH0Z+HJ1ne5SnJu/1Ut9WvEe0lRy/Il2qkqUGoxUoo8KldpP9+xOKy1wwbPLVxRk
         KWkSZEu3QaMacQv/0AB4AeQWOLKypDIV0748xWO50xgoccyRi5wel+oO8b301CQUjsrz
         kegVE2vVhLZD/q1niQR0VleGWpwze2FC4chVPBXpSOOg51358E0CYaglvl5UXKff68wh
         Pa1WKSG1fxJlf6whfDCIasA50YuRuJGE7Plkp5pYyH+L8dCHkvKmWcFwyWM4oAzAVIjX
         SMSz6P5xSfc0yk8WZFe2QwMBAuMMnw0/fNILQJ6AGIh6BOVDjWXk/UREQhNtKvPCHjSO
         a5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988627; x=1697593427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSiDNY1At9S23ErLXYjIIHPvj55pOXoepaXSEOsk/yk=;
        b=F+9dm+oJgC+7W9RNYbdzyYsUdnP6Vq40eHIAF77Es0xldFeP/TJxZ6KlBV4J9ZpUNb
         C3dFYnk+3Lk84XgoRQfVJrE4fZxPyLF5oNxT8DKnaSpaQ0yLAkCAWKfDipZN5yGeiJ0H
         pnRgfkE0ppR2+OULbZhk8ZnS0K64E2m6eyqQHfiSDbWCwpBgm3UMvUTVHIZoaHnOesxL
         pqKUe/GlNyraXmmmFEY2agUbpgJTXzXC8w/dfnCxQkyghPusHDoaRtZc6oU1JKSuz8Ps
         V/GSX8v9bCXLXD3xVo1llQ46Q4VW3qmJxeLi0DeIS0UrjEC54TGXTVLuUGEZeG9IDV3A
         Of1g==
X-Gm-Message-State: AOJu0Yw+ilo/vZmCVGemowoPil1cH408LWw08rsIhxQvp4NWkRbDrxRp
        1Do2S40N77VhIi1Qhopxe4hd8OOYokEtdP6URet9zg==
X-Google-Smtp-Source: AGHT+IGQuqX/VPx/KsIYHsiqXWsHllqMS9gkv4RcG0kqs5xw80WAtRklZow5+p7P/W71aIWwcCnXC7ibfgqfTnGCNNw=
X-Received: by 2002:a05:6102:534:b0:452:b96c:313b with SMTP id
 m20-20020a056102053400b00452b96c313bmr17791514vsa.13.1696988626704; Tue, 10
 Oct 2023 18:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130116.329529591@linuxfoundation.org>
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Oct 2023 07:13:35 +0530
Message-ID: <CA+G9fYu-h0kUGyQG4XTc6J7NZMvUeMSUuiY8KU0giNcPfzuU7A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 at 18:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.258-rc1.gz
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
* kernel: 5.4.258-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 9209af362e00e07217be717fc07b25118037adc6
* git describe: v5.4.257-132-g9209af362e00
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
57-132-g9209af362e00

## Test Regressions (compared to v5.4.257)

## Metric Regressions (compared to v5.4.257)

## Test Fixes (compared to v5.4.257)

## Metric Fixes (compared to v5.4.257)

## Test result summary
total: 88941, pass: 70613, fail: 2365, skip: 15914, xfail: 49

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 148 passed, 0 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 39 total, 39 passed, 0 failed

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
