Return-Path: <linux-kernel+bounces-142336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC808A2A53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27B51C20D85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E511950241;
	Fri, 12 Apr 2024 09:02:07 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80955E73;
	Fri, 12 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912527; cv=fail; b=kBk/2kYy5RyEzOoN8TubYzKLVTWAJgfY0jGnL9uE0SQrYXqbDgvJ43P/rblyTBUw3Q1EkBRWDTd6PMpTNXNbk0mSDQ2NzpqClnpZsYeSWJEF3Ye7ftVHdTu/2p4IsLHe2BY6Xy9r2cRdG3DUEGe3VVca8U0VRa0DGE2A4oiPXIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912527; c=relaxed/simple;
	bh=oq2v9gCWeFx8LdndXKnnRISPXrKq/y6Qy54hzSTGGRM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZS3HAiUVmCCmoGGMn34oSkH2gXFG5BW0H2HX78HAd4Rcciays3S2+untxmMG/7Kvu07R5Vu/iGDiY7/vlgpb/XGUMv3luo0JKqbrzaUCDIcPqm5tfBTInNenYGwQW/SXX/PLP32gZYKhWNvez9XAlt2/ObvwyDRJ5ZgRmOfIklg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht3JbqbJUsT3kanxepb1XHSqeH+WoXR0OTik4lD+y9Yh4gWelYW17LZjR0KR8imUDbaiJ2UtbGzm4lcpj6oliJGCdwOB9cCEYg/h/EDX10s+bTQcuy1O6/zSome8cUlmzsJ/iRp7FomPVQDZAdRtwjRhk7iJG4CP3++8Zbf1yvY+gCJ1H3wlmP2T++rIj6cdxGsJMPe6pToDtQxVyRzurqznAntQLHNtb7TTyQPiye1Q4AOtxpCzvnOOFIOiEzy8lVslQuQfIB0bdxU9Vccl/dr2D6jz/l9wnbsgvOVKi96jH5KnFSBV6svT5dj4sTznZH00YmcVB2FBrSnUtQTdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNzpdygQBfMKxTe42Cu/s1EdFW1op4TMRhlCfJh+XzA=;
 b=i3/UzeSnu3M5MpZs7249ydNDD7UiraQqAiP8Gi4SuYAPo9OTONLbHHMCiP6ne7kdjmYgKYxGNcuLNTIBmllfy1gu0G3UwNs4e2DqiqMP8odK97fHPdrbdGSz5ChaftdTOJGJFz077ShwJRy9AWOxj8qr0im1rzroKPlXoIaRJg5FXIOu0I4WUaodhy9J9tcdn0M9lig8auUhArvwV3ez/Q3icigFt8WYGvOLVRjhaCFi075Z8W2wKAIkMrJWQQU72nufC0HiurWq5fAy59XDCi3O0sv2UpAJCFcg60KCHT2LE9H5x7/Ij5iYEsS9/jUCPHh5zmd75N12WDpOb5NTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1129.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:45:51 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490]) by NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 08:45:51 +0000
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
Subject: [PATCH v10 0/3] Add timer driver for StarFive JH7110 RISC-V SoC
Date: Fri, 12 Apr 2024 16:45:40 +0800
Message-Id: <20240412084543.7243-1-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 6512790c-846f-45d0-dd43-08dc5accf506
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kazuBHqqI5AFbXg2wb2vXAOqh5xJ59H+lt2QlyuSrqpCSG/3lpWxaI7RLwDU23fQByywuB5IZxj5Xj57PveUlXRHj03+22RumUwdxx/ZtGfn9qwl9EI0tXGy4gm8/BxM4STkwjpch/1/zNQfTBlumfttagI11C/xmmIwSkI3pUF6YkMRr4ulzeBOeh4xh8k45xSRggRxa2S/gE6IB2CifcrMzEY19Y/awofpo4yY4agV59w08CJYFhono/wCBsoD95p+gJVA3g7d/fj970ZAlH2f/6/FqfWi+Bpl5bK7h+FwgQGxJ88RTSuile0t7NXQXXfHaKS1KR+uACFbOeMMsqR7O54yh3lv1/ziTBrlNeldph6+DrFLHmTP2tHT4wfAKn6Mp+z0LdOvTRRNH1h0rP9grtu7jjVPaX8I5V2bW9o0KHgY923+Nf37nf3opFYMQ4DkEMONvVOA2/U4rENq6VkL3z9ZY9hQ97k8u+xk4eRkmcfGhI7VjXsNEywEFhYnt3kYOL60W3j3o0SmT/X5eyHPqSzAUtq6+LjnUOujrUGv7E3ziAtiTz1hZcsZj7MxsjElAR/iQWpT2gOWM3P5dh7/mHQwVjD0g2nFRw4eyyh+6JlDoqlXhBCIKOeEcqFZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(366007)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K/rBKC2XGp3NFAwwu5u8RwOKYMY2w4uRoOZZ06BW3OfqdbC/II8g1wDCr2mg?=
 =?us-ascii?Q?XcflDXNqXrVMjlCrfQ9Em6eMiWyne+DKdY8A75GqwTM5logJMuwPviPIaiK6?=
 =?us-ascii?Q?mOno+yNsyFA4KY4ie0MLAQ2xxTL3yC6d8L8XuCc2pqnpoHJCWy5DmuHGfmXP?=
 =?us-ascii?Q?UZGSSFkbE5gWFLJOZx8FEjaGAhlL5WWzrV19LOpEsYUF0uwTiobhBf0PbHVj?=
 =?us-ascii?Q?xest/5/e46EEFG6DgqrKPG1U4XmSuzd8pu0BdfY8xjOKGwbTGIPRBEohmQkt?=
 =?us-ascii?Q?uq0TM6Vs+mr2LHyjoRgGeUtVpXkY9UD9wm3c/8CnbLj503trGrwhIKkwi2dC?=
 =?us-ascii?Q?tLZX8ZWitX58hCeKdUCDiayi0ZsU3w/TLB82uhv82IML7ebwlpNsqaxIJJ1p?=
 =?us-ascii?Q?Ia+9umjSQzoc7ndFlQeuis8AQ/HuBvN1WmYYqwEEzHL9u4Cnxuq2ufN0kIkh?=
 =?us-ascii?Q?SSzootjsVSubXzdhRz5WGV3tbZwtHaLoAS+eFRmWujDqcslsg1qR26uwBUrx?=
 =?us-ascii?Q?Uta8i0ZH1SgBsYoB5Us83wAmlR27isPHhYs4hOebcI1Ch0p9/rygrq4DzZsL?=
 =?us-ascii?Q?b8D96xm6vZiVKS704Cx/12nUCp1au6tklyPrBSiDxQYDzvO7+03rI4iXMWrm?=
 =?us-ascii?Q?YvXm1h47Pdf+zwtMAr0Ob2SZIVxrdPG+YeyA0bVZxf8y85cMPtNKLmuJ6DI8?=
 =?us-ascii?Q?0SU5Ty+DGeW8jgQvqNcw+CoE3Uh7fF2BbnddZB00vBQvjKQiKJBYkCVkB4Bo?=
 =?us-ascii?Q?P9d2OL88KeeeiIkD8ABDxd7EGxmXNgF9+gXGw898JrxCaBWx81XUtm9U9c7W?=
 =?us-ascii?Q?heIlFT2GMcPpXMI0vSwQ9oNv87pC29pBefUc1UiUDkBQbMk2Eez1clVdAPRz?=
 =?us-ascii?Q?I/ek6S4d8rTBqt1ATtXJP2zeJypZ/pGJ3aZxAjdymtTnG9/o4ZVo3f/EDsBb?=
 =?us-ascii?Q?DzQGGFLEiwir0z5Tq8z/l+wr/57uW42BlDPwz7ffXC3koLFAurPKn3Qte9A5?=
 =?us-ascii?Q?BhsG9wuCYDujBNVXhzGnBYulusYfBe99xW+p7+t4vkmehKHpGFfpys8DJLuj?=
 =?us-ascii?Q?OvmJyRHWPc7vtTAySXsTGKzaPIhmvsAuOeqlB/WAdTPSkUPqEOxePpUP1tDK?=
 =?us-ascii?Q?lKto+IE+4UGbSLcj2/uqd4OHs2X4BejaeexmrO82+JhnNd3dK5rE6rqum1VV?=
 =?us-ascii?Q?bfghKQt09JBgQnv70Dk1Ue2TS9K6y0MxueLPFE5tW8KP0Vt+pHhXC7VE0IaI?=
 =?us-ascii?Q?r7B/b46LlSOKgZY1S5ZV0/lmfFfXATtXwnwn1ivMGo22smlpk+vHwLk07k94?=
 =?us-ascii?Q?qdBdXLFNEsBR1SFxJ7ELaDH0CRJVRoRWNpX777f+ZzaGnilnRTppB/Vi3wvB?=
 =?us-ascii?Q?un3azFf/hDjLwiEbA8oejO5mPLkZT+Ob04OVgsTGkLsGTAl9FA5n6eIhJxGK?=
 =?us-ascii?Q?gHvTkLNP1csNZNJA6IL7HaTcSxx8AZT/0ltsU8kQJjgcmJjhVBbN6ieE1vXH?=
 =?us-ascii?Q?kZMAYnvcDVOajoANIBawjg7siVDCPXKSDIioEEe2e7hkqxUB78HisFZf0S0v?=
 =?us-ascii?Q?TOXd4nuDlfsNQAwdid3CeRR7vAay6qK8uQHfcwPpjbbePi1IGI+j+UK2GDqv?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6512790c-846f-45d0-dd43-08dc5accf506
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:45:51.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EGtevnFkvHIAH0lQY8UOGFgBaVXTrFfoETaEyFePhyby7KBwW+lI9bJdOF8+awh+tXgiqBOq3L5zbWaTwI0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1129

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

Changes since v9:
- Rebase on 6.9-rc2.
- checked the return value in the jh7110_timer_start function.

v9: https://lore.kernel.org/all/20240318030649.10413-1-ziv.xu@starfivetech.com/

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


