Return-Path: <linux-kernel+bounces-83372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0D8695E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B20128B09C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B751420DE;
	Tue, 27 Feb 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A0Lclbi6"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B013DB92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042743; cv=none; b=AKV03SLUZ9y1zCLmu7wQhC+OI28jOpxK2lD+E4vFUAePCzhWzzkiOa/J6f999n4nHPm78S7IWGhNQMynObdubbYLH7zZ0kTVdDLkDXOtQg5ewFJpfT0Lkm1h2F/RhXGeB0vMXOfejtFoUD6ANwbpniJNnYqryiQxV+vcT7INpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042743; c=relaxed/simple;
	bh=OHSclOO4U3709lHWNDb/EddMb+GPzDAUmacnR26g0DY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+aJ9FVg/OwByIsbl7wkEaaceD5dQEGmcGNkfr58Rkf5w9jcVb6rnhFCV7OJlzit14bfBCLiMdHE3r3hgRbzk9lQVrQ/VsS3qJ0BpgzIJU6xfWFztEIAK0f2Fh8EuaLuIR3SZeHgVnQDGroCnGD0Z1cOI2Isww2uzKbSdfeWfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A0Lclbi6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R7naYA028471;
	Tue, 27 Feb 2024 06:05:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=MCmudTZ5Pp0SoleXqdLK4+RDt1EZiSyX+odtxKv2Wew=; b=A0L
	clbi6PisXeR4B2sXl26XXGTNyFdNpCh/lOhXLD+iSKnCmSd4yBlo/HvCKeIkXONi
	3aX3iy+Lug3vyFVJiLyZFQj0GGc0TbeDh44APaKBnerHjYHyUrCzMo6b6Mv017TQ
	kf+W+CkLDG/kZFMYtCAOBgW0Clbv0EVxCFH1W8ET0rppt/kct/mkJyqZRljtxqSd
	s/g9/aGXzCYWfp1RSf+nsD3R4ZUFDELQMIsTieoizWyoCgsGgURnJj6TrWY3hIlZ
	SW2a9x0yDc2gRN8rOWiIj62cbxTOxoSm77uQoUBW5HXkHtWmupTXk/seeJPQyE8w
	yqEcw1EGz4c7trKYc7Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3whbpe0xm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:05:27 -0800 (PST)
Received: from DC6WP-EXCH01.marvell.com (10.76.176.21) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1258.12; Tue, 27 Feb 2024 06:05:26 -0800
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH01.marvell.com (10.76.176.21) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 27 Feb 2024 09:04:35 -0500
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 06:04:35 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 71F3A3F712E;
	Tue, 27 Feb 2024 06:04:32 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v4 1/3] perf/marvell: Refactor to extract platform data - no
Date: Tue, 27 Feb 2024 19:34:23 +0530
Message-ID: <20240227140425.3418814-2-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227140425.3418814-1-gthiagarajan@marvell.com>
References: <20240227140425.3418814-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CbUr52CzjMpfgGqceGvO2LaEpYMHJ8sG
X-Proofpoint-ORIG-GUID: CbUr52CzjMpfgGqceGvO2LaEpYMHJ8sG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02

This commit introduces a refactor to the Marvell driver
code, specifically targeting the extraction of platform data
(referred to as "pdata") from the existing driver. The purpose of
this refactor is to prepare for the upcoming support of the next
version of the Performance Monitoring Unit (PMU) in this
driver.

No functional changes are introduced in this refactor. Its sole
purpose is to improve code organization and pave the way for
future enhancements to the driver.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 282 ++++++++++++++++++++-------
 1 file changed, 210 insertions(+), 72 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 524ba82bfce2..d6485c4cf30f 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
+/*
+ * Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
  *
- * Copyright (C) 2021 Marvell.
+ * Copyright (C) 2024 Marvell.
  */
 
 #include <linux/init.h>
@@ -14,24 +15,24 @@
 #include <linux/platform_device.h>
 
 /* Performance Counters Operating Mode Control Registers */
-#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
-#define OP_MODE_CTRL_VAL_MANNUAL	0x1
+#define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
+#define OP_MODE_CTRL_VAL_MANUAL	0x1
 
 /* Performance Counters Start Operation Control Registers */
-#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
+#define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
 #define START_OP_CTRL_VAL_START		0x1ULL
 #define START_OP_CTRL_VAL_ACTIVE	0x2
 
 /* Performance Counters End Operation Control Registers */
-#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
+#define CN10K_DDRC_PERF_CNT_END_OP_CTRL	0x8030
 #define END_OP_CTRL_VAL_END		0x1ULL
 
 /* Performance Counters End Status Registers */
-#define DDRC_PERF_CNT_END_STATUS		0x8038
+#define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
 #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
 
 /* Performance Counters Configuration Registers */
-#define DDRC_PERF_CFG_BASE		0x8040
+#define CN10K_DDRC_PERF_CFG_BASE		0x8040
 
 /* 8 Generic event counter + 2 fixed event counters */
 #define DDRC_PERF_NUM_GEN_COUNTERS	8
@@ -42,17 +43,19 @@
 					 DDRC_PERF_NUM_FIX_COUNTERS)
 
 /* Generic event counter registers */
-#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
+#define DDRC_PERF_CFG(base, n)		((base) + 8 * (n))
 #define EVENT_ENABLE			BIT_ULL(63)
 
 /* Two dedicated event counters for DDR reads and writes */
 #define EVENT_DDR_READS			101
 #define EVENT_DDR_WRITES		100
 
+#define DDRC_PERF_REG(base, n)		((base) + 8 * (n))
 /*
  * programmable events IDs in programmable event counters.
  * DO NOT change these event-id numbers, they are used to
  * program event bitmap in h/w.
+ *
  */
 #define EVENT_OP_IS_ZQLATCH			55
 #define EVENT_OP_IS_ZQSTART			54
@@ -63,8 +66,8 @@
 #define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
 #define EVENT_BSM_STARVATION			48
 #define EVENT_BSM_ALLOC				47
-#define EVENT_LPR_REQ_WITH_NOCREDIT		46
-#define EVENT_HPR_REQ_WITH_NOCREDIT		45
+#define EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED	46
+#define EVENT_DFI_OR_HPR_REQ_NOCRED		45
 #define EVENT_OP_IS_ZQCS			44
 #define EVENT_OP_IS_ZQCL			43
 #define EVENT_OP_IS_LOAD_MODE			42
@@ -102,28 +105,38 @@
 #define EVENT_HIF_RD_OR_WR			1
 
 /* Event counter value registers */
-#define DDRC_PERF_CNT_VALUE_BASE		0x8080
-#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
+#define CN10K_DDRC_PERF_CNT_VALUE_BASE	0x8080
 
 /* Fixed event counter enable/disable register */
-#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
+#define CN10K_DDRC_PERF_CNT_FREERUN_EN		0x80C0
 #define DDRC_PERF_FREERUN_WRITE_EN	0x1
 #define DDRC_PERF_FREERUN_READ_EN	0x2
 
 /* Fixed event counter control register */
-#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
+#define CN10K_DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
 #define DDRC_FREERUN_WRITE_CNT_CLR	0x1
 #define DDRC_FREERUN_READ_CNT_CLR	0x2
 
-/* Fixed event counter value register */
-#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
-#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
 #define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
 #define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
 
+/* Fixed event counter value register */
+#define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
+#define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
+
+enum mrvl_ddr_pmu_version {
+	DDR_PMU_V1 = 1,
+};
+
+struct ddr_pmu_data {
+	int id;
+};
+
 struct cn10k_ddr_pmu {
 	struct pmu pmu;
 	void __iomem *base;
+	const struct ddr_pmu_platform_data *p_data;
+	int version;
 	unsigned int cpu;
 	struct	device *dev;
 	int active_events;
@@ -132,8 +145,35 @@ struct cn10k_ddr_pmu {
 	struct hlist_node node;
 };
 
+struct ddr_pmu_ops {
+	void (*enable_read_freerun_counter)(struct cn10k_ddr_pmu *pmu,
+					    bool enable);
+	void (*enable_write_freerun_counter)(struct cn10k_ddr_pmu *pmu,
+					     bool enable);
+	void (*clear_read_freerun_counter)(struct cn10k_ddr_pmu *pmu);
+	void (*clear_write_freerun_counter)(struct cn10k_ddr_pmu *pmu);
+	void (*pmu_overflow_handler)(struct cn10k_ddr_pmu *pmu, int evt_idx);
+};
+
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
 
+struct ddr_pmu_platform_data {
+	u64 counter_overflow_val;
+	u64 counter_max_val;
+	u64 ddrc_perf_cnt_base;
+	u64 ddrc_perf_cfg_base;
+	u64 ddrc_perf_cnt_op_mode_ctrl;
+	u64 ddrc_perf_cnt_start_op_ctrl;
+	u64 ddrc_perf_cnt_end_op_ctrl;
+	u64 ddrc_perf_cnt_end_status;
+	u64 ddrc_perf_cnt_freerun_en;
+	u64 ddrc_perf_cnt_freerun_ctrl;
+	u64 ddrc_perf_cnt_freerun_clr;
+	u64 ddrc_perf_cnt_value_wr_op;
+	u64 ddrc_perf_cnt_value_rd_op;
+	const struct ddr_pmu_ops *ops;
+};
+
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -189,9 +229,9 @@ static struct attribute *cn10k_ddr_perf_events_attrs[] = {
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpr_req_with_nocredit,
-					EVENT_HPR_REQ_WITH_NOCREDIT),
+				 EVENT_DFI_OR_HPR_REQ_NOCRED),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpr_req_with_nocredit,
-					EVENT_LPR_REQ_WITH_NOCREDIT),
+				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
@@ -266,7 +306,8 @@ static ktime_t cn10k_ddr_pmu_timer_period(void)
 	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
 }
 
-static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
+static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
+				     struct cn10k_ddr_pmu *ddr_pmu)
 {
 	switch (eventid) {
 	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
@@ -354,6 +395,8 @@ static int cn10k_ddr_perf_event_init(struct perf_event *event)
 static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 					  int counter, bool enable)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = p_data->ops;
 	u32 reg;
 	u64 val;
 
@@ -363,7 +406,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 	}
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
-		reg = DDRC_PERF_CFG(counter);
+		reg = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
 		val = readq_relaxed(pmu->base + reg);
 
 		if (enable)
@@ -373,19 +416,10 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
-		if (enable) {
-			if (counter == DDRC_PERF_READ_COUNTER_IDX)
-				val |= DDRC_PERF_FREERUN_READ_EN;
-			else
-				val |= DDRC_PERF_FREERUN_WRITE_EN;
-		} else {
-			if (counter == DDRC_PERF_READ_COUNTER_IDX)
-				val &= ~DDRC_PERF_FREERUN_READ_EN;
-			else
-				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
-		}
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		if (counter == DDRC_PERF_READ_COUNTER_IDX)
+			ops->enable_read_freerun_counter(pmu, enable);
+		else
+			ops->enable_write_freerun_counter(pmu, enable);
 	}
 }
 
@@ -393,13 +427,18 @@ static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
 {
 	u64 val;
 
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+
 	if (counter == DDRC_PERF_READ_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->ddrc_perf_cnt_value_rd_op);
 
 	if (counter == DDRC_PERF_WRITE_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_WR_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->ddrc_perf_cnt_value_wr_op);
 
-	val = readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
+	val = readq_relaxed(pmu->base +
+			    DDRC_PERF_REG(p_data->ddrc_perf_cnt_base, counter));
 	return val;
 }
 
@@ -407,6 +446,7 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	u64 prev_count, new_count, mask;
 
 	do {
@@ -414,7 +454,7 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
 
-	mask = DDRC_PERF_CNT_MAX_VALUE;
+	mask = p_data->counter_max_val;
 
 	local64_add((new_count - prev_count) & mask, &event->count);
 }
@@ -435,6 +475,8 @@ static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = p_data->ops;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
 	int counter, ret;
@@ -454,8 +496,8 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
-		reg_offset = DDRC_PERF_CFG(counter);
-		ret = ddr_perf_get_event_bitmap(config, &val);
+		reg_offset = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
+		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
 		if (ret)
 			return ret;
 
@@ -463,11 +505,9 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	} else {
 		/* fixed event counter, clear counter value */
 		if (counter == DDRC_PERF_READ_COUNTER_IDX)
-			val = DDRC_FREERUN_READ_CNT_CLR;
+			ops->clear_read_freerun_counter(pmu);
 		else
-			val = DDRC_FREERUN_WRITE_CNT_CLR;
-
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
+			ops->clear_write_freerun_counter(pmu);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -512,17 +552,19 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
-		       DDRC_PERF_CNT_START_OP_CTRL);
+		       p_data->ddrc_perf_cnt_start_op_ctrl);
 }
 
 static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
-		       DDRC_PERF_CNT_END_OP_CTRL);
+		       p_data->ddrc_perf_cnt_end_op_ctrl);
 }
 
 static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
@@ -547,8 +589,63 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 	}
 }
 
+static void ddr_pmu_enable_read_freerun(struct cn10k_ddr_pmu *pmu, bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_en);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_READ_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_READ_EN;
+
+	writeq_relaxed(val, pmu->base +	p_data->ddrc_perf_cnt_freerun_en);
+}
+
+static void ddr_pmu_enable_write_freerun(struct cn10k_ddr_pmu *pmu, bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_en);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_WRITE_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_WRITE_EN;
+
+	writeq_relaxed(val, pmu->base +	p_data->ddrc_perf_cnt_freerun_en);
+}
+
+static void ddr_pmu_read_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_READ_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_write_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_WRITE_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
+{
+	cn10k_ddr_perf_event_update_all(pmu);
+	cn10k_ddr_perf_pmu_disable(&pmu->pmu);
+	cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+}
+
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	const struct ddr_pmu_ops *ops = p_data->ops;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -586,11 +683,9 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 			continue;
 
 		value = cn10k_ddr_perf_read_counter(pmu, i);
-		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
-			cn10k_ddr_perf_event_update_all(pmu);
-			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
-			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			ops->pmu_overflow_handler(pmu, i);
 		}
 	}
 
@@ -629,13 +724,44 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static const struct ddr_pmu_ops ddr_pmu_ops = {
+	.enable_read_freerun_counter = ddr_pmu_enable_read_freerun,
+	.enable_write_freerun_counter = ddr_pmu_enable_write_freerun,
+	.clear_read_freerun_counter = ddr_pmu_read_clear_freerun,
+	.clear_write_freerun_counter = ddr_pmu_write_clear_freerun,
+	.pmu_overflow_handler = ddr_pmu_overflow_hander,
+};
+
+static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
+	.counter_overflow_val =  BIT_ULL(48),
+	.counter_max_val = GENMASK_ULL(48, 0),
+	.ddrc_perf_cnt_base = CN10K_DDRC_PERF_CNT_VALUE_BASE,
+	.ddrc_perf_cfg_base = CN10K_DDRC_PERF_CFG_BASE,
+	.ddrc_perf_cnt_op_mode_ctrl = CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.ddrc_perf_cnt_start_op_ctrl = CN10K_DDRC_PERF_CNT_START_OP_CTRL,
+	.ddrc_perf_cnt_end_op_ctrl = CN10K_DDRC_PERF_CNT_END_OP_CTRL,
+	.ddrc_perf_cnt_end_status = CN10K_DDRC_PERF_CNT_END_STATUS,
+	.ddrc_perf_cnt_freerun_en = CN10K_DDRC_PERF_CNT_FREERUN_EN,
+	.ddrc_perf_cnt_freerun_ctrl = CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
+	.ddrc_perf_cnt_freerun_clr = 0,
+	.ddrc_perf_cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
+	.ddrc_perf_cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
+	.ops = &ddr_pmu_ops,
+};
+
+static const struct ddr_pmu_data ddr_pmu_data = {
+	.id   = DDR_PMU_V1,
+};
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
+	const struct ddr_pmu_data *dev_data;
 	struct cn10k_ddr_pmu *ddr_pmu;
 	struct resource *res;
 	void __iomem *base;
 	char *name;
 	int ret;
+	int version;
 
 	ddr_pmu = devm_kzalloc(&pdev->dev, sizeof(*ddr_pmu), GFP_KERNEL);
 	if (!ddr_pmu)
@@ -644,30 +770,42 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	ddr_pmu->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ddr_pmu);
 
+	dev_data = device_get_match_data(&pdev->dev);
+	if (!dev_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+	version = dev_data->id;
+	ddr_pmu->version = version;
+
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	ddr_pmu->base = base;
 
-	/* Setup the PMU counter to work in manual mode */
-	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
-		       DDRC_PERF_CNT_OP_MODE_CTRL);
-
-	ddr_pmu->pmu = (struct pmu) {
-		.module	      = THIS_MODULE,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
-		.task_ctx_nr = perf_invalid_context,
-		.attr_groups = cn10k_attr_groups,
-		.event_init  = cn10k_ddr_perf_event_init,
-		.add	     = cn10k_ddr_perf_event_add,
-		.del	     = cn10k_ddr_perf_event_del,
-		.start	     = cn10k_ddr_perf_event_start,
-		.stop	     = cn10k_ddr_perf_event_stop,
-		.read	     = cn10k_ddr_perf_event_update,
-		.pmu_enable  = cn10k_ddr_perf_pmu_enable,
-		.pmu_disable = cn10k_ddr_perf_pmu_disable,
-	};
+	if (version == DDR_PMU_V1) {
+		/* Setup the PMU counter to work in manual mode */
+		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
+			       (ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl));
+
+		ddr_pmu->pmu = (struct pmu) {
+			.module       = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = cn10k_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add         = cn10k_ddr_perf_event_add,
+			.del         = cn10k_ddr_perf_event_del,
+			.start       = cn10k_ddr_perf_event_start,
+			.stop        = cn10k_ddr_perf_event_stop,
+			.read        = cn10k_ddr_perf_event_update,
+			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
+			.pmu_disable = cn10k_ddr_perf_pmu_disable,
+		};
+
+		ddr_pmu->p_data = &cn10k_ddr_pmu_pdata;
+	}
 
 	/* Choose this cpu to collect perf data */
 	ddr_pmu->cpu = raw_smp_processor_id();
@@ -688,7 +826,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
+	pr_info("DDR PMU Driver for ddrc@%llx\n", res->start);
 	return 0;
 error:
 	cpuhp_state_remove_instance_nocalls(
@@ -711,7 +849,7 @@ static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ .compatible = "marvell,cn10k-ddr-pmu", .data = &ddr_pmu_data},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -719,7 +857,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
-	{"MRVL000A", 0},
+	{"MRVL000A", (kernel_ulong_t)&ddr_pmu_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1


