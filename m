Return-Path: <linux-kernel+bounces-143924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3B8A3FB7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816E028224D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97095823C;
	Sat, 13 Apr 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV0yuJiR"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF25822D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052584; cv=none; b=HIew1IPYdFNvDbZQkRvtuYNWvMm2M5t/cU7NDYZE9/QLuP76wy0ltGew+hZBuD6h9uBuMwHEUyCyJyA2QAkz/YmoaIa0tP/1w3G/aUUJllGc+5/zyS9eDr5nqGrNC8EXaZujjgY4fQogD2CmOsfjwmB/Pwat7ywE9tK3DUPfx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052584; c=relaxed/simple;
	bh=+rQKjsWKkF5WVIXm0tlmggLd86PgwjLOBVKIvi8IZY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MJsGR8+CqAxtP/HQwnZ6Jj3Q+IvlTGorTvgdJIu5VO4cTx1blrfK0cikvN4YddDAt2H34Vp/QznjDlwFsQM+dAYaiGtfumhE7CAeT6r10Q8WNjdrX42BgZxBF0Ev3Htc5lalyRXgZFFN3eOFSYRiKJ2P88iStSMbbCLgoX5rnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV0yuJiR; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a4930d9c48so1033212eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713052581; x=1713657381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlo8iiW9XzNbwgCxhCI3oz9F/KupitoTXB2VwtVn9QI=;
        b=ZV0yuJiRUHCIFMlwW/0cQZpdIIx3nNuf9+ExR59LjmQlYqPeUYBl6crHfwxnv4nU7D
         uVaQ4tYPayNF8xw31joWjK5IzDlnxtNwIIIvTWa1p42N2gLdjgkXV6vrZtfMu84oZghS
         z1cwPjO/yDELVoohC57zhha2F/0UAF+/fHRcY1llL5XZYfcA/CD8ykgmklOeq0Q1qPpK
         EMWjTdGbk9jFNoIYkQ9hkDQD/i7VsBjxg3/XQsT0c/hh644jN2ZwY+ywtFGr50TWaX7h
         LRgx4sGN83yzYE7aZRSksauTg6z7xMNXTaqWKDw5YzBfPmFBiEO7iDRe3gw7jsvUxJoK
         9Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052581; x=1713657381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlo8iiW9XzNbwgCxhCI3oz9F/KupitoTXB2VwtVn9QI=;
        b=Co3yC9+xzP1pUaFycuebRt/RqUNTEcUNocVE8WE+H59WCZbxK6pSS5yUx/YrhIZdZC
         Q/KsfJd1M2kaTKxfzu+SjmxKhY5sE+dNyO/WMigf0ornM25wBOWz5icf8VgvD25Q7eg9
         bvfIGsrAJSmQPJfV1CijT9EqjnX7YCyGE75tgb5DD2XuxF8MbzNwjei7usq5gp49CAKF
         g+Vl+4TZBaf1X6iuiVAV3el+erTecJTr0H+zsQHPH9zymEGFplRsv9sYRNa4Vs40zuMR
         Gu33VdNREyoZX+cBoMARcLgCWa0vPC85RNE/dqRC7xW8fFtTm3XSFgJUm1LRsgtndyhM
         plgg==
X-Gm-Message-State: AOJu0YzZg/MeCwZWbfHvAgzRixopNpbo5yFJv+Dl4XJ5MH2XLROF1y6k
	8ekbx3uWJcSqExeoTcwgEi1WAJMD33CQDKe7AzBF5rmBUTL8G09NZGqeUohV
X-Google-Smtp-Source: AGHT+IHZLfmH4vSy+8/9v9lUfqHzU8MYj0rSF/HuiKH+LCO8N1xSWPVyVEi/YRDpE7ZqFqyuslnwGw==
X-Received: by 2002:a05:6808:2204:b0:3c6:394:2334 with SMTP id bd4-20020a056808220400b003c603942334mr7431610oib.2.1713052580988;
        Sat, 13 Apr 2024 16:56:20 -0700 (PDT)
Received: from SDF-ThinkCentre-M93p.localdomain (c-76-17-255-148.hsd1.mn.comcast.net. [76.17.255.148])
        by smtp.googlemail.com with ESMTPSA id x64-20020a25ce43000000b00dc74258241fsm1375829ybe.45.2024.04.13.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:56:20 -0700 (PDT)
From: Shimrra Shai <shimmyshai00@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Max Schwarz <max.schwarz@online.de>,
	Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
	Niyas Sait <niyas.sait@huawei.com>,
	Shimrra Shai <shimmyshai00@gmail.com>
Subject: [PATCH 0/0] [v2] Add ACPI binding to Rockchip RK3xxx I2C bus
Date: Sat, 13 Apr 2024 19:03:55 -0500
Message-Id: <20240414000355.10984-1-shimmyshai00@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a second version of the patch that I submitted a few weeks ago for
adding an ACPI binding for I2C bringup on the Rockchip RK3xxx
(specifically, RK3588) platforms for compatibility with the newfangled
TianoCore EDK2 firmwares. This was previously discussed here:

https://lore.kernel.org/linux-kernel/20240321173447.15660-1-shimmyshai00@gmail.com/

After some convo with the maintainer of the firmware, it was suggested I
should have a kernel patch ready and approvable here before he can amend
the ACPI tables in it. The following patch accepts an ACPI table entry for
the I2C busses that looks like this:

  Device (I2Cx) {
    Name (_HID, "RKCP3001")
    Name (_CID, "PRP0001")
    Name (_UID, x)
    Name (_CCA, 0)

    Method (_CRS, 0x0, Serialized) {
      Name (RBUF, ResourceTemplate() {
        Memory32Fixed (ReadWrite, 0xfea90000, 0x1000)
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 350 }
        ClockInput (198000000, 1, Hz, Fixed, "\\_SB_.CRU_", PCLK_I2Cx)
        ClockInput (198000000, 1, Hz, Fixed, "\\_SB_.CRU_", BCLK_I2Cx)
      })
      Return (RBUF)
    }
    Name (_DSD, Package () {
      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
      Package () {
        Package (2) { "compatible", Package (2) { "rockchip,rk3588-i2c", "rockchip,rk3399-i2c" } },
        Package (2) { "i2c,clk-rate", 198000000 },
        Package (2) { "rockchip,bclk", 198000000 },
        Package (2) { "#address-cells", 1 },
        Package (2) { "#size-cells", 0 },
      }
    })
  }

where "x" above in the name, _UID, and bindings should be replaced with the
bus number (0..8). There was some debate about how to specify the clock
rates in the first proposed version of this patch - in particular,
regarding the inclusion of the "i2c,clk-rate" and "rockchip,bclk" settings
in the _DSD section above. It was determined through correspondence with
the firmware team that the reason for the inclusion of these settings was
for compatibility with Microsoft Windows, but the kernel team here
suggested it would be better to use ClockInput bindings, introduced as of
ACPI 6.5. Hence, this patch is based on the assumption such bindings are
available and is designed to fetch the clock rates from them. Note how the
above example maintains both methods of specifying rates in parallel; this
is also documented in the patch and it is noted that the _DSD settings
should NOT be used in the kernel. The code to use ClockInput bindings is
based off a base patch suggested by Niyas Sait, as in the linked thread.

Signed-off-by: Shimrra Shai <shimmyshai00@gmail.com>
---

 Documentation/firmware-guide/acpi/dsd/soc/general.rst | 32 +++++++++
 Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst | 59 +++++++++++++++++
 drivers/acpi/Makefile                                 |  1 +
 drivers/acpi/acpi_clk.c                               | 93 +++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-rk3x.c                         | 79 ++++++++++++++++++++---
 include/linux/acpi.h                                  |  8 +++
 6 files changed, 262 insertions(+), 10 deletions(-)
 
diff --git a/Documentation/firmware-guide/acpi/dsd/soc/general.rst b/Documentation/firmware-guide/acpi/dsd/soc/general.rst
new file mode 100644
index 000000000..9c287e838
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/dsd/soc/general.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+System-on-Chip (SoC) facility descriptions
+==========================================
+
+These documents describe how to create ACPI profiles for devices composed into
+system-on-chip (SoC) architectures. Currently, we only describe the options
+availed in the _DSD block for select platforms; other considerations are not
+yet applied. The inspiration for these documents are based around the advent
+(as of March 2024) of hefty, non-Apple ARM SoC systems such as the Rockchip
+RK3588 and newer chips that have desktop-like performance and thus are prime
+candidates for a UEFI-based desktop-like boot system with the goal being to
+deliver the same user-friendly ease of loading operating systems as on the
+Intel x86 sphere. Open-source UEFI-based firmware engines, such as TianoCore
+[1], mean it is possible on such platforms for the open-source developer to
+control both firmware and kernel simultaneously, which is not the case for
+the situation with Intel-based PC boards where boards are provided with pre-
+baked, vendor-selected and opaque firmwares.
+
+The description of ACPI usage here is not meant to suggest that ACPI replace
+Device Tree altogether for such SoCs; rather, we recognize that given they
+often will have a variety of applications that may include embedded usage where
+that more hard-wired boot loader setups such as U-Boot still shine, the
+maintenance of ACPI and DTB-based configuration options should be in parallel,
+and it may be possible for the same firmware to deploy both options.
+
+References
+==========
+
+[1] EDK2-RK3588 port of TianoCore EDK2 firmware.
+    https://github.com/edk2-porting/edk2-rk3588
diff --git a/Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst b/Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst
new file mode 100644
index 000000000..0e6c5df65
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+I2C buses on SoCs
+=================
+
+This document describes the ACPI _DSD parameters currently being employed for
+Inter-Integrated Circuit (I2C) buses in the Linux kernel. It is based off the
+conventions used in the Rockchip RK3588 firmware project [1], which is also the
+first SoC documented here.
+
+General considerations
+======================
+
+For general use, we recommend indicating I2C busses in the ACPI firmware table
+in the following manner. First, they should be named I2Cx, where "x" is the bus
+index, and that index should also be used for the _UID component, e.g. on
+Rockchip RK3588 (see below), we use:
+
+  Device (I2Cx) {
+    Name (_HID, "RKCP3001")
+    Name (_CID, "PRP0001")
+    Name (_UID, x)
+    Name (_CCA, 0)
+
+    ...
+  }
+
+Interrupts should be specified in the usual ACPI manner. Likewise, as of ACPI
+6.5, clock rates should be given in ClockInput resources. Parameters specific to
+the Rockchip and I2C devices are indicated in the _DSD block as given below.
+The parameters are a curated selection from the Device Tree Blob (DTB)
+representation.
+
+_DSD parameters for different SoCs
+==================================
+
+Rockchip RK3588
+---------------
+
+The following parameters are indicated here for the I2C on Rockchip RK3588.
+
+- i2c,clk-rate 	Describe the pclk rate for the I2C bus, in Hz.
+- rockchip,bclk	Describe the bclk rate for the I2C bus, in Hz.
+
+These two parameters describe the peripheral (pclk) and bus (bclk) clock rates
+for the I2C bus. It is NOT recommended to use these clock rate parameters in the
+kernel, as they are intended for compatibility with Microsoft Windows. They are
+ONLY mentioned here for documentation's sake. Instead, the method mentioned
+earlier should be used to provide the clock rates; in the current revisions of
+the i2c-rk3x driver, the first clock resource appearing (resource 0) will be
+treated as giving the bclk rate, and the second clock resource (resource 1)
+appearing will be treated as giving the pclk rate.
+
+References
+==========
+
+[1] EDK2-RK3588 port of TianoCore EDK2 firmware.
+    https://github.com/edk2-porting/edk2-rk3588
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8cc8c0d9c..26343ffce 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -48,6 +48,7 @@ acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
 acpi-$(CONFIG_PCI)		+= acpi_lpss.o
 acpi-y				+= acpi_apd.o
+acpi-y				+= acpi_clk.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-y				+= power.o
diff --git a/drivers/acpi/acpi_clk.c b/drivers/acpi/acpi_clk.c
new file mode 100644
index 000000000..fbb1c4a4a
--- /dev/null
+++ b/drivers/acpi/acpi_clk.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * drivers/acpi/acpi_clk.c - ACPI device clock resources support.
+ *
+ * (C) 2023 Niyas Sait <niyas.sait@huawei.com>
+ * (C) 2024 Shimrra Shai <shimmyshai00@gmail.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+struct acpi_clk_lookup {
+	u16 freq_div;
+	u32 freq_num;
+	u8 scale;
+	u8 mode;
+	int index;
+	bool found;
+	int n;
+};
+
+static uint64_t calc_clock_rate(u32 freq_num, u16 freq_denom, u8 scale)
+{
+	uint32_t scale_factor[3] = { 1, 1000, 1000000 };
+	uint64_t rate = 0;
+
+	if (scale < ARRAY_SIZE(scale_factor))
+		rate = DIV_ROUND_UP(freq_num * scale_factor[scale], freq_denom);
+
+	return rate;
+}
+
+static int acpi_populate_clk_lookup(struct acpi_resource *ares, void *data)
+{
+	struct acpi_clk_lookup *lookup = data;
+	struct acpi_resource_clock_input *resource = &ares->data.clock_input;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_CLOCK_INPUT)
+		return 1;
+
+	if (lookup->n++ != lookup->index)
+		return 1;
+
+	lookup->mode = resource->mode;
+	lookup->freq_div = resource->frequency_divisor;
+	lookup->freq_num = resource->frequency_numerator;
+	lookup->scale = resource->scale;
+	lookup->found = true;
+
+	return 1;
+}
+
+struct clk *acpi_clk_register(struct acpi_device *adev, int index,
+			      const char *name)
+{
+	struct acpi_clk_lookup lookup;
+	struct list_head list;
+	struct clk *clk;
+	uint64_t rate;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.index = index;
+
+	ret = acpi_dev_get_resources(adev, &list, acpi_populate_clk_lookup,
+				     &lookup);
+	if (ret < 0)
+		return ERR_PTR(-ENODEV);
+
+	acpi_dev_free_resource_list(&list);
+
+	/* register fixed clocks only */
+	if (!lookup.found || lookup.mode != 0)
+		return ERR_PTR(-EINVAL);
+
+	rate = calc_clock_rate(lookup.freq_num, lookup.freq_div, lookup.scale);
+
+	const char *regname = name;
+
+	if (name == NULL)
+		regname = dev_name(&adev->dev);
+
+	clk = clk_register_fixed_rate(&adev->dev, regname, NULL, 0, rate);
+	clk_register_clkdev(clk, regname, NULL);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(acpi_clk_register);
+
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 086fdf262..1aaf2daba 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/acpi.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/wait.h>
@@ -1235,6 +1236,15 @@ static const struct of_device_id rk3x_i2c_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
 
+#ifdef CONFIG_ACPI
+/* for RK3588 and at least when loaded with EDK2-RK3588 Tianocore firmware */
+static const struct acpi_device_id rk3x_i2c_acpi_match[] = {
+	{ .id = "RKCP3001", .driver_data = (kernel_ulong_t)&rk3399_soc_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rk3x_i2c_acpi_match);
+#endif
+
 static int rk3x_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1243,6 +1253,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	int ret = 0;
 	int bus_nr;
 	u32 value;
+	u64 value64;
+	char name[64];
 	int irq;
 	unsigned long clk_rate;
 
@@ -1250,8 +1262,12 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	match = of_match_node(rk3x_i2c_match, np);
-	i2c->soc_data = match->data;
+	if (acpi_disabled) {
+		match = of_match_node(rk3x_i2c_match, np);
+		i2c->soc_data = match->data;
+	} else {
+		i2c->soc_data = device_get_match_data(&pdev->dev);
+	}
 
 	/* use common interface to get I2C timing properties */
 	i2c_parse_fw_timings(&pdev->dev, &i2c->t, true);
@@ -1266,6 +1282,9 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	i2c->dev = &pdev->dev;
 
+	if (!acpi_disabled)
+		ACPI_COMPANION_SET(&i2c->adap.dev, ACPI_COMPANION(&pdev->dev));
+
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
@@ -1273,8 +1292,25 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c->regs))
 		return PTR_ERR(i2c->regs);
 
-	/* Try to set the I2C adapter number from dt */
-	bus_nr = of_alias_get_id(np, "i2c");
+	if (acpi_disabled) {
+		/* Try to set the I2C adapter number from dt */
+		bus_nr = of_alias_get_id(np, "i2c");
+	} else {
+		ret = acpi_dev_uid_to_integer(ACPI_COMPANION(&pdev->dev),
+					      &value64);
+		if (ret) {
+			dev_err(&pdev->dev, "Cannot retrieve UID\n");
+			return ret;
+		}
+
+		if (value64 < INT_MAX) {
+			bus_nr = (int) value64;
+		} else {
+			/* shouldn't happen!!! */
+			dev_err(&pdev->dev, "Too big UID\n");
+			return -EINVAL;
+		}
+	}
 
 	/*
 	 * Switch to new interface if the SoC also offers the old one.
@@ -1325,13 +1361,36 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
-		/* Only one clock to use for bus clock and peripheral clock */
-		i2c->clk = devm_clk_get(&pdev->dev, NULL);
-		i2c->pclk = i2c->clk;
+	if (acpi_disabled) {
+		if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
+			/* Only one clock to use for bus clock and peripheral
+			 * clock
+			 */
+			i2c->clk = devm_clk_get(&pdev->dev, NULL);
+			i2c->pclk = i2c->clk;
+		} else {
+			i2c->clk = devm_clk_get(&pdev->dev, "i2c");
+			i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
+		}
 	} else {
-		i2c->clk = devm_clk_get(&pdev->dev, "i2c");
-		i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
+		if (i2c->soc_data->calc_timings != rk3x_i2c_v0_calc_timings) {
+			snprintf(name, sizeof(name), "rk3x-i2c[%d].bclk",
+				 bus_nr);
+			i2c->clk = acpi_clk_register(ACPI_COMPANION(&pdev->dev),
+						     0, name);
+
+			snprintf(name, sizeof(name), "rk3x-i2c[%d].pclk",
+				 bus_nr);
+			i2c->pclk = acpi_clk_register(ACPI_COMPANION(&pdev->dev),
+						      1, name);
+		} else {
+			/* NB: currently not expected w/UEFI firmware given
+			 * these are not super performant RK3xxx
+			 */
+			dev_err(&pdev->dev,
+				"ACPI not supported for this RK3xxx\n");
+			return -EINVAL;
+		}
 	}
 
 	if (IS_ERR(i2c->clk))
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c5..13ca67d2c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -32,6 +32,7 @@ struct irq_domain_ops;
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/fw_table.h>
+#include <linux/clk-provider.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -1569,4 +1570,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
 }
 #endif
 
+/* Clock support */
+
+#ifdef CONFIG_ACPI
+struct clk *acpi_clk_register(struct acpi_device *adev, int index,
+			      const char *name);
+#endif
+
 #endif	/*_LINUX_ACPI_H*/

