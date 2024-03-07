Return-Path: <linux-kernel+bounces-94929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676B8746DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E431C2151C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31C1B299;
	Thu,  7 Mar 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dbokmyEf"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A1E574;
	Thu,  7 Mar 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782630; cv=none; b=Ekv06A3QJuJ6dUZRHlUdzJGcc7pQQ4kgLrxDyv3cmzgEZDKPMSBQ2G3y/QLtqYoTLNl7q1vkVnEhFbKY9OcrvIycHX3iPcvZdhXI/HAMNn2rQ6/eEIzZ796IqLf3AC8BVoptL+IkiM7GheX23kAroTzhN70Pko2Rsck79sJtz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782630; c=relaxed/simple;
	bh=jj1StVqEpvWRZnpelHCFpLyLjDErU7DzR9jr3m5s3kA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoIkeqOy+wjQM3+oOc+n3VQoaOeK3ogfkxG+MqVAoKiVViHUaJMT4qYIvH7b16t5B65lpD+ytXpObP5T+hSy4Bal9zW6nWvil9USJ8Km4yFMoANF8P+IM9hDsUAeYfuAmIEu8qkogBBZFAIbdpW5nCXVoSfNCDO1itFsyhmSuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dbokmyEf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427129k1031657;
	Wed, 6 Mar 2024 19:36:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=/rbUSh0zkfOnJiqxqKQgdX85S8tAyv3YyXqKnxLInsQ=; b=dbo
	kmyEfIsL0wPjlOf9uj4M7l5Ucd/sh6FIKP1kAjVS4DYDebpwPZzveqr7Xko5YBs2
	OLOUsA8y3hnwQ8vFWfhlksJip+6YiVIe/n8kp16+zX9/e5dtfeNv3vZF6/qukzlG
	v9q3EEBkAUNjNsJI4XKJ+6lWpvrXjrsLg87QVvJg6LSOqYTV4sK/RGdMR3h+GC8v
	DPYX2xzX56PRcPA2VWgHabUKXo8STMEDHOrisdgwLfwTcTyyQkbixa5jUbJbNeqc
	kNEtwL+qfk/pFctMmwFp+WsZ6E5dZqItWnsGXSQvnxuUWyoagHtiBjpfnMZ7RuGK
	xfmBkn/99F1JcXEFAKQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wq3jfrdh9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:36:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 19:36:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 19:36:47 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id A92083F707F;
	Wed,  6 Mar 2024 19:36:42 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy <areddy3@marvell.com>
Subject: [PATCH v7 2/7] coresight: tmc-etr: Add support to use reserved trace memory
Date: Thu, 7 Mar 2024 09:06:20 +0530
Message-ID: <20240307033625.325058-3-lcherian@marvell.com>
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
X-Proofpoint-GUID: 87dHm7pj-OUsdtRyH6OSMiBwCUYmOtER
X-Proofpoint-ORIG-GUID: 87dHm7pj-OUsdtRyH6OSMiBwCUYmOtER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02

Add support to use reserved memory for coresight ETR trace buffer.

Introduce a new ETR buffer mode called ETR_MODE_RESRV, which
becomes available when ETR device tree node is supplied with a valid
reserved memory region.

ETR_MODE_RESRV can be selected only by explicit user request.

$ echo resrv >/sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v6:
* Removed redundant goto statements
* Setting of etr_buf->size to the reserved memory size is done
  after successful dma map inside the alloc function
* Removed the special casing for ETR_MODE_RESRV 
* Fixed the tab spacing in struct tmc_drvdata 

 .../hwtracing/coresight/coresight-tmc-core.c  | 47 +++++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 82 ++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   | 27 ++++++
 3 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 72005b0c633e..1325387d6257 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 
@@ -370,6 +371,50 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
 	return (auth & TMC_AUTH_NSID_MASK) == 0x3;
 }
 
+static struct device_node *tmc_get_region_byname(struct device_node *node,
+						 char *name)
+{
+	int index;
+
+	index = of_property_match_string(node, "memory-region-names", name);
+	if (index < 0)
+		return ERR_PTR(-ENODEV);
+
+	return of_parse_phandle(node, "memory-region", index);
+}
+
+static void tmc_get_reserved_region(struct device *parent)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
+	struct device_node *node;
+	struct resource res;
+	int rc;
+
+	node = tmc_get_region_byname(parent->of_node, "tracedata");
+	if (IS_ERR_OR_NULL(node)) {
+		dev_dbg(parent, "No reserved trace buffer specified\n");
+		return;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	of_node_put(node);
+	if (rc || res.start == 0 || resource_size(&res) == 0) {
+		dev_err(parent, "Reserved trace buffer memory is invalid\n");
+		return;
+	}
+
+	drvdata->crash_tbuf.vaddr = memremap(res.start,
+						resource_size(&res),
+						MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(drvdata->crash_tbuf.vaddr)) {
+		dev_err(parent, "Reserved trace buffer mapping failed\n");
+		return;
+	}
+
+	drvdata->crash_tbuf.paddr = res.start;
+	drvdata->crash_tbuf.size  = resource_size(&res);
+}
+
 /* Detect and initialise the capabilities of a TMC ETR */
 static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
 {
@@ -482,6 +527,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
+	tmc_get_reserved_region(dev);
+
 	desc.dev = dev;
 
 	switch (drvdata->config_type) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e75428fa1592..2bbf53480c66 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -30,6 +30,7 @@ struct etr_buf_hw {
 	bool	has_iommu;
 	bool	has_etr_sg;
 	bool	has_catu;
+	bool	has_resrv;
 };
 
 /*
@@ -694,6 +695,75 @@ static const struct etr_buf_operations etr_flat_buf_ops = {
 	.get_data = tmc_etr_get_data_flat_buf,
 };
 
+/*
+ * tmc_etr_alloc_resrv_buf: Allocate a contiguous DMA buffer from reserved region.
+ */
+static int tmc_etr_alloc_resrv_buf(struct tmc_drvdata *drvdata,
+				  struct etr_buf *etr_buf, int node,
+				  void **pages)
+{
+	struct etr_flat_buf *resrv_buf;
+	struct device *real_dev = drvdata->csdev->dev.parent;
+
+	/* We cannot reuse existing pages for resrv buf */
+	if (pages)
+		return -EINVAL;
+
+	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_KERNEL);
+	if (!resrv_buf)
+		return -ENOMEM;
+
+	resrv_buf->daddr = dma_map_resource(real_dev, drvdata->crash_tbuf.paddr,
+					   drvdata->crash_tbuf.size,
+					   DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(real_dev, resrv_buf->daddr)) {
+		dev_err(real_dev, "failed to map source buffer address\n");
+		kfree(resrv_buf);
+		return -ENOMEM;
+	}
+
+	resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
+	resrv_buf->size = etr_buf->size = drvdata->crash_tbuf.size;
+	resrv_buf->dev = &drvdata->csdev->dev;
+	etr_buf->hwaddr = resrv_buf->daddr;
+	etr_buf->mode = ETR_MODE_RESRV;
+	etr_buf->private = resrv_buf;
+	return 0;
+}
+
+static void tmc_etr_free_resrv_buf(struct etr_buf *etr_buf)
+{
+	struct etr_flat_buf *resrv_buf = etr_buf->private;
+
+	if (resrv_buf && resrv_buf->daddr) {
+		struct device *real_dev = resrv_buf->dev->parent;
+
+		dma_unmap_resource(real_dev, resrv_buf->daddr,
+				resrv_buf->size, DMA_FROM_DEVICE, 0);
+	}
+	kfree(resrv_buf);
+}
+
+static void tmc_etr_sync_resrv_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	/*
+	 * Adjust the buffer to point to the beginning of the trace data
+	 * and update the available trace data.
+	 */
+	etr_buf->offset = rrp - etr_buf->hwaddr;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = rwp - rrp;
+}
+
+static const struct etr_buf_operations etr_resrv_buf_ops = {
+	.alloc = tmc_etr_alloc_resrv_buf,
+	.free = tmc_etr_free_resrv_buf,
+	.sync = tmc_etr_sync_resrv_buf,
+	.get_data = tmc_etr_get_data_flat_buf,
+};
+
 /*
  * tmc_etr_alloc_sg_buf: Allocate an SG buf @etr_buf. Setup the parameters
  * appropriately.
@@ -800,6 +870,7 @@ static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
 	[ETR_MODE_CATU] = NULL,
+	[ETR_MODE_RESRV] = &etr_resrv_buf_ops
 };
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu)
@@ -825,6 +896,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 	case ETR_MODE_FLAT:
 	case ETR_MODE_ETR_SG:
 	case ETR_MODE_CATU:
+	case ETR_MODE_RESRV:
 		if (etr_buf_ops[mode] && etr_buf_ops[mode]->alloc)
 			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
 						      node, pages);
@@ -843,6 +915,7 @@ static void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
 	buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
 	buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
 	buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
+	buf_hw->has_resrv = is_tmc_reserved_region_valid(dev->parent);
 }
 
 static bool etr_can_use_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
@@ -874,13 +947,10 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	if (!etr_buf)
 		return ERR_PTR(-ENOMEM);
 
-	etr_buf->size = size;
-
 	/* If there is user directive for buffer mode, try that first */
 	if (drvdata->etr_mode != ETR_MODE_AUTO)
 		rc = tmc_etr_mode_alloc_buf(drvdata->etr_mode, drvdata,
 					    etr_buf, node, pages);
-
 	/*
 	 * If we have to use an existing list of pages, we cannot reliably
 	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
@@ -1830,6 +1900,7 @@ static const char *const buf_modes_str[] = {
 	[ETR_MODE_FLAT]		= "flat",
 	[ETR_MODE_ETR_SG]	= "tmc-sg",
 	[ETR_MODE_CATU]		= "catu",
+	[ETR_MODE_RESRV]	= "resrv",
 	[ETR_MODE_AUTO]		= "auto",
 };
 
@@ -1848,6 +1919,9 @@ static ssize_t buf_modes_available_show(struct device *dev,
 	if (buf_hw.has_catu)
 		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
 
+	if (buf_hw.has_resrv)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_RESRV]);
+
 	size += sysfs_emit_at(buf, size, "\n");
 	return size;
 }
@@ -1875,6 +1949,8 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
 		drvdata->etr_mode = ETR_MODE_ETR_SG;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
 		drvdata->etr_mode = ETR_MODE_CATU;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
+		drvdata->etr_mode = ETR_MODE_RESRV;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
 		drvdata->etr_mode = ETR_MODE_AUTO;
 	else
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index cef979c897e6..2abc5387cdf7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -135,6 +135,7 @@ enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
+	ETR_MODE_RESRV,		/* Use reserved region contiguous buffer */
 	ETR_MODE_AUTO,		/* Use the default mechanism */
 };
 
@@ -164,6 +165,17 @@ struct etr_buf {
 	void				*private;
 };
 
+/**
+ * @paddr	: Start address of reserved memory region.
+ * @vaddr	: Corresponding CPU virtual address.
+ * @size	: Size of reserved memory region.
+ */
+struct tmc_resrv_buf {
+	phys_addr_t     paddr;
+	void		*vaddr;
+	size_t		size;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @base:	memory mapped base address for this component.
@@ -187,6 +199,10 @@ struct etr_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
+ * @crash_tbuf:	Used by ETR as hardware trace buffer and for trace data
+ *		retention (after crash) only when ETR_MODE_RESRV buffer
+ *		mode is enabled. Used by ETF for trace data retention
+ *		(after crash) by default.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -211,6 +227,7 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct tmc_resrv_buf	crash_tbuf;
 };
 
 struct etr_buf_operations {
@@ -328,6 +345,16 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
+static inline bool is_tmc_reserved_region_valid(struct device *dev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata->crash_tbuf.paddr &&
+		drvdata->crash_tbuf.size)
+		return true;
+	return false;
+}
+
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
-- 
2.34.1


