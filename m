Return-Path: <linux-kernel+bounces-47336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDF844CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC4B1F23460
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA941757;
	Wed, 31 Jan 2024 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="qJsPClIu"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC963B193;
	Wed, 31 Jan 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742381; cv=none; b=ZZ16jarE+QUq/XKKfQR3e8hUimRb+eBE5Xv4CCBEIx/H+VmLLV6VtiTPrraOtS0hcAGcOQg21T/oQbwq3r7dlvlB4YUkyHYON3NZ282GyS2c+c1uUYxW+eWGkbE+imBOb5zIkoN8yzpQ9Qvv557tPmye1RrPz12eW95ihyciI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742381; c=relaxed/simple;
	bh=OLFlhXsNJUnGrTLhdRM/pYZjtVkTK0JMd1HZFWemSoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMLp6Fu5mBZpKnONJw0bANIt0peGhvh6i0yVWpZjZyMS7O3KihI3aW9WpKWMdWczjh1X438tSw1LsVNx9JTRGY67jfBgZQdWl0GGwUuBtJwO3ZVUG8/fBsRbEEEoRg5aOD1lp54zNI4dC1Oq0xz2nskZtz/U/hWvK1OuQ/k5sZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=qJsPClIu; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 99E7E9C2794;
	Wed, 31 Jan 2024 18:06:17 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id l5vL5cMf2Pv5; Wed, 31 Jan 2024 18:06:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 45DF99C2C74;
	Wed, 31 Jan 2024 18:06:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 45DF99C2C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706742376; bh=0pXAIZwgHMKwu0Wf+HzHt+zMXpKLdLgKffCS3Er+NSA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=qJsPClIu56PAAs4uFIMWqlao5kyLSS/3LHjPhlv8ODXbP8aPVc3fLlmC2j9zSpWTa
	 NsloOCZHtu/Not6akXFrXeMhZxiWgp1qH5l1AKswNIfurOSl4VI6hl3UnI+Qu97H7j
	 m0SeehXoUXQT/oS61tsUmMcbWC7W/wiNW89laoBo8P/t7nqhYhVCnH5W2Ztgs8gz1x
	 RiV2xknTpcYj8eqljPsmnueeuFO25WYp5MdR7mjfzQTAltVhigEHodT+JwzcwibeWa
	 YIN/0mxzt0SN6Rvzozn7Qg44mekRtaFFKJ4iW72CFq3JKkBgOaPt3Kb2MI5cFpw7x4
	 /eB1PSgDaVGmw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tkKwWwiTgTvW; Wed, 31 Jan 2024 18:06:16 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 20F309C2794;
	Wed, 31 Jan 2024 18:06:16 -0500 (EST)
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
Subject: [PATCH 1/3] fpga: xilinx-spi: extract a common driver core
Date: Wed, 31 Jan 2024 18:05:31 -0500
Message-ID: <20240131230542.3993409-2-charles.perry@savoirfairelinux.com>
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

Factor out the gpio handshaking (using PROGRAM_B, INIT_B and DONE)
protocol in xilinx-core so that it can be reused for another driver.
This commit does not change anything functionally to xilinx-spi.

xilinx-core expects drivers to provide two operations:

 * ->write(const char* buf, size_t count): write to the device
 * ->write_one_dummy_byte(): write 0xFF to the device

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/fpga/Kconfig       |   4 +
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/xilinx-core.c | 210 +++++++++++++++++++++++++++++++++++++
 drivers/fpga/xilinx-core.h |  27 +++++
 drivers/fpga/xilinx-spi.c  | 204 +++--------------------------------
 5 files changed, 257 insertions(+), 189 deletions(-)
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
index 0000000000000..aff40e9394085
--- /dev/null
+++ b/drivers/fpga/xilinx-core.c
@@ -0,0 +1,210 @@
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
+
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
+		ret =3D core->write_one_dummy_byte(core);
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
+int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
+		      xilinx_write_func write,
+		      xilinx_write_one_dummy_byte_func write_one_dummy_byte)
+{
+	struct fpga_manager *mgr;
+
+	core->dev =3D dev;
+	core->write =3D write;
+	core->write_one_dummy_byte =3D write_one_dummy_byte;
+
+	/* PROGRAM_B is active low */
+	core->prog_b =3D devm_gpiod_get(dev, "prog_b", GPIOD_OUT_LOW);
+	if (IS_ERR(core->prog_b))
+		return dev_err_probe(dev, PTR_ERR(core->prog_b),
+				     "Failed to get PROGRAM_B gpio\n");
+
+	core->init_b =3D devm_gpiod_get_optional(dev, "init-b", GPIOD_IN);
+	if (IS_ERR(core->init_b))
+		return dev_err_probe(dev, PTR_ERR(core->init_b),
+				     "Failed to get INIT_B gpio\n");
+
+	core->done =3D devm_gpiod_get(dev, "done", GPIOD_IN);
+	if (IS_ERR(core->done))
+		return dev_err_probe(dev, PTR_ERR(core->done),
+				     "Failed to get DONE gpio\n");
+
+	mgr =3D devm_fpga_mgr_register(dev, "Xilinx Slave Serial FPGA Manager",
+				     &xilinx_core_ops, core);
+	return PTR_ERR_OR_ZERO(mgr);
+}
diff --git a/drivers/fpga/xilinx-core.h b/drivers/fpga/xilinx-core.h
new file mode 100644
index 0000000000000..40e120945ba70
--- /dev/null
+++ b/drivers/fpga/xilinx-core.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __XILINX_CORE_H
+#define __XILINX_CORE_H
+
+#include <linux/device.h>
+
+struct xilinx_fpga_core;
+
+typedef int (*xilinx_write_func)(struct xilinx_fpga_core *core, const ch=
ar *buf,
+				 size_t count);
+typedef int (*xilinx_write_one_dummy_byte_func)(struct xilinx_fpga_core =
*core);
+
+struct xilinx_fpga_core {
+	struct device *dev;
+	xilinx_write_func write;
+	xilinx_write_one_dummy_byte_func write_one_dummy_byte;
+	struct gpio_desc *prog_b;
+	struct gpio_desc *init_b;
+	struct gpio_desc *done;
+};
+
+int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
+		      xilinx_write_func write,
+		      xilinx_write_one_dummy_byte_func write_one_dummy_byte);
+
+#endif /* __XILINX_CORE_H */
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index e1a227e7ff2ae..ec128dee97312 100644
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
+#define to_xilinx_spi_conf(obj) container_of(obj, struct xilinx_spi_conf=
, core)
=20
-	err =3D wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
-	if (err) {
-		gpiod_set_value(conf->prog_b, 0);
-		return err;
-	}
-
-	gpiod_set_value(conf->prog_b, 0);
-
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
@@ -153,77 +50,22 @@ static int xilinx_spi_write(struct fpga_manager *mgr=
, const char *buf,
 	return 0;
 }
=20
-static int xilinx_spi_apply_cclk_cycles(struct xilinx_spi_conf *conf)
+static int xilinx_spi_apply_cclk_cycles(struct xilinx_fpga_core *core)
 {
-	struct spi_device *spi =3D conf->spi;
+	struct xilinx_spi_conf *conf =3D to_xilinx_spi_conf(core);
 	const u8 din_data[1] =3D { 0xff };
 	int ret;
=20
 	ret =3D spi_write(conf->spi, din_data, sizeof(din_data));
 	if (ret)
-		dev_err(&spi->dev, "applying CCLK cycles failed: %d\n", ret);
+		dev_err(core->dev, "applying CCLK cycles failed: %d\n", ret);
=20
 	return ret;
 }
=20
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
@@ -231,31 +73,15 @@ static int xilinx_spi_probe(struct spi_device *spi)
=20
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
+	return xilinx_core_probe(&conf->core, &spi->dev, xilinx_spi_write,
+				 xilinx_spi_apply_cclk_cycles);
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


