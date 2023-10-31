Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E447DC6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjJaHBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjJaHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:01:20 -0400
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 00:01:16 PDT
Received: from mx0b-002bf204.pphosted.com (mx0b-002bf204.pphosted.com [205.220.172.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D0BB;
        Tue, 31 Oct 2023 00:01:16 -0700 (PDT)
Received: from pps.filterd (m0207525.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V3vDVI029443;
        Tue, 31 Oct 2023 00:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :content-type:content-transfer-encoding:mime-version; s=pps1;
         bh=/BAjpaJkIrHpD/gb2GQdHuOIg9AmU8vqrDGNL+7f80E=; b=JFBGSsosLlsq
        o4SDv1lZYXEu2DyCvjZwqus34b+T7nRSDu4wiUzLC2nINfIsOiXgjYOf93d8B24F
        SF4eUgw5440op3qRISxn2WoT4CGh1C3Bd6QFEn0CCIFz4cZnBvlCwtLGiaMX2OZ2
        ahdcdrtLXMl+aSv7T1sDM+9EbCWX7RGLueaQYg+MNEgjhE8wGaOLT7sej50XFAZs
        EPwnIvZTCqSU6KQ/XUcZSAHInskjtdHHZ3IxNL7l+ZBrHaJMYLIcYbrJA/oZtV/N
        IoVWhf7WdM1mtq2WP6yJB6oaaQt/sFc7llmLTgU23AH0LRan2Q9yfSOPdyHEjGbp
        cqK0tXPVnw==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3u0xyyup3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Oct 2023 00:01:07 -0700 (PDT)
Received: from CD-MSH02.monolithicpower.com (10.10.70.19) by
 MPS-MSH03.monolithicpower.com (10.10.10.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 31 Oct 2023 00:01:05 -0700
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 CD-MSH02.monolithicpower.com (10.10.70.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 31 Oct 2023 15:01:03 +0800
Received: from CD-MSH04.monolithicpower.com ([fe80::69c9:32c5:3392:58d]) by
 CD-MSH04.monolithicpower.com ([fe80::69c9:32c5:3392:58d%2]) with mapi id
 15.01.2242.004; Tue, 31 Oct 2023 15:01:02 +0800
From:   "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
Subject: [PATCH 2/2] leds: add mp3326 driver
Thread-Topic: [PATCH 2/2] leds: add mp3326 driver
Thread-Index: AdoLx+b9ERoaSp5CSa+Oy18KCe3oTg==
Date:   Tue, 31 Oct 2023 07:01:02 +0000
Message-ID: <ab9663a6b41e4bd7b347f51f72f5c4a1@monolithicpower.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.84.127]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-GUID: 33HCEIRAiY7z9xkc8IpSfQW6KXoeTb4A
X-Proofpoint-ORIG-GUID: 33HCEIRAiY7z9xkc8IpSfQW6KXoeTb4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310240000
 definitions=main-2310310053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds mp3326 led driver.

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
---
 drivers/leds/Kconfig       |   7 +
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-mp3326.c | 632 +++++++++++++++++++++++++++++++++++++
 3 files changed, 640 insertions(+)
 create mode 100644 drivers/leds/leds-mp3326.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b92208eccdea..ac8115bffc2e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -260,6 +260,13 @@ config LEDS_MIKROTIK_RB532
 	  This option enables support for the so called "User LED" of
 	  Mikrotik's Routerboard 532.
=20
+config LEDS_MP3326
+	tristate "LED Support for MPS MP3326"
+	depends on LEDS_CLASS
+	help
+	  This option enables support for on-chip LED drivers found on
+	  MPS MP3326.
+
 config LEDS_MT6323
 	tristate "LED Support for Mediatek MT6323 PMIC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d7348e8bc019..196befb56278 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_LEDS_MENF21BMC)		+=3D leds-menf21bmc.o
 obj-$(CONFIG_LEDS_MIKROTIK_RB532)	+=3D leds-rb532.o
 obj-$(CONFIG_LEDS_MLXCPLD)		+=3D leds-mlxcpld.o
 obj-$(CONFIG_LEDS_MLXREG)		+=3D leds-mlxreg.o
+obj-$(CONFIG_LEDS_MP3326)		+=3D leds-mp3326.o
 obj-$(CONFIG_LEDS_MT6323)		+=3D leds-mt6323.o
 obj-$(CONFIG_LEDS_NET48XX)		+=3D leds-net48xx.o
 obj-$(CONFIG_LEDS_NETXBIG)		+=3D leds-netxbig.o
diff --git a/drivers/leds/leds-mp3326.c b/drivers/leds/leds-mp3326.c
new file mode 100644
index 000000000000..140c71b334f7
--- /dev/null
+++ b/drivers/leds/leds-mp3326.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MP3326 Led driver
+ *
+ * Copyright 2023 Monolithic Power Systems, Inc
+ *
+ * Author: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+ */
+#include <linux/bits.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/leds.h>
+#include <linux/device.h>
+#include <linux/led-class-multicolor.h>
+
+#define MP3326_PWM_DIM_FREQUENCY_CONFIG			0x00
+#define MP3326_PWM_CTRL							0x01
+#define MP3326_PWM_DIM_FREQUENCY_CONFIG			0x00
+#define MP3326_PWM_CTRL_CHANNEL_9_16			0x04
+#define MP3326_PWM_CTRL_CHANNEL_1_8				0x05
+#define MP3326_PWM_OPEN_FAULT_CHANNEL_9_16		0x06
+#define MP3326_PWM_OPEN_FAULT_CHANNEL_1_8		0x07
+#define MP3326_PWM_SHORT_FAULT_CHANNEL_9_16		0x08
+#define MP3326_PWM_SHORT_FAULT_CHANNEL_1_8		0x09
+#define MP3326_PWM_CURRENT_SET_CHANNEL1			0x0A
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL1		0x0B
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL1		0x0C
+#define MP3326_PWM_CURRENT_SET_CHANNEL2			0x0D
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL2		0x0E
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL2		0x0F
+#define MP3326_PWM_CURRENT_SET_CHANNEL3			0x10
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL3		0x11
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL3		0x12
+#define MP3326_PWM_CURRENT_SET_CHANNEL4			0x13
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL4		0x14
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL4		0x15
+#define MP3326_PWM_CURRENT_SET_CHANNEL5			0x16
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL5		0x17
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL5		0x18
+#define MP3326_PWM_CURRENT_SET_CHANNEL6			0x19
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL6		0x1A
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL6		0x1B
+#define MP3326_PWM_CURRENT_SET_CHANNEL7			0x1C
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL7		0x1D
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL7		0x1E
+#define MP3326_PWM_CURRENT_SET_CHANNEL8			0x1F
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL8		0x20
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL8		0x21
+#define MP3326_PWM_CURRENT_SET_CHANNEL9			0x22
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL9		0x23
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL9		0x24
+#define MP3326_PWM_CURRENT_SET_CHANNEL10		0x25
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL10		0x26
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL10		0x27
+#define MP3326_PWM_CURRENT_SET_CHANNEL11		0x28
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL11		0x29
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL11		0x2A
+#define MP3326_PWM_CURRENT_SET_CHANNEL12		0x2B
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL12		0x2C
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL12		0x2D
+#define MP3326_PWM_CURRENT_SET_CHANNEL13		0x2E
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL13		0x2F
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL13		0x30
+#define MP3326_PWM_CURRENT_SET_CHANNEL14		0x31
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL14		0x32
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL14		0x33
+#define MP3326_PWM_CURRENT_SET_CHANNEL15		0x34
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL15		0x35
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL15		0x36
+#define MP3326_PWM_CURRENT_SET_CHANNEL16		0x37
+#define MP3326_PWM_DUTY_LSB_SET_CHANNEL16		0x38
+#define MP3326_PWM_DUTY_MSB_SET_CHANNEL16		0x39
+#define MAX_BRIGHTNESS	63
+
+enum led_ctrl {
+	ENABLE =3D 0,
+	BRIGHTNESS,
+	COLOR_L4,
+	COLOR_H8,
+	OPEN_FAULT,
+	SHORT_FAULT,
+	Max_CTRL,
+};
+
+enum mp3326_channel {
+	Channel1,
+	Channel2,
+	Channel3,
+	Channel4,
+	Channel5,
+	Channel6,
+	Channel7,
+	Channel8,
+	Channel9,
+	Channel10,
+	Channel11,
+	Channel12,
+	Channel13,
+	Channel14,
+	Channel15,
+	Channel16,
+	Max_Channel,
+};
+
+#define MP3326_Reg_Connect_Inner(prefix, range)	prefix##range
+#define MP3326_Reg_Connect(prefix, range)		MP3326_Reg_Connect_Inner(prefix=
, range)
+#define MP3326_Reg_Field(reg, minbit, maxbit)	REG_FIELD(reg, minbit, maxbi=
t)
+#define Range1(a, b) MP3326_Reg_Connect_Inner(a, b)
+#define Range2(a, b) MP3326_Reg_Connect_Inner(a, b)
+
+#define MP3326_Channel_FIELD(bit, num, range) { \
+	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_CTRL_CHANNEL_, range), bit=
, bit),	\
+	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_CURRENT_SET_CHANNEL, num),=
 0, 5),	\
+	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_DUTY_LSB_SET_CHANNEL, num)=
, 0, 3),	\
+	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_DUTY_MSB_SET_CHANNEL, num)=
, 0, 7),	\
+	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_OPEN_FAULT_CHANNEL_, range=
), bit, bit),	\
+	MP3326_Reg_Field(MP3326_Reg_Connect(MP3326_PWM_SHORT_FAULT_CHANNEL_, rang=
e), bit, bit), \
+	}
+struct mp3326_led {
+	struct mp3326 *private_data;
+	struct led_classdev cdev;
+	struct mc_subled *subled_info;
+	int num_colors;
+};
+
+struct mp3326 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct regmap_field *regmap_fields[Max_Channel][Max_CTRL];
+	int num_of_leds;
+	struct mp3326_led leds[];
+};
+
+static const struct regmap_config MP3326_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+};
+
+static const struct reg_field channels_reg_fields[Max_Channel][Max_CTRL] =
=3D {
+	[Channel1] =3D MP3326_Channel_FIELD(0, 1, Range1(1_, 8)),
+	[Channel2] =3D MP3326_Channel_FIELD(1, 2, Range1(1_, 8)),
+	[Channel3] =3D MP3326_Channel_FIELD(2, 3, Range1(1_, 8)),
+	[Channel4] =3D MP3326_Channel_FIELD(3, 4, Range1(1_, 8)),
+	[Channel5] =3D MP3326_Channel_FIELD(4, 5, Range1(1_, 8)),
+	[Channel6] =3D MP3326_Channel_FIELD(5, 6, Range1(1_, 8)),
+	[Channel7] =3D MP3326_Channel_FIELD(6, 7, Range1(1_, 8)),
+	[Channel8] =3D MP3326_Channel_FIELD(7, 8, Range1(1_, 8)),
+	[Channel9] =3D MP3326_Channel_FIELD(0, 9, Range2(9_, 16)),
+	[Channel10] =3D MP3326_Channel_FIELD(1, 10, Range2(9_, 16)),
+	[Channel11] =3D MP3326_Channel_FIELD(2, 11, Range2(9_, 16)),
+	[Channel12] =3D MP3326_Channel_FIELD(3, 12, Range2(9_, 16)),
+	[Channel13] =3D MP3326_Channel_FIELD(4, 13, Range2(9_, 16)),
+	[Channel14] =3D MP3326_Channel_FIELD(5, 14, Range2(9_, 16)),
+	[Channel15] =3D MP3326_Channel_FIELD(6, 15, Range2(9_, 16)),
+	[Channel16] =3D MP3326_Channel_FIELD(7, 16, Range2(9_, 16)),
+};
+
+static int led_brightness_set(struct led_classdev *led_cdev, enum led_brig=
htness brightness)
+{
+	struct mp3326_led *led =3D container_of(led_cdev, struct mp3326_led, cdev=
);
+	struct mp3326 *chip =3D led->private_data;
+	int ret;
+	int i;
+
+	if (brightness > led_cdev->max_brightness)
+		brightness =3D led_cdev->max_brightness;
+	if (brightness < 0)
+		brightness =3D 0;
+	for (i =3D 0; i < led->num_colors; i++) {
+		ret =3D regmap_field_write(
+			chip->regmap_fields[led->subled_info[i].channel][BRIGHTNESS],
+			brightness);
+		if (ret)
+			return ret;
+		led->subled_info[i].brightness =3D brightness;
+	}
+	led_cdev->brightness =3D brightness;
+	return 0;
+}
+
+static ssize_t led_pwm_store(struct device *dev, struct device_attribute *=
attr,
+			 const char *buf, size_t count)
+{
+	struct led_classdev *lcdev =3D dev_get_drvdata(dev);
+	struct mp3326_led *led =3D container_of(lcdev, struct mp3326_led, cdev);
+	struct mp3326 *chip =3D led->private_data;
+	ssize_t ret;
+	int r_val, g_val, b_val;
+	int i;
+
+	ret =3D sscanf(buf, "%i %i %i", &r_val, &g_val, &b_val);
+	if (ret !=3D 3 && ret !=3D 1)
+		return ret;
+	r_val =3D r_val * 4095 / 255 + (r_val * 4095 % 255) / (255 / 2);
+	g_val =3D g_val * 4095 / 255 + (g_val * 4095 % 255) / (255 / 2);
+	b_val =3D b_val * 4095 / 255 + (b_val * 4095 % 255) / (255 / 2);
+	for (i =3D 0; i < led->num_colors; i++) {
+		switch (led->subled_info[i].color_index) {
+		case LED_COLOR_ID_RED:
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4],
+				r_val & 0x0f);
+			if (ret)
+				return ret;
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8],
+				r_val >> 4);
+			if (ret)
+				return ret;
+			break;
+		case LED_COLOR_ID_GREEN:
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4],
+				g_val & 0x0f);
+			if (ret)
+				return ret;
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8],
+				g_val >> 4);
+			if (ret)
+				return ret;
+			break;
+		case LED_COLOR_ID_BLUE:
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4],
+				b_val & 0x0f);
+			if (ret)
+				return ret;
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8],
+				b_val >> 4);
+			if (ret)
+				return ret;
+			break;
+		default:
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4],
+				r_val & 0x0f);
+			if (ret)
+				return ret;
+			ret =3D regmap_field_write(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8],
+				r_val >> 4);
+			if (ret)
+				return ret;
+			break;
+		}
+	}
+	return count;
+}
+
+static ssize_t led_pwm_show(struct device *dev, struct device_attribute *a=
ttr,
+			char *buf)
+{
+	struct led_classdev *lcdev =3D dev_get_drvdata(dev);
+	struct mp3326_led *led =3D container_of(lcdev, struct mp3326_led, cdev);
+	struct mp3326 *chip =3D led->private_data;
+	ssize_t ret;
+	int r_val =3D 0, g_val =3D 0, b_val =3D 0, val;
+	int i;
+
+	for (i =3D 0; i < led->num_colors; i++) {
+		switch (led->subled_info[i].color_index) {
+		case LED_COLOR_ID_RED:
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4], &val);
+			if (ret)
+				return ret;
+			r_val |=3D val;
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8], &val);
+			if (ret)
+				return ret;
+			r_val |=3D val << 4;
+			break;
+		case LED_COLOR_ID_GREEN:
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4], &val);
+			if (ret)
+				return ret;
+			g_val |=3D val;
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8], &val);
+			if (ret)
+				return ret;
+			g_val |=3D val << 4;
+			break;
+		case LED_COLOR_ID_BLUE:
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4], &val);
+			if (ret)
+				return ret;
+			b_val |=3D val;
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8], &val);
+			if (ret)
+				return ret;
+			b_val |=3D val << 4;
+			break;
+		default:
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_L4], &val);
+			if (ret)
+				return ret;
+			r_val |=3D val;
+			ret =3D regmap_field_read(
+				chip->regmap_fields[led->subled_info[i].channel][COLOR_H8], &val);
+			if (ret)
+				return ret;
+			r_val |=3D val << 4;
+			break;
+		}
+	}
+	r_val =3D r_val * 255 / 4095 + (r_val * 255 % 4095) / (4095 / 2);
+	g_val =3D g_val * 255 / 4095 + (g_val * 255 % 4095) / (4095 / 2);
+	b_val =3D b_val * 255 / 4095 + (b_val * 255 % 4095) / (4095 / 2);
+	if (led->num_colors =3D=3D 1)
+		return sysfs_emit(buf, "0x%x\n", r_val);
+	else
+		return sysfs_emit(buf, "0x%x 0x%x 0x%x\n", r_val, g_val, b_val);
+}
+
+static ssize_t led_enable_store(struct device *dev, struct device_attribut=
e *attr,
+			 const char *buf, size_t count)
+{
+	struct led_classdev *lcdev =3D dev_get_drvdata(dev);
+	struct mp3326_led *led =3D container_of(lcdev, struct mp3326_led, cdev);
+	struct mp3326 *chip =3D led->private_data;
+	ssize_t ret;
+	uint val, i;
+
+	ret =3D kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+	for (i =3D 0; i < led->num_colors; i++) {
+		ret =3D regmap_field_write(
+			chip->regmap_fields[led->subled_info[i].channel][BRIGHTNESS],
+			led->subled_info[i].brightness);
+		if (ret)
+			return ret;
+		ret =3D regmap_field_write(
+			chip->regmap_fields[led->subled_info[i].channel][ENABLE], !!val);
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+
+static ssize_t led_enable_show(struct device *dev, struct device_attribute=
 *attr,
+			char *buf)
+{
+	struct led_classdev *lcdev =3D dev_get_drvdata(dev);
+	struct mp3326_led *led =3D container_of(lcdev, struct mp3326_led, cdev);
+	struct mp3326 *chip =3D led->private_data;
+	uint val, rval =3D 0;
+	int i, ret;
+
+	for (i =3D 0; i < led->num_colors; i++) {
+		ret =3D regmap_field_read(
+			chip->regmap_fields[led->subled_info[i].channel][ENABLE], &val);
+
+		rval |=3D val << i;
+		if (ret)
+			return ret;
+	}
+
+	if (rval)
+		return sysfs_emit(buf, "%s\n", "True");
+	else
+		return sysfs_emit(buf, "%s\n", "False");
+}
+
+static ssize_t led_short_fault_show(struct device *dev, struct device_attr=
ibute *attr,
+			char *buf)
+{
+	struct led_classdev *lcdev =3D dev_get_drvdata(dev);
+	struct mp3326_led *led =3D container_of(lcdev, struct mp3326_led, cdev);
+	struct mp3326 *chip =3D led->private_data;
+	uint val, rval =3D 0, i;
+	int ret;
+
+	for (i =3D 0; i < led->num_colors; i++) {
+		ret =3D regmap_field_read(
+			chip->regmap_fields[led->subled_info[i].channel][SHORT_FAULT], &val);
+		rval |=3D val << i;
+		if (ret)
+			return ret;
+	}
+
+	if (rval)
+		return sysfs_emit(buf, "%s\n", "Occur");
+	else
+		return sysfs_emit(buf, "%s\n", "None");
+}
+
+static ssize_t led_open_fault_show(struct device *dev, struct device_attri=
bute *attr,
+			char *buf)
+{
+	struct led_classdev *lcdev =3D dev_get_drvdata(dev);
+	struct mp3326_led *led =3D container_of(lcdev, struct mp3326_led, cdev);
+	struct mp3326 *chip =3D led->private_data;
+	uint val, rval =3D 0, i;
+	int ret;
+
+	for (i =3D 0; i < led->num_colors; i++) {
+		ret =3D regmap_field_read(
+			chip->regmap_fields[led->subled_info[i].channel][OPEN_FAULT], &val);
+		rval |=3D val << i;
+		if (ret)
+			return ret;
+	}
+
+	if (rval)
+		return sysfs_emit(buf, "%s\n", "Occur");
+	else
+		return sysfs_emit(buf, "%s\n", "None");
+}
+
+static DEVICE_ATTR_RW(led_pwm);
+static DEVICE_ATTR_RW(led_enable);
+static DEVICE_ATTR_RO(led_short_fault);
+static DEVICE_ATTR_RO(led_open_fault);
+
+static struct attribute *led_sysfs_attrs[] =3D {
+	&dev_attr_led_pwm.attr,
+	&dev_attr_led_enable.attr,
+	&dev_attr_led_short_fault.attr,
+	&dev_attr_led_open_fault.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(led_sysfs);
+
+static int mp3326_add_led(struct mp3326 *chip, struct device_node *np, int=
 index)
+{
+	struct mp3326_led *led =3D &chip->leds[index];
+	struct mc_subled *info;
+	struct device_node *child;
+	struct led_classdev *cdev;
+	struct led_init_data init_data =3D {};
+	int ret;
+	int i;
+	int count;
+	u32 color =3D 0;
+	u32 reg =3D 0;
+
+	ret =3D of_property_read_u32(np, "color", &color);
+	if (ret) {
+		dev_err(&chip->client->dev, "Miss color in the node\n");
+		return ret;
+	}
+	led->private_data =3D chip;
+	if (color =3D=3D LED_COLOR_ID_RGB) {
+		count =3D of_get_child_count(np);
+		if (count !=3D 3) {
+			dev_err(&chip->client->dev, "RGB must have three node.\n");
+			return -EINVAL;
+		}
+
+		info =3D devm_kcalloc(&chip->client->dev, 3, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		for_each_available_child_of_node(np, child) {
+			ret =3D of_property_read_u32(child, "reg", &reg);
+			if (ret || reg > Max_Channel) {
+				dev_err(&chip->client->dev,
+				"reg must less or equal than %d\n", Max_Channel);
+				return -EINVAL;
+			}
+
+			ret =3D of_property_read_u32(child, "color", &color);
+			if (ret) {
+				dev_err(&chip->client->dev, "color must have value\n");
+				return ret;
+			}
+
+			if (color > 3 || !color) {
+				dev_err(&chip->client->dev,
+				"color must be Red, Green and Blue. The color is %d\n", color);
+				return ret;
+			}
+			info[i].color_index =3D color;
+			info[i].channel =3D reg - 1;
+			info[i].brightness =3D 0;
+			i++;
+		}
+
+		led->subled_info =3D info;
+		led->num_colors =3D 3;
+		cdev =3D &led->cdev;
+		cdev->max_brightness =3D MAX_BRIGHTNESS;
+		cdev->brightness_set_blocking =3D led_brightness_set;
+		cdev->groups =3D led_sysfs_groups;
+		init_data.fwnode =3D &np->fwnode;
+
+		ret =3D devm_led_classdev_register_ext(&chip->client->dev, &led->cdev, &=
init_data);
+
+		if (ret) {
+			dev_err(&chip->client->dev, "Unable register multicolor:%s\n", cdev->na=
me);
+			return ret;
+		}
+	} else {
+		ret =3D of_property_read_u32(np, "reg", &reg);
+		if (ret || reg > Max_Channel) {
+			dev_err(&chip->client->dev,
+			"reg must less or equal than %d\n", Max_Channel);
+			return -EINVAL;
+		}
+		info =3D devm_kcalloc(&chip->client->dev, 1, sizeof(*info), GFP_KERNEL);
+		led->num_colors =3D 1;
+		info[i].color_index =3D LED_COLOR_ID_WHITE;
+		info[i].channel =3D reg - 1;
+		info[i].brightness =3D 0;
+		led->subled_info =3D info;
+		cdev =3D &led->cdev;
+		cdev->max_brightness =3D MAX_BRIGHTNESS;
+		cdev->brightness_set_blocking =3D led_brightness_set;
+		cdev->groups =3D led_sysfs_groups;
+		init_data.fwnode =3D &np->fwnode;
+		ret =3D devm_led_classdev_register_ext(&chip->client->dev, &led->cdev, &=
init_data);
+		if (ret) {
+			dev_err(&chip->client->dev, "Unable register led:%s\n", cdev->name);
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static int mp3326_parse_dt(struct mp3326 *chip)
+{
+	struct device_node *np =3D dev_of_node(&chip->client->dev);
+	struct device_node *child;
+	int ret;
+	int index;
+	int val;
+
+	for_each_available_child_of_node(np, child) {
+		ret =3D mp3326_add_led(chip, child, index);
+		if (ret)
+			return ret;
+		index++;
+	}
+	ret =3D of_property_read_u32(np, "led-protect", &val);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(chip->regmap, 0x01, BIT(4) | BIT(5), val << 4)=
;
+
+	ret =3D regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_9_16, 0);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_1_8, 0);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int mp3326_leds_probe(struct i2c_client *client)
+{
+	struct mp3326 *chip;
+	const struct reg_field *reg_fields;
+	int count, i, j;
+
+	count =3D device_get_child_node_count(&client->dev);
+	if (!count) {
+		return dev_err_probe(&client->dev, -EINVAL,
+				"Incorrect number of leds (%d)", count);
+	}
+	chip =3D devm_kzalloc(&client->dev, struct_size(chip, leds, count), GFP_K=
ERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client =3D client;
+	chip->num_of_leds =3D count;
+	i2c_set_clientdata(client, chip);
+	chip->regmap =3D devm_regmap_init_i2c(client, &MP3326_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
+
+	for (i =3D 0; i < Max_Channel; i++) {
+		reg_fields =3D channels_reg_fields[i];
+		for (j =3D 0; j < Max_CTRL; j++) {
+			chip->regmap_fields[i][j] =3D devm_regmap_field_alloc(&client->dev,
+			chip->regmap, reg_fields[j]);
+			if (IS_ERR(chip->regmap_fields[i][j])) {
+				dev_err(&client->dev,
+				"regmap field alloc fail, channel:%d, item: %d\n", i, j);
+				return PTR_ERR(chip->regmap_fields[i][j]);
+			}
+		}
+	}
+	if (mp3326_parse_dt(chip))
+		return 1;
+	else
+		return 0;
+}
+
+static const struct i2c_device_id mp3326_id[] =3D {
+	{"mp3326", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp3326_id);
+
+static const struct of_device_id mp3326_of_match[] =3D {
+	{ .compatible =3D "mps,mp3326" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp3326_of_match);
+
+static struct i2c_driver mp3326_driver =3D {
+	.probe_new =3D mp3326_leds_probe,
+	.driver =3D {
+			.owner =3D THIS_MODULE,
+			.name =3D "MP3326_led",
+			.of_match_table =3D mp3326_of_match,
+		   },
+	.id_table =3D mp3326_id,
+};
+
+module_i2c_driver(mp3326_driver);
+MODULE_AUTHOR("Yuxi Wang <Yuxi.Wang@monolithicpower.com>");
+MODULE_DESCRIPTION("MPS MP3326 LED driver");
+MODULE_LICENSE("GPL");
--=20
2.25.1

