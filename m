Return-Path: <linux-kernel+bounces-43595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2897841612
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E6B2868A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429852F9E;
	Mon, 29 Jan 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="jDeYYAYO"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650050A9D;
	Mon, 29 Jan 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568989; cv=none; b=ALoiePCis/EupGaDmB/ZBpx3lYJf/6Ezhddh25xziAQJc8TtZ5LBb0IGUagQ5oyZ2rG2PCH2qxWjpzIhjdve7wiwSgBZQ1V3lyUzH9qsX2LYDIyR/zJr5Ppf4YKh2DcsUBZtcf/in/TtOWzC9j/K0qv+uuRlFLPxNyQjFKUW7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568989; c=relaxed/simple;
	bh=YrDDWt2nTuofUc47/AlvEPWYZMHhHI14tCDat3nLYuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ3yBMp+navDBk7smtqVMvaWEx2Vs/WLKQR5aR+iRrBW5cv0ZZaJkE2foiEtbFHh+v1wz90fORGR1lQmPPCTxhsbA/4Q0wVMgFw4iK0iaiNdRc0Pj+98RJyVxBeZY8/sSK8dETCZYG22sjffuSsFOABNBSgnu+00qGru5xw932Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=jDeYYAYO; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B09F79C45C6;
	Mon, 29 Jan 2024 17:56:20 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id olu6P28T0NBN; Mon, 29 Jan 2024 17:56:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 062559C46AD;
	Mon, 29 Jan 2024 17:56:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 062559C46AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706568980; bh=03qdXq/R91xUihk3FNo5Q+1l664fIDZz7tTpbLePyrc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=jDeYYAYOsMcsCspaDsjFRkSlDYurNx0VUNc8F/NBgiQwJvu08jQQp6/VXDAweGxyE
	 ylp6PLHlGIxgSPnNK3w+U3lw2hsefXkcW4zB+7Wa1hbwCALgE3gRVRcCNAmgWCAENC
	 j+yi4x58jFxTfo09+PV3J6hFZHy8TOiTag6HOIe8gyjGYwF6o83EoAxRJL6rLO5Vm7
	 eOZvQXYCGXPONjx1mskibsZ8xcnFtSmoeXzdnIRzxj0XLbSugg9RAPsULqYavi/kB8
	 myZG8z6eK/dty8erIcvInJ9L5C2yDy8dhZ9fDfin+OdchsJuK6veIRURWLYBjH9FhE
	 yr7uBkIcvVHtA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P0rmldCCEzon; Mon, 29 Jan 2024 17:56:19 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D7DAA9C45C6;
	Mon, 29 Jan 2024 17:56:19 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	krzysztof.kozlowski+dt@linaro.org,
	bcody@markem-imaje.com,
	avandiver@markem-imaje.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles Perry <charles.perry@savoirfairelinux.com>
Subject: [PATCH 3/3] fpga: xilinx-selectmap: add new driver
Date: Mon, 29 Jan 2024 17:56:02 -0500
Message-ID: <20240129225602.3832449-3-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
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

The following DT fragment shows a valid configuration on a custom i.MX6
board (pinctrl not shown for readability):

&weim {
    status =3D "okay";
    ranges =3D <0 0 0x08000000 0x04000000>;

    fpga_mgr: fpga_programmer@0,0 {
        compatible =3D "xlnx,fpga-slave-selectmap";
        reg =3D <0 0 0x4000000>;
        fsl,weim-cs-timing =3D <0x00070031 0x00000142
                              0x00020000 0x00000000
                              0x0c000645 0x00000000>;
        prog_b-gpios =3D <&gpio5 5 GPIO_ACTIVE_LOW>;
        init-b-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
        done-gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
        csi-b-gpios =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
        rdwr-b-gpios =3D <&gpio3 10 GPIO_ACTIVE_LOW>;
    };
};

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/fpga/Kconfig            |   8 +++
 drivers/fpga/Makefile           |   1 +
 drivers/fpga/xilinx-selectmap.c | 100 ++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
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
diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-select=
map.c
new file mode 100644
index 0000000000000..e9e522e9952bb
--- /dev/null
+++ b/drivers/fpga/xilinx-selectmap.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Xilinx Spartan6 and 7 Series Slave SelectMAP Driver
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
+static int xilinx_selectmap_write(struct xilinx_fpga_core *core, const c=
har *buf,
+			    size_t count)
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(base), "ioremap error\n");
+	conf->base =3D base;
+
+	/* CSI_B is active low */
+	conf->csi_b =3D devm_gpiod_get_optional(&pdev->dev, "csi-b", GPIOD_OUT_=
HIGH);
+	if (IS_ERR(conf->csi_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
+				     "Failed to get CSI_B gpio\n");
+
+	/* RDWR_B is active low */
+	conf->rdwr_b =3D devm_gpiod_get_optional(&pdev->dev, "rdwr-b", GPIOD_OU=
T_HIGH);
+	if (IS_ERR(conf->rdwr_b))
+		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
+				     "Failed to get RDWR_B gpio\n");
+
+	return xilinx_core_probe(&conf->core, &pdev->dev,
+							xilinx_selectmap_write,
+							xilinx_selectmap_apply_padding);
+}
+
+static const struct of_device_id xlnx_selectmap_of_match[] =3D {
+		{ .compatible =3D "xlnx,fpga-slave-selectmap", },
+		{}
+};
+MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
+
+static struct platform_driver xilinx_slave_selectmap_driver =3D {
+	.driver =3D {
+		.name =3D "xilinx-slave-selectmap",
+		.of_match_table =3D of_match_ptr(xlnx_selectmap_of_match),
+	},
+	.probe  =3D xilinx_selectmap_probe,
+};
+
+module_platform_driver(xilinx_slave_selectmap_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Charles Perry <charles.perry@savoirfairelinux.com>");
+MODULE_DESCRIPTION("Load Xilinx FPGA firmware over SelectMap");
--=20
2.43.0


