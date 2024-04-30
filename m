Return-Path: <linux-kernel+bounces-163216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0F8B6750
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F541F21BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1E10A35;
	Tue, 30 Apr 2024 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N/6MLfgx"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BDA8F44;
	Tue, 30 Apr 2024 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439763; cv=none; b=lZ3xxZFL475VEySt891AMkApk1IyHAoDO2PSkeyz4HE0Ie6BtzO0pZ26EUVlylvgKUpO2SKNFwhBzvk2ZSs4sKD9IaWCtuSYGST4E7c1ANc2OGdM1BOaF1tY55pUh8HNec9Ozbjby15JAaQviDQ+ZexPkJtBBNWWrNSv4GWyaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439763; c=relaxed/simple;
	bh=TY5yKcnIZE00KhYpgmN4mdctJk6alW5yPHI5sk3a9IY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tijMY72agw0nca7fcy3ojjbHztQaOg5Wd9pAZx9eRWO9X8kGIEYlY3VYYvvKiPeaqZl7yKK6E8iNQly4z++aXn+82t+jde9lGDY/IYbYK03B63n0/WEnSXW5CLZoHDHd8kfZlWiCucwdAnSaHcMOd14gp2fM5LqbqtPX1AXNICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N/6MLfgx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2fe4335a068f11efb92737409a0e9459-20240430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5mLisfXXgL/VSvUU2SUsL5fRTTbTWAxuxt+JrE74xnM=;
	b=N/6MLfgx153J/d53+hE2sioO7o5dEKiadv5mk5S/W1dKSKyP5ut1HE+XU5ecvLfxzu15Sru+d37aP3JQVWzOnZAQ349aV6t5b26/oxAANfGra+87ckvzqazN46jbhBN0DQEpKxULvQkeZ1SSBqeopPPyEzgg7obzCF5dNBpTCtQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f88789b9-107c-4a02-9cbf-31f4b9e206e6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:3e8ec386-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2fe4335a068f11efb92737409a0e9459-20240430
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 238621689; Tue, 30 Apr 2024 09:15:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Apr 2024 09:15:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Apr 2024 09:15:50 +0800
From: Olivia Wen <olivia.wen@mediatek.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Tinghan Shen" <tinghan.shen@mediatek.com>,
	<linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jason-ch.chen@mediatek.com>, <yaya.chang@mediatek.com>,
	<teddy.chen@mediatek.com>, <olivia.wen@mediatek.com>
Subject: [PATCH v4 3/4] remoteproc: mediatek: Support setting DRAM and IPI shared buffer sizes
Date: Tue, 30 Apr 2024 09:15:33 +0800
Message-ID: <20240430011534.9587-4-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240430011534.9587-1-olivia.wen@mediatek.com>
References: <20240430011534.9587-1-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.911700-8.000000
X-TMASE-MatchedRID: d/mUWMuHsom0PK/eA06et2NW0DAjL5p+YefZ7F9kLgss/uUAk6xP7N4z
	BXBaIg4K3NDQwWqGEoVR6PqD1/sDxge3cFgbc4mUaK+MsTwM+1n0O7M3lSnTWzFidTBRWb28CWR
	nKv1knVY/ByLtx2Xthw3K/RXmY1xYw4mZjhdFeRXnx2TmxvCbKFV+08YFNHSuwDR44lliPu2Cjh
	4HUudaCG2IWWk4CSvny3HscmUQ3XxlZ48frA+isnV7tdtvoibaU+A7YkpDJ1iiXe5nNnUYt5ffm
	caR0qCL4vM1YF6AJbbCCfuIMF6xLXnN0DN7HnFmWQHrLGVYdcfiO0e00aV05m5u2x0Zh2nTR/2O
	ZSL1NkYFlLoBMuZT/JRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.911700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7335C20C3B1F0223D0F73DA4A0AF0395956A4426D61E955AD1C657F29AF48A892000:8
X-MTK: N

The SCP on different chips will require different DRAM sizes and IPI
shared buffer sizes based on varying requirements.

Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_common.h  | 11 ++++--
 drivers/remoteproc/mtk_scp.c     | 84 +++++++++++++++++++++++++++++++---------
 drivers/remoteproc/mtk_scp_ipi.c |  7 +++-
 3 files changed, 79 insertions(+), 23 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 6d7736a..fd5c539 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -78,7 +78,6 @@
 #define MT8195_L2TCM_OFFSET			0x850d0
 
 #define SCP_FW_VER_LEN			32
-#define SCP_SHARE_BUFFER_SIZE		288
 
 struct scp_run {
 	u32 signaled;
@@ -97,6 +96,11 @@ struct scp_ipi_desc {
 
 struct mtk_scp;
 
+struct mtk_scp_sizes_data {
+	size_t max_dram_size;
+	size_t ipi_share_buffer_size;
+};
+
 struct mtk_scp_of_data {
 	int (*scp_clk_get)(struct mtk_scp *scp);
 	int (*scp_before_load)(struct mtk_scp *scp);
@@ -110,6 +114,7 @@ struct mtk_scp_of_data {
 	u32 host_to_scp_int_bit;
 
 	size_t ipi_buf_offset;
+	const struct mtk_scp_sizes_data *scp_sizes;
 };
 
 struct mtk_scp_of_cluster {
@@ -141,10 +146,10 @@ struct mtk_scp {
 	struct scp_ipi_desc ipi_desc[SCP_IPI_MAX];
 	bool ipi_id_ack[SCP_IPI_MAX];
 	wait_queue_head_t ack_wq;
+	u8 *share_buf;
 
 	void *cpu_addr;
 	dma_addr_t dma_addr;
-	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
 
@@ -162,7 +167,7 @@ struct mtk_scp {
 struct mtk_share_obj {
 	u32 id;
 	u32 len;
-	u8 share_buf[SCP_SHARE_BUFFER_SIZE];
+	u8 *share_buf;
 };
 
 void scp_memcpy_aligned(void __iomem *dst, const void *src, unsigned int len);
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 6295148..e281d28 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -20,7 +20,6 @@
 #include "mtk_common.h"
 #include "remoteproc_internal.h"
 
-#define MAX_CODE_SIZE 0x500000
 #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
 
 /**
@@ -94,14 +93,15 @@ static void scp_ipi_handler(struct mtk_scp *scp)
 {
 	struct mtk_share_obj __iomem *rcv_obj = scp->recv_buf;
 	struct scp_ipi_desc *ipi_desc = scp->ipi_desc;
-	u8 tmp_data[SCP_SHARE_BUFFER_SIZE];
 	scp_ipi_handler_t handler;
 	u32 id = readl(&rcv_obj->id);
 	u32 len = readl(&rcv_obj->len);
+	const struct mtk_scp_sizes_data *scp_sizes;
 
-	if (len > SCP_SHARE_BUFFER_SIZE) {
-		dev_err(scp->dev, "ipi message too long (len %d, max %d)", len,
-			SCP_SHARE_BUFFER_SIZE);
+	scp_sizes = scp->data->scp_sizes;
+	if (len > scp_sizes->ipi_share_buffer_size) {
+		dev_err(scp->dev, "ipi message too long (len %d, max %zd)", len,
+			scp_sizes->ipi_share_buffer_size);
 		return;
 	}
 	if (id >= SCP_IPI_MAX) {
@@ -117,8 +117,9 @@ static void scp_ipi_handler(struct mtk_scp *scp)
 		return;
 	}
 
-	memcpy_fromio(tmp_data, &rcv_obj->share_buf, len);
-	handler(tmp_data, len, ipi_desc[id].priv);
+	memset(scp->share_buf, 0, scp_sizes->ipi_share_buffer_size);
+	memcpy_fromio(scp->share_buf, &rcv_obj->share_buf, len);
+	handler(scp->share_buf, len, ipi_desc[id].priv);
 	scp_ipi_unlock(scp, id);
 
 	scp->ipi_id_ack[id] = true;
@@ -133,6 +134,8 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 {
 	int ret;
 	size_t buf_sz, offset;
+	size_t share_buf_offset;
+	const struct mtk_scp_sizes_data *scp_sizes;
 
 	/* read the ipi buf addr from FW itself first */
 	ret = scp_elf_read_ipi_buf_addr(scp, fw, &offset);
@@ -152,12 +155,15 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 		return -EOVERFLOW;
 	}
 
+	scp_sizes = scp->data->scp_sizes;
 	scp->recv_buf = (struct mtk_share_obj __iomem *)
 			(scp->sram_base + offset);
+	share_buf_offset = sizeof(scp->recv_buf->id)
+		+ sizeof(scp->recv_buf->len) + scp_sizes->ipi_share_buffer_size;
 	scp->send_buf = (struct mtk_share_obj __iomem *)
-			(scp->sram_base + offset + sizeof(*scp->recv_buf));
-	memset_io(scp->recv_buf, 0, sizeof(*scp->recv_buf));
-	memset_io(scp->send_buf, 0, sizeof(*scp->send_buf));
+			(scp->sram_base + offset + share_buf_offset);
+	memset_io(scp->recv_buf, 0, share_buf_offset);
+	memset_io(scp->send_buf, 0, share_buf_offset);
 
 	return 0;
 }
@@ -741,14 +747,16 @@ static int scp_start(struct rproc *rproc)
 static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 {
 	int offset;
+	const struct mtk_scp_sizes_data *scp_sizes;
 
+	scp_sizes = scp->data->scp_sizes;
 	if (da < scp->sram_size) {
 		offset = da;
 		if (offset >= 0 && (offset + len) <= scp->sram_size)
 			return (void __force *)scp->sram_base + offset;
-	} else if (scp->dram_size) {
+	} else if (scp_sizes->max_dram_size) {
 		offset = da - scp->dma_addr;
-		if (offset >= 0 && (offset + len) <= scp->dram_size)
+		if (offset >= 0 && (offset + len) <= scp_sizes->max_dram_size)
 			return scp->cpu_addr + offset;
 	}
 
@@ -758,7 +766,9 @@ static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 {
 	int offset;
+	const struct mtk_scp_sizes_data *scp_sizes;
 
+	scp_sizes = scp->data->scp_sizes;
 	if (da >= scp->sram_phys &&
 	    (da + len) <= scp->sram_phys + scp->sram_size) {
 		offset = da - scp->sram_phys;
@@ -774,9 +784,9 @@ static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 	}
 
 	/* optional memory region */
-	if (scp->dram_size &&
+	if (scp_sizes->max_dram_size &&
 	    da >= scp->dma_addr &&
-	    (da + len) <= scp->dma_addr + scp->dram_size) {
+	    (da + len) <= scp->dma_addr + scp_sizes->max_dram_size) {
 		offset = da - scp->dma_addr;
 		return scp->cpu_addr + offset;
 	}
@@ -997,6 +1007,7 @@ EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
 static int scp_map_memory_region(struct mtk_scp *scp)
 {
 	int ret;
+	const struct mtk_scp_sizes_data *scp_sizes;
 
 	ret = of_reserved_mem_device_init(scp->dev);
 
@@ -1012,8 +1023,8 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	}
 
 	/* Reserved SCP code size */
-	scp->dram_size = MAX_CODE_SIZE;
-	scp->cpu_addr = dma_alloc_coherent(scp->dev, scp->dram_size,
+	scp_sizes = scp->data->scp_sizes;
+	scp->cpu_addr = dma_alloc_coherent(scp->dev, scp_sizes->max_dram_size,
 					   &scp->dma_addr, GFP_KERNEL);
 	if (!scp->cpu_addr)
 		return -ENOMEM;
@@ -1023,10 +1034,13 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 
 static void scp_unmap_memory_region(struct mtk_scp *scp)
 {
-	if (scp->dram_size == 0)
+	const struct mtk_scp_sizes_data *scp_sizes;
+
+	scp_sizes = scp->data->scp_sizes;
+	if (scp_sizes->max_dram_size == 0)
 		return;
 
-	dma_free_coherent(scp->dev, scp->dram_size, scp->cpu_addr,
+	dma_free_coherent(scp->dev, scp_sizes->max_dram_size, scp->cpu_addr,
 			  scp->dma_addr);
 	of_reserved_mem_device_release(scp->dev);
 }
@@ -1090,6 +1104,7 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
 	struct resource *res;
 	const char *fw_name = "scp.img";
 	int ret, i;
+	const struct mtk_scp_sizes_data *scp_sizes;
 
 	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
 	if (ret < 0 && ret != -EINVAL)
@@ -1137,6 +1152,13 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
 		goto release_dev_mem;
 	}
 
+	scp_sizes = scp->data->scp_sizes;
+	scp->share_buf = kzalloc(scp_sizes->ipi_share_buffer_size, GFP_KERNEL);
+	if (!scp->share_buf) {
+		dev_err(dev, "Failed to allocate IPI share buffer\n");
+		goto release_dev_mem;
+	}
+
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
@@ -1156,6 +1178,8 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
 remove_subdev:
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
+	kfree(scp->share_buf);
+	scp->share_buf = NULL;
 release_dev_mem:
 	scp_unmap_memory_region(scp);
 	for (i = 0; i < SCP_IPI_MAX; i++)
@@ -1171,6 +1195,8 @@ static void scp_free(struct mtk_scp *scp)
 
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
+	kfree(scp->share_buf);
+	scp->share_buf = NULL;
 	scp_unmap_memory_region(scp);
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_destroy(&scp->ipi_desc[i].lock);
@@ -1357,6 +1383,21 @@ static void scp_remove(struct platform_device *pdev)
 	mutex_destroy(&scp_cluster->cluster_lock);
 }
 
+static const struct mtk_scp_sizes_data default_scp_sizes = {
+	.max_dram_size = 0x500000,
+	.ipi_share_buffer_size = 288,
+};
+
+static const struct mtk_scp_sizes_data mt8188_scp_sizes = {
+	.max_dram_size = 0x500000,
+	.ipi_share_buffer_size = 600,
+};
+
+static const struct mtk_scp_sizes_data mt8188_scp_c1_sizes = {
+	.max_dram_size = 0xA00000,
+	.ipi_share_buffer_size = 600,
+};
+
 static const struct mtk_scp_of_data mt8183_of_data = {
 	.scp_clk_get = mt8183_scp_clk_get,
 	.scp_before_load = mt8183_scp_before_load,
@@ -1368,6 +1409,7 @@ static const struct mtk_scp_of_data mt8183_of_data = {
 	.host_to_scp_reg = MT8183_HOST_TO_SCP,
 	.host_to_scp_int_bit = MT8183_HOST_IPC_INT_BIT,
 	.ipi_buf_offset = 0x7bdb0,
+	.scp_sizes = &default_scp_sizes,
 };
 
 static const struct mtk_scp_of_data mt8186_of_data = {
@@ -1381,6 +1423,7 @@ static const struct mtk_scp_of_data mt8186_of_data = {
 	.host_to_scp_reg = MT8183_HOST_TO_SCP,
 	.host_to_scp_int_bit = MT8183_HOST_IPC_INT_BIT,
 	.ipi_buf_offset = 0x3bdb0,
+	.scp_sizes = &default_scp_sizes,
 };
 
 static const struct mtk_scp_of_data mt8188_of_data = {
@@ -1393,6 +1436,7 @@ static const struct mtk_scp_of_data mt8188_of_data = {
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
+	.scp_sizes = &mt8188_scp_sizes,
 };
 
 static const struct mtk_scp_of_data mt8188_of_data_c1 = {
@@ -1405,6 +1449,7 @@ static const struct mtk_scp_of_data mt8188_of_data_c1 = {
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
+	.scp_sizes = &mt8188_scp_c1_sizes,
 };
 
 static const struct mtk_scp_of_data mt8192_of_data = {
@@ -1417,6 +1462,7 @@ static const struct mtk_scp_of_data mt8192_of_data = {
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
+	.scp_sizes = &default_scp_sizes,
 };
 
 static const struct mtk_scp_of_data mt8195_of_data = {
@@ -1429,6 +1475,7 @@ static const struct mtk_scp_of_data mt8195_of_data = {
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
+	.scp_sizes = &default_scp_sizes,
 };
 
 static const struct mtk_scp_of_data mt8195_of_data_c1 = {
@@ -1441,6 +1488,7 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
+	.scp_sizes = &default_scp_sizes,
 };
 
 static const struct mtk_scp_of_data *mt8188_of_data_cores[] = {
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index cd0b601..c068227 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -162,10 +162,13 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 	struct mtk_share_obj __iomem *send_obj = scp->send_buf;
 	u32 val;
 	int ret;
+	const struct mtk_scp_sizes_data *scp_sizes;
+
+	scp_sizes = scp->data->scp_sizes;
 
 	if (WARN_ON(id <= SCP_IPI_INIT) || WARN_ON(id >= SCP_IPI_MAX) ||
 	    WARN_ON(id == SCP_IPI_NS_SERVICE) ||
-	    WARN_ON(len > sizeof(send_obj->share_buf)) || WARN_ON(!buf))
+	    WARN_ON(len > scp_sizes->ipi_share_buffer_size) || WARN_ON(!buf))
 		return -EINVAL;
 
 	ret = clk_prepare_enable(scp->clk);
@@ -184,7 +187,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 		goto unlock_mutex;
 	}
 
-	scp_memcpy_aligned(send_obj->share_buf, buf, len);
+	scp_memcpy_aligned(&send_obj->share_buf, buf, len);
 
 	writel(len, &send_obj->len);
 	writel(id, &send_obj->id);
-- 
2.6.4


