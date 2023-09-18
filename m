Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9C7A54DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjIRVKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:10:11 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA810F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:10:05 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4963a2e3aa6so2802169e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695071405; x=1695676205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGyy1dLZvQWY2khpmZDJDrrkK5+L0RBN0UD0GvrVsSQ=;
        b=SxuBE4xYhM2o2TJl2mqTumelEAvrlIokLKaJl5miz/eZWliwSeeBhVBSjwnaXzEAaO
         7jKxm/EC0b/LH2H3WNvTgil7QDBoZjTFa6FwjLSDBGQI7w8uEIQFMvH0AqfgNWC0tCWv
         WuHs3tNGKmhXRcdsz6ITS0inAKlXnQpLAk44U+chtHxmYMbjpJyee6NKXT9PRETO7Mb2
         +JE4E7ACKRWJhFxlwo//9LRjrxjQEmsDkHwk7FqMRVl4NlQObL/lGCtB2AMa3UxXCZfV
         wSugIlbpDQ/qP7zIotEt+mFIgV3nbWTtf9l7Vs+EBhs9ZNKerg2YDudFas61Ne1m5F9Y
         2gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695071405; x=1695676205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGyy1dLZvQWY2khpmZDJDrrkK5+L0RBN0UD0GvrVsSQ=;
        b=LdxjNgOWQtCBErxjg+SGSnPX+IqcQmy3RKiXIRaIrL9LIGxplOWbrFOxCr7bkS/MM+
         QbgsjMWDzvU4fn7EnuHms4I8OG8EhXqxKrpVZ4saENWzz6yWX89fcl5VNixTABBOPbE6
         qmpf7Q0hCyxNPIzZUaRFsPA0WuNgGaAkUz9u6E+XQN4UGmDTypLAEzFNVV/Ad/ChatS+
         H6WAtCA095UE/zCG3VZXppB9RC75cPOszWVo9zDK3cfuBdsaAW8FgKRAj61GhennqWQY
         cgoHzAtRN1q4FUSdnl/rzL9CKk9y9Jtm0VfW6tjYk8HnacW+jUmWi+o1E1rnzmofVLIF
         s6Hg==
X-Gm-Message-State: AOJu0Yzo9ZAHv3FCO5F8unMwc5S+qltSXma3wkRltv3k4HgVATRwGZAz
        S30FGhuea3Qbv64HBd3PvEVTl5ImZdaZF3QIkJj1rQ==
X-Google-Smtp-Source: AGHT+IHWXN87NID162xsRwF1TcA1ezoFYpSyGoOq+JUSMd1jr2lgG69g4Lg2h0B8AggAIrPmikVYWjfv7XtvB2iu3m4=
X-Received: by 2002:a1f:ea02:0:b0:48e:1463:914e with SMTP id
 i2-20020a1fea02000000b0048e1463914emr457962vkh.7.1695071404718; Mon, 18 Sep
 2023 14:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191113.831992765@linuxfoundation.org>
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Sep 2023 02:39:53 +0530
Message-ID: <CA+G9fYtYniwcnL3yi30o-krrb0wO_4tb5uj5wyoxFaF=2abQXA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 01:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.132-rc1.gz
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
* kernel: 5.15.132-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: ead88697522a847255e61a898bf924d37d65ee3d
* git describe: v5.15.131-512-gead88697522a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.131-512-gead88697522a

## Test Regressions (compared to v5.15.131)

## Metric Regressions (compared to v5.15.131)

## Test Fixes (compared to v5.15.131)

## Metric Fixes (compared to v5.15.131)

## Test result summary
total: 88627, pass: 70361, fail: 2511, skip: 15669, xfail: 86

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 114 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 32 total, 32 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 7 total, 7 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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
