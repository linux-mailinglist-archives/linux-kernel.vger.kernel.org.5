Return-Path: <linux-kernel+bounces-46319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DD843DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738991F21C98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151757992E;
	Wed, 31 Jan 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hUmJRzfN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4778B66;
	Wed, 31 Jan 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699380; cv=none; b=uFMngJIGk9byEbJaS8cZN8vwX4vxS5OxivLxLzZcPjDZC4UCzN5bDpYz8GAoXqKP8aTFRzvoymlZL2HtCg1gdJ0VDzPP4ES1V6piMVEL/8ZtW42ERL8hif3DtWM1eF62SYNfnuXxvoDbMf1ZgnMndDCE2yWTUWfBnMPju/8gWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699380; c=relaxed/simple;
	bh=Xqy52vIcvXJeRMiKzcF+4BdYl08rCg9Lk7j3OSFo49o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiepNi1HWAlibYyjyTLLh0XHfa2mRrI1ji7hjLiqHj0/mQLyBUAT/fGFA5j2t0VjrwlYnNVa9PhQbpSH2JzXC7m8bSOrnTP35BO++jW8gR42SZpH3UqHL+a6Cblnm2EcM//0SzKzpZsM4Fd8GWZkmtT1bHY/1Em5FWV3o90PHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hUmJRzfN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V77UYB002143;
	Wed, 31 Jan 2024 11:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2nwuSUUya5Pmo11oGL6x4RKwwnnd1qGdMvMXWMYo8aQ=; b=hU
	mJRzfNaNAw0y5/SDp6DKFH8M3kc5m3Jm74hirzwnjIScrI4gJPg/+QABRvSJTUSn
	M9YBnI7zz+sJmg1BgvL/HZ9JOVz9OJMKvjil0UK+p2VgKBmp/4jWo39IH23FJheF
	PRE/IXi7M/MK7u8EJGdFMfQg1fjziTDWhTUOG4SK2z/Umh0odMPhINo2Fea5qnRr
	drkIyl6DmT5SA+3XvkbLa7w3oLz8epZvQci9QLVmVRUqG5hoeDlunlBJhmTVIWKM
	PG/EIUGCFChGe68XYfkAfhAdSQDfUZ/WQHyYGBr8khR7sIS7S+COUDhty4va+ZYs
	/5Rh36vkVNQXpNLdUw8w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy4rqach2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:09:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VB9EQN001468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:09:14 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 03:09:05 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v8 02/10] soc: qcom: Add qcom_rproc_minidump module
Date: Wed, 31 Jan 2024 16:38:29 +0530
Message-ID: <20240131110837.14218-3-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240131110837.14218-1-quic_mojha@quicinc.com>
References: <20240131110837.14218-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fwi-55Fv1K91PDQljvkQd3ZZz-C5lSQ1
X-Proofpoint-GUID: Fwi-55Fv1K91PDQljvkQd3ZZz-C5lSQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310085

Add qcom_rproc_minidump module in a preparation to remove
minidump specific code from driver/remoteproc/qcom_common.c
and provide needed exported API, this as well helps to
abstract minidump specific data layout from qualcomm's
remoteproc driver.

It is just a copying of qcom_minidump() functionality from
driver/remoteproc/qcom_common.c into a separate file under
qcom_rproc_minidump().

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig                  |  10 ++
 drivers/soc/qcom/Makefile                 |   1 +
 drivers/soc/qcom/qcom_minidump_internal.h |  64 +++++++++++++
 drivers/soc/qcom/qcom_rproc_minidump.c    | 111 ++++++++++++++++++++++
 include/soc/qcom/qcom_minidump.h          |  23 +++++
 5 files changed, 209 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
 create mode 100644 drivers/soc/qcom/qcom_rproc_minidump.c
 create mode 100644 include/soc/qcom/qcom_minidump.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index c6ca4de42586..33584bbbfc0e 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -268,4 +268,14 @@ config QCOM_INLINE_CRYPTO_ENGINE
 	tristate
 	select QCOM_SCM
 
+config QCOM_RPROC_MINIDUMP
+	tristate "QCOM Remoteproc Minidump Support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SMEM
+	help
+	  Enablement of core Minidump feature is controlled from boot firmware
+	  side, so if it is enabled from firmware, this config allow Linux to
+	  query predefined Minidump segments associated with the remote processor
+	  and check its validity and end up collecting the dump on remote processor
+	  crash during its recovery.
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 9268e15e1719..fa685e5a12a6 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
+obj-$(CONFIG_QCOM_RPROC_MINIDUMP)	+= qcom_rproc_minidump.o
diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
new file mode 100644
index 000000000000..71709235b196
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump_internal.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_MINIDUMP_INTERNAL_H_
+#define _QCOM_MINIDUMP_INTERNAL_H_
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID	   ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE	   ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	   ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+/**
+ * struct minidump_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @valid		: This entry to be dumped (if set to 1)
+ * @address		: Physical address of region to be dumped
+ * @size		: Size of the region
+ */
+struct minidump_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	__le32	seq_num;
+	__le32	valid;
+	__le64	address;
+	__le64	size;
+};
+
+/**
+ * struct minidump_subsystem - Subsystem's SMEM Table of content
+ * @status : Subsystem toc init status
+ * @enabled : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @region_count : Number of regions added in this subsystem toc
+ * @regions_baseptr : regions base pointer of the subsystem
+ */
+struct minidump_subsystem {
+	__le32	status;
+	__le32	enabled;
+	__le32	encryption_status;
+	__le32	encryption_required;
+	__le32	region_count;
+	__le64	regions_baseptr;
+};
+
+/**
+ * struct minidump_global_toc - Global Table of Content
+ * @status : Global Minidump init status
+ * @md_revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				md_revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
+};
+
+#endif /* _QCOM_MINIDUMP_INTERNAL_H_ */
diff --git a/drivers/soc/qcom/qcom_rproc_minidump.c b/drivers/soc/qcom/qcom_rproc_minidump.c
new file mode 100644
index 000000000000..9bc84cc2536f
--- /dev/null
+++ b/drivers/soc/qcom/qcom_rproc_minidump.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/remoteproc.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/string.h>
+#include <soc/qcom/qcom_minidump.h>
+
+#include "qcom_minidump_internal.h"
+
+static void qcom_minidump_cleanup(struct rproc *rproc)
+{
+	struct rproc_dump_segment *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
+		list_del(&entry->node);
+		kfree(entry->priv);
+		kfree(entry);
+	}
+}
+
+static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
+			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
+				void *dest, size_t offset, size_t size))
+{
+	struct minidump_region __iomem *ptr;
+	struct minidump_region region;
+	int seg_cnt, i;
+	dma_addr_t da;
+	size_t size;
+	char *name;
+
+	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
+		dev_err(&rproc->dev, "dump segment list already populated\n");
+		return -EUCLEAN;
+	}
+
+	seg_cnt = le32_to_cpu(subsystem->region_count);
+	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
+		      seg_cnt * sizeof(struct minidump_region));
+	if (!ptr)
+		return -EFAULT;
+
+	for (i = 0; i < seg_cnt; i++) {
+		memcpy_fromio(&region, ptr + i, sizeof(region));
+		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
+			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
+			if (!name) {
+				iounmap(ptr);
+				return -ENOMEM;
+			}
+			da = le64_to_cpu(region.address);
+			size = le64_to_cpu(region.size);
+			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
+		}
+	}
+
+	iounmap(ptr);
+	return 0;
+}
+
+void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
+		void (*rproc_dumpfn_t)(struct rproc *rproc,
+		struct rproc_dump_segment *segment, void *dest, size_t offset,
+		size_t size))
+{
+	int ret;
+	struct minidump_subsystem *subsystem;
+	struct minidump_global_toc *toc;
+
+	/* Get Global minidump ToC*/
+	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
+
+	/* check if global table pointer exists and init is set */
+	if (IS_ERR(toc) || !toc->status) {
+		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
+		return;
+	}
+
+	/* Get subsystem table of contents using the minidump id */
+	subsystem = &toc->subsystems[minidump_id];
+
+	/**
+	 * Collect minidump if SS ToC is valid and segment table
+	 * is initialized in memory and encryption status is set.
+	 */
+	if (subsystem->regions_baseptr == 0 ||
+	    le32_to_cpu(subsystem->status) != 1 ||
+	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
+	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
+		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
+		return;
+	}
+
+	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
+	if (ret) {
+		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
+		goto clean_minidump;
+	}
+	rproc_coredump_using_sections(rproc);
+clean_minidump:
+	qcom_minidump_cleanup(rproc);
+}
+EXPORT_SYMBOL_GPL(qcom_rproc_minidump);
+
+MODULE_DESCRIPTION("Qualcomm remoteproc minidump(smem) helper module");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
new file mode 100644
index 000000000000..cd87caef919d
--- /dev/null
+++ b/include/soc/qcom/qcom_minidump.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_MINIDUMP_H_
+#define _QCOM_MINIDUMP_H_
+
+struct rproc;
+struct rproc_dump_segment;
+
+#if IS_ENABLED(CONFIG_QCOM_RPROC_MINIDUMP)
+void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
+		   void (*rproc_dumpfn_t)(struct rproc *rproc,
+		   struct rproc_dump_segment *segment, void *dest, size_t offset,
+		   size_t size));
+#else
+static inline void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
+		   void (*rproc_dumpfn_t)(struct rproc *rproc,
+		   struct rproc_dump_segment *segment, void *dest, size_t offset,
+		   size_t size)) { }
+#endif /* CONFIG_QCOM_RPROC_MINIDUMP */
+#endif /* _QCOM_MINIDUMP_H_ */
-- 
2.43.0.254.ga26002b62827


