Return-Path: <linux-kernel+bounces-2268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D448D815A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC011F23DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C83D0C8;
	Sat, 16 Dec 2023 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayixFSuC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56739ADF;
	Sat, 16 Dec 2023 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so214841866b.1;
        Sat, 16 Dec 2023 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744040; x=1703348840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeP9TO9V+vEKe4+An2VukwFpdenqcBYIdbA3kdqXnt8=;
        b=ayixFSuC79q4Aon/eqqsjXLpWOzUbexVLV0QQk50ieBw8gmS+IUrfi5He+vzqlnD8t
         OCyp2Pt7aR06oGf//vj1pTCmBRJDBqPK9sCaJ1HuG1Q7pLgij1Br9XddV/ju5FILp70q
         Yrr/Bwi2fS6YWS0iwrRbQqxc9TytkWdoLvWTHM8do4SFDlwBVI0hmD1BWDgenKmG5h12
         mLT+/kIanu6zQg9cVM+n96b/1CtoUBYll38vlx7uOG0X2uENXUqfL3gB1TQhrmTQnFe8
         Nq+nfs/EEBerervkXU1W5W7PDHHknIPj2BxJbbcJ9iuHfB9Rt1KmZYTtnb8jlUsGLgKb
         0TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744040; x=1703348840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeP9TO9V+vEKe4+An2VukwFpdenqcBYIdbA3kdqXnt8=;
        b=inBgFGBTHt2hpdnyhrUzRKaUpc4ulsx62uaf7Pc4ZxiRrAWB8qVgqsceaS6JYC97I3
         RA5pMBhFKPuvUYxNu+RHQvobCVCXoSVVcEhPo8JKboS1UNbEPEwTj6fOsLhULxJSRwpD
         uqrcLKZLz4OSeaffjTqqAZlU490UVxaMoFSVuD6zS+ZrZ6psiEo5nqztxmhvbwqxiVhZ
         sbktkMbt4ZXe07Ln2+pjZP2CWI2pu7m8M9/zaernfpaO5fktC1lkp9gS8+cBYGGXMXId
         zR4ZNjiKNSH17LlQBalH/BzjmVWzI1en8F4zvV3D65xSdF/Q/dRlghcV2tuFTqgQLyUP
         DlEQ==
X-Gm-Message-State: AOJu0Ywtc/7kiByhSHfOqOSJTgygC0uoZECA3ej5acQGM0/g92fT6guv
	Q4IDIvEctm7aorMTT4XOXw==
X-Google-Smtp-Source: AGHT+IEy38X0xbtf3xBfqjoxplLyZkqC6IMsseY2tnTm+ch8eIhob3KOfE1WsE0GkDI5Mc3Qu6NtmA==
X-Received: by 2002:a17:906:24e:b0:a1d:b7b9:3274 with SMTP id 14-20020a170906024e00b00a1db7b93274mr3725525ejl.169.1702744040255;
        Sat, 16 Dec 2023 08:27:20 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.19
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
Subject: [PATCH v2 20/27] drm/rockchip: inno_hdmi: Correctly setup HDMI quantization range
Date: Sat, 16 Dec 2023 17:26:31 +0100
Message-ID: <20231216162639.125215-21-knaerzche@gmail.com>
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

The display controller will always give full range RGB regardless of the
mode set, but HDMI requires certain modes to be transmitted in limited
range RGB. This is especially required for HDMI sinks which do not support
non-standard quantization ranges.

This enables color space conversion for those modes and sets the
quantization range accordingly in the AVI infoframe.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - made rgb_limited_range part of the new custom connector state

 drivers/gpu/drm/rockchip/inno_hdmi.c | 60 +++++++++++++++++++---------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 6799d24501b8..9f27a5faf12d 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -54,6 +54,7 @@ struct inno_hdmi_connector_state {
 	unsigned int			enc_out_format;
 	unsigned int			colorimetry;
 	unsigned long			tmds_rate;
+	bool				rgb_limited_range;
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -293,6 +294,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	else
 		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
+	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_RGB) {
+		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
+						   connector, mode,
+						   inno_conn_state->rgb_limited_range ?
+						   HDMI_QUANTIZATION_RANGE_LIMITED :
+						   HDMI_QUANTIZATION_RANGE_FULL);
+	} else {
+		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
+		frame.avi.ycc_quantization_range =
+			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
+	}
+
 	return inno_hdmi_upload_frame(hdmi, &frame, HDMI_INFOFRAME_TYPE_AVI);
 }
 
@@ -320,29 +333,37 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 	hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL2, value);
 
 	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_RGB) {
-		value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
-		hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
-
-		hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
-			  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
-			  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
-			  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
-		return 0;
-	}
-
-	if (inno_conn_state->colorimetry == HDMI_COLORIMETRY_ITU_601) {
-		if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
-			csc_mode = CSC_RGB_0_255_TO_ITU601_16_235_8BIT;
+		if (inno_conn_state->rgb_limited_range) {
+			csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
 			auto_csc = AUTO_CSC_DISABLE;
 			c0_c2_change = C0_C2_CHANGE_DISABLE;
 			csc_enable = v_CSC_ENABLE;
+
+		} else {
+			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
+			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
+
+			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
+				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
+				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
+				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
+			return 0;
 		}
 	} else {
-		if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
-			csc_mode = CSC_RGB_0_255_TO_ITU709_16_235_8BIT;
-			auto_csc = AUTO_CSC_DISABLE;
-			c0_c2_change = C0_C2_CHANGE_DISABLE;
-			csc_enable = v_CSC_ENABLE;
+		if (inno_conn_state->colorimetry == HDMI_COLORIMETRY_ITU_601) {
+			if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
+				csc_mode = CSC_RGB_0_255_TO_ITU601_16_235_8BIT;
+				auto_csc = AUTO_CSC_DISABLE;
+				c0_c2_change = C0_C2_CHANGE_DISABLE;
+				csc_enable = v_CSC_ENABLE;
+			}
+		} else {
+			if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
+				csc_mode = CSC_RGB_0_255_TO_ITU709_16_235_8BIT;
+				auto_csc = AUTO_CSC_DISABLE;
+				c0_c2_change = C0_C2_CHANGE_DISABLE;
+				csc_enable = v_CSC_ENABLE;
+			}
 		}
 	}
 
@@ -431,6 +452,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	else
 		inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
 
+	inno_conn_state->rgb_limited_range =
+		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
+
 	/* Mute video and audio output */
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
 		  v_AUDIO_MUTE(1) | v_VIDEO_MUTE(1));
-- 
2.43.0


