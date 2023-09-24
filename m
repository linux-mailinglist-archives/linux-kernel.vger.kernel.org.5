Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A240D7ACB98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjIXT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIXT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFBBF1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b275afb6abso281653866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583575; x=1696188375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GGwz4wHTU6Hq3RRU7lNI3Q1wc2dl9iWY5fWoPCz14w=;
        b=d9HexRLBkVxBtbwzgZFtb19Hr36iAPGUwUG5HSIN5SlAkrgcPnAfsdAiMtsJwD3597
         C4AjA5IeF1pvn0iyT7xpXCAalB1FDg6HgzwEXhux3Dd56n1iCC59oUHMeEGdhEge6YXU
         eM/WYxrbqLwYmiZ15qc8K667xwdciLl1BZ9oIieumOF04RHDGc/Cede6oI1liLsx5XaK
         DSj7ZzurnqFSmVMQ472sHj9AnUaVeacC52eBSeQVAYuWq2SHYkX3Cv9qgNML4OIoBYgE
         AycjDMWHu6uehLhoroaBUcVDWFIUTFC4ZKkipgAUJ+CWuFGyCH7mB6lnjc5PPME7Lh8I
         iVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583575; x=1696188375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GGwz4wHTU6Hq3RRU7lNI3Q1wc2dl9iWY5fWoPCz14w=;
        b=RYu/d4yxi/FFfXn3KZHtUe6tCypxlBJmPCZX8CekhvjCMFlj4ZnktxLONewRbcJIzz
         fbsHbpZvAgAm1I3A8p7noEF8Y/drlitoa2i3CI/2mhdjJ7GJ3rP7d3iyn1qNTz1nsmMs
         UA8g8vBAyUFExgwb9Da29tR0pB3YQ+3L9jkFlnha7v2qcqgNOhmoLVi6r+7Hja3dsdRG
         6elVZGWbY2imNZkA/F9O4/XFuHm1mbt3RDRyitNklp+PBTcekp094EHpsQSmkdMfjjXz
         vtJliV5jGhXxWoniY9IgRqBSln1zquYuO95Bsu4iIa5oqiBWGtkMLzLpFeGJgsaOSWGx
         VtKA==
X-Gm-Message-State: AOJu0Yw9WNL+u+IooDaA2ON8dOU9N7HNX89Scu8Zgm6AwPJ8UYLjgGKS
        FCh19gx44AooXTk9VSJEO+o=
X-Google-Smtp-Source: AGHT+IGrm0GcL+bThs+FW6loLKtnsAa0IIh3+UexCsckNUEBFlIPvms+brojuoJoSOy/PrKpwCa8JQ==
X-Received: by 2002:a17:907:ea5:b0:9a1:e0b1:e919 with SMTP id ho37-20020a1709070ea500b009a1e0b1e919mr13414633ejc.4.1695583574659;
        Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/7] drm/sun4i: dw-hdmi: Remove double encoder cleanup
Date:   Sun, 24 Sep 2023 21:25:59 +0200
Message-ID: <20230924192604.3262187-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that comment is wrong - dw hdmi driver never does any
encoder cleanup. In fact, cleanup is done automatically, in destroy
callback of encoder. Even more, encoder memory will be freed when hdmi
device is destroyed. However, encoder will be cleaned up after that, in
drm_mode_config_cleanup(), which is called later. This will cause use
after free bug.

Remove redundant encoder cleanup, switch memory allocation to live as
long as drm object and while at it, check return code of encoder
initialization.

Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 0b647b030b15..8f8d3bdba5ce 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_of.h>
 #include <drm/drm_simple_kms_helper.h>
@@ -107,7 +108,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
+	hdmi = drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
@@ -180,7 +181,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 
 	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	if (ret)
+		goto err_deinit_phy;
 
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;
@@ -189,20 +192,14 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	platform_set_drvdata(pdev, hdmi);
 
 	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
-
-	/*
-	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
-	 * which would have called the encoder cleanup.  Do it manually.
-	 */
 	if (IS_ERR(hdmi->hdmi)) {
 		ret = PTR_ERR(hdmi->hdmi);
-		goto cleanup_encoder;
+		goto err_deinit_phy;
 	}
 
 	return 0;
 
-cleanup_encoder:
-	drm_encoder_cleanup(encoder);
+err_deinit_phy:
 	sun8i_hdmi_phy_deinit(hdmi->phy);
 err_disable_clk_tmds:
 	clk_disable_unprepare(hdmi->clk_tmds);
-- 
2.42.0

