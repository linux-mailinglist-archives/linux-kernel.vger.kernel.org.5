Return-Path: <linux-kernel+bounces-102625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222887B4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D267B2246B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E75E099;
	Wed, 13 Mar 2024 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="e42UWxxR"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCF5D732;
	Wed, 13 Mar 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370695; cv=none; b=tCLUCqShbQfsh+AyXzmcL0xdAj8u+RkZPzItdLWJoRkODZ8w+q3T8sCI2dqji/s7AarbLyTMPKz3/sS2UjfgLJRUBu4/f1zQr95EME/MmHDfizLsAtSK/3k/IrOaHjrYoY5tk9b+/km331HcnyRKCJSyz80kwj4Igf6lXmTBrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370695; c=relaxed/simple;
	bh=KF+lq4YcH6Xp00756RYp+wxJMi6yCrGpi1MQUqaB15I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLJrC+dHX2iAnHkPWgGvthKLm8ENaZhu76PQld3XY19/whod8waikVDVleTTkIboqIYn15jUBAx5F80OckJBEtmaTNfmn+NwaOU+rtBAxgi5fOTPuda+ddizx/rcLLZIv7OnaNAI9pFBQkW7/6CjdFNlqF+Dt64yFZdWeGmPNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=e42UWxxR; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 62F8D9C5407;
	Wed, 13 Mar 2024 18:58:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lKd-ydaZrGzp; Wed, 13 Mar 2024 18:58:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CA5DB9C540A;
	Wed, 13 Mar 2024 18:58:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CA5DB9C540A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1710370690; bh=QuEtk/uQ5emxPDFdbuSL173B4llg7dyYsWnwoFXcz1o=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=e42UWxxRUCSxgMAgM4JlPbrjr6FGfHJVyEvM8fSws3p8KQ1Ruhuq1st23XMi/TKNC
	 slMZA//IZtg+xB++8zKtjhsG7wCsdlFY5T1OrOllqB5avKyeJrQlOEgPp67gnLEc5V
	 UO5dss9L/Xo+GPqoc4QHusBPpyUkLGZEoGS0xLIb6Vu42804WMVnt/IfENi720YJls
	 Xjpf77+y+Rsq5k7iagywD1UXc0aDxt6kkhR3BpK8dnMmmqD73kdsC7r6OHGObEznW4
	 F5cb+YAkH1Bgm6GfZMQ74UcYDbnvxzX7Ex4OC8YUKx+6lGARxeovceUa7O7P785/m6
	 SCw06oHwnWF0g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Ovi_2tKXUoMl; Wed, 13 Mar 2024 18:58:10 -0400 (EDT)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A90FE9C5409;
	Wed, 13 Mar 2024 18:58:10 -0400 (EDT)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/3] fpga: xilinx-selectmap: add new driver
Date: Wed, 13 Mar 2024 18:57:37 -0400
Message-ID: <20240313225746.489253-4-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Xilinx 7 series FPGA can be programmed using a parallel port named
the SelectMAP interface in the datasheet. This interface is compatible
with the i.MX6 EIM bus controller but other types of external memory
mapped parallel bus might work.

xilinx-selectmap currently only supports the x8 mode where data is loaded
at one byte per rising edge of the clock, with the MSb of each byte
presented to the D0 pin.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
Changes since v4: (from Yilun review)
 * xilinx-core: select between prog/init and prog_b/init-b

 drivers/fpga/Kconfig            |  8 +++
 drivers/fpga/Makefile           |  1 +
 drivers/fpga/xilinx-core.c      | 29 +++++++++-
 drivers/fpga/xilinx-selectmap.c | 97 +++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 drivers/fpga/xilinx-selectmap.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index d27a1ebf40838..37b35f58f0dfb 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -67,6 +67,14 @@ config FPGA_MGR_STRATIX10_SOC
 config FPGA_MGR_XILINX_CORE
 	tristate

+config FPGA_MGR_XILINX_SELECTMAP
+	tristate "Xilinx Configuration over SelectMAP"
+	depends on HAS_IOMEM
+	select FPGA_MGR_XILINX_CORE
+	help
+	  FPGA manager driver support for Xilinx FPGA configuration
+	  over SelectMAP interface.
+
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 7ec795b6a5a70..aeb89bb13517e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+=3D socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+=3D stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+=3D ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+=3D xilinx-core.o
+obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+=3D xilinx-selectmap.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+=3D xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+=3D zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D zynqmp-fpga.o
diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
index a35c43382dd5f..ccdeb45eba4ee 100644
--- a/drivers/fpga/xilinx-core.c
+++ b/drivers/fpga/xilinx-core.c
@@ -171,6 +171,29 @@ static int xilinx_core_write_complete(struct fpga_ma=
nager *mgr,
 	return -ETIMEDOUT;
 }

+/**
+ * xilinx_core_devm_gpiod_get - Obtain a resource-managed GPIO using a
+ *                              legacy consumer name fallback.
+ *
+ * @dev:           Device managing the GPIO
+ * @con_id:        Consumer id
+ * @legacy_con_id: Legacy consumer id
+ * @flags:         optional GPIO initialization flags
+ */
+static inline struct gpio_desc *
+xilinx_core_devm_gpiod_get(struct device *dev, const char *con_id,
+			   const char *legacy_con_id, enum gpiod_flags flags)
+{
+	struct gpio_desc *desc;
+
+	desc =3D devm_gpiod_get(dev, con_id, flags);
+	if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -ENOENT &&
+	    of_device_is_compatible(dev->of_node, "xlnx,fpga-slave-serial"))
+		desc =3D devm_gpiod_get(dev, legacy_con_id, flags);
+
+	return desc;
+}
+
 static const struct fpga_manager_ops xilinx_core_ops =3D {
 	.state =3D xilinx_core_state,
 	.write_init =3D xilinx_core_write_init,
@@ -186,12 +209,14 @@ int xilinx_core_probe(struct xilinx_fpga_core *core=
)
 		return -EINVAL;

 	/* PROGRAM_B is active low */
-	core->prog_b =3D devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
+	core->prog_b =3D xilinx_core_devm_gpiod_get(core->dev, "prog", "prog_b"=
,
+						  GPIOD_OUT_LOW);
 	if (IS_ERR(core->prog_b))
 		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
 				     "Failed to get PROGRAM_B gpio\n");

-	core->init_b =3D devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN)=
;
+	core->init_b =3D xilinx_core_devm_gpiod_get(core->dev, "init", "init-b"=
,
+						  GPIOD_IN);
 	if (IS_ERR(core->init_b))
 		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
 				     "Failed to get INIT_B gpio\n");
diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-select=
map.c
new file mode 100644
index 0000000000000..b63f4623f8b2c
--- /dev/null
+++ b/drivers/fpga/xilinx-selectmap.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Xilinx Spartan6 and 7 Series SelectMAP interface driver
+ *
+ * (C) 2024 Charles Perry <charles.perry@savoirfairelinux.com>
+ *
+ * Manage Xilinx FPGA firmware loaded over the SelectMAP configuration
+ * interface.
+ */
+
+#include "xilinx-core.h"
+
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/io.h>
+
+struct xilinx_selectmap_conf {
+	struct xilinx_fpga_core core;
+	void __iomem *base;
+};
+
+#define to_xilinx_selectmap_conf(obj) \
+	container_of(obj, struct xilinx_selectmap_conf, core)
+
+static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
+				  const char *buf, size_t count)
+{
+	struct xilinx_selectmap_conf *conf =3D to_xilinx_selectmap_conf(core);
+	u32 i;
+
+	for (i =3D 0; i < count; ++i)
+		writeb(buf[i], conf->base);
+
+	return 0;
+}
+
+static int xilinx_selectmap_probe(struct platform_device *pdev)
+{
+	struct xilinx_selectmap_conf *conf;
+	struct resource *r;
+	void __iomem *base;
+	struct gpio_desc *csi_b;
+	struct gpio_desc *rdwr_b;
+
+	conf =3D devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	conf->core.dev =3D &pdev->dev;
+	conf->core.write =3D xilinx_selectmap_write;
+
+	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "ioremap error\n");
+	conf->base =3D base;
+
+	/* CSI_B is active low */
+	csi_b =3D devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
+	if (IS_ERR(csi_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(csi_b),
+				     "Failed to get CSI_B gpio\n");
+
+	/* RDWR_B is active low */
+	rdwr_b =3D devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
+	if (IS_ERR(rdwr_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rdwr_b),
+				     "Failed to get RDWR_B gpio\n");
+
+	return xilinx_core_probe(&conf->core);
+}
+
+static const struct of_device_id xlnx_selectmap_of_match[] =3D {
+	{ .compatible =3D "xlnx,fpga-xc7s-selectmap", }, // Spartan-7
+	{ .compatible =3D "xlnx,fpga-xc7a-selectmap", }, // Artix-7
+	{ .compatible =3D "xlnx,fpga-xc7k-selectmap", }, // Kintex-7
+	{ .compatible =3D "xlnx,fpga-xc7v-selectmap", }, // Virtex-7
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
+
+static struct platform_driver xilinx_selectmap_driver =3D {
+	.driver =3D {
+		.name =3D "xilinx-selectmap",
+		.of_match_table =3D xlnx_selectmap_of_match,
+	},
+	.probe  =3D xilinx_selectmap_probe,
+};
+
+module_platform_driver(xilinx_selectmap_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Charles Perry <charles.perry@savoirfairelinux.com>");
+MODULE_DESCRIPTION("Load Xilinx FPGA firmware over SelectMap");
--
2.43.0

