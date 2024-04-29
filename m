Return-Path: <linux-kernel+bounces-161881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F958B52A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DF2B2120B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64416419;
	Mon, 29 Apr 2024 07:52:03 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417717BAE;
	Mon, 29 Apr 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377122; cv=fail; b=EXchqS0S5xtD1F0bQxCCyE3OChq05mVRXw7E0As9TO0rHsxEvef17jO0G3kWJ6Y635lA7rKvJPcmcrX7RZIElA2/c/G0/fTSpKTKKaG9n8E9ZCDKgqGLjawfaAp8Gy5Szn7quuzUtPbEswGTFBp1wCvtSdHls1ROja28UPzJNEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377122; c=relaxed/simple;
	bh=/Q0l11IGrXE3mcJuZLB8tYWdRlACoYmVnCXd1ei4af8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DREBQ6dZ8diff3tVSpYQoj6x38g/m0rKR4mVQPdYrgkrp/8Jm4zq/yJLjmwk8eODoJTZt896UaAZnTyQQYPk/UT+ZvFCb/ZfG9UDY+4r7HDyqeCdkAH81/YAZAqzgn67GkZOy1cBJqbVzgC5+22MatrjpJ9tUu5vRoW8TQhJc+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETgvPPuZ6yg/11vZMtkzfcxcJ82B6FuRtGue9ZZWOYBiLthDVLZ1sZrghqJ0/5zmuSlhSXwArlDhaNi0XPb3UFC2cR0TjPJoiUafs8p9jXCFoegQDlWgDEoybyJyrXWv12ogJZKg6Y/KezOkwRJhrFQk2FE67BYtoT76D5DTx4VsRZ4E0TpLKuwo5r2tMenNcIEIGBXe0cKu/X2t/Q2+EVDOSd9+3qzedWYOc8nf9twWU16VvBd2WCeDOUflksnVuR7EAayi2Uy8gNNSF2teob6YRet9H8alAh5HgpjE2WyuS3AIhd27JTbWvpfuOIvV+NvY3oM4JrbdSoV2dUOo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99/xs6t2Eul9ExvregowuX4WiJ2swVXzo0u32yrB1q0=;
 b=YQgdCwj8Kr/014gS1I7A0PJOywomz+ddS9HeW5vxXmazl9l8pfoqnLCGIeOAxHFYMP+kVFcNLOwExlkA+mmEkzyoUKti6vBJjJR7g79Zmj3N9AbTmBUFa5xOR4Q+2DZMibt+3xm2uHcWuy1icOdvBcJtHZyIUDKu2ZYaqTxJv5eEMn8HnZI0saCuokUqjv2Xnl8qn0YUXlDsR0/cJd18Y8O/spsuZnQxBRRYmDH6ZkFIyj1U5fGWLJrcFSpjCixxI0JRSXU4cMtABQXfgar0cZxsjOO/xO5g1/eEbkW0E2w6gR8UizVWFIjNYAbVGWPEkrOp3SP3lS1UT5viNaokSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1173.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 07:51:47 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::4f3f:f537:9330:dbdd]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::4f3f:f537:9330:dbdd%7])
 with mapi id 15.20.7472.044; Mon, 29 Apr 2024 07:51:46 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v12] pwm: opencores: Add PWM driver support
Date: Mon, 29 Apr 2024 15:51:40 +0800
Message-Id: <20240429075140.56867-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::14) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8358cb80-dafa-4913-fa79-08dc6821383a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHcDcQiXU+yGyWzT2AixyvtaGFv9oKFn/8tIt4wAXQtCDa105fQHC1B7IfjWxfSlBPuPFvXg5HgC1b/YFt7hO+G9utmpqpux3mKGMFlgVkttrlmhz7iUBK8CjpocdHa1wtU3UesiAf09lfgyZVgtElkyVtjyUhaR3LHx8GA4IueXGFFELabqErM+VfKik6TAXRGcD/67caNmHU4N6BIlhQHv5sSLEO96w6CTe6IBF7nEkWUnhqd2B9dNF3w7EkY2IZTOQyFnukIonIHe31hPBnWPtlOgKjmxuVSTFTmiGrOaRLuEococbnhLaLQXl+5LVoxWUo0EErQwY7rOF+TvzN+k9cgJts00VEcZg4hvPEGPQ+VFGkpn1oSwsONh6mtnohihrCKp/7XjGROgVwWIEBp/3M+BOfmfzGtGGz540UIIS+Ek8PikNKxO5ACAAjpQxOE8G2XYgEXm68ltKRS8dkarBhggUXPZQ7+pxfZbUM92R6XHsch/stLAhPlpr2lf0lYJ40zN/UZRI4uIN+05VfeJeuQXhOWVDfINxs6uLm2PPusH9PHeMC3D1gpP1yPsBjd3kc8buYJVWQBSplApKH0rsPAB84OVNxaou5UoF1EFqB7vk0d8HRcS8ypGQAZu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6IRurcWIdMBvx7hEWTCjwazewhQvd/vthEF+gjBozx6jbbgjOEbgQ0Nsqx2?=
 =?us-ascii?Q?m1NvOojC/FTJZGLW1hjWoKnBgfG/YRQLe3TnWhrdhC46YY+LzfdTX+Jp639H?=
 =?us-ascii?Q?bcmL8gxnwhWxfUJbscVVnD0Hp/mvaBAy8S9XefH4+T4c0xpDSQXG9tR4M7lE?=
 =?us-ascii?Q?bxGuKP9HB4+4kTnw81IOHxfyGAqSJmGFYY3Vc8Q2DF6cG0NCws0LcTp9ob1h?=
 =?us-ascii?Q?BM1wT8CRAXBKkiHfreCIGQ62cqr3IX2Fp0rYCXuIHSedDXYiQG1bsMW7oAFW?=
 =?us-ascii?Q?WYxtmW6OlA1P8v0MF58n5RmSvjS5lEIFhuJreffq1yyg/r4qa93CdFYyutmi?=
 =?us-ascii?Q?JsU126VFeMQkriVmgSa+kx9S5dcv6kkmMT+sugeYvrpQ10gBDlVAVcQjbJYV?=
 =?us-ascii?Q?5RfhNU0gjN5/1LpLniiLaRl9xRCBclcfNyxr/Cjxx8VmFa/FLCWiwYJef6qI?=
 =?us-ascii?Q?F/9ZPOex0c7GDTYL02q6ECB8hvcdBIUCFvtoUaX+9AhhZJhA+VhnRLz6o9ej?=
 =?us-ascii?Q?bexiyTjd5l7UjttGFFA7KfsJCp7I4AQTq6GX6Y2qOAq4PRAcK/lYDTeDfBWi?=
 =?us-ascii?Q?lA1yY/24JW0ioYF2wFoKBBGDc7vDCzrUtYXqi2An6eicC8ZCgP3k7//VKQAZ?=
 =?us-ascii?Q?ROXptBS5BbyusArqf0PEUSGLuhOcyzF/P3MumXdA5nL3TXIUbGKsd9H16lTm?=
 =?us-ascii?Q?t5wE/29u2v8Uf7R1e3h8cNxt/ZTCrk0DUIBcq4Dxkgz5vx7R4T9SaaQEb+W9?=
 =?us-ascii?Q?q/t91AXBXW07Pg/2xIIghioaC46oB5NhFJPhQ6/d4ZceEpwsO4H7mTiLuHxJ?=
 =?us-ascii?Q?Q2J8RLWM52yxQhcYo2dYh066cLtyWcsNV9eJH4nym5MXlkjGYQslT8HSwZ2X?=
 =?us-ascii?Q?RUSj4LZIH/cVJ9MKXKu5oeRs2dznyfO5XRbG8G95BHmFkb+RTWO8g1fZ9TOv?=
 =?us-ascii?Q?jJM9fytitfBLgjF/YDpv9PrI0Zo4XD6FFU6lZEieIzPDkCye3bNTLfsJHNqP?=
 =?us-ascii?Q?7ujq2UVaqeUPCaqc/WNk2B5SKuFw0RIfaIp9tyLpCUqPqWvuY8nDFcXQHs97?=
 =?us-ascii?Q?1S55jtBqm54MxigyEzrROm+RPDiX+VDVf9RQATYdos6WWQc7sI8fyAiHm8sx?=
 =?us-ascii?Q?bqf195qcFt4cc9Wj/u2PeynXPRTu6ZncPdJFVQuSUIXJdL8Lr8E2VbzalmCz?=
 =?us-ascii?Q?GbE5fReLVI6ZlTBAUfAxso92FvHUQTenD3n5GXN82YhTzYO1vVXUNsN4snnC?=
 =?us-ascii?Q?c5OuVSNJFUQW0pHGwqZOSX6S3DbATOInMmL1qhfVq0wzFCoAuVnHRHAaEy3+?=
 =?us-ascii?Q?O6+s6bXZIENNVgSb9cXlo2/7TbOVPPPk3OGm9Jb03/xGdbdUaLF8AybMhiP3?=
 =?us-ascii?Q?627idjinj+tiUWaNlAXC7yv2OYP154lNHPcMTfyChhV3GeUobwGLbtvc8l8c?=
 =?us-ascii?Q?RFvbSlOLxlJ6pX3lfXp8h7EQE6SlRjPH3g1evDDeblZTqAEI3xypXfyOdVc0?=
 =?us-ascii?Q?KZrJvZ5svdIOJyVXdDHfj05xEntYTUi6oHnicbpnblQTeQgc564LfMXa96v6?=
 =?us-ascii?Q?tKgLkA1Q8l7M0DEkvSZz6vrI3X2gpaJrVbCC4yXvenaVrjnbIiLNnXIviBdz?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8358cb80-dafa-4913-fa79-08dc6821383a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:51:46.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtiJv+esLm/BBK8pMJj7KcblRU+YwbljXlXnoPFkLlmn0t5pIqkNXIbLTO8EvR3RVCG1yPZqxQskDakPWwV/V3Daxizo6pXLO2PxFPjw+wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1173

Add driver for OpenCores PWM Controller. And add compatibility code
which based on StarFive SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS              |   7 ++
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 240 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..eb3ff739998f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16548,6 +16548,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
 F:	drivers/i2c/busses/i2c-ocores.c
 F:	include/linux/platform_data/i2c-ocores.h
 
+OPENCORES PWM DRIVER
+M:	William Qiu <william.qiu@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+F:	drivers/pwm/pwm-ocores.c
+
 OPENRISC ARCHITECTURE
 M:	Jonas Bonn <jonas@southpole.se>
 M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..92acce23298d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -444,6 +444,18 @@ config PWM_NTXEC
 	  controller found in certain e-book readers designed by the original
 	  design manufacturer Netronix.
 
+config PWM_OCORES
+	tristate "OpenCores PTC PWM support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK && RESET_CONTROLLER
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	help
+	  If you say yes to this option, support will be included for the
+	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ocores.
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..517c4f643058 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..039fb3c526a7
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenCores PWM Driver
+ *
+ * https://opencores.org/projects/ptc
+ *
+ * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
+ *
+ * Limitations:
+ * - The hardware only do inverted polarity.
+ * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency) ns.
+ * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency) ns.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+/* OpenCores Register offsets */
+#define REG_OCPWM_CNTR    0x0
+#define REG_OCPWM_HRC     0x4
+#define REG_OCPWM_LRC     0x8
+#define REG_OCPWM_CTRL    0xC
+
+/* OCPWM_CTRL register bits*/
+#define REG_OCPWM_EN      BIT(0)
+#define REG_OCPWM_ECLK    BIT(1)
+#define REG_OCPWM_NEC     BIT(2)
+#define REG_OCPWM_OE      BIT(3)
+#define REG_OCPWM_SIGNLE  BIT(4)
+#define REG_OCPWM_INTE    BIT(5)
+#define REG_OCPWM_INT     BIT(6)
+#define REG_OCPWM_CNTRRST BIT(7)
+#define REG_OCPWM_CAPTE   BIT(8)
+
+struct ocores_pwm_device {
+	const struct ocores_pwm_data *data;
+	void __iomem *regs;
+	u32 clk_rate; /* PWM APB clock frequency */
+};
+
+struct ocores_pwm_data {
+	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
+};
+
+static inline u32 ocores_pwm_readl(struct ocores_pwm_device *ddata,
+				   unsigned int channel,
+				   unsigned int offset)
+{
+	void __iomem *base = ddata->data->get_ch_base ?
+			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
+
+	return readl(base + offset);
+}
+
+static inline void ocores_pwm_writel(struct ocores_pwm_device *ddata,
+				     unsigned int channel,
+				     unsigned int offset, u32 val)
+{
+	void __iomem *base = ddata->data->get_ch_base ?
+			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
+
+	writel(val, base + offset);
+}
+
+static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
+						 unsigned int channel)
+{
+	unsigned int offset = (channel & 4) << 13 | (channel & 3) << 4;
+
+	return base + offset;
+}
+
+static int ocores_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
+	u32 period_data, duty_data, ctrl_data;
+
+	period_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_LRC);
+	duty_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_HRC);
+	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
+
+	state->period = DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, ddata->clk_rate);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, ddata->clk_rate);
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = (ctrl_data & REG_OCPWM_EN) ? true : false;
+
+	return 0;
+}
+
+static int ocores_pwm_apply(struct pwm_chip *chip,
+			    struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
+	u32 ctrl_data = 0;
+	u64 period_data, duty_data;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
+	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL, 0);
+
+	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
+	if (period_data > U32_MAX)
+		period_data = U32_MAX;
+	else if (period_data > 0)
+		ocores_pwm_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
+	else
+		return -EINVAL;
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data <= U32_MAX)
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
+	else
+		return -EINVAL;
+
+	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CNTR, 0);
+
+	if (state->enabled) {
+		ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
+				  ctrl_data | REG_OCPWM_EN | REG_OCPWM_OE);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops ocores_pwm_ops = {
+	.get_state	= ocores_pwm_get_state,
+	.apply		= ocores_pwm_apply,
+};
+
+static const struct ocores_pwm_data jh7100_pwm_data = {
+	.get_ch_base = starfive_jh71x0_get_ch_base,
+};
+
+static const struct ocores_pwm_data jh7110_pwm_data = {
+	.get_ch_base = starfive_jh71x0_get_ch_base,
+};
+
+static const struct of_device_id ocores_pwm_of_match[] = {
+	{ .compatible = "opencores,pwm-v1" },
+	{ .compatible = "starfive,jh7100-pwm", .data = &jh7100_pwm_data},
+	{ .compatible = "starfive,jh7110-pwm", .data = &jh7110_pwm_data},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
+
+static void ocores_pwm_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int ocores_pwm_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct device *dev = &pdev->dev;
+	struct ocores_pwm_device *ddata;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	struct reset_control *rst;
+	int ret;
+
+	id = of_match_device(ocores_pwm_of_match, dev);
+	if (!id)
+		return -EINVAL;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return -ENOMEM;
+
+	ddata = chip_to_ocores(chip);
+	ddata->data = id->data;
+	chip->ops = &ocores_pwm_ops;
+
+	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->regs))
+		return dev_err_probe(dev, PTR_ERR(ddata->regs),
+				     "Unable to map IO resources\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Unable to get pwm's clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return ret;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Unable to get pwm's reset\n");
+
+	reset_control_deassert(rst);
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
+	if (ret)
+		return ret;
+
+	ddata->clk_rate = clk_get_rate(clk);
+	if (ddata->clk_rate <= 0 || ddata->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(dev, ddata->clk_rate,
+				     "Unable to get clock's rate\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver ocores_pwm_driver = {
+	.probe = ocores_pwm_probe,
+	.driver = {
+		.name = "ocores-pwm",
+		.of_match_table = ocores_pwm_of_match,
+	},
+};
+module_platform_driver(ocores_pwm_driver);
+
+MODULE_AUTHOR("Jieqin Chen");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("OpenCores PTC PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


