Return-Path: <linux-kernel+bounces-72053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC285AE50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C7AB21B91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269156777;
	Mon, 19 Feb 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IcCTe/mL"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7F54F9D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381114; cv=none; b=XY1bckEtKLR3yuVGCJyqw44sQctPfTQERtiYh0aXwazgZ4ETcs7p3NqSsV+0sJnNmVSxFhQiAzbAOweaJz1Ssl5lMhLJCTcGDN7bpuNGdEWXO5LVx9g2geJulK3ri8VwtM80hVcKheNy/gd35BGif08A9qP38NSphR8QcGXRqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381114; c=relaxed/simple;
	bh=Kz10T01bA+b7zW6jUgV0Nf38GSabdjIk5BBO3xLs1UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwSH+tPfVmm9We+6C3GbfTua50sopQzIOHLwLW0ATPyr5gVxtXV2Y15Ni7I1jRLvfK75rYb1qIg0MnyFx7b9V19DIotlUFFSHqq+guIi9gP7JRT41yfveT1kACRkJ8njeD/772lhG+n6GaINidU3C0lWk/w63nqgya0i917LmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IcCTe/mL; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F269E2C072D;
	Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708381108;
	bh=x4o4MIsFrPnpOzzP0Y7lDKTW8gUa/+IluW7OBG60G1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcCTe/mLfWjpxtY6ki17wzCrGNTyPQ5p0VbLTX3UAlaIaDmNaCw6weCALs/fjIpre
	 XBkZiOyjdk9NzX57uLCTvwMRmdx4BRpDsaRZjDM0RRTfGsBHJmYRQaea9L3GFE4b0l
	 T0OwXhFzBBsBMWQcb5jfMF9T/WNDD4A8b4Q/sIj6TY5UOxF4vL3aG1hKKeTgTP07CH
	 5ZWldjE0xAKgVFn+aYV10pFahvamuPVaiMuYkYGO3fL8P0hOc8amo6KQFPayIQvL4q
	 RLu5QSwQuft7jM1zHta+zcdH+wmOsGaeKJe3VcSYeIUZH3PU92ymwgyYZuucwBxOaD
	 nQD4gmboRr74g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d3d3b40001>; Tue, 20 Feb 2024 11:18:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8D64813EE5B;
	Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 86DE0280480; Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: antoniu.miclaus@analog.com,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 1/2] drivers: rtc: add max313xx series rtc driver
Date: Tue, 20 Feb 2024 11:18:23 +1300
Message-ID: <20240219221827.3821415-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
References: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d3d3b4 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=TgWwoY1It6pAwy9ok4IA:9 a=3ZKOabzyN94A:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Adding support for Analog Devices MAX313XX series RTCs.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/rtc/Kconfig        |    2 +-
 drivers/rtc/rtc-max31335.c | 1152 ++++++++++++++++++++++++------------
 2 files changed, 790 insertions(+), 364 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e37a4341f442..b30e384d0d3c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -381,7 +381,7 @@ config RTC_DRV_MAX31335
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Analog Devices
-	  MAX31335.
+	  MAX31335/31328/31329/31331/31334/31341/31342/31343.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max31335.
diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 402fda8fd548..36a5bb37e0b0 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -1,13 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * RTC driver for the MAX31335
+ * RTC driver for the MAX313XX series
  *
  * Copyright (C) 2023 Analog Devices
  *
  * Antoniu Miclaus <antoniu.miclaus@analog.com>
  *
  */
-
 #include <asm-generic/unaligned.h>
 #include <linux/bcd.h>
 #include <linux/bitfield.h>
@@ -24,232 +23,398 @@
 #include <linux/rtc.h>
 #include <linux/util_macros.h>
=20
-/* MAX31335 Register Map */
-#define MAX31335_STATUS1			0x00
-#define MAX31335_INT_EN1			0x01
-#define MAX31335_STATUS2			0x02
-#define MAX31335_INT_EN2			0x03
-#define MAX31335_RTC_RESET			0x04
-#define MAX31335_RTC_CONFIG			0x05
-#define MAX31335_RTC_CONFIG2			0x06
-#define MAX31335_TIMESTAMP_CONFIG		0x07
-#define MAX31335_TIMER_CONFIG			0x08
-#define MAX31335_SECONDS_1_128			0x09
-#define MAX31335_SECONDS			0x0A
-#define MAX31335_MINUTES			0x0B
-#define MAX31335_HOURS				0x0C
-#define MAX31335_DAY				0x0D
-#define MAX31335_DATE				0x0E
-#define MAX31335_MONTH				0x0F
-#define MAX31335_YEAR				0x0F
-#define MAX31335_ALM1_SEC			0x11
-#define MAX31335_ALM1_MIN			0x12
-#define MAX31335_ALM1_HRS			0x13
-#define MAX31335_ALM1_DAY_DATE			0x14
-#define MAX31335_ALM1_MON			0x15
-#define MAX31335_ALM1_YEAR			0x16
-#define MAX31335_ALM2_MIN			0x17
-#define MAX31335_ALM2_HRS			0x18
-#define MAX31335_ALM2_DAY_DATE			0x19
-#define MAX31335_TIMER_COUNT			0x1A
-#define MAX31335_TIMER_INIT			0x1B
-#define MAX31335_PWR_MGMT			0x1C
-#define MAX31335_TRICKLE_REG			0x1D
-#define MAX31335_AGING_OFFSET			0x1E
-#define MAX31335_TS_CONFIG			0x30
-#define MAX31335_TEMP_ALARM_HIGH_MSB		0x31
-#define MAX31335_TEMP_ALARM_HIGH_LSB		0x32
-#define MAX31335_TEMP_ALARM_LOW_MSB		0x33
-#define MAX31335_TEMP_ALARM_LOW_LSB		0x34
-#define MAX31335_TEMP_DATA_MSB			0x35
-#define MAX31335_TEMP_DATA_LSB			0x36
-#define MAX31335_TS0_SEC_1_128			0x40
-#define MAX31335_TS0_SEC			0x41
-#define MAX31335_TS0_MIN			0x42
-#define MAX31335_TS0_HOUR			0x43
-#define MAX31335_TS0_DATE			0x44
-#define MAX31335_TS0_MONTH			0x45
-#define MAX31335_TS0_YEAR			0x46
-#define MAX31335_TS0_FLAGS			0x47
-#define MAX31335_TS1_SEC_1_128			0x48
-#define MAX31335_TS1_SEC			0x49
-#define MAX31335_TS1_MIN			0x4A
-#define MAX31335_TS1_HOUR			0x4B
-#define MAX31335_TS1_DATE			0x4C
-#define MAX31335_TS1_MONTH			0x4D
-#define MAX31335_TS1_YEAR			0x4E
-#define MAX31335_TS1_FLAGS			0x4F
-#define MAX31335_TS2_SEC_1_128			0x50
-#define MAX31335_TS2_SEC			0x51
-#define MAX31335_TS2_MIN			0x52
-#define MAX31335_TS2_HOUR			0x53
-#define MAX31335_TS2_DATE			0x54
-#define MAX31335_TS2_MONTH			0x55
-#define MAX31335_TS2_YEAR			0x56
-#define MAX31335_TS2_FLAGS			0x57
-#define MAX31335_TS3_SEC_1_128			0x58
-#define MAX31335_TS3_SEC			0x59
-#define MAX31335_TS3_MIN			0x5A
-#define MAX31335_TS3_HOUR			0x5B
-#define MAX31335_TS3_DATE			0x5C
-#define MAX31335_TS3_MONTH			0x5D
-#define MAX31335_TS3_YEAR			0x5E
-#define MAX31335_TS3_FLAGS			0x5F
+/* common registers */
+#define MAX313XX_INT_ALARM1		BIT(0)
+#define MAX313XX_HRS_F_AM_PM		BIT(5)
+#define MAX313XX_HRS_F_12_24		BIT(6)
+#define MAX313XX_MONTH_CENTURY		BIT(7)
=20
-/* MAX31335_STATUS1 Bit Definitions */
-#define MAX31335_STATUS1_PSDECT			BIT(7)
-#define MAX31335_STATUS1_OSF			BIT(6)
-#define MAX31335_STATUS1_PFAIL			BIT(5)
-#define MAX31335_STATUS1_VBATLOW		BIT(4)
-#define MAX31335_STATUS1_DIF			BIT(3)
-#define MAX31335_STATUS1_TIF			BIT(2)
-#define MAX31335_STATUS1_A2F			BIT(1)
-#define MAX31335_STATUS1_A1F			BIT(0)
+#define MAX313XX_TIME_SIZE		0x07
=20
-/* MAX31335_INT_EN1 Bit Definitions */
-#define MAX31335_INT_EN1_DOSF			BIT(6)
-#define MAX31335_INT_EN1_PFAILE			BIT(5)
-#define MAX31335_INT_EN1_VBATLOWE		BIT(4)
-#define MAX31335_INT_EN1_DIE			BIT(3)
-#define MAX31335_INT_EN1_TIE			BIT(2)
-#define MAX31335_INT_EN1_A2IE			BIT(1)
-#define MAX31335_INT_EN1_A1IE			BIT(0)
+/* device specific registers */
+#define MAX3134X_CFG2_REG		0x01
+#define MAX3134X_CFG2_SET_RTC		BIT(1)
=20
-/* MAX31335_STATUS2 Bit Definitions */
-#define MAX31335_STATUS2_TEMP_RDY		BIT(2)
-#define MAX31335_STATUS2_OTF			BIT(1)
-#define MAX31335_STATUS2_UTF			BIT(0)
+#define MAX31341_TRICKLE_RES_MASK	GENMASK(1, 0)
+#define MAX31341_TRICKLE_DIODE_EN	BIT(2)
+#define MAX31341_TRICKLE_ENABLE_BIT	BIT(3)
+#define MAX31341_POWER_MGMT_REG		0x56
+#define MAX31341_POWER_MGMT_TRICKLE_BIT	BIT(0)
=20
-/* MAX31335_INT_EN2 Bit Definitions */
-#define MAX31335_INT_EN2_TEMP_RDY_EN		BIT(2)
-#define MAX31335_INT_EN2_OTIE			BIT(1)
-#define MAX31335_INT_EN2_UTIE			BIT(0)
+#define MAX3133X_TRICKLE_RES_MASK	GENMASK(2, 1)
+#define MAX3133X_TRICKLE_DIODE_EN	BIT(3)
+#define MAX3133X_TRICKLE_ENABLE_BIT	BIT(0)
=20
-/* MAX31335_RTC_RESET Bit Definitions */
-#define MAX31335_RTC_RESET_SWRST		BIT(0)
+#define MAX31329_TRICKLE_ENABLE_BIT	BIT(7)
+#define MAX31343_TRICKLE_ENABLE_MASK	GENMASK(7, 4)
+#define MAX31343_TRICKLE_ENABLE_CODE	5
+#define MAX31329_43_TRICKLE_RES_MASK	GENMASK(1, 0)
+#define MAX31329_43_TRICKLE_DIODE_EN	BIT(2)
=20
-/* MAX31335_RTC_CONFIG1 Bit Definitions */
-#define MAX31335_RTC_CONFIG1_EN_IO		BIT(6)
-#define MAX31335_RTC_CONFIG1_A1AC		GENMASK(5, 4)
-#define MAX31335_RTC_CONFIG1_DIP		BIT(3)
-#define MAX31335_RTC_CONFIG1_I2C_TIMEOUT	BIT(1)
-#define MAX31335_RTC_CONFIG1_EN_OSC		BIT(0)
+#define MAX31329_CONFIG2_REG		0x04
+#define MAX31329_CONFIG2_CLKIN_EN	BIT(2)
+#define MAX31329_CONFIG2_CLKIN_FREQ	GENMASK(1, 0)
=20
-/* MAX31335_RTC_CONFIG2 Bit Definitions */
-#define MAX31335_RTC_CONFIG2_ENCLKO		BIT(2)
-#define MAX31335_RTC_CONFIG2_CLKO_HZ		GENMASK(1, 0)
+#define MAX31341_42_CONFIG1_REG		0x00
+#define MAX31341_42_CONFIG1_CLKIN_EN	BIT(7)
+#define MAX31341_42_CONFIG1_CLKIN_FREQ	GENMASK(5, 4)
+#define MAX31341_42_CONFIG1_OSC_DISABLE	BIT(3)
+#define MAX31341_42_CONFIG1_SWRST	BIT(0)
=20
-/* MAX31335_TIMESTAMP_CONFIG Bit Definitions */
-#define MAX31335_TIMESTAMP_CONFIG_TSVLOW	BIT(5)
-#define MAX31335_TIMESTAMP_CONFIG_TSPWM		BIT(4)
-#define MAX31335_TIMESTAMP_CONFIG_TSDIN		BIT(3)
-#define MAX31335_TIMESTAMP_CONFIG_TSOW		BIT(2)
-#define MAX31335_TIMESTAMP_CONFIG_TSR		BIT(1)
-#define MAX31335_TIMESTAMP_CONFIG_TSE		BIT(0)
+enum max313xx_ids {
+	ID_MAX31328,
+	ID_MAX31329,
+	ID_MAX31331,
+	ID_MAX31334,
+	ID_MAX31335,
+	ID_MAX31341,
+	ID_MAX31342,
+	ID_MAX31343,
+	MAX313XX_ID_NR
+};
=20
-/* MAX31335_TIMER_CONFIG Bit Definitions */
-#define MAX31335_TIMER_CONFIG_TE		BIT(4)
-#define MAX31335_TIMER_CONFIG_TPAUSE		BIT(3)
-#define MAX31335_TIMER_CONFIG_TRPT		BIT(2)
-#define MAX31335_TIMER_CONFIG_TFS		GENMASK(1, 0)
+struct clkout_cfg {
+	const int *freq_avail;
+	u8 freq_size;
+	u8 freq_pos;
+	u8 reg;
+	u8 en_bit;
+	bool en_invert;
+};
=20
-/* MAX31335_HOURS Bit Definitions */
-#define MAX31335_HOURS_F_24_12			BIT(6)
-#define MAX31335_HOURS_HR_20_AM_PM		BIT(5)
+struct chip_desc {
+	struct clkout_cfg *clkout;
+	const char *clkout_name;
+	u8 sec_reg;
+	u8 alarm1_sec_reg;
=20
-/* MAX31335_MONTH Bit Definitions */
-#define MAX31335_MONTH_CENTURY			BIT(7)
+	u8 int_en_reg;
+	u8 int_status_reg;
+	u8 osf_bit;
=20
-/* MAX31335_PWR_MGMT Bit Definitions */
-#define MAX31335_PWR_MGMT_PFVT			BIT(0)
+	u8 ram_reg;
+	u8 ram_size;
=20
-/* MAX31335_TRICKLE_REG Bit Definitions */
-#define MAX31335_TRICKLE_REG_TRICKLE		GENMASK(3, 1)
-#define MAX31335_TRICKLE_REG_EN_TRICKLE		BIT(0)
+	u8 temp_reg;
=20
-/* MAX31335_TS_CONFIG Bit Definitions */
-#define MAX31335_TS_CONFIG_AUTO			BIT(4)
-#define MAX31335_TS_CONFIG_CONVERT_T		BIT(3)
-#define MAX31335_TS_CONFIG_TSINT		GENMASK(2, 0)
+	u8 trickle_reg;
=20
-/* MAX31335_TS_FLAGS Bit Definitions */
-#define MAX31335_TS_FLAGS_VLOWF			BIT(3)
-#define MAX31335_TS_FLAGS_VBATF			BIT(2)
-#define MAX31335_TS_FLAGS_VCCF			BIT(1)
-#define MAX31335_TS_FLAGS_DINF			BIT(0)
+	u8 rst_reg;
+	u8 rst_bit;
+};
=20
-/* MAX31335 Miscellaneous Definitions */
-#define MAX31335_TRICKLE_SCHOTTKY_DIODE		1
-#define MAX31335_TRICKLE_STANDARD_DIODE		4
-#define MAX31335_RAM_SIZE			32
-#define MAX31335_TIME_SIZE			0x07
+#define clk_hw_to_max313xx(_hw) container_of(_hw, struct max313xx, clkou=
t)
=20
-#define clk_hw_to_max31335(_hw) container_of(_hw, struct max31335_data, =
clkout)
-
-struct max31335_data {
+struct max313xx {
+	enum max313xx_ids id;
 	struct regmap *regmap;
 	struct rtc_device *rtc;
 	struct clk_hw clkout;
+	struct clk *clkin;
+	const struct chip_desc *chip;
+	int irq;
 };
=20
-static const int max31335_clkout_freq[] =3D { 1, 64, 1024, 32768 };
+static const int max313xx_clkin_freq[] =3D { 1, 50, 60, 32768 };
=20
-static const u16 max31335_trickle_resistors[] =3D {3000, 6000, 11000};
+static const int max31328_clkout_freq[] =3D { 1, 1024, 4096, 8192 };
+static const int max31329_clkout_freq[] =3D { 1, 4096, 8192, 32768 };
+static const int max3133x_clkout_freq[] =3D { 1, 64, 1024, 32768 };
+static const int max31341_42_clkout_freq[] =3D { 1, 50, 60, 32768 };
+static const int max31343_clkout_freq[] =3D { 1, 2, 4, 8, 16, 32, 64, 12=
8, 32875 };
=20
-static bool max31335_volatile_reg(struct device *dev, unsigned int reg)
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
+static struct clkout_cfg max31335_clkout =3D {
+	.freq_avail =3D max3133x_clkout_freq,
+	.freq_size =3D ARRAY_SIZE(max3133x_clkout_freq),
+	.freq_pos =3D 0,
+	.reg =3D 0x06,
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
+	[ID_MAX31335] =3D {
+		.int_en_reg =3D 0x01,
+		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
+		.sec_reg =3D 0x0a,
+		.alarm1_sec_reg =3D 0x11,
+		.ram_reg =3D 0x40,
+		.ram_size =3D 32,
+		.temp_reg =3D 0x35,
+		.trickle_reg =3D 0x1d,
+		.clkout =3D &max31335_clkout,
+		.clkout_name =3D "max31335-clkout",
+		.rst_reg =3D 0x04,
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
 {
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	const struct chip_desc *chip =3D rtc->chip;
+
 	/* time keeping registers */
-	if (reg >=3D MAX31335_SECONDS &&
-	    reg < MAX31335_SECONDS + MAX31335_TIME_SIZE)
+	if (reg >=3D chip->sec_reg && reg < chip->sec_reg + MAX313XX_TIME_SIZE)
 		return true;
=20
 	/* interrupt status register */
-	if (reg =3D=3D MAX31335_INT_EN1_A1IE)
+	if (reg =3D=3D chip->int_status_reg)
 		return true;
=20
 	/* temperature registers */
-	if (reg =3D=3D MAX31335_TEMP_DATA_MSB || reg =3D=3D MAX31335_TEMP_DATA_=
LSB)
-		return true;
-
-	return false;
+	return chip->temp_reg &&
+		(reg =3D=3D chip->temp_reg || reg =3D=3D chip->temp_reg + 1);
 }
=20
 static const struct regmap_config regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
-	.max_register =3D 0x5F,
-	.volatile_reg =3D max31335_volatile_reg,
+	.cache_type =3D REGCACHE_RBTREE,
+	.volatile_reg =3D max313xx_volatile_reg,
 };
=20
-static int max31335_read_time(struct device *dev, struct rtc_time *tm)
+static int max313xx_get_hour(u8 hour_reg)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
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
+static int max313xx_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
 	u8 date[7];
 	int ret;
+	unsigned int status;
=20
-	ret =3D regmap_bulk_read(max31335->regmap, MAX31335_SECONDS, date,
-			       sizeof(date));
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_status_reg, &status);
+	if (ret)
+		return ret;
+
+	if (status & rtc->chip->osf_bit)
+		return -EINVAL;
+
+	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->sec_reg, date, 7);
 	if (ret)
 		return ret;
=20
 	tm->tm_sec  =3D bcd2bin(date[0] & 0x7f);
 	tm->tm_min  =3D bcd2bin(date[1] & 0x7f);
-	tm->tm_hour =3D bcd2bin(date[2] & 0x3f);
+	tm->tm_hour =3D max313xx_get_hour(date[2]);
 	tm->tm_wday =3D bcd2bin(date[3] & 0x7) - 1;
 	tm->tm_mday =3D bcd2bin(date[4] & 0x3f);
 	tm->tm_mon  =3D bcd2bin(date[5] & 0x1f) - 1;
 	tm->tm_year =3D bcd2bin(date[6]) + 100;
=20
-	if (FIELD_GET(MAX31335_MONTH_CENTURY, date[5]))
+	if (FIELD_GET(MAX313XX_MONTH_CENTURY, date[5]))
 		tm->tm_year +=3D 100;
=20
 	return 0;
 }
=20
-static int max31335_set_time(struct device *dev, struct rtc_time *tm)
+static int max313xx_pre_set_time(struct max313xx *rtc)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
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
+static int max313xx_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
 	u8 date[7];
+	int ret;
=20
 	date[0] =3D bin2bcd(tm->tm_sec);
 	date[1] =3D bin2bcd(tm->tm_min);
@@ -260,20 +425,34 @@ static int max31335_set_time(struct device *dev, st=
ruct rtc_time *tm)
 	date[6] =3D bin2bcd(tm->tm_year % 100);
=20
 	if (tm->tm_year >=3D 200)
-		date[5] |=3D FIELD_PREP(MAX31335_MONTH_CENTURY, 1);
+		date[5] |=3D FIELD_PREP(MAX313XX_MONTH_CENTURY, 1);
=20
-	return regmap_bulk_write(max31335->regmap, MAX31335_SECONDS, date,
-				 sizeof(date));
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
+	ret =3D regmap_bulk_write(rtc->regmap, rtc->chip->sec_reg, date, 7);
+	if (ret)
+		return ret;
+
+	return max313xx_post_set_time(rtc);
 }
=20
-static int max31335_read_alarm(struct device *dev, struct rtc_wkalrm *al=
rm)
+static int max313xx_read_alarm(struct device *dev, struct rtc_wkalrm *al=
rm)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
-	int ret, ctrl, status;
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	unsigned int status, int_en;
 	struct rtc_time time;
 	u8 regs[6];
+	int ret;
=20
-	ret =3D regmap_bulk_read(max31335->regmap, MAX31335_ALM1_SEC, regs,
+	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->alarm1_sec_reg, regs,
 			       sizeof(regs));
 	if (ret)
 		return ret;
@@ -285,30 +464,30 @@ static int max31335_read_alarm(struct device *dev, =
struct rtc_wkalrm *alrm)
 	alrm->time.tm_mon  =3D bcd2bin(regs[4] & 0x1f) - 1;
 	alrm->time.tm_year =3D bcd2bin(regs[5]) + 100;
=20
-	ret =3D max31335_read_time(dev, &time);
+	ret =3D max313xx_read_time(dev, &time);
 	if (ret)
 		return ret;
=20
 	if (time.tm_year >=3D 200)
 		alrm->time.tm_year +=3D 100;
=20
-	ret =3D regmap_read(max31335->regmap, MAX31335_INT_EN1, &ctrl);
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_status_reg, &status);
 	if (ret)
 		return ret;
=20
-	ret =3D regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_en_reg, &int_en);
 	if (ret)
 		return ret;
=20
-	alrm->enabled =3D FIELD_GET(MAX31335_INT_EN1_A1IE, ctrl);
-	alrm->pending =3D FIELD_GET(MAX31335_STATUS1_A1F, status);
+	alrm->enabled =3D FIELD_GET(MAX313XX_INT_ALARM1, int_en);
+	alrm->pending =3D FIELD_GET(MAX313XX_INT_ALARM1, status);
=20
 	return 0;
 }
=20
-static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm *alr=
m)
+static int max313xx_set_alarm(struct device *dev, struct rtc_wkalrm *alr=
m)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
 	unsigned int reg;
 	u8 regs[6];
 	int ret;
@@ -320,61 +499,62 @@ static int max31335_set_alarm(struct device *dev, s=
truct rtc_wkalrm *alrm)
 	regs[4] =3D bin2bcd(alrm->time.tm_mon + 1);
 	regs[5] =3D bin2bcd(alrm->time.tm_year % 100);
=20
-	ret =3D regmap_bulk_write(max31335->regmap, MAX31335_ALM1_SEC,
-				regs, sizeof(regs));
+	ret =3D regmap_bulk_write(rtc->regmap, rtc->chip->alarm1_sec_reg, regs,
+				sizeof(regs));
 	if (ret)
 		return ret;
=20
-	reg =3D FIELD_PREP(MAX31335_INT_EN1_A1IE, alrm->enabled);
-	ret =3D regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
-				 MAX31335_INT_EN1_A1IE, reg);
+	reg =3D FIELD_PREP(MAX313XX_INT_ALARM1, alrm->enabled);
+	ret =3D regmap_update_bits(rtc->regmap, rtc->chip->int_en_reg,
+				 MAX313XX_INT_ALARM1, reg);
 	if (ret)
 		return ret;
=20
-	ret =3D regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
-				 MAX31335_STATUS1_A1F, 0);
-
-	return 0;
+	/* Clear status register */
+	return regmap_read(rtc->regmap, rtc->chip->int_status_reg, &reg);
 }
=20
-static int max31335_alarm_irq_enable(struct device *dev, unsigned int en=
abled)
+static int max313xx_alarm_irq_enable(struct device *dev, unsigned int en=
abled)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
=20
-	return regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
-				  MAX31335_INT_EN1_A1IE, enabled);
+	return regmap_update_bits(rtc->regmap, rtc->chip->int_en_reg,
+				  MAX313XX_INT_ALARM1,
+				  FIELD_PREP(MAX313XX_INT_ALARM1, enabled));
 }
=20
-static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
+static irqreturn_t max313xx_irq(int irq, void *dev_id)
 {
-	struct max31335_data *max31335 =3D dev_id;
+	struct max313xx	*rtc =3D dev_id;
 	bool status;
 	int ret;
=20
-	ret =3D regmap_update_bits_check(max31335->regmap, MAX31335_STATUS1,
-				       MAX31335_STATUS1_A1F, 0, &status);
+	ret =3D regmap_update_bits_check(rtc->regmap, rtc->chip->int_status_reg=
,
+				       MAX313XX_INT_ALARM1, 0, &status);
 	if (ret)
 		return IRQ_HANDLED;
=20
 	if (status)
-		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
+		rtc_update_irq(rtc->rtc, 1, RTC_AF | RTC_IRQF);
=20
 	return IRQ_HANDLED;
 }
=20
-static const struct rtc_class_ops max31335_rtc_ops =3D {
-	.read_time =3D max31335_read_time,
-	.set_time =3D max31335_set_time,
-	.read_alarm =3D max31335_read_alarm,
-	.set_alarm =3D max31335_set_alarm,
-	.alarm_irq_enable =3D max31335_alarm_irq_enable,
+static const struct rtc_class_ops max3133x_rtc_ops =3D {
+	.read_time	=3D max313xx_read_time,
+	.set_time	=3D max313xx_set_time,
+	.read_alarm	=3D max313xx_read_alarm,
+	.set_alarm	=3D max313xx_set_alarm,
+	.alarm_irq_enable =3D max313xx_alarm_irq_enable,
 };
=20
-static int max31335_trickle_charger_setup(struct device *dev,
-					  struct max31335_data *max31335)
+static int max313xx_trickle_charger_setup(struct device *dev)
 {
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
+	bool trickle_diode_en;
+	int index, reg;
 	u32 ohms, chargeable;
-	int i, trickle_cfg;
+	int ret;
 	const char *diode;
=20
 	if (device_property_read_u32(dev, "aux-voltage-chargeable",
@@ -388,144 +568,196 @@ static int max31335_trickle_charger_setup(struct =
device *dev,
 		return 0;
=20
 	if (!strcmp(diode, "schottky"))
-		trickle_cfg =3D MAX31335_TRICKLE_SCHOTTKY_DIODE;
+		trickle_diode_en =3D 0;
 	else if (!strcmp(diode, "standard+schottky"))
-		trickle_cfg =3D MAX31335_TRICKLE_STANDARD_DIODE;
+		trickle_diode_en =3D 1;
 	else
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid tc-diode value: %s\n", diode);
=20
-	for (i =3D 0; i < ARRAY_SIZE(max31335_trickle_resistors); i++)
-		if (ohms =3D=3D max31335_trickle_resistors[i])
-			break;
-
-	if (i >=3D ARRAY_SIZE(max31335_trickle_resistors))
+	if (!rtc->chip->trickle_reg)
 		return 0;
=20
-	i =3D i + trickle_cfg;
+	index =3D find_closest(ohms, max313xx_trickle_ohms,
+			     ARRAY_SIZE(max313xx_trickle_ohms)) + 1;
=20
-	return regmap_write(max31335->regmap, MAX31335_TRICKLE_REG,
-			    FIELD_PREP(MAX31335_TRICKLE_REG_TRICKLE, i) |
-			    FIELD_PREP(MAX31335_TRICKLE_REG_EN_TRICKLE,
-				       chargeable));
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
 }
=20
-static unsigned long max31335_clkout_recalc_rate(struct clk_hw *hw,
+static unsigned long max313xx_clkout_recalc_rate(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
-	struct max31335_data *max31335 =3D clk_hw_to_max31335(hw);
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	const struct clkout_cfg *clkout =3D rtc->chip->clkout;
 	unsigned int freq_mask;
 	unsigned int reg;
 	int ret;
=20
-	ret =3D regmap_read(max31335->regmap, MAX31335_RTC_CONFIG2, &reg);
+	ret =3D regmap_read(rtc->regmap, clkout->reg, &reg);
 	if (ret)
 		return 0;
=20
-	freq_mask =3D __roundup_pow_of_two(ARRAY_SIZE(max31335_clkout_freq)) - =
1;
+	freq_mask =3D __roundup_pow_of_two(clkout->freq_size) - 1;
=20
-	return max31335_clkout_freq[reg & freq_mask];
+	return clkout->freq_avail[(reg >> clkout->freq_pos) & freq_mask];
 }
=20
-static long max31335_clkout_round_rate(struct clk_hw *hw, unsigned long =
rate,
+static long max313xx_clkout_round_rate(struct clk_hw *hw, unsigned long =
rate,
 				       unsigned long *prate)
 {
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
 	int index;
=20
-	index =3D find_closest(rate, max31335_clkout_freq,
-			     ARRAY_SIZE(max31335_clkout_freq));
-
-	return max31335_clkout_freq[index];
+	index =3D find_closest(rate, clkout->freq_avail, clkout->freq_size);
+	return clkout->freq_avail[index];
 }
=20
-static int max31335_clkout_set_rate(struct clk_hw *hw, unsigned long rat=
e,
+static int max313xx_clkout_set_rate(struct clk_hw *hw, unsigned long rat=
e,
 				    unsigned long parent_rate)
 {
-	struct max31335_data *max31335 =3D clk_hw_to_max31335(hw);
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
 	unsigned int freq_mask;
 	int index;
=20
-	index =3D find_closest(rate, max31335_clkout_freq,
-			     ARRAY_SIZE(max31335_clkout_freq));
-	freq_mask =3D __roundup_pow_of_two(ARRAY_SIZE(max31335_clkout_freq)) - =
1;
+	index =3D find_closest(rate, clkout->freq_avail, clkout->freq_size);
+	freq_mask =3D __roundup_pow_of_two(clkout->freq_size) - 1;
=20
-	return regmap_update_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
-				  freq_mask, index);
+	return regmap_update_bits(rtc->regmap, clkout->reg,
+				  freq_mask << clkout->freq_pos,
+				  index << clkout->freq_pos);
 }
=20
-static int max31335_clkout_enable(struct clk_hw *hw)
+static int max313xx_clkout_enable(struct clk_hw *hw)
 {
-	struct max31335_data *max31335 =3D clk_hw_to_max31335(hw);
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
=20
-	return regmap_set_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
-			       MAX31335_RTC_CONFIG2_ENCLKO);
+	if (clkout->en_invert)
+		return regmap_clear_bits(rtc->regmap, clkout->reg,
+					 clkout->en_bit);
+
+	return regmap_set_bits(rtc->regmap, clkout->reg,  clkout->en_bit);
 }
=20
-static void max31335_clkout_disable(struct clk_hw *hw)
+static void max313xx_clkout_disable(struct clk_hw *hw)
 {
-	struct max31335_data *max31335 =3D clk_hw_to_max31335(hw);
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
=20
-	regmap_clear_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
-			  MAX31335_RTC_CONFIG2_ENCLKO);
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
 }
=20
-static int max31335_clkout_is_enabled(struct clk_hw *hw)
+static int max313xx_clkout_is_enabled(struct clk_hw *hw)
 {
-	struct max31335_data *max31335 =3D clk_hw_to_max31335(hw);
+	struct max313xx *rtc =3D clk_hw_to_max313xx(hw);
+	struct clkout_cfg *clkout =3D rtc->chip->clkout;
 	unsigned int reg;
 	int ret;
=20
-	ret =3D regmap_read(max31335->regmap, MAX31335_RTC_CONFIG2, &reg);
+	ret =3D regmap_read(rtc->regmap, clkout->reg, &reg);
 	if (ret)
 		return ret;
=20
-	return !!(reg & MAX31335_RTC_CONFIG2_ENCLKO);
+	return !!(reg & clkout->en_bit) ^ clkout->en_invert;
 }
=20
-static const struct clk_ops max31335_clkout_ops =3D {
-	.recalc_rate =3D max31335_clkout_recalc_rate,
-	.round_rate =3D max31335_clkout_round_rate,
-	.set_rate =3D max31335_clkout_set_rate,
-	.enable =3D max31335_clkout_enable,
-	.disable =3D max31335_clkout_disable,
-	.is_enabled =3D max31335_clkout_is_enabled,
+static const struct clk_ops max313xx_clkout_ops =3D {
+	.recalc_rate =3D max313xx_clkout_recalc_rate,
+	.round_rate =3D max313xx_clkout_round_rate,
+	.set_rate =3D max313xx_clkout_set_rate,
+	.enable =3D max313xx_clkout_enable,
+	.disable =3D max313xx_clkout_disable,
+	.is_enabled =3D max313xx_clkout_is_enabled,
 };
=20
-static struct clk_init_data max31335_clk_init =3D {
-	.name =3D "max31335-clkout",
-	.ops =3D &max31335_clkout_ops,
+struct clk_init_data max313xx_clk_init =3D {
+	.name =3D "max313xx-clkout",
+	.ops =3D &max313xx_clkout_ops,
 };
=20
-static int max31335_nvmem_reg_read(void *priv, unsigned int offset,
+static int max313xx_nvmem_reg_read(void *priv, unsigned int offset,
 				   void *val, size_t bytes)
 {
-	struct max31335_data *max31335 =3D priv;
-	unsigned int reg =3D MAX31335_TS0_SEC_1_128 + offset;
+	struct max313xx *rtc =3D priv;
+	unsigned int reg =3D rtc->chip->ram_reg + offset;
=20
-	return regmap_bulk_read(max31335->regmap, reg, val, bytes);
+	return regmap_bulk_read(rtc->regmap, reg, val, bytes);
 }
=20
-static int max31335_nvmem_reg_write(void *priv, unsigned int offset,
+static int max313xx_nvmem_reg_write(void *priv, unsigned int offset,
 				    void *val, size_t bytes)
 {
-	struct max31335_data *max31335 =3D priv;
-	unsigned int reg =3D MAX31335_TS0_SEC_1_128 + offset;
+	struct max313xx *rtc =3D priv;
+	unsigned int reg =3D rtc->chip->ram_reg + offset;
=20
-	return regmap_bulk_write(max31335->regmap, reg, val, bytes);
+	return regmap_bulk_write(rtc->regmap, reg, val, bytes);
 }
=20
-static struct nvmem_config max31335_nvmem_cfg =3D {
-	.reg_read =3D max31335_nvmem_reg_read,
-	.reg_write =3D max31335_nvmem_reg_write,
+struct nvmem_config max313xx_nvmem_cfg =3D {
+	.reg_read =3D max313xx_nvmem_reg_read,
+	.reg_write =3D max313xx_nvmem_reg_write,
 	.word_size =3D 8,
-	.size =3D MAX31335_RAM_SIZE,
 };
=20
 #if IS_REACHABLE(HWMON)
-static int max31335_read_temp(struct device *dev, enum hwmon_sensor_type=
s type,
+static int max313xx_read_temp(struct device *dev, enum hwmon_sensor_type=
s type,
 			      u32 attr, int channel, long *val)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
+	struct max313xx *rtc =3D dev_get_drvdata(dev);
 	u8 reg[2];
 	s16 temp;
 	int ret;
@@ -533,8 +765,7 @@ static int max31335_read_temp(struct device *dev, enu=
m hwmon_sensor_types type,
 	if (type !=3D hwmon_temp || attr !=3D hwmon_temp_input)
 		return -EOPNOTSUPP;
=20
-	ret =3D regmap_bulk_read(max31335->regmap, MAX31335_TEMP_DATA_MSB,
-			       reg, 2);
+	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->temp_reg, reg, 2);
 	if (ret)
 		return ret;
=20
@@ -545,7 +776,7 @@ static int max31335_read_temp(struct device *dev, enu=
m hwmon_sensor_types type,
 	return 0;
 }
=20
-static umode_t max31335_is_visible(const void *data,
+static umode_t max313xx_is_visible(const void *data,
 				   enum hwmon_sensor_types type,
 				   u32 attr, int channel)
 {
@@ -555,143 +786,338 @@ static umode_t max31335_is_visible(const void *da=
ta,
 	return 0;
 }
=20
-static const struct hwmon_channel_info *max31335_info[] =3D {
+static const struct hwmon_channel_info *max313xx_info[] =3D {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
 	NULL
 };
=20
-static const struct hwmon_ops max31335_hwmon_ops =3D {
-	.is_visible =3D max31335_is_visible,
-	.read =3D max31335_read_temp,
+static const struct hwmon_ops max313xx_hwmon_ops =3D {
+	.is_visible =3D max313xx_is_visible,
+	.read =3D max313xx_read_temp,
 };
=20
-static const struct hwmon_chip_info max31335_chip_info =3D {
-	.ops =3D &max31335_hwmon_ops,
-	.info =3D max31335_info,
+static const struct hwmon_chip_info max313xx_chip_info =3D {
+	.ops =3D &max313xx_hwmon_ops,
+	.info =3D max313xx_info,
 };
 #endif
=20
-static int max31335_clkout_register(struct device *dev)
+static int max313xx_init(struct max313xx *rtc)
 {
-	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
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
 	int ret;
=20
 	if (!device_property_present(dev, "#clock-cells"))
-		return regmap_clear_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
-					 MAX31335_RTC_CONFIG2_ENCLKO);
+		return 0;
=20
-	max31335->clkout.init =3D &max31335_clk_init;
+	max313xx_clk_init.name =3D rtc->chip->clkout_name;
+	device_property_read_string(dev, "clock-output-names",
+				    &max313xx_clk_init.name);
+	rtc->clkout.init =3D &max313xx_clk_init;
=20
-	ret =3D devm_clk_hw_register(dev, &max31335->clkout);
+	ret =3D devm_clk_hw_register(dev, &rtc->clkout);
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot register clock\n");
=20
-	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
-					  &max31335->clkout);
-	if (ret)
-		return dev_err_probe(dev, ret, "cannot add hw provider\n");
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &rtc->clkout);
+}
=20
-	max31335->clkout.clk =3D devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(max31335->clkout.clk))
-		return dev_err_probe(dev, PTR_ERR(max31335->clkout.clk),
-				     "cannot enable clkout\n");
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
=20
 	return 0;
 }
=20
-static int max31335_probe(struct i2c_client *client)
+static int max313xx_probe(struct i2c_client *client)
 {
-	struct max31335_data *max31335;
+	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
+	struct device *dev =3D &client->dev;
+	struct max313xx *max313xx;
 #if IS_REACHABLE(HWMON)
 	struct device *hwmon;
 #endif
+	const void *match;
 	int ret;
=20
-	max31335 =3D devm_kzalloc(&client->dev, sizeof(*max31335), GFP_KERNEL);
-	if (!max31335)
+	max313xx =3D devm_kzalloc(&client->dev, sizeof(*max313xx), GFP_KERNEL);
+	if (!max313xx)
 		return -ENOMEM;
=20
-	max31335->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
-	if (IS_ERR(max31335->regmap))
-		return PTR_ERR(max31335->regmap);
+	dev_set_drvdata(&client->dev, max313xx);
=20
-	i2c_set_clientdata(client, max31335);
-
-	max31335->rtc =3D devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(max31335->rtc))
-		return PTR_ERR(max31335->rtc);
-
-	max31335->rtc->ops =3D &max31335_rtc_ops;
-	max31335->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
-	max31335->rtc->range_max =3D RTC_TIMESTAMP_END_2199;
-	max31335->rtc->alarm_offset_max =3D 24 * 60 * 60;
-
-	ret =3D max31335_clkout_register(&client->dev);
-	if (ret)
-		return ret;
-
-	if (client->irq > 0) {
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, max31335_handle_irq,
-						IRQF_ONESHOT,
-						"max31335", max31335);
-		if (ret) {
-			dev_warn(&client->dev,
-				 "unable to request IRQ, alarm max31335 disabled\n");
-			client->irq =3D 0;
-		}
+	max313xx->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(max313xx->regmap)) {
+		return dev_err_probe(dev, PTR_ERR(max313xx->regmap),
+				     "regmap init failed\n");
 	}
=20
-	if (!client->irq)
-		clear_bit(RTC_FEATURE_ALARM, max31335->rtc->features);
+	i2c_set_clientdata(client, max313xx);
=20
-	max31335_nvmem_cfg.priv =3D max31335;
-	ret =3D devm_rtc_nvmem_register(max31335->rtc, &max31335_nvmem_cfg);
-	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "cannot register rtc nvmem\n");
+	match =3D device_get_match_data(dev);
+	if (match)
+		max313xx->chip =3D match;
+	else if (id)
+		max313xx->chip =3D (struct chip_desc *)id->driver_data;
+	else
+		return -ENODEV;
=20
-#if IS_REACHABLE(HWMON)
-	hwmon =3D devm_hwmon_device_register_with_info(&client->dev, client->na=
me,
-						     max31335,
-						     &max31335_chip_info,
-						     NULL);
-	if (IS_ERR(hwmon))
-		return dev_err_probe(&client->dev, PTR_ERR(hwmon),
-				     "cannot register hwmon device\n");
-#endif
+	max313xx->id =3D max313xx->chip - chip;
=20
-	ret =3D max31335_trickle_charger_setup(&client->dev, max31335);
+	ret =3D max313xx_init(max313xx);
 	if (ret)
 		return ret;
=20
-	return devm_rtc_register_device(max31335->rtc);
+	max313xx->rtc =3D devm_rtc_allocate_device(dev);
+	if (IS_ERR(max313xx->rtc))
+		return PTR_ERR(max313xx->rtc);
+
+	max313xx->rtc->ops =3D &max3133x_rtc_ops;
+	max313xx->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
+	max313xx->rtc->range_max =3D RTC_TIMESTAMP_END_2199;
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
+	ret =3D max313xx_trickle_charger_setup(dev);
+	if (ret)
+		return ret;
+
+	return devm_rtc_register_device(max313xx->rtc);
 }
=20
-static const struct i2c_device_id max31335_id[] =3D {
-	{ "max31335", 0 },
+static const struct of_device_id max313xx_of_id[] =3D {
+	{ .compatible =3D "adi,max31328", .data =3D &chip[ID_MAX31328] },
+	{ .compatible =3D "adi,max31329", .data =3D &chip[ID_MAX31329] },
+	{ .compatible =3D "adi,max31331", .data =3D &chip[ID_MAX31331] },
+	{ .compatible =3D "adi,max31334", .data =3D &chip[ID_MAX31334] },
+	{ .compatible =3D "adi,max31335", .data =3D &chip[ID_MAX31335] },
+	{ .compatible =3D "adi,max31341", .data =3D &chip[ID_MAX31341] },
+	{ .compatible =3D "adi,max31342", .data =3D &chip[ID_MAX31342] },
+	{ .compatible =3D "adi,max31343", .data =3D &chip[ID_MAX31343] },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, max313xx_of_id);
=20
-MODULE_DEVICE_TABLE(i2c, max31335_id);
-
-static const struct of_device_id max31335_of_match[] =3D {
-	{ .compatible =3D "adi,max31335" },
+static const struct i2c_device_id max313xx_id[] =3D {
+	{ "max31328", (kernel_ulong_t)&chip[ID_MAX31328] },
+	{ "max31329", (kernel_ulong_t)&chip[ID_MAX31329] },
+	{ "max31331", (kernel_ulong_t)&chip[ID_MAX31331] },
+	{ "max31334", (kernel_ulong_t)&chip[ID_MAX31334] },
+	{ "max31335", (kernel_ulong_t)&chip[ID_MAX31335] },
+	{ "max31341", (kernel_ulong_t)&chip[ID_MAX31341] },
+	{ "max31342", (kernel_ulong_t)&chip[ID_MAX31342] },
+	{ "max31343", (kernel_ulong_t)&chip[ID_MAX31343] },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, max313xx_id);
=20
-MODULE_DEVICE_TABLE(of, max31335_of_match);
-
-static struct i2c_driver max31335_driver =3D {
+static struct i2c_driver max313xx_driver =3D {
 	.driver =3D {
-		.name =3D "rtc-max31335",
-		.of_match_table =3D max31335_of_match,
+		.name	=3D "rtc-max31335",
+		.of_match_table =3D max313xx_of_id,
 	},
-	.probe =3D max31335_probe,
-	.id_table =3D max31335_id,
+	.probe		=3D max313xx_probe,
+	.id_table	=3D max313xx_id,
 };
-module_i2c_driver(max31335_driver);
+module_i2c_driver(max313xx_driver);
=20
 MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
-MODULE_DESCRIPTION("MAX31335 RTC driver");
+MODULE_AUTHOR("Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>");
+MODULE_AUTHOR("Ibrahim Tilki <Ibrahim.Tilki@analog.com>");
+MODULE_DESCRIPTION("MAX313XX RTC driver");
+MODULE_SOFTDEP("pre: regmap-i2c");
 MODULE_LICENSE("GPL");
--=20
2.43.2


