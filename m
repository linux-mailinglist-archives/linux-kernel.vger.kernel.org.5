Return-Path: <linux-kernel+bounces-80589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76951866A03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A63B21AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60F1BDC3;
	Mon, 26 Feb 2024 06:24:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72171BC41;
	Mon, 26 Feb 2024 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928646; cv=fail; b=SD1MV8o6UjRdfWkcA8xm1VhXKMAvsU9jIuv+SYklhCK6BuppoX6SdHAu+DIG6ogvmXrk3b50gpweIbokr0NmpaS2ZPPZ8hOTVUKoNq5ysw6oEVh70rjozgr/1MTdYgFIRH6l+2x1nPBFW2wqHfwF+mS9RBuzmxyF7gflGKdyxfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928646; c=relaxed/simple;
	bh=qslqf3BlyvwslRkyh1TiHzo+SoiFN2D0W8XzJzyUaEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgLbjskJIMHbc12jOU7dpcoW28eQZ4UYOosEPzmdFdK7GIN9+3uYLP8FNDEnuRy6NT88g4H6jxK0wfSBjsJl/i1/eXPVv9k2cNCwvrDxARJUn1JnKfT3jQWcTjFGe7y4RLkVezo+wqUGj5LRHoFwJqJ4J0m0MyCJxIcG3kifWbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJiHSbuS/MzGOkpKom4T+StJmpKkwOzs9sjqQ0w+SC75znNuKZKMVpqmtDwZJKztO6xwIEGXcoN1KTtc8Xsisnjt40SyCCBCQREocMfJvGiSLxjcAUr5/Jmy1FAuc18UeyoV0+YB0A7Ty78kqm0pdYCDDwQKExQS3V+vboeU7DPfocf543JogdZGRz3kK83q+Kv9QxirMYvzkrWsEBQKsOR6Vt+ukcOorPOPh+AFqgMgIsqn/P/mN7S+4Y84es+yfhCVoMO3T04jerx2rVVkbAlW18m+ZI0jRthIQYN2jTx9SLaTYlkFyJ4ZjKqDLEpGsKsGMM/fnDGne2uco0xweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nJvQqKTYPgqgoT7wXNUg2rBXNmwTFzh2tMe9vIr1FQ=;
 b=iL8d8X5lA1vXoxdow02hEyPLGl+qooaHeGDfDvnQf0YkxznToCXMhNrbU3shMyfAlbpagHWI1VoDeR7mbaiHJ0EfuK8vJRfGUx9GEkucE43uEM/RsJOU3Xq10JSR8vgwK2+LOGH20ZPlN01KS9pr4ycIOoJfQxHZp1zP9bQMZBNk8zs/zuQzRoiXKVTb7qxYlbErKzvP9S5AiEWs4JS7XquOO+2Kn4RMWxPrwpeMG9s2h0nRuKhE0StnSOEEg9xzPvZbKAsW56RiIvkH+BAPtA1X75cH/wTar/50vO/GIOgn2k5NZlFE76WEnR7eXcN7T3/2Q1a7A90ngzngKPyaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Mon, 26 Feb
 2024 05:50:34 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Mon, 26 Feb 2024 05:50:34 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] irqchip: Add StarFive external interrupt controller
Date: Sun, 25 Feb 2024 21:50:25 -0800
Message-Id: <20240226055025.1669223-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226055025.1669223-1-changhuang.liang@starfivetech.com>
References: <20240226055025.1669223-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::18) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f05218f-ebde-4536-649a-08dc368ed975
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AD3uqZA96CHGnt653PX+EUggCSgrTZ5Pf0ErAkppjGRXGnT2+/4PsNoVzGA6iYe3hOiyLkQ+1yCUKuFYsU8hdVXNGr5IuldN2Jpb2sCrQDeDhxVkJsiSYZs0WOxkB5VQi6abgcEYP77AgfOVp79lBaWQquLjvTYMCDeGd47PkwDcUpvN+VZXeLyFhsZZs8oVao07F8hmHeG4KnGTZbH5pD6zY/pLd8fGslSUUI1W+P30K3mfCWMk2mW92eeiposev4m6466oQ1h+/i13uQkI3guO87nSdLMiffPdI+4uVYIwVFfF8k56khC1qenHNhwFzofDcqapUjay1yli4z5rFQ3w7JSyzdCaSQ1KGSTf5OkMwmojEb7L8Mua0TpVa0wFS4cUdXwWfassPKS91wE5jz/gNCOH1DQfqrFpdlPSWneHGSlHiohlohFLUg6ACDf6qMX0/vNXMfT7MJa/KWOIwlC8AzoeTXPTG5ezZWlOMDfmQuI07em0sT9P0tYoK/qPFZ6HLqD6yYFr5I1l1HADBMrjx8cxhbsO2iF8SifbPpyzi3+c2NEju1Z4s5Fu20upSys0x6G7ED+kKHcihuR2uIyJvElSVfQ79HHPeIZ5aM57tS3uUeLpAhzAncm2Ncbq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3v+5PeSmjoXFoBkppA5YCBV0qdCuYexgHU1nit66xLDN5aHw16rf8MXuiEn?=
 =?us-ascii?Q?q/3NR6Tc9l4+Fv4SVox25dTx5W0BqioYLL4lMOhtG1deCJtL6ta/zq/4QHNT?=
 =?us-ascii?Q?U64rqcq3npQ7X6PQ+MIR3ibkTiPi3sfrNvj8XPlGlZbefVaX3dgsnGuSw/RD?=
 =?us-ascii?Q?lhG8KvY04cgXm/nNLGHzCNO4cwdl4Qa5QmFSyCXs8C+9slxNRzMRG6+GqYCQ?=
 =?us-ascii?Q?ToveMl0FPHm+i3b1IQYeKqb9srqCLTv0fxw0yGJi1/IsHvF65nNLvZQS5uxe?=
 =?us-ascii?Q?I0zfKc53JzVKStsTPf/89y5M2QKi82eKX6Oc6Ip2M+NXTzZ3g8+FLFEfVVSF?=
 =?us-ascii?Q?Zr2SxMm9yo3UT8VUyMcTEu5kgQLW68fqEDb6La+3IXySCxY9/zrOFUMkjAjz?=
 =?us-ascii?Q?HLBIJL7CixdApHD/Go25kBZ21JGioV520jZZcbgrGr8bpVgy24b1Kyo7qFUU?=
 =?us-ascii?Q?bbFpsPaAEtIDqW660oWscQ3Zh5NTW49J8WgK8SW7zURFR0dzy08nnHyN1eAl?=
 =?us-ascii?Q?dqKRCG8i4IGu961u0r572o0eMvJumrXeHKbCksrJPVoaOGUsIuk8d4iYCY6h?=
 =?us-ascii?Q?287dcHhFR1P5yD+pogL21hutdHVyAbbEfUCMnEDvlCwvH5zAZF22oKXn5xRP?=
 =?us-ascii?Q?O9/6PcnVgZCJx2EDSKiiZZTurTNKot4kRgD37xLys59WxqtAg+9i0hLE7l4v?=
 =?us-ascii?Q?OfLgPTewqGAFyVSkhQSlNlyyTz+rOvyPWDd2cWx16L8Kd2oseMCAWpIZ9MLO?=
 =?us-ascii?Q?TSFT6TZagCxz5FoYm2nPqzPcfsVA/RBBlEj9l73l3/KG5RJQayNernFVYmIT?=
 =?us-ascii?Q?9qg7TS2jZ15y+Dqp4FaJcNsW7eukZtgj8+svmASE1z8HIzH8TljYvlBoY4v6?=
 =?us-ascii?Q?LZUhPJZ7wrhpHe6xsfyX+VlNtgEDgaST5oH9G1RxNclr+qNwZSY4vZGsoocA?=
 =?us-ascii?Q?ZHv284Qib/YDOe+UuDR3TzJwM9G1aG4BYN8r71IgjzobAOfxtrlxyHnJGiOh?=
 =?us-ascii?Q?MFqZE5u8eVHEwRmC3a2vELhBdtLD7BjP7B0GZRDpuwobnuCWwpAXu34bTeNH?=
 =?us-ascii?Q?SeCE8lWQPYtyU/N1LNzIJiOqdqPGuO8+M79HL0k/NmNA00MQC+lv+qPZ5gUC?=
 =?us-ascii?Q?N9tAGJczr3by0EjVTT14I6bgiI0C5U8fCibEWZoOUgOiK7RS9n3Woc3aezoZ?=
 =?us-ascii?Q?nZqjPsoGpf0+k9jO09Ir5S6jlWrKbTBPYkeTZcnTIGpULEV8gz7Rz+UCAZop?=
 =?us-ascii?Q?MhOylmvfDvxLOa91X9sDoUQNeYUh7/4vghk5zmoglDAosGI/4hD1WwmxYmMX?=
 =?us-ascii?Q?G5asit+dvIAQdG6ItFPjW7cG2x3d7+8+KY8opihVq8FTuvHs/8sHvjs/d31U?=
 =?us-ascii?Q?mloTGDrPOjVYssWTjD1WOg9/hR0jBKKcShuYBdq7q8EJCnl+pTMzYwxEwYRo?=
 =?us-ascii?Q?jE8dDMdL/gapvybnvEZ7ZauuwWvyt0BGxR65Z4wRtzqXsTIJ/UpOWziZYeiQ?=
 =?us-ascii?Q?qK2eS17J+/+0wvLVyTs+8nxlnuDeM4h7MTxOLImMqZrTM/ASsBQg9c8g+bNF?=
 =?us-ascii?Q?Pw8ZUvivOVJQkAGt4CILQ4/r2zPAFLpfTNmSObqbk33GqLY+KKijuM2VaaLW?=
 =?us-ascii?Q?5hAZm1Bwdb/3ay+enjQq+3Y=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f05218f-ebde-4536-649a-08dc368ed975
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 05:50:34.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC7qDUHcXmT2OVluxznqDk7bOjEu7HbC+Z++RQJ3IHnSOjkgt9QGKYH4D44qXPOIdsiXZlMuVRFVgZRGkmn/Q8af193pEmlBsvrYQkD/+BfoVIGbYwq9LtPzM4uQgUdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0671

Add StarFive external interrupt controller for JH8100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 MAINTAINERS                                |   6 +
 drivers/irqchip/Kconfig                    |  11 ++
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c | 207 +++++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..3359d5016f00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20960,6 +20960,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JH8100 EXTERNAL INTERRUPT CONTROLLER DRIVER
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
+F:	drivers/irqchip/irq-starfive-jh8100-intc.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..72c07a12f5e1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,17 @@ config SIFIVE_PLIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
+config STARFIVE_JH8100_INTC
+	bool "StarFive JH8100 External Interrupt Controller"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	default ARCH_STARFIVE
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This enables support for the INTC chip found in StarFive JH8100
+	  SoC.
+
+	  If you don't know what to do here, say Y.
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..ec4a18380998 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
+obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
new file mode 100644
index 000000000000..0f5837176e53
--- /dev/null
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 External Interrupt Controller driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ */
+
+#define pr_fmt(fmt) "irq-starfive-jh8100: " fmt
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define STARFIVE_INTC_SRC0_CLEAR	0x10
+#define STARFIVE_INTC_SRC0_MASK		0x14
+#define STARFIVE_INTC_SRC0_INT		0x1c
+
+#define STARFIVE_INTC_SRC_IRQ_NUM	32
+
+struct starfive_irq_chip {
+	void __iomem		*base;
+	struct irq_domain	*domain;
+	raw_spinlock_t		lock;
+};
+
+static void starfive_intc_bit_set(struct starfive_irq_chip *irqc,
+				  u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(irqc->base + reg);
+	value |= bit_mask;
+	iowrite32(value, irqc->base + reg);
+}
+
+static void starfive_intc_bit_clear(struct starfive_irq_chip *irqc,
+				    u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(irqc->base + reg);
+	value &= ~bit_mask;
+	iowrite32(value, irqc->base + reg);
+}
+
+static void starfive_intc_unmask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&irqc->lock);
+	starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock(&irqc->lock);
+}
+
+static void starfive_intc_mask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&irqc->lock);
+	starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock(&irqc->lock);
+}
+
+static struct irq_chip intc_dev = {
+	.name		= "StarFive JH8100 INTC",
+	.irq_unmask	= starfive_intc_unmask,
+	.irq_mask	= starfive_intc_mask,
+};
+
+static int starfive_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_domain_set_info(d, irq, hwirq, &intc_dev, d->host_data,
+			    handle_level_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops starfive_intc_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= starfive_intc_map,
+};
+
+static void starfive_intc_irq_handler(struct irq_desc *desc)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_handler_data(&desc->irq_data);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long value;
+	int hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	value = ioread32(irqc->base + STARFIVE_INTC_SRC0_INT);
+	while (value) {
+		hwirq = ffs(value) - 1;
+
+		generic_handle_domain_irq(irqc->domain, hwirq);
+
+		starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
+		starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
+
+		__clear_bit(hwirq, &value);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int __init starfive_intc_init(struct device_node *intc,
+				     struct device_node *parent)
+{
+	struct starfive_irq_chip *irqc;
+	struct reset_control *rst;
+	struct clk *clk;
+	int parent_irq;
+	int ret;
+
+	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	irqc->base = of_iomap(intc, 0);
+	if (!irqc->base) {
+		pr_err("Unable to map registers\n");
+		ret = -ENXIO;
+		goto err_free;
+	}
+
+	rst = of_reset_control_get_exclusive(intc, NULL);
+	if (IS_ERR(rst)) {
+		pr_err("Unable to get reset control %pe\n", rst);
+		ret = PTR_ERR(rst);
+		goto err_unmap;
+	}
+
+	clk = of_clk_get(intc, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Unable to get clock %pe\n", clk);
+		ret = PTR_ERR(clk);
+		goto err_reset_put;
+	}
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		goto err_clk_put;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto err_reset_assert;
+
+	raw_spin_lock_init(&irqc->lock);
+
+	irqc->domain = irq_domain_add_linear(intc, STARFIVE_INTC_SRC_IRQ_NUM,
+					     &starfive_intc_domain_ops, irqc);
+	if (!irqc->domain) {
+		pr_err("Unable to create IRQ domain\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	parent_irq = of_irq_get(intc, 0);
+	if (parent_irq < 0) {
+		pr_err("Failed to get main IRQ: %d\n", parent_irq);
+		ret = parent_irq;
+		goto err_remove_domain;
+	}
+
+	irq_set_chained_handler_and_data(parent_irq, starfive_intc_irq_handler,
+					 irqc);
+
+	pr_info("Interrupt controller register, nr_irqs %d\n",
+		STARFIVE_INTC_SRC_IRQ_NUM);
+
+	return 0;
+
+err_remove_domain:
+	irq_domain_remove(irqc->domain);
+err_clk_disable:
+	clk_disable_unprepare(clk);
+err_reset_assert:
+	reset_control_assert(rst);
+err_clk_put:
+	clk_put(clk);
+err_reset_put:
+	reset_control_put(rst);
+err_unmap:
+	iounmap(irqc->base);
+err_free:
+	kfree(irqc);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(starfive_intc)
+IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_init)
+IRQCHIP_PLATFORM_DRIVER_END(starfive_intc)
+
+MODULE_DESCRIPTION("StarFive JH8100 External Interrupt Controller");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
-- 
2.25.1


