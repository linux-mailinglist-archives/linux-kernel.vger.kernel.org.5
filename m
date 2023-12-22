Return-Path: <linux-kernel+bounces-9973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3DB81CE06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE36B1C22672
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900A4BA95;
	Fri, 22 Dec 2023 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR7K5+E7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1A446C3;
	Fri, 22 Dec 2023 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3367903b4dcso1994251f8f.1;
        Fri, 22 Dec 2023 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266959; x=1703871759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRDLrc4Pqc9q8YV3BNYLNdW1nNQ91cRb/kLeFqZo5Z4=;
        b=LR7K5+E7qWUu6IM23FVY2fu583rdm10wZUP14OqI0o+AZ+Sw6hiruj3KCqof+EaktR
         6f2mbOj1fKGvKWPLG6piOTf6jbAjdjVA8fkIHVDnxL4COKYZWX9asv25WsCc03/T+P64
         Yt6MKyESi/pmAZjk1qMn0YRPxPFYtI9Tqvnj+7+lTB1UYIC6QA56WmspbAwVnGkOlmmJ
         hHHJH/YqURYW3gOYKCnvwJ7tnYlRjMmMABT/2IXtknmz3/AITNGi6HHIbNL3UuFhrcFd
         UIkpkZ/D428ohsKaUfPMXFaDTULlSt0p2alr79Z8+6NTUjGRB71jY+r3hud/J+UmEttE
         DbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266959; x=1703871759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRDLrc4Pqc9q8YV3BNYLNdW1nNQ91cRb/kLeFqZo5Z4=;
        b=k5jbc6OcOpMZFxOgscxInIxymePvahcqTY8osu+oMyyhnzYhkGeAgbzfio4FKkA5SK
         mtZw3pvosHPD5bqq5V+9fvCA1EIsYdhMOYBCthXbVgmKe5Er3cj2SMx2fSQQQgciC+BQ
         rxo7G+3PjimMztKvvSc9wYpywoQFGP6sQfPz3buvoQmaLrC7oIPlRdPec1jN23VAo7Ag
         p1iX6mGU7ZQoQMrFoKGsUHXDdGhe2pCdF2F0rexau+ueM7N1C3JpGn+TkpidL98mv8aE
         oY5PXxduLGh9Q7XDiJN69AGbce9OcHCU9MbnanmxpbaJRSTfoJA92oZTwDzm6wW5ojx0
         vIfw==
X-Gm-Message-State: AOJu0YyR2IYDuke2UQfZmg5Am6+awDKtKTw/GsngWtIHSgpKxh0pmGnw
	MJZH3/+ZDuY4zzsTa5VqPg==
X-Google-Smtp-Source: AGHT+IE2+DqN7baMUSo6d5TvP8kuW5Y4xLA/e6OLwP2k9pd79ImZ8Ug8T4zNqmw73cYCUbKdboHsaA==
X-Received: by 2002:a5d:66c6:0:b0:336:7a37:27ed with SMTP id k6-20020a5d66c6000000b003367a3727edmr931646wrw.20.1703266959411;
        Fri, 22 Dec 2023 09:42:39 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:38 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 24/29] drm/rockchip: inno_hdmi: Add RK3128 support
Date: Fri, 22 Dec 2023 18:42:15 +0100
Message-ID: <20231222174220.55249-25-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variant requires the phy reference clock to be enabled before the DDC
block can work and the (initial) DDC bus frequency is calculated based on
the rate of this clock. Besides the only difference is phy configuration
required to make the driver working for this variant as well.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

changes in v3:
 - no changes

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 46 +++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 34f0358e8d7b..3b76929deefe 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -51,6 +51,7 @@ struct inno_hdmi {
 	struct device *dev;
 
 	struct clk *pclk;
+	struct clk *refclk;
 	void __iomem *regs;
 
 	struct drm_connector	connector;
@@ -132,6 +133,12 @@ static struct inno_hdmi_phy_config rk3036_hdmi_phy_configs[] = {
 	{      ~0UL, 0x00, 0x00 }
 };
 
+static struct inno_hdmi_phy_config rk3128_hdmi_phy_configs[] = {
+	{  74250000, 0x3f, 0xaa },
+	{ 165000000, 0x5f, 0xaa },
+	{      ~0UL, 0x00, 0x00 }
+};
+
 static int inno_hdmi_find_phy_config(struct inno_hdmi *hdmi,
 				     unsigned long pixelclk)
 {
@@ -911,6 +918,20 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	hdmi->refclk = devm_clk_get_optional(hdmi->dev, "ref");
+	if (IS_ERR(hdmi->refclk)) {
+		DRM_DEV_ERROR(hdmi->dev, "Unable to get HDMI reference clock\n");
+		ret = PTR_ERR(hdmi->refclk);
+		goto err_disable_pclk;
+	}
+
+	ret = clk_prepare_enable(hdmi->refclk);
+	if (ret) {
+		DRM_DEV_ERROR(hdmi->dev,
+			      "Cannot enable HDMI reference clock: %d\n", ret);
+		goto err_disable_pclk;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
@@ -927,12 +948,16 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	/*
-	 * When IP controller haven't configured to an accurate video
-	 * timing, then the TMDS clock source would be switched to
-	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
-	 * and reconfigure the DDC clock.
+	 * When the controller isn't configured to an accurate
+	 * video timing and there is no reference clock available,
+	 * then the TMDS clock source would be switched to PCLK_HDMI,
+	 * so we need to init the TMDS rate to PCLK rate, and
+	 * reconfigure the DDC clock.
 	 */
-	inno_hdmi_i2c_init(hdmi, clk_get_rate(hdmi->pclk));
+	if (hdmi->refclk)
+		inno_hdmi_i2c_init(hdmi, clk_get_rate(hdmi->refclk));
+	else
+		inno_hdmi_i2c_init(hdmi, clk_get_rate(hdmi->pclk));
 
 	ret = inno_hdmi_register(drm, hdmi);
 	if (ret)
@@ -956,6 +981,8 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 err_put_adapter:
 	i2c_put_adapter(hdmi->ddc);
 err_disable_clk:
+	clk_disable_unprepare(hdmi->refclk);
+err_disable_pclk:
 	clk_disable_unprepare(hdmi->pclk);
 	return ret;
 }
@@ -969,6 +996,7 @@ static void inno_hdmi_unbind(struct device *dev, struct device *master,
 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
 
 	i2c_put_adapter(hdmi->ddc);
+	clk_disable_unprepare(hdmi->refclk);
 	clk_disable_unprepare(hdmi->pclk);
 }
 
@@ -992,10 +1020,18 @@ static const struct inno_hdmi_variant rk3036_inno_hdmi_variant = {
 	.default_phy_config = &rk3036_hdmi_phy_configs[1],
 };
 
+static const struct inno_hdmi_variant rk3128_inno_hdmi_variant = {
+	.phy_configs = rk3128_hdmi_phy_configs,
+	.default_phy_config = &rk3128_hdmi_phy_configs[1],
+};
+
 static const struct of_device_id inno_hdmi_dt_ids[] = {
 	{ .compatible = "rockchip,rk3036-inno-hdmi",
 	  .data = &rk3036_inno_hdmi_variant,
 	},
+	{ .compatible = "rockchip,rk3128-inno-hdmi",
+	  .data = &rk3128_inno_hdmi_variant,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, inno_hdmi_dt_ids);
-- 
2.43.0


