Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C278FDD4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbjIAM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346946AbjIAM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:56:05 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335C10D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:56:00 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7a02252eb5dso573152241.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693572959; x=1694177759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvH35cfo8hbq7kkNMUx0gNbEXq2JOSFfFOtm9Y71cKU=;
        b=rsTr5OA0VGQmGpe3CIUCnVHAFM9iMvUU8ZE/rkg8DeHL9SP98EvD2FuMzYviHXGCEm
         Hrt6m0xnrDy2x778PDt4CKR2D8TWCaetB1/y0GMiGo9k5BEwR8J9Ox9rWSFcl9WyJRXc
         E+rVumF5mIy1qt/dDgFum6CtGPAMySvSbSOuzADAmaTKpjhkOHLy3ckfQErg0Ki1M3sw
         OBEwApUpqWZsVGfjJz+jGWPrbCUidfzsa60RmezyQfCMMWC46SccOH2R1TtQ8jnN4Es6
         DeWEeJRPqVLugVLTRqF0DHqMvhhh56gNolwPxHHUv98Mq7CECbnOitVPwEAMu52gnwrb
         ZlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572959; x=1694177759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvH35cfo8hbq7kkNMUx0gNbEXq2JOSFfFOtm9Y71cKU=;
        b=JOJ2o0YQO+qJGrQx26SsOvr6YdA4iUEhADqVFphTpjOaEhhOx44/7RQ+TV1YfRuTxA
         hTb4+w8NlTGO6AoihXgzdMdT0mu0IvXu77f6hLXALiTMJxkPMbmdvv7g0OMqQhgzjC5X
         eytWvxGjMwsACONnYEl99lmcYKFzORANI/v+Ja1jp7T7IRHgyTqczljejB1PM7mk1fvW
         Xe3VrJyPgEKiaara15lGUcgXkVMFDecvg8UZ2+v6jo3m8NAQQJW7bRoUXaXPhMh99YK2
         o/SzzcAQjjmR4/mbMhltGBJ+dqJ971HUwr8gt3HJ1PFFgPFC+ekgJnOKSTx1gFgnmlt0
         8nLA==
X-Gm-Message-State: AOJu0YzVcGncNRUyUm+UHvwGhlz9GjS4TLIWUFHEFFeU5tXjMvmXsTdv
        djpT7tSCb4vQL32VjlBMeOkSd83uDikTzO5kyDnpJA==
X-Google-Smtp-Source: AGHT+IH6Cm2+42kWJhzcgE2fegmE9O6UDhVOlB3LtIZEaoHsDvBDJxBuyk88NAyOP2o56XB3/nKT50+OImD4rl6JMII=
X-Received: by 2002:a67:ce0c:0:b0:44d:476b:3bbf with SMTP id
 s12-20020a67ce0c000000b0044d476b3bbfmr2326282vsl.33.1693572959425; Fri, 01
 Sep 2023 05:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230831172214.759342877@linuxfoundation.org>
In-Reply-To: <20230831172214.759342877@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Sep 2023 18:25:48 +0530
Message-ID: <CA+G9fYuKxuDKrWfjNya+12TUHrCMXqWx0o0RkuaYW4-ybSm7wA@mail.gmail.com>
Subject: Re: [PATCH 4.19 0/2] 4.19.294-rc2 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 23:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 17:22:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.294-rc2.gz
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
* kernel: 4.19.294-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: cb2cdf2272086683c41f5bb61390600f01227b6e
* git describe: v4.19.293-3-gcb2cdf227208
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.293-3-gcb2cdf227208

## Test Regressions (compared to v4.19.293)

## Metric Regressions (compared to v4.19.293)

## Test Fixes (compared to v4.19.293)

## Metric Fixes (compared to v4.19.293)

## Test result summary
total: 48932, pass: 41532, fail: 1475, skip: 5891, xfail: 34

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 100 passed, 8 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 11 total, 11 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
