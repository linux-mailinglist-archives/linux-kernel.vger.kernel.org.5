Return-Path: <linux-kernel+bounces-75434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1C85E8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FB6281598
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B3139581;
	Wed, 21 Feb 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="LaRCFxj0"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF3134CD4;
	Wed, 21 Feb 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545140; cv=none; b=jzW7iamL3pdrGzJVg2tC1aqapvjTuVUkXOYQIFjEjbpaE4G2sVg3RHvXDL8+J3uiMn/ZXyBWg/OP2RVKHhgiIZ+RpdO8JKUJ7FwsC03INFqu3FEqceH87upfkdzUBd2hnD1LpBLQXzz7QAMCzsWQohSqRwN2aijSG3KdEvQDdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545140; c=relaxed/simple;
	bh=U9ISTnvY2x0O1yNDgNt7SO01HJoEd3Ht+CK0RGK26aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoJYEavvzBGn26pOofMTUOyxyKFeY0ys4vobZ/GZvpmx0N0wknAwcbdYrU9Jn+Toga56hBAUNIv5wttbGWJ56NGhIURGF0ngwkRE0+O1/yRSnEzNCEZUTyjclbEEmojHQ8yIeSEjkAFUl91+gYO4yo5GQ9hztbjD62rewqhTbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=LaRCFxj0; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9F8B79C4BEA;
	Wed, 21 Feb 2024 14:52:10 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id DdOALsJcIl7t; Wed, 21 Feb 2024 14:52:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 83FC19C4BD8;
	Wed, 21 Feb 2024 14:52:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 83FC19C4BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1708545127; bh=wblcgkvxFKNoIBmJlLw5uhCpCh2AOHqRl6jZojMqhfQ=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=LaRCFxj0ULkhMPPmlr1SKm3VkK/mwZBBBXGs52L27pdQe8JTMxrOUBHcJFyUU2aNT
	 OzrkMw93Nm5FMAGXkID85b4654CJNvaALQ/LP8QibIoEu3fZI/SHYnKRKEDD91EbsS
	 G8QXYJHjwnD96OErYS0gjnbds5zlKFhdScpBdKwO969MOx9pRDo+6fg6JqxdfvAuW6
	 rUk5C89GRXpRXv7DQFYdGaMXXldxbNyQa2RoqDyABGeNhUm/Ff0NrTT/ZzVP5YR05f
	 KPu07P/fy3JQJuSd+0a+ElwJVFhl+vHjaXk8iqK3Rht/W1+byQ1UH4ZjHDw1Y1JHCM
	 5LulxutvyipKQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id QwHaBiIn-5r3; Wed, 21 Feb 2024 14:52:07 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5B0A99C4B59;
	Wed, 21 Feb 2024 14:52:07 -0500 (EST)
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
Subject: [PATCH v4 1/3] fpga: xilinx-spi: extract a common driver core
Date: Wed, 21 Feb 2024 14:50:47 -0500
Message-ID: <20240221195058.1281973-2-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor out the gpio handshaking (using PROGRAM_B, INIT_B and DONE)
protocol in xilinx-core so that it can be reused for another driver.
This commit does not change anything functionally to xilinx-spi.

xilinx-core expects drivers to provide a single operation:

 * ->write(const char* buf, size_t count): write to the device

As well as a struct device* for resource management.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/fpga/Kconfig       |   4 +
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/xilinx-core.c | 208 ++++++++++++++++++++++++++++++++++++
 drivers/fpga/xilinx-core.h |  28 +++++
 drivers/fpga/xilinx-spi.c  | 212 +++----------------------------------
 5 files changed, 254 insertions(+), 199 deletions(-)
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 2f689ac4ba3a3..d27a1ebf40838 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -64,9 +64,13 @@ config FPGA_MGR_STRATIX10_SOC
 	help
 	  FPGA manager driver support for the Intel Stratix10 SoC.
=20
+config FPGA_MGR_XILINX_CORE
+	tristate
+
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
 	depends on SPI
+	select FPGA_MGR_XILINX_CORE
 	help
 	  FPGA manager driver support for Xilinx FPGA configuration
 	  over slave serial interface.
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 352a2612623e0..7ec795b6a5a70 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+=3D socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+=3D socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+=3D stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+=3D ts73xx-fpga.o
+obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+=3D xilinx-core.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+=3D xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+=3D zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D zynqmp-fpga.o
diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
new file mode 100644
index 0000000000000..597e8b7a530b7
--- /dev/null
+++ b/drivers/fpga/xilinx-core.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common parts of the Xilinx Spartan6 and 7 Series FPGA manager drivers=
.
+ *
+ * Copyright (C) 2017 DENX Software Engineering
+ *
+ * Anatolij Gustschin <agust@denx.de>
+ */
+
+#include "xilinx-core.h"
+
+#include <linux/delay.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+
+static int get_done_gpio(struct fpga_manager *mgr)
+{
+	struct xilinx_fpga_core *core =3D mgr->priv;
+	int ret;
+
+	ret =3D gpiod_get_value(core->done);
+	if (ret < 0)
+		dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
+
+	return ret;
+}
+
+static enum fpga_mgr_states xilinx_core_state(struct fpga_manager *mgr)
+{
+	if (!get_done_gpio(mgr))
+		return FPGA_MGR_STATE_RESET;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+/**
+ * wait_for_init_b - wait for the INIT_B pin to have a given state, or w=
ait
+ * a given delay if the pin is unavailable
+ *
+ * @mgr:        The FPGA manager object
+ * @value:      Value INIT_B to wait for (1 =3D asserted =3D low)
+ * @alt_udelay: Delay to wait if the INIT_B GPIO is not available
+ *
+ * Returns 0 when the INIT_B GPIO reached the given state or -ETIMEDOUT =
if
+ * too much time passed waiting for that. If no INIT_B GPIO is available
+ * then always return 0.
+ */
+static int wait_for_init_b(struct fpga_manager *mgr, int value,
+			   unsigned long alt_udelay)
+{
+	struct xilinx_fpga_core *core =3D mgr->priv;
+	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
+
+	if (core->init_b) {
+		while (time_before(jiffies, timeout)) {
+			int ret =3D gpiod_get_value(core->init_b);
+
+			if (ret =3D=3D value)
+				return 0;
+
+			if (ret < 0) {
+				dev_err(&mgr->dev,
+					"Error reading INIT_B (%d)\n", ret);
+				return ret;
+			}
+
+			usleep_range(100, 400);
+		}
+
+		dev_err(&mgr->dev, "Timeout waiting for INIT_B to %s\n",
+			value ? "assert" : "deassert");
+		return -ETIMEDOUT;
+	}
+
+	udelay(alt_udelay);
+
+	return 0;
+}
+
+static int xilinx_core_write_init(struct fpga_manager *mgr,
+				  struct fpga_image_info *info, const char *buf,
+				  size_t count)
+{
+	struct xilinx_fpga_core *core =3D mgr->priv;
+	int err;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
+		return -EINVAL;
+	}
+
+	gpiod_set_value(core->prog_b, 1);
+
+	err =3D wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
+	if (err) {
+		gpiod_set_value(core->prog_b, 0);
+		return err;
+	}
+
+	gpiod_set_value(core->prog_b, 0);
+
+	err =3D wait_for_init_b(mgr, 0, 0);
+	if (err)
+		return err;
+
+	if (get_done_gpio(mgr)) {
+		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
+		return -EIO;
+	}
+
+	/* program latency */
+	usleep_range(7500, 7600);
+	return 0;
+}
+
+static int xilinx_core_write(struct fpga_manager *mgr, const char *buf,
+			     size_t count)
+{
+	struct xilinx_fpga_core *core =3D mgr->priv;
+
+	return core->write(core, buf, count);
+}
+
+static int xilinx_core_write_complete(struct fpga_manager *mgr,
+				      struct fpga_image_info *info)
+{
+	struct xilinx_fpga_core *core =3D mgr->priv;
+	unsigned long timeout =3D
+		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	bool expired =3D false;
+	int done;
+	int ret;
+	const char padding[1] =3D { 0xff };
+
+	/*
+	 * This loop is carefully written such that if the driver is
+	 * scheduled out for more than 'timeout', we still check for DONE
+	 * before giving up and we apply 8 extra CCLK cycles in all cases.
+	 */
+	while (!expired) {
+		expired =3D time_after(jiffies, timeout);
+
+		done =3D get_done_gpio(mgr);
+		if (done < 0)
+			return done;
+
+		ret =3D core->write(core, padding, 1);
+		if (ret)
+			return ret;
+
+		if (done)
+			return 0;
+	}
+
+	if (core->init_b) {
+		ret =3D gpiod_get_value(core->init_b);
+
+		if (ret < 0) {
+			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
+			return ret;
+		}
+
+		dev_err(&mgr->dev,
+			ret ? "CRC error or invalid device\n" :
+			      "Missing sync word or incomplete bitstream\n");
+	} else {
+		dev_err(&mgr->dev, "Timeout after config data transfer\n");
+	}
+
+	return -ETIMEDOUT;
+}
+
+static const struct fpga_manager_ops xilinx_core_ops =3D {
+	.state =3D xilinx_core_state,
+	.write_init =3D xilinx_core_write_init,
+	.write =3D xilinx_core_write,
+	.write_complete =3D xilinx_core_write_complete,
+};
+
+int xilinx_core_probe(struct xilinx_fpga_core *core)
+{
+	struct fpga_manager *mgr;
+
+	if (!core || !core->dev || !core->write)
+		return -EINVAL;
+
+	/* PROGRAM_B is active low */
+	core->prog_b =3D devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
+	if (IS_ERR(core->prog_b))
+		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
+				     "Failed to get PROGRAM_B gpio\n");
+
+	core->init_b =3D devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN)=
;
+	if (IS_ERR(core->init_b))
+		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
+				     "Failed to get INIT_B gpio\n");
+
+	core->done =3D devm_gpiod_get(core->dev, "done", GPIOD_IN);
+	if (IS_ERR(core->done))
+		return dev_err_probe(core->dev, PTR_ERR(core->done),
+				     "Failed to get DONE gpio\n");
+
+	mgr =3D devm_fpga_mgr_register(core->dev,
+				     "Xilinx Slave Serial FPGA Manager",
+				     &xilinx_core_ops, core);
+	return PTR_ERR_OR_ZERO(mgr);
+}
diff --git a/drivers/fpga/xilinx-core.h b/drivers/fpga/xilinx-core.h
new file mode 100644
index 0000000000000..bea190287b403
--- /dev/null
+++ b/drivers/fpga/xilinx-core.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __XILINX_CORE_H
+#define __XILINX_CORE_H
+
+#include <linux/device.h>
+
+/**
+ * struct xilinx_fpga_core - interface between the driver and the core m=
anager
+ *                           of Xilinx 7 Series FPGA manager
+ * @dev:       device node, must be set by the driver
+ * @write:     write callback of the driver, must be set by the driver
+ * @prog_b:    PROGRAM_B gpio, handled by the core manager
+ * @init_b:    INIT_B gpio, handled by the core manager
+ * @done:      DONE gpio, handled by the core manager
+ */
+struct xilinx_fpga_core {
+	struct device *dev;
+	int (*write)(struct xilinx_fpga_core *core, const char *buf,
+		     size_t count);
+	struct gpio_desc *prog_b;
+	struct gpio_desc *init_b;
+	struct gpio_desc *done;
+};
+
+int xilinx_core_probe(struct xilinx_fpga_core *core);
+
+#endif /* __XILINX_CORE_H */
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index e1a227e7ff2ae..12f401502a53a 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -10,127 +10,24 @@
  * the slave serial configuration interface.
  */
=20
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/fpga/fpga-mgr.h>
-#include <linux/gpio/consumer.h>
+#include "xilinx-core.h"
+
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/spi/spi.h>
-#include <linux/sizes.h>
=20
 struct xilinx_spi_conf {
+	struct xilinx_fpga_core core;
 	struct spi_device *spi;
-	struct gpio_desc *prog_b;
-	struct gpio_desc *init_b;
-	struct gpio_desc *done;
 };
=20
-static int get_done_gpio(struct fpga_manager *mgr)
-{
-	struct xilinx_spi_conf *conf =3D mgr->priv;
-	int ret;
-
-	ret =3D gpiod_get_value(conf->done);
-
-	if (ret < 0)
-		dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
-
-	return ret;
-}
-
-static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
-{
-	if (!get_done_gpio(mgr))
-		return FPGA_MGR_STATE_RESET;
-
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
-/**
- * wait_for_init_b - wait for the INIT_B pin to have a given state, or w=
ait
- * a given delay if the pin is unavailable
- *
- * @mgr:        The FPGA manager object
- * @value:      Value INIT_B to wait for (1 =3D asserted =3D low)
- * @alt_udelay: Delay to wait if the INIT_B GPIO is not available
- *
- * Returns 0 when the INIT_B GPIO reached the given state or -ETIMEDOUT =
if
- * too much time passed waiting for that. If no INIT_B GPIO is available
- * then always return 0.
- */
-static int wait_for_init_b(struct fpga_manager *mgr, int value,
-			   unsigned long alt_udelay)
-{
-	struct xilinx_spi_conf *conf =3D mgr->priv;
-	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
-
-	if (conf->init_b) {
-		while (time_before(jiffies, timeout)) {
-			int ret =3D gpiod_get_value(conf->init_b);
-
-			if (ret =3D=3D value)
-				return 0;
-
-			if (ret < 0) {
-				dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
-				return ret;
-			}
-
-			usleep_range(100, 400);
-		}
-
-		dev_err(&mgr->dev, "Timeout waiting for INIT_B to %s\n",
-			value ? "assert" : "deassert");
-		return -ETIMEDOUT;
-	}
-
-	udelay(alt_udelay);
-
-	return 0;
-}
-
-static int xilinx_spi_write_init(struct fpga_manager *mgr,
-				 struct fpga_image_info *info,
-				 const char *buf, size_t count)
-{
-	struct xilinx_spi_conf *conf =3D mgr->priv;
-	int err;
-
-	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
-		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
-		return -EINVAL;
-	}
-
-	gpiod_set_value(conf->prog_b, 1);
-
-	err =3D wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
-	if (err) {
-		gpiod_set_value(conf->prog_b, 0);
-		return err;
-	}
-
-	gpiod_set_value(conf->prog_b, 0);
+#define to_xilinx_spi_conf(obj) container_of(obj, struct xilinx_spi_conf=
, core)
=20
-	err =3D wait_for_init_b(mgr, 0, 0);
-	if (err)
-		return err;
-
-	if (get_done_gpio(mgr)) {
-		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
-		return -EIO;
-	}
-
-	/* program latency */
-	usleep_range(7500, 7600);
-	return 0;
-}
-
-static int xilinx_spi_write(struct fpga_manager *mgr, const char *buf,
+static int xilinx_spi_write(struct xilinx_fpga_core *core, const char *b=
uf,
 			    size_t count)
 {
-	struct xilinx_spi_conf *conf =3D mgr->priv;
+	struct xilinx_spi_conf *conf =3D to_xilinx_spi_conf(core);
 	const char *fw_data =3D buf;
 	const char *fw_data_end =3D fw_data + count;
=20
@@ -143,7 +40,7 @@ static int xilinx_spi_write(struct fpga_manager *mgr, =
const char *buf,
=20
 		ret =3D spi_write(conf->spi, fw_data, stride);
 		if (ret) {
-			dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
+			dev_err(core->dev, "SPI error in firmware write: %d\n",
 				ret);
 			return ret;
 		}
@@ -153,109 +50,26 @@ static int xilinx_spi_write(struct fpga_manager *mg=
r, const char *buf,
 	return 0;
 }
=20
-static int xilinx_spi_apply_cclk_cycles(struct xilinx_spi_conf *conf)
-{
-	struct spi_device *spi =3D conf->spi;
-	const u8 din_data[1] =3D { 0xff };
-	int ret;
-
-	ret =3D spi_write(conf->spi, din_data, sizeof(din_data));
-	if (ret)
-		dev_err(&spi->dev, "applying CCLK cycles failed: %d\n", ret);
-
-	return ret;
-}
-
-static int xilinx_spi_write_complete(struct fpga_manager *mgr,
-				     struct fpga_image_info *info)
-{
-	struct xilinx_spi_conf *conf =3D mgr->priv;
-	unsigned long timeout =3D jiffies + usecs_to_jiffies(info->config_compl=
ete_timeout_us);
-	bool expired =3D false;
-	int done;
-	int ret;
-
-	/*
-	 * This loop is carefully written such that if the driver is
-	 * scheduled out for more than 'timeout', we still check for DONE
-	 * before giving up and we apply 8 extra CCLK cycles in all cases.
-	 */
-	while (!expired) {
-		expired =3D time_after(jiffies, timeout);
-
-		done =3D get_done_gpio(mgr);
-		if (done < 0)
-			return done;
-
-		ret =3D xilinx_spi_apply_cclk_cycles(conf);
-		if (ret)
-			return ret;
-
-		if (done)
-			return 0;
-	}
-
-	if (conf->init_b) {
-		ret =3D gpiod_get_value(conf->init_b);
-
-		if (ret < 0) {
-			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
-			return ret;
-		}
-
-		dev_err(&mgr->dev,
-			ret ? "CRC error or invalid device\n"
-			: "Missing sync word or incomplete bitstream\n");
-	} else {
-		dev_err(&mgr->dev, "Timeout after config data transfer\n");
-	}
-
-	return -ETIMEDOUT;
-}
-
-static const struct fpga_manager_ops xilinx_spi_ops =3D {
-	.state =3D xilinx_spi_state,
-	.write_init =3D xilinx_spi_write_init,
-	.write =3D xilinx_spi_write,
-	.write_complete =3D xilinx_spi_write_complete,
-};
-
 static int xilinx_spi_probe(struct spi_device *spi)
 {
 	struct xilinx_spi_conf *conf;
-	struct fpga_manager *mgr;
=20
 	conf =3D devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
 		return -ENOMEM;
=20
+	conf->core.dev =3D &spi->dev;
+	conf->core.write =3D xilinx_spi_write;
 	conf->spi =3D spi;
=20
-	/* PROGRAM_B is active low */
-	conf->prog_b =3D devm_gpiod_get(&spi->dev, "prog_b", GPIOD_OUT_LOW);
-	if (IS_ERR(conf->prog_b))
-		return dev_err_probe(&spi->dev, PTR_ERR(conf->prog_b),
-				     "Failed to get PROGRAM_B gpio\n");
-
-	conf->init_b =3D devm_gpiod_get_optional(&spi->dev, "init-b", GPIOD_IN)=
;
-	if (IS_ERR(conf->init_b))
-		return dev_err_probe(&spi->dev, PTR_ERR(conf->init_b),
-				     "Failed to get INIT_B gpio\n");
-
-	conf->done =3D devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
-	if (IS_ERR(conf->done))
-		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
-				     "Failed to get DONE gpio\n");
-
-	mgr =3D devm_fpga_mgr_register(&spi->dev,
-				     "Xilinx Slave Serial FPGA Manager",
-				     &xilinx_spi_ops, conf);
-	return PTR_ERR_OR_ZERO(mgr);
+	return xilinx_core_probe(&conf->core);
 }
=20
 #ifdef CONFIG_OF
 static const struct of_device_id xlnx_spi_of_match[] =3D {
-	{ .compatible =3D "xlnx,fpga-slave-serial", },
+	{
+		.compatible =3D "xlnx,fpga-slave-serial",
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, xlnx_spi_of_match);
--=20
2.43.0


