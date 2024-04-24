Return-Path: <linux-kernel+bounces-156192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479B8AFF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F381C223E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE213C82F;
	Wed, 24 Apr 2024 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cOrOOBmH"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109A84DF9;
	Wed, 24 Apr 2024 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927867; cv=none; b=rZlKYnKj4j6lQgP962lhgtutImVI7iE0dYwfR1W9iP1P59thIWdlIbaEi3dwmlnZTJZb3rL/Dp6mmfuzhV+8QvrLOEsO3RN/HiyEPor4fJala7ddtdqdaEKz1Z3dgYOn/wI75d3j1eYwATnhJEZqdwPYsr5lA3zy/SEML2L9dDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927867; c=relaxed/simple;
	bh=27m4gjq08BB1f7dVqTWqJRbF/gX5RiDFjXCSOXjjRIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVY9S55E7iZ8uyzyJl4mMIQhsKMoVTlRmm86P/W4CRgz1JuJtTPSOwNa9uMVj76RyB8VbzicBVHUeDn/bFOhcoEyP3Rr05oB/p7gNosg06REipOU6DL3B1Cf3hlTqjMTxCthpBOH1jciUMN45aqjzJ8sHJFmIuoOV/Uo+jL9vLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cOrOOBmH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 568dee4e01e711ef935d6952f98a51a9-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y+7KhOeUNIR6jFtotjoE7W/U4gWcjEJKe+gFHWmbUBc=;
	b=cOrOOBmHvFN2ehYoyGxgcOY7PylYmhFZG3HUkhEeFFiS2Ywm+RsMSNE32nDFQgAVvChhGAI9dcmQsaG4N+DHVWzoKyhEHY2dev7bJYWRHwIES47dgv4YvNfVBEQlb89nROrhtjRF/jWDfNIYWqXKKxYB9AkqY3kFn/DuAgYjHNc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:88529258-36d4-4a51-99e5-a4f751134344,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a8f40983-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 568dee4e01e711ef935d6952f98a51a9-20240424
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2105321467; Wed, 24 Apr 2024 11:04:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 11:04:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 11:04:15 +0800
From: Olivia Wen <olivia.wen@mediatek.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tinghan
 Shen <tinghan.shen@mediatek.com>, <linux-remoteproc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jason-ch.chen@mediatek.com>, <yaya.chang@mediatek.com>,
	<teddy.chen@mediatek.com>, <olivia.wen@mediatek.com>
Subject: [PATCH v3 2/4] remoteproc: mediatek: Support MT8188 SCP core 1
Date: Wed, 24 Apr 2024 11:03:49 +0800
Message-ID: <20240424030351.5294-3-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240424030351.5294-1-olivia.wen@mediatek.com>
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

MT8188 SCP has two RISC-V cores which is similar to MT8195 but without
L1TCM. We've added MT8188-specific functions to configure L1TCM in
multicore setups.

Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>
---
 drivers/remoteproc/mtk_scp.c | 146 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 6751829..6295148 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -471,6 +471,86 @@ static int mt8186_scp_before_load(struct mtk_scp *scp)
 	return 0;
 }
 
+static int mt8188_scp_l2tcm_on(struct mtk_scp *scp)
+{
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+
+	mutex_lock(&scp_cluster->cluster_lock);
+
+	if (scp_cluster->l2tcm_refcnt == 0) {
+		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
+		writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
+
+		/* Power on L2TCM */
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
+	}
+
+	scp_cluster->l2tcm_refcnt += 1;
+
+	mutex_unlock(&scp_cluster->cluster_lock);
+
+	return 0;
+}
+
+static int mt8188_scp_before_load(struct mtk_scp *scp)
+{
+	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
+
+	mt8188_scp_l2tcm_on(scp);
+
+	scp_sram_power_on(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
+
+	/* enable MPU for all memory regions */
+	writel(0xff, scp->cluster->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
+
+	return 0;
+}
+
+static int mt8188_scp_c1_before_load(struct mtk_scp *scp)
+{
+	u32 sec_ctrl;
+	struct mtk_scp *scp_c0;
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+
+	scp->data->scp_reset_assert(scp);
+
+	mt8188_scp_l2tcm_on(scp);
+
+	scp_sram_power_on(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
+
+	/* enable MPU for all memory regions */
+	writel(0xff, scp->cluster->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
+
+	/*
+	 * The L2TCM_OFFSET_RANGE and L2TCM_OFFSET shift the destination address
+	 * on SRAM when SCP core 1 accesses SRAM.
+	 *
+	 * This configuration solves booting the SCP core 0 and core 1 from
+	 * different SRAM address because core 0 and core 1 both boot from
+	 * the head of SRAM by default. this must be configured before boot SCP core 1.
+	 *
+	 * The value of L2TCM_OFFSET_RANGE is from the viewpoint of SCP core 1.
+	 * When SCP core 1 issues address within the range (L2TCM_OFFSET_RANGE),
+	 * the address will be added with a fixed offset (L2TCM_OFFSET) on the bus.
+	 * The shift action is tranparent to software.
+	 */
+	writel(0, scp->cluster->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_LOW);
+	writel(scp->sram_size, scp->cluster->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_HIGH);
+
+	scp_c0 = list_first_entry(&scp_cluster->mtk_scp_list, struct mtk_scp, elem);
+	writel(scp->sram_phys - scp_c0->sram_phys, scp->cluster->reg_base + MT8195_L2TCM_OFFSET);
+
+	/* enable SRAM offset when fetching instruction and data */
+	sec_ctrl = readl(scp->cluster->reg_base + MT8195_SEC_CTRL);
+	sec_ctrl |= MT8195_CORE_OFFSET_ENABLE_I | MT8195_CORE_OFFSET_ENABLE_D;
+	writel(sec_ctrl, scp->cluster->reg_base + MT8195_SEC_CTRL);
+
+	return 0;
+}
+
 static int mt8192_scp_before_load(struct mtk_scp *scp)
 {
 	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
@@ -717,6 +797,47 @@ static void mt8183_scp_stop(struct mtk_scp *scp)
 	writel(0, scp->cluster->reg_base + MT8183_WDT_CFG);
 }
 
+static void mt8188_scp_l2tcm_off(struct mtk_scp *scp)
+{
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+
+	mutex_lock(&scp_cluster->cluster_lock);
+
+	if (scp_cluster->l2tcm_refcnt > 0)
+		scp_cluster->l2tcm_refcnt -= 1;
+
+	if (scp_cluster->l2tcm_refcnt == 0) {
+		/* Power off L2TCM */
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
+	}
+
+	mutex_unlock(&scp_cluster->cluster_lock);
+}
+
+static void mt8188_scp_stop(struct mtk_scp *scp)
+{
+	mt8188_scp_l2tcm_off(scp);
+
+	scp_sram_power_off(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
+
+	/* Disable SCP watchdog */
+	writel(0, scp->cluster->reg_base + MT8192_CORE0_WDT_CFG);
+}
+
+static void mt8188_scp_c1_stop(struct mtk_scp *scp)
+{
+	mt8188_scp_l2tcm_off(scp);
+
+	/* Power off CPU SRAM */
+	scp_sram_power_off(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
+
+	/* Disable SCP watchdog */
+	writel(0, scp->cluster->reg_base + MT8195_CORE1_WDT_CFG);
+}
+
 static void mt8192_scp_stop(struct mtk_scp *scp)
 {
 	/* Disable SRAM clock */
@@ -1264,16 +1385,28 @@ static const struct mtk_scp_of_data mt8186_of_data = {
 
 static const struct mtk_scp_of_data mt8188_of_data = {
 	.scp_clk_get = mt8195_scp_clk_get,
-	.scp_before_load = mt8192_scp_before_load,
-	.scp_irq_handler = mt8192_scp_irq_handler,
+	.scp_before_load = mt8188_scp_before_load,
+	.scp_irq_handler = mt8195_scp_irq_handler,
 	.scp_reset_assert = mt8192_scp_reset_assert,
 	.scp_reset_deassert = mt8192_scp_reset_deassert,
-	.scp_stop = mt8192_scp_stop,
+	.scp_stop = mt8188_scp_stop,
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
 };
 
+static const struct mtk_scp_of_data mt8188_of_data_c1 = {
+	.scp_clk_get = mt8195_scp_clk_get,
+	.scp_before_load = mt8188_scp_c1_before_load,
+	.scp_irq_handler = mt8195_scp_c1_irq_handler,
+	.scp_reset_assert = mt8195_scp_c1_reset_assert,
+	.scp_reset_deassert = mt8195_scp_c1_reset_deassert,
+	.scp_stop = mt8188_scp_c1_stop,
+	.scp_da_to_va = mt8192_scp_da_to_va,
+	.host_to_scp_reg = MT8192_GIPC_IN_SET,
+	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
+};
+
 static const struct mtk_scp_of_data mt8192_of_data = {
 	.scp_clk_get = mt8192_scp_clk_get,
 	.scp_before_load = mt8192_scp_before_load,
@@ -1310,6 +1443,12 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
 	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
 };
 
+static const struct mtk_scp_of_data *mt8188_of_data_cores[] = {
+	&mt8188_of_data,
+	&mt8188_of_data_c1,
+	NULL
+};
+
 static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
 	&mt8195_of_data,
 	&mt8195_of_data_c1,
@@ -1320,6 +1459,7 @@ static const struct of_device_id mtk_scp_of_match[] = {
 	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
 	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
 	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
+	{ .compatible = "mediatek,mt8188-scp-dual", .data = &mt8188_of_data_cores },
 	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
 	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
 	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
-- 
2.6.4


