Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120976B438
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjHAL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjHAL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:59:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10331FC6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:59:13 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C19D8660719E;
        Tue,  1 Aug 2023 12:59:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690891152;
        bh=0jjC3Fg5s2rO0VQ/mVis11uZqJIg4LIgSGY5cW68WVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3R6cqlK085xUWcXg6UptkC6YQqgymple26EyBKjt8cibwdgFJLxSMb0TBo0TN9PG
         J9q54fpBncBXTs8/k7du/CgnSaitIeQ5LB5p+Pp3d0r3rPygOT6Kiyx5d+SpYYWz1H
         cSpSwaoX5rPj/yproq3zCXGXnIm9v+uDIeIQjyYTzLP9juHfwFrpGe2fIDupS4+poF
         GjUYeYnDVAk2WPPFmXF6QC/nFXKI+dXAyUExbLnjM1r6jp8wmZg2A+RLfSdZaIzgV9
         Wa81e+0VxsNYQ59vj54uxwiu1Vd1XWhhmWN4+zGspDYbLLM6XwE03Sjn2eDZRWK3Xn
         eEd/Q+2OaRhCA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v8 13/13] drm/mediatek: mtk_disp_gamma: Add kerneldoc for struct mtk_disp_gamma
Date:   Tue,  1 Aug 2023 13:58:54 +0200
Message-ID: <20230801115854.150346-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
References: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
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

The mtk_disp_gamma structure was completely undocumented: add some
kerneldoc documentation to it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index c6b77ca3e655..9be1efa9766c 100644
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

