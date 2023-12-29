Return-Path: <linux-kernel+bounces-13113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9C81FFDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A1C1F21E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8A11725;
	Fri, 29 Dec 2023 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CFfUtJ/W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206D134A9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccebd0377fso9287371fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703857949; x=1704462749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I04AycXU2gthDovU4fhTPLpGwaRhcBOoWll3dN0DmSw=;
        b=CFfUtJ/WP6Yl21Yn9J7mNsctuMeS7Mk8+AMzKP4/Q3Ap1JFStnfBnAK3ibgoHQj1vA
         BgGkgYTYF1YGK8bHv4+1ZAHLp/bMGNuivxRA/ozG0lFbOob+YGXrQMHNr85vgoHRTKyF
         MQSiu+VsZRE80Kst4ujygQnsc55v8sRHgv0Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703857949; x=1704462749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I04AycXU2gthDovU4fhTPLpGwaRhcBOoWll3dN0DmSw=;
        b=bBEtKFMeQhe5LTahgFYlQ5VPuTxjyvv6tP2JbiVxEND+s1n/bDrEH6R8Y9D1/WCsbb
         HRj+XDOqyndlwQdhjXklq2UgVdhzK3x8e4kPlVmbV03s2BnWxXfSmfLxpoaMCyUYDc/j
         2ABzetZuzV4RXPmrAm0MsqM2/mlIdVcJ2+9ZbSKOK+flZyhTd2zdp2UitbB34ogd3Ke8
         HgNgjooU3qLxjyVNy15XeeYajYhNgbzkwFXhpMhV8SL97BxTfrpOE1F84PQkrU/i5j/5
         mcVxMP3UiCYjAIf48ke5GGXjhOwiUUBhfxPpKCcmKSFiiyxLZ19czNDmj0/SKSK+zzwE
         8ocQ==
X-Gm-Message-State: AOJu0YwndEbWm1xtzgGUfvmEcDSYJv91A2ZcoWlLyWnDj5+4Qa3A1Izz
	VNhIugj1jfvveJps4s1Fqbh+xc9j9qf5RQckO7L1z4P/Q9o=
X-Google-Smtp-Source: AGHT+IHOtc5IkKmhCbd0Ze1jDDKCs0xUxs7gN1zGo15FKjOCb36qByeeIpxGR4YJYMTK8KBp1srJgg==
X-Received: by 2002:a2e:3c19:0:b0:2cc:df53:5309 with SMTP id j25-20020a2e3c19000000b002ccdf535309mr798204lja.91.1703857949279;
        Fri, 29 Dec 2023 05:52:29 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-49-57-70.retail.telecomitalia.it. [79.49.57.70])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c710000000b00553b243b1a8sm11019160edq.92.2023.12.29.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:52:28 -0800 (PST)
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
Subject: [PATCH 8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
Date: Fri, 29 Dec 2023 14:51:23 +0100
Message-ID: <20231229135154.675946-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialization commands are taken from the STMicroelectronics driver
found at https://github.com/STMicroelectronics/STM32CubeF7/blob/master/Drivers/BSP/Components/nt35510/

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 2a5a624fe447..3cdcc75c4c76 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Novatek NT35510 panel driver
+ * Copyright (C) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Add support to Frida FRD400B25025-A-CTK panel.
+ * Based on code by MCD Application Team (C) 2020 STMicroelectronics
  * Copyright (C) 2020 Linus Walleij <linus.walleij@linaro.org>
  * Based on code by Robert Teather (C) 2012 Samsung
  *
@@ -165,6 +168,49 @@ static const struct panel_init_cmd hydis_hva40wv1_init_cmds[] = {
 	{},
 };
 
+static const struct panel_init_cmd frida_frd400b25025_init_cmds[] = {
+	_INIT_DCS_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x01),
+	_INIT_DCS_CMD(0xB0, 0x03, 0x03, 0x03),
+	_INIT_DCS_CMD(0xB6, 0x46, 0x46, 0x46),
+	_INIT_DCS_CMD(0xB1, 0x03, 0x03, 0x03),
+	_INIT_DCS_CMD(0xB7, 0x36, 0x36, 0x36),
+	_INIT_DCS_CMD(0xB2, 0x00, 0x00, 0x02),
+	_INIT_DCS_CMD(0xB8, 0x26, 0x26, 0x26),
+	_INIT_DCS_CMD(0xBF, 0x01),
+	_INIT_DCS_CMD(0xB3, 0x09, 0x09, 0x09),
+	_INIT_DCS_CMD(0xB9, 0x36, 0x36, 0x36),
+	_INIT_DCS_CMD(0xB5, 0x08, 0x08, 0x08),
+	_INIT_DCS_CMD(0xBA, 0x26, 0x26, 0x26),
+	_INIT_DCS_CMD(0xBC, 0x00, 0x80, 0x00),
+	_INIT_DCS_CMD(0xBD, 0x00, 0x80, 0x00),
+	_INIT_DCS_CMD(0xBE, 0x00, 0x50),
+	_INIT_DCS_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x00),
+	_INIT_DCS_CMD(0xB1, 0xFC, 0x00),
+	_INIT_DCS_CMD(0xB6, 0x03),
+	_INIT_DCS_CMD(0xB5, 0x50),
+	_INIT_DCS_CMD(0xB7, 0x00, 0x00),
+	_INIT_DCS_CMD(0xB8, 0x01, 0x02, 0x02, 0x02),
+	_INIT_DCS_CMD(0xBC, 0x00, 0x00, 0x00),
+	_INIT_DCS_CMD(0xCC, 0x03, 0x00, 0x00),
+	_INIT_DCS_CMD(0xBA, 0x01),
+	_INIT_DCS_CMD(0x35, 0x00),
+	_INIT_DCS_CMD(0x3A, 0x77),
+	_INIT_DELAY_CMD(0xC8),
+	_INIT_DCS_CMD(0x36, 0x00),
+	_INIT_DCS_CMD(0x2A, 0x00, 0x00, 0x01, 0xDF),
+	_INIT_DCS_CMD(0x2B, 0x00, 0x00, 0x03, 0x1F),
+	_INIT_DCS_CMD(0x11),
+	_INIT_DELAY_CMD(0x78),
+	_INIT_DCS_CMD(0x3A, 0x77),
+	_INIT_DCS_CMD(0x51, 0x7F, 0x00),
+	_INIT_DCS_CMD(0x53, 0x2C),
+	_INIT_DCS_CMD(0x55, 0x02),
+	_INIT_DCS_CMD(0x5E, 0xFF),
+	_INIT_DCS_CMD(0x29),
+	_INIT_DCS_CMD(0x2C),
+	{},
+};
+
 /**
  * struct nt35510 - state container for the NT35510 panel
  */
@@ -606,7 +652,36 @@ static const struct nt35510_config nt35510_hydis_hva40wv1 = {
 	.init_cmds = hydis_hva40wv1_init_cmds,
 };
 
+/*
+ * The Frida FRD400B25025-A-CTK panel
+ */
+static const struct nt35510_config nt35510_frida_frd400b25025 = {
+	.width_mm = 52,
+	.height_mm = 86,
+	.mode = {
+		.clock = 23000,
+		.hdisplay = 480,
+		.hsync_start = 480 + 34, /* HFP = 34 */
+		.hsync_end = 480 + 34 + 2, /* HSync = 2 */
+		.htotal = 480 + 34 + 2 + 34, /* HBP = 34 */
+		.vdisplay = 800,
+		.vsync_start = 800 + 15, /* VFP = 15 */
+		.vsync_end = 800 + 15 + 12, /* VSync = 12 */
+		.vtotal = 800 + 15 + 12 + 15, /* VBP = 15 */
+		.flags = 0,
+	},
+	.lanes = 2,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			MIPI_DSI_MODE_LPM,
+	.init_cmds = frida_frd400b25025_init_cmds,
+};
+
 static const struct of_device_id nt35510_of_match[] = {
+	{
+		.compatible = "frida,frd400b25025",
+		.data = &nt35510_frida_frd400b25025,
+	},
 	{
 		.compatible = "hydis,hva40wv1",
 		.data = &nt35510_hydis_hva40wv1,
-- 
2.43.0


