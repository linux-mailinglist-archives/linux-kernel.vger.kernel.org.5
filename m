Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288527A95DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjIUQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85052CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:56:11 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41214998fc2so6972131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695315370; x=1695920170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9XA+JBraCda9eBva3Lypt3IJDPDw9JlxvkFOYuewBA=;
        b=AijvaEzWyK9A7sQWEagVef9rrhdffJshv+rqoHLiGudNpFxyzXx82FI+aLbtq/opVs
         kN+oXU6Qm97VqG5xyqeFWVLLpVx7rc7/WN5kI2KLUw+CN8DpM3TTYl4/eCLldS0HzNab
         FSunpZfw8BdU/LnUONR9J2F0EqFkDyjlaubgR3+FxAvy/RPZieUmxUrnxNnStVbwOp7c
         Xap1ht5mm9ujcU3qa+HTnYqoidwAyGyzar6g0KfrTodTNFx8l7P7FibQFQhNWaQNXdAH
         HI6T+NcZdtb4WjeXOy7xbNZUrKmiv//zJ8eve3HLQAjmxWkTYNJswiAGXYQC7+t/67Nw
         IUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315370; x=1695920170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9XA+JBraCda9eBva3Lypt3IJDPDw9JlxvkFOYuewBA=;
        b=CjQKX2lDU65+Dma63siodl8Xi9IKJOW4Xh0W1HtJ1rzBFp8WM2dN9XaFXprOR/Q/Ev
         A1rtZqCCBKGN7ystYhPdEX2F1HaEhfNXOwQzC5AOvv7y+eo3yJWYTdMhSlV6sHgcWX8q
         6BPHqaF9Jw1uj/yFXqCt2tPlJGR8n7WDU5QLkNAv7P4uQXZgMbWcuXxsKQOZDtZF37lO
         yTFmpqxDQ3/LDr9ygITv/TCLE3KzQgHGSRoRWsvT+NMjev6Ef4J7lLhNYRTCucF3jgMn
         yhUE6IU3+e99mKbyiWTEgsXqupfEzVmGV2juFZfIQRXKOJyFYUI3CkwgzsxQfYqUL2J0
         2siw==
X-Gm-Message-State: AOJu0YzSxzl3KgXq523p6dDLpsYbPeHHqvNucKvRf6f0//teIYN5Xy22
        Sh76ASxbe82a9tupKJ04Dbv+UE3TVUm1MOrJO/7xNzzH8GZFIujrO5F06w==
X-Google-Smtp-Source: AGHT+IFyUPOELrhW7Z+XSfDYSuhUZcYQy1NdI5INSJe1W1E+2AqewKf3Am8KYOt/k3/4unEl85dxvZZ1koniljIGRFg=
X-Received: by 2002:a1f:dd44:0:b0:495:3d9d:535c with SMTP id
 u65-20020a1fdd44000000b004953d9d535cmr5450821vkg.4.1695304533825; Thu, 21 Sep
 2023 06:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112830.377666128@linuxfoundation.org>
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 15:55:22 +0200
Message-ID: <CA+G9fYuLmUQ=f2J7vdgDM54urA7muB3NpjrnZ=PTzwkGh48zRA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
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
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 14:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.133-rc1.gz
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
* kernel: 5.15.133-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 634d2466eedd8795e5251256807f08190998f237
* git describe: v5.15.132-111-g634d2466eedd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.132-111-g634d2466eedd

## Test Regressions (compared to v5.15.132)

## Metric Regressions (compared to v5.15.132)

## Test Fixes (compared to v5.15.132)

## Metric Fixes (compared to v5.15.132)

## Test result summary
total: 94047, pass: 74238, fail: 2610, skip: 17099, xfail: 100

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 34 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
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
* kvm-unit-tests
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
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
