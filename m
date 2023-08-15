Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B877CB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjHOKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjHOKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:42:44 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7501BB;
        Tue, 15 Aug 2023 03:42:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RQ7Bh65Y8z9sSN;
        Tue, 15 Aug 2023 12:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1692096156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=aaFexMLw4I4u/on8fKS6nzjA+acRhoQwebKEZpPyH04=;
        b=X3hd3/w18/1KtoI/yPF7Cs9zrY8ZtIp+voBzhH8m8EV0lTzYYrle46GBARuUkk4r7vPG9w
        dg3dp0NlE3FWnvESeF5xCJy7SLc08k/OwrUYtMWA6hz4mWCtrtcemjw7dBr+YrP7B1hl25
        D64ogKJDxYzkDTxSO2LePw3gUlWa14kkpLlIpDZdVDnjzEFhU/EQTfVLxqund5jULOIA0i
        RCg5bGD40mNkYyIFq7FDCKXv54bh4cTZyWZwITKVBYiPN6z+MCfmwpWbVHs416nFTGZiKF
        9yGjgXfSGSGk3HfrXUVFS/3/SQB/obg9IGe+/Mf/nvmgg+SHspqrC0TibGNQWA==
Date:   Tue, 15 Aug 2023 12:42:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1692096153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=aaFexMLw4I4u/on8fKS6nzjA+acRhoQwebKEZpPyH04=;
        b=Nr+FeVCSa4GX+9tk1RCafwYTOwGKy7BDmI9c7S8kdjaFUW4utqyMIqDANRFCkpXCsAEmq3
        2mLQmNbfyqRCQIf8LiI8aUFQf+pXLWltzNKtLisj36jX+5pVJQ7m6EW2ok/JYz5Xope37E
        zsFCfCXZ7KwfaCfzn9GqtkhI/DGdivT4bG2o9neg/uLHJ/9/s98Q58M9ALrN25KrtijXQi
        m9mgE70+KhwQfTNarjUPghVdj9UYNEYU5NOCmUHWpYP9+LooqW/XzPDB5HyHSR2sUg5O1i
        N824O5Tcqphx6uQ1X/GoPyw2CCYzr7L0ZgUkpbb8S54gh21dsw2wEUaBtdIq5g==
From:   Loic Guegan <manzerbredes@mailbox.org>
To:     jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH] Adding a driver for the INA260 chip of Texas Instrument. It
 follows the hardware monitoring kernel API.
Message-ID: <ZNtWl_Jyj2PWBYpf@lguegan-thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VcPTyQb/Q5VvjApe"
Content-Disposition: inline
X-MBO-RS-META: aey4wixhfppfuttyok6inssax8zx5ntr
X-MBO-RS-ID: f94818aab7a60b918a6
X-Rspamd-Queue-Id: 4RQ7Bh65Y8z9sSN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VcPTyQb/Q5VvjApe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Loic Guegan <manzerbredes@mailbox.org>
---
 drivers/staging/Kconfig         |   2 +
 drivers/staging/Makefile        |   1 +
 drivers/staging/ina260/Kconfig  |   6 +
 drivers/staging/ina260/Makefile |   6 +
 drivers/staging/ina260/TODO     |   2 +
 drivers/staging/ina260/ina260.c | 261 ++++++++++++++++++++++++++++++++
 6 files changed, 278 insertions(+)
 create mode 100644 drivers/staging/ina260/Kconfig
 create mode 100644 drivers/staging/ina260/Makefile
 create mode 100644 drivers/staging/ina260/TODO
 create mode 100755 drivers/staging/ina260/ina260.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index f9aef39ca..e173e4353 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -78,4 +78,6 @@ source "drivers/staging/qlge/Kconfig"
=20
 source "drivers/staging/vme_user/Kconfig"
=20
+source "drivers/staging/ina260/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index ffa70dda4..a1d7e1ddb 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_PI433)		+=3D pi433/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+=3D axis-fifo/
 obj-$(CONFIG_FIELDBUS_DEV)     +=3D fieldbus/
 obj-$(CONFIG_QLGE)		+=3D qlge/
+obj-$(CONFIG_INA260)		+=3D ina260/
\ No newline at end of file
diff --git a/drivers/staging/ina260/Kconfig b/drivers/staging/ina260/Kconfig
new file mode 100644
index 000000000..e873abc9d
--- /dev/null
+++ b/drivers/staging/ina260/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+config INA260
+	tristate "Support for INA260 Power Monitoring i2c chip"
+	depends on I2C && REGMAP_I2C
+	help
+	  Support for the Texas Instrument INA260 power monitoring chip with prec=
ision integrated shunt.
diff --git a/drivers/staging/ina260/Makefile b/drivers/staging/ina260/Makef=
ile
new file mode 100644
index 000000000..d4eeba95e
--- /dev/null
+++ b/drivers/staging/ina260/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Texas Instruments INA260 drivers
+#
+
+obj-$(CONFIG_INA260) +=3D ina260.o
diff --git a/drivers/staging/ina260/TODO b/drivers/staging/ina260/TODO
new file mode 100644
index 000000000..2ed5b80c3
--- /dev/null
+++ b/drivers/staging/ina260/TODO
@@ -0,0 +1,2 @@
+Created on: 15 August 2023
+Contact: Loic GUEGAN <loic.guegan@mailbox.org>
\ No newline at end of file
diff --git a/drivers/staging/ina260/ina260.c b/drivers/staging/ina260/ina26=
0.c
new file mode 100755
index 000000000..f827236b8
--- /dev/null
+++ b/drivers/staging/ina260/ina260.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Texas Instruments INA260 power monitor chip
+ * with precision integrated shunt.
+ * Datasheet: https://www.ti.com/lit/gpn/INA260
+ *
+ * Copyright (C) 2023 GUEGAN Loic <loic.guegan@mailbox.org>
+ */
+
+#include "linux/module.h"
+#include "linux/uaccess.h"
+#include "linux/i2c.h"
+#include "linux/kobject.h"
+#include "linux/slab.h"
+#include "linux/kernel.h"
+#include <linux/sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/regmap.h>
+
+// INA260 registers
+#define INA260_REG_CONFIGURATION  0x00
+#define INA260_REG_CURRENT        0x01
+#define INA260_REG_VOLTAGE        0x02
+#define INA260_REG_POWER          0x03
+#define INA260_REG_MASKENABLE     0x06
+#define INA260_REG_ALERTLIMIT     0x07
+#define INA260_REG_MANUFACTURER   0xFE
+#define INA260_REG_DIE            0xFF
+
+static struct regmap_config ina260_regmap_config =3D {
+	.max_register =3D INA260_REG_DIE,
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+};
+
+#define INA260_REG_SHOW(_attr, _reg) \
+static ssize_t _attr##_show(struct device *dev, struct device_attribute *a=
ttr, char *buf) \
+{ \
+	unsigned int rvalue; \
+	int err; \
+	struct client_data *cdata =3D dev_get_drvdata(dev); \
+	err =3D regmap_read(cdata->regmap, (_reg), &rvalue); \
+	if (err > 0) \
+		return err; \
+	return sprintf(buf, "0x%x\n", rvalue); \
+}
+
+#define INA260_REG_STORE(_attr, _reg) \
+static ssize_t _attr##_store(struct device *dev, struct device_attribute *=
attr, \
+const char *buf, size_t count) \
+{ \
+	int uvalue, err; \
+	struct client_data *cdata =3D dev_get_drvdata(dev); \
+	if (kstrtoint(buf, 0, &uvalue)) \
+		return -EINVAL; \
+	err =3D regmap_write(cdata->regmap, (_reg), uvalue); \
+	if (err > 0) \
+		return err; \
+	return count; \
+}
+
+/**
+ * @brief Embedded user data
+ */
+struct client_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static int ina260_hwmon_read(struct device *dev, enum hwmon_sensor_types t=
ype,
+			     u32 attr, int channel, long *val)
+{
+	int rvalue, reg, err, rem;
+	struct client_data *cdata =3D dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_power:
+		reg =3D INA260_REG_POWER;
+		break;
+	case hwmon_curr:
+		reg =3D INA260_REG_CURRENT;
+		break;
+	case hwmon_in:
+		reg =3D INA260_REG_VOLTAGE;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	err =3D regmap_read(cdata->regmap, reg, &rvalue);
+	if (err < 0)
+		return err;
+	else if (type =3D=3D hwmon_power)
+		*val =3D rvalue * 10000;
+	else
+		*val =3D div_u64_rem(rvalue * 25, 100, &rem) + rvalue + div_u64(rem, 10);
+	return 0;
+}
+
+static int ina260_hwmon_write(struct device *dev, enum hwmon_sensor_types =
type,
+			      u32 attr, int channel, long val)
+{
+	return -EOPNOTSUPP;
+}
+
+INA260_REG_SHOW(configuration, INA260_REG_CONFIGURATION)
+INA260_REG_SHOW(curr, INA260_REG_CURRENT)
+INA260_REG_SHOW(bus_voltage, INA260_REG_VOLTAGE)
+INA260_REG_SHOW(power, INA260_REG_POWER)
+INA260_REG_SHOW(mask_enable, INA260_REG_MASKENABLE)
+INA260_REG_SHOW(alert_limit, INA260_REG_ALERTLIMIT)
+INA260_REG_SHOW(manufacturer_id, INA260_REG_MANUFACTURER)
+INA260_REG_SHOW(die_id, INA260_REG_DIE)
+
+INA260_REG_STORE(configuration, INA260_REG_CONFIGURATION)
+INA260_REG_STORE(curr, INA260_REG_CURRENT)
+INA260_REG_STORE(bus_voltage, INA260_REG_VOLTAGE)
+INA260_REG_STORE(power, INA260_REG_POWER)
+INA260_REG_STORE(mask_enable, INA260_REG_MASKENABLE)
+INA260_REG_STORE(alert_limit, INA260_REG_ALERTLIMIT)
+
+static umode_t ina260_hwmon_is_visible(const void *drvdata,
+				       enum hwmon_sensor_types type, u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		default:
+			return 0;
+		}
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			return 0444;
+		default:
+			return 0;
+		}
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			return 0444;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info *ina260_hwmon_info[] =3D {
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
+	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops ina260_hwmon_ops =3D {
+	.is_visible =3D ina260_hwmon_is_visible,
+	.read =3D ina260_hwmon_read,
+	.write =3D ina260_hwmon_write,
+};
+
+static const struct hwmon_chip_info ina260_chip_info =3D {
+	.ops =3D &ina260_hwmon_ops,
+	.info =3D ina260_hwmon_info,
+};
+
+// ----- Registers -----
+static DEVICE_ATTR_RW(configuration);
+static DEVICE_ATTR_RW(curr);
+static DEVICE_ATTR_RW(bus_voltage);
+static DEVICE_ATTR_RW(power);
+static DEVICE_ATTR_RW(mask_enable);
+static DEVICE_ATTR_RW(alert_limit);
+static DEVICE_ATTR_RO(manufacturer_id);
+static DEVICE_ATTR_RO(die_id);
+static struct attribute *registers_attrs[] =3D {
+	&dev_attr_configuration.attr,
+	&dev_attr_curr.attr,
+	&dev_attr_bus_voltage.attr,
+	&dev_attr_power.attr,
+	&dev_attr_mask_enable.attr,
+	&dev_attr_alert_limit.attr,
+	&dev_attr_manufacturer_id.attr,
+	&dev_attr_die_id.attr,
+	NULL,
+};
+
+static const struct attribute_group registers_group =3D {
+	.attrs =3D registers_attrs,
+	.name =3D "registers"
+};
+
+const struct attribute_group *extra_groups[] =3D {
+	&registers_group,
+	NULL
+};
+
+static int ina260_probe_new(struct i2c_client *client)
+{
+	struct client_data *p;
+	struct device *hwmon_dev;
+
+	// Initialize client data:
+	dev_dbg(&client->dev, "Adding ina260 [bus=3D%d address=3D0x%02x]\n",
+		client->adapter->nr, client->addr);
+	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+	p->client =3D client;
+	p->regmap =3D devm_regmap_init_i2c(client, &ina260_regmap_config);
+
+	hwmon_dev =3D hwmon_device_register_with_info(&client->dev, client->name,=
 p,
+						    &ina260_chip_info, extra_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+	return 0;
+}
+
+static void ina260_remove(struct i2c_client *client)
+{
+	struct client_data *p =3D i2c_get_clientdata(client);
+
+	kfree(p);
+	hwmon_device_unregister(&client->dev);
+	dev_dbg(&client->dev, "Removing ina260 [bus=3D%d address=3D0x%02x]\n",
+		client->adapter->nr, client->addr);
+}
+
+static const struct i2c_device_id ina260_ids[] =3D {
+	{ "ina260", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ina260_ids);
+
+static struct i2c_driver ina260_driver =3D {
+	.class =3D I2C_CLASS_HWMON,
+	.driver =3D {
+		.name =3D "ina260"
+	},
+	.probe_new =3D ina260_probe_new,
+	.remove =3D ina260_remove,
+	.id_table =3D ina260_ids
+};
+
+static int __init ina260_init(void)
+{
+	i2c_add_driver(&ina260_driver);
+	return 0;
+}
+
+static void __exit ina260_exit(void)
+{
+	i2c_del_driver(&ina260_driver);
+}
+
+module_init(ina260_init);
+module_exit(ina260_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Lo=EFc Guegan");
+MODULE_DESCRIPTION("INA260 Texas Instruments");
+MODULE_VERSION("1.0");
--=20
2.41.0


--VcPTyQb/Q5VvjApe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEELbFoQbUxNyOsnPanyduc5laJN94FAmTbVpcACgkQyduc5laJ
N95WeQ/+KDrZzFJZ6quLbbLsHBQRCaDhm2cAkUTPKK9bzytLhSQgg9wJ7Lmj47Rd
RrWdSNNTFXx5WrXSyFruLzdWeOniSQ1u4iEszDj4tEev+s5VrbLVv9ULNj+AEN21
6+hqqDB64VDYHcThCg/qJi4D4QVE1TWyi95KEVtQ8nGsTK4dwqR/MTjW1h9asbBw
8oxgjTvIQrgTLKKPbesjKm6SbvsfQ3rDtCLpLwROTkAuUXQHNuCdN8EfZim6SEuB
PapPnPRfXFI+AtuDa86lvJA6+d45htNZ785onMvRKOESuja75BY5ftlGYSEAL14f
GsIK8VqZ7uwzK7FLDPO7RUiNsaIN4UiuFQo8ILX4z38YLQCCPR3Wf7Mw/kE5vedq
NlxLQdqWIhYky2J6CsSUhqqguxypnm+a+lYI5whiW/NdpXxDXNsDWwaNmgBauv/X
yir5Zv5fQ63SzkEDo47tjwT7p7nDugrG4sNURtN18MGsGQ8J9wogxecRDxsXn3qz
YMvx0RHDYfHTXK5L2y6vahPWjQJGHprQwLpUEyyZwW+ZsEsDNG8A5vayp1PN7OeB
uUrvUccBl2fFtaXhNd1uSxbocpUb5rdljzgSa2IUt/npZhE/cUV15oCtfU29xCpF
qFF3HJ5m038Wpp2+4Xmh0qri3ytHv/2DTlgUfMwRpYZyXSl+zrY=
=qjVt
-----END PGP SIGNATURE-----

--VcPTyQb/Q5VvjApe--
