Return-Path: <linux-kernel+bounces-9972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84481CE03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01949285F01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95214381CF;
	Fri, 22 Dec 2023 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sve8O9Kl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651541740;
	Fri, 22 Dec 2023 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336746a545fso1256686f8f.0;
        Fri, 22 Dec 2023 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266958; x=1703871758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuPa/UCZ+S+tpMXY2+ZSGIMlsWF9xT2DWjDbU4B7UZI=;
        b=Sve8O9Kl1AxBAf+S33RJOOmXK4QuNDROQYUVtamTi7ETSSu8bBoLc6rzsCB77DYTxq
         RYVIazZaazud7nsZ3zcvwDU8U96dU5TL8o3ZFy38Xm3FhtCRO+yKWeJkB/QU//TBAMJ3
         HEp1eZ1EEyLsQgSUOZscRoRRn6BfZ2tfHiTrEQls3bt3iD+Igak/ulOG//dH9x6pqJqX
         0QOe4IfOMKFR9gh88w9Wemcrh9T1u9dq3LlSBHHbWQaCqhAjvl4mQS1n+kJ4qrrd19v3
         2BJbs0BArmb6EMyYQ7k0FwO0ToKFXG0lDd/JR17hIGOQQcqmkl3DyuCvhpXlDrcqnAof
         CyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266958; x=1703871758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuPa/UCZ+S+tpMXY2+ZSGIMlsWF9xT2DWjDbU4B7UZI=;
        b=VYaecsPKs27vZiH+ftJXYzWftb7A/+8qp2RVdZ4id+p5bTImlS12KXthEyNMcPDYAK
         3GogjP4Fz4WRpvydAG3M9qgSB/bJZngD99r+XRVehZ+Z90ZSgQOyupcV56F1Q7e32uPw
         rqB3F95hADuYsu+pzRHuXo+E8/cQER3sSgBZFCcnWDEHBgVCFiydBq8DqNmiyygX/Pfj
         PgYWl/NmKVn2z71FMDQ+5/Jv1FEk7sGLhAZ5SqVe7ZrT4t6Ba2eSiPZWgPdfDAgpoL/z
         waeEdeGlmztq8gXOlqwtld+uy719mCSiOXIr9IUh5z4+qx6hoR6mRSKXjvx5VmFa2mF8
         Ed2Q==
X-Gm-Message-State: AOJu0YzzMjvdFXLgcGAPPSTyYedV60yW8pUc3MvGDQu8xhZVluLzMP/b
	sHwgBgoIbg5MSP8vxBFQiQ==
X-Google-Smtp-Source: AGHT+IEjk2JX3cryTNZLnr1na63oKaFCjP2+oPseqP9/67kTJYx/j+qLJatXCAdYf2yZBPppd7BLkQ==
X-Received: by 2002:a05:6000:1c9:b0:336:6dd3:bfd3 with SMTP id t9-20020a05600001c900b003366dd3bfd3mr1061282wrx.37.1703266958541;
        Fri, 22 Dec 2023 09:42:38 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.37
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
Subject: [PATCH v4 23/29] drm/rockchip: inno_hdmi: Add variant support
Date: Fri, 22 Dec 2023 18:42:14 +0100
Message-ID: <20231222174220.55249-24-knaerzche@gmail.com>
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

In preparation to support RK3128's integration of the controller, this
patch adds a simple variant implementation. They mainly differ in the phy
configuration required, so those are part of the match_data. The values
have been taken from downstream. The pixelclocks in there are meant to be
max-inclusive.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - no changes

changes in v3:
 - adapt to the newly introduced inno_hdmi_power_up / inno_hdmi_standby functions

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 74 ++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 44c311e7e2d3..34f0358e8d7b 100644
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
@@ -113,6 +126,30 @@ static const char coeff_csc[][24] = {
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
@@ -164,12 +201,25 @@ static void inno_hdmi_standby(struct inno_hdmi *hdmi)
 	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
 };
 
-static void inno_hdmi_power_up(struct inno_hdmi *hdmi)
+static void inno_hdmi_power_up(struct inno_hdmi *hdmi,
+			       unsigned long mpixelclock)
 {
+	struct inno_hdmi_phy_config *phy_config;
+	int ret = inno_hdmi_find_phy_config(hdmi, mpixelclock);
+
+	if (ret < 0) {
+		phy_config = hdmi->variant->default_phy_config;
+		DRM_DEV_ERROR(hdmi->dev,
+			      "Using default phy configuration for TMDS rate %lu",
+			      mpixelclock);
+	} else {
+		phy_config = &hdmi->variant->phy_configs[ret];
+	}
+
 	inno_hdmi_sys_power(hdmi, false);
 
-	hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x6f);
-	hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0xbb);
+	hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, phy_config->pre_emphasis);
+	hdmi_writeb(hdmi, HDMI_PHY_DRIVER, phy_config->voltage_level_control);
 	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
 	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x14);
 	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x10);
@@ -406,6 +456,7 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 			   struct drm_display_mode *mode)
 {
 	struct drm_display_info *display = &hdmi->connector.display_info;
+	unsigned long mpixelclock = mode->clock * 1000;
 
 	/* Mute video and audio output */
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
@@ -428,13 +479,13 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	 * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
 	 * clock rate, and reconfigure the DDC clock.
 	 */
-	inno_hdmi_i2c_init(hdmi, mode->clock * 1000);
+	inno_hdmi_i2c_init(hdmi, mpixelclock);
 
 	/* Unmute video and audio output */
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
 		  v_AUDIO_MUTE(0) | v_VIDEO_MUTE(0));
 
-	inno_hdmi_power_up(hdmi);
+	inno_hdmi_power_up(hdmi, mpixelclock);
 
 	return 0;
 }
@@ -827,6 +878,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
 	struct inno_hdmi *hdmi;
+	const struct inno_hdmi_variant *variant;
 	int irq;
 	int ret;
 
@@ -836,6 +888,12 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 
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
@@ -929,8 +987,14 @@ static void inno_hdmi_remove(struct platform_device *pdev)
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


