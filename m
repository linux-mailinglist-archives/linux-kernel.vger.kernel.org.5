Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44819808A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443203AbjLGOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443366AbjLGOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:22:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25506273B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso10309771fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958659; x=1702563459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9POmGM8FFxQ0phKiYUCTqq/2h5caBL36ATB9vcbhedE=;
        b=UB5D7iytgjdf9HTk28WRv6tWXdJfpZVg00OQaQEEFmbMmlocnEYoK27AePWdJL5FVC
         zUnS0Sg4Q1xS4C4VvWzu7Wtqlsi28ujnBPiPvQWpudRER8C2kTbEWv7zEpG9HZ+RIN/q
         owuvMQPR+BXzoyKEmVm4BWR6uXzREqqiresYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958659; x=1702563459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9POmGM8FFxQ0phKiYUCTqq/2h5caBL36ATB9vcbhedE=;
        b=UD45zUc8Tl2W4Lj6J6P6NqbEDc8VpMt/TfZDLW4EIzXujCWG15scd+s5OzS5HVGgr+
         iDb3UbAF6G0k0l73CHjBvgOn55p/FvUD01E97GrWLgwqVkxFy2Jjk9nGWlumLbP3jV7p
         URL/bfwZuf9cgGmcq+mKSzHogwUSPe+oMYeAmEZoI0jPjjwHGywk0K/zYW4nJfMG/1td
         Huw7ejnRIopRXKyGjAsPtBI1amYCkuyE+HKM6vhdmHTgVHsAAmWkHBGDbCxa8WVng2Dn
         wdL/yBQ4Ucu5zBWMd3jfx0BOSlK7W/3ppTs6T522hMgAlIWJqvwZPBm6+zLgjvzA0Pmx
         3dLA==
X-Gm-Message-State: AOJu0YyDvQCCUXM29cCRd8A/kIvcwO1rftNxj6WsvdKfZWRw1PkNB46+
        FmCY/Ukj6bi+6K+IYJijCyBKF9o5iMRF/zGDEyTb8w==
X-Google-Smtp-Source: AGHT+IF0rcetHY7XsVlKyJSutTPF8Sf6dQa4iwg2cLSaJcL2XX0czyaRGE7Hi6uTkpbsEI6hj8mR0Q==
X-Received: by 2002:a2e:9194:0:b0:2c9:fc3b:da2b with SMTP id f20-20020a2e9194000000b002c9fc3bda2bmr1638701ljg.104.1701958658970;
        Thu, 07 Dec 2023 06:17:38 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:38 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 09/10] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
Date:   Thu,  7 Dec 2023 15:16:38 +0100
Message-ID: <20231207141723.108004-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v4)

Changes in v4:
- Add Reviewed-by tag of Neil Armstrong

 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index e36984b46e14..5054d1a2b2f5 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -87,6 +87,36 @@ static const struct ili9805_instr gpm1780a0_init[] = {
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
@@ -227,6 +257,20 @@ static const struct drm_display_mode gpm1780a0_timing = {
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
@@ -331,8 +375,17 @@ static const struct ili9805_desc gpm1780a0_desc = {
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
2.43.0

