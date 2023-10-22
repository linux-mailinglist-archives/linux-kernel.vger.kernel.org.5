Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ACA7D2363
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJVOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:42:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A558F3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:42:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so31996731fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697985748; x=1698590548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2jxN58Rd50B5qNlzzl+HgDNo1YZPDCqE37ZPo/QrR8=;
        b=vYg0RlsJswv5BqkSWzsqOq1nhymh4MDtu0g1Ki6SxVtXTUhx2O3/hjkudfi5EQSi6L
         dSIO+LUG/UWet8aIjyH9P3TkOtpZonrpWLB+XSUW9vkcFBdk5vUbHYZGtLFQzirSRmfF
         8LU4s/0D4bUtzK+SPyWxfVgCqYLYQ7rbV3ZQyPBW0/fB9TEkSYEqQLHxlvCEE64zWXqq
         gYW0d/U59AIticz4jxQDPphKpfIMKyzFfLtL3kM665mrPwmPZzNeeuzEfgXk0uuqluWH
         gnour5F2DafyGJb3zDoXGM7VGYu2PxjHWnNszwVXSCTBzvezaKVH/u5bKfF3zD6EpeV1
         AIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697985748; x=1698590548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2jxN58Rd50B5qNlzzl+HgDNo1YZPDCqE37ZPo/QrR8=;
        b=cOnZRZHrKlrqT1Tk+8ynnQ25+1mOMfF6SHPjlxvFByETOmpNkFwEQg+MTa4VpNr5dd
         fLJ4SJGr7HepNrPs5v7jqImhk7FweMus+W72plwy5jlivJKacPb11Frqu4+OKdWzA1oN
         X82r/e9AY8Z+X5CqiEoF/a31qpAP5vp7RIfzkUrn0rZnWoK6b+BVYr3kgBRUnxCcB6tT
         T/uw6IH9Cvy6UP0hpp0Ty4EqLDbC7KtZ1Ka619u6YyeVYtnN6A93figYVq5TecpfMKGk
         rUZ2JElEIDvdTdAMO6/PVMEEXPh+iOph396g4ZysebkOKmA0++J69Y3N65l4TsYKGjb5
         zxrQ==
X-Gm-Message-State: AOJu0YxZbo1+82fobm6I/YXuLGfmBoguyT9yOSU/dAsmFtRjYLmKQpvU
        TM23ihBAACov0xCT+Z7gFZmWG3MWj0yO753oC3g=
X-Google-Smtp-Source: AGHT+IF4DjTi8VI5kLF6HbYNHbRd4ens1x/g/+IRCor29hYZcgSeulBALYpy478UxCsdxjTinUPj5w==
X-Received: by 2002:a05:651c:1025:b0:2c0:1bf9:3c94 with SMTP id w5-20020a05651c102500b002c01bf93c94mr4262023ljm.50.1697985748380;
        Sun, 22 Oct 2023 07:42:28 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id iv15-20020a05600c548f00b00405c7591b09sm7115935wmb.35.2023.10.22.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 07:42:27 -0700 (PDT)
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
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH -fixes] drivers: perf: Do not broadcast to other cpus when starting a counter
Date:   Sun, 22 Oct 2023 16:42:20 +0200
Message-Id: <20231022144220.109469-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
 drivers/perf/riscv_pmu_sbi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 96c7f670c8f0..439da49dd0a9 100644
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
+		pmu_sbi_set_scounteren((void *)event);
 
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
-- 
2.39.2

