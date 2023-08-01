Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AE376B084
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjHAKK6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjHAKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:10:40 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9ACA1;
        Tue,  1 Aug 2023 03:10:36 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F05678016;
        Tue,  1 Aug 2023 18:10:34 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Aug
 2023 18:10:35 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Aug
 2023 18:10:34 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Keith Zhao <keith.zhao@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 v1 5/7] drm/vs: Register DRM device
Date:   Tue, 1 Aug 2023 18:10:28 +0800
Message-ID: <20230801101030.2040-6-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801101030.2040-1-keith.zhao@starfivetech.com>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement drm device registration interface

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 drivers/gpu/drm/Kconfig                  |   2 +
 drivers/gpu/drm/Makefile                 |   1 +
 drivers/gpu/drm/verisilicon/Kconfig      |  25 ++
 drivers/gpu/drm/verisilicon/Makefile     |  13 +
 drivers/gpu/drm/verisilicon/vs_drv.c     | 273 +++++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_drv.h     |  54 ++++
 drivers/gpu/drm/verisilicon/vs_gem.c     | 298 +++++++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_gem.h     |  50 ++++
 drivers/gpu/drm/verisilicon/vs_modeset.c |  92 +++++++
 drivers/gpu/drm/verisilicon/vs_modeset.h |  13 +
 include/uapi/drm/vs_drm.h                |  50 ++++
 11 files changed, 871 insertions(+)
 create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/verisilicon/Makefile
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
 create mode 100644 include/uapi/drm/vs_drm.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index afb3b2f5f..9ede80ef9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -363,6 +363,8 @@ source "drivers/gpu/drm/solomon/Kconfig"
 
 source "drivers/gpu/drm/sprd/Kconfig"
 
+source "drivers/gpu/drm/verisilicon/Kconfig"
+
 config DRM_HYPERV
 	tristate "DRM Support for Hyper-V synthetic video device"
 	depends on DRM && PCI && MMU && HYPERV
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 7a09a89b4..6db3bc397 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -194,3 +194,4 @@ obj-y			+= gud/
 obj-$(CONFIG_DRM_HYPERV) += hyperv/
 obj-y			+= solomon/
 obj-$(CONFIG_DRM_SPRD) += sprd/
+obj-$(CONFIG_DRM_VERISILICON) += verisilicon/
diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
new file mode 100644
index 000000000..fcc39dded
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_VERISILICON
+	tristate "DRM Support for VeriSilicon"
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_GEM_DMA_HELPER
+	select CMA
+	select DMA_CMA
+	help
+	  Choose this option if you have a VeriSilicon soc chipset.
+	  This driver provides VeriSilicon kernel mode
+	  setting and buffer management. It does not
+	  provide 2D or 3D acceleration.
+
+if DRM_VERISILICON
+
+config STARFIVE_HDMI
+	bool "Starfive specific extensions HDMI"
+	help
+	   This selects support for StarFive SoC specific extensions
+	   for the Innosilicon HDMI driver. If you want to enable
+	   HDMI on JH7110 based SoC, you should select this option.
+
+	   To compile this driver as a module, choose M here.
+endif
diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
new file mode 100644
index 000000000..26cc7e21b
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+vs_drm-objs := vs_dc_hw.o \
+		vs_dc.o \
+		vs_crtc.o \
+		vs_drv.o \
+		vs_modeset.o \
+		vs_gem.o \
+		vs_plane.o
+
+vs_drm-$(CONFIG_STARFIVE_HDMI) += starfive_hdmi.o
+obj-$(CONFIG_DRM_VERISILICON) += vs_drm.o
+
diff --git a/drivers/gpu/drm/verisilicon/vs_drv.c b/drivers/gpu/drm/verisilicon/vs_drv.c
new file mode 100644
index 000000000..69591e640
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_drv.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/version.h>
+
+#include <drm/drm_aperture.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_file.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_of.h>
+#include <drm/drm_prime.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+
+#include "vs_drv.h"
+#include "vs_modeset.h"
+#include "vs_gem.h"
+
+#define DRV_NAME	"starfive"
+#define DRV_DESC	"Starfive DRM driver"
+#define DRV_DATE	"202305161"
+#define DRV_MAJOR	1
+#define DRV_MINOR	0
+
+static struct platform_driver vs_drm_platform_driver;
+
+static const struct file_operations fops = {
+	.owner			= THIS_MODULE,
+	.open			= drm_open,
+	.release		= drm_release,
+	.unlocked_ioctl	= drm_ioctl,
+	.compat_ioctl	= drm_compat_ioctl,
+	.poll			= drm_poll,
+	.read			= drm_read,
+	.mmap			= drm_gem_mmap,
+};
+
+static struct drm_driver vs_drm_driver = {
+	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
+	.lastclose		= drm_fb_helper_lastclose,
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_import_sg_table = vs_gem_prime_import_sg_table,
+	.gem_prime_mmap		= drm_gem_prime_mmap,
+	.dumb_create		= vs_gem_dumb_create,
+	.fops			= &fops,
+	.name			= DRV_NAME,
+	.desc			= DRV_DESC,
+	.date			= DRV_DATE,
+	.major			= DRV_MAJOR,
+	.minor			= DRV_MINOR,
+};
+
+void vs_drm_update_pitch_alignment(struct drm_device *drm_dev,
+				   unsigned int alignment)
+{
+	struct vs_drm_private *priv = to_vs_dev(drm_dev);
+
+	if (alignment > priv->pitch_alignment)
+		priv->pitch_alignment = alignment;
+}
+
+static int vs_drm_bind(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct vs_drm_private *priv;
+	int ret;
+	static u64 dma_mask = DMA_BIT_MASK(40);
+	struct drm_device *drm_dev;
+
+	/* Remove existing drivers that may own the framebuffer memory. */
+	ret = drm_aperture_remove_framebuffers(&vs_drm_driver);
+	if (ret) {
+		dev_err(dev,
+			    "Failed to remove existing framebuffers - %d.\n",
+			    ret);
+		return ret;
+	}
+
+	priv = devm_drm_dev_alloc(dev, &vs_drm_driver, struct vs_drm_private, base);
+		if (IS_ERR(priv))
+			return PTR_ERR(priv);
+
+	priv->pitch_alignment = 64;
+	priv->dma_dev = priv->base.dev;
+	priv->dma_dev->coherent_dma_mask = dma_mask;
+	drm_dev = &priv->base;
+	platform_set_drvdata(pdev, drm_dev);
+
+	vs_mode_config_init(drm_dev);
+
+	/* Now try and bind all our sub-components */
+	ret = component_bind_all(dev, drm_dev);
+	if (ret)
+		goto err_mode;
+
+	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
+	if (ret)
+		goto err_bind;
+
+	drm_mode_config_reset(drm_dev);
+
+	drm_kms_helper_poll_init(drm_dev);
+
+	ret = drm_dev_register(drm_dev, 0);
+	if (ret)
+		goto err_helper;
+
+	drm_fbdev_generic_setup(drm_dev, 32);
+
+	return 0;
+
+err_helper:
+	drm_kms_helper_poll_fini(drm_dev);
+err_bind:
+	component_unbind_all(drm_dev->dev, drm_dev);
+err_mode:
+	drm_mode_config_cleanup(drm_dev);
+
+	return ret;
+}
+
+static void vs_drm_unbind(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	drm_dev_unregister(drm_dev);
+
+	drm_kms_helper_poll_fini(drm_dev);
+
+	component_unbind_all(drm_dev->dev, drm_dev);
+}
+
+static const struct component_master_ops vs_drm_ops = {
+	.bind = vs_drm_bind,
+	.unbind = vs_drm_unbind,
+};
+
+static struct platform_driver *drm_sub_drivers[] = {
+
+
+	/* connector + encoder*/
+#ifdef CONFIG_STARFIVE_HDMI
+	&starfive_hdmi_driver,
+#endif
+
+};
+
+#define NUM_DRM_DRIVERS \
+	(sizeof(drm_sub_drivers) / sizeof(struct platform_driver *))
+
+static int compare_dev(struct device *dev, void *data)
+{
+	return dev == (struct device *)data;
+}
+
+static struct component_match *vs_drm_match_add(struct device *dev)
+{
+	struct component_match *match = NULL;
+	int i;
+
+	for (i = 0; i < NUM_DRM_DRIVERS; ++i) {
+		struct platform_driver *drv = drm_sub_drivers[i];
+		struct device *p = NULL, *d;
+
+		while ((d = platform_find_device_by_driver(p, &drv->driver))) {
+			put_device(p);
+
+			component_match_add(dev, &match, compare_dev, d);
+			p = d;
+		}
+		put_device(p);
+	}
+
+	return match ?: ERR_PTR(-ENODEV);
+}
+
+static int vs_drm_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct component_match *match;
+
+	match = vs_drm_match_add(dev);
+	if (IS_ERR(match))
+		return PTR_ERR(match);
+
+	return component_master_add_with_match(dev, &vs_drm_ops, match);
+}
+
+static int vs_drm_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &vs_drm_ops);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int vs_drm_suspend(struct device *dev)
+{
+	return drm_mode_config_helper_suspend(dev_get_drvdata(dev));
+}
+
+static int vs_drm_resume(struct device *dev)
+{
+	drm_mode_config_helper_resume(dev_get_drvdata(dev));
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(vs_drm_pm_ops, vs_drm_suspend, vs_drm_resume);
+
+static const struct of_device_id vs_drm_dt_ids[] = {
+	{ .compatible = "starfive,display-subsystem", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, vs_drm_dt_ids);
+
+static struct platform_driver vs_drm_platform_driver = {
+	.probe = vs_drm_platform_probe,
+	.remove = vs_drm_platform_remove,
+
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = vs_drm_dt_ids,
+		.pm = &vs_drm_pm_ops,
+	},
+};
+
+static int __init vs_drm_init(void)
+{
+	int ret;
+
+	ret = platform_register_drivers(drm_sub_drivers, NUM_DRM_DRIVERS);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&vs_drm_platform_driver);
+	if (ret)
+		platform_unregister_drivers(drm_sub_drivers, NUM_DRM_DRIVERS);
+
+	return ret;
+}
+
+static void __exit vs_drm_fini(void)
+{
+	platform_driver_unregister(&vs_drm_platform_driver);
+	platform_unregister_drivers(drm_sub_drivers, NUM_DRM_DRIVERS);
+}
+
+module_init(vs_drm_init);
+module_exit(vs_drm_fini);
+
+MODULE_DESCRIPTION("VeriSilicon DRM Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/verisilicon/vs_drv.h b/drivers/gpu/drm/verisilicon/vs_drv.h
new file mode 100644
index 000000000..6ddc99dcf
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_drv.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_DRV_H__
+#define __VS_DRV_H__
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/version.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_managed.h>
+
+/*
+ *
+ * @dma_dev: device for DMA API.
+ *	- use the first attached device if support iommu
+	else use drm device (only contiguous buffer support)
+ * @domain: iommu domain for DRM.
+ *	- all DC IOMMU share same domain to reduce mapping
+ * @pitch_alignment: buffer pitch alignment required by sub-devices.
+ *
+ */
+struct vs_drm_private {
+	struct drm_device base;
+	struct device *dma_dev;
+	struct iommu_domain *domain;
+	unsigned int pitch_alignment;
+};
+
+static inline struct vs_drm_private *
+to_vs_dev(const struct drm_device *dev)
+{
+	return container_of(dev, struct vs_drm_private, base);
+}
+
+void vs_drm_update_pitch_alignment(struct drm_device *drm_dev,
+				   unsigned int alignment);
+
+
+static inline bool is_iommu_enabled(struct drm_device *dev)
+{
+	struct vs_drm_private *priv = to_vs_dev(dev);
+
+	return priv->domain ? true : false;
+}
+
+#ifdef CONFIG_STARFIVE_HDMI
+extern struct platform_driver starfive_hdmi_driver;
+#endif
+
+#endif /* __VS_DRV_H__ */
diff --git a/drivers/gpu/drm/verisilicon/vs_gem.c b/drivers/gpu/drm/verisilicon/vs_gem.c
new file mode 100644
index 000000000..a7d5a5c7b
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_gem.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/of_reserved_mem.h>
+#include <drm/drm_gem_dma_helper.h>
+
+#include "vs_drv.h"
+#include "vs_gem.h"
+
+MODULE_IMPORT_NS(DMA_BUF);
+
+static const struct drm_gem_object_funcs vs_gem_default_funcs;
+
+static int vs_gem_alloc_buf(struct vs_gem_object *vs_obj)
+{
+	struct drm_device *dev = vs_obj->base.base.dev;
+	unsigned int nr_pages;
+	struct sg_table sgt;
+	int ret = -ENOMEM;
+
+	if (vs_obj->base.dma_addr) {
+		drm_dbg_kms(dev, "already allocated.\n");
+		return 0;
+	}
+
+	vs_obj->base.dma_addr = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_FORCE_CONTIGUOUS
+			   | DMA_ATTR_NO_KERNEL_MAPPING;
+
+	nr_pages = vs_obj->base.base.size >> PAGE_SHIFT;
+
+	vs_obj->pages = kvmalloc_array(nr_pages, sizeof(struct page *),
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!vs_obj->pages)
+		return -ENOMEM;
+
+	vs_obj->cookie = dma_alloc_attrs(dev->dev, vs_obj->base.base.size,
+					 &vs_obj->base.dma_addr, GFP_KERNEL,
+					 vs_obj->dma_attrs);
+
+	if (!vs_obj->cookie) {
+		dev_err(dev->dev, "failed to allocate buffer.\n");
+		goto err_free;
+	}
+
+	vs_obj->iova = vs_obj->base.dma_addr;
+
+	ret = dma_get_sgtable_attrs(dev->dev, &sgt,
+				    vs_obj->cookie, vs_obj->base.dma_addr,
+				    vs_obj->base.base.size, vs_obj->dma_attrs);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to get sgtable.\n");
+		goto err_mem_free;
+	}
+
+	if (drm_prime_sg_to_page_array(&sgt, vs_obj->pages, nr_pages)) {
+		dev_err(dev->dev, "invalid sgtable.\n");
+		ret = -EINVAL;
+		goto err_sgt_free;
+	}
+
+	sg_free_table(&sgt);
+
+	return 0;
+
+err_sgt_free:
+	sg_free_table(&sgt);
+err_mem_free:
+		dma_free_attrs(dev->dev, vs_obj->base.base.size, vs_obj->cookie,
+			       vs_obj->base.dma_addr, vs_obj->dma_attrs);
+err_free:
+	kvfree(vs_obj->pages);
+
+	return ret;
+}
+
+static void vs_gem_free_buf(struct vs_gem_object *vs_obj)
+{
+	struct drm_device *dev = vs_obj->base.base.dev;
+
+	if (!vs_obj->base.dma_addr) {
+		drm_dbg_kms(dev, "dma_addr is invalid.\n");
+		return;
+	}
+
+	dma_free_attrs(dev->dev, vs_obj->base.base.size, vs_obj->cookie,
+		       (dma_addr_t)vs_obj->base.dma_addr,
+		       vs_obj->dma_attrs);
+
+	kvfree(vs_obj->pages);
+}
+
+static void vs_gem_free_object(struct drm_gem_object *obj)
+{
+	struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
+
+	if (obj->import_attach)
+		drm_prime_gem_destroy(obj, vs_obj->base.sgt);
+	else
+		vs_gem_free_buf(vs_obj);
+
+	drm_gem_object_release(obj);
+
+	kfree(vs_obj);
+}
+
+static struct vs_gem_object *vs_gem_alloc_object(struct drm_device *dev,
+						 size_t size)
+{
+	struct vs_gem_object *vs_obj;
+	struct drm_gem_object *obj;
+	int ret;
+
+	vs_obj = kzalloc(sizeof(*vs_obj), GFP_KERNEL);
+	if (!vs_obj)
+		return ERR_PTR(-ENOMEM);
+
+	vs_obj->base.base.size = size;
+	obj = &vs_obj->base.base;
+
+	ret = drm_gem_object_init(dev, obj, size);
+	if (ret)
+		goto err_free;
+
+	vs_obj->base.base.funcs = &vs_gem_default_funcs;
+
+	ret = drm_gem_create_mmap_offset(obj);
+	if (ret) {
+		drm_gem_object_release(obj);
+		goto err_free;
+	}
+
+	return vs_obj;
+
+err_free:
+	kfree(vs_obj);
+	return ERR_PTR(ret);
+}
+
+static struct vs_gem_object *vs_gem_create_object(struct drm_device *dev,
+						  size_t size)
+{
+	struct vs_gem_object *vs_obj;
+	int ret;
+
+	size = PAGE_ALIGN(size);
+
+	vs_obj = vs_gem_alloc_object(dev, size);
+	if (IS_ERR(vs_obj))
+		return vs_obj;
+
+	ret = vs_gem_alloc_buf(vs_obj);
+	if (ret) {
+		drm_gem_object_release(&vs_obj->base.base);
+		kfree(vs_obj);
+		return ERR_PTR(ret);
+	}
+
+	return vs_obj;
+}
+
+static struct vs_gem_object *vs_gem_create_with_handle(struct drm_device *dev,
+						       struct drm_file *file,
+						       size_t size,
+						       unsigned int *handle)
+{
+	struct vs_gem_object *vs_obj;
+	struct drm_gem_object *obj;
+	int ret;
+
+	vs_obj = vs_gem_create_object(dev, size);
+	if (IS_ERR(vs_obj))
+		return vs_obj;
+
+	obj = &vs_obj->base.base;
+
+	ret = drm_gem_handle_create(file, obj, handle);
+
+	drm_gem_object_put(obj);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return vs_obj;
+}
+
+static struct sg_table *vs_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
+
+	return drm_prime_pages_to_sg(obj->dev, vs_obj->pages,
+					 vs_obj->base.base.size >> PAGE_SHIFT);
+}
+
+static int vs_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
+{
+	struct vs_gem_object *vs_obj = to_vs_gem_object(obj);
+
+	vs_obj->base.vaddr = vs_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING ?
+		       page_address(vs_obj->cookie) : vs_obj->cookie;
+
+	return drm_gem_dma_vmap(&vs_obj->base, map);
+}
+
+static const struct vm_operations_struct vs_vm_ops = {
+	.open  = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
+static const struct drm_gem_object_funcs vs_gem_default_funcs = {
+	.free = vs_gem_free_object,
+	.get_sg_table = vs_gem_prime_get_sg_table,
+	.vmap = vs_gem_prime_vmap,
+	.mmap = drm_gem_dma_object_mmap,
+	.vm_ops = &vs_vm_ops,
+};
+
+int vs_gem_dumb_create(struct drm_file *file,
+		       struct drm_device *dev,
+		       struct drm_mode_create_dumb *args)
+{
+	struct vs_drm_private *priv = to_vs_dev(dev);
+	struct vs_gem_object *vs_obj;
+	unsigned int pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+
+	if (args->bpp % 10)
+		args->pitch = ALIGN(pitch, priv->pitch_alignment);
+	else
+		/* for costum 10bit format with no bit gaps */
+		args->pitch = pitch;
+	args->size = PAGE_ALIGN(args->pitch * args->height);
+	vs_obj = vs_gem_create_with_handle(dev, file, args->size,
+					   &args->handle);
+	return PTR_ERR_OR_ZERO(vs_obj);
+}
+
+struct drm_gem_object *
+vs_gem_prime_import_sg_table(struct drm_device *dev,
+			     struct dma_buf_attachment *attach,
+			     struct sg_table *sgt)
+{
+	struct vs_gem_object *vs_obj;
+	int npages;
+	int ret;
+	struct scatterlist *s;
+	u32 i;
+	dma_addr_t expected;
+	size_t size = attach->dmabuf->size;
+
+	size = PAGE_ALIGN(size);
+
+	vs_obj = vs_gem_alloc_object(dev, size);
+	if (IS_ERR(vs_obj))
+		return ERR_CAST(vs_obj);
+
+	expected = sg_dma_address(sgt->sgl);
+	for_each_sg(sgt->sgl, s, sgt->nents, i) {
+		if (sg_dma_address(s) != expected) {
+			DRM_ERROR("sg_table is not contiguous");
+			ret = -EINVAL;
+			goto err;
+		}
+		if (sg_dma_len(s) & (PAGE_SIZE - 1)) {
+			ret = -EINVAL;
+			goto err;
+		}
+		if (i == 0)
+			vs_obj->iova = sg_dma_address(s);
+		expected = sg_dma_address(s) + sg_dma_len(s);
+	}
+
+	vs_obj->base.dma_addr = sg_dma_address(sgt->sgl);
+
+	npages = vs_obj->base.base.size >> PAGE_SHIFT;
+	vs_obj->pages = kvmalloc_array(npages, sizeof(struct page *),
+				       GFP_KERNEL);
+	if (!vs_obj->pages) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = drm_prime_sg_to_page_array(sgt, vs_obj->pages, npages);
+	if (ret)
+		goto err_free_page;
+
+	vs_obj->base.sgt = sgt;
+
+	return &vs_obj->base.base;
+
+err_free_page:
+	kvfree(vs_obj->pages);
+err:
+	vs_gem_free_object(&vs_obj->base.base);
+
+	return ERR_PTR(ret);
+}
diff --git a/drivers/gpu/drm/verisilicon/vs_gem.h b/drivers/gpu/drm/verisilicon/vs_gem.h
new file mode 100644
index 000000000..d9ff6d23b
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_gem.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_GEM_H__
+#define __VS_GEM_H__
+
+#include <linux/dma-buf.h>
+
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_prime.h>
+
+#include "vs_drv.h"
+/*
+ *
+ * @base: drm_gem_dma_object.
+ * @cookie: cookie returned by dma_alloc_attrs
+ *	- not kernel virtual address with DMA_ATTR_NO_KERNEL_MAPPING
+ * @dma_attrs: attribute for DMA API
+ * @get_pages: flag for manually applying for non-contiguous memory.
+ * @pages: Array of backing pages.
+ *
+ */
+struct vs_gem_object {
+	struct drm_gem_dma_object	base;
+	void			*cookie;
+	u32				iova;
+	unsigned long	dma_attrs;
+	bool			get_pages;
+	struct page		**pages;
+};
+
+static inline struct vs_gem_object *
+to_vs_gem_object(const struct drm_gem_object *bo)
+{
+	return container_of(to_drm_gem_dma_obj(bo), struct vs_gem_object, base);
+}
+
+int vs_gem_dumb_create(struct drm_file *file_priv,
+		       struct drm_device *drm,
+		       struct drm_mode_create_dumb *args);
+
+struct drm_gem_object *
+vs_gem_prime_import_sg_table(struct drm_device *dev,
+			     struct dma_buf_attachment *attach,
+			     struct sg_table *sgt);
+
+#endif /* __VS_GEM_H__ */
diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.c b/drivers/gpu/drm/verisilicon/vs_modeset.c
new file mode 100644
index 000000000..cd0bdf530
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_modeset.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_dma_helper.h>
+
+#include "vs_modeset.h"
+#include "vs_gem.h"
+
+#define fourcc_mod_vs_get_type(val) \
+	(((val) & DRM_FORMAT_MOD_VS_TYPE_MASK) >> 54)
+
+struct vs_gem_object *vs_fb_get_gem_obj(struct drm_framebuffer *fb,
+					unsigned char plane)
+{
+	if (plane > DRM_FORMAT_MAX_PLANES)
+		return NULL;
+
+	return to_vs_gem_object(fb->obj[plane]);
+}
+
+static const struct drm_format_info vs_formats[] = {
+	{.format = DRM_FORMAT_NV12, .depth = 0, .num_planes = 2, .char_per_block = { 20, 40, 0 },
+	 .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true},
+	{.format = DRM_FORMAT_YUV444, .depth = 0, .num_planes = 3, .char_per_block = { 20, 20, 20 },
+	 .block_w = { 4, 4, 4 }, .block_h = { 4, 4, 4 }, .hsub = 1, .vsub = 1, .is_yuv = true},
+};
+
+static const struct drm_format_info *
+vs_lookup_format_info(const struct drm_format_info formats[],
+		      int num_formats, u32 format)
+{
+	int i;
+
+	for (i = 0; i < num_formats; i++) {
+		if (formats[i].format == format)
+			return &formats[i];
+	}
+
+	return NULL;
+}
+
+static const struct drm_format_info *
+vs_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
+{
+	if (fourcc_mod_vs_get_type(cmd->modifier[0]) ==
+		DRM_FORMAT_MOD_VS_TYPE_CUSTOM_10BIT)
+		return vs_lookup_format_info(vs_formats, ARRAY_SIZE(vs_formats),
+									 cmd->pixel_format);
+	else
+		return NULL;
+}
+
+static const struct drm_mode_config_funcs vs_mode_config_funcs = {
+	.fb_create			 = drm_gem_fb_create,
+	.get_format_info	 = vs_get_format_info,
+	.output_poll_changed = drm_fb_helper_output_poll_changed,
+	.atomic_check		 = drm_atomic_helper_check,
+	.atomic_commit		 = drm_atomic_helper_commit,
+};
+
+static struct drm_mode_config_helper_funcs vs_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+void vs_mode_config_init(struct drm_device *dev)
+{
+	drm_mode_config_init(dev);
+	dev->mode_config.fb_modifiers_not_supported = false;
+
+	if (dev->mode_config.max_width == 0 ||
+	    dev->mode_config.max_height == 0) {
+		dev->mode_config.min_width  = 0;
+		dev->mode_config.min_height = 0;
+		dev->mode_config.max_width  = 4096;
+		dev->mode_config.max_height = 4096;
+	}
+	dev->mode_config.funcs = &vs_mode_config_funcs;
+	dev->mode_config.helper_private = &vs_mode_config_helpers;
+}
diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.h b/drivers/gpu/drm/verisilicon/vs_modeset.h
new file mode 100644
index 000000000..2e1f04a8a
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_modeset.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_FB_H__
+#define __VS_FB_H__
+
+struct vs_gem_object *vs_fb_get_gem_obj(struct drm_framebuffer *fb,
+					unsigned char plane);
+
+void vs_mode_config_init(struct drm_device *dev);
+#endif /* __VS_FB_H__ */
diff --git a/include/uapi/drm/vs_drm.h b/include/uapi/drm/vs_drm.h
new file mode 100644
index 000000000..96b7fc95d
--- /dev/null
+++ b/include/uapi/drm/vs_drm.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020 VeriSilicon Holdings Co., Ltd.
+ */
+
+#ifndef __VS_DRM_H__
+#define __VS_DRM_H__
+
+#include "drm.h"
+
+enum drm_vs_degamma_mode {
+	VS_DEGAMMA_DISABLE = 0,
+	VS_DEGAMMA_BT709 = 1,
+	VS_DEGAMMA_BT2020 = 2,
+};
+
+enum drm_vs_sync_dc_mode {
+	VS_SINGLE_DC = 0,
+	VS_MULTI_DC_PRIMARY = 1,
+	VS_MULTI_DC_SECONDARY = 2,
+};
+
+enum drm_vs_mmu_prefetch_mode {
+	VS_MMU_PREFETCH_DISABLE = 0,
+	VS_MMU_PREFETCH_ENABLE = 1,
+};
+
+struct drm_vs_watermark {
+	__u32 watermark;
+	__u8 qos_low;
+	__u8 qos_high;
+};
+
+struct drm_vs_color_mgmt {
+	__u32 colorkey;
+	__u32 colorkey_high;
+	__u32 clear_value;
+	bool  clear_enable;
+	bool  transparency;
+};
+
+struct drm_vs_roi {
+	bool enable;
+	__u16 roi_x;
+	__u16 roi_y;
+	__u16 roi_w;
+	__u16 roi_h;
+};
+
+#endif /* __VS_DRM_H__ */
-- 
2.34.1

