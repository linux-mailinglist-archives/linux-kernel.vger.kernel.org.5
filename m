Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E857ACB9F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjIXT0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIXT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A86FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso617119166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583578; x=1696188378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyCnYDXrBkQd8nc6ex8m6+Z4ml6K8C/rEJGtjuolnss=;
        b=fHpG8akxhmY77VFnHBNbfLnd9u2v2e/CMjc0niDznwayVL29ZYQSJtVA/FRgzdobbH
         ES1h2lGHUrxvK9CkT7AhoLVAcJyDR/uLf8ocvztUJkai9OdKOjO6KEz8O3ZHTwuQw7Zb
         exWb+cW8v9IkMc60i0hGvxc+OH/HiF1+zrDewF2wMJVDs1TJ2WaL98FX35i9GMDTuSNU
         nCjW9l4FQfcU52rx79gtSdKKjmOPWYA3HLr8h8N8hfLAXEqiMr38YiIDekmdqMcITERB
         Jn6Q8DtTY7HAPP3LhcYQBVHZ0Kmmmfkv3RZMoFLTgjtMX1Hw393NGM7ifPs9AMbIcldm
         hlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583578; x=1696188378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyCnYDXrBkQd8nc6ex8m6+Z4ml6K8C/rEJGtjuolnss=;
        b=j5l12WID5/avS/AcmNXWntqIcA7d3v+lupKbVqTCJzldjHuqkk1pEbCp5/lYcNKRos
         YlSoXcctQdAbxmEs4ASulVuNAS/GmGvO6cLwWhkLKtPuFtJ+hxXBsRSL5p74zn8CedaP
         Hn5SvyQq6WJ4mZg+5UkbejpooFCIw3BZcANiGDycgXqa3SgytuGVCT7HtaazbN+07dvI
         /EKj4BaRj+2B6LY0L63B0upZtkiFIFYB0A6PQLbD/JXwgRPQeq9jpY6cIJ6FOlodZyow
         iH2RrUbWLclyGis9hMHBsB2bjWjgrXTTgQpQBLmakGiKsLZrOWixv5jiziuuoGfXxcdL
         xZIw==
X-Gm-Message-State: AOJu0Ywo2hwR0FWOx5XszvK7+gGv4f71veHNGfaUY6KcsrCXWfSokPxP
        ZnJUZ/+qQ5vDp92m3NNWNbM=
X-Google-Smtp-Source: AGHT+IHCd1BgUV+vVYd3ZH8172gAFJIE1DUEWCbKCJthb4PpjhafqLcGbcOPCGbl9m5xDtLEBPKB7g==
X-Received: by 2002:a17:907:7715:b0:9ae:6a8b:f8aa with SMTP id kw21-20020a170907771500b009ae6a8bf8aamr3983876ejc.26.1695583578522;
        Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 6/7] drm/sun4i: dw-hdmi: Make sun8i_hdmi_phy_get() more intuitive
Date:   Sun, 24 Sep 2023 21:26:03 +0200
Message-ID: <20230924192604.3262187-7-jernej.skrabec@gmail.com>
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

Let's make sun8i_hdmi_phy_get() to behave more like other kernel
functions and return phy pointer instead of setting field in struct.
This also makes function more universal.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  5 +++--
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 10 ++++------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index d93e8ff71aae..41f815a1faec 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -239,10 +239,11 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 	}
 
-	ret = sun8i_hdmi_phy_get(hdmi, phy_node);
+	hdmi->phy = sun8i_hdmi_phy_get(phy_node);
 	of_node_put(phy_node);
-	if (ret) {
+	if (IS_ERR(hdmi->phy)) {
 		dev_err(dev, "Couldn't get the HDMI PHY\n");
+		ret = PTR_ERR(hdmi->phy);
 		goto err_disable_clk_tmds;
 	}
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 21e010deeb48..748b6a4d9cdd 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -200,7 +200,7 @@ encoder_to_sun8i_dw_hdmi(struct drm_encoder *encoder)
 	return container_of(encoder, struct sun8i_dw_hdmi, encoder);
 }
 
-int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node);
+struct sun8i_hdmi_phy *sun8i_hdmi_phy_get(struct device_node *node);
 
 int sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
 void sun8i_hdmi_phy_deinit(struct sun8i_hdmi_phy *phy);
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index f917a979e4a4..1c9bdefed35e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -650,25 +650,23 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{ /* sentinel */ }
 };
 
-int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
+struct sun8i_hdmi_phy *sun8i_hdmi_phy_get(struct device_node *node)
 {
 	struct platform_device *pdev = of_find_device_by_node(node);
 	struct sun8i_hdmi_phy *phy;
 
 	if (!pdev)
-		return -EPROBE_DEFER;
+		return ERR_PTR(-EPROBE_DEFER);
 
 	phy = platform_get_drvdata(pdev);
 	if (!phy) {
 		put_device(&pdev->dev);
-		return -EPROBE_DEFER;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	hdmi->phy = phy;
-
 	put_device(&pdev->dev);
 
-	return 0;
+	return phy;
 }
 
 static int sun8i_hdmi_phy_probe(struct platform_device *pdev)
-- 
2.42.0

