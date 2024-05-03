Return-Path: <linux-kernel+bounces-167654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC568BACD0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C3D1F21D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC2153584;
	Fri,  3 May 2024 12:49:32 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1A1534E7;
	Fri,  3 May 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740571; cv=fail; b=sOkYj1bQyRGBV30Ly2Azd6S8ZG2fgylOWh+/WBPBJdsuKdz+Fr3xuLO3odGSry4aT+Jo6x3XumHKNnzFp7+pEz6NIn9fwxQAOAqeywKU6a3wMau7BxVHUj38yqn42dRdhYr24YnlSlVReqBLkNh0hF9lm/f0HdGU3QpcgWFSjKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740571; c=relaxed/simple;
	bh=b0+Y/H4T61Q/T2VkWr6mLoegIZnSoJJuLeH9xqrU4V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l41TMMJxOJR2+tslVtH+rISWdUs4MvMBf7mhOGDuufNh8vUT0Zgw2eiM0XNTqPThv5lSqr06IUGx0rxMGDmEx+GKfeXgMAs8UvwSV4CzTJ7fjpUgBdiQEsZpZIQRhhQJmS7mUP5awRY27FTZGs57LkcCUo6WBavJFqXfaKu7XTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc6emfCmmDOaSNi28/XZ36qJiEN5xlMtx7/4sBurXVbKkGtA3bFXuU9lzuLB056zPlcEtIodUikXz+S3XcJk3tWN1capU0umaZQRMt3V5Z6jTRj5S57zS3lRw4rQIrc1dY82q9JxUp56tSr/uAxayB3HAuMCYjzhzZHpYfKZpt1Hcya7Pe2mLCLWgptMpmh7/7tQZNJ0vzO2AZI4XacuZeVkHgAtkNYd4uSrk+fJUIGaHjq7x9sX0ciWytYPMPlUtrT6cUZ+4T7GiK4tjtR+oVKpxtRRRuAs3RxX4bvU6LVGI61LVQ5XhhW/pTUQ9P9CGfORjfE85zzDoVtpBEot7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4jb7iFCnA3QDskpBV8VGbbtzV1NunIi753ciHo9LA8=;
 b=PBpisGU65Dt0urmk38HKq1cOhgFwgIAjGhsPAhQWQ17Dc/ApwHlXSuSeK7jPPOWkEq30ipyUR979Ib7pBfewcme1UxrjG8SLBwR42sZSNRQaWcHjQH5eiE6lv2cYXdpRzc9ThnoNNnW/mtt+qCNtp1ugHxt+A54ydfmKf4psqx9OyzTPi9dcf5G3X/7rDWYIqqqunZh30aq+g/So79OPejhWnVpdtWr8CeezvUftkq0oNn1naGqwfRRCF8CxHTCAe86e/gss9of1nxj0ngvIvu/sZbbiFo6FVPe3WIDyoRwwBZmsbneWgUalfguRYEwLf3A155k6CB+MfrnkOAJGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1238.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:14:56 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:14:56 +0000
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
Subject: [RFC PATCH v3 3/7] pinctrl: starfive: jh8100: add sys_west domain sub-driver
Date: Fri,  3 May 2024 19:14:32 +0800
Message-Id: <20240503111436.113089-4-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: d12fe879-e9cc-4afe-dda7-08dc6b62434b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U51KBppsyaMNg4IC/g5pQ90fRSAsK09+VMlb7wgqPrUbA0we6UjC66YazeXvxFGDHq3CZ2hTIWz7Jr3xG7qouQ1tcNdJhgTPuWberl5PiTdeKajc0yfWzJc55DdfIynBOql/Wi68Rq4iCjXgR1MCoK5Beu8U2ryb7X+lhIvNgbtnpbnjlNexC0oEFZMandGll61BAn/84D2z+gOTRz5a1KqkaV2YqiFiKwwo+d8lay39tzssnyHjnozz/qnT0HxugIuu4VhjYt/F9903X2GjKMYHloFlu5kh8GDljSpyFU/dqtnk9AxpWlUqVMS7fR5aSkYVsyfEdwzttFm//DzfKtDBVzhos8m3SZB0iFgLXGAD2PDq2rnX68w9pQsKcPB6461ET44Lh5h+p9hlTDEylvx91L2a4ush5brBsyGUxawdNmqgCmSy2v+adwjk+gOXEzeOfpPj6J+FSL7utUIJ8wohyXWANENC4z+myq4A/b//fyGNup9iq/KJt1BEcg1rPHSDgKGvZLH6wnwUDUHShaMyEqM7Qh42Eeu5gQn/GOVh39E231BYCPidBYcgj+n2nGjSPZaIx4CxPWDqlFOfZwhsd0aZ2DLx06RvSskkHz+4Z8lkNeJuoHRmGVF2bexw4b+5myLW4u+9tXvJPMiZ7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(7416005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xw0xFhWEZzb3s9qqQ9Qj8DWMV/5Nev6px5oGNZTna1FQcp3sGVNG8VQ0TgnY?=
 =?us-ascii?Q?x0+yKyi8/COoKKNMKJoXgmKq331eUpEBqXqCYToCFT0aWvvkj2hjxb37linx?=
 =?us-ascii?Q?fMjKZ0xGnIMDDP9MV7x4Sfu5Lq25s/GREACNucEg9DxulkW7haSrypkdAu8c?=
 =?us-ascii?Q?3omiXBVUPMRFKcMwiMtKxMZ2j7KytfkVsBvvEg/bNbllVY/v7pN2tnqMy/yL?=
 =?us-ascii?Q?o3Qi9xGbBQorOflXPSAg5s2DripEyOGl9pEU+MZMKU3CrIJq94BmnDQlP3Is?=
 =?us-ascii?Q?YpZEGQL0BfJjGjdJBTzXYQbwP83dsz+brI30ibI5qke8VdmYgVJ7AjOizM55?=
 =?us-ascii?Q?KY/zOFxfKaFznsJauK2PjvA00699CIMJf1HTy47BY0lTFnEnXQGvdCo5lYKJ?=
 =?us-ascii?Q?iK3bAiGuuQq/1R6dCfh0dPj5EltL+lMSTB0VyiJg5BhZI/ndRE2n5NZrMHvE?=
 =?us-ascii?Q?XKNlFJUU7riMTvU07GZzO73rgUm7UL/mx5pECBRabU88jZkcDolRuxm8RlKf?=
 =?us-ascii?Q?m1a8yV5X+hHWPjR1ezQev1e6cZeFfBNWZwAwgizAKuruwPkRl0INeH80FbGt?=
 =?us-ascii?Q?jOzUyfvxpm0B25VPzIcR1WIgPe1pFHzIuwxF1/4r2Ik+icWAX1vmkMM6Ycia?=
 =?us-ascii?Q?2Yv59evcqt+KixIASWpVZmVs/EiNxKIP5+Yea4PXr10ayt7feRuRkeUt5OWq?=
 =?us-ascii?Q?Zyt+mfw89NxsdqR7xbRzWcAvivr/nPKGRBEdKoPo9ifEMcYjWJOEw7Rx3k6S?=
 =?us-ascii?Q?iXj1kOOqTwNCXELxvW9m+rfZPecOydFlbgyHuz5WJ9dc89mgFQducMGDrT7/?=
 =?us-ascii?Q?2o3jjpEdSspuzFAl9vQpLPjU6JB302GRoJbQectorBvNcHNIkSljV7kVRblv?=
 =?us-ascii?Q?Z5BsFZ67q9yNmbJ8L4EIQhyUfzncZN70DZRjb3Q3PFMymf7218PBFQVD/rec?=
 =?us-ascii?Q?dka4M/HJRURXj1rO/rFRSB365J/ytJipaRNwWuDbCDrgymymYKYLTTufzKlA?=
 =?us-ascii?Q?6PJSRbu2apwR9e2VLMqGqFOOvs0a0jtSfcyn+XnRX0+DU1mqsBK9FbUQKUjv?=
 =?us-ascii?Q?sVu8xOA8HinFGxOjbDowEbb4Xm4CC53e3f2eI/vAcxqC8cGKMMQxx5p3VNPK?=
 =?us-ascii?Q?+TOHST97yLPHdx9V9BeagiX4QdfP5+Caf/66jFowOzb6qHkF2/p16osgftQ3?=
 =?us-ascii?Q?CzFXr5LsGUqAz817X2q4SdN+427m9tr91IjxDp+0a/1uCPMs1w6iSVfQS6VA?=
 =?us-ascii?Q?60wCLv5walnPpmxCkmNfuGQgQAJJV885fzUTA57fQRPJjB8deRVB6OapQM7j?=
 =?us-ascii?Q?BMkpDPv+QmIdXWRnnnaZpK9xuXRaUMDdIRowAssFcjxORmA4YuRTuT2YtwwZ?=
 =?us-ascii?Q?MnQ3obYEg6b1XTuFTxVsnYGeGPliDzF4y0J+IsgxbOjZowhv66XsWZg+6SZL?=
 =?us-ascii?Q?gypLNcDVW2yxpKAx4BsPqemDDlpAx0IBsMqsynwvlexspGGmIA6VSqs9CNLZ?=
 =?us-ascii?Q?V84/h8GATz9dfWtg8FDPGKlShgVYOeZvdaWuPwAqQOd15cgVOpmgFzrb/lWd?=
 =?us-ascii?Q?Nnc5/yK6OnvqQs/8HFH/McaJfrqjTgNauTcqOI6N3icCbD9ATb1bkcjsLNMV?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12fe879-e9cc-4afe-dda7-08dc6b62434b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:14:56.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXFjiYlC6YSZd5Xk7hS+bK4jGc6fY/Zpdc27ERRDV9PKQxWEk4Js4js+IfaaoiVk6QjRZGhFd0anXwImHASt0vjOFkwOMo76teJMdxseruY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1238

Add sys_west domain sub-driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |  12 ++
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../pinctrl-starfive-jh8100-sys-west.c        | 164 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.c        |   6 +
 .../starfive/pinctrl-starfive-jh8100.h        |   5 +
 5 files changed, 188 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index afcbf9d4dc8d..d78f161a636c 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -70,3 +70,15 @@ config PINCTRL_STARFIVE_JH8100_SYS_EAST
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100_SYS_WEST
+	tristate "StarFive JH8100 SoC System IOMUX-West pinctrl and GPIO driver"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-west pin control on the StarFive JH8100 SoC.
+	  This also provides an interface to the GPIO pins not used by other
+	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
+	  and interrupts on input changes.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index 45698c502b48..784465157ae2 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+= pinctrl-starfive-jh7110-aon.o
 
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+= pinctrl-starfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+= pinctrl-starfive-jh8100-sys-east.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+= pinctrl-starfive-jh8100-sys-west.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c
new file mode 100644
index 000000000000..b97d89777aa3
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys west controller
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
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_W_GC_BASE			0
+
+/* registers */
+#define JH8100_SYS_W_DOEN			0x000
+#define JH8100_SYS_W_DOUT			0x010
+#define JH8100_SYS_W_GPI			0x020
+#define JH8100_SYS_W_GPIOIN			0x068
+
+#define JH8100_SYS_W_GPIOEN			0x048
+#define JH8100_SYS_W_GPIOIS0			0x04c
+#define JH8100_SYS_W_GPIOIC0			0x050
+#define JH8100_SYS_W_GPIOIBE0			0x054
+#define JH8100_SYS_W_GPIOIEV0			0x058
+#define JH8100_SYS_W_GPIOIE0			0x05c
+#define JH8100_SYS_W_GPIORIS0			0x060
+#define JH8100_SYS_W_GPIOMIS0			0x064
+
+static const struct pinctrl_pin_desc jh8100_sys_w_pins[] = {
+	PINCTRL_PIN(0,	"SYS_W_GPIO0"),
+	PINCTRL_PIN(1,	"SYS_W_GPIO1"),
+	PINCTRL_PIN(2,	"SYS_W_GPIO2"),
+	PINCTRL_PIN(3,	"SYS_W_GPIO3"),
+	PINCTRL_PIN(4,	"SYS_W_GPIO4"),
+	PINCTRL_PIN(5,	"SYS_W_GPIO5"),
+	PINCTRL_PIN(6,	"SYS_W_GPIO6"),
+	PINCTRL_PIN(7,	"SYS_W_GPIO7"),
+	PINCTRL_PIN(8,	"SYS_W_GPIO8"),
+	PINCTRL_PIN(9,	"SYS_W_GPIO9"),
+	PINCTRL_PIN(10,	"SYS_W_GPIO10"),
+	PINCTRL_PIN(11,	"SYS_W_GPIO11"),
+	PINCTRL_PIN(12,	"SYS_W_GPIO12"),
+	PINCTRL_PIN(13,	"SYS_W_GPIO13"),
+	PINCTRL_PIN(14,	"SYS_W_GPIO14"),
+	PINCTRL_PIN(15,	"SYS_W_GPIO15"),
+};
+
+static const struct jh8100_gpio_func_sel
+	jh8100_sys_w_func_sel[ARRAY_SIZE(jh8100_sys_w_pins)] = {
+	[0]    = { 0xb4,  0, 2 },
+	[1]    = { 0xb4, 12, 2 },
+	[2]    = { 0xb4, 14, 2 },
+	[3]    = { 0xb4, 16, 2 },
+	[4]    = { 0xb4, 18, 2 },
+	[5]    = { 0xb4, 20, 2 },
+	[6]    = { 0xb4, 22, 2 },
+	[7]    = { 0xb4, 24, 2 },
+	[8]    = { 0xb4, 26, 2 },
+	[9]    = { 0xb4, 28, 2 },
+	[10]   = { 0xb4,  2, 2 },
+	[11]   = { 0xb4,  4, 2 },
+	[12]   = { 0xb4,  6, 2 },
+	[13]   = { 0xb4,  8, 2 },
+	[14]   = { 0xb4, 10, 2 },
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_w_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		sfp->jh8100_sys_west_regs[i] = readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_w_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp = dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i = 0; i < sfp->info->nregs; i++)
+		writel_relaxed(sfp->jh8100_sys_west_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_w_pinctrl_dev_pm_ops,
+			 jh8100_sys_w_pinctrl_suspend,
+			 jh8100_sys_w_pinctrl_resume);
+
+static const struct jh8100_gpio_irq_reg jh8100_sys_w_irq_reg = {
+	.is_reg_base	= JH8100_SYS_W_GPIOIS0,
+	.ic_reg_base	= JH8100_SYS_W_GPIOIC0,
+	.ibe_reg_base	= JH8100_SYS_W_GPIOIBE0,
+	.iev_reg_base	= JH8100_SYS_W_GPIOIEV0,
+	.ie_reg_base	= JH8100_SYS_W_GPIOIE0,
+	.ris_reg_base	= JH8100_SYS_W_GPIORIS0,
+	.mis_reg_base	= JH8100_SYS_W_GPIOMIS0,
+	.ien_reg_base	= JH8100_SYS_W_GPIOEN,
+};
+
+static const struct jh8100_pinctrl_domain_info jh8100_sys_w_pinctrl_info = {
+	.pins				= jh8100_sys_w_pins,
+	.npins				= ARRAY_SIZE(jh8100_sys_w_pins),
+	.ngpios				= JH8100_SYS_W_NGPIO,
+	.gc_base			= JH8100_SYS_W_GC_BASE,
+	.name				= JH8100_SYS_W_DOMAIN_NAME,
+	.nregs				= JH8100_SYS_W_REG_NUM,
+	.dout_reg_base			= JH8100_SYS_W_DOUT,
+	.dout_mask			= GENMASK(5, 0),
+	.doen_reg_base			= JH8100_SYS_W_DOEN,
+	.doen_mask			= GENMASK(4, 0),
+	.gpi_reg_base			= JH8100_SYS_W_GPI,
+	.gpi_mask			= GENMASK(4, 0),
+	.gpioin_reg_base		= JH8100_SYS_W_GPIOIN,
+	.func_sel			= jh8100_sys_w_func_sel,
+	.irq_reg			= &jh8100_sys_w_irq_reg,
+	.mis_pin_num			= JH8100_SYS_W_NGPIO,
+};
+
+static const struct of_device_id jh8100_sys_w_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh8100-sys-pinctrl-west",
+		.data = &jh8100_sys_w_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_w_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_w_pinctrl_driver = {
+	.probe = jh8100_pinctrl_probe,
+	.driver = {
+		.name = "starfive-jh8100-sys-pinctrl-west",
+#ifdef CONFIG_PM_SLEEP
+		.pm = &jh8100_sys_w_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table = jh8100_sys_w_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_w_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH8100 SoC sys west controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
index 4b68463ff5a5..8c3e4a90d68d 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
@@ -333,6 +333,9 @@ static int jh8100_set_one_pin_mux(struct jh8100_pinctrl *sfp,
 	if (!strcmp(sfp->info->name, JH8100_SYS_E_DOMAIN_NAME) &&
 	    pin < sfp->gc.ngpio && func == 1)
 		jh8100_set_function(sfp, pin, func);
+	else if (!strcmp(sfp->info->name, JH8100_SYS_W_DOMAIN_NAME) &&
+		 pin < sfp->gc.ngpio - 1 && func == 2)
+		jh8100_set_function(sfp, pin, func);
 
 	return 0;
 }
@@ -410,6 +413,9 @@ static int jh8100_get_padcfg_base(struct jh8100_pinctrl *sfp,
 	if (!strcmp(sfp->info->name, JH8100_SYS_E_DOMAIN_NAME)) {
 		if (pin < JH8100_SYS_E_NGPIO)
 			return JH8100_SYS_E_GPO_PDA_00_47_CFG;
+	} else if (!strcmp(sfp->info->name, JH8100_SYS_W_DOMAIN_NAME)) {
+		if (pin < JH8100_SYS_W_NGPIO)
+			return JH8100_SYS_W_GPO_PDA_00_15_CFG;
 	}
 
 	return -ENXIO;
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 6eb4f1896a90..7c7a05c1c828 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -12,12 +12,16 @@
 
 #include "../core.h"
 
+#define JH8100_SYS_W_DOMAIN_NAME	"jh8100-sys-west"
 #define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
 
+#define JH8100_SYS_W_NGPIO		16
 #define JH8100_SYS_E_NGPIO		48
 
+#define JH8100_SYS_W_REG_NUM		44
 #define JH8100_SYS_E_REG_NUM		116
 
+#define JH8100_SYS_W_GPO_PDA_00_15_CFG	0x074
 #define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
 
 struct jh8100_pinctrl {
@@ -30,6 +34,7 @@ struct jh8100_pinctrl {
 	/* register read/write mutex */
 	struct mutex mutex;
 	const struct jh8100_pinctrl_domain_info *info;
+	unsigned int jh8100_sys_west_regs[JH8100_SYS_W_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
 	/* wakeup */
 	struct irq_domain *irq_domain;
-- 
2.25.1


