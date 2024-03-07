Return-Path: <linux-kernel+bounces-94937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA308746EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E4C1F29360
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66917753;
	Thu,  7 Mar 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ECvyFs2u"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA59250F8;
	Thu,  7 Mar 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782654; cv=none; b=q29FOJoyRVCZ4ddKWiAzcIChHDfmnc3pQ5o/pe27U5nwe+XPJ+8mVtvSgq14pxC55RiBijxTUtrRnEPOW77R7yBahlH87JXphXUtRvrs972vTv8y1LpUVwlcZ2XV1V1sJ8qHEFGgaeP/sfSdCgRGbdrlwyoGpbvcDWmeHl8q/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782654; c=relaxed/simple;
	bh=IIXdbsYE7RegVpOnRHFX3zXhrytaVD+AGaUKbytHv+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcYzyOhJKKEfqdoj+rSKY59XqfB26nB0MF5UlCSI6+jscchHLL7hy9JV3s53Wvfg2o9tYsL8ewWtZJoFSG/l93QAmAZGr1N9nrBNqUmdBIWO2bDSzdgS7TJdFcnPmupdFXfHRLrlTsmcBpg5fxG57NLtbNJxYGoMN+c2PILKesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ECvyFs2u; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427129k3031657;
	Wed, 6 Mar 2024 19:37:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=T5iUH7HaRhYUUrVVA/Z/KTEILQ2jAbv61I5geWef4bM=; b=ECv
	yFs2uPXwa3PKil78AOQivmhBTDIDXycDWAE+S74PaAh3i9Z7R8tsQka9TRKxYruc
	B2sqDLMwJcRyPjrZFNQ0acNfPR8KjIh85sJ6hj4wep3u5rTAmiqhzttsRlYBBPa5
	58v7KtgN7qr1TqbbZ7gGeMksVM49Q9YtlufHEOenyjZeh2R+fq6c26qp5CxGCcpd
	c7ynMQ7UEMA4toWxS5no9o2lP8xN/DX8syTp6vMc6UZjEhh25N3vwQ+wBWG6/gi8
	oQzH/10PuEUDutCV06EwPstnX2M6P9/0lSpmOuUSSGS0ZQ6vpdlNLVpriMJlLmIl
	Rx7OHwg0N4Jrl+euljA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wq3jfrdjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:37:19 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 19:37:18 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 6 Mar 2024 19:36:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 19:36:57 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id D6CAD3F707F;
	Wed,  6 Mar 2024 19:36:52 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v7  4/7] coresight: tmc: Enable panic sync handling
Date: Thu, 7 Mar 2024 09:06:22 +0530
Message-ID: <20240307033625.325058-5-lcherian@marvell.com>
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
X-Proofpoint-GUID: M0wda1IPSxfnHbiKgX9DirPd7WbXMh7w
X-Proofpoint-ORIG-GUID: M0wda1IPSxfnHbiKgX9DirPd7WbXMh7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02

- Get reserved region from device tree node for metadata
- Define metadata format for TMC
- Add TMC ETR panic sync handler that syncs register snapshot
  to metadata region
- Add TMC ETF panic sync handler that syncs register snapshot
  to metadata region and internal SRAM to reserved trace buffer
  region.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v6:
* Moved the changes specific to stop on flush event that are part of
  panic sync handler, from patch 6 to here. 
* Added missing tmc_wait_for_tmcready(drvdata);
   

 .../hwtracing/coresight/coresight-tmc-core.c  | 25 +++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 72 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 70 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   | 45 +++++++++++-
 4 files changed, 211 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 1325387d6257..7170416c3e1a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -413,6 +413,31 @@ static void tmc_get_reserved_region(struct device *parent)
 
 	drvdata->crash_tbuf.paddr = res.start;
 	drvdata->crash_tbuf.size  = resource_size(&res);
+
+	/* Metadata region */
+	node = tmc_get_region_byname(parent->of_node, "metadata");
+	if (IS_ERR_OR_NULL(node)) {
+		dev_dbg(parent, "No metadata memory-region specified\n");
+		return;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	of_node_put(node);
+	if (rc || res.start == 0 || resource_size(&res) == 0) {
+		dev_err(parent, "Metadata memory is invalid\n");
+		return;
+	}
+
+	drvdata->crash_mdata.vaddr = memremap(res.start,
+					       resource_size(&res),
+					       MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(drvdata->crash_mdata.vaddr)) {
+		dev_err(parent, "Metadata memory mapping failed\n");
+		return;
+	}
+
+	drvdata->crash_mdata.paddr = res.start;
+	drvdata->crash_mdata.size  = resource_size(&res);
 }
 
 /* Detect and initialise the capabilities of a TMC ETR */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d4f641cd9de6..e396716da4f3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -590,6 +590,73 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	return to_read;
 }
 
+static int tmc_panic_sync_etf(struct coresight_device *csdev)
+{
+	u32 val;
+	struct csdev_access *csa;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	csa = &drvdata->csdev->access;
+
+	/* Make sure we have valid reserved memory */
+	if (!is_tmc_reserved_region_valid(csdev->dev.parent))
+		return 0;
+
+	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
+	mdata->valid = false;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Proceed only if ETF is enabled or configured as sink */
+	val = readl(drvdata->base + TMC_CTL);
+	if (!(val & TMC_CTL_CAPT_EN))
+		goto out;
+
+	val = readl(drvdata->base + TMC_MODE);
+	if (val != TMC_MODE_CIRCULAR_BUFFER)
+		goto out;
+
+	val = readl(drvdata->base + TMC_FFSR);
+	/* Do manual flush and stop only if its not auto-stopped */
+	if (!(val & TMC_FFSR_FT_STOPPED)) {
+		dev_info(&csdev->dev,
+			 "%s: Triggering manual flush\n", __func__);
+		tmc_flush_and_stop(drvdata);
+	} else
+		tmc_wait_for_tmcready(drvdata);
+
+	/* Sync registers from hardware to metadata region */
+	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
+	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
+
+	/* Sync Internal SRAM to reserved trace buffer region */
+	tmc_etb_dump_hw(drvdata);
+	memcpy(drvdata->crash_tbuf.vaddr, drvdata->buf, drvdata->len);
+	/* Store as per RSZ register convention */
+	mdata->size = drvdata->len >> 2;
+
+	/*
+	 * Make sure all previous writes are completed,
+	 * before we mark valid
+	 */
+	dsb(sy);
+	mdata->valid = true;
+	/*
+	 * Below order need to maintained, since crc of metadata
+	 * is dependent on first
+	 */
+	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
+	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
+
+	tmc_disable_hw(drvdata);
+
+	dev_info(&csdev->dev, "%s: success\n", __func__);
+out:
+	CS_UNLOCK(drvdata->base);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -603,6 +670,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
 	.disable	= tmc_disable_etf_link,
 };
 
+static const struct coresight_ops_panic tmc_etf_sync_ops = {
+	.sync		= tmc_panic_sync_etf,
+};
+
 const struct coresight_ops tmc_etb_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 };
@@ -610,6 +681,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
 const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
+	.panic_ops	= &tmc_etf_sync_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 2bbf53480c66..b268de6af9a3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1810,6 +1810,71 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_panic_sync_etr(struct coresight_device *csdev)
+{
+	u32 val;
+	struct csdev_access *csa;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	csa = &drvdata->csdev->access;
+
+	if (!drvdata->etr_buf)
+		return 0;
+
+	/* Being in RESRV mode implies valid reserved memory as well */
+	if (drvdata->etr_buf->mode != ETR_MODE_RESRV)
+		return 0;
+
+	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
+	mdata->valid = false;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Proceed only if ETR is enabled */
+	val = readl(drvdata->base + TMC_CTL);
+	if (!(val & TMC_CTL_CAPT_EN))
+		goto out;
+
+	val = readl(drvdata->base + TMC_FFSR);
+	/* Do manual flush and stop only if its not auto-stopped */
+	if (!(val & TMC_FFSR_FT_STOPPED)) {
+		dev_info(&csdev->dev,
+			 "%s: Triggering manual flush\n", __func__);
+		tmc_flush_and_stop(drvdata);
+	} else
+		tmc_wait_for_tmcready(drvdata);
+
+	/* Sync registers from hardware to metadata region */
+	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
+	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
+	mdata->rrp = tmc_read_rrp(drvdata);
+	mdata->rwp = tmc_read_rwp(drvdata);
+	mdata->dba = tmc_read_dba(drvdata);
+	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
+
+	/*
+	 * Make sure all previous writes are completed,
+	 * before we mark valid
+	 */
+	dsb(sy);
+	mdata->valid = true;
+	/*
+	 * Below order need to maintained, since crc of metadata
+	 * is dependent on first
+	 */
+	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
+	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
+
+	tmc_disable_hw(drvdata);
+
+	dev_info(&csdev->dev, "%s: success\n", __func__);
+out:
+	CS_UNLOCK(drvdata->base);
+
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
@@ -1818,8 +1883,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.free_buffer	= tmc_free_etr_buffer,
 };
 
+static const struct coresight_ops_panic tmc_etr_sync_ops = {
+	.sync		= tmc_panic_sync_etr,
+};
+
 const struct coresight_ops tmc_etr_cs_ops = {
 	.sink_ops	= &tmc_etr_sink_ops,
+	.panic_ops	= &tmc_etr_sync_ops,
 };
 
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2abc5387cdf7..875d4129da7c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -12,6 +12,7 @@
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/crc32.h>
 
 #define TMC_RSZ			0x004
 #define TMC_STS			0x00c
@@ -76,6 +77,9 @@
 #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
 #define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
 
+/* TMC_FFSR - 0x300 */
+#define TMC_FFSR_FT_STOPPED	BIT(1)
+
 /* TMC_FFCR - 0x304 */
 #define TMC_FFCR_FLUSHMAN_BIT	6
 #define TMC_FFCR_EN_FMT		BIT(0)
@@ -131,6 +135,21 @@ enum tmc_mem_intf_width {
 #define CORESIGHT_SOC_600_ETR_CAPS	\
 	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
 
+/* TMC metadata region for ETR and ETF configurations */
+struct tmc_crash_metadata {
+	uint32_t crc32_mdata;	/* crc of metadata */
+	uint32_t crc32_tdata;	/* crc of tracedata */
+	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
+	uint32_t size;          /* Ram Size register */
+	uint32_t sts;           /* Status register */
+	uint32_t reserved32[3];
+	uint64_t rrp;           /* Ram Read pointer register */
+	uint64_t rwp;           /* Ram Write pointer register */
+	uint64_t dba;		/* Data buffer address register */
+	uint64_t trc_paddr;	/* Phys address of trace buffer */
+	uint64_t reserved64[3];
+};
+
 enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
@@ -203,6 +222,8 @@ struct tmc_resrv_buf {
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
  *		(after crash) by default.
+ * @crash_mdata: Reserved memory for storing tmc crash metadata.
+ *		 Used by ETR/ETF.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -228,6 +249,7 @@ struct tmc_drvdata {
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	crash_tbuf;
+	struct tmc_resrv_buf	crash_mdata;
 };
 
 struct etr_buf_operations {
@@ -350,11 +372,32 @@ static inline bool is_tmc_reserved_region_valid(struct device *dev)
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata->crash_tbuf.paddr &&
-		drvdata->crash_tbuf.size)
+		drvdata->crash_tbuf.size &&
+		drvdata->crash_mdata.paddr &&
+		drvdata->crash_mdata.size)
 		return true;
 	return false;
 }
 
+static inline uint32_t find_crash_metadata_crc(struct tmc_crash_metadata *md)
+{
+	unsigned long crc_size;
+
+	crc_size = sizeof(struct tmc_crash_metadata) -
+		offsetof(struct tmc_crash_metadata, crc32_tdata);
+	return crc32_le(0, (void *)&md->crc32_tdata, crc_size);
+}
+
+static inline uint32_t find_crash_tracedata_crc(struct tmc_drvdata *drvdata,
+						struct tmc_crash_metadata *md)
+{
+	unsigned long crc_size;
+
+	/* Take CRC of configured buffer size to keep it simple */
+	crc_size = md->size << 2;
+	return crc32_le(0, (void *)drvdata->crash_tbuf.vaddr, crc_size);
+}
+
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
-- 
2.34.1


