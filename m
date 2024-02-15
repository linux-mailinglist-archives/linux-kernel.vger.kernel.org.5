Return-Path: <linux-kernel+bounces-66927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDE88563C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5076B24DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BEE12F388;
	Thu, 15 Feb 2024 12:51:31 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9E12F371
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001491; cv=none; b=R17JKCCpwuWpbc44vjsmQCyWMzScUjpVejpdHbdilrj3Fia0D0o0cscofvzb9H/LyliuhcNmqnYIZIBMTreqObjnD88+Fou2AMw3PTOmMWpQZSbJpTzwN1d0T9RYj+aR4+JPLnhH+g6UdaYj5GZI6EEo05D5c0DabDgZ34UHcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001491; c=relaxed/simple;
	bh=numjJyssHCK83ZTxToyLkXAvONvPBcoOdl89HtYTob0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxkKxfOaL2adjrF8BUrjVpfMpyT7aNvLsF7aMPq+yD58ikSnXxgcoITJq0wPfjJl6qRWGi+h5xPowlz/hiZ4oqW40hiGPqSBoCtpLCRGh1TDwZqBjmoFcd57KRHwAoJNfcivqPzCxztFFazQ+BENhPDzlxBcq3Grzvjo/vP9ol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by laurent.telenet-ops.be with bizsmtp
	id nQrM2B0090LVNSS01QrM3z; Thu, 15 Feb 2024 13:51:21 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabCr-000gwp-Pl;
	Thu, 15 Feb 2024 13:51:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabCz-00HVKe-5H;
	Thu, 15 Feb 2024 13:51:21 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] thermal: Drop spaces before TABs
Date: Thu, 15 Feb 2024 13:51:19 +0100
Message-Id: <480478a53fd42621e97b2db36e181903cc0f53e3.1708001426.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is never a need to have a space before a TAB, but it hurts the
eyes of vim users.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop change to removed drivers/thermal/st/st_thermal_syscfg.c.
---
 drivers/thermal/Makefile               |  2 +-
 drivers/thermal/st/st_thermal.h        | 18 +++++++++---------
 drivers/thermal/st/st_thermal_memmap.c |  2 +-
 drivers/thermal/thermal_of.c           |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d77d7fe99a84aa3f..5cdf7d68687f43b3 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
-obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
+obj-$(CONFIG_DOVE_THERMAL)	+= dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
diff --git a/drivers/thermal/st/st_thermal.h b/drivers/thermal/st/st_thermal.h
index 75a84e6ec6a729bf..8639d9165c9b9d56 100644
--- a/drivers/thermal/st/st_thermal.h
+++ b/drivers/thermal/st/st_thermal.h
@@ -38,10 +38,10 @@ struct st_thermal_sensor;
  *
  * @power_ctrl:		Function for powering on/off a sensor. Clock to the
  *			sensor is also controlled from this function.
- * @alloc_regfields: 	Allocate regmap register fields, specific to a sensor.
- * @do_memmap_regmap: 	Memory map the thermal register space and init regmap
+ * @alloc_regfields:	Allocate regmap register fields, specific to a sensor.
+ * @do_memmap_regmap:	Memory map the thermal register space and init regmap
  *			instance or find regmap instance.
- * @register_irq: 	Register an interrupt handler for a sensor.
+ * @register_irq:	Register an interrupt handler for a sensor.
  */
 struct st_thermal_sensor_ops {
 	int (*power_ctrl)(struct st_thermal_sensor *, enum st_thermal_power_state);
@@ -56,15 +56,15 @@ struct st_thermal_sensor_ops {
  *
  * @reg_fields:		Pointer to the regfields array for a sensor.
  * @sys_compat:		Pointer to the syscon node compatible string.
- * @ops: 		Pointer to private thermal ops for a sensor.
- * @calibration_val: 	Default calibration value to be written to the DCORRECT
+ * @ops:		Pointer to private thermal ops for a sensor.
+ * @calibration_val:	Default calibration value to be written to the DCORRECT
  *			register field for a sensor.
- * @temp_adjust_val: 	Value to be added/subtracted from the data read from
+ * @temp_adjust_val:	Value to be added/subtracted from the data read from
  *			the sensor. If value needs to be added please provide a
  *			positive value and if it is to be subtracted please
- * 			provide a negative value.
- * @crit_temp: 		The temperature beyond which the SoC should be shutdown
- * 			to prevent damage.
+ *			provide a negative value.
+ * @crit_temp:		The temperature beyond which the SoC should be shutdown
+ *			to prevent damage.
  */
 struct st_thermal_compat_data {
 	char *sys_compat;
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index e8cfa83b724a774b..29c2269b0fb35ced 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -27,7 +27,7 @@ static const struct reg_field st_mmap_thermal_regfields[MAX_REGFIELDS] = {
 	 * written simultaneously for powering on and off the temperature
 	 * sensor. regmap_update_bits() will be used to update the register.
 	 */
-	[INT_THRESH_HI]	= REG_FIELD(STIH416_MPE_INT_THRESH, 	0,  7),
+	[INT_THRESH_HI]	= REG_FIELD(STIH416_MPE_INT_THRESH,	0,  7),
 	[DCORRECT]	= REG_FIELD(STIH416_MPE_CONF,		5,  9),
 	[OVERFLOW]	= REG_FIELD(STIH416_MPE_STATUS,		9,  9),
 	[DATA]		= REG_FIELD(STIH416_MPE_STATUS,		11, 18),
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4d6c22e0ed85bf55..c9bee46b48cd0f75 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -463,7 +463,7 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
  * @ops: A set of thermal sensor ops
  *
  * Return: a valid thermal zone structure pointer on success.
- * 	- EINVAL: if the device tree thermal description is malformed
+ *	- EINVAL: if the device tree thermal description is malformed
  *	- ENOMEM: if one structure can not be allocated
  *	- Other negative errors are returned by the underlying called functions
  */
-- 
2.34.1


