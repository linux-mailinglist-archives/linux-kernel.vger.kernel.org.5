Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC91808A54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443349AbjLGOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443193AbjLGOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:22:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44AB26BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1915034144so127722566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958655; x=1702563455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVh6PC472lZgerr4mfywa9L9+B1rFGAMxmajJY6iaoU=;
        b=DPCdSiq4+9jLK+vE5Zge4QU6NmeQfxbFikCRSoAl17qLDo4jMf20nuhcSNNsLePsEx
         rgJODC/qtVVLXnuPK6WHEvKubhidPjVsX/1TRAm95twE/FukDvQjONcEULhw2BDqTnJl
         n+AS3Dzw00LYC8wSpKsaaMCedkquOA6SmvjpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958655; x=1702563455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVh6PC472lZgerr4mfywa9L9+B1rFGAMxmajJY6iaoU=;
        b=H1Pu5BP0ll+9CxEnyampTxHwc6X+kdpUUJQZkvq9C3/EN/Mer1uMSo9Y5aWyK8Q2yB
         6Obbqad/Rtu958ycMdAU8Trsc+6OX4dO20ewVBAwOmmubW3IjyBgfIDerybtQfU82Ssy
         MHeTMjUH6YQ9rOIB9zM6+3WOWkxqshYD+sNDIhVHfvg1AJI44vtfJ799gRUY5x8vvWVB
         /wNxpkOkgfiXmAeEQonhfkTlLTggAA9fP67M+821+QXqfKccgl2IWGai1K97KZUow3PI
         ftEBQrgP4WsU47qm0meqc9lXUpCsiX6emMl3w3Awp944xhPaCeYApKVoN7AOceY/fC/S
         SFMg==
X-Gm-Message-State: AOJu0YzayDHYKqRUl/3zQZt9hPQnMdlzDnEnS5LG0K8QD5etlzxZFutB
        +JSbBEIbVmKthfQ+Xfw7W/VBnkvSU0Vm4vdx7kkrsA==
X-Google-Smtp-Source: AGHT+IGf/RYHqcdtf29q3/P1QxGfbZeZlG37nkLhl6j9vIFOeWkhaVxG+g8PtgwlI6DtRPMM7i7NXg==
X-Received: by 2002:a17:907:9705:b0:9e7:d1ab:e90b with SMTP id jg5-20020a170907970500b009e7d1abe90bmr1777303ejc.19.1701958655536;
        Thu, 07 Dec 2023 06:17:35 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:35 -0800 (PST)
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
Subject: [PATCH v5 06/10] drm/panel: Add Synaptics R63353 panel driver
Date:   Thu,  7 Dec 2023 15:16:35 +0100
Message-ID: <20231207141723.108004-7-dario.binacchi@amarulasolutions.com>
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

The LS068B3SX02 panel is based on the Synaptics R63353 Controller.
Add a driver for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v5:
- Replace a 'return ret' with a 'goto fail' in the r63353_panel_activate()

Changes in v4:
- Set the reset gpio to low in a single operation
- Remove duplicated code for prepare/unprepare callbacks

Changes in v2:
- Adjust the timings of the panel reset

 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-synaptics-r63353.c    | 363 ++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-synaptics-r63353.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b73..b82dc141d209 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6874,6 +6874,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/ste,mcde.yaml
 F:	drivers/gpu/drm/mcde/
 
+DRM DRIVER FOR SYNAPTICS R63353 PANELS
+M:	Michael Trimarchi <michael@amarulasolutions.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
+F:	drivers/gpu/drm/panel/panel-synaptics-r63353.c
+
 DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 99e14dc212ec..d018702be3dc 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -735,6 +735,15 @@ config DRM_PANEL_SITRONIX_ST7789V
 	  Say Y here if you want to enable support for the Sitronix
 	  ST7789V controller for 240x320 LCD panels
 
+config DRM_PANEL_SYNAPTICS_R63353
+	tristate "Synaptics R63353-based panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Synaptics R63353 controller.
+
 config DRM_PANEL_SONY_ACX565AKM
 	tristate "Sony ACX565AKM panel"
 	depends on GPIOLIB && OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index d10c3de51c6d..f267d932c2b5 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LS060T1SX01) += panel-sharp-ls060t1sx01.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
+obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) += panel-synaptics-r63353.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
 obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) += panel-sony-td4353-jdi.o
 obj-$(CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521) += panel-sony-tulip-truly-nt35521.o
diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
new file mode 100644
index 000000000000..3f61fcdc550b
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics R63353 Controller driver
+ *
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
+#include <linux/media-bus-format.h>
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
+#define R63353_INSTR(...) { \
+		.len = sizeof((u8[]) {__VA_ARGS__}), \
+		.data = (u8[]){__VA_ARGS__} \
+	}
+
+struct r63353_instr {
+	size_t len;
+	const u8 *data;
+};
+
+static const struct r63353_instr sharp_ls068b3sx02_init[] = {
+	R63353_INSTR(0x51, 0xff),
+	R63353_INSTR(0x53, 0x0c),
+	R63353_INSTR(0x55, 0x00),
+	R63353_INSTR(0x84, 0x00),
+	R63353_INSTR(0x29),
+};
+
+struct r63353_desc {
+	const char *name;
+	const struct r63353_instr *init;
+	const size_t init_length;
+	const struct drm_display_mode *mode;
+	u32 width_mm;
+	u32 height_mm;
+};
+
+struct r63353_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *dsi;
+
+	struct gpio_desc *reset_gpio;
+	struct regulator *dvdd;
+	struct regulator *avdd;
+
+	struct r63353_desc *pdata;
+};
+
+static inline struct r63353_panel *to_r63353_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct r63353_panel, base);
+}
+
+static int r63353_panel_power_on(struct r63353_panel *rpanel)
+{
+	struct mipi_dsi_device *dsi = rpanel->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = regulator_enable(rpanel->avdd);
+	if (ret) {
+		dev_err(dev, "Failed to enable avdd regulator (%d)\n", ret);
+		return ret;
+	}
+
+	usleep_range(15000, 25000);
+
+	ret = regulator_enable(rpanel->dvdd);
+	if (ret) {
+		dev_err(dev, "Failed to enable dvdd regulator (%d)\n", ret);
+		regulator_disable(rpanel->avdd);
+		return ret;
+	}
+
+	usleep_range(300000, 350000);
+	gpiod_set_value(rpanel->reset_gpio, 1);
+	usleep_range(15000, 25000);
+
+	return 0;
+}
+
+static int r63353_panel_power_off(struct r63353_panel *rpanel)
+{
+	gpiod_set_value(rpanel->reset_gpio, 0);
+	regulator_disable(rpanel->dvdd);
+	regulator_disable(rpanel->avdd);
+
+	return 0;
+}
+
+static int r63353_panel_activate(struct r63353_panel *rpanel)
+{
+	struct mipi_dsi_device *dsi = rpanel->dsi;
+	struct device *dev = &dsi->dev;
+	int i, ret;
+
+	ret = mipi_dsi_dcs_soft_reset(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
+		goto fail;
+	}
+
+	usleep_range(15000, 17000);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
+		goto fail;
+	}
+
+	for (i = 0; i < rpanel->pdata->init_length; i++) {
+		const struct r63353_instr *instr = &rpanel->pdata->init[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, instr->data, instr->len);
+		if (ret < 0)
+			goto fail;
+	}
+
+	msleep(120);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
+		goto fail;
+	}
+
+	usleep_range(5000, 10000);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display ON (%d)\n", ret);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	gpiod_set_value(rpanel->reset_gpio, 0);
+
+	return ret;
+}
+
+static int r63353_panel_prepare(struct drm_panel *panel)
+{
+	struct r63353_panel *rpanel = to_r63353_panel(panel);
+	struct mipi_dsi_device *dsi = rpanel->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dev_dbg(dev, "Preparing\n");
+
+	ret = r63353_panel_power_on(rpanel);
+	if (ret)
+		return ret;
+
+	ret = r63353_panel_activate(rpanel);
+	if (ret) {
+		r63353_panel_power_off(rpanel);
+		return ret;
+	}
+
+	dev_dbg(dev, "Prepared\n");
+	return 0;
+}
+
+static int r63353_panel_deactivate(struct r63353_panel *rpanel)
+{
+	struct mipi_dsi_device *dsi = rpanel->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
+		return ret;
+	}
+
+	usleep_range(5000, 10000);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int r63353_panel_unprepare(struct drm_panel *panel)
+{
+	struct r63353_panel *rpanel = to_r63353_panel(panel);
+
+	r63353_panel_deactivate(rpanel);
+	r63353_panel_power_off(rpanel);
+
+	return 0;
+}
+
+static const struct drm_display_mode sharp_ls068b3sx02_timing = {
+	.clock = 70000,
+	.hdisplay = 640,
+	.hsync_start = 640 + 35,
+	.hsync_end = 640 + 35 + 2,
+	.htotal = 640 + 35 + 2 + 150,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 2,
+	.vsync_end = 1280 + 2 + 4,
+	.vtotal = 1280 + 2 + 4 + 0,
+};
+
+static int r63353_panel_get_modes(struct drm_panel *panel,
+				  struct drm_connector *connector)
+{
+	struct r63353_panel *rpanel = to_r63353_panel(panel);
+	struct drm_display_mode *mode;
+	static const u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+
+	mode = drm_mode_duplicate(connector->dev, rpanel->pdata->mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	connector->display_info.width_mm = rpanel->pdata->width_mm;
+	connector->display_info.height_mm = rpanel->pdata->height_mm;
+
+	drm_display_info_set_bus_formats(&connector->display_info,
+					 &bus_format, 1);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs r63353_panel_funcs = {
+	.prepare = r63353_panel_prepare,
+	.unprepare = r63353_panel_unprepare,
+	.get_modes = r63353_panel_get_modes,
+};
+
+static int r63353_panel_probe(struct mipi_dsi_device *dsi)
+{
+	int ret = 0;
+	struct device *dev = &dsi->dev;
+	struct r63353_panel *panel;
+
+	panel = devm_kzalloc(&dsi->dev, sizeof(*panel), GFP_KERNEL);
+	if (!panel)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, panel);
+	panel->dsi = dsi;
+	panel->pdata = (struct r63353_desc *)of_device_get_match_data(dev);
+
+	dev_info(dev, "Panel %s\n", panel->pdata->name);
+
+	dsi->lanes = 2;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
+			  MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_NO_EOT_PACKET;
+
+	panel->dvdd = devm_regulator_get(dev, "dvdd");
+	if (IS_ERR(panel->dvdd))
+		return PTR_ERR(panel->dvdd);
+	panel->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(panel->avdd))
+		return PTR_ERR(panel->avdd);
+
+	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(panel->reset_gpio)) {
+		dev_err(dev, "failed to get RESET GPIO\n");
+		return PTR_ERR(panel->reset_gpio);
+	}
+
+	drm_panel_init(&panel->base, dev, &r63353_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	panel->base.prepare_prev_first = true;
+	ret = drm_panel_of_backlight(&panel->base);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&panel->base);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
+		drm_panel_remove(&panel->base);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void r63353_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(dev, "Failed to detach from host (%d)\n", ret);
+
+	drm_panel_remove(&rpanel->base);
+}
+
+static void r63353_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
+
+	r63353_panel_unprepare(&rpanel->base);
+}
+
+static const struct r63353_desc sharp_ls068b3sx02_data = {
+	.name = "Sharp LS068B3SX02",
+	.mode = &sharp_ls068b3sx02_timing,
+	.init = sharp_ls068b3sx02_init,
+	.init_length = ARRAY_SIZE(sharp_ls068b3sx02_init),
+	.width_mm = 68,
+	.height_mm = 159,
+};
+
+static const struct of_device_id r63353_of_match[] = {
+	{ .compatible = "sharp,ls068b3sx02", .data = &sharp_ls068b3sx02_data },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, r63353_of_match);
+
+static struct mipi_dsi_driver r63353_panel_driver = {
+	.driver = {
+		   .name = "r63353-dsi",
+		   .of_match_table = r63353_of_match,
+	},
+	.probe = r63353_panel_probe,
+	.remove = r63353_panel_remove,
+	.shutdown = r63353_panel_shutdown,
+};
+
+module_mipi_dsi_driver(r63353_panel_driver);
+
+MODULE_AUTHOR("Matthias Proske <Matthias.Proske@bshg.com>");
+MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
+MODULE_DESCRIPTION("Synaptics R63353 Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

