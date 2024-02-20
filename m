Return-Path: <linux-kernel+bounces-72421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C8985B30D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC862866A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709A5820E;
	Tue, 20 Feb 2024 06:44:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573A2E414;
	Tue, 20 Feb 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411465; cv=fail; b=TXirx8vUXaK9jnHP35PSLFDiifIBFN6OjktB7pjNrxRiVaxoWkmwYGZwreDkrsMPllEGoG+GpSa/JpKBhFN0ie/2cZZo+ySigJ25VRra5zuIGlGmZnU9uWoeAEd2vq/RwQpotHAUNVWcY075IQIAruGpqzkl3VraQLfqwDFxWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411465; c=relaxed/simple;
	bh=PDDq4HIOyD97U7xTm6wo10tA/eBAMmmvdK8Zg+POgHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6ww6NL6hwAwC0WvLGBaHkwRvAt9enbLZdc8Co3pRKkF9xydHqxJK5+j0rsS0/+mVZG2zuvty+AMJ26/i2NV4sE7a+YTYm1B5FVevIbbGpFHOiC8cVOLLqLums/tqmqlg2YohJBSM0hlDhZLnJYK6/z2uAItziLeeuehMRAdcag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6gBxZ2XcVypRZZHGAT+Yu90xf4J6nrVwF3sCZfkOVL5VG7IbVFy2iSPV6qlWjEhz6rmTu94DgtplYHA32DX+VeMXvd32zBfgE4/kBWSFgdCjIZ3ANbqqSyE3Kb7CbjNhEFByzQ12g8clD+wEGcViZ3Rux6bIIFOoLpAshtj+Qojb9Mmca7FK9cZlDnrVyQTPtWg68aq3yVkZd9OXl/QZO23EPVQ/+LWEzmkrkB/CfEr/2ua9BCTj/gyWyfn+048LRUYRAtk2KWNO2EEQqH3muKsQeS9fNZik/8ekCZScACM69qSBcqtX2vW9HQZn4H4a6s9yhIwdLKAbGrSUCmL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBg/4vBCKxIjllDZf7iZrHzT9vCut7ZumNWh3lJZ9pQ=;
 b=TtZ9mGwN7u1SiuOQbmz9k72M9yPgzcFTlITsl/gToA72jzVrRGXGN0+iKxX1ur27LbJmbHIbK8H8v+uNUtsZ4IzVa3Wiox2boEMCp7ZXo3C+30oTZ8IQ6qdt4mIwQ9Aq3J4KDoZzJi7KoOzh9QK4Sr8RxAhydZP27EzzpNf4KIcyGW5dprx2yU4f/28HAEfXJ+Qj87cPoOgLRvmu9YbDPaclCJwhOvPGy3zfWgIxuy/PWsfRjoMjfdcDtgUH3aZ0+yq8jBuyRyXzyCeFXdDYvMjScs9ATvc5oeEpnkaHQGs89p+1e1spDpsoFx8xALRMSdL0d+wdP5EGULYOwjDjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 20 Feb
 2024 06:43:10 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 06:43:10 +0000
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH v2 4/6] pinctrl: starfive: jh8100: add pinctrl driver for sys_gmac domain
Date: Tue, 20 Feb 2024 14:42:44 +0800
Message-ID: <20240220064246.467216-5-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 720988c2-79e5-43d2-3993-08dc31df345b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dZHBUP5SSgqdgoGxPxL9c37Tir+VdA8gVrAuTYPJFo/7/iYesAvIL1YXBJAKMhVxRiVKmrsfGRIrCDtnK0JDhqYjRGMM57zInzyhgTXD+ikwMiBLuinNA9LvNxOtOvArQuq8h5mnPe0YKC4irU0hRwQgT5jeYHqmXmx6eyzs/EzJPR8FWzxqnwrMAE2Faqopy5JTbpGtLvmggHKhbkKf9EX6bpHZbUffn6qveMrNJWQj7+Mzc6L15u3/b/UuWFn72TWAytnC8jOnB6hKJC7vPQjjMMr52Ax+ReS1EI2F3GaXwiHxDFeTZDt4lquZYDl9MkGJUEHT96NGEav4/dF/4jbcuvcIs4NaNqZlCO8snzL8Uz8hB21hv1e7L1Ynq2QyqcOM0mdf+rQaKrKzp+zXkidecEr/LZHmljj4CTLe0S5L3ey60ii/GioBehAOwbzqWokYkEScdV+GJYLcj49A7QpHX7Yuf625/MlZ3P18MSedie6CAXJboBm3B4Vpd0xe9cBSwb6IlXdOGzLOPGLhy+ANYpYfyXAtcCZeTY7xXfa1v1PdeU7EeEyI7uvgPq1bSeO/1tg2ifdW5Kpt3qxRBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRKU/JxJKHZ+mBG+7op2SCNXXcvcZtJhRbbTv5hTgwttbmIQRaLIaktzPQsC?=
 =?us-ascii?Q?7PFgheKCcudsHPKfu8FxxYny+vbhUCxEL6Vetmj1D1Ki8tiWtUQLzTcn4p2r?=
 =?us-ascii?Q?ZsLyjHp47e8sThez2j727cTXZqqGQF819a6DGvLSEhA+4DMgV5DzZh5jYjwP?=
 =?us-ascii?Q?3adEyVi2phYvzoPDqfG+sMCjfBgZjiqXTJbCbr7OXcXIr4NQxwnW00Uk6ORH?=
 =?us-ascii?Q?I+BO3q8GPDwG7/EKxWlM8s8fMmC+iHtaH4R2DrJn5tVCR2MV7iQhnFOiKoHj?=
 =?us-ascii?Q?Nz6d48SukXPFfMLcMEJ04L8nlwI1VwKq183MCu77chDj3Psdp7+3+eHTUcpF?=
 =?us-ascii?Q?gyqo7SeolwlLp/8tiQyz9C5RPq8EHe1rQVxwlNLLBpScVZK0/m3z4MRP8uNE?=
 =?us-ascii?Q?X6MIsBZGqVNN/K+WoHe2SJ3dvWE6fuPwaqcJrJJKCgFSY0g9nsWbdyxJyrtc?=
 =?us-ascii?Q?jPN/T/iz4fqbSUNzJFdDt0aJQR2CFBroPqgvytjCcA5KF8Z+BYlcSCvYZyqX?=
 =?us-ascii?Q?wFtwu7yKLv/rQhW34RFoeVdLlZRednFrEgNWpgxcylSaSiWIfacB5ZeJNdy6?=
 =?us-ascii?Q?xvDZnBis4xJ6amOkzqcqSwT/GspM6e1cXitQMVHfaq3fwr1bT/OZ2Gqlgggn?=
 =?us-ascii?Q?1hqPDGIkLUqWRkkfHIGxQ+GCs2o8L/t29OfjM8XPfVwsyxE+eA/2U+3S1exg?=
 =?us-ascii?Q?qwOVD5dKbQutg0SPrQ7hIAeaEH68Vap//4q4irEKmL06rcGog1KIRWVZytoH?=
 =?us-ascii?Q?2hhmwe0d9D7rtLqF0iEWWFNWJ5a+Sjvo+6pHcRc5wlYFsQ/aduPJT394PmoG?=
 =?us-ascii?Q?DNE/1lbPOUXfeVuLZvZ0Ei6hY2sUeMA1vzY8zN6AFJGdQsPxKNFWgVjTGfGo?=
 =?us-ascii?Q?bigRWRADSyXY+WS+YDI4bUHcrNzjv26e7a0SYZ/ECVtFdm4DWjc6ZUAJAvvj?=
 =?us-ascii?Q?eJ0m/dw48aNnOuSlZZECC2x6CBtRBJOtKk9wLJ2oSLv/KsFZrW4wRxd6izY9?=
 =?us-ascii?Q?x2GplxAXonutF5QMySiZY7Hr2VfiP3qxsISBD2CgnIY9hQrICpeXnuXWBbrN?=
 =?us-ascii?Q?NmMndVuA6wU503ox6j6BLiIxHsLHnkigfP4BglvrVQUst9YtKfoy18r2hqvO?=
 =?us-ascii?Q?9hm7sVfVEg8Sa1iylSbKjIpIoRXUBUinVXqCnvu7VwznZP7BtIMocA9m1NAF?=
 =?us-ascii?Q?Ji2mkabnL9v9IswKTTfmP3B13+Sn/yMk7oFzVrF4c8y7bYIqv5hsiQRmS3Hm?=
 =?us-ascii?Q?tajiHoFSgu53duJT64Ivk3fr3+QH4VGoeNq3Sd1JcbpcZU3JK6/4bwgnJYsy?=
 =?us-ascii?Q?WWzff24mzz9cYVTQA+IAqjNcm5qCc2wptNb7ugqQ6Bdq+JetdJtd9XHLcvFd?=
 =?us-ascii?Q?91mMw1sgO45jlHcbk6Wkw/sEAZ/Ut8ENgPChz4vmQw58ovbtuXALGd0Yvv9r?=
 =?us-ascii?Q?Z0JBI5gnetyQ/Qz0BsGDYVgbHVUtrQgIj4zS8BpFNvb3XLSFSjcEiJ10KyTC?=
 =?us-ascii?Q?/edUx+J0NTRCTXUEErOdD2alvWGDo2WfM2COxki7sVeOlhgzdTXdbsNklQC7?=
 =?us-ascii?Q?g9Sxrx9unhuD8nJEO6aisaA83O8//ATDRuf79JgU2Dh+1SytKMIhaJoLFd+x?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720988c2-79e5-43d2-3993-08dc31df345b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:43:10.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuCPqp11m+6rREWDGYgOTZd916FDEh5p5tpnpyCD99oo3y7LQ3WRHNRBAUVxQBhe2xewekQY9EOyez8vJKgIc3zeO500Mf4pWyz1/VsQXzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

Add pinctrl driver for sys_gmac domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              | 12 +++
 drivers/pinctrl/starfive/Makefile             |  1 +
 .../pinctrl-starfive-jh8100-sys-gmac.c        | 93 +++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |  3 +
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index d78f161a636c..bc123c0bf35e 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -82,3 +82,15 @@ config PINCTRL_STARFIVE_JH8100_SYS_WEST
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100_SYS_GMAC
+	tristate "StarFive JH8100 SoC System IOMUX-GMAC pinctrl and GPIO driver"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-gmac pin control on the StarFive JH8100 SoC.
+	  This provides syscon registers to indicate voltage level on SDIO1/GMAC1, to indicate
+	  GMAC1 pads voltage level under different GMAC interface modes, and to configure
+	  GMAC1 interface slew rate.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index 784465157ae2..236a693a8aef 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+= pinctrl-starfive-jh7110-aon.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+= pinctrl-starfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+= pinctrl-starfive-jh8100-sys-east.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+= pinctrl-starfive-jh8100-sys-west.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_GMAC)	+= pinctrl-starfive-jh8100-sys-gmac.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
new file mode 100644
index 000000000000..be0d238be08c
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys gmac controller
+ *
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "../core.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_G_NGPIO			0
+#define JH8100_SYS_G_GC_BASE			-1
+#define JH8100_SYS_G_DOMAIN_NAME		"jh8100-sys-gmac"
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_gmac_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		sfp->jh8100_sys_gmac_regs[i] = readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_gmac_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		writel_relaxed(sfp->jh8100_sys_gmac_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_gmac_pinctrl_dev_pm_ops,
+			 jh8100_sys_gmac_pinctrl_suspend,
+			 jh8100_sys_gmac_pinctrl_resume);
+
+static const struct jh8100_pinctrl_domain_info jh8100_sys_gmac_pinctrl_info = {
+	.ngpios		= JH8100_SYS_G_NGPIO,
+	.gc_base	= JH8100_SYS_G_GC_BASE,
+	.name		= JH8100_SYS_G_DOMAIN_NAME,
+	.nregs		= JH8100_SYS_G_REG_NUM,
+};
+
+static const struct of_device_id jh8100_sys_gmac_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh8100-sys-pinctrl-gmac",
+		.data = &jh8100_sys_gmac_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_gmac_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_gmac_pinctrl_driver = {
+	.probe = jh8100_pinctrl_probe,
+	.driver = {
+		.name = "starfive-jh8100-sys-pinctrl-gmac",
+#ifdef CONFIG_PM_SLEEP
+		.pm = &jh8100_sys_gmac_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table = jh8100_sys_gmac_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_gmac_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH8100 SoC sys gmac controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 92d3b5d6de40..4652885feaa2 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -15,9 +15,11 @@
 
 #define JH8100_SYS_W_DOMAIN_NAME	"jh8100-sys-west"
 #define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
+#define JH8100_SYS_G_DOMAIN_NAME	"jh8100-sys-gmac"
 
 #define JH8100_SYS_W_REG_NUM		44
 #define JH8100_SYS_E_REG_NUM		116
+#define JH8100_SYS_G_REG_NUM		19
 
 #define JH8100_SYS_W_GPO_PDA_00_15_CFG	0x074
 #define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
@@ -34,6 +36,7 @@ struct jh8100_pinctrl {
 	const struct jh8100_pinctrl_domain_info *info;
 	unsigned int jh8100_sys_west_regs[JH8100_SYS_W_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
+	unsigned int jh8100_sys_gmac_regs[JH8100_SYS_G_REG_NUM];
 	/* wakeup */
 	int wakeup_gpio;
 	int wakeup_irq;
-- 
2.43.0


