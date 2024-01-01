Return-Path: <linux-kernel+bounces-13901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1B82146B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BFE281EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C95DDA2;
	Mon,  1 Jan 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KrtEyHKh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B50D28E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a27c6c88694so105854266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704125776; x=1704730576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxKslzO12Rzu7e9CjOOzNcXsKs1X72Uim34HnVRTS1M=;
        b=KrtEyHKhXq354G8NcZ8Phnheya/r6ubKA8LTC7OQwpBLXQz0NQu8ucXbcV7mBwgMVh
         Js0Oz0qTYki/T2mPKwyei5xTA8vMkT5o6sppQcL2LOtkoi8KsQdt3q24ZLL4bY5i/xlx
         3QnTvtUMghEyQvlANVs27Iv+Rtkn/s6edCiQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704125776; x=1704730576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxKslzO12Rzu7e9CjOOzNcXsKs1X72Uim34HnVRTS1M=;
        b=NP2wkB5dFMZq/gGvStN6+rfcMhaN6PyvlQdlSD+oPstBv55EzO9jtkhlp+R9o9wS5p
         jaVWah7jTYo8YZT82myo3tdJ80Mu70X/O+K2oHZ/X2OnU7AqPbbQqoCXYTgEOlUZRfbX
         fJLu9/k21snxOOhWq2pAUpWIjurUjYJJMkWSOFK85Ts+u/W4rdX1YvPvxZw6ePm013rb
         0JCf/naCLxhdfqiSAbeywGNSgc/KRidsZQieNbihG2aFbFKUf06kDbHT/S6G1E2GSK+W
         3eTS8QQ9YA0W5LS7RWDMsTMu2g/6D7PN/O5zH+/G3g4eVZNtuYwqQ2mlzttu8vnQegMW
         EgMA==
X-Gm-Message-State: AOJu0YyMF8vOch81WNDeUwkyvPInUsY7zb2WDftx/TE8HdZpnMot+kHf
	7zIU3DGZ5HXXW0+HucuhpNPBD+w6d9fbuAz4LlxGa0ENZLg=
X-Google-Smtp-Source: AGHT+IF9nTOTvtZdygw4LRTQqwecBir0/nNcBz/B7fiDx57kBV/dej++K0Kd2mlXUEie4H9DzZHo3w==
X-Received: by 2002:a50:fa81:0:b0:556:202d:c6a9 with SMTP id w1-20020a50fa81000000b00556202dc6a9mr1953880edr.7.1704125775927;
        Mon, 01 Jan 2024 08:16:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-48-44-179.retail.telecomitalia.it. [82.48.44.179])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b00a27d5e9b3ebsm1897857ejc.105.2024.01.01.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 08:16:15 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 7/8] drm/panel: nt35510: move hardwired parameters to configuration
Date: Mon,  1 Jan 2024 17:15:50 +0100
Message-ID: <20240101161601.2232247-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
References: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch, preparatory for future developments, move the hardwired
parameters to configuration data to allow the addition of new
NT35510-based panels.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Re-write the patch [7/8] "drm/panel: nt35510: refactor panel initialization"
  in the same style as the original driver in order to maintain the same
  structure.

 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 140 ++++++++++++++----
 1 file changed, 115 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index d6dceb858008..ce8969f48286 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -171,6 +171,10 @@ struct nt35510_config {
 	 * timing in the display controller.
 	 */
 	const struct drm_display_mode mode;
+	/**
+	 * @mode_flags: DSI operation mode related flags
+	 */
+	unsigned long mode_flags;
 	/**
 	 * @avdd: setting for AVDD ranging from 0x00 = 6.5V to 0x14 = 4.5V
 	 * in 0.1V steps the default is 0x05 which means 6.0V
@@ -273,6 +277,100 @@ struct nt35510_config {
 	 * same layout of bytes as @vgp.
 	 */
 	u8 vgn[NT35510_P1_VGN_LEN];
+	/**
+	 * @dopctr: setting optional control for display
+	 * ERR bits 0..1 in the first byte is the ERR pin output signal setting.
+	 * 0 = Disable, ERR pin output low
+	 * 1 = ERR pin output CRC error only
+	 * 2 = ERR pin output ECC error only
+	 * 3 = ERR pin output CRC and ECC error
+	 * The default is 0.
+	 * N565 bit 2 in the first byte is the 16-bit/pixel format selection.
+	 * 0 = R[4:0] + G[5:3] & G[2:0] + B[4:0]
+	 * 1 = G[2:0] + R[4:0] & B[4:0] + G[5:3]
+	 * The default is 0.
+	 * DIS_EoTP_HS bit 3 in the first byte is "DSI protocol violation" error
+	 * reporting.
+	 * 0 = reporting when error
+	 * 1 = not reporting when error
+	 * DSIM bit 4 in the first byte is the video mode data type enable
+	 * 0 = Video mode data type disable
+	 * 1 = Video mode data type enable
+	 * The default is 0.
+	 * DSIG bit 5 int the first byte is the generic r/w data type enable
+	 * 0 = Generic r/w disable
+	 * 1 = Generic r/w enable
+	 * The default is 0.
+	 * DSITE bit 6 in the first byte is TE line enable
+	 * 0 = TE line is disabled
+	 * 1 = TE line is enabled
+	 * The default is 0.
+	 * RAMKP bit 7 in the first byte is the frame memory keep/loss in
+	 * sleep-in mode
+	 * 0 = contents loss in sleep-in
+	 * 1 = contents keep in sleep-in
+	 * The default is 0.
+	 * CRL bit 1 in the second byte is the source driver data shift
+	 * direction selection. This bit is XOR operation with bit RSMX
+	 * of 3600h command.
+	 * 0 (RMSX = 0) = S1 -> S1440
+	 * 0 (RMSX = 1) = S1440 -> S1
+	 * 1 (RMSX = 0) = S1440 -> S1
+	 * 1 (RMSX = 1) = S1 -> S1440
+	 * The default is 0.
+	 * CTB bit 2 in the second byte is the vertical scanning direction
+	 * selection for gate control signals. This bit is XOR operation
+	 * with bit ML of 3600h command.
+	 * 0 (ML = 0) = Forward (top -> bottom)
+	 * 0 (ML = 1) = Reverse (bottom -> top)
+	 * 1 (ML = 0) = Reverse (bottom -> top)
+	 * 1 (ML = 1) = Forward (top -> bottom)
+	 * The default is 0.
+	 * CRGB bit 3 in the second byte is RGB-BGR order selection. This
+	 * bit is XOR operation with bit RGB of 3600h command.
+	 * 0 (RGB = 0) = RGB/Normal
+	 * 0 (RGB = 1) = BGR/RB swap
+	 * 1 (RGB = 0) = BGR/RB swap
+	 * 1 (RGB = 1) = RGB/Normal
+	 * The default is 0.
+	 * TE_PWR_SEL bit 4 in the second byte is the TE output voltage
+	 * level selection (only valid when DSTB_SEL = 0 or DSTB_SEL = 1,
+	 * VSEL = High and VDDI = 1.665~3.3V).
+	 * 0 = TE output voltage level is VDDI
+	 * 1 = TE output voltage level is VDDA
+	 * The default is 0.
+	 */
+	u8 dopctr[NT35510_P0_DOPCTR_LEN];
+	/**
+	 * @madctl: Memory data access control
+	 * RSMY bit 0 is flip vertical. Flips the display image top to down.
+	 * RSMX bit 1 is flip horizontal. Flips the display image left to right.
+	 * MH bit 2 is the horizontal refresh order.
+	 * RGB bit 3 is the RGB-BGR order.
+	 * 0 = RGB color sequence
+	 * 1 = BGR color sequence
+	 * ML bit 4 is the vertical refresh order.
+	 * MV bit 5 is the row/column exchange.
+	 * MX bit 6 is the column address order.
+	 * MY bit 7 is the row address order.
+	 */
+	u8 madctl;
+	/**
+	 * @sdhdtctr: source output data hold time
+	 * 0x00..0x3F = 0..31.5us in steps of 0.5us
+	 * The default is 0x05 = 2.5us.
+	 */
+	u8 sdhdtctr;
+	/**
+	 * @gseqctr: EQ control for gate signals
+	 * GFEQ_XX[3:0]: time setting of EQ step for falling edge in steps
+	 * of 0.5us.
+	 * The default is 0x07 = 3.5us
+	 * GREQ_XX[7:4]: time setting of EQ step for rising edge in steps
+	 * of 0.5us.
+	 * The default is 0x07 = 3.5us
+	 */
+	u8 gseqctr[NT35510_P0_GSEQCTR_LEN];
 	/**
 	 * @sdeqctr: Source driver control settings, first byte is
 	 * 0 for mode 1 and 1 for mode 2. Mode 1 uses two steps and
@@ -536,46 +634,28 @@ static int nt35510_setup_display(struct nt35510 *nt)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(nt->dev);
 	const struct nt35510_config *conf = nt->conf;
-	u8 dopctr[NT35510_P0_DOPCTR_LEN];
-	u8 gseqctr[NT35510_P0_GSEQCTR_LEN];
 	u8 dpfrctr[NT35510_P0_DPFRCTR1_LEN];
-	/* FIXME: set up any rotation (assume none for now) */
-	u8 addr_mode = NT35510_ROTATE_0_SETTING;
-	u8 val;
 	int ret;
 
-	/* Enable TE, EoTP and RGB pixel format */
-	dopctr[0] = NT35510_DOPCTR_0_DSITE | NT35510_DOPCTR_0_EOTP |
-		NT35510_DOPCTR_0_N565;
-	dopctr[1] = NT35510_DOPCTR_1_CTB;
 	ret = nt35510_send_long(nt, dsi, NT35510_P0_DOPCTR,
 				NT35510_P0_DOPCTR_LEN,
-				dopctr);
+				conf->dopctr);
 	if (ret)
 		return ret;
 
-	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_ADDRESS_MODE, &addr_mode,
-				 sizeof(addr_mode));
+	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_ADDRESS_MODE, &conf->madctl,
+				 sizeof(conf->madctl));
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Source data hold time, default 0x05 = 2.5us
-	 * 0x00..0x3F = 0 .. 31.5us in steps of 0.5us
-	 * 0x0A = 5us
-	 */
-	val = 0x0A;
-	ret = mipi_dsi_dcs_write(dsi, NT35510_P0_SDHDTCTR, &val,
-				 sizeof(val));
+	ret = mipi_dsi_dcs_write(dsi, NT35510_P0_SDHDTCTR, &conf->sdhdtctr,
+				 sizeof(conf->sdhdtctr));
 	if (ret < 0)
 		return ret;
 
-	/* EQ control for gate signals, 0x00 = 0 us */
-	gseqctr[0] = 0x00;
-	gseqctr[1] = 0x00;
 	ret = nt35510_send_long(nt, dsi, NT35510_P0_GSEQCTR,
 				NT35510_P0_GSEQCTR_LEN,
-				gseqctr);
+				conf->gseqctr);
 	if (ret)
 		return ret;
 
@@ -896,7 +976,6 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
 	 */
 	dsi->hs_rate = 349440000;
 	dsi->lp_rate = 9600000;
-	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
 	/*
 	 * Every new incarnation of this display must have a unique
@@ -908,6 +987,8 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
 		return -ENODEV;
 	}
 
+	dsi->mode_flags = nt->conf->mode_flags;
+
 	nt->supplies[0].supply = "vdd"; /* 2.3-4.8 V */
 	nt->supplies[1].supply = "vddi"; /* 1.65-3.3V */
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(nt->supplies),
@@ -1030,6 +1111,7 @@ static const struct nt35510_config nt35510_hydis_hva40wv1 = {
 		.vtotal = 800 + 2 + 0 + 5, /* VBP = 5 */
 		.flags = 0,
 	},
+	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS,
 	/* 0x09: AVDD = 5.6V */
 	.avdd = { 0x09, 0x09, 0x09 },
 	/* 0x34: PCK = Hsync/2, BTP = 2 x VDDB */
@@ -1050,6 +1132,14 @@ static const struct nt35510_config nt35510_hydis_hva40wv1 = {
 	.vgp = { 0x00, 0xA3, 0x00 },
 	/* VGMP: 0x0A3 = 5.0375V, VGSP = 0V */
 	.vgn = { 0x00, 0xA3, 0x00 },
+	/* Enable TE, EoTP and RGB pixel format */
+	.dopctr = { NT35510_DOPCTR_0_DSITE | NT35510_DOPCTR_0_EOTP |
+		    NT35510_DOPCTR_0_N565, NT35510_DOPCTR_1_CTB },
+	.madctl = NT35510_ROTATE_180_SETTING,
+	/* 0x0A: SDT = 5 us */
+	.sdhdtctr = 0x0A,
+	/* EQ control for gate signals, 0x00 = 0 us */
+	.gseqctr = { 0x00, 0x00 },
 	/* SDEQCTR: source driver EQ mode 2, 2.5 us rise time on each step */
 	.sdeqctr = { 0x01, 0x05, 0x05, 0x05 },
 	/* SDVPCTR: Normal operation off color during v porch */
-- 
2.43.0


