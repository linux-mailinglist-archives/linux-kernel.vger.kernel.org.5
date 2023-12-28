Return-Path: <linux-kernel+bounces-12745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0081F98E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703D21C21D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FECF51D;
	Thu, 28 Dec 2023 15:16:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F09DF4C;
	Thu, 28 Dec 2023 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKd9Am6X2N8nKDyiujL9zhit/H/NuCp/jSZztfdLu+3U40M/uFU1a+Lp1ZRhhydZuV0N7tblMssjnIhevXD9U3g6Pgp6N6XeflHrH7gwGOjIdfm6bZUcfJQGPmykBvv7933RXoWOs3GB1HicpF+W5p8vts+1q7PxwXlP6gZ67VMHcAkYDvqaRIRF1vgtTfgDwDkj09KUfESNVZbH8/xE/Cfy3gJ/4PybrJUVxiahGW0JJ4KcDst3tnWO+SbbYiMO8IAk3hScLfVpyEBX0/Zf8EfqcdpyIUoKJd7WIKn8dO//M6O7SyOM8jl1VXvAl0S3MgMh+yZSDZHSciMYQO/+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAcmYvLBZxnXY0EJukamCZSpBHFwkOuiAsawPPFGdFk=;
 b=XA34uwGNO+84RUlyY7F4gQ6/NED5sT2UqmDR866qzvuMsAdnr3OY7OCu+noA8VLB4OndS/poOZFPWdiGOEJwfjmW7QFzdl72MXqAHlslG0Xk+/B7Gtb7PCHSEDn+Bf+yd5p8UuvTh8uBSkyjYY4TVQT6FDfkHapXw2DLbbNhl8ZAXv/iJrsXIzH5AvoLGtHbbmZMn7b4eCB+Bw/dCLHCLampfLB/BL16j3T75ekngcFeXZNP2LJ7XqEf/9sYSfnG2o1Vv3xpLo62770+8PGqO5bsPW7Q06CMfdYDxbYI3Y/7HhAI4wKdVxA0oWt1ZBb+tla11LBGHJk02ViT55Y1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6650.apcprd06.prod.outlook.com (2603:1096:820:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 15:16:17 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 15:16:16 +0000
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
Subject: [PATCH V8 1/3] mfd: Add support for UP board CPLD/FPGA
Date: Thu, 28 Dec 2023 23:15:42 +0800
Message-Id: <20231228151544.14408-2-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcdeb73b-8ef7-44b7-4c4b-08dc07b7eff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m047FMbbKlGDwDkHubALPPMvcib/+49bXw1ZyLotqBZTp/hwKjMNMeBmSy2T7MoM2dxXYtuvivtnNXz5kVeMD25WIRHAXzRyjEvROM48ZPsxX0lLUGNz1+IknGeRAVC3LLZK01PMUrYoV0gyKlr//IVdQkFcKglk4qiMCXLns3fpogi7S8n7DlDo0JKPeP+MxVoADi/MxlBbS7uiJRMM+oP23UgBit1b41ov93qYM0UddrwRTE4hiXtkm+kMPUOepiFiNz4TDEv8ECHQ9turrGDWDtgVx1y/guTILunWCKVstzxKbARad7z7sLnZ6obUarpd0wAhzHw5QByc9G+e6MR/rLJdeqZViMS4VLN/hkQ/IlXCZQCqN5Ok8brPlk/6WXLK2dZNclUsmdlxW7CKaZHKFr0b4urYiw5JPbYpLNZtNryOjjD1FMXGUd/lwpfh4AH0ETJDG7QlCXSiYV3nl6mBEPt50Ec7s7ZCD2krQ/VreYrHmFtZAY3GB11FtqnyAqZs44v4UU3OzTb8X7N/KQCyRb/roSN+tND+dYGjkOuBn5m7whgr0+enfo+WUkmyR9nB65aN2xPzVsHlIcyOSGXCgp2Qs+L0fQFNR5jU0OoNO6CFOMHbiM1l/AxMqBuCOH/PQ/n0yIRI/4IyahsCcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(86362001)(30864003)(2906002)(38100700002)(36756003)(41300700001)(66946007)(54906003)(66476007)(316002)(66556008)(83380400001)(6486002)(6506007)(52116002)(1076003)(26005)(478600001)(2616005)(6666004)(5660300002)(4326008)(8936002)(8676002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zS68Cz+Fe2hjoZJoVCotak/+tLG5Zv6UH4cMMdgO7XL1g4a+bZTwyaIqU+e?=
 =?us-ascii?Q?oHA630Jcf33BB/RFE7V32E3zlh8YZGCQwukOBC6PcEbFXWYykoZvCA0BIOKb?=
 =?us-ascii?Q?OuSz4ldVN0CInfk5hrb+peuPGNhSgJqqB63+9V1Sn7LRSq2prWDXuPKrItHi?=
 =?us-ascii?Q?xLrt5u+STYzeLgDl3r7IKemy2tyreWmor+xkclVRVmBWoe0XnnJhGTL9wX89?=
 =?us-ascii?Q?xRysnzvjxJ5Lc64w7kPZRksriWjCMdgCBszvJpVhTE20vWv2JUdMmCAAN4yq?=
 =?us-ascii?Q?C/tqmyQowRDA5U8/9IpuPynVziSseD3uv0XDSku58hy0910FaPKf2yM2Y2wX?=
 =?us-ascii?Q?UC+WMhFeBilHBdied7xm7ejHcwh/RhHWYln9lQAWyGLbmUt2hlKB4QJyFWu0?=
 =?us-ascii?Q?hR2Go9+XeIvW7pk08ncNlSE80CcnhqjlDSgLI9AmqHSCRS39ZJRaFrExX7Dw?=
 =?us-ascii?Q?c97SFlokqzHcaK1c9Sp9F0uVyGqlpqHe41BubFKTB+KdAZdPm4xw8gTraKJR?=
 =?us-ascii?Q?82gNgnSkknQFTDxuiEeBlgRAG01WXf54dV6AsJ6g07JvXWPq+saqkBsQvrNn?=
 =?us-ascii?Q?wfjKXIy51dO8FoB2E4ucLSzSreJMslV4iXheb11FpBlueUKmke4MAUnLbRkv?=
 =?us-ascii?Q?hiN5DLOGjrqJw7aZ8UKemU5sxXjKbEGKy6gaMvSwC6DMqC4+hgmf+3qANjga?=
 =?us-ascii?Q?HcqWBALjptThanHn5tnjNw560781n1Sa7LCyfq+cFwE07p0SR7coebu5rvoJ?=
 =?us-ascii?Q?ow67fS25iRH+/h2yZHXF64LgQlMBe0QpsgBYHjGSXDKl4hlop6mtnFyCHKak?=
 =?us-ascii?Q?ffu41zyerJyLP+q41hlLjB2zO+vi8oGYC6FUgWqN/mkFH6ThStwYvFWPzZ9o?=
 =?us-ascii?Q?RzxP38k9DooK2sBH2769PsDgxrboftWBT8Kt/jIBOARZG0eH3x+ngqVB/86X?=
 =?us-ascii?Q?YGT93ijqJe08aMIiDqajMBV0A/gyYeOPi7ll9R5p5VuY/he1OUGRGi+sSfVB?=
 =?us-ascii?Q?ahoUixkLLONHF+WhvmUtTSnSc/1NPutAdu5Powo2uLOMW7g860HzfhTg6jc+?=
 =?us-ascii?Q?2LAI81YKZsVt7vGF38d5R0DxFd+mAW7cEDr0CD9OvjvULtZVDUOBRuEvLkkA?=
 =?us-ascii?Q?ZvthV8oGMkSOFaKW1fqvTSB65UYzRc9W4Ko7ROjEUj+49OJvcTw2S4PolnfH?=
 =?us-ascii?Q?BIIVWKJkpCAmqp7P+wLphSmZPjqb+BpjNED7Ux47aPwv/WRxCw0mFkMRxVWO?=
 =?us-ascii?Q?YbOs3lwgYDtDx5E+kMih1sA18Qsf62UThkuuJZk+YlQWWl29kFB8yPWlielg?=
 =?us-ascii?Q?bRvsxrPv2epYh0JHjb3wa5HoWh/a4gUAguVSkGwjdhAfJuDD7XtrhRPegxNu?=
 =?us-ascii?Q?0r5E6FqKvhX7X95p21Aa33ZzUQk37iGSNa4AbcoeT4eK7oBhA+LfWD/rHQfh?=
 =?us-ascii?Q?UfGsvMJ9FRyQkL7nwXdKE0hknxAl64eGJkjBQSQzpugvf03BMNWKAkQHLBWP?=
 =?us-ascii?Q?FNJCJslq3906jAY3Bp/3gc6g4Gf8+dJAjLsfvHXVEEUAnuJmvkc4Fo1X6tjE?=
 =?us-ascii?Q?BH/oWB15Z3tRYe4r30ZysAnP9AiuIUJzVvvu+prthCcwwqGVqTXIYdIOkSqD?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdeb73b-8ef7-44b7-4c4b-08dc07b7eff2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 15:16:16.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGE6PGZELqBf1rECBpTCGX46pixkYuWGJOz/2bb2SnrfZPx8eLv4MJhY8AcBlRcU2hqBx12yBvCw+TjH4twi1pagFMHHkLdOz1f3IctELmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6650

The UP Squared board <http://www.upboard.com> implements certain
features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.

This driver implements the line protocol to read and write registers
from the FPGA through regmap. The register address map is also included.

The UP Boards provide a few I/O pin headers (for both GPIO and
functions), including a 40-pin Raspberry Pi compatible header.

This patch implements the FPGA-based pin controller that manages direction
and enable state for those header pins.

Partial supported boards:
* UP core + CREX
* UP core + CRST02

Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
PATCH V7 -> PATCH V8
(1) Refer 2023/11/14 Andy Shevchenko review, cleaned up coding style
and addressed review comments.
PATCH V6 -> PATCH V7
(1) Refer 2023/09/15 Lee Jones review, cleaned up coding style
and addressed review comments.
PATCH V5 -> PATCH V6
(1) Fixed kernel test robot compiler warning.
PATCH V4 -> PATCH V5
(1) Refer 2023/05/25 Lee Jones review, cleaned up coding style
and addressed review comments.
(2) Synchronizing upboard github to v1.0.5 tag.
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 -> RFC 2023/04/25
(1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style
and addressed review comments.
PATCH V3 -> RFC 2022/11/23:
(1) Refer 2022/11/16 Lee Jones review, cleaned up coding style and
addressed review comments.
(2) Description on the UP Boards FPGA register read/write protocols
PATCH V2 -> V3:
(1) fixed kernel test robot compiler warning.
PATCH V1 -> V2:
(1) Synchronizing upboard github to rc2.
(2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.
---
 drivers/mfd/Kconfig              |  12 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 364 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  59 +++++
 4 files changed, 436 insertions(+)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..54b5ddf782e3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2104,6 +2104,18 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_UPBOARD_FPGA
+	tristate "Support for the Intel platform foundation kit UP board FPGA"
+	select MFD_CORE
+	depends on (X86 && ACPI) || COMPILE_TEST
+	help
+	  Select this option to enable the AAEON UP and UP^2 on-board FPGA.
+	  This is core driver for the UP board that implements certain (pin
+	  control, onboard LEDs or CEC) through an on-board FPGA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called upboard-fpga.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..d9d10e3664f7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
new file mode 100644
index 000000000000..03158025b57f
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board multifunction device driver.
+ * CPLD provide more GPIO driving power, LEDs and pin mux function.
+ * HID AANT0F00 ~ AAANT0F04 in ACPI namespace.
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define ENABLE_DEVICE			1
+
+#define AAEON_MANUFACTURER_ID		0x01
+#define SUPPORTED_FW_MAJOR		0x0
+#define MENUFACTURER_ID_MASK		GENMASK(7, 0)
+
+#define FIRMWARE_ID_BUILD_OFFSET	12
+#define FIRMWARE_ID_MAJOR_OFFSET	8
+#define FIRMWARE_ID_MINOR_OFFSET	4
+#define FIRMWARE_ID_PATCH_OFFSET	0
+#define FIRMWARE_ID_MASK		GENMASK(3, 0)
+
+/*
+ * read CPLD register on custom protocol
+ * send clock and addr bit in strobe and datain pins then read from dataout pin
+ */
+static int upboard_cpld_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	/* clear to start new transcation */
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	reg |= UPFPGA_READ_FLAG;
+
+	/* send clock and data from strobe & datain */
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+	*val = 0;
+
+	/* read from dataout */
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+/*
+ * write CPLD register on custom protocol
+ * send clock and addr bit in strobe and datain pins then write to datain pin
+ */
+static int upboard_cpld_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	/* clear to start new transcation */
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	/* send clock and data from strobe & datain */
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+
+	/* write to datain pin */
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->datain_gpio, !!(val & BIT(i)));
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+}
+
+static const struct regmap_range upboard_up_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_range upboard_up_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_access_table upboard_up_readable_table = {
+	.yes_ranges = upboard_up_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up_writable_table = {
+	.yes_ranges = upboard_up_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_writable_ranges),
+};
+
+static struct regmap_config upboard_up_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_cpld_read,
+	.reg_write = upboard_cpld_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up_readable_table,
+	.wr_table = &upboard_up_writable_table,
+};
+
+static struct upboard_led_data upboard_gpio_led_data[] = {
+	{ .bit = 0, .colour = "gpio" },
+};
+
+/* 3 LEDs controlled by CPLD */
+static struct upboard_led_data upboard_up_led_data[] = {
+	{ .bit = 0, .colour = "yellow" },
+	{ .bit = 1, .colour = "green" },
+	{ .bit = 2, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up_mfd_cells[] = {
+	MFD_CELL_NAME("upboard-pinctrl"),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[0],
+		       sizeof(*upboard_up_led_data), 0),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[1],
+		       sizeof(*upboard_up_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[2],
+		       sizeof(*upboard_up_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
+		       sizeof(*upboard_gpio_led_data), 0),
+};
+
+static const struct upboard_fpga_data upboard_up_fpga_data = {
+	.cpld_config = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+/* UP^2 board */
+static const struct regmap_range upboard_up2_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_range upboard_up2_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_access_table upboard_up2_readable_table = {
+	.yes_ranges = upboard_up2_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up2_writable_table = {
+	.yes_ranges = upboard_up2_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
+};
+
+static struct regmap_config upboard_up2_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_cpld_read,
+	.reg_write = upboard_cpld_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static struct upboard_led_data upboard_up2_led_data[] = {
+	{ .bit = 0, .colour = "blue" },
+	{ .bit = 1, .colour = "yellow" },
+	{ .bit = 2, .colour = "green" },
+	{ .bit = 3, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	MFD_CELL_NAME("upboard-pinctrl"),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
+		       sizeof(*upboard_up2_led_data), 0),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[1],
+		       sizeof(*upboard_up2_led_data), 1),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[2],
+		       sizeof(*upboard_up2_led_data), 2),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[3],
+		       sizeof(*upboard_up2_led_data), 3),
+	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
+		       sizeof(*upboard_gpio_led_data), 0),
+};
+
+static const struct upboard_fpga_data upboard_up2_fpga_data = {
+	.cpld_config = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+/* UP-CREX carrier board for UP Core */
+
+/* same MAXV config as UP1 (proto2 release) */
+#define upboard_upcore_crex_fpga_data upboard_up_fpga_data
+
+/* UP-CRST02 carrier board for UP Core */
+
+/* same MAX10 config as UP2, but same LED cells as UP1 */
+static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
+	.cpld_config = &upboard_up2_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static int upboard_cpld_gpio_init(struct upboard_fpga *fpga)
+{
+	fpga->enable_gpio = devm_gpiod_get(fpga->dev, "enable", GPIOD_ASIS);
+	if (IS_ERR(fpga->enable_gpio))
+		return PTR_ERR(fpga->enable_gpio);
+
+	fpga->clear_gpio = devm_gpiod_get(fpga->dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->clear_gpio))
+		return PTR_ERR(fpga->clear_gpio);
+
+	fpga->strobe_gpio = devm_gpiod_get(fpga->dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->strobe_gpio))
+		return PTR_ERR(fpga->strobe_gpio);
+
+	fpga->datain_gpio = devm_gpiod_get(fpga->dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->datain_gpio))
+		return PTR_ERR(fpga->datain_gpio);
+
+	fpga->dataout_gpio = devm_gpiod_get(fpga->dev, "dataout", GPIOD_IN);
+	if (IS_ERR(fpga->dataout_gpio))
+		return PTR_ERR(fpga->dataout_gpio);
+
+	gpiod_set_value(fpga->enable_gpio, ENABLE_DEVICE);
+
+	return 0;
+}
+
+/* This function is for debugging with user for showing firmware information. */
+static int upboard_fpga_verify_device(struct upboard_fpga *fpga)
+{
+	unsigned int platform_id, manufacturer_id;
+	unsigned int firmware_id, build, major, minor, patch;
+	int ret;
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id & MENUFACTURER_ID_MASK;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_err(fpga->dev,
+			"Manufacturer ID 0x%02x not supported\n",
+			manufacturer_id);
+
+		return -ENODEV;
+	}
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = (firmware_id >> FIRMWARE_ID_BUILD_OFFSET) & FIRMWARE_ID_MASK;
+	major = (firmware_id >> FIRMWARE_ID_MAJOR_OFFSET) & FIRMWARE_ID_MASK;
+	minor = (firmware_id >> FIRMWARE_ID_MINOR_OFFSET) & FIRMWARE_ID_MASK;
+	patch = (firmware_id >> FIRMWARE_ID_PATCH_OFFSET) & FIRMWARE_ID_MASK;
+
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_err(fpga->dev, "Manufacturer ID 0x%02x not supported\n", build);
+
+		return -ENODEV;
+	}
+
+	dev_info(fpga->dev, "Compatible FPGA FW v%u.%u.%u build 0x%02x",
+		 major, minor, patch, build);
+
+	return 0;
+}
+
+static const struct acpi_device_id upboard_fpga_acpi_match[] = {
+	{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
+	{ "AANT0F02", (kernel_ulong_t)&upboard_upcore_crex_fpga_data },
+	{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
+	{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
+
+static int upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct upboard_fpga *ddata;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->fpga_data = device_get_match_data(dev);
+	if (!ddata->fpga_data)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, ddata);
+	ddata->dev = dev;
+	ddata->regmap = devm_regmap_init(dev, NULL, ddata, ddata->fpga_data->cpld_config);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ret = upboard_cpld_gpio_init(ddata);
+	if (ret) {
+		/* Not FPGA firmware, abort FPGA GPIO initialize process */
+		dev_warn(dev, "Failed to initialize CPLD common GPIOs: %d", ret);
+	} else {
+		upboard_fpga_verify_device(ddata);
+	}
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				    ddata->fpga_data->cells,
+				    ddata->fpga_data->ncells,
+				    NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_fpga_driver = {
+	.driver = {
+		.name = "upboard-cpld",
+		.acpi_match_table = upboard_fpga_acpi_match,
+	},
+};
+module_platform_driver_probe(upboard_fpga_driver, upboard_fpga_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board CPLD/FPGA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
new file mode 100644
index 000000000000..b25bf02e79aa
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board CPLD/FPGA driver
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Author: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#ifndef __MFD_UPBOARD_FPGA_H
+#define __MFD_UPBOARD_FPGA_H
+
+/* CPLD/FPGA protocol version */
+#define UPFPGA_PROTOCOL_V1_HRV	1
+#define UPFPGA_PROTOCOL_V2_HRV	2
+
+#define UPFPGA_ADDRESS_SIZE	7
+#define UPFPGA_REGISTER_SIZE	16
+
+#define UPFPGA_READ_FLAG	BIT(UPFPGA_ADDRESS_SIZE)
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID	= 0x10,
+	UPFPGA_REG_FIRMWARE_ID	= 0x11,
+	UPFPGA_REG_FUNC_EN0	= 0x20,
+	UPFPGA_REG_FUNC_EN1	= 0x21,
+	UPFPGA_REG_GPIO_EN0	= 0x30,
+	UPFPGA_REG_GPIO_EN1	= 0x31,
+	UPFPGA_REG_GPIO_EN2	= 0x32,
+	UPFPGA_REG_GPIO_DIR0	= 0x40,
+	UPFPGA_REG_GPIO_DIR1	= 0x41,
+	UPFPGA_REG_GPIO_DIR2	= 0x42,
+	UPFPGA_REG_MAX
+};
+
+struct upboard_fpga_data {
+	struct regmap_config *cpld_config;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+struct upboard_fpga {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct gpio_desc	*enable_gpio;
+	struct gpio_desc	*reset_gpio;
+	struct gpio_desc	*clear_gpio;
+	struct gpio_desc	*strobe_gpio;
+	struct gpio_desc	*datain_gpio;
+	struct gpio_desc	*dataout_gpio;
+	const struct upboard_fpga_data *fpga_data;
+};
+
+struct upboard_led_data {
+	unsigned int		bit;
+	const char		*colour;
+};
+
+#endif /*  __MFD_UPBOARD_FPGA_H */
-- 
2.17.1


