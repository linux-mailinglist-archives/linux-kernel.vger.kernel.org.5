Return-Path: <linux-kernel+bounces-24612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AB82BF21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6431F23BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B99E67E82;
	Fri, 12 Jan 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UeTp5QiX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7C67E7E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d51bf8a7dcso13649595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705058277; x=1705663077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w/9bskBXsRWHhui8ZaSBSUqNBD3kcRzwMs9bhf0U2U=;
        b=UeTp5QiX8bOfJdIpByqoSErlghEBY6+Wxg/bLyXD2QN405Q2AV2Xj3pcKuBEBlvnfr
         Wxn7w58EtlPELjuGgiDq7d1+/DCoiOW6qVQMguK/xMSsp+X0T0uyok8+rjUJTito53wp
         mHo2NA7XuA6Fr8PgeNB4WtGzJkHg5Rlkivcf69urN+G3VnTFqjWSS3XNEWz8ucZApjH0
         VrCRZHEKi4XLsm0kvHvXsL0GuP/P+7iQNWoBo4s5MD/IKKkfQikeGRwmg6IIDlyny8bs
         DCGSjLpQbhQn+24dpvYFXO91KDn52kiDWkGT8+KkcaotBNczdu2XYXKlaqtJJ5Z9y+ub
         u1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705058277; x=1705663077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w/9bskBXsRWHhui8ZaSBSUqNBD3kcRzwMs9bhf0U2U=;
        b=QvhwUgXocAJe5/P+yhKp1jC9RMTQy8c5EMm3U82OfGPD33gpuubyTt5tE+WSiluybH
         sBPAiflH+GXdFJNWleb9vLd9PEV//YGYfzgvTg70BhQbU09FGOZ13II1Nk0jBeYTW4km
         OI/S82sgBbKLKAhYvJ6d2UEk7o95sBmN3b8BlQwOvPZdUP4Y3oRicCcyZ3GtZyz9mNCM
         lWP4u187mgncSZ+CG2LbFPnwBs78aDTDIxvQjMeKZ0tW6XFeqag+Z9L5Azkr106VM2Tt
         r3qEaRwG6UGXs/W9MeMWIEYwM9L+Yuq1fmoz0ujn1SrNfDaRBlJhwhc/U6ysFFJrdnBP
         TuLA==
X-Gm-Message-State: AOJu0YxjiuMRaINLENOrroSgNYhRk5rpsiAbywGL4r1p0k23w8Vt04Qo
	5ct862/KnE1go/XHGtfP30HWbHeauzVdFg==
X-Google-Smtp-Source: AGHT+IE7/kN9i+GiQIVlZVdE2Vic4gF/Ie1ElYGWcAfLnQxdjsUZVPiwKOEkVwRXM2sM2j4JicpVGQ==
X-Received: by 2002:a17:90b:4c43:b0:28d:e5e7:fe43 with SMTP id np3-20020a17090b4c4300b0028de5e7fe43mr1344177pjb.1.1705058277475;
        Fri, 12 Jan 2024 03:17:57 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:a276:8a4e:2aa1:5f09])
        by smtp.gmail.com with ESMTPSA id sd12-20020a17090b514c00b0028cef021d45sm3794179pjb.17.2024.01.12.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:17:57 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <apatel@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 3/3] perf: RISC-V: add support for SSE event
Date: Fri, 12 Jan 2024 12:17:15 +0100
Message-ID: <20240112111720.2975069-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112111720.2975069-1-cleger@rivosinc.com>
References: <20240112111720.2975069-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to use SSE within PMU drivers, register a SSE handler for the
local PMU event. Reuse the existing overlflow IRQ handler and pass
appropriate pt_regs.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..c82d7fe004c8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
+#include <linux/riscv_sse.h>
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
 
@@ -668,10 +669,10 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 	}
 }
 
-static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
+static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
+				       struct pt_regs *regs, bool from_sse)
 {
 	struct perf_sample_data data;
-	struct pt_regs *regs;
 	struct hw_perf_event *hw_evt;
 	union sbi_pmu_ctr_info *info;
 	int lidx, hidx, fidx;
@@ -679,7 +680,6 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	struct perf_event *event;
 	unsigned long overflow;
 	unsigned long overflowed_ctrs = 0;
-	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
 
 	if (WARN_ON_ONCE(!cpu_hw_evt))
@@ -688,13 +688,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	/* Firmware counter don't support overflow yet */
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	if (fidx == RISCV_MAX_COUNTERS) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		if (!from_sse)
+			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 		return IRQ_NONE;
 	}
 
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		if (!from_sse)
+			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 		return IRQ_NONE;
 	}
 
@@ -706,16 +708,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
-	 * all the counters to avoid any race condition.
+	 * all the counters to avoid any race condition. When using SSE,
+	 * interrupt is cleared when stopping counters.
 	 */
-	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+	if (!from_sse)
+		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 
 	/* No overflow bit is set */
 	if (!overflow)
 		return IRQ_NONE;
 
-	regs = get_irq_regs();
-
 	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
 		struct perf_event *event = cpu_hw_evt->events[lidx];
 
@@ -761,6 +763,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
+{
+	return pmu_sbi_ovf_handler(dev, get_irq_regs(), false);
+}
+
+static int pmu_sbi_ovf_sse_handler(uint32_t evt, void *arg,
+				   struct pt_regs *regs)
+{
+	struct cpu_hw_events __percpu *hw_events = arg;
+	struct cpu_hw_events *hw_event = raw_cpu_ptr(hw_events);
+
+	pmu_sbi_ovf_handler(hw_event, regs, true);
+
+	return 0;
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -804,9 +822,17 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
 {
 	int ret;
+	struct sse_event *evt;
 	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
 	struct irq_domain *domain = NULL;
 
+	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_PMU, 0,
+				 pmu_sbi_ovf_sse_handler, hw_events);
+	if (!IS_ERR(evt)) {
+		sse_event_enable(evt);
+		return 0;
+	}
+
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
@@ -834,7 +860,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		return -ENODEV;
 	}
 
-	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_irq_handler, "riscv-pmu", hw_events);
 	if (ret) {
 		pr_err("registering percpu irq failed [%d]\n", ret);
 		return ret;
-- 
2.43.0


