Return-Path: <linux-kernel+bounces-102938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F0887B8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFAA1C232AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F75CDDB;
	Thu, 14 Mar 2024 07:46:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227355D724;
	Thu, 14 Mar 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402384; cv=fail; b=N5eUPw8sdBEU8OxknsFywZ3jFG1fftGjgoqdrO1H9IB3FrPE9Ac9Z/RcEb0JgzU1TrTIqgNDFRNKMi54GvgxHTqZxBqsrIhZWymggK7TdfMNuvlAXtmSjPe6xM7EVz799KGJDcyJpvl68H6HiWWz9Q97xGt0p3ZnHPCwEapfdJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402384; c=relaxed/simple;
	bh=PoksSSO/4MjT5LKsifIJUmpo/IyjFGk/uo0lmuWTbrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqidItVHfgSbqPRCESz2qtAFDpB3yseSBdJIPrWDuyVAMNFiPmWyIF/EgWKHWqGTkFsHv/YV/gijXiorewvrM6iiYJbxS2+8Ga4Rs0184mlL4ykA7MTPUtVYelKJ+Sb79uEWhHwxmsPFdtuovqV4I35a6Xyo9BhPHbeQqsUw0Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFJSdJ7QnYniOG72gxZIHB42G7zRBU2+mrBpx907gB1X31cwz3FN0nQXlzjUPNMEManLklAycLVcoyE+r0gLw3uOukMX470nivKKCbKNfxgbK+owp+6I6Jy9yHlD2cMu/5azb2Kw1ANiqCQYYNJbIENNq+bXouDGWEuZ1Q8vJRa+YgfJKsvgp0cuBMFxCj2bFJco7CN15McpMhQ9J1p6xgmIi10TMZUj6uXCGt8vmKweSkylyp3FQu2UHTUJd61wBJOwUOs9m9SWnqYPHWf/OHtjzUandyS5OcWZ9xmOSGfu/5q2cCKWJAbb+4jv+OZlj6c2iyye2w+dpwOSawU5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G1Nz9ycT1DhhUUC4iDrZWbhROgmt3+O2Ya8UuFhLbQ=;
 b=oWGOeu2DApaZt0jeasWRa6Sc/y/DpoqBu4P/Fz13fo5SUJFigEpNbI8+6qM54i/GQCCOhCJpJvv4OXjzD2g65ncfO1N3kA4ePVBFm30KxXo/acl2i4kvrWs/Ew6Kc9xIzLxleeafygToruI9MsoO9EuXc6HMwKMh0wI/YMOwBsAZ+qh0Wba2wTJRRwc/0f80iUoc3iRW1eZq9osKOgP+WXpqV6Z7eDWX8Bs8MHOJum97zUiK+Qjsv3qzkAuBWdKZOxoZwyYTXGKxWDRjygr3QqLaQf3s/XNtbqnRFMhJbTXTasvn5YwG8eYqzgwIJtAxFRQ9Fs3vn4P94OFiU53THg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0711.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Thu, 14 Mar
 2024 06:12:35 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::a038:3f49:b470:9207]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::a038:3f49:b470:9207%4])
 with mapi id 15.20.7386.017; Thu, 14 Mar 2024 06:12:35 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	geert+renesas@glider.be,
	joshua.yeong@starfivetech.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	conor.dooley@microchip.com,
	alexghiti@rivosinc.com,
	evan@rivosinc.com,
	ajones@ventanamicro.com,
	heiko@sntech.de,
	guoren@kernel.org,
	uwu@icenowy.me,
	jszhang@kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/4] cache: Add StarLink-500 cache management for StarFive  JH8100 RISC-V core
Date: Thu, 14 Mar 2024 14:12:04 +0800
Message-Id: <20240314061205.26143-4-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::9) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0711:EE_
X-MS-Office365-Filtering-Correlation-Id: c22cd1d8-7982-474f-1b5c-08dc43edbe13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pzr5/KKPqLVWDFMa8lhCke4KRUPCWIxvPXKF6GjC+dZYbwz/WNj8JteG3LiGoSfPp8T8qp5YEnp31SsntS3pGFSj4ipxg3f/ERAmtTfhclBUDZPnHNPyPsic9902UmFayYZKCvX/dToI9jsnwrATgnM0KAhMC8oy5xPeCM33I+5qlhxn5hu5SSxp+Q7cdoq4wps4a4iQWZg/Bw/By2vLUa7a1vV57Z6Rt7cayDD0FZttz1S1oDX4nmtTcHOiuwk8/71T26hRAdXJFAQgPqlEQDRlKbL5oUnEWFCjYX5ulH+WL39p2Z1jxsnUddkqxu8qIKP/2BYol+MW4Ih6Ts7+Ta0FXIzYllt6Z68bDnacr0zAF/V1mrbtCHN+d+lu1RE525uZIRYixJ9u2lScd8UAz0jiftKWJM9sxwwOCevm4qUJmFEMIama28LC5bHg6sdgrjRWxJNmyOm2COSatyXF+qxpMxi4hex56MNAMPpXTsa/h/iNkWRyEpD9/5b9LMQZicwblgf6NBo47z2zpbecZogJ3hane0/I1wq6C0FVhYq2ZzzJwa9t3A7mVni0ehXmHo6tBtx6m2Oqejw+duvYLSmi8gUj+li3yaLfTuNqpM94GezRGu+tSk7TATEtqybAf0H4QI9r1NHiyRuAHPyW9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(52116005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rjTv+dBV24qnAt/KcYWLMDsPV0lPx+GZBFxqJ6SAeXBjrVASZzdtzUAGPoo?=
 =?us-ascii?Q?piDERj87HGvoPhhKv8GiT1NeN8OOxp0qnPRktvLYCD73UKg0ktIBf8wkunHD?=
 =?us-ascii?Q?fxh+STQRsh7Hh1K4K+2Wc41nhvb1zNvg4VAd+G4EONlLmoceaNz6PVSeHDaq?=
 =?us-ascii?Q?hYF2ctLnAOdEx5ZNxR7edGI6j8N+JciS9tuWq8IK8pBUKxJgM4yY5AvczCBf?=
 =?us-ascii?Q?+3U07ydpYCVKvnPUqAxIvboUJY52udnFneQOV6NEPZubrrs75xnGJCNk/jxj?=
 =?us-ascii?Q?yGg755bAZUPXgW3UFC5aG0cDGyHTd0Q3VMv2VOF9uCjfUwrbMMrDudZ2pHix?=
 =?us-ascii?Q?MD2ZOW7DfNgcogePz0U84FtiYMUQw4J8pLC6xoqGkIdEmoYzC1iAaJA1xyo5?=
 =?us-ascii?Q?UzJ6IQ+TnBbvCF93T8C+3K4Yxdj9TEY7SYH5X2uD2U0a0ZPU6hNlwz7FWbAG?=
 =?us-ascii?Q?zo4Ifa3C59HJwr6fIUMp0aSl9lYPAagcIilJ6NB+F4c26RS511O2sOO1no1i?=
 =?us-ascii?Q?6R55KpbFkFUIYdyNK6w8J4pAowD9GiQ19MEON0aZXBW/bZtIP3oKlDz2hRTC?=
 =?us-ascii?Q?mcQVXL66SI0Nk9dbpK+TD7jTD+KxTrWOGV+T/4A/ihJ18Xo5K4rQ9jjcVHRd?=
 =?us-ascii?Q?fl74hhSYUfEtL0Muv44cptdgvTbfp95tYSziLpf5nV36o8GSElOmkvbjxgGN?=
 =?us-ascii?Q?WKIDSU/ELKQqwExWek20JVuM8+kJ4aXKKwRRhwfv/feLpRyX9fBeOzgkszwS?=
 =?us-ascii?Q?TfPNHrhem+Z4RuDvy7aIW8FIi1S9yC1UQNlVXyOXiA3Xq0ooanIo2oe2eLHb?=
 =?us-ascii?Q?l4LfRF0RW0qCsrs0uaQQxcAms6VkE90EmMpPACSHWQLxMLPzC2hkNxbK1bMa?=
 =?us-ascii?Q?TxhPKWRQnLLmcRg7Qk9rtkjR1uywh1t9Xo7PJUxWtayzO0Icy02WFXIH9uhW?=
 =?us-ascii?Q?k1DL6zvN3ym7wIr+kjYY0g5JyHD62iidq5cVLAcbMK1oNQVIsAREpBqIIskq?=
 =?us-ascii?Q?HDgGcTXPzrZPTHTs8Q65QKI5tD+eMCAhFI3F5J1oTqyHNoE5+SZcVSuqBkLm?=
 =?us-ascii?Q?sIIHPOpBEgb7AOtE3y1u1jgptA2VGqym4p35BkKlUtkmyvndXDJ6sYfLWKPx?=
 =?us-ascii?Q?AbB64N7P2DzousM7l+NZwsuskonDopHeGOoQ44pTKO+38lsSlDpdJNK7/83h?=
 =?us-ascii?Q?qj3wWj61kVT6jrjtSuOTnzpuY1RiUeOy77SOadQM8SpDLk82BeW/TwgBQWrI?=
 =?us-ascii?Q?L2U+IuKpe17hQs2RpagsuxENtIz7g1mpotvm2hBvprhZzpXIiW+pgqpLvelS?=
 =?us-ascii?Q?MKYgx4QLv/AlTF7kZURzroyqNWH8MqplpBsHrS7NGhnlU9eggMaap5KZHQue?=
 =?us-ascii?Q?JILbQUX0jWoeupddrsTrHTJyvj0+WGR/Gnz+voruVVwkM5P9tskRIpC8R9p3?=
 =?us-ascii?Q?noCCnTAHb88Y2LMkJFzteoOxWqeWhBQwRO9BzE8gj2RisBSKHsAz4QtaYd2x?=
 =?us-ascii?Q?1uiI8TX2soYZcI86idEkCfvMQqTw/6XSTvW0CC9RXpcA/nKRPyosGY03Yu5F?=
 =?us-ascii?Q?RbpnwB/rM6rrX4kLIxuCNlWnBZ33o++MzmTcyV55ah8W9Pl36QDR91Zh1stI?=
 =?us-ascii?Q?mh8CT7pPzZvTu98QfuwI7nE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22cd1d8-7982-474f-1b5c-08dc43edbe13
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:12:35.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIgb+5vRo/W3YVV8b3EpQqprnp5iwQPHaTlcEKsq4yQm44HOJ5HPVOSWfc4KvvTAinAom7WjG8VxE8NcpA2q59YDAomu3xW++AUVTuc6QO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0711

Add software workaround for StarFive StarLink-500
on JH8100 SoC for CMO extension instructions.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cache/Kconfig             |   9 ++
 drivers/cache/Makefile            |   1 +
 drivers/cache/starlink500_cache.c | 137 ++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/cache/starlink500_cache.c

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 9345ce4976d7..e215379f6a73 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -14,4 +14,13 @@ config SIFIVE_CCACHE
 	help
 	  Support for the composable cache controller on SiFive platforms.
 
+config STARLINK_500_CACHE
+	bool "StarLink-500 Cache controller"
+	depends on RISCV_DMA_NONCOHERENT
+	depends on ERRATA_STARFIVE
+	select RISCV_NONSTANDARD_CACHE_OPS
+	default y
+	help
+	  Support for the StarLink-500 cache controller on StarFive platforms.
+
 endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 7657cff3bd6c..c515eb5714ea 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_AX45MP_L2_CACHE)	+= ax45mp_cache.o
 obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
+obj-$(CONFIG_STARLINK_500_CACHE) += starlink500_cache.o
diff --git a/drivers/cache/starlink500_cache.c b/drivers/cache/starlink500_cache.c
new file mode 100644
index 000000000000..eaf8303cb086
--- /dev/null
+++ b/drivers/cache/starlink500_cache.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Non-coherent cache functions for StarFive's StarLink-500 cache controller
+ *
+ * Copyright (C) 2024 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Author: Joshua Yeong <joshua.yeong@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cacheflush.h>
+#include <linux/cacheinfo.h>
+#include <linux/delay.h>
+#include <linux/dma-direction.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/processor.h>
+
+#include <asm/dma-noncoherent.h>
+
+#define STARFIVE_SL500_CMO_FLUSH_START_ADDR		0x0
+#define STARFIVE_SL500_CMO_FLUSH_END_ADDR		0x8
+#define STARFIVE_SL500_CMO_FLUSH_CTL			0x10
+#define STARFIVE_SL500_CMO_CACHE_ALIGN			0x40
+
+#define STARFIVE_SL500_ADDRESS_RANGE_MASK		GENMASK(39, 0)
+#define STARFIVE_SL500_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
+#define STARFIVE_SL500_FLUSH_CTL_ENABLE_MASK		BIT(0)
+
+#define STARFIVE_SL500_FLUSH_CTL_CLEAN_INVALIDATE	0
+#define STARFIVE_SL500_FLUSH_CTL_MAKE_INVALIDATE	1
+#define STARFIVE_SL500_FLUSH_CTL_CLEAN_SHARED		2
+
+struct starfive_sl500_cache_priv {
+	void __iomem *base_addr;
+};
+
+static struct starfive_sl500_cache_priv starfive_sl500_cache_priv;
+
+static void starfive_sl500_cmo_flush_complete(void)
+{
+	ktime_t timeout;
+
+	volatile void __iomem *_ctl = starfive_sl500_cache_priv.base_addr +
+                                      STARFIVE_SL500_CMO_FLUSH_CTL;
+	timeout = ktime_add_ms(ktime_get(), 5000);
+
+	do {
+		if(!(ioread64(_ctl) & STARFIVE_SL500_FLUSH_CTL_ENABLE_MASK))
+			return;
+		msleep(50);
+	} while (ktime_before(ktime_get(), timeout));
+
+	pr_err("StarFive CMO operation timeout\n");
+	dump_stack();
+}
+
+void starfive_sl500_dma_cache_wback(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr + size),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARFIVE_SL500_FLUSH_CTL_MODE_MASK,
+	       STARFIVE_SL500_FLUSH_CTL_CLEAN_SHARED),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_CTL);
+
+	starfive_sl500_cmo_flush_complete();
+}
+
+void starfive_sl500_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr + size),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARFIVE_SL500_FLUSH_CTL_MODE_MASK,
+	       STARFIVE_SL500_FLUSH_CTL_MAKE_INVALIDATE),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_CTL);
+
+	starfive_sl500_cmo_flush_complete();
+}
+
+void starfive_sl500_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr + size),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARFIVE_SL500_FLUSH_CTL_MODE_MASK,
+	       STARFIVE_SL500_FLUSH_CTL_CLEAN_INVALIDATE),
+	       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_CTL);
+
+	starfive_sl500_cmo_flush_complete();
+}
+
+static const struct riscv_nonstd_cache_ops starfive_sl500_cmo_ops = {
+	.wback = &starfive_sl500_dma_cache_wback,
+	.inv = &starfive_sl500_dma_cache_invalidate,
+	.wback_inv = &starfive_sl500_dma_cache_wback_inv,
+};
+
+static const struct of_device_id starfive_sl500_cache_ids[] = {
+	{ .compatible = "starfive,starlink-500-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init starfive_sl500_cache_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int ret;
+
+	np = of_find_matching_node(NULL, starfive_sl500_cache_ids);
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+
+	starfive_sl500_cache_priv.base_addr = ioremap(res.start, resource_size(&res));
+	if (!starfive_sl500_cache_priv.base_addr)
+		return -ENOMEM;
+
+	riscv_noncoherent_register_cache_ops(&starfive_sl500_cmo_ops);
+
+	return 0;
+}
+early_initcall(starfive_sl500_cache_init);
-- 
2.25.1


