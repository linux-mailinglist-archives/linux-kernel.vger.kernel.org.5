Return-Path: <linux-kernel+bounces-42499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CC840237
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82E9282F87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769F5644E;
	Mon, 29 Jan 2024 09:52:36 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2056.outbound.protection.partner.outlook.cn [139.219.17.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38E55777;
	Mon, 29 Jan 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521955; cv=fail; b=RZIt8tfTOKqmKCD3iqMJ6r5LsG7/QVEEkrLBpQWBZouIn+XAJwrgINm/BP8rAzypZRAjfNGrYIRQZRSoZIZMLhByMAfZqAvJ3frziYKL7O/I/Wg44nB5eMAlZKu0rGwCgNgq+Nv6exPJCKObnwU9oDf38vPo6R5QxzdwkIepXtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521955; c=relaxed/simple;
	bh=uV/ftEyjHaDLGcwIQnCPn6xs4eA3Q4UkHAY6LYk7Phs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/DNAyKhc0I2SedsGltIiBGAx6hbdhSkRatO/HmebaI1il1ZWzEbqUjvtgqE2IEpa6i/jwrO6M695u8+P23/9jUQ6gMhoqvDqV+G2QV9gUZT3sNsTzwYYOxPg0dB4pZk+GRjd84I3ZHLd3Om5I0vWxH4VSLPx23zh3SzW6k7vp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjTPUxKKlrr09+rIbaRCpdWuhmgPm1DZvAkkaTzrZXc5u2GcCCz49Dzzb6PO97WPQkX6aBbyl4GHY9pqo01sn0feK2M3Lgjlue+gneVGKTkXAROV/4JtWrpegOdK4Yjdw0vPnFPZzzZscMf/cFrOE8dgf2l1VehHnMc02W45O1L59rDuG1wi1ItiyOQ4yeypgbwqSDOgytrZN4a7t6eb3BBvxLCrb487Ysbb2SFJf18f/OSEuzrDVRkrcnldDI3LEy7EE/x0HHIZQkdNaDAmz+wRCd1/SqUxMTgMWXWLR7RJ4WpE77LeGnOCRagfQF57/X8RjmYNW7ouAEKn0Py9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8W4g7SHXsEDpar/GhUcPeiDhkIdF9FQlQJBlh8sSGA=;
 b=HZLrXGsWhjZmrb638FNR9aL3Mz37rWUJ6If94pyhGAs3HK4hPY0bOxg2i+0LtGqnivoa7HfGZDjsuYIsjXqYqq6Z1jQw3itNVrYKyZaPtRZVBpbDAW6udTamedjsbcYc4hIpNUIhuUJOoKCnXdRf4pM6eyUfb7uI9YOc2Frg9ySp7PD3ATcCmhw2WosSnPiyZvu3pR4X/9RLGwvy3gWozFYoOh79uLBQVg7o/MG4W+7nbLdqUniX+yNkgT/8RVd3Fb1x1SplHKfo5KndddlggcJ/y0tP/Gu8iEpqbLBaWEV2jX8JFdRuh4c9eN7hLLuCUvM7JafoLNzU0vj1aI2eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 09:52:23 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7228.028; Mon, 29 Jan 2024 09:52:23 +0000
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
	Dave Jiang <dave.jiang@intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v6 1/4] perf: starfive: Add StarLink PMU support
Date: Mon, 29 Jan 2024 17:51:38 +0800
Message-ID: <20240129095141.3262366-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a25b42c-d957-4985-82a6-08dc20affdff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	098Sv319ugnpKJZYOcywEntWh9OlZtMXEqftx4Wwn+ktrMaCvdeOBf7lm3OVOvqkGU/LtRXuzDTO2yOyJzklijztaVg28R052Gif56OTwJEvFcFmMbytCORYa/FJCNm/Xdx/EJRFdfpO7ru2WAhDogaFBRzCaLgbrjljDU11irV16LYURuOGopZskTCgW+avyxduG4b1XAfh7p1UDn4WcHZX/y1VeRw8Rikh/qcfo0X9W81VQqcoCHGZyaW7Br3BBadh+BS0RO2tWhPfImT7TbcVfPcQoSYeqXVMed+WVOdfZZqVaG3Lo59WuogARyBLqbWtEnATnd98YjXeEyssmTy4le4QGcXV3nO5nvQmwRPuQKT1pfznuLkVwgzSVT94j5fjQyELaxwx9R/lt+Vj4/wDx8IFgjIWFw+wPor0zQpEGzFrfJC76tgUxN2TzeNF9MT5qEveaJcV0ZAfxXWR6AbyiDu5L6/iTFt1OLsBCiYZI1/jiZp8L6ZGnPa/fnua5lt/nxC6PC1+RyGJuWrn40tLpxHwnm61bLVP0kq/2WlUPDV/ts5S7W8KfhC1POrl4LKyNtyp2V0E/1bLRyws1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(30864003)(4326008)(7416002)(8676002)(8936002)(66946007)(66556008)(5660300002)(110136005)(86362001)(2906002)(40180700001)(38350700005)(36756003)(52116002)(54906003)(508600001)(38100700002)(40160700002)(66476007)(83380400001)(2616005)(6666004)(41300700001)(1076003)(921011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+IPW+hy99BWwJhJ9SnA/57DFzfQwe+qgu9Bur4uh+nFuMt7m26VCOx3g8M+5?=
 =?us-ascii?Q?lUrgXSd8FTUzg8IsyWvSzADEbWdEeBLTvcKo7FvG91gu42JlaV82HPOX8P2Q?=
 =?us-ascii?Q?ejVMg+xGNfUCtCHADoUidWc8lIkvpj8/VP0K5SJVqWIPURfbG/Fvrc3vyZ7f?=
 =?us-ascii?Q?lR/pse5beLhnQW/hx7JOcgzGTGu6RCxJ9/pJk9Bt+bOFKWAKpkzWEe8vjsR0?=
 =?us-ascii?Q?PJqOrbJp82UUTB6hxLsDdP6SeUJoMxodL4jYyQT8hJhNMmGklAIepCRFhhdC?=
 =?us-ascii?Q?RToMrltPI2bKfvAQD7Fbl8Im4QfYoDYLmNj2o2AEl9yS5nbkK/to0VvpvQVI?=
 =?us-ascii?Q?GjYu1yt6VtC7spWZyhPJXbV9DNpaNbx2OWGol+76GFUwwFc3WQag5NXhWp40?=
 =?us-ascii?Q?dTu8H6RV1jKrMV8QfULNwDWXN1BzlvdW/wtNFWs4a37dOZx6y1KVqqMT/fn1?=
 =?us-ascii?Q?Iz2WgRzDtWR4FIlCPpxGy0N5n0m6dFKeGMOwCmL/AMO2Wwy861t6EZgjph1Z?=
 =?us-ascii?Q?IOBUrBriZMhXWDZD8KNZwGCEIWiGdZDd18sn1walt8wcSzhEOuDo3SobH0eH?=
 =?us-ascii?Q?7gTrTMjOrPcAxYHFcH5Ci04bTO5qfjxrrMKqPPftXcmZGU2UA2DBdhyNzC7S?=
 =?us-ascii?Q?F4o2N2dGd4n1kBMXGN/wFdPmCEMPZnNFur45n57Aw2kiTnT8MEZcBEV1GeFM?=
 =?us-ascii?Q?m1GJ3317YPiXQXQ6wP3ZB4TwMplIHd2G+7GGXclsonSmb2ngCt9GHo9bv3R2?=
 =?us-ascii?Q?d0dUkdWSkTjYOTqmDUEAThOpW/BJKzmGATqLY4LlD92GZPic8EhWHGDeYzSP?=
 =?us-ascii?Q?7zH0VlCy+6lzhrqaNJJqfqrb1Opbf+F8XeXw4Da2E9qdEhGyaw1/XYqUKeUy?=
 =?us-ascii?Q?jjf62UJ+3LG9AplPtc5IJsvTiorQD2ETEYM0oKqacosQqEzcdVrZI0q0ivcj?=
 =?us-ascii?Q?S9h67IGqEHvY+AQnTE5O+2XSEbUWnE7R0+uDsKDVIuWGArwEHz0lOkvMKH7d?=
 =?us-ascii?Q?ooBU6l6EaazZwl6S8XP9QhNCYC03aR2cNItTiqURpxGbDJOl9P+73S9lZ6ZM?=
 =?us-ascii?Q?rBY0leFjB+18vIPJf2/Mspkj6o793z4/GUIq4aKiar/u640ijolfIaiSjQPF?=
 =?us-ascii?Q?uv5pJKXVqO3tMvvcILtuxhaL+jMH5h9OfIEzjOD5khcxsOO+2qu/bR6Khl4c?=
 =?us-ascii?Q?AqHNCgSNCE9Rxu+qiDCV2ZHt7WklEr691Uc/viI7ceBlz29H0LjeJQPgMcaJ?=
 =?us-ascii?Q?V5YTsHlK1VUu9r/qci49ijwAY06InnFS4FepqQWUaL9FmV0SurYiCJeVqfVr?=
 =?us-ascii?Q?sDr9hiKvQ1ecr/jXhHQDVHOZwT0wqt5mRpnnpm7ascCCJYeZBKrEkQY6nIFq?=
 =?us-ascii?Q?bJUC8z7Yc97QknCgSM/pL1WE7tstRP2L86TclL2l3bXczU1oT5vz0oQceUa/?=
 =?us-ascii?Q?uACc5AdmjMLyapUM8JkZuhNdAYNhehUeIVro0SNjM4bBy5dIbjkuzR2XPWAP?=
 =?us-ascii?Q?16JfpI+j3JD4WtMw8E8bbRYPK+gySkcX5pEpWCiwNE9cQqpILEwtMttmfZEV?=
 =?us-ascii?Q?tXPmBs/mGKgz8UJGTWeJPmh9iCnxB8ZmqxG2DPxD31r9Y2iyO0mJwIRPvexP?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a25b42c-d957-4985-82a6-08dc20affdff
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:52:23.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR6H9Ro16f7EFLLe/j++xXvBwzGRgUOsrXDiOTFOmCHcfH/LQFZCXZ3OUthLCY+e2JW65Xj0ykxch7C0On8JX9YQAazeMZAPbKpnKqQgVxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096

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
 drivers/perf/starfive_starlink_pmu.c | 643 +++++++++++++++++++++++++++
 3 files changed, 653 insertions(+)
 create mode 100644 drivers/perf/starfive_starlink_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2..41278742ef88 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -86,6 +86,15 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config STARFIVE_STARLINK_PMU
+	depends on ARCH_STARFIVE
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
index 000000000000..2447ca09a471
--- /dev/null
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -0,0 +1,643 @@
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
+#define STARLINK_PMU_GLOBAL_ENABLE			BIT(0)
+
+#define STARLINK_PMU_INTERRUPT_ENABLE			0x050
+#define STARLINK_PMU_COUNTER_OVERFLOW_STATUS		0x048
+#define STARLINK_PMU_CYCLE_OVERFLOW_MASK		BIT(63)
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
+		val |= (1 << idx);
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
+		val &= ~(1 << idx);
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
+		if (!(overflow_status & BIT(idx)))
+			continue;
+
+		writeq(1 << idx, starlink_pmu->pmu_base +
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
+		kfree(starlink_pmu);
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


