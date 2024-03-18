Return-Path: <linux-kernel+bounces-105678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECE87E27D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C581C2106D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B44720DFF;
	Mon, 18 Mar 2024 03:21:59 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F681E533;
	Mon, 18 Mar 2024 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732118; cv=fail; b=qhgcvwNgWQAgPIyeK7ZTulp48A3RFmP88cehf9nLaZIAWi+aWlNDEDKE0LI0dcdGq7W9vietdQOCFYymxYL+8Xv6yVNrR5ScD6+v+6giMVKoR11i09xkwaaYhct9ROR6JOCHsn0FhssMpljnTOr+aQD3GbmWq4HJkpGKrtbCgRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732118; c=relaxed/simple;
	bh=GDmzuyemaNl2X+PBQww46ALDo/1u2wyCEPcGCgGLjX8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VWqPe2y56pKYaGoCw04xs4rRNKjhalnFcyiaACwAyLdNuhMX377k/LPqAhTvQy1rWGD949TmhbhgOkRAN0Zbwj/kHiFwJ6F7/J6wlH0PgWEiD80ZSq4RVQ4hW3ke4VzUDopugO5EdalD5A0Uzv0RrCJIN6c1QVbvjiTYvX8iPJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwfLP3p0ltYKXzin3sUL/ZXTX42F+0wMieiBeZQy2dztkFJL0Yry9cMO6WJyFTkV5ndb64Cv4kJoSmE7twzh47iK5JcLO6p24bOSZ9uTHX4cIHa1c/2YylmN5c3/HUAN7PDA8gBEqqoPIys8EZPawZRY8cNqjLKxuMXAWNiRiO0jS+QVhDdHQBXXF/LFykr4zhfVNnMqjg6d7hc1pMvNqLDJ4tBO0HfoJ4k4562KD9PKFapOqGJM2n0PjzZzHTJ/TytckCxI/Q/BRUGXRdVAH4hHbgQf9t4CiQO5hsXgw5+bJZk74Fl4LvhCtXzBupoR8Nm5CZgbU0SkiFooFrFryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swPeyA+PKTAiWrzqgwY3vv7/xM9a+gOEIvhedCiaNFQ=;
 b=iYLbzyunAViSCCUPZQMng6jBFxAMBc0+f9CxlePSQPkFH/Z0Dz3Y6dwfV5W3c/DtGNfL1D/ItuXBKwyygoIiZFnHFNWp+dX6+XIFfucMcK/9yeLfRzL9AP+nw4mjSBF7yN2a/1y7cshef0J6OpwKYBvJGcH+vnGhGX9U9da+viNyXtgb/PVxpT0CEKZHUYQ5jlyLUKWm0ZenQf7rEcmEWywpB96HQ8ZgWuv+vXVCCdVEDq58hyoLWtYJ81HSbglgShnzb6p+0ogac3kTc5EliVpA5vfUTPzeAsmEixX6ef+wD2mrx+iQ3N1306UiSCmUkanrhcLOgVypEL7fyD0Ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Mon, 18 Mar
 2024 03:06:55 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::6011:feb9:5761:3880]) by
 NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn ([fe80::6011:feb9:5761:3880%6])
 with mapi id 15.20.7386.016; Mon, 18 Mar 2024 03:06:55 +0000
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
Subject: [PATCH v9 0/3] Add timer driver for StarFive JH7110 RISC-V SoC
Date: Mon, 18 Mar 2024 11:06:46 +0800
Message-Id: <20240318030649.10413-1-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: NTZPR01MB0986:EE_|NTZPR01MB1018:EE_
X-MS-Office365-Filtering-Correlation-Id: dc63e279-3889-4c33-2a4a-08dc46f877ea
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WiJ4x3ZFQJA/xSXsRCrmA0Xbya+3ZCUxkh5HCNpVCKQP1htckOCEDsmDpqiizrB/pxIlqETe/jwJb3SdXyq0s32Oy9yWfkJN5yIe9op0K9IEsNybNTRGUIzZ7GeggneJ0iszYU+eob3quOHV020m9TpDxPeq8/dQnl1lmW5uWrPEQ/h/Gxl7mHou6p5Q1ST0V1cIF1qlUcD1Ly02sx/GfJGjxir3kRaVQy1WQ2epmjmwLs8eBfg9v5YxBTQ8Flclwal/s6MpOU32tYRyqQV9vOWaNv5mbXep60RRTndTQEu8JNACkW8XEMN3628Df3oxQDD9rSuYlu8LyCa/3slmFKo92Phd8CkCCAxseoAR6OIXobbk0FoD2lpweJdG6SXMxAnps5vkBbbcOxfY6hGcONy0G7Hba4UYRu/0vglsvZxjbc/sZ2AG58G3/1B107Czs0gUXtTcNFIuzG39hol7ASkY3Bk739iVo7/6MVGMxcU4EkRSwQ12oQJblOPNisJSlQNJ0J28yXPeUc2/yRwdpc8rQxUog5R6CYoDA67VRnCE1E9NhoY5gf0PYrtL11udQ+nVaKd0gapHc6rNOwnpm7QfgvgXHHJj/fj4cP5Kt9I9aK8ZpQoe21vrxL9WbUlP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sftG1pJs++jYcSg1x+XIm++XK6TjhxGxCh5Y4QnnH1VYHzMEI5cA55vyKpqe?=
 =?us-ascii?Q?5WcAWzj50NrxZcyAjw2NNfNuS3bPZsWHca5HQo3kofR/hQQ1zqyKGe/2wl6D?=
 =?us-ascii?Q?w59xfgQ/G+5/1tOEVymXgXaMsUERsZKYPCKoDXXxrB+yfUxP7m7NCKlk09LK?=
 =?us-ascii?Q?YhJC69+N38Lfl0k4F0pWqT4peI8oOvWgxLvVr2GMeukXbHhWUQms6f+GkTJ6?=
 =?us-ascii?Q?mbShddA7qEbfSoFYqMaDXYLmSj6rxjJda9c1pioIvkxj7tA9B5CSjrzqubGz?=
 =?us-ascii?Q?w9cqBXYe+vGKqzNTF0k7OLR2VlGAS2S2mkmC6LnqMVYawhcG4EMey2ee1xks?=
 =?us-ascii?Q?lJD+haCeL55eG0y787JUM4NHHS7jg5HcWzBAZqLJSaAzhMWDuwrEtIZHnbOS?=
 =?us-ascii?Q?hkPQ5LU8GURA2N0alAKScHhQjec6jAQGK4bk3LlE32X7RulNnQ4alsUZ7nsg?=
 =?us-ascii?Q?il8+UCCzjW684tXQ3mirqz4T/H3GIBJeshtdIdDLG5JWA3Ka/f9iBvjHEByS?=
 =?us-ascii?Q?IWA0o69ZJZF4uRY312GgcAs8EhYxvixQ6HK9GAXw1Da/vegq2VCatoBcYxbH?=
 =?us-ascii?Q?RBKIbTyP7DtE7hSPcyiXyXZQn9PtzXFema9or+HNQhUGT+vpamYszPWgs8VZ?=
 =?us-ascii?Q?ttxiTrDWuJi2EJliiGPXWo377ZULICP7fW6N/7fCMd522AUhebpziJwTH6V5?=
 =?us-ascii?Q?csQxaaOHVe62dTu2Ajva1wfyi4+m9f3WkGgmCTVIrKUen82Pf/oxaxV/r8s+?=
 =?us-ascii?Q?NDbbhuzLUjMxJN/BPCHBqYb50fLtLvHBRb4osFUeMUhwwxCWJxXcitSt2wAz?=
 =?us-ascii?Q?qtZue5OEpwgCK9/3Q/cM0he/ziOid4icdqCwU7scGdFB5bxJgeo2Ovi78euL?=
 =?us-ascii?Q?kHm7k0YP9C0xfWD6aSw9cfidJAGk8R39Colz8dC+XqKpXU+JbrYsH8WERc40?=
 =?us-ascii?Q?eOmcNqFfcDp44jHzkjN8yQ1Id7XTER6u+tkbp5zz862EU5ZwZBLPSAAEIKRf?=
 =?us-ascii?Q?n+gjTcxL8OCgoMBvyaZ2Cxxkdj3qTHVkuFNl+r0h/dt7VIFLdV8oYHmyH7n3?=
 =?us-ascii?Q?YhrBR+QbolrxZY/yo21hMmKkoJAHDRDV3erqetKwA/yV4PCRQC3SsxKvnYn7?=
 =?us-ascii?Q?Mb/MV47RfcYN8g1mL07J9h1n2oOtSuUGvzHb1DsSXDO4iCshJGwwc4yA67zg?=
 =?us-ascii?Q?bhxwKEmxikbSccEfjYPY0V/3NfW4JNresy4ckPqwFdUmFvyVuVqk1l+wLl3j?=
 =?us-ascii?Q?EP51t71/pbD0I9dhzmGG9b4EL115XmOrsxxjj5O8O7p7GIQ13Q14/BXOSMtd?=
 =?us-ascii?Q?vabdZ5gYS9/bmROj/0Zp7W1YGXOynvMFGEyeEM5o5Sc3wRyaEPXoqU7sRII9?=
 =?us-ascii?Q?yP7grGF6LarnfHSXTlJp+laYRCMAHAJEc/WG4ZarQQuLjuWECiEGYVDAHxWt?=
 =?us-ascii?Q?CobNglxeg/1haK4sBE4m7JrRqn2sxKCITr7Wa41DvS50f918yT6ZkZuluE32?=
 =?us-ascii?Q?A02okfh6l+ICLh6TMMKQ0TjuHUdJIJeNYewqrWvaBs4e6USsT/jldGUFfzdA?=
 =?us-ascii?Q?JSumAuUG13riEgvroTgLcBmYEibtJt+m7pRLFDBn?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc63e279-3889-4c33-2a4a-08dc46f877ea
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 03:06:55.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js3fz5fKyKklulkES/nI6ixRbpUKbiqTSwvsu84R/fSRigNn6IBrw9AI/9Wplrzhk2tPyd/Aa+znjvjo5eK3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1018

This patch serises are to add timer driver for the StarFive JH7110
RISC-V SoC. The first patch adds documentation to describe device
tree bindings. The subsequent patch adds timer driver and support
JH7110 SoC. The last patch adds device node about timer in JH7110
dts.

This timer has four free-running 32 bit counters and runs in 24MHz
clock on StarFive JH7110 SoC. And each channel(counter) triggers
an interrupt when timeout. They support one-shot mode and 
continuous-run mode.

This timer is used as global timer and register clockevent for each
CPU core after riscv-timer registration on the StarFive JH7110 SoC.

Changes since v8:
- Rebased on 6.8
- Improved the cpu hot swap startup process of the timer.
- Modified irq request timing to prevent sleep.
- Deleted clockevent suspend and resume function and these 
  operations are included in cpu hot swap operations.
- Formated data structures.

v8: https://lore.kernel.org/all/20231219145402.7879-1-xingyu.wu@starfivetech.com/

Changes since v7:
- Rebased on 6.7-rc6.
- Modified the Kconfig file and added selection in SOC_STARFIVE.
- Used the timer as a global timer and registered as clockevent
  for each CPU core.
- Dropped the timeout function in the interrupt handler callback.
- Changed the way in the functions of jh7110_timer_tick_resume() and
  jh7110_timer_resume().
- Dropped the registration of clocksource in the probe.

v7: https://lore.kernel.org/all/20231019053501.46899-1-xingyu.wu@starfivetech.com/

Changes since v6: 
- Rebased on 6.6-rc6.
- Used sizeof() instead of the numbers of characters about names.
- Added devm_add_action_or_reset() to release the resets and 
  clocksources in the case of remove or error in the probe.
- Added flags to check each clocksource is suceessfully registered and 
  used in the release function.
- Dropped the variable of irq in the jh7110_clkevt struct.
- Dropped the wrappers and used enum definitions and writel() calls
  directly.

v6: https://lore.kernel.org/all/20231012081015.33121-1-xingyu.wu@starfivetech.com/

Changes since v5: 
- Rebased on 6.6-rc5.
- Changed the number about characters of name.
- Made the clkevt->periodic to a local variable.
- Dropped the variables of device and base.
- Used clkevt->evt.irq directly and dropped the extra copy of irq.

V5: https://lore.kernel.org/all/20230907053742.250444-1-xingyu.wu@starfivetech.com/

Changes since v4: 
- Rebased on 6.5.
- Dropped the useless enum and used value directly when writing
  registers.
- Modified the description in Kconfig.
- Add the reviewed tag in patch 3.

v4: https://lore.kernel.org/all/20230814101603.166951-1-xingyu.wu@starfivetech.com/

Changes since v3: 
- Rebased on 6.5-rc6
- Dropped the useless enum names like 'JH7110_TIMER_CH_0'.
- Dropped the platform data about JH7110 and used the register offsets
  directly.
- Drroped the useless functions of clk_disable_unprepare().

v3: https://lore.kernel.org/all/20230627055313.252519-1-xingyu.wu@starfivetech.com/

Changes since v2: 
- Rebased on 6.4-rc7.
- Merged the header file into the c file.
- Renamed the functions from 'starfive_' to 'jh7110_'
- Used function 'clocksource_register_hz' instead of
  'clocksource_mmio_init'.

v2: https://lore.kernel.org/all/20230320135433.144832-1-xingyu.wu@starfivetech.com/

Changes since v1:
- Added description about timer and modified properties' description
  in dt-bindings.
- Dropped the 'interrupt-names' and 'clock-frequency' in dt-bindings.
- Renamed the functions and added 'starfive_'
- Modified that the driver probe by platform bus.

v1: https://lore.kernel.org/all/20221223094801.181315-1-xingyu.wu@starfivetech.com/

Xingyu Wu (3):
  dt-bindings: timer: Add timer for StarFive JH7110 SoC
  clocksource: Add JH7110 timer driver
  riscv: dts: jh7110: starfive: Add timer node

 .../bindings/timer/starfive,jh7110-timer.yaml |  96 +++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-jh7110.c            | 345 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 7 files changed, 481 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
 create mode 100644 drivers/clocksource/timer-jh7110.c

-- 
2.17.1


