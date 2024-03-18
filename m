Return-Path: <linux-kernel+bounces-105671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E287E263
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB21F2313F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356220332;
	Mon, 18 Mar 2024 03:07:15 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2128.outbound.protection.partner.outlook.cn [139.219.146.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADD1E521;
	Mon, 18 Mar 2024 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731234; cv=fail; b=fJNLMI0S5bCZye3qlUQt7Fr+F2s+4Om1ok0xtF0vj4qE+FUMOsNvVlEABW1rvZyedlhoxrgRQQmg0BDtx8240wFPyzEIBtNjQrqrBG+3aXORRG/MH4W3UpyV1HBphr7yf4uUAdQUke7L6XLJN+iAl5iClyBj6ITE9K4+MtEKKVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731234; c=relaxed/simple;
	bh=wcrOCnz/c0ggSZriD86GKVpS3n6LRRALBA7mtC321eM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOAm9dSDOB+q8vSAOXIhJxnQhpiKyTJSvUYcKTdbNp/mUb8tLFxh/OJRO+hmcLXHl1Ou7TBCxnP0kFAiArHYUcE0sMCdT5/0qTMwkLMIrAXN0YM3mlDbleUyvVybBykm41wH2McE7bzyIm/bYvJLZzKbmrZirDf2rhYcQ2kkUg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izcey+8cFWlthR/WYY6CjXkLTrfqFozfCbHzN5tyZ9Qn/HJJpGRBFiFH2Rrm9LN3T3IV/8wZFVpYYIr3Qoh16axbW3VDBUFPLWJthhri+qJq18QrC883y1BE8SHIeTCqe1KjQjFUwJlca4aFKuRidYBv1Sn8Du4d/rXoOOhiAgfen8SaJ8nUL/A7p4utxkUiuhdoZgSAOn+XKNNrLr65L723vw5zodqYDEM+Lf7Dz+m3s2B8N5hOSDlDvb2vXTkLJc8rJO10SvYR1HSK67SjRT47vGykmooU31ZjK43Ris/yC9Zo083Ogvf8AeYyDpfnJ4yJpK26BXtGWPB1oRK/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8UDMEgJZ35PNkT3i/bAcb7z0sq8Sfn29xy62LbKFEc=;
 b=Nl43lDitbUbmn6uCMPHmwfGiI70WntBMyb/WVnCTpGV5Xi2eqfIZoBFXncMK9CCiKQPCAmbdhvBpdqeVP+ELWabM8kiSI4gdgP6rN2ZKI8d6J0ApfPrMOutNymxCsXOzRQSOoCADGnxa+MtJL4uu1t5GhRYzEaFGiw3oRjwEr626BSy9vL2n1sfW8VAxBbLpy9zACT0suJQ26omCTAWz0b3zVn0mcUUyWKr+ID8Nm/E370ZrofPO87hubEOCSt1cgBE62DhDrASi+S6CMmvkuSJwtz/wmQ0E3WbzhtSciGHpZ6n4NNB9xvtH68hPaKbgvlzKZjghVyw6BZrauuvfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1083.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Mon, 18 Mar
 2024 03:06:57 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::6011:feb9:5761:3880]) by
 NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn ([fe80::6011:feb9:5761:3880%6])
 with mapi id 15.20.7386.016; Mon, 18 Mar 2024 03:06:57 +0000
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
Subject: [PATCH v9 2/3] clocksource: Add JH7110 timer driver
Date: Mon, 18 Mar 2024 11:06:48 +0800
Message-Id: <20240318030649.10413-3-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240318030649.10413-1-ziv.xu@starfivetech.com>
References: <20240318030649.10413-1-ziv.xu@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::11) To NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0986:EE_|NTZPR01MB1083:EE_
X-MS-Office365-Filtering-Correlation-Id: e3aa8a4d-a07a-4aee-ea6d-08dc46f878c1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ppofZb3z4zUcmtA6N5J3pqKvORUsoPxl2KbtVFsVe0oH1hggu7AtfFzvWh4HKaz5VjkZ5yfKbkKx2QgcOZBFWJ+9iCRSwxp0wip6P6r5Ssx9oYgwJekhhgxj1vxS9JA/t+m805Q8dvrr/ATpqetPabeAxa8mzVHZsoQw5DbaV0fZgOqkE2WBv90qBhOmifldl6HLm+fzsqnc3KGI7CrV5r9zx84ssz/MnhcxpGLY8TFXeVpXq3LvJvdVtsHHtlRp7CuZ1jjnHXfkE5ku9+FpzWSPMHmacGkNapO0LEy3CbimISn8z1NUnztp35HQolkj+o5xe6tHUXzasoYCgvCeJXFNa2c51wBfWqDhlm3L8ockuXnFW1plh2MuyADMO9/RHKAeXbiR/Apxtk9msDqRWulimOfr37lpRrQeIlwvII/Hft/iSG4MoBheT3A0QL39TPUeDEC1DzwBn+Xnx6KFk0Qa3p2XkKla8x+QOnQRbPCRffKXKm1XbFm/046OObGy8CnRBj8mhAPproD+qh0djA3qNmba2tGA+pRm48gkiZPH9KGkso6i+dv70S1D+3r0LnkuaN7PoGTe7UuTjkGnSit6F49y/D0xZMv/6zIoJTPvrrCmmgPXX6s20nasH2+u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8j/SI/zV465pXidDX1UoyPNSpAcUjCe4gBxjOE2UhsXZttH93POI+mRmaMy?=
 =?us-ascii?Q?Zatuxp/H5VYyXyPolI+HPxynfxO62luhgolLq42Nj/NZ3eO6rbH2HOItzjvU?=
 =?us-ascii?Q?urqCCPCJrmLrXatr1Yo5xO8nnQGSAyr+RrhBDvXadM9acs9b0eBDExJd/Gsw?=
 =?us-ascii?Q?uTcr8TTFXxiv2a2JGC5e8Sg+PPVdg8RV9SFCpf70XlVNHI0q34PQB8YoFT2i?=
 =?us-ascii?Q?ZzgYK207RFoVh2pjmmyyV3J3XzZkiWT8BuQ66crDPzRzk1khdTEx4p2ikIVz?=
 =?us-ascii?Q?Zbz1LQTdmbTLIdr9+OHBKqIAbDKbpPMv0g2vF4GNT9DX9FU6sBN0gs4rfqql?=
 =?us-ascii?Q?KtEtFn2aCywMbY/nL7oY/YzWPMVX40TTXD/2q9nnfc1Asy9//1Ht0hJLBBvk?=
 =?us-ascii?Q?YEhd/toIMUisKrl8PMhvcT60kunweAS7MPHbqvGE3b6LJhXiDzEhA2Lf6+4S?=
 =?us-ascii?Q?VuVEkQuYMiTcLBs/6lZM1vk+l8R7oTG6CBvLHclbnT4YS8pJujbMIdcymG0K?=
 =?us-ascii?Q?3MXbRNBioWOdhVItXdRg/QWdxFeSZMkB+iwiTu9AbS6757vJVNCCv1Q/KtzC?=
 =?us-ascii?Q?6d3y7hJwpoQh/HNwv+U0YptXMeJu9ITg8RUFeixHKTQNpGqvoWCCT15vew/g?=
 =?us-ascii?Q?9BzgWOGkGeKyIzJl9eUYo++mhFcqkEqOx6idU/bnUDtLJRo+ju+KwtaCvNMb?=
 =?us-ascii?Q?FtV2V0nI9n3Z1nNK9GmsPZc7SoMESGPontvAofkN9ZhBeXbvvqoRoCf3F7c7?=
 =?us-ascii?Q?aWnPh1Bajw97KG894i4qix5uTgVd/sUmhnhdI87Qy3ffaTr8Vlm1S16WVnHR?=
 =?us-ascii?Q?MUJIGKwBXkbZpZ7nKwjo2Ok7VKzuiVBLlyiQ40yWYG36d3VcboV3oVzGffFc?=
 =?us-ascii?Q?C71tUJVbz5kx7AqHgnRkISj8ynUGQM20AWdGNS8NauT2NF4dXKd2mbgQkvjl?=
 =?us-ascii?Q?ZzRQB5YEG7u/wX0NFU5p1RlGo/9cnCyJX/pp/L3tSJnl4tRPGwCjWkcyiIpI?=
 =?us-ascii?Q?ZGlYH3lnXsXSE1JWbA5JPxpweUNm5BbLbC3Jfj/9VwXSWmSxmD8bAYcniYDL?=
 =?us-ascii?Q?Ap4BzfquYbyyRWQYFVhOnYsRrJy9rmjlEE6s3dIUIBAEdvgpNIhh+WPEhH9M?=
 =?us-ascii?Q?oX8UzRuKZC8mVAcWyub2i88yF3kTtD50ZJZxQWxrkBa8lZjj5B834NIUrTOO?=
 =?us-ascii?Q?/JzHu2TOM5hACT+7VGOCLjQDDm3Kjj+uwCs5rIfdPPbCm6kJTwifkoKTq8iV?=
 =?us-ascii?Q?9TrzetdBUtfsfBhWxSd4962ciaB9y8+FBv9//f/l7XWgbpaZqUMEtnMikCQI?=
 =?us-ascii?Q?UmWOieAv5QUqAv4jvKX19xjgBmPE7g4i1Ea9sQkv0q4mFiZxLw2bJsrd+RGM?=
 =?us-ascii?Q?2wKeGRG3nbgWFEoTJTbVA/Xcs5/00GguUFWA052cM1akfOKFfcvv3kWBNxAr?=
 =?us-ascii?Q?ANYzjfYsBOMgZwqVIarfgE+wFbVadShlbwAeLgr4NvHUZxb8nAnmHb+hc92+?=
 =?us-ascii?Q?12Gn39Fa+hvXcFEpN5zLu7N1/dlTHhGJJzBA3Ss3uDUblcnD02rX/yPMLxiW?=
 =?us-ascii?Q?FAHF1G1m4VrouV/wSdFL7QNUkaopiUKn2GhLQq8E?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aa8a4d-a07a-4aee-ea6d-08dc46f878c1
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 03:06:57.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gebml7x0ijEYurvGGBbWbFGFIvZCqKiBHdKXDx/d57OTL9+o1rk8cKZoipa0ZUoIEHkRQw8t+Iy1kPQFxA7vPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1083

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
index 1aabf1c15bb3..181d3fd714de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20893,6 +20893,13 @@ S:	Maintained
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
index 000000000000..9257689c2e8a
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
+	return 0;
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
index 172d0a743e5d..a46f46906c23 100644
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


