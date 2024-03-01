Return-Path: <linux-kernel+bounces-87792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA786D915
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2806E1C21933
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDC38F9A;
	Fri,  1 Mar 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="k0PcmdhK"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1152E3F9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257336; cv=none; b=bpCdn6EM0Ly+yw29S9YU3/9mrxkayrpaOgfR9dxdCP7twFEERzL9qBFdxIZuzfuK0IwMaZACZ7iPVhsF0zmbuizGoBrR0eLhmHvvCo9LF2YYJKQZoNOMSkHZaemNBfR0OYyVURKCtjTeJwI58//vdpTCN5w5sau04Ah01HVHYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257336; c=relaxed/simple;
	bh=RNUeX2QswcUV/QEhcNBHWEj8Ccpf3D8EvbFjfCOMyUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvlypJGHGfmhkjgHszqLsSAqmXCGrIL5eqsqenF5UPJLrpL56cfB/QaVQGykHCWzikghGdAjDwxBIE8vG4QimIJIx3enr7frz44DbpXxJOhYI8RaHlSBsplnXv8TxS7vlKqqClPBFyU8aQv/M8ws3DWhXPVB8gwuP2kqGQB5bhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=k0PcmdhK; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 443812C04EC;
	Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709257330;
	bh=zWXVDcjqgm2q5KyAz8sgdgp4FZWDT7x0PrMhgI7cPiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0PcmdhKPs/9cboPxvtOFHvfUzIdthQ9LqF/xKRmwRptHtx1TXLLCoLkigNAgDiKb
	 Jz6oO3xqsK3KjBwMVSkBAQ2ilskb3UOQGAhxgONBWXp0k93Xk8WRkK7jR+JKIP7AXB
	 4tlS8EfHc6c1QEV8IVn51LZBc3dpmKnVeAtvLYmNtOhih1i6fRNoCOaMzUwMogrbXz
	 u6Kcd+PdjmxOdhIt7r0KlZeLS83ArER3WWb8TynYH9sJAfa1CK22vDqE185b1dpmPf
	 U6Erg24lamFtAu0vBFFUU6cDy00pXcomrGy9mnH8R4fCbvzR2aHgMVq+upr+BkQTWI
	 yhmDWbwFyZHTQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e132720001>; Fri, 01 Mar 2024 14:42:10 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 0BCCA13EE4F;
	Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 07A38280062; Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	pavel@ucw.cz,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Date: Fri,  1 Mar 2024 14:42:00 +1300
Message-ID: <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e13272 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=F0jKMMnsshfnaHI64i4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a driver for a 7-segment LED display. At the moment only one
character is supported but it should be possible to expand this to
support more characters and/or 14-segment displays in the future.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
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

 drivers/auxdisplay/Kconfig        |  10 +++
 drivers/auxdisplay/Makefile       |   1 +
 drivers/auxdisplay/seg-led-gpio.c | 122 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/auxdisplay/seg-led-gpio.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index d4be0a3695ce..898ecfb34ed7 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -211,6 +211,16 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
=20
+config SEG_LED_GPIO
+	tristate "Generic 7-segment LED display"
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
index 000000000000..01aad84d0c82
--- /dev/null
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -0,0 +1,122 @@
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
+#include <linux/bitmap.h>
+#include <linux/container_of.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
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
+	DECLARE_BITMAP(values, 8);
+
+	bitmap_zero(values, 8);
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


