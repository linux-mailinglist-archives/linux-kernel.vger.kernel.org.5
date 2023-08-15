Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D777C772
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjHOGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjHOGG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:06:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18FE63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:05:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bd066b0fd4so3491967a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692079532; x=1692684332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXr33l0AXnBSelUy+vnrpJC4GIAAMMQpSggPziQyGz0=;
        b=Vr7cCUnGLKJ76CH0r29QZPe9EaOyHK8s+1hyTGkBxp78xjNaWowlbRsQ+uBrl/ZsSk
         X2v2rt8Ok3iIa9nEJSi0rCp8b3LsUieOzjv2xc9tK5kAmI8UWzGmMvaxR+1Tb29aF0Ls
         yuEnXUZmj0govGurmpRzyGa6IRz/kKj/vVk+RSm6bwSkDoFL9fesV8GOTTZKqLcc0bzR
         x9X2uIuZ7LqBx7OjXQ7nqDJzKUEajjd6eMl1vAmGpPrPspWN4xk1EUJ896jwcWt2rXKE
         5y8zUlfJpLRRNjQOpRu600E6ClgCSVp6B4loKQv8nwRnmy/jnFZbyAhl0UEMvQ9K2XJ1
         fcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079532; x=1692684332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXr33l0AXnBSelUy+vnrpJC4GIAAMMQpSggPziQyGz0=;
        b=aAAyMb6gjnRYJnWcXGRpMKErDDm9UFskfulkww2LHPrBZw2Hq143h7VSPskZ9Wr1Ms
         MY5yz0fgtFdlWAtcrs/17+1KfOahDhdQ6oLDA31+Olk8dpSo9PWhlpNRVhcFZo1gRQkd
         KRiyTnTCaJusEFIeR3+F4xwVSKWE59tleuPwztk0yr3lbtrf+0JUFmLePf6KJX1+GQwI
         OIJBhpMMcv0iNTLuYBqe34wVzXNhTfoboLWiiuKE61sJwJ3neweKsSspcUsaRLM3+/Ap
         2WiFosjlGKTlAQVaARrmPgmi88sQwyhIL9Zwm0/lLOCtQ3rnWpkVirckgsmay6JV4yvr
         P/Pw==
X-Gm-Message-State: AOJu0YxDj2TTOSKCTr05pew7gmwwly2JKB1ShdloaEJYrw+HNGbx6HRm
        PKSu5VOHtpZagznAyCUSwAN1LA==
X-Google-Smtp-Source: AGHT+IFpLfygi/tifEWrCGgQRb3XX7QBlVuNeVJKkjSUzEM5u14TEABRf4MT1tFc/Ys5794JzubYSg==
X-Received: by 2002:a9d:7551:0:b0:6bb:101c:f723 with SMTP id b17-20020a9d7551000000b006bb101cf723mr8901447otl.31.1692079532249;
        Mon, 14 Aug 2023 23:05:32 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id i9-20020a9d6249000000b006b95f0db2besm5069010otk.41.2023.08.14.23.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 23:05:31 -0700 (PDT)
Message-ID: <83286ddd-a709-71bd-16b1-7f93af8cd818@linaro.org>
Date:   Tue, 15 Aug 2023 00:05:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4.14 00/26] 4.14.323-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230813211702.980427106@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 4.14.323 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.323-rc1.gz
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
* kernel: 4.14.323-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: c2d79804d11f0661ccff5d641b6549212f81c8f0
* git describe: v4.14.322-27-gc2d79804d11f
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.322-27-gc2d79804d11f

## No test regressions (compared to v4.14.322)

## No metric regressions (compared to v4.14.322)

## No test fixes (compared to v4.14.322)

## No metric fixes (compared to v4.14.322)

## Test result summary
total: 60155, pass: 50129, fail: 1434, skip: 8487, xfail: 105

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 100 passed, 8 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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

