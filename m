Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37247D4A61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjJXIgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjJXIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:36:35 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046910D0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:36:31 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5832ea25c7eso1602135eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698136591; x=1698741391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFK5k+WyCRpKrbHhGAax9JXCvlUkc9VlqKKWcgFoIFk=;
        b=fhxEMEVtQjb8hrnLg/78YHPje5uQQq3XefEd/TBq3ndzlsWmQ0aOhPqxMlONiSmWj/
         uaVNnnRtSztDiOEazTrXHL3XxsM6H9HOh+3wZLjkThVpQE0NS8U0NtARrhpJmXIpHfMZ
         kEHLnOBlFsctiKbXI5TNeXpT6s34kP68KmxB71Eirp86xzOkDbor/MZw02VQjtkzJFBn
         BfZsatrU2w1PpluRSA2ssxgBZtO7gzT2ZJMLZXLl28bdsEeEZmh6o91rh/m2u73qS1jr
         20htOQyI9bnFmUADB3PAgrWX2FKhpMQjRqSeUPrqfbvLT3D6hs7U8txqwcNWB3ftK1vQ
         v/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136591; x=1698741391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFK5k+WyCRpKrbHhGAax9JXCvlUkc9VlqKKWcgFoIFk=;
        b=oRMBafLCBZ8vJbQU5QukhaUUjxyq+1ZmxfysWCrlHWYru3iVVspEXiUcXp/e7AJmRL
         +VfBqSyOoRY9QIYQ3sCv2c8l8cpYq6i/PBNl1BdYjWb6w3rxM4G1rJZF+FJ+hokaHz4c
         r2jmuEBg5zkamwgfPF+M/1Ca6zR7His0uuWAkEgvaaB996aoRqTr5TysadmkJJP2Jhnh
         P/FFgSHV5C4Mc9CirYYXc+GEZo9sauDNkhsJVqBH5/jTJxPVrWuvoEyQdgpMo3qSg0k2
         ouTcNK5Hg4xIGEEpxrfz9evk4IiugZHZNltFdoD6VpQuO/XxRzS9Dk8izvF5hnFRz/22
         YjmA==
X-Gm-Message-State: AOJu0YwNV80xzglDpFlRxTUlTP8sdYQp3RpUSAdRH0WwSGSTqjf/lYy0
        q2W6Wq0jCijyR0I2U2Y7kekYUg==
X-Google-Smtp-Source: AGHT+IGSMJ0piiAiwfyvmnGbpCfN1/lJbhUActtZOTV0+s3MxR9fImA4LNHpZ4m5Zvp0GxJrO/sNQA==
X-Received: by 2002:a4a:ca0b:0:b0:581:f2d8:3f9f with SMTP id w11-20020a4aca0b000000b00581f2d83f9fmr10227466ooq.7.1698136590993;
        Tue, 24 Oct 2023 01:36:30 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id v18-20020a4aa512000000b00581f11e81c7sm1829225ook.7.2023.10.24.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:36:30 -0700 (PDT)
Message-ID: <ad8d0dd9-d9dc-43f6-a112-8177bfb55b90@linaro.org>
Date:   Tue, 24 Oct 2023 02:36:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/66] 4.14.328-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104810.781270702@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
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

On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.328 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.328-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.328-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 3ca3af8901320d3cbd71731933ed8a51bdbe55eb
* git describe: v4.14.327-67-g3ca3af890132
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.327-67-g3ca3af890132

## No test regressions (compared to v4.14.327)

## No metric regressions (compared to v4.14.327)

## No test fixes (compared to v4.14.327)

## No metric fixes (compared to v4.14.327)

## Test result summary
total: 55044, pass: 46798, fail: 1550, skip: 6658, xfail: 38

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 210 total, 200 passed, 10 failed
* arm64: 62 total, 54 passed, 8 failed
* i386: 36 total, 30 passed, 6 failed
* mips: 42 total, 42 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 16 total, 14 passed, 2 failed
* s390: 11 total, 9 passed, 2 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 47 total, 39 passed, 8 failed

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


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org

