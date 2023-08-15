Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA46177C6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjHOFE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjHOFEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:04:35 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0410D8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:04:32 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56c87f89178so3523313eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692075869; x=1692680669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8w+wpq7D3cAQqYH9lDcZD2LZvn8vmqvatqs9ATlFzgk=;
        b=oXk2Yred3G2VZqbV0t+XvWXvGg2iO3kRxdXsRg9TYhnjvU7xB29C60cvjT2XIX3SIK
         SlhFMg+biRT32pdcvmLlZ6QPngEQSVZq7gxemtv+f2dy2g4zzryTAQrc6aTk9p6FyLKo
         sNxXwGyUN2BdNlkAbCZzyohiPewLEe5EooNKkW8ul5DA4ISVD7a/ZoQ08Hs9mEEUrSx2
         GuSoq7f5IRcLqs8Aao7+mvjQVK3V7btJfipSUyLQA5nWYsxwHUwIQalWUGp1pzBLneaL
         Hi4kCSkA/Ih6+rfTypVnO/K+VyyW0SobSlSJrVfSMPDhgKV04jiB+QXn7lr2jCFKNPp3
         CVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075869; x=1692680669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8w+wpq7D3cAQqYH9lDcZD2LZvn8vmqvatqs9ATlFzgk=;
        b=cqQX8t1P9dt7yyN+90idsuzY2ry9X/ScuILaBVncmWDbOJCnUMXqkKVQf9SWg7d6O0
         KwEKelZIhnyzOhqXJW2hpgD9uOn2wEKk7Vp4KL1m5Yn+y1/70EjeMBZkxyrqJMCjaMlB
         xpjqp02xlYzlKzzTe+4Zoj+9FJWBy5fA7rfu5V2PJjlkWK7ooDxG14jByOWMZipX3Vib
         tg/tROSEam+EtkHT/te7rV6eQEyNWmh9TRuwZIhcgM8l/EdUODXhwq5NVXdfjIKq0xnG
         KE7IG3R8Mi8QoGiwKiJl3lJ5NVU74FsiIS3Y+oYrFQAAmwwprtpEuRUIm8RfU3JvGjHb
         lO8Q==
X-Gm-Message-State: AOJu0YyLySxsx3FWsFxOTa2M4/bZJruuszKbSE0aR7pbNJRRiaHyfhQA
        nYSVGHHK4d/37vefelaao6OaeQ==
X-Google-Smtp-Source: AGHT+IHj4KRKRS84x6AohUXQ8nGmzjzEipNw2QbxKPhgNUxYev5jq3yMKHeX/JLelUuYC0tIAY6WUg==
X-Received: by 2002:a4a:6206:0:b0:56c:d9d4:e80d with SMTP id x6-20020a4a6206000000b0056cd9d4e80dmr8975451ooc.2.1692075869131;
        Mon, 14 Aug 2023 22:04:29 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id e20-20020a4a8f14000000b00569c240e398sm5430998ool.30.2023.08.14.22.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:04:28 -0700 (PDT)
Message-ID: <5a3f5686-b303-8c30-a637-787be94f6623@linaro.org>
Date:   Mon, 14 Aug 2023 23:04:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230813211710.787645394@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

This branch exhibits the same problem with regards to x86 and Clang as reported on 6.4 [1] and 6.1 [2].

We found a one-off warning on i386 (physical machine):

-----8<-----
   [ 1346.674005] NETDEV WATCHDOG: eth0 (igb): transmit queue 0 timed out
   [ 1346.680282] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:477 dev_watchdog+0x21c/0x230
   [ 1346.688549] Modules linked in: tun x86_pkg_temp_thermal
   [ 1346.693773] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.15.127-rc1 #1
   [ 1346.700211] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.2 05/23/2018
   [ 1346.707595] EIP: dev_watchdog+0x21c/0x230
   [ 1346.711609] Code: 0a 1b 2e 00 eb b2 c6 43 ac 00 eb 89 8b 7d e8 c6 05 ac c0 76 c9 01 89 f8 e8 d1 19 fb ff 56 50 57 68 64 4a 4d c9 e8 06 f1 26 00 <0f> 0b 83 c4 10 eb 90 8d b4 26 00 00 00 00 8d b6 00 00 00 00 3e 8d
   [ 1346.730352] EAX: 00000037 EBX: c1b482a8 ECX: f5bb2690 EDX: f5bacbac
   [ 1346.736611] ESI: 00000000 EDI: c1b48000 EBP: c118ff4c ESP: c118ff20
   [ 1346.742869] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210296
   [ 1346.749653] CR0: 80050033 CR2: b7f4122c CR3: 030fe000 CR4: 003506d0
   [ 1346.755910] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
   [ 1346.762167] DR6: fffe0ff0 DR7: 00000400
   [ 1346.766000] Call Trace:
   [ 1346.768442]  <SOFTIRQ>
   [ 1346.770801]  ? show_regs.cold+0x14/0x1a
   [ 1346.774640]  ? __warn+0x71/0x100
   [ 1346.777873]  ? dev_watchdog+0x21c/0x230
   [ 1346.781713]  ? report_bug+0x7e/0xa0
   [ 1346.785203]  ? exc_overflow+0x40/0x40
   [ 1346.788871]  ? handle_bug+0x2a/0x50
   [ 1346.792363]  ? exc_invalid_op+0x1b/0x60
   [ 1346.796200]  ? handle_exception+0x133/0x133
   [ 1346.800379]  ? sugov_start+0x4b/0x160
   [ 1346.804046]  ? mptcp_token_join_cookie_init_state+0xa8/0xe0
   [ 1346.809616]  ? exc_overflow+0x40/0x40
   [ 1346.813274]  ? dev_watchdog+0x21c/0x230
   [ 1346.817104]  ? mptcp_token_join_cookie_init_state+0xa8/0xe0
   [ 1346.822668]  ? exc_overflow+0x40/0x40
   [ 1346.826335]  ? dev_watchdog+0x21c/0x230
   [ 1346.830176]  ? pfifo_fast_reset+0x150/0x150
   [ 1346.834361]  call_timer_fn+0x28/0xe0
   [ 1346.837939]  __run_timers+0x1e8/0x260
   [ 1346.841596]  ? pfifo_fast_reset+0x150/0x150
   [ 1346.845773]  run_timer_softirq+0x19/0x30
   [ 1346.849692]  __do_softirq+0xfc/0x2e9
   [ 1346.853272]  ? __softirqentry_text_start+0x8/0x8
   [ 1346.857888]  call_on_stack+0x45/0x50
   [ 1346.861459]  </SOFTIRQ>
   [ 1346.863905]  ? __irq_exit_rcu+0x90/0xc0
   [ 1346.867745]  ? irq_exit_rcu+0xd/0x20
   [ 1346.871324]  ? sysvec_apic_timer_interrupt+0x27/0x40
   [ 1346.876288]  ? handle_exception+0x133/0x133
   [ 1346.880467]  ? cpuidle_enter+0x27/0x40
   [ 1346.884217]  ? cpuidle_enter_state+0xc5/0x3c0
   [ 1346.888577]  ? trace_array_put+0x8/0x50
   [ 1346.892417]  ? sysvec_call_function_single+0x40/0x40
   [ 1346.897382]  ? cpuidle_enter_state+0xc8/0x3c0
   [ 1346.901742]  ? show_energy_performance_preference+0xd8/0xf0
   [ 1346.907315]  ? trace_array_put+0x8/0x50
   [ 1346.911153]  ? sysvec_call_function_single+0x40/0x40
   [ 1346.916111]  ? cpuidle_enter_state+0xc8/0x3c0
   [ 1346.920471]  ? cpuidle_enter+0x27/0x40
   [ 1346.924221]  ? do_idle+0x1e9/0x290
   [ 1346.927621]  ? cpu_startup_entry+0x25/0x30
   [ 1346.931720]  ? start_secondary+0x105/0x140
   [ 1346.935818]  ? startup_32_smp+0x161/0x164
   [ 1346.939822] ---[ end trace 8a197f71c975528f ]---
----->8-----

This is possibly related to bug 216884 [3]. Full test log is available [4]. This did not happen again on handful of reruns of the same test.

Here's the rest of report:

## Build
* kernel: 5.15.127-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 952b0de2b49f760b2e3b49d93faae7a6beb96dee
* git describe: v5.15.126-90-g952b0de2b49f
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.126-90-g952b0de2b49f

## Test regressions (compared to v5.15.126)
* i386, log-parser-test
   - check-kernel-exception
   - check-kernel-warning

* x86, log-parser-boot
   - check-kernel-warning

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## No metric regressions (compared to v5.15.126)

## No test fixes (compared to v5.15.126)

## No metric fixes (compared to v5.15.126)

## Test result summary
total: 123935, pass: 100041, fail: 3496, skip: 20284, xfail: 114

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 45 passed, 0 failed
* i386: 35 total, 34 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
[2] https://lore.kernel.org/stable/239281dd-3cb8-23de-9ea1-27e9c224cfbd@linaro.org/
[3] https://bugzilla.kernel.org/show_bug.cgi?id=216884
[4] https://lkft.validation.linaro.org/scheduler/job/6664165#L2145

-- 
Linaro LKFT
https://lkft.linaro.org
