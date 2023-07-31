Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E7769725
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGaNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjGaNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:05:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4EB1729
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:04:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 516F46607109;
        Mon, 31 Jul 2023 14:04:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690808697;
        bh=Ty0rQR9CismILWHOJ9rVqiJlfrfqryVc5J0W+SMm8aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJ/qBrIlNdzyNH5lU1jL2PV4Di/QpqJC8xTyJ26kc6HThEVPaX3hFrajMuBrZk8fi
         Ca/ts09vEPNXLg1Y9D/Udxbk3uS42IgWEn6LKqI8SbYqWPXiOJ5+i2TBXlWth6eFul
         bCLUGFuBRNZj/4oHQ9ztdljuAXvdqyK9VcqsALMFk8pA5Tc97iZKU0a6s/EXyYx+sU
         wiWuQqfwbU8GRUvQ+zGGjHJRlFC+prditImZKDWO7oEQhJHS8pvFgwk8FR28SkGLMu
         8NuIXr3Fq+fPyxGE/xwg49ZfP8nMCDmUCCZcbVffcKyjqqON/DW8rgfOBB7EllmyjD
         EJTRjRJd+wQ2A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v7 12/13] drm/mediatek: aal: Rewrite kerneldoc for struct mtk_disp_aal
Date:   Mon, 31 Jul 2023 15:04:40 +0200
Message-ID: <20230731130441.173960-13-angelogioacchino.delregno@collabora.com>
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

The kerneldoc for struct mtk_disp_aal was entirely wrong: rewrite it
to actually document the structure.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index e2e4155faf01..2b51d6f79bfe 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -26,9 +26,11 @@ struct mtk_disp_aal_data {
 };
 
 /**
- * struct mtk_disp_aal - DISP_AAL driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
+ * struct mtk_disp_aal - Display Adaptive Ambient Light driver structure
+ * @clk:      clock for DISP_AAL controller
+ * @regs:     MMIO registers base
+ * @cmdq_reg: CMDQ Client register
+ * @data:     platform specific data for DISP_AAL
  */
 struct mtk_disp_aal {
 	struct clk *clk;
-- 
2.41.0

