Return-Path: <linux-kernel+bounces-22240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED20829B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EFD2899D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524E4A9B7;
	Wed, 10 Jan 2024 13:32:34 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A748CD2;
	Wed, 10 Jan 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMq5FN8ebFbr/dqY9vwLDrxD9bchv2P7Yfkj27VHbvNl58hgwNeIwCh9xhwoFPtqvbbONEku+6zumI+YQE7Dcb51c+bdlvJAU261uqcwTU0ZiCWHIocgwfv1nW7v8j7DeBRAeRYIH5M1ab7rvuNvj7Vfms3tJ1uPSB1GWx7t52TfslQwTpIC4Jqn2AJ3Ls8dYLdI0HoGGW/6oe65uJQylRB/iJQaV0klgwByUL8VulCTCA+7TdNiV2h5GG1C85jl4gbyIRPPVokKp20FoYXg1zsogIHwzaV0Pl/Tkyt9V2wBAV1aKxbY2j5ltFwovNy/ywTM/7DwQ57xGG18Xs4wGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSRkXU9BfabriSMC3ca8IBms3ZqZ3OTXIxVD5Z5+odk=;
 b=WWxUlZOvsS/jAObbtrVUNZ+XuL2xrNwCGdveheOWoMAIQOse7cDfMHQiPyIdj2e3zqKnYIrGJIDGK8zwcInCJCzYZp1yyCEXWz8BPuty0r5uggmX377m/WdHip/UTRa1ow9mLl0DKrhLv7moDfcfg2pf9gU3v9kfpE5HZ6n3RDX/FwXIChFx0LW1KWrENwqZeHW9NJv7fUdr9duRPPaf/wbnzcMMxCLsWeMrM6vJ/OBJNSqcx0W6iMEmDsFcGuAe9IxVIr1QL9WXp1jc7E6ftAssMjdHeU4dh3J7MbrFkrpgRjvTf86r4xVZq3wYX3xIRamP7/bvpZ/j+8zfSmh5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:27 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:27 +0000
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
Subject: [RFC v3 12/16] clk: starfive: Add JH8100 South-West clock generator driver
Date: Wed, 10 Jan 2024 21:31:24 +0800
Message-Id: <20240110133128.286657-13-jeeheng.sia@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8433f7ae-58e4-472d-a711-08dc11e0961c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lm3cc2vKNR88UHi5pXXaXMagNMOczNEu8MIP7DefQIAuxRSHj6g5UBxqbwHY2KsihnojoeA15f1tqO4uY9biY2yApX10qH5y+TnJwzgdetrFm8j72HriOJ1E0BTkPZ2fmqPkFD4ZEDGRh6StYDMnmWtTodcU6H/tHX97kEiotwt/N0pm9fr0vDum2HS1y4o5lR9rMwH2w7CNyRnIOe+3oBK+rQrnRKPQRinMhfSf1uvLxaoJ5ngmmSoNtwWAm0uhhT4tczgG3ZifHU9vXNmmJr0wF67oxS3jZk8xR22ECQVckcnYSVZH3a40lncISD8gv5TKgxhHS28Xc+JirjdfKsCT3WyldXvkCeEy4tueT3rByLdrIpEsUhZuw5HsImatdg/co+ERQ5Ea62GB6Z63C16lmGsykbzInezRlwRAy3GmefDtHbgrNeD8LYbqbp6/6oAHfHejY941+mRAauiRFfiuRPJwqp2LuXI3DJ1mY4J01s2Dc1uGr5KfVQn20c18llG0t7uO6Ode0w/QKQ5wc1X6iaEYAxr0EWW8EhHgLhzRpMzxRk7q0VlfG0XkQzzQX0xagSIDSTNPmibpB7T60kk370rZPTnKbHfH3ROpIGqcb3F/ABY6QeqDQ9e8h3mb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(107886003)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wOBBZYHV4rkJ6+aPZQWAfKDPMPz/zirmEJqdNwzuSNzAMSRWmvMmQ3pao0Dx?=
 =?us-ascii?Q?338pZYQy8wMaTZaiRMbDRrAen4mrjvruaIbC4OaUDQdrMVK8yIM57NhzPXe1?=
 =?us-ascii?Q?hxzvVbTqtDA54fBRsKNeVFgKhzIJ/g7zZ1cnhrWzPbo2g1xHFH/pFsqqeuav?=
 =?us-ascii?Q?VPK+tREWs3loiOsUWafPbRgEoJtAKnY2BdgDzNpoZDIXkbbN3ytdxd2Lb5xz?=
 =?us-ascii?Q?kKxkxMspUJM0QHKhgmIFu4judne+ojbWrz1xrHApT/9+6CboJnaMD5Loqwz6?=
 =?us-ascii?Q?jC/zqz7Hi6lVQPbP9GRnB4tz4KQoNiXZqvnLu0sNEWdorFE7XUZTBShquCE+?=
 =?us-ascii?Q?KzV9FqRgWk7+85zXu3okoHehvvQGNnSFhfTS35qNEHkjxfEG1JiKQ71D4S2k?=
 =?us-ascii?Q?Qo8Bzrk2UMCLXff9Mw/Fc6Z+SXuRcYeWTvTePQG+HbJcqiB1xodHj6BvHYwu?=
 =?us-ascii?Q?CE+QKEjiwmQ+MIeQAywfrM2q1XwLarg2cR4l3Oj8AW3fQqaGAodTakm/Ei7o?=
 =?us-ascii?Q?lvaRFn3+7Yn0YXw982isbbFJqk80pYgE2KJD4APEOZFQDuI++ViLjVRS/fsS?=
 =?us-ascii?Q?oyYvzf/0nef7GdMmUa1GzBeyMgidvtIBtg6wYwH15F4+7rYqCuE4e7DRn7j4?=
 =?us-ascii?Q?RSDuwA/xyy88Q5VTDk0Pp5cIL7hcCRhmiMaZfbij+EiU60BoiouL1Z1om3w+?=
 =?us-ascii?Q?M9pqCxOfSyxqSDZm/YwZIKCItkOtu0JzCYmanIXY4TzZ7ErYZo+oTUbz9eFJ?=
 =?us-ascii?Q?U8JRPy8vZO8c99EUYuwu7FXMu3JBCqDY90WxGwHRoMp23thbsxguhsGuVTfi?=
 =?us-ascii?Q?HB2AKMtT0WLA2In2W0+za+XHeIEgfkIA18OnRQ6N80q1Ovx0PwUtViqMtTwS?=
 =?us-ascii?Q?3l6QqR2/O6pZhhEFs2OoSV+PrUCMv7VGDMYmxiqf/pZfXtXQeGXQQLNKnRL9?=
 =?us-ascii?Q?nYcIQwCJf/PsVMhBDnQ2aLf5UWpJv6MKyyI8/ZG6gx6zaKHCXnWNLAmYYP81?=
 =?us-ascii?Q?cUgnpF45u1wecEnLeZWCrz2KYulEyG8bm0nPIRgC4o9nOwy7YSmQJ81r/s1w?=
 =?us-ascii?Q?vLtovTYQRAEK8HIWA9b3Lv3t+evv1gZwL1eEdWwIIn5bVj6WrIdWNrIvC9nw?=
 =?us-ascii?Q?lH0Ee02PRBCEjYbrQs1Gn75n030W5HMz/hs4raSiliD55V0w6NzA03oQj/sj?=
 =?us-ascii?Q?RCi2AgcqHdd1VmkvYn4xOrAEYd635xGYmLBuaxbzSdymGKNg0UASn+WlcdWC?=
 =?us-ascii?Q?7omucilfcD6F3Mb6ZUXog0FfM0KQphDC54HV4UeFwYAlLfSnPdJggEOz/XV+?=
 =?us-ascii?Q?oza5sZV4FhqOKmfWCwDq9o6TKLqgq/1ivvOymLaZmX58ZDe8HOjLo/e1q+CS?=
 =?us-ascii?Q?D6nbtQeXVlBtXNtDE5MxxiJ1wEZe4cTfMkl4f3GUMjmVYE5Q50yTG45LQgha?=
 =?us-ascii?Q?6iEppTmXq+6mNJjIKoLUKv387glhgDwp8hruJ+6p1J2Fed6AYHPKe9IrFs1t?=
 =?us-ascii?Q?F8JgsAqbjoq0s3tjv/o7e4RWcHU7SXLw6fLS+up584FdmfKUCZzmGONl7O14?=
 =?us-ascii?Q?xYZZzNBFhJFsDBxy8QulHvi3Xym2IhgjHMGjJISewoVnwKM6Hocu3/nGodeD?=
 =?us-ascii?Q?toD/np2078bQq3DbPMinK/w=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8433f7ae-58e4-472d-a711-08dc11e0961c
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:27.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYRQ3ZIN5CHunGCZPXlJo1fdilGAXkkym3BunxwJoJaS/6CHmUlzhbadJT+OjSr/6C0xm/zqA8vEYnuGnd9+jlljxCtfBQ0VJKFCigJwPmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add support for JH8100 South-West (SWCRG) clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   7 +
 drivers/clk/starfive/Makefile                 |   1 +
 drivers/clk/starfive/clk-starfive-jh8100-sw.c | 134 ++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sw.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 23968e97969b..23ae894fedb9 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -95,3 +95,10 @@ config CLK_STARFIVE_JH8100_NE
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the North-East clock controller on the StarFive JH8100 SoC.
+
+config CLK_STARFIVE_JH8100_SW
+	bool "StarFive JH8100 South-West clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the South-West clock controller on the StarFive JH8100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index cecce3655600..242e2e75dadb 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= clk-starfive-jh8100-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NW)	+= clk-starfive-jh8100-nw.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NE)	+= clk-starfive-jh8100-ne.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SW)	+= clk-starfive-jh8100-sw.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-sw.c b/drivers/clk/starfive/clk-starfive-jh8100-sw.c
new file mode 100644
index 000000000000..f583f7d984ed
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-sw.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 South-West Clock Driver
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
+#define JH8100_SWCLK_NUM_CLKS		(JH8100_SWCLK_VDEC_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_SWCLK_APB_BUS		(JH8100_SWCLK_NUM_CLKS + 0)
+#define JH8100_SWCLK_VDEC_ROOT		(JH8100_SWCLK_NUM_CLKS + 1)
+#define JH8100_SWCLK_FLEXNOC1		(JH8100_SWCLK_NUM_CLKS + 2)
+
+static const struct starfive_clk_data jh8100_swcrg_clk_data[] = {
+	/* jpeg */
+	STARFIVE__DIV(JH8100_SWCLK_JPEG_AXI, "jpeg_axi", 20, JH8100_SWCLK_VDEC_ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000DJ_AXI, "vc9000dj_axi", CLK_IGNORE_UNUSED,
+		      JH8100_SWCLK_JPEG_AXI),
+	STARFIVE_GDIV(JH8100_SWCLK_VC9000DJ_VDEC, "vc9000dj_vdec", CLK_IGNORE_UNUSED, 40,
+		      JH8100_SWCLK_VDEC_ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000DJ_APB, "vc9000dj_apb", CLK_IGNORE_UNUSED,
+		      JH8100_SWCLK_APB_BUS),
+	/* video dec */
+	STARFIVE__DIV(JH8100_SWCLK_VDEC_AXI, "vdec_axi", 20, JH8100_SWCLK_VDEC_ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000D_AXI, "vc9000d_axi", CLK_IGNORE_UNUSED,
+		      JH8100_SWCLK_VDEC_AXI),
+	STARFIVE_GDIV(JH8100_SWCLK_VC9000D_VDEC, "vc9000d_vdec", CLK_IGNORE_UNUSED, 40,
+		      JH8100_SWCLK_FLEXNOC1),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000D_APB, "vc9000d_apb", CLK_IGNORE_UNUSED,
+		      JH8100_SWCLK_APB_BUS),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_SWCLK_JPEG_ICG_EN, "jpeg_en", 0, JH8100_SWCLK_VDEC_ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VDEC_ICG_EN, "vdec_en", 0, JH8100_SWCLK_VDEC_AXI),
+};
+
+static struct clk_hw *jh8100_swcrg_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH8100_SWCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_swcrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_SWCLK_NUM_CLKS),
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
+	for (idx = 0; idx < JH8100_SWCLK_NUM_CLKS; idx++) {
+		u32 max = jh8100_swcrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_swcrg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_swcrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_swcrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_SWCLK_NUM_CLKS)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH8100_SWCLK_APB_BUS)
+				parents[i].fw_name = "apb_bus";
+			else if (pidx == JH8100_SWCLK_VDEC_ROOT)
+				parents[i].fw_name = "vdec_root";
+			else if (pidx == JH8100_SWCLK_FLEXNOC1)
+				parents[i].fw_name = "flexnoc1";
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_swcrg_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sw", 3);
+}
+
+static const struct of_device_id jh8100_swcrg_match[] = {
+	{ .compatible = "starfive,jh8100-swcrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_swcrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-sw",
+		.of_match_table = jh8100_swcrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_swcrg_driver, jh8100_swcrg_probe);
-- 
2.34.1


