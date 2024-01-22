Return-Path: <linux-kernel+bounces-32521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81059835CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF91C1C21647
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8439860;
	Mon, 22 Jan 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aGcUNdpn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D93839A;
	Mon, 22 Jan 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912218; cv=none; b=tPpkAENMzcLfKGs/2tPhsGRlOWkO/x1QMLO7m2OtiqtXVHa90LOjU8R7ayjpv1g+ZOvY/KgSVXDhmjpYLOjeBIEblSrkWSmLBqjOKOn3RpP61EL3m1I/ef+YmJDVm0XvVnktxJJoRnvssJyG+nOSX7BIUFfv4/h6X27xCa2Ab+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912218; c=relaxed/simple;
	bh=lqB+rFrz8UHAATUAIntAyt5YG+K0J2b3zpuBhYbUSaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SY4a6PK3WZSYkUQGsYAmtjhfz/i6G9GeaH2kmJASifjwbSPZW4+6buLKHXJO7hvjEGCiGzgyMBPlIZP+ZsaUaQuow4rhrJXrByAYGvXFxCRBC8elUHQDBXWeymICq34Zm97Zxvrp4LBe5IHSTFpVV/ukws1abjZWU2tjd7xsuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aGcUNdpn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705912216; x=1737448216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqB+rFrz8UHAATUAIntAyt5YG+K0J2b3zpuBhYbUSaA=;
  b=aGcUNdpnSO5RJSVNGZ6PVCDaO0/fqH0xEnCU+KX6EaXQajMHytDUcods
   Kb9oc90T4Gbfdj2ts0jinS0pTvf9dfhpbmk8hAUcp7tYpkxV6JCq8J9Qy
   MEO2miHIPSS9vIoZlY0QkXTW7zXut/QJTZabIpyJ9VEpAvyev2W2ME5xh
   O1uStKpqrdzcUKpkEUz+2p3otYU4Vx/cW2G++ny3HkIVfHLe3oMi+SaKb
   1fw66gqHcV/wopzOr/zUz8QkijKc9ffTOLSZJ3InSebdruMONHZr2t5Kb
   +N/UkSGtsfqVuWfM+3/5cVwFxlSZ7QyVyYyRgSgHMAsAeKmJD0N/7I/Vp
   Q==;
X-CSE-ConnectionGUID: Rdeq91MiSf2exbg0h6qqSg==
X-CSE-MsgGUID: H633/nq9QU+/AjKWL5u8dg==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="15568732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 01:30:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:30:11 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 01:30:04 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <manikandan.m@microchip.com>, <dharma.b@microchip.com>,
	<andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux4microchip@microchip.com>
Subject: [PATCH 2/3] drm/bridge: add lvds controller support for sam9x7
Date: Mon, 22 Jan 2024 13:59:46 +0530
Message-ID: <20240122082947.21645-3-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122082947.21645-1-dharma.b@microchip.com>
References: <20240122082947.21645-1-dharma.b@microchip.com>
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
 drivers/gpu/drm/bridge/Kconfig          |   7 +
 drivers/gpu/drm/bridge/Makefile         |   1 +
 drivers/gpu/drm/bridge/microchip-lvds.c | 250 ++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3e6a4e2044c0..200afb36e421 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -173,6 +173,13 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
 	  to DP++. This is used with the i.MX6 imx-ldb
 	  driver. You are likely to say N here.
 
+config DRM_MICROCHIP_LVDS_SERIALIZER
+	tristate "Microchip LVDS serailzer support"
+	depends on OF
+	depends on DRM_ATMEL_HLCDC
+	help
+	  Support for Microchip's LVDS serializer.
+
 config DRM_NWL_MIPI_DSI
 	tristate "Northwest Logic MIPI DSI Host controller"
 	depends on DRM
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 2b892b7ed59e..e3804e93d324 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
+obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
new file mode 100644
index 000000000000..297f5ae514f6
--- /dev/null
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -0,0 +1,250 @@
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
+	int format; /* vesa or jeida format */
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
+			dev_err(lvds->dev, "%s: timeout error\n", __func__);
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
+	struct resource *res;
+	struct device_node *port;
+	int ret;
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lvds->regs = devm_ioremap_resource(lvds->dev, res);
+	if (IS_ERR(lvds->regs))
+		return PTR_ERR(lvds->regs);
+
+	lvds->pclk = devm_clk_get(lvds->dev, "pclk");
+	if (IS_ERR(lvds->pclk)) {
+		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
+		return PTR_ERR(lvds->pclk);
+	}
+
+	ret = clk_prepare(lvds->pclk);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to prepare pclk_lvds\n");
+		return ret;
+	}
+
+	port = of_graph_get_remote_node(dev->of_node, 1, 0);
+	if (!port) {
+		DRM_DEV_ERROR(dev,
+			      "can't find port point, please init lvds panel port!\n");
+		return -EINVAL;
+	}
+
+	lvds->panel = of_drm_find_panel(port);
+	of_node_put(port);
+
+	if (IS_ERR(lvds->panel)) {
+		DRM_DEV_ERROR(dev, "failed to find panel node\n");
+		return -EPROBE_DEFER;
+	}
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
+	pm_runtime_enable(dev);
+
+	drm_bridge_add(&lvds->bridge);
+
+	return 0;
+}
+
+static int mchp_lvds_remove(struct platform_device *pdev)
+{
+	struct mchp_lvds *lvds = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(lvds->pclk);
+
+	return 0;
+}
+
+static const struct of_device_id mchp_lvds_dt_ids[] = {
+	{
+		.compatible = "microchip,sam9x7-lvds",
+	},
+	{},
+};
+
+struct platform_driver mchp_lvds_driver = {
+	.probe = mchp_lvds_probe,
+	.remove = mchp_lvds_remove,
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
+MODULE_ALIAS("platform:microchip-lvds");
-- 
2.25.1


