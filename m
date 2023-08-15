Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800F77C753
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjHOGCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjHOGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:01:47 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BE109
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:01:46 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a7d402fc6fso3713810b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692079304; x=1692684104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CN1ukS812eWNs8l1sOwa3N0lI+V/+LeWQr70g7q+bw=;
        b=mq5cnCCUnfD2cXko7EdbvHEtY2ZuZklviBcevjKh8az5O6IX3pg2XtDhzeeO7397dS
         9iXbKYdeSCIfr0sA8TpPDV/FwnPQosY7yiTBX+iaPtv7yDeL8jmVLutxRz+RyjAf2eJZ
         BogpYZ2sSAyyWhWaJ10QR0YeTLTz19mu6G9i04bEbD16nXkj8XeobDjOF31qQFPx7dPV
         4/INl+PkYp7RtxapL9uMqPd+bvJcdcM35Yq09z3nkxk9mdsuwqswuHRiw1b4kO10uvGw
         r7A8bmXtMRZYqsPapswww9XlJjamLhxC4loNWzr2vai+hLEchfSkYRZ1h3Gs785EMyGz
         XmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079304; x=1692684104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CN1ukS812eWNs8l1sOwa3N0lI+V/+LeWQr70g7q+bw=;
        b=QZKos4KrsKahh5bGHLcIujL4Zq0n0WwCqdmEYWXoYAbgho1FABywCdtkLekNp96tpl
         Gr3RqUBesbUv6s6bgin83DsJeGQgnnTVjlbSV9zyNRcVD2sb3nRKZNIWhJuGnz5FlznG
         TR+EXGSy7O8KkPSsypyrbtUkmOvV8Yf8Y3F7FYqR+TMjeX5FjqMvEP/AXEhYq/61fEQh
         arr/KpnQdj1DTNrJLwCSbzuEqM8eRYGiLdBpEAnFFtcfU7C3mN2FrJTcBXHLSVWL1q7h
         oBYXWVlnfnTRk/9/oK7NK7j4UtfOSJIhbcWg14eJ1Cs5EXV0OB1cI8/CMeD4XDvZAiCz
         XNxw==
X-Gm-Message-State: AOJu0Yz3+6znr5FV9dVMaPwXYCIZhCnW0CoYzSgPUnlEDPpU41SPKIDG
        kWinLKwjSPFKAijXnRuZKH2ybA==
X-Google-Smtp-Source: AGHT+IEczQ+3GYMHBR/D7t3uMalG4cPl9xcjJoqPTi5R3rHONvMx6DbZ88ukT2iuVZVbbyVMj0iA0w==
X-Received: by 2002:a05:6808:23c6:b0:3a7:6059:7fd0 with SMTP id bq6-20020a05680823c600b003a760597fd0mr12957440oib.15.1692079304491;
        Mon, 14 Aug 2023 23:01:44 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id bl12-20020a056808308c00b003a791c0cc03sm5229710oib.1.2023.08.14.23.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 23:01:43 -0700 (PDT)
Message-ID: <ec105d85-c983-9090-a3a8-dc26d5c6c9fb@linaro.org>
Date:   Tue, 15 Aug 2023 00:01:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4.19 00/33] 4.19.292-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230813211703.915807095@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13/08/23 15:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.292 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.292-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.292-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 84b9d8b93009a14264e351f2ae6dd63d95dd6ceb
* git describe: v4.19.291-34-g84b9d8b93009
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.291-34-g84b9d8b93009

## No test regressions (compared to v4.19.291)

## No metric regressions (compared to v4.19.291)

## No test fixes (compared to v4.19.291)

## No metric fixes (compared to v4.19.291)

## Test result summary
total: 61007, pass: 50993, fail: 1472, skip: 8453, xfail: 89

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 102 passed, 9 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
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
* kunit
* kvm-unit-tests
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
* rcutorture
* v4l2-compliance


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org

