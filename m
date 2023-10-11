Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704537C472A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjJKBTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344494AbjJKBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:19:04 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F0393
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:19:02 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b5fe8ab5f9so554433241.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696987142; x=1697591942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qRQt0N2+eG5tTO7gMqIqRXn/l5QeFqF7gp8hxeFcmo=;
        b=fuCToiEl5Xf6tsKwnp93JYY9EFqH+leG8s+pNnM2EXFUU8W2VIJVWUmemFWvI6fk1h
         9ZWibxWUjALD+4RJ38bU6NM2qv4il8drXrUmzMpi9aL5/WgP3YIybA9WXoc8d1BkKnJ7
         Y3Y0+KQTu10qNyS8ioOCMls4cw/gabx3dCwcr120BiHhfjuTE7XZQlP1LzYSUrrlXVip
         6/2I64hXda45OIsxjyPXpCV+d1iwfka4DucO+BlCIMrwJxy3aFqQLDNZa99JzFE8yVgZ
         52qMjs2KG04GyfiEcwyMioatlXjNAOd1Wm+ARS3ntelXL0Gw9SB8ZGdZT6TGM876n/Jt
         3riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987142; x=1697591942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qRQt0N2+eG5tTO7gMqIqRXn/l5QeFqF7gp8hxeFcmo=;
        b=d5Dr5jesPJ6SlzDY9RYYUyG2le5kaO3JFsjo9YMFbRsmdQ4AGdrEmujqH/a/NRSKAu
         uiZdpfdnK2uvXc0A/BIeqtA713zzcEolNXYu9KDu0Fbjdy7ggXCEYXXpkGZ1r/SvBAcx
         uVEkpWFZzfYcpHZhfXUR3U4SpbVXgykTU0GdRzhh0ewMzSx5ZruD0GVkg2xW5Eu5klve
         7HS9XJH2G0rra3pSCsTlYV3LCmlycrhwdNDiQ0KCbPQiB2aU2vBxKpLX/0cW9emU4YDW
         pqw1fTiELTSXh5U+XZe2ktRjJLzxSmcwsK1rjFbWt6rI7zUTiqYHa4RzO2piZe1rUPE6
         y45g==
X-Gm-Message-State: AOJu0YzChB66MfDxh4tngAYeTO0k+J5rRbLRLNFJClIRm5cS4SR4yEDz
        qn6DePVjx57osKY8k7t2eszRDUq3m0e+FvDQOYhWwA==
X-Google-Smtp-Source: AGHT+IFN0U40s7eLJzdbWkjJD3n0biSCYIDzhpK0Q+K/vj9v6AoWcKMHt7JPnE+eK53Su37ix2frrsX0CnZidbBWcoI=
X-Received: by 2002:a67:fa17:0:b0:452:547d:845f with SMTP id
 i23-20020a67fa17000000b00452547d845fmr18734244vsq.15.1696987141749; Tue, 10
 Oct 2023 18:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130107.717692466@linuxfoundation.org>
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Oct 2023 06:48:50 +0530
Message-ID: <CA+G9fYv2n+7yb6rDU3oK_PexRLUmcUyUnU1ZtG-ip6UcULBYHA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/55] 4.14.327-rc1 review
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

On Mon, 9 Oct 2023 at 19:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.327 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.327-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.327-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: bb6db074be992e4cc085ef23dc81d00467ba2d29
* git describe: v4.14.326-56-gbb6db074be99
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.326-56-gbb6db074be99

## Test Regressions (compared to v4.14.326)

## Metric Regressions (compared to v4.14.326)

## Test Fixes (compared to v4.14.326)

## Metric Fixes (compared to v4.14.326)

## Test result summary
total: 52445, pass: 44239, fail: 1592, skip: 6580, xfail: 34

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 103 passed, 5 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
