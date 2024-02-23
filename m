Return-Path: <linux-kernel+bounces-77965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150C860D67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CC91C25208
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87122067;
	Fri, 23 Feb 2024 08:59:49 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2131.outbound.protection.partner.outlook.cn [139.219.17.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2061B59C;
	Fri, 23 Feb 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678788; cv=fail; b=bWTog8fQ5TT5PO1BkjZadfxilzHhwbZYdt6vdNQxMFf36C25I81IboDXNAPmXvxS7SOrcr0gslhhP03+Acd8u4ZRmfwX/jLCKq7tM6TZsMpDyvCJgzIFq1ir+ql5XWTN/hK6VxSGl6f0KDocOwPjW86rlYSETo7ef/R9kKDCyQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678788; c=relaxed/simple;
	bh=zQkJb4JLscsPirq8bN3z7FhbSlp9T/mSna6RxIg3Xko=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YMVinLwLUjgwb9a1vTHgvFJe8LKCxYg2R26bS91Q0KY980rXUGm3jkc+dJ3F4aMQzpz2MFLYWVk+OENdsjvhfKcxTAB4ZYG0Aac4tiFmtGUmqhph1Uu4VNo0uEoc5eztxKVeFFKVrScjOTXLDh5RnSYVW6vm+9KxPh+reNMNJqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz7gAcKXKfKOoqNqxbJlKL3kTBZVZW6pBySn4OVbSe8+qPt3mv0aomPX9dyhcInukJRrPP1mhV7jf+BKQ377Ihe7oQSLy0jZYORA9wDzTQFIAl0SPMRoBmqp8bp9D1jL5RZlXVsvNccHiHIeSFUFmiuF49oCIzlCGtdVhQSDZj/SwaOeYU9fVVZlskyy1Y4JGQ3Vxwrp5yMGLDEy5f0Qt+GodtDKHWvfCxe1xZjfuMrWW1m1k7xf9C0BoUedyYTPioqwV5fxwEMTPMxU4GBLHIXY7tTViGrHQExLXhmO+eEZM9cWwztlNX8jIZZ7JXuXLiwAq1ecj5Q4lDqhswZ/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6pAsBP5+6SDjubTRP2MJ666KO/KtCTKeE47PwgbW9Q=;
 b=eXuuJr3NxGPCu5ELgXkLIkHf68UkTm8t5wZJBIY0zC5ip/VbFqe2hIRXLfaM7XuxeCAtpySdJdU5zlA/H8Ubqodh6t3X2VEr/42hcRA0Scw6skJasi5JEOk2+nqcrSXb96bZMvKTud6UIOfsNQQ4EZM2QxDfw53vm5+jhqrmcAnQj48K6Cry+yebEAVtzlwNeiZnuuIqzY9dDV4Hjq4RuAlRSHPAM1mrtVTkPn6aaBSbyExw/zREsnD4U7Gx6HZm1Vf4RhhK/gk4+QfNOVQdFEKzqGDtXHCCVqcfK2FP3Odx8B6h/OUjjSd6/tY3DqHgMvhu8rwQXSGU8Rr+6X+R1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB0967.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Fri, 23 Feb
 2024 08:43:39 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::380f:84dd:fec:a39]) by ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::380f:84dd:fec:a39%4]) with mapi id 15.20.7270.047; Fri, 23 Feb 2024
 08:43:39 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v11] pwm: opencores: Add PWM driver support
Date: Fri, 23 Feb 2024 16:43:32 +0800
Message-Id: <20240223084332.100410-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn (10.43.33.22)
 To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn (10.2.3.232)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB0967:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdeb5c4-af75-452e-189a-08dc344b885f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lcmOrupSrDYmjnH/qLn5mu0V3VK2RIBb9EEUJBcAFKiRyP+01m4TT0HJXAweU7iom3nYIdXYAxBr+DcJARr/yymKNddlAzzlx8s3NqJz6xNKyqr48fHFfMR3RKqxUiPvb8GfJx6KgNGrT5jSo0+r9gWhMWwVp/N5NPSOTM6L6li/JU8BYmb1jBiUyvbsk/qZl3nIOcXKupCCWo5tYTr9xwFys75ujoZeNkjJqGAo1MaAUivNNRYux+rO3gyQ+kNhBwNedH1xrcW+YrDSjdr5ZNY8BD3we/QJ8SuLiJ788Vdrs9uN+OlDoy7UwBuPDm9/5bbyNgkU3B9nuEGsyZZD1STAZpBK1/pHhetZYwRMQ4ZWn9uKq+WyV+mGwBG2/NiHEK1jaHxxnA7K+RH11ga445gNkqJNRwSCNjLUrxtMUqnAJrL3dxupOUPMnDrL5NgkxkVA23cnFdI2D5zz96SfkR5IlZ9XYy6NyFK6O10QU4AB0XIYgmdcw/BYmXNtI915YlKrwl7aT3YNyHJCiHWDhFiifhXtmRDFyEqfcoxmUGxHdHRJnRSHd9/fGb341ghz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6u6Hmi/IFMcFNP6h1yfZzNt4sScEVEIYe26WokhdlDAVNU1yuWc9Vb3FpRw?=
 =?us-ascii?Q?29nu4dwrRxcBbVrBh3oA+WKxQFzXnqPfK82qhr50VzXatILbkum8Rq6mVSD8?=
 =?us-ascii?Q?KT38dGBqqWb1xNgFEsddpRw3Y6PzWylkLCcuryK4PhAv7QpffQRx7EKVOnIM?=
 =?us-ascii?Q?5+ApX3yYxGkI4JrdIGdDpX+gqOqCgupgy6M3e45R0yU24qKyA3VXszzdqfxX?=
 =?us-ascii?Q?Csp1QnKpSNjZxeRrD5MPkbp4pBHr+R84W8mEdD3er/YLPcbbyb+VOgqg88fs?=
 =?us-ascii?Q?gtzJQohnwx8BAeCSlwfdgFPJFyIYSVmysq7VAhtfFjU/onLPa9S88jobB/vM?=
 =?us-ascii?Q?79NuA7TN2s+/mAVUhuu5PwIkl1++a7jOjcey9WyF+7b4grQF6Y0XjKUPLsVm?=
 =?us-ascii?Q?2Hq5vGjJmDy2TZoyPp/QrXiD6mnIA4aqMLRmecZjj6O78paRc1JIJK5+dQj/?=
 =?us-ascii?Q?RcNIGNHn84riFBlQqiz7bqWy3C+FITh32gWxe+w7I4fsFsuOoAGOyNROiYcT?=
 =?us-ascii?Q?4G9UqNDgyiPSdBZV8HYe/D+zHHHM546p7WSWxroJhnMA8hXH0IA9/4obS4On?=
 =?us-ascii?Q?wa60MzSkMiiBmWZ/gRXc1LxlqDukU+Q+t1spONIian4Ldd4/rGL/IQvi2ml+?=
 =?us-ascii?Q?HjGsTd9AwG/lkt1dYDeg1cGCvCHDQSId/P8QcRC9iXgRms7trMzpamjZmpgW?=
 =?us-ascii?Q?mI4TyqpUvpMPNuyo7GvpR0p5mvmxVBgx5VlmvWcF5HY4EDfSnSoNdgKLh8OL?=
 =?us-ascii?Q?Ok6/b9a9GYNs/PBB3k07AJd8+sKIZuOb+VsG/QdiYKC6dVXSJH48gF6oOAzT?=
 =?us-ascii?Q?CB4hj7IX7wPr9W16OG+FYlDJK4zQJU17rQxVtztSIHn/L7H+XwOo/Bfx3ltr?=
 =?us-ascii?Q?SyCdEdUJCP7yyLExcRDdXoUaIMB5DxDJYhP8MviXgLooMhXRQv5g7ZXtjVPu?=
 =?us-ascii?Q?79r2L4DD0wgq9z70nNvHpjSgTdYAi2lqILu3EzTIAtfbBLHnZdCG0F7hFb66?=
 =?us-ascii?Q?BrWzl9+er2D2e8jlKVRGLLybrfzYx3oLN5PEsfX/LoIAln1VeWUqUBe1I7QL?=
 =?us-ascii?Q?nX4vM6QVZBeBTbUNU5BRfDxFEucmg9GKOJyh5IrvruHAOIaXV4UO49hoNUnZ?=
 =?us-ascii?Q?nZ1NXJxUGyucDTecnSZekva9QjIWUix0Z+LuR/PmP/crwZJ1FiaymCOAGVN2?=
 =?us-ascii?Q?Mche42xcC1G3AYHoU1UUTA+y4wMGWU3lWvjWHVsKwxge4GWb7Hu6HiWMOykN?=
 =?us-ascii?Q?dmByETmPPFNKYSR36RMm05bFAwVwUNwt11/s2o0D3DLssPLAGF6lJiDk6LuH?=
 =?us-ascii?Q?Nocu98gULoxdve+5AnZwdH0Ki3z4VHECH5PJE2orNCylGE+FX8IOF+NRnyfc?=
 =?us-ascii?Q?4zzlLs+DGu9w566bllKfQZ9K0jtBZdV0sSHbR1NnmO4MUWzB4/Qre4Bc64Uy?=
 =?us-ascii?Q?tOZPE53QtkqWxbQwtmS4JfTIi7ErM/7nGK3NL2ttBTeb02gIsEtMHLDYD1Nu?=
 =?us-ascii?Q?Pbf3CcdbKeklgXYQD2zjfvxTNqFGlz0dJ4sP7B5mXNAozkCDwmVI1wQ0TMCe?=
 =?us-ascii?Q?z/iwsnMS04g7yWBgemLUYRxMIzERqweRuBe4Nky5cQrJbijPZU+FtyfQm1s8?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdeb5c4-af75-452e-189a-08dc344b885f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:43:39.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxTx2BpUzCKmnoM978t++j5nhn+2f6Spn/LCoSBEi/Ej9hr5E1hW36tCjX12SgUAvCBE2f8F6cUgu2VDLbhlDiskax35OqpwxdWYG6xNJOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0967

Add driver for OpenCores PWM Controller. And add compatibility code
which based on StarFive SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS              |   7 ++
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 232 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..12ea5e86fc23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16414,6 +16414,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 4b956d661755..d87e1bb350ba 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -444,6 +444,18 @@ config PWM_NTXEC
 	  controller found in certain e-book readers designed by the original
 	  design manufacturer Netronix.
 
+config PWM_OCORES
+	tristate "OpenCores PWM support"
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
index 000000000000..874bc630bf2d
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,232 @@
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
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct reset_control *rst;
+	const struct ocores_pwm_data *data;
+	void __iomem *regs;
+	u32 clk_rate; /* PWM APB clock frequency */
+};
+
+struct ocores_pwm_data {
+	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
+};
+
+static inline u32 ocores_readl(struct ocores_pwm_device *ddata,
+			       unsigned int channel,
+			       unsigned int offset)
+{
+	void __iomem *base = ddata->data->get_ch_base ?
+			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
+
+	return readl(base + offset);
+}
+
+static inline void ocores_writel(struct ocores_pwm_device *ddata,
+				 unsigned int channel,
+				 unsigned int offset, u32 val)
+{
+	void __iomem *base = ddata->data->get_ch_base ?
+			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
+
+	writel(val, base + offset);
+}
+
+static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ocores_pwm_device, chip);
+}
+
+static void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
+						 unsigned int channel)
+{
+	unsigned int offset = (channel > 3 ? 1 << 15 : 0) + (channel & 3) * 0x10;
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
+	period_data = ocores_readl(ddata, pwm->hwpwm, 0x8);
+	duty_data = ocores_readl(ddata, pwm->hwpwm, 0x4);
+	ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
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
+	ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
+	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
+
+	period_data = DIV_ROUND_DOWN_ULL(state->period * ddata->clk_rate, NSEC_PER_SEC);
+	if (period_data <= U32_MAX)
+		ocores_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
+	else
+		return -EINVAL;
+
+	duty_data = DIV_ROUND_DOWN_ULL(state->duty_cycle * ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data <= U32_MAX)
+		ocores_writel(ddata, pwm->hwpwm, 0x4, (u32)duty_data);
+	else
+		return -EINVAL;
+
+	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
+
+	if (state->enabled) {
+		ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
+		ocores_writel(ddata, pwm->hwpwm, 0xC, ctrl_data | REG_OCPWM_EN | REG_OCPWM_OE);
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
+static void ocores_reset_control_assert(void *data)
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
+	int ret;
+
+	id = of_match_device(ocores_pwm_of_match, dev);
+	if (!id)
+		return -EINVAL;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->data = id->data;
+	chip = &ddata->chip;
+	chip->dev = dev;
+	chip->ops = &ocores_pwm_ops;
+	chip->npwm = 8;
+
+	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->regs))
+		return dev_err_probe(dev, PTR_ERR(ddata->regs),
+				     "Unable to map IO resources\n");
+
+	ddata->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(ddata->clk))
+		return dev_err_probe(dev, PTR_ERR(ddata->clk),
+				     "Unable to get pwm's clock\n");
+
+	ddata->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(ddata->rst))
+		return dev_err_probe(dev, PTR_ERR(ddata->rst),
+				     "Unable to get pwm's reset\n");
+
+	reset_control_deassert(ddata->rst);
+
+	ret = devm_add_action_or_reset(dev, ocores_reset_control_assert, ddata->rst);
+	if (ret)
+		return ret;
+
+	ddata->clk_rate = clk_get_rate(ddata->clk);
+	if (ddata->clk_rate <= 0)
+		return dev_err_probe(dev, ddata->clk_rate,
+				     "Unable to get clock's rate\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+
+	platform_set_drvdata(pdev, ddata);
+
+	return ret;
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
+MODULE_DESCRIPTION("OpenCores PWM PTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


