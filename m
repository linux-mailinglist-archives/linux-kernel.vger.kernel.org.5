Return-Path: <linux-kernel+bounces-49119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D539D84660F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA828D748
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B80E56B;
	Fri,  2 Feb 2024 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ph72pIZu"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE8E54E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842374; cv=none; b=FsrKRO+r/2GQtySAbKHjNf5CpLGf00lpxQQsTyXhB0Jut5AgRiZDzGmytceNfZTmZ5aLYtPt7uc1GpsW+AYUfqQlbGTLQazOH+1I68HJMAAfcMi+v+D1QjpnXAwX2LjfAJVaBegHhsXSsE6nzDJN7lCbuw4cODF/oS9/l6KNsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842374; c=relaxed/simple;
	bh=e0skIBCnXDExRlKgoGmZojFLHGObObbkMveiXYsCSTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD4grgbZJ2XSIrt4EaziGHoGaQ4GcSDWDRDd17Cj0SCsETGq7CifqjotFDiWHxAXHif77JNsOfCr187Ik0QTKjhwXZMti6bEAoLOiAbyueeRt5R7pnCEAOY+RQ/p2cYCus2WxeYIJ6aJ8mM7eXQyo4JiPJRwe0VVAr/FThJwREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Ph72pIZu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B16C12C05FB;
	Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1706842368;
	bh=a8Zyo/XNz0jOtDmuNsgPL2GeH/t00tJzhra68gf2YPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ph72pIZu5idpa5+kkFHwmtSBV1ZVVgVZRuvpX71dTUNqDljW4gLbzJnPLb9YatIG4
	 rLOJwAtEux/3y/D4p8JA5JBWexPcnLansfwS7HTJCxNCKTLcawjI0RosMs3clplrWC
	 cdGWQ92m9gS4F/3ea/Jg3Pji7m/14ALXAXTCxxXxsmpjysZEh+Jkg/bOTzWZNfvH4E
	 jEgyww9XlGt0TtIyySc3F9BwB0FkV7FfPCwgZvD3fqXIt3RqZAxSlokoxuttkzSUip
	 Y/ixVhjoQaeenDq5ddfLtCORTBb9k8s7Q0Cak+7mkCO/R4OR+oevfQfQLEbW30qx59
	 q0zwFr4W59iyw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65bc59000001>; Fri, 02 Feb 2024 15:52:48 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 63F5F13EE5E;
	Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 5A0B7280386; Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	antoniu.miclaus@analog.com,
	noname.nuno@gmail.com
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 1/2] drivers: rtc: add max313xx series rtc driver
Date: Fri,  2 Feb 2024 15:52:40 +1300
Message-ID: <20240202025241.834283-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=yIKnACOTrQxQ0XkKiqwA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Adding support for Analog Devices MAX313XX series RTCs.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/rtc/Kconfig        |   11 +
 drivers/rtc/Makefile       |    1 +
 drivers/rtc/rtc-max313xx.c | 1098 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1110 insertions(+)
 create mode 100644 drivers/rtc/rtc-max313xx.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e37a4341f442..fc53cc3c6093 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -386,6 +386,17 @@ config RTC_DRV_MAX31335
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max31335.
=20
+config RTC_DRV_MAX313XX
+	tristate "Analog Devices MAX313XX RTC driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you will get support for the
+	  Analog Devices MAX313XX series RTC family.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-max313xx.
+
 config RTC_DRV_MAX77686
 	tristate "Maxim MAX77686"
 	depends on MFD_MAX77686 || MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 6efff381c484..8bf6c60c837c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_RTC_DRV_M48T35)	+=3D rtc-m48t35.o
 obj-$(CONFIG_RTC_DRV_M48T59)	+=3D rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+=3D rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_MA35D1)	+=3D rtc-ma35d1.o
+obj-$(CONFIG_RTC_DRV_MAX313XX)	+=3D rtc-max313xx.o
 obj-$(CONFIG_RTC_DRV_MAX31335)	+=3D rtc-max31335.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+=3D rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+=3D rtc-max6902.o
diff --git a/drivers/rtc/rtc-max313xx.c b/drivers/rtc/rtc-max313xx.c
new file mode 100644
index 000000000000..50194f162e13
--- /dev/null
+++ b/drivers/rtc/rtc-max313xx.c
@@ -0,0 +1,1098 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices MAX313XX series I2C RTC driver
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+#include <asm-generic/unaligned.h>
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/util_macros.h>
+
+/* common registers */
+#define MAX313XX_INT_ALARM1		BIT(0)
+#define MAX313XX_HRS_F_AM_PM		BIT(5)
+#define MAX313XX_HRS_F_12_24		BIT(6)
+#define MAX313XX_MONTH_CENTURY		BIT(7)
+
+#define MAX313XX_TIME_SIZE		0x07
+
+/* device specific registers */
+#define MAX3134X_CFG2_REG		0x01
+#define MAX3134X_CFG2_SET_RTC		BIT(1)
+
+#define MAX31341_TRICKLE_RES_MASK	GENMASK(1, 0)
+#define MAX31341_TRICKLE_DIODE_EN	BIT(2)
+#define MAX31341_TRICKLE_ENABLE_BIT	BIT(3)
+#define MAX31341_POWER_MGMT_REG		0x56
+#define MAX31341_POWER_MGMT_TRICKLE_BIT	BIT(0)
+
+#define MAX3133X_TRICKLE_RES_MASK	GENMASK(2, 1)
+#define MAX3133X_TRICKLE_DIODE_EN	BIT(3)
+#define MAX3133X_TRICKLE_ENABLE_BIT	BIT(0)
+
+#define MAX31329_TRICKLE_ENABLE_BIT	BIT(7)
+#define MAX31343_TRICKLE_ENABLE_MASK	GENMASK(7, 4)
+#define MAX31343_TRICKLE_ENABLE_CODE	5
+#define MAX31329_43_TRICKLE_RES_MASK	GENMASK(1, 0)
+#define MAX31329_43_TRICKLE_DIODE_EN	BIT(2)
+
+#define MAX31329_CONFIG2_REG		0x04
+#define MAX31329_CONFIG2_CLKIN_EN	BIT(2)
+#define MAX31329_CONFIG2_CLKIN_FREQ	GENMASK(1, 0)
+
+#define MAX31341_42_CONFIG1_REG		0x00
+#define MAX31341_42_CONFIG1_CLKIN_EN	BIT(7)
+#define MAX31341_42_CONFIG1_CLKIN_FREQ	GENMASK(5, 4)
+#define MAX31341_42_CONFIG1_OSC_DISABLE	BIT(3)
+#define MAX31341_42_CONFIG1_SWRST	BIT(0)
+
+enum max313xx_ids {
+	ID_MAX31328,
+	ID_MAX31329,
+	ID_MAX31331,
+	ID_MAX31334,
+	ID_MAX31341,
+	ID_MAX31342,
+	ID_MAX31343,
+	MAX313XX_ID_NR
+};
+
+struct clkout_cfg {
+	const int *freq_avail;
+	u8 freq_size;
+	u8 freq_pos;
+	u8 reg;
+	u8 en_bit;
+	bool en_invert;
+};
+
+struct chip_desc {
+	struct clkout_cfg *clkout;
+	const char *clkout_name;
+	u8 sec_reg;
+	u8 alarm1_sec_reg;
+
+	u8 int_en_reg;
+	u8 int_status_reg;
+	u8 osf_bit;
+
+	u8 ram_reg;
+	u8 ram_size;
+
+	u8 temp_reg;
+
+	u8 trickle_reg;
+
+	u8 rst_reg;
+	u8 rst_bit;
+};
+
+#define clk_hw_to_max313xx(_hw) container_of(_hw, struct max313xx, clkou=
t)
+
+struct max313xx {
+	enum max313xx_ids id;
+	struct regmap *regmap;
+	struct rtc_device *rtc;
+	struct clk_hw clkout;
+	struct clk *clkin;
+	const struct chip_desc *chip;
+	int irq;
+};
+
+static const int max313xx_clkin_freq[] =3D { 1, 50, 60, 32768 };
+
+static const int max31328_clkout_freq[] =3D { 1, 1024, 4096, 8192 };
+static const int max31329_clkout_freq[] =3D { 1, 4096, 8192, 32768 };
+static const int max3133x_clkout_freq[] =3D { 1, 64, 1024, 32768 };
+static const int max31341_42_clkout_freq[] =3D { 1, 50, 60, 32768 };
+static const int max31343_clkout_freq[] =3D { 1, 2, 4, 8, 16, 32, 64, 12=
8, 32875 };
+
+static struct clkout_cfg max31328_clkout =3D {
+	.freq_avail =3D max31328_clkout_freq,
+	.freq_size =3D ARRAY_SIZE(max31328_clkout_freq),
+	.freq_pos =3D 3,
+	.reg =3D 0x0E,
+	.en_bit =3D BIT(3),
+	.en_invert =3D true,
+};
+
+static struct clkout_cfg max31329_clkout =3D {
+	.freq_avail =3D max31329_clkout_freq,
+	.freq_size =3D ARRAY_SIZE(max31329_clkout_freq),
+	.freq_pos =3D 5,
+	.reg =3D 0x04,
+	.en_bit =3D BIT(7),
+};
+
+static struct clkout_cfg max3133x_clkout =3D {
+	.freq_avail =3D max3133x_clkout_freq,
+	.freq_size =3D ARRAY_SIZE(max3133x_clkout_freq),
+	.freq_pos =3D 0,
+	.reg =3D 0x04,
+	.en_bit =3D BIT(2),
+};
+
+static struct clkout_cfg max31341_42_clkout =3D {
+	.freq_avail =3D max31341_42_clkout_freq,
+	.freq_size =3D ARRAY_SIZE(max31341_42_clkout_freq),
+	.freq_pos =3D 1,
+	.reg =3D 0x00,
+	.en_bit =3D BIT(6),
+	.en_invert =3D true,
+};
+
+static struct clkout_cfg max31343_clkout =3D {
+	.freq_avail =3D max31343_clkout_freq,
+	.freq_size =3D ARRAY_SIZE(max31343_clkout_freq),
+	.freq_pos =3D 3,
+	.reg =3D 0x04,
+	.en_bit =3D BIT(7),
+};
+
+static const struct chip_desc chip[MAX313XX_ID_NR] =3D {
+	[ID_MAX31328] =3D {
+		.int_en_reg =3D 0x0E,
+		.int_status_reg =3D 0x0F,
+		.osf_bit =3D BIT(7),
+		.sec_reg =3D 0x00,
+		.alarm1_sec_reg =3D 0x07,
+		.temp_reg =3D 0x11,
+		.clkout =3D &max31328_clkout,
+		.clkout_name =3D "max31328-sqw",
+	},
+	[ID_MAX31329] =3D {
+		.int_en_reg =3D 0x01,
+		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x06,
+		.alarm1_sec_reg =3D 0x0D,
+		.ram_reg =3D 0x22,
+		.ram_size =3D 64,
+		.trickle_reg =3D 0x19,
+		.clkout =3D &max31329_clkout,
+		.clkout_name =3D "max31329-clkout",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
+	},
+	[ID_MAX31331] =3D {
+		.int_en_reg =3D 0x01,
+		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x08,
+		.alarm1_sec_reg =3D 0x0F,
+		.ram_reg =3D 0x20,
+		.ram_size =3D 32,
+		.trickle_reg =3D 0x1B,
+		.clkout =3D &max3133x_clkout,
+		.clkout_name =3D "max31331-clkout",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
+	},
+	[ID_MAX31334] =3D {
+		.int_en_reg =3D 0x01,
+		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x09,
+		.alarm1_sec_reg =3D 0x10,
+		.ram_reg =3D 0x30,
+		.ram_size =3D 32,
+		.trickle_reg =3D 0x1E,
+		.clkout =3D &max3133x_clkout,
+		.clkout_name =3D "max31334-clkout",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
+	},
+	[ID_MAX31341] =3D {
+		.int_en_reg =3D 0x04,
+		.int_status_reg =3D 0x05,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x06,
+		.alarm1_sec_reg =3D 0x0D,
+		.ram_reg =3D 0x16,
+		.ram_size =3D 64,
+		.trickle_reg =3D 0x57,
+		.clkout =3D &max31341_42_clkout,
+		.clkout_name =3D "max31341-clkout",
+		.rst_reg =3D 0x00,
+		.rst_bit =3D BIT(0),
+	},
+	[ID_MAX31342] =3D {
+		.int_en_reg =3D 0x04,
+		.int_status_reg =3D 0x05,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x06,
+		.alarm1_sec_reg =3D 0x0D,
+		.clkout =3D &max31341_42_clkout,
+		.clkout_name =3D "max31342-clkout",
+		.rst_reg =3D 0x00,
+		.rst_bit =3D BIT(0),
+	},
+	[ID_MAX31343] =3D {
+		.int_en_reg =3D 0x01,
+		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x06,
+		.alarm1_sec_reg =3D 0x0D,
+		.ram_reg =3D 0x22,
+		.ram_size =3D 64,
+		.temp_reg =3D 0x1A,
+		.trickle_reg =3D 0x19,
+		.clkout =3D &max31343_clkout,
+		.clkout_name =3D "max31343-clko",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
+	},
+};
+
+static const u32 max313xx_trickle_ohms[] =3D { 3000, 6000, 11000 };
+
+static bool max313xx_volatile_reg(struct device *dev, unsigned int reg)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	const struct chip_desc *chip =3D rtc->chip;
+
+	/* time keeping registers */
+	if (reg >=3D chip->sec_reg && reg < chip->sec_reg + MAX313XX_TIME_SIZE)
+		return true;
+
+	/* interrupt status register */
+	if (reg =3D=3D chip->int_status_reg)
+		return true;
+
+	/* temperature registers */
+	return chip->temp_reg &&
+		(reg =3D=3D chip->temp_reg || reg =3D=3D chip->temp_reg + 1);
+}
+
+static const struct regmap_config regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.cache_type =3D REGCACHE_RBTREE,
+	.volatile_reg =3D max313xx_volatile_reg,
+};
+
+static int max313xx_get_hour(u8 hour_reg)
+{
+	int hour;
+
+	/* 24Hr mode */
+	if (!FIELD_GET(MAX313XX_HRS_F_12_24, hour_reg))
+		return bcd2bin(hour_reg & 0x3f);
+
+	/* 12Hr mode */
+	hour =3D bcd2bin(hour_reg & 0x1f);
+	if (hour =3D=3D 12)
+		hour =3D 0;
+
+	if (FIELD_GET(MAX313XX_HRS_F_AM_PM, hour_reg))
+		hour +=3D 12;
+
+	return hour;
+}
+
+static int max313xx_read_time(struct device *dev, struct rtc_time *t)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	u8 regs[7];
+	int ret;
+	unsigned int status;
+
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_status_reg, &status);
+	if (ret)
+		return ret;
+
+	if (status & rtc->chip->osf_bit)
+		return -EINVAL;
+
+	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->sec_reg, regs, 7);
+	if (ret)
+		return ret;
+
+	t->tm_sec =3D bcd2bin(regs[0] & 0x7f);
+	t->tm_min =3D bcd2bin(regs[1] & 0x7f);
+	t->tm_hour =3D max313xx_get_hour(regs[2]);
+	t->tm_wday =3D bcd2bin(regs[3] & 0x07) - 1;
+	t->tm_mday =3D bcd2bin(regs[4] & 0x3f);
+	t->tm_mon =3D bcd2bin(regs[5] & 0x1f) - 1;
+	t->tm_year =3D bcd2bin(regs[6]) + 100;
+
+	if (FIELD_GET(MAX313XX_MONTH_CENTURY, regs[5]))
+		t->tm_year +=3D 100;
+
+	return 0;
+}
+
+static int max313xx_pre_set_time(struct max313xx *rtc)
+{
+	if (!rtc->clkin)
+		return 0;
+
+	/* Clkin needs to be disabled before setting time. */
+	switch (rtc->id) {
+	case ID_MAX31341:
+	case ID_MAX31342:
+		return regmap_clear_bits(rtc->regmap,
+					 MAX31341_42_CONFIG1_REG,
+					 MAX31341_42_CONFIG1_CLKIN_EN);
+	default:
+		return 0;
+	}
+}
+
+static int max313xx_post_set_time(struct max313xx *rtc)
+{
+	int ret;
+
+	switch (rtc->id) {
+	case ID_MAX31341:
+	case ID_MAX31342:
+		ret =3D regmap_set_bits(rtc->regmap, MAX3134X_CFG2_REG,
+				      MAX3134X_CFG2_SET_RTC);
+		if (ret)
+			return ret;
+
+		fsleep(10000);
+
+		ret =3D regmap_clear_bits(rtc->regmap, MAX3134X_CFG2_REG,
+					MAX3134X_CFG2_SET_RTC);
+		if (ret)
+			return ret;
+
+		if (rtc->clkin)
+			ret =3D regmap_set_bits(rtc->regmap,
+					      MAX31341_42_CONFIG1_REG,
+					      MAX31341_42_CONFIG1_CLKIN_EN);
+
+		break;
+	default:
+		return 0;
+	}
+
+	return ret;
+}
+
+static int max313xx_set_time(struct device *dev, struct rtc_time *t)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	u8 regs[7];
+	int ret;
+
+	regs[0] =3D bin2bcd(t->tm_sec);
+	regs[1] =3D bin2bcd(t->tm_min);
+	regs[2] =3D bin2bcd(t->tm_hour);
+	regs[3] =3D bin2bcd(t->tm_wday + 1);
+	regs[4] =3D bin2bcd(t->tm_mday);
+	regs[5] =3D bin2bcd(t->tm_mon + 1);
+	regs[6] =3D bin2bcd(t->tm_year % 100);
+
+	if (t->tm_year >=3D 200)
+		regs[5] |=3D FIELD_PREP(MAX313XX_MONTH_CENTURY, 1);
+
+	ret =3D max313xx_pre_set_time(rtc);
+	if (ret)
+		return ret;
+
+	if (rtc->chip->rst_bit) {
+		ret =3D regmap_clear_bits(rtc->regmap, rtc->chip->rst_reg, rtc->chip->=
rst_bit);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D regmap_bulk_write(rtc->regmap, rtc->chip->sec_reg, regs, 7);
+	if (ret)
+		return ret;
+
+	return max313xx_post_set_time(rtc);
+}
+
+static int max313xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	unsigned int status, int_en;
+	struct rtc_time time;
+	u8 regs[6];
+	int ret;
+
+	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->alarm1_sec_reg, regs,
+			       sizeof(regs));
+	if (ret)
+		return ret;
+
+	t->time.tm_sec =3D bcd2bin(regs[0] & 0x7f);
+	t->time.tm_min =3D bcd2bin(regs[1] & 0x7f);
+	t->time.tm_hour =3D bcd2bin(regs[2] & 0x3f);
+	t->time.tm_mday =3D bcd2bin(regs[3] & 0x3f);
+	t->time.tm_mon =3D bcd2bin(regs[4] & 0x1f) - 1;
+	t->time.tm_year =3D bcd2bin(regs[5]) + 100;
+
+	ret =3D max313xx_read_time(dev, &time);
+	if (ret)
+		return ret;
+
+	if (time.tm_year >=3D 200)
+		t->time.tm_year +=3D 100;
+
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_status_reg, &status);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_en_reg, &int_en);
+	if (ret)
+		return ret;
+
+	t->enabled =3D FIELD_GET(MAX313XX_INT_ALARM1, int_en);
+	t->pending =3D FIELD_GET(MAX313XX_INT_ALARM1, status);
+
+	return 0;
+}
+
+static int max313xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	unsigned int reg;
+	u8 regs[6];
+	int ret;
+
+	regs[0] =3D bin2bcd(t->time.tm_sec);
+	regs[1] =3D bin2bcd(t->time.tm_min);
+	regs[2] =3D bin2bcd(t->time.tm_hour);
+	regs[3] =3D bin2bcd(t->time.tm_mday);
+	regs[4] =3D bin2bcd(t->time.tm_mon + 1);
+	regs[5] =3D bin2bcd(t->time.tm_year % 100);
+
+	ret =3D regmap_bulk_write(rtc->regmap, rtc->chip->alarm1_sec_reg, regs,
+				sizeof(regs));
+	if (ret)
+		return ret;
+
+	reg =3D FIELD_PREP(MAX313XX_INT_ALARM1, t->enabled);
+	ret =3D regmap_update_bits(rtc->regmap, rtc->chip->int_en_reg,
+				 MAX313XX_INT_ALARM1, reg);
+	if (ret)
+		return ret;
+
+	/* Clear status register */
+	return regmap_read(rtc->regmap, rtc->chip->int_status_reg, &reg);
+}
+
+static int max313xx_alarm_irq_enable(struct device *dev, unsigned int en=
abled)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+
+	return regmap_update_bits(rtc->regmap, rtc->chip->int_en_reg,
+				  MAX313XX_INT_ALARM1,
+				  FIELD_PREP(MAX313XX_INT_ALARM1, enabled));
+}
+
+static const struct rtc_class_ops max3133x_rtc_ops =3D {
+	.read_time	=3D max313xx_read_time,
+	.set_time	=3D max313xx_set_time,
+	.read_alarm	=3D max313xx_read_alarm,
+	.set_alarm	=3D max313xx_set_alarm,
+	.alarm_irq_enable =3D max313xx_alarm_irq_enable,
+};
+
+static irqreturn_t max313xx_irq(int irq, void *dev_id)
+{
+	struct max313xx	*rtc =3D dev_id;
+	struct mutex *lock =3D &rtc->rtc->ops_lock;
+	int stat, ret;
+
+	mutex_lock(lock);
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_status_reg, &stat);
+	if (ret)
+		goto out;
+
+	if (FIELD_GET(MAX313XX_INT_ALARM1, stat)) {
+		ret =3D regmap_update_bits(rtc->regmap, rtc->chip->int_en_reg,
+					 MAX313XX_INT_ALARM1, 0);
+		if (ret)
+			goto out;
+
+		rtc_update_irq(rtc->rtc, 1, RTC_AF | RTC_IRQF);
+	}
+
+out:
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
+}
+
+static int max313xx_nvmem_reg_read(void *priv, unsigned int offset,
+				   void *val, size_t bytes)
+{
+	struct max313xx *rtc =3D priv;
+	unsigned int reg =3D rtc->chip->ram_reg + offset;
+
+	return regmap_bulk_read(rtc->regmap, reg, val, bytes);
+}
+
+static int max313xx_nvmem_reg_write(void *priv, unsigned int offset,
+				    void *val, size_t bytes)
+{
+	struct max313xx *rtc =3D priv;
+	unsigned int reg =3D rtc->chip->ram_reg + offset;
+
+	return regmap_bulk_write(rtc->regmap, reg, val, bytes);
+}
+
+struct nvmem_config max313xx_nvmem_cfg =3D {
+	.reg_read =3D max313xx_nvmem_reg_read,
+	.reg_write =3D max313xx_nvmem_reg_write,
+	.word_size =3D 8,
+};
+
+static unsigned long max313xx_clkout_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	const struct clkout_cfg *clkout =3D rtc->chip->clkout;
+	unsigned int freq_mask;
+	unsigned int reg;
+	int ret;
+
+	ret =3D regmap_read(rtc->regmap, clkout->reg, &reg);
+	if (ret)
+		return 0;
+
+	freq_mask =3D __roundup_pow_of_two(clkout->freq_size) - 1;
+
+	return clkout->freq_avail[(reg >> clkout->freq_pos) & freq_mask];
+}
+
+static long max313xx_clkout_round_rate(struct clk_hw *hw, unsigned long =
rate,
+				       unsigned long *prate)
+{
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
+	int index;
+
+	index =3D find_closest(rate, clkout->freq_avail, clkout->freq_size);
+	return clkout->freq_avail[index];
+}
+
+static int max313xx_clkout_set_rate(struct clk_hw *hw, unsigned long rat=
e,
+				    unsigned long parent_rate)
+{
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
+	unsigned int freq_mask;
+	int index;
+
+	index =3D find_closest(rate, clkout->freq_avail, clkout->freq_size);
+	freq_mask =3D __roundup_pow_of_two(clkout->freq_size) - 1;
+
+	return regmap_update_bits(rtc->regmap, clkout->reg,
+				  freq_mask << clkout->freq_pos,
+				  index << clkout->freq_pos);
+}
+
+static int max313xx_clkout_enable(struct clk_hw *hw)
+{
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
+
+	if (clkout->en_invert)
+		return regmap_clear_bits(rtc->regmap, clkout->reg,
+					 clkout->en_bit);
+
+	return regmap_set_bits(rtc->regmap, clkout->reg,  clkout->en_bit);
+}
+
+static void max313xx_clkout_disable(struct clk_hw *hw)
+{
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
+
+	switch (rtc->id) {
+	case ID_MAX31331:
+	case ID_MAX31334:
+		if (rtc->irq > 0) {
+			dev_err(rtc->rtc->dev.parent,
+				"clkout cannot be disabled when IRQ is requested");
+			return;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (clkout->en_invert)
+		regmap_set_bits(rtc->regmap, clkout->reg, clkout->en_bit);
+	else
+		regmap_clear_bits(rtc->regmap, clkout->reg,  clkout->en_bit);
+}
+
+static int max313xx_clkout_is_enabled(struct clk_hw *hw)
+{
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
+	unsigned int reg;
+	int ret;
+
+	ret =3D regmap_read(rtc->regmap, clkout->reg, &reg);
+	if (ret)
+		return ret;
+
+	return !!(reg & clkout->en_bit) ^ clkout->en_invert;
+}
+
+static const struct clk_ops max313xx_clkout_ops =3D {
+	.recalc_rate =3D max313xx_clkout_recalc_rate,
+	.round_rate =3D max313xx_clkout_round_rate,
+	.set_rate =3D max313xx_clkout_set_rate,
+	.enable =3D max313xx_clkout_enable,
+	.disable =3D max313xx_clkout_disable,
+	.is_enabled =3D max313xx_clkout_is_enabled,
+};
+
+struct clk_init_data max313xx_clk_init =3D {
+	.name =3D "max313xx-clkout",
+	.ops =3D &max313xx_clkout_ops,
+};
+
+#if IS_REACHABLE(HWMON)
+static int max313xx_read_temp(struct device *dev, enum hwmon_sensor_type=
s type,
+			      u32 attr, int channel, long *val)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	u8 reg[2];
+	s16 temp;
+	int ret;
+
+	if (type !=3D hwmon_temp || attr !=3D hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->temp_reg, reg, 2);
+	if (ret)
+		return ret;
+
+	temp =3D get_unaligned_be16(reg);
+
+	*val =3D (temp / 64) * 250;
+
+	return 0;
+}
+
+static umode_t max313xx_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_input)
+		return 0444;
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *max313xx_info[] =3D {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops max313xx_hwmon_ops =3D {
+	.is_visible =3D max313xx_is_visible,
+	.read =3D max313xx_read_temp,
+};
+
+static const struct hwmon_chip_info max313xx_chip_info =3D {
+	.ops =3D &max313xx_hwmon_ops,
+	.info =3D max313xx_info,
+};
+#endif
+
+static int max313xx_init(struct max313xx *rtc)
+{
+	int ret;
+
+	switch (rtc->id) {
+	case ID_MAX31341:
+	case ID_MAX31342:
+		ret =3D regmap_clear_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
+					MAX31341_42_CONFIG1_OSC_DISABLE);
+		if (ret)
+			return ret;
+
+		return regmap_set_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
+				       MAX31341_42_CONFIG1_SWRST);
+	default:
+		return 0;
+	}
+}
+
+static int max313xx_clkout_register(struct device *dev)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	int ret;
+
+	if (!device_property_present(dev, "#clock-cells"))
+		return 0;
+
+	max313xx_clk_init.name =3D rtc->chip->clkout_name;
+	device_property_read_string(dev, "clock-output-names",
+				    &max313xx_clk_init.name);
+	rtc->clkout.init =3D &max313xx_clk_init;
+
+	ret =3D devm_clk_hw_register(dev, &rtc->clkout);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot register clock\n");
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &rtc->clkout);
+}
+
+static int max313xx_trickle_charger_setup(struct device *dev)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	bool trickle_diode_en;
+	int index, reg;
+	u32 ohms, chargeable;
+	int ret;
+	const char *diode;
+
+	if (device_property_read_u32(dev, "aux-voltage-chargeable",
+				     &chargeable))
+		return 0;
+
+	if (device_property_read_u32(dev, "trickle-resistor-ohms", &ohms))
+		return 0;
+
+	if (device_property_read_string(dev, "adi,tc-diode", &diode))
+		return 0;
+
+	if (!strcmp(diode, "schottky"))
+		trickle_diode_en =3D 0;
+	else if (!strcmp(diode, "standard+schottky"))
+		trickle_diode_en =3D 1;
+	else
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid tc-diode value: %s\n", diode);
+
+	if (!rtc->chip->trickle_reg)
+		return 0;
+
+	index =3D find_closest(ohms, max313xx_trickle_ohms,
+			     ARRAY_SIZE(max313xx_trickle_ohms)) + 1;
+
+	switch (rtc->id) {
+	case ID_MAX31329:
+		reg =3D FIELD_PREP(MAX31329_TRICKLE_ENABLE_BIT, chargeable) |
+		      FIELD_PREP(MAX31329_43_TRICKLE_RES_MASK, index) |
+		      FIELD_PREP(MAX31329_43_TRICKLE_DIODE_EN, trickle_diode_en);
+		break;
+	case ID_MAX31331:
+	case ID_MAX31334:
+		reg =3D FIELD_PREP(MAX3133X_TRICKLE_ENABLE_BIT, chargeable) |
+		      FIELD_PREP(MAX3133X_TRICKLE_RES_MASK, index) |
+		      FIELD_PREP(MAX3133X_TRICKLE_DIODE_EN, trickle_diode_en);
+		break;
+	case ID_MAX31341:
+		if (index =3D=3D 1)
+			index =3D 0;
+
+		reg =3D FIELD_PREP(MAX31341_TRICKLE_ENABLE_BIT, chargeable) |
+		      FIELD_PREP(MAX31341_TRICKLE_RES_MASK, index) |
+		      FIELD_PREP(MAX31341_TRICKLE_DIODE_EN, trickle_diode_en);
+
+		ret =3D regmap_set_bits(rtc->regmap, MAX31341_POWER_MGMT_REG,
+				      MAX31341_POWER_MGMT_TRICKLE_BIT);
+		if (ret)
+			return ret;
+
+		break;
+	case ID_MAX31343:
+		reg =3D FIELD_PREP(MAX31329_43_TRICKLE_RES_MASK, index) |
+		      FIELD_PREP(MAX31329_43_TRICKLE_DIODE_EN, trickle_diode_en) |
+		      FIELD_PREP(MAX31343_TRICKLE_ENABLE_MASK,
+				 MAX31343_TRICKLE_ENABLE_CODE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return regmap_write(rtc->regmap, rtc->chip->trickle_reg, reg);
+}
+
+static int max313xx_find_clkin_freq_index(struct clk *clk)
+{
+	unsigned long rate =3D clk_get_rate(clk);
+	int freq;
+	int i;
+
+	i =3D find_closest(rate, max313xx_clkin_freq,
+			 ARRAY_SIZE(max313xx_clkin_freq));
+	if (max313xx_clkin_freq[i] =3D=3D rate)
+		return i;
+
+	for (i =3D ARRAY_SIZE(max313xx_clkin_freq) - 1; i >=3D 0; i--) {
+		freq =3D max313xx_clkin_freq[i];
+		if (freq =3D=3D clk_round_rate(clk, freq))
+			return i;
+	}
+
+	/* supplied clock cannot produce one of desired frequency rate */
+	return -ENODEV;
+}
+
+static int max313xx_clkin_init(struct device *dev)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	int rate;
+	int ret;
+
+	rtc->clkin =3D devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(rtc->clkin)) {
+		if (PTR_ERR(rtc->clkin) =3D=3D -ENOENT)
+			rtc->clkin =3D NULL;
+		else
+			return dev_err_probe(dev, PTR_ERR(rtc->clkin),
+					     "error while clkin setup\n");
+	}
+
+	if (!rtc->clkin) {
+		switch (rtc->id) {
+		case ID_MAX31329:
+			return regmap_clear_bits(rtc->regmap,
+						 MAX31329_CONFIG2_REG,
+						 MAX31329_CONFIG2_CLKIN_EN);
+		case ID_MAX31341:
+		case ID_MAX31342:
+			return regmap_clear_bits(rtc->regmap,
+						 MAX31341_42_CONFIG1_REG,
+						 MAX31341_42_CONFIG1_CLKIN_EN);
+		default:
+			return 0;
+		}
+	}
+
+	rate =3D max313xx_find_clkin_freq_index(rtc->clkin);
+	if (rate < 0)
+		return dev_err_probe(dev, rate,
+				     "clkin cannot produce required frequency\n");
+
+	ret =3D clk_set_rate(rtc->clkin, max313xx_clkin_freq[rate]);
+	if (ret)
+		return ret;
+
+	switch (rtc->id) {
+	case ID_MAX31329:
+		ret =3D regmap_update_bits(rtc->regmap, MAX31329_CONFIG2_REG,
+					 MAX31329_CONFIG2_CLKIN_FREQ, rate);
+		if (ret)
+			return ret;
+
+		return regmap_set_bits(rtc->regmap, MAX31329_CONFIG2_REG,
+				       MAX31329_CONFIG2_CLKIN_EN);
+	case ID_MAX31341:
+	case ID_MAX31342:
+		ret =3D regmap_update_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
+					 MAX31341_42_CONFIG1_CLKIN_FREQ,
+					 FIELD_PREP(MAX31341_42_CONFIG1_CLKIN_FREQ, rate));
+		if (ret)
+			return ret;
+
+		return regmap_set_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
+				       MAX31341_42_CONFIG1_CLKIN_EN);
+	default:
+		rtc->clkin =3D NULL;
+		dev_warn(dev, "device does not have clock input\n");
+		return 0;
+	}
+}
+
+static int max313xx_irq_init(struct device *dev, const char *devname)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	int ret;
+
+	switch (rtc->id) {
+	case ID_MAX31328:
+		break;
+	case ID_MAX31331:
+	case ID_MAX31334:
+		if (rtc->clkout.clk) {
+			/*
+			 * interrupt muxing depends on clkout so enable clkout
+			 * if configured before requesting interrupt
+			 */
+			ret =3D clk_prepare_enable(rtc->clkout.clk);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "cannot enable clkout\n");
+		}
+		break;
+	default:
+		if (rtc->clkin) {
+			if (rtc->clkout.clk && rtc->irq > 0)
+				return dev_err_probe(dev, -EOPNOTSUPP,
+						     "irq not possible when both clkin and clkout are configured\n=
");
+
+			if (rtc->irq <=3D 0)
+				break;
+
+			/* clkout needs to be disabled for interrupt */
+			if (rtc->chip->clkout->en_invert)
+				ret =3D regmap_set_bits(rtc->regmap,
+						      rtc->chip->clkout->reg,
+						      rtc->chip->clkout->en_bit);
+			else
+				ret =3D regmap_clear_bits(rtc->regmap,
+							rtc->chip->clkout->reg,
+							rtc->chip->clkout->en_bit);
+
+			if (ret)
+				return ret;
+		}
+		break;
+	}
+
+	if (rtc->irq > 0) {
+		return devm_request_threaded_irq(dev, rtc->irq, NULL,
+						 &max313xx_irq, IRQF_ONESHOT,
+						 devname, rtc);
+	} else if (device_property_read_bool(dev, "wakeup-source")) {
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtc->features);
+		return device_init_wakeup(dev, true);
+	}
+
+	clear_bit(RTC_FEATURE_ALARM, rtc->rtc->features);
+
+	return 0;
+}
+
+static int max313xx_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
+	struct device *dev =3D &client->dev;
+	struct max313xx *max313xx;
+#if IS_REACHABLE(HWMON)
+	struct device *hwmon;
+#endif
+	const void *match;
+	int ret;
+
+	max313xx =3D devm_kzalloc(&client->dev, sizeof(*max313xx), GFP_KERNEL);
+	if (!max313xx)
+		return -ENOMEM;
+
+	dev_set_drvdata(&client->dev, max313xx);
+
+	max313xx->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(max313xx->regmap)) {
+		return dev_err_probe(dev, PTR_ERR(max313xx->regmap),
+				     "regmap init failed\n");
+	}
+
+	i2c_set_clientdata(client, max313xx);
+
+	match =3D device_get_match_data(dev);
+	if (match)
+		max313xx->chip =3D match;
+	else if (id)
+		max313xx->chip =3D (struct chip_desc *)id->driver_data;
+	else
+		return -ENODEV;
+
+	max313xx->id =3D max313xx->chip - chip;
+
+	ret =3D max313xx_init(max313xx);
+	if (ret)
+		return ret;
+
+	max313xx->rtc =3D devm_rtc_allocate_device(dev);
+	if (IS_ERR(max313xx->rtc))
+		return PTR_ERR(max313xx->rtc);
+
+	max313xx->rtc->ops =3D &max3133x_rtc_ops;
+	max313xx->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
+	max313xx->rtc->range_max =3D RTC_TIMESTAMP_END_2199;
+
+	ret =3D devm_rtc_register_device(max313xx->rtc);
+	if (ret)
+		return ret;
+
+	max313xx->irq =3D client->irq;
+
+	ret =3D max313xx_clkout_register(dev);
+	if (ret)
+		return ret;
+
+	ret =3D max313xx_clkin_init(dev);
+	if (ret)
+		return ret;
+
+	/* IRQ wiring depends on the clock configuration so parse them first */
+	ret =3D max313xx_irq_init(dev, client->name);
+	if (ret)
+		return ret;
+
+	if (max313xx->chip->ram_size) {
+		max313xx_nvmem_cfg.size =3D max313xx->chip->ram_size;
+		max313xx_nvmem_cfg.priv =3D max313xx;
+
+		ret =3D devm_rtc_nvmem_register(max313xx->rtc, &max313xx_nvmem_cfg);
+		if (ret)
+			dev_warn(dev, "cannot register rtc nvmem\n");
+	}
+
+#if IS_REACHABLE(HWMON)
+	if (max313xx->chip->temp_reg) {
+		hwmon =3D devm_hwmon_device_register_with_info(dev, client->name,
+							     max313xx,
+							     &max313xx_chip_info,
+							     NULL);
+		if (IS_ERR(hwmon))
+			dev_warn(dev, "cannot register hwmon device: %li\n",
+				 PTR_ERR(hwmon));
+	}
+#endif
+
+	return max313xx_trickle_charger_setup(dev);
+}
+
+static const struct of_device_id max313xx_of_id[] =3D {
+	{ .compatible =3D "adi,max31328", .data =3D &chip[ID_MAX31328] },
+	{ .compatible =3D "adi,max31329", .data =3D &chip[ID_MAX31329] },
+	{ .compatible =3D "adi,max31331", .data =3D &chip[ID_MAX31331] },
+	{ .compatible =3D "adi,max31334", .data =3D &chip[ID_MAX31334] },
+	{ .compatible =3D "adi,max31341", .data =3D &chip[ID_MAX31341] },
+	{ .compatible =3D "adi,max31342", .data =3D &chip[ID_MAX31342] },
+	{ .compatible =3D "adi,max31343", .data =3D &chip[ID_MAX31343] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max313xx_of_id);
+
+static const struct i2c_device_id max313xx_id[] =3D {
+	{ "max31328", (kernel_ulong_t)&chip[ID_MAX31328] },
+	{ "max31329", (kernel_ulong_t)&chip[ID_MAX31329] },
+	{ "max31331", (kernel_ulong_t)&chip[ID_MAX31331] },
+	{ "max31334", (kernel_ulong_t)&chip[ID_MAX31334] },
+	{ "max31341", (kernel_ulong_t)&chip[ID_MAX31341] },
+	{ "max31342", (kernel_ulong_t)&chip[ID_MAX31342] },
+	{ "max31343", (kernel_ulong_t)&chip[ID_MAX31343] },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max313xx_id);
+
+static struct i2c_driver max313xx_driver =3D {
+	.driver =3D {
+		.name	=3D "rtc-max313xx",
+		.of_match_table =3D max313xx_of_id,
+	},
+	.probe		=3D max313xx_probe,
+	.id_table	=3D max313xx_id,
+};
+module_i2c_driver(max313xx_driver);
+
+MODULE_DESCRIPTION("Analog Devices MAX313XX RTCs");
+MODULE_AUTHOR("Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>");
+MODULE_AUTHOR("Ibrahim Tilki <Ibrahim.Tilki@analog.com>");
+MODULE_SOFTDEP("pre: regmap-i2c");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
--=20
2.43.0


