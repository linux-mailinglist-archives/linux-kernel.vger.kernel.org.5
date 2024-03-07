Return-Path: <linux-kernel+bounces-96132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03E87577F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142AA282646
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE1C137C4C;
	Thu,  7 Mar 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="iM67tkxS"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A421369A6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841061; cv=none; b=kvXodRqW9W6UWVgyEvPbukJ5yvF9Mt1/Vu6jTJ4FZhH1nIv9Acx7LmnwOFi3sDarqT0aOAxqKDnGXfxZeO+jPMjKfQoPs7K21sgVuSWzFUcSrR4mCzroG0Sm/uB6uw+bWy9aYI1p32Wu/fv5dwZUtSRmOJ9Y90O70gKV8UVG+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841061; c=relaxed/simple;
	bh=dcuwCIcPkwlpCeqeGzB2ahg6kGQcvfajIjuTZHCKCRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJOkWcmRmhixybd8RiRYnhfNrX8Y4hF+N5Uez1L6FfNc49UiO80xSkBMj32XMwECw3MI+c6heLKQvJESu/MliRHx+2xmxyG7i2SANNMu85VTJ9FsgumC2OcziU/WjehuigzALtaextH6H32vIP6nSTQ83dWwtsTMt/wrHk3olL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=iM67tkxS; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 23AA92C0191;
	Fri,  8 Mar 2024 08:50:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709841056;
	bh=eIbYqqtkIi1075lhYmfRmxlxQ5ZAYFkVhvIGsJudGBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iM67tkxSt9glgR1LT4D0eVaavY5b8uiqSPva18UDbDMzd4zFGG57A+S//Eo+vdO9T
	 SkQg96sH4VLW22WPgY4alI9eBuG96q1znaj3AiKRc/rk+y+Au/73HQBOgBa/8zu5pD
	 ERv3NyBDQn0ZT0rCdl/A1G8B2pTtVGjGemlS4tMxnT7LW0P5hgVHO3ulfIMTV3eiho
	 xKljU53oz/U/E06DQuwwlU3b6KEOVKGS7WMgseAtzEWDQVJgbr4SykgjGeN0ilaG6V
	 a/q+0oZ+ZH/GGYlm5NLUQrur3udU/dU5Y7bAwSI/JhwhRwCXIdwThMVIK9VDgexsdQ
	 SNhwY5hHLtXEw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65ea1a9f0002>; Fri, 08 Mar 2024 08:50:55 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id C19E013EE6D;
	Fri,  8 Mar 2024 08:50:55 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id B98E22806D9; Fri,  8 Mar 2024 08:50:55 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 1/3] auxdisplay: Add 7-segment LED display driver
Date: Fri,  8 Mar 2024 08:50:51 +1300
Message-ID: <20240307195053.1320538-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
References: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65ea1a9f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=U_IlPVK5r1qgVbMESHIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a driver for a 7-segment LED display. At the moment only one
character is supported but it should be possible to expand this to
support more characters and/or 14-segment displays in the future.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v6:
    - Enforce maximum number of GPIOs
    - Drop unnecessary 0 in initialiser
    Changes in v5:
    - Add depends on GPIOLIB || COMPILE_TEST
    - Validate that we get enough GPIOs
    Changes in v4:
    - Fix one more usage of 7 segment
    - Move ASCII art diagram to DT binding
    - Include map_to_7segment.h for map_to_seg7()
    - Use initialiser for values in seg_led_update
    Changes in v3:
    - "7 segment" -> "7-Segment" in Kconfig help text
    - Update after feedback from Andy
    - Use compatible =3D "gpio-7-segment" as suggested by Rob
    Changes in v2:
    - Rebased on top of auxdisplay/for-next dropping unnecessary code for=
 7
      segment maps.
    - Update for new linedisp_register() API
    - Include headers based on actual usage
    - Allow building as module
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 drivers/auxdisplay/Kconfig        |  11 +++
 drivers/auxdisplay/Makefile       |   1 +
 drivers/auxdisplay/seg-led-gpio.c | 112 ++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/auxdisplay/seg-led-gpio.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index d4be0a3695ce..151d95f96b11 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -211,6 +211,17 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
=20
+config SEG_LED_GPIO
+	tristate "Generic 7-segment LED display"
+	depends on GPIOLIB || COMPILE_TEST
+	select LINEDISP
+	help
+	  This driver supports a generic 7-segment LED display made up
+	  of GPIO pins connected to the individual segments.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called seg-led-gpio.
+
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index a725010ca651..4a8ea41b0550 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_PARPORT_PANEL)	+=3D panel.o
 obj-$(CONFIG_LCD2S)		+=3D lcd2s.o
 obj-$(CONFIG_LINEDISP)		+=3D line-display.o
 obj-$(CONFIG_MAX6959)		+=3D max6959.o
+obj-$(CONFIG_SEG_LED_GPIO)	+=3D seg-led-gpio.o
diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-l=
ed-gpio.c
new file mode 100644
index 000000000000..5dc2a006cac5
--- /dev/null
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for a 7-segment LED display
+ *
+ * The decimal point LED present on some devices is currently not
+ * supported.
+ *
+ * Copyright (C) Allied Telesis Labs
+ */
+
+#include <linux/bitmap.h>
+#include <linux/container_of.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/map_to_7segment.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "line-display.h"
+
+struct seg_led_priv {
+	struct linedisp linedisp;
+	struct delayed_work work;
+	struct gpio_descs *segment_gpios;
+};
+
+static void seg_led_update(struct work_struct *work)
+{
+	struct seg_led_priv *priv =3D container_of(work, struct seg_led_priv, w=
ork.work);
+	struct linedisp *linedisp =3D &priv->linedisp;
+	struct linedisp_map *map =3D linedisp->map;
+	DECLARE_BITMAP(values, 8) =3D { };
+
+	bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0])=
, 0);
+
+	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segme=
nt_gpios->desc,
+				       priv->segment_gpios->info, values);
+}
+
+static int seg_led_linedisp_get_map_type(struct linedisp *linedisp)
+{
+	struct seg_led_priv *priv =3D container_of(linedisp, struct seg_led_pri=
v, linedisp);
+
+	INIT_DELAYED_WORK(&priv->work, seg_led_update);
+	return LINEDISP_MAP_SEG7;
+}
+
+static void seg_led_linedisp_update(struct linedisp *linedisp)
+{
+	struct seg_led_priv *priv =3D container_of(linedisp, struct seg_led_pri=
v, linedisp);
+
+	schedule_delayed_work(&priv->work, 0);
+}
+
+static const struct linedisp_ops seg_led_linedisp_ops =3D {
+	.get_map_type =3D seg_led_linedisp_get_map_type,
+	.update =3D seg_led_linedisp_update,
+};
+
+static int seg_led_probe(struct platform_device *pdev)
+{
+	struct seg_led_priv *priv;
+	struct device *dev =3D &pdev->dev;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->segment_gpios =3D devm_gpiod_get_array(dev, "segment", GPIOD_OUT_=
LOW);
+	if (IS_ERR(priv->segment_gpios))
+		return PTR_ERR(priv->segment_gpios);
+
+	if (priv->segment_gpios->ndescs < 7 || priv->segment_gpios->ndescs > 8)
+		return -EINVAL;
+
+	return linedisp_register(&priv->linedisp, dev, 1, &seg_led_linedisp_ops=
);
+}
+
+static int seg_led_remove(struct platform_device *pdev)
+{
+	struct seg_led_priv *priv =3D platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&priv->work);
+	linedisp_unregister(&priv->linedisp);
+
+	return 0;
+}
+
+static const struct of_device_id seg_led_of_match[] =3D {
+	{ .compatible =3D "gpio-7-segment"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, seg_led_of_match);
+
+static struct platform_driver seg_led_driver =3D {
+	.probe =3D seg_led_probe,
+	.remove =3D seg_led_remove,
+	.driver =3D {
+		.name =3D "seg-led-gpio",
+		.of_match_table =3D seg_led_of_match,
+	},
+};
+module_platform_driver(seg_led_driver);
+
+MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
+MODULE_DESCRIPTION("7 segment LED driver");
+MODULE_LICENSE("GPL");
--=20
2.43.2


