Return-Path: <linux-kernel+bounces-143017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0F8A334C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD882282331
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FC149DE2;
	Fri, 12 Apr 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qkHwS4KK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864E148FE0;
	Fri, 12 Apr 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938177; cv=none; b=GOLgFt6ao+HgGeaQVfHiu4/dsAF46NKHjA0FuXwznYMQF2arNtZz0zdTitxpV6zzGQuYnH72fItq9yMefFK39lnFHMYvyyHdlRdDRS5bEyNVv3bAy3ztsI9qxFJLywMDh5fCpeW64JvtsfBQzlFhQH6B13pLDf5b7B81GvGyMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938177; c=relaxed/simple;
	bh=Xl//q731aW0Vkg6xStkZbeY7hhmmCZZjkS/RmnzqPTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUls6CqbZ/4Hx6I2gaNCWZuki+34voIsiYqfq6JOXIBpEPfshfS2DA4wlBALtEgVLlOx0vH+5OuZZ5z+PbTAB86IzJ8gWyU808VOkr2XEXxqDxsl/TCpB0+/749x4nncRdNi1ByqW+95xdJIoMMB9mMwS+FxgIvw7nZlARTIpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qkHwS4KK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712938146; x=1713542946; i=w_armin@gmx.de;
	bh=4bNz4HADHMJk8zX2s5JUwo5N2xKp50HBrHFfUcgB7HE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=qkHwS4KKWc7FCDSqiU32rOgfMegf7Ux9Y8xnW3SJS1bdFEvaMCeIrFu2a+DTo8q/
	 fFNmEZz9TublMolVfGNhCzG35v0TIazk7E1/E0WXPbT9D3BgQVVDdnfeczPoYGd/T
	 y/4x2Hc3/QUUKcPyWvZFl4c04078Q7T8KMPNEf9ETXvgDq/0+3Vrl7NmAJoeN4Xp7
	 Ca1pBYaJ8jtNNgHRjHxIU8stZBNmgZcEjHnpZxevchU1T1Xy8jmJHiE6j1m9n0eNF
	 2fS9ryMSh205nZckBr86WftnzwFFgRwGgP9N97qskTWy5j0L96y/CEpKkuT9H1PFt
	 dDQdSWbqDmIJVVhZpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1Obh-1st56v08Nv-012qfA; Fri, 12 Apr 2024 18:09:06 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 2/2] ACPI: fan: Add hwmon support
Date: Fri, 12 Apr 2024 18:08:57 +0200
Message-Id: <20240412160857.79858-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412160857.79858-1-W_Armin@gmx.de>
References: <20240412160857.79858-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ATeDI3Ztaey3Q+xF/40OjjazINpxlzLusnTzoboGCKkbDinWhCc
 XASO0ZGZJFO3TInxY1oS0cXcNjAsnrRz2Z3s9rvehpsTfRRgWr1uJ/eYhSgZa3k5U76qCJ+
 QmI4xs+YRw1jisd3z19sjRkg3F+tp3rUJO03Dzh0daroiLrQKnQoR6L/rw1bGaTxwRc5K9f
 WjBW2XwsHJoUeq0FC/wAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c0G0mNKzvb4=;3eyu6aPGlHi1JnisxhB4NzhShOm
 Hiw1pqRHXNuhoL01BDjCSuE68TkE8xAv2WiojS2A4acITIfwukxsyZ4RIVzTEj1oR4w/SE99L
 b5mvlV+On6EHgvYzuBGFlHRxOMckqJ4QWGl8LK6nPu0IiqyspOn40gASJTNMu5JvihrO4ofuj
 S5gr+iP0DgG29AJHeAHvKb7l+2IVCM+sjMpcWTdCpABdMOsDVuqmi5+rA9u/uzjRV6KYYiZ9c
 CAGpJbhXVvEOQFkshzfASDwSzq2/4PDfCe4zHzji2C6hLHNVkuyiBgZjUA1QFKrj4Ma229K8J
 pov9ATB+2dZ3lQixalKZmXV0dkTL+2xHFKjV5wLlFL8ucUxcn+UOofXQw/8ZWemFhbpZfmnm7
 hUG+AEGdbaCJrDSKczUWggH428T2ZDBK9dIOq0RoodvjEfHqSrPPLabGNHPQF5W4cum05WAPq
 qlX0NnLKgl/XPO+rVaD2zmZX//hbqF3kE5J3TvRxUcizYk4TLLl4zPmSGELqd/tnXP9hnNvVs
 2VXQ+8bkGteakZ/lv4qylizAoYlbTWoVdrLcz4afX/xg3A/292Q0M6nuWOznCTyeNMtl7sV6i
 exmtIpCrGM/nQwhuoFI3NWCQVzVrJUOzKvnYIo8vS5FmP05s2DeaDTnVuO8Lif9ddjxPqY3V9
 AK/kJCTpPc02p18QUlIlLQtwYs1u9mIurz3EAPrW0ZiDJWRd+95ELwRMnJb74+fANN4q30ACX
 6oexrr9TL4Ph95aarBSX3jUV0TcUHoEa/QUVjVhWTm9/nsNSu/C+ohD8/0OP7akKrfZmJepjq
 ++i3guXpCSHk9vzwgSYvV60LPZ1BtRk7RZuO74qPv9Dsw=

Currently, the driver does only support a custom sysfs
to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v2:
- add support for fanX_target and power attrs

Changes since v1:
- fix undefined reference error
- fix fan speed validation
- coding style fixes
- clarify that the changes are compile-tested only
- add hwmon maintainers to cc list

The changes will be tested by Mikael Lund Jepsen from Danelec and
should be merged only after those tests.
=2D--
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/fan.h       |   9 +++
 drivers/acpi/fan_core.c  |   4 ++
 drivers/acpi/fan_hwmon.c | 148 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/acpi/fan_hwmon.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 39ea5cfa8326..61ca4afe83dc 100644
=2D-- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+=3D tiny-power-but=
ton.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
 fan-objs			:=3D fan_core.o
 fan-objs			+=3D fan_attr.o
+fan-$(CONFIG_HWMON)		+=3D fan_hwmon.o

 obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
 obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index f89d19c922dc..db25a3898af7 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -10,6 +10,8 @@
 #ifndef _ACPI_FAN_H_
 #define _ACPI_FAN_H_

+#include <linux/kconfig.h>
+
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
@@ -57,4 +59,11 @@ struct acpi_fan {
 int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst=
);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
+
+#if IS_REACHABLE(CONFIG_HWMON)
+int devm_acpi_fan_create_hwmon(struct acpi_device *device);
+#else
+static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) =
{ return 0; };
+#endif
+
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index ff72e4ef8738..7cea4495f19b 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;

+		result =3D devm_acpi_fan_create_hwmon(device);
+		if (result)
+			return result;
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
new file mode 100644
index 000000000000..57216ba872db
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * fan_hwmon.c - hwmon interface for the ACPI Fan driver
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/hwmon.h>
+#include <linux/limits.h>
+#include <linux/units.h>
+
+#include "fan.h"
+
+/* Returned when the ACPI fan does not support speed reporting */
+#define FAN_SPEED_UNAVAILABLE	0xffffffff
+#define FAN_POWER_UNAVAILABLE	0xffffffff
+
+static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan=
, u64 control)
+{
+	int i;
+
+	for (i =3D 0; i < fan->fps_count; i++) {
+		if (fan->fps[i].control =3D=3D control)
+			return &fan->fps[i];
+	}
+
+	return NULL;
+}
+
+static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor=
_types type, u32 attr,
+				   int channel)
+{
+	return 0444;
+}
+
+static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type=
, u32 attr, int channel,
+			 long *val)
+{
+	struct acpi_device *adev =3D dev_get_drvdata(dev);
+	struct acpi_fan *fan =3D acpi_driver_data(adev);
+	struct acpi_fan_fps *fps;
+	struct acpi_fan_fst fst;
+	int ret;
+
+	ret =3D acpi_fan_get_fst(adev, &fst);
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
+				return -ENODATA;
+
+			if (fst.speed > LONG_MAX)
+				return -EOVERFLOW;
+
+			*val =3D fst.speed;
+			return 0;
+		case hwmon_fan_target:
+			fps =3D acpi_fan_get_current_fps(fan, fst.control);
+			if (!fps)
+				return -ENODATA;
+
+			*val =3D fps->speed;
+			return 0;
+		case hwmon_fan_fault:
+			*val =3D (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE);
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_power:
+		fps =3D acpi_fan_get_current_fps(fan, fst.control);
+		if (!fps)
+			return -ENODATA;
+
+		switch (attr) {
+		case hwmon_power_input:
+			if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
+				return -ENODATA;
+
+			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
+				return -EOVERFLOW;
+
+			*val =3D fps->power * MICROWATT_PER_MILLIWATT;
+			return 0;
+		case hwmon_power_fault:
+			*val =3D (fps->power =3D=3D FAN_POWER_UNAVAILABLE);
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops acpi_fan_ops =3D {
+	.is_visible =3D acpi_fan_is_visible,
+	.read =3D acpi_fan_read,
+};
+
+static const struct hwmon_channel_info * const acpi_fan_info[] =3D {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET |  HWMON_F_FAULT)=
,
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_FAULT),
+	NULL
+};
+
+static const struct hwmon_chip_info acpi_fan_chip_info =3D {
+	.ops =3D &acpi_fan_ops,
+	.info =3D acpi_fan_info,
+};
+
+static const struct hwmon_channel_info * const acpi_fan_fine_grain_info[]=
 =3D {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT),
+	NULL
+};
+
+static const struct hwmon_chip_info acpi_fan_fine_grain_chip_info =3D {
+	.ops =3D &acpi_fan_ops,
+	.info =3D acpi_fan_fine_grain_info,
+};
+
+int devm_acpi_fan_create_hwmon(struct acpi_device *device)
+{
+	struct acpi_fan *fan =3D acpi_driver_data(device);
+	const struct hwmon_chip_info *info;
+	struct device *hdev;
+
+	/* When in fine grain control mode, not every fan control value
+	 * has an associated fan performance state.
+	 */
+	if (fan->fif.fine_grain_ctrl)
+		info =3D &acpi_fan_fine_grain_chip_info;
+	else
+		info =3D &acpi_fan_chip_info;
+
+	hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", =
device, info, NULL);
+
+	return PTR_ERR_OR_ZERO(hdev);
+}
=2D-
2.39.2


