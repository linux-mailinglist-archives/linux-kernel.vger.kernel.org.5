Return-Path: <linux-kernel+bounces-47338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A2844CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032C22A1DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6F46449;
	Wed, 31 Jan 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="lcdBO6Hj"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554B40C15;
	Wed, 31 Jan 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742383; cv=none; b=rwS/t4oItrpYKxzcZfoxqj5ruZOor5YfkErnXFOlNbbbtc0zYjk9uV5N1QbiM69dOXK5WMNtwgklB4FS6gco12NnmuXmlVnXYWViq/Eq+h+bLYrf0bzSVq6bD7UitIcQgq3znQsvmRNyl1mW/eExVFyafZnjOZrThHwzkiUsPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742383; c=relaxed/simple;
	bh=ZDxIxgfYVx76FAwLMeo/MWXr5O9I56F+fJe5SZLXxts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntG0z5RF4dQB0/Yw3SL8g7cDbyXR6N6lAObAOBsCPpQY2kZlTvrJdIFefifQmPI4kEqPg9jOnxCheNga19pdf6K9cfmrP8e3HaqlnTZHS26e+xy5i+SIdwqH5K0f+r0O6pwmxqqrs70H/JSvXHJ63AH2zmfKX03+S2eKgWwdxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=lcdBO6Hj; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 429BD9C3278;
	Wed, 31 Jan 2024 18:06:21 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id m8zlYKJ5ghfD; Wed, 31 Jan 2024 18:06:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 625E49C443E;
	Wed, 31 Jan 2024 18:06:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 625E49C443E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706742380; bh=lSmF8cHelUJ4wmBZ9/AGS4jpTRm1smUqT8nHydzlEJQ=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=lcdBO6HjrdLI66IVX8l2mF91N9VIOI7JSCT93xa2a2iXlnFFY1UYoWcGJ7snzeXa/
	 htDUtd8vYoF7gx3oHXfepGejISQ1qfAPlvqnf3KNv3rb0PO4zUZX7QR+up1LZIvvjB
	 jblt8H8avZfByXg/nSw1nfUKXBTdAtFEqlUgS8Nx4apL4IGc494jPcpzqXDGTvnsrP
	 YLL8pwQNbwgaLCjdduCvF2svpvv4nxOgeuhYPh+oBGHOjj84aMl1Z3kKr6C7dx+VFx
	 pGr4rm4oSoZABz/vhS2jaEZYUtr4SL3RhO1FbZvLSXgsWUpmPyPdcffzyEgyaMybdx
	 i8lhBzeNumRww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MVL6h6YUiCts; Wed, 31 Jan 2024 18:06:20 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3F3059C3278;
	Wed, 31 Jan 2024 18:06:20 -0500 (EST)
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
Subject: [PATCH 3/3] fpga: xilinx-selectmap: add new driver
Date: Wed, 31 Jan 2024 18:05:33 -0500
Message-ID: <20240131230542.3993409-4-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Xilinx 7 series FPGA can be programmed using a slave parallel port named
the SelectMAP interface in the datasheet. This slave interface is
compatible with the i.MX6 EIM bus controller but other types of external
memory mapped parallel bus might work.

xilinx-selectmap currently only supports the x8 mode where data is loaded
at one byte per rising edge of the clock, with the MSb of each byte
presented to the D0 pin.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/fpga/Kconfig            |   8 +++
 drivers/fpga/Makefile           |   1 +
 drivers/fpga/xilinx-core.c      |  11 +++-
 drivers/fpga/xilinx-core.h      |   3 +-
 drivers/fpga/xilinx-selectmap.c | 106 ++++++++++++++++++++++++++++++++
 drivers/fpga/xilinx-spi.c       |   3 +-
 6 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100644 drivers/fpga/xilinx-selectmap.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index d27a1ebf40838..37b35f58f0dfb 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -67,6 +67,14 @@ config FPGA_MGR_STRATIX10_SOC
 config FPGA_MGR_XILINX_CORE
 	tristate
=20
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
index aff40e9394085..64117759be100 100644
--- a/drivers/fpga/xilinx-core.c
+++ b/drivers/fpga/xilinx-core.c
@@ -180,21 +180,26 @@ static const struct fpga_manager_ops xilinx_core_op=
s =3D {
=20
 int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
 		      xilinx_write_func write,
-		      xilinx_write_one_dummy_byte_func write_one_dummy_byte)
+		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
+		      const char *prog_con_id, const char *init_con_id)
 {
 	struct fpga_manager *mgr;
=20
+	if (!core || !dev || !write || !write_one_dummy_byte || !prog_con_id ||
+	    !init_con_id)
+		return -EINVAL;
+
 	core->dev =3D dev;
 	core->write =3D write;
 	core->write_one_dummy_byte =3D write_one_dummy_byte;
=20
 	/* PROGRAM_B is active low */
-	core->prog_b =3D devm_gpiod_get(dev, "prog_b", GPIOD_OUT_LOW);
+	core->prog_b =3D devm_gpiod_get(dev, prog_con_id, GPIOD_OUT_LOW);
 	if (IS_ERR(core->prog_b))
 		return dev_err_probe(dev, PTR_ERR(core->prog_b),
 				     "Failed to get PROGRAM_B gpio\n");
=20
-	core->init_b =3D devm_gpiod_get_optional(dev, "init-b", GPIOD_IN);
+	core->init_b =3D devm_gpiod_get_optional(dev, init_con_id, GPIOD_IN);
 	if (IS_ERR(core->init_b))
 		return dev_err_probe(dev, PTR_ERR(core->init_b),
 				     "Failed to get INIT_B gpio\n");
diff --git a/drivers/fpga/xilinx-core.h b/drivers/fpga/xilinx-core.h
index 40e120945ba70..817f0e551d093 100644
--- a/drivers/fpga/xilinx-core.h
+++ b/drivers/fpga/xilinx-core.h
@@ -22,6 +22,7 @@ struct xilinx_fpga_core {
=20
 int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
 		      xilinx_write_func write,
-		      xilinx_write_one_dummy_byte_func write_one_dummy_byte);
+		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
+		      const char *prog_con_id, const char *init_con_id);
=20
 #endif /* __XILINX_CORE_H */
diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-select=
map.c
new file mode 100644
index 0000000000000..08054e19bb498
--- /dev/null
+++ b/drivers/fpga/xilinx-selectmap.c
@@ -0,0 +1,106 @@
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
+	struct gpio_desc *csi_b;
+	struct gpio_desc *rdwr_b;
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
+static int xilinx_selectmap_apply_padding(struct xilinx_fpga_core *core)
+{
+	struct xilinx_selectmap_conf *conf =3D to_xilinx_selectmap_conf(core);
+
+	writeb(0xFF, conf->base);
+	return 0;
+}
+
+static int xilinx_selectmap_probe(struct platform_device *pdev)
+{
+	struct xilinx_selectmap_conf *conf;
+	struct resource *r;
+	void __iomem *base;
+
+	conf =3D devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "ioremap error\n");
+	conf->base =3D base;
+
+	/* CSI_B is active low */
+	conf->csi_b =3D
+		devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->csi_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
+				     "Failed to get CSI_B gpio\n");
+
+	/* RDWR_B is active low */
+	conf->rdwr_b =3D
+		devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->rdwr_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
+				     "Failed to get RDWR_B gpio\n");
+
+	return xilinx_core_probe(&conf->core, &pdev->dev,
+				 xilinx_selectmap_write,
+				 xilinx_selectmap_apply_padding, "prog",
+				 "init");
+}
+
+static const struct of_device_id xlnx_selectmap_of_match[] =3D {
+	{
+		.compatible =3D "xlnx,fpga-selectmap",
+	},
+	{}
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
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index ec128dee97312..b9ab3d5da004c 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -74,7 +74,8 @@ static int xilinx_spi_probe(struct spi_device *spi)
 	conf->spi =3D spi;
=20
 	return xilinx_core_probe(&conf->core, &spi->dev, xilinx_spi_write,
-				 xilinx_spi_apply_cclk_cycles);
+				 xilinx_spi_apply_cclk_cycles, "prog_b",
+				 "init-b");
 }
=20
 #ifdef CONFIG_OF
--=20
2.43.0


