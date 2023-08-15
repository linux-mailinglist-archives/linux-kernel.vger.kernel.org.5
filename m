Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1077C685
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjHODxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjHODvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:51:40 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C456BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:38:02 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56ca9a337caso3225735eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692070681; x=1692675481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJKlZzDbubR+pnxrcZu6u0BxLhnKqVDXEAomyLChOTA=;
        b=lYmDH91e556LS50pfu5GMg5/5aXxIRrcuPxKwVlKw1hBOHMQ779q1TQlrvDmCNg7tm
         A9zgt7uCANqLLHQGqwaJvWm+byIv6gln7fegB/GsftdlQVKgAVlynZrZjtWJZrI+USr3
         gTJwSruw7lRWOSbP1ggnTob0FZvsCZ4llwvalibiM7GusVC9cNs+czRcQeFkbhdAoI3H
         EbyXxgJ3EdKsF9aJ4B0aeRjRjbu/nGsQrACgXPXe0PkTiKjjX6IHB92RwbtPiCjuPZVP
         36HnBvY9T0JTAen7BLAAw+G4aLSa4oQHZcQYPcgs1fD4yDuAwapXlCqtb4GGbeb8W6PP
         pKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692070681; x=1692675481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJKlZzDbubR+pnxrcZu6u0BxLhnKqVDXEAomyLChOTA=;
        b=YT5CbiKzN35ietI0CHUfRYPLZmRwKpScjYOt8Drd/wTOYRlpxtbWYASmqwx6ki+zku
         mSypMKSnWwAAox5vw7PCuKAyg2IiEMmAgpinKGq8TpD7q8L9q+sGjl4q2ACJvLCAFEVI
         F5qaAh4iWN8GwExRPZOOupGFR0fnUINDyFgXJ7yg9YRI9ycS/VjFpxpKqs95Zq3zy4Xt
         lhzGxVbw3TI4HIFXN7MHAjAfWld3nXcBpFZr7cHrq10wWCn2vMLMpq3C1dKf6HBgpW+w
         dKfncnZoWVz3x76bJl8/s/HFa4pynKseSGoum/CdQ4FUkcPo7yNlVkd7wTXKa5oqKfPr
         bqbg==
X-Gm-Message-State: AOJu0YwWx6JHImePVVy01ftref8brELH0YdGrOKqqRIPafUj65GSxFo/
        dWFDRrWCkkm+LiCThWGTx5t4kg==
X-Google-Smtp-Source: AGHT+IFoREvs2BLTxyMY01U+gh0PcdzzC19OMAse0PbEGflDhkSfGEus5WdG0Q37lJSDmZCk8GQ4aQ==
X-Received: by 2002:a05:6870:c6a9:b0:1ba:dbad:e70 with SMTP id cv41-20020a056870c6a900b001badbad0e70mr13292483oab.21.1692070681200;
        Mon, 14 Aug 2023 20:38:01 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id zc13-20020a056871270d00b001c03d1a519fsm5897286oab.39.2023.08.14.20.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 20:38:00 -0700 (PDT)
Message-ID: <239281dd-3cb8-23de-9ea1-27e9c224cfbd@linaro.org>
Date:   Mon, 14 Aug 2023 21:37:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        broonie@kernel.org
References: <20230813211718.757428827@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13/08/23 15:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

This branch exhibits the same problem with regards to x86 and Clang as reported on 6.4 [1].

(An old warning is restored in tools/testing/selftests/rseq/, now that it builds again, but it was there in 6.1.44 too, so this is not a newly introduced warning. This is the warning:
-----8<-----
   clang --target=aarch64-linux-gnu -fintegrated-as -Werror=unknown-warning-option -Werror=ignored-optimization-argument -no-integrated-as --target=aarch64-linux-gnu -fintegrated-as -O2 -Wall -g -I./ -isystem /home/tuxbuild/.cache/tuxmake/builds/1/build/usr/include -L/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/rseq -Wl,-rpath=./ --target=aarch64-linux-gnu -fintegrated-as -Werror=unknown-warning-option -Werror=ignored-optimization-argument -no-integrated-as --target=aarch64-linux-gnu  -DBENCHMARK param_test.c -lpthread -ldl -lrseq -o /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/rseq/param_test_benchmark
   param_test.c:20:21: warning: unused function 'rseq_gettid' [-Wunused-function]
      20 | static inline pid_t rseq_gettid(void)
         |                     ^~~~~~~~~~~
   1 warning generated.
----->8-----

As expected, this reappeared due to Broonie's patch to fix rseq's build ("selftests/rseq: Fix build with undefined __weak").)

Rest of the report as follows:

## Build
* kernel: 6.1.46-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: dbb92b2240baeb83c338da3c22ea784f13375059
* git describe: v6.1.45-150-gdbb92b2240ba
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.45-150-gdbb92b2240ba

## Test regressions (compared to v6.1.45)
* x86, log-parser-boot
   - check-kernel-warning

## Metric regressions (compared to v6.1.45)
* arm64, build
   - clang-17-lkftconfig-gki-kselftest-warnings
   - clang-17-lkftconfig-gki-no-kselftest-frag-warnings
   - clang-17-lkftconfig-no-kselftest-frag-warnings
   - clang-nightly-lkftconfig-kselftest-warnings

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test fixes (compared to v6.1.45)
* x86_64, build
   - clang-17-allmodconfig
   - clang-17-lkftconfig
   - clang-17-lkftconfig-compat
   - clang-17-lkftconfig-kcsan
   - clang-17-lkftconfig-no-kselftest-frag
   - clang-17-x86_64_defconfig
   - clang-lkftconfig
   - clang-nightly-lkftconfig
   - clang-nightly-lkftconfig-kselftest
   - clang-nightly-x86_64_defconfig

## Test result summary
total: 167336, pass: 141554, fail: 4214, skip: 21375, xfail: 193

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 55 passed, 2 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 16 total, 15 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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


Greetings!

Daniel Díaz
daniel.diaz@linaro.org
  
[1] https://lore.kernel.org/stable/b2145971-5417-e1b1-40b4-f971e247e1ea@linaro.org/

-- 
Linaro LKFT
https://lkft.linaro.org

