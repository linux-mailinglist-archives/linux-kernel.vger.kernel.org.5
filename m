Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5FE7C474B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjJKBa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344597AbjJKBa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:30:56 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A39B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:30:54 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49a885c5961so2140673e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696987853; x=1697592653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WCazXgjZG6/RbtNWBEaTlLjOlWoiY3DlSKlQpJqUVg=;
        b=O6heOzCF1tAD8WhKSFYhExhIFBFKbcFrc59q5dS/bTnKHlSok+DNBV21yI4J1hLRgu
         1iJCGIuko+VQAHW3rJGJWaf6ql+91OeN5J0vSHDYeOydldn3s2c0KBMnDdcQdlGYItfK
         Dmi3Z1kVAUr+xycmCQnEqzP+tJwHC8ZAvRKEgllhlN0T3Ug5PZJegeKXb2L384wFtH5i
         2hbzGDaDphpMWS8zpa3VoxM+bip3prVU2Gfmt4xDHSi98SLQAVcqkzkMIVmt2ZAcLQdX
         2b1lTHJNKX+o/4MLglMYwvCphplsOr57PbIqStG/Ag5dNksBp/SDjAYs3YGiZUHq4yM8
         uX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987853; x=1697592653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WCazXgjZG6/RbtNWBEaTlLjOlWoiY3DlSKlQpJqUVg=;
        b=wBqCkxLBUzZL3YeZVr5/xhHqWNKP+FeP+y7x1Ae5AR0IkV/sKiuoQoJ0Gl0N0AfIJi
         83dEPZ2BgxSVzU7cntBV64mxtQlmxrIbno+fDS+OzYVu1yvRdZfV7Z3djBEjmtOYA3ZW
         /0Qv5LhJ52aiPtTSy7XfHhxEqEu5y+yveX5XJRCVdXkui1FxUhqHBh/omjpDfO3mdx1x
         /rxwJKxiD2MjYeXWsRLdTZl1ZEmkD2ezCU+LIqqEU0XSwtqxfp5qilrKbgPOVmTZy3ip
         uHuVbOhWR7eTMSQp3+YznElzQd8GXODPVwVtDKcRlQJl3mWPlb1o1NxobP66a8rq8xHC
         oV9g==
X-Gm-Message-State: AOJu0YzLL33RmIXBwgzuIOEM5F7gpIJSbGaPm/E8BWcf4sii1OPADWGV
        oy7PqgQYZ1hBtcTdGUtQHS6gZgOG1BkXtT2ldiAasQ==
X-Google-Smtp-Source: AGHT+IH8MAtZKzz5d7zmiYzvXuyT1JqyT4ZqLCkvEdCZJQcXXb81/Jogy5TjCC0TNg7qu4hLdW1qzymIDi671Ka3t28=
X-Received: by 2002:a1f:e043:0:b0:49d:a52a:4421 with SMTP id
 x64-20020a1fe043000000b0049da52a4421mr17043739vkg.4.1696987852124; Tue, 10
 Oct 2023 18:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130111.518916887@linuxfoundation.org>
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Oct 2023 07:00:40 +0530
Message-ID: <CA+G9fYtm8JvOEOUXQj9=ukN4vyH_E3wwMOHsD0wsHQs-Y-e9DA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/91] 4.19.296-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 at 19:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.296 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.296-rc1.gz
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
* kernel: 4.19.296-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 1d560dafb2e3608cc252a10c4558f86edc39b34c
* git describe: v4.19.295-92-g1d560dafb2e3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.295-92-g1d560dafb2e3

## Test Regressions (compared to v4.19.295)

## Metric Regressions (compared to v4.19.295)

## Test Fixes (compared to v4.19.295)

## Metric Fixes (compared to v4.19.295)

## Test result summary
total: 52204, pass: 44074, fail: 1739, skip: 6358, xfail: 33

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 30 total, 26 passed, 4 failed

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
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
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
