Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C376B437
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjHAL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjHAL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:59:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046821BF8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:59:13 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFAAB660718F;
        Tue,  1 Aug 2023 12:59:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690891151;
        bh=206jZKMDUUUvALUeIajtTnxov5G04xrQ/ztlKez7bcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5a0ffn+rzU/UghUYP4Y0t1LhRwtJPYH0jf6F5W8jRvG5y9/aQkJBS5xZyx7NLJD0
         fsQEuh1Rzg1DnoMDJ83q1DNQPykpRjVBm3EXVgGFR9HdsBUXRlBV/1KRM53eTdsOUB
         iYNnedFRHcR4TZVkjD3vSkt+NenffRe/Kk6Aiw5lSPs7OwP0UAELpmyA9x8U/r6Q1E
         jV4/doB88QiIl98pZuJaz7Rga0Wb026My+EtP8LQkivf9QspWbcPsBgXEjC5GwRG7/
         W9m0yZ3hQDK06uimHFp0UXcu9qYfTbRxQrBxtOyzrlYDlfrMwdATxg7xHHXpJG3rvX
         JLBQBm2Qoc+yA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v8 12/13] drm/mediatek: mtk_disp_aal: Rewrite kerneldoc for struct mtk_disp_aal
Date:   Tue,  1 Aug 2023 13:58:53 +0200
Message-ID: <20230801115854.150346-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
References: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index e390ccfdee18..d93b97a84825 100644
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

