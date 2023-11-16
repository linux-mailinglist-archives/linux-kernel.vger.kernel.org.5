Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7397EE68E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjKPSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:18:51 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449CC195
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:18:48 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45dad6ece90so395393137.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700158727; x=1700763527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YAci+1wqiwB/kontdKmzRRGgE3fU/1zqtfW4K+RiiE=;
        b=ESq1zj3jJff6EGWgZ2z+ZZmrHLPRtJJbYYX4/eZwdZBv5vyy/wyl/209/793d6mmIw
         EA642agZeDReeQ2Afc0NNuYPdnP/rfd1W2vA+q9XT63hskZYQSLdgCMN8RXs6UUy7A1k
         XFKNHlZ0AiL0JYSGQjO+sACn1sfJJ7kqCR6Sho+PTcyjdml0hYnaqEsaTtdse2I4tdLz
         5C5QSkZQ+DTmRjJnZD0Gy/gZM4Oet6k7+J4mB5mhcVGWM+R1Df+J0Bzj8DYRSA5wwMT1
         lrf0ZNyikYOGQS9NTvEeNSEHTXiYoX12LoCxR6PKda7qNsXszfV1mlGTHq6WS97XSxkU
         etvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158727; x=1700763527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YAci+1wqiwB/kontdKmzRRGgE3fU/1zqtfW4K+RiiE=;
        b=wbCyX5fgDXe4wfM/9LNYgUHXwYx4EU9vzGWtPHl46woEGTlmvFaeikE0CJcmTI38Mv
         P+c6fBXv2PiAP5bEG+U7KXxQgc5Ykx/KXzFWz8JnGDxVU0StxCM/MJLfyGjuQIsLrSUQ
         /ABAoBAGoKKfJCUff16HSaQ+T8hHviKBc9ci03Knsqy5uYoIPvhZ/xqOixJv7656kmxc
         +yJqkgakRTMsscML4MtaoCN4LbbAApSHBdOqHUOJTTx7AUmILPE/M+rPHR2gCeKqdfnm
         /Px4Wh8ZqioLcEPCnX7gfh3Vufta/+Fy9I8ztifWK+NRwiRpyqj3HIIQDeIHMFviClVh
         q48w==
X-Gm-Message-State: AOJu0Yxhguq6c3N0qHopx3Qq8qZzb2Q1yyNNYnMJF7xZk+7dguF3gY7S
        ABkSEz6tFz5u8v7rRN+PPHCBaHj11CHPaWneZJ/T8w==
X-Google-Smtp-Source: AGHT+IGQEZ5wLUtlYPdF70kdQrc120i9IsEXXMv5n2+gnrkPnGz0H2wC/EneYGbqiS19pHHY6y5+0MTWWdIm4KZoiY8=
X-Received: by 2002:a05:6102:4687:b0:44e:8626:71f2 with SMTP id
 dw7-20020a056102468700b0044e862671f2mr11397434vsb.13.1700158727243; Thu, 16
 Nov 2023 10:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20231115204644.490636297@linuxfoundation.org>
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 23:48:34 +0530
Message-ID: <CA+G9fYsuoZdsy_biRqB0a+3pwTLK7z_xL3sYrJMsckivmxKimA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 02:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.201 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.201-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.201-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 550b7e1fee20e8840f9c1028c89dd3fc9c959fff
* git describe: v5.10.200-192-g550b7e1fee20
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.200-192-g550b7e1fee20

## Test Regressions (compared to v5.10.200)

## Metric Regressions (compared to v5.10.200)

## Test Fixes (compared to v5.10.200)

## Metric Fixes (compared to v5.10.200)

## Test result summary
total: 82357, pass: 64836, fail: 2567, skip: 14910, xfail: 44

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 113 total, 110 passed, 3 failed
* arm64: 43 total, 40 passed, 3 failed
* i386: 34 total, 33 passed, 1 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
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

--
Linaro LKFT
https://lkft.linaro.org
