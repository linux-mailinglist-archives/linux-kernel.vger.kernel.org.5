Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30D762FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjGZIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjGZIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:32:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F16E93
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:23:01 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B99F1660711D;
        Wed, 26 Jul 2023 09:22:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690359779;
        bh=7S4BmWWUvw/WhRBHq0ubcEQhqplrJYEMp5mtO/yukgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB4ffQornmdszsZQH07HZXx/UkjdjOtxtEKNJnQP0A2s85zmD8fCDh3mTffaAjSIe
         Dtjk8FTcs22EcQWu+G2JDwXOZDa6JBo+dSSkJKek5CHKDAo5G+NRJVW+B6rlgkcN8f
         ofqtFnJllXPMf9yJkKrU3vFqfc5IwHI+C3tQUZlN2PGccdnsIJYu8X1s75oe+PSdiZ
         rmZ3sqrVdFVdue02VMy47Ml6jj5UwM3KLeBF1gcUGJHXpCQe1PxZc1xm7eoMR5+umr
         A17OhzSnfA7zLX5y0RpHG6FQxCdPxTjJpbf9Ap1nGqUyHM5zMrrasODGTe6Binl3iM
         A8kJslQqULGZw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        fshao@chromium.org, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v3 6/6] drm/mediatek: mtk_dpi: Compress struct of_device_id entries
Date:   Wed, 26 Jul 2023 10:22:45 +0200
Message-ID: <20230726082245.550929-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726082245.550929-1-angelogioacchino.delregno@collabora.com>
References: <20230726082245.550929-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce line count by compressing the entries of struct of_device_id;
while at it, also add the usual /* sentinel */ comment to the last
entry.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index a6fa26301a58..cc55dbb909ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1090,28 +1090,14 @@ static void mtk_dpi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_dpi_of_ids[] = {
-	{ .compatible = "mediatek,mt2701-dpi",
-	  .data = &mt2701_conf,
-	},
-	{ .compatible = "mediatek,mt8173-dpi",
-	  .data = &mt8173_conf,
-	},
-	{ .compatible = "mediatek,mt8183-dpi",
-	  .data = &mt8183_conf,
-	},
-	{ .compatible = "mediatek,mt8186-dpi",
-	  .data = &mt8186_conf,
-	},
-	{ .compatible = "mediatek,mt8188-dp-intf",
-	  .data = &mt8188_dpintf_conf,
-	},
-	{ .compatible = "mediatek,mt8192-dpi",
-	  .data = &mt8192_conf,
-	},
-	{ .compatible = "mediatek,mt8195-dp-intf",
-	  .data = &mt8195_dpintf_conf,
-	},
-	{ },
+	{ .compatible = "mediatek,mt2701-dpi", .data = &mt2701_conf },
+	{ .compatible = "mediatek,mt8173-dpi", .data = &mt8173_conf },
+	{ .compatible = "mediatek,mt8183-dpi", .data = &mt8183_conf },
+	{ .compatible = "mediatek,mt8186-dpi", .data = &mt8186_conf },
+	{ .compatible = "mediatek,mt8188-dp-intf", .data = &mt8188_dpintf_conf },
+	{ .compatible = "mediatek,mt8192-dpi", .data = &mt8192_conf },
+	{ .compatible = "mediatek,mt8195-dp-intf", .data = &mt8195_dpintf_conf },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
 
-- 
2.41.0

