Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7567E77C73F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjHOFvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjHOFuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:50:15 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE7FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:50:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1ebb85f99so4779978b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692078612; x=1692683412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GM/F2aT/AdzelnPJypyLDc47uCimSRGNWre9XskWuk=;
        b=tak//h6TQW4EXa7ComatJzaq6jnz5TspDSesOlNjeXfwDE9U11ZT6NIkHVITASVdMe
         TOA71S4ZoyV7+ummjY4EgxaOGvGjznPvMFn9SdpDC/oybo8m3vduB0hN2MhtHh2QdPVm
         GFuRYHJ7Cw18+rrdV+2fPTVLPeLZ2SjD40CHp0s6k5YOo9syqEEGadKaZ2gJi8DHgGXo
         WR0MERcGQDyDBJW+4Abx/jqVDLemhgnb0J5ksdFm+16KrCfuQBZ0Lj4T2YOMZo6PhvOt
         CJgqp5pAWLMZXsZswoO9kVRGdHr6EIl/OLgsmzS9eFFCblvMAJXbxrtVZJf7iHuxU38z
         d2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692078612; x=1692683412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GM/F2aT/AdzelnPJypyLDc47uCimSRGNWre9XskWuk=;
        b=itZJSflyCHlW5TOQg86Hvyfj+gW8hYCu+XfGOkfNULI+JM8R4uftbWmjl5Evy33NqR
         n0AMEhsS10W0vWytZQnk5bhzFDVloxoobDOpLxiahvT8Reb1fm72xN/zXgeztsP9vZfI
         1H0p+Ke4OiDF1VfPqhTja0LC2i29PNTpsXtn36yRTCcr3tupop43qSabEA4XaX2+AQCo
         7/MHGwDWJuSCQAGu9Ky75WuPuG+1Vgvhne5mD74LjC21i6bJs3cR4v5wGg5WoviEdSlx
         Tg8yFMrMUVBb7osCy6fpDU457iBYKzAaijVxAIo61svk3p4XrUYsbPjO0s6XFxh3VM+x
         ADIg==
X-Gm-Message-State: AOJu0YxVCgDI4J+8pxXpCiXrfu4waTPP8hAfwMak5haRa1bMUQ9BjD5w
        QUnDajKGql7EENE6KHUdS5pmGA==
X-Google-Smtp-Source: AGHT+IG6qUVv1FZ/1VruAIQP+6owVSj+0GmlOMvJ5nhPRB6zh5wikkRuxxMAHRQ8Dr+i0G7pGxPD8w==
X-Received: by 2002:aca:d06:0:b0:3a7:30ad:df28 with SMTP id 6-20020aca0d06000000b003a730addf28mr10710880oin.37.1692078612239;
        Mon, 14 Aug 2023 22:50:12 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id q35-20020a056808202300b003a7916076desm5191962oiw.52.2023.08.14.22.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:50:11 -0700 (PDT)
Message-ID: <65e4b86c-2f99-7fc2-6b65-09eb0f41a705@linaro.org>
Date:   Mon, 14 Aug 2023 23:50:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5.4 00/39] 5.4.254-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230813211704.796906808@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13/08/23 15:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.254 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.254-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.254-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 89e2e795021f6c31714341452eb5e5ef0e0f420f
* git describe: v5.4.253-40-g89e2e795021f
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.253-40-g89e2e795021f

## No test regressions (compared to v5.4.253)

## No metric regressions (compared to v5.4.253)

## No test fixes (compared to v5.4.253)

## No metric fixes (compared to v5.4.253)

## Test result summary
total: 117800, pass: 94600, fail: 2545, skip: 20571, xfail: 84

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 147 passed, 1 failed
* arm64: 48 total, 46 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 33 total, 32 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
* perf
* rcutorture
* v4l2-compliance


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org

