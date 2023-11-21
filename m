Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642F77F2DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjKUMvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjKUMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9BD52;
        Tue, 21 Nov 2023 04:50:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB37F660731B;
        Tue, 21 Nov 2023 12:50:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571057;
        bh=rbMxFG/9Z/MvXIMSXdH+Z5ELUWvpXJ2G/c2LivRCtOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBpzUERpnXVxQTq62hizv4R8fVPbIUHQHcCLwXPwO6zzL2zGsXcb12DLbdmJUVFq1
         ICTMNG8y4zzELKcVCaY3i0hTea/M301YmHNuOUmnpQ2pz4pWxQcUguqsJNusCGUBd7
         oaV26QCH0nOlmXt5watgiE+y+quzHg6fcxah8oQ0qXb/q+/z14H18mRpCbob4ZDg+I
         yW2hH7epRTbxUOALclfGyTF/iYDR3Qp+vKjonIYo7SbHxlrtpd1omapjnm4EHLXRvS
         nhrxLhBGCOgs+wOEn1BJra0d2PvEUPnBbkO7WDN4WGhwxHUG+GVb6jrGY3IQGWnpmy
         k7/7fvcF4cPYA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 06/20] soc: mediatek: mtk-svs: Change the thermal sensor device name
Date:   Tue, 21 Nov 2023 13:50:30 +0100
Message-ID: <20231121125044.78642-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver tries to create a device link to the thermal sensor device:
change all instances of "lvts" and "thermal" to "thermal-sensor", as
that's what the devicetree node name must be.

Note for MT8183: As specified in a previous commit, this SoC never got
SVS probing, so this is not a breaking change and it does not require
fallback for older device trees.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 6c27fb523bfa..b5beb33c95ba 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2329,7 +2329,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
 				     "cannot get svs reset control\n");
 
-	dev = svs_add_device_link(svsp, "lvts");
+	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get lvts device\n");
@@ -2362,7 +2362,7 @@ static int svs_mt8186_platform_probe(struct svs_platform *svsp)
 		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
 				     "cannot get svs reset control\n");
 
-	dev = svs_add_device_link(svsp, "lvts");
+	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get lvts device\n");
@@ -2401,7 +2401,7 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 	struct svs_bank *svsb;
 	u32 idx;
 
-	dev = svs_add_device_link(svsp, "thermal");
+	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get thermal device\n");
-- 
2.42.0

