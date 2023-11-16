Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE5D7EDF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbjKPLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbjKPLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:13:36 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE0E0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:13:32 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-45da9f949aaso251373137.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700133211; x=1700738011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPbTsNVbTJpvM9xFj6LjzFWal6KJ/8xDtc70facoOGk=;
        b=Sac8YYcONKSvEGqX7Tb4TUjy04m/uY/kubX/92PutXdVnuHpDvAjy2bXjipOsmbWWZ
         M5JrZrEjPCdMsDSB62y92k4vwMyrx8VkOKE8tmKGZRivzh5FaxTSC0Ixp1GXU54lWCw3
         gReZazt+UdAVZPfPe6R719LEj2fzMEWF4UA/E8QkGhHkrHqH92Lg+ji+SER1mHNYvPJD
         YOZ6RwLP+FLGfAhDKPJuzEv0skw+qfypLeKVZKKf3udjR7IAR4EwY+E3cbTkn/SrZgzS
         PpIrYh4E1IMHvnizTRiA7i8WrV27BDQdj1dicSTQVGZ3KTUmMtdQLXSg1usfiYrgZOAb
         pY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133211; x=1700738011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPbTsNVbTJpvM9xFj6LjzFWal6KJ/8xDtc70facoOGk=;
        b=CO8+sYbF+uMsDpG3DudQmjw3WA63mDVcaxrwcHQFQMWqUE7giNXGQSf4uOZYIdH7YX
         Q4PfmoUOUqrOIyYbU1vMLtRssDOM1zGXY0Ep/W8s141JqEEt67Uj7Qg1PkzIb9S/DPRH
         jzwzW6eaqiItA3a1Rnisk/uRCfj2DciVvhTQDm8qtwjWr3sYaQdRmgPGpvjAEUWTWUTl
         d3oTp573/knGRaBskk126k3WiA/xzHkQFsgTp7TAuQkUQyJomYZTrnppJP0yalTMHogU
         fKZtyY3UJCd8DB7+N8/uo5rOu/6eRgwEbag+p5i/sXCI9eMYewd7fNZa2o/oNOGZGU9s
         cYqA==
X-Gm-Message-State: AOJu0YwDI2CY4ZQ0lN9Hz+Qfh+v98mo4WP+QcYiTkhj5QXd1Yf0WT0U1
        /dV7CCPGjNU2YMtqi6G99jHSnazVTN894PmhPjmKHA==
X-Google-Smtp-Source: AGHT+IEA2x1WPWP9jfSdwsLXwYb+NbDsT7pP3FL/Ha+9jHQmjvVEub6KCNATZoBtK104xn94ETxAamo97B3WhzCTPco=
X-Received: by 2002:a67:e885:0:b0:45f:1790:5b55 with SMTP id
 x5-20020a67e885000000b0045f17905b55mr13106640vsn.28.1700133211627; Thu, 16
 Nov 2023 03:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20231115191426.221330369@linuxfoundation.org>
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 16:43:20 +0530
Message-ID: <CA+G9fYsq8SV8vpmcZexRWsPoBxYDKNfFBxJKPmev8cXvCJw+uw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/88] 4.19.299-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 02:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.299 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.299-rc1.gz
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
