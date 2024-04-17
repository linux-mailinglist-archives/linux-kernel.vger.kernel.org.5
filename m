Return-Path: <linux-kernel+bounces-147860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7118A7AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BFE1F22125
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E3B674;
	Wed, 17 Apr 2024 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JTb4PoQ8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81994685;
	Wed, 17 Apr 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321762; cv=none; b=LvC+LFzuL6VOisIJbDCUtAP69FIBZx+JvhhZArG45+t5DyvQZvoh3iIMIfL4E2etAKvEuz1z2BPhP9IkX1IPHUDOwHs/2F4QAzJDFvNOhmbV1B3BNFUk4BpMQCXfpRXY1nroZCHzYhnAFt+3MX7KVhgtvd6Q0Qalk/gwwfMfQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321762; c=relaxed/simple;
	bh=iDEJkvcGZurxsFdQ+lxuLVkBWypAQLoLWAJ5Qob1Clk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcWYCsO5ig2sIVihUEbb8YMEHeGZTnnzzc/TW2QrykIRaqlKpe4DuOM+JceJOeBfIxSHXAKprXhK5C8AkrefAILpaZJ+dxVyt2PYUqqnYDyEuh5dlLuVtIMrvTvqKxnKJCDNNqwcZTHhcWCdMA8O2CloaxoMNmjpuTDgHV8hIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JTb4PoQ8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713321760; x=1744857760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDEJkvcGZurxsFdQ+lxuLVkBWypAQLoLWAJ5Qob1Clk=;
  b=JTb4PoQ8zV0sbjnPGxktBZrf8lUNRDxwyvVOz3qJJPfIAW6nl9v9QuFo
   1GJ4ocK8d7AIFJlFbTtMYXAYmiz2fL7nAEBnablRwMNkta3GauLlNl8dj
   OGujwag9k+iNCbrxwkJlXbIvZQ7rRvHUyXsf7GBxzB8td2LAy4vapfTOs
   e8O3ZF841z8z+dVAg+nU0j1gpuBI9PqtoD959fYhL46jRfmFqeGUlp9Jl
   B7c2cDpUyYCtHmSRd1OgbmAGvhviOiNNTzcIIQp6eHivNehHy5CotxrNy
   JHwzYDunSaK4ZDzMim8zL8+dagGV0rQE5XP9ZmRP8j0OvPbBrqDRdaEWi
   g==;
X-CSE-ConnectionGUID: rOmQUjIYQSOnYHCy61jG5w==
X-CSE-MsgGUID: OnqmvDjrQPquuangdwbz9w==
X-IronPort-AV: E=Sophos;i="6.07,207,1708412400"; 
   d="scan'208";a="21373555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 19:42:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 19:42:31 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 19:42:20 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <Dharma.B@microchip.com>, <andrzej.hajda@intel.com>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Manikandan.M@microchip.com>, <arnd@arndb.de>,
	<geert+renesas@glider.be>, <Jason@zx2c4.com>, <mpe@ellerman.id.au>,
	<gerg@linux-m68k.org>, <rdunlap@infradead.org>, <vbabka@suse.cz>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Dharma Balasubiramani
	<dharma.b@microchip.com>, Manikandan Muralidharan
	<manikandan.m@microchip.com>
Subject: [PATCH v6 2/4] drm/bridge: add lvds controller support for sam9x7
Date: Wed, 17 Apr 2024 08:11:35 +0530
Message-ID: <20240417024137.144727-3-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417024137.144727-1-dharma.b@microchip.com>
References: <20240417024137.144727-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a new LVDS controller driver for sam9x7 which does the following:
- Prepares and enables the LVDS Peripheral clock
- Defines its connector type as DRM_MODE_CONNECTOR_LVDS and adds itself
to the global bridge list.
- Identifies its output endpoint as panel and adds it to the encoder
display pipeline
- Enables the LVDS serializer

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changelog
v5 -> v6
- No Changes.
v4 -> v5
- Drop the unused variable 'format'.
- Use DRM wrapper for dev_err() to maintain uniformity.
- return -ENODEV instead of -EINVAL to maintain consistency with other DRM
  bridge drivers.
v3 -> v4
- No changes.
v2 ->v3
- Correct Typo error "serializer".
- Consolidate get() and prepare() functions and use devm_clk_get_prepared().
- Remove unused variable 'ret' in probe().
- Use devm_pm_runtime_enable() and drop the mchp_lvds_remove().
v1 -> v2
- Drop 'res' variable and combine two lines into one.
- Handle deferred probe properly, use dev_err_probe().
- Don't print anything on deferred probe. Dropped print.
- Remove the MODULE_ALIAS and add MODULE_DEVICE_TABLE().
- symbol 'mchp_lvds_driver' was not declared. It should be static.
---
 drivers/gpu/drm/bridge/Kconfig          |   7 +
 drivers/gpu/drm/bridge/Makefile         |   1 +
 drivers/gpu/drm/bridge/microchip-lvds.c | 228 ++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index efd996f6c138..889098e2d65f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -190,6 +190,13 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
 	  to DP++. This is used with the i.MX6 imx-ldb
 	  driver. You are likely to say N here.
 
+config DRM_MICROCHIP_LVDS_SERIALIZER
+	tristate "Microchip LVDS serializer support"
+	depends on OF
+	depends on DRM_ATMEL_HLCDC
+	help
+	  Support for Microchip's LVDS serializer.
+
 config DRM_NWL_MIPI_DSI
 	tristate "Northwest Logic MIPI DSI Host controller"
 	depends on DRM
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 017b5832733b..7df87b582dca 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
+obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
new file mode 100644
index 000000000000..149704f498a6
--- /dev/null
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
+ * Author: Dharma Balasubiramani <dharma.b@microchip.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_graph.h>
+#include <linux/pinctrl/devinfo.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+
+#define LVDS_POLL_TIMEOUT_MS 1000
+
+/* LVDSC register offsets */
+#define LVDSC_CR	0x00
+#define LVDSC_CFGR	0x04
+#define LVDSC_SR	0x0C
+#define LVDSC_WPMR	0xE4
+
+/* Bitfields in LVDSC_CR (Control Register) */
+#define LVDSC_CR_SER_EN	BIT(0)
+
+/* Bitfields in LVDSC_CFGR (Configuration Register) */
+#define LVDSC_CFGR_PIXSIZE_24BITS	0
+#define LVDSC_CFGR_DEN_POL_HIGH		0
+#define LVDSC_CFGR_DC_UNBALANCED	0
+#define LVDSC_CFGR_MAPPING_JEIDA	BIT(6)
+
+/*Bitfields in LVDSC_SR */
+#define LVDSC_SR_CS	BIT(0)
+
+/* Bitfields in LVDSC_WPMR (Write Protection Mode Register) */
+#define LVDSC_WPMR_WPKEY_MASK	GENMASK(31, 8)
+#define LVDSC_WPMR_WPKEY_PSSWD	0x4C5644
+
+struct mchp_lvds {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *pclk;
+	struct drm_panel *panel;
+	struct drm_bridge bridge;
+	struct drm_bridge *panel_bridge;
+};
+
+static inline struct mchp_lvds *bridge_to_lvds(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct mchp_lvds, bridge);
+}
+
+static inline u32 lvds_readl(struct mchp_lvds *lvds, u32 offset)
+{
+	return readl_relaxed(lvds->regs + offset);
+}
+
+static inline void lvds_writel(struct mchp_lvds *lvds, u32 offset, u32 val)
+{
+	writel_relaxed(val, lvds->regs + offset);
+}
+
+static void lvds_serialiser_on(struct mchp_lvds *lvds)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(LVDS_POLL_TIMEOUT_MS);
+
+	/* The LVDSC registers can only be written if WPEN is cleared */
+	lvds_writel(lvds, LVDSC_WPMR, (LVDSC_WPMR_WPKEY_PSSWD &
+				LVDSC_WPMR_WPKEY_MASK));
+
+	/* Wait for the status of configuration registers to be changed */
+	while (lvds_readl(lvds, LVDSC_SR) & LVDSC_SR_CS) {
+		if (time_after(jiffies, timeout)) {
+			DRM_DEV_ERROR(lvds->dev, "%s: timeout error\n",
+				      __func__);
+			return;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	/* Configure the LVDSC */
+	lvds_writel(lvds, LVDSC_CFGR, (LVDSC_CFGR_MAPPING_JEIDA |
+				LVDSC_CFGR_DC_UNBALANCED |
+				LVDSC_CFGR_DEN_POL_HIGH |
+				LVDSC_CFGR_PIXSIZE_24BITS));
+
+	/* Enable the LVDS serializer */
+	lvds_writel(lvds, LVDSC_CR, LVDSC_CR_SER_EN);
+}
+
+static int mchp_lvds_attach(struct drm_bridge *bridge,
+			    enum drm_bridge_attach_flags flags)
+{
+	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
+
+	bridge->encoder->encoder_type = DRM_MODE_ENCODER_LVDS;
+
+	return drm_bridge_attach(bridge->encoder, lvds->panel_bridge,
+				 bridge, flags);
+}
+
+static void mchp_lvds_enable(struct drm_bridge *bridge)
+{
+	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
+	int ret;
+
+	ret = clk_enable(lvds->pclk);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to enable lvds pclk %d\n", ret);
+		return;
+	}
+
+	ret = pm_runtime_get_sync(lvds->dev);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
+		clk_disable(lvds->pclk);
+		return;
+	}
+
+	lvds_serialiser_on(lvds);
+}
+
+static void mchp_lvds_disable(struct drm_bridge *bridge)
+{
+	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
+
+	pm_runtime_put(lvds->dev);
+	clk_disable(lvds->pclk);
+}
+
+static const struct drm_bridge_funcs mchp_lvds_bridge_funcs = {
+	.attach = mchp_lvds_attach,
+	.enable = mchp_lvds_enable,
+	.disable = mchp_lvds_disable,
+};
+
+static int mchp_lvds_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mchp_lvds *lvds;
+	struct device_node *port;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	lvds = devm_kzalloc(&pdev->dev, sizeof(*lvds), GFP_KERNEL);
+	if (!lvds)
+		return -ENOMEM;
+
+	lvds->dev = dev;
+
+	lvds->regs = devm_ioremap_resource(lvds->dev,
+			platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	if (IS_ERR(lvds->regs))
+		return PTR_ERR(lvds->regs);
+
+	lvds->pclk = devm_clk_get_prepared(lvds->dev, "pclk");
+	if (IS_ERR(lvds->pclk))
+		return dev_err_probe(lvds->dev, PTR_ERR(lvds->pclk),
+				"could not get pclk_lvds prepared\n");
+
+	port = of_graph_get_remote_node(dev->of_node, 1, 0);
+	if (!port) {
+		DRM_DEV_ERROR(dev,
+			      "can't find port point, please init lvds panel port!\n");
+		return -ENODEV;
+	}
+
+	lvds->panel = of_drm_find_panel(port);
+	of_node_put(port);
+
+	if (IS_ERR(lvds->panel))
+		return -EPROBE_DEFER;
+
+	lvds->panel_bridge = devm_drm_panel_bridge_add(dev, lvds->panel);
+
+	if (IS_ERR(lvds->panel_bridge))
+		return PTR_ERR(lvds->panel_bridge);
+
+	lvds->bridge.of_node = dev->of_node;
+	lvds->bridge.type = DRM_MODE_CONNECTOR_LVDS;
+	lvds->bridge.funcs = &mchp_lvds_bridge_funcs;
+
+	dev_set_drvdata(dev, lvds);
+	devm_pm_runtime_enable(dev);
+
+	drm_bridge_add(&lvds->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id mchp_lvds_dt_ids[] = {
+	{
+		.compatible = "microchip,sam9x75-lvds",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mchp_lvds_dt_ids);
+
+static struct platform_driver mchp_lvds_driver = {
+	.probe = mchp_lvds_probe,
+	.driver = {
+		   .name = "microchip-lvds",
+		   .of_match_table = mchp_lvds_dt_ids,
+	},
+};
+module_platform_driver(mchp_lvds_driver);
+
+MODULE_AUTHOR("Manikandan Muralidharan <manikandan.m@microchip.com>");
+MODULE_AUTHOR("Dharma Balasubiramani <dharma.b@microchip.com>");
+MODULE_DESCRIPTION("Low Voltage Differential Signaling Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


