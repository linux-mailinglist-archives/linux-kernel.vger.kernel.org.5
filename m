Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8837D7EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjJZIkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:40:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA7F128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:40:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507c8316abcso689815e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698309612; x=1698914412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4TscohSUMsguzpw2lOVFXhOAHSLy0dY/Ok/2lGq6Tg=;
        b=CL4fgF+QdOruCi2nYBNviChGZiG0m1ZDN6NLmk/g6YLXS+DZ7KYCflHs4JqqeZQql+
         kibkh2c9atX1sNBcjjW8sZIFIQ7bQBAKdGA+bgtF6XQe8isSeNYVpaAxjx5EyHfmq2hx
         V4Y8Wxm8kRbBWXENAFDQK1W42Ggz0QhN08dZcwrGT8R7/Gz0QrsMG2WhDlG95tvWZxiw
         NbI3h5efuQNumDo/Zo6R6KY4vA1J9+JahRVab5j6GxLVqS57vnjyBoFBcBdUP3SlMd9s
         RqQVCe16Jc7LrYjWhKFuwJrNHO53tzUuHnrxvwjsN6WYXx2J0QiwOnzSN+yfL+REoFl4
         U9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698309612; x=1698914412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4TscohSUMsguzpw2lOVFXhOAHSLy0dY/Ok/2lGq6Tg=;
        b=B0gan1k+JInK2F0moP+NLOHFbbD7SUSwgj+IvI2NlL93QPscWD28ffPL8eJ6hNP1bs
         FP3f8UyJIpCXf0zXqwvwmj4CF5dAFev5ottk0jVOmXIeZCrLI7MgjO/IC6W6/f89TD5J
         i1x8MH3ndB0Y+7/d4HJO98jYpF/TvZ6XrVCYpUtmB3WO55r7M5fsTvAqYEcwO5iuugs+
         I/WVOpcKLzQNibqOB5OhJeyvYtnucaJA5sVipT3ad12HNHkUwMeLUMWCqls2np1Xj7eW
         mPIzB+HtpbYrG1JAKk7b5CqoIc8p03iXwa57902x7zPkCffpuBdrIU70iCcypeRZx+W8
         W/Kw==
X-Gm-Message-State: AOJu0YzH+c0XjQu+PlmhfH1uYSiP5bYyrdqj6EV44Gsyeoj2ehjnQFwr
        KKcZlaQcZ5kOdz1+7F+j9uDiDsHdkipVvTnn2NM=
X-Google-Smtp-Source: AGHT+IGPzS4QwaJ48KsMa5vMztfn1B9sXTdqP4Ko1neTizBj0F3LXJeqyfJI6fwXGsGtb77TwMCBQg==
X-Received: by 2002:a05:6512:69:b0:503:3808:389a with SMTP id i9-20020a056512006900b005033808389amr12687011lfo.11.1698309612058;
        Thu, 26 Oct 2023 01:40:12 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b003fe1fe56202sm1927140wmq.33.2023.10.26.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:40:11 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH -fixes v2] drivers: perf: Do not broadcast to other cpus when starting a counter
Date:   Thu, 26 Oct 2023 10:40:10 +0200
Message-Id: <20231026084010.11888-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This command:

$ perf record -e cycles:k -e instructions:k -c 10000 -m 64M dd if=/dev/zero of=/dev/null count=1000

gives rise to this kernel warning:

[  444.364395] WARNING: CPU: 0 PID: 104 at kernel/smp.c:775 smp_call_function_many_cond+0x42c/0x436
[  444.364515] Modules linked in:
[  444.364657] CPU: 0 PID: 104 Comm: perf-exec Not tainted 6.6.0-rc6-00051-g391df82e8ec3-dirty #73
[  444.364771] Hardware name: riscv-virtio,qemu (DT)
[  444.364868] epc : smp_call_function_many_cond+0x42c/0x436
[  444.364917]  ra : on_each_cpu_cond_mask+0x20/0x32
[  444.364948] epc : ffffffff8009f9e0 ra : ffffffff8009fa5a sp : ff20000000003800
[  444.364966]  gp : ffffffff81500aa0 tp : ff60000002b83000 t0 : ff200000000038c0
[  444.364982]  t1 : ffffffff815021f0 t2 : 000000000000001f s0 : ff200000000038b0
[  444.364998]  s1 : ff60000002c54d98 a0 : ff60000002a73940 a1 : 0000000000000000
[  444.365013]  a2 : 0000000000000000 a3 : 0000000000000003 a4 : 0000000000000100
[  444.365029]  a5 : 0000000000010100 a6 : 0000000000f00000 a7 : 0000000000000000
[  444.365044]  s2 : 0000000000000000 s3 : ffffffffffffffff s4 : ff60000002c54d98
[  444.365060]  s5 : ffffffff81539610 s6 : ffffffff80c20c48 s7 : 0000000000000000
[  444.365075]  s8 : 0000000000000000 s9 : 0000000000000001 s10: 0000000000000001
[  444.365090]  s11: ffffffff80099394 t3 : 0000000000000003 t4 : 00000000eac0c6e6
[  444.365104]  t5 : 0000000400000000 t6 : ff60000002e010d0
[  444.365120] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[  444.365226] [<ffffffff8009f9e0>] smp_call_function_many_cond+0x42c/0x436
[  444.365295] [<ffffffff8009fa5a>] on_each_cpu_cond_mask+0x20/0x32
[  444.365311] [<ffffffff806e90dc>] pmu_sbi_ctr_start+0x7a/0xaa
[  444.365327] [<ffffffff806e880c>] riscv_pmu_start+0x48/0x66
[  444.365339] [<ffffffff8012111a>] perf_adjust_freq_unthr_context+0x196/0x1ac
[  444.365356] [<ffffffff801237aa>] perf_event_task_tick+0x78/0x8c
[  444.365368] [<ffffffff8003faf4>] scheduler_tick+0xe6/0x25e
[  444.365383] [<ffffffff8008a042>] update_process_times+0x80/0x96
[  444.365398] [<ffffffff800991ec>] tick_sched_handle+0x26/0x52
[  444.365410] [<ffffffff800993e4>] tick_sched_timer+0x50/0x98
[  444.365422] [<ffffffff8008a6aa>] __hrtimer_run_queues+0x126/0x18a
[  444.365433] [<ffffffff8008b350>] hrtimer_interrupt+0xce/0x1da
[  444.365444] [<ffffffff806cdc60>] riscv_timer_interrupt+0x30/0x3a
[  444.365457] [<ffffffff8006afa6>] handle_percpu_devid_irq+0x80/0x114
[  444.365470] [<ffffffff80065b82>] generic_handle_domain_irq+0x1c/0x2a
[  444.365483] [<ffffffff8045faec>] riscv_intc_irq+0x2e/0x46
[  444.365497] [<ffffffff808a9c62>] handle_riscv_irq+0x4a/0x74
[  444.365521] [<ffffffff808aa760>] do_irq+0x7c/0x7e
[  444.365796] ---[ end trace 0000000000000000 ]---

That's because the fix in commit 3fec323339a4 ("drivers: perf: Fix panic
in riscv SBI mmap support") was wrong since there is no need to broadcast
to other cpus when starting a counter, that's only needed in mmap when
the counters could have already been started on other cpus, so simply
remove this broadcast.

Fixes: 3fec323339a4 ("drivers: perf: Fix panic in riscv SBI mmap support")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Clément Léger <cleger@rivosinc.com>
Tested-by: Yu Chien Peter Lin <peterlin@andestech.com>
---

Changes in v2:
- Fix wrong usage of pmu_sbi_set_scounteren in pmu_sbi_ctr_stop, as
  noticed by Peter Lin
- Add TB from Peter Lin

 drivers/perf/riscv_pmu_sbi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 96c7f670c8f0..fcb0c70ca222 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -543,8 +543,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
-		on_each_cpu_mask(mm_cpumask(event->owner->mm),
-				 pmu_sbi_set_scounteren, (void *)event, 1);
+		pmu_sbi_set_scounteren((void *)event);
 }
 
 static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
@@ -554,8 +553,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
-		on_each_cpu_mask(mm_cpumask(event->owner->mm),
-				 pmu_sbi_reset_scounteren, (void *)event, 1);
+		pmu_sbi_reset_scounteren((void *)event);
 
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
-- 
2.39.2

