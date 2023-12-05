Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84A80514C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbjLEKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346801AbjLEKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:54:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300E1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:54:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1c7b20f895so50510866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701773654; x=1702378454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XKeSnE1o1bVHtCvXc9BPZG1WDGDESQII0YlQSzaFMY=;
        b=mUlud3NzcRNm3I2H9C/46qx5rpLSyU9fwJo1T0E/hfG1cin9oRE3cbpZj5CDOuv2M0
         vdL5OA/MJ/rD1sREG6jbWfvVXBgyC14T9d02ZwS961lRbsjJEYsnx4kNylxzsvxssaf+
         Plc+TQokc/SML027Fa+fzGWkgFgwp2TABVUlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773654; x=1702378454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XKeSnE1o1bVHtCvXc9BPZG1WDGDESQII0YlQSzaFMY=;
        b=Q/+3FJk/kZyILt31hjuq6mUmkfolqRhuNZ+GZFpE8bavZ2K81l9TC0aePNJ5hiFPss
         wjEbvR+jcv7wsycgRXyNFHBSgc4rNDQAWgZY7HiZ5d8xP/yFCcGgoNw4iD6m1lJsqQ4I
         jOD3EA7JPfw5IqDYuPMZ6FhQGBdY2mc8qw9tzg+2lhpo/kHI/L5IBo+2IJGXu8w3xDrL
         zw48gby9Mi/Z3P6nwDVNI+J8XLA1GPe2zBddxbdpCL8An/tIAK3vZiCH8qissnSgGqoJ
         o+kRw0arbvhVx07bObtD7lwjVH44tHmD+uDyNqlYxZXzX1afBKU8n5S+JrKgrdryiCmu
         IWZw==
X-Gm-Message-State: AOJu0YzMX92y2UkfiwSNNNWqA45BwsDmyYOE4DR393PxEaSz1j7Mkehy
        IbRgE4u0J+xSOStbwE2LNTBvuWNoB5cmBjAIYp62Rg==
X-Google-Smtp-Source: AGHT+IEyxg6cFIuwPR8KPrHo26U1Lfl945XCHFUNx8NMkh1S/1HWEsns0iGYdQWzgxBPqDCOaLSgAA==
X-Received: by 2002:a17:906:c4d1:b0:a19:a1ba:8ce4 with SMTP id cl17-20020a170906c4d100b00a19a1ba8ce4mr3247255ejb.130.1701773654190;
        Tue, 05 Dec 2023 02:54:14 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906089700b0099297782aa9sm6413491eje.49.2023.12.05.02.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:54:13 -0800 (PST)
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
Subject: [PATCH v4 08/10] drm/panel: Add Ilitek ILI9805 panel driver
Date:   Tue,  5 Dec 2023 11:52:55 +0100
Message-ID: <20231205105341.4100896-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
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

The GPM1790A0 panel is based on the Ilitek ILI9805 Controller.
Add a driver for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Remove duplicated code for prepare/unprepare callbacks

 MAINTAINERS                                  |   6 +
 drivers/gpu/drm/panel/Kconfig                |   9 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 353 +++++++++++++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9805.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b82dc141d209..4dccc72a0ed6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6646,6 +6646,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
 F:	drivers/gpu/drm/tiny/ili9486.c
 
+DRM DRIVER FOR ILITEK ILI9805 PANELS
+M:	Michael Trimarchi <michael@amarulasolutions.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
+F:	drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+
 DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
 M:	Jagan Teki <jagan@edgeble.ai>
 S:	Maintained
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d018702be3dc..dad938cf6dec 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -194,6 +194,15 @@ config DRM_PANEL_ILITEK_ILI9341
 	  QVGA (240x320) RGB panels. support serial & parallel rgb
 	  interface.
 
+config DRM_PANEL_ILITEK_ILI9805
+	tristate "Ilitek ILI9805-based panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Ilitek ILI9805 controller.
+
 config DRM_PANEL_ILITEK_ILI9881C
 	tristate "Ilitek ILI9881C-based panels"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f267d932c2b5..d94a644d0a6c 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
+obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) += panel-ilitek-ili9882t.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) += panel-innolux-ej030na.o
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
new file mode 100644
index 000000000000..e36984b46e14
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BSH Hausgerate GmbH
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+#define ILI9805_EXTCMD_CMD_SET_ENABLE_REG	(0xff)
+#define ILI9805_SETEXTC_PARAMETER1		(0xff)
+#define ILI9805_SETEXTC_PARAMETER2		(0x98)
+#define ILI9805_SETEXTC_PARAMETER3		(0x05)
+
+#define ILI9805_INSTR(_delay, ...) { \
+		.delay = (_delay), \
+		.len = sizeof((u8[]) {__VA_ARGS__}), \
+		.data = (u8[]){__VA_ARGS__} \
+	}
+
+struct ili9805_instr {
+	size_t len;
+	const u8 *data;
+	u32 delay;
+};
+
+struct ili9805_desc {
+	const char *name;
+	const struct ili9805_instr *init;
+	const size_t init_length;
+	const struct drm_display_mode *mode;
+	u32 width_mm;
+	u32 height_mm;
+};
+
+struct ili9805 {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+	const struct ili9805_desc	*desc;
+
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset_gpio;
+};
+
+static const struct ili9805_instr gpm1780a0_init[] = {
+	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
+		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
+	ILI9805_INSTR(100, 0xFD, 0x0F, 0x10, 0x44, 0x00),
+	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
+		      0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00),
+	ILI9805_INSTR(0, 0xB8, 0x62),
+	ILI9805_INSTR(0, 0xF1, 0x00),
+	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
+	ILI9805_INSTR(0, 0xF3, 0x60, 0x83, 0x04),
+	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
+	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
+	ILI9805_INSTR(0, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
+		      0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
+	ILI9805_INSTR(0, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
+		      0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
+	ILI9805_INSTR(10, 0xc1, 0x13, 0x39, 0x19, 0x06),
+	ILI9805_INSTR(10, 0xc7, 0xe5),
+	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
+	ILI9805_INSTR(10, 0xB4, 0x02),
+	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
+	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x08),
+	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
+	ILI9805_INSTR(0, 0x20),
+	ILI9805_INSTR(0, 0xB0, 0x01),
+	ILI9805_INSTR(0, 0xB6, 0x31, 0x00, 0xef),
+	ILI9805_INSTR(0, 0xDF, 0x23),
+	ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
+};
+
+static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
+{
+	return container_of(panel, struct ili9805, panel);
+}
+
+static int ili9805_power_on(struct ili9805 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret) {
+		dev_err(dev, "Failed to enable avdd regulator (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(ctx->dvdd);
+	if (ret) {
+		dev_err(dev, "Failed to enable dvdd regulator (%d)\n", ret);
+		regulator_disable(ctx->avdd);
+		return ret;
+	}
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(5000, 10000);
+	gpiod_set_value(ctx->reset_gpio, 1);
+	msleep(120);
+
+	return 0;
+}
+
+static int ili9805_power_off(struct ili9805 *ctx)
+{
+	gpiod_set_value(ctx->reset_gpio, 0);
+	regulator_disable(ctx->dvdd);
+	regulator_disable(ctx->avdd);
+
+	return 0;
+}
+
+static int ili9805_activate(struct ili9805 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int i, ret;
+
+	for (i = 0; i < ctx->desc->init_length; i++) {
+		const struct ili9805_instr *instr = &ctx->desc->init[i];
+
+		ret = mipi_dsi_dcs_write_buffer(ctx->dsi, instr->data, instr->len);
+		if (ret < 0)
+			return ret;
+
+		if (instr->delay > 0)
+			msleep(instr->delay);
+	}
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
+	if (ret) {
+		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
+		return ret;
+	}
+
+	usleep_range(5000, 6000);
+
+	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
+	if (ret) {
+		dev_err(dev, "Failed to set display ON (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ili9805_prepare(struct drm_panel *panel)
+{
+	struct ili9805 *ctx = panel_to_ili9805(panel);
+	int ret;
+
+	ret = ili9805_power_on(ctx);
+	if (ret)
+		return ret;
+
+	ret = ili9805_activate(ctx);
+	if (ret) {
+		ili9805_power_off(ctx);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ili9805_deactivate(struct ili9805 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
+		return ret;
+	}
+
+	usleep_range(5000, 10000);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ili9805_unprepare(struct drm_panel *panel)
+{
+	struct ili9805 *ctx = panel_to_ili9805(panel);
+
+	ili9805_deactivate(ctx);
+	ili9805_power_off(ctx);
+
+	return 0;
+}
+
+static const struct drm_display_mode gpm1780a0_timing = {
+	.clock = 26227,
+
+	.hdisplay = 480,
+	.hsync_start = 480 + 10,
+	.hsync_end = 480 + 10 + 2,
+	.htotal = 480 + 10 + 2 + 36,
+
+	.vdisplay = 480,
+	.vsync_start = 480 + 2,
+	.vsync_end = 480 + 10 + 4,
+	.vtotal = 480 + 2 + 4 + 10,
+};
+
+static int ili9805_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	struct ili9805 *ctx = panel_to_ili9805(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, ctx->desc->mode);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			ctx->desc->mode->hdisplay,
+			ctx->desc->mode->vdisplay,
+			drm_mode_vrefresh(ctx->desc->mode));
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs ili9805_funcs = {
+	.prepare	= ili9805_prepare,
+	.unprepare	= ili9805_unprepare,
+	.get_modes	= ili9805_get_modes,
+};
+
+static int ili9805_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct ili9805 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+	ctx->desc = of_device_get_match_data(&dsi->dev);
+
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
+		MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->lanes = 2;
+
+	drm_panel_init(&ctx->panel, &dsi->dev, &ili9805_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
+	if (IS_ERR(ctx->dvdd))
+		return PTR_ERR(ctx->dvdd);
+	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd))
+		return PTR_ERR(ctx->avdd);
+
+	ctx->reset_gpio = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(ctx->reset_gpio);
+	}
+
+	ctx->panel.prepare_prev_first = true;
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(&dsi->dev, "mipi_dsi_attach failed: %d\n", ret);
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct ili9805 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
+			ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct ili9805_desc gpm1780a0_desc = {
+	.init = gpm1780a0_init,
+	.init_length = ARRAY_SIZE(gpm1780a0_init),
+	.mode = &gpm1780a0_timing,
+	.width_mm = 65,
+	.height_mm = 65,
+};
+
+static const struct of_device_id ili9805_of_match[] = {
+	{ .compatible = "giantplus,gpm1790a0", .data = &gpm1780a0_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ili9805_of_match);
+
+static struct mipi_dsi_driver ili9805_dsi_driver = {
+	.probe		= ili9805_dsi_probe,
+	.remove		= ili9805_dsi_remove,
+	.driver = {
+		.name		= "ili9805-dsi",
+		.of_match_table	= ili9805_of_match,
+	},
+};
+module_mipi_dsi_driver(ili9805_dsi_driver);
+
+MODULE_AUTHOR("Matthias Proske <Matthias.Proske@bshg.com>");
+MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
+MODULE_DESCRIPTION("Ilitek ILI9805 Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

