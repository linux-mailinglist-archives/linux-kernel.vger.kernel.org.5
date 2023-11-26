Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628297F938C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjKZPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKZPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:47:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BFE1BDC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a02d91ab199so465410766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013617; x=1701618417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erudOmqHwz7UV9hNO347ob72QzcGCkrlqg/uTC7nUp0=;
        b=QnyGuP4yffjebGnkBmWFFnZzklV6SDsDo1c3OT42R4ITQJLzVcSuJMJQ8+36JVXYAN
         orj04B13Ejwn5QEG/oH5R6k1YumAFTlZsPsL6b6z21Djwpl1ORNZMOe70t5fSh4mDSXL
         SR/DZSDTrkCwGBbbkJfAUdXlHzizty9N72H2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013617; x=1701618417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erudOmqHwz7UV9hNO347ob72QzcGCkrlqg/uTC7nUp0=;
        b=vo80q6qDGjZMAY7fWST+YkJL5AQpBSvj5jdiNz/I/rfdh8TK0GcEsVanXQHhu4U0sF
         iQxRrt2lRLuW54j+NpFpERoMdZbKbBygcBxXCmbL+rY5XLYN9O1LoxDHt+/YWbyOh7Yl
         bfPZSIgH48I53/elFkdV4vyzfNwjBq+n4BWcla3rCUKXuVz9gWrl79zmKGdTZ6l9/CdD
         Gpb6td+lQGGA0dNTVsvoY3PfOYn9B/9kDtUcIGDZaFOdB/s4dqqm07iP3amVTjW5PucY
         PvEEAjHEBVSVuwSL9jFExb2LrUOfRJ2lQG5UEyZEVn4e7cP6QkNZ5Knl1IUKfrWc9dZK
         vidw==
X-Gm-Message-State: AOJu0YxjxrVmAGXmTqpQeFNdZTYwXFoCwxkBqgNUUnk0xtw6qz61lIut
        1AzH/zKzyA/YHf24pOcBCmra/VWa1VM38IG0N88Kpw==
X-Google-Smtp-Source: AGHT+IEolIjfj9K8tJnalD1Fijw3whk9G8+iNU+MtvGcITwS/h/ousas+U1JY7dwgBKeGA09+E/IEA==
X-Received: by 2002:a17:906:131b:b0:a0f:42da:1710 with SMTP id w27-20020a170906131b00b00a0f42da1710mr449173ejb.59.1701013617161;
        Sun, 26 Nov 2023 07:46:57 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:56 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 10/11] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
Date:   Sun, 26 Nov 2023 16:45:02 +0100
Message-ID: <20231126154605.15767-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
References: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Tianma TM041XDHG01 utilizes the Ilitek ILI9805 controller.

Add this panel's initialzation sequence and timing to ILI9805 driver.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 749959e10d92..cd187b0b1998 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -89,6 +89,36 @@ static const struct ili9805_instr gpm1780a0_init[] = {
 	ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
 };
 
+static const struct ili9805_instr tm041xdhg01_init[] = {
+	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
+		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
+	ILI9805_INSTR(100, 0xFD, 0x0F, 0x13, 0x44, 0x00),
+	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
+		      0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01),
+	ILI9805_INSTR(0, 0xB8, 0x74),
+	ILI9805_INSTR(0, 0xF1, 0x00),
+	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
+	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
+	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
+	ILI9805_INSTR(0, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
+		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
+	ILI9805_INSTR(0, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
+		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
+	ILI9805_INSTR(10, 0xc1, 0x15, 0x03, 0x03, 0x31),
+	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
+	ILI9805_INSTR(10, 0xB4, 0x02),
+	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
+	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x0a),
+	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
+	ILI9805_INSTR(0, 0x20),
+	ILI9805_INSTR(0, 0xB0, 0x00),
+	ILI9805_INSTR(0, 0xB6, 0x01),
+	ILI9805_INSTR(0, 0xc2, 0x11),
+	ILI9805_INSTR(0, 0x51, 0xFF),
+	ILI9805_INSTR(0, 0x53, 0x24),
+	ILI9805_INSTR(0, 0x55, 0x00),
+};
+
 static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9805, panel);
@@ -239,6 +269,20 @@ static const struct drm_display_mode gpm1780a0_timing = {
 	.vtotal = 480 + 2 + 4 + 10,
 };
 
+static const struct drm_display_mode tm041xdhg01_timing = {
+	.clock = 26227,
+
+	.hdisplay = 480,
+	.hsync_start = 480 + 10,
+	.hsync_end = 480 + 10 + 2,
+	.htotal = 480 + 10 + 2 + 36,
+
+	.vdisplay = 768,
+	.vsync_start = 768 + 2,
+	.vsync_end = 768 + 10 + 4,
+	.vtotal = 768 + 2 + 4 + 10,
+};
+
 static int ili9805_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -343,8 +387,17 @@ static const struct ili9805_desc gpm1780a0_desc = {
 	.height_mm = 65,
 };
 
+static const struct ili9805_desc tm041xdhg01_desc = {
+	.init = tm041xdhg01_init,
+	.init_length = ARRAY_SIZE(tm041xdhg01_init),
+	.mode = &tm041xdhg01_timing,
+	.width_mm = 42,
+	.height_mm = 96,
+};
+
 static const struct of_device_id ili9805_of_match[] = {
 	{ .compatible = "giantplus,gpm1790a0", .data = &gpm1780a0_desc },
+	{ .compatible = "tianma,tm041xdhg01", .data = &tm041xdhg01_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ili9805_of_match);
-- 
2.42.0

