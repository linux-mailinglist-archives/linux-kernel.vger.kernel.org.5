Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352F079A4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjIKHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjIKHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:43:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A5CD7;
        Mon, 11 Sep 2023 00:42:58 -0700 (PDT)
X-UUID: ce04427a507611eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jhXji772hLI0yuv6/flR7J8iZD7soc0SkuwbZh8VPV4=;
        b=fqJSyDjHBY2vr0sFUG0eAvSJG/QR1YYuZ1DbrjkNuqKm/Aj6XVTQ9qQ2kXSxoWM19uaErAY/rg5ppFFWZGMZgXbb7evk00D7wPLj4bn7O5Tn6cOlLuUxZL3lO/zmkaqm4F12V2CFzDH+OV5xfcWOwyzuRp0aiz2S/y12+8C9ggE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8f16aa5f-f71f-4a89-9a42-296af915ad12,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:7dfab0be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ce04427a507611eea33bb35ae8d461a2-20230911
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1738525211; Mon, 11 Sep 2023 15:42:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 15:42:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 15:42:47 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "CK Hu" <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [RESEND PATCH v6 20/20] drm/mediatek: Set DPI input to 1T2P mode
Date:   Mon, 11 Sep 2023 15:42:33 +0800
Message-ID: <20230911074233.31556-21-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230911074233.31556-1-shawn.sung@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.788100-8.000000
X-TMASE-MatchedRID: PHWFXbsmkDRF/TNFimjSuEOZWaJBszmq3zhylsE9dsyOUV82NDH4AlO4
        BD7nLMxnThbvLLI8RvNq7k1NHAqvK5sYdIGP6PlZjtK7dC6UBnl9LQinZ4QefCP/VFuTOXUT3n8
        eBZjGmUzkwjHXXC/4IzsAVzN+Ov/stIQSbsaENgdNt2l9xnSaYRy2fvzjG4gKnxMQcCdlcTFN1W
        7aDGzFOw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.788100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2D16226B424DEBDEADAAD09A20A92CE73EE6C6096DDBA8452C8E346697E298AD2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPI input is in 1T2P mode on MT8195,
align the setting of MT8188 with it,
otherwise the screen will glitch.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 2f931e4e2b60..c6ee21e275ba 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -963,7 +963,7 @@ static const struct mtk_dpi_conf mt8188_dpintf_conf = {
 	.output_fmts = mt8195_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
 	.pixels_per_iter = 4,
-	.input_2pixel = false,
+	.input_2pixel = true,
 	.dimension_mask = DPINTF_HPW_MASK,
 	.hvsize_mask = DPINTF_HSIZE_MASK,
 	.channel_swap_shift = DPINTF_CH_SWAP,
--
2.18.0

