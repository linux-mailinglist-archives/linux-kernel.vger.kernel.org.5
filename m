Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1B76C8BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjHBIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHBIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:52:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4A101
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:52:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso60797005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690966352; x=1691571152;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wsrvVf1Tq2vaUhYtAT2JkjgDSEB22fZNeeTE0a5xSU=;
        b=IVOBTjzguAcA8nzoBa7REcOzJwvUR/3BndO0bPmLQRkwUFH4N3RsPRbfz6wGzY8mX/
         vT11GLqVCGmMrD4TewyaQm6InaYrjTG+NV7nnFiPgetuYQYqmKDafmNfd5Kyt7S+N9RY
         ym8em805p4ceawjLf1PRU1ox5Za/b7VP5iemiHUYFC9m+GHCV9YBFZzL3NiwVD9/ulbQ
         +XzmqlwlmOHi8eDo8BLneVJ6VVwOOdmR5ksuIvntNfEgaWQoc6A3fQcv4asPbn5wJGl0
         xFoTZ3ivECi9+kPDKKftXzkzX+BCKFLmJH0HymQZanARtu4ItLCgutNnh/us46DDWhde
         JGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690966352; x=1691571152;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wsrvVf1Tq2vaUhYtAT2JkjgDSEB22fZNeeTE0a5xSU=;
        b=hUv0UdMolMW9LzMjZIbLo9iGVcs/fAFaV5NnaFNCUQwSVZeqDcXobcPHKS+m1w4Lp4
         L6Q97VMQQ8TEavRbdYMyn5b5uG9rJ/xSYWJBB5go/LbpDK4LSRKgIjp9Qep5RXq6q1Y2
         3uKMKKI4rjxq6k58J/cBHodSp6TBDJEJJIB+oym/heXSvmMMwbC9vcXNHcYFINLSrkyd
         ++1eAadk1LmaCM3tNUWHpdGGy7+RrvO9z7e47gDewsg0C4J4Lz2UCgUVrsM7Dx8FDQDp
         tn8N1OapU3ajqVfp0OqlXFRB4x8HoF0rECp6KCnv8o3PTDX0F73lq+276nI7MMY/0Hk7
         RK5A==
X-Gm-Message-State: ABy/qLbTFQA24viE/h8el3lFrdBbR4UZi57r+94nvNMY3zw9enZhy7Mf
        UlwJyDtomczYMMAlKw+cC7+piA==
X-Google-Smtp-Source: APBJJlFBrp0L1ElAj3/o+Jo3C6rZJBSvJPabmqO9SI7o9s+MUcvicTG8Z9gr1Gc4Ww2MLgt4RhW52g==
X-Received: by 2002:a05:600c:2159:b0:3fe:1f93:8cf4 with SMTP id v25-20020a05600c215900b003fe1f938cf4mr4223087wml.8.1690966351956;
        Wed, 02 Aug 2023 01:52:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x4-20020a1c7c04000000b003fa973e6612sm1094035wmc.44.2023.08.02.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:52:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 02 Aug 2023 10:52:22 +0200
Subject: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEUZymQC/x2NwQrDIBBEfyXsuQtqSgn9ldKDJmOUgsoqJRDy7
 116mMNjHjMndUhGp+d0kuCbe65Fwd4mWpMvOzhvyuSMm81iHKsEGbxVLnXwjgLxA5xi4xQ03TO
 0aH79YPAjmrsLNvjFzqSbTRDz8f97va/rBwbXaYZ/AAAA
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=e9tUV/g8uW3iJGQla2yximmXQmIZ4VqzDUhHU5HlWnQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkyhlOPAxfJvCKRFgFs7eo6UzvGsJ/l1XX6BklteG9
 88m6BGyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMoZTgAKCRB33NvayMhJ0cmAD/
 4xEICh1qTqtu2jreftXCG4HpmJWmOW9vxu5esdTN960Zi4rZDQnO3dTtJn/JQz88MItdN1NsICzWiq
 oUBBHD/ZYREyV1+oGOCmRxkkJ7n4SgB+GW1euwJeLsnxUXOWOPwiton1GHVm0vLZ80wmMMdHtdaBXf
 t3fqPdaaLD0XumzBQnXOSnU6IJ31TemVwkFbZIUJ2v9rXtNfnu5Oyd8n6wOVS54cag4Ffi61T9KmVp
 ktX+ET+Ysu87MD1PohBj5ccuANrVpcbLcH7zhStTmMkIX4ml4ipkEIU+mVuQirjjitt6ALXay+CoIz
 CsBvo/P5Neb8f3AlzSFMUxCRli4b51geO36qb2P3ETWLElTTwsTAljJ6Mhr4ToDb4xohxc2TphiA1K
 pClXYCQdb0F4cS6ce141ZRL/parRNNGUJnZAS2xlHEzRWNwYKm6YxMkZxO7QUa6JVF7Elr9s5ephD4
 9gx8q1bDXV3V9a7bosSOtyvxAtWXAIxaYliGDYJlFBUYy0SVqnR+uebZtppw9K6G5tMG5XtqntZ0lS
 8FTQxKb8TwC66ZvQJccqFTiv3Lx2HIFFXCiT33CDxwyeoKmEfU9G5RGuOW79tjMX9dYA0UAuzOXi6a
 oQdFtZ8Gth6/03IUD97/e/nC9v6oIQQmjceqDQDv1bu6nndW76cUj3mFhZoA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit [1] to fix display regression on the Dragonboard 845c
(SDM845) devboard.

There's a mismatch on the real action of the following flags:
- MIPI_DSI_MODE_VIDEO_NO_HSA
- MIPI_DSI_MODE_VIDEO_NO_HFP
- MIPI_DSI_MODE_VIDEO_NO_HBP
which leads to a non-working display on qcom platforms.

[1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")

Cc: Marek Vasut <marex@denx.de>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Link: https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 5163e5224aad..9663601ce098 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -774,9 +774,7 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
-			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
-			  MIPI_DSI_MODE_NO_EOT_PACKET;
+			  MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {

---
base-commit: f590814603bf2dd8620584b7d59ae94d7c186c69
change-id: 20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-6f042b1ba813

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

