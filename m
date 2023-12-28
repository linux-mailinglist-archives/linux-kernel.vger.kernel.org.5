Return-Path: <linux-kernel+bounces-12746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957681F991
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F59F1C211C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A67101D0;
	Thu, 28 Dec 2023 15:16:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CEF51A;
	Thu, 28 Dec 2023 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yunjingtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunjingtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+bxVGGt9MTy+iB3hD5zwl0ByCZRjU0x/btuIFRJEO8sl60ZRQMGcugxV+/G26/dG2Iwt+X407dE+ky1yUh5nySLcWE6irMlDpiIxrfgcCEqJaqUTA1jq4TK47OYlt3L97xG5dotPyUJozoMjpStGxJXAplwBam/b2C0DxB74HYZPQBm4JT4bH3Uu6hpELZ0ajLQT+Im9zwkYHDEvsOoyqG88FTAYtGvPFkoM2S5BEol3yN+w9zSGTxWzERl77Gf3vZ/csNIK2ZZjvKKjASBuyjJMBvZWxyMmo7hMFVqhudBpbi1jWrQuV8sYWR/rKquMPuOEIIEo880Y5dD6fiLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OexX29tKg/18LKwOaoK2Wx1u/+gQS5retHWX6bM3ws8=;
 b=Qwt89DCfsUiL0fP4DlHzKJ1Ny6Wov46+Pv4sb1mRpT/95YGX6XtMKsBsCMoXcwwboGg59jn8MORcK6TgQYfAX/vzB2J/XR3lBlZbC95lVD9xvDRTVNtUjMiovy4TGOzvIofpX4HdOKyAH6Ue/fvWdbnN16yhTQAkd8Ys/hL4OHhQVkx9Sn6gRuk7a5+kv9DoqcaqVEHy1kn7tkJ9/7uLJZ1aM+SXntK0Liat9QQyrYD/FYnQcaGu42DWUm3v+0X+RN7ztvFEQS3aUS6I6FvvVf/IYdd06B94a8IfnTsh1jMRgsV+60ykY7vUDEEk4Y/IQzE8//K2dkghf2497bTewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR06MB6650.apcprd06.prod.outlook.com (2603:1096:820:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 15:16:21 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::883b:97ce:6565:e5e%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 15:16:21 +0000
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
Subject: [PATCH V8 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
Date: Thu, 28 Dec 2023 23:15:43 +0800
Message-Id: <20231228151544.14408-3-larry.lai@yunjingtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46a1de95-8515-4560-c0b6-08dc07b7f2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v2jXOnLEvl1F43RiauGsdEV0xR/KZSyNG6DPZpnRhlHmV+8PUoQXF4Kd7S8Yg2MJovfYYR3Wi5HSUDZarMuX9IVdfhE7rbjWbx1nY0/iDW9G/DavzP8kJmnyEsxl8ltU4kvprfJD4LUy97+I2vo5bxKsA4WHX2Q+Fx8SPns55HQdl6l+7+zSOE2iu2QIzbjp4Zuwq53eCuSqZWQaLfYp8cK4M8JdvEZD0fsSaLE89VH8y1e9xy4ZsT8lHM9CY+Ws6yYfD2AHjEOHzVjzoRtpg2B6pOZyG5oDjScTSHhqApWtO734fvxaEAx7D5OtRjD+kNhpW3+LndBSToMM4Id9DQ5h+ZrnmUBfv2fNDc68TLm17EnDDU/Z5tLwa8nP19RRmeWeGH2eeTM67Z/dFl0Ylyae8i3peeLMG6Lsg/01oSq6h1bzlzc6BZPMfzeZuZWDumhxNOpjYJwQbb0fAJgE8ifQvB43mu3jNrXH3LYewysXQDb5HbkImBnXLEJwiXjn3PC4zWXq8REI92maqY7BmfQ3bWkTIHEDSfVCGdVA31MNzNXNZj22Na1m8HZoDCnTpEMwv7x8mTlP8pEwIRJs8QGX04fYt75XSkcbzPUc1t2DYtWj5eHrDm/H3MV0+NLwUGBIy27mzbvgLOihmlZvGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39830400003)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(86362001)(30864003)(2906002)(38100700002)(36756003)(41300700001)(66946007)(54906003)(66476007)(316002)(66556008)(83380400001)(6486002)(6506007)(52116002)(1076003)(26005)(478600001)(2616005)(6666004)(5660300002)(4326008)(8936002)(8676002)(6512007)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r57mQkc/J5AdL/3lGwHzgyihJtmUOWZNKitm7Gl5P8Q85jnkAfkYFvhOSccA?=
 =?us-ascii?Q?UGUVvx7l5rKCq1+PWfTSfEj/s3Qbfj2mzTRulElsP4q32nGgoDZBS1f9X7ML?=
 =?us-ascii?Q?p38AEyQ7tcpT7GdmlDnnUNmPlNbDWOZvNS4o0C4XR1f+KEpNDprx56AwSFQC?=
 =?us-ascii?Q?P0GYiSdN8Nug23JvrH9e8FztKbKGSkHbRKQrS9bh5i21GzrpuYoH22Pno/21?=
 =?us-ascii?Q?8uqBmLr7SGVlnFqtRGmbbubamMq/JFPYzmhfkTsQWS/h6XMVAPoxDm8Q0KOq?=
 =?us-ascii?Q?nitGNm9lAMq+o4P0eKRejO9QSL6beHKo0ZBOLxWxy7vjDslBgp7YsSHKXZYk?=
 =?us-ascii?Q?9/ECGDEKs1PvdZey9RLBV9FkNifYvz0AqYWavolxCfqVOboWvnu6Xl/gToQh?=
 =?us-ascii?Q?v/bq16YJ8gBpr+AE7626xL2Odg48L0wi94zwg1V2maR37tY31up7MAAR0JZp?=
 =?us-ascii?Q?2DkaLQEVwLNumCMKfyn/4Ev01dx1y1UBrsU9E/JoTQhn9n7v5uJyfZJwqysQ?=
 =?us-ascii?Q?DmN45+qHhH5CklHuXfA0rSS4Z9Y0t8wYPd2TWTLn/My72s5Wki25QUQCxuWa?=
 =?us-ascii?Q?ONvO5zjEOOsfXr+zw6Zm85VP0Vof32yHDcAzYtlFqcYwKUmIKEUgu6R3mIJl?=
 =?us-ascii?Q?r3VSwl/H/Qgh3Fn6DILwvmC14ovEOp9onllY71CDIgRmeZR9YhINcmcIhF3k?=
 =?us-ascii?Q?ayr0HGH9BQ2gdu2lm7aKcKiXatIKNjI+qU8q2OGzDWmydNx0zssEjpYbm5PL?=
 =?us-ascii?Q?mwvBbkTuZxM2WU07cPTD+dy32iM18GF6dbmQyS3VABEvK7sjaDrL1+wrIcug?=
 =?us-ascii?Q?XmKbqHMsZuBBEFNp7P9SpbnXQtqlPQZrjvAii2xPwi9/vzsD2vR1k9HDj966?=
 =?us-ascii?Q?n+kjD4LlGBwthroaZsyFvFK5F/lOzFPgH996YePdIMr9eb3x39Ezf0QRDC2K?=
 =?us-ascii?Q?rK2megg+Vn326oTHFI6njkf/Z/UL2UakKqiaQdcdZzmgZpEAfW051PbtHLVt?=
 =?us-ascii?Q?pbNpxnruy8KFFvG030PJN8RBObjbBnn9yUh+31F971GboC26ZI4u+rsNsgl+?=
 =?us-ascii?Q?AU81aW3ANFvImLXgDnzlWn2ePVouwXDq+e18IIdfSSOEMTtQqTLKMhk245ed?=
 =?us-ascii?Q?wsVO5vTBWeDxoRhQlRpHnjzaXc8rLfT8F3Mf9G11xH1IrlnOVkB21p1eLb9D?=
 =?us-ascii?Q?sxmYQhcufl+44T7Hpz1lnDdrocyDfhC+f9+Ahvmmqqn4xBLCeP3TzlIVmqAa?=
 =?us-ascii?Q?KDCOKpG3iqPjIrvBtivDIYhLwdjMHrwT2aJ20owdy3IiIRpKmbG4qt7KdxZQ?=
 =?us-ascii?Q?u2ufb47kl8Yw/sB93GdqDB7xoKVpucGJ61l6cViddx5rJEJGED5pdgL0ieWQ?=
 =?us-ascii?Q?G4CfsLSp6ld+nSjQZi7i9hvDI/oWhYlZY/CSlc9292FXkF1tK21mDPAc6jgB?=
 =?us-ascii?Q?Az48qnV8bkoEz8mD4ThgYc/4fEq9JdjIHNahMWeRwkthp6empPNxLFLnPNOF?=
 =?us-ascii?Q?0MVVWNNgLLVcUGaPUwmbV73HqEVOCT+D3KXQP9DV5o4J1f8RcmTy0M9+4EP2?=
 =?us-ascii?Q?uiqobahtR/ktkJUEvSIxlqZ7a9ssmlegBhSBl5Y/kmxjXAvARKZ0yOcOClW/?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a1de95-8515-4560-c0b6-08dc07b7f2a5
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 15:16:21.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbaPWV0HTeObHeJKTNEOeW3St0/MObQ/1GjLjpRQl2WsFCU0Ox0RLDVlr3biN0ggjXewTlXckF5kyazHgHvuUEsJP67t+fn6vyW/JRnD9FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6650

The UP Squared board <http://www.upboard.com> implements certain
features (pin control) through an on-board FPGA.

Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
---
PATCH V7 -> PATCH V8
(1) Refer 2023/11/14 Andy Shevchenko review, cleaned up coding style
and addressed review comments.
(2) Refer 2023/11/01 Krzysztof Kozlowski review, cleaned up coding style
and addressed review comments.
PATCH V6 -> V7: There's no change.
PATCH V5 -> PATCH V6
(1) Refer 2023/08/10 Linus Walleij review, cleaned up coding style and
addressed review comments.
PATCH V4 -> PATCH V5
(1) Fixed kernel test robot compiler warning.
(2) Synchronizing upboard github to v1.0.5 tag.
RFC 2023/04/25 -> PATCH V4
(1) Fixed kernel test robot compiler warning.
(2) Remove mistakes with wrong Reviewed-by tags.
RFC 2022/11/23 -> RFC 2023/04/25
(1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style and
addressed review comments.
PATCH V3 -> RFC 2022/11/23:
(1) Refer 2022/11/09 Linus Walleij review, cleaned up coding style and
addressed review comments.
PATCH V2 -> V3:
There's no change.
PATCH V1 -> V2:
(1) Synchronized with upboard github to rc2
(2) Refer 2022/10/19 Mark Brown and Andy Shevchenko review, we removed
the regmap and acpi patches and implement in upboard pinctrl driver.
(3) Refer 2022/10/19 Andy Shevchenko review, fixed the coding style
issues, removed using gpio_xxxx API and removed including <linux/gpio.h>.
---
 drivers/pinctrl/Kconfig           |   15 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1309 +++++++++++++++++++++++++++++
 3 files changed, 1325 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 1cf74b0c42e5..c114fc2b7cec 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -483,6 +483,21 @@ config PINCTRL_THUNDERBAY
 	  rate control and direction control. This module will be
 	  called as pinctrl-thunderbay.
 
+config PINCTRL_UPBOARD
+	tristate "UP board FPGA pin controller"
+	depends on (X86 && ACPI) || COMPILE_TEST
+	depends on MFD_UPBOARD_FPGA
+	select GENERIC_PINCONF
+	select PINMUX
+	select PINCONF
+	help
+	  Pin controller for the FPGA GPIO lines on UP boards. Due to the
+	  hardware layout, these are meant to be controlled in tandem with their
+	  corresponding Intel SoC GPIOs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pinctrl-upboard.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e76f5cdc64b0..c366706d36e7 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
+obj-$(CONFIG_PINCTRL_UPBOARD)	+= pinctrl-upboard.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
new file mode 100644
index 000000000000..b9a65dcf6cc0
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-upboard.c
@@ -0,0 +1,1309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board HAT pin controller driver
+ * remapping native GPIO to RPI GPIO and set CPLD
+ *
+ * Copyright (c) AAEON. All rights reserved.
+ *
+ * Authors: Gary Wang <garywang@aaeon.com.tw>
+ */
+
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "core.h"
+#include "intel/pinctrl-intel.h"
+
+/* Offset from regs */
+#define REVID				0x000
+#define REVID_SHIFT			16
+#define REVID_MASK			GENMASK(31, 16)
+#define PADBAR				0x00c
+
+#define PADCFG0				0x000
+#define PADCFG1				0x004
+#define PADCFG2				0x008
+#define PADCFG0_GPIORXDIS		BIT(9)
+#define PADCFG0_GPIOTXDIS		BIT(8)
+#define PADCFG0_GPIORXSTATE		BIT(1)
+#define PADCFG0_GPIOTXSTATE		BIT(0)
+#define PADCFG0_PMODE_GPIO		0
+#define PADCFG0_PMODE_SHIFT		10
+#define PADCFG0_PMODE_MASK		GENMASK(13, 10)
+
+#define BOARD_UP_CHT01				0
+#define BOARD_UP_APL01				1
+#define BOARD_UP_UPCORE				2
+#define BOARD_UP_CORE_PLUS			3
+#define BOARD_AIOT_IP6801			4
+#define BOARD_UP_WHL01				5
+#define BOARD_UP_ISH				7
+#define BOARD_UPN_APL				8
+#define BOARD_UP_APL03				9
+#define BOARD_UPX_WHLite			10
+#define BOARD_UPX_TGL				11
+#define BOARD_UPX_EDGE_WHL2			12
+#define BOARD_UPN_EHL01				13
+#define BOARD_UPS_EHL01				BOARD_UPN_EHL01
+#define BOARD_UPX_ADLP01			15
+#define BOARD_UPN_ADLN01			16
+#define BOARD_UPS_ADLP01			BOARD_UPX_ADLP01
+#define BOARD_UP_ADLN01				18
+
+struct upboard_pin {
+	struct regmap_field *funcbit;
+	struct regmap_field *enbit;
+	struct regmap_field *dirbit;
+	/* native pin controllers: number, base, irq */
+	unsigned int gpio;
+	unsigned int base;
+	int irq;
+	void __iomem *regs;
+};
+
+struct upboard_pinctrl {
+	struct gpio_chip chip;
+	struct device *dev;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc *pctldesc;
+	struct upboard_pin *pins;
+	struct regmap *regmap;
+	const unsigned int *rpi_mapping;
+	int ident;
+};
+
+enum upboard_func0_fpgabit {
+	UPFPGA_I2C0_EN = 8,
+	UPFPGA_I2C1_EN = 9,
+	UPFPGA_CEC0_EN = 12,
+	UPFPGA_ADC0_EN = 14
+};
+
+static const struct reg_field upboard_i2c0_reg =
+	REG_FIELD(UPFPGA_REG_FUNC_EN0, UPFPGA_I2C0_EN, UPFPGA_I2C0_EN);
+
+static const struct reg_field upboard_i2c1_reg =
+	REG_FIELD(UPFPGA_REG_FUNC_EN0, UPFPGA_I2C1_EN, UPFPGA_I2C1_EN);
+
+static const struct reg_field upboard_adc0_reg =
+	REG_FIELD(UPFPGA_REG_FUNC_EN0, UPFPGA_ADC0_EN, UPFPGA_ADC0_EN);
+
+/* Pin group information */
+struct upboard_pingroup {
+	const char *name;
+	const unsigned int *pins;
+	size_t npins;
+};
+
+/* Pin function information */
+struct upboard_function {
+	const char *name;
+	const char * const *groups;
+	size_t ngroups;
+};
+
+#define UPBOARD_BIT_TO_PIN(r, bit) \
+	((r) * UPFPGA_REGISTER_SIZE + (bit))
+
+/*
+ * UP board data
+ */
+
+#define UPBOARD_UP_BIT_TO_PIN(r, id) (UPBOARD_BIT_TO_PIN(r, UPFPGA_UP_##id))
+
+#define UPBOARD_UP_PIN_ANON(r, bit)					\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+	}
+
+#define UPBOARD_UP_PIN_NAME(r, id)					\
+	{								\
+		.number = UPBOARD_UP_BIT_TO_PIN(r, id),			\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UP_PIN_FUNC(r, id, data)				\
+	{								\
+		.number = UPBOARD_UP_BIT_TO_PIN(r, id),			\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+#define UPBOARD_PIN_GROUP(n, p)			\
+	{					\
+		.name = (n),			\
+		.pins = (p),			\
+		.npins = ARRAY_SIZE((p)),	\
+	}
+
+#define FUNCTION(n, g)				\
+	{					\
+		.name = (n),			\
+		.groups = (g),			\
+		.ngroups = ARRAY_SIZE((g)),	\
+	}
+
+enum upboard_up_reg1_fpgabit {
+	UPFPGA_UP_I2C1_SDA,
+	UPFPGA_UP_I2C1_SCL,
+	UPFPGA_UP_ADC0,
+	UPFPGA_UP_GPIO17,
+	UPFPGA_UP_GPIO27,
+	UPFPGA_UP_GPIO22,
+	UPFPGA_UP_SPI_MOSI,
+	UPFPGA_UP_SPI_MISO,
+	UPFPGA_UP_SPI_CLK,
+	UPFPGA_UP_I2C0_SDA,
+	UPFPGA_UP_GPIO5,
+	UPFPGA_UP_GPIO6,
+	UPFPGA_UP_PWM1,
+	UPFPGA_UP_I2S_FRM,
+	UPFPGA_UP_GPIO26,
+	UPFPGA_UP_UART1_TX
+};
+
+enum upboard_up_reg2_fpgabit {
+	UPFPGA_UP_UART1_RX,
+	UPFPGA_UP_I2S_CLK,
+	UPFPGA_UP_GPIO23,
+	UPFPGA_UP_GPIO24,
+	UPFPGA_UP_GPIO25,
+	UPFPGA_UP_SPI_CS0,
+	UPFPGA_UP_SPI_CS1,
+	UPFPGA_UP_I2C0_SCL,
+	UPFPGA_UP_PWM0,
+	UPFPGA_UP_GPIO16,
+	UPFPGA_UP_I2S_DIN,
+	UPFPGA_UP_I2S_DOUT,
+};
+
+#define UPFPGA_UP_UART1_RTS UPFPGA_UP_GPIO17
+#define UPFPGA_UP_UART1_CTS UPFPGA_UP_GPIO16
+
+static struct pinctrl_pin_desc upboard_up_pins[] = {
+	UPBOARD_UP_PIN_FUNC(0, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UP_PIN_FUNC(0, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UP_PIN_FUNC(0, ADC0, &upboard_adc0_reg),
+	UPBOARD_UP_PIN_NAME(0, UART1_RTS),
+	UPBOARD_UP_PIN_NAME(0, GPIO27),
+	UPBOARD_UP_PIN_NAME(0, GPIO22),
+	UPBOARD_UP_PIN_NAME(0, SPI_MOSI),
+	UPBOARD_UP_PIN_NAME(0, SPI_MISO),
+	UPBOARD_UP_PIN_NAME(0, SPI_CLK),
+	UPBOARD_UP_PIN_FUNC(0, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UP_PIN_NAME(0, GPIO5),
+	UPBOARD_UP_PIN_NAME(0, GPIO6),
+	UPBOARD_UP_PIN_NAME(0, PWM1),
+	UPBOARD_UP_PIN_NAME(0, I2S_FRM),
+	UPBOARD_UP_PIN_NAME(0, GPIO26),
+	UPBOARD_UP_PIN_NAME(0, UART1_TX),
+	/* register 1 */
+	UPBOARD_UP_PIN_NAME(1, UART1_RX),
+	UPBOARD_UP_PIN_NAME(1, I2S_CLK),
+	UPBOARD_UP_PIN_NAME(1, GPIO23),
+	UPBOARD_UP_PIN_NAME(1, GPIO24),
+	UPBOARD_UP_PIN_NAME(1, GPIO25),
+	UPBOARD_UP_PIN_NAME(1, SPI_CS0),
+	UPBOARD_UP_PIN_NAME(1, SPI_CS1),
+	UPBOARD_UP_PIN_FUNC(1, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UP_PIN_NAME(1, PWM0),
+	UPBOARD_UP_PIN_NAME(1, UART1_CTS),
+	UPBOARD_UP_PIN_NAME(1, I2S_DIN),
+	UPBOARD_UP_PIN_NAME(1, I2S_DOUT),
+};
+
+static const unsigned int upboard_up_rpi_mapping[] = {
+	UPBOARD_UP_BIT_TO_PIN(0, I2C0_SDA),
+	UPBOARD_UP_BIT_TO_PIN(1, I2C0_SCL),
+	UPBOARD_UP_BIT_TO_PIN(0, I2C1_SDA),
+	UPBOARD_UP_BIT_TO_PIN(0, I2C1_SCL),
+	UPBOARD_UP_BIT_TO_PIN(0, ADC0),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO5),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO6),
+	UPBOARD_UP_BIT_TO_PIN(1, SPI_CS1),
+	UPBOARD_UP_BIT_TO_PIN(1, SPI_CS0),
+	UPBOARD_UP_BIT_TO_PIN(0, SPI_MISO),
+	UPBOARD_UP_BIT_TO_PIN(0, SPI_MOSI),
+	UPBOARD_UP_BIT_TO_PIN(0, SPI_CLK),
+	UPBOARD_UP_BIT_TO_PIN(1, PWM0),
+	UPBOARD_UP_BIT_TO_PIN(0, PWM1),
+	UPBOARD_UP_BIT_TO_PIN(0, UART1_TX),
+	UPBOARD_UP_BIT_TO_PIN(1, UART1_RX),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO16),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO17),
+	UPBOARD_UP_BIT_TO_PIN(1, I2S_CLK),
+	UPBOARD_UP_BIT_TO_PIN(0, I2S_FRM),
+	UPBOARD_UP_BIT_TO_PIN(1, I2S_DIN),
+	UPBOARD_UP_BIT_TO_PIN(1, I2S_DOUT),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO22),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO23),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO24),
+	UPBOARD_UP_BIT_TO_PIN(1, GPIO25),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO26),
+	UPBOARD_UP_BIT_TO_PIN(0, GPIO27),
+};
+
+/*
+ * UP^2 board data
+ */
+
+#define UPBOARD_UP2_BIT_TO_PIN(r, id) (UPBOARD_BIT_TO_PIN(r, UPFPGA_UP2_##id))
+
+#define UPBOARD_UP2_PIN_MUX(r, bit, data)				\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+		.name = "PINMUX",					\
+		.drv_data = (void *)(data),				\
+	}
+
+#define UPBOARD_UP2_PIN_NAME(r, id)					\
+	{								\
+		.number = UPBOARD_UP2_BIT_TO_PIN(r, id),		\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UP2_PIN_FUNC(r, id, data)				\
+	{								\
+		.number = UPBOARD_UP2_BIT_TO_PIN(r, id),		\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+enum upboard_up2_reg0_fpgabit {
+	UPFPGA_UP2_UART1_TXD,
+	UPFPGA_UP2_UART1_RXD,
+	UPFPGA_UP2_UART1_RTS,
+	UPFPGA_UP2_UART1_CTS,
+	UPFPGA_UP2_GPIO3_ADC0,
+	UPFPGA_UP2_GPIO5_ADC2,
+	UPFPGA_UP2_GPIO6_ADC3,
+	UPFPGA_UP2_GPIO11,
+	UPFPGA_UP2_EXHAT_LVDS1n,
+	UPFPGA_UP2_EXHAT_LVDS1p,
+	UPFPGA_UP2_SPI2_TXD,
+	UPFPGA_UP2_SPI2_RXD,
+	UPFPGA_UP2_SPI2_FS1,
+	UPFPGA_UP2_SPI2_FS0,
+	UPFPGA_UP2_SPI2_CLK,
+	UPFPGA_UP2_SPI1_TXD,
+};
+
+enum upboard_up2_reg1_fpgabit {
+	UPFPGA_UP2_SPI1_RXD,
+	UPFPGA_UP2_SPI1_FS1,
+	UPFPGA_UP2_SPI1_FS0,
+	UPFPGA_UP2_SPI1_CLK,
+	UPFPGA_UP2_BIT20,
+	UPFPGA_UP2_BIT21,
+	UPFPGA_UP2_BIT22,
+	UPFPGA_UP2_BIT23,
+	UPFPGA_UP2_PWM1,
+	UPFPGA_UP2_PWM0,
+	UPFPGA_UP2_EXHAT_LVDS0n,
+	UPFPGA_UP2_EXHAT_LVDS0p,
+	UPFPGA_UP2_I2C0_SCL,
+	UPFPGA_UP2_I2C0_SDA,
+	UPFPGA_UP2_I2C1_SCL,
+	UPFPGA_UP2_I2C1_SDA,
+};
+
+enum upboard_up2_reg2_fpgabit {
+	UPFPGA_UP2_EXHAT_LVDS3n,
+	UPFPGA_UP2_EXHAT_LVDS3p,
+	UPFPGA_UP2_EXHAT_LVDS4n,
+	UPFPGA_UP2_EXHAT_LVDS4p,
+	UPFPGA_UP2_EXHAT_LVDS5n,
+	UPFPGA_UP2_EXHAT_LVDS5p,
+	UPFPGA_UP2_I2S_SDO,
+	UPFPGA_UP2_I2S_SDI,
+	UPFPGA_UP2_I2S_WS_SYNC,
+	UPFPGA_UP2_I2S_BCLK,
+	UPFPGA_UP2_EXHAT_LVDS6n,
+	UPFPGA_UP2_EXHAT_LVDS6p,
+	UPFPGA_UP2_EXHAT_LVDS7n,
+	UPFPGA_UP2_EXHAT_LVDS7p,
+	UPFPGA_UP2_EXHAT_LVDS2n,
+	UPFPGA_UP2_EXHAT_LVDS2p,
+};
+
+static struct pinctrl_pin_desc upboard_up2_pins[] = {
+	UPBOARD_UP2_PIN_NAME(0, UART1_TXD),
+	UPBOARD_UP2_PIN_NAME(0, UART1_RXD),
+	UPBOARD_UP2_PIN_NAME(0, UART1_RTS),
+	UPBOARD_UP2_PIN_NAME(0, UART1_CTS),
+	UPBOARD_UP2_PIN_NAME(0, GPIO3_ADC0),
+	UPBOARD_UP2_PIN_NAME(0, GPIO5_ADC2),
+	UPBOARD_UP2_PIN_NAME(0, GPIO6_ADC3),
+	UPBOARD_UP2_PIN_NAME(0, GPIO11),
+	UPBOARD_UP2_PIN_NAME(0, EXHAT_LVDS1n),
+	UPBOARD_UP2_PIN_NAME(0, EXHAT_LVDS1p),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_TXD),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_RXD),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_FS1),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_FS0),
+	UPBOARD_UP2_PIN_NAME(0, SPI2_CLK),
+	UPBOARD_UP2_PIN_NAME(0, SPI1_TXD),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_RXD),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_FS1),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_FS0),
+	UPBOARD_UP2_PIN_NAME(1, SPI1_CLK),
+	UPBOARD_UP2_PIN_MUX(1, 4, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_MUX(1, 5, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_MUX(1, 6, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_MUX(1, 7, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_NAME(1, PWM1),
+	UPBOARD_UP2_PIN_NAME(1, PWM0),
+	UPBOARD_UP2_PIN_NAME(1, EXHAT_LVDS0n),
+	UPBOARD_UP2_PIN_NAME(1, EXHAT_LVDS0p),
+	UPBOARD_UP2_PIN_FUNC(1, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_FUNC(1, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS3n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS3p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS4n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS4p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS5n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS5p),
+	UPBOARD_UP2_PIN_NAME(2, I2S_SDO),
+	UPBOARD_UP2_PIN_NAME(2, I2S_SDI),
+	UPBOARD_UP2_PIN_NAME(2, I2S_WS_SYNC),
+	UPBOARD_UP2_PIN_NAME(2, I2S_BCLK),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS6n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS6p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS7n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS7p),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS2n),
+	UPBOARD_UP2_PIN_NAME(2, EXHAT_LVDS2p),
+};
+
+static const unsigned int upboard_up2_rpi_mapping[] = {
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C0_SDA),
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C0_SCL),
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C1_SDA),
+	UPBOARD_UP2_BIT_TO_PIN(1, I2C1_SCL),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO3_ADC0),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO11),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_CLK),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_FS1),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_FS0),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_RXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI1_TXD),
+	UPBOARD_UP2_BIT_TO_PIN(1, SPI1_CLK),
+	UPBOARD_UP2_BIT_TO_PIN(1, PWM0),
+	UPBOARD_UP2_BIT_TO_PIN(1, PWM1),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_TXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_RXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_CTS),
+	UPBOARD_UP2_BIT_TO_PIN(0, UART1_RTS),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_BCLK),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_WS_SYNC),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_SDI),
+	UPBOARD_UP2_BIT_TO_PIN(2, I2S_SDO),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO6_ADC3),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_FS1),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_RXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_TXD),
+	UPBOARD_UP2_BIT_TO_PIN(0, SPI2_FS0),
+	UPBOARD_UP2_BIT_TO_PIN(0, GPIO5_ADC2),
+};
+
+/*
+ * UP Core board + CREX carrier board data
+ */
+
+#define UPBOARD_UPCORE_CREX_BIT_TO_PIN(r, id)				\
+	(UPBOARD_BIT_TO_PIN(r, UPFPGA_UPCORE_CREX_##id))
+
+#define UPBOARD_UPCORE_CREX_PIN_ANON(r, bit)				\
+	{								\
+		.number = UPBOARD_BIT_TO_PIN(r, bit),			\
+	}
+
+#define UPBOARD_UPCORE_CREX_PIN_NAME(r, id)				\
+	{								\
+		.number = UPBOARD_UPCORE_CREX_BIT_TO_PIN(r, id),	\
+		.name = #id,						\
+	}
+
+#define UPBOARD_UPCORE_CREX_PIN_FUNC(r, id, data)			\
+	{								\
+		.number = UPBOARD_UPCORE_CREX_BIT_TO_PIN(r, id),	\
+		.name = #id,						\
+		.drv_data = (void *)(data),				\
+	}
+
+enum upboard_upcore_crex_reg1_fpgabit {
+	UPFPGA_UPCORE_CREX_I2C0_SDA,
+	UPFPGA_UPCORE_CREX_I2C0_SCL,
+	UPFPGA_UPCORE_CREX_I2C1_SDA,
+	UPFPGA_UPCORE_CREX_I2C1_SCL,
+	UPFPGA_UPCORE_CREX_SPI2_CS0,
+	UPFPGA_UPCORE_CREX_SPI2_CS1,
+	UPFPGA_UPCORE_CREX_SPI2_MOSI,
+	UPFPGA_UPCORE_CREX_SPI2_MISO,
+	UPFPGA_UPCORE_CREX_SPI2_CLK,
+	UPFPGA_UPCORE_CREX_UART1_TXD,
+	UPFPGA_UPCORE_CREX_UART1_RXD,
+	UPFPGA_UPCORE_CREX_PWM0,
+	UPFPGA_UPCORE_CREX_PWM1,
+	UPFPGA_UPCORE_CREX_I2S2_FRM,
+	UPFPGA_UPCORE_CREX_I2S2_CLK,
+	UPFPGA_UPCORE_CREX_I2S2_RX,
+};
+
+enum upboard_upcore_crex_reg2_fpgabit {
+	UPFPGA_UPCORE_CREX_I2S2_TX,
+	UPFPGA_UPCORE_CREX_GPIO0,
+	UPFPGA_UPCORE_CREX_GPIO2,
+	UPFPGA_UPCORE_CREX_GPIO3,
+	UPFPGA_UPCORE_CREX_GPIO4,
+	UPFPGA_UPCORE_CREX_GPIO9,
+};
+
+static struct pinctrl_pin_desc upboard_upcore_crex_pins[] = {
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C0_SDA, &upboard_i2c0_reg),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C0_SCL, &upboard_i2c0_reg),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C1_SDA, &upboard_i2c1_reg),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(0, I2C1_SCL, &upboard_i2c1_reg),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_CS0),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_CS1),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_MOSI),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_MISO),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, SPI2_CLK),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, UART1_TXD),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, UART1_RXD),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, PWM0),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, PWM1),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, I2S2_FRM),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, I2S2_CLK),
+	UPBOARD_UPCORE_CREX_PIN_NAME(0, I2S2_RX),
+	/* register 1 */
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, I2S2_TX),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO0),
+	UPBOARD_UPCORE_CREX_PIN_FUNC(1, GPIO2, &upboard_adc0_reg),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO3),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO4),
+	UPBOARD_UPCORE_CREX_PIN_NAME(1, GPIO9),
+};
+
+static unsigned int upboard_upcore_crex_rpi_mapping[] = {
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C0_SDA),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C0_SCL),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C1_SDA),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2C1_SCL),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO0),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO2),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO3),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_CS1),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_CS0),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_MISO),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_MOSI),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, SPI2_CLK),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, PWM0),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, PWM1),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, UART1_TXD),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, UART1_RXD),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO9),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, GPIO4),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2S2_CLK),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2S2_FRM),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(0, I2S2_RX),
+	UPBOARD_UPCORE_CREX_BIT_TO_PIN(1, I2S2_TX),
+};
+
+/*
+ * UP Core board + CRST02 carrier board data
+ */
+
+#define upboard_upcore_crst02_pins		upboard_upcore_crex_pins
+#define upboard_upcore_crst02_rpi_mapping	upboard_upcore_crex_rpi_mapping
+
+static int upboard_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
+			   unsigned int group)
+{
+	return 0;
+}
+
+static int upboard_fpga_request_enable(struct pinctrl_dev *pctldev,
+				       struct pinctrl_gpio_range *range,
+				       unsigned int pin)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+	int ret;
+
+	p = pd->drv_data;
+	if (p->funcbit) {
+		ret = regmap_field_write(p->funcbit, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (p->enbit) {
+		ret = regmap_field_write(p->enbit, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int upboard_fpga_request_free(struct pinctrl_dev *pctldev,
+				     unsigned int pin)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+	int ret;
+
+	p = pd->drv_data;
+	if (p->funcbit) {
+		ret = regmap_field_write(p->funcbit, 1);
+		if (ret)
+			return ret;
+	}
+
+	if (p->enbit) {
+		ret = regmap_field_write(p->enbit, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int upboard_fpga_set_direction(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int pin, bool input)
+{
+	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
+	const struct upboard_pin *p;
+
+	p = pd->drv_data;
+
+	return regmap_field_write(p->dirbit, input);
+}
+
+static int upboard_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *upboard_get_function_name(struct pinctrl_dev *pctldev,
+					     unsigned int selector)
+{
+	return NULL;
+}
+
+static int upboard_get_function_groups(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const char * const **groups,
+				       unsigned int *num_groups)
+{
+	*groups = NULL;
+	*num_groups = 0;
+	return 0;
+}
+
+static const struct pinmux_ops upboard_pinmux_ops = {
+	.get_functions_count = upboard_get_functions_count,
+	.get_function_groups = upboard_get_function_groups,
+	.get_function_name = upboard_get_function_name,
+	.set_mux = upboard_set_mux,
+	.gpio_request_enable = upboard_fpga_request_enable,
+	.gpio_set_direction = upboard_fpga_set_direction,
+};
+
+static int upboard_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *upboard_get_group_name(struct pinctrl_dev *pctldev,
+					  unsigned int selector)
+{
+	return NULL;
+}
+
+static void upboard_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				 unsigned int pin)
+{
+	struct upboard_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	void __iomem *padcfg;
+	u32 cfg0, cfg1, mode;
+
+	if (pctrl->pins[pin].regs == NULL)
+		return;
+
+	cfg0 = readl(pctrl->pins[pin].regs);
+	cfg1 = readl(pctrl->pins[pin].regs + PADCFG1);
+
+	mode = (cfg0 & PADCFG0_PMODE_MASK) >> PADCFG0_PMODE_SHIFT;
+	if (mode == PADCFG0_PMODE_GPIO)
+		seq_puts(s, "GPIO ");
+	else
+		seq_printf(s, "mode %d ", mode);
+
+	seq_printf(s, "0x%08x 0x%08x", cfg0, cfg1);
+
+	/* Dump the additional PADCFG registers if available */
+	padcfg = pctrl->pins[pin].regs + PADCFG2;
+	if (padcfg)
+		seq_printf(s, " 0x%08x", readl(padcfg));
+
+	seq_printf(s, " 0x%p", pctrl->pins[pin].regs);
+}
+
+static const struct pinctrl_ops upboard_pinctrl_ops = {
+	.get_groups_count = upboard_get_groups_count,
+	.get_group_name = upboard_get_group_name,
+	.pin_dbg_show = upboard_pin_dbg_show,
+};
+
+static struct pinctrl_desc upboard_up_pinctrl_desc = {
+	.pins = upboard_up_pins,
+	.npins = ARRAY_SIZE(upboard_up_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct pinctrl_desc upboard_up2_pinctrl_desc = {
+	.pins = upboard_up2_pins,
+	.npins = ARRAY_SIZE(upboard_up2_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct pinctrl_desc upboard_upcore_crex_pinctrl_desc = {
+	.pins = upboard_upcore_crex_pins,
+	.npins = ARRAY_SIZE(upboard_upcore_crex_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct pinctrl_desc upboard_upcore_crst02_pinctrl_desc = {
+	.pins = upboard_upcore_crst02_pins,
+	.npins = ARRAY_SIZE(upboard_upcore_crst02_pins),
+	.pctlops = &upboard_pinctrl_ops,
+	.pmxops = &upboard_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+static void upboard_alt_func_enable(struct gpio_chip *gc, const char *name, int id)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	int offset[pctrl->pctldesc->npins];
+	int i, cnt;
+	bool input;
+	int mode;
+	unsigned int val;
+
+	/* find all pins */
+	for (i = 0, cnt = 0; i < pctrl->pctldesc->npins; i++) {
+		if (strstr(pctrl->pctldesc->pins[i].name, name))
+			offset[cnt++] = i;
+	}
+
+	/* change to alternate function */
+	for (i = 0; i < cnt; i++) {
+		if (pctrl->pins[offset[i]].regs == NULL)
+			continue;
+		input = false;
+		mode = 0; /* default GPIO */
+		val = readl(pctrl->pins[offset[i]].regs);
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2C") ||
+		    strstr(pctrl->pctldesc->pins[offset[i]].name, "PINMUX")) {
+			mode = 1;
+			switch (id) {
+			case BOARD_UPN_ADLN01:
+			case BOARD_UPX_ADLP01:
+				mode = 2;
+				break;
+			default:
+				break;
+			}
+
+			val |= mode<<PADCFG0_PMODE_SHIFT;
+			writel(val, pctrl->pins[offset[i]].regs);
+			upboard_fpga_request_free(pctrl->pctldev, offset[i]);
+			continue;
+		}
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "UART")) {
+			mode = 1;
+			switch (id) {
+			case BOARD_UPN_EHL01:
+				mode = 4;
+				break;
+			case BOARD_UP_ADLN01:
+			case BOARD_UPN_ADLN01:
+			case BOARD_UPX_ADLP01:
+				mode = 2;
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SPI")) {
+			mode = 1;
+			switch (id) {
+			case BOARD_UP_WHL01:
+				mode = 3;
+				break;
+			case BOARD_UP_ADLN01:
+			case BOARD_UPN_ADLN01:
+			case BOARD_UPX_ADLP01:
+				mode = 7;
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MOSI")) {
+					val &= ~PADCFG0_GPIOTXDIS;
+					val |= PADCFG0_GPIORXDIS;
+				}
+
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
+					val |= PADCFG0_GPIORXDIS;
+
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CLK")) {
+					val &= ~PADCFG0_GPIOTXDIS;
+					val |= PADCFG0_GPIORXDIS;
+				}
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS0"))
+					val |= PADCFG0_GPIORXDIS;
+
+				if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS1"))
+					continue;
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2S")) {
+			mode = 1;
+			switch (id) {
+			case BOARD_UPX_ADLP01:
+				mode = 4;
+				break;
+			default:
+				break;
+			}
+		}
+
+		val |= mode<<PADCFG0_PMODE_SHIFT;
+		writel(val, pctrl->pins[offset[i]].regs);
+
+		/* input pins */
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "RX"))
+			input = true;
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CTS"))
+			input = true;
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "ADC")) {
+			input = true;
+			if (id == BOARD_UP_APL01)
+				upboard_fpga_request_enable(pctrl->pctldev, NULL, offset[i]);
+			else
+				upboard_fpga_request_free(pctrl->pctldev, offset[i]);
+		}
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
+			input = true;
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "DIN"))
+			input = true;
+
+		if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SDI"))
+			input = true;
+
+		upboard_fpga_set_direction(pctrl->pctldev, NULL, offset[i], input);
+	}
+}
+
+static int upboard_rpi_to_native_gpio(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[gpio];
+	struct pinctrl_gpio_range *range;
+
+	range = pinctrl_find_gpio_range_from_pin(pctrl->pctldev, pin);
+	if (!range)
+		return -ENODEV;
+
+	return range->base;
+}
+
+static int upboard_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+
+	upboard_fpga_request_enable(pctrl->pctldev, NULL, pin);
+	return pinctrl_gpio_request(gpio);
+}
+
+static void upboard_gpio_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+
+	pinctrl_gpio_free(gpio);
+
+	upboard_alt_func_enable(gc, pctrl->pctldesc->pins[pin].name, pctrl->ident);
+}
+
+static int upboard_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	unsigned int padcfg0;
+
+	if (!pctrl->pins[pin].regs)
+		return -EINVAL;
+
+	padcfg0 = readl(pctrl->pins[pin].regs);
+	if (padcfg0 & PADCFG0_GPIOTXDIS)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int upboard_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	int reg_val = readl(pctrl->pins[pin].regs);
+
+	if (gpio < 0)
+		return gpio;
+
+	/* APL03 board open drain GPIO */
+	if (pctrl->ident == BOARD_UP_APL03) {
+		switch (pin) {
+		case 0:
+		case 1:
+		case 9:
+		case 23:
+			return reg_val & 0x00000003;
+		default:
+			break;
+		}
+	}
+
+	if (!(reg_val & PADCFG0_GPIOTXDIS))
+		return !!(reg_val & PADCFG0_GPIOTXSTATE);
+
+	return !!(reg_val & PADCFG0_GPIORXSTATE);
+}
+
+static void upboard_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			     int value)
+{
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	int reg_val = readl(pctrl->pins[pin].regs);
+
+	if (gpio < 0)
+		return;
+
+	/* APL03 board open drain GPIO */
+	if (pctrl->ident == BOARD_UP_APL03) {
+		switch (pin) {
+		case 0:
+		case 1:
+		case 9:
+		case 23:
+			if (value)
+				reg_val |= PADCFG0_GPIOTXDIS;
+			else
+				reg_val &= ~PADCFG0_GPIOTXDIS;
+
+			writel(reg_val, pctrl->pins[pin].regs);
+			return;
+		default:
+			break;
+		}
+	}
+	if (value)
+		reg_val |= PADCFG0_GPIOTXSTATE;
+	else
+		reg_val &= ~PADCFG0_GPIOTXSTATE;
+	writel(reg_val, pctrl->pins[pin].regs);
+}
+
+static int upboard_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+
+	upboard_fpga_set_direction(pctrl->pctldev, NULL, pin, true);
+
+	return pinctrl_gpio_direction_input(gpio);
+}
+
+static int upboard_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset, int value)
+{
+	int gpio = upboard_rpi_to_native_gpio(gc, offset);
+	struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
+	unsigned int pin = pctrl->rpi_mapping[offset];
+
+	upboard_fpga_set_direction(pctrl->pctldev, NULL, pin, false);
+
+	return pinctrl_gpio_direction_output(gpio);
+}
+
+static void __iomem *upboard_get_regs(struct gpio_chip *gc, unsigned int gpio, unsigned int reg)
+{
+	struct platform_device *pdev = to_platform_device(gc->parent);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+	size_t nregs;
+	void __iomem *base = NULL;
+	u32 offset, value;
+	int pin = gpio-gc->base;
+
+	/* check Intel pin controller for all platform */
+	if (pctrl->ncommunities > 1) {
+		int i, j, offset = 0;
+
+		pin = -1;
+		for (i = 0; i < pctrl->ncommunities; i++) {
+			struct intel_community *community = &pctrl->communities[i];
+
+			for (j = 0; j < community->ngpps ; j++) {
+				struct intel_padgroup gpps = community->gpps[j];
+
+				if (gpio < gc->base + gpps.gpio_base + gpps.size) {
+					res = platform_get_resource(pdev, IORESOURCE_MEM,
+								    community->barno);
+					pin = gpio-gc->base-gpps.gpio_base +
+					      offset-community->pin_base;
+					break;
+				}
+
+				offset += gpps.size;
+			}
+
+			if (pin != -1)
+				break;
+		}
+	}
+
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (base == NULL)
+		return base;
+
+	offset = readl(base + PADBAR);
+	value = readl(base + REVID);
+
+	if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x94)
+		nregs = 4;
+	else
+		nregs = 2;
+
+	return base + offset + reg + pin * nregs * 4;
+}
+
+static int upboard_acpi_node_pin_mapping(struct upboard_fpga *fpga,
+				  struct upboard_pinctrl *pctrl,
+				  const char *propname,
+				  const char *pinctl_name,
+				  unsigned int pin_offset)
+{
+	struct gpio_descs *descs;
+	int ret, i;
+
+	descs = devm_gpiod_get_array(fpga->dev, propname, GPIOD_ASIS);
+	if (IS_ERR(descs)) {
+		ret = PTR_ERR(descs);
+		if (ret != -EPROBE_DEFER)
+			dev_err(fpga->dev, "Failed to get %s GPIOs", propname);
+
+		return ret;
+	}
+
+	for (i = 0; i < descs->ndescs; i++) {
+		struct gpio_desc *desc = descs->desc[i];
+		struct gpio_chip *gc = gpiod_to_chip(desc);
+
+		pctrl->pins[i].gpio = desc_to_gpio(desc);
+		pctrl->pins[i].base = gc->base;
+		pctrl->pins[i].irq = gpiod_to_irq(desc);
+		pctrl->pins[i].regs =
+			upboard_get_regs(gc,
+					 desc_to_gpio(desc) - gc->base,
+					 PADCFG0);
+
+		/* The GPIOs may not be contiguous, so add them 1-by-1 */
+		ret = gpiochip_add_pin_range(gpiod_to_chip(desc), pinctl_name,
+					     desc_to_gpio(desc) - gc->base,
+					     pin_offset + i, 1);
+		if (ret)
+			return ret;
+	}
+
+	/* dispose acpi resource */
+	devm_gpiod_put_array(fpga->dev, descs);
+
+	return ret;
+}
+
+static struct gpio_chip upboard_gpio_chip = {
+	.label = "Raspberry Pi compatible UP GPIO",
+	.base = 0,
+	.request = upboard_gpio_request,
+	.free = upboard_gpio_free,
+	.get = upboard_gpio_get,
+	.set = upboard_gpio_set,
+	.get_direction = upboard_gpio_get_direction,
+	.direction_input = upboard_gpio_direction_input,
+	.direction_output = upboard_gpio_direction_output,
+	.owner = THIS_MODULE,
+};
+
+/* DMI Matches to assign pin mapping driver data */
+static const struct dmi_system_id upboard_dmi_table[] __initconst = {
+	{
+		.ident = BOARD_UP_APL01,
+		.matches = { /* UP SQUARED */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+		},
+	},
+	{
+		.ident = BOARD_UP_APL01,
+		.matches = { /* UP SQUARED Pro*/
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-APL01"),
+		},
+	},
+	{
+		.ident = BOARD_UP_APL03,
+		.matches = { /* UP 4000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
+		},
+	},
+	{
+		.ident = BOARD_UP_WHL01,
+		.matches = { /* UPX WHL */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPX_TGL,
+		.matches = { /* UP i11 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-TGL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPN_EHL01,
+		.matches = { /* UP 6000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-EHL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPS_EHL01,
+		.matches = { /* UP squared v2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-EHL01"),
+		},
+	},
+	{
+		.ident = BOARD_UPX_ADLP01,
+		.matches = { /* UP Xtreme i12 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-ADLP01"),
+		},
+	},
+	{
+		.ident = BOARD_UPN_ADLN01,
+		.matches = { /* UP 7000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-ADLN01"),
+		},
+	},
+	{
+		.ident = BOARD_UPS_ADLP01,
+		.matches = { /* UP Squared i12 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-ADLP01"),
+		},
+	},
+	{
+		.ident = BOARD_UP_ADLN01,
+		.matches = { /* UP 7000 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-ADLN01"),
+		},
+	},
+	{ }	/* Terminating entry */
+};
+
+static int upboard_pinctrl_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const fpga = dev_get_drvdata(pdev->dev.parent);
+	struct pinctrl_desc *pctldesc;
+	struct upboard_pinctrl *pctrl;
+	struct upboard_pin *pins;
+	const struct dmi_system_id *system_id;
+	const unsigned int *rpi_mapping;
+	unsigned int ngpio;
+	int ret;
+	int i;
+	/* default */
+	int board_id = BOARD_UP_APL03;
+
+	/* check board id to arrange driver data */
+	system_id = dmi_first_match(upboard_dmi_table);
+	if (system_id)
+		board_id = system_id->ident;
+	dev_info(&pdev->dev, "Compatible Up Board ID %d", board_id);
+	switch (board_id) {
+	case BOARD_UP_APL01:
+		pctldesc = &upboard_up2_pinctrl_desc;
+		rpi_mapping = upboard_up2_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_up2_rpi_mapping);
+		break;
+	case BOARD_UP_UPCORE:
+		pctldesc = &upboard_upcore_crex_pinctrl_desc;
+		rpi_mapping = upboard_upcore_crex_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_upcore_crex_rpi_mapping);
+		break;
+	case BOARD_UP_CORE_PLUS:
+		pctldesc = &upboard_upcore_crst02_pinctrl_desc;
+		rpi_mapping = upboard_upcore_crst02_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_upcore_crst02_rpi_mapping);
+		break;
+	default:
+		pctldesc = &upboard_up_pinctrl_desc;
+		rpi_mapping = upboard_up_rpi_mapping;
+		ngpio = ARRAY_SIZE(upboard_up_rpi_mapping);
+		break;
+	}
+
+	pctldesc->name = dev_name(&pdev->dev);
+
+	pins = devm_kcalloc(&pdev->dev, pctldesc->npins, sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	/* initialise pins */
+	for (i = 0; i < pctldesc->npins; i++) {
+		struct upboard_pin *pin = &pins[i];
+		struct pinctrl_pin_desc *pd = (struct pinctrl_pin_desc *) &pctldesc->pins[i];
+		struct reg_field fldconf = {0};
+		unsigned int regoff = (pd->number / UPFPGA_REGISTER_SIZE);
+		unsigned int lsb = pd->number % UPFPGA_REGISTER_SIZE;
+
+		pin->funcbit = NULL;
+
+		if (pd->drv_data) {
+			fldconf = *(struct reg_field *)pd->drv_data;
+
+			pin->funcbit = devm_regmap_field_alloc(&pdev->dev,
+							       fpga->regmap,
+							       fldconf);
+			if (IS_ERR(pin->funcbit))
+				return PTR_ERR(pin->funcbit);
+		}
+
+		fldconf.reg = UPFPGA_REG_GPIO_EN0 + regoff;
+		fldconf.lsb = lsb;
+		fldconf.msb = lsb;
+
+		pin->enbit = devm_regmap_field_alloc(&pdev->dev,
+						     fpga->regmap,
+						     fldconf);
+		if (IS_ERR(pin->enbit))
+			return PTR_ERR(pin->enbit);
+
+		fldconf.reg = UPFPGA_REG_GPIO_DIR0 + regoff;
+		fldconf.lsb = lsb;
+		fldconf.msb = lsb;
+
+		pin->dirbit = devm_regmap_field_alloc(&pdev->dev,
+						      fpga->regmap,
+						      fldconf);
+		if (IS_ERR(pin->dirbit))
+			return PTR_ERR(pin->dirbit);
+
+		pd->drv_data = pin;
+	}
+
+	/* create a new pinctrl device and register it */
+	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
+	if (!pctrl)
+		return -ENOMEM;
+
+	pctrl->rpi_mapping = rpi_mapping;
+	pctrl->chip = upboard_gpio_chip;
+	pctrl->pctldesc = pctldesc;
+	pctrl->chip.parent = &pdev->dev;
+	pctrl->chip.ngpio = ngpio;
+	pctrl->pins = pins;
+	pctrl->ident = board_id;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &pctrl->chip, pctrl);
+	if (ret)
+		return ret;
+
+	pctrl->pctldev = devm_pinctrl_register(&pdev->dev, pctldesc, pctrl);
+	if (IS_ERR(pctrl->pctldev))
+		return PTR_ERR(pctrl->pctldev);
+
+	/* add acpi pin mapping according to external-gpios key */
+	ret = upboard_acpi_node_pin_mapping(fpga, pctrl,
+					    "external",
+					    dev_name(&pdev->dev),
+					    0);
+	if (ret)
+		return ret;
+
+	upboard_alt_func_enable(&pctrl->chip, "I2C",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "SPI",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "UART",   pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "I2S",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "PWM",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "ADC",    pctrl->ident);
+	upboard_alt_func_enable(&pctrl->chip, "PINMUX", pctrl->ident);
+
+	return ret;
+}
+
+static struct platform_driver upboard_pinctrl_driver = {
+	.driver = {
+		.name = "upboard-pinctrl",
+	},
+};
+module_platform_driver_probe(upboard_pinctrl_driver, upboard_pinctrl_probe);
+
+MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
+MODULE_DESCRIPTION("UP Board HAT pin controller driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-pinctrl");
-- 
2.17.1


