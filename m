Return-Path: <linux-kernel+bounces-94934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5068746E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755B4281558
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFF14F7F;
	Thu,  7 Mar 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I6gKvbQC"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAA134A8;
	Thu,  7 Mar 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782646; cv=none; b=XJXh45SUl3pzwIwl2cpwJDieCjitE4iEyANM5NohwO/NHhZ3c55Hr/DqoW7g7X/PEcvQF+j4WiNLaOtLQ4A3WwxP83K1H2xmS4ekHrvMaWFjeJpmuWUBhVxUicgLehF24pHjU9Ui07fTfFVPv91pXB9wCkkW9gwsm2rRBjd41KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782646; c=relaxed/simple;
	bh=BzuOUQNyVOa3UfBS4GVFZPnayxVHtS5L8tv1f5RUYxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKAOJYSPTawH7G0rSq+DFuyyyWSfxWL/CZff1u0UP8Mmncab8OlVYh5wDUiJGYHOnz0041SP3oPlOwwRh9YOnuk1+XmmiyAqy+1ba2xk7gi3AhnPVonq6igaT/QUMG5IgcpMxyjW4HP/rUCii7Apa+5cgnmT63slvR6NJrcF3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I6gKvbQC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426IDCns004180;
	Wed, 6 Mar 2024 19:37:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=92KJSpAEm/tV8alNk37q4zTWi2/GA8WqCkd6Y17XKEM=; b=I6g
	KvbQCmFw/RfhTfIX8I2ywTvYEtaj1Yrk07LBPcCLSuK4wong5oRIS+5NyLguLLFp
	4o8EQ6j6NWsRNHgH/v6CyVOFqhZXhWsNjWUDiJp+nAfSa8kAtVTCfCzSExO0ULT9
	PQl6aK/LXf1FzNjCLBSQLClWIhBfWk4o0GRq1/QDJUqbBAHC4kRPevZ40r9hbGLb
	827bt/s1w78jpuhNwtUzKaHH0hgNpqNIWusnTX7SRGkoLjZxtD0UbZW01cZwIP7j
	T1LYJepZZh/rihfUhiadDz8qYwNNO86Hm0NF2fp8qTDXKU8UbbcytVF9cXOHbSXH
	FTDjR6rJL6GtYB/L9bw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wpp7bm1bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:37:13 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 19:37:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 19:37:12 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 4BF683F7084;
	Wed,  6 Mar 2024 19:37:08 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v7 7/7] coresight: config: Add preloaded configuration
Date: Thu, 7 Mar 2024 09:06:25 +0530
Message-ID: <20240307033625.325058-8-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307033625.325058-1-lcherian@marvell.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1R1HiusCRp8b3Q-H9OK0_VuBibJhh4BH
X-Proofpoint-GUID: 1R1HiusCRp8b3Q-H9OK0_VuBibJhh4BH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02

Add a preloaded configuration for generating
external trigger on address match. This can be
used by CTI and ETR blocks to stop trace capture
on kernel panic.

Kernel address for "panic" function is used as the
default trigger address.

This new configuration is available as,
/sys/kernel/config/cs-syscfg/configurations/panicstop

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v6:
* By default address value is set to kernel "panic"

 drivers/hwtracing/coresight/Makefile          |  2 +-
 .../coresight/coresight-cfg-preload.c         |  2 +
 .../coresight/coresight-cfg-preload.h         |  2 +
 .../hwtracing/coresight/coresight-cfg-pstop.c | 83 +++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 4ba478211b31..46ce7f39d05f 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -25,7 +25,7 @@ subdir-ccflags-y += $(condflags)
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
-		coresight-cfg-preload.o coresight-cfg-afdo.o \
+		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
 		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
index e237a4edfa09..4980e68483c5 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
@@ -13,6 +13,7 @@
 static struct cscfg_feature_desc *preload_feats[] = {
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	&strobe_etm4x,
+	&gen_etrig_etm4x,
 #endif
 	NULL
 };
@@ -20,6 +21,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
 static struct cscfg_config_desc *preload_cfgs[] = {
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	&afdo_etm4x,
+	&pstop_etm4x,
 #endif
 	NULL
 };
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
index 21299e175477..291ba530a6a5 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
@@ -10,4 +10,6 @@
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 extern struct cscfg_feature_desc strobe_etm4x;
 extern struct cscfg_config_desc afdo_etm4x;
+extern struct cscfg_feature_desc gen_etrig_etm4x;
+extern struct cscfg_config_desc pstop_etm4x;
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-cfg-pstop.c b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
new file mode 100644
index 000000000000..c2bfbd07bfaf
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2023  Marvell.
+ * Based on coresight-cfg-afdo.c
+ */
+
+#include "coresight-config.h"
+
+/* ETMv4 includes and features */
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+#include "coresight-etm4x-cfg.h"
+
+/* preload configurations and features */
+
+/* preload in features for ETMv4 */
+
+/* panic_stop feature */
+static struct cscfg_parameter_desc gen_etrig_params[] = {
+	{
+		.name = "address",
+		.value = (u64)panic,
+	},
+};
+
+static struct cscfg_regval_desc gen_etrig_regs[] = {
+	/* resource selector */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCRSCTLRn(2),
+		.hw_info = ETM4_CFG_RES_SEL,
+		.val32 = 0x40001,
+	},
+	/* single address comparator */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_64BIT |
+			CS_CFG_REG_TYPE_VAL_PARAM,
+		.offset =  TRCACVRn(0),
+		.val32 = 0x0,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCACATRn(0),
+		.val64 = 0xf00,
+	},
+	/* Driver external output[0] with comparator out */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCEVENTCTL0R,
+		.val32 = 0x2,
+	},
+	/* end of regs */
+};
+
+struct cscfg_feature_desc gen_etrig_etm4x = {
+	.name = "gen_etrig",
+	.description = "Generate external trigger on address match\n"
+		       "parameter \'address\': address of kernel address\n",
+	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
+	.nr_params = ARRAY_SIZE(gen_etrig_params),
+	.params_desc = gen_etrig_params,
+	.nr_regs = ARRAY_SIZE(gen_etrig_regs),
+	.regs_desc = gen_etrig_regs,
+};
+
+/* create a panic stop configuration */
+
+/* the total number of parameters in used features */
+#define PSTOP_NR_PARAMS	ARRAY_SIZE(gen_etrig_params)
+
+static const char *pstop_ref_names[] = {
+	"gen_etrig",
+};
+
+struct cscfg_config_desc pstop_etm4x = {
+	.name = "panicstop",
+	.description = "Stop ETM on kernel panic\n",
+	.nr_feat_refs = ARRAY_SIZE(pstop_ref_names),
+	.feat_ref_names = pstop_ref_names,
+	.nr_total_params = PSTOP_NR_PARAMS,
+};
+
+/* end of ETM4x configurations */
+#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */
-- 
2.34.1


