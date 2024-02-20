Return-Path: <linux-kernel+bounces-72420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83F485B30A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736051F22706
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEA52D79D;
	Tue, 20 Feb 2024 06:44:22 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA8186F;
	Tue, 20 Feb 2024 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411461; cv=fail; b=neEulHUFAyoiO0QnLVFZsk388rBmXTG6TgtaZiOoKYFaIa86GRTFaLvLF23PCINWzCjlqIyFiD41fCQCw3zyFuuPgyl6EjJ39c3mCQjlXlVbmoGEvHGtPPeMiLirzhJ3pOA023H/tHH+Nf3od6vEnFec+TVez8SyMFKCzofSOzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411461; c=relaxed/simple;
	bh=tvDfIHBKeOAAMReIBRbX/fM+2+2qmDKEbquJ7oBeUF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5ymrqIlhyyMTIEwwrQxTeUwOWQ4vK0KpQ9bIeRmcm2k5kuVQJ3EPEQQoOYQSm3/adZhDqaBsYipHZ0hdOzfFa3HgkAHQtXlhQgv1QErRFaPUWwzSgw0iY4jSWfU/dmMXJNeyCAy7wyB73//aeBT5IUSUe61Mv8V2pGxDf3dEMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AurWyJFzYK0TBJN7kSTID15wnsFTtfoP2WAAA6bd6ciKFvRnS/cC1ij07qqa7zEtHzhG09p8yUNPVVk6DFO7KEAZBuBQbQzgd3maKPpieS+IdhMMPRghw6ffKoZsilcIww1EbDkAAYTg50dBhabTAN7m1H7gqOHUXheF+8mbsL/Gkyn1Kn/mN93pqiqJIpNShfDhrUv5jLvF+lD2bAFsnf0GVsK2lsmIbz2wNHnRlHMJqbGjCKjVRa82iPR46v8EuZ8L9p64HD3QXLZEumQWcPaTHpI1Xp3bFDzASW31qN5bUmCAOfEuhQ3785bG+lL8KgfAdGwBri2eB3hUOUbEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkHW2dhT8C5P2CS97e6m94pna1V8koDUyMxCGBYomc4=;
 b=Qo7oOWoQJJMAVu2NaxsnA6Y1SIkpgPBxElGPgcK60YRixt3ZZOkeuAMtwGzddtkyUy/WH2kBBba/FUbhTelSXRIvd/rz8pbDF4GUh+gpLQYiNLjATZaWvdnXfhi1tPtlmIaIV1SH1uNZ5Hj9KOSwECuKLGLrs6YCXRnYF2zkYciFNkHjQVlaa4KUOO1rWR7vx7WeNAnCGfu2CEw/Ry//Fee6gaoRJLrEq773hPdNCPfVWerGlSVTVZhnv46X1190WZU5hRxsv+oj88vDSOPPOmF8QH5wNytCNXpmiZQ4YbMT9h7CCV3FH+elPAZEAL9sxtBVEHy2w/4TutyxNoA6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 20 Feb
 2024 06:43:07 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 06:43:07 +0000
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
Subject: [RFC PATCH v2 3/6] pinctrl: starfive: jh8100: add pinctrl driver for sys_west domain
Date: Tue, 20 Feb 2024 14:42:43 +0800
Message-ID: <20240220064246.467216-4-yuklin.soo@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d11f398d-35b5-49b2-b758-08dc31df3280
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oIXgILgYiNOMepGCbQ3Qa4BbZpTYwuTKHpwaotffRA+j7mgcB5JPOCHFbUtg9gHyV6SmVjLTQXpwO26qa0oKeyMp7TRzdwJMZrtmK7G0ICyST5jbLRZ9rT0dRjyZtrSBCmP5pG8YfYTK7XzSyUAOHHYZ7Bp3ZLWmRKyG0kPVClUf+VNsaXu59UTEebZ7m44EKBAEElkXUtk9JSRuBNI22O8fcoKSNrhteTzdJpJSUYXfHJb9fmJBZVPW/3GTF0mgOdOrRrhQtf7h6/yocxzFK2vqo7Ha4PJb24+lTyvvCcY6UHecRnL4g6oJ454V4b0rOPoDUD2TA1v4jsy3BP2D761XRhNAC8yGY0uByhEH2ON6sJqGTKFIGUl+t6JPhA8ViM0+vZSRr+znMZq8BOdMXZg9sW1Zd1oIzsvYN24Rw08l0mUjywTo2yaoNhqsTaLBhdjlyOxfgwptGbpToy0sSoNybEbKx94xLYfltuAoo0/McDHWW1gbG1T15j8pnf4p0uV5/jTdoGAssLQ33CzyNTUOnGNp8hWTjuTYlQjj5NpeWLUVwfDiUzXWZXURUQqTQugWsEZUePEOmlC/Akkwfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3U+Cun4r2K8PtwAMrqporU3888lFMucT8Za1ApE8m96tI+F2lC+/7AqhiYqb?=
 =?us-ascii?Q?RcFW5z4ifzfmXfChgdkOqZJ8NYu5w5CQSADpctljYOBNa77TCemhfTXnMeGZ?=
 =?us-ascii?Q?88tXFebNuKVTR4/UwZXkPToSb6m7L82PYn+rBxjj3PRNuT++L8qeU/gEuR06?=
 =?us-ascii?Q?/XYKlxUk2LBBSwUTAewx2EV+ghqkDzoE0NFuGteiPSKnYU5b9Rc68wq3e/5g?=
 =?us-ascii?Q?Ya/PDeDzOtWB36Dx+ikCc1NBzC8kIPyThIBbUhVDonGU2KG1vDy+srKJQshz?=
 =?us-ascii?Q?V+5PWQYfJyeStSLqBqorFREcmhlstO7iFUoTacscbXlSUSEOuc4jFThONWE6?=
 =?us-ascii?Q?F/Cfl0xF8pPdWnUVfVKKlQaQ568WPKW3qzW7mBCQFhfdn79DarDwUh6e4AEh?=
 =?us-ascii?Q?4BUCNoxWz38l9mbxYxtjTR2yRbCKDYdUlOMw/fVkorbJliBgy8FHm1pcpyAr?=
 =?us-ascii?Q?Mq+ZRLW9TCWDQrcRmhYtOvh1Lm/wiLkO036WpjNQt2j5FvzMQq0Z6U2jtrNw?=
 =?us-ascii?Q?3METi9gnzziTFSH5h3QCPAG4i0NAEue0Py8Jnla/iUOnjtDkRQ1XB1IIfvY3?=
 =?us-ascii?Q?XQdDYCTAuDznJ53QqWVRTh06O6GBahCwMOymH6spFQuYyMs7AftnNtDHcHI6?=
 =?us-ascii?Q?J6QmgsVdawrJR7y3Kl11hvexH9kdHvP6WENyS8/RljSlJYZ30lqMe0Vpo6/8?=
 =?us-ascii?Q?6H9Qk+RWvp+j6p1JOGne2U+ZKZhA/1ep7RN+J/UzBOn47T70GpWHI9U1q1So?=
 =?us-ascii?Q?OPmp/q7O+eSuLyGOqDG/yKG204jcDZQQbcajhQzoAH2/4ywMVZ7fWi5A9bEG?=
 =?us-ascii?Q?HWp94xoq7D+9qNWsGFV068nKhbQWRxNNuMSm1ae/vUq03Lu3X4Yh5rski3VR?=
 =?us-ascii?Q?6jMHF5lE2q8Tck3IhPdMGdHpjbS1NHxi8M5e95ULSEUKSeWJQ3IvF9ghvY7W?=
 =?us-ascii?Q?g9RKblS7+ElCX+aDrMyyNcUFwcxkmCE7ZBUNajizieXjcjZaFUgjS14HiYfH?=
 =?us-ascii?Q?XRC5yEtBgJBnBagkP51CiaDoZWTyKhDOzd11tbo+9C/AiVFs3CwTfdWXIHcM?=
 =?us-ascii?Q?WRvKlAhHpIVuYEvkFXpJ904a2pCsg57/XAwxjqn1dPbSF61x9UnRfJrViY5E?=
 =?us-ascii?Q?J+hQjLfMf0TmphXtrHGyWAYZ5kIMVR3h1D5DTOgxIlz6S0ISSC9htbUvprt7?=
 =?us-ascii?Q?Ie5708tkJPKrqxvmlKptPBGTEctRfknOXFkn5Hhqugys34wtyUMfYAGxwhDY?=
 =?us-ascii?Q?MhQQb3DNC4nxG7RdOvfcdDRmV77jWiqhso0PJQ1t+Le2/ikFQYqeXjFmG9tZ?=
 =?us-ascii?Q?crVh6FvzODNtK6MX5tfIsXg9k2mfYVqzK8tH+k2t79BLpKAZ47exrpACofMu?=
 =?us-ascii?Q?+yhJtPdGOQUhmF1RKfFDm4XuD6XQoVx+iCh6ge0AsEDsGifUoE3eb4Kvy7qZ?=
 =?us-ascii?Q?Vpk/AhlcvAQNx/IEDYwgcMgR/9SkO9yNwmpW0CMgosamacF07JGy+KUngfQC?=
 =?us-ascii?Q?TV5s+0bUOpUaDRltKcCuNvihQDbBJhVrClKppQNJOwiyxmmcxQGkunnL+d9K?=
 =?us-ascii?Q?PuBSBPQe/4/ZLkHleR8JHC53wjWHJfHA0GzwkbP/tQq3QIGXwj530wR/Koos?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11f398d-35b5-49b2-b758-08dc31df3280
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:43:07.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vF2NG+eBeb7w/FjYOBBPOoinaeSp2AzHj8X5XA/erCzcFYp1jlm+q3wl/SGJvHm6kjQItccdsdgoeAIkDMJziXuCh4GHtbhS3SdPBzIwrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

Add pinctrl driver for sys_west domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |  12 ++
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../pinctrl-starfive-jh8100-sys-west.c        | 168 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   4 +
 4 files changed, 185 insertions(+)
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
index 000000000000..0aebb30596af
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c
@@ -0,0 +1,168 @@
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
+#include "../core.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_W_NGPIO			16
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
+	PINCTRL_PIN(PAD_GPIO0_W,	"SYS_W_GPIO0"),
+	PINCTRL_PIN(PAD_GPIO1_W,	"SYS_W_GPIO1"),
+	PINCTRL_PIN(PAD_GPIO2_W,	"SYS_W_GPIO2"),
+	PINCTRL_PIN(PAD_GPIO3_W,	"SYS_W_GPIO3"),
+	PINCTRL_PIN(PAD_GPIO4_W,	"SYS_W_GPIO4"),
+	PINCTRL_PIN(PAD_GPIO5_W,	"SYS_W_GPIO5"),
+	PINCTRL_PIN(PAD_GPIO6_W,	"SYS_W_GPIO6"),
+	PINCTRL_PIN(PAD_GPIO7_W,	"SYS_W_GPIO7"),
+	PINCTRL_PIN(PAD_GPIO8_W,	"SYS_W_GPIO8"),
+	PINCTRL_PIN(PAD_GPIO9_W,	"SYS_W_GPIO9"),
+	PINCTRL_PIN(PAD_GPIO10_W,	"SYS_W_GPIO10"),
+	PINCTRL_PIN(PAD_GPIO11_W,	"SYS_W_GPIO11"),
+	PINCTRL_PIN(PAD_GPIO12_W,	"SYS_W_GPIO12"),
+	PINCTRL_PIN(PAD_GPIO13_W,	"SYS_W_GPIO13"),
+	PINCTRL_PIN(PAD_GPIO14_W,	"SYS_W_GPIO14"),
+	PINCTRL_PIN(PAD_GPIO15_W,	"SYS_W_GPIO15"),
+};
+
+static const struct jh8100_gpio_func_sel
+	jh8100_sys_w_func_sel[ARRAY_SIZE(jh8100_sys_w_pins)] = {
+	[PAD_GPIO0_W]    = { 0xb4,  0, 2 },
+	[PAD_GPIO1_W]    = { 0xb4, 12, 2 },
+	[PAD_GPIO2_W]    = { 0xb4, 14, 2 },
+	[PAD_GPIO3_W]    = { 0xb4, 16, 2 },
+	[PAD_GPIO4_W]    = { 0xb4, 18, 2 },
+	[PAD_GPIO5_W]    = { 0xb4, 20, 2 },
+	[PAD_GPIO6_W]    = { 0xb4, 22, 2 },
+	[PAD_GPIO7_W]    = { 0xb4, 24, 2 },
+	[PAD_GPIO8_W]    = { 0xb4, 26, 2 },
+	[PAD_GPIO9_W]    = { 0xb4, 28, 2 },
+	[PAD_GPIO10_W]   = { 0xb4,  2, 2 },
+	[PAD_GPIO11_W]   = { 0xb4,  4, 2 },
+	[PAD_GPIO12_W]   = { 0xb4,  6, 2 },
+	[PAD_GPIO13_W]   = { 0xb4,  8, 2 },
+	[PAD_GPIO14_W]   = { 0xb4, 10, 2 },
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
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 920cdd8b6376..92d3b5d6de40 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -13,10 +13,13 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 
+#define JH8100_SYS_W_DOMAIN_NAME	"jh8100-sys-west"
 #define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
 
+#define JH8100_SYS_W_REG_NUM		44
 #define JH8100_SYS_E_REG_NUM		116
 
+#define JH8100_SYS_W_GPO_PDA_00_15_CFG	0x074
 #define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
 
 struct jh8100_pinctrl {
@@ -29,6 +32,7 @@ struct jh8100_pinctrl {
 	/* register read/write mutex */
 	struct mutex mutex;
 	const struct jh8100_pinctrl_domain_info *info;
+	unsigned int jh8100_sys_west_regs[JH8100_SYS_W_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
 	/* wakeup */
 	int wakeup_gpio;
-- 
2.43.0


