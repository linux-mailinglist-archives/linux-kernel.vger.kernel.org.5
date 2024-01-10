Return-Path: <linux-kernel+bounces-22242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC490829B56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C47B2299C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD474BA90;
	Wed, 10 Jan 2024 13:32:38 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02624B5B5;
	Wed, 10 Jan 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSAVJzfEWpRdnWNq4nhHzLWRTi4n4DuuyWWHt09BcM8B84zKKypH+SM6fxJdrZeQVXnikfOs820W051Yx0S6VWhumWxwGuS+ChRcCBKiub8Yhz8nzzLM9Z17iYHV5aAHkQNnlm5fY8Puis6qKMndZRtpwtddBzbsIreWmIZbr9lCLS7N8qcDFyYKHlxe7lbhRCB0SVBsq7e6s7Yy8mF9caHUYex7S47yEZ3ydhVVfieBKaGIuRnoILGkbSvQPggiPIYuGlywY9JqmklknaIJ9RndTPSL69hnhz5pC8PrOSbzYaZhTBvplqTKW9wW1Oqed3xcNr3GWxT0T8XCGeY3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/CveWqH6dj0kaGQ76WGcyUdtzX7u/fuiu1IbOBqVNI=;
 b=MiWYdcJlfYbouZ0M7668zJLCsmY5F2lMb45vajxunZW6Tr16b8ZqGJk+AWsbFMJ1SNWoLx3dKI9d2JZLFp9gY7nI3CBw/CY/BaSLEHIQZOSlFv4eDcgPYSTMTMmT3aT5J5fLr9bdRjJqvsbA0adHLHc/2xbQ1QkzyA0BjJbSScCpFZmX7pV2KAD8XY/ZyAZ9YIZSHfAvE6BNPb3cTelfQwqNI6bqeqV4Qh0g3XFw0LJ4U4pv8yavUhkV9q2pMCQoNmDAnQd4t3DkBCqoQtPFujQT9ofzPGz86AeROwHsjeJ+a8EH6O41Mewk7uIxsbHxdXBBfK1IQznRDpKrYLfvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:34 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:34 +0000
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
Subject: [RFC v3 14/16] clk: starfive: Add JH8100 Always-On clock generator driver
Date: Wed, 10 Jan 2024 21:31:26 +0800
Message-Id: <20240110133128.286657-15-jeeheng.sia@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: e38f0f7e-1dae-4ed0-add5-08dc11e09a67
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CNqh0N12Hnp2mOcl07EQjUt++Z7tYmdnWPhLzZNYu8G74UVw1Kg9MLmNjodERCiSRpMyizxbnJZXu/N+HuD/bubDoXrP93drS6PWyOVGaiT21OSl0XH+nrbmUCT7hFGtPXGq0PopKBe47ejt0XnAMY6Dpxf8WK+buwe8QGONB8iHq6j3gYX9WOncdCNdOKvZqByxwdcxFHb3vH3YqVBrGhY0oUgATgqbe9Cig8faKP/LOxSlLy4uTqpHEbOZrZo7nTFNTcWhE7dMbOEwTaXyBkCTDJ289WWBu+4QuTD5YEAgee2vcZROndZ/4EhB+HJjVbrZtVw9lp5rIw/7BUx24CgkXopv2DENEJa3kCpEOIAoDM6tej75WCuPx1YiOluz/exgNMJydEe3edP0hy60SlwbXo4kG/37PUkiedYXXFc5VURQZ2MyLrFbFMLUv2fd8r6ZnT7rqOqTJPkoTdfOp5bdzIAni1Jd+CPircRDL9+hQ7F/mnNlC9qmZNRRBtiSaxLTgVHP3MPPzI2YhdXWaKpU68OGL7oqmRQU59vCSUR7v5f0hbADP95pgsUq22ukw73D3txGp6cBRAnF0YA1ibzPExExyz8Eqc5Q3ej3JwP+uxOqPmjxYK6CdwiEG2bb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(107886003)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(30864003)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7CRYnZT2DGbY0wVb6PL4qLUn/YzcfLSesaiydSX5tDy5xyG5BdAo36kgJ/1c?=
 =?us-ascii?Q?v2gLmM4p8R5AgUkF6puUM16w6K+H9VwGXgEMeQCJgf/I0MzabUgmxP0Vrlnu?=
 =?us-ascii?Q?OtRVv2t50dj7YOmj88nJUOA+xJAzbQZEDYWR5XFDJEb/Onb5jNAmwXScpeaI?=
 =?us-ascii?Q?Ajw4gt9To3007AXj32+hplLAWXZKIvlTrbsMsCI/1EQ/AY9QLP0MzZE2awSg?=
 =?us-ascii?Q?QOshrcfutXzjDUo1CBt2kWQdiD0NlZUgMFF9jzjuJV0KP8sqK0MoJNdJ1fUU?=
 =?us-ascii?Q?o/QgXh1IOHB0T5AKvi98mZ9TxSbjwBEL992g+wzneAsdpL/Vu10pGkoHxopk?=
 =?us-ascii?Q?5n0g3o7QgqA9POxRhijuz+YfstbO/a7T+EEBOtjdgGPnWSx3ltyLReLCPrLZ?=
 =?us-ascii?Q?0e5MXO91wjGsiiq6bUsP8Cqjw2BmXExZzDbHhBUYeuv4SV9axBGtdeyrHS52?=
 =?us-ascii?Q?YLqoxdDSWhHFDYitDrgT/V8OiOvz8cVpBDa28ZaW4+HMJlG5yZiwm4BR9JkM?=
 =?us-ascii?Q?tf/smKgdaQWPWBUQIBBEoqB/1btXOkA8wuVS1c3RsnpX9z3TD+rNxzUyXmTz?=
 =?us-ascii?Q?+8jc8fLW0T9C9c2qiKrGnEl72nyalyJzSLehWbJNXEOatTG15OFECKLH0yn+?=
 =?us-ascii?Q?f/kUQaxwoqrsrFJgD+oU6Xirmjx3xxARQQDgIytiFh24Gkwg+jlxTqRnjj7P?=
 =?us-ascii?Q?b2l872XQDRITs4IV6TnwnCJA12Vi2JEL2AXJVBKx8HvcO0dEOI8IWNGWMfdV?=
 =?us-ascii?Q?OZopwwNoVwUv3bf2WleviH4uy4nL1f7Sa6MdYQmrcRuwIhO9WOeQiBGhNOSr?=
 =?us-ascii?Q?W34JYcZlE20/RCeTKDqxusZi+5fIBIwIyacmTmRWfnVVFbUo1qMrGEWXym4t?=
 =?us-ascii?Q?M47WBM2a2D7g9Z7d7Ecr43bh36TKVFb/tgNMArFXxrvFLG5o7xBW1F9H1BOy?=
 =?us-ascii?Q?hQZhrV4/03w0z6zArXQt2GnM49n1xEjA8FIJXTItsPFOf+EHptwDKf7kRtdQ?=
 =?us-ascii?Q?WEzey6QnOevpJI/JJuGEtzcFbFKIXjHaeT7SkmAlJ3lzlRQv+xilRwnfyBck?=
 =?us-ascii?Q?8FNGGQ3b63PUy8v0uhDV0cEa/IVuPSqeFD/BnVjOfm0i8W7NrvOd6ODmGJYd?=
 =?us-ascii?Q?kLkI1na/RivJCTSsx+j+rXZTcQAXmve8QiI3iia/1YjhD8qnFkPkpePGUi8P?=
 =?us-ascii?Q?gEjkOOR+YPYdTAihJ293+ySez9SdHjI277yPYwIeFfRXtXCiZ1zYPAYmiaKl?=
 =?us-ascii?Q?okc+IaVN+EtmV4qykGcYXZO054UyFAUiYxb7jOywvlz7/54w357BCyDRLPIL?=
 =?us-ascii?Q?BGnFZywYVOYcp2M5OOtfsY9UbjgdOphOTHMYgUn4I/Xa/35fRZRffPhtidc6?=
 =?us-ascii?Q?nTXmIJ0n9tigK1M/cImg0TF4NmRJ6VQlBr2I4L0LIKuOsfconF/gNvBz8el/?=
 =?us-ascii?Q?BwbvtGz/ZxxEGm4S9GIIJeprL3vRhZR543XBnowqYZuIEuZF2tYK2dFKJQN3?=
 =?us-ascii?Q?kjZKLjt/7HY+yO1NYYP3bhpHuZUo+VQMEJ3rZsXfXdvvTZif1FlkB8cry3dG?=
 =?us-ascii?Q?TOv0Zvrxn2XvHU49fQRTUzh8VS1DWGs1CuQG4sMo+aTdCN/qvHpq0sqetziQ?=
 =?us-ascii?Q?BM/HbHE1R7GgFTPLbDcgdAo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38f0f7e-1dae-4ed0-add5-08dc11e09a67
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:34.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8fni7zA4KxqD75bWa8gU8DzCp7QpZvSysh7Cffsm0laqKVXhLK8siCKfd8XIQunttgS4PTxz3Eno25+2W77hlxqaZHtOOriZHhurEQ5418=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add support for JH8100 Always-On (AONCRG) clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   7 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh8100-aon.c    | 256 ++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-aon.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 23ae894fedb9..3b1fbc795879 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -102,3 +102,10 @@ config CLK_STARFIVE_JH8100_SW
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the South-West clock controller on the StarFive JH8100 SoC.
+
+config CLK_STARFIVE_JH8100_AON
+	bool "StarFive JH8100 Always-On clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the Always-On clock controller on the StarFive JH8100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 242e2e75dadb..e498f1761c2d 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= clk-starfive-jh8100-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NW)	+= clk-starfive-jh8100-nw.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NE)	+= clk-starfive-jh8100-ne.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SW)	+= clk-starfive-jh8100-sw.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_AON)	+= clk-starfive-jh8100-aon.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-aon.c b/drivers/clk/starfive/clk-starfive-jh8100-aon.c
new file mode 100644
index 000000000000..ea547fbab6c7
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-aon.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 Always-On Clock Driver
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
+#define JH8100_AONCLK_NUM_CLKS		(JH8100_AONCLK_TOP_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_AONCLK_OSC		(JH8100_AONCLK_NUM_CLKS + 0)
+#define JH8100_AONCLK_GMAC0_RMII_FUNC	(JH8100_AONCLK_NUM_CLKS + 1)
+#define JH8100_AONCLK_AON_50		(JH8100_AONCLK_NUM_CLKS + 2)
+#define JH8100_AONCLK_GMAC0_RGMII_FUNC	(JH8100_AONCLK_NUM_CLKS + 3)
+#define JH8100_AONCLK_AON_125		(JH8100_AONCLK_NUM_CLKS + 4)
+#define JH8100_AONCLK_AON_2000		(JH8100_AONCLK_NUM_CLKS + 5)
+#define JH8100_AONCLK_AON_200		(JH8100_AONCLK_NUM_CLKS + 6)
+#define JH8100_AONCLK_AON_667		(JH8100_AONCLK_NUM_CLKS + 7)
+#define JH8100_AONCLK_RTC		(JH8100_AONCLK_NUM_CLKS + 8)
+
+static const struct starfive_clk_data jh8100_aoncrg_clk_data[] = {
+	/* source */
+	STARFIVE__MUX(JH8100_AONCLK_GMAC0_RMII_REFIN, "gmac0_rmii_refin", 2,
+		      JH8100_AONCLK_GMAC0_RMII_FUNC, JH8100_AONCLK_AON_50),
+	STARFIVE__MUX(JH8100_AONCLK_GMAC0_RGMII_RXIN, "gmac0_rgmii_rxin", 2,
+		      JH8100_AONCLK_GMAC0_RGMII_FUNC, JH8100_AONCLK_AON_125),
+	STARFIVE__DIV(JH8100_AONCLK_GMAC0_GTXCLK, "gmac0_gtxclk", 50, JH8100_AONCLK_AON_125),
+	STARFIVE__DIV(JH8100_AONCLK_AON_1000, "aon_1000", 2, JH8100_AONCLK_AON_2000),
+	STARFIVE__DIV(JH8100_AONCLK_AON_400, "aon_400", 5, JH8100_AONCLK_AON_2000),
+	STARFIVE__MUX(JH8100_AONCLK_AON_400_POSTOSC, "aon_400_postosc", 2,
+		      JH8100_AONCLK_OSC, JH8100_AONCLK_AON_400),
+	STARFIVE__DIV(JH8100_AONCLK_AON_500, "aon_500", 4, JH8100_AONCLK_AON_2000),
+	STARFIVE__MUX(JH8100_AONCLK_AON_500_POSTOSC, "aon_500_postosc", 2,
+		      JH8100_AONCLK_OSC, JH8100_AONCLK_AON_500),
+	STARFIVE__DIV(JH8100_AONCLK_XSPI_PHY, "xspi_phy", 4, JH8100_AONCLK_AON_200),
+	STARFIVE__DIV(JH8100_AONCLK_AON_100, "aon_100", 2, JH8100_AONCLK_AON_200),
+	STARFIVE__MUX(JH8100_AONCLK_AON_100_POSTOSC, "aon_100_postosc", 2,
+		      JH8100_AONCLK_OSC, JH8100_AONCLK_AON_100),
+	STARFIVE__MUX(JH8100_AONCLK_AON_50_POSTOSC, "aon_50_postosc", 2,
+		      JH8100_AONCLK_OSC, JH8100_AONCLK_AON_50),
+	STARFIVE_GATE(JH8100_AONCLK_DDR50_POSTOCC_ICG, "ddr50_postocc", CLK_IS_CRITICAL,
+		      JH8100_AONCLK_AON_50_POSTOSC),
+	STARFIVE_GATE(JH8100_AONCLK_DDR100_POSTOCC_ICG, "ddr100_postocc", CLK_IS_CRITICAL,
+		      JH8100_AONCLK_AON_100),
+	/* pufrt */
+	STARFIVE_GATE(JH8100_AONCLK_PUFRT_APB, "pufrt_apb", CLK_IS_CRITICAL,
+		      JH8100_AONCLK_OSC),
+	/* rtc hms */
+	STARFIVE_GATE(JH8100_AONCLK_RTC_HMS_APB, "rtc_hms_apb", 0, JH8100_AONCLK_OSC),
+	STARFIVE__DIV(JH8100_AONCLK_RTC_INTERNAL, "rtc_internal", 1020, JH8100_AONCLK_OSC),
+	STARFIVE__MUX(JH8100_AONCLK_RTC_HMS_OSC32K, "rtc_hms_osc32k", 2,
+		      JH8100_AONCLK_RTC, JH8100_AONCLK_RTC_INTERNAL),
+	STARFIVE_GATE(JH8100_AONCLK_RTC_HMS_CAL, "rtc_hms_cal", 0, JH8100_AONCLK_OSC),
+	/* gmac5_axi128 */
+	STARFIVE_GATE(JH8100_AONCLK_GMAC0_AXI128_AHB, "gmac0_axi128_ahb", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_GMAC0_AXI128_MSTRCLK, "gmac0_axi128_mstrclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_667),
+	STARFIVE_GATE(JH8100_AONCLK_GMAC0_AXI128_AXI, "gmac0_axi128_axi", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_400_POSTOSC),
+	STARFIVE__DIV(JH8100_AONCLK_GMAC0_RMII_RTX, "gmac0_rmii_rtx", 30,
+		      JH8100_AONCLK_GMAC0_RMII_REFIN),
+	STARFIVE_GMUX(JH8100_AONCLK_GMAC0_AXI128_TX, "gmac0_axi128_tx", CLK_IGNORE_UNUSED, 2,
+		      JH8100_AONCLK_GMAC0_GTXCLK,
+		      JH8100_AONCLK_GMAC0_RMII_RTX),
+	STARFIVE_GINV(JH8100_AONCLK_GMAC0_AXI128_TX_INV, "gmac0_axi128_tx_inv", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_GMAC0_AXI128_TX),
+	STARFIVE__MUX(JH8100_AONCLK_GMAC0_AXI128_RX, "gmac0_axi128_rx", 2,
+		      JH8100_AONCLK_GMAC0_RGMII_RXIN, JH8100_AONCLK_GMAC0_RMII_RTX),
+	STARFIVE__INV(JH8100_AONCLK_GMAC0_AXI128_RX_INV, "gmac0_axi128_rx_inv",
+		      JH8100_AONCLK_GMAC0_AXI128_RX),
+	STARFIVE_GATE(JH8100_AONCLK_GMAC0_GTXC, "gmac0_gtxc", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_GMAC0_GTXCLK),
+	/* xspi */
+	STARFIVE_GATE(JH8100_AONCLK_XSPI_AXI, "xspi_axi", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_XSPI_APB, "xspi_apb", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GMUX(JH8100_AONCLK_XSPI_XSPI_PHY, "xspi_xspi_phy", CLK_IGNORE_UNUSED, 2,
+		      JH8100_AONCLK_OSC, JH8100_AONCLK_XSPI_PHY),
+	/* tvsensor */
+	STARFIVE_GATE(JH8100_AONCLK_TVSENSOR_PCLK, "tvsensor_pclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_TVSENSOR_TSADC, "tvsensor_tsadc", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GDIV(JH8100_AONCLK_TVSENSOR_BG, "tvsensor_bg", CLK_IGNORE_UNUSED, 3,
+		      JH8100_AONCLK_OSC),
+	/* meu */
+	STARFIVE_GATE(JH8100_AONCLK_MEU_PCLK_AP, "meu_pclk_ap", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_MEU_PCLK_SCP, "meu_pclk_scp", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_MEU_MEM_AXI, "meu_mem_axi", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_200),
+	/* aximem_128b */
+	STARFIVE_GATE(JH8100_AONCLK_AXIMEM_128B_ACLK, "aximem_128b_aclk", CLK_IS_CRITICAL,
+		      JH8100_AONCLK_AON_200),
+	/* apb2bisr */
+	STARFIVE_GATE(JH8100_AONCLK_APB2BISR_APB, "apb2bisr_apb", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_APB2BISR_BISR, "apb2bisr_bisr", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	/* emmc */
+	STARFIVE_GATE(JH8100_AONCLK_EMMC_S_PCLK, "emmc_s_pclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_50_POSTOSC),
+	STARFIVE_GATE(JH8100_AONCLK_EMMC_MSTRCLK, "emmc_mstrclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_667),
+	STARFIVE_GATE(JH8100_AONCLK_EMMC, "emmc", CLK_IGNORE_UNUSED, JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_EMMC_SDMCLK, "emmc_sdmclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_EMMC_SDPHY_PCLK, "emmc_sdphy_pclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_50_POSTOSC),
+	/* sdio */
+	STARFIVE_GATE(JH8100_AONCLK_SDIO0_PCLK, "sdio0_pclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_50_POSTOSC),
+	STARFIVE_GATE(JH8100_AONCLK_SDIO0_MSTRCLK, "sdio0_mstrclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_667),
+	STARFIVE_GATE(JH8100_AONCLK_SDIO0, "sdio0", CLK_IGNORE_UNUSED, JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_SDIO0_SDMCLK, "sdio0_sdmclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_SDIO0_SDPHY_PCLK, "sdio0_sdphy_pclk", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_50_POSTOSC),
+	/* top */
+	STARFIVE_GATE(JH8100_AONCLK_HCLK, "hclk", CLK_IS_CRITICAL, JH8100_AONCLK_AON_200),
+	STARFIVE_GATE(JH8100_AONCLK_ACLK, "aclk", CLK_IS_CRITICAL, JH8100_AONCLK_AON_500_POSTOSC),
+	STARFIVE_GATE(JH8100_AONCLK_PERF_MSTRCLK, "perf_mstrclk", CLK_IS_CRITICAL,
+		      JH8100_AONCLK_AON_667),
+	STARFIVE_GATE(JH8100_AONCLK_PERF_SLVCLK, "perf_slvclk", CLK_IS_CRITICAL,
+		      JH8100_AONCLK_AON_500_POSTOSC),
+	STARFIVE_GDIV(JH8100_AONCLK_GCLK0, "gclk0", CLK_IS_CRITICAL, 100, JH8100_AONCLK_AON_1000),
+	STARFIVE_GATE(JH8100_AONCLK_GCLK_OSC, "gclk_osc", CLK_IS_CRITICAL, JH8100_AONCLK_OSC),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_AONCLK_RTC_ICG_EN, "rtc_en", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_GMAC0_ICG_EN, "gmac0_en", 0, JH8100_AONCLK_GMAC0_GTXCLK),
+	STARFIVE_GATE(JH8100_AONCLK_XSPI_ICG_EN, "xspi_en", 0, JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_TVSENSOR0_ICG_EN, "tvsensor0_en", 0, JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_MEU_ICG_EN, "meu_en", CLK_IGNORE_UNUSED, JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_APB2BISR_ICG_EN, "apb2bisr_en", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_OSC),
+	STARFIVE_GATE(JH8100_AONCLK_EMMC_ICG_EN, "emmc_en", 0, JH8100_AONCLK_AON_50_POSTOSC),
+	STARFIVE_GATE(JH8100_AONCLK_SDIO0_ICG_EN, "sdio0_en", 0, JH8100_AONCLK_AON_50_POSTOSC),
+	STARFIVE_GATE(JH8100_AONCLK_TOP_ICG_EN, "top_en", CLK_IGNORE_UNUSED,
+		      JH8100_AONCLK_AON_500_POSTOSC),
+};
+
+static struct clk_hw *jh8100_aoncrg_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH8100_AONCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int __init jh8100_aoncrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_AONCLK_NUM_CLKS),
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
+	for (idx = 0; idx < JH8100_AONCLK_NUM_CLKS; idx++) {
+		u32 max = jh8100_aoncrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_aoncrg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_aoncrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_aoncrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_AONCLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH8100_AONCLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JH8100_AONCLK_GMAC0_RMII_FUNC)
+				parents[i].fw_name = "gmac0-rmii-func";
+			else if (pidx == JH8100_AONCLK_AON_50)
+				parents[i].fw_name = "aon50";
+			else if (pidx == JH8100_AONCLK_GMAC0_RGMII_FUNC)
+				parents[i].fw_name = "gmac0-rgmii-func";
+			else if (pidx == JH8100_AONCLK_AON_125)
+				parents[i].fw_name = "aon125";
+			else if (pidx == JH8100_AONCLK_AON_2000)
+				parents[i].fw_name = "aon2000";
+			else if (pidx == JH8100_AONCLK_AON_200)
+				parents[i].fw_name = "aon200";
+			else if (pidx == JH8100_AONCLK_AON_667)
+				parents[i].fw_name = "aon667";
+			else if (pidx == JH8100_AONCLK_RTC)
+				parents[i].fw_name = "rtc";
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_aoncrg_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-aon", 4);
+}
+
+static const struct of_device_id jh8100_aoncrg_match[] = {
+	{ .compatible = "starfive,jh8100-aoncrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_aoncrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-aon",
+		.of_match_table = jh8100_aoncrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_aoncrg_driver, jh8100_aoncrg_probe);
-- 
2.34.1


