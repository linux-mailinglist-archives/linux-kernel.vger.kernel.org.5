Return-Path: <linux-kernel+bounces-149497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDB8A9202
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF941F2153C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF4548F6;
	Thu, 18 Apr 2024 04:22:33 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2137.outbound.protection.partner.outlook.cn [139.219.146.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F803BB47;
	Thu, 18 Apr 2024 04:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414152; cv=fail; b=CtSQiXCnZdVl2KJl7WEruU3vC2c1aNylzCm5f/Nh/jZ/R8coLBia9dEgJZPJnpt2VHbbGmsHK97MwQtl9lwmSy1ScXBSngFK5v/qVzPVVjP3mzVMW3Y8Eb9zIJLbhPot8DKcYkGCoiOpIFTAj4hmYkFOUIsY5fgCswgKMi27c14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414152; c=relaxed/simple;
	bh=AZfmVU8VfXg+wqecI1uRX50qMe/GAf/kXnHw8TcKmM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/Saz9r4llN/E0iCJ3ZQZu0rmyz5Nnsxm3bSTq/PA4UawYiBL5GGpa6WOPUCmF8Vo+JHb+r8jqLySxDbNkqe661HHDXD1aJ0honxJGDqIp2pvyBoo3l6wELwTO9xP1PRzGJ2qxRHUrW3Uxcerkp+cThW7TwemnjLpeO7q3/GfzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofs7mf09A0SLiuVnGtVV2IayUQ0MIcPYSkO4J44YDJ01+3wpcpKnegen7FqJB/ZytdVMfzSywdlixmVp864mrSYOFUvWO09b5qIolcrE8FG3KKJsGikzt8cT1uPKFABeTlKP8otmm4DlJd71no121r1GWS/5EVQTvqtJSkHrkfB2wKzvnFeIyX+n/Af41//zcrt48at1J5fSBjuphaQICtErOUNHqmVXN2q4k+L4m+QsxEwFaQFK5GMKp+ykc4Q8Q1W2p+9bdDMyluTaRR8/OvM2q/zTQcyeAOxLRlC4QTZZzsl6m6HxXilji2SduPbp1tpq8kLkpZWfjNHHkbBFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTvz4fXXcnIN18b4efNkfkxRw0HHf0A3WwkzvdwVFEU=;
 b=Md38/941xdCd0IIRv+s4OHzx7p5R4k6KmXUA1r1vnnQq4iXgdKoWF035C2vuAqGpc0wx/CGomHOWmQkf5P3nqb/Ks4w+z98Of7i14cQVuviBDjtEBFBes6+f4BZCqN8wpvbmYYmZURgSKsfETqkxU8ch5S2rT4AXleA0f4fwsKFsOkxqM4nbKGBMB0u3kBGpu4/y4UcjF1r/vBzoIQovHZnYzSAQREmOiWbYrKl+7auhDCY6b7dQPIfIxxK6JrG3wqc1D8VplVN/Y9cUQNT3U2AyJ+8pgBtkE7v3C5Q2QA5fv61ZkxY1HTkq2I8EsNZFDJGQ7GCrrSsTe0TlrhpilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1071.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 18 Apr
 2024 03:50:35 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::103a:5792:ddaf:4283]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::103a:5792:ddaf:4283%4])
 with mapi id 15.20.7409.042; Thu, 18 Apr 2024 03:50:35 +0000
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
Subject: [PATCH v5 2/2] phy: starfive: Add mipi dphy tx support
Date: Thu, 18 Apr 2024 11:50:20 +0800
Message-Id: <20240418035020.47876-3-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
References: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::13) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB1071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cef3375-9669-4182-a787-08dc5f5ab452
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6pP23w/1dNlV6LBbAKJtVZwYEiqn6A2SARzmEq451jA2cm+cj/c9aoDIfe7i4f7aCPQAyLMvEpZs05X+O3PBixu2I3ce/sTQIH39lpQhmxSqeYJQot1weNxhahYuWF//P7gKdFltKtJYXGvaTm9Dr/uyM49ZQXmaoJbDPVcagbsFHeqi6/GPtkC45LAabtwfqPs1wf2RtpD24xxkfqlQqS7sJiQDt7YYITpICad9EVWdVfjDU9ZD3nKT8b+4fNXsp3HVEuc3VJ9Qs01njZ5kgvmw11vZl5rVflpcKeZVqQIm1npuekcC8qX4vNGkQNBMxFyae+DSrZkBUUfpLzc26x1zVfpI8Tyv6eDuQ8a9G0CUu1uWKJqfzr1clQ4sRBq3TC3E0Q3sFarGp0tqrpd4GoWMP/S7adkVEihq8AonaJm08Bte1FE6ch9pM+FX5Um5P18uw0v6oFULUrzMVVIjz4UmuyBrdflqJkdcUCLU+GqX2REg1A1z8sC6D2NfgfJ37BfqB+YbfCOLA67Xm4f3qMSvrR2ykEeWRkqq7SHh7Z9y+mPkMRWzPcGK//ZFYQR1eBL3xgOU4qmqFz9VxzdHc/CG8DF7ttffzjURTyxbOQxC9wKxiftjQufh6QCyISpE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DOvGcUsGVfRLnBhMWRKZTTzVxvnPQ4ExL78dTFJOT82ZcHE4ln5O6nvzGoEr?=
 =?us-ascii?Q?/dVy1usAffD3/O92DFffdakmoTbJJxJdfIYJc1+6JqTaWRnRx3POUfGjB4lr?=
 =?us-ascii?Q?a16I9pIHsWz8XPqgtJmPS6FtLu1fb4ucOsZ7p6rLvsAqL2P8YObMUxPqh/jQ?=
 =?us-ascii?Q?Ego43oquaGAYqpjTbeUxEOeLHAIU/xosAz2o+anVC+OWr28UDHNxpSSvgZaa?=
 =?us-ascii?Q?E7EzDYZ7PxGTyg/z0Godm9GSRp9zda567Y6tDjuLs2VX0/OX+Kls/obG4Fbs?=
 =?us-ascii?Q?29vzYScEwg271DwVS4z+7ohpsO876Dn89FDzun9Zs72W6+j0ERJZ2Vpxj3PJ?=
 =?us-ascii?Q?FaAYab7DFeWbDieJA6gKgtsBKlyfqqaRnRpy0jlQUSU5UtMMRSxUYgRDVjr8?=
 =?us-ascii?Q?as9HufsyG6OC11FNpdgU0tGqOjfMEc4gIGjuIOTb9WRZMGxlCQHflavWLTEL?=
 =?us-ascii?Q?lD5O2+MkJosdgAcQFddvQ9dOf9gy5oGG+i/EY9y7Nfghvn1N2H48trtW2Y7B?=
 =?us-ascii?Q?4femY5vWc+aJzDwNpMuZZNl3s5GVPwE9DupaePz6LQNnytEoWz1nH4vV80DQ?=
 =?us-ascii?Q?5cBTHeVjT7F3Slfq+kWUWsKIOc+y00NvB90sT9bbiWzJ4HFOzCzGkuI8t4nO?=
 =?us-ascii?Q?CH/km71DBIFY5oocJMO3TENhaO2cYZla8546L3pIsu7oGOls6gCREYHkbI7H?=
 =?us-ascii?Q?fAUzgnuCxQw2QYWGbCj9mlLNFgM1a4P9M9ClwSxNnfky7KJgg1fU6poVAnSR?=
 =?us-ascii?Q?8oo3fKooWwk2UcB6wLwhR8GL5I467Y+aaiQdAT0v0GjaQCtQbVW+p7yYGY1J?=
 =?us-ascii?Q?tTEY/ML3kXzwofUIelXkiFuKzIY+LdP5wNSeiCm69IoSCF1ViyPi1LlreM+k?=
 =?us-ascii?Q?LwLCpjoGeTSqbuzzHAXXoTseg0j6CKk5WgE46N+84I7T9fP3sPrzKn2GSfOj?=
 =?us-ascii?Q?hj65TTYpZHS/ZnAU9zXpGzuXArmKB4r7MhrTubQjCcvYaKZPSdp5z4ZOpMOU?=
 =?us-ascii?Q?RjgnRhWzG5AZYond7qlw07EJbfV48DQKQnm4cWSTtM42SGCyNAVrZmQufvON?=
 =?us-ascii?Q?S3qngX4OmJY/fMkdaVlY49NbG/8yxxzHrCNOI9Ton1oQGJ8zRMiA5kaI4pi3?=
 =?us-ascii?Q?mx+8K1iRoYM2DPyQIR5EKYOrRX3c7SiH6kfzZ24YXzX2LGaldm9/DTbgZRwy?=
 =?us-ascii?Q?oB42ZVkplGYpB0vtUt0w4w/FMThqXGteoYukwaO3yNC4tzBDiwJPfod3HC+f?=
 =?us-ascii?Q?z+MU+sCGWxNgH+xU3DVauvLcwHHgPEUYtV6df8TgAo0c96bAPv+xziFW860Y?=
 =?us-ascii?Q?e35wuSAW/WcoifH2yeltKQR4WxvUVY2QbmQbcYOI6CWAnVYjsyUA8BP6NMsI?=
 =?us-ascii?Q?LaCt9RW+FTkWlgK18SjV6Uk8ubta7YgThgUqo/d4JDRi1spQB9qH0pBmIXU4?=
 =?us-ascii?Q?36LdNQvDsf0o3SRbg02MG3exyZG8EI1dAgsqy5xOdfh+qHTSm8IhJu1etsOd?=
 =?us-ascii?Q?L3nFLjMjNS9IuRHWjfc+K3upJ7Kk/2tf+ITKaCSjNCLFC/AvIcnc8jLOJzJL?=
 =?us-ascii?Q?akrgxNSpam0fNZmG6JJwNGaY0k8+rdZcKV5RckbSaaBHEiRvxZJrrMTRcaX2?=
 =?us-ascii?Q?ZPuDf3dKY5h+X9+sdthzKdA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cef3375-9669-4182-a787-08dc5f5ab452
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:50:35.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8XreCrsgkuFl8Pw+SUpRGVDU9B9SavN8EujiB420lUp0hp48PpjD9cQdDwk3KAZF/S/9oH3EXWT/udt8GwQ4IaaaeYeCsEIBZuNpPRGzB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1071

Add mipi dphy tx support for the StarFive JH7110 SoC.
It is a module which is used to receive data from DSI
driver and transfer data to DSI interface like mipi screen.

Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                               |   7 +
 drivers/phy/starfive/Kconfig              |  10 +
 drivers/phy/starfive/Makefile             |   1 +
 drivers/phy/starfive/phy-jh7110-dphy-tx.c | 459 ++++++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a5e1d0f3b35..ef56944d2d0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21009,6 +21009,13 @@ S:	Supported
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
index 000000000000..61b0da6096e5
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DPHY TX driver for the StarFive JH7110 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Keith Zhao <keith.zhao@starfivetech.com>
+ * Author: Shengyang Chen <shengyang.chen@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-mipi-dphy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define STF_DPHY_APBIFSAIF_SYSCFG(x)			(x)
+
+#define STF_DPHY_AON_POWER_READY_N_ACTIVE		0
+#define STF_DPHY_AON_POWER_READY_N			BIT(0)
+#define STF_DPHY_CFG_L0_SWAP_SEL			GENMASK(14, 12)
+#define STF_DPHY_CFG_L1_SWAP_SEL			GENMASK(17, 15)
+#define STF_DPHY_CFG_L2_SWAP_SEL			GENMASK(20, 18)
+#define STF_DPHY_CFG_L3_SWAP_SEL			GENMASK(23, 21)
+#define STF_DPHY_CFG_L4_SWAP_SEL			GENMASK(26, 24)
+#define STF_DPHY_RGS_CDTX_PLL_UNLOCK			BIT(18)
+#define STF_DPHY_RG_CDTX_L0N_HSTX_RES			GENMASK(23, 19)
+#define STF_DPHY_RG_CDTX_L0P_HSTX_RES			GENMASK(28, 24)
+
+#define STF_DPHY_RG_CDTX_L1P_HSTX_RES			GENMASK(9, 5)
+#define STF_DPHY_RG_CDTX_L2N_HSTX_RES			GENMASK(14, 10)
+#define STF_DPHY_RG_CDTX_L2P_HSTX_RES			GENMASK(19, 15)
+#define STF_DPHY_RG_CDTX_L3N_HSTX_RES			GENMASK(24, 20)
+#define STF_DPHY_RG_CDTX_L3P_HSTX_RES			GENMASK(29, 25)
+
+#define STF_DPHY_RG_CDTX_L4N_HSTX_RES			GENMASK(4, 0)
+#define STF_DPHY_RG_CDTX_L4P_HSTX_RES			GENMASK(9, 5)
+#define STF_DPHY_RG_CDTX_PLL_FBK_FRA			GENMASK(23, 0)
+
+#define STF_DPHY_RG_CDTX_PLL_FBK_INT			GENMASK(8, 0)
+#define STF_DPHY_RG_CDTX_PLL_FM_EN			BIT(9)
+#define STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN		BIT(10)
+#define STF_DPHY_RG_CDTX_PLL_PRE_DIV			GENMASK(12, 11)
+
+#define STF_DPHY_RG_CDTX_PLL_SSC_EN			BIT(18)
+
+#define STF_DPHY_RG_CLANE_HS_CLK_POST_TIME		GENMASK(7, 0)
+#define STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME		GENMASK(15, 8)
+#define STF_DPHY_RG_CLANE_HS_PRE_TIME			GENMASK(23, 16)
+#define STF_DPHY_RG_CLANE_HS_TRAIL_TIME			GENMASK(31, 24)
+
+#define STF_DPHY_RG_CLANE_HS_ZERO_TIME			GENMASK(7, 0)
+#define STF_DPHY_RG_DLANE_HS_PRE_TIME			GENMASK(15, 8)
+#define STF_DPHY_RG_DLANE_HS_TRAIL_TIME			GENMASK(23, 16)
+#define STF_DPHY_RG_DLANE_HS_ZERO_TIME			GENMASK(31, 24)
+
+#define STF_DPHY_RG_EXTD_CYCLE_SEL			GENMASK(2, 0)
+#define STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME		GENMASK(31, 0)
+
+#define STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL		GENMASK(2, 1)
+#define STF_DPHY_SCFG_PPI_C_READY_SEL			GENMASK(4, 3)
+
+#define STF_DPHY_REFCLK_IN_SEL				GENMASK(28, 26)
+#define STF_DPHY_RESETB					BIT(29)
+
+#define STF_DPHY_REFCLK_12M				1
+#define STF_DPHY_BITRATE_ALIGN				10000000
+
+#define STF_MAP_LANES_NUM				5
+
+#define STF_DPHY_LSHIFT_16(x)				(FIELD_PREP(GENMASK(23, 16), (x)))
+#define STF_DPHY_LSHIFT_8(x)				(FIELD_PREP(GENMASK(15, 8), (x)))
+
+#define STF_DPHY_HW_DELAY_US				200
+#define STF_DPHY_HW_TIMEOUT_US				5000
+
+struct stf_dphy_config {
+	unsigned long bitrate;
+	u32 pll_fbk_int;
+	u32 pll_fbk_fra_val;
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
+static const struct stf_dphy_config reg_configs[] = {
+	{160000000, 0x6a, 0xaa, 0x3, 0xa, 0x17, 0x11, 0x5, 0x2b, 0xd, 0x7, 0x3d},
+	{170000000, 0x71, 0x55, 0x3, 0xb, 0x18, 0x11, 0x5, 0x2e, 0xd, 0x7, 0x3d},
+	{180000000, 0x78, 0x0, 0x3, 0xb, 0x19, 0x12, 0x6, 0x30, 0xe, 0x7, 0x3e},
+	{190000000, 0x7e, 0xaa, 0x3, 0xc, 0x1a, 0x12, 0x6, 0x33, 0xe, 0x7, 0x3e},
+	{200000000, 0x85, 0x55, 0x3, 0xc, 0x1b, 0x13, 0x7, 0x35, 0xf, 0x7, 0x3f},
+	{320000000, 0x6a, 0xaa, 0x2, 0x8, 0x14, 0xf, 0x5, 0x2b, 0xd, 0x3, 0x23},
+	{330000000, 0x6e, 0x0, 0x2, 0x8, 0x15, 0xf, 0x5, 0x2d, 0xd, 0x3, 0x23},
+	{340000000, 0x71, 0x55, 0x2, 0x9, 0x15, 0xf, 0x5, 0x2e, 0xd, 0x3, 0x23},
+	{350000000, 0x74, 0xaa, 0x2, 0x9, 0x15, 0x10, 0x6, 0x2f, 0xe, 0x3, 0x24},
+	{360000000, 0x78, 0x0, 0x2, 0x9, 0x16, 0x10, 0x6, 0x30, 0xe, 0x3, 0x24},
+	{370000000, 0x7b, 0x55, 0x2, 0x9, 0x17, 0x10, 0x6, 0x32, 0xe, 0x3, 0x24},
+	{380000000, 0x7e, 0xaa, 0x2, 0xa, 0x17, 0x10, 0x6, 0x33, 0xe, 0x3, 0x24},
+	{390000000, 0x82, 0x0, 0x2, 0xa, 0x17, 0x11, 0x6, 0x35, 0xf, 0x3, 0x25},
+	{400000000, 0x85, 0x55, 0x2, 0xa, 0x18, 0x11, 0x7, 0x35, 0xf, 0x3, 0x25},
+	{410000000, 0x88, 0xaa, 0x2, 0xa, 0x19, 0x11, 0x7, 0x37, 0xf, 0x3, 0x25},
+	{420000000, 0x8c, 0x0, 0x2, 0xa, 0x19, 0x12, 0x7, 0x38, 0x10, 0x3, 0x26},
+	{430000000, 0x8f, 0x55, 0x2, 0xb, 0x19, 0x12, 0x7, 0x39, 0x10, 0x3, 0x26},
+	{440000000, 0x92, 0xaa, 0x2, 0xb, 0x1a, 0x12, 0x7, 0x3b, 0x10, 0x3, 0x26},
+	{450000000, 0x96, 0x0, 0x2, 0xb, 0x1b, 0x12, 0x8, 0x3c, 0x10, 0x3, 0x26},
+	{460000000, 0x99, 0x55, 0x2, 0xb, 0x1b, 0x13, 0x8, 0x3d, 0x11, 0x3, 0x27},
+	{470000000, 0x9c, 0xaa, 0x2, 0xc, 0x1b, 0x13, 0x8, 0x3e, 0x11, 0x3, 0x27},
+	{480000000, 0xa0, 0x27, 0x2, 0xc, 0x1c, 0x13, 0x8, 0x40, 0x11, 0x3, 0x27},
+	{490000000, 0xa3, 0x55, 0x2, 0xc, 0x1d, 0x14, 0x8, 0x42, 0x12, 0x3, 0x28},
+	{500000000, 0xa6, 0xaa, 0x2, 0xc, 0x1d, 0x14, 0x9, 0x42, 0x12, 0x3, 0x28},
+	{510000000, 0xaa, 0x0, 0x2, 0xc, 0x1e, 0x14, 0x9, 0x44, 0x12, 0x3, 0x28},
+	{520000000, 0xad, 0x55, 0x2, 0xd, 0x1e, 0x15, 0x9, 0x45, 0x13, 0x3, 0x29},
+	{530000000, 0xb0, 0xaa, 0x2, 0xd, 0x1e, 0x15, 0x9, 0x47, 0x13, 0x3, 0x29},
+	{540000000, 0xb4, 0x0, 0x2, 0xd, 0x1f, 0x15, 0x9, 0x48, 0x13, 0x3, 0x29},
+	{550000000, 0xb7, 0x55, 0x2, 0xd, 0x20, 0x16, 0x9, 0x4a, 0x14, 0x3, 0x2a},
+	{560000000, 0xba, 0xaa, 0x2, 0xe, 0x20, 0x16, 0xa, 0x4a, 0x14, 0x3, 0x2a},
+	{570000000, 0xbe, 0x0, 0x2, 0xe, 0x20, 0x16, 0xa, 0x4c, 0x14, 0x3, 0x2a},
+	{580000000, 0xc1, 0x55, 0x2, 0xe, 0x21, 0x16, 0xa, 0x4d, 0x14, 0x3, 0x2a},
+	{590000000, 0xc4, 0xaa, 0x2, 0xe, 0x22, 0x17, 0xa, 0x4f, 0x15, 0x3, 0x2b},
+	{600000000, 0xc8, 0x0, 0x2, 0xe, 0x23, 0x17, 0xa, 0x50, 0x15, 0x3, 0x2b},
+	{610000000, 0xcb, 0x55, 0x2, 0xf, 0x22, 0x17, 0xb, 0x50, 0x15, 0x3, 0x2b},
+	{620000000, 0xce, 0xaa, 0x2, 0xf, 0x23, 0x18, 0xb, 0x52, 0x16, 0x3, 0x2c},
+	{630000000, 0x69, 0x0, 0x1, 0x7, 0x12, 0xd, 0x5, 0x2a, 0xc, 0x1, 0x15},
+	{640000000, 0x6a, 0xaa, 0x1, 0x7, 0x13, 0xe, 0x5, 0x2b, 0xd, 0x1, 0x16},
+	{650000000, 0x6c, 0x55, 0x1, 0x7, 0x13, 0xe, 0x5, 0x2c, 0xd, 0x1, 0x16},
+	{660000000, 0x6e, 0x0, 0x1, 0x7, 0x13, 0xe, 0x5, 0x2d, 0xd, 0x1, 0x16},
+	{670000000, 0x6f, 0xaa, 0x1, 0x8, 0x13, 0xe, 0x5, 0x2d, 0xd, 0x1, 0x16},
+	{680000000, 0x71, 0x55, 0x1, 0x8, 0x13, 0xe, 0x5, 0x2e, 0xd, 0x1, 0x16},
+	{690000000, 0x73, 0x0, 0x1, 0x8, 0x14, 0xe, 0x6, 0x2e, 0xd, 0x1, 0x16},
+	{700000000, 0x74, 0xaa, 0x1, 0x8, 0x14, 0xf, 0x6, 0x2f, 0xe, 0x1, 0x16},
+	{710000000, 0x76, 0x55, 0x1, 0x8, 0x14, 0xf, 0x6, 0x2f, 0xe, 0x1, 0x17},
+	{720000000, 0x78, 0x0, 0x1, 0x8, 0x15, 0xf, 0x6, 0x30, 0xe, 0x1, 0x17},
+	{730000000, 0x79, 0xaa, 0x1, 0x8, 0x15, 0xf, 0x6, 0x31, 0xe, 0x1, 0x17},
+	{740000000, 0x7b, 0x55, 0x1, 0x8, 0x15, 0xf, 0x6, 0x32, 0xe, 0x1, 0x17},
+	{750000000, 0x7d, 0x0, 0x1, 0x8, 0x16, 0xf, 0x6, 0x32, 0xe, 0x1, 0x17},
+	{760000000, 0x7e, 0xaa, 0x1, 0x9, 0x15, 0xf, 0x6, 0x33, 0xe, 0x1, 0x17},
+	{770000000, 0x80, 0x55, 0x1, 0x9, 0x15, 0x10, 0x6, 0x34, 0xf, 0x1, 0x18},
+	{780000000, 0x82, 0x0, 0x1, 0x9, 0x16, 0x10, 0x6, 0x35, 0xf, 0x1, 0x18,},
+	{790000000, 0x83, 0xaa, 0x1, 0x9, 0x16, 0x10, 0x7, 0x34, 0xf, 0x1, 0x18},
+	{800000000, 0x85, 0x55, 0x1, 0x9, 0x17, 0x10, 0x7, 0x35, 0xf, 0x1, 0x18},
+	{810000000, 0x87, 0x0, 0x1, 0x9, 0x17, 0x10, 0x7, 0x36, 0xf, 0x1, 0x18},
+	{820000000, 0x88, 0xaa, 0x1, 0x9, 0x17, 0x10, 0x7, 0x37, 0xf, 0x1, 0x18},
+	{830000000, 0x8a, 0x55, 0x1, 0x9, 0x18, 0x10, 0x7, 0x37, 0xf, 0x1, 0x18},
+	{840000000, 0x8c, 0x0, 0x1, 0x9, 0x18, 0x11, 0x7, 0x38, 0x10, 0x1, 0x19},
+	{850000000, 0x8d, 0xaa, 0x1, 0xa, 0x17, 0x11, 0x7, 0x39, 0x10, 0x1, 0x19},
+	{860000000, 0x8f, 0x55, 0x1, 0xa, 0x18, 0x11, 0x7, 0x39, 0x10, 0x1, 0x19},
+	{870000000, 0x91, 0x0, 0x1, 0xa, 0x18, 0x11, 0x7, 0x3a, 0x10, 0x1, 0x19},
+	{880000000, 0x92, 0xaa, 0x1, 0xa, 0x18, 0x11, 0x7, 0x3b, 0x10, 0x1, 0x19},
+	{890000000, 0x94, 0x55, 0x1, 0xa, 0x19, 0x11, 0x7, 0x3c, 0x10, 0x1, 0x19},
+	{900000000, 0x96, 0x0, 0x1, 0xa, 0x19, 0x12, 0x8, 0x3c, 0x10, 0x1, 0x19},
+	{910000000, 0x97, 0xaa, 0x1, 0xa, 0x19, 0x12, 0x8, 0x3c, 0x11, 0x1, 0x1a},
+	{920000000, 0x99, 0x55, 0x1, 0xa, 0x1a, 0x12, 0x8, 0x3d, 0x11, 0x1, 0x1a},
+	{930000000, 0x9b, 0x0, 0x1, 0xa, 0x1a, 0x12, 0x8, 0x3e, 0x11, 0x1, 0x1a},
+	{940000000, 0x9c, 0xaa, 0x1, 0xb, 0x1a, 0x12, 0x8, 0x3e, 0x11, 0x1, 0x1a},
+	{950000000, 0x9e, 0x55, 0x1, 0xb, 0x1a, 0x12, 0x8, 0x3f, 0x11, 0x1, 0x1a},
+	{960000000, 0xa0, 0x0, 0x1, 0xb, 0x1a, 0x12, 0x8, 0x40, 0x11, 0x1, 0x1a},
+	{970000000, 0xa1, 0xaa, 0x1, 0xb, 0x1b, 0x13, 0x8, 0x41, 0x12, 0x1, 0x1b},
+	{980000000, 0xa3, 0x55, 0x1, 0xb, 0x1b, 0x13, 0x8, 0x42, 0x12, 0x1, 0x1b},
+	{990000000, 0xa5, 0x0, 0x1, 0xb, 0x1b, 0x13, 0x8, 0x42, 0x12, 0x1, 0x1b},
+	{1000000000, 0xa6, 0xaa, 0x1, 0xb, 0x1c, 0x13, 0x9, 0x42, 0x12, 0x1, 0x1b},
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
+	struct phy *phy;
+	const struct stf_dphy_info *info;
+};
+
+static u32 stf_dphy_get_config_index(u32 bitrate)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(reg_configs); i++) {
+		if (reg_configs[i].bitrate == bitrate)
+			return i;
+	}
+
+	return 0;
+}
+
+static void stf_dphy_hw_reset(struct stf_dphy *dphy, int assert)
+{
+	int rc;
+	u32 status = 0;
+
+	writel(FIELD_PREP(STF_DPHY_RESETB, assert),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
+
+	if (assert) {
+		rc = readl_poll_timeout_atomic(dphy->topsys +
+					       STF_DPHY_APBIFSAIF_SYSCFG(8),
+					       status,
+					       !(FIELD_GET(STF_DPHY_RGS_CDTX_PLL_UNLOCK, status)),
+					       STF_DPHY_HW_DELAY_US, STF_DPHY_HW_TIMEOUT_US);
+		if (rc)
+			dev_err(dphy->dev, "MIPI dphy-tx # PLL Locked\n");
+	}
+}
+
+static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	const struct stf_dphy_info *info = dphy->info;
+	const struct stf_dphy_config *p = reg_configs;
+	unsigned long alignment  = STF_DPHY_BITRATE_ALIGN;
+	u32 bitrate = opts->mipi_dphy.hs_clk_rate;
+	u32 i = stf_dphy_get_config_index(bitrate);
+	u32 tmp;
+
+	if (bitrate % alignment)
+		bitrate += alignment - (bitrate % alignment);
+
+	tmp = readl(dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
+	tmp &= ~STF_DPHY_REFCLK_IN_SEL;
+	tmp |= FIELD_PREP(STF_DPHY_REFCLK_IN_SEL, STF_DPHY_REFCLK_12M);
+	writel(tmp, dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
+
+	writel(FIELD_PREP(STF_DPHY_RG_CDTX_L0N_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L0P_HSTX_RES, 0x10),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(8));
+
+	writel(FIELD_PREP(STF_DPHY_RG_CDTX_L0N_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L2N_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L3N_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L1P_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L2P_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L3P_HSTX_RES, 0x10),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(12));
+
+	writel(FIELD_PREP(STF_DPHY_RG_CDTX_L4N_HSTX_RES, 0x10) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_L4P_HSTX_RES, 0x10),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(16));
+
+	/* Lane setting */
+	writel(FIELD_PREP(STF_DPHY_AON_POWER_READY_N,
+			  STF_DPHY_AON_POWER_READY_N_ACTIVE) |
+	       FIELD_PREP(STF_DPHY_CFG_L0_SWAP_SEL, info->maps[0]) |
+	       FIELD_PREP(STF_DPHY_CFG_L1_SWAP_SEL, info->maps[1]) |
+	       FIELD_PREP(STF_DPHY_CFG_L2_SWAP_SEL, info->maps[2]) |
+	       FIELD_PREP(STF_DPHY_CFG_L3_SWAP_SEL, info->maps[3]) |
+	       FIELD_PREP(STF_DPHY_CFG_L4_SWAP_SEL, info->maps[4]),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(0));
+
+	/* PLL setting */
+	writel(FIELD_PREP(STF_DPHY_RG_CDTX_PLL_SSC_EN, 0x0),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(28));
+
+	writel(FIELD_PREP(STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN, 0x1) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_PLL_FM_EN, 0x1) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_PLL_PRE_DIV, 0x0) |
+	       FIELD_PREP(STF_DPHY_RG_CDTX_PLL_FBK_INT, p[i].pll_fbk_int),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(24));
+
+	writel(FIELD_PREP(STF_DPHY_RG_CDTX_PLL_FBK_FRA,
+			  STF_DPHY_LSHIFT_16(p[i].pll_fbk_fra_val) |
+			  STF_DPHY_LSHIFT_8(p[i].pll_fbk_fra_val) |
+			  p[i].pll_fbk_fra_val),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(20));
+
+	writel(FIELD_PREP(STF_DPHY_RG_EXTD_CYCLE_SEL, p[i].extd_cycle_sel),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(40));
+
+	writel(FIELD_PREP(STF_DPHY_RG_DLANE_HS_PRE_TIME,  p[i].dlane_hs_pre_time) |
+	       FIELD_PREP(STF_DPHY_RG_DLANE_HS_ZERO_TIME, p[i].dlane_hs_zero_time) |
+	       FIELD_PREP(STF_DPHY_RG_DLANE_HS_TRAIL_TIME, p[i].dlane_hs_trail_time) |
+	       FIELD_PREP(STF_DPHY_RG_CLANE_HS_ZERO_TIME, p[i].clane_hs_zero_time),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(36));
+
+	writel(FIELD_PREP(STF_DPHY_RG_CLANE_HS_PRE_TIME,  p[i].clane_hs_pre_time) |
+	       FIELD_PREP(STF_DPHY_RG_CLANE_HS_TRAIL_TIME, p[i].clane_hs_trail_time) |
+	       FIELD_PREP(STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME, p[i].clane_hs_clk_pre_time) |
+	       FIELD_PREP(STF_DPHY_RG_CLANE_HS_CLK_POST_TIME, p[i].clane_hs_clk_post_time),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(32));
+
+	return 0;
+}
+
+static int stf_dphy_init(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+
+	stf_dphy_hw_reset(dphy, 1);
+
+	writel(FIELD_PREP(STF_DPHY_SCFG_PPI_C_READY_SEL, 0) |
+	       FIELD_PREP(STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL, 0),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(48));
+
+	writel(FIELD_PREP(STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME, 0x30),
+	       dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(44));
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
+	stf_dphy_hw_reset(dphy, 0);
+
+	return 0;
+}
+
+static int stf_dphy_power_on(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+
+	return pm_runtime_resume_and_get(dphy->dev);
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
+	return pm_runtime_put_sync(dphy->dev);
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


