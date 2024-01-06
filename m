Return-Path: <linux-kernel+bounces-18455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFC825DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935221F24441
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC41FDC;
	Sat,  6 Jan 2024 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIwsRip3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87715B3;
	Sat,  6 Jan 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bb0ab8e79fso7420539f.1;
        Fri, 05 Jan 2024 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704506197; x=1705110997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSNtUaXH8CsrOUD7vBJgXlkIJaay0K5bfffGKlF06l4=;
        b=JIwsRip37rCb73wLu2eTcaz3naPfinni+BAILP+6MPTB9O5txLs/wrH9n0XPT4gAQH
         //2xNiNKSAjWSVcgsY6XwAOumwc1xcT/0gjzVMXLaD51HilkVMs0G/eMzP3xipVBxRnZ
         XXFnxteuW/J/n5p9OENxTYVOiizFdHjeEZG5Wv+vfnLtEVWTrLxOEyQjoeyyFP85/7cZ
         PHfbUmX9eSMNBfq3nO4Kqlb5iovkte8gRiTZtSDqU0Fb9n6wpuaDmqJdQBoXAKEuf0ox
         os/d0GQW+2WLQBV6i5G+BlCXLKSVbjK6UPvdrzfApfCizRKCNwF37xr/yKMqnUbViApI
         jh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704506197; x=1705110997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSNtUaXH8CsrOUD7vBJgXlkIJaay0K5bfffGKlF06l4=;
        b=ob3o3mMq9D7OiNEOofJhrB1LACR3Iw+xp9/AjfnskhvaO2cRbnv/rTF9NjrVO2+VUx
         /fk9+jtyBDulk6jg11TF2wrY7x8mNuASIbyJ9aHqMweKyym/n5GmEyUvRju5Y+y8nz8M
         WOFnCN16gvltghh7hOM1FOaGVKYdpD+odBQxu2aOL9tD8IaDApXWfoXVcnP7QFut6G31
         q9Ce2sIYeiGacXS7A8EyejFt3jpz1RedC7CMzPm0PaIidgzlrk7EaJzm/MXHLzvXc9Cd
         +OFcqVzZe6pbRP9fVyijc8Yu5dAyVt8Oli7zGMhp7NOR3VGFi1yuUY4U1kreg+dePYWl
         DKMg==
X-Gm-Message-State: AOJu0Yzpin4h3VvRlIPcUXBG3RuXXo8b5xHPfELAEO9zibhDlWNoGM+L
	ccxfzlbL+CzBcV+P3XzMEvE=
X-Google-Smtp-Source: AGHT+IFhd6gVH6NfUiOMCuUlLtRXmzdMYmmDt/VTrPmYDlgAo8IWUORSYOMXEZUQXBm0FbBHWn8cJA==
X-Received: by 2002:a05:6602:14ce:b0:7bc:17b2:e500 with SMTP id b14-20020a05660214ce00b007bc17b2e500mr656690iow.4.1704506197259;
        Fri, 05 Jan 2024 17:56:37 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:df15:214a:36d9:2326])
        by smtp.gmail.com with ESMTPSA id ci13-20020a0566383d8d00b0046e06d79884sm459581jab.26.2024.01.05.17.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 17:56:36 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Marek Vasut <marex@denx.de>,
	Richard Leitner <richard.leitner@skidata.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Fabio Estevam <festevam@gmail.com>,
	Adam Ford <aford173@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/2] drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
Date: Fri,  5 Jan 2024 19:56:22 -0600
Message-ID: <20240106015623.193503-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106015623.193503-1-aford173@gmail.com>
References: <20240106015623.193503-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

This IP block is found in the HDMI subsystem of the i.MX8MP SoC. It has a
full timing generator and can switch between different video sources. On
the i.MX8MP however the only supported source is the LCDIF. The block
just needs to be powered up and told about the polarity of the video
sync signals to act in bypass mode.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
Tested-by: Marek Vasut <marex@denx.de> (v1)
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> (v2)
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> (v3)
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---

V5:  I (Adam) tried to help move this along, so I took Lucas' patch and
     attempted to apply fixes based on feedback.  I don't have
     all the history, so apologies for that.
     No changes from V4 to V5

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 5a4f3d58501e..a4d13331e320 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -3,6 +3,13 @@ if ARCH_MXC || COMPILE_TEST
 config DRM_IMX_LDB_HELPER
 	tristate
 
+config DRM_IMX8MP_HDMI_PVI
+	tristate "Freescale i.MX8MP HDMI PVI bridge support"
+	depends on OF
+	help
+	  Choose this to enable support for the internal HDMI TX Parallel
+	  Video Interface found on the Freescale i.MX8MP SoC.
+
 config DRM_IMX8QM_LDB
 	tristate "Freescale i.MX8QM LVDS display bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
index 2b0c2e44aa1b..e2c2106509fa 100644
--- a/drivers/gpu/drm/bridge/imx/Makefile
+++ b/drivers/gpu/drm/bridge/imx/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_DRM_IMX_LDB_HELPER) += imx-ldb-helper.o
+obj-$(CONFIG_DRM_IMX8MP_HDMI_PVI) += imx8mp-hdmi-pvi.o
 obj-$(CONFIG_DRM_IMX8QM_LDB) += imx8qm-ldb.o
 obj-$(CONFIG_DRM_IMX8QXP_LDB) += imx8qxp-ldb.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) += imx8qxp-pixel-combiner.o
diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
new file mode 100644
index 000000000000..9efe051a1e31
--- /dev/null
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright (C) 2022 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_crtc.h>
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
+
+#define HTX_PVI_CTRL			0x0
+#define  PVI_CTRL_OP_VSYNC_POL		BIT(18)
+#define  PVI_CTRL_OP_HSYNC_POL		BIT(17)
+#define  PVI_CTRL_OP_DE_POL		BIT(16)
+#define  PVI_CTRL_INP_VSYNC_POL		BIT(14)
+#define  PVI_CTRL_INP_HSYNC_POL		BIT(13)
+#define  PVI_CTRL_INP_DE_POL		BIT(12)
+#define  PVI_CTRL_MODE_MASK		GENMASK(2, 1)
+#define  PVI_CTRL_MODE_LCDIF		2
+#define  PVI_CTRL_EN			BIT(0)
+
+struct imx8mp_hdmi_pvi {
+	struct drm_bridge	bridge;
+	struct device		*dev;
+	struct drm_bridge	*next_bridge;
+	void __iomem		*regs;
+};
+
+static inline struct imx8mp_hdmi_pvi *
+to_imx8mp_hdmi_pvi(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct imx8mp_hdmi_pvi, bridge);
+}
+
+static int imx8mp_hdmi_pvi_bridge_attach(struct drm_bridge *bridge,
+					 enum drm_bridge_attach_flags flags)
+{
+	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
+
+	return drm_bridge_attach(bridge->encoder, pvi->next_bridge,
+				 bridge, flags);
+}
+
+static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
+					  struct drm_bridge_state *bridge_state)
+{
+	struct drm_atomic_state *state = bridge_state->base.state;
+	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
+	struct drm_connector_state *conn_state;
+	const struct drm_display_mode *mode;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	u32 bus_flags, val;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+
+	if (WARN_ON(pm_runtime_resume_and_get(pvi->dev)))
+		return;
+
+	mode = &crtc_state->adjusted_mode;
+
+	val = FIELD_PREP(PVI_CTRL_MODE_MASK, PVI_CTRL_MODE_LCDIF) | PVI_CTRL_EN;
+
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		val |= PVI_CTRL_OP_VSYNC_POL | PVI_CTRL_INP_VSYNC_POL;
+
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		val |= PVI_CTRL_OP_HSYNC_POL | PVI_CTRL_INP_HSYNC_POL;
+
+	if (pvi->next_bridge->timings)
+		bus_flags = pvi->next_bridge->timings->input_bus_flags;
+	else if (bridge_state)
+		bus_flags = bridge_state->input_bus_cfg.flags;
+
+	if (bus_flags & DRM_BUS_FLAG_DE_HIGH)
+		val |= PVI_CTRL_OP_DE_POL | PVI_CTRL_INP_DE_POL;
+
+	writel(val, pvi->regs + HTX_PVI_CTRL);
+}
+
+static void imx8mp_hdmi_pvi_bridge_disable(struct drm_bridge *bridge,
+					   struct drm_bridge_state *bridge_state)
+{
+	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
+
+	writel(0x0, pvi->regs + HTX_PVI_CTRL);
+
+	pm_runtime_put(pvi->dev);
+}
+
+static u32 *
+imx8mp_hdmi_pvi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
+					  struct drm_bridge_state *bridge_state,
+					  struct drm_crtc_state *crtc_state,
+					  struct drm_connector_state *conn_state,
+					  u32 output_fmt,
+					  unsigned int *num_input_fmts)
+{
+	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
+	struct drm_bridge *next_bridge = pvi->next_bridge;
+	struct drm_bridge_state *next_state;
+
+	if (!next_bridge->funcs->atomic_get_input_bus_fmts)
+		return 0;
+
+	next_state = drm_atomic_get_new_bridge_state(crtc_state->state,
+						     next_bridge);
+
+	return next_bridge->funcs->atomic_get_input_bus_fmts(next_bridge,
+							     next_state,
+							     crtc_state,
+							     conn_state,
+							     output_fmt,
+							     num_input_fmts);
+}
+
+static const struct drm_bridge_funcs imx_hdmi_pvi_bridge_funcs = {
+	.attach		= imx8mp_hdmi_pvi_bridge_attach,
+	.atomic_enable	= imx8mp_hdmi_pvi_bridge_enable,
+	.atomic_disable	= imx8mp_hdmi_pvi_bridge_disable,
+	.atomic_get_input_bus_fmts = imx8mp_hdmi_pvi_bridge_get_input_bus_fmts,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+};
+
+static int imx8mp_hdmi_pvi_probe(struct platform_device *pdev)
+{
+	struct device_node *remote;
+	struct imx8mp_hdmi_pvi *pvi;
+
+	pvi = devm_kzalloc(&pdev->dev, sizeof(*pvi), GFP_KERNEL);
+	if (!pvi)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pvi);
+	pvi->dev = &pdev->dev;
+
+	pvi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pvi->regs))
+		return PTR_ERR(pvi->regs);
+
+	/* Get the next bridge in the pipeline. */
+	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
+	if (!remote)
+		return -EINVAL;
+
+	pvi->next_bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
+
+	if (!pvi->next_bridge)
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				     "could not find next bridge\n");
+
+	pm_runtime_enable(&pdev->dev);
+
+	/* Register the bridge. */
+	pvi->bridge.funcs = &imx_hdmi_pvi_bridge_funcs;
+	pvi->bridge.of_node = pdev->dev.of_node;
+	pvi->bridge.timings = pvi->next_bridge->timings;
+
+	drm_bridge_add(&pvi->bridge);
+
+	return 0;
+}
+
+static int imx8mp_hdmi_pvi_remove(struct platform_device *pdev)
+{
+	struct imx8mp_hdmi_pvi *pvi = platform_get_drvdata(pdev);
+
+	drm_bridge_remove(&pvi->bridge);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id imx8mp_hdmi_pvi_match[] = {
+	{
+		.compatible = "fsl,imx8mp-hdmi-pvi",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx8mp_hdmi_pvi_match);
+
+static struct platform_driver imx8mp_hdmi_pvi_driver = {
+	.probe	= imx8mp_hdmi_pvi_probe,
+	.remove	= imx8mp_hdmi_pvi_remove,
+	.driver		= {
+		.name = "imx-hdmi-pvi",
+		.of_match_table	= imx8mp_hdmi_pvi_match,
+	},
+};
+module_platform_driver(imx8mp_hdmi_pvi_driver);
+
+MODULE_DESCRIPTION("i.MX8MP HDMI TX Parallel Video Interface bridge driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


