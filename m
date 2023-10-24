Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487C97D5B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjJXTir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJXTiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:38:46 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72188B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:38:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57ad95c555eso2964380eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698176324; x=1698781124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuTM2h0Za1xwO3OgU5JiMSRU9mqcRe/XE1zlT+0MqRA=;
        b=vjV2QJk/uDE+9hu5o4Vo1+cF54uuhrDsQosBuFLzGHd5w7O3cVepFaGxUez/lDdoB8
         UgDBbjfrtK6biRmTZ2cDb63rKaPOemmH4r2QZcQLjqdo6nvJs/4B5dZGraX2O6y9YO/o
         IBCTfsEdDxoZNxoWUIJ7Qoz1a6lSZ/DLnVqI7MrDjb4giPbm5vqbwV4hwhRJDtO9wnss
         D1P/cTDuBSeJmO/ghZzZ4ZEMRwlKSu807pNcMb0GTt8aCLyIIw4e7odgCeMRETaM+Tu1
         sUIuEXnMHPyQdjJqY4X2DIXRkdOjYKB8ud5d6GR2N26JE42iah23LNxn+K1A6rDsC5Ys
         KETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176324; x=1698781124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuTM2h0Za1xwO3OgU5JiMSRU9mqcRe/XE1zlT+0MqRA=;
        b=TnZvT0PO70GuhB9VqmJHlidHdDyF4y9iXd5MiPTJVGg1J1SSYEkwYkBqU4RfeKQBq4
         5me1sndcZlDvnVLKDCBrICm1KVbpkqr3j8Yn9swGqX7aXzuyarCSqDttPc6CumDfTRSy
         eaprjaSgBMXLFEDjdHsNjSXa1z88Mbuv2VLAaA2RiiqWp8R449tyw3X2WHLxznXyKKJs
         YuToxnDOCYWWq9gA+t7ZDN3rfzs87kvwQ8j9evGAHWDA1f+tyVIB1XbyJglNp5P2bMMx
         Z861N1388v/TUNdieqwdRwSpDOAuPTNBrlnjCXNfBejGrbTokLVXIWmoFj1Fyu/NFLk5
         /BrQ==
X-Gm-Message-State: AOJu0YyP75y0N0EAZfadidm+snuivgwrgndjbxUy9XYBYxsO2B76hoiX
        p9To0YY6mTee6eGO/NVVflFg6A==
X-Google-Smtp-Source: AGHT+IFuj7nrOGCJqa4WvnYMW9DaPkCEQgbz1KNABRFKijasEGNBEgavi5YFX5ZsY02Ib731vpKaCA==
X-Received: by 2002:a4a:bd05:0:b0:581:ff09:62e4 with SMTP id n5-20020a4abd05000000b00581ff0962e4mr12843476oop.2.1698176323647;
        Tue, 24 Oct 2023 12:38:43 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id d9-20020a0568301b6900b006ce2c31dd9bsm1993535ote.20.2023.10.24.12.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:38:43 -0700 (PDT)
Message-ID: <dcddf886-0687-49c2-b96b-0673cc0639fc@linaro.org>
Date:   Tue, 24 Oct 2023 13:38:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231024083326.219645073@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24/10/23 2:36 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.199-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: e31b6513c43d7f4efa2c5913dd7d4fbef162e736
* git describe: v5.10.198-200-ge31b6513c43d
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.198-200-ge31b6513c43d

## No test regressions (compared to v5.10.198)

## No metric regressions (compared to v5.10.198)

## No test fixes (compared to v5.10.198)

## No metric fixes (compared to v5.10.198)

## Test result summary
total: 89095, pass: 69854, fail: 2647, skip: 16533, xfail: 61

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 114 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 32 total, 32 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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
* kselftest-timers
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


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org

