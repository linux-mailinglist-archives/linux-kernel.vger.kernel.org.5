Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6F76FB30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjHDHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjHDH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:29:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129423AB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:29:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D8D766071C2;
        Fri,  4 Aug 2023 08:29:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691134150;
        bh=eOGxKFVDezkCZBwW2hUee7R5nYDwDHZk82jsXyRXIgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cB9BjZ+Uh0lMovSOzN0a/Ugu0u79UdFA39R9jOkGWpsGAIuE/yvVPkSaK9yGjcD1A
         atqx7Bn/kZGL3XX2lgxbpyhURUD4/G2snCvNmr3pdr0EXiKC3UFNVQo9+jtvZvi3pd
         BNZDHv3q9fSSm/Q7r97fR/tmZN0xbjxL59PpWye9XAcVASV28skJwuhd/xv2hftjpA
         zj90iUOorcQrN+C3ygC7ChzInMNnuznvohNKXV7RqxZivGFYmKuuahD6ZX+irw0VL7
         BN1kawNtm1oeJC1xd1EkeUde0ybauzjNS6iq5jhYwkorvdjp8/UvWmzxFQ6c1TB5TB
         rE/jinzzjd+Ag==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v10 16/16] drm/mediatek: aal: Compress of_device_id entries and add sentinel
Date:   Fri,  4 Aug 2023 09:28:50 +0200
Message-ID: <20230804072850.89365-17-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

