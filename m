Return-Path: <linux-kernel+bounces-2261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1156815A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480FB1F23903
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3836AEA;
	Sat, 16 Dec 2023 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC6ELqZ6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89334CF1;
	Sat, 16 Dec 2023 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso2601012a12.0;
        Sat, 16 Dec 2023 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744035; x=1703348835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9QZuywAC4EI3NrqImc1jlnBGMQF6PpPHDhHez7fyFw=;
        b=lC6ELqZ66HTWeSk1fO0gBvzesZIupydZdhYexTiF+MkbiTU5N/qM7wSmLB5pHdpTkS
         TjEtvBs9cF+Y8aAnIspe6BvXUxA0n2IFXhgAdZyA0kIGQ25adKkRD9l7PXAtuYIzYpnZ
         PqrT54vqL90GuU3BpIKvksbJUWFoHPZ4MjL1C8hsNDrPzEB2nel52fRdMjjcmjT5JN4z
         FeWilNCsbghNXjR6LZlWkcJua5jETJ0T/S4l9Ubmxa8h4Azn23WrxF+pt+Ul+CsgRiwV
         gXCdP1K4dZvuH0TBn4AIM9K33F+Z14Ym7++tj3xph6JuV1UBWjOfg0inKo5D1nErkBM5
         Tmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744035; x=1703348835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9QZuywAC4EI3NrqImc1jlnBGMQF6PpPHDhHez7fyFw=;
        b=syoHOsqdoK0Ofx0XWULxmx/Lv5d4HJgUUunuJHBSZeRk1eDbq2BCp9xddSezmitd3u
         DPtueQthTV2vZx0L/8VqdOz5VdTlDRcRDVpzelM/Bc4MOUBXftYL2V3SIsfPfEd0NvfQ
         iVulnx/FGNL9uS7TMaxDx35UA4IbLQotM6LmLvsFo/0omLY8l6etUo0MSH4sjWVYGjRq
         VW9x0AHCL6u5drOiOIJvqGdp8OV6nUg5W0s7Pm83Oqg+qw5BaGdQZ2kjRpwIp4G2pOWM
         FzADyGeIprYHIX2lZvJKGOjxpm4MuUjXKkpxYytu9H+fbVXZE/dWyTOFTTh2vyvf7gBs
         BoSA==
X-Gm-Message-State: AOJu0YzaGLQoxMwzuu+rXghMdNFPU2Ea0+z00Uh+mqi5CHE/DnsKy8au
	uYMPrBDglQOFYyvty5P83sumhHz9KA==
X-Google-Smtp-Source: AGHT+IHGbh6ggRb8WI42dSTU+fAZTkS0f9QpcbJqWKC6qLhps1dmDmupPrITbbQTUiS7sKzLN0d+eQ==
X-Received: by 2002:a17:906:610:b0:a19:a409:37dc with SMTP id s16-20020a170906061000b00a19a40937dcmr14010099ejb.53.1702744035357;
        Sat, 16 Dec 2023 08:27:15 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:15 -0800 (PST)
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
Subject: [PATCH v2 13/27] drm/rockchip: inno_hdmi: Move infoframe disable to separate function
Date: Sat, 16 Dec 2023 17:26:24 +0100
Message-ID: <20231216162639.125215-14-knaerzche@gmail.com>
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

The code to upload infoframes to the controller uses a weird construct
which, based on the previous function call return code, will either
disable or enable that infoframe.

In order to get rid of that argument, let's split the function to
disable the infoframe into a separate function and make it obvious what
we are doing in the error path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 46 ++++++++++++++++++----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 1dd757845547..6354949bfd8e 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -207,34 +207,44 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
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
@@ -246,6 +256,10 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
 						      &hdmi->connector,
 						      mode);
+	if (rc) {
+		inno_hdmi_disable_frame(hdmi, INFOFRAME_AVI);
+		return rc;
+	}
 
 	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
 		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
@@ -254,7 +268,7 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	else
 		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
-	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI);
+	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_AVI);
 }
 
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
-- 
2.43.0


