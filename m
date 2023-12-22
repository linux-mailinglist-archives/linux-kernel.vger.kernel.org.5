Return-Path: <linux-kernel+bounces-9969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BA81CDFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00082B2490C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476EC40C1C;
	Fri, 22 Dec 2023 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3SWqONi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA938FA3;
	Fri, 22 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d48304efdso4205555e9.0;
        Fri, 22 Dec 2023 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266956; x=1703871756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzkYbwlGueFkeXw8MQWVExgytplkJ2Nf/UnR4OES2p8=;
        b=M3SWqONiCNGloE3SGnpEhyq0l3y9cuz9EtsSlWRrZFNhKVOJ8Ia7K4337/ukErlIQD
         KxvAhr2xYW/LRMb5hplGOxSx+M5KO+BIZ+WF0JY16e/Fkturyd7UWxxK/R/NczulmXX1
         HmuDrvc+N/+QUOv9T9eD9KqaHoPVvZA+FkSFJGnFrMr3taJLLBiP97hnPFoQwkyONZ84
         B9KayxYmMbDU01UjA7EgJEPpipgCZA9sOEtVb6n9b5RsDpY3fHbIo6vX4T1nc9jeMjjV
         w/rJQNuJkYb3SOxjMhVJi66FMy5TNWp7533nnPun3adZs0uPzQBDQ9rg9ZR6tUo8n1PW
         nrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266956; x=1703871756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzkYbwlGueFkeXw8MQWVExgytplkJ2Nf/UnR4OES2p8=;
        b=GlhkX9MKYXDGBYVZ2G16urtd0HzS5KgPgEcWAE7klrCnmgQk2krnUgcUxovho5pXY2
         6eZPoZ7e9MYvQYeo34M15NQFg4Yl0xGHcQAUvYqGZAdk2m+Ktm6VnAe6KvMnxdZ5CW2Z
         KYLPVHEFh10NSy2zFrsgwJ0/BwGTIymc1YWuybZ8g6oAwWi/lwCPE1bEhHPp0ptlVBzc
         RHH8E82IKnNFd6jp02EJvbZgO+qbyJ0223nmHQishbbC32IVP7OzJYY909P0luY2vXPk
         MfLd/IJFHFtb3fj34y5Bx59W9mQ/fTvC9zOqZDAu+ZgOLL0o8UT3flvOqW8p8m0swQZJ
         rCyA==
X-Gm-Message-State: AOJu0YzecwHhSBrqTwY2hjBoTPifn5EU4Er9mCYUbXEfniXADXaciPMB
	icLmZxDTkP8e4LmObpnkFg==
X-Google-Smtp-Source: AGHT+IGjw9eaTW3bYuJzaeJRxodZiDLkX0kYbSh2SunwyP2K37rlC164b3cp2fGSEgNHWdq2zTdZoQ==
X-Received: by 2002:a05:600c:4e87:b0:40b:4808:5d0a with SMTP id f7-20020a05600c4e8700b0040b48085d0amr983939wmq.17.1703266956443;
        Fri, 22 Dec 2023 09:42:36 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:36 -0800 (PST)
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
Subject: [PATCH v4 20/29] drm/rockchip: inno_hdmi: Correctly setup HDMI quantization range
Date: Fri, 22 Dec 2023 18:42:11 +0100
Message-ID: <20231222174220.55249-21-knaerzche@gmail.com>
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

changes in v3:
 - moved assignment of rgb_limited_range to atomic check

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 60 +++++++++++++++++++---------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e43fce968310..f3b90b479ab9 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -53,6 +53,7 @@ struct inno_hdmi_connector_state {
 	struct drm_connector_state	base;
 	unsigned int			enc_out_format;
 	unsigned int			colorimetry;
+	bool				rgb_limited_range;
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -270,6 +271,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
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
 
@@ -297,29 +310,37 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
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
 
@@ -473,6 +494,8 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 		inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
 
 	inno_conn_state->enc_out_format = HDMI_COLORSPACE_RGB;
+	inno_conn_state->rgb_limited_range =
+		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
 
 	return 0;
 }
@@ -559,6 +582,7 @@ static void inno_hdmi_connector_reset(struct drm_connector *connector)
 
 	inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
 	inno_conn_state->enc_out_format = HDMI_COLORSPACE_RGB;
+	inno_conn_state->rgb_limited_range = false;
 }
 
 static struct drm_connector_state *
-- 
2.43.0


