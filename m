Return-Path: <linux-kernel+bounces-72422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5D85B310
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D1B20849
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC3959B79;
	Tue, 20 Feb 2024 06:44:28 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B656B8A;
	Tue, 20 Feb 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411467; cv=fail; b=WGmPBti+c9hptRK9hSnCMOTprguDELVzpr8UuWFsKAGrHFV7b5si4ar3f4EfZN8izdsDvU0+xO/weY/NAChscw9i9TSFJ3trd16r8a/yhHSj8yhqT0LaOYG5DuzWQgU60liCKe0hWl6zcC3++jklp9xy5+6ZmiQxSEkb6oxj5Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411467; c=relaxed/simple;
	bh=E7Fyc45QaIXbuB9FZC/IKYLW6yNlidJR89fdQiN3vu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPtjlPtDU47cpPN732WjT9e5m8wgvd5moRSVo6Nk0roW2UblWRMHfGVSVMs8zN6GJZ2aRsM5QTVicQj9gJ84g+e6JAZP0k2ooVFZHKlflA4u1WtnmChNd2M2f1r8WuoISZf/UNnPtQJwM08IGstPTGqVMXfTptC7PHnJfjNIBcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9yOY1mvTEL8o4cQarDTX6tloxd4p7tAbW97C2M1PqCnJ6qRn+ohesijkggMGYLZT/cgJ6+b9DgGX26Igr5AOhmVBb3FZG0OjDjmV5OSbORDiH5u3tOlauAdkN/TIYpfoRG0qMn2VB4n9wsVOy3z3HYBMtsL/03MwIy7YA0YzYViqb/usXO1tZqPBFfZZPTnY92tYqIOkNlh5Tek9vAbZ1xcruAjwGmsf96FMbyi8c92ZDrRmOulYjsnqRgOtMF5yubszZf0QN3rLZdLYdOoGRFnk8AteU1a1mqzOX5EG8zlqkhQQ/zrrz+xiNr4DZc52m5I2V+83ZP399Tnvgyx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ME+CxejWGcwvddfb8Y1nqhfte9R9xA3PCjUBwVIoAw=;
 b=X6K6Fm+S4z3X9HAcMACBIpSDVf2nSKFcgmHrYiJktPKJkPXnShJK+bkPj2z2Io3LEAPBz5GG1l1X1VvXvQZ6EIvs8bQQmFk8kfGBhEsVf/dUIWBnoglO5mLffRbV9vl03/NEhBiMh363kZnL9+5HETwJNAh545sHQLDgfeoYyW2hWPP/8xJQA/r5cbOCzyAy1bAmeUw57bPZgEWN0JhXR9UaAxfu/YAfeTNjWej/37+6ein5+KY4vImlKZrLXgJMnrOxt0Gsw5X00JjdJdudV5aqsGEu3Vmk3XnhZKl0IouqDF5ZDVtmZvv1huaPgKGGuueLw4xZBydhUvf2poHACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 20 Feb
 2024 06:43:14 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 06:43:13 +0000
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH v2 5/6] pinctrl: starfive: jh8100: add pinctrl driver for AON domain
Date: Tue, 20 Feb 2024 14:42:45 +0800
Message-ID: <20240220064246.467216-6-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c5e447-22b5-440d-80ba-08dc31df363a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tsBYEFFmF3ZOg1lxUvb00+8KEOTm/b+VGQv5J5+y/XHH1/Q4eDlPk5jJDhw6cfNS9eQGtqT5fkb2MbMEOed2sQxDUnLg/XKb2vKXLS+3xQ5npeqp0AlAJfouHoObauIZ2Oi70tMvC+LZG8VZlYEjOK/2NdIFerfc+EMz2wU/jw0ZNpkxRc1G5jS7aOR2Ci4mVhjfpRW7TrPobzyA3xceHD/Yp+5ZfsOc0LUL1cJRu77USQ+7EkZzdN1z0sZy4nuEAr4SXiPVDm5ugZJLqlWGDjkWXgQzjyLdQhsvcdJRDoiTcsY1ueNqzZG/u63PwJI89Tw3xWp9sIsDhY3DsoNk3O7vOJkJp5K745pdKiNp7i585cVw1h2J0Wwxber3gEi2gIJgIJLVAPdVvRwu0psvZ14023DmONg5DBGaOgJiUOv0DsmSEgLLOTGXN1yzw7QTSHuq2ApKd63UplkoQUFfngpGIHF5wsvZjI7/gUjKupS/IlKrwh2cYR2W1sz5vUbf4WCAfGLCnGni1tyBmxG02cEbKa/utyKN/CuWVlR3oga40CTOyGW+5ZK8CfP37QCMCvDTz+LOCYeZwuV+DDBrzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4f/r3yo6w8UHknZC//B0IZfjI+VAG6JCnmsqO7tP+0kNOL6k+0Mz3LJYalz?=
 =?us-ascii?Q?ytmKhGnDjgfzN8vlYTd/0ucoCzzY/6w74lJrQXq1BxoRqogdl7HZ0HCGVVSZ?=
 =?us-ascii?Q?9u+Op5G1U2+68EiGLfJ7Dx6BkHgWsIvrVk24gz+euENTT269KzGu4m6GWZLw?=
 =?us-ascii?Q?PQEr0p2jL6P6APqjS32wtWv1Q62B8lly0jKRAktyyfsBSpVz1+x6KNfUIegS?=
 =?us-ascii?Q?sO1YcHcbggOJIpduou1LPg0mOq1U8L4t1PjTSFpAi7+0URwDlJQsK4GQQ4T6?=
 =?us-ascii?Q?41N/HTHwV4DXXppkyjiV9MiB/CSjgSkdInAsACGrO99s6vNhTRYl8+FTLh2h?=
 =?us-ascii?Q?LjaTFmXQUtPLyvKanNJ3vOxbA7wzz7BwSEcxEFxfd6Vm/A/PxJUtIA3oJug1?=
 =?us-ascii?Q?7p2i5cCel7p8sQfxE0IAOF9T3pEImtwPOB6SDRtKLi907VlvmF95yI8m5miD?=
 =?us-ascii?Q?cC8j9kfZiuoplhwLYMYsYmRD2tBz4mBivqQT57R8siZAvm7hsGSiSHk8U1QX?=
 =?us-ascii?Q?b2we0qgqstuWsX0O4aQh07UDtHsh3fh/W6hvrgzp0PVPDemmyGN4Hdi1jFzO?=
 =?us-ascii?Q?WCuEDHny2VxvHg+Q7P1GVvmC+rra+zWjODkwZvS0nHpnlguZIOP2vYZks8Jc?=
 =?us-ascii?Q?9jccaghemnJ9IYPpvctcpBTbRm2DTz1v9hA6PcjX9Ep9rJaMwgb4M2M51F3p?=
 =?us-ascii?Q?eQDjP4Ki9fQLDqAE3R04etPmR0965juLPu852zCTIvQF3LDszok5jCAqlIUv?=
 =?us-ascii?Q?Z5CTQgMzdBd20Q6FzPrO6D2Ms3OeGKzBjHOviSltp3El1TmqJuhsl4Vy9shT?=
 =?us-ascii?Q?LvpzZhAZe8vmE40jYPwVcPT+K2G0bDsbUHHbFqLQr9xKB1GHXHV9tTUVFdq2?=
 =?us-ascii?Q?YO1zTDWq5WB3HmjFhlU9n6npM9V3uUcnriZN8uzhbgi9trtZKmhSlHH3TxVW?=
 =?us-ascii?Q?uG1O4+seUCjXaIDMFXA92dmpwz9WYqQut3Owrn3ZQMTdjRExV4NtFDvubhez?=
 =?us-ascii?Q?FwoUi5j5rwqgHjithvwk2F57ny2DaUofZefJwiszlLfFBVLpNZ86eM/mXSzz?=
 =?us-ascii?Q?I/0+3F0ImupKTBrmSwWUbfQgIjJBAe68EwRgQUEMAYMvNIRuDLKM7WwC6ylb?=
 =?us-ascii?Q?U2wJriKeccL1NvAapzcIYgJ9srNK094hB5W/ae7w9kNwbWAZNtxLpZwAS2Ed?=
 =?us-ascii?Q?EXA0kIgN/tQwNFwyjR9deKGPrgE0F+j1RS+Uk5CgYjOFd1sTFBmQtsL15FEJ?=
 =?us-ascii?Q?f/iqxhTX9pcVHue5MJlMzlcS2QpQjhQ2In/3LenWvWq2VHpoVINcXrLmehVr?=
 =?us-ascii?Q?62FfBHcKvXmk5/IGFeI9MPCRXfrj80FEkHwhz5nDvxaeZtM0W+M7DbLRGxA/?=
 =?us-ascii?Q?mjDJSfu84GXB1Hs5Fc9p3jaqfXfq3OJPLZmAu1C8aZC1IaUqqLzl/I9oveyk?=
 =?us-ascii?Q?APuhoIkHzuKcf+vDTTOvgfFMkYTWBQLnm3Cl29JgxH2gLFIdXgu/z03LRqpG?=
 =?us-ascii?Q?0NwP/EVKQcH2FTwbHPDucTiQPAyLcbVdtiiX0GZvLjlifBLJ4YQh/UEdsXXR?=
 =?us-ascii?Q?49DXrVxPsMBvRoF1kFxKRf8G6TwYPWaBeW8sxKhHOtwBqe21zH+nd6LXNRfc?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c5e447-22b5-440d-80ba-08dc31df363a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:43:13.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHAT71YZuyZpDvyY09RJ7wpSFnzLSAzxWkBNUrF3xD38h9GxghBFx5lvk4gEe+qLCHW1hYlMxReqBFuSIldsPTuH3msKZWphCRgudIAXVNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

Add pinctrl driver for AON (always-on) domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/pinctrl/starfive/Kconfig              |  14 ++
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../starfive/pinctrl-starfive-jh8100-aon.c    | 154 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   4 +
 5 files changed, 180 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c

diff --git a/MAINTAINERS b/MAINTAINERS
index beb219107d8c..fa8d2bbb4e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20975,6 +20975,13 @@ S:	Maintained
 F:	drivers/reset/starfive/reset-starfive-jh81*
 F:	include/dt-bindings/reset/starfive?jh81*.h
 
+STARFIVE JH8100 PINCTRL DRIVERS
+M:	Alex Soo <yuklin.soo@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pinctrl/starfive,jh81*.yaml
+F:	drivers/pinctrl/starfive/pinctrl-starfive-jh81*
+F:	include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index bc123c0bf35e..6c448837f5f6 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -94,3 +94,17 @@ config PINCTRL_STARFIVE_JH8100_SYS_GMAC
 	  This provides syscon registers to indicate voltage level on SDIO1/GMAC1, to indicate
 	  GMAC1 pads voltage level under different GMAC interface modes, and to configure
 	  GMAC1 interface slew rate.
+
+config PINCTRL_STARFIVE_JH8100_AON
+	tristate "Always-on pinctrl and GPIO driver for the StarFive JH8100 SoC"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support always-on pin control on the StarFive JH8100 SoC.
+	  This provides an interface to the RGPIO pins not used by other peripherals
+	  supporting inputs, outputs, configuring pull-up/pull-down and interrupts
+	  on input changes. And also, the syscon registers to indicate voltage level
+	  on eMMC/SDIO0/XSPI/RGPIOs/GMAC0, to indicate GMAC0 pads voltage level under
+	  different GMAC interface modes, and to configure GMAC0 interface slew rate.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index 236a693a8aef..46b1ab97779b 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+= pinctrl-starfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+= pinctrl-starfive-jh8100-sys-east.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+= pinctrl-starfive-jh8100-sys-west.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_GMAC)	+= pinctrl-starfive-jh8100-sys-gmac.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_AON)	+= pinctrl-starfive-jh8100-aon.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c
new file mode 100644
index 000000000000..0f4a75f3c632
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC aon controller
+ *
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_AON_NGPIO		16
+#define JH8100_AON_GC_BASE		64
+
+/* registers */
+#define JH8100_AON_DOEN			0x00
+#define JH8100_AON_DOUT			0x10
+#define JH8100_AON_GPI			0x20
+#define JH8100_AON_GPIOIN		0x54
+
+#define JH8100_AON_GPIOEN		0x34
+#define JH8100_AON_GPIOIS		0x38
+#define JH8100_AON_GPIOIC		0x3c
+#define JH8100_AON_GPIOIBE		0x40
+#define JH8100_AON_GPIOIEV		0x44
+#define JH8100_AON_GPIOIE		0x48
+#define JH8100_AON_GPIORIS		0x4c
+#define JH8100_AON_GPIOMIS		0x50
+
+static const struct pinctrl_pin_desc jh8100_aon_pins[] = {
+	PINCTRL_PIN(PAD_RGPIO0,		"AON_RGPIO0"),
+	PINCTRL_PIN(PAD_RGPIO1,		"AON_RGPIO1"),
+	PINCTRL_PIN(PAD_RGPIO2,		"AON_RGPIO2"),
+	PINCTRL_PIN(PAD_RGPIO3,		"AON_RGPIO3"),
+	PINCTRL_PIN(PAD_RGPIO4,		"AON_RGPIO4"),
+	PINCTRL_PIN(PAD_RGPIO5,		"AON_RGPIO5"),
+	PINCTRL_PIN(PAD_RGPIO6,		"AON_RGPIO6"),
+	PINCTRL_PIN(PAD_RGPIO7,		"AON_RGPIO7"),
+	PINCTRL_PIN(PAD_RGPIO8,		"AON_RGPIO8"),
+	PINCTRL_PIN(PAD_RGPIO9,		"AON_RGPIO9"),
+	PINCTRL_PIN(PAD_RGPIO10,	"AON_RGPIO10"),
+	PINCTRL_PIN(PAD_RGPIO11,	"AON_RGPIO11"),
+	PINCTRL_PIN(PAD_RGPIO12,	"AON_RGPIO12"),
+	PINCTRL_PIN(PAD_RGPIO13,	"AON_RGPIO13"),
+	PINCTRL_PIN(PAD_RGPIO14,	"AON_RGPIO14"),
+	PINCTRL_PIN(PAD_RGPIO15,	"AON_RGPIO15"),
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_aon_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(sfp->wakeup_irq);
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		sfp->jh8100_aon_regs[i] = readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_aon_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(sfp->wakeup_irq);
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		writel_relaxed(sfp->jh8100_aon_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_aon_pinctrl_dev_pm_ops,
+			 jh8100_aon_pinctrl_suspend,
+			 jh8100_aon_pinctrl_resume);
+
+static const struct jh8100_gpio_irq_reg jh8100_aon_irq_reg = {
+	.is_reg_base	= JH8100_AON_GPIOIS,
+	.ic_reg_base	= JH8100_AON_GPIOIC,
+	.ibe_reg_base	= JH8100_AON_GPIOIBE,
+	.iev_reg_base	= JH8100_AON_GPIOIEV,
+	.ie_reg_base	= JH8100_AON_GPIOIE,
+	.ris_reg_base	= JH8100_AON_GPIORIS,
+	.mis_reg_base	= JH8100_AON_GPIOMIS,
+	.ien_reg_base   = JH8100_AON_GPIOEN,
+};
+
+static const struct jh8100_pinctrl_domain_info jh8100_aon_pinctrl_info = {
+	.pins				= jh8100_aon_pins,
+	.npins				= ARRAY_SIZE(jh8100_aon_pins),
+	.ngpios				= JH8100_AON_NGPIO,
+	.gc_base			= JH8100_AON_GC_BASE,
+	.name				= JH8100_AON_DOMAIN_NAME,
+	.nregs				= JH8100_AON_REG_NUM,
+	.dout_reg_base			= JH8100_AON_DOUT,
+	.dout_mask			= GENMASK(4, 0),
+	.doen_reg_base			= JH8100_AON_DOEN,
+	.doen_mask			= GENMASK(2, 0),
+	.gpi_reg_base			= JH8100_AON_GPI,
+	.gpi_mask			= GENMASK(4, 0),
+	.gpioin_reg_base		= JH8100_AON_GPIOIN,
+	.irq_reg			= &jh8100_aon_irq_reg,
+	.mis_pin_num			= JH8100_AON_NGPIO
+};
+
+static const struct of_device_id jh8100_aon_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh8100-aon-pinctrl",
+		.data = &jh8100_aon_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_aon_pinctrl_of_match);
+
+static struct platform_driver jh8100_aon_pinctrl_driver = {
+	.probe = jh8100_pinctrl_probe,
+	.driver = {
+		.name = "starfive-jh8100-aon-pinctrl",
+#ifdef CONFIG_PM_SLEEP
+		.pm = &jh8100_aon_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table = jh8100_aon_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_aon_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH8100 SoC aon controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 4652885feaa2..b4042a7f7936 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -16,13 +16,16 @@
 #define JH8100_SYS_W_DOMAIN_NAME	"jh8100-sys-west"
 #define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
 #define JH8100_SYS_G_DOMAIN_NAME	"jh8100-sys-gmac"
+#define JH8100_AON_DOMAIN_NAME		"jh8100-aon"
 
 #define JH8100_SYS_W_REG_NUM		44
 #define JH8100_SYS_E_REG_NUM		116
 #define JH8100_SYS_G_REG_NUM		19
+#define JH8100_AON_REG_NUM		65
 
 #define JH8100_SYS_W_GPO_PDA_00_15_CFG	0x074
 #define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
+#define JH8100_AON_GPO_PDA_00_15_CFG	0x90
 
 struct jh8100_pinctrl {
 	struct device *dev;
@@ -37,6 +40,7 @@ struct jh8100_pinctrl {
 	unsigned int jh8100_sys_west_regs[JH8100_SYS_W_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
 	unsigned int jh8100_sys_gmac_regs[JH8100_SYS_G_REG_NUM];
+	unsigned int jh8100_aon_regs[JH8100_AON_REG_NUM];
 	/* wakeup */
 	int wakeup_gpio;
 	int wakeup_irq;
-- 
2.43.0


