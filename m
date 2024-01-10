Return-Path: <linux-kernel+bounces-22246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F231829B63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1CE1F25FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAA14C3B8;
	Wed, 10 Jan 2024 13:33:16 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2059.outbound.protection.partner.outlook.cn [139.219.146.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C02495E7;
	Wed, 10 Jan 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0ujGktmQkPSY2I3+KGW1mQXt7jXk7UqdLiVavZV19Q1W9jVBJANrloxvrGLUR/ek6UcKKxzOre6mqOE89rIOh/KIDXF3oU63PiL2ej1elkWaEUqRXkWAGTRHuc3lscfO5k/r4AvujaYxQXgd5RBn1vCbKMVYyQp1CcVuCV9mdvwl52VxyVABiwP4g1eBNNhz6RNK0yjTsZ8EfAx5+ZjR9kmQ9qfolkagoSU92AEh8Pda4hUMSvu1U+ujLmFb+BOa2a2MjUNSkvjAW4Zac7p3fWvYpHkcXEHZTOlf5QuXiJ3k/cC+R/kCA63zAzvibt3UWQchF9ewFfMqO50cnafyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkT1U6B4T9lveexxN2Xk/76AuS1PVR99s+TkNOSUKZU=;
 b=WhVQ63DkOjU4IRXGToEaYearLjD3YEYAAYmP6ss9g1/hC4/eeseEhcekIdPUpQXw3Vkw913tQJy27Vpw2j3eXcY0oe+xSnbcvg/kOPUKU6dvWXgcYc10ic3lGQzRxYCuT9V0lRvdE4gmkViHuB2cyVwbXnw/hAxDhdqYv48kiwSYBZBWiRaOAe5cKDEzY6RKwohag2PZqaM5XyLUFoRW+eGGzkacjGHFljldr8U9W6Jm2bfQMyDyg6g22fgd+fbwsapmPmny/eBl6uYQTYdGGlUxLAoNzhKpbr3CeGVw6KmP1wGy3xp7xAPp6KViFwprODAnijyoCI8x3WKw2P9weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0865.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:04 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:04 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com
Subject: [RFC v3 06/16] clk: starfive: Add JH8100 System clock generator driver
Date: Wed, 10 Jan 2024 21:31:18 +0800
Message-Id: <20240110133128.286657-7-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f3f8de-0cc8-418d-c1e5-08dc11e088c6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TnoP+X+5vf/r5+7Eb6FktG/NpjN2N1wXp3CDlCSqDT1U7hIqgemt/BMLadjiGSwm5ph1C6+5G0gUWh2Up3Qbxt1ymwz7uTExnn9aNhBbSeKZTXQBeLmLd8MiaGRmyTH5Riebw52cNIIovlDgDa4htXacT49myac67S7iSv/v8bxE86YIG9JOnDhmkqNBqLim9RnwZgcK9psF93KYDHeU0EadepH3F90ViXNxUIpy/MeR8wrWRRZJFNX8mW6htdutrQgdQEeUCPWukKfkq6GTGGijB+U8HoG2O7aVHBOwl77R12r8sJr1FD9jHARNRg8U6HgN/NTxWdBErpThriY6+Uk0dnfTYTigbnbnLAVwXKW60Mwxezy2CaJYge1iyyKFeJa8xuAmbEp5BtZNvTRcpnNtCC175+7edVd1KuZt0mQKhf1uuuEJF6LrLkG3cmmKa8pgqoWieAdlpnJwRGBf0nBByc5Cvp1V/whHE1l+c241/vJcfoPfFgYQuLnCBQWFW0up+fywrDJB79JICIQ5ltKBAAcKXF0NaVyVRkUOwRIhJ40LDCu6fgS2d9c+KzfPexmuuuxSPtoj+mZwEHAfbOIiDsn7VOYwSZ9MitiEqNUCOQ9bSUuh9sGc1PovozeU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39830400003)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6666004)(2616005)(1076003)(107886003)(26005)(508600001)(52116002)(55236004)(83380400001)(5660300002)(30864003)(2906002)(41300700001)(7416002)(4326008)(66946007)(8676002)(8936002)(6636002)(66476007)(66556008)(921011)(40160700002)(38100700002)(38350700005)(36756003)(40180700001)(86362001)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQ53TS5ZquLPbU0vIBigF6ZVz1j6PyU4Pm54ZsW+sqR/c98rBdDomwqg7j+j?=
 =?us-ascii?Q?CatYolmptZG7sRN2MQgkclesfCmXqVxJW7ZpuPFlYJLAeIHQLI+XBx7La0Bm?=
 =?us-ascii?Q?ql5sB1eo0/3r3hfo9YPvHJiiiWQ8ltIEsCPWITZWvJxEIBHY00pGsA8JPPJ0?=
 =?us-ascii?Q?hoPbrZJMYNPKKE9RxqmZqfigKjhARr2entZvmvfGmxBdZitav96vAMI4JXSE?=
 =?us-ascii?Q?wxuWbnI5PCh2ElF/Q36dTlYjIIBHDp8Gp67AAJJ2SxW8VGiUzBjSaO5P6x/J?=
 =?us-ascii?Q?2E0QgjykIUI/rMUaIsH4t/D1SwZik6Fgbw5kyCBkEpB4wCi2N0v/X4t2mPOz?=
 =?us-ascii?Q?U79Y57cN0nlaSDZlXfjh+Msg9Xo0+5amc2KXTBUe5q8DFADG7/Y42hWxoMPn?=
 =?us-ascii?Q?r9AzOl+hdn4xvb3qqGt87gSOtG7u4DaSGjyNQwwCPwOJLI2JRVbmciLza0tR?=
 =?us-ascii?Q?LRdhx6Qh8JlBBKimDYTCvGgSLNiBaDKWQSRjoCUG/VeT43emPWSgKfNhGy+n?=
 =?us-ascii?Q?zAitLZZsdHzsX9ykHmoCaC+KOINMYAue2Ny6VbcuaDcsvfZxzx83VoGM9WFN?=
 =?us-ascii?Q?/2po0SBvJKxfM6OqeV9KLuZMwKJ/cpw9JI5pRLsIwXgMGK7mZgD/NvPeaxsu?=
 =?us-ascii?Q?xdoqJ7sSdeEzVCt+NTOz2Vco/JivC2jcmctLjZrTcLNocJEQAkq96j3cfiVZ?=
 =?us-ascii?Q?1KcBszrqyMyw9gvsulvombquMowVxRAJP0fOfGFcL1DnG/TZ5RgLDx+zoF6d?=
 =?us-ascii?Q?/s+iehgCn9H+410y6or3wG+V6YCSZoEGxiykf/D2OZQ2EeXdM8u0WAPwcnay?=
 =?us-ascii?Q?FXYsmIy3XuNuobRnkxGMau4+2OpswF7TJV0fcrYJe7PL0RvDlXY4XoT++0V+?=
 =?us-ascii?Q?G1ewLpMp297CqXvdWpw6WZRz2LmY6K2bZfDQ8Hgn1mhLAK1vkEmDFXcKs2Sm?=
 =?us-ascii?Q?xhwc1+ObEfXw4sJo3SRVG4AzabixwMmHZcb8QWmESLRUSbRUlhTXfcZLXgl9?=
 =?us-ascii?Q?2P0Ddmf8/TAopCkhQ+bqfICelrwVSBuqSw+AGiscT3v/M9VpviIGa8Q6eGSM?=
 =?us-ascii?Q?45XupOamEN9z2iLG/blcvmkeh/sZDKQlVWoIuTSgxbALP247eXhBdyuIzCgb?=
 =?us-ascii?Q?dArRVg5VJ3JPq0cI2yKG+wMX+IyXTcapjPV5p/Dv25ZrermYVrRg99DtnuQZ?=
 =?us-ascii?Q?yqJKQHPNLUlIwlfS3LT/YQvrluUJUAyJEhUbgqxQVe6zvGlzOv08MQzU5MjL?=
 =?us-ascii?Q?lTPDRCR2Ew9d3bnfbgwhNiPvi9lrFqaaUjckFf8tN7XKRFZOIonU2XSrQhZL?=
 =?us-ascii?Q?KQ0UDrJ1EBbTPxrgr1SIcjzLAf1v93hx1uDnpHm9ZH4iM4B9KRKLYdmKwIm/?=
 =?us-ascii?Q?9ZXFtZwrzBfG1LC6Strn38wFbdp+cENUKoUjRB//4bxiJQXVTxaqu5T7KEBA?=
 =?us-ascii?Q?i7Ht6JW8PnlOmcvexqUFXQZYan47lv/MrPS1pA5wjBhPAz6IblgtRIRZt1T1?=
 =?us-ascii?Q?Oo44w5Du9Arh4UiwQl6tsQa7JKO0oxINurPja7IgqYZzGmrmRIAdixdimTdk?=
 =?us-ascii?Q?C7jQlIaR7zqGYs/7RC+dbjc17dnzy+oNoWmkHOMwYeVnN3rsiD69pVjXSSQi?=
 =?us-ascii?Q?opHDn7zb/OYYOLs3JWOiilU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f3f8de-0cc8-418d-c1e5-08dc11e088c6
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:04.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NH0D6baMINybR3wz5S//k18G6qZ0L+xcq4qdwwli7/qipE099HuXVSP1Wi3NOTbtHSpsahI/STqceA8RJxBJCKsbzChnyeuCZjch5qM/RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0865

Add support for JH8100 System clock generator (SYSCRG).

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   8 +
 drivers/clk/starfive/Kconfig                  |  10 +
 drivers/clk/starfive/Makefile                 |   2 +
 .../clk/starfive/clk-starfive-jh8100-sys.c    | 415 ++++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh8100.h    |  11 +
 5 files changed, 446 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 40c754b4c39c..c5d563594e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20730,6 +20730,14 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JH8100 CLOCK DRIVERS
+M:	Sia Jee Heng <jeeheng.sia@starfivetech.com>
+M:	Ley Foon Tan <leyfoon.tan@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/starfive,jh81*.yaml
+F:	drivers/clk/starfive/clk-starfive-jh81*
+F:	include/dt-bindings/clock/starfive?jh81*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index ff8eace36e64..1dddf1415360 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -72,3 +72,13 @@ config CLK_STARFIVE_JH7110_VOUT
 	help
 	  Say yes here to support the Video-Output clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH8100_SYS
+	bool "StarFive JH8100 System clock support"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the System clock controller on the StarFive JH8100 SoC.
+
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 012f7ee83f8e..af6903c4f987 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
+
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= clk-starfive-jh8100-sys.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-sys.c b/drivers/clk/starfive/clk-starfive-jh8100-sys.c
new file mode 100644
index 000000000000..6d7e750dce82
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-sys.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 System Clock Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <soc/starfive/reset-starfive-common.h>
+
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+#include "clk-starfive-jh8100.h"
+
+#define JH8100_SYSCLK_NUM_CLKS			(JH8100_SYSCLK_NNE_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_SYSCLK_OSC			(JH8100_SYSCLK_NUM_CLKS + 0)
+#define JH8100_SYSCLK_MCLK_EXT			(JH8100_SYSCLK_NUM_CLKS + 1)
+#define JH8100_SYSCLK_PLL0_OUT			(JH8100_SYSCLK_NUM_CLKS + 2)
+#define JH8100_SYSCLK_PLL1_OUT			(JH8100_SYSCLK_NUM_CLKS + 3)
+#define JH8100_SYSCLK_PLL2_OUT			(JH8100_SYSCLK_NUM_CLKS + 4)
+#define JH8100_SYSCLK_PLL3_OUT			(JH8100_SYSCLK_NUM_CLKS + 5)
+#define JH8100_SYSCLK_PLL4_OUT			(JH8100_SYSCLK_NUM_CLKS + 6)
+#define JH8100_SYSCLK_PLL6_OUT			(JH8100_SYSCLK_NUM_CLKS + 7)
+#define JH8100_SYSCLK_PLL7_OUT			(JH8100_SYSCLK_NUM_CLKS + 8)
+
+static const struct starfive_clk_data jh8100_syscrg_clk_data[] __initconst = {
+	/* root */
+	STARFIVE__DIV(JH8100_SYSCLK_VDEC_ROOT_PREOSC, "vdec_root_preosc", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VDEC_ROOT, "vdec_root", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VDEC_ROOT_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_VENC_ROOT_PREOSC, "venc_root_preosc", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VENC_ROOT, "venc_root", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VENC_ROOT_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_GPU_ROOT, "gpu_root", 7,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_GPU_CORE, "gpu_core", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_GPU_ROOT),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_ROOT0_PREOSC, "vout_root0_preosc", 127,
+		      JH8100_SYSCLK_PLL1_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VOUT_ROOT0, "vout_root0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VOUT_ROOT0_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_ROOT1_PREOSC, "vout_root1_preosc", 127,
+		      JH8100_SYSCLK_PLL6_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VOUT_ROOT1, "vout_root1", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VOUT_ROOT1_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_SCAN_ATS, "vout_scan_ats", 6,
+		      JH8100_SYSCLK_PLL3_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PERH_ROOT_PREOSC, "perh_root_preosc", 4,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_PERH_ROOT, "perh_root", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_PERH_ROOT_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_200_PREOSC, "axi_200_preosc", 4,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_200, "axi_200", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_200_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_200_GMAC, "axi_200_gmac", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_200_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_500_PREOSC, "axi_500_preosc", 10,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500, "axi_500", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX1A, "axi_500_pciex1a", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX1B, "axi_500_pciex1b", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX2, "axi_500_pciex2", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX8, "axi_500_pciex8", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_400_PREOSC, "axi_400_preosc", 10,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_400, "axi_400", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_400_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_400_APBOOTRAM, "axi_400_apbootram", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_400_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_125_PREOSC, "axi_125_preosc", 32,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_125, "axi_125", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_125_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AHB0_PREOSC, "ahb0_preosc", 15,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AHB0, "ahb0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AHB0_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_APB_BUS_FUNC, "apb_bus_func", 30,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS, "apb_bus", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER0, "apb_bus_per0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER1, "apb_bus_per1", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER2, "apb_bus_per2", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER3, "apb_bus_per3", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER4, "apb_bus_per4", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER5, "apb_bus_per5", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER6, "apb_bus_per6", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER7, "apb_bus_per7", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER8, "apb_bus_per8", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER9, "apb_bus_per9", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER10, "apb_bus_per10", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_SPI_CORE_100, "spi_core_100", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL1_DIV2, "pll1_div2", 2,
+		      JH8100_SYSCLK_PLL1_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL2_DIV2, "pll2_div2", 2,
+		      JH8100_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL3_DIV2, "pll3_div2", 2,
+		      JH8100_SYSCLK_PLL3_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL4_DIV2, "pll4_div2", 2,
+		      JH8100_SYSCLK_PLL4_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL6_DIV2, "pll6_div2", 2,
+		      JH8100_SYSCLK_PLL6_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL7_DIV2, "pll7_div2", 2,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_AUDIO_ROOT, "audio_root", 8,
+		      JH8100_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_MCLK_INNER, "mclk_inner", 64,
+		      JH8100_SYSCLK_AUDIO_ROOT),
+	STARFIVE__MUX(JH8100_SYSCLK_MCLK, "mclk", 2,
+		      JH8100_SYSCLK_MCLK_INNER, JH8100_SYSCLK_MCLK_EXT),
+	STARFIVE_GATE(JH8100_SYSCLK_MCLK_OUT, "mclk_out", 0,
+		      JH8100_SYSCLK_MCLK_INNER),
+	STARFIVE_MDIV(JH8100_SYSCLK_ISP_2X_PREOSC, "isp_2x_preosc", 8, 2,
+		      JH8100_SYSCLK_PLL7_OUT, JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_ISP_2X, "isp_2x", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_ISP_2X_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_ISP_AXI, "isp_axi", 4,
+		      JH8100_SYSCLK_ISP_2X),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK1, "gclk1", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL1_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK2, "gclk2", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL2_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK3, "gclk3", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL3_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK4, "gclk4", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL4_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK6, "gclk6", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL6_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK7, "gclk7", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL7_DIV2),
+	/* flexnoc (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_FLEXNOC0_PREOSC, "flexnoc0_preosc", 8,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_FLEXNOC0, "flexnoc0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC0_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_FLEXNOC1_PREOSC, "flexnoc1_preosc", 8,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_FLEXNOC1, "flexnoc1", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC1_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_FLEXNOC2_PREOSC, "flexnoc2_preosc", 12,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_FLEXNOC2, "flexnoc2", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC2_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_VDEC_CORE, "vdec_core", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC1_PREOSC),
+	/* img_gpu (se) */
+	STARFIVE_GATE(JH8100_SYSCLK_GPU_CORE_ICG, "gpu_core_icg", 0,
+		      JH8100_SYSCLK_GPU_CORE),
+	STARFIVE_GATE(JH8100_SYSCLK_IMG_GPU_CLK_APB, "img_gpu_clk_apb", 0,
+		      JH8100_SYSCLK_APB_BUS_PER7),
+	STARFIVE_GATE(JH8100_SYSCLK_IMG_GPU_RTC_TOGGLE, "img_gpu_rtc_toggle", 0,
+		      JH8100_SYSCLK_OSC),
+	STARFIVE_GATE(JH8100_SYSCLK_IMG_GPU_TIMER_USC, "img_gpu_timer_usc", 0,
+		      JH8100_SYSCLK_OSC),
+	/* hifi4 (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_HIFI4_CORE_PREOSC, "hifi4_core_preosc", 15,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_HIFI4_CORE, "hifi4_core", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_HIFI4_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_E_200_PREOSC, "e_200_preosc", 2,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_E_200, "e_200", 2, JH8100_SYSCLK_OSC,
+		      JH8100_SYSCLK_E_200_PREOSC),
+	/* hd audio */
+	STARFIVE__DIV(JH8100_SYSCLK_HD_AUDIO_48M, "hd_audio_48m", 80,
+		      JH8100_SYSCLK_PLL7_OUT),
+	/* dom vout */
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_DC_CORE, "vout_dc_core", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_AXI, "vout_axi", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	/* stg2_usb_wrap (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_625, "usb_wrap_625", 6,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_480, "usb_wrap_480", 8,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_240, "usb_wrap_240", 2,
+		      JH8100_SYSCLK_USB_WRAP_480),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_60, "usb_wrap_60", 10,
+		      JH8100_SYSCLK_USB_WRAP_480),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_156P25, "usb_wrap_156p25", 4,
+		      JH8100_SYSCLK_USB_WRAP_625),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_312P5, "usb_wrap_312p5", 2,
+		      JH8100_SYSCLK_USB_WRAP_625),
+	/* stg */
+	STARFIVE__DIV(JH8100_SYSCLK_USB_125M, "usb_125m", 32,
+		      JH8100_SYSCLK_PLL0_OUT),
+	/* Flexnoc (se) */
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_APBOOTRAM, "flexnoc_apbootram", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_400_APBOOTRAM),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1AMST, "flexnoc_pciex1amst", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1A),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1ASLV, "flexnoc_pciex1aslv", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1A),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1BMST, "flexnoc_pciex1bmst", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1B),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1BSLV, "flexnoc_pciex1bslv", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1B),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX2MST, "flexnoc_pciex2mst", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX2),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX2SLV, "flexnoc_pciex2slv", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX2),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX8MST, "flexnoc_pciex8mst", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX8),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX8SLV, "flexnoc_pciex8slv", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX8),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_GMACSYSSLV, "flexnoc_gmacsysslv", CLK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_200_GMAC),
+	/* gmac1 (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_GMAC_SRC, "gmac_src", 7,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_GMAC1_GTXCLK_TOP, "gmac1_gtxclk_top", 400,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_GMAC1_PTP, "gmac1_ptp", 31,
+		      JH8100_SYSCLK_GMAC_SRC),
+	/* hd audio */
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_SYSTEM_CLOCK, "hd_audio_system_clock", 0,
+		      JH8100_SYSCLK_APB_BUS_PER7),
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_CLOCK_48, "hd_audio_clock_48", 0,
+		      JH8100_SYSCLK_HD_AUDIO_48M),
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_BCLK_POST_OCC_IN, "hd_audio_bclk_post_occ_in", 0,
+		      JH8100_SYSCLK_HD_AUDIO_48M),
+	/* nne_vip (se) */
+	STARFIVE_GATE(JH8100_SYSCLK_NNE_VIP_ACLK, "nne_vip_aclk", 0, JH8100_SYSCLK_AXI_500),
+	STARFIVE_GATE(JH8100_SYSCLK_NNE_VIP_HCLK, "nne_vip_hclk", 0, JH8100_SYSCLK_AXI_200),
+	STARFIVE_GMUX(JH8100_SYSCLK_NNE_VIP_CLKCORE, "nne_vip_clkcore", 0, 2,
+		      JH8100_SYSCLK_PLL2_OUT, JH8100_SYSCLK_PLL0_OUT),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_SYSCLK_GPU_ICG_EN, "gpu_en", 0, JH8100_SYSCLK_GPU_CORE),
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_ICG_EN, "hd_audio_en", 0, JH8100_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH8100_SYSCLK_NNE_ICG_EN, "nne_en", CLK_IGNORE_UNUSED,
+		      JH8100_SYSCLK_PLL2_OUT),
+};
+
+static struct clk_hw *jh8100_sysclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH8100_SYSCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void jh8100_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void jh8100_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
+
+	kfree(rdev);
+}
+
+int jh8100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id)
+{
+	struct starfive_reset_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return -ENOMEM;
+
+	rdev->base = priv->base;
+
+	adev = &rdev->adev;
+	adev->name = adev_name;
+	adev->dev.parent = priv->dev;
+	adev->dev.release = jh8100_reset_adev_release;
+	adev->id = adev_id;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(priv->dev,
+					jh8100_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(jh8100_reset_controller_register);
+
+static int __init jh8100_syscrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_SYSCLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JH8100_SYSCLK_NUM_CLKS; idx++) {
+		u32 max = jh8100_syscrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_syscrg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_syscrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_syscrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_SYSCLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH8100_SYSCLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JH8100_SYSCLK_MCLK_EXT)
+				parents[i].fw_name = "mclk-ext";
+			else if (pidx == JH8100_SYSCLK_PLL0_OUT)
+				parents[i].fw_name = "pll0";
+			else if (pidx == JH8100_SYSCLK_PLL1_OUT)
+				parents[i].fw_name = "pll1";
+			else if (pidx == JH8100_SYSCLK_PLL2_OUT)
+				parents[i].fw_name = "pll2";
+			else if (pidx == JH8100_SYSCLK_PLL3_OUT)
+				parents[i].fw_name = "pll3";
+			else if (pidx == JH8100_SYSCLK_PLL4_OUT)
+				parents[i].fw_name = "pll4";
+			else if (pidx == JH8100_SYSCLK_PLL6_OUT)
+				parents[i].fw_name = "pll6";
+			else
+				parents[i].fw_name = "pll7";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_sysclk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sys", 0);
+}
+
+static const struct of_device_id jh8100_syscrg_match[] = {
+	{ .compatible = "starfive,jh8100-syscrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_syscrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-sys",
+		.of_match_table = jh8100_syscrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_syscrg_driver, jh8100_syscrg_probe);
diff --git a/drivers/clk/starfive/clk-starfive-jh8100.h b/drivers/clk/starfive/clk-starfive-jh8100.h
new file mode 100644
index 000000000000..9b69a56fe5fc
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLK_STARFIVE_JH8100_H
+#define __CLK_STARFIVE_JH8100_H
+
+#include "clk-starfive-common.h"
+
+int jh8100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id);
+
+#endif
-- 
2.34.1


