Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081EF76E651
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjHCLD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjHCLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:02:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F333AA0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:02:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B36E066071B2;
        Thu,  3 Aug 2023 12:02:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691060555;
        bh=eOGxKFVDezkCZBwW2hUee7R5nYDwDHZk82jsXyRXIgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYg+BLNcCZWfYvOBc79Cldv92wmSwBsSTRdQesNTk0xi+aDyXWMskQVNtYHYBHYMJ
         8ciy72f9F2L7SSoEu41qA8BvGN5gD7Lr2cvAShiZlVxiP2ZUj//MqN3HYGfSkgeTE/
         5mU94q8T0cah+fgS+GS7V/9vDcLEg1QryM5hIlPW05ctOudm/rKEQVWsEkYlBbb7Wn
         b96idRuoIisXzYkTpfbtWpB13ray91f5Zs7RoZrB6t7M8fZfeHJVy/hvlHZGU0KbW6
         8Wm/RZ+y43Y7o7XHMiHKQjgJdK5BN9p63NKhclzQdaCARjY9AHULQINhs80n9qIm9B
         zVHZo0Gn9sMBg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v9 16/16] drm/mediatek: aal: Compress of_device_id entries and add sentinel
Date:   Thu,  3 Aug 2023 13:02:14 +0200
Message-ID: <20230803110214.163645-17-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803110214.163645-1-angelogioacchino.delregno@collabora.com>
References: <20230803110214.163645-1-angelogioacchino.delregno@collabora.com>
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

Compress the entry for mediatek,mt8173-disp-aal, as it fits in one
line, and fix the style; while at it, also add the usual sentinel
comment to the last entry.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index e6ab3eaa1126..70de5f3007e4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -212,10 +212,9 @@ static const struct mtk_disp_aal_data mt8173_aal_driver_data = {
 };
 
 static const struct of_device_id mtk_disp_aal_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-aal",
-	  .data = &mt8173_aal_driver_data},
-	{ .compatible = "mediatek,mt8183-disp-aal"},
-	{},
+	{ .compatible = "mediatek,mt8173-disp-aal", .data = &mt8173_aal_driver_data },
+	{ .compatible = "mediatek,mt8183-disp-aal" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_aal_driver_dt_match);
 
-- 
2.41.0

