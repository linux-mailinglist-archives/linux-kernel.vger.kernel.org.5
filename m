Return-Path: <linux-kernel+bounces-33051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A6B8363B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0AA28F79E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697643D0A0;
	Mon, 22 Jan 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E330Wwdy"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCD3CF71
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927809; cv=none; b=b4pYrdjiJbw5mqkLtyDlyIDKoPrAXQkej0IRgHGiDQR+XGA5q4LXBYtEgqyXtpmwoGN4tU2hwztiO/ooDV3zONh5vgSthaPh3T2qvOdFtunPEShBlihewkphKmqlMf/xXJqePd6Eo+Tjp6xMwcM0Y5J5htKOrzrzjlCl7srqg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927809; c=relaxed/simple;
	bh=O/06CasHvsHA45aDy0ELcS3XII2Pxv+2pQlz4vvnqO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3K5BRg2un0/DZ86KHv0IC4ojnPyu6gQDoNrZClj23xcrcxvKkXAbzrPuyIvcira1gK2qpLg95KvK76GUg4HBIxC1dXjIrOgl0Z307dQMBEoXOuJmcvLlTuZrucrTxCtvWnXVCoIIVhmBM4weQcwZ0wdTSThLdA9uNR9toBnjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E330Wwdy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5hZEq011128;
	Mon, 22 Jan 2024 04:49:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=I65KhJUDgvYVDgUj5X5nEe3yqsDYgkp4ddn8Qul30Aw=; b=E33
	0WwdyNfXAZZKRo9ygW8CEGev11AdG5HL7ollHR2c2Gxph8x/RhdMRCvhwTOvdlCG
	icxLxp8BdmZw2/AZ4jmlvzinWGiRnyBOD7aY6WNKZbnFFTY1EVnEVNphpv+JNDY4
	zNQPELQcBoFLGLtyHDLzBA/1DJi5SCRI/cy/D9n9jlLG/Q3ljBJtiP//0e6bqKDV
	Y+b7pcVBha7azWaIXHo5N3WvKzFfQi7rLq62MzP+4H/PCSldymb3aYkBCIoArStc
	a4Z2T67TK+CaLXJ2P56n/FiBcUSr13qG9TzB50m2ucGz0y+YO308I54tCzcJGMji
	k4ua7yh6o9U0NANu98A==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vsjews78e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 04:49:43 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 04:49:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 22 Jan 2024 04:49:42 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id AB1473F7071;
	Mon, 22 Jan 2024 04:49:39 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <george.cherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance monitor support
Date: Mon, 22 Jan 2024 18:19:32 +0530
Message-ID: <20240122124933.1311925-2-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122124933.1311925-1-gthiagarajan@marvell.com>
References: <20240122124933.1311925-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Lj_T10hBnWnWtSMZ4KP851xpci_ibYuG
X-Proofpoint-GUID: Lj_T10hBnWnWtSMZ4KP851xpci_ibYuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02

Odyssey DRAM Subsystem supports eight counters for monitoring performance
and software can program those counters to monitor any of the defined
performance events. Supported performance events include those counted
at the interface between the DDR controller and the PHY, interface between
the DDR Controller and the CHI interconnect, or within the DDR Controller.

Additionally DSS also supports two fixed performance event counters, one
for ddr reads and the other for ddr writes.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 421 +++++++++++++++++++++++----
 1 file changed, 359 insertions(+), 62 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 524ba82bfce2..b9c8be08d720 100644
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
@@ -14,24 +15,29 @@
 #include <linux/platform_device.h>
 
 /* Performance Counters Operating Mode Control Registers */
-#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
-#define OP_MODE_CTRL_VAL_MANNUAL	0x1
+#define OP_MODE_CTRL_VAL_MANUAL	0x1
+#define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
+#define ODY_DDRC_PERF_CNT_OP_MODE_CTRL		0x20020
 
 /* Performance Counters Start Operation Control Registers */
-#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
+#define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
 #define START_OP_CTRL_VAL_START		0x1ULL
 #define START_OP_CTRL_VAL_ACTIVE	0x2
+#define ODY_DDRC_PERF_CNT_START_OP_CTRL		0x200A0
 
 /* Performance Counters End Operation Control Registers */
-#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
+#define CN10K_DDRC_PERF_CNT_END_OP_CTRL		0x8030
 #define END_OP_CTRL_VAL_END		0x1ULL
+#define ODY_DDRC_PERF_CNT_END_OP_CTRL		0x200E0
 
 /* Performance Counters End Status Registers */
-#define DDRC_PERF_CNT_END_STATUS		0x8038
+#define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
+#define ODY_DDRC_PERF_CNT_END_STATUS		0x20120
 #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
 
 /* Performance Counters Configuration Registers */
-#define DDRC_PERF_CFG_BASE		0x8040
+#define CN10K_DDRC_PERF_CFG_BASE		0x8040
+#define ODY_DDRC_PERF_CFG_BASE			0x20160
 
 /* 8 Generic event counter + 2 fixed event counters */
 #define DDRC_PERF_NUM_GEN_COUNTERS	8
@@ -42,18 +48,26 @@
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
+#define EVENT_DFI_CMD_IS_RETRY			61
+#define EVENT_RD_UC_ECC_ERROR			60
+#define EVENT_RD_CRC_ERROR			59
+#define EVENT_CAPAR_ERROR			58
+#define EVENT_WR_CRC_ERROR			57
+#define EVENT_DFI_PARITY_POISON			56
 #define EVENT_OP_IS_ZQLATCH			55
 #define EVENT_OP_IS_ZQSTART			54
 #define EVENT_OP_IS_TCR_MRR			53
@@ -63,8 +77,8 @@
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
@@ -102,28 +116,40 @@
 #define EVENT_HIF_RD_OR_WR			1
 
 /* Event counter value registers */
-#define DDRC_PERF_CNT_VALUE_BASE		0x8080
-#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
+#define CN10K_DDRC_PERF_CNT_VALUE_BASE	0x8080
+#define ODY_DDRC_PERF_CNT_VALUE_BASE	0x201C0
 
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
+#define ODY_DDRC_PERF_CNT_FREERUN_CTRL		0x20240
+
+/* Fixed event counter clear register, defined only for Odyssey */
+#define ODY_DDRC_PERF_CNT_FREERUN_CLR		0x20248
 
-/* Fixed event counter value register */
-#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
-#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
 #define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
 #define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
 
+/* Fixed event counter value register */
+#define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
+#define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
+#define ODY_DDRC_PERF_CNT_VALUE_WR_OP		0x20250
+#define ODY_DDRC_PERF_CNT_VALUE_RD_OP		0x20258
+
+#define VERSION_V1				1
+#define VERSION_V2				2
+
 struct cn10k_ddr_pmu {
 	struct pmu pmu;
 	void __iomem *base;
+	struct ddr_pmu_platform_data *p_data;
+	int version;
 	unsigned int cpu;
 	struct	device *dev;
 	int active_events;
@@ -134,6 +160,54 @@ struct cn10k_ddr_pmu {
 
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
+};
+
+static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
+	.counter_overflow_val = 0,
+	.counter_max_val = GENMASK_ULL(63, 0),
+	.ddrc_perf_cnt_base = ODY_DDRC_PERF_CNT_VALUE_BASE,
+	.ddrc_perf_cfg_base = ODY_DDRC_PERF_CFG_BASE,
+	.ddrc_perf_cnt_op_mode_ctrl = ODY_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.ddrc_perf_cnt_start_op_ctrl = ODY_DDRC_PERF_CNT_START_OP_CTRL,
+	.ddrc_perf_cnt_end_op_ctrl = ODY_DDRC_PERF_CNT_END_OP_CTRL,
+	.ddrc_perf_cnt_end_status = ODY_DDRC_PERF_CNT_END_STATUS,
+	.ddrc_perf_cnt_freerun_en = 0,
+	.ddrc_perf_cnt_freerun_ctrl = ODY_DDRC_PERF_CNT_FREERUN_CTRL,
+	.ddrc_perf_cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
+	.ddrc_perf_cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
+	.ddrc_perf_cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
+};
+
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -189,9 +263,9 @@ static struct attribute *cn10k_ddr_perf_events_attrs[] = {
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
@@ -214,6 +288,85 @@ static struct attribute_group cn10k_ddr_perf_events_attr_group = {
 	.attrs = cn10k_ddr_perf_events_attrs,
 };
 
+static struct attribute *odyssey_ddr_perf_events_attrs[] = {
+	/* Programmable */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_or_wr_access, EVENT_HIF_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_wr_access, EVENT_HIF_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_access, EVENT_HIF_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rmw_access, EVENT_HIF_RMW),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_pri_rdaccess, EVENT_HIF_HI_PRI_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_bypass_access, EVENT_READ_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_act_bypass_access, EVENT_ACT_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_wr_data_access,
+				 EVENT_DFI_WR_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_rd_data_access,
+				 EVENT_DFI_RD_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpri_sched_rd_crit_access,
+				 EVENT_HPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpri_sched_rd_crit_access,
+				 EVENT_LPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_trxn_crit_access,
+				 EVENT_WR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_active_access, EVENT_OP_IS_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_or_wr_access,
+				 EVENT_OP_IS_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_active_access,
+				 EVENT_OP_IS_RD_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_read, EVENT_OP_IS_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_write, EVENT_OP_IS_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_mwr, EVENT_OP_IS_MWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge, EVENT_OP_IS_PRECHARGE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_rdwr,
+				 EVENT_PRECHARGE_FOR_RDWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_other,
+				 EVENT_PRECHARGE_FOR_OTHER),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rdwr_transitions, EVENT_RDWR_TRANSITIONS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write_combine, EVENT_WRITE_COMBINE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_war_hazard, EVENT_WAR_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_raw_hazard, EVENT_RAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_waw_hazard, EVENT_WAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_selfref, EVENT_OP_IS_ENTER_SELFREF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_powerdown,
+				 EVENT_OP_IS_ENTER_POWERDOWN),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_mpsm, EVENT_OP_IS_ENTER_MPSM),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_crit_ref, EVENT_OP_IS_CRIT_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_spec_ref, EVENT_OP_IS_SPEC_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_load_mode, EVENT_OP_IS_LOAD_MODE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cycles, EVENT_DFI_OR_HPR_REQ_NOCRED),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_retry_fifo_full,
+				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
+				 EVENT_VISIBLE_WIN_LIMIT_REACHED_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_wr,
+				 EVENT_VISIBLE_WIN_LIMIT_REACHED_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mpc, EVENT_OP_IS_DQSOSC_MPC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mrr, EVENT_OP_IS_DQSOSC_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_tcr_mrr, EVENT_OP_IS_TCR_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqstart, EVENT_OP_IS_ZQSTART),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqlatch, EVENT_OP_IS_ZQLATCH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_parity_poison,
+				 EVENT_DFI_PARITY_POISON),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_crc_error, EVENT_WR_CRC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_capar_error, EVENT_CAPAR_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_crc_error, EVENT_RD_CRC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_uc_ecc_error, EVENT_RD_UC_ECC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cmd_is_retry, EVENT_DFI_CMD_IS_RETRY),
+	/* Free run event counters */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_reads, EVENT_DDR_READS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_writes, EVENT_DDR_WRITES),
+	NULL
+};
+
+static struct attribute_group odyssey_ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = odyssey_ddr_perf_events_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-8");
 
 static struct attribute *cn10k_ddr_perf_format_attrs[] = {
@@ -254,6 +407,13 @@ static const struct attribute_group *cn10k_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *odyssey_attr_groups[] = {
+	&odyssey_ddr_perf_events_attr_group,
+	&cn10k_ddr_perf_format_attr_group,
+	&cn10k_ddr_perf_cpumask_attr_group,
+	NULL
+};
+
 /* Default poll timeout is 100 sec, which is very sufficient for
  * 48 bit counter incremented max at 5.6 GT/s, which may take many
  * hours to overflow.
@@ -266,13 +426,24 @@ static ktime_t cn10k_ddr_pmu_timer_period(void)
 	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
 }
 
-static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
+static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
+				     struct cn10k_ddr_pmu *ddr_pmu)
 {
+	int ret = 0;
+
 	switch (eventid) {
 	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
 	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
 		*event_bitmap = (1ULL << (eventid - 1));
 		break;
+	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
+		if (ddr_pmu->version == VERSION_V2) {
+			*event_bitmap = (1ULL << (eventid - 1));
+		} else {
+			pr_err("%s Invalid eventid %d\n", __func__, eventid);
+			ret = -EINVAL;
+		}
+		break;
 	case EVENT_OP_IS_ENTER_SELFREF:
 	case EVENT_OP_IS_ENTER_POWERDOWN:
 	case EVENT_OP_IS_ENTER_MPSM:
@@ -280,10 +451,10 @@ static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
 		break;
 	default:
 		pr_err("%s Invalid eventid %d\n", __func__, eventid);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int cn10k_ddr_perf_alloc_counter(struct cn10k_ddr_pmu *pmu,
@@ -356,6 +527,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 {
 	u32 reg;
 	u64 val;
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 
 	if (counter > DDRC_PERF_NUM_COUNTERS) {
 		pr_err("Error: unsupported counter %d\n", counter);
@@ -363,7 +535,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 	}
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
-		reg = DDRC_PERF_CFG(counter);
+		reg = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
 		val = readq_relaxed(pmu->base + reg);
 
 		if (enable)
@@ -373,7 +545,13 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		if (p_data->ddrc_perf_cnt_freerun_en)
+			val = readq_relaxed(pmu->base +
+					    p_data->ddrc_perf_cnt_freerun_en);
+		else
+			val = readq_relaxed(pmu->base +
+					    p_data->ddrc_perf_cnt_freerun_ctrl);
+
 		if (enable) {
 			if (counter == DDRC_PERF_READ_COUNTER_IDX)
 				val |= DDRC_PERF_FREERUN_READ_EN;
@@ -385,7 +563,13 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 			else
 				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
 		}
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+
+		if (p_data->ddrc_perf_cnt_freerun_en)
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_en);
+		else
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_ctrl);
 	}
 }
 
@@ -393,13 +577,18 @@ static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
 {
 	u64 val;
 
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
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
 
@@ -407,6 +596,7 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	u64 prev_count, new_count, mask;
 
 	do {
@@ -414,20 +604,48 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
 
-	mask = DDRC_PERF_CNT_MAX_VALUE;
+	mask = p_data->counter_max_val;
 
 	local64_add((new_count - prev_count) & mask, &event->count);
 }
 
+static void cn10k_ddr_perf_counter_start(struct cn10k_ddr_pmu *ddr_pmu,
+					 int counter)
+{
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
+	u64 ctrl_reg = p_data->ddrc_perf_cnt_start_op_ctrl;
+
+	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
+		       DDRC_PERF_REG(ctrl_reg, counter));
+}
+
+static void cn10k_ddr_perf_counter_stop(struct cn10k_ddr_pmu *ddr_pmu,
+					int counter)
+{
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
+	u64 ctrl_reg = p_data->ddrc_perf_cnt_end_op_ctrl;
+
+	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
+		       DDRC_PERF_REG(ctrl_reg, counter));
+}
+
 static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
+	u64 ctrl_reg = pmu->p_data->ddrc_perf_cnt_op_mode_ctrl;
 
 	local64_set(&hwc->prev_count, 0);
 
 	cn10k_ddr_perf_counter_enable(pmu, counter, true);
+	if (pmu->version == VERSION_V2) {
+	/* Setup the PMU counter to work in manual mode */
+		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, pmu->base +
+			       DDRC_PERF_REG(ctrl_reg, counter));
+
+		cn10k_ddr_perf_counter_start(pmu, counter);
+	}
 
 	hwc->state = 0;
 }
@@ -435,6 +653,7 @@ static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
 	int counter, ret;
@@ -454,8 +673,8 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
-		reg_offset = DDRC_PERF_CFG(counter);
-		ret = ddr_perf_get_event_bitmap(config, &val);
+		reg_offset = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
+		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
 		if (ret)
 			return ret;
 
@@ -467,7 +686,12 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 		else
 			val = DDRC_FREERUN_WRITE_CNT_CLR;
 
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
+		if (p_data->ddrc_perf_cnt_freerun_clr)
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_clr);
+		else
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_ctrl);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -486,6 +710,9 @@ static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
 
 	cn10k_ddr_perf_counter_enable(pmu, counter, false);
 
+	if (pmu->version == VERSION_V2)
+		cn10k_ddr_perf_counter_stop(pmu, counter);
+
 	if (flags & PERF_EF_UPDATE)
 		cn10k_ddr_perf_event_update(event);
 
@@ -512,17 +739,19 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
-		       DDRC_PERF_CNT_START_OP_CTRL);
+		       p_data->ddrc_perf_cnt_start_op_ctrl);
 }
 
 static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
-		       DDRC_PERF_CNT_END_OP_CTRL);
+		       p_data->ddrc_perf_cnt_end_op_ctrl);
 }
 
 static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
@@ -549,6 +778,7 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -561,7 +791,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 		prev_count = local64_read(&hwc->prev_count);
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 
-		/* Overflow condition is when new count less than
+		/*
+		 * Overflow condition is when new count less than
 		 * previous count
 		 */
 		if (new_count < prev_count)
@@ -574,7 +805,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 		prev_count = local64_read(&hwc->prev_count);
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 
-		/* Overflow condition is when new count less than
+		/*
+		 * Overflow condition is when new count less than
 		 * previous count
 		 */
 		if (new_count < prev_count)
@@ -586,11 +818,23 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 			continue;
 
 		value = cn10k_ddr_perf_read_counter(pmu, i);
-		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
-			cn10k_ddr_perf_event_update_all(pmu);
-			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
-			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			/*
+			 * As separate control register is added for each
+			 * counter in odyssey, no need to update all
+			 * the events
+			 */
+			if (pmu->version == VERSION_V2) {
+				cn10k_ddr_perf_event_update(pmu->events[i]);
+				cn10k_ddr_perf_counter_stop(pmu, i);
+				cn10k_ddr_perf_counter_start(pmu, i);
+
+			} else {
+				cn10k_ddr_perf_event_update_all(pmu);
+				cn10k_ddr_perf_pmu_disable(&pmu->pmu);
+				cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			}
 		}
 	}
 
@@ -631,7 +875,10 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
+	struct ddr_pmu_platform_data *pltfm_data;
+	struct device *dev = &pdev->dev;
 	struct cn10k_ddr_pmu *ddr_pmu;
+	const char  *compatible;
 	struct resource *res;
 	void __iomem *base;
 	char *name;
@@ -642,6 +889,14 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddr_pmu->dev = &pdev->dev;
+
+	pltfm_data = (struct ddr_pmu_platform_data *)
+		      device_get_match_data(&pdev->dev);
+	if (!pltfm_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+	ddr_pmu->p_data = pltfm_data;
 	platform_set_drvdata(pdev, ddr_pmu);
 
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -650,25 +905,59 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 
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
+	ret = device_property_read_string(dev, "compatible", &compatible);
+	if (ret) {
+		pr_err("compatible property not found\n");
+		return ret;
+	}
 
+	if ((strncmp("marvell,cn10k-ddr-pmu", compatible,
+		     strlen(compatible)) == 0))
+		ddr_pmu->version = VERSION_V1;
+	else
+		ddr_pmu->version = VERSION_V2;
+
+	if (ddr_pmu->version == VERSION_V1) {
+		ddr_pmu->pmu = (struct pmu) {
+			.module	      = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = cn10k_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add	     = cn10k_ddr_perf_event_add,
+			.del	     = cn10k_ddr_perf_event_del,
+			.start	     = cn10k_ddr_perf_event_start,
+			.stop	     = cn10k_ddr_perf_event_stop,
+			.read	     = cn10k_ddr_perf_event_update,
+			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
+			.pmu_disable = cn10k_ddr_perf_pmu_disable,
+		};
+
+	/*
+	 * As we have separate control registers for each counter in Odyssey,
+	 * setting up the mode will be done when we enable each counter
+	 *
+	 */
+
+	/* Setup the PMU counter to work in manual mode */
+		writeq(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
+		      (ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl));
+	} else {
+		ddr_pmu->pmu = (struct pmu) {
+			.module       = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = odyssey_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add         = cn10k_ddr_perf_event_add,
+			.del         = cn10k_ddr_perf_event_del,
+			.start       = cn10k_ddr_perf_event_start,
+			.stop        = cn10k_ddr_perf_event_stop,
+			.read        = cn10k_ddr_perf_event_update,
+			.pmu_enable  = NULL,
+			.pmu_disable = NULL,
+		};
+	}
 	/* Choose this cpu to collect perf data */
 	ddr_pmu->cpu = raw_smp_processor_id();
 
@@ -688,7 +977,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
+	pr_info("DDR PMU Driver for ddrc@%llx\n", res->start);
 	return 0;
 error:
 	cpuhp_state_remove_instance_nocalls(
@@ -711,7 +1000,8 @@ static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ .compatible = "marvell,cn10k-ddr-pmu",
+	  .data = &cn10k_ddr_pmu_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -719,7 +1009,14 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
-	{"MRVL000A", 0},
+	{
+		.id = "MRVL000A",
+		.driver_data = (kernel_ulong_t)&cn10k_ddr_pmu_pdata,
+	},
+	{
+		.id = "MRVL000C",
+		.driver_data = (kernel_ulong_t)&odyssey_ddr_pmu_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1


