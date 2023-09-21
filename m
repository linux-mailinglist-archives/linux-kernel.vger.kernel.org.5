Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5107A998D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjIUSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIUSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759CC7D71D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:35:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so905631b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317740; x=1695922540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/PqXWQfhVy+I8T2s3N1D7o33scIo2tfwpAYEoZrILA=;
        b=ushMqOOJo3Z7xT+OK7kXiRE55ryTyBOxMQd5jvlYvQ/0Udl3NYloBP/iAB7lgZg/ee
         OCRx/xlaypGvHhC+DKQAenfh219k3BBPBwj8nOEnXHKg0IAdgRe/TPdaRsmGIY75RcrZ
         CfGqugovBphxSDAgZZtlYEOeM9Bi8+x/IslBn01s5f6zYOSG0QCtsCoViJCr115GMkZV
         I4B0AZ69iVLwmLMWxMDL8n90YHTU5XCqCk81MTWmZnJ94sLidERe+vhBEpHZ+TeVkt2L
         5vKmEaclEI+upaZteXg70JZuF7co7sUnC1nE4/grNkoMKLR6Xfj4bdDu+X947fJrApLp
         GvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317740; x=1695922540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/PqXWQfhVy+I8T2s3N1D7o33scIo2tfwpAYEoZrILA=;
        b=DWQnXWhVa2VLol0HmJWqDo9TgKcsjnVNrl3jsPsE3WKD3RaB8Bf7roV78ruTUTMYOj
         XjtjCMrXRgarzNmaW71g8g7ef991CnSCrUUsidBPgkwliXKmV1YhAnBIpr48Dk+o3Get
         RiriSVO8dk58ekTk34fjPZ6nY8OFDpeJWRL/rTfEGxfOnwEf/29Ou2bdtrReSl71jym2
         HTlBdWjzEL6iSICC2ZvGob3DXcPGCWyXkOocjqPYXbEQgq2ijUplh5+IFBSK60Aq7pkE
         9RZOFOf9Wg074YKpwbHWnlOr+MBgYWr9pJkYPJFiCvOju14SkI+jQ4yHohWP2I559iZG
         +xlQ==
X-Gm-Message-State: AOJu0Yyebv0WQCFJYTtjC+zIs7DPluyv5qLZ3QPC+71pp05T8OtrkNrT
        tS6sSwNEWM7cpxsthe/Sa6vXW3OlzKDzKMQFkDGQQq6D2emeN4EnzRiJ0Q==
X-Google-Smtp-Source: AGHT+IFWlx6n2/Kk0g46UDZm3S6M/U7TGZzI2JNZdQpgITr3ukFkfiSX7//HF3bxEWslCcCtpPLluke/ZzL90KT7rwE=
X-Received: by 2002:a05:6102:101:b0:452:700c:7230 with SMTP id
 z1-20020a056102010100b00452700c7230mr5965430vsq.8.1695297652808; Thu, 21 Sep
 2023 05:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112846.440597133@linuxfoundation.org>
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 14:00:41 +0200
Message-ID: <CA+G9fYsZ-dwwaQRRPxUpCx+hhKuUNCp9C5K2EhgyH-kuZR+5GQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/273] 4.19.295-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 14:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.295 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.295-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following arm build regressions noticed on 4.19 kernel.

* arm, build
  - clang-17-imx_v6_v7_defconfig
  - gcc-12-imx_v6_v7_defconfig
  - gcc-8-imx_v6_v7_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Logs:
------
drivers/pci/controller/dwc/pci-imx6.c:645:10: error: 'const struct
dw_pcie_host_ops' has no member named 'host_deinit'; did you mean
'host_init'?
  645 |         .host_deinit = imx6_pcie_host_exit,
      |          ^~~~~~~~~~~
      |          host_init
drivers/pci/controller/dwc/pci-imx6.c:645:24: error:
'imx6_pcie_host_exit' undeclared here (not in a function); did you
mean 'imx6_pcie_host_init'?
  645 |         .host_deinit = imx6_pcie_host_exit,
      |                        ^~~~~~~~~~~~~~~~~~~
      |                        imx6_pcie_host_init

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.294-274-gb67b483f6a45/testrun/20075618/suite/build/test/gcc-12-imx_v6_v7_defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.294-274-gb67b483f6a45/testrun/20075618/suite/build/test/gcc-12-imx_v6_v7_defconfig/log

## Build
* kernel: 4.19.295-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: b67b483f6a4512bad5b589f3bf49503cfe941cf9
* git describe: v4.19.294-274-gb67b483f6a45
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.294-274-gb67b483f6a45

## Test Regressions (compared to v4.19.294-235-gf91592b50ab2)
* arm, build
  - clang-17-imx_v6_v7_defconfig
  - gcc-12-imx_v6_v7_defconfig
  - gcc-8-imx_v6_v7_defconfig

## Metric Regressions (compared to v4.19.294-235-gf91592b50ab2)

## Test Fixes (compared to v4.19.294-235-gf91592b50ab2)

## Metric Fixes (compared to v4.19.294-235-gf91592b50ab2)

## Test result summary
total: 52194, pass: 44599, fail: 1323, skip: 6238, xfail: 34

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 102 passed, 9 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
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
