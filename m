Return-Path: <linux-kernel+bounces-12747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5A081F995
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A706F1F24245
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8510781;
	Thu, 28 Dec 2023 15:16:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA95101CA;
	Thu, 28 Dec 2023 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEFxh2UKvJCAAa/kzKp1XMrGQXFseukYhED10rQSHHBoqT+YYUdRn0qobX6onDi6T/qhq/WIIrzwSTRVtL+HWUOi1ZEebsr5wJ+rZSLNdQ4eenbwgS2Tax1njMJNJBh4ESdI6bRA7U6y1wvoU7JS0OJWjHWFTRqHRD3w7t0tITrWmevamMVwTphi7CpAML9AWXXcIzPrYHA/GbcONY823rkqgwmYyAjT9XqdBq13qNf/JewBJnix8c9tgdcrAcwRGM1dWRvQik8hzLB1yLtXPN/VcnhPaWt81ldApHxshxXFhlMiQ3SQtZRtil0ExeJMujIIe5K8N1sTueNwDRCTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFIRk9wClPM6tKzCBtbJ4YgDZ54aAVyda+ezhHJ1hXc=;
 b=FhU75dtl0Z1k2NScO5oxxwnKUB+EP5PXoSd6QWH+3qPG0Cuz/GZC+UIKS56m95e5QwrdQNwSsYR6G0GR9hGOdP/H4axoyV+Vq1Z0ydLcZdRl+hiHGaAOPxkShnXj62V1ZXSuUu5V287wb+6gdU9FtLtjGR+mUACI/HCPxy9NlpdABR2Yn7BKdzZ0fb1clvqNEwdPF0Q823H7HfN9XKerKd+37PR3RhKBB08A14cEaKXF5SZ9bC3CReNYIL1Yo601Duj6jhsVbfPbWQW1g+vDT4b4a+Wc8qdptchtZ/fE8kGZFeikkl5q/TnFJpZ9LP5pIwWU/z7GjDInsyuI0DihIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6650.apcprd06.prod.outlook.com (2603:1096:820:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 15:16:25 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 15:16:25 +0000
From: "larry.lai" <larry.lai@yunjingtech.com>
To: lee@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	pavel@ucw.cz,
	krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	GaryWang@aaeon.com.tw,
	musa.lin@yunjingtech.com,
	jack.chang@yunjingtech.com,
	noah.hung@yunjingtech.com,
	"larry.lai" <larry.lai@yunjingtech.com>,
	Gary Wang <garywang@aaeon.com.tw>
Subject: [PATCH V8 3/3] leds: Add support for UP board CPLD onboard LEDS
Date: Thu, 28 Dec 2023 23:15:44 +0800
Message-Id: <20231228151544.14408-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231228151544.14408-1-larry.lai@yunjingtech.com>
References: <20231228151544.14408-1-larry.lai@yunjingtech.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|KL1PR06MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: de33075a-222e-48a2-3608-08dc07b7f53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PLgf7UWrrW5obAaDwqHs8MvrQ6BpNz2SKn4xzX3R1cLAozjS5uoewZKvmckTpw4dQnuSNY/zEH8EJCO82NEDwFkA78dDB3UiMy67fbG2o8Brrj7fBI+ocLWChE2Z3EhME2V3EyZtVDqvDKgJPz4nQCzBOOtw8ADSv08GvTUq4uqobKqY5p6rCpQxTIlgK2q3wHKpwaO6AsvjqF8XUgBHXK7S1zJV0q1XrR0SNOwmPv+QSSwK6yPDdhO8l/zXvROTkayFXE5brd+wkHmXBcfCqTbzAGGU3CySSDpLxMHl3O5ILnfsnS9HhYaP1KXMhNaRlPkHK3D6qHKm9XIb7Km7ri+ebP3p69/pWk3IvKoiqglnWycQpbgLdsOlSfIgSwKjDk0Y/GdE4M3sMkcfkZxXlZBLH1gXf/Q0JN8i0uq5uQIuGqv6hK88XeJaG/TxFhZLfZ/exPwy0DC+5VZDWiP3/tkGh6L8BzK7QvVyH9ZOAZFfEzCUAXOy9/WTgqcreUQYFddfSBOE6bsQo1clUgERghdAx2uJcPU+GWwF4WH2f38UZX+zfquo7HYoS42U5qwk0oqeQX+BCmYHdYNydCGPVTJiMcL4pQDO9ussf0PFvfFBEJrZDTYu6fDV+gDmL4DNBKo82Tl5e48OL+6fTms5kH7OV5tiSfBVfGrZtW3RmRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(86362001)(2906002)(38100700002)(36756003)(41300700001)(66946007)(54906003)(66476007)(316002)(66556008)(83380400001)(6486002)(6506007)(52116002)(1076003)(26005)(478600001)(2616005)(6666004)(5660300002)(4326008)(8936002)(8676002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?btLgs/z/Z7oZAdTf67vRHDRKA/mcSdQHrgUWKzU1t/wvLBWVQxWk/N69wRtX?=
 =?us-ascii?Q?w/Z5YIXt14AXyYxUgTBCPoqBsMvzwyccGlXj8cKJ2aDZzfaAxevUX4VuMn0c?=
 =?us-ascii?Q?h0OOR6Drwvgruvf71z+mSDtLP2uNxZmkf37hFUOTYU+JSqzqnfH45txBFmfV?=
 =?us-ascii?Q?Heci/eI+GYXMgY2PfL4q3dXqQyV6l5mW9B/6Aljzi0nZ8Vortwg8AM8u/3nV?=
 =?us-ascii?Q?BpT0lQOP2F37MzUaI/qFm4WZqliBUscYJol/Xn61BiCfsp7SOfvOsFmkey1B?=
 =?us-ascii?Q?Nb+rMDDj7Pd/713rhGws+6xBKqwJBES5ckTRkZPG9lkzTYBIvim1oA/DQ4Em?=
 =?us-ascii?Q?eebzcqSW7zrWIG+yb/JQWVK9xEjNrjVCS6dpe0+xhGZrF/c35Yml0AtooUit?=
 =?us-ascii?Q?McdPqx6PQ5xXOJMGH+PZkroaFCWgEIObJOZsg96DxiFDLmbr21AI7pCPlljg?=
 =?us-ascii?Q?uTjdw0qgMv8z8z/b3WEW4HRLPW83SxjMejuo3xKwDdye4AoEANQmVmeF9Q1Z?=
 =?us-ascii?Q?qh8Q0QseqImsgeC+jnlG8IoBsZV1ZzmzWddSZw2b1FN4t/FMcpZ4x810Q9rb?=
 =?us-ascii?Q?bff1eSRUGVluDMuaMBB7Sm5eKDyqNO9ud302koziCQ6onXgRCkLIa+g4SdV4?=
 =?us-ascii?Q?IeQZiRttw2Y2551+/UXy17a0KuWG36ttmoaXStWIxjicX4o6GxhuOzQHu8NE?=
 =?us-ascii?Q?f5w3/4QhP2jIoh+U8aen4xdoaClTacRMkJTqR1u5lqNXIFZhldYS/eQepkp8?=
 =?us-ascii?Q?bEOV5gyZn99eZzPNuvqP5SzwDnsASQ0Th/e6NioMaI27yK5bNI2CD52TKybI?=
 =?us-ascii?Q?5sbcIRCeDabMRkR3P1wJrbkIFHR9EwWAxxxNORYL+jWew9MPNdRDM2W1Y2Or?=
 =?us-ascii?Q?xHFCmDemWg85QL4go0qs/4f3NCF4rF5n8qZxS0elcJq93DAtT4NmqHsAvRUp?=
 =?us-ascii?Q?McRlTwIHjaaPXnY3gcl1kDO8B5GR6zsDx40osf2qhCHqmObeGPBkv218yM6f?=
 =?us-ascii?Q?wy6lhywSFwaBE+8lTSlE1l0tCm4IaRURGSRc3sjkx1CdsyczZDN80PeiyaAS?=
 =?us-ascii?Q?skObNIFTLdIuoeOe+pXv6aZ86NiAccx+21FTaKeMQWpQV55lBhFtRUkg8Vx7?=
 =?us-ascii?Q?F/IqiigS9AoyQJ61qFbByMj9rMOKb63pqpXZil9UtBqgpWWtl7IPRZS+dEl1?=
 =?us-ascii?Q?v+psX/dEvTWOLw4RdBGmzaL46vxaQCaXxlDnJK8rb0Kmi0HpcSF7UVrkHiog?=
 =?us-ascii?Q?rCdJ7CoVLLT1JqZgCBP5ZD0RpGv5tgkzSHZuU1T1385YWlzZh7Mp6Efo63B8?=
 =?us-ascii?Q?Pd6/5M8375ca+cKNBfVaHFL4D92FFo7nemyqpPVBLefCynwq7MY3qev6vhH8?=
 =?us-ascii?Q?Ygy7hm3eLhjK42Th8e7HYm6VWxn8SXfnM2K+AQCSOuIJbwhp7rrobuqCJb1v?=
 =?us-ascii?Q?4x4d6ZqiouXTtOgG8ZZgha2POnnuVpE4PzQ2xIlCXvuxPX2VMeBRCkhvr1z4?=
 =?us-ascii?Q?LAqi1g97/e62Co/nQ8cYKomKmST15tOwIcJgsKnwY5FjhZtBt1VmdkhF/Xwl?=
 =?us-ascii?Q?bnFXfBC4dsRsgwafJ2PGvNFENFF+XOYzjN2GlXIPd5n/fsKuU61hNA67vYPG?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de33075a-222e-48a2-3608-08dc07b7f53a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 15:16:25.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nkobwr2g1TQthVBXumGveoD3X0tIXMoI96sGaIVrYBOwpCrdn0cZ01O28dEMKTql8coqZHazR3/BjnnvZphsN+8NaN6lKz6ica+x/noMEaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6650

The UP boards come with a few FPGA-controlled onboard LEDs:
* UP Board: yellow, green, red
* UP Squared: blue, yellow, green, red

Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
PATCH V7 -> PATCH V8
(1) Refer 2023/11/01 Krzysztof Kozlowski review, cleaned up coding style
and addressed review comments.
PATCH V6 --> PATCH V7: cleaned up coding style and addressed review
comments.
PATCH V4 -> PATCH V6 : There is no change.
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 --> RFC 2023/04/25: Refer 2022/12/08 Lee Jones review,
cleaned up coding style.
PATCH V3 -> RFC 2022/11/23: Update the changes Copyright.
PATCH V1 -> V3: There is no change.
PATCH --> PATCH V1: Refer 2022/10/03 Andy Shevchenko review, cleaned up
coding style.
---
 drivers/leds/Kconfig        |  10 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-upboard.c | 154 ++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..80b9c394c5b6 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -872,6 +872,16 @@ source "drivers/leds/flash/Kconfig"
 comment "RGB LED drivers"
 source "drivers/leds/rgb/Kconfig"
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP board"
+	depends on LEDS_CLASS
+	depends on MFD_UPBOARD_FPGA
+	help
+	  This option enables support for the UP board LEDs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-upboard.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..e72956645646 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= leds-ti-lmu-common.o
 obj-$(CONFIG_LEDS_TLC591XX)		+= leds-tlc591xx.o
 obj-$(CONFIG_LEDS_TPS6105X)		+= leds-tps6105x.o
 obj-$(CONFIG_LEDS_TURRIS_OMNIA)		+= leds-turris-omnia.o
+obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
new file mode 100644
index 000000000000..61164402926e
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board CPLD/GPIO based LED driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_led {
+	struct regmap_field *field;
+	struct led_classdev cdev;
+	unsigned char bit;
+};
+
+static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+	int brightness = 0;
+
+	regmap_field_read(led->field, &brightness);
+
+	return brightness;
+};
+
+static void upboard_led_brightness_set(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+
+	regmap_field_write(led->field, brightness != LED_OFF);
+};
+
+static struct gpio_led_platform_data upboard_gpio_led_pd;
+static const struct mfd_cell upboard_gpio_led_cells[] = {
+	MFD_CELL_BASIC("leds-gpio", NULL,
+		       &upboard_gpio_led_pd,
+		       sizeof(upboard_gpio_led_pd), 0)
+};
+
+static int upboard_led_gpio_register(struct upboard_fpga *fpga)
+{
+	struct gpio_led blue_led, yellow_led, green_led, red_led;
+	struct gpio_desc *desc;
+	static struct gpio_led leds[4];
+	int num_leds = 0;
+	int ret;
+
+	desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		blue_led.name = "upboard:blue:";
+		blue_led.gpio = desc_to_gpio(desc);
+		blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = blue_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		yellow_led.name = "upboard:yellow:";
+		yellow_led.gpio = desc_to_gpio(desc);
+		yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = yellow_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		green_led.name = "upboard:green:";
+		green_led.gpio = desc_to_gpio(desc);
+		green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = green_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
+	if (!IS_ERR(desc)) {
+		red_led.name = "upboard:red:";
+		red_led.gpio = desc_to_gpio(desc);
+		red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+		leds[num_leds++] = red_led;
+		devm_gpiod_put(fpga->dev, desc);
+	}
+
+	/* No optional LEDs defined */
+	if (num_leds == 0)
+		return -ENODEV;
+
+	upboard_gpio_led_pd.num_leds = num_leds;
+	upboard_gpio_led_pd.leds = leds;
+
+	ret = devm_mfd_add_devices(fpga->dev, PLATFORM_DEVID_AUTO,
+				   upboard_gpio_led_cells,
+				   ARRAY_SIZE(upboard_gpio_led_cells),
+				   NULL, 0, NULL);
+	if (ret) {
+		dev_err(fpga->dev, "Failed to add GPIO LEDs, %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int upboard_led_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const cpld = dev_get_drvdata(pdev->dev.parent);
+	struct reg_field fldconf = {
+		.reg = UPFPGA_REG_FUNC_EN0,
+	};
+	struct upboard_led_data * const pdata = pdev->dev.platform_data;
+	struct upboard_led *led;
+
+	/* check & register GPIO LEDs */
+	if (strstr(pdata->colour, "gpio"))
+		return upboard_led_gpio_register(cpld);
+
+	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	fldconf.lsb = pdata->bit;
+	fldconf.msb = pdata->bit;
+	led->field = devm_regmap_field_alloc(&pdev->dev, cpld->regmap, fldconf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:", pdata->colour);
+	if (!led->cdev.name)
+		return -ENOMEM;
+
+	return devm_led_classdev_register(&pdev->dev, &led->cdev);
+};
+
+static struct platform_driver upboard_led_driver = {
+	.driver = {
+		.name = "upboard-led",
+	},
+};
+module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-led");
-- 
2.17.1


