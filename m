Return-Path: <linux-kernel+bounces-142377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F6E8A2AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BF21C20C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DEC54BDB;
	Fri, 12 Apr 2024 09:18:24 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03E753E06;
	Fri, 12 Apr 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913503; cv=fail; b=O3e24wOoNm5OPJFePNk+qYFB1ju6TiZIrLyyC7kRXtkwndxQRJ6fapwMPZ5BH0enVUgT7uhoOp8AOZrFexyxKhd+P+rC9102Ne0nopj/O8wonixKbNwUddnR2oZTU1dZGfz9hpjabJU+hY/p6d3ekwzVT0kwtKrQ6kHrjHtpxTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913503; c=relaxed/simple;
	bh=kMqhhlB1KkPwCPpsv05A3sGYO3a5L0kjxvQ+XB/eAsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sf2ovl9poqmO0bGDUiX1+aKIDN9tlnwFsXBcF0BDwniHkMjeBHUAzDD5ZhlpH+PouWUs6DlD7DATpYG/hUlLOO8+ZvsJaXA38Fsdy9/wkGCRCn8HmE27xJJueS2t6GUMz4CyIJqLQPQg91NPeRBsPFEXPeI73+v17V3hxhQLKTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv4Ch2pD8rcZdpgDArv5ZB6OLB12GaUUvLvr77YNcQA4pa8R9e815htPZLRdwqiCHROU4RjAC4qIDkRM1+vDPftrn7i81R++ROH88zTdWK/21BYckm7LAcO/aCU79SI3NHsFWF+xqEVXYa9dx7AcnEVwiiqN87GntIszwWY7uBmKPBu8/zK0S3FkK6Y5f2RGAz/AdA45QhiJY797gUcmSHBW/2mWjvf+7m4H3OJj8AeqS8vpTHcsOnTVpokE3XyXgeY6i5c3sAFUk4lx+g/dwDzpgnToPQVd8LF7ZxOy0tLjnzDtfW+2FPv8yHwW3K9sO8CTAnnvIN18IJYp+n7pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uprU00VRCPMLbyTwKVO8JcCFB9V7peGMzT3pRaot68=;
 b=YAmFBlCslTMF6iQfNMhW1ZD6jBcmedKO2pAwp9ikdulieT3B/vq2se5ggZpk75e8av9XuQuTP2Z6cT56KLdd2zhPqNvnL3z2IhFPCqqyK9CHKWFsMshABs5MgUrU9ilKC3BmPdN1HNKutLlud0qoAO3Wkp4iBGagk8K6SmkjFhGyrUA0BU1chTYM0xZqATOR7lwkRMRUzjKHnKLU8Kw8HQdTOEAFzpmu4fSxHaPFw8tMT5nzFZsXRLNemJm4GWZZm1+w4/ee32fEyffgAi/ULmDqBa6RWXOotnHKPXSv3Aew6LsGnJtFZwXaGui4YMqDNZpLe3kjkbuDTRDhDxMUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1129.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:45:54 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490]) by NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 08:45:54 +0000
From: Ziv Xu <ziv.xu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v10 2/3] clocksource: Add JH7110 timer driver
Date: Fri, 12 Apr 2024 16:45:42 +0800
Message-Id: <20240412084543.7243-3-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240412084543.7243-1-ziv.xu@starfivetech.com>
References: <20240412084543.7243-1-ziv.xu@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::21) To NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0986:EE_|NTZPR01MB1129:EE_
X-MS-Office365-Filtering-Correlation-Id: 64628ac3-1301-44e2-98b2-08dc5accf6eb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mPyl4jEOo0tz5phWfXq4+OCb/XGcIf0Fb9EirF6VR8wWki53Qw55WxOeUkesvP4cuOhXMt/vuQcj2zTz0TzBfSxKrpMF09ybo66mTPK/gL43tdhUFscOWnhhNNhrH0ukU2XP9I2csCEhd6waoFKLukBKCJS1886V9d/VmhClAm2yOj2f0zPTGeCmTHjR4RsOzS77qwtrxJeyjwpYHMypDEI+T7Jn9cLVsoJRPKG7kJ4TWhebbYNNZ/DV/9uL60m3n4y1YYUFJzXrp+MCk3mdeMRhU4XACt6HbzvRE+rKCYXKOfFNXFgqcAW2XzS8iwlrEonVSk9UR9BCCEIZRZrv9pEMNHaIJZQnMR/Ap6Me2orWWOOOapBuKD1BLxkag2AcqF3Z5c6OWWVwgpI40aNTMoWnVPajaqNvNVHu6JPu2mgfdAZNNwgfzsFvm5c13brM+u8wMVS3YjbFrnCEWFQNwLFnpfy9jCBbsMzpLwQpVi2VwE/v4pCGvTzcnluqXWoQLW/vFl4EIKirkpJKgx7x4+A57LB0Ef45geoKdaUmrVzUNMBTZmS1tVYsKmTVxBa35YF+U8wBG9D/8mPhK409Gi9vSau+FkPNV8Qy/PP0JqKqw8EQCWVXouWp5gCJiHsk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(366007)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZr4HXhS29m3OJ6LEHHDZL9TdljhnArz/zl5gKcM8PQahPVhSHciDPkgliwg?=
 =?us-ascii?Q?tPaclKPj0Cr1JYWcPIkpZ/Lnx1nR4piQOgZP18wWm6UorGAUCf4+Hiv+oVYT?=
 =?us-ascii?Q?t4LqmPEH3n/XeHfarwvU3TOH+4l5kz5RVauq+0Ot+X2Q015ObcHxflS2LA/g?=
 =?us-ascii?Q?65Oe89ETlRdJaaKoTITaUxIWxZFETbVLWyBzEFExeWAZKkGc9IW6e7FkkImo?=
 =?us-ascii?Q?/1xubpis++DNraK3NGT3/SnY0+HRS89ikOuJm5twjn5J7yyEJacDWaTMvzWx?=
 =?us-ascii?Q?RiX+NNhjJ3Cc7EUNegjc0bqDsCQZynRPs8xXcgE8Er0n+bub9x9VAgKMd70w?=
 =?us-ascii?Q?3mvanoWAYpOsKngqfL0O8QhcB/sUz+Ki2VS3CR+DSr6yvNzrRQeoP7Z4hGWu?=
 =?us-ascii?Q?G6Vm1GhvyyKqt/811CLZzpNMRXlRbvtEt8sV2av0ecsJpxWZ+mp5v/QPrFhC?=
 =?us-ascii?Q?xtyF8bD83ecE9ZQgfgxXYJcPWsCXTiPBE7Z+cuUeodgS6LUh2VoVEvPcU6sW?=
 =?us-ascii?Q?hTMTRKqb7ubpAjygwXUuHzEsQuPE6U4h+o9BvfuYjjN5s8hVWBD8/hil+szx?=
 =?us-ascii?Q?QC3wOP3UUF88jFzC3Pms83EoGw7S+ZVpiNox4QMdcMUym8AyGoGtYpT+4MVR?=
 =?us-ascii?Q?PGrOqBk6ohcbrNb6Tc8ucyU8Hx8eAOA9rDf2yrcSbvzuO6FAK25Sf7uuehQt?=
 =?us-ascii?Q?CsaAL4vUjQMWP/wWd3864vP618o4gc90epblQDyKsmGNuUQEfjOssdOF8ajo?=
 =?us-ascii?Q?2BQHRCdVXDYVIKEJlXnvBWZkShVgA7e2aXT4xevHE9qWynEGMasXBvEPXs4y?=
 =?us-ascii?Q?Vx7NGwYxa+oI/AQ8szSz9Y3IGAqWP9e3AwE0dNP9+SdZVr+TQKt2nrywiTDc?=
 =?us-ascii?Q?FJOdPHFE/xe5XRN5wAuI3zUukd2DGPFb1Ul6wcCnDeoq7Kf6Z4kOFwalZ28J?=
 =?us-ascii?Q?V4oZOi+GviSBxI3+Pqq8SEOOJ7ElS8ftpG2e92kqvrOJx549KNrYoeJmBj0q?=
 =?us-ascii?Q?atKIYHUYAXVJNd2bzH/uV6bh0a3jeYL6Ml3NGnMQ3OeAkxVcNZl6dtD8UnB7?=
 =?us-ascii?Q?7hbAp2vw2ng6HZXjBK1VN2bVM3O8H3bO4KYBHosg2aJ0n8PFXCjXBjJHGv//?=
 =?us-ascii?Q?SG+DNp91owEoF01L39OFTvuLMXKdNx10SE+P6BgIzPqOi+FzVeihS8w0+hD8?=
 =?us-ascii?Q?fsY0UheDLiLu7uullLqo7a7hy/EMU/xMRhE99Y9M1GKEiV9ZMDYuD9DFPEoS?=
 =?us-ascii?Q?fWPZ8/4280mxMXrdv/ixn9lWT73sK583TmNW9zsbJmVCGSh/2aqYn6tt9hgP?=
 =?us-ascii?Q?hUAS0D79ot7tN7dZixvle60dy+Ee3R8EANUDr08tQzCFr+S5uxhzZ/OM+AWM?=
 =?us-ascii?Q?IzpzEs7KLHh3f0soEym+eBTeCxzdalyc8DbCG1e24qfAXDxNe3KCcznSrqeU?=
 =?us-ascii?Q?GaWAzqdTmBh1oCJM6IwflWwmAlbBEldLjl0z0fs4E2Rkt4fuhIbkGsPTbKs1?=
 =?us-ascii?Q?3mUD9DY+4nWvnVLYogXKx+T13p0Pzwv/xKT9qhm2uaehjtL+QheqxYR00v+n?=
 =?us-ascii?Q?JwzfXUnCCljBehZVn7m8f7qAf+GDKvCwsZixKogDCKzkkmRvBkNywMKsIEEH?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64628ac3-1301-44e2-98b2-08dc5accf6eb
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:45:54.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnhUjUzyyPJc+6Pwi1RnQJZz4kuL7yaWc0wWyUEU6hzSrEodLVPoGQ7ss51+F3Mlbvxlv4vcQOFhRcsD4P/o/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1129

From: Xingyu Wu <xingyu.wu@starfivetech.com>

Add timer driver for the StarFive JH7110 SoC.

This timer has four free-running and independent 32-bit counters.
Each channel(counter) can trigger an interrupt when timeout even
CPU is sleeping. So this timer is used as global timer and register
clockevent for each CPU core after riscv-timer registration on the
StarFive JH7110 SoC.

Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                        |   7 +
 drivers/clocksource/Kconfig        |  11 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-jh7110.c | 345 +++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h         |   1 +
 5 files changed, 365 insertions(+)
 create mode 100644 drivers/clocksource/timer-jh7110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..ef9b5f5bad9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21043,6 +21043,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
 F:	sound/soc/starfive/jh7110_tdm.c
 
+STARFIVE JH7110 TIMER DRIVER
+M:	Samin Guo <samin.guo@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
+F:	drivers/clocksource/timer-jh7110.c
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34faa0320ece..2dc97201dee1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -641,6 +641,17 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config STARFIVE_JH7110_TIMER
+	bool "Timer for the STARFIVE JH7110 SoC"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select TIMER_OF
+	select CLKSRC_MMIO
+	default ARCH_STARFIVE
+	help
+	  This enables the timer for StarFive JH7110 SoC. On RISC-V platform,
+	  the system has started RISCV_TIMER, but you can also use this timer
+	  which can provide four channels to do a lot more things on JH7110 SoC.
+
 config CLINT_TIMER
 	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4bb856e4df55..8dc2f0ea2d0f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
+obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+= timer-jh7110.o
 obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-jh7110.c b/drivers/clocksource/timer-jh7110.c
new file mode 100644
index 000000000000..dc770507f209
--- /dev/null
+++ b/drivers/clocksource/timer-jh7110.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive JH7110 Timer driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * This timer has four free-running and independent 32-bit counters and runs in 24MHz
+ * clock on the StarFive JH7110 SoC. Each channel(counter) can trigger an interrupt
+ * when timeout even CPU is sleeping. They support one-shot mode and continuous-run mode.
+ *
+ * Each channel is used as a global timer that serves each cpu core:
+ * JH7110 Timer Channel 0 -- CPU 0
+ * JH7110 Timer Channel 1 -- CPU 1
+ * JH7110 Timer Channel 2 -- CPU 2
+ * JH7110 Timer Channel 3 -- CPU 3
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
+#define JH7110_TIMER_CH_LEN		0x40
+#define JH7110_TIMER_CH_BASE(x)		((x) * JH7110_TIMER_CH_LEN)
+#define JH7110_TIMER_CH_MAX		4
+
+#define JH7110_DELAY_US			0
+#define JH7110_TIMEOUT_US		10000
+#define JH7110_CLOCKEVENT_RATING	300
+#define JH7110_TIMER_MAX_TICKS		0xffffffff
+#define JH7110_TIMER_MIN_TICKS		0xf
+
+#define JH7110_TIMER_INT_STATUS		0x00 /* RO[0:4]: Interrupt Status for channel0~4 */
+#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run, 1-single run */
+#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter */
+#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable register */
+#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both reload counter */
+#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
+#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear register */
+#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer interrupt mask register */
+
+#define JH7110_TIMER_INT_CLR_ENA	BIT(0)
+#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
+
+#define JH7110_PERCPU_GET_CLKEVT	(&jh7110_timer_info.clkevt[smp_processor_id()])
+
+/**
+ * struct jh7110_clkevt - Description of each timer channel
+ * @clk:		Clock of each timer channel
+ * @rst:		Reset of each timer channel
+ * @base:		Virtual address of each timer channel
+ * @irq:                Interrupt number of each timer channel
+ * @timer_enabled:      Enabled flag for each timer channel
+ * @name:		Name of each timer channel
+ */
+struct jh7110_clkevt {
+	struct clk		*clk;
+	struct reset_control	*rst;
+	void __iomem		*base;
+	int			irq;
+	bool			timer_enabled;
+	char			name[sizeof("jh7110-timer.chX")];
+};
+
+struct jh7110_timer_priv {
+	struct clk		*pclk;
+	struct reset_control	*prst;
+	struct device		*dev;
+	struct jh7110_clkevt	clkevt[JH7110_TIMER_CH_MAX];
+};
+
+static struct jh7110_timer_priv jh7110_timer_info;
+
+/* 0:continuous-run mode, 1:single-run mode */
+enum jh7110_timer_mode {
+	JH7110_TIMER_MODE_CONTIN,
+	JH7110_TIMER_MODE_SINGLE,
+};
+
+/* Interrupt Mask, 0:Unmask, 1:Mask */
+enum jh7110_timer_int_mask {
+	JH7110_TIMER_INT_ENA,
+	JH7110_TIMER_INT_DIS,
+};
+
+enum jh7110_timer_enable {
+	JH7110_TIMER_DIS,
+	JH7110_TIMER_ENA,
+};
+
+/*
+ * BIT(0): Read value represent channel int status.
+ * Write 1 to this bit to clear interrupt. Write 0 has no effects.
+ * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be written.
+ */
+static inline int jh7110_timer_int_clear(struct jh7110_clkevt *clkevt)
+{
+	u32 value;
+	int ret;
+
+	/* Waiting interrupt can be cleared */
+	ret = readl_poll_timeout_atomic(clkevt->base + JH7110_TIMER_INT_CLR, value,
+					!(value & JH7110_TIMER_INT_CLR_AVA_MASK),
+					JH7110_DELAY_US, JH7110_TIMEOUT_US);
+	if (!ret)
+		writel(JH7110_TIMER_INT_CLR_ENA, clkevt->base + JH7110_TIMER_INT_CLR);
+
+	return ret;
+}
+
+static int jh7110_timer_start(struct jh7110_clkevt *clkevt)
+{
+	int ret;
+
+	/* Disable and clear interrupt first */
+	writel(JH7110_TIMER_INT_DIS, clkevt->base + JH7110_TIMER_INT_MASK);
+	ret = jh7110_timer_int_clear(clkevt);
+
+	writel(JH7110_TIMER_INT_ENA, clkevt->base + JH7110_TIMER_INT_MASK);
+	writel(JH7110_TIMER_ENA, clkevt->base + JH7110_TIMER_ENABLE);
+
+	return ret;
+}
+
+static int jh7110_timer_shutdown(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
+	return jh7110_timer_int_clear(clkevt);
+}
+
+/* IRQ handler for the timer */
+static irqreturn_t jh7110_timer_interrupt(int irq, void *data)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)data;
+	struct jh7110_clkevt *clkevt = &jh7110_timer_info.clkevt[0];
+	u32 reg = readl(clkevt->base + JH7110_TIMER_INT_STATUS);
+	u8 cpu_id = smp_processor_id();
+
+	/* Check interrupt status and channel(cpu) ID */
+	if (!(reg & BIT(cpu_id)))
+		return IRQ_NONE;
+
+	clkevt = &jh7110_timer_info.clkevt[cpu_id];
+	writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base + JH7110_TIMER_INT_CLR));
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int jh7110_timer_set_periodic(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_MODE_CONTIN, clkevt->base + JH7110_TIMER_CTL);
+	return 0;
+}
+
+static int jh7110_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base + JH7110_TIMER_CTL);
+	return 0;
+}
+
+static int jh7110_timer_set_next_event(unsigned long next,
+				       struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base + JH7110_TIMER_CTL);
+	writel(next, clkevt->base + JH7110_TIMER_LOAD);
+
+	return jh7110_timer_start(clkevt);
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, jh7110_clock_event) = {
+	.features			= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+	.rating				= JH7110_CLOCKEVENT_RATING,
+	.set_state_shutdown		= jh7110_timer_shutdown,
+	.set_state_periodic		= jh7110_timer_set_periodic,
+	.set_state_oneshot		= jh7110_timer_set_oneshot,
+	.set_state_oneshot_stopped	= jh7110_timer_shutdown,
+	.set_next_event			= jh7110_timer_set_next_event,
+};
+
+static int jh7110_timer_dying_cpu(unsigned int cpu)
+{
+	struct jh7110_timer_priv *priv = &jh7110_timer_info;
+
+	if (!priv->clkevt[cpu].timer_enabled)
+		return 0;
+
+	writel(JH7110_TIMER_DIS, priv->clkevt[cpu].base + JH7110_TIMER_ENABLE);
+	jh7110_timer_int_clear(&priv->clkevt[cpu]);
+	reset_control_assert(priv->clkevt[cpu].rst);
+	clk_disable_unprepare(priv->clkevt[cpu].clk);
+
+	return 0;
+}
+
+static int jh7110_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = per_cpu_ptr(&jh7110_clock_event, cpu);
+	struct jh7110_timer_priv *priv = &jh7110_timer_info;
+	int err;
+	u32 rate;
+
+	if (cpu >= JH7110_TIMER_CH_MAX)
+		return -ENOMEM;
+
+	err = clk_prepare_enable(priv->clkevt[cpu].clk);
+	if (err)
+		goto err_starting_cpu;
+
+	err = reset_control_deassert(priv->clkevt[cpu].rst);
+	if (err)
+		goto err_soft_reset;
+
+	rate = clk_get_rate(priv->clkevt[cpu].clk);
+	evt->cpumask = cpumask_of(cpu);
+	evt->irq = priv->clkevt[cpu].irq;
+
+	err = irq_force_affinity(evt->irq, cpumask_of(cpu));
+	if (err)
+		goto err_affinity;
+
+	clockevents_config_and_register(evt, rate, JH7110_TIMER_MIN_TICKS,
+					JH7110_TIMER_MAX_TICKS);
+
+	/* Use one-shot mode */
+	writel(JH7110_TIMER_MODE_SINGLE, (priv->clkevt[cpu].base + JH7110_TIMER_CTL));
+
+	priv->clkevt[cpu].timer_enabled = true;
+
+	err = jh7110_timer_start(&priv->clkevt[cpu]);
+	if (err)
+		goto err_affinity;
+	return 0;
+
+err_affinity:
+	reset_control_assert(priv->clkevt[cpu].rst);
+err_soft_reset:
+	clk_disable_unprepare(priv->clkevt[cpu].clk);
+err_starting_cpu:
+	free_irq(evt->irq, evt);
+	return err;
+}
+
+static int jh7110_timer_probe(struct platform_device *pdev)
+{
+	struct jh7110_timer_priv *priv = &jh7110_timer_info;
+	struct clock_event_device *evt;
+	struct jh7110_clkevt *clkevt;
+	char name[sizeof("chX")];
+	int ch;
+	int ret;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "failed to map registers\n");
+
+	priv->prst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
+	if (IS_ERR(priv->prst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->prst),
+				     "failed to get apb reset\n");
+
+	priv->pclk = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->pclk),
+				     "failed to get & enable apb clock\n");
+
+	ret = reset_control_deassert(priv->prst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n");
+
+	for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
+		evt = per_cpu_ptr(&jh7110_clock_event, ch);
+		clkevt = &priv->clkevt[ch];
+		snprintf(name, sizeof(name), "ch%d", ch);
+
+		clkevt->base = base + JH7110_TIMER_CH_BASE(ch);
+		/* Ensure timer is disabled */
+		writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
+		ret = jh7110_timer_int_clear(clkevt);
+		if (ret)
+			return ret;
+
+		clkevt->rst = devm_reset_control_get_exclusive(&pdev->dev, name);
+		if (IS_ERR(clkevt->rst))
+			return PTR_ERR(clkevt->rst);
+
+		clkevt->clk = devm_clk_get(&pdev->dev, name);
+		if (IS_ERR(clkevt->clk))
+			return PTR_ERR(clkevt->clk);
+
+		clkevt->irq = platform_get_irq(pdev, ch);
+		if (clkevt->irq < 0)
+			return clkevt->irq;
+
+		snprintf(clkevt->name, sizeof(clkevt->name), "jh7110-timer.ch%d", ch);
+		ret = devm_request_irq(&pdev->dev, clkevt->irq, jh7110_timer_interrupt,
+				       IRQF_TIMER | IRQF_IRQPOLL,
+				       clkevt->name, evt);
+
+		if (ret)
+			return ret;
+
+		clkevt->timer_enabled = false;
+	}
+
+	return cpuhp_setup_state(CPUHP_AP_JH7110_TIMER_STARTING,
+				"clockevents/jh7110/timer:starting",
+				jh7110_timer_starting_cpu, jh7110_timer_dying_cpu);
+}
+
+static const struct of_device_id jh7110_timer_match[] = {
+	{ .compatible = "starfive,jh7110-timer", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_timer_match);
+
+static struct platform_driver jh7110_timer_driver = {
+	.probe = jh7110_timer_probe,
+	.driver = {
+		.name = "jh7110-timer",
+		.of_match_table = jh7110_timer_match,
+	},
+};
+module_platform_driver(jh7110_timer_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 timer driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 35e78ddb2b37..4a8b487c327e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -175,6 +175,7 @@ enum cpuhp_state {
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
+	CPUHP_AP_JH7110_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
-- 
2.17.1


