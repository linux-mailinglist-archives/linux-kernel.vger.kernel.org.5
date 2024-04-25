Return-Path: <linux-kernel+bounces-158582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4218B2270
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6AC1F276C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E19149C67;
	Thu, 25 Apr 2024 13:22:34 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7D1494BC;
	Thu, 25 Apr 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051354; cv=fail; b=RRSvXL/NY2tOvD8leeoDHT3b5VYALI395KrNXVwYIGNEQDvaeBOW3jtA7YngV2AmZciAbgPf8ss5UXnlf22O+csgTnMrSvdUywiIZ5PQ/9U78UsOxVEidI6oL2gwZOzmPSwdou1klw46UuXtjUrQLegLzzUr4kR0d8jWtzfx8oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051354; c=relaxed/simple;
	bh=dqpdNn8e5dE+oDPVp/j0zgsWIN7gUaoVzdh/8/uhReI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e1TGCo6bwcOIHBGPRCEmEzyufCmDyLdaPR0dm78Decm61i6o0+dIlKQe+nNWXlh7wtlrmRKzYpayUhI1QX4FH2DYUpGnjXDxlwEpya2zbZoUAssAMsmJgb7zHRgUebbK4y+6n5cp2COwmc/sFidw02anaQSvD+TIDv61tstLdxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjmCuDrFLzG3g5q+Lw1DhrpnMFcYqWfZVSV8SUixoW2BWfoKq4bMvqCnbW0J3dqdgMmmOeaG056SCayy9jn9JStbtv7xsvALDNse+Ps5Wr/TmIzBuGf+I2ISSRFjklG5KfxwhzkyWyZYQ3kgigkh0wGXvgz1ZtzGgbYheeMFuHRdbO2ZVltNT1aNZBc+WWGNRP1X2SAVIWdcI3syfs1RvSac5PSdAU+DV1FA8m00W7Qxg6SpitXDm09fwSCmdfDYSQdQqQqGB+dM3JY2P0nhVl8Yg6pQOhacKIRvnoaFwVDz1mwS/YDvhjWeve9zkKiqRP5lBuGtDJDIoYTMPcJxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eevb188hiDYHB6pL10t94LTiewvQ4+f2VyfERGf4yH8=;
 b=mWPXvdBDR458mkTAJ1kuh4pD6YZIeX3bWpwJYwFXmlchaIF64lWjBsGUDL1UtW82UkU3e9d5v6BCBEpA5hXPtBtM7BwgHlxyXzaobTHtq2OqRoIm0Q3nolg03ASetqdtW157vtidLVuaTPcM58koI7vIy36E3RT7nCcTEGr3zAuxyOf/dMcTnS93oWaxV7mEOYZblHUoRXuUsGeKt3/zmY6tRm9cAYsz5cOj8sH9fdSiPjXkG0g7y2fB9RpXTv6sU2rbmiUlCZ0mlsdnuIyVFW1XD7PUdZ5MbaNITgwDi4v7BrtllKkmL0OF1TtXvrPCU38TF+EaZUWE5TR7nD3ilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 10:49:04 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 10:49:04 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/2] cache: Add StarFive StarLink cache management
Date: Thu, 25 Apr 2024 18:48:40 +0800
Message-Id: <20240425104841.72379-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425104841.72379-1-joshua.yeong@starfivetech.com>
References: <20240425104841.72379-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::19) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0491:EE_
X-MS-Office365-Filtering-Correlation-Id: eb29ef21-1597-4519-b8eb-08dc6515533e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W2VdQJqfDgtITfKR60ptY7RgXg0Hx3IfwC3v9/U+mC0ZmabdJ/bE1yh8LR20fCccZqZWgUjnYzH+GoAsKtZzPZ9wfF6u4bNiXpSdBim+mnPmzL7WU/NXwB9To8weCBHKlS7OHO+NgCDJQVFqre9NvbmfcB7QOgNBkgRc75t+TIWjZFcKph+WC6wXEBqxkXtZM3PR2IQfJou/CyjT3mtIBcaNk4JD15qGj7JlheZlaXCkmPwFZL7giZsxF9IGv1/PEWJET89cvwEAL+sch39z3AKXTZLdW5Ev+NFJm+VsQXef2lIegkd9fKPOCQ9C8kUL+NRalrn1c3U66lGQNFifQ3R28CO8ZnL+HtR4sTWmNq4uQktFqxl7H/OOrnRA1Jxej2sHTNARkgqh/5J43icnCeY+/f0uX7hvsuRKs4cVSOiq8E6qa4h4VBcVxW/AGMO5pKXsGRuLjF3ekU1BUbH0fzNAf3SY123wlxfLunbJ6BN0+1koQd15JnKxhZlPlWh9uDygzvUKz8wO1tcVEqHpp+TGsD3k+c89O++GRTFifUnDU947sKPaQQ8OWhftoSx2yxvwT+k9gywnPNVZnbNGlTkOjJtuzOO6i43vUoBIuqqL93AZVFVjzt+5m12k7Nz1Np7HfRknAyOyfhdJAI9GHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(41320700004)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oz8FwwMPq3wm1OeJjlMoYiKJ67lDvK3ssbrXivMqHKEarUbcZCREsF7ZSEUM?=
 =?us-ascii?Q?W1lh72QYnYmjN5ER6F+ypzbPdTz4SvEpzVuQKDa08Q0jSSDFaUZofXjP+Kh4?=
 =?us-ascii?Q?LS7ecIAS3n3kOHvEX4725fbuA3aP0UiNQpCJB/ayoHW8m21zDQ3J7wOr9goo?=
 =?us-ascii?Q?Bd/kLgd7fKyvbgkdY0HrmnUNH1ri83amxlDLp0JnjzAMbNHaeI+yF7E2GTYy?=
 =?us-ascii?Q?Gpil03AFLMvnFB+VfyZATYnn2K1j7iKHhvu1wS0IMQdmoBr/+AViJ9AS1RL/?=
 =?us-ascii?Q?QDFJ1zTGuSxuYJXsrWUzNOihtXqJtMYO1w9oUt2PJuZ9uDGmeb07Q2J6dZvH?=
 =?us-ascii?Q?UOXiw6BLR7KMcKx7fY+ypfrVtprrMgE0NkZShRrnIeGArls6yIG49aRPWkVN?=
 =?us-ascii?Q?rI0fZBF7+Zv2ZYjYERah0kTb4w8WWEwzHDanmHpeG0lc5kZ7yuhwVIvav8TT?=
 =?us-ascii?Q?rEgPi8V3xb5A6Pj8qLQxjHkE4JdY3e5O42Has0+/cvEtqNOcl3fKV3VNdZUh?=
 =?us-ascii?Q?fMUGeD1OQJN37J9dbiuU5akSUfT7njtVko55KVLYtxDona7AcmM9I6bfGsR2?=
 =?us-ascii?Q?f3jLRg5WYH6Lz5WmUa3JEBmhTBu46DqhTztrS8nlWpStPZ4/oO3zgyp/m43G?=
 =?us-ascii?Q?oMSzw8H/z62HbHurfWcXkdRlVFLKn2BoSld+Lm0xKNS25l72n+R+b2g6XHwA?=
 =?us-ascii?Q?sWmxjF009FOrWesOhIgjko3MEAfehaMEfGzQuKQALUWJjeA9zgTxue8AuyD3?=
 =?us-ascii?Q?SuI+lRsB0mFVnkZngTPQ/sMmHVEPGeeS7Hx8YPQXBiljVAMKJp7veqRGKBo/?=
 =?us-ascii?Q?rl3LFu5oZVbrLUB30XgummYdW3gESYqUxulEi+jafaXcgy5/EIS4e7X1B37p?=
 =?us-ascii?Q?YvPlCRyTHJNgw9yD/67GcAPwxcTUraHuCgzP5Ti1Pzo58GO9J66zAS+6ijdL?=
 =?us-ascii?Q?y/+dtQZlpcM4rbnzVrHaAyMYTvDpNVrzTxa1OmvKBYIH3mCq6tl1+XmO5As4?=
 =?us-ascii?Q?qViwesjgn2/En/V9oZ5b2AlSm7SRRRypTHeBsH0h1ZFyavye6rXkygyspGCP?=
 =?us-ascii?Q?CGHKUQAdyLK71HAf3VQQFByBrIzN59Sh1m6036H4QhP2SifgiiYelGYO0CMz?=
 =?us-ascii?Q?Svwr6ZiexUxPUQf/tORn5b3MsivYooh5aT90UULyumxH0dtxN5KOAKIzrf4z?=
 =?us-ascii?Q?8aaNXD4Rq4ZgMWbTJkjk86NwDwtotZhyYmipx3vKbBMktSkE/QnkgB6Zo2AW?=
 =?us-ascii?Q?TniHW0t0klbIWcF1fThW1ByhVCA/HiE1OqveH0nVXjnTR7B7rXQ2fhQJl2OG?=
 =?us-ascii?Q?VbMuTb8W8aLyzQFJwz0doaM/N0hivJCer0rliVsNqtCmSTwQ0NdHRPsK/+85?=
 =?us-ascii?Q?suuTfCYExHzv/27ziKmvl06c8ffv45utrMa1PficPaMyR/Z2rHf6w86kMjmA?=
 =?us-ascii?Q?mGn4Mce/Ujk+5ew81eIgb1ByO50UW7HRW9eb7Irnz6XEcA7YxRaDOf136jcr?=
 =?us-ascii?Q?OXG4WNKP5HyFgWiTtJko3gNJB/ooLDHNW8Hf8h2kKRSvUZfmuZQN1TSkKMMY?=
 =?us-ascii?Q?1ekAQ2Arhvq2CoGm9pkJdP63SSWtxMsf5gNe4LGFil8LBVZ9HzBaeuLbQRpD?=
 =?us-ascii?Q?UQlepTvXLcE4N+zMamJKNmw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb29ef21-1597-4519-b8eb-08dc6515533e
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:49:04.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufqo4WDviBmQ7WuilaE+3mvW/17r5B0pl1XP07J4SLvls3LEmwKLdi3z5OM5eneZNIkLY673hzVhx6Au7Pai6P1U4sxuKD+rLChrO1Bgbz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0491

Add StarFive Starlink cache management driver.
The driver enables RISC-V non-standard cache
operation on SoC that does not support Zicbom
extension instructions.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cache/Kconfig                   |   9 ++
 drivers/cache/Makefile                  |   5 +-
 drivers/cache/starfive_starlink_cache.c | 130 ++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cache/starfive_starlink_cache.c

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 9345ce4976d7..94abd8f632a7 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -14,4 +14,13 @@ config SIFIVE_CCACHE
 	help
 	  Support for the composable cache controller on SiFive platforms.
 
+config STARFIVE_STARLINK_CACHE
+	bool "StarFive StarLink Cache controller"
+	depends on RISCV
+	depends on ARCH_STARFIVE
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
+	help
+	  Support for the StarLink cache controller IP from StarFive.
+
 endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 7657cff3bd6c..55c5e851034d 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_AX45MP_L2_CACHE)	+= ax45mp_cache.o
-obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
+obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
+obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
+obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
new file mode 100644
index 000000000000..24c7d078ca22
--- /dev/null
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Management Operations for StarFive's Starlink cache controller
+ *
+ * Copyright (C) 2024 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Author: Joshua Yeong <joshua.yeong@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cacheflush.h>
+#include <linux/iopoll.h>
+#include <linux/of_address.h>
+
+#include <asm/dma-noncoherent.h>
+
+#define STARLINK_CACHE_FLUSH_START_ADDR			0x0
+#define STARLINK_CACHE_FLUSH_END_ADDR			0x8
+#define STARLINK_CACHE_FLUSH_CTL			0x10
+#define STARLINK_CACHE_ALIGN				0x40
+
+#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
+#define STARLINK_CACHE_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
+#define STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK		BIT(0)
+
+#define STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE	0
+#define STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE	1
+#define STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED		2
+#define STARLINK_CACHE_FLUSH_POLL_DELAY_US		1
+#define STARLINK_CACHE_FLUSH_TIMEOUT_US			5000000
+
+static void __iomem *starlink_cache_base;
+
+static void starlink_cache_flush_complete(void)
+{
+	volatile void __iomem *ctl = starlink_cache_base + STARLINK_CACHE_FLUSH_CTL;
+	u64 v;
+	int ret;
+
+	ret = readq_poll_timeout_atomic(ctl, v, !(v & STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK),
+					STARLINK_CACHE_FLUSH_POLL_DELAY_US,
+					STARLINK_CACHE_FLUSH_TIMEOUT_US);
+	if (ret)
+		WARN(1, "StarFive Starlink cache flush operation timeout\n");
+}
+
+static void starlink_cache_dma_cache_wback(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static const struct riscv_nonstd_cache_ops starlink_cache_ops = {
+	.wback = &starlink_cache_dma_cache_wback,
+	.inv = &starlink_cache_dma_cache_invalidate,
+	.wback_inv = &starlink_cache_dma_cache_wback_inv,
+};
+
+static const struct of_device_id starlink_cache_ids[] = {
+	{ .compatible = "starfive,jh8100-starlink-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init starlink_cache_init(void)
+{
+	struct device_node *np;
+	u32 block_size;
+	int ret;
+
+	np = of_find_matching_node(NULL, starlink_cache_ids);
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	ret = of_property_read_u32(np, "cache-block-size", &block_size);
+	if (ret)
+		return ret;
+
+	if (block_size % STARLINK_CACHE_ALIGN)
+		return -EINVAL;
+
+	starlink_cache_base = of_iomap(np, 0);
+	if (!starlink_cache_base)
+		return -ENOMEM;
+
+	riscv_cbom_block_size = block_size;
+	riscv_noncoherent_supported();
+	riscv_noncoherent_register_cache_ops(&starlink_cache_ops);
+
+	return 0;
+}
+arch_initcall(starlink_cache_init);
-- 
2.25.1


