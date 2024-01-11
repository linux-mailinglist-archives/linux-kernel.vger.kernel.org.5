Return-Path: <linux-kernel+bounces-22985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DF382A60F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EB61C231B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C538A6D6EA;
	Thu, 11 Jan 2024 02:32:32 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836DECD;
	Thu, 11 Jan 2024 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX1fqQLrnD5Swgj0oz3FyusPeX8ZQ7RidvvlWqeCmTe0VH8jMN0S5gmKJ+Wdh+MGbLKxz8VWCs4WsQGcdn3eOmvnpYlm8G/I+6Cp91tU72O20se4nbW7Y4TPjOVKo9wg4MuE1toFzzGGitgABHKB4SwnCObuOtIQ1XhGwLSP/o3wtQNy4DQ4AAk3wllOEIXTCi2Z80YFP5QJLEosUvK5kdkXHWO2TV343IBBiNxq0cg4um6EUINHRYyapVTXvOc2INwQH3YIp+auOXU1tC2QeW/BvGPDQW7IjmvQjUcG9c0gtL1xL2bJh1bTq4NoUarSxGNjbcm96d1RpvD07CkAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d4X8lZNCu0jXpAkRxeakd2vF4R+588s0FLhY3QdLIo=;
 b=PbTDa3FyjGMAL4MmtqiLpN24LSGu2as+4DswYZ+i8fdUT/I1rqHyrjDr9LzFGcayYshTXfud4JVuivABhu27J61cbmPYXDdL505/BzGEQYW8BwJakms5cBO/RQ0FMPP7qDVE1TQxhYQ8LcGJTKemtMQXd1gdhmkal6////2U8Rtu42lgDw48lJMOKq1ktsKdUqcbAb4v4BvgRht5U1HfqZifh4MLNmyy8X4ekr/1RwSHiLzIqXDoEXb57MI6dRIpijrQWmeBrw/tXu8fZK7YSpEshodM/1cR7aX6NR+8OpEZk9oRleWBCuLCY2kEsumhNGfFUjKYB7saJ/ccnZs9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0859.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Thu, 11 Jan
 2024 02:32:12 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 02:32:12 +0000
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
Subject: [PATCH v1 2/2] irqchip: Add StarFive external interrupt controller
Date: Wed, 10 Jan 2024 18:32:01 -0800
Message-Id: <20240111023201.6187-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111023201.6187-1-changhuang.liang@starfivetech.com>
References: <20240111023201.6187-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::22) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0859:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b0b4a2-9c33-4d23-ddf5-08dc124d842f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Db3fa4Fywmc4kvSMVZdSCVhjjJoVZGJ8ZL0+TOcRPUe8aL4BBD1MDicLqTLMJG20tmMY0nikyVZryZSscyt9j1JUHfFLx7gSOvdsOboVimoXN8QyowS3vYGFPvVJ8nPOjKiFyNMDz4YkIcFbwgL/XIniwDUnmhcNkaYN0l4DENyHL4pc2Yc7EdbwtnoOfcx6m77V4ujJ6E9/H3fhQZ73dwKuSwJB9k1J3Vlihi+bkrY6Fd15F1FUYmu1Dn0CN5s6ZGHwxYFoSbAjvpUA6qDS/L9/qAXKTADvW3sgCUX+T5XjZcd5s3HXv9Fb2WnZXPqSAIZBqkXmzaIsMap6KWB1DHGTABytDxaFtnHBFPHBwk/R0mVsMqxIn+sAqSL2tbfZRmuOsb7R9OASoysDC0t/3esqee8su5PIRe3UhZLkh9zYSCIIOlKFQ8Ef7ncD/jMBm6vwyced6LawHYg5h5HpkWV6zX0JYXrshAJNkfpCk3IwSB+9Ex9w1jp1KPaKzfGCogPXyhd0avFDKYs7JwJTbHCC9JsRs3laZHJcUadkBor5IT1FVqWreubE7OE9scch+uBmxbCWYG4jCsdw1dv118n7f/QAEH14SnFs1OMF9dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(1076003)(38100700002)(40160700002)(36756003)(38350700005)(86362001)(2616005)(6666004)(66476007)(66946007)(54906003)(83380400001)(52116002)(508600001)(110136005)(66556008)(26005)(40180700001)(41300700001)(2906002)(4326008)(8676002)(5660300002)(44832011)(41320700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7dYngIdL7o4zS19eBm9xlxE4kC8Rd6fSl3W50sXAFglo56e/2VdNBa97VKZV?=
 =?us-ascii?Q?8LyIEv3eQxUgwqcpw1giyRNHElvx+cd4/8jAOW1nNKF5pDIuCWiv8bGBVCMU?=
 =?us-ascii?Q?F0JDCwejKWmucCGbwyqwm9+uLZsx1hWLRfBE2jmtsnJsL/7sGWKC4ow7nUmp?=
 =?us-ascii?Q?fMEA7PjzA/MPj57UXN4JgN4T57mCw/5fmzXo3vTIFTKFoNo6OcSW8dLsBh/y?=
 =?us-ascii?Q?UtZWz5AYSHa79oCo9uegjBOaIRTVpC9ziO3EiitAO00/2v/H8tNjNqTUUfXw?=
 =?us-ascii?Q?y6H1wp0jVi6v++mNxnjZyehXU+xyJIKzZ/gyICJ/Q3bUJrnu1QmvFHoev40U?=
 =?us-ascii?Q?kzvJtT+uSYU5A8zgmb6mfDPl/IPasFuT74L1238JD6OHjDRMnRsVqNYrYme5?=
 =?us-ascii?Q?xEx1heyp7cfwZFiNdIK9BQkYVbjszZcb/NCblZODlMLoC7mh1wFUbO3X2PXL?=
 =?us-ascii?Q?8yKIASWFh0lWSxRj8C/l0CPVWo2zu3J6xZZU0xo4YOyoYidTuRvhsr4fdYa7?=
 =?us-ascii?Q?U4hbr9VwA7bFgrnHdT3+DMi9s4FU29BeaQtlkbdqYbdPc/Z7AQzwoxWRcipH?=
 =?us-ascii?Q?24XnxeOg3mIPdVH/BchBi8EX5MNono7KDJQUuE0Ia+Ks2yAIybz5L1O64VhX?=
 =?us-ascii?Q?G3gHA55J4v1yr9wGT9EQUE3kfNhMbVHidLkAPsNvU/pb7HyzT99cVgSnHx3c?=
 =?us-ascii?Q?JlYtwzo2mMfJJs2H5bBPH1h5kZK37vcRweNfXROQt7lG2W/w+20lft6ZnY3U?=
 =?us-ascii?Q?+lf364HWvlujghhVpmGRp62wXpY4KsXfQRpwatWca7PYsuEMfsczL2m/AVRj?=
 =?us-ascii?Q?LGsyDsKyS0BYJR4qRTxUT+ZN1t+nsFabA49Xqie8a27ftg71spNO6JSNWtU6?=
 =?us-ascii?Q?wWKr6PJgmQsl5CCMWwbET5ZexICMR5o+OuKcZDASWpJSRlolxz3A7QM6j0Cq?=
 =?us-ascii?Q?Jj/pEupeyq6SshA3Sws2tCf9YoFplgvfZJ7KeNNfcaZXJzAfOlC8/Acpjt8O?=
 =?us-ascii?Q?MBOTuJRQFs74qyyOpL1tJgaJMZsI6YNDXveIJHhAONhRMxml1dxkpSgQDb3q?=
 =?us-ascii?Q?EEYRF02aC86VdJctYHKfeu7E0esy3pWBWnfj7mBX46TfwFjksBUznNAm1Er2?=
 =?us-ascii?Q?fS7JPvfU/HKJRSqtbFdwpUov4QwhobCS2gASXfSKCmQD9o1QLjg7npOsLN0O?=
 =?us-ascii?Q?K5Efx+Lptwbq6q2Scc69qOo7gOryNPQL4LEitOWXLWR97+0VTfFIarZl3lW9?=
 =?us-ascii?Q?tpKxLFjG9/+dhGSdTKbC46B11oRAWRMRLxteDOTnenjT5BnimQlCXRBPt3rb?=
 =?us-ascii?Q?9p7GFp8MSKcaQYoe66nb1AtAlw18a7EGhSgcXqCzGfECvJteufrgpJH50P9y?=
 =?us-ascii?Q?hDmXBiDZV6pyDd+GIha5uVMj37gX+xMQqTLO3dQviLBWwCLl51cUcUprVXm/?=
 =?us-ascii?Q?gYfxV4Vug6vumm/sBjfnA6LMnXGToq36J8MI/D+dGoxS89jpwAQQOmBxhaO9?=
 =?us-ascii?Q?Z8YpTjbMh4LLgVAh9VlUjOd+Lv0hMNaaS/Wma/Al5Tkn1gJkZPh3y4Zpobga?=
 =?us-ascii?Q?cfViQTEF27XqTcnJ0M6hkpYgh0gfuBG5FALbOiZSwVOjuFKtuRW5s+vuAs9k?=
 =?us-ascii?Q?455G/iDZ4CnVhCuPu6wYjbo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b0b4a2-9c33-4d23-ddf5-08dc124d842f
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:32:12.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJa3G6/b7nuxlkaFKZw76egmGIScB1TU9R/Nxxb+/i0DlJnMHzM6LaSf3/r8ZweJPP0DqZWw02YtWPq6YC5JScp1Gxmlhak76CzLV5hoVLuP7R9D3pHypH60E9gMfOWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0859

Add StarFive external interrupt controller for JH8100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                |   6 +
 drivers/irqchip/Kconfig                    |  11 ++
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c | 180 +++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..b53cc42cd2f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20691,6 +20691,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
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
index 000000000000..be8224111cf2
--- /dev/null
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -0,0 +1,180 @@
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
+
+#define STARFIVE_INTC_SRC0_CLEAR	0x10
+#define STARFIVE_INTC_SRC0_MASK		0x14
+#define STARFIVE_INTC_SRC0_INT		0x1c
+
+#define STARFIVE_INTC_SRC_IRQ_NUM	32
+
+struct starfive_irq_chip {
+	void __iomem *base;
+	struct irq_domain *root_domain;
+	struct clk *clk;
+	struct reset_control *rst;
+};
+
+static void starfive_intc_mod(struct starfive_irq_chip *irqc, u32 reg, u32 mask, u32 data)
+{
+	u32 value;
+
+	value = ioread32(irqc->base + reg) & ~mask;
+	data &= mask;
+	data |= value;
+	iowrite32(data, irqc->base + reg);
+}
+
+static void starfive_intc_unmask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
+	starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq), 0);
+}
+
+static void starfive_intc_mask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
+	starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq), BIT(d->hwirq));
+}
+
+static struct irq_chip intc_dev = {
+	.name = "starfive jh8100 intc",
+	.irq_unmask = starfive_intc_unmask,
+	.irq_mask = starfive_intc_mask,
+};
+
+static int starfive_intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_domain_set_info(d, irq, hwirq, &intc_dev, d->host_data,
+			    handle_level_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops starfive_intc_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = starfive_intc_map,
+};
+
+static void starfive_intc_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct starfive_irq_chip *irqc = irq_data_get_irq_handler_data(&desc->irq_data);
+	unsigned long value = 0;
+	int hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	value = ioread32(irqc->base + STARFIVE_INTC_SRC0_INT);
+	while (value) {
+		hwirq = ffs(value) - 1;
+
+		generic_handle_domain_irq(irqc->root_domain, hwirq);
+
+		starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq), BIT(hwirq));
+		starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq), 0);
+
+		clear_bit(hwirq, &value);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int __init starfive_intc_init(struct device_node *intc,
+				     struct device_node *parent)
+{
+	struct starfive_irq_chip *irqc;
+	int ret;
+	int parent_irq;
+
+	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	irqc->base = of_iomap(intc, 0);
+	if (!irqc->base) {
+		pr_err("Unable to map IC registers\n");
+		ret = -ENXIO;
+		goto err_free;
+	}
+
+	irqc->rst = of_reset_control_get_by_index(intc, 0);
+	if (IS_ERR(irqc->rst)) {
+		pr_err("Unable to get reset control\n");
+		ret = PTR_ERR(irqc->rst);
+		goto err_unmap;
+	}
+
+	irqc->clk = of_clk_get(intc, 0);
+	if (IS_ERR(irqc->clk)) {
+		pr_err("Unable to get clock\n");
+		ret = PTR_ERR(irqc->clk);
+		goto err_rst;
+	}
+
+	ret = reset_control_deassert(irqc->rst);
+	if (ret)
+		goto err_clk;
+
+	ret = clk_prepare_enable(irqc->clk);
+	if (ret)
+		goto err_clk;
+
+	irqc->root_domain = irq_domain_add_linear(intc, STARFIVE_INTC_SRC_IRQ_NUM,
+						  &starfive_intc_domain_ops, irqc);
+	if (!irqc->root_domain) {
+		pr_err("Unable to create IRQ domain\n");
+		ret = -EINVAL;
+		goto err_clk;
+	}
+
+	parent_irq = of_irq_get(intc, 0);
+	if (parent_irq < 0) {
+		pr_err("Failed to get main IRQ: %d\n", parent_irq);
+		ret = parent_irq;
+		goto err_clk;
+	}
+
+	irq_set_chained_handler_and_data(parent_irq, starfive_intc_irq_handler, irqc);
+
+	pr_info("Interrupt controller register, nr_irqs %d\n", STARFIVE_INTC_SRC_IRQ_NUM);
+
+	return 0;
+
+err_clk:
+	clk_put(irqc->clk);
+err_rst:
+	reset_control_put(irqc->rst);
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


