Return-Path: <linux-kernel+bounces-20475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF523827F79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135FD1C256A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4838C129;
	Tue,  9 Jan 2024 07:27:50 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2081.outbound.protection.partner.outlook.cn [139.219.146.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91669471;
	Tue,  9 Jan 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9MO5bq0SEMriSrgRKzSOKQ3yoGg+rBsEn9Vx3obxOyO50DX7Uj9OQulAE/mG2Ld3bSIWreZsxW1NTtwgdEqgZp8AAzhy5yz1o4z2K93fFOwT8O2vyuOMpqEUkD+eoyHatkQmP3aR6aV92uD6LuvYfjHWntNiWrZM4Nq9D7g2Yi0uKS3P2kAp3t1z9G5K5hnlETCT2CN9n0441OvXyRabl8Chua7yTrnpy+1wAgf2rh0qkW9ZHOSJWjQbUSWO7fy4xMUN3zKsLPANuempkfxSHMM3TVqD7ZiFxSxWDmg/Z7JWE6SbMfEnIUQQwxxIBISjyj2/jQ20cAtmWBUUvwdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ygp27E91Nf7RrlX2k2QXyENq6X2nzc4BCrAjkEmPqA=;
 b=fTjYVsQo1zt/iZOb5BvbUyePVbU2pei/hv4t3KWP/w8EdsXzqrOT944RegrEyQqhFVByTKPkoumDVBDme0nxSypS2sfNVoaKKTFGPre5eoSqvDM8e5gtJOXAt1E2Cz2BZu3PSTJbAdncomA2GjMgsVLtaqtJ/tG/paxpJIeT0kRJ4SsmLxlnx8mU51BdVVuQ1+hQ7cUk7saDDjad/pvMy36GeCkGxnDICCDOVg35Zjv+4HwXA2qCkyU6jYlxXX0eq/5vDlz5x6/pktSnJwuIHPAfjUKK8p0vODO0ZaPfWlwxr2pyaYg37akUot0mvjwPrO9dI8BHt7AwfD0bbvFWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0957.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Tue, 9 Jan
 2024 07:12:58 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::85fc:7fb9:8b00:dd88]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::85fc:7fb9:8b00:dd88%3])
 with mapi id 15.20.7135.019; Tue, 9 Jan 2024 07:12:58 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	minda.chen@starfivetech.com,
	changhuang.liang@starfivetech.com,
	rogerq@kernel.org,
	geert+renesas@glider.be,
	keith.zhao@starfivetech.com,
	shengyang.chen@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] phy: starfive: Add mipi dphy tx support
Date: Tue,  9 Jan 2024 15:12:46 +0800
Message-Id: <20240109071246.24065-3-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109071246.24065-1-shengyang.chen@starfivetech.com>
References: <20240109071246.24065-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB0957:EE_
X-MS-Office365-Filtering-Correlation-Id: d37203b8-795f-45da-37a5-08dc10e268d0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MYBJOz+EK9Psc5msfxMH4u2UUiVz2l91diu6uDR2hdfalvx/PN76ZOk4F1QJApeWm7cIrflP1o62GlaosaihNz4eJlRqrvAh0awAFvqKFkDGFZj78jqf7j6rYX5+dvxgJa606gupGRB/fCd9z/eayaJ1zaozGkTKfhyAE+jumJ8paRpsDZyQ/n2vgU9JmkDNrfJeF3MjzVKk9KGBQH4u9FOuL7zbxYvhH0g9nu8nnVBWkR1d+obleDDp6JJjkBOVa7fD0X0cfvYfZZwHpZ7on4joSmRWjZojZaqr2ssi3IMJ9NFPUD3blBY7TaCTMp5V8HpFAmWNShOp2TbzOgRSW41PTMbazDRThqAt90/xtFnVj99wBRC5oqtMZwkABS+tSee53nLRreEDImvbA6zEA+QG8ZHMdWJVcNWA3oWbanQewjp8fNs9JuHsoPcDQzZPjkQva+/j23QBd7B0qS8Wdzlc92yEVRHxildBpiAJGBU52MDXLQVqWoTGLyMCYD6KnMJoVEI1SWYIbtcmvHEZ0wKiYP1ehr7DET3UV5HIagt9gaXjeASyeNfzfnYGe6HX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(66946007)(4326008)(66556008)(8936002)(44832011)(36756003)(26005)(2616005)(6666004)(1076003)(508600001)(8676002)(41320700001)(41300700001)(5660300002)(2906002)(30864003)(7416002)(52116002)(83380400001)(40180700001)(38350700005)(40160700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfrixfM3s5a7Lpdt8ueUXBWuv6S7tvvlM3h7ArSeH0vv3ihRzdEPcwXLItli?=
 =?us-ascii?Q?O3OxtyP9FrKwCKsiiIW2KiqoNXDZbO2kSbCQmP6HBVpeanCJx2tahA/iDgzY?=
 =?us-ascii?Q?7Q4hsVkD1QSKOnU36nym/GXn7+y+ALhdJ516nGyv6gn5lu0Tvm26s1RtthaX?=
 =?us-ascii?Q?+7rX6JoJtCOEliOQonu6Tyr/mruFTkNeiksCvRo7Ag4J5mABS50R4blbsXTV?=
 =?us-ascii?Q?RtAthB7LTIlIbT7ehKsUSd6CbavYurIjAq9wEhaBwARqTkX5Z5eXJFmmuNHP?=
 =?us-ascii?Q?Q6u0KGQh6mC6b87/SZ7NuryQsrxtd9WTVm29Ru8P/9VYfdxTSeJGJ8SWiuqa?=
 =?us-ascii?Q?Z8fWlFjqZaTN+omuXVZrfo5EFxfWT8Vp8b9fau9n+K1UjO3HvMT0CGMsvRaQ?=
 =?us-ascii?Q?lcSKBKm1yg2olkoC1PdKfeguxAPWIWwnoGVJaYG7FQ5k1KOnKDYznvFGv8C1?=
 =?us-ascii?Q?7bgzwgVB76rlJig4DqSv0myS5xqeOMoDtrmfaCXuB5osxeizNf7qA1HjSQSO?=
 =?us-ascii?Q?0eFH+Z3Q94e+yDSwnWm5hc7QGJ7YV/CTEcrmmQePGPGumEA9wHcVi5jMyJaT?=
 =?us-ascii?Q?JqQlBA7jPBW5JlonxZsjG86C17gIgpTvsH8MZujEPnfuRb14P6yRqly7mLjC?=
 =?us-ascii?Q?V6jmjm6e7l094aZueXyFKgW3PZIHMqZCogwbZXC9ZZAHHhVz/mWgcu97Sfsr?=
 =?us-ascii?Q?oe7EHf3V07p5KNBJbXCRF2QtBJs7Z5cK4NUIKLCFblpJer4BxuIRtjzpGvNb?=
 =?us-ascii?Q?YdacfdObO3cXWf6o2Xx979oa2BU+XpbP9HUvsVgTkK1cNURtm6j/IxBtmFR5?=
 =?us-ascii?Q?QBKvQ+A3NChulDVYMUw3m2nKpJCENX7bVB8rSVN8gO8Ky9EkqW68eWCfMzJK?=
 =?us-ascii?Q?QPStowmSak/ZonOJjN/InS2+cYH7GGPiODc5BIRYiDh6ihh6gKQ8kon0VA6t?=
 =?us-ascii?Q?GYdybYyjZUUfJumSilCaxrkF0MaC9sgLOMVA0Q140yGfAglPw2bwstX7MaY8?=
 =?us-ascii?Q?l9iF7HoG//8z8PvDsuGksgNkDCloXxw1VzLZ+bhMoKlFu605f3WR/k14BaqI?=
 =?us-ascii?Q?4UrnzsxDx/bgS0CI2J8Q1vq9k4tcufePpap+XjvZc11u/sFAdewExaS8MOem?=
 =?us-ascii?Q?u9XLjm2nFt4DjcLrCSilftLDMYRh9WScJ1Ss/woYMJr4BcjTnHXfxRg8RMBw?=
 =?us-ascii?Q?iwdMr6xj4SCK2TXdAz+19N8A5TDj94hq9I7mHG+TgNmJFPDi1FXGbRCerrdo?=
 =?us-ascii?Q?2wncpuBtYoh/MFPkMjWN6y1jf0XfIRrXpC/7wEwt/RzJQhL+6LeMVB7fxyOI?=
 =?us-ascii?Q?IjYt0RXNUHlb+p8+m48v4QtEYxxZrtJlvTsj3GrZzCtjy7KCCmdex9gWXF4j?=
 =?us-ascii?Q?kVbQl0b8c3dvjCLHOpnIkb68r1B4UhJEoAr6IgX3rbLTSeEJ+Qh+SCDrlp/R?=
 =?us-ascii?Q?eKnf1yC1Ausk8f824jIFN5lkf/lpOfCgahC6o/hGGzhzqYM8vwy5JLlqkttH?=
 =?us-ascii?Q?F3/NOJUs84SVuiJ2dUYWQFbx5EYJxjmhIGhoR3rHSO8cUbJfER5ZPmfRMvXb?=
 =?us-ascii?Q?XTa6SyM6cb61Qq/qD2mbUWt3J3HOc9xros5hfPehBwawJ7Bcpvt9qHdPJzMG?=
 =?us-ascii?Q?w9m3P+oTyM9k/1JPGgysxxU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37203b8-795f-45da-37a5-08dc10e268d0
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:12:58.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aClWs9Fths92S9ZFvN3Xn0pMTiaO5PPSF6B8LqOp8fRbrbVx/thMJseWyoSu+0v9ed0z+vD1NocKWi4JwXbMYggSvR8mmYqDFL7NAl3/Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0957

Add mipi dphy tx support for the StarFive JH7110 SoC.
It is a module which is used to receive data from DSI
driver and transfer data to DSI interface like mipi screen.

Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
---
 MAINTAINERS                               |   7 +
 drivers/phy/starfive/Kconfig              |  10 +
 drivers/phy/starfive/Makefile             |   1 +
 drivers/phy/starfive/phy-jh7110-dphy-tx.c | 651 ++++++++++++++++++++++
 4 files changed, 669 insertions(+)
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a220ea04f5c4..d8244fa6bdae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20607,6 +20607,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
 F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
 
+STARFIVE JH7110 DPHY TX DRIVER
+M:	Keith Zhao <keith.zhao@starfivetech.com>
+M:	Shengyang Chen <shengyang.chen@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
+F:	drivers/phy/starfive/phy-jh7110-dphy-tx.c
+
 STARFIVE JH7110 MMC/SD/SDIO DRIVER
 M:	William Qiu <william.qiu@starfivetech.com>
 S:	Supported
diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index 9508e2143011..d0cdd7cb4a13 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -15,6 +15,16 @@ config PHY_STARFIVE_JH7110_DPHY_RX
 	  system. If M is selected, the module will be called
 	  phy-jh7110-dphy-rx.ko.
 
+config PHY_STARFIVE_JH7110_DPHY_TX
+	tristate "StarFive JH7110 D-PHY TX Support"
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	select GENERIC_PHY_MIPI_DPHY
+	help
+	  Choose this option if you have a StarFive D-PHY TX in your
+	  system. If M is selected, the module will be called
+	  phy-jh7110-dphy-tx.ko.
+
 config PHY_STARFIVE_JH7110_PCIE
 	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
index b391018b7c47..eedc4a6fec15 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_RX)	+= phy-jh7110-dphy-rx.o
+obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_TX)	+= phy-jh7110-dphy-tx.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)		+= phy-jh7110-pcie.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)		+= phy-jh7110-usb.o
diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
new file mode 100644
index 000000000000..14a1774cdd32
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DPHY TX driver for the StarFive JH7110 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Keith Zhao <keith.zhao@starfivetech.com>
+ * Author: Shengyang Chen <shengyang.chen@starfivetech.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-mipi-dphy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+
+#define STF_DPHY_APBIFSAIF_SYSCFG(x)			(x)
+
+#define  STF_DPHY_AON_POWER_READY_N_SHIFT		0x0U
+#define  STF_DPHY_AON_POWER_READY_N_MASK		BIT(0)
+#define  STF_DPHY_CFG_L0_SWAP_SEL_SHIFT			0xCU
+#define  STF_DPHY_CFG_L0_SWAP_SEL_MASK			GENMASK(14, 12)
+#define  STF_DPHY_CFG_L1_SWAP_SEL_SHIFT			0xFU
+#define  STF_DPHY_CFG_L1_SWAP_SEL_MASK			GENMASK(17, 15)
+#define  STF_DPHY_CFG_L2_SWAP_SEL_SHIFT			0x12U
+#define  STF_DPHY_CFG_L2_SWAP_SEL_MASK			GENMASK(20, 18)
+#define  STF_DPHY_CFG_L3_SWAP_SEL_SHIFT			0x15U
+#define  STF_DPHY_CFG_L3_SWAP_SEL_MASK			GENMASK(23, 21)
+#define  STF_DPHY_CFG_L4_SWAP_SEL_SHIFT			0x18U
+#define  STF_DPHY_CFG_L4_SWAP_SEL_MASK			GENMASK(26, 24)
+#define  STF_DPHY_RGS_CDTX_PLL_UNLOCK_SHIFT		0x12U
+#define  STF_DPHY_RGS_CDTX_PLL_UNLOCK_MASK		BIT(18)
+#define  STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT		0x13U
+#define  STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK		GENMASK(23, 19)
+#define  STF_DPHY_RG_CDTX_L0P_HSTX_RES_SHIFT		0x18U
+#define  STF_DPHY_RG_CDTX_L0P_HSTX_RES_MASK		GENMASK(28, 24)
+
+#define  STF_DPHY_RG_CDTX_L1P_HSTX_RES_SHIFT		0x5U
+#define  STF_DPHY_RG_CDTX_L1P_HSTX_RES_MASK		GENMASK(9, 5)
+#define  STF_DPHY_RG_CDTX_L2N_HSTX_RES_SHIFT		0xAU
+#define  STF_DPHY_RG_CDTX_L2N_HSTX_RES_MASK		GENMASK(14, 10)
+#define  STF_DPHY_RG_CDTX_L2P_HSTX_RES_SHIFT		0xFU
+#define  STF_DPHY_RG_CDTX_L2P_HSTX_RES_MASK		GENMASK(19, 15)
+#define  STF_DPHY_RG_CDTX_L3N_HSTX_RES_SHIFT		0x14U
+#define  STF_DPHY_RG_CDTX_L3N_HSTX_RES_MASK		GENMASK(24, 20)
+#define  STF_DPHY_RG_CDTX_L3P_HSTX_RES_SHIFT		0x19U
+#define  STF_DPHY_RG_CDTX_L3P_HSTX_RES_MASK		GENMASK(29, 25)
+
+#define  STF_DPHY_RG_CDTX_L4N_HSTX_RES_SHIFT		0x0U
+#define  STF_DPHY_RG_CDTX_L4N_HSTX_RES_MASK		GENMASK(4, 0)
+#define  STF_DPHY_RG_CDTX_L4P_HSTX_RES_SHIFT		0x5U
+#define  STF_DPHY_RG_CDTX_L4P_HSTX_RES_MASK		GENMASK(9, 5)
+#define  STF_DPHY_RG_CDTX_PLL_FBK_FRA_SHIFT		0x0U
+#define  STF_DPHY_RG_CDTX_PLL_FBK_FRA_MASK		GENMASK(23, 0)
+
+#define  STF_DPHY_RG_CDTX_PLL_FBK_INT_SHIFT		0x0U
+#define  STF_DPHY_RG_CDTX_PLL_FBK_INT_MASK		GENMASK(8, 0)
+#define  STF_DPHY_RG_CDTX_PLL_FM_EN_SHIFT		0x9U
+#define  STF_DPHY_RG_CDTX_PLL_FM_EN_MASK		BIT(9)
+#define  STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_SHIFT	0xAU
+#define  STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_MASK	BIT(10)
+#define  STF_DPHY_RG_CDTX_PLL_PRE_DIV_SHIFT		0xBU
+#define  STF_DPHY_RG_CDTX_PLL_PRE_DIV_MASK		GENMASK(12, 11)
+
+#define  STF_DPHY_RG_CDTX_PLL_SSC_EN_SHIFT		0x12U
+#define  STF_DPHY_RG_CDTX_PLL_SSC_EN_MASK		0x40000U
+
+#define  STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_SHIFT	0x0U
+#define  STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_MASK	GENMASK(7, 0)
+#define  STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_SHIFT	0x8U
+#define  STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_MASK		GENMASK(15, 8)
+#define  STF_DPHY_RG_CLANE_HS_PRE_TIME_SHIFT		0x10U
+#define  STF_DPHY_RG_CLANE_HS_PRE_TIME_MASK		GENMASK(23, 16)
+#define  STF_DPHY_RG_CLANE_HS_TRAIL_TIME_SHIFT		0x18U
+#define  STF_DPHY_RG_CLANE_HS_TRAIL_TIME_MASK		GENMASK(31, 24)
+
+#define  STF_DPHY_RG_CLANE_HS_ZERO_TIME_SHIFT		0x0U
+#define  STF_DPHY_RG_CLANE_HS_ZERO_TIME_MASK		GENMASK(7, 0)
+#define  STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT		0x8U
+#define  STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK		GENMASK(15, 8)
+#define  STF_DPHY_RG_DLANE_HS_TRAIL_TIME_SHIFT		0x10U
+#define  STF_DPHY_RG_DLANE_HS_TRAIL_TIME_MASK		GENMASK(23, 16)
+#define  STF_DPHY_RG_DLANE_HS_ZERO_TIME_SHIFT		0x18U
+#define  STF_DPHY_RG_DLANE_HS_ZERO_TIME_MASK		GENMASK(31, 24)
+
+#define  STF_DPHY_RG_EXTD_CYCLE_SEL_SHIFT		0x0U
+#define  STF_DPHY_RG_EXTD_CYCLE_SEL_MASK		GENMASK(2, 0)
+#define  STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_SHIFT		0x0U
+#define  STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_MASK		GENMASK(31, 0)
+
+#define  STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_SHIFT	0x1U
+#define  STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_MASK		GENMASK(2, 1)
+#define  STF_DPHY_SCFG_PPI_C_READY_SEL_SHIFT		0x3U
+#define  STF_DPHY_SCFG_PPI_C_READY_SEL_MASK		GENMASK(4, 3)
+
+#define  STF_DPHY_REFCLK_IN_SEL_SHIFT			0x1AU
+#define  STF_DPHY_REFCLK_IN_SEL_MASK			GENMASK(28, 26)
+#define  STF_DPHY_RESETB_SHIFT				0x1DU
+#define  STF_DPHY_RESETB_MASK				BIT(29)
+
+#define STF_DPHY_REFCLK_12M				1
+#define STF_DPHY_BITRATE_ALIGN				10000000
+
+#define STF_MAP_LANES_NUM				5
+
+struct m31_dphy_config {
+	int ref_clk;
+	unsigned long bitrate;
+	u32 pll_prev_div;
+	u32 pll_fbk_int;
+	u32 pll_fbk_fra;
+	u32 extd_cycle_sel;
+	u32 dlane_hs_pre_time;
+	u32 dlane_hs_zero_time;
+	u32 dlane_hs_trail_time;
+	u32 clane_hs_pre_time;
+	u32 clane_hs_zero_time;
+	u32 clane_hs_trail_time;
+	u32 clane_hs_clk_pre_time;
+	u32 clane_hs_clk_post_time;
+};
+
+static const struct m31_dphy_config m31_dphy_configs[] = {
+	{12000000, 160000000, 0x0, 0x6a, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x3, 0xa, 0x17, 0x11, 0x5, 0x2b, 0xd, 0x7, 0x3d},
+	{12000000, 170000000, 0x0, 0x71, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x3, 0xb, 0x18, 0x11, 0x5, 0x2e, 0xd, 0x7, 0x3d},
+	{12000000, 180000000, 0x0, 0x78, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x3, 0xb, 0x19, 0x12, 0x6, 0x30, 0xe, 0x7, 0x3e},
+	{12000000, 190000000, 0x0, 0x7e, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x3, 0xc, 0x1a, 0x12, 0x6, 0x33, 0xe, 0x7, 0x3e},
+	{12000000, 200000000, 0x0, 0x85, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x3, 0xc, 0x1b, 0x13, 0x7, 0x35, 0xf, 0x7, 0x3f},
+	{12000000, 320000000, 0x0, 0x6a, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0x8, 0x14, 0xf, 0x5, 0x2b, 0xd, 0x3, 0x23},
+	{12000000, 330000000, 0x0, 0x6e, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0x8, 0x15, 0xf, 0x5, 0x2d, 0xd, 0x3, 0x23},
+	{12000000, 340000000, 0x0, 0x71, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0x9, 0x15, 0xf, 0x5, 0x2e, 0xd, 0x3, 0x23},
+	{12000000, 350000000, 0x0, 0x74, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0x9, 0x15, 0x10, 0x6, 0x2f, 0xe, 0x3, 0x24},
+	{12000000, 360000000, 0x0, 0x78, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0x9, 0x16, 0x10, 0x6, 0x30, 0xe, 0x3, 0x24},
+	{12000000, 370000000, 0x0, 0x7b, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0x9, 0x17, 0x10, 0x6, 0x32, 0xe, 0x3, 0x24},
+	{12000000, 380000000, 0x0, 0x7e, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xa, 0x17, 0x10, 0x6, 0x33, 0xe, 0x3, 0x24},
+	{12000000, 390000000, 0x0, 0x82, 0x0 << 16 | 0x0 << 8 | 0x0, 0x2,
+	 0xa, 0x17, 0x11, 0x6, 0x35, 0xf, 0x3, 0x25},
+	{12000000, 400000000, 0x0, 0x85, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xa, 0x18, 0x11, 0x7, 0x35, 0xf, 0x3, 0x25},
+	{12000000, 410000000, 0x0, 0x88, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xa, 0x19, 0x11, 0x7, 0x37, 0xf, 0x3, 0x25},
+	{12000000, 420000000, 0x0, 0x8c, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xa, 0x19, 0x12, 0x7, 0x38, 0x10, 0x3, 0x26},
+	{12000000, 430000000, 0x0, 0x8f, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xb, 0x19, 0x12, 0x7, 0x39, 0x10, 0x3, 0x26},
+	{12000000, 440000000, 0x0, 0x92, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xb, 0x1a, 0x12, 0x7, 0x3b, 0x10, 0x3, 0x26},
+	{12000000, 450000000, 0x0, 0x96, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xb, 0x1b, 0x12, 0x8, 0x3c, 0x10, 0x3, 0x26},
+	{12000000, 460000000, 0x0, 0x99, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xb, 0x1b, 0x13, 0x8, 0x3d, 0x11, 0x3, 0x27},
+	{12000000, 470000000, 0x0, 0x9c, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xc, 0x1b, 0x13, 0x8, 0x3e, 0x11, 0x3, 0x27},
+	{12000000, 480000000, 0x0, 0xa0, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xc, 0x1c, 0x13, 0x8, 0x40, 0x11, 0x3, 0x27},
+	{12000000, 490000000, 0x0, 0xa3, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xc, 0x1d, 0x14, 0x8, 0x42, 0x12, 0x3, 0x28},
+	{12000000, 500000000, 0x0, 0xa6, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xc, 0x1d, 0x14, 0x9, 0x42, 0x12, 0x3, 0x28},
+	{12000000, 510000000, 0x0, 0xaa, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xc, 0x1e, 0x14, 0x9, 0x44, 0x12, 0x3, 0x28},
+	{12000000, 520000000, 0x0, 0xad, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xd, 0x1e, 0x15, 0x9, 0x45, 0x13, 0x3, 0x29},
+	{12000000, 530000000, 0x0, 0xb0, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xd, 0x1e, 0x15, 0x9, 0x47, 0x13, 0x3, 0x29},
+	{12000000, 540000000, 0x0, 0xb4, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xd, 0x1f, 0x15, 0x9, 0x48, 0x13, 0x3, 0x29},
+	{12000000, 550000000, 0x0, 0xb7, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xd, 0x20, 0x16, 0x9, 0x4a, 0x14, 0x3, 0x2a},
+	{12000000, 560000000, 0x0, 0xba, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xe, 0x20, 0x16, 0xa, 0x4a, 0x14, 0x3, 0x2a},
+	{12000000, 570000000, 0x0, 0xbe, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xe, 0x20, 0x16, 0xa, 0x4c, 0x14, 0x3, 0x2a},
+	{12000000, 580000000, 0x0, 0xc1, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xe, 0x21, 0x16, 0xa, 0x4d, 0x14, 0x3, 0x2a},
+	{12000000, 590000000, 0x0, 0xc4, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xe, 0x22, 0x17, 0xa, 0x4f, 0x15, 0x3, 0x2b},
+	{12000000, 600000000, 0x0, 0xc8, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x2, 0xe, 0x23, 0x17, 0xa, 0x50, 0x15, 0x3, 0x2b},
+	{12000000, 610000000, 0x0, 0xcb, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x2, 0xf, 0x22, 0x17, 0xb, 0x50, 0x15, 0x3, 0x2b},
+	{12000000, 620000000, 0x0, 0xce, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x2, 0xf, 0x23, 0x18, 0xb, 0x52, 0x16, 0x3, 0x2c},
+	{12000000, 630000000, 0x0, 0x69, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x7, 0x12, 0xd, 0x5, 0x2a, 0xc, 0x1, 0x15},
+	{12000000, 640000000, 0x0, 0x6a, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x7, 0x13, 0xe, 0x5, 0x2b, 0xd, 0x1, 0x16},
+	{12000000, 650000000, 0x0, 0x6c, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x7, 0x13, 0xe, 0x5, 0x2c, 0xd, 0x1, 0x16},
+	{12000000, 660000000, 0x0, 0x6e, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x7, 0x13, 0xe, 0x5, 0x2d, 0xd, 0x1, 0x16},
+	{12000000, 670000000, 0x0, 0x6f, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x8, 0x13, 0xe, 0x5, 0x2d, 0xd, 0x1, 0x16},
+	{12000000, 680000000, 0x0, 0x71, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x8, 0x13, 0xe, 0x5, 0x2e, 0xd, 0x1, 0x16},
+	{12000000, 690000000, 0x0, 0x73, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x8, 0x14, 0xe, 0x6, 0x2e, 0xd, 0x1, 0x16},
+	{12000000, 700000000, 0x0, 0x74, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x8, 0x14, 0xf, 0x6, 0x2f, 0xe, 0x1, 0x16},
+	{12000000, 710000000, 0x0, 0x76, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x8, 0x14, 0xf, 0x6, 0x2f, 0xe, 0x1, 0x17},
+	{12000000, 720000000, 0x0, 0x78, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x8, 0x15, 0xf, 0x6, 0x30, 0xe, 0x1, 0x17},
+	{12000000, 730000000, 0x0, 0x79, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x8, 0x15, 0xf, 0x6, 0x31, 0xe, 0x1, 0x17},
+	{12000000, 740000000, 0x0, 0x7b, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x8, 0x15, 0xf, 0x6, 0x32, 0xe, 0x1, 0x17},
+	{12000000, 750000000, 0x0, 0x7d, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x8, 0x16, 0xf, 0x6, 0x32, 0xe, 0x1, 0x17},
+	{12000000, 760000000, 0x0, 0x7e, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x9, 0x15, 0xf, 0x6, 0x33, 0xe, 0x1, 0x17},
+	{12000000, 770000000, 0x0, 0x80, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x9, 0x15, 0x10, 0x6, 0x34, 0xf, 0x1, 0x18},
+	{12000000, 780000000, 0x0, 0x82, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x9, 0x16, 0x10, 0x6, 0x35, 0xf, 0x1, 0x18,},
+	{12000000, 790000000, 0x0, 0x83, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x9, 0x16, 0x10, 0x7, 0x34, 0xf, 0x1, 0x18},
+	{12000000, 800000000, 0x0, 0x85, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x9, 0x17, 0x10, 0x7, 0x35, 0xf, 0x1, 0x18},
+	{12000000, 810000000, 0x0, 0x87, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x9, 0x17, 0x10, 0x7, 0x36, 0xf, 0x1, 0x18},
+	{12000000, 820000000, 0x0, 0x88, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0x9, 0x17, 0x10, 0x7, 0x37, 0xf, 0x1, 0x18},
+	{12000000, 830000000, 0x0, 0x8a, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0x9, 0x18, 0x10, 0x7, 0x37, 0xf, 0x1, 0x18},
+	{12000000, 840000000, 0x0, 0x8c, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0x9, 0x18, 0x11, 0x7, 0x38, 0x10, 0x1, 0x19},
+	{12000000, 850000000, 0x0, 0x8d, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0xa, 0x17, 0x11, 0x7, 0x39, 0x10, 0x1, 0x19},
+	{12000000, 860000000, 0x0, 0x8f, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0xa, 0x18, 0x11, 0x7, 0x39, 0x10, 0x1, 0x19},
+	{12000000, 870000000, 0x0, 0x91, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0xa, 0x18, 0x11, 0x7, 0x3a, 0x10, 0x1, 0x19},
+	{12000000, 880000000, 0x0, 0x92, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0xa, 0x18, 0x11, 0x7, 0x3b, 0x10, 0x1, 0x19},
+	{12000000, 890000000, 0x0, 0x94, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0xa, 0x19, 0x11, 0x7, 0x3c, 0x10, 0x1, 0x19},
+	{12000000, 900000000, 0x0, 0x96, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0xa, 0x19, 0x12, 0x8, 0x3c, 0x10, 0x1, 0x19},
+	{12000000, 910000000, 0x0, 0x97, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0xa, 0x19, 0x12, 0x8, 0x3c, 0x11, 0x1, 0x1a},
+	{12000000, 920000000, 0x0, 0x99, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0xa, 0x1a, 0x12, 0x8, 0x3d, 0x11, 0x1, 0x1a},
+	{12000000, 930000000, 0x0, 0x9b, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0xa, 0x1a, 0x12, 0x8, 0x3e, 0x11, 0x1, 0x1a},
+	{12000000, 940000000, 0x0, 0x9c, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0xb, 0x1a, 0x12, 0x8, 0x3e, 0x11, 0x1, 0x1a},
+	{12000000, 950000000, 0x0, 0x9e, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0xb, 0x1a, 0x12, 0x8, 0x3f, 0x11, 0x1, 0x1a},
+	{12000000, 960000000, 0x0, 0xa0, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0xb, 0x1a, 0x12, 0x8, 0x40, 0x11, 0x1, 0x1a},
+	{12000000, 970000000, 0x0, 0xa1, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0xb, 0x1b, 0x13, 0x8, 0x41, 0x12, 0x1, 0x1b},
+	{12000000, 980000000, 0x0, 0xa3, 0x55 << 16 | 0x55 << 8 | 0x55,
+	 0x1, 0xb, 0x1b, 0x13, 0x8, 0x42, 0x12, 0x1, 0x1b},
+	{12000000, 990000000, 0x0, 0xa5, 0x0 << 16 | 0x0 << 8 | 0x0,
+	 0x1, 0xb, 0x1b, 0x13, 0x8, 0x42, 0x12, 0x1, 0x1b},
+	{12000000, 1000000000, 0x0, 0xa6, 0xaa << 16 | 0xaa << 8 | 0xaa,
+	 0x1, 0xb, 0x1c, 0x13, 0x9, 0x42, 0x12, 0x1, 0x1b},
+};
+
+struct stf_dphy_info {
+	/**
+	 * @maps:
+	 *
+	 * Physical lanes and logic lanes mapping table.
+	 *
+	 * The default order is:
+	 * [data lane 0, data lane 1, data lane 2, date lane 3, clk lane]
+	 */
+	u8 maps[STF_MAP_LANES_NUM];
+};
+
+struct stf_dphy {
+	struct device *dev;
+	void __iomem *topsys;
+	struct clk *txesc_clk;
+	struct reset_control *sys_rst;
+
+	struct phy_configure_opts_mipi_dphy config;
+
+	struct regulator *mipitx_0p9;
+
+	struct phy *phy;
+	const struct stf_dphy_info *info;
+};
+
+static inline u32 stf_dphy_get_reg(void __iomem *io_addr, u32 addr, u32 shift, u32 mask)
+{
+	u32 tmp;
+
+	tmp = readl(io_addr);
+	tmp = (tmp & mask) >> shift;
+	return tmp;
+}
+
+static inline void stf_dphy_set_reg(void __iomem *io_addr, u32 addr, u32 data, u32 shift, u32 mask)
+{
+	u32 tmp;
+
+	tmp = readl(io_addr + addr);
+	tmp &= ~mask;
+	tmp |= (data << shift) & mask;
+	writel(tmp, (io_addr + addr));
+}
+
+static int is_pll_locked(struct stf_dphy *dphy)
+{
+	int tmp = stf_dphy_get_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8),
+				  STF_DPHY_RGS_CDTX_PLL_UNLOCK_SHIFT,
+				  STF_DPHY_RGS_CDTX_PLL_UNLOCK_MASK);
+	return !tmp;
+}
+
+static void stf_dphy_hw_reset(struct stf_dphy *dphy, int assert)
+{
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(100),
+			 !assert, STF_DPHY_RESETB_SHIFT, STF_DPHY_RESETB_MASK);
+
+	if (!assert) {
+		/*the lock-in time of pll of M31 is 20us-50ms*/
+		while ((!is_pll_locked(dphy)) && msecs_to_jiffies(50))
+			;
+		dev_err(dphy->dev, "MIPI dphy-tx # PLL Locked\n");
+	}
+}
+
+static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct stf_dphy *dphy;
+	u32 bitrate;
+	unsigned long alignment;
+	int i;
+	const struct m31_dphy_config *p;
+	const u32 STF_DPHY_AON_POWER_READY_N_active = 0;
+	const struct stf_dphy_info *info;
+
+	dphy = phy_get_drvdata(phy);
+	info = dphy->info;
+	bitrate = opts->mipi_dphy.hs_clk_rate;
+
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8), 0x10,
+			 STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
+			 STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
+			 STF_DPHY_RG_CDTX_L2N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L2N_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
+			 STF_DPHY_RG_CDTX_L3N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L3N_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(16), 0x10,
+			 STF_DPHY_RG_CDTX_L4N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L4N_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8), 0x10,
+			 STF_DPHY_RG_CDTX_L0P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0P_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
+			 STF_DPHY_RG_CDTX_L1P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L1P_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
+			 STF_DPHY_RG_CDTX_L2P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L2P_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
+			 STF_DPHY_RG_CDTX_L3P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L3P_HSTX_RES_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(16), 0x10,
+			 STF_DPHY_RG_CDTX_L4P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L4P_HSTX_RES_MASK);
+
+	alignment = STF_DPHY_BITRATE_ALIGN;
+	if (bitrate % alignment)
+		bitrate += alignment - (bitrate % alignment);
+
+	p = m31_dphy_configs;
+	for (i = 0; i < ARRAY_SIZE(m31_dphy_configs); i++, p++) {
+		if (p->bitrate == bitrate) {
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(100),
+					 STF_DPHY_REFCLK_12M, STF_DPHY_REFCLK_IN_SEL_SHIFT,
+					 STF_DPHY_REFCLK_IN_SEL_MASK);
+
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0),
+					 STF_DPHY_AON_POWER_READY_N_active,
+					 STF_DPHY_AON_POWER_READY_N_SHIFT,
+					 STF_DPHY_AON_POWER_READY_N_MASK);
+
+			/*Lane setting*/
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[0],
+					 STF_DPHY_CFG_L0_SWAP_SEL_SHIFT,
+					 STF_DPHY_CFG_L0_SWAP_SEL_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[1],
+					 STF_DPHY_CFG_L1_SWAP_SEL_SHIFT,
+					 STF_DPHY_CFG_L1_SWAP_SEL_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[2],
+					 STF_DPHY_CFG_L2_SWAP_SEL_SHIFT,
+					 STF_DPHY_CFG_L2_SWAP_SEL_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[3],
+					 STF_DPHY_CFG_L3_SWAP_SEL_SHIFT,
+					 STF_DPHY_CFG_L3_SWAP_SEL_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[4],
+					 STF_DPHY_CFG_L4_SWAP_SEL_SHIFT,
+					 STF_DPHY_CFG_L4_SWAP_SEL_MASK);
+			/*PLL setting*/
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(28), 0x0,
+					 STF_DPHY_RG_CDTX_PLL_SSC_EN_SHIFT,
+					 STF_DPHY_RG_CDTX_PLL_SSC_EN_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24), 0x1,
+					 STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_SHIFT,
+					 STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24), 0x1,
+					 STF_DPHY_RG_CDTX_PLL_FM_EN_SHIFT,
+					 STF_DPHY_RG_CDTX_PLL_FM_EN_MASK);
+
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24),
+					 p->pll_prev_div, STF_DPHY_RG_CDTX_PLL_PRE_DIV_SHIFT,
+					 STF_DPHY_RG_CDTX_PLL_PRE_DIV_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24),
+					 p->pll_fbk_int, STF_DPHY_RG_CDTX_PLL_FBK_INT_SHIFT,
+					 STF_DPHY_RG_CDTX_PLL_FBK_INT_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(20),
+					 p->pll_fbk_fra, STF_DPHY_RG_CDTX_PLL_FBK_FRA_SHIFT,
+					 STF_DPHY_RG_CDTX_PLL_FBK_FRA_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(40),
+					 p->extd_cycle_sel, STF_DPHY_RG_EXTD_CYCLE_SEL_SHIFT,
+					 STF_DPHY_RG_EXTD_CYCLE_SEL_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
+					 p->dlane_hs_pre_time,
+					 STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT,
+					 STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
+					 p->dlane_hs_pre_time,
+					 STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT,
+					 STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
+					 p->dlane_hs_zero_time,
+					 STF_DPHY_RG_DLANE_HS_ZERO_TIME_SHIFT,
+					 STF_DPHY_RG_DLANE_HS_ZERO_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
+					 p->dlane_hs_trail_time,
+					 STF_DPHY_RG_DLANE_HS_TRAIL_TIME_SHIFT,
+					 STF_DPHY_RG_DLANE_HS_TRAIL_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
+					 p->clane_hs_pre_time,
+					 STF_DPHY_RG_CLANE_HS_PRE_TIME_SHIFT,
+					 STF_DPHY_RG_CLANE_HS_PRE_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
+					 p->clane_hs_zero_time,
+					 STF_DPHY_RG_CLANE_HS_ZERO_TIME_SHIFT,
+					 STF_DPHY_RG_CLANE_HS_ZERO_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
+					 p->clane_hs_trail_time,
+					 STF_DPHY_RG_CLANE_HS_TRAIL_TIME_SHIFT,
+					 STF_DPHY_RG_CLANE_HS_TRAIL_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
+					 p->clane_hs_clk_pre_time,
+					 STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_SHIFT,
+					 STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_MASK);
+			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
+					 p->clane_hs_clk_post_time,
+					 STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_SHIFT,
+					 STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_MASK);
+
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int stf_dphy_init(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+
+	stf_dphy_hw_reset(dphy, 0);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(48), 0,
+			 STF_DPHY_SCFG_PPI_C_READY_SEL_SHIFT, STF_DPHY_SCFG_PPI_C_READY_SEL_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(48), 0,
+			 STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_SHIFT,
+			 STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_MASK);
+	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(44), 0x30,
+			 STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_SHIFT,
+			 STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_MASK);
+
+	ret = clk_prepare_enable(dphy->txesc_clk);
+	if (ret) {
+		dev_err(dphy->dev, "Failed to prepare/enable txesc_clk\n");
+		return ret;
+	}
+
+	ret = reset_control_deassert(dphy->sys_rst);
+	if (ret) {
+		dev_err(dphy->dev, "Failed to deassert sys_rst\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stf_dphy_exit(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = reset_control_assert(dphy->sys_rst);
+	if (ret) {
+		dev_err(dphy->dev, "Failed to assert sys_rst\n");
+		return ret;
+	}
+
+	clk_disable_unprepare(dphy->txesc_clk);
+
+	stf_dphy_hw_reset(dphy, 1);
+
+	return 0;
+}
+
+static int stf_dphy_power_on(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dphy->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_enable(dphy->mipitx_0p9);
+	if (ret) {
+		dev_err(dphy->dev, "Cannot enable mipitx_0p9 regulator\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stf_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
+			     union phy_configure_opts *opts)
+{
+	if (mode != PHY_MODE_MIPI_DPHY)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int stf_dphy_power_off(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+
+	regulator_disable(dphy->mipitx_0p9);
+
+	pm_runtime_put_sync(dphy->dev);
+
+	return 0;
+}
+
+static const struct phy_ops stf_dphy_ops = {
+	.power_on	= stf_dphy_power_on,
+	.power_off	= stf_dphy_power_off,
+	.init		= stf_dphy_init,
+	.exit		= stf_dphy_exit,
+	.configure	= stf_dphy_configure,
+	.validate	= stf_dphy_validate,
+	.owner		= THIS_MODULE,
+};
+
+static int stf_dphy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct stf_dphy *dphy;
+
+	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
+	if (!dphy)
+		return -ENOMEM;
+
+	dphy->info = of_device_get_match_data(&pdev->dev);
+
+	dphy->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, dphy);
+
+	dphy->topsys = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dphy->topsys))
+		return PTR_ERR(dphy->topsys);
+
+	pm_runtime_enable(&pdev->dev);
+
+	dphy->mipitx_0p9 = devm_regulator_get(&pdev->dev, "mipi_0p9");
+	if (IS_ERR(dphy->mipitx_0p9))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dphy->mipitx_0p9),
+				     "Failed to get regulator\n");
+
+	dphy->txesc_clk = devm_clk_get(&pdev->dev, "txesc");
+	if (IS_ERR(dphy->txesc_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dphy->txesc_clk),
+				     "Failed to get txesc clock\n");
+
+	dphy->sys_rst = devm_reset_control_get_exclusive(&pdev->dev, "sys");
+	if (IS_ERR(dphy->sys_rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dphy->sys_rst),
+				     "Failed to get sys reset\n");
+
+	dphy->phy = devm_phy_create(&pdev->dev, NULL, &stf_dphy_ops);
+	if (IS_ERR(dphy->phy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dphy->phy),
+				     "Failed to create phy\n");
+
+	phy_set_drvdata(dphy->phy, dphy);
+
+	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(&pdev->dev, PTR_ERR(phy_provider),
+				     "Failed to register phy\n");
+
+	return 0;
+}
+
+static const struct stf_dphy_info starfive_dphy_info = {
+	.maps = {0, 1, 2, 3, 4},
+};
+
+static const struct of_device_id stf_dphy_dt_ids[] = {
+	{
+		.compatible = "starfive,jh7110-dphy-tx",
+		.data = &starfive_dphy_info,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, stf_dphy_dt_ids);
+
+static struct platform_driver stf_dphy_driver = {
+	.driver = {
+		.name	= "starfive-dphy-tx",
+		.of_match_table = stf_dphy_dt_ids,
+	},
+	.probe = stf_dphy_probe,
+};
+module_platform_driver(stf_dphy_driver);
+
+MODULE_AUTHOR("Keith Zhao <keith.zhao@starfivetech.com>");
+MODULE_AUTHOR("Shengyang Chen <shengyang.chen@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 DPHY TX driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


