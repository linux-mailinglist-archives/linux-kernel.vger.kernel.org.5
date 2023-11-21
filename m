Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B587F2C67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjKUL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjKUL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5999D63;
        Tue, 21 Nov 2023 03:56:47 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73D99660731B;
        Tue, 21 Nov 2023 11:56:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567806;
        bh=EEiAga7/PEKFwq5/KS3naIy5UuB1z5wjPE5byYQKsG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpDnSoPGdSH1UzaeAKrP95OFmvISNmdjMD2sQMrcis1DwAE0iY57IcLuXpXMKNvG1
         wgsn5gdgujm2irWdQuxHZk48L9cYQ5xahqFRwXRiRAiNQaobt+ahTQL8Y+XzUD2Dzo
         KtfZX8b2pVFWiO25m7E0s8NonOIxatF6SyRaSEXb3l/3L+nYrQogcikjHDda1rOek0
         x00Jc8svE91glrxLm8VmYo2le9ZC1wXKMtXbYNLWZFlOtn7FfFIhazsOBxRYPXkikS
         ggSj/54pHRz8N7cMVU4Xg94djhV1anjwj9wf9p6UalW+scbGHy1zsQms5hAJixltE8
         Vn1Smp6ABGFmw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 14/20] soc: mediatek: mtk-svs: Compress of_device_id entries
Date:   Tue, 21 Nov 2023 12:56:18 +0100
Message-ID: <20231121115624.56855-15-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
References: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compress each entry to one line, as they fit in 84 columns, which
is acceptable.
While at it, also change the capital 'S' to 's' in 'sentinel'.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 5fd9884dd20f..ac36c2efcafa 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2731,24 +2731,12 @@ static const struct svs_platform_data svs_mt8183_platform_data = {
 };
 
 static const struct of_device_id svs_of_match[] = {
-	{
-		.compatible = "mediatek,mt8195-svs",
-		.data = &svs_mt8195_platform_data,
-	}, {
-		.compatible = "mediatek,mt8192-svs",
-		.data = &svs_mt8192_platform_data,
-	}, {
-		.compatible = "mediatek,mt8188-svs",
-		.data = &svs_mt8188_platform_data,
-	}, {
-		.compatible = "mediatek,mt8186-svs",
-		.data = &svs_mt8186_platform_data,
-	}, {
-		.compatible = "mediatek,mt8183-svs",
-		.data = &svs_mt8183_platform_data,
-	}, {
-		/* Sentinel */
-	},
+	{ .compatible = "mediatek,mt8195-svs", .data = &svs_mt8195_platform_data },
+	{ .compatible = "mediatek,mt8192-svs", .data = &svs_mt8192_platform_data },
+	{ .compatible = "mediatek,mt8188-svs", .data = &svs_mt8188_platform_data },
+	{ .compatible = "mediatek,mt8186-svs", .data = &svs_mt8186_platform_data },
+	{ .compatible = "mediatek,mt8183-svs", .data = &svs_mt8183_platform_data },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, svs_of_match);
 
-- 
2.42.0

