Return-Path: <linux-kernel+bounces-134678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4C89B4CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D22A1F21322
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797734E1BE;
	Sun,  7 Apr 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="te8oMd0g"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DA45951
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712534039; cv=none; b=pO/PiX5JCmgkZ6j5LODEKzCERaWHGRnNFOpAmUek96g2p2nIp121JZXRDE+8bA9khev7Ey3GUvQBVbakFlmdrZg5pL6q9UH+/FFU2FWSv1eWRV9ySuMeol03CqMfvEaPpdNSZO1PLhLQ3n0KeheIv+YAtKZfx1c3AhtVQ60PnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712534039; c=relaxed/simple;
	bh=gZ2vNyEf3xtWpmG35b3OtW/LriwLRLam79OQMzrL4n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOolDruW2qLK/NrPgWOqFUwTuqs1Kc4JdG5CWu7dL6BIjRpMqFGHh+ENFZMOcQl3kl74WUgBbsLQPtQZb9BPWX5J5cWMEM6P+3QsJsqme5LUpBiO5uJTfji76htdQpRW4pb8TfgjxjCGPjX/eyv+lBbOeRAzFO16MQRz7jAiIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=te8oMd0g; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516cdb21b34so4835351e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 16:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712534035; x=1713138835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8cZ4HjrT4QF3C+ZxK/HOdz80vfMrRJrlKKl1sb7th0=;
        b=te8oMd0gdDQPQ40l9NC8gM6OAFHoQUKlKfzScLySf5S89fWvWlcJJ5bgf2to7ZTWR7
         A+MP36z/eMMluSdp9QgbiRf9dYti1qvQI6JAJxQT5fWfSzppm531JvnJSP808qaSiUSE
         rpPB4TMWu31ArYBEMKMkN9kD3fH/GWOan71oG73BsVwUlzqKgaTAcjvMIU3iPSIFdnxf
         XD4mvcQipnrHNkzR531PulvF6E0rgVDhFl1q0tvBQ7VlQWxJAvpxZeEWi0z405FqTJnQ
         jHaGWiH2p+S4aY+s9VCE8FCkXgkv9mFUt5RDKxDJ1eBrSm+pY+4dUfNc89Lxk2Ygs5Nk
         j0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712534035; x=1713138835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8cZ4HjrT4QF3C+ZxK/HOdz80vfMrRJrlKKl1sb7th0=;
        b=i0wblsrjBMMKjOf88fWmNtks1EBK9t9jEt2/575CsGpxFcc/bF7tkH1I6sgDumAeuG
         PfrlWAeKsX/zt6M20fXDaWahvZxQ/F/IVPkK/VaXR+XR7fh6KNPo3Xl2vzwm1FJ3jt5c
         zEr+qWLTdhIVzl49/2k1eFd71udCq1G36c3jhv/mjNw7SSj+aEeP/+ApqOKQJEjRhToZ
         U75rsm8kBFnJ5z23qWG3z1yQZyvmCBFEXwTNFLF+9ElhmsYqvFJEIcj8w7RbMkXtSXgM
         KprNS3d5U973sLYETFSRJCfBfI1T/yADdZ9esa/OTN2C7Kf/z6g0I3fXu3ijs6xiUJkp
         2ccw==
X-Forwarded-Encrypted: i=1; AJvYcCU8QvOv12prIcgA2P89+SDiyed5+WrmL5FNEIXMsm6eoy0xjmBOeBXZUmiw2t3TJWvBlok9zH9qM0fzSjmy7wjj54+nW6o+HTp8lvpD
X-Gm-Message-State: AOJu0YzSgKb9Fv7BwrY59dEyLJaKhQJ98ft6tNzHhfyFc54vy6C3MwqN
	w7Os3lsTfBxAXnxVjE/3i+FuirlJXIY7GAIOlfLtGf3hT00lYCF/EmGpvWb7kFUln2YCB+kxf/S
	/
X-Google-Smtp-Source: AGHT+IGiQL48SbF9mS4ZUaUS76FlhKARUM82x95vG2t1oJnSlY1a/ukS/BXqh/gz+PTf47yHFEXVhQ==
X-Received: by 2002:ac2:514c:0:b0:515:d0e6:a141 with SMTP id q12-20020ac2514c000000b00515d0e6a141mr4730217lfd.40.1712534034799;
        Sun, 07 Apr 2024 16:53:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b00516b07fdc26sm965696lfk.109.2024.04.07.16.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 16:53:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 02:53:53 +0300
Subject: [PATCH v5 4/4] drm: panel: Add LG sw43408 panel driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-lg-sw43408-panel-v5-4-4e092da22991@linaro.org>
References: <20240408-lg-sw43408-panel-v5-0-4e092da22991@linaro.org>
In-Reply-To: <20240408-lg-sw43408-panel-v5-0-4e092da22991@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12311;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rBO0yC8UpgMVwvLTQTxZhiafy7u8OGxH1e/YYI9RoRg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmEzIPVSR9B6y/jl9SjHHOD6e1y+5UOJtLZGSGE
 meJBTYYLU6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhMyDwAKCRCLPIo+Aiko
 1crWB/0c/JWNIrhM/3rJ8TpqKfuBOX5Ax4nmpJbllKt4HwF+rqaV88KP7T3TNVJ3m0ldFDwJI+A
 1PvXReP1ttFEVQBP+4zvIqyzgP1t6xkQmRjU5BA/CoNkd7bXQa4fZv1ckXuwbarQxT9mh9ATq/H
 iBbq7AeHdEVOUJ13Mb8wXipLLC3Dw5rXmLF5efIXQW7uxy5aYwyZ1aztb8XUowcLpqGgmeykVQE
 VCxVTNdzNOAQHRcijy1NMmim3ShqhGleyIh6oSqIOVOSxLJTR6UnC/qW1T6WCT998RnMejCWEpn
 Vr37VHvuOxak5wyLN17EHFEUtHUAi3Mtd3Lkn05qhyczpjbT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

From: Sumit Semwal <sumit.semwal@linaro.org>

LG SW43408 is 1080x2160@60Hz, 4-lane MIPI-DSI panel, used in some
Google Pixel-3 phones.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
[vinod: Add DSC support]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[caleb: cleanup and support turning off the panel]
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
[DB: partially rewrote the driver and fixed DSC programming]
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS                              |   8 +
 drivers/gpu/drm/panel/Kconfig            |  11 ++
 drivers/gpu/drm/panel/Makefile           |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 323 +++++++++++++++++++++++++++++++
 4 files changed, 343 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d36c19c1bf81..4cc43c16e07e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6789,6 +6789,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
 F:	drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
 
+DRM DRIVER FOR LG SW43408 PANELS
+M:	Sumit Semwal <sumit.semwal@linaro.org>
+M:	Caleb Connolly <caleb.connolly@linaro.org>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
+F:	drivers/gpu/drm/panel/panel-lg-sw43408.c
+
 DRM DRIVER FOR LOGICVC DISPLAY CONTROLLER
 M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
 S:	Supported
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 6dc451f58a3e..4dc435fd9a44 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -335,6 +335,17 @@ config DRM_PANEL_LG_LG4573
 	  Say Y here if you want to enable support for LG4573 RGB panel.
 	  To compile this driver as a module, choose M here.
 
+config DRM_PANEL_LG_SW43408
+	tristate "LG SW43408 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for LG sw43408 panel.
+	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per
+	  pixel. It provides a MIPI DSI interface to the host and has a
+	  built-in LED backlight.
+
 config DRM_PANEL_MAGNACHIP_D53E6EA8966
 	tristate "Magnachip D53E6EA8966 DSI panel"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 24a02655d726..0b40b010e8e7 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
 obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
 obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
+obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
 obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
 obj-$(CONFIG_DRM_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
 obj-$(CONFIG_DRM_PANEL_NEWVISION_NV3051D) += panel-newvision-nv3051d.o
diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
new file mode 100644
index 000000000000..bd9706ae7615
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019-2024 Linaro Ltd
+ * Author: Sumit Semwal <sumit.semwal@linaro.org>
+ *	 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+
+#define NUM_SUPPLIES 2
+
+struct sw43408_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *link;
+
+	struct regulator_bulk_data supplies[NUM_SUPPLIES];
+
+	struct gpio_desc *reset_gpio;
+
+	struct drm_dsc_config dsc;
+};
+
+static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
+{
+	return container_of(panel, struct sw43408_panel, base);
+}
+
+static int sw43408_unprepare(struct drm_panel *panel)
+{
+	struct sw43408_panel *ctx = to_panel_info(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->link);
+	if (ret < 0)
+		dev_err(panel->dev, "set_display_off cmd failed ret = %d\n", ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->link);
+	if (ret < 0)
+		dev_err(panel->dev, "enter_sleep cmd failed ret = %d\n", ret);
+
+	msleep(100);
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+}
+
+static int sw43408_program(struct drm_panel *panel)
+{
+	struct sw43408_panel *ctx = to_panel_info(panel);
+	struct drm_dsc_picture_parameter_set pps;
+
+	mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
+
+	mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+
+	mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
+	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
+
+	mipi_dsi_dcs_exit_sleep_mode(ctx->link);
+
+	msleep(135);
+
+	/* COMPRESSION_MODE moved after setting the PPS */
+
+	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xac);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xe5,
+			       0x00, 0x3a, 0x00, 0x3a, 0x00, 0x0e, 0x10);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xb5,
+			       0x75, 0x60, 0x2d, 0x5d, 0x80, 0x00, 0x0a, 0x0b,
+			       0x00, 0x05, 0x0b, 0x00, 0x80, 0x0d, 0x0e, 0x40,
+			       0x00, 0x0c, 0x00, 0x16, 0x00, 0xb8, 0x00, 0x80,
+			       0x0d, 0x0e, 0x40, 0x00, 0x0c, 0x00, 0x16, 0x00,
+			       0xb8, 0x00, 0x81, 0x00, 0x03, 0x03, 0x03, 0x01,
+			       0x01);
+	msleep(85);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xcd,
+			       0x00, 0x00, 0x00, 0x19, 0x19, 0x19, 0x19, 0x19,
+			       0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19,
+			       0x16, 0x16);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xc0, 0x02, 0x02, 0x0f);
+	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
+	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
+
+	mipi_dsi_dcs_set_display_on(ctx->link);
+
+	msleep(50);
+
+	ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
+	mipi_dsi_picture_parameter_set(ctx->link, &pps);
+
+	ctx->link->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	/*
+	 * This panel uses PPS selectors with offset:
+	 * PPS 1 if pps_identifier is 0
+	 * PPS 2 if pps_identifier is 1
+	 */
+	mipi_dsi_compression_mode_ext(ctx->link, true,
+				      MIPI_DSI_COMPRESSION_DSC, 1);
+
+
+	return 0;
+}
+
+static int sw43408_prepare(struct drm_panel *panel)
+{
+	struct sw43408_panel *ctx = to_panel_info(panel);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(5000, 6000);
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(9000, 10000);
+	gpiod_set_value(ctx->reset_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(9000, 10000);
+
+	ret = sw43408_program(panel);
+	if (ret)
+		goto poweroff;
+
+	return 0;
+
+poweroff:
+	gpiod_set_value(ctx->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	return ret;
+}
+
+static const struct drm_display_mode sw43408_mode = {
+	.clock = (1080 + 20 + 32 + 20) * (2160 + 20 + 4 + 20) * 60 / 1000,
+
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 20,
+	.hsync_end = 1080 + 20 + 32,
+	.htotal = 1080 + 20 + 32 + 20,
+
+	.vdisplay = 2160,
+	.vsync_start = 2160 + 20,
+	.vsync_end = 2160 + 20 + 4,
+	.vtotal = 2160 + 20 + 4 + 20,
+
+	.width_mm = 62,
+	.height_mm = 124,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int sw43408_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &sw43408_mode);
+}
+
+static int sw43408_backlight_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	uint16_t brightness = backlight_get_brightness(bl);
+
+	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+}
+
+const struct backlight_ops sw43408_backlight_ops = {
+	.update_status = sw43408_backlight_update_status,
+};
+
+static int sw43408_backlight_init(struct sw43408_panel *ctx)
+{
+	struct device *dev = &ctx->link->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_PLATFORM,
+		.brightness = 255,
+		.max_brightness = 255,
+	};
+
+	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
+							ctx->link,
+							&sw43408_backlight_ops,
+							&props);
+
+	if (IS_ERR(ctx->base.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->base.backlight),
+				     "Failed to create backlight\n");
+
+	return 0;
+}
+
+static const struct drm_panel_funcs sw43408_funcs = {
+	.unprepare = sw43408_unprepare,
+	.prepare = sw43408_prepare,
+	.get_modes = sw43408_get_modes,
+};
+
+static const struct of_device_id sw43408_of_match[] = {
+	{ .compatible = "lg,sw43408", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sw43408_of_match);
+
+static int sw43408_add(struct sw43408_panel *ctx)
+{
+	struct device *dev = &ctx->link->dev;
+	int ret;
+
+	ctx->supplies[0].supply = "vddi"; /* 1.88 V */
+	ctx->supplies[0].init_load_uA = 62000;
+	ctx->supplies[1].supply = "vpnl"; /* 3.0 V */
+	ctx->supplies[1].init_load_uA = 857000;
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		dev_err(dev, "cannot get reset gpio %ld\n",
+			      PTR_ERR(ctx->reset_gpio));
+		return PTR_ERR(ctx->reset_gpio);
+	}
+
+	ret = sw43408_backlight_init(ctx);
+	if (ret < 0)
+		return ret;
+
+	ctx->base.prepare_prev_first = true;
+
+	drm_panel_init(&ctx->base, dev, &sw43408_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	drm_panel_add(&ctx->base);
+	return ret;
+}
+
+static int sw43408_probe(struct mipi_dsi_device *dsi)
+{
+	struct sw43408_panel *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	dsi->mode_flags = MIPI_DSI_MODE_LPM;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	ctx->link = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ret = sw43408_add(ctx);
+	if (ret < 0)
+		return ret;
+
+	/* The panel works only in the DSC mode. Set DSC params. */
+	ctx->dsc.dsc_version_major = 0x1;
+	ctx->dsc.dsc_version_minor = 0x1;
+
+	/* slice_count * slice_width == width */
+	ctx->dsc.slice_height = 16;
+	ctx->dsc.slice_width = 540;
+	ctx->dsc.slice_count = 2;
+	ctx->dsc.bits_per_component = 8;
+	ctx->dsc.bits_per_pixel = 8 << 4;
+	ctx->dsc.block_pred_enable = true;
+
+	dsi->dsc = &ctx->dsc;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static void sw43408_remove(struct mipi_dsi_device *dsi)
+{
+	struct sw43408_panel *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = sw43408_unprepare(&ctx->base);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to unprepare panel: %d\n",
+			      ret);
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->base);
+}
+
+static struct mipi_dsi_driver sw43408_driver = {
+	.driver = {
+		.name = "panel-lg-sw43408",
+		.of_match_table = sw43408_of_match,
+	},
+	.probe = sw43408_probe,
+	.remove = sw43408_remove,
+};
+module_mipi_dsi_driver(sw43408_driver);
+
+MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
+MODULE_DESCRIPTION("LG SW436408 MIPI-DSI LED panel");
+MODULE_LICENSE("GPL");

-- 
2.39.2


