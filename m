Return-Path: <linux-kernel+bounces-110725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D68862EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA01C20383
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5B137764;
	Thu, 21 Mar 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="bQLARnJG"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7A136655;
	Thu, 21 Mar 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058777; cv=none; b=fYV3IbmTeMTfWtNM6T/dDw7mTwX4dN3pZqKB72bEaBjJOHoVJOL16pKe0a3glIdOxBkWTtvEgDA0lNUlZJa67oySnFlT34qm3yh/auh/pm/SAZiJkvWznZ+287GglfvAe4+u95Px/TDksyciQ8jrML5/8YdXNSNC/jTvHj75VfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058777; c=relaxed/simple;
	bh=zExycQHhyq4wetHrvMjx6ezUg1OGcA43b6ovflqSDQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQAGxPHyxAW1gVPzjH9Efucjels4H8BrLIvFjSUp1PPPgtX4wo5eh3CMW2thA9ZMSx6Qgn4ap7Gr2A30qX+HC0PdUKe/CIrhowGTVNR/oZupR6QNoVZ5IsIhl1LYTDZYswUGV9Rjgk5Aa/mEKIRFw5yUPfXVlC4PyCs9KPUObPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=bQLARnJG; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BC6969C52F1;
	Thu, 21 Mar 2024 18:06:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id uZZNF_W9J2XZ; Thu, 21 Mar 2024 18:06:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6F1139C5431;
	Thu, 21 Mar 2024 18:06:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6F1139C5431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1711058768; bh=M3GSWx4R0LeLuAZK16aErTgq9ORy17epEWJFTwq9YKM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=bQLARnJGM5sT7zK+UB4Cq7WXn8tLw+ICMQe/l8xikb3H/2W8wc9hazo59j2owPwko
	 6nmvxqL7rvKloCUoCbswxkFJneSizuJNCJRd//YmTN0iXPRLBc/BJpbkIyzex/XjTs
	 mYbz60ecz11JlgJ/6TxNpoTFF5FS/aPaDOQKci8Cyj+Je4yhgUFnFggigQ1i6lOPXm
	 uwRKdC8Uslymhj9dq3Z7kT4g0o8UBIZhJLS2PWahAy5u5LMVEP/ULnPiLvlxLFDKiU
	 1xWNu329J6580C8g1JRcRVkqoOJsShhWHgdIWB5swKqsImf0b+SwZdD7pStR5CKq98
	 He1GXX2K9Zjow==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vI5FfOXABKdL; Thu, 21 Mar 2024 18:06:08 -0400 (EDT)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4752E9C52F1;
	Thu, 21 Mar 2024 18:06:08 -0400 (EDT)
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
Subject: [PATCH v6 3/4] fpga: xilinx-selectmap: add new driver
Date: Thu, 21 Mar 2024 18:04:35 -0400
Message-ID: <20240321220447.3260065-4-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
References: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
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
Changes since v5: (from Yilun review)
 * xilinx-core.c: introduce the new gpio names in patch 4/4
 * xilinx-core.c: remove kernel-doc on xilinx_core_devm_gpiod_get()
 * xilinx-selectmap.c:
   * reorder includes in alphabetical order
   * xilinx_selectmap_probe(): remove unused resource *r variable
   * xilinx_selectmap_probe(): use a single gpio_desc* temporary
   * xilinx_selectmap_probe(): declare variables in reverse xmas tree

Changes since v4: (from Yilun review)
 * xilinx-core: select between prog/init and prog_b/init-b

 drivers/fpga/Kconfig            |  8 +++
 drivers/fpga/Makefile           |  1 +
 drivers/fpga/xilinx-selectmap.c | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
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
diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-select=
map.c
new file mode 100644
index 0000000000000..d716fcb935ce3
--- /dev/null
+++ b/drivers/fpga/xilinx-selectmap.c
@@ -0,0 +1,95 @@
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
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
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
+	struct gpio_desc *gpio;
+	void __iomem *base;
+
+	conf =3D devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	conf->core.dev =3D &pdev->dev;
+	conf->core.write =3D xilinx_selectmap_write;
+
+	base =3D devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "ioremap error\n");
+	conf->base =3D base;
+
+	/* CSI_B is active low */
+	gpio =3D devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
+				     "Failed to get CSI_B gpio\n");
+
+	/* RDWR_B is active low */
+	gpio =3D devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
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

