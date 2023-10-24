Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8537D4A01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJXI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjJXI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:27:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919AD7E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:27:06 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6ce31c4a653so2650343a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698136026; x=1698740826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6xFOWkzDc9VNNDhFj5k3kApmxSIikFRxzXsDT+7/Oc=;
        b=jOw6n9QTANPWLcKxYRxEp2GYk9mmuHmTeryajIeAhkqgC0pBsgicWpjN8O/XJSQTgs
         d484Ach+uxvdQoZ3WfZSWtcj6WLvNjP54d9xsZAHCP6+68qnOXjyGy4S2y4o4cVcATSY
         fH1Smx36f5MbGDnqVYsoQAHh/+2qUQGUi70UtQKvA+BWmBkDSNpBvDfgU30Kh3/WuuCG
         YMdLz4q0bbAR+ODrCfEQQ+dHFIwCaCvtUA/56UVAo0rJ7ZvAzLPJ9/du63oMqD+GKV2j
         De+pKptoaf/0/M7XXn/KjIMSRLlPjHsFQgNM4LsHTpbgHXds7RSByMo+3heG0fjD3cm4
         MZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136026; x=1698740826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6xFOWkzDc9VNNDhFj5k3kApmxSIikFRxzXsDT+7/Oc=;
        b=h30Yj3g/EtnLWwrt0clc6J+TLO4yw9pf7IJXpdS1oOWgt9YOhpCz+X5KikF63GerLX
         YpJl2SMl6bjxFfOhhYQ5tExuhr4Ks7lNzzbgCVdBsO3r7GSU8jnrUsOhMy0k5XDJKOu3
         IKX8irSozLbhuHQupBr38AJLA5Y3QuB9gqypunEUWHoVySL9kye4RQ2XRE30+S7i+XH9
         9dER2wjJwNclFmUqqhlT9lm0M5Exaent/Hdgi34VZdZBn9oHo1dJaux5Wbm6e/N6FgDO
         WTvKfT33Rqr4yvNbdALtyW/wGr1tOk8JIsadhosekcAN5hNfz61i5b1F3WP7WVs/5OAb
         zw2Q==
X-Gm-Message-State: AOJu0YxczH5Bh/6UqZZBl31JmJP5tiOPkUwg8CejRNZf04ndQCQuFgWf
        jGwK9Q2pH5RDhnf1IAempXmsUg==
X-Google-Smtp-Source: AGHT+IG/PZxz2wLDicsKHgvZOahUW87F+0RkArgSq4FocJWiU6Di3+djYJ8FiaqiO9l7L9TCeE8cCg==
X-Received: by 2002:a05:6830:1d6c:b0:6ce:25da:6e9a with SMTP id l12-20020a0568301d6c00b006ce25da6e9amr12570527oti.34.1698136025872;
        Tue, 24 Oct 2023 01:27:05 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id v25-20020a9d69d9000000b006c65f431799sm1790208oto.23.2023.10.24.01.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:27:05 -0700 (PDT)
Message-ID: <ea064789-9dd7-48e4-9415-2c6333229ec7@linaro.org>
Date:   Tue, 24 Oct 2023 02:27:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104833.832874523@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23/10/23 4:53 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.5.9-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: b83aad774cc81f19bac02dd06d3d3c907ea44893
* git describe: v6.5.7-432-gb83aad774cc8
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.7-432-gb83aad774cc8

## No test regressions (compared to v6.5.7-191-gbe4ec7370801)

## No metric regressions (compared to v6.5.7-191-gbe4ec7370801)

## No test fixes (compared to v6.5.7-191-gbe4ec7370801)

## No metric fixes (compared to v6.5.7-191-gbe4ec7370801)

## Test result summary
total: 142426, pass: 122802, fail: 2262, skip: 17248, xfail: 114

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 270 total, 270 passed, 0 failed
* arm64: 86 total, 86 passed, 0 failed
* i386: 64 total, 64 passed, 0 failed
* mips: 52 total, 52 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 67 total, 67 passed, 0 failed
* riscv: 43 total, 43 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 73 total, 73 passed, 0 failed

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
* kselftest-livepatch
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
* libhugetlbfs
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
