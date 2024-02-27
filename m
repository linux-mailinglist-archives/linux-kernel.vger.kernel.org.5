Return-Path: <linux-kernel+bounces-84025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D961D86A188
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091A41C22466
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7614F9DF;
	Tue, 27 Feb 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="kXBsLGER"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E614F961
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068971; cv=none; b=fwJihAueycZjAFma38+JKmuVIXsxzhsD459vuRbWEqTsIsdZQjHIeuSzH4ttQZEZUXuFIpi0HcVHKKaALvaYLy6TyEeW3Q29Ydr0X+jeivFnYkBELITqXd6zef8sI5NCHRxT6QkXTVLsBWm8YwRBsOimgxaU7QP9h1gkr/ESNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068971; c=relaxed/simple;
	bh=qzfiETCWDTDKCh2kO3rgSBlBWXrnzAF7pzLqrMmcF4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb6qkZqLiuUY50UfVhj52iQUgagwZGFFXgnsUQl1OhBG5Fiu8bjLnUdiXRb7CB4BNghx8E8a/YJ01Eybm/KIH0U0NJQR+FybFU8oQUlpQ6HryN+shs1zHyUBihj47hzrAEDIghDPV8Tux//UkK2QHS36J0TaRgYlp2b2ZAaZCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=kXBsLGER; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B306C2C02AB;
	Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709068966;
	bh=bmOeu545IlDEfWmGK3n3UhjYbFI/JyDlqa6BrnpO7w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXBsLGERG+uysYrZysHfrOnXr3yfKbmmDdtJrEmLtPiR8o0mU7p/xZ1fJdAgGKesP
	 JuxhaERwRugwzv+rXQCHBil1/LmhghvPo8vbXox2RsWfpeiVQBKoCYjLFTvksQT7ef
	 tUKnMEHmgwk7yS4ZWrYmH79iog3RJ5QE1A11S64oLa7a4Jq0BPuknnwwxC36y1FMAb
	 bksStlvnFCYlzIKL4d5YOxsLDsNHLpOFkAcfezY/FzHtZUClzWYLKiL42Bt+uhSHaX
	 oGtd7Cu6JnX2pozxMiUQfZYVediiFVtmlP5PWgw5RX6U145jO2bPPEVHuXbzuZstMm
	 zzlrEB+OPO9Xg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65de52a60001>; Wed, 28 Feb 2024 10:22:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 619CE13EE4F;
	Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 5C74F280788; Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	ojeda@kernel.org,
	tzimmermann@suse.de,
	javierm@redhat.com,
	robin@protonic.nl,
	lee@kernel.org,
	pavel@ucw.cz
Cc: devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/4] auxdisplay: Add 7 segment LED display driver
Date: Wed, 28 Feb 2024 10:22:41 +1300
Message-ID: <20240227212244.262710-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65de52a6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=F0jKMMnsshfnaHI64i4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a driver for a 7 segment LED display. At the moment only one
character is supported but it should be possible to expand this to
support more characters and/or 14 segment displays in the future.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Rebased on top of auxdisplay/for-next dropping unnecessary code for=
 7
      segment maps.
    - Update for new linedisp_register() API
    - Include headers based on actual usage
    - Allow building as module
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 drivers/auxdisplay/Kconfig   |  10 +++
 drivers/auxdisplay/Makefile  |   1 +
 drivers/auxdisplay/seg-led.c | 119 +++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/auxdisplay/seg-led.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index d4be0a3695ce..52a245ca0c8d 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -211,6 +211,16 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
=20
+config SEG_LED
+	tristate "Generic 7 segment LED display"
+	select LINEDISP
+	help
+	  This driver supports a generic 7 segment LED display made up
+	  of GPIO pins connected to the individual segments.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called seg-led.
+
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index a725010ca651..744e354318ae 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_PARPORT_PANEL)	+=3D panel.o
 obj-$(CONFIG_LCD2S)		+=3D lcd2s.o
 obj-$(CONFIG_LINEDISP)		+=3D line-display.o
 obj-$(CONFIG_MAX6959)		+=3D max6959.o
+obj-$(CONFIG_SEG_LED)		+=3D seg-led.o
diff --git a/drivers/auxdisplay/seg-led.c b/drivers/auxdisplay/seg-led.c
new file mode 100644
index 000000000000..7bb304fcaa6e
--- /dev/null
+++ b/drivers/auxdisplay/seg-led.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for a 7 segment LED display
+ *
+ * The GPIOs are wired to the 7 segments in a clockwise fashion starting=
 from
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
+ * The decimal point LED present on some devices is currently not
+ * supported.
+ *
+ * Copyright (C) Allied Telesis Labs
+ */
+
+#include <linux/container_of.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "line-display.h"
+
+struct seg_led_priv {
+	struct gpio_descs *segment_gpios;
+	struct delayed_work work;
+	struct linedisp linedisp;
+};
+
+static void seg_led_update(struct work_struct *work)
+{
+	struct seg_led_priv *priv =3D container_of(work, struct seg_led_priv, w=
ork.work);
+	struct linedisp_map *map =3D priv->linedisp.map;
+	DECLARE_BITMAP(values, 8);
+
+	values[0] =3D map_to_seg7(&map->map.seg7, priv->linedisp.buf[0]);
+
+	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segme=
nt_gpios->desc,
+				       priv->segment_gpios->info, values);
+}
+
+static int seg_led_linedisp_get_map_type(struct linedisp *linedisp)
+{
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
+static const struct of_device_id seg_led_of_match[] =3D {
+	{ .compatible =3D "generic-gpio-7seg"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, seg_led_of_match);
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
+	INIT_DELAYED_WORK(&priv->work, seg_led_update);
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
+static struct platform_driver seg_led_driver =3D {
+	.probe =3D seg_led_probe,
+	.remove =3D seg_led_remove,
+	.driver =3D {
+		.name =3D "seg-led",
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


