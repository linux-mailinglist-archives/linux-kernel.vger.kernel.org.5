Return-Path: <linux-kernel+bounces-80310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB9862D36
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9ECB20B00
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914B1BC5A;
	Sun, 25 Feb 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UdI/plJr"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C41B950
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896886; cv=none; b=grl37mC57E4f1dzPbl7lrjJEXIoA+wow+jnkHsXCxzbR0oCcBqx7GFRBThtNLyZZGINfE2yt79pJ5ikso0By0BeZPX7pDgVwapo4yTZSUAGShfR61g2b4lDNNUjrWKl0/RfEBuQs6SMhQj15CgNEctk5OgZzuV3uBiP99jFAKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896886; c=relaxed/simple;
	bh=SdZOKZXPjiq5MBQHbcDJJWZtWB3WvC2tXqy38ykXjE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTnoTv1YJlhdQiJj5BEMq4IcIhoxe6Scx03QcojH8yhbJj4J7mQatl5vPPQpMEbDbH4ve5Z71bYn4jyHbHFAAyCI6l6uAzVWe8QNaHK3+HwUnNWZ0G2giL2QzDQdecsJkBiTbVQmtyywZa4JnU8pHyzQQlCKkEr6EhawsKXNBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=UdI/plJr; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F3AC52C07F0;
	Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708896875;
	bh=jbmr+ls+8vmNT0RepVMQNTeMhYsEBu7U/6wroDdbQ9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdI/plJrktm39vQGTA+E6G9Wvzhhv9+J9Wa3fo2OVexTPQNFgtmE0FLUefQO0w28e
	 bLcWdo0pcrDgWknVV32mlrB0LvCg2oCO8ydpTfHpyIPfblmDVM8ooE01+AfYi/JFL8
	 GXxbGDEiXtfvAD3bPFD/SLGmhTFYUtAoy0cTBEuMiayDRkKF3+uHorHMwTf8bHlcKl
	 7fcvxaiHF3uJXc+oReQl2TAirYE7LNnBy0aD2Lf0h9xKiDmuCTqCOTndx4y6DHDb9i
	 5J5EHQovwLxiO4peujLCAk32LppVuHUuH8Wu7fIdp62khFmPXn7d2YCrLny+7txgdW
	 Dfvzgr0maIQkw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dbb26b0001>; Mon, 26 Feb 2024 10:34:35 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9CB9613EE4F;
	Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 97F9D28031B; Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: ojeda@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	andy.shevchenko@gmail.com,
	geert@linux-m68k.org,
	pavel@ucw.cz,
	lee@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/3] auxdisplay: Add 7 segment LED display driver
Date: Mon, 26 Feb 2024 10:34:21 +1300
Message-ID: <20240225213423.690561-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dbb26b a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=F0jKMMnsshfnaHI64i4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a driver for a 7 segment LED display. At the moment only one
character is supported but it should be possible to expand this to
support more characters and/or 14 segment displays in the future.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/auxdisplay/Kconfig   |   7 ++
 drivers/auxdisplay/Makefile  |   1 +
 drivers/auxdisplay/seg-led.c | 152 +++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/auxdisplay/seg-led.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index d944d5298eca..e826b5b15881 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -197,6 +197,13 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
=20
+config SEG_LED
+	bool "Generic 7 segment LED display"
+	select LINEDISP
+	help
+	  This driver supports a generic 7 segment LED display made up
+	  of GPIO pins connected to the individual segments.
+
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 6968ed4d3f0a..808fdf156bd5 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_HT16K33)		+=3D ht16k33.o
 obj-$(CONFIG_PARPORT_PANEL)	+=3D panel.o
 obj-$(CONFIG_LCD2S)		+=3D lcd2s.o
 obj-$(CONFIG_LINEDISP)		+=3D line-display.o
+obj-$(CONFIG_SEG_LED)		+=3D seg-led.o
diff --git a/drivers/auxdisplay/seg-led.c b/drivers/auxdisplay/seg-led.c
new file mode 100644
index 000000000000..c0b302a09cbb
--- /dev/null
+++ b/drivers/auxdisplay/seg-led.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for a 7 segment LED display
+ *
+ * The GPIOs are wired to the 7 segments in a clock wise fashion startin=
g from
+ * the top.
+ *
+ *      -a-
+ *     |   |
+ *     f   b
+ *     |   |
+ *      -g-
+ *     |   |
+ *     e   c
+ *     |   |
+ *      -d-
+ *
+ * The decimal point LED presnet on some devices is currently not
+ * supported.
+ *
+ * Copyright (C) Allied Telesis Labs
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/map_to_7segment.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "line-display.h"
+
+struct seg_led_priv {
+	struct gpio_descs *segment_gpios;
+	struct delayed_work work;
+	struct linedisp linedisp;
+	struct seg7_conversion_map seg7;
+	unsigned int map_size;
+	size_t num_char;
+	char curr[];
+};
+
+static const SEG7_DEFAULT_MAP(initial_map_seg7);
+
+static ssize_t map_seg7_show(struct device *dev, struct device_attribute=
 *attr,
+			     char *buf)
+{
+	struct seg_led_priv *priv =3D dev_get_drvdata(dev);
+
+	memcpy(buf, &priv->seg7, priv->map_size);
+	return priv->map_size;
+}
+
+static ssize_t map_seg7_store(struct device *dev, struct device_attribut=
e *attr,
+			      const char *buf, size_t cnt)
+{
+	struct seg_led_priv *priv =3D dev_get_drvdata(dev);
+
+	if (cnt !=3D priv->map_size)
+		return -EINVAL;
+
+	memcpy(&priv->seg7, buf, cnt);
+	return cnt;
+}
+
+static DEVICE_ATTR_RW(map_seg7);
+
+static void seg_led_linedisp_update(struct linedisp *linedisp)
+{
+	struct seg_led_priv *priv =3D container_of(linedisp, struct seg_led_pri=
v, linedisp);
+
+	schedule_delayed_work(&priv->work, 0);
+}
+
+static void seg_led_update(struct work_struct *work)
+{
+	struct seg_led_priv *priv =3D container_of(work, struct seg_led_priv, w=
ork.work);
+	DECLARE_BITMAP(values, 8);
+
+	values[0] =3D map_to_seg7(&priv->seg7, priv->curr[0]);
+
+	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segme=
nt_gpios->desc,
+				       priv->segment_gpios->info, values);
+}
+
+static const struct of_device_id seg_led_of_match[] =3D {
+	{ .compatible =3D "generic,gpio-7seg"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, seg_led_of_match);
+
+static int seg_led_probe(struct platform_device *pdev)
+{
+	struct seg_led_priv *priv;
+	int err;
+
+	priv =3D devm_kzalloc(&pdev->dev, struct_size(priv, curr, 1), GFP_KERNE=
L);
+	if (!priv)
+		return -ENOMEM;
+	priv->num_char =3D 1;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->segment_gpios =3D devm_gpiod_get_array(&pdev->dev, "segment", GPI=
OD_OUT_LOW);
+	if (IS_ERR(priv->segment_gpios))
+		return PTR_ERR(priv->segment_gpios);
+
+	priv->seg7 =3D initial_map_seg7;
+	priv->map_size =3D sizeof(priv->seg7);
+
+	err =3D device_create_file(&pdev->dev, &dev_attr_map_seg7);
+	if (err)
+		return err;
+
+	INIT_DELAYED_WORK(&priv->work, seg_led_update);
+
+	err =3D linedisp_register(&priv->linedisp, &pdev->dev, 1, priv->curr,
+				seg_led_linedisp_update);
+	if (err) {
+		device_remove_file(&pdev->dev, &dev_attr_map_seg7);
+		return err;
+	}
+
+	return 0;
+}
+
+static int seg_led_remove(struct platform_device *pdev)
+{
+	struct seg_led_priv *priv =3D platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&priv->work);
+	linedisp_unregister(&priv->linedisp);
+	device_remove_file(&pdev->dev, &dev_attr_map_seg7);
+
+	return 0;
+}
+
+static struct platform_driver seg_led_driver =3D {
+	.probe =3D seg_led_probe,
+	.remove =3D seg_led_remove,
+	.driver =3D {
+		.name =3D "seg-led",
+		.of_match_table =3D seg_led_of_match,
+	},
+};
+
+module_platform_driver(seg_led_driver);
+
+MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
+MODULE_DESCRIPTION("7 segment LED driver");
+MODULE_LICENSE("GPL");
+
--=20
2.43.2


