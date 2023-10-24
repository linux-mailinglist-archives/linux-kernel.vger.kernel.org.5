Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB17D461F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjJXDvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJXDu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:50:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886E10C9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:50:54 -0700 (PDT)
X-UUID: 85b63340722011ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7BreaDgCH7mRp5CSo98g29nYk3nW8Yu1AIFy53p6Y/I=;
        b=CJXfn8d/wyUDfFeGKn9UG1PQazyiexpxAbXW8E17y95LARaiPHHM6GuDZRb9sIfXKfG3PuFOZpV+ijayl1GzZiOpnxyhGHOoiCiMCO7JVYJhVce2m7y5fsqeiIAuQr3jX/Rg31/nSDp0oVNemIlh16z9A3MGlnaqazGlPHOwEio=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e8b26b00-aa94-4de8-8fd4-eb0983131630,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:b7a58d94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 85b63340722011ee8051498923ad61e6-20231024
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1306072661; Tue, 24 Oct 2023 11:50:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 11:50:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 11:50:48 +0800
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
Subject: [PATCH v2 2/3] ASoC: mediatek: mt7986: remove the mt7986_wm8960_priv structure
Date:   Tue, 24 Oct 2023 11:50:18 +0800
Message-ID: <20231024035019.11732-3-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231024035019.11732-1-maso.huang@mediatek.com>
References: <20231024035019.11732-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.396400-8.000000
X-TMASE-MatchedRID: fmS20tPE9ksZ9uxgtDtJQgPZZctd3P4BCt59Uh3p/NUKogmGusPLb7uA
        YZFvH/IiJ7vDzKaAUziGwpg7pPpeGdEdmUPXI8FxRnmgWPGIUuN9LQinZ4QefPcjNeVeWlqY+gt
        Hj7OwNO34ZhR52Rc1agOckpztc5q9DTKwjifCv/JaBY1H+rGnJmceWHNlxh0NYxCRwJSgalga8k
        2hFPMqR5nyvuWwh3WTLDv877bId1VPpulV5YAHJ0ma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6
        x5U/HridGByp+zdaDg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.396400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F482FDE8C42D897BE79991F8C5C7B1E56E94812EDF60B7011729E2E99BD7179F2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the mt7986_wm8960_priv structure.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt7986/mt7986-wm8960.c | 33 +++++++++--------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/sound/soc/mediatek/mt7986/mt7986-wm8960.c b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
index f6b9794b7229..c1390b373410 100644
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
@@ -158,8 +149,8 @@ static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
 	}
 
 err_of_node_put:
-	of_node_put(priv->codec_node);
-	of_node_put(priv->platform_node);
+	of_node_put(platform_dai_node);
+	of_node_put(codec_dai_node);
 	return ret;
 }
 
-- 
2.18.0

