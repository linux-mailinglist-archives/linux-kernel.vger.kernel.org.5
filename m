Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5F769724
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGaNFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGaNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:05:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579F1735
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:04:59 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3240D6607190;
        Mon, 31 Jul 2023 14:04:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690808697;
        bh=oi90BFzw+vRNJ7SDlZut9Au2BJmQDV5m4O2v1GmjzUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Neol1ctUBENvx71Ht4UmmXxdW4B/HmSgfgO4UrxYzk4nyv5+yBqiYSWym7rWoplHb
         1wU0NRRTIHt6lmJKxNLd4tzRfL6rYn9YHIlmIX4yQBKeYdFKQcAojop057QAv1/J7x
         i5KysVJ6F8zps4h31ahGBaNvUsxc+Q+HtynSjyFj5hIJptL7lt/1GtXXKqPvHhLe/6
         GEdUPRHMyIyrq8vErVGJt3YDJN/iFNlr2T0ZVd/VjRHWJwetfRD1ingh4+RKimn33v
         qaIVou/udg7UvsjkZHosSSc3lpn70Fi5zc9gmAd5QRJHLkmbc8ddyW/s6YwuJOn93c
         gjRLJSOgg8jCA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v7 13/13] drm/mediatek: gamma: Add kerneldoc for struct mtk_disp_gamma
Date:   Mon, 31 Jul 2023 15:04:41 +0200
Message-ID: <20230731130441.173960-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731130441.173960-1-angelogioacchino.delregno@collabora.com>
References: <20230731130441.173960-1-angelogioacchino.delregno@collabora.com>
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

The mtk_disp_gamma structure was completely undocumented: add some
kerneldoc documentation to it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 6fa3f583f8a1..ee6b06223291 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -54,8 +54,12 @@ struct mtk_disp_gamma_data {
 	u8 lut_bits;
 };
 
-/*
- * struct mtk_disp_gamma - DISP_GAMMA driver structure
+/**
+ * struct mtk_disp_gamma - Display Gamma driver structure
+ * @clk:      clock for DISP_GAMMA block
+ * @regs:     MMIO registers base
+ * @cmdq_reg: CMDQ Client register
+ * @data:     platform data for DISP_GAMMA
  */
 struct mtk_disp_gamma {
 	struct clk *clk;
-- 
2.41.0

