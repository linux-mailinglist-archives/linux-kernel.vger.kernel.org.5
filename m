Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099217C6A38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjJLJ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjJLJ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:58:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB59ED
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A76036607353;
        Thu, 12 Oct 2023 10:57:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104677;
        bh=F86yWw2q9jRPtZJ/+Z1yLORSlOTQBx0C3WCmrGPVXMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDRmH/+XLLQ8NVYfRr/Kni7gONMnyJ9bi/N3lXRnNeDQlmehZoP++yqJIQTXKy/Wo
         CX7K+DXcbNviXcrRYIF1QktlhT/IbCXaX42ZCy4gTL/imQIPsEDDdeqldWMAD+Kg7M
         g7pO3XQ0DxbxfKrmLSaDqYZBassxSP5ZKuuiDPxUJVQ0izlvC53rLqmp2/j6AnXeah
         xyIfcMKbkgUKQqoJCB2Sfv9hZ6+Ocg0a51fDfO1FJXRxKcCyp8XqmmRc4MHHToRAMk
         oeLt9m0A0sX+5jn8+2NKHwp5VMEFbQobvCkQHQGFTdNCggiTbjGjza/mP4YfcLWeh3
         vbQ49hOTaQLFw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        nfraprado@collabora.com, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v11 15/16] drm/mediatek: gamma: Add kerneldoc for struct mtk_disp_gamma
Date:   Thu, 12 Oct 2023 11:57:35 +0200
Message-ID: <20231012095736.100784-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
References: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_disp_gamma structure was completely undocumented: add some
kerneldoc documentation to it.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 0f116c0e51b5..52c752bc5f41 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -50,8 +50,12 @@ struct mtk_disp_gamma_data {
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
2.42.0

