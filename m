Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951577E0137
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347469AbjKCJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347380AbjKCJyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:54:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CCB1BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:54:49 -0700 (PDT)
X-UUID: 029a1fa07a2f11eea33bb35ae8d461a2-20231103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1PNy4lQFDD/9P/cCBJ+oFYmFIxu9jH1NPA/0OOwYEBQ=;
        b=exflmBaW3pz4CX2PxrtXv6Ox93ybXp7gYvw0C2Hf/j+fmS20+kWNvHhUvRctBFoPr6UFcFvfBW/sOGZkhryEkqlFJxWagYg1nzRrrfIrNad1EdHdSzIXUoG/6C4APWhiIX3uWZB3w8lswXZMZKaTRlPBinusRfe3gTjnaSG4Cdo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:84f5920e-a7b2-4fae-8d45-4a812c825796,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:a75ea55f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 029a1fa07a2f11eea33bb35ae8d461a2-20231103
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 859796463; Fri, 03 Nov 2023 17:54:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Nov 2023 17:54:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Nov 2023 17:54:40 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <yc.hung@mediatek.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: SOF: mediatek: mt8195: clean up unused code
Date:   Fri, 3 Nov 2023 17:54:30 +0800
Message-ID: <20231103095433.10475-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231103095433.10475-1-trevor.wu@mediatek.com>
References: <20231103095433.10475-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are some variables that are no longer being used, we remove
the code that was implemented for those variables.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 49 --------------------------
 1 file changed, 49 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index cac0a085f60a..8ee7ee246344 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -96,29 +96,6 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	struct mtk_adsp_chip_info *adsp = data;
 	int ret;
 
-	mem_region = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (!mem_region) {
-		dev_err(dev, "no dma memory-region phandle\n");
-		return -ENODEV;
-	}
-
-	ret = of_address_to_resource(mem_region, 0, &res);
-	of_node_put(mem_region);
-	if (ret) {
-		dev_err(dev, "of_address_to_resource dma failed\n");
-		return ret;
-	}
-
-	dev_dbg(dev, "DMA %pR\n", &res);
-
-	adsp->pa_shared_dram = (phys_addr_t)res.start;
-	adsp->shared_size = resource_size(&res);
-	if (adsp->pa_shared_dram & DRAM_REMAP_MASK) {
-		dev_err(dev, "adsp shared dma memory(%#x) is not 4K-aligned\n",
-			(u32)adsp->pa_shared_dram);
-		return -EINVAL;
-	}
-
 	ret = of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
@@ -238,26 +215,6 @@ static int adsp_memory_remap_init(struct device *dev, struct mtk_adsp_chip_info
 	return 0;
 }
 
-static int adsp_shared_base_ioremap(struct platform_device *pdev, void *data)
-{
-	struct device *dev = &pdev->dev;
-	struct mtk_adsp_chip_info *adsp = data;
-
-	/* remap shared-dram base to be non-cachable */
-	adsp->shared_dram = devm_ioremap(dev, adsp->pa_shared_dram,
-					 adsp->shared_size);
-	if (!adsp->shared_dram) {
-		dev_err(dev, "failed to ioremap base %pa size %#x\n",
-			adsp->shared_dram, adsp->shared_size);
-		return -ENOMEM;
-	}
-
-	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%pa,  size=%#x\n",
-		adsp->shared_dram, &adsp->pa_shared_dram, adsp->shared_size);
-
-	return 0;
-}
-
 static int mt8195_run(struct snd_sof_dev *sdev)
 {
 	u32 adsp_bootup_addr;
@@ -338,12 +295,6 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 	}
 	priv->adsp->va_dram = sdev->bar[SOF_FW_BLK_TYPE_SRAM];
 
-	ret = adsp_shared_base_ioremap(pdev, priv->adsp);
-	if (ret) {
-		dev_err(sdev->dev, "adsp_shared_base_ioremap fail!\n");
-		goto err_adsp_sram_power_off;
-	}
-
 	sdev->bar[DSP_REG_BAR] = priv->adsp->va_cfgreg;
 
 	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
-- 
2.18.0

