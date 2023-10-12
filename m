Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E547C6A36
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjJLJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjJLJ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:58:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3487E8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:57 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B45C7660735F;
        Thu, 12 Oct 2023 10:57:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104676;
        bh=P77/YJTDYSmaGaK0qEws105RIsjmcoEYcEi31r4tRak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsNcUiyYcr5XDShO3jtR6lFvlbnttI8Bj9IT5wRcAVxxNmfrK1oSd5yYjKUcYc/M3
         yoLfBUpSg2XIxz/PIgAFSLOCVf1/becsUAVE6cKNnlz16brkuRgMGGIw8quEFV9uUY
         ZUouCH6PbMiOfUVXo0+xdoLWaKb5PeoDBPvJQ/r5HnaQSYdTuOGZp5H9AYoo6mG9Rx
         OdsjXQAAutSbNy8jZiMSdIW9Hu2dEY9+XGjJaWyG91pwiag6C/rGlXD0c/DPjgvDpz
         BoJYCsTymG7C9a/xSyUD06ZBmomCwr6yEdu9urIwBnTEF3v4DYdKHtfsqf6lW6C41Q
         j4BvyIfh8FAcA==
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
Subject: [PATCH v11 14/16] drm/mediatek: aal: Add kerneldoc for struct mtk_disp_aal
Date:   Thu, 12 Oct 2023 11:57:34 +0200
Message-ID: <20231012095736.100784-15-angelogioacchino.delregno@collabora.com>
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

The kerneldoc for struct mtk_disp_aal is missing: write one and
document this structure.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index 15f91cea9f20..7b3e1c275056 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -35,6 +35,13 @@ struct mtk_disp_aal_data {
 	bool has_gamma;
 };
 
+ /**
+ * struct mtk_disp_aal - Display Adaptive Ambient Light driver structure
+ * @clk:      clock for DISP_AAL controller
+ * @regs:     MMIO registers base
+ * @cmdq_reg: CMDQ Client register
+ * @data:     platform specific data for DISP_AAL
+ */
 struct mtk_disp_aal {
 	struct clk *clk;
 	void __iomem *regs;
-- 
2.42.0

