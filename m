Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406AA77BF97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHNSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjHNSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:12:56 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20F31BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:12:54 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a1fa977667so3619223fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692036773; x=1692641573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8y7m8mVXPBvCJUohO0isZKMbqlhr4Ta+xAXjRe1GD4k=;
        b=Wh2gNTiViCBPcsHehCRxnz7D8RH+7zJoFSJD5jWU4hEe7ejoAyai/y6w9iWjRjNwq1
         0+wVSOTGtM2g7jE5BBu0KU50QuVbmj7lIbLu+cy4Yv6tNZ79ISXQBGu1/P1X8mxMobLj
         ewn3ivb+cjfymslohz2Brhz9/FZ0lF8gMvjOx+PK/tGyGS94AnLufR6qGHpoTGEZPZKG
         tcB2bTP86vk5CUhlUpguMX/QUvoLOkbOButCyCK1z7o3xgRRvJtzq7Q/Bz8XMXN+W3ct
         UnE9I/vLEAQjk7roa9g1sru09leD+5WNxVfxbXi7MTiVrqKgAuh0LrryeL9gdoRjf54e
         tGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036773; x=1692641573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8y7m8mVXPBvCJUohO0isZKMbqlhr4Ta+xAXjRe1GD4k=;
        b=G8kFHi76Wddls+3KB1OXG9ihwPVSgjXOXc3fXcEaLMFVczeZ3DDy9g9KQikD6vPToh
         yi7EYkiF+NyHMtzSguM8K55LPZdoMJByJn8jH3iWeruIBZwu+W+stV8DEYFpwP01j0br
         giMSuop6o5UplbtbU80jteA9gooizjT547g7VpXbDJt5GyBrTgcbFJWWR1p57Ltyplqc
         isKuIucTgIK5WqeoqnJWsVF4xousoct95vPRvWeYOgHXeEs6X7v/RMQA+/LIpumMZTKt
         mm9TFHcj4CRu/etdIjZzGIwS2MbwAr+42Ast+DNnrKmP9fFT5LKZNC7PPkNHtYRCnrsq
         qBbA==
X-Gm-Message-State: AOJu0YyA7la+brduOKhZ6TP3LY6RlJjkoBJmtZcL2iRuYRL9zp/HavPO
        rkM+GqinqP2Iq2HTbZF9PJyZzw==
X-Google-Smtp-Source: AGHT+IEE3lvLDiYiLhU5iKzgoVQEt2R66USH/QzAbUEpFRMhW8/U8wI1VGJfr7Ca/08zzbqYkmddIg==
X-Received: by 2002:a05:6871:821:b0:1b0:293e:f8f3 with SMTP id q33-20020a056871082100b001b0293ef8f3mr12692158oap.53.1692036773399;
        Mon, 14 Aug 2023 11:12:53 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id z4-20020a0568301da400b006b8c277be12sm4507898oti.8.2023.08.14.11.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 11:12:52 -0700 (PDT)
Message-ID: <b2145971-5417-e1b1-40b4-f971e247e1ea@linaro.org>
Date:   Mon, 14 Aug 2023 12:12:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        nathan@kernel.org, peterz@infradead.org
References: <20230813211724.969019629@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We see this warning on x86 (real machine and Qemu) with Clang:

-----8<-----
   [    1.364590] ------------[ cut here ]------------
   [    1.364685] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6 ff ff ff
   [    1.364691] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:630 apply_returns+0x2c9/0x420
   [    1.366684] Modules linked in:
   [    1.367685] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.11-rc1 #1
   [    1.368684] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.0b 07/27/2017
   [    1.369685] RIP: 0010:apply_returns+0x2c9/0x420
   [    1.370685] Code: ff ff 0f 0b e9 b5 fd ff ff c6 05 a8 97 fa 01 01 48 c7 c7 e6 b5 9f a7 4c 89 ee 4c 89 e2 b9 05 00 00 00 4d 89 e8 e8 57 c2 11 00 <0f> 0b e9 8d fd ff ff 4d 85 e4 0f 84 1f ff ff ff 48 c7 c7 bf 44 98
   [    1.371684] RSP: 0000:ffffffffa7c03e00 EFLAGS: 00010246
   [    1.372684] RAX: 8bcba40230adee00 RBX: ffffffffa8150ba4 RCX: ffffffffa7c72440
   [    1.373684] RDX: ffffffffa7c03c88 RSI: 00000000ffffdfff RDI: 0000000000000001
   [    1.374684] RBP: ffffffffa7c03ed8 R08: 0000000000001fff R09: ffffffffa7c726d0
   [    1.375684] R10: 0000000000005ffd R11: 0000000000000004 R12: ffffffffa7182140
   [    1.376684] R13: ffffffffa7182145 R14: ffffffffa8150b9c R15: ffffffffa71821f0
   [    1.377684] FS:  0000000000000000(0000) GS:ffff8adb1fc00000(0000) knlGS:0000000000000000
   [    1.378684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [    1.379684] CR2: ffff8ad8b7001000 CR3: 00000001f6640001 CR4: 00000000003706f0
   [    1.380684] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   [    1.381684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   [    1.382684] Call Trace:
   [    1.383685]  <TASK>
   [    1.384685]  ? show_regs+0x61/0x70
   [    1.385685]  ? __warn+0xce/0x1d0
   [    1.386684]  ? apply_returns+0x2c9/0x420
   [    1.387685]  ? report_bug+0x160/0x210
   [    1.388685]  ? handle_bug+0x41/0x70
   [    1.389684]  ? exc_invalid_op+0x1f/0x50
   [    1.390685]  ? asm_exc_invalid_op+0x1f/0x30
   [    1.391684]  ? srso_safe_ret+0x30/0x30
   [    1.392685]  ? __ret+0x5/0x7e
   [    1.393684]  ? zen_untrain_ret+0x1/0x1
   [    1.394685]  ? apply_returns+0x2c9/0x420
   [    1.395685]  ? __ret+0x5/0x7e
   [    1.396684]  ? __ret+0x14/0x7e
   [    1.397684]  ? __ret+0xa/0x7e
   [    1.398685]  alternative_instructions+0x50/0x120
   [    1.399685]  arch_cpu_finalize_init+0x30/0x60
   [    1.400684]  start_kernel+0x30e/0x3e0
   [    1.401685]  x86_64_start_reservations+0x28/0x30
   [    1.402684]  x86_64_start_kernel+0xaf/0xc0
   [    1.403685]  secondary_startup_64_no_verify+0x107/0x10b
   [    1.404685]  </TASK>
   [    1.405685] ---[ end trace 0000000000000000 ]---
-----8>-----

Full log here of one of those instances:
   https://lkft.validation.linaro.org/scheduler/job/6664660#L671

There is a ClangBuiltLinux issue addressing this [1]. Nathan refers Peter's second patch [2] in his series fixes this problem.

This was introduced in v6.4.9 (which we did not review). Clang builds failed for v6.4.10 [3][4] and are now fixed, so this is the first time we're seeing this warning.

Rest of the report as follows:

## Build
* kernel: 6.4.11-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.4.y
* git commit: 427a3a47257b870ef6dce995a40bb7aca1bfc6ec
* git describe: v6.4.10-207-g427a3a47257b
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4.10-207-g427a3a47257b

## Test Regressions (compared to v6.4.10)
* x86, log-parser-boot
   - check-kernel-warning

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## No metric regressions (compared to v6.4.10)

## Test Fixes (compared to v6.4.10)
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

## No metric fixes (compared to v6.4.10)

## Test result summary
total: 172870, pass: 149103, fail: 3038, skip: 20556, xfail: 173

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 54 total, 52 passed, 2 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 24 passed, 2 failed
* s390: 16 total, 14 passed, 2 failed
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

[1] https://github.com/ClangBuiltLinux/linux/issues/1911
[2] https://lore.kernel.org/20230809072200.543939260@infradead.org/
[3] https://lore.kernel.org/stable/CA+G9fYuoajK0n7RNhSqm-ycO6Md3W4ah_Sc=b_KVAQwY=Rt6YQ@mail.gmail.com/
[4] https://github.com/ClangBuiltLinux/linux/issues/1907

-- 
Linaro LKFT
https://lkft.linaro.org
