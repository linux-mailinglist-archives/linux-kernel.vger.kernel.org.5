Return-Path: <linux-kernel+bounces-43996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C17841BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E7628303F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53A37707;
	Tue, 30 Jan 2024 06:32:27 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2062.outbound.protection.partner.outlook.cn [139.219.146.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AB38F82;
	Tue, 30 Jan 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596346; cv=fail; b=c7ZgTV85LK63PEFQ1we5m3z7MoUWaBNx5+c9FFL9avnYcch10XFhBkHmQnl78HJq9VCvT4z7iR6dUGfxahLwc9paFqwVLJq9jb1Loq06AzRlw4sqeurXNB3b4wJJKTmFnoytPz9FOLq/7el8OliqMFYW5110XKEawdQemJ6XBw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596346; c=relaxed/simple;
	bh=yk7frkv5danfETUUdgxdaQ4ybQ0Q614XCBFahvs9iQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7xFYaRt5n2eiHCjfpD8Q5eaUYChSxDnUeRsuqXQYCYoY0/HmcA3VNPUAH604OuPEb24d2Zk7vTuZRUb1B8vqJAvahVaH61xPQ/m74d7G0Q1PgFcK3UIhiXz9/TI7HNum3kt9g4gVHJ8/oGPiKUkpjA3uXitqP8bGZsLBydiL28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+qXNmq7mHy+u+EQ3+R9uS2mEiSJ73a8E6vGtzjwQK+Rb23eYQU2yQQReUCdbMnKIPVRj3S8As+2JSpTd2v9t3j4SiFEzewMuoWBPTjIImDZIk4QuP9gfsoMvOcggGkSNBTNfOTHLTGO1m0iP1z9B02t+ny3h3sg+LdVRtwjleQuYGDWNL/xkE2Xa7gWZgENyB1goNdj3YFDed6jVb1fHLECV3Rtmf+X/XmVaArYxi/jnIhSR/14ZWHQRZpjy90Akg22boDYJZYYpK0Lt3fyxhcYyFtc07I4ZbRgnCUrsxDzH6Wpt900+A4lV9ozGRovIv/k2//v6eApH/iJiRsRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mGUyLJl1yAY6240/Gzp6AVO3eFqx0inKkbU7vmNsqE=;
 b=Io2Qr3D6br0VvswFTa3hzvoU5i9QZVK9N2XqWHof0hiaycFWsAbIRbVKGyQtGr5/M3Rzaoy6c0XwpwuG+53XODtlkFP+iukAB+UVkLR2s+bmYXM1voyso852nAquzlxOlpMJTrSwWR3BSedk+p6G1PH36C6vpNhe+P4EqrCm+wTDRGry0DeHLLoEKGao11T1LqtaBJlZri+Yzw2cW/xNvumUpSflcQRb6JY6aM5WnrUzh4cxQdV0XH+wKclTGnh2fDTD/nyLsSazpviBf4Gn3ekWYl1e8STmcUNGt9SencJ7ZDkOpZ5hzw04gwX7J0oXgRmbxTtHiQGgpPnrC8fahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0878.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Tue, 30 Jan
 2024 05:58:51 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Tue, 30 Jan 2024 05:58:51 +0000
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
Subject: [PATCH v2 2/2] irqchip: Add StarFive external interrupt controller
Date: Mon, 29 Jan 2024 21:58:43 -0800
Message-Id: <20240130055843.216342-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
References: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::8) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0878:EE_
X-MS-Office365-Filtering-Correlation-Id: 153e6806-d3e0-4d5a-43c2-08dc2158888b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6sQyF50dEMIkxakgP9qCXHGfJf/dbprsohGwuViZzTzvZ7c2yZnEB6C2XEECLioo4C64lgvKfezNY46U54oqxKUxAKhuyNdVIvkzyQkWtf0mCUb8OltBHIS2USZTmPM3nr9Sg+dhuM3N+J83eeVh258j31dviiIiuIFUSHCJcsxOCo3dSyX9UC+7up0ROoQ6YwttO/11wH8QTd8rJe/P+JeC8HVmLksSMSr+izNMVFQnYIRcy3+xzMUW19Tj6SDA/hHKN/OlwSHWWS1FALzux/1X2gEqRoBue2jcmbld6maN/yFJ2/vQUfQS1D4AKFsVYj5CewpusdOOwSmeohmlQ84LPHIJcvRoAJtV/u71vbiyI3Fb6f1QDX+6ZDYh4UHPEfGfMXA46I5Kj3+z5gqCKyEUYdc1eccFuyFboQd1nN9192vhB63Hp3XokvIOG7DUIRPZjW64m4CVQ7gf84AR5IUc0dlWyxoj140s7IRpqKZ6ADQi+MA01kdYRP2qU87eW8w+KyZjiYOOukLPzLlwv3rVa8sVtNqzPz9GZSNnc1TjHx9/xBTu1RU9HZtqygdKXe8OLW3hQmXXdHoKgRSAbM2Logk8QXtYTefWuvunlj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39830400003)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(41300700001)(1076003)(41320700001)(36756003)(38350700005)(2616005)(508600001)(40160700002)(40180700001)(54906003)(83380400001)(52116002)(6666004)(38100700002)(8676002)(5660300002)(110136005)(86362001)(66556008)(66476007)(4326008)(44832011)(2906002)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJZcHg3MqUTHoDXdBhk3aDFnjJafDP8b8comWMe2rqHR7eobeAjX65anO8h7?=
 =?us-ascii?Q?sBkQMx54tkDzHc002iwGmpYOy9nwXHPsmy+eenwXqf7qLtRZBjMA3hmeoVSU?=
 =?us-ascii?Q?uGabrD5R0XO4cLmVid3XqBR31P/po8Mk59OwvELTLLhbbIYa1G61T2C5wowD?=
 =?us-ascii?Q?XJvNTqp2F7+eQ0/d8aHpMr1Ih7YIjT8uue8V6HN4zFga7HD7lZeKwK7r8C1x?=
 =?us-ascii?Q?ZDB6GZ0v37Wfw+Nk7LUrfHiuMtGKPjmQ6VLb+fJp3FJmBusX3aQa3MDfeGHx?=
 =?us-ascii?Q?l9/bzxFG4hRy3YDbKmztwVZkQkpF3+Bfo9VS34AfmmwH2Oo7uHUOzYpwbYCy?=
 =?us-ascii?Q?vNtOcpcs7Wj6iLUsAo+9s54ZveFh0gK0PS+fpw1ZAwR58nvqtQCh8FU86MGX?=
 =?us-ascii?Q?x2/okiPsltk3BnmYCyzE5vMkbzxgREtRgzmx7quWYx4KzF8EO6xAslgtFCJw?=
 =?us-ascii?Q?tfyTVW8kR62HluH3iGHYcyKw10ikxJRs+SoJyI1v/wfZNf6eV0bECrStNKhY?=
 =?us-ascii?Q?fcK1XEQ1RIPk64c4+ggjF1WubyGKahaH9f54WZZwibASygFQVSSZDzot/ssM?=
 =?us-ascii?Q?Bu8nOwbdQIdj7y8wTqUNzHfCJDc04VaNV8HhxPQlDnuwO8OR7LL5CULn/Osm?=
 =?us-ascii?Q?JUSzvqVmuCFRLkDsl4B/lkAl28M+hzW3j25ODB7DroqEJgU9FZEXPXa3j16U?=
 =?us-ascii?Q?2mw9pE7bNEJ0gg0zFhe+7b9CP6jqCidBt8rrKMqj8Qt5LdIBUOH9pbvHj8mQ?=
 =?us-ascii?Q?jN5xBMHMmW3bOVhEkGB+33nSYduiw+ESnrUXrayDcgQ4yVO+wkxKqMM9AVXf?=
 =?us-ascii?Q?hod+dirwiTnGAYVmuTIWauch4udE9r4SsA/sw9vUl2J2hLmWOdmCd9vV+ZPY?=
 =?us-ascii?Q?et58fvHapaQ3YRwlM+onlhIYuQjuSmUeYsn8hFgft9Cj6KWHQIT0TG/nbNx0?=
 =?us-ascii?Q?x2Cd8oVZ5JgtEyoWQQo5IPQGVFqBryjN8AL4gTLnh05JNht2Gju0r5NR2zql?=
 =?us-ascii?Q?5KK0/C8ZnyoRQvT2kdetWgISsim8/28tLvNiWphAWf9ycCsGAI7L3iyY+haw?=
 =?us-ascii?Q?hWonu6DLslInZ0fBjy3iyZVe/1dUNrWBZVP5SF4Xkf3KhfXMd+35waEoaDyA?=
 =?us-ascii?Q?aGHiOQ6D5z52JSZG4NeMReQV6z8rKDUUb+8sWR4vxNssGRA6/h75wC5/q9qK?=
 =?us-ascii?Q?gg5up+nHMcTiX9qaI9txivXbSL+EsMA/JotIJDEvKuOj5RloqJoYIbgO2Ohi?=
 =?us-ascii?Q?3fPbskzqyOWoubhInVOq796CXVbxMdiHjm/0E1XZq9gb9IgpnAO8KaifH0+D?=
 =?us-ascii?Q?une2fT/vWa/P8+LRwLc9itQT8TIXapiLZVQM/+mvGfSNS6PliQQTwTxyrUnp?=
 =?us-ascii?Q?+kQHVKLxO3wWil9L6U7f5PM2yqb+MbhcO1wel59uiy7NbdQjyspHtOZx2RcT?=
 =?us-ascii?Q?1sdFaln6QXoAdgNW9nRezXOtUHgXsk7EfP6H9KaBzXfZ5n1Zsn8jbF4qNDvg?=
 =?us-ascii?Q?srgTlE1U1HziuvLsaS2huuH7i1k3FfYstlczGnast50As31MW5TRdVAnQ5aL?=
 =?us-ascii?Q?4gbyqPzeh7WX2UB5twKo2X1TXL3gpiXkgss2AJsgijg+FqzzJcIY9Nc6XjCS?=
 =?us-ascii?Q?VzMbOsBXKjt2TLE0Bq+ffKc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e6806-d3e0-4d5a-43c2-08dc2158888b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:58:51.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7Ht1j+BStyO6XlMZ85i6lhNHM+pNU78urFyFd/XETKut/qh4bFPQMemtr75OKpDJQTizSh1p7DdUBlKRDYJT5Lce1Ii8RCV+frK4PI2maAveKFubIHnUh3BGjluTC3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0878

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
index 8d1052fa6a69..ef678f04c830 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20956,6 +20956,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
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
index 000000000000..344f7d871518
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
+	struct reset_control *rst;
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
+	rst = of_reset_control_get_exclusive(intc, NULL);
+	if (IS_ERR(rst)) {
+		pr_err("Unable to get reset control %pe\n", rst);
+		ret = PTR_ERR(rst);
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
+	ret = reset_control_deassert(rst);
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


