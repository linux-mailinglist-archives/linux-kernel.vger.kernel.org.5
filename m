Return-Path: <linux-kernel+bounces-5633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C1818D72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20621C23B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185EB3B190;
	Tue, 19 Dec 2023 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag++kioa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D839859;
	Tue, 19 Dec 2023 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2308faedso56872875e9.1;
        Tue, 19 Dec 2023 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005280; x=1703610080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLVOVeutPpE/o943uN9J0cWjrEPzXhsU4YUzCWYMJxA=;
        b=Ag++kioaLZBYMy6gi5yNznCDfCzXI5BLHTDlDjl+Hyq5w0pt3GKiBg9GZpT2NL0kgK
         WI0kvk7AEKiJVv91A2xLH2VPjC3Pv7dYZcqakz6G+dmp2aP0H0YLjUMdZk2P5nP9owLT
         AeHhDhttcz1XMy1GmzSEf87Ho6IrlhP8FWMd3ks4SikoQiXAqiNsDn4G4rcNAguOapvT
         HDQkzCOnsnemociZXIwliqbTWz26uOA7iC+zvBU8v4iKXh8ND/hrn+9gsJULV8uCrqU5
         w7POzw71aoholSplG8coI+kEyAs6J5iBH22Hdyskr4YmG/k8ZjbWKU/7UY1mY0l58vmO
         LHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005280; x=1703610080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLVOVeutPpE/o943uN9J0cWjrEPzXhsU4YUzCWYMJxA=;
        b=o2gRRc9D3ANTTon72jWEMq7BGOZbZQKiuWAIxwihQWonyH0kWjRSSlBI8V0Qjz+5fW
         IgNlr4rEgYmRaxNr0al8ZU8eC1tNXL/CG3UAo0rhb+TqwEVBDgJncQ91LD0WyZEQQOiA
         oWQl5xr9o877+GNhUVwaJITIbYJtUk7EQMoEBg6xxDsB1wGMem1EbofEQMg891cexolI
         H0zI5MkHwHeP3/GAjme715OrFDew7x6gh/X94I4Gt0mD4jOSxUCJkg05I5rFAXNPjswD
         6wAp5kWMoDq652Js6BLk0/ItzC8zb7ZWkvOpqVD8wqtM5ABHguBACXupTyUB8Pcbdjax
         kDTQ==
X-Gm-Message-State: AOJu0Yyftt1GqhIt/D/GWVUs3B3s6zM1/C8qDguWwHNnyRW8P0HWsnxh
	cPYoKFJ4TfPzG8/AA66NnQ==
X-Google-Smtp-Source: AGHT+IGRlC9Raac+QygKKLDkdfOeiYrk+nrbVIe+Lff6n3kh+jfvi6jEh6b9PVLAsBO1Ls90F8sAzQ==
X-Received: by 2002:a05:600c:808e:b0:40b:5e59:c581 with SMTP id ew14-20020a05600c808e00b0040b5e59c581mr9903834wmb.171.1703005279654;
        Tue, 19 Dec 2023 09:01:19 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:19 -0800 (PST)
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
Subject: [PATCH v3 14/29] drm/rockchip: inno_hdmi: Move infoframe disable to separate function
Date: Tue, 19 Dec 2023 18:00:44 +0100
Message-ID: <20231219170100.188800-15-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

The code to upload infoframes to the controller uses a weird construct
which, based on the previous function call return code, will either
disable or enable that infoframe.

In order to get rid of that argument, let's split the function to
disable the infoframe into a separate function and make it obvious what
we are doing in the error path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 46 ++++++++++++++++++----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 5c9f1325441f..10466c2aa520 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -205,34 +205,44 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
-static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi, int setup_rc,
-				  union hdmi_infoframe *frame, u32 frame_index)
+static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi, u32 frame_index)
 {
 	struct drm_connector *connector = &hdmi->connector;
 
 	if (frame_index != INFOFRAME_AVI) {
 		drm_err(connector->dev,
 			"Unsupported infoframe type: %u\n", frame_index);
-		return 0;
+		return;
 	}
 
 	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, frame_index);
+}
 
-	if (setup_rc >= 0) {
-		u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
-		ssize_t rc, i;
-
-		rc = hdmi_infoframe_pack(frame, packed_frame,
-					 sizeof(packed_frame));
-		if (rc < 0)
-			return rc;
+static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
+				  union hdmi_infoframe *frame, u32 frame_index)
+{
+	struct drm_connector *connector = &hdmi->connector;
+	u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
+	ssize_t rc, i;
 
-		for (i = 0; i < rc; i++)
-			hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i,
-				    packed_frame[i]);
+	if (frame_index != INFOFRAME_AVI) {
+		drm_err(connector->dev,
+			"Unsupported infoframe type: %u\n", frame_index);
+		return 0;
 	}
 
-	return setup_rc;
+	inno_hdmi_disable_frame(hdmi, frame_index);
+
+	rc = hdmi_infoframe_pack(frame, packed_frame,
+				 sizeof(packed_frame));
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; i < rc; i++)
+		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i,
+			    packed_frame[i]);
+
+	return 0;
 }
 
 static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
@@ -244,6 +254,10 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
 						      &hdmi->connector,
 						      mode);
+	if (rc) {
+		inno_hdmi_disable_frame(hdmi, INFOFRAME_AVI);
+		return rc;
+	}
 
 	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
 		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
@@ -252,7 +266,7 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	else
 		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
-	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI);
+	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_AVI);
 }
 
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
-- 
2.43.0


