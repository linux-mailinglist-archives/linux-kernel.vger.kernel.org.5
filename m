Return-Path: <linux-kernel+bounces-15776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADB823199
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13355B21B56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336531BDF0;
	Wed,  3 Jan 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UoWeLLZx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC341BDDF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce0656a7bdso1970550a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704300881; x=1704905681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=At4QHdwp3ZadpLBcNbgmNjMEMqeIcq9YtBwBsEfmi00=;
        b=UoWeLLZxCab0VKZC1YVQqfLDYgWaJ5oYSsNdgDQ3eZ2+fsyscXqgY0sp/NQnXzDCnQ
         nE9tJ4FMyIO3uNG8PJOMl5LBXiZRsxpbrCMC2Y6bMGAPn3FGnULsrSblHGNyAZMXRTq9
         KBnmcfyQvjaBW+D7wGCHSJn6+dl6knNXmZXf+A+CuVc4wEyarLXvmECiLhBp3DL8N4SO
         fWRjtyKUUg81bfi+jwKpTLSPZ6W8jxpwv84bbILwNl1L2ZwBFimAwkCt3rLEPVnBn+CV
         dv+xI7zuNDVJdpt3TFn+p33x2JaH75X63vXWhUWaikcA/R6KdKAS1gsbqKZv19IVKr+n
         AVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300881; x=1704905681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=At4QHdwp3ZadpLBcNbgmNjMEMqeIcq9YtBwBsEfmi00=;
        b=C8wa3Mtvj8jb2b5rcWyFPaZ0/xjWKr7v/sR0Pa6HvT6RKe1guNSsLIIxERhx7bfoeI
         D4GYiEWsnafGuY4Jv/m8j28oay/3zgjQq5jW+NEIcnhfQEZtYYkdMt56sOwaGPB2QbZ+
         Aotbo0ExwPvyOu026B1RtAwXeV5H3rrK/e+2KzsSUhrSPvUks2ixj66DKAdRH67au8fH
         a6Zncg+/10T5KBHwqdYDmsQml1PsVUeATntC3SKHrI/Yv0uoKpJSzJDwS93iMnyXfzzH
         V3y33BAM8Di0pq7Mi0LHBXexytft3kYaO6KKtGI+FAgT5XnSIuW3JxVD4903r5gw7KlZ
         YX6A==
X-Gm-Message-State: AOJu0YzxCJdjtSEKnGQilVpwgRobTIcruBrDwwgpy/Q0QWDbzgYj3AuV
	fNVZMs7AOlFaKPMeUQWYRlmQJL+k4xOnrQ==
X-Google-Smtp-Source: AGHT+IFphH96nvot+o6OJI+1Oefu5ZnyAS0PgflwFC1JcbKaoG4F36jfxfu5/7Zi+jYM28KFX7allg==
X-Received: by 2002:a05:6a20:1615:b0:198:ae17:6a86 with SMTP id l21-20020a056a20161500b00198ae176a86mr636668pzj.10.1704300881041;
        Wed, 03 Jan 2024 08:54:41 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a930700b0028b89520c7asm1954805pjo.9.2024.01.03.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:54:40 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] perf: RISC-V: Check standard event availability
Date: Wed,  3 Jan 2024 08:53:48 -0800
Message-ID: <20240103165438.633054-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V SBI PMU specification defines several standard hardware and
cache events. Currently, all of these events appear in the `perf list`
output, even if they are not actually implemented. Add logic to check
which events are supported by the hardware (i.e. can be mapped to some
counter), so only usable events are reported to userspace.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
Before this patch:
$ perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
  stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
  stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]

$ perf stat -ddd true

 Performance counter stats for 'true':

              4.36 msec task-clock                       #    0.744 CPUs utilized
                 1      context-switches                 #  229.325 /sec
                 0      cpu-migrations                   #    0.000 /sec
                38      page-faults                      #    8.714 K/sec
         4,375,694      cycles                           #    1.003 GHz                         (60.64%)
           728,945      instructions                     #    0.17  insn per cycle
            79,199      branches                         #   18.162 M/sec
            17,709      branch-misses                    #   22.36% of all branches
           181,734      L1-dcache-loads                  #   41.676 M/sec
             5,547      L1-dcache-load-misses            #    3.05% of all L1-dcache accesses
     <not counted>      LLC-loads                                                               (0.00%)
     <not counted>      LLC-load-misses                                                         (0.00%)
     <not counted>      L1-icache-loads                                                         (0.00%)
     <not counted>      L1-icache-load-misses                                                   (0.00%)
     <not counted>      dTLB-loads                                                              (0.00%)
     <not counted>      dTLB-load-misses                                                        (0.00%)
     <not counted>      iTLB-loads                                                              (0.00%)
     <not counted>      iTLB-load-misses                                                        (0.00%)
     <not counted>      L1-dcache-prefetches                                                    (0.00%)
     <not counted>      L1-dcache-prefetch-misses                                               (0.00%)

       0.005860375 seconds time elapsed

       0.000000000 seconds user
       0.010383000 seconds sys

After this patch:
$ perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]

$ perf stat -ddd true

 Performance counter stats for 'true':

              5.16 msec task-clock                       #    0.848 CPUs utilized
                 1      context-switches                 #  193.817 /sec
                 0      cpu-migrations                   #    0.000 /sec
                37      page-faults                      #    7.171 K/sec
         5,183,625      cycles                           #    1.005 GHz
           961,696      instructions                     #    0.19  insn per cycle
            85,853      branches                         #   16.640 M/sec
            20,462      branch-misses                    #   23.83% of all branches
           243,545      L1-dcache-loads                  #   47.203 M/sec
             5,974      L1-dcache-load-misses            #    2.45% of all L1-dcache accesses
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
   <not supported>      L1-icache-loads
   <not supported>      L1-icache-load-misses
   <not supported>      dTLB-loads
            19,619      dTLB-load-misses
   <not supported>      iTLB-loads
             6,831      iTLB-load-misses
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

       0.006085625 seconds time elapsed

       0.000000000 seconds user
       0.013022000 seconds sys


 drivers/perf/riscv_pmu_sbi.c | 37 ++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..b58a70ee8317 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -86,7 +86,7 @@ struct sbi_pmu_event_data {
 	};
 };
 
-static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
+static struct sbi_pmu_event_data pmu_hw_event_map[] = {
 	[PERF_COUNT_HW_CPU_CYCLES]		= {.hw_gen_event = {
 							SBI_PMU_HW_CPU_CYCLES,
 							SBI_PMU_EVENT_TYPE_HW, 0}},
@@ -120,7 +120,7 @@ static const struct sbi_pmu_event_data pmu_hw_event_map[] = {
 };
 
 #define C(x) PERF_COUNT_HW_CACHE_##x
-static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
+static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
 [PERF_COUNT_HW_CACHE_OP_MAX]
 [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	[C(L1D)] = {
@@ -265,6 +265,36 @@ static const struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_M
 	},
 };
 
+static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
+			0, cmask, 0, edata->event_idx, 0, 0);
+	if (!ret.error) {
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+			  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+	} else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
+		/* This event cannot be monitored by any counter */
+		edata->event_idx = -EINVAL;
+	}
+}
+
+static void pmu_sbi_update_events(void)
+{
+	/* Ensure events are not already mapped to a counter */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+		  0, cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+
+	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
+		pmu_sbi_check_event(&pmu_hw_event_map[i]);
+
+	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
+		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++)
+			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
+				pmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
+}
+
 static int pmu_sbi_ctr_get_width(int idx)
 {
 	return pmu_ctr_list[idx].width;
@@ -1046,6 +1076,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
 		goto out_free;
 
+	/* Check which standard events are available */
+	pmu_sbi_update_events();
+
 	ret = pmu_sbi_setup_irqs(pmu, pdev);
 	if (ret < 0) {
 		pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
-- 
2.42.0


