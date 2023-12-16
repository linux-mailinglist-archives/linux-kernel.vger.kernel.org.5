Return-Path: <linux-kernel+bounces-2270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A531A815A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293DCB253EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC53FB08;
	Sat, 16 Dec 2023 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY/RmLFO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD83C487;
	Sat, 16 Dec 2023 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c6e2a47f6so13693595e9.0;
        Sat, 16 Dec 2023 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744041; x=1703348841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFps/f+CAs2Nk6z2SsJd+Q0Norbs9x1sCDtq35o8jMc=;
        b=YY/RmLFOGakkb7BP+E3CEnrzuRGnqDL1QzDYS6OAzpad1MPRYJ+YkP/feS9LnzHkMZ
         Zb4a+1n9CU6TphEDQM9tgpfZ5LC7umgIZ2KyywkDteqKSIfJFStIsOkQWxDbvSlPcLGK
         3P+T/KCYBUSoDu+2pDI8astw1wa2oM5igk9Ma8JFUH8FyFGjbRn0w4JsUutcfTkG4wEt
         3ZI0JwmJOGlAfGkrqoAM4AlZlEntAdVHS727w5peEXZ83YTMyHB+pW6vn01oj6EWnalP
         Zhz7bgsgi8PGmKKnbbplF0fabGf9fmGGN3StWf7gZWQB9E5FHjsbzNJGrKPuj6qA5Nc8
         wErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744041; x=1703348841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFps/f+CAs2Nk6z2SsJd+Q0Norbs9x1sCDtq35o8jMc=;
        b=RY2srUuwapDJKaRHEQ5wdMzTveF4GjRubJzjFVr8VV/x/r54Zs2CGhRNKMrsFRmf8H
         7zPxoCyyFjmkzu3UydxSO3GvheLB8QnXCdA77mbta0t6NLlrWi6lnGJOcHjCDLYqjynY
         RmcvSnIaCxfQjgsNziMzA5Q0NRGJXo7Tfw6Q3ytFYij8yHA9jA8FOQToe9HDSTfec6Sw
         2i+kpXa/43tu+ECYiq35vckn88Mm90kUkfJqpUXN9/poZRwMXl0WjD1Ms2bgc8F4je3Y
         CcyZkROiyczK6itKgaJKhh9kWXsXCD6gFOZMv7jsFqLGaqIKXVRiG8C8ovqLtjG21AJf
         6Nzw==
X-Gm-Message-State: AOJu0YwMwRKDsuhDq1hmRK1q7wQ6sDMHW87Pb7cL2CMeRyJ6SdMBuDDL
	fM+8imcc2O8fJIcP25o4xw==
X-Google-Smtp-Source: AGHT+IGBF4gaRoU/EL0I7tI8RwIyRSfbuxuXO3TR0CaxGjhOjNNy6BcBWFK0VOilT5H96GBjjIme0g==
X-Received: by 2002:a05:600c:3d10:b0:40c:dda4:3582 with SMTP id bh16-20020a05600c3d1000b0040cdda43582mr264470wmb.314.1702744041618;
        Sat, 16 Dec 2023 08:27:21 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:21 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 22/27] drm/rockchip: inno_hdmi: Add RK3128 support
Date: Sat, 16 Dec 2023 17:26:33 +0100
Message-ID: <20231216162639.125215-23-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
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

 drivers/gpu/drm/rockchip/inno_hdmi.c | 46 +++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 579baba6a61b..792e5fad09bf 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -51,6 +51,7 @@ struct inno_hdmi {
 	struct device *dev;
 
 	struct clk *pclk;
+	struct clk *refclk;
 	void __iomem *regs;
 
 	struct drm_connector	connector;
@@ -133,6 +134,12 @@ static struct inno_hdmi_phy_config rk3036_hdmi_phy_configs[] = {
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
@@ -182,13 +189,17 @@ static unsigned long inno_hdmi_tmds_rate(struct inno_hdmi *hdmi)
 	}
 
 	/*
-	 * When IP controller haven't configured to an accurate video
-	 * timing, then the TMDS clock source would be switched to
-	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
-	 * and reconfigure the DDC clock.
+	 * When IP controller isn't configured to an accurate
+	 * video timing and there is no reference clock available,
+	 * then the TMDS clock source would be switched to PCLK_HDMI,
+	 * so we need to init the TMDS rate to PCLK rate, and
+	 * reconfigure the DDC clock.
 	 */
 
-	return clk_get_rate(hdmi->pclk);
+	if (hdmi->refclk)
+		return clk_get_rate(hdmi->refclk);
+	else
+		return clk_get_rate(hdmi->pclk);
 }
 
 static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi)
@@ -912,6 +923,20 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
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
@@ -951,6 +976,8 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 err_put_adapter:
 	i2c_put_adapter(hdmi->ddc);
 err_disable_clk:
+	clk_disable_unprepare(hdmi->refclk);
+err_disable_pclk:
 	clk_disable_unprepare(hdmi->pclk);
 	return ret;
 }
@@ -964,6 +991,7 @@ static void inno_hdmi_unbind(struct device *dev, struct device *master,
 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
 
 	i2c_put_adapter(hdmi->ddc);
+	clk_disable_unprepare(hdmi->refclk);
 	clk_disable_unprepare(hdmi->pclk);
 }
 
@@ -987,10 +1015,18 @@ static const struct inno_hdmi_variant rk3036_inno_hdmi_variant = {
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


