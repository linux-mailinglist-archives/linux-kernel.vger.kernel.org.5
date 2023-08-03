Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBEE76E254
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjHCIB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjHCIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165535BF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:50:39 -0700 (PDT)
X-UUID: 6c018bae31d211ee9cb5633481061a41-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zXH6sbvQV5thKqmsP6yJ7hqCSFhMzTMFPJkhA6neuGg=;
        b=aRC1M50+4z2u8hhjg5ZGCDpTLDvwwdM4cwjxbOaHAftkM0zsgo93q9wNy5wb5c2sSCco3r7VvcDQIoBJUaV3q8qnRZQqCs1HwgkptSltHcd3YXVDg9AE0RJJAiBjo2ziiGVsdTTBJqXxSt8RFwB17xj22m8YJGoscSSm2GGAQrc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:51fb2311-386c-460e-8f2d-105528158e03,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:51fb2311-386c-460e-8f2d-105528158e03,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:e211d8a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:23080315503407VZUZJE,BulkQuantity:2,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS
X-UUID: 6c018bae31d211ee9cb5633481061a41-20230803
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1813568689; Thu, 03 Aug 2023 15:50:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 15:50:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 15:50:30 +0800
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
        <allen-kh.cheng@mediatek.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: mediatek: mt8186 modify dram type as non-cache
Date:   Thu, 3 Aug 2023 15:50:28 +0800
Message-ID: <20230803075028.32170-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent incorrect access between the host and DSP sides, we need to
modify DRAM as a non-cache memory type. Additionally, we can retrieve
the size of shared DMA from the device tree.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
Reviewed-by: Kuan-Hsun Cheng <Allen-KH.Cheng@mediatek.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 40 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 3e0ea0e109e2..f587edf9e0a7 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -111,6 +111,14 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 
 	dev_dbg(dev, "DMA %pR\n", &res);
 
+	adsp->pa_shared_dram = (phys_addr_t)res.start;
+	adsp->shared_size = resource_size(&res);
+	if (adsp->pa_shared_dram & DRAM_REMAP_MASK) {
+		dev_err(dev, "adsp shared dma memory(%#x) is not 4K-aligned\n",
+			(u32)adsp->pa_shared_dram);
+		return -EINVAL;
+	}
+
 	ret = of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
@@ -244,23 +252,18 @@ static int adsp_shared_base_ioremap(struct platform_device *pdev, void *data)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_adsp_chip_info *adsp = data;
-	u32 shared_size;
 
 	/* remap shared-dram base to be non-cachable */
-	shared_size = TOTAL_SIZE_SHARED_DRAM_FROM_TAIL;
-	adsp->pa_shared_dram = adsp->pa_dram + adsp->dramsize - shared_size;
-	if (adsp->va_dram) {
-		adsp->shared_dram = adsp->va_dram + DSP_DRAM_SIZE - shared_size;
-	} else {
-		adsp->shared_dram = devm_ioremap(dev, adsp->pa_shared_dram,
-						 shared_size);
-		if (!adsp->shared_dram) {
-			dev_err(dev, "ioremap failed for shared DRAM\n");
-			return -ENOMEM;
-		}
+	adsp->shared_dram = devm_ioremap(dev, adsp->pa_shared_dram,
+					 adsp->shared_size);
+	if (!adsp->shared_dram) {
+		dev_err(dev, "failed to ioremap base %pa size %#x\n",
+			adsp->shared_dram, adsp->shared_size);
+		return -ENOMEM;
 	}
-	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%pa, size=%#x\n",
-		adsp->shared_dram, &adsp->pa_shared_dram, shared_size);
+
+	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%pa,  size=%#x\n",
+		adsp->shared_dram, &adsp->pa_shared_dram, adsp->shared_size);
 
 	return 0;
 }
@@ -307,9 +310,12 @@ static int mt8186_dsp_probe(struct snd_sof_dev *sdev)
 		return -ENOMEM;
 	}
 
-	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap_wc(sdev->dev,
-							  priv->adsp->pa_dram,
-							  priv->adsp->dramsize);
+	priv->adsp->va_sram = sdev->bar[SOF_FW_BLK_TYPE_IRAM];
+
+	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(sdev->dev,
+						       priv->adsp->pa_dram,
+						       priv->adsp->dramsize);
+
 	if (!sdev->bar[SOF_FW_BLK_TYPE_SRAM]) {
 		dev_err(sdev->dev, "failed to ioremap base %pa size %#x\n",
 			&priv->adsp->pa_dram, priv->adsp->dramsize);
-- 
2.18.0

