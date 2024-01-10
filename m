Return-Path: <linux-kernel+bounces-22236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E325829B41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F80F289914
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C69487AF;
	Wed, 10 Jan 2024 13:32:26 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661EC48CCA;
	Wed, 10 Jan 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZVMNFLisAoAp73CJXvy534SiwuQTRbNvd/s9AtBXJPgc1DSs8KCngx1tilmomoWOB0FPpyoYeHxH089mFByyP5C5niaZJCpHf3D41whVEEEYsIfuem6E1+LeIce/03XRcwyB3lv16g7IJA5ZAiK6ruq/dUngnAaZEYJL/VodpFbBz1zejAkcb90tl4l0G8bNx8U1uOPb2+32/XhmZ+pQpnnggR80Ty+DB24pmQrGLq1RbrOM9TecLjJUxZNnqd/V2VOT9btWSgDBM6IASSN4ersSQBeMPl6amX7pX6Nf8JwqHjp+8N9e33KXXFN7NXdMMjGG3mMMEB9S0UcEtdQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnXNwJcBmYMxpU2vI+F/w4D2rbSa27tu39q2yXTnC0s=;
 b=oP+4SNEDorZWtBLkXgzZrmkPgqNzzb2T21ZW9hOY8EBIDPEoaq0Wd76VjM6v565froOHBAMoguINWLyMz8wMEFsmwcz8fY3JjdPuD8YFNRkc/kb1z1cB7RRxyPsTN6y0jBqeP0haRgL29gb2vFW8tlzsPK2eTgg7dD63SPC+Tzrq4DBBEBhbtwrfoBey1a/h8mkPacP/84kO0BTnUwYlTE9PyxwEH6aL8Ukgr2M13MqJdKowoxY5L8Xa7u0vtT5M7b4VgDURgRSbMeojsbdjxD3J7RZsh775txhkZkFIQic8s8GeGMxz3zStnl7U+UZ0cnlJgwxv7/lLRP5Evh7G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:12 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:12 +0000
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
Subject: [RFC v3 08/16] clk: starfive: Add JH8100 North-West clock generator driver
Date: Wed, 10 Jan 2024 21:31:20 +0800
Message-Id: <20240110133128.286657-9-jeeheng.sia@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0626:EE_
X-MS-Office365-Filtering-Correlation-Id: aed82801-5393-4652-9daa-08dc11e08d48
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jlz4cYJXwIBE1eEd9vV1xgBEkIksbQRbyLWFtXECbBUe3bzmfhIeKFYAHNaoGgcWPzGhI0rLL4tnkrLLBFrvd5FaplKNs00xP6QI7u66uG6AJqH6gqzX1eYkFPUuwKFyiBnb4ybUGqa+TkHaI0vsCf5nKMiPEiTmb2C111MjSj+ia9y+S/w3J5LwdD6P1c+fm/UhLTSBLbCGYp1vvKOSRFMVtSeHWyRZNUa8QeqNb/uaeWjMvmhWkLvbKgd3vtdeLZv/ElZL35g2nLBab7Kqw5txGe8Kh/9Ppox9JHP7tbUSbhziImWNey0KwgHyp+iPNRRMNqYyqkV4iOKE0hz8mc+yycqk/aZ389nIg5WVopWXn+y4EOkrhwWLvekll7OugE18GZRjRuYmHBWAqdehYbx+212dE2yxJaGFz4ASl+CoutIWCzc8V5X0uJvFCEsgNxzvUC+pzAGBwTyVWQ1yz+XXhEe61LGCo+9ubd0npwKhPInl8anxwHWVaou/GFGEwN2CE1aC04hHDy5VWTmdXfSzHpt/OPHtHerV5nqIvI4beciI5kSoZPNeYKTzK43vAAhxz3yZp34hIfo2LzC3qHcvT9IoOVwIIJBGQWa0+N3HgRM4IkbSVmqybRJc8FC+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(107886003)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(30864003)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxKUvg0NIZzGBzqruTqgGIo5rDAzCUmrtEZLNHFUCOkOp9tCwzOoCcYIY/7U?=
 =?us-ascii?Q?8FeJgNrg1M0Kir53g7GpIxZTrlZ0tBJeoKxJOp/r0F4eTU+p7WpWxnJr4+tf?=
 =?us-ascii?Q?lgj9fhOuwSMMBqSWEC1gN8OGYZ0NKnqtNRzO0YT8bE4E72NiIJG0KTFmZf3f?=
 =?us-ascii?Q?4KF9808l9A6+6hKKNLSVeDtwuFnE7/OufiI06UWwttkwyl+1IESnAMPtyDh2?=
 =?us-ascii?Q?zzvV9ad8uEnxnJkCOoxao+skqRnWKFiWRxJJ4Yv6DKKGQX3juHTxlIW9xnxE?=
 =?us-ascii?Q?kCp6rYOSNfW8IbwMlxyQLW0FnlS5CcxBJHtKSRHY9AVDt1h2Ds/wr6y0sd+B?=
 =?us-ascii?Q?RwpCxTo2VcKvwfff2TnSQqRUqHPvC3s8Os+toOIbobzNyTcoWm+/PDQFw/gE?=
 =?us-ascii?Q?TzCfM9YSl6a65A+GtlQ7AEh8qOAmv0S5gBJUdm7uZUyOGaPRCWS7sBISEbXt?=
 =?us-ascii?Q?ifNzb8FKyLKmAtUQErw02SIDzILzatU2CnWPwe+jmEafcX/uyeoS5Pxt4eNn?=
 =?us-ascii?Q?zEr/D72fzkAakVRvEd69rF6k6OjWXnRitIZxQh8UJhoBZLS+mwuznOFsMIm/?=
 =?us-ascii?Q?Fc9MAMn6FDY/dc31PrJYvLCQ/obGA8Z8SUGQo1EJRnrLA3kPGnPeFu6hADSl?=
 =?us-ascii?Q?0W5bEKQd3RXlrWBFIHMBrc+3QZE5O+zTgMWYjuUA2cpYx9tOyO8La6JZbGT1?=
 =?us-ascii?Q?5fA6DN9oORJHvsU+zurgVIsXg1KGMLSIqPuGlDjp7jlan0bSIaH8JGHtLNAU?=
 =?us-ascii?Q?Pbv3rZEHYF9iHMzYOh1FzSmZm85b6f7qaMDSz30vliTDaB7C4VniVcKxUImE?=
 =?us-ascii?Q?h9Hw1MTGsah8m6quysPyENTkd5YvSDzsWaGxYct/vSkt2e52kd9tCIoIsY1L?=
 =?us-ascii?Q?W9JTFPPfvCv8uJkIFrT84nyY+zVCMJBp2AnHibjv3qFivAJmSLkNpzav0++C?=
 =?us-ascii?Q?MQlxCNXZ+dNEXUcdqNwKrEp9fO7BCkAbRswkLcLFleRnJRF+GhYoA1cDQ5O3?=
 =?us-ascii?Q?2TjURxtScVe//52+7EGwjCm+kOTA9kqOA5k64/dez1qPyenr99YkYWWk/49M?=
 =?us-ascii?Q?JxLSFx9jjgsXt976KkImsa6jA863IQWEsLYBPu/jMFpwEMbKKoBtZZo9FgLF?=
 =?us-ascii?Q?NCvcCKMrYsbduVC8k/hxk5bYcJv9fionbUkufDjpXVQF0tYU+1IeMawkymQ9?=
 =?us-ascii?Q?zKZoKayI2bUnuEKsgydUVWtUYMc6IRgtXM3UghZ2gm8AeMKUoMic3ZAiptxH?=
 =?us-ascii?Q?5B7Wj67NkarGa6DdcwVbyQrNyR+uHtF68XggTBd74NtI0XbN6k1ftnZT4JTI?=
 =?us-ascii?Q?1XPo/mfkBMJsXwqEqWELMCK9rg2CWlXkMFZM5hVzpMHK4XySlZRCkqCocRv7?=
 =?us-ascii?Q?Ropk/VEVgOgqHci9/SGgpQgY1E7yc9PBdho/rocb743N5OAqQVLt1PZxu0PW?=
 =?us-ascii?Q?No2Vo5b4YOc/PwvD5cO5V6A6VU6Tgan0AnrfBS04oAFVvEupU6eRgOVc06rC?=
 =?us-ascii?Q?tyjS6yaIrlYYIY+GfVbRKlR9GcHtfCVhXA+COzUK8Sm47fYPBR1dnGs15xhz?=
 =?us-ascii?Q?L+GYq6nqQDGEl5y1QzYhDmlVSMh3I66z/VQsMKoi/px+WUz+wd9FwOcVevVG?=
 =?us-ascii?Q?LkPHwqe7PpMxrR741f42X38=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed82801-5393-4652-9daa-08dc11e08d48
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:12.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEUWv1jhqe9/DCfUEki90Fxf6n9qylxkB7k+FeYoicT0OXioG7RgkHllmtNvpCILXizbX8r3uHM9mn/IFx7woaGlkdutHDH3qaur/Kd8uG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add support for JH8100 North-West (NWCRG) clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Makefile                 |   1 +
 drivers/clk/starfive/clk-starfive-jh8100-nw.c | 237 ++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-nw.c

diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index af6903c4f987..2ba07d3398f0 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= clk-starfive-jh8100-sys.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_NW)	+= clk-starfive-jh8100-nw.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-nw.c b/drivers/clk/starfive/clk-starfive-jh8100-nw.c
new file mode 100644
index 000000000000..018f5af6c777
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-nw.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 North-West Clock Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+#include "clk-starfive-jh8100.h"
+
+#define JH8100_NWCLK_NUM_CLKS				(JH8100_NWCLK_UART6_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_NWCLK_OSC				(JH8100_NWCLK_NUM_CLKS + 0)
+#define JH8100_NWCLK_APB_BUS				(JH8100_NWCLK_NUM_CLKS + 1)
+#define JH8100_NWCLK_APB_BUS_PER4			(JH8100_NWCLK_NUM_CLKS + 2)
+#define JH8100_NWCLK_SPI_CORE_100			(JH8100_NWCLK_NUM_CLKS + 3)
+#define JH8100_NWCLK_ISP_2X				(JH8100_NWCLK_NUM_CLKS + 4)
+#define JH8100_NWCLK_ISP__AXI				(JH8100_NWCLK_NUM_CLKS + 5)
+#define JH8100_NWCLK_VOUT_ROOT0				(JH8100_NWCLK_NUM_CLKS + 6)
+#define JH8100_NWCLK_VOUT_ROOT1				(JH8100_NWCLK_NUM_CLKS + 7)
+#define JH8100_NWCLK_VOUT_SCAN__ATS			(JH8100_NWCLK_NUM_CLKS + 8)
+#define JH8100_NWCLK_VOUT_DC__CORE			(JH8100_NWCLK_NUM_CLKS + 9)
+#define JH8100_NWCLK_VOUT__AXI				(JH8100_NWCLK_NUM_CLKS + 10)
+#define JH8100_NWCLK_AXI_400				(JH8100_NWCLK_NUM_CLKS + 11)
+#define JH8100_NWCLK_DVP_EXT				(JH8100_NWCLK_NUM_CLKS + 12)
+#define JH8100_NWCLK_ISP_DPHY_TAP_TCK_EXT		(JH8100_NWCLK_NUM_CLKS + 13)
+#define JH8100_NWCLK_GLB_EXT				(JH8100_NWCLK_NUM_CLKS + 14)
+#define JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK_EXT		(JH8100_NWCLK_NUM_CLKS + 15)
+#define JH8100_NWCLK_VOUT_EDP_TAP_TCK_EXT		(JH8100_NWCLK_NUM_CLKS + 16)
+#define JH8100_NWCLK_SPI_IN2_EXT			(JH8100_NWCLK_NUM_CLKS + 17)
+#define JH8100_NWCLK_PERH_ROOT_PREOSC			(JH8100_NWCLK_NUM_CLKS + 18)
+#define JH8100_NWCLK_AHB_VOUT				(JH8100_NWCLK_NUM_CLKS + 19)
+#define JH8100_NWCLK_PLL5_OUT				(JH8100_NWCLK_NUM_CLKS + 20)
+
+static const struct starfive_clk_data jh8100_nwcrg_clk_data[] = {
+	/* root */
+	STARFIVE__DIV(JH8100_NWCLK_PLL5_DIV2, "pll5_div2", 2, JH8100_NWCLK_PLL5_OUT),
+	STARFIVE_GDIV(JH8100_NWCLK_GCLK5, "gclk5", CLK_IS_CRITICAL, 120, JH8100_NWCLK_PLL5_DIV2),
+	/* gpio */
+	STARFIVE_GATE(JH8100_NWCLK_GPIO_100, "gpio_100", CLK_IS_CRITICAL, JH8100_NWCLK_PLL5_OUT),
+	STARFIVE_GATE(JH8100_NWCLK_GPIO_50, "gpio_50", CLK_IS_CRITICAL, JH8100_NWCLK_PLL5_OUT),
+	STARFIVE_GATE(JH8100_NWCLK_GPIO_150, "gpio_150", CLK_IS_CRITICAL, JH8100_NWCLK_PLL5_OUT),
+	STARFIVE_GDIV(JH8100_NWCLK_GPIO_60, "gpio_60", CLK_IS_CRITICAL, 30, JH8100_NWCLK_PLL5_OUT),
+	/* iomux */
+	STARFIVE_GATE(JH8100_NWCLK_IOMUX_WEST_PCLK, "iomux_west_pclk", 0,
+		      JH8100_NWCLK_APB_BUS_PER4),
+	/* i2c */
+	STARFIVE_GATE(JH8100_NWCLK_I2C6_APB, "i2c6_apb", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_I2C7_APB, "i2c7_apb", 0, JH8100_NWCLK_APB_BUS_PER4),
+	/* spi */
+	STARFIVE_GATE(JH8100_NWCLK_SPI2_APB, "spi2_apb", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_SPI2_CORE, "spi2_core", 0, JH8100_NWCLK_SPI_CORE_100),
+	STARFIVE__MUX(JH8100_NWCLK_SPI2_SCLK_IN, "spi2_sclk_in", 2,
+		      JH8100_NWCLK_SPI_IN2_EXT, JH8100_NWCLK_GPIO_100),
+	/* smbus */
+	STARFIVE_GATE(JH8100_NWCLK_SMBUS1_APB, "smbus1_apb", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GDIV(JH8100_NWCLK_SMBUS1_CORE, "smbus1_core", CLK_IGNORE_UNUSED, 120,
+		      JH8100_NWCLK_PERH_ROOT_PREOSC),
+	/* isp */
+	STARFIVE__MUX(JH8100_NWCLK_ISP_DVP, "isp_dvp", 2, JH8100_NWCLK_DVP_EXT,
+		      JH8100_NWCLK_GPIO_150),
+	STARFIVE_GATE(JH8100_NWCLK_ISP_CORE_2X, "isp_core_2x", 0, JH8100_NWCLK_ISP_2X),
+	STARFIVE_GATE(JH8100_NWCLK_ISP_AXI, "isp_axi_nw", 0, JH8100_NWCLK_ISP__AXI),
+	STARFIVE__MUX(JH8100_NWCLK_ISP_DPHY_TAP_TCK, "isp_dphy_tap_tck", 2,
+		      JH8100_NWCLK_ISP_DPHY_TAP_TCK_EXT, JH8100_NWCLK_GLB_EXT),
+	STARFIVE_GATE(JH8100_NWCLK_FLEXNOC_ISPSLV, "flexnoc_ispslv", 0, JH8100_NWCLK_ISP__AXI),
+	/* vout */
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_PIX0, "vout_pix0", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_VOUT_ROOT0),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_PIX1, "vout_pix1", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_VOUT_ROOT1),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_SCAN_ATS, "vout_scan_ats_nw",
+		      CLK_IGNORE_UNUSED, JH8100_NWCLK_VOUT_SCAN__ATS),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_DC_CORE, "vout_dc_core_nw",
+		      CLK_IGNORE_UNUSED, JH8100_NWCLK_VOUT_DC__CORE),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_APB, "vout_apb", CLK_IGNORE_UNUSED, JH8100_NWCLK_APB_BUS),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_DSI, "vout_dsi", CLK_IGNORE_UNUSED, JH8100_NWCLK_AXI_400),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_AHB, "vout_ahb", CLK_IGNORE_UNUSED, JH8100_NWCLK_AHB_VOUT),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_AXI, "vout_axi_nw", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_VOUT__AXI),
+	STARFIVE__MUX(JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK, "vout_mipi_dphy_tap_tck", 2,
+		      JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK_EXT, JH8100_NWCLK_GLB_EXT),
+	STARFIVE__MUX(JH8100_NWCLK_VOUT_EDP_PHY_TAP_TCK, "vout_edp_phy_tap_tck", 2,
+		      JH8100_NWCLK_VOUT_EDP_TAP_TCK_EXT, JH8100_NWCLK_GLB_EXT),
+	/* uart */
+	STARFIVE__DIV(JH8100_NWCLK_UART5_CORE_PREOSC, "uart5_core_preosc", 131071,
+		      JH8100_NWCLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NWCLK_UART5_APB, "uart5_apb", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GMUX(JH8100_NWCLK_UART5_CORE, "uart5_core", 0, 2,
+		      JH8100_NWCLK_OSC, JH8100_NWCLK_UART5_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_NWCLK_UART6_CORE_PREOSC, "uart6_core_preosc", 131071,
+		      JH8100_NWCLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NWCLK_UART6_APB, "uart6_apb", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GMUX(JH8100_NWCLK_UART6_CORE, "uart6_core", 0, 2,
+		      JH8100_NWCLK_OSC, JH8100_NWCLK_UART6_CORE_PREOSC),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_NWCLK_SPI2_ICG_EN, "spi2_en", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_SMBUS1_ICG_EN, "smbus1_en", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_ISP_ICG_EN, "isp_en", 0, JH8100_NWCLK_ISP__AXI),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_ICG_EN, "vout_en", 0, JH8100_NWCLK_VOUT_ROOT0),
+	STARFIVE_GATE(JH8100_NWCLK_UART5_ICG_EN, "uart5_en", 0, JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_UART6_ICG_EN, "uart6_en", 0, JH8100_NWCLK_APB_BUS_PER4),
+};
+
+static struct clk_hw *jh8100_nwcrg_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH8100_NWCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_nwcrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_NWCLK_NUM_CLKS),
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
+	for (idx = 0; idx < JH8100_NWCLK_NUM_CLKS; idx++) {
+		u32 max = jh8100_nwcrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_nwcrg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_nwcrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_nwcrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_NWCLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH8100_NWCLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JH8100_NWCLK_APB_BUS)
+				parents[i].fw_name = "apb_bus";
+			else if (pidx == JH8100_NWCLK_APB_BUS_PER4)
+				parents[i].fw_name = "apb_bus_per4";
+			else if (pidx == JH8100_NWCLK_SPI_CORE_100)
+				parents[i].fw_name = "spi_core_100";
+			else if (pidx == JH8100_NWCLK_ISP_2X)
+				parents[i].fw_name = "isp_2x";
+			else if (pidx == JH8100_NWCLK_ISP__AXI)
+				parents[i].fw_name = "isp_axi";
+			else if (pidx == JH8100_NWCLK_VOUT_ROOT0)
+				parents[i].fw_name = "vout_root0";
+			else if (pidx == JH8100_NWCLK_VOUT_ROOT1)
+				parents[i].fw_name = "vout_root1";
+			else if (pidx == JH8100_NWCLK_VOUT_SCAN__ATS)
+				parents[i].fw_name = "vout_scan_ats";
+			else if (pidx == JH8100_NWCLK_VOUT_DC__CORE)
+				parents[i].fw_name = "vout_dc_core";
+			else if (pidx == JH8100_NWCLK_VOUT__AXI)
+				parents[i].fw_name = "vout_axi";
+			else if (pidx == JH8100_NWCLK_AXI_400)
+				parents[i].fw_name = "axi_400";
+			else if (pidx == JH8100_NWCLK_DVP_EXT)
+				parents[i].fw_name = "dvp-ext";
+			else if (pidx == JH8100_NWCLK_ISP_DPHY_TAP_TCK_EXT)
+				parents[i].fw_name = "isp-dphy-tap-tck-ext";
+			else if (pidx == JH8100_NWCLK_GLB_EXT)
+				parents[i].fw_name = "glb-ext-clk";
+			else if (pidx == JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK_EXT)
+				parents[i].fw_name = "vout-mipi-dphy-tap-tck-ext";
+			else if (pidx == JH8100_NWCLK_VOUT_EDP_TAP_TCK_EXT)
+				parents[i].fw_name = "vout-edp-tap-tck-ext";
+			else if (pidx == JH8100_NWCLK_SPI_IN2_EXT)
+				parents[i].fw_name = "spi-in2-ext";
+			else if (pidx == JH8100_NWCLK_PERH_ROOT_PREOSC)
+				parents[i].fw_name = "perh_root_preosc";
+			else if (pidx == JH8100_NWCLK_AHB_VOUT)
+				parents[i].fw_name = "ahb0";
+			else
+				parents[i].fw_name = "pll5";
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_nwcrg_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-nw", 1);
+}
+
+static const struct of_device_id jh8100_nwcrg_match[] = {
+	{ .compatible = "starfive,jh8100-nwcrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_nwcrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-nw",
+		.of_match_table = jh8100_nwcrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_nwcrg_driver, jh8100_nwcrg_probe);
-- 
2.34.1


