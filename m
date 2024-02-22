Return-Path: <linux-kernel+bounces-76898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280385FE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E5C1C25583
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F3153BC5;
	Thu, 22 Feb 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQrXYwgr"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296B8C0B;
	Thu, 22 Feb 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620274; cv=none; b=l167rL6ssn1xgsD/Fq/yhaVkpmge6gTn61vGMpfZNFw/C7UGfKANKtZVKAe05zQ/+Qum21I4zYQ4w0fwZ4GgRGTRa1sJer8vpP3eZDRq8buwr7yFp8eXMP5tKxFbmFvUPS0xbmFypTIYYs5RdVRwt/55oQVPp3o1amdbLP8fOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620274; c=relaxed/simple;
	bh=vSzCyAi5T9sgr9bUOid1vdtAG0RYpvMRx5Jwt+lpGZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjcUZWAB8Hvw8cS1HAQqGQUh7k16XDWW2IjT81NDChoNlOyXuxmHjtDKN9LlOUxyLzCLYuOyHmdJoXzexbIpDtBDFGpBwBjxgCEJ0vH6uLZCGBwaXddLTOPod/0Dg/EW59THgk/ayzhLnFr2GKgQaKQUZxFShoUILq65HhxLIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQrXYwgr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41275971886so15805325e9.3;
        Thu, 22 Feb 2024 08:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708620271; x=1709225071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9SWDIfh91PUFnssD98ZcjvHp+kf1OGg+JV2t9c32to=;
        b=lQrXYwgr/x8yokKrw4OOCnpPYbbsT1TSk9zznRO2YL+PvGgXz0OA10vUxLmQ8SJDlQ
         YNjl9pzQvylAeJ+tILS/HLUCH4TGVoKgXDh4ou/J4shSbNvk6hD/j2G94WBH/UEZc3gE
         8ql7YwA1cRZ7TzZRmrLzzdriUsQ1lOF+dlpI4b9TIPqvAOaRNMvhsUUp8/4kpuf9sFU/
         Re74xg6UxuiDhOVqpJDnZ5Tvh9tcx2xQ1Uo8XxYa/Nt7IAuwNXrqL5aCEtAjgQUpkxSI
         4NtH53cBgX9Lm+r+sqotLxrIeH2J85CTsS3XVYiXaIJms6MZh1M7maYSb9bDOAAXip17
         FuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620271; x=1709225071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9SWDIfh91PUFnssD98ZcjvHp+kf1OGg+JV2t9c32to=;
        b=vXpce6r7hUQSU1Wj4cHKCwY7mEXuFExLjE/LnFNqXPxB8LOmrcLoeUcSe6B/p+EXbX
         IJoNkd0UBsKjl0kYmwdoV5rRNkJHgfnWCelqSGDU4gylt0UPv0n/ZZQ/36oW7CQs7gy+
         HFYryBemRA8/0fkdOtdnnKxPmswGb7PdSVKNq3nImDBjHB5nOMEd/EK42Nbo6PHW1N69
         hvdirrqU9kCkd96ylrz2iMK8ll7tKl5wdtT/WAPKG4R0IdLnVJKXSPcvATKGaRwsUoVc
         VeEzW8PkJEpPlhz5i1B295EW6//xMlYmiZX+pZ6IM9+U0LmUkBx6VLOoBlf4K9LqO/i5
         jMPg==
X-Forwarded-Encrypted: i=1; AJvYcCXVOfSBbcpII2PYtzN3+jZt7/AX10rhJhqN+59+H7z9Z4BPWy26OCdx959Q3v4m1xSlCv0xeDqtDbtcV9N19YynBbREA2wQfyo44nsUlVeQBeXUfZzWuVysokSA4Y7Ej7xbTJBqnzTaSg==
X-Gm-Message-State: AOJu0YwYlaS5uVGE7RfRDPevuYLuARsEYlovD5hnKHXmjc9sa1NflKRg
	U2DzRzZJ/SDe8PHgQvn4AhTl07C+KRul7+Xy0KoFKpNmrxJLyYPH
X-Google-Smtp-Source: AGHT+IEul6GqBAA/Msq8v6waetwmRcblzCBJdBfcC5IKA8u9Zx+o6OZlp4pd+n3RPHbXJzH8Zuvcjg==
X-Received: by 2002:a05:600c:4449:b0:412:8fef:7f with SMTP id v9-20020a05600c444900b004128fef007fmr233521wmn.1.1708620270748;
        Thu, 22 Feb 2024 08:44:30 -0800 (PST)
Received: from localhost.localdomain ([90.255.110.157])
        by smtp.googlemail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm22800420wmq.37.2024.02.22.08.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:44:30 -0800 (PST)
From: Adam Green <greena88@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: greena88@gmail.com
Subject: [PATCH v2 1/2] drm: panel: st7701: Add Hardkernel ODROID-GO Ultra panel support
Date: Thu, 22 Feb 2024 16:43:13 +0000
Message-ID: <20240222164332.3864716-2-greena88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222164332.3864716-1-greena88@gmail.com>
References: <20240221194528.1855714-1-greena88@gmail.com>
 <20240222164332.3864716-1-greena88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hardkernel ODROID-GO Ultra is a handheld gaming devices, with
a 5 inch 480x854 display. Add support for the display.

Signed-off-by: Adam Green <greena88@gmail.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 158 +++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 421eb4592b61..d08e8f4c39dd 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -423,6 +423,62 @@ static void kd50t048a_gip_sequence(struct st7701 *st7701)
 		   0xFF, 0xFF, 0xFF, 0xFF, 0x10, 0x45, 0x67, 0x98, 0xBA);
 }
 
+static void odroid_go_ultra_gip_sequence(struct st7701 *st7701)
+{
+	ST7701_DSI(st7701, 0x01);
+	msleep(20);
+	ST7701_DSI(st7701, 0x11);
+	msleep(120);
+
+	ST7701_DSI(st7701, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x10);
+	ST7701_DSI(st7701, 0xC0, 0xE9, 0x03);
+	ST7701_DSI(st7701, 0xC1, 0x11, 0x02);
+	ST7701_DSI(st7701, 0xC2, 0x31, 0x08);
+	ST7701_DSI(st7701, 0xCC, 0x10);
+	ST7701_DSI(st7701, 0xB0, 0x00, 0x0D, 0x14, 0x0D, 0x10, 0x05, 0x02, 0x08,
+		   0x08, 0x1E, 0x05, 0x13, 0x11, 0xA3, 0x29, 0x18);
+	ST7701_DSI(st7701, 0xB1, 0x00, 0x0C, 0x14, 0x0C, 0x10, 0x05, 0x03, 0x08,
+		   0x07, 0x20, 0x05, 0x13, 0x11, 0xA4, 0x29, 0x18);
+	ST7701_DSI(st7701, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x11);
+	ST7701_DSI(st7701, 0xB0, 0x6C);
+	ST7701_DSI(st7701, 0xB1, 0x43);
+	ST7701_DSI(st7701, 0xB2, 0x07);
+	ST7701_DSI(st7701, 0xB3, 0x80);
+	ST7701_DSI(st7701, 0xB5, 0x47);
+	ST7701_DSI(st7701, 0xB7, 0x85);
+	ST7701_DSI(st7701, 0xB8, 0x20);
+	ST7701_DSI(st7701, 0xB9, 0x10);
+	ST7701_DSI(st7701, 0xC1, 0x78);
+	ST7701_DSI(st7701, 0xC3, 0x78);
+	ST7701_DSI(st7701, 0xD0, 0x88);
+	msleep(120);
+
+	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
+	ST7701_DSI(st7701, 0xE1, 0x08, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x09,
+		   0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		   0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE5, 0x0E, 0x60, 0xA0, 0xA0, 0x10, 0x60, 0xA0,
+		   0xA0, 0x0A, 0x60, 0xA0, 0xA0, 0x0C, 0x60, 0xA0, 0xA0);
+	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE8, 0x0D, 0x60, 0xA0, 0xA0, 0x0F, 0x60, 0xA0,
+		   0xA0, 0x09, 0x60, 0xA0, 0xA0, 0x0B, 0x60, 0xA0, 0xA0);
+	ST7701_DSI(st7701, 0xEB, 0x02, 0x01, 0xE4, 0xE4, 0x44, 0x00, 0x40);
+	ST7701_DSI(st7701, 0xEC, 0x02, 0x01);
+	ST7701_DSI(st7701, 0xED, 0xAB, 0x89, 0x76, 0x54, 0x01, 0xFF, 0xFF,
+		   0xFF, 0xFF, 0xFF, 0xFF, 0x10, 0x45, 0x67, 0x98, 0xBA);
+	ST7701_DSI(st7701, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x00);
+	ST7701_DSI(st7701, 0x3A, 0x70);
+	ST7701_DSI(st7701, 0x53, 0xEC);
+	ST7701_DSI(st7701, 0x55, 0xB3);
+	ST7701_DSI(st7701, 0x5E, 0xFF);
+	ST7701_DSI(st7701, 0x29);
+	msleep(50);
+}
+
 static void rg_arc_gip_sequence(struct st7701 *st7701)
 {
 	st7701_switch_cmd_bkx(st7701, true, 3);
@@ -470,7 +526,7 @@ static int st7701_prepare(struct drm_panel *panel)
 				    st7701->supplies);
 	if (ret < 0)
 		return ret;
-	msleep(20);
+	msleep(120);
 
 	gpiod_set_value(st7701->reset, 1);
 	msleep(150);
@@ -875,6 +931,105 @@ static const struct st7701_panel_desc kd50t048a_desc = {
 	.gip_sequence = kd50t048a_gip_sequence,
 };
 
+static const struct drm_display_mode odroid_go_ultra_mode = {
+	.clock		= 29170,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 12,
+	.hsync_end	= 480 + 12 + 12,
+	.htotal		= 480 + 12 + 12 + 38,
+
+	.vdisplay	= 854,
+	.vsync_start	= 854 + 2,
+	.vsync_end	= 854 + 2 + 19,
+	.vtotal		= 854 + 2 + 19 + 22,
+
+	.width_mm	= 70,
+	.height_mm	= 140,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct st7701_panel_desc odroid_go_ultra_desc = {
+	.mode = &odroid_go_ultra_mode,
+	.lanes = 2,
+	.format = MIPI_DSI_FMT_RGB888,
+	.panel_sleep_delay = 120,
+
+	.pv_gamma = {
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x2),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1e),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x23),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
+	},
+	.nv_gamma = {
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xc),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xc),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x3),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x24),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
+	},
+	.nlinv = 1,
+	.vop_uv = 4887500,
+	.vcom_uv = 937500,
+	.vgh_mv = 15000,
+	.vgl_mv = -9510,
+	.avdd_mv = 6600,
+	.avcl_mv = -4400,
+	.gamma_op_bias = OP_BIAS_MIDDLE,
+	.input_op_bias = OP_BIAS_MIN,
+	.output_op_bias = OP_BIAS_MIN,
+	.t2d_ns = 1600,
+	.t3d_ns = 10400,
+	.eot_en = true,
+	.gip_sequence = odroid_go_ultra_gip_sequence,
+};
+
 static const struct drm_display_mode rg_arc_mode = {
 	.clock          = 25600,
 
@@ -1055,6 +1210,7 @@ static const struct of_device_id st7701_of_match[] = {
 	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
 	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
 	{ .compatible = "elida,kd50t048a", .data = &kd50t048a_desc },
+	{ .compatible = "hardkernel,odroid-go-ultra-panel", .data = &odroid_go_ultra_desc },
 	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
 	{ }
 };
-- 
2.43.0


