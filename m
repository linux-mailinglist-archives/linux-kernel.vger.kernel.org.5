Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED37A7782
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjITJ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjITJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:29:30 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B6483
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:29:24 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-493545b4eaeso2379959e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695202163; x=1695806963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nbOx1BbglWhHdxW1iStH8Zi/cenHx3K/euDipqng7jI=;
        b=TG4dkOwYSD4WloQESL2XOABTbvusBMAv3onRU5dxsfDasYCKTAu2Hx366ZoWaj/28R
         qZtCQqaI591gkLZyvG4Ov+Z6UmHczE6T9Xtog5sLCMjbBebgHphik23XUi/BVyxwpHV7
         OZlMyFWbGM5i+gFUA6zI2diRwfCdG8TZpwNJ8ivHgGIjDphvednTsGH78wKWiWlq7Pl7
         35WfGkZ55QZ9pMH9AkkiZjgH0EL5NwfVf/iczFnLXeIfK0amA+vrKi+gbt74Yo6XoRQe
         MHXFvpx1nwXuNCneHO2BA1O1Wx3jKrN5LsZuZowkz2522q+kr7Nl+Gw0W9Fuy9eK3EKn
         xcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695202163; x=1695806963;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbOx1BbglWhHdxW1iStH8Zi/cenHx3K/euDipqng7jI=;
        b=XUyvlV0xSCT4ZhYvlv60Jl0vDiZIfESd50xyK58AXmoAzWwzdxp2NTSOOJxVORtyJh
         ttHWLhhEUFVVCSLty9ZvWQE1R1FxnDMovC/Csok6GfObQ1SokLEIgkEaiixW0CpNUlbi
         7lkQ+cl+E68c7Wxvm/6LHTxRLa88V6Lo/cswbDKENpKQ1jm0u2KejNmX1VwMreYKhFB+
         jYFZ1alQsfwP2SySNXlwzyXEVpELFk4HkXTpH0AkPH7CC/Nx2/a+FcqyfiuE/KOtxhEK
         m6fdGGrA/NvWsBqWvjN1LIx2PmzCHehgq3FocOJelJp+IL2y/wCC1ckgLO4TYJena9dy
         1eBQ==
X-Gm-Message-State: AOJu0YzhxMGkJB2hF1V+ibvK2VVm7zvxBQOL1dfsvkF570k3pJ74HCRN
        tzljtnr8cdlFtZmTn5VqPNEdToHsWDM8HBwQ8ghyNdZ8DWeJuMvXbR9vEykp
X-Google-Smtp-Source: AGHT+IETpPauNZDkFwFCiHSJaRaecVzeXGKMV6br8Vo5FTAmSiBPuy0XvZNiSJrFk0lydCTSZPJBqrNNvdnDSZfRH1c=
X-Received: by 2002:a1f:6643:0:b0:493:7df9:bcc4 with SMTP id
 a64-20020a1f6643000000b004937df9bcc4mr1757866vkc.4.1695202162964; Wed, 20 Sep
 2023 02:29:22 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Sep 2023 11:29:12 +0200
Message-ID: <CA+G9fYtqLarsezP_-6iQqonh8M4Q6McUCEBM9gFv+GU-zZRHAQ@mail.gmail.com>
Subject: arm64: Unable to handle kernel execute from non-executable memory at
 virtual address ffff8000834c13a0
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     chrubis <chrubis@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ my two cents ]
While running LTP pty07 test cases on arm64 juno-r2 with Linux next-20230919
the following kernel crash was noticed.

I have been noticing this issue intermittently on Juno-r2 for more than a month.
Anyone have noticed this crash ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    0.000000] Linux version 6.6.0-rc2-next-20230919 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.41) #1 SMP PREEMPT @1695107157
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: ARM Juno development board (r2)
...
LTP running pty
...

pty07.c:92: TINFO: Saving active console 1
../../../include/tst_fuzzy_sync.h:640: TINFO: Stopped sampling at 552
(out of 1024) samples, sampling time reached 50% of the total time
limit
../../../include/tst_fuzzy_sync.h:307: TINFO: loop = 552, delay_bias = 0
../../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg
=   127ns, avg_dev =    84ns, dev_ratio = 0.66 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg
= 17296156ns, avg_dev = 5155058ns, dev_ratio = 0.30 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg
= 101202336ns, avg_dev = 6689286ns, dev_ratio = 0.07 }
../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg
= -83906064ns, avg_dev = 10230694ns, dev_ratio = 0.12 }
../../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg
= 2765565  , avg_dev = 339285  , dev_ratio = 0.12 }
[  384.133538] Unable to handle kernel execute from non-executable
memory at virtual address ffff8000834c13a0
[  384.133559] Mem abort info:
[  384.133568]   ESR = 0x000000008600000f
[  384.133578]   EC = 0x21: IABT (current EL), IL = 32 bits
[  384.133590]   SET = 0, FnV = 0
[  384.133600]   EA = 0, S1PTW = 0
[  384.133610]   FSC = 0x0f: level 3 permission fault
[  384.133621] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082375000
[  384.133634] [ffff8000834c13a0] pgd=10000009fffff003,
p4d=10000009fffff003, pud=10000009ffffe003, pmd=10000009ffff8003,
pte=00780000836c1703
[  384.133697] Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
[  384.133707] Modules linked in: tda998x onboard_usb_hub cec hdlcd
crct10dif_ce drm_dma_helper drm_kms_helper fuse drm backlight dm_mod
ip_tables x_tables
[  384.133767] CPU: 3 PID: 589 Comm: (udev-worker) Not tainted
6.6.0-rc2-next-20230919 #1
[  384.133779] Hardware name: ARM Juno development board (r2) (DT)
[  384.133784] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  384.133796] pc : in_lookup_hashtable+0x178/0x2000
[  384.133818] lr : rcu_core (arch/arm64/include/asm/preempt.h:13
(discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1)
kernel/rcu/tree.c:2403 (discriminator 1))
[  384.133832] sp : ffff800083533e60
[  384.133836] x29: ffff800083533e60 x28: ffff0008008a6180 x27: 000000000000000a
[  384.133854] x26: 0000000000000000 x25: 0000000000000000 x24: ffff800083533f10
[  384.133871] x23: ffff800082404008 x22: ffff800082ebea80 x21: ffff800082f55940
[  384.133889] x20: ffff00097ed75440 x19: 0000000000000001 x18: 0000000000000000
[  384.133905] x17: ffff8008fc95c000 x16: ffff800083530000 x15: 00003d0900000000
[  384.133922] x14: 0000000000030d40 x13: 0000000000000000 x12: 003d090000000000
[  384.133939] x11: 0000000000000000 x10: 0000000000000008 x9 : ffff80008015b05c
[  384.133955] x8 : ffff800083533da8 x7 : 0000000000000000 x6 : 0000000000000100
[  384.133971] x5 : ffff800082ebf000 x4 : ffff800082ebf2e8 x3 : 0000000000000000
[  384.133987] x2 : ffff000825bf8618 x1 : ffff8000834c13a0 x0 : ffff00082b6d7170
[  384.134005] Call trace:
[  384.134009] in_lookup_hashtable+0x178/0x2000
[  384.134022] rcu_core_si (kernel/rcu/tree.c:2421)
[  384.134035] __do_softirq (arch/arm64/include/asm/jump_label.h:21
include/linux/jump_label.h:207 include/trace/events/irq.h:142
kernel/softirq.c:554)
[  384.134046] ____do_softirq (arch/arm64/kernel/irq.c:81)
[  384.134058] call_on_irq_stack (arch/arm64/kernel/entry.S:888)
[  384.134070] do_softirq_own_stack (arch/arm64/kernel/irq.c:86)
[  384.134082] irq_exit_rcu (arch/arm64/include/asm/percpu.h:44
kernel/softirq.c:612 kernel/softirq.c:634 kernel/softirq.c:644)
[  384.134094] el0_interrupt (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:763)
[  384.134110] __el0_irq_handler_common (arch/arm64/kernel/entry-common.c:769)
[  384.134124] el0t_64_irq_handler (arch/arm64/kernel/entry-common.c:774)
[  384.134137] el0t_64_irq (arch/arm64/kernel/entry.S:592)
[ 384.134153] Code: 00000000 00000000 00000000 00000000 (2b6d7170)
All code
========
...
  10: 70 71                jo     0x83
  12: 6d                    insl   (%dx),%es:(%rdi)
  13: 2b                    .byte 0x2b

Code starting with the faulting instruction
===========================================
   0: 70 71                jo     0x73
   2: 6d                    insl   (%dx),%es:(%rdi)
   3: 2b                    .byte 0x2b
[  384.134161] ---[ end trace 0000000000000000 ]---
[  384.134168] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  384.134173] SMP: stopping secondary CPUs
[  384.134184] Kernel Offset: disabled
[  384.134187] CPU features: 0x8000020c,3c020000,0000421b
[  384.134194] Memory Limit: none

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230919/testrun/20054202/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230919/testrun/20054202/suite/log-parser-test/test/check-kernel-oops/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2VbZdpWwncUx8oSxsSXCWV3N5DH/
 - https://lkft.validation.linaro.org/scheduler/job/6666807#L2461

--
Linaro LKFT
https://lkft.linaro.org
