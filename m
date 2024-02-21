Return-Path: <linux-kernel+bounces-73954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1285CE01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A331C23010
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ACA17BB6;
	Wed, 21 Feb 2024 02:27:19 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2107.outbound.protection.partner.outlook.cn [139.219.146.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BA154B1;
	Wed, 21 Feb 2024 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482438; cv=fail; b=JLWIRVP0wajZqzcfcGRbW54210HbgDDjqoEgcyG1fuqKMUN3nn/++jIt4pWBvGq68Rt526fkvUwfe/h6e0Mjus8MHLDTxG29IvNT+4NqEDTxCD+/gqIkPGwbKJnPmaLyDAf0zKS1XDEqvcPqJCDn/pFr2RvYEOdp/UOZGXZIrdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482438; c=relaxed/simple;
	bh=ZE0Gm2H+R05ae9LneQuPHiJAJ/fZ02DBSgPAltY/Bvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVbjP4qUQ7BcvBOOCDZhwzKQItA+wPxPYhvh3z72cZFsdRqXuFx+uFZGqdTBtH5WRcWtWAqjJZeFeX6N59cqSs3Vhq1elfUWXoWgvHZpgsT9wzvuisZ5sXDaEeEWjZLAw0yuRt4/8OCbQ3bh+On+vbSELN3gEahDsKHqgCCUPaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6x7ziNT3IkcJY/gICyQ9PB66+dTNhsGpsx014FgRpn9hNCXJenM0R/Pr4/Znu40uDkwXMgNmtj9lb2W96hnixxxi8QE4BydRsjw9oPY1VXDO3ZlEqdlvvdE03s5PWapNGAqloLQsZmU1fDoIur7EKHs8F3GvNLIS0SGvKQAFnLUzwxUuhV2ZXuFCuAK5uiYBuun7irLS/sUucE/4Zvb70pwaYEEuQndaUEumZen6ArXRBSdQttsD3WZU1QW9H0388efQvEPB/XcszxS7iPFzM3freI32xt82yMJQHjPfJqhxMqUpq4B64BfuSywr3SYNXTs2JEqBaHqzPEHbBiUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3J7vJaxM3jUR4q2zFdrL8tMpvILc/3hyS2EV4Da33U=;
 b=ZtuxRYII+dGq5YcC0S2Gwkb8cIBKvOZlLWjcz4vu9apG4HQHR6f9gcKz4GUVQCy1ijz4aDXLgzpfgvlwIov9ojjjWEn19H2hhVBZKx4+Rkv0t9q8NO+y3iEFlqizXtipBu78v459CjcgbiNDDwR3lbM5OUOA6qDrlomo3NYBUqSC2mGS8YITj3ELA8uSechry60KShQVje8NexMjdOAB9HovINn0R/qkCB20mNo+0xmD55j9jE4MUStMa4DTCw56jHrJOcYdzkcAg5P6Nn8Tk+h7VNfB82JZFPOq+kTzJG5YwsuNETsyV3CneNsW864Q4eQypFxJcct2K9HV0Hf5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0541.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Wed, 21 Feb
 2024 02:26:58 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 21 Feb 2024 02:26:58 +0000
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
Subject: [PATCH v3 2/2] irqchip: Add StarFive external interrupt controller
Date: Tue, 20 Feb 2024 18:26:47 -0800
Message-Id: <20240221022647.5297-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
References: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::31) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0541:EE_
X-MS-Office365-Filtering-Correlation-Id: f489f186-4bdd-4dcb-878f-08dc3284944a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Woz1ujBEkuwWc+292NIvwvvjMfx9O0fdHJivF1Mumje+y2xWSRYw5toBk6fUjoXdHnzx8WCtk+bLeY10xKFoo+Y0DO4o1bd+qJmS/szzYGD9EZcQNFO58XUhmtbGaFJ9gI7TvlpDxuwnxbziHSmii7zwd8WC1oL1scUMEXYMpwgPSZFQ2zXmjMReY2jDMSw83QZ/cbRPIp2RrghVjGbWoq6fASY1GtXEknFhJSp9bYDpPmadMct8mnamOJVP4s2RF4dLZ1B+ONeFmAISd3LkCRkIZR/1jXr9UCj1z6anKOHXtF13UxoMzy8/aTUlroXeavBN5nHA7LqhqTeCZcknn/7NSim+oElBE9ZV6oWGxbX9atnEYnkHLqGYHQheyvsTNclxH+ZG+jxQpCBrdODB0NJ+5XfV+wRKanWMnYMYBH1BLO5qyjGG4loRBZekhp44vqzVNJMrGscfKRl/LY7UZRi4AL+PZcqXPaW+ZY1k1Z5ejfR9ifBpPHSETcWYbmuB78K6nXEfczxcD0pQ/XEgy2I/1bwOgdEgfSKFGsivl2iHRvtfjYwxAWWVNKr8ScQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xHfz9b23cDFwsQqY2KdXA7DSfQKtuf3e5fqVoVw5Uy+4AJtvcCLuxWDuG0cQ?=
 =?us-ascii?Q?NYeG+L5hv+mmauCdW8A/7tgPbIzR4OuBAl07kF/SErFFZkgMJv5YoHaKdnVX?=
 =?us-ascii?Q?R1NGQ8ygaeSwZDmAcxWjQYYjHCe5go8leYh4t94YwZPGTJPfJfLF5nxVxJbq?=
 =?us-ascii?Q?IcfQOOLOXJ71QVkB5/uwUddvp+f0QI2U/Us175T/y19gQkqv41H9MGcoNrPu?=
 =?us-ascii?Q?AvFLpjSArbioJ6qkHlb9YY1vcmel2BQvFtAKbCgb5ifPaURCmj8oS7RmUN/w?=
 =?us-ascii?Q?J5r7IqdWciObtinJonKYHKaJziGgbDCp7NbiqqktNmEVBP2oPIrW8vn/mfWO?=
 =?us-ascii?Q?z2gSifCMR3oR26ewR+dwByx7uXDnEs+VS0inYq3A8V12fRrS5JTZRcf4eltA?=
 =?us-ascii?Q?B/R+F/WUPrdak+/furXDzUQTsqnBD/3oAS6eirgLFQRY97TLHLGPGWpfYl95?=
 =?us-ascii?Q?sKnv9mL8MG9sy7SXm/mQMvjAD6w2Ekjd/sByNE9T/bu8FZYDAYk7/l+tpur+?=
 =?us-ascii?Q?tLSlo5PWPG8jGMNrWjK7jTa+/SoGJvfgQWg216LFHWbuN2y2TVF8uvTgMSf7?=
 =?us-ascii?Q?GLU6orqa1niDOuW5YefCT6BtuwLwoALOpU/SEbxT5CJYA5XTTZa1+VmiPFTU?=
 =?us-ascii?Q?hQwu5zfLPF25rE1U+hrGAbuaIAXcn6ofbvzIzj6Ovs3Lvmk9oECIfJdWZUQN?=
 =?us-ascii?Q?ZBxOGOSYlkbH5YAGQjCWkI/5zfaTZn+fGrHJkq2k8wub68XIbJACIDilrYsW?=
 =?us-ascii?Q?PhtqZ5YAVINu6Q1g6oGH772E2P3Gmizps1MqUW5SzzkPVpNOliklffceBiPt?=
 =?us-ascii?Q?Scsv8Fj/0w7WTZCKOrP+q9M4e65bMIeNGuiVjauLH2jfjTkmviQ9gTC4m0dw?=
 =?us-ascii?Q?uIfzRwCA09BSSPy3MYkYXWEhMvJz66Aqci6+fb8m4sbZvVFDycghS9zvboA8?=
 =?us-ascii?Q?Z0oNDA6VbuIlkgHb82UWJavIMzxwhQrwrRk8RumbkE59BuAOjMza0LkQaWuN?=
 =?us-ascii?Q?oR1mct67u4fe+GRDX1i5eKaI91adfVi+/NqL6FWQp8DVcrIsn5ecqhz6PWe9?=
 =?us-ascii?Q?KIz2uiVoa2QyUOOIv67GjaWmklzTqbBLocPiz7+rS5+Z/d8uVvCds3Sl7qjw?=
 =?us-ascii?Q?1tAuX14flr1bhHIs+d14cU7HHZm03SRdmz+w01tHx6MtKsb1q8YMB3xkFGtB?=
 =?us-ascii?Q?1t13b/N41QOQunwFG7fRsX35M9X+4RdL7NoPT0hrCHLz+wi7wORk0B6PIs0U?=
 =?us-ascii?Q?G0CPgjn9XXJtsWDUqYa400LWhB5pTp2xsgF12Ol53W/HFyJf+9Mf3KIqZb37?=
 =?us-ascii?Q?acHaJ+2/QGLAiIqSGvdv+1fsfX+XCFdVTLw76WKVTR7enZNB/ZlemxKZ1d/h?=
 =?us-ascii?Q?+cnGoyN0h2q7XTokoggs00IfZVC0z6K1/3Vw2rXnaOCJkYqKvDx09xkdFohf?=
 =?us-ascii?Q?AyiEpOnlD/qb7/fRz5tPohXyy/lRS0yBVbVmeICPVqlz4G/AV9ohubLMAQ2n?=
 =?us-ascii?Q?3KS2ACMSh1fkN1gS8B1Jzt2HYrRFAh+ND8vIppo4v8Zt3fQlp7S1iXGqkkoI?=
 =?us-ascii?Q?0f6KBhYMYSGAqRH1jV9+o5qUP0q1XJt/0mklF+uVVoHcuQ6PClKJJ6QjZN1w?=
 =?us-ascii?Q?iB5adCGu6wtYnc78iVXxt68=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f489f186-4bdd-4dcb-878f-08dc3284944a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 02:26:58.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s34lNXclK3AHkJKJsWt6gfQwVIHRUKbW8Gqv7QA7diiQexHUEmptfWTssQdAR/h2IHDI5Hn3TNougpUxszO8OBVrSzON/sg/+wDNLycXsUWQL3kz8Jw3922KLMA0aMrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0541

Add StarFive external interrupt controller for JH8100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                |   6 +
 drivers/irqchip/Kconfig                    |  11 ++
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c | 208 +++++++++++++++++++++
 4 files changed, 226 insertions(+)
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
index 000000000000..0e6e10c321ff
--- /dev/null
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -0,0 +1,208 @@
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
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&irqc->lock, flags);
+	starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock_irqrestore(&irqc->lock, flags);
+}
+
+static void starfive_intc_mask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&irqc->lock, flags);
+	starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock_irqrestore(&irqc->lock, flags);
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


