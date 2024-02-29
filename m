Return-Path: <linux-kernel+bounces-86246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B486C2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A08282223
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CD482C2;
	Thu, 29 Feb 2024 07:46:00 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FE50255;
	Thu, 29 Feb 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192759; cv=fail; b=pAS7idF5HQ8n/bZakg2F4KI/xZ9sv69gxETpS69v/WL0ccVScaUFJCU1MW1paxdwSHj0vaYSDiuv6KX2s5ROoBP4knQEE1vgVgRQW+dZsZemf6coXTH2TeHRLr5F1i8ECEDMX1XMV43DXk5wSVZkB6F/xeI1tH7J9tR1K+DODYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192759; c=relaxed/simple;
	bh=xpEKy3Rn/7hvdo/Vy32nqWCBlxFF2+XfXvqxzgkuXCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LybZs6AX1KdAW/qVTN3lrfnOH9o1o/umJN3vEhrO9rcGjd2qsZv9Y78V2oy3sYzTY/Cys+ozdUWu8zTblvPKPd2wgfeCRj248NU6+ENjd+I/mdYQlz1ZJjLbhg+hxAGws7LBiF0BzNKB3p7FGOTc+rzR4LJg6145fEl4OtMfrn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx4XP3Lw0LjvGnqUCeTZ6zyej8SQBf5Ny099tpYJ7f6f39CcwzDBLy0sysGqQmnk5Hv95t7tH708u7frcfpvbECTvAN+TiD4emOpNVBwoisDfEiyWvhy70t7IhF8yrm0D/YD1nUCFRwF+f7Zq2jf9ocXOijpuveTt+MPLrw9KQxG6pB3Ab0pRtHaWwqjaBvD8fTw9LbN+mggC/f3IrkD2yfVtPjhORTyDLxwR624j0EHXdd8fCp84h3wAlqkBHx3T/tKE+AB+yO3kN0zVQ6k35ujbf2zfZR/rYO2fdXbe+Ycu0OaiVYfwMT27twajoueS1mR+cqVt551LQuNfcs/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR4HjIB/ALX5+ZlAmIg7MsxRqKDlFc9Y3QGk7k/sr+E=;
 b=X1DecGYOIctYVIfuAEMu8AFXX59V8C0xSKNPt6GS8l9/6XIB5HqltHX+72V6tubR8cCULkUfn72ISORTrhvpxj5lGIpc7Qmbt4i/A0t4PFluxtSRHRHmouWcWahO6okE9nkPHenF24oW+1+rBbL1/3sBt+QWGW8/1YDo6lT+PgNyJLmfP78ZV/OpbKmtko1HRfqAH1udiGYE+R6mqSj9kXEgGtC+SJfPS6GMuM2M6ZjJTZC8aJ7zJ67AXBb/kga9OjP/SuKgO3gWk5fuwPgPV9pA3NFpuowBQO3DFYyNOYlAjr5XeH7/cXh57AbQqNvnJqo56rvGG2TjHL3PFvesXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Thu, 29 Feb
 2024 07:30:13 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b]) by ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:30:13 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v7 1/4] perf: starfive: Add StarLink PMU support
Date: Thu, 29 Feb 2024 15:27:17 +0800
Message-ID: <20240229072720.3987876-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
References: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1013:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cf4112-2689-40e0-025a-08dc38f84455
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fbwWG9D+HoCN8ufHyVlf9wx7s4fFbPSLZAq8HP40SMhQaCaIyct1Q14eWMUTOK4v+WwAcKXjxz5gGpqcD4pc1U398a9FAu8tjBgB+zlHhHNdXfiQIqHN12aTHyJaH6L81shmnikp2e3+IgDmu1eCtAFCIdyQxhFWPtcWeE5JRe5Rij9FcDr0/DaHWecFtoEyy3ZOwdELe1eymr0xb6cdO0XFQqKcWzuP4fPy9kYcpH47NKDP2pM8YcpBd1Jhoo91UfkFkuRwADQJbZkWr8E0S5/wqkTEOGpdrBDQ0AXTGet93VHg8uNljRavmJvsn2zsy7Yq2Mi/VGgOZMYjQBh8nSXIFc2kr9+IsYLseBlaJ1c6LSLa4wAqaioVUkAxlthzJnoiHHsMJJrIFav7PvTdPlr4YkgZfpQG2vnVkWFGLDlxROt+jt7mW5KXx8K9thkribPx1eRpM5uq2VWJecw85rWU16jgsRUnLuYXuXSMII+tmjiXe1Up4y4XkP4ERUXmiflgcRyBMXMJ9TrJXBBv45qwdPVvNd8HzOFbsijAmbE9t1OZfrfrNIr8quWrlVlvDg4oC5Bl82SsHx5tkkoZFgYaqnTSihgCaaPiKhiTqlNwu2fBukIYD7wM6/I7PrONI0Y3TP7Po2jwflvOCl7K1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vcMpycd6NtwxjL4sisaeyjkacbj5pmU701VIjvech7fGnjigjge6rvo3zUx4?=
 =?us-ascii?Q?mf5/iUJ9x1+h+NgQVVntbtiK+e0XBPld80ia8mTFIxb/E4A6V1F81WiW4vz8?=
 =?us-ascii?Q?GmINvmNxLquBSyhuy+yf6MTpQC47MTpInKgQQoBSFERvufWLruEwnrQYnjik?=
 =?us-ascii?Q?6s4HP9WM3q1rb3e7Ncaz4jPv0BjNPoFtqRD7POd6v837NEjSPQxYBbBu0xhC?=
 =?us-ascii?Q?W050VYBwch5KfymwobkxwUyTdag0M+6vR7DDBJjmCptLvUJI3+Ev7uHMWnnr?=
 =?us-ascii?Q?RbtFXbbBRMHpF0WDEdFP35DwbYV3lYmTroZHSaLoEJ2oVLQCGqSalN3vsaSz?=
 =?us-ascii?Q?jgC1hNcsI4ImDtMhm3oTrkT9Stpy9mFv2ndWlGHVywTIPH0HXSeCmTHC+YTX?=
 =?us-ascii?Q?rk7b1qoPiOUAMifWtoKBRfI0fFKJpUqKMt6/NgEGDYCpisdkRf1S0/t9OIS1?=
 =?us-ascii?Q?2OusF0Uw2Chj0O7jXtBnq4IiE3JIKugXtEZnnyhGpi9JjfnqlfigF8gqiLRp?=
 =?us-ascii?Q?TvrVL9EKEYdGTFiAutHpJyraiEN9OGHgNJEufhyqwtklZduTxefDijAZJLTD?=
 =?us-ascii?Q?4VwSGQ+08u6jwkfs1PVkUDMSDL/ksC5qmphG1dwz61TQFijM3NhuZbNe+53V?=
 =?us-ascii?Q?Gl2aTvdxezCWQqAZgjNldIa4p3BIFcFLsN5bl6JDrSAwP5eYIgHqtVl/vGpF?=
 =?us-ascii?Q?c7TzMULsWsjbfoqc9ioC6PV11RevWlUh5pgX4dldJQzrQCPu7elKBb/pbb6Z?=
 =?us-ascii?Q?FMAWCV/HhOpuUo56m9ND1DJxurGRsMRB1sZSTlAQq0IH839/13Dfg8M7THl1?=
 =?us-ascii?Q?IjcrnFyMbSKSwRFAcjz+s7CLwFR/IwPq3ctysfwPkFkzugeO2M5spbzz1kEA?=
 =?us-ascii?Q?xMnpQeoAY70SjEPm3RBnTIpLmZT/LC1GOmwtiddXwN3LvXPWYpmtoNKtxY+N?=
 =?us-ascii?Q?kCfxB59hlO8mkiip7G1CeMvk9iVDUOluaUXS1CMm6T8OSrh1s8QEyAmhpBZ2?=
 =?us-ascii?Q?fk7HL9xh5yYvQ5p6DYsRAbFo8128shpTxEiiorsqm0VaLDzoyUs8BwFbfRLr?=
 =?us-ascii?Q?Xt4xQB3oe5ZIYDgfTMfP11DH50spcTd8X8s/vt9q2TqxXPEyYlaa/KgC3UKp?=
 =?us-ascii?Q?GJBTl0YBdPmWHR5+XD5F9LuVs5Daoop2DMt+iUpQiKzBBjh5JEoVPGnbtBcK?=
 =?us-ascii?Q?cHgOgw7rzufE5K4+nuRULSYwf5IU+TEb1sshXmcRVKxK3y4TYmqBnP4eYhlb?=
 =?us-ascii?Q?ZZi+/0CbLre57eYUfmXYQReRgCJ1X46KAi7mplVfmRCV0x3aeWikBxvP37Sh?=
 =?us-ascii?Q?E283hiiIYKmtTIHFtU8/BZAmWyvHValDBjpp8leYRKRpsZ3UzTMia0WB6xOP?=
 =?us-ascii?Q?f41Rux14fcmcKEao+XKRlFzmXeM051PeK6ANFjK2d2W9mM9wW15YF1JXTaJd?=
 =?us-ascii?Q?LfyWBy4jDlNnSQoiH0tMXBYZTwXWxBeji8T1Bmt25bime4cSxqQabIfUUdhI?=
 =?us-ascii?Q?yoVP10RTCL5oAIb0wWu+L27thvGA2voC2++0/yCEi9XIdo4O5VXYU0R5/6CU?=
 =?us-ascii?Q?vWsD2zWewSODThSiSb6KMKWY1TEQyT+aPDhmRb9IfR6rBNBNHMK6Izt9hj1L?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cf4112-2689-40e0-025a-08dc38f84455
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:30:13.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZuOEkQVxWbDlL5h68mSuUuS9Xm2CEh6sTumwcnnxcbR4DQxxoxkKKkTSo5w5C5h0Pg7+a8BszoLLStP2zej4gFJhNXNJPO0WW0Q9CxQCpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1013

This patch adds support for StarFive's StarLink PMU (Performance
Monitor Unit). StarLink PMU integrates one or more CPU cores with
a shared L3 memory system. The PMU supports overflow interrupt,
up to 16 programmable 64bit event counters, and an independent
64bit cycle counter. StarLink PMU is accessed via MMIO.

Example Perf stat output:
[root@user]# perf stat -a -e /starfive_starlink_pmu/cycles/ \
	-e /starfive_starlink_pmu/read_miss/ \
	-e /starfive_starlink_pmu/read_hit/ \
	-e /starfive_starlink_pmu/release_request/  \
	-e /starfive_starlink_pmu/write_hit/ \
	-e /starfive_starlink_pmu/write_miss/ \
	-e /starfive_starlink_pmu/write_request/ \
	-e /starfive_starlink_pmu/writeback/ \
	-e /starfive_starlink_pmu/read_request/ \
	-- openssl speed rsa2048
Doing 2048 bits private rsa's for 10s: 5 2048 bits private RSA's in
2.84s
Doing 2048 bits public rsa's for 10s: 169 2048 bits public RSA's in
2.42s
version: 3.0.11
built on: Tue Sep 19 13:02:31 2023 UTC
options: bn(64,64)
CPUINFO: N/A
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.568000s 0.014320s      1.8     69.8
/////////
 Performance counter stats for 'system wide':

         649991998      starfive_starlink_pmu/cycles/
           1009690      starfive_starlink_pmu/read_miss/
           1079750      starfive_starlink_pmu/read_hit/
           2089405      starfive_starlink_pmu/release_request/
               129      starfive_starlink_pmu/write_hit/
                70      starfive_starlink_pmu/write_miss/
               194      starfive_starlink_pmu/write_request/
            150080      starfive_starlink_pmu/writeback/
           2089423      starfive_starlink_pmu/read_request/

      27.062755678 seconds time elapsed

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 drivers/perf/Kconfig                 |   9 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/starfive_starlink_pmu.c | 642 +++++++++++++++++++++++++++
 3 files changed, 652 insertions(+)
 create mode 100644 drivers/perf/starfive_starlink_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2..8dfeb583b059 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -86,6 +86,15 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config STARFIVE_STARLINK_PMU
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	bool "StarFive StarLink PMU"
+	help
+	   Provide support for StarLink Performance Monitor Unit.
+	   StarLink Performance Monitor Unit integrates one or more cores with
+	   an L3 memory system. The L3 cache events are added into perf event
+	   subsystem, allowing monitoring of various L3 cache perf events.
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 16b3ec4db916..e2153aee1e04 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
+obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
new file mode 100644
index 000000000000..5e5a672b4229
--- /dev/null
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * StarFive's StarLink PMU driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+ *
+ */
+
+#define STARLINK_PMU_PDEV_NAME	"starfive_starlink_pmu"
+#define pr_fmt(fmt)	STARLINK_PMU_PDEV_NAME ": " fmt
+
+#include <linux/bitmap.h>
+#include <linux/cpu_pm.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#define STARLINK_PMU_MAX_COUNTERS			64
+#define STARLINK_PMU_NUM_COUNTERS			16
+#define STARLINK_PMU_IDX_CYCLE_COUNTER			63
+
+#define STARLINK_PMU_EVENT_SELECT			0x060
+#define STARLINK_PMU_EVENT_COUNTER			0x160
+#define STARLINK_PMU_COUNTER_MASK			GENMASK_ULL(63, 0)
+#define STARLINK_PMU_CYCLE_COUNTER			0x058
+
+#define STARLINK_PMU_CONTROL				0x040
+#define STARLINK_PMU_GLOBAL_ENABLE			BIT_ULL(0)
+
+#define STARLINK_PMU_INTERRUPT_ENABLE			0x050
+#define STARLINK_PMU_COUNTER_OVERFLOW_STATUS		0x048
+#define STARLINK_PMU_CYCLE_OVERFLOW_MASK		BIT_ULL(63)
+
+#define STARLINK_CYCLES				0x058
+#define CACHE_READ_REQUEST			0x04000701
+#define CACHE_WRITE_REQUEST			0x03000001
+#define CACHE_RELEASE_REQUEST			0x0003e001
+#define CACHE_READ_HIT				0x00901202
+#define CACHE_READ_MISS				0x04008002
+#define CACHE_WRITE_HIT				0x006c0002
+#define CACHE_WRITE_MISS			0x03000002
+#define CACHE_WRITEBACK				0x00000403
+
+#define to_starlink_pmu(p) (container_of(p, struct starlink_pmu, pmu))
+
+#define STARLINK_FORMAT_ATTR(_name, _config)				      \
+	(&((struct dev_ext_attribute[]) {				      \
+		{ .attr = __ATTR(_name, 0444, starlink_pmu_sysfs_format_show, NULL), \
+		  .var = (void *)_config, }				      \
+	})[0].attr.attr)
+
+#define STARLINK_EVENT_ATTR(_name, _id)					     \
+	PMU_EVENT_ATTR_ID(_name, starlink_pmu_sysfs_event_show, _id)
+
+static int starlink_pmu_cpuhp_state;
+
+struct starlink_hw_events {
+	struct perf_event	*events[STARLINK_PMU_MAX_COUNTERS];
+	DECLARE_BITMAP(used_mask, STARLINK_PMU_MAX_COUNTERS);
+};
+
+struct starlink_pmu {
+	struct pmu					pmu;
+	struct starlink_hw_events			__percpu *hw_events;
+	struct hlist_node				node;
+	struct notifier_block				starlink_pmu_pm_nb;
+	void __iomem					*pmu_base;
+	cpumask_t					cpumask;
+	int						irq;
+};
+
+static ssize_t
+starlink_pmu_sysfs_format_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct dev_ext_attribute *eattr = container_of(attr,
+						       struct dev_ext_attribute, attr);
+
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+
+static struct attribute *starlink_pmu_format_attrs[] = {
+	STARLINK_FORMAT_ATTR(event, "config:0-31"),
+	NULL
+};
+
+static const struct attribute_group starlink_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = starlink_pmu_format_attrs,
+};
+
+static ssize_t
+starlink_pmu_sysfs_event_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct perf_pmu_events_attr *eattr = container_of(attr,
+							  struct perf_pmu_events_attr, attr);
+
+	return sysfs_emit(buf, "event=0x%02llx\n", eattr->id);
+}
+
+static struct attribute *starlink_pmu_event_attrs[] = {
+	STARLINK_EVENT_ATTR(cycles, STARLINK_CYCLES),
+	STARLINK_EVENT_ATTR(read_request, CACHE_READ_REQUEST),
+	STARLINK_EVENT_ATTR(write_request, CACHE_WRITE_REQUEST),
+	STARLINK_EVENT_ATTR(release_request, CACHE_RELEASE_REQUEST),
+	STARLINK_EVENT_ATTR(read_hit, CACHE_READ_HIT),
+	STARLINK_EVENT_ATTR(read_miss, CACHE_READ_MISS),
+	STARLINK_EVENT_ATTR(write_hit, CACHE_WRITE_HIT),
+	STARLINK_EVENT_ATTR(write_miss, CACHE_WRITE_MISS),
+	STARLINK_EVENT_ATTR(writeback, CACHE_WRITEBACK),
+	NULL
+};
+
+static const struct attribute_group starlink_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = starlink_pmu_event_attrs,
+};
+
+static ssize_t
+cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &starlink_pmu->cpumask);
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *starlink_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group starlink_pmu_cpumask_attr_group = {
+	.attrs = starlink_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *starlink_pmu_attr_groups[] = {
+	&starlink_pmu_format_attr_group,
+	&starlink_pmu_events_attr_group,
+	&starlink_pmu_cpumask_attr_group,
+	NULL
+};
+
+static void starlink_pmu_set_event_period(struct perf_event *event)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = event->hw.idx;
+
+	/*
+	 * Program counter to half of it's max count to handle
+	 * cases of extreme interrupt latency.
+	 */
+	u64 val = STARLINK_PMU_COUNTER_MASK >> 1;
+
+	local64_set(&hwc->prev_count, val);
+	if (hwc->config == STARLINK_CYCLES)
+		writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_CYCLE_COUNTER);
+	else
+		writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_EVENT_COUNTER +
+		       idx * sizeof(u64));
+}
+
+static void starlink_pmu_counter_start(struct perf_event *event,
+				       struct starlink_pmu *starlink_pmu)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = event->hw.idx;
+	u64 val;
+
+	/*
+	 * Enable counter overflow interrupt[63:0],
+	 * which is mapped as follow:
+	 *
+	 * event counter 0	- Bit [0]
+	 * event counter 1	- Bit [1]
+	 * ...
+	 * cycle counter	- Bit [63]
+	 */
+	val = readq(starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
+
+	if (hwc->config == STARLINK_CYCLES) {
+		/*
+		 * Cycle count has its dedicated register, and it starts
+		 * counting as soon as STARLINK_PMU_GLOBAL_ENABLE is set.
+		 */
+		val |= STARLINK_PMU_CYCLE_OVERFLOW_MASK;
+	} else {
+		writeq(event->hw.config, starlink_pmu->pmu_base +
+		       STARLINK_PMU_EVENT_SELECT + idx * sizeof(u64));
+
+		val |= BIT_ULL(idx);
+	}
+
+	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
+
+	writeq(STARLINK_PMU_GLOBAL_ENABLE, starlink_pmu->pmu_base +
+	       STARLINK_PMU_CONTROL);
+}
+
+static void starlink_pmu_counter_stop(struct perf_event *event,
+				      struct starlink_pmu *starlink_pmu)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = event->hw.idx;
+	u64 val;
+
+	val = readq(starlink_pmu->pmu_base + STARLINK_PMU_CONTROL);
+	val &= ~STARLINK_PMU_GLOBAL_ENABLE;
+	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_CONTROL);
+
+	val = readq(starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
+	if (hwc->config == STARLINK_CYCLES)
+		val &= ~STARLINK_PMU_CYCLE_OVERFLOW_MASK;
+	else
+		val &= ~BIT_ULL(idx);
+
+	writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_INTERRUPT_ENABLE);
+}
+
+static void starlink_pmu_update(struct perf_event *event)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u64 prev_raw_count, new_raw_count;
+	u64 oldval;
+	u64 delta;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		if (hwc->config == STARLINK_CYCLES)
+			new_raw_count = readq(starlink_pmu->pmu_base +
+					      STARLINK_PMU_CYCLE_COUNTER);
+		else
+			new_raw_count = readq(starlink_pmu->pmu_base +
+					      STARLINK_PMU_EVENT_COUNTER +
+					      idx * sizeof(u64));
+		oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+					 new_raw_count);
+	} while (oldval != prev_raw_count);
+
+	delta = (new_raw_count - prev_raw_count) & STARLINK_PMU_COUNTER_MASK;
+	local64_add(delta, &event->count);
+}
+
+static void starlink_pmu_start(struct perf_event *event, int flags)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+
+	starlink_pmu_set_event_period(event);
+	starlink_pmu_counter_start(event, starlink_pmu);
+
+	perf_event_update_userpage(event);
+}
+
+static void starlink_pmu_stop(struct perf_event *event, int flags)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	starlink_pmu_counter_stop(event, starlink_pmu);
+	starlink_pmu_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int starlink_pmu_add(struct perf_event *event, int flags)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct starlink_hw_events *hw_events =
+					this_cpu_ptr(starlink_pmu->hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long *used_mask = hw_events->used_mask;
+	u32 n_events = STARLINK_PMU_NUM_COUNTERS;
+	int idx;
+
+	/*
+	 * Cycle counter has dedicated register to hold counter value.
+	 * Event other than cycle count has to be enabled through
+	 * event select register, and assigned with independent counter
+	 * as they appear.
+	 */
+
+	if (hwc->config == STARLINK_CYCLES) {
+		idx = STARLINK_PMU_IDX_CYCLE_COUNTER;
+	} else {
+		idx = find_first_zero_bit(used_mask, n_events);
+		/* All counter are in use */
+		if (idx < 0)
+			return idx;
+
+		set_bit(idx, used_mask);
+	}
+
+	hwc->idx = idx;
+	hw_events->events[idx] = event;
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		starlink_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void starlink_pmu_del(struct perf_event *event, int flags)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct starlink_hw_events *hw_events =
+					this_cpu_ptr(starlink_pmu->hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	starlink_pmu_stop(event, PERF_EF_UPDATE);
+	hw_events->events[hwc->idx] = NULL;
+	clear_bit(hwc->idx, hw_events->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static bool starlink_pmu_validate_event_group(struct perf_event *event)
+{
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int counter = 1;
+
+	/*
+	 * Ensure hardware events in the group are on the same PMU,
+	 * software events are acceptable.
+	 */
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return false;
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->pmu != event->pmu && !is_software_event(sibling))
+			return false;
+
+		counter++;
+	}
+
+	return counter <= STARLINK_PMU_NUM_COUNTERS;
+}
+
+static int starlink_pmu_event_init(struct perf_event *event)
+{
+	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * Sampling is not supported, as counters are shared
+	 * by all CPU.
+	 */
+	if (hwc->sample_period)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Per-task and attach to a task are not supported,
+	 * as uncore events are not specific to any CPU.
+	 */
+	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (!starlink_pmu_validate_event_group(event))
+		return -EINVAL;
+
+	hwc->idx = -1;
+	hwc->config = event->attr.config;
+	event->cpu = cpumask_first(&starlink_pmu->cpumask);
+
+	return 0;
+}
+
+static irqreturn_t starlink_pmu_handle_irq(int irq_num, void *data)
+{
+	struct starlink_pmu *starlink_pmu = data;
+	struct starlink_hw_events *hw_events =
+			this_cpu_ptr(starlink_pmu->hw_events);
+	bool handled = false;
+	int idx;
+	u64 overflow_status;
+
+	for (idx = 0; idx < STARLINK_PMU_MAX_COUNTERS; idx++) {
+		struct perf_event *event = hw_events->events[idx];
+
+		if (!event)
+			continue;
+
+		overflow_status = readq(starlink_pmu->pmu_base +
+					STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
+		if (!(overflow_status & BIT_ULL(idx)))
+			continue;
+
+		writeq(BIT_ULL(idx), starlink_pmu->pmu_base +
+		       STARLINK_PMU_COUNTER_OVERFLOW_STATUS);
+
+		starlink_pmu_update(event);
+		starlink_pmu_set_event_period(event);
+		handled = true;
+	}
+	return IRQ_RETVAL(handled);
+}
+
+static int starlink_setup_irqs(struct starlink_pmu *starlink_pmu,
+			       struct platform_device *pdev)
+{
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -EINVAL;
+
+	ret = devm_request_irq(&pdev->dev, irq, starlink_pmu_handle_irq,
+			       0, STARLINK_PMU_PDEV_NAME, starlink_pmu);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request IRQ\n");
+
+	starlink_pmu->irq = irq;
+
+	return 0;
+}
+
+static int starlink_pmu_pm_notify(struct notifier_block *b,
+				  unsigned long cmd, void *v)
+{
+	struct starlink_pmu *starlink_pmu = container_of(b, struct starlink_pmu,
+							 starlink_pmu_pm_nb);
+	struct starlink_hw_events *hw_events =
+					this_cpu_ptr(starlink_pmu->hw_events);
+	int enabled = bitmap_weight(hw_events->used_mask,
+				    STARLINK_PMU_MAX_COUNTERS);
+	struct perf_event *event;
+	int idx;
+
+	if (!enabled)
+		return NOTIFY_OK;
+
+	for (idx = 0; idx < STARLINK_PMU_MAX_COUNTERS; idx++) {
+		event = hw_events->events[idx];
+		if (!event)
+			continue;
+
+		switch (cmd) {
+		case CPU_PM_ENTER:
+			/* Stop and update the counter */
+			starlink_pmu_stop(event, PERF_EF_UPDATE);
+			break;
+		case CPU_PM_EXIT:
+		case CPU_PM_ENTER_FAILED:
+			/* Restore and enable the counter */
+			starlink_pmu_start(event, PERF_EF_RELOAD);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int starlink_pmu_pm_register(struct starlink_pmu *starlink_pmu)
+{
+	if (!IS_ENABLED(CONFIG_CPU_PM))
+		return 0;
+
+	starlink_pmu->starlink_pmu_pm_nb.notifier_call = starlink_pmu_pm_notify;
+	return cpu_pm_register_notifier(&starlink_pmu->starlink_pmu_pm_nb);
+}
+
+static void starlink_pmu_pm_unregister(struct starlink_pmu *starlink_pmu)
+{
+	if (!IS_ENABLED(CONFIG_CPU_PM))
+		return;
+
+	cpu_pm_unregister_notifier(&starlink_pmu->starlink_pmu_pm_nb);
+}
+
+static void starlink_pmu_destroy(struct starlink_pmu *starlink_pmu)
+{
+	starlink_pmu_pm_unregister(starlink_pmu);
+	cpuhp_state_remove_instance(starlink_pmu_cpuhp_state,
+				    &starlink_pmu->node);
+}
+
+static int starlink_pmu_probe(struct platform_device *pdev)
+{
+	struct starlink_pmu *starlink_pmu;
+	struct starlink_hw_events *hw_events;
+	struct resource *res;
+	int cpuid, i, ret;
+
+	starlink_pmu = devm_kzalloc(&pdev->dev, sizeof(*starlink_pmu), GFP_KERNEL);
+	if (!starlink_pmu)
+		return -ENOMEM;
+
+	starlink_pmu->pmu_base =
+			devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(starlink_pmu->pmu_base))
+		return PTR_ERR(starlink_pmu->pmu_base);
+
+	starlink_pmu->hw_events = alloc_percpu_gfp(struct starlink_hw_events,
+						   GFP_KERNEL);
+	if (!starlink_pmu->hw_events) {
+		dev_err(&pdev->dev, "Failed to allocate per-cpu PMU data\n");
+		return -ENOMEM;
+	}
+
+	for_each_possible_cpu(cpuid) {
+		hw_events = per_cpu_ptr(starlink_pmu->hw_events, cpuid);
+		for (i = 0; i < STARLINK_PMU_MAX_COUNTERS; i++)
+			hw_events->events[i] = NULL;
+	}
+
+	ret = starlink_setup_irqs(starlink_pmu, pdev);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_state_add_instance(starlink_pmu_cpuhp_state,
+				       &starlink_pmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register hotplug\n");
+		return ret;
+	}
+
+	ret = starlink_pmu_pm_register(starlink_pmu);
+	if (ret) {
+		cpuhp_state_remove_instance(starlink_pmu_cpuhp_state,
+					    &starlink_pmu->node);
+		return ret;
+	}
+
+	starlink_pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= starlink_pmu_event_init,
+		.add		= starlink_pmu_add,
+		.del		= starlink_pmu_del,
+		.start		= starlink_pmu_start,
+		.stop		= starlink_pmu_stop,
+		.read		= starlink_pmu_update,
+		.attr_groups	= starlink_pmu_attr_groups,
+	};
+
+	ret = perf_pmu_register(&starlink_pmu->pmu, STARLINK_PMU_PDEV_NAME, -1);
+	if (ret)
+		starlink_pmu_destroy(starlink_pmu);
+
+	return ret;
+}
+
+static const struct of_device_id starlink_pmu_of_match[] = {
+	{ .compatible = "starfive,jh8100-starlink-pmu" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, starlink_pmu_of_match);
+
+static struct platform_driver starlink_pmu_driver = {
+	.driver = {
+		.name	= STARLINK_PMU_PDEV_NAME,
+		.of_match_table = starlink_pmu_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = starlink_pmu_probe,
+};
+
+static int
+starlink_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct starlink_pmu *starlink_pmu = hlist_entry_safe(node,
+							     struct starlink_pmu,
+							     node);
+
+	if (cpumask_empty(&starlink_pmu->cpumask))
+		cpumask_set_cpu(cpu, &starlink_pmu->cpumask);
+
+	WARN_ON(irq_set_affinity(starlink_pmu->irq, cpumask_of(cpu)));
+
+	return 0;
+}
+
+static int
+starlink_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct starlink_pmu *starlink_pmu = hlist_entry_safe(node,
+							     struct starlink_pmu,
+							     node);
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &starlink_pmu->cpumask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&starlink_pmu->pmu, cpu, target);
+
+	cpumask_set_cpu(target, &starlink_pmu->cpumask);
+	WARN_ON(irq_set_affinity(starlink_pmu->irq, cpumask_of(target)));
+
+	return 0;
+}
+
+static int __init starlink_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "soc/starfive/starlink_pmu:online",
+				      starlink_pmu_online_cpu,
+				      starlink_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	starlink_pmu_cpuhp_state = ret;
+
+	return platform_driver_register(&starlink_pmu_driver);
+}
+
+device_initcall(starlink_pmu_init);
-- 
2.43.0


