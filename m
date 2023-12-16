Return-Path: <linux-kernel+bounces-2267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF398815A59
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C945B25258
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803B3D0A7;
	Sat, 16 Dec 2023 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eunQT72/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51058381B2;
	Sat, 16 Dec 2023 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so1996812a12.2;
        Sat, 16 Dec 2023 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744039; x=1703348839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xquaKm3YPbbfHci/n27FNskS85Fe2FEHpYLHWs9wnrA=;
        b=eunQT72/2oqPu2ddLmo+onfpQsJkJ+S4avC2v9wcjvAYsyllXxZfBaF4qgeojNea+V
         LQQs34MxoKsRJ2VsEtYuCdDRihDf2Nj0M6AQKlq+XWpspGVStDUI5kzCzzaam5DO5p+/
         yttIxUjBd7s1HJ1LbxR8kJPzUuTABJ5O+zadxD7dIsE+R/oNYpFoxjKI+OqnEb/t9BGw
         hSNFYwDeKTO2wx2O/34DkdKdN4Cdz6eAcsHTjdq9J7Y2nUUHNBijJhx7LQUwpHsYvHQD
         0G9u9KHA/LErvBLtehFl0nVdHv6eLDSrAzZueI1Q+jVTFfPgeiYBn7UTQvstuH5D4gjt
         hMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744039; x=1703348839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xquaKm3YPbbfHci/n27FNskS85Fe2FEHpYLHWs9wnrA=;
        b=JMqEa71EEABFS1YanCvigLl6W3SFDM64FHkISUmV6bFsUUj8AEGi9cHTWEDsYWgH0i
         jJpAk02+AS5Qjqms1JPQF6JSBJ9yo1Tf7Q8vj0TmZ+rFlEOpU1Zk7LhZRS10M1WvQn8f
         Rp52sLWms78+iCmIUQueeuxc10TZz7grcphtVz03vQ69XtyrHBMqT6zBWO79dVAy72jL
         zPdp+NR0lB9d+UC1zOROYVxyoUK5Yo+0L5itRFycH82wEhF0bo3NGG/p+vD2VMXPIMyT
         lFU1IxKfNNYcFRq1AgKGon0+EM3i8zL7L19DAX/ohDf3fEi2whkrtxVIK/JJCye7RY1I
         sOrw==
X-Gm-Message-State: AOJu0YwWqiwIgZfbPnmH4yh2kKw8AofO7gzn3DbXV7Pm13T088aknXR3
	A2fc9A+w1M9augoE4u8KVw==
X-Google-Smtp-Source: AGHT+IFUzerbBkuL8ogyxF7tayR3DeWeoAa4xKPEYCPluQhDzstDriEv+K+qp24yTyj3tqDUtQcT3Q==
X-Received: by 2002:a17:906:2c7:b0:a23:2aa7:d48b with SMTP id 7-20020a17090602c700b00a232aa7d48bmr212918ejk.14.1702744039643;
        Sat, 16 Dec 2023 08:27:19 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:19 -0800 (PST)
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
Subject: [PATCH v2 19/27] drm/rockchip: inno_hdmi: Move tmds rate to connector state subclass
Date: Sat, 16 Dec 2023 17:26:30 +0100
Message-ID: <20231216162639.125215-20-knaerzche@gmail.com>
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

Similar to the othter members of inno_hdmi_connector_state the tmds_rate is
not a property of the device, but of the connector state. Move it to
inno_hdmi_connector_state and make it a long to comply with the clock
framework. To get arround the issue of not having the connector state when
inno_hdmi_i2c_init is called in the bind path, getting the tmds rate is
wrapped in function which returns the fallback rate if the connector
doesn't have a state yet.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - new patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 36 +++++++++++++++++++---------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f9bfae1e97a2..6799d24501b8 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -47,14 +47,13 @@ struct inno_hdmi {
 
 	struct inno_hdmi_i2c *i2c;
 	struct i2c_adapter *ddc;
-
-	unsigned int tmds_rate;
 };
 
 struct inno_hdmi_connector_state {
 	struct drm_connector_state	base;
 	unsigned int			enc_out_format;
 	unsigned int			colorimetry;
+	unsigned long			tmds_rate;
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -133,11 +132,33 @@ static inline void hdmi_modb(struct inno_hdmi *hdmi, u16 offset,
 	hdmi_writeb(hdmi, offset, temp);
 }
 
+static unsigned long inno_hdmi_tmds_rate(struct inno_hdmi *hdmi)
+{
+	struct drm_connector *connector = &hdmi->connector;
+	struct drm_connector_state *conn_state =  connector->state;
+	struct inno_hdmi_connector_state *inno_conn_state;
+
+	if (conn_state) {
+		inno_conn_state = to_inno_hdmi_conn_state(conn_state);
+		return inno_conn_state->tmds_rate;
+	}
+
+	/*
+	 * When IP controller haven't configured to an accurate video
+	 * timing, then the TMDS clock source would be switched to
+	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
+	 * and reconfigure the DDC clock.
+	 */
+
+	return clk_get_rate(hdmi->pclk);
+}
+
 static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi)
 {
 	int ddc_bus_freq;
+	unsigned long tmds_rate = inno_hdmi_tmds_rate(hdmi);
 
-	ddc_bus_freq = (hdmi->tmds_rate >> 2) / HDMI_SCL_RATE;
+	ddc_bus_freq = (tmds_rate >> 2) / HDMI_SCL_RATE;
 
 	hdmi_writeb(hdmi, DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
 	hdmi_writeb(hdmi, DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
@@ -431,7 +452,7 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	 * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
 	 * clock rate, and reconfigure the DDC clock.
 	 */
-	hdmi->tmds_rate = mode->clock * 1000;
+	inno_conn_state->tmds_rate = mode->clock * 1000;
 	inno_hdmi_i2c_init(hdmi);
 
 	/* Unmute video and audio output */
@@ -823,13 +844,6 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk;
 	}
 
-	/*
-	 * When IP controller haven't configured to an accurate video
-	 * timing, then the TMDS clock source would be switched to
-	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
-	 * and reconfigure the DDC clock.
-	 */
-	hdmi->tmds_rate = clk_get_rate(hdmi->pclk);
 	inno_hdmi_i2c_init(hdmi);
 
 	ret = inno_hdmi_register(drm, hdmi);
-- 
2.43.0


