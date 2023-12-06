Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC13807B42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377478AbjLFWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFWSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:18:46 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1E12F;
        Wed,  6 Dec 2023 14:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701901130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IoK/DWTc/F2oNroTlg8YVK4rpr4uwrYEr8RTRWYORG8=;
        b=tO1XerVK4nfhQMK8rp5eGZJq4vHoJocvfCQUy0pDRql5npwiYj+3dwX79SR9l7ObAfrgoh
        ObUWbHQI9xPDv8DKQfdvX4tHgvHiM7dO6/wxlVXg4LGVRuhIZGPhNryoE3fZ7JWb+qZ78i
        apfWXtDUih6gjo9P9Vyclr9MuetwzpM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH RESEND] drm/exynos: dpi: Change connector type to DPI
Date:   Wed,  6 Dec 2023 23:18:41 +0100
Message-ID: <20231206221841.15685-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When exynos_drm_dpi.c was written, DRM_MODE_CONNECTOR_DPI did not exist
yet and I guess that's the reason why DRM_MODE_CONNECTOR_VGA was used as
the connector type.

However, now it makes more sense to use DRM_MODE_CONNECTOR_DPI as the
connector type.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/exynos/exynos_drm_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 378e5381978f..0dc36df6ada3 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -101,7 +101,7 @@ static int exynos_dpi_create_connector(struct drm_encoder *encoder)
 
 	ret = drm_connector_init(encoder->dev, connector,
 				 &exynos_dpi_connector_funcs,
-				 DRM_MODE_CONNECTOR_VGA);
+				 DRM_MODE_CONNECTOR_DPI);
 	if (ret) {
 		DRM_DEV_ERROR(ctx->dev,
 			      "failed to initialize connector with drm\n");
-- 
2.42.0

