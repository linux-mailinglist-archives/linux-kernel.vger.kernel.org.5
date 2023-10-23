Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5A7D2F34
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjJWJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjJWJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:56:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0B21BFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:55:20 -0700 (PDT)
X-UUID: 42f44efc718a11ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=knB+uMvpmxTF3yJ9XiU/mohcSPtntRiZjuCKxsC5XOw=;
        b=YJkkxnr2xN/2G5wdsVd9zoOnumgwPnV/zAmhmOXlaxH0ulYqirZoCBZZPuVL0Na3mxAFwi9WLZ9BJzK8zbjSs52D8Iul7Yz4N/0SqpFAy9ZWVj7bOybXfBqSA6zvFuO2xVQnhfaJ3kINHvZcuuHLNNvhVEzszS2IVm+H8px2YtY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:562cd2e6-56bc-484f-bef2-955635f42848,IP:0,U
        RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-30
X-CID-META: VersionHash:5f78ec9,CLOUDID:0613a9fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
        KR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42f44efc718a11ee8051498923ad61e6-20231023
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 876049281; Mon, 23 Oct 2023 17:55:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 17:55:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 17:55:13 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH 1/2] ASoC: mediatek: mt7986: remove redundant remove function
Date:   Mon, 23 Oct 2023 17:54:52 +0800
Message-ID: <20231023095453.4860-2-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023095453.4860-1-maso.huang@mediatek.com>
References: <20231023095453.4860-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant remove function of mt7986-wm8960.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt7986/mt7986-wm8960.c | 43 +++++++----------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/sound/soc/mediatek/mt7986/mt7986-wm8960.c b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
index 364d13b1c426..c1390b373410 100644
--- a/sound/soc/mediatek/mt7986/mt7986-wm8960.c
+++ b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
@@ -12,11 +12,6 @@
 
 #include "mt7986-afe-common.h"
 
-struct mt7986_wm8960_priv {
-	struct device_node *platform_node;
-	struct device_node *codec_node;
-};
-
 static const struct snd_soc_dapm_widget mt7986_wm8960_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("AMIC", NULL),
@@ -92,20 +87,18 @@ static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &mt7986_wm8960_card;
 	struct snd_soc_dai_link *dai_link;
 	struct device_node *platform, *codec;
-	struct mt7986_wm8960_priv *priv;
+	struct device_node *platform_dai_node, *codec_dai_node;
 	int ret, i;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	card->dev = &pdev->dev;
 
 	platform = of_get_child_by_name(pdev->dev.of_node, "platform");
 
 	if (platform) {
-		priv->platform_node = of_parse_phandle(platform, "sound-dai", 0);
+		platform_dai_node = of_parse_phandle(platform, "sound-dai", 0);
 		of_node_put(platform);
 
-		if (!priv->platform_node) {
+		if (!platform_dai_node) {
 			dev_err(&pdev->dev, "Failed to parse platform/sound-dai property\n");
 			return -EINVAL;
 		}
@@ -117,24 +110,22 @@ static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->platforms->name)
 			continue;
-		dai_link->platforms->of_node = priv->platform_node;
+		dai_link->platforms->of_node = platform_dai_node;
 	}
 
-	card->dev = &pdev->dev;
-
 	codec = of_get_child_by_name(pdev->dev.of_node, "codec");
 
 	if (codec) {
-		priv->codec_node = of_parse_phandle(codec, "sound-dai", 0);
+		codec_dai_node = of_parse_phandle(codec, "sound-dai", 0);
 		of_node_put(codec);
 
-		if (!priv->codec_node) {
-			of_node_put(priv->platform_node);
+		if (!codec_dai_node) {
+			of_node_put(platform_dai_node);
 			dev_err(&pdev->dev, "Failed to parse codec/sound-dai property\n");
 			return -EINVAL;
 		}
 	} else {
-		of_node_put(priv->platform_node);
+		of_node_put(platform_dai_node);
 		dev_err(&pdev->dev, "Property 'codec' missing or invalid\n");
 		return -EINVAL;
 	}
@@ -142,7 +133,7 @@ static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->codecs->name)
 			continue;
-		dai_link->codecs->of_node = priv->codec_node;
+		dai_link->codecs->of_node = codec_dai_node;
 	}
 
 	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
@@ -158,20 +149,11 @@ static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
 	}
 
 err_of_node_put:
-	of_node_put(priv->codec_node);
-	of_node_put(priv->platform_node);
+	of_node_put(platform_dai_node);
+	of_node_put(codec_dai_node);
 	return ret;
 }
 
-static void mt7986_wm8960_machine_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct mt7986_wm8960_priv *priv = snd_soc_card_get_drvdata(card);
-
-	of_node_put(priv->codec_node);
-	of_node_put(priv->platform_node);
-}
-
 static const struct of_device_id mt7986_wm8960_machine_dt_match[] = {
 	{.compatible = "mediatek,mt7986-wm8960-sound"},
 	{ /* sentinel */ }
@@ -184,7 +166,6 @@ static struct platform_driver mt7986_wm8960_machine = {
 		.of_match_table = mt7986_wm8960_machine_dt_match,
 	},
 	.probe = mt7986_wm8960_machine_probe,
-	.remove_new = mt7986_wm8960_machine_remove,
 };
 
 module_platform_driver(mt7986_wm8960_machine);
-- 
2.18.0

