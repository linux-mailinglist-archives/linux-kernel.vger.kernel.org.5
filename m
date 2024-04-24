Return-Path: <linux-kernel+bounces-156528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F38B03F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856771C231F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F815885C;
	Wed, 24 Apr 2024 08:13:46 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839D1586CD;
	Wed, 24 Apr 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946426; cv=fail; b=CUmLmMZvWDif2xfRKcSf6wfveU24QCkw5LjcrLF1VckDDagtzzyYmjNOr88Dqat+1nVKlDs54kUdO28BisWlY+tEGc70R748MyIlsj7d0hrsqSRqp26SxDCHs709oj4F/xY18Ll0+f75B3laXRcjqtURAp4dTXEylnxkZXqF2z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946426; c=relaxed/simple;
	bh=5d2+winPr1qWSQSgklak+E67WUuDKl54a/7JQuYj1iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3k2sJac56cr2+P/wLJdUe8ZNh5mvBEWLhZKeqirMJCYdvoFabWpqx4FWDfsftYUvA35HBSbQY+OtTFI2pQgv2quJy60OdbfsVAVZPLrpqJBIVVlaCc4HiXWBxktvgzYiY5Rimq7LwTxsQaL9vTz6vx1rflqqSDTiGm3aTTI5Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGpAzmAxaVzMlcbMqcf6O53ZbXME7AL6jrC3J3MRBTsQ11U35bN/n7Zbysxegv+X+SbztpePFyDWcBEUF2OezlYLvKwDpe+rmCWaKH0ElFar7YU1pNCdL9lcPtZ09DBVIAYvBuYCeaoLu04ZUvqc7wGV1rJWFc1Zf+MiZaVUN1RRHdqhj9sgxO8UIenJ/tB0SErYzdGQ79DBnRE2yl4h3+iwn1xHE76Gd8mHhuKD9DJcYPCvj5jUvFEIiI10Z3JBg7eUFN6Jg2lr797uTOAwLw3IUz7LFYOY6iyF7fUIMK7+j6NUZTZKQ5lFK6g37S4x34BZAXIUfbJP/Pu8fakr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNtDg60wNrrjdhIVYCSsKiN5ruLjPoYQcVIa7XLQcc0=;
 b=ZQStBNWOv7c74ABS4KH/UQLA4TZzqA53iXy97rxsL1LiTCJx6fvxUZbrTjWbKZhp/9pzeFvEE6Tui8T8SlH33upyX8HiGydLq7A3mdLqozJGUal0Di2qP4L9bYB9CXAXX/gcsZLRBbQ9SahNsHp6tnDm8kkrvV3TzoJXTjsODCFWC2tu/z9TEXm/v1V+C7vNeQYSntZFU26IdzycAFWyYPS9OLRUEdjfWwbgNrIsHXZNlxRm0liXZJIpzp00L6BMl/kdK6yNtb1ebsfbORv67R5qar/JJtfrUWbnpaOItKPV7bT6rmP8A39E4Y5lsdaN9bQO+Lg7IB39lRLkbbh9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0460.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Wed, 24 Apr
 2024 07:59:19 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:59:19 +0000
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
Subject: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for StarFive JH8100
Date: Wed, 24 Apr 2024 15:58:55 +0800
Message-Id: <20240424075856.145850-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::15) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0460:EE_
X-MS-Office365-Filtering-Correlation-Id: a7443985-e42e-4d9c-167a-08dc643471fe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lEYMvYyZsbKSH215i1rdV5bBVzrqiQqL1AApvkWZuITcxoTmQJdBR0/9F0F8wqDfz/7gdNScrLEA13rYf4p/avXmedAX7LP81rf9rE/lWQfuiIejPjP3fl5vv5nFGiMhf9V+7e3g4nAi8StHb9j9qpSMPUAr8fzCemgE4VPwnEmr1ppm6GHil+C+BrLDaLDAD3In02xHNdXMPqQfzlnB9/L6JvIotSH8RvqWmA3A2QRFjCF4VWOW8BRY1uC2G2PwTCjfD9Dq42+8bhAcRUsPMwwGULpu6OixGMPO8/oE+Ed6CXq0G0utWLqH+LoIXeEv8++fC7i6wuinb02kI4wrqe95m5s4jFFW7slfeO7RcGImtIR1eVaX9Nx0ke4CzCbQbKYaVeTJfHYZiY/3NmN59P6hcXyu/pkhdo66uDUiqSHP6Q0pD1M3p9SeY6l15CGNIoJ3SUuA6f5DHeyUXnomgM2zP10ZVibL55+d3yS1vPp7K16NF7cGLuSo3u4vzmD9+lo35fGg5FVjq6MPmCvxtXSO6cQrGL9dmMevM1GiDNpMkm6cnwOXMCctmr75w+cpKzKcrVf2cldagzQ4V26ULls9E9f/CzQzqRyzRYsI8DaBp06eMRjMHLEiDhm5YwLuB43EW1wXipp4+Hpp7P3fAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(41320700004)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAOkKnBvMHrFFb63gtYFdY8chgiSH635rQ1TX77y+wjpt1mAeUkCSs1q09EB?=
 =?us-ascii?Q?nSfqk5niNhIA3D/wb25cQ4iuRvJTsrpEZpWtbTHqxjdRxyxqYfzsHeGBm9Vk?=
 =?us-ascii?Q?QLz1ebHsgVwmDHokUaoIeOmyqdW5gbRNzoAw2ElGIU3Jky9jmHiT7wbC5CWn?=
 =?us-ascii?Q?PD0ZRDcMJgnDHewRYhJ+LAx6RLM9FxFUBvXcG8wnVkg/B7o3ormWa+3sMS69?=
 =?us-ascii?Q?6mWI6An/p01g6Fi0bN38lZY7l/ZG4OHFZgN8LyCQEniS3NlqtShKMOalZVNv?=
 =?us-ascii?Q?jroflBX1tzP7vERDeYBUXrjK00Y2VIpJT6sgFC+tP+MiO8XK8B7nYN8obaBq?=
 =?us-ascii?Q?HkAUSGMpFhKDAtGtaYd7NQMgeV2w+95F+9BOHySWyaI3x4k/iZfLZ979qYBB?=
 =?us-ascii?Q?IP1l8HBxujc0/d97U0vr2o6V55W9T3j8c0+aVHrEkv6WPdpM9iHWM0FhE6g1?=
 =?us-ascii?Q?VIh3Oy3O0kbjvDvJBt92gG3nIKfiSLIQq9fTUowLftUhgxNlScai4nIqtoKW?=
 =?us-ascii?Q?/ZBDS4Q19m9LUNJ9PAceFfpvpPu5727DDZouLc46JcxinU0zdOc+Bx85Y021?=
 =?us-ascii?Q?1jXwEDPYYTNucH/J+9e13+sITkzwekDpKzB7K8D7v7pnxuIaxcMvM8yJZ709?=
 =?us-ascii?Q?gYAikpY0wz0jV52SoVQlryl231eP40DhO+8d5IKwDkcJMfCz8T7z8Z8rpsXA?=
 =?us-ascii?Q?h9uA2klPwflcPUUClKJFcwVPbLz4KWdQelkCvNEhzIqsJLs1WBwtHf46UuXA?=
 =?us-ascii?Q?k/aa5XHooMGOZvM0RHhscFPhf3mqRXrayhetGvy/aK4AEKrMcm1ZzHXQ/ERm?=
 =?us-ascii?Q?Ft+0IStd/JkhfRz8stKyST5OvjApA5As2F8G7zrb5koxDHgiAjwDHmYi6gyU?=
 =?us-ascii?Q?eUSC6oVcm6VItm8k3LJW+/9ZDEdwYoH5nePt5EVyqLaq4ZFVvYbEu172i3RL?=
 =?us-ascii?Q?61NgmD9kKp46S7zQfbf286P3Igh/AsY4LwjtXIzz1DcMnJl6omA8QYvRU8xh?=
 =?us-ascii?Q?Wo9tfHAm+/Ds688JJWnIMTe10+j85qPx7Hmatt80xlsPbbd6K4o8LQew77f8?=
 =?us-ascii?Q?keBZOsuCVq9s91j5FI7/+0QPF9aBMYhRN3y43TtYF+PB3zxmpl6/IhKDwvc+?=
 =?us-ascii?Q?lI/KfkrqmXELyiRQMkOsY458rjr8rEjY2+VBRBRyAqYsUhWr/5NrJZnK7PyF?=
 =?us-ascii?Q?hddHJrI6eGzhGI/F9V8uAGvACKUB2kJUzzpDOGp/5KbPw63J+02v8Po/HTf6?=
 =?us-ascii?Q?ZX5gh8Usij5KerY1MQOUF/QuKltnYqENO2akZAl6Fg/INejvb9DFpIucA6ZU?=
 =?us-ascii?Q?w6C/vGb5Oyf9o/GRaHirt6qqhjRj0OOml1++5Ez73t4/T+DKqvwLd52UejsZ?=
 =?us-ascii?Q?oS1TjaZEIzkxxVk4SrrR9R0uB/YtU/954ea86DwV4MUWyAd18Thyshduspoc?=
 =?us-ascii?Q?V/hTLCNYj0Bii7a1smpQJOqwTmbb4bKXMAC4b/K2o1CNaJeUIO6nj+uUwsao?=
 =?us-ascii?Q?v9edd/QO9hyUG1qJSN1BJXyn3fQLKwI2pIXlWWJlD62QjuKeMakzHYk6OPeC?=
 =?us-ascii?Q?s/R3BTKJkc0SaY1Yy//grMRy6FO4z/OG/ibAlQUr+atdc9xhFXZgC7J43rOj?=
 =?us-ascii?Q?hvo5KjdCyAg7yjJoZMuUQGI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7443985-e42e-4d9c-167a-08dc643471fe
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:59:19.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2vFHAnfuZhQ0V9pnQ7jJ1ju28cKjiaMX0x21p4yGhdgj49iv2qjRhPU+VmX/6v5roUPtynsAvvtAhT9Gw0RqqhIYFMazV97jHeuECUj21Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0460

Add StarFive Starlink cache management driver for
JH8100 SoC. This driver enables RISC-V
non-standard cache operation on JH8100 that does
not support Zicbom extension instructions.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cache/Kconfig                   |   9 ++
 drivers/cache/Makefile                  |   5 +-
 drivers/cache/starfive_starlink_cache.c | 135 ++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cache/starfive_starlink_cache.c

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 9345ce4976d7..9181cd391f53 100644
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
+	  Support for the StarLink cache controller on StarFive platforms.
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
index 000000000000..2f1fa6a923ee
--- /dev/null
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -0,0 +1,135 @@
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
+struct starlink_cache_priv {
+	void __iomem *base_addr;
+};
+
+static struct starlink_cache_priv starlink_cache_priv;
+
+static void starlink_cache_flush_complete(void)
+{
+	volatile void __iomem *ctl = starlink_cache_priv.base_addr +
+				     STARLINK_CACHE_FLUSH_CTL;
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
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_CTL);
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
+	u32 block_size = 0;
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
+	starlink_cache_priv.base_addr = of_iomap(np, 0);
+	if (!starlink_cache_priv.base_addr)
+		return -ENOMEM;
+
+	riscv_cbom_block_size = block_size;
+	riscv_noncoherent_supported();
+	riscv_noncoherent_register_cache_ops(&starlink_cache_ops);
+
+	return 0;
+}
+early_initcall(starlink_cache_init);
-- 
2.25.1


