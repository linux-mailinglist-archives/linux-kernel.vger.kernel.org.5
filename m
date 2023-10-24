Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B327D4620
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjJXDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjJXDu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:50:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3432111
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:50:51 -0700 (PDT)
X-UUID: 834a1522722011ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QfVVtZBb9l5MkYex/BrRtzyJ2IeY7PLkE34QeN8pkSQ=;
        b=e1HhZCOPG2VBJGY1NG3BVi4+f/XIDerEVOlus5kHYJw3afd5UTMkjk6gz+UmjnpJOqtCCIMH6TRr/KvMSlSQHSYMA3zVFTPMGDwMOlWTyaHPQSLfpTKX8AF/Y2JsO9meenhBi2hwBRE3ik884FbneCWeCdIDk48geQ00uq0iwfQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6ecd9648-9318-448e-95bf-75ea406d78ff,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:94a58d94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 834a1522722011ee8051498923ad61e6-20231024
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 977540919; Tue, 24 Oct 2023 11:50:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 11:50:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 11:50:45 +0800
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
Subject: [PATCH v2 1/3] ASoC: mediatek: mt7986: drop the remove callback of mt7986_wm8960
Date:   Tue, 24 Oct 2023 11:50:17 +0800
Message-ID: <20231024035019.11732-2-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231024035019.11732-1-maso.huang@mediatek.com>
References: <20231024035019.11732-1-maso.huang@mediatek.com>
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

Drop the remove callback of mt7986_wm8960.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt7986/mt7986-wm8960.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/mediatek/mt7986/mt7986-wm8960.c b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
index 364d13b1c426..f6b9794b7229 100644
--- a/sound/soc/mediatek/mt7986/mt7986-wm8960.c
+++ b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
@@ -163,15 +163,6 @@ static int mt7986_wm8960_machine_probe(struct platform_device *pdev)
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
@@ -184,7 +175,6 @@ static struct platform_driver mt7986_wm8960_machine = {
 		.of_match_table = mt7986_wm8960_machine_dt_match,
 	},
 	.probe = mt7986_wm8960_machine_probe,
-	.remove_new = mt7986_wm8960_machine_remove,
 };
 
 module_platform_driver(mt7986_wm8960_machine);
-- 
2.18.0

