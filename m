Return-Path: <linux-kernel+bounces-2260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8950E815A48
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045A7B2496A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E513529F;
	Sat, 16 Dec 2023 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRsM2dgx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672E3457A;
	Sat, 16 Dec 2023 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a233bf14cafso3904266b.2;
        Sat, 16 Dec 2023 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744035; x=1703348835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECr4TU+4dWwEpyi0MRJHLZRYm5yt9s85NOlMMczFD3o=;
        b=nRsM2dgxziOh7IR/Ec0+3dhEvdlPxRuAShetYoQ4+ku8pSZoWLUF4HAkJjiWGUwoVX
         i8NKUJ7kZutYBqmji0Pa/Nrv0YhBEgjScztMRjj+6kvWqj6ydvIR176RRwg5yYHV3Uqf
         cSr+YBsX4UH6IFdyLCQ0n23E4vHcmz1C9nU6h2CFSK+1SjoYRHFoPa9iQzwRKudX1KYV
         ITleLTLdTbtiIWCFB8FwG/NHZTF9s/9Cj1WJNQlyqXszYMIUBs3FF55aPDoJXCFDUeIQ
         GF84dMArT868PtUJSx8kO685qhB6J0gIvJf5Rfq41JwYfO/3rfl5Ea4vVxF91ebjuDqF
         KT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744035; x=1703348835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECr4TU+4dWwEpyi0MRJHLZRYm5yt9s85NOlMMczFD3o=;
        b=LTtBNN7LLoOJTUc29pZHTb19U6BFBXAvCct/MfVwvPHIkUHsAPMg4InDfGo7PILzB8
         U82dsVF6wP8nLmiMeEG5UYawyWeknh5PwFvU+kAz/eN/JFJudRGuXRHXg04kdaoTKD+u
         QhWzIPmgII8H7lT1tNXwJW1eoZYel0TccyKR/w8cqGqWAy4sBeGfx46IkbbumvYx1+YQ
         QzhZaDoshrNof7qW1uS8ljZI37OPss699eWHm4hJmVkzHC/zjPzN/MxdHRIxE1eJ+qzP
         cJfsLzZ+hbS5qghvU1tKjSzSMEZFm/nlFuxXw/CI2QFRJnktBAh4/HCqGXyC3Rz0t+16
         3aCg==
X-Gm-Message-State: AOJu0YxWOdNvPrUrBZBry5K47q/UznndODZTUivtxIyk9usWjt3FcyU8
	ua49CX6OIYd2OtgXvevkgw==
X-Google-Smtp-Source: AGHT+IGGXCXV7iuVsJthNs7xfU7rsSHw66Q2y9j042wi558zp4keY2U5j+cevcIqQYjVqvV5U3yloQ==
X-Received: by 2002:a17:906:e8d:b0:a19:a19b:c736 with SMTP id p13-20020a1709060e8d00b00a19a19bc736mr6780924ejf.134.1702744034682;
        Sat, 16 Dec 2023 08:27:14 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:14 -0800 (PST)
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
	Johan Jonker <jbx6244@gmail.com>,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 12/27] drm/rockchip: inno_hdmi: Drop HDMI Vendor Infoframe support
Date: Sat, 16 Dec 2023 17:26:23 +0100
Message-ID: <20231216162639.125215-13-knaerzche@gmail.com>
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

From: Maxime Ripard <mripard@kernel.org>

The HDMI vendor infoframe is only meant to be sent with 4k60 modes and
higher, but the controller doesn't support them. Let's drop them from
the kernel.

Suggested-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 35 ++++++++--------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 04344ee1265d..1dd757845547 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -208,11 +208,15 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 }
 
 static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi, int setup_rc,
-				  union hdmi_infoframe *frame, u32 frame_index,
-				  u32 mask, u32 disable, u32 enable)
+				  union hdmi_infoframe *frame, u32 frame_index)
 {
-	if (mask)
-		hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, mask, disable);
+	struct drm_connector *connector = &hdmi->connector;
+
+	if (frame_index != INFOFRAME_AVI) {
+		drm_err(connector->dev,
+			"Unsupported infoframe type: %u\n", frame_index);
+		return 0;
+	}
 
 	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, frame_index);
 
@@ -228,28 +232,11 @@ static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi, int setup_rc,
 		for (i = 0; i < rc; i++)
 			hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i,
 				    packed_frame[i]);
-
-		if (mask)
-			hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, mask, enable);
 	}
 
 	return setup_rc;
 }
 
-static int inno_hdmi_config_video_vsi(struct inno_hdmi *hdmi,
-				      struct drm_display_mode *mode)
-{
-	union hdmi_infoframe frame;
-	int rc;
-
-	rc = drm_hdmi_vendor_infoframe_from_display_mode(&frame.vendor.hdmi,
-							 &hdmi->connector,
-							 mode);
-
-	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_VSI,
-		m_PACKET_VSI_EN, v_PACKET_VSI_EN(0), v_PACKET_VSI_EN(1));
-}
-
 static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 				      struct drm_display_mode *mode)
 {
@@ -267,7 +254,7 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	else
 		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
-	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
+	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI);
 }
 
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
@@ -410,10 +397,8 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 
 	inno_hdmi_config_video_csc(hdmi);
 
-	if (display->is_hdmi) {
+	if (display->is_hdmi)
 		inno_hdmi_config_video_avi(hdmi, mode);
-		inno_hdmi_config_video_vsi(hdmi, mode);
-	}
 
 	/*
 	 * When IP controller have configured to an accurate video
-- 
2.43.0


