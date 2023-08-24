Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F35786949
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjHXICI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Aug 2023 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjHXIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:01:23 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D70D1709;
        Thu, 24 Aug 2023 01:01:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3E2C824E33B;
        Thu, 24 Aug 2023 16:01:12 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Aug
 2023 16:01:12 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Aug
 2023 16:01:11 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <jack.zhu@starfivetech.com>, <changhuang.liang@starfivetech.com>
Subject: [PATCH v8 3/8] media: staging: media: starfive: camss: Add core driver
Date:   Thu, 24 Aug 2023 16:01:04 +0800
Message-ID: <20230824080109.89613-4-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824080109.89613-1-jack.zhu@starfivetech.com>
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core driver for StarFive Camera Subsystem. The code parses
the device platform resources and registers related devices.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 MAINTAINERS                                   |   1 +
 drivers/staging/media/Kconfig                 |   2 +
 drivers/staging/media/Makefile                |   1 +
 drivers/staging/media/starfive/Kconfig        |   5 +
 drivers/staging/media/starfive/Makefile       |   2 +
 drivers/staging/media/starfive/camss/Kconfig  |  17 +
 drivers/staging/media/starfive/camss/Makefile |   9 +
 .../staging/media/starfive/camss/stf_camss.c  | 316 ++++++++++++++++++
 .../staging/media/starfive/camss/stf_camss.h  | 129 +++++++
 9 files changed, 482 insertions(+)
 create mode 100644 drivers/staging/media/starfive/Kconfig
 create mode 100644 drivers/staging/media/starfive/Makefile
 create mode 100644 drivers/staging/media/starfive/camss/Kconfig
 create mode 100644 drivers/staging/media/starfive/camss/Makefile
 create mode 100644 drivers/staging/media/starfive/camss/stf_camss.c
 create mode 100644 drivers/staging/media/starfive/camss/stf_camss.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c63c0a85301..97d3054416ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20258,6 +20258,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+F:	drivers/staging/media/starfive/camss
 
 STARFIVE CRYPTO DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index bc6c7b248f86..554c2e475ce3 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -36,6 +36,8 @@ source "drivers/staging/media/omap4iss/Kconfig"
 
 source "drivers/staging/media/rkvdec/Kconfig"
 
+source "drivers/staging/media/starfive/Kconfig"
+
 source "drivers/staging/media/sunxi/Kconfig"
 
 source "drivers/staging/media/tegra-video/Kconfig"
diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index 1a4c3a062e3d..dcaeeca0ee6d 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_VIDEO_MAX96712)	+= max96712/
 obj-$(CONFIG_VIDEO_MESON_VDEC)	+= meson/vdec/
 obj-$(CONFIG_VIDEO_OMAP4)	+= omap4iss/
 obj-$(CONFIG_VIDEO_ROCKCHIP_VDEC)	+= rkvdec/
+obj-$(CONFIG_VIDEO_STARFIVE_CAMSS)	+= starfive/
 obj-$(CONFIG_VIDEO_SUNXI)	+= sunxi/
 obj-$(CONFIG_VIDEO_TEGRA)	+= tegra-video/
 obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
diff --git a/drivers/staging/media/starfive/Kconfig b/drivers/staging/media/starfive/Kconfig
new file mode 100644
index 000000000000..34727cf56072
--- /dev/null
+++ b/drivers/staging/media/starfive/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+comment "StarFive media platform drivers"
+
+source "drivers/staging/media/starfive/camss/Kconfig"
diff --git a/drivers/staging/media/starfive/Makefile b/drivers/staging/media/starfive/Makefile
new file mode 100644
index 000000000000..4639fa1bca32
--- /dev/null
+++ b/drivers/staging/media/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += camss/
diff --git a/drivers/staging/media/starfive/camss/Kconfig b/drivers/staging/media/starfive/camss/Kconfig
new file mode 100644
index 000000000000..8d20e2bd2559
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_STARFIVE_CAMSS
+	tristate "Starfive Camera Subsystem driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && OF
+	depends on HAS_DMA
+	depends on PM
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	   Enable this to support for the Starfive Camera subsystem
+	   found on Starfive JH7110 SoC.
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called stf-camss.
diff --git a/drivers/staging/media/starfive/camss/Makefile b/drivers/staging/media/starfive/camss/Makefile
new file mode 100644
index 000000000000..f53c5cbe958f
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for StarFive Camera Subsystem driver
+#
+
+starfive-camss-objs += \
+		stf_camss.o
+
+obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
diff --git a/drivers/staging/media/starfive/camss/stf_camss.c b/drivers/staging/media/starfive/camss/stf_camss.c
new file mode 100644
index 000000000000..75ebc3a35218
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf_camss.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_camss.c
+ *
+ * Starfive Camera Subsystem driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jack Zhu <jack.zhu@starfivetech.com>
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ *
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mc.h>
+
+#include "stf_camss.h"
+
+static const char * const stfcamss_clocks[] = {
+	"clk_wrapper_clk_c",
+	"clk_ispcore_2x",
+	"clk_isp_axi",
+};
+
+static const char * const stfcamss_resets[] = {
+	"rst_wrapper_p",
+	"rst_wrapper_c",
+	"rst_axiwr",
+	"rst_isp_top_n",
+	"rst_isp_top_axi",
+};
+
+static int stfcamss_get_mem_res(struct stfcamss *stfcamss)
+{
+	struct platform_device *pdev = to_platform_device(stfcamss->dev);
+
+	stfcamss->syscon_base =
+		devm_platform_ioremap_resource_byname(pdev, "syscon");
+	if (IS_ERR(stfcamss->syscon_base))
+		return PTR_ERR(stfcamss->syscon_base);
+
+	stfcamss->isp_base = devm_platform_ioremap_resource_byname(pdev, "isp");
+	if (IS_ERR(stfcamss->isp_base))
+		return PTR_ERR(stfcamss->isp_base);
+
+	return 0;
+}
+
+/*
+ * stfcamss_of_parse_endpoint_node - Parse port endpoint node
+ * @dev: Device
+ * @node: Device node to be parsed
+ * @csd: Parsed data from port endpoint node
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int stfcamss_of_parse_endpoint_node(struct stfcamss *stfcamss,
+					   struct device_node *node,
+					   struct stfcamss_async_subdev *csd)
+{
+	struct v4l2_fwnode_endpoint vep = { { 0 } };
+	int ret;
+
+	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	if (ret) {
+		dev_err(stfcamss->dev, "endpoint not defined at %pOF\n", node);
+		return ret;
+	}
+
+	csd->port = vep.base.port;
+
+	return 0;
+}
+
+/*
+ * stfcamss_of_parse_ports - Parse ports node
+ * @stfcamss: STFCAMSS device
+ *
+ * Return number of "port" nodes found in "ports" node
+ */
+static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
+{
+	struct device_node *node = NULL;
+	int ret, num_subdevs = 0;
+
+	for_each_endpoint_of_node(stfcamss->dev->of_node, node) {
+		struct stfcamss_async_subdev *csd;
+
+		if (!of_device_is_available(node))
+			continue;
+
+		csd = v4l2_async_nf_add_fwnode_remote(&stfcamss->notifier,
+						      of_fwnode_handle(node),
+						      struct stfcamss_async_subdev);
+		if (IS_ERR(csd)) {
+			ret = PTR_ERR(csd);
+			dev_err(stfcamss->dev, "failed to add async notifier\n");
+			v4l2_async_nf_cleanup(&stfcamss->notifier);
+			return ret;
+		}
+
+		ret = stfcamss_of_parse_endpoint_node(stfcamss, node, csd);
+		if (ret)
+			return ret;
+
+		num_subdevs++;
+	}
+
+	return num_subdevs;
+}
+
+static int stfcamss_subdev_notifier_complete(struct v4l2_async_notifier *ntf)
+{
+	struct stfcamss *stfcamss =
+		container_of(ntf, struct stfcamss, notifier);
+
+	return v4l2_device_register_subdev_nodes(&stfcamss->v4l2_dev);
+}
+
+static const struct v4l2_async_notifier_operations
+stfcamss_subdev_notifier_ops = {
+	.complete = stfcamss_subdev_notifier_complete,
+};
+
+static void stfcamss_mc_init(struct platform_device *pdev,
+			     struct stfcamss *stfcamss)
+{
+	stfcamss->media_dev.dev = stfcamss->dev;
+	strscpy(stfcamss->media_dev.model, "Starfive Camera Subsystem",
+		sizeof(stfcamss->media_dev.model));
+	media_device_init(&stfcamss->media_dev);
+
+	stfcamss->v4l2_dev.mdev = &stfcamss->media_dev;
+}
+
+/*
+ * stfcamss_probe - Probe STFCAMSS platform device
+ * @pdev: Pointer to STFCAMSS platform device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int stfcamss_probe(struct platform_device *pdev)
+{
+	struct stfcamss *stfcamss;
+	struct device *dev = &pdev->dev;
+	int ret, num_subdevs;
+	unsigned int i;
+
+	stfcamss = devm_kzalloc(dev, sizeof(*stfcamss), GFP_KERNEL);
+	if (!stfcamss)
+		return -ENOMEM;
+
+	stfcamss->dev = dev;
+
+	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
+	for (i = 0; i < stfcamss->nclks; ++i)
+		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
+	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
+	if (ret) {
+		dev_err(dev, "Failed to get clk controls\n");
+		return ret;
+	}
+
+	stfcamss->nrsts = ARRAY_SIZE(stfcamss->sys_rst);
+	for (i = 0; i < stfcamss->nrsts; ++i)
+		stfcamss->sys_rst[i].id = stfcamss_resets[i];
+	ret = devm_reset_control_bulk_get_shared(dev, stfcamss->nrsts,
+						 stfcamss->sys_rst);
+	if (ret) {
+		dev_err(dev, "Failed to get reset controls\n");
+		return ret;
+	}
+
+	ret = stfcamss_get_mem_res(stfcamss);
+	if (ret) {
+		dev_err(dev, "Could not map registers\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, stfcamss);
+
+	v4l2_async_nf_init(&stfcamss->notifier);
+
+	num_subdevs = stfcamss_of_parse_ports(stfcamss);
+	if (num_subdevs < 0) {
+		ret = -ENODEV;
+		dev_err(dev, "Failed to get sub devices: %d\n", ret);
+		goto err_cleanup_notifier;
+	}
+
+	stfcamss_mc_init(pdev, stfcamss);
+
+	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
+		goto err_cleanup_media_device;
+	}
+
+	ret = media_device_register(&stfcamss->media_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register media device: %d\n", ret);
+		goto err_unregister_device;
+	}
+
+	pm_runtime_enable(dev);
+
+	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
+	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
+	if (ret) {
+		dev_err(dev, "Failed to register async subdev nodes: %d\n",
+			ret);
+		pm_runtime_disable(dev);
+		goto err_unregister_media_dev;
+	}
+
+	return 0;
+
+err_unregister_media_dev:
+	media_device_unregister(&stfcamss->media_dev);
+err_unregister_device:
+	v4l2_device_unregister(&stfcamss->v4l2_dev);
+err_cleanup_media_device:
+	media_device_cleanup(&stfcamss->media_dev);
+err_cleanup_notifier:
+	v4l2_async_nf_cleanup(&stfcamss->notifier);
+	return ret;
+}
+
+/*
+ * stfcamss_remove - Remove STFCAMSS platform device
+ * @pdev: Pointer to STFCAMSS platform device
+ *
+ * Always returns 0.
+ */
+static int stfcamss_remove(struct platform_device *pdev)
+{
+	struct stfcamss *stfcamss = platform_get_drvdata(pdev);
+
+	v4l2_device_unregister(&stfcamss->v4l2_dev);
+	media_device_cleanup(&stfcamss->media_dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id stfcamss_of_match[] = {
+	{ .compatible = "starfive,jh7110-camss" },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, stfcamss_of_match);
+
+static int __maybe_unused stfcamss_runtime_suspend(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_bulk_assert(stfcamss->nrsts, stfcamss->sys_rst);
+	if (ret) {
+		dev_err(dev, "reset assert failed\n");
+		return ret;
+	}
+
+	clk_bulk_disable_unprepare(stfcamss->nclks, stfcamss->sys_clk);
+
+	return 0;
+}
+
+static int __maybe_unused stfcamss_runtime_resume(struct device *dev)
+{
+	struct stfcamss *stfcamss = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(stfcamss->nclks, stfcamss->sys_clk);
+	if (ret) {
+		dev_err(dev, "clock prepare enable failed\n");
+		return ret;
+	}
+
+	ret = reset_control_bulk_deassert(stfcamss->nrsts, stfcamss->sys_rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
+		clk_bulk_disable_unprepare(stfcamss->nclks, stfcamss->sys_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops stfcamss_pm_ops = {
+	SET_RUNTIME_PM_OPS(stfcamss_runtime_suspend,
+			   stfcamss_runtime_resume,
+			   NULL)
+};
+
+static struct platform_driver stfcamss_driver = {
+	.probe = stfcamss_probe,
+	.remove = stfcamss_remove,
+	.driver = {
+		.name = "starfive-camss",
+		.pm = &stfcamss_pm_ops,
+		.of_match_table = stfcamss_of_match,
+	},
+};
+
+module_platform_driver(stfcamss_driver);
+
+MODULE_AUTHOR("Jack Zhu <jack.zhu@starfivetech.com>");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive Camera Subsystem driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/starfive/camss/stf_camss.h b/drivers/staging/media/starfive/camss/stf_camss.h
new file mode 100644
index 000000000000..6110433e59f7
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf_camss.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_camss.h
+ *
+ * Starfive Camera Subsystem driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_CAMSS_H
+#define STF_CAMSS_H
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-device.h>
+
+enum stf_port_num {
+	STF_PORT_DVP = 0,
+	STF_PORT_CSI2RX
+};
+
+enum stf_clk {
+	STF_CLK_WRAPPER_CLK_C = 0,
+	STF_CLK_ISPCORE_2X,
+	STF_CLK_ISP_AXI,
+	STF_CLK_NUM
+};
+
+enum stf_rst {
+	STF_RST_WRAPPER_P = 0,
+	STF_RST_WRAPPER_C,
+	STF_RST_AXIWR,
+	STF_RST_ISP_TOP_N,
+	STF_RST_ISP_TOP_AXI,
+	STF_RST_NUM
+};
+
+struct stf_isr_data {
+	const char *name;
+	irqreturn_t (*isr)(int irq, void *priv);
+};
+
+struct stfcamss {
+	struct v4l2_device v4l2_dev;
+	struct media_device media_dev;
+	struct media_pipeline pipe;
+	struct device *dev;
+	struct v4l2_async_notifier notifier;
+	void __iomem *syscon_base;
+	void __iomem *isp_base;
+	struct clk_bulk_data sys_clk[STF_CLK_NUM];
+	int nclks;
+	struct reset_control_bulk_data sys_rst[STF_RST_NUM];
+	int nrsts;
+};
+
+struct stfcamss_async_subdev {
+	struct v4l2_async_subdev asd;  /* must be first */
+	enum stf_port_num port;
+};
+
+static inline u32 stf_isp_reg_read(struct stfcamss *stfcamss, u32 reg)
+{
+	return ioread32(stfcamss->isp_base + reg);
+}
+
+static inline void stf_isp_reg_write(struct stfcamss *stfcamss,
+				     u32 reg, u32 val)
+{
+	iowrite32(val, stfcamss->isp_base + reg);
+}
+
+static inline void stf_isp_reg_write_delay(struct stfcamss *stfcamss,
+					   u32 reg, u32 val, u32 delay)
+{
+	iowrite32(val, stfcamss->isp_base + reg);
+	usleep_range(1000 * delay, 1000 * delay + 100);
+}
+
+static inline void stf_isp_reg_set_bit(struct stfcamss *stfcamss,
+				       u32 reg, u32 mask, u32 val)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->isp_base + reg) & ~mask;
+	val &= mask;
+	val |= value;
+	iowrite32(val, stfcamss->isp_base + reg);
+}
+
+static inline void stf_isp_reg_set(struct stfcamss *stfcamss, u32 reg, u32 mask)
+{
+	iowrite32(ioread32(stfcamss->isp_base + reg) | mask,
+		  stfcamss->isp_base + reg);
+}
+
+static inline u32 stf_syscon_reg_read(struct stfcamss *stfcamss, u32 reg)
+{
+	return ioread32(stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_write(struct stfcamss *stfcamss,
+					u32 reg, u32 val)
+{
+	iowrite32(val, stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_set_bit(struct stfcamss *stfcamss,
+					  u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->syscon_base + reg);
+	iowrite32(value | bit_mask, stfcamss->syscon_base + reg);
+}
+
+static inline void stf_syscon_reg_clear_bit(struct stfcamss *stfcamss,
+					    u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(stfcamss->syscon_base + reg);
+	iowrite32(value & ~bit_mask, stfcamss->syscon_base + reg);
+}
+#endif /* STF_CAMSS_H */
-- 
2.34.1

