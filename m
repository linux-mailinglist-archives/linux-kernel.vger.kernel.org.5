Return-Path: <linux-kernel+bounces-2266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57E815A55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954E01F23C73
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B23B191;
	Sat, 16 Dec 2023 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlnoPjCR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457F37D1F;
	Sat, 16 Dec 2023 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so216693566b.0;
        Sat, 16 Dec 2023 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744039; x=1703348839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/eFbXWfaMM0I74IrKyTPfTKiYx+jg35hR0AyiA/w9A=;
        b=LlnoPjCRW5tMBVZSdBvvWV1668s2ZS1ltUQD0IaWBMQPxogH5zfNeqY7WdMscuOfe6
         q9YM7hbPfzEVHp9qTVbjMWZ3OSPqqcemLW28X1uMAo75PRds71eVUHJJWN2olIv7D+zg
         F6/cvUBEWV6uc5/TS+u1iZ+bVAdCIB05fAYaO5nbENSbCBLfMzqcult+8Xn26om7B62d
         CttXnzZw4YG0dJIdT+RSv9z2uATw/ex+KaeeP6L030pI71V3gVhX/VJ9rKg9pRYRPV8Y
         a9P0yELvgjhrA0G+iaXbAUFDvG30bmtzvihVto8d3bE+qnGS4eSh5OAp6INtL5ObsWPJ
         xgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744039; x=1703348839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/eFbXWfaMM0I74IrKyTPfTKiYx+jg35hR0AyiA/w9A=;
        b=nDN4Q2qBXeQ3lETtZ6B8rGgn45n9ZLo7kTCL4yjkgzKe6jjiOBnvHGqr5mq3SSkmVv
         FY7rnumohx1nQ+0pv2GELl+BcZXOMu6jGYVc7fQcCKO+8l7d5s2JsBvH/YLrRRT+ZOK2
         VYx8ANSu1/OriDEdCaL4vZOcQ0EYoQgd/SFafJmita9VeXNqFyPZzflWqUJLtzbCx7gR
         LvcMpM8UgcnmmAYm226d5XjvPi6AAAuMK/JWoqJ31A45YnqsYwduVQvno1FJJsdmtDY/
         mqE+5SlVlLDUJhwpb+BJsor/7DileVJR3Vr1tNs9AvQFqQ1I9O0Ewf4NfCTSgDoOO8ih
         K0XA==
X-Gm-Message-State: AOJu0YwTcRH16yX6YDujPFXg1f8pAR2Jy5BTs1okKoZUKjn2MqakW26K
	gQa1sT0AzlzY4D0cGWxlNw==
X-Google-Smtp-Source: AGHT+IFcXZmVFLxYHlvqMbP/xbdnhMTM7dR1bMRRMLYfTq4p6bSRSS6zHWkOWzhS8av038yeCD6ZRw==
X-Received: by 2002:a17:907:cbc8:b0:a19:a1ba:bae1 with SMTP id vk8-20020a170907cbc800b00a19a1babae1mr4432738ejc.135.1702744039030;
        Sat, 16 Dec 2023 08:27:19 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:18 -0800 (PST)
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
Subject: [PATCH v2 18/27] drm/rockchip: inno_hdmi: Subclass connector state
Date: Sat, 16 Dec 2023 17:26:29 +0100
Message-ID: <20231216162639.125215-19-knaerzche@gmail.com>
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

The data which is currently hold in hdmi_data should not be part of device
itself but of the connector state.
Introduce a connector state subclass and move the data from hdmi_data in
there.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - new patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 67 +++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 62c7e2275246..f9bfae1e97a2 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -26,11 +26,6 @@
 
 #include "inno_hdmi.h"
 
-struct hdmi_data_info {
-	unsigned int enc_out_format;
-	unsigned int colorimetry;
-};
-
 struct inno_hdmi_i2c {
 	struct i2c_adapter adap;
 
@@ -54,8 +49,12 @@ struct inno_hdmi {
 	struct i2c_adapter *ddc;
 
 	unsigned int tmds_rate;
+};
 
-	struct hdmi_data_info	hdmi_data;
+struct inno_hdmi_connector_state {
+	struct drm_connector_state	base;
+	unsigned int			enc_out_format;
+	unsigned int			colorimetry;
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -70,6 +69,9 @@ static struct inno_hdmi *connector_to_inno_hdmi(struct drm_connector *connector)
 	return container_of(connector, struct inno_hdmi, connector);
 }
 
+#define to_inno_hdmi_conn_state(_state) \
+	container_of_const(_state, struct inno_hdmi_connector_state, base)
+
 enum {
 	CSC_RGB_0_255_TO_ITU601_16_235_8BIT,
 	CSC_RGB_0_255_TO_ITU709_16_235_8BIT,
@@ -248,6 +250,10 @@ static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
 static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 				      struct drm_display_mode *mode)
 {
+	struct drm_connector *connector = &hdmi->connector;
+	struct drm_connector_state *conn_state = connector->state;
+	struct inno_hdmi_connector_state *inno_conn_state =
+					to_inno_hdmi_conn_state(conn_state);
 	union hdmi_infoframe frame;
 	int rc;
 
@@ -259,9 +265,9 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 		return rc;
 	}
 
-	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
+	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444)
 		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
-	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
+	else if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV422)
 		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
 	else
 		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
@@ -271,7 +277,10 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 {
-	struct hdmi_data_info *data = &hdmi->hdmi_data;
+	struct drm_connector *connector = &hdmi->connector;
+	struct drm_connector_state *conn_state = connector->state;
+	struct inno_hdmi_connector_state *inno_conn_state =
+					to_inno_hdmi_conn_state(conn_state);
 	int c0_c2_change = 0;
 	int csc_enable = 0;
 	int csc_mode = 0;
@@ -289,7 +298,7 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 		v_VIDEO_INPUT_CSP(0);
 	hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL2, value);
 
-	if (data->enc_out_format == HDMI_COLORSPACE_RGB) {
+	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_RGB) {
 		value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
 		hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
 
@@ -300,15 +309,15 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 		return 0;
 	}
 
-	if (data->colorimetry == HDMI_COLORIMETRY_ITU_601) {
-		if (data->enc_out_format == HDMI_COLORSPACE_YUV444) {
+	if (inno_conn_state->colorimetry == HDMI_COLORIMETRY_ITU_601) {
+		if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
 			csc_mode = CSC_RGB_0_255_TO_ITU601_16_235_8BIT;
 			auto_csc = AUTO_CSC_DISABLE;
 			c0_c2_change = C0_C2_CHANGE_DISABLE;
 			csc_enable = v_CSC_ENABLE;
 		}
 	} else {
-		if (data->enc_out_format == HDMI_COLORSPACE_YUV444) {
+		if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
 			csc_mode = CSC_RGB_0_255_TO_ITU709_16_235_8BIT;
 			auto_csc = AUTO_CSC_DISABLE;
 			c0_c2_change = C0_C2_CHANGE_DISABLE;
@@ -386,16 +395,20 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 {
 	struct drm_display_info *display = &hdmi->connector.display_info;
 	u8 vic = drm_match_cea_mode(mode);
+	struct drm_connector *connector = &hdmi->connector;
+	struct drm_connector_state *conn_state = connector->state;
+	struct inno_hdmi_connector_state *inno_conn_state =
+					to_inno_hdmi_conn_state(conn_state);
 
-	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
+	inno_conn_state->enc_out_format = HDMI_COLORSPACE_RGB;
 
 	if (vic == 6 || vic == 7 ||
 	    vic == 21 || vic == 22 ||
 	    vic == 2 || vic == 3 ||
 	    vic == 17 || vic == 18)
-		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
+		inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_601;
 	else
-		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
+		inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
 
 	/* Mute video and audio output */
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
@@ -522,12 +535,32 @@ static void inno_hdmi_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
+static struct drm_connector_state *
+inno_hdmi_connector_duplicate_state(struct drm_connector *connector)
+{
+	struct inno_hdmi_connector_state *inno_conn_state;
+
+	if (WARN_ON(!connector->state))
+		return NULL;
+
+	inno_conn_state = kmemdup(to_inno_hdmi_conn_state(connector->state),
+				  sizeof(*inno_conn_state), GFP_KERNEL);
+
+	if (!inno_conn_state)
+		return NULL;
+
+	__drm_atomic_helper_connector_duplicate_state(connector,
+						      &inno_conn_state->base);
+
+	return &inno_conn_state->base;
+}
+
 static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
 	.fill_modes = inno_hdmi_probe_single_connector_modes,
 	.detect = inno_hdmi_connector_detect,
 	.destroy = inno_hdmi_connector_destroy,
 	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_duplicate_state = inno_hdmi_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-- 
2.43.0


