Return-Path: <linux-kernel+bounces-2269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C19F815A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EB2285DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DF3DBA0;
	Sat, 16 Dec 2023 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/pwDwu1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B23A8E4;
	Sat, 16 Dec 2023 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c31f18274so20681285e9.0;
        Sat, 16 Dec 2023 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744041; x=1703348841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQiEPu38i3aFFXbXmZDuj9Z5I3dO6tjlHXJ/GQ5qAv8=;
        b=Y/pwDwu1SWujJS+mfrve8neCtZsuD4WmJyhhphEWSD/s3C6RcBe0nLFXBo7QrVAhQ5
         kbi85GwxW6KDY0NDl5VfCGWnc8t/UNB9Edzqu1+J+gAOjQQ4YGO6Vnn5Zc9FiZdsV69z
         rU84Z51GYweEidt5wP7HJkciwmQHfAVu5DrVQBBtgbjpVQKWDz/p3LFcQ9LBmQolAivv
         sL396AGUqQoHQOja9VRtS1QCB18lzS+YU+NZQugrhPbIAWCKxGaSygAKJUF1SGJusOHx
         OFwPS5PX15ReAHNSbsapEAlkpJmbg90K9fXuiPgW5nUyKFVvxHpL2uZSt+p+s8qURyWz
         nBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744041; x=1703348841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQiEPu38i3aFFXbXmZDuj9Z5I3dO6tjlHXJ/GQ5qAv8=;
        b=Y4M1gKLmw+P05c+iTlYgViibFuBIVGmiG23NfTsYGuTKurpqCuwA6xhkoYyFd4Pk8l
         2l+aiI8+UyAKMJE+eEBlBLCrsBnloi1elXh5UtJl+WPxHrIi16wbTUZwiEW0k5IWJWam
         R1cm1SbJEwn6UJkxSpdkmdqtTx2SjU2YfxP2wyuFxM8EL1JHFWJzVkQcGKOUcPkPfik0
         mK6eiKwc6DAWnWfrrz5aC3LVv2GmQ4QqrYAyKC/WI16Do0WpMXrjBhkckCH4U9X5pPMs
         Gseu9DK2/7YSOgOB55nCaTem4q2MUWeo1luLs1Gcj1k+yGKztawOJu8/HPJFr8iyD2Xw
         5k+w==
X-Gm-Message-State: AOJu0YzdT0TadIHxLdABXDpV5KWzLNKjU9PkV+8xX11k/m/Xh2xuMGmH
	QHmK7Y3miPZ9z9C3/lsRZg==
X-Google-Smtp-Source: AGHT+IGQCWmeafdHQEypddGMm/p+SelPFJgQl85DV9NvkhBX+hUyEJqHE51Oq1RSeni9fFl9ZjpDOw==
X-Received: by 2002:a05:600c:524e:b0:40c:18e9:d610 with SMTP id fc14-20020a05600c524e00b0040c18e9d610mr6278994wmb.71.1702744040982;
        Sat, 16 Dec 2023 08:27:20 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:20 -0800 (PST)
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
Subject: [PATCH v2 21/27] drm/rockchip: inno_hdmi: Add variant support
Date: Sat, 16 Dec 2023 17:26:32 +0100
Message-ID: <20231216162639.125215-22-knaerzche@gmail.com>
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

In preparation to support RK3128's integration of the controller, this
patch adds a simple variant implementation. They mainly differ in the phy
configuration required, so those are part of the match_data. The values
have been taken from downstream. The pixelclocks in there are meant to be
max-inclusive.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes
 
 drivers/gpu/drm/rockchip/inno_hdmi.c | 69 +++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 9f27a5faf12d..579baba6a61b 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -26,6 +26,17 @@
 
 #include "inno_hdmi.h"
 
+struct inno_hdmi_phy_config {
+	unsigned long pixelclock;
+	u8 pre_emphasis;
+	u8 voltage_level_control;
+};
+
+struct inno_hdmi_variant {
+	struct inno_hdmi_phy_config *phy_configs;
+	struct inno_hdmi_phy_config *default_phy_config;
+};
+
 struct inno_hdmi_i2c {
 	struct i2c_adapter adap;
 
@@ -47,6 +58,8 @@ struct inno_hdmi {
 
 	struct inno_hdmi_i2c *i2c;
 	struct i2c_adapter *ddc;
+
+	const struct inno_hdmi_variant *variant;
 };
 
 struct inno_hdmi_connector_state {
@@ -114,6 +127,30 @@ static const char coeff_csc[][24] = {
 	},
 };
 
+static struct inno_hdmi_phy_config rk3036_hdmi_phy_configs[] = {
+	{  74250000, 0x3f, 0xbb },
+	{ 165000000, 0x6f, 0xbb },
+	{      ~0UL, 0x00, 0x00 }
+};
+
+static int inno_hdmi_find_phy_config(struct inno_hdmi *hdmi,
+				     unsigned long pixelclk)
+{
+	const struct inno_hdmi_phy_config *phy_configs =
+						hdmi->variant->phy_configs;
+	int i;
+
+	for (i = 0; phy_configs[i].pixelclock != ~0UL; i++) {
+		if (pixelclk <= phy_configs[i].pixelclock)
+			return i;
+	}
+
+	DRM_DEV_DEBUG(hdmi->dev, "No phy configuration for pixelclock %lu\n",
+		      pixelclk);
+
+	return -EINVAL;
+}
+
 static inline u8 hdmi_readb(struct inno_hdmi *hdmi, u16 offset)
 {
 	return readl_relaxed(hdmi->regs + (offset) * 0x04);
@@ -179,12 +216,26 @@ static void inno_hdmi_sys_power(struct inno_hdmi *hdmi, bool enable)
 
 static void inno_hdmi_set_pwr_mode(struct inno_hdmi *hdmi, int mode)
 {
+	struct inno_hdmi_phy_config *phy_config;
+	int ret;
+	unsigned long tmds_rate;
+
 	switch (mode) {
 	case NORMAL:
 		inno_hdmi_sys_power(hdmi, false);
+		tmds_rate = inno_hdmi_tmds_rate(hdmi);
+		ret = inno_hdmi_find_phy_config(hdmi, tmds_rate);
+		if (ret < 0) {
+			phy_config = hdmi->variant->default_phy_config;
+			DRM_DEV_ERROR(hdmi->dev,
+				      "Using default phy configuration for TMDS rate %lu",
+				      tmds_rate);
+		} else {
+			phy_config = &hdmi->variant->phy_configs[ret];
+		}
 
-		hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x6f);
-		hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0xbb);
+		hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, phy_config->pre_emphasis);
+		hdmi_writeb(hdmi, HDMI_PHY_DRIVER, phy_config->voltage_level_control);
 
 		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
 		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x14);
@@ -827,6 +878,8 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
 	struct inno_hdmi *hdmi;
+	const struct inno_hdmi_variant *variant;
+
 	int irq;
 	int ret;
 
@@ -836,6 +889,12 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 
 	hdmi->dev = dev;
 
+	variant = of_device_get_match_data(hdmi->dev);
+	if (!variant)
+		return -EINVAL;
+
+	hdmi->variant = variant;
+
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
 		return PTR_ERR(hdmi->regs);
@@ -923,8 +982,14 @@ static void inno_hdmi_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &inno_hdmi_ops);
 }
 
+static const struct inno_hdmi_variant rk3036_inno_hdmi_variant = {
+	.phy_configs = rk3036_hdmi_phy_configs,
+	.default_phy_config = &rk3036_hdmi_phy_configs[1],
+};
+
 static const struct of_device_id inno_hdmi_dt_ids[] = {
 	{ .compatible = "rockchip,rk3036-inno-hdmi",
+	  .data = &rk3036_inno_hdmi_variant,
 	},
 	{},
 };
-- 
2.43.0


