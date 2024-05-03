Return-Path: <linux-kernel+bounces-167572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E18BAB75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC462814B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC1152198;
	Fri,  3 May 2024 11:15:13 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDA13C691;
	Fri,  3 May 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734912; cv=fail; b=jnphFKl39RlSUS1SJT7IMkGeX0NgMF+CwnnAawfjNvw1lzUNfKMB2i6GIfWjgs/TqfW9rVB+UphalKK1fzn8AvRJdNN8n6AiECS2Dr78qWxL4HPrp21LgZaXMct4XmdAjaNggoQ+Cp8tfFwcTbyFPf7pLFEryR39mxlbcOk/BLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734912; c=relaxed/simple;
	bh=QKFpaA40MjwZ3Rxw7RW4vCnpSZ6thbTek/ebXkHkWDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUdfEXWBnRBAqu69Sbvjkxw12p0lBLgYCnNQvcIo3aIeCE7u6ABFNUz8VopfjXJ1zGhWQ4TQ3OEFOF64kxXJ6PC5gEy62eSdmovxVEgPRiyawsUu1sTEzrf611+PFJm4pHabS/gX3iGpQOfz7np7PmqX5jNuGuarP9bcbIFiKFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOfVsAfc7nWM6u/SwH4u7Se92McExawo/Apc/+YgxyNXLTGVtVV0IbEcdGhPkebvWTVAsETNBH9Zi5PTTRkkwdYIJvhkeC90MGk8p2f/8BhS8jLYDUGZ2+bPVWh7/WcqFoLnpfkv4rQr5MmbTIuCoCOmnhEyLrlf9JToYgMOBXUt1yCgZhmDBgRULUpMZrgHZVxgie7KI7zHvMotJajtLojtr3KwcB6PkrNQyYWQQgntk4tDQwMOROJrzFPTD1wWpqwgdBLtnZG3Gfs47cDfj7vkckBhGvIZS3+7omihK2eeWth9ny31hdPi/sQYMPklnQ8zribMdZvGR+hJJhu2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRmGvKORfU/XNM9dcs5jbKFZWA/+xM+i3RYFCRfhR8A=;
 b=h3QT0+/wVCBpYUfyO/sLXivts2SRVGwO5V2FY6Z2mWoC+7xZSh4wTJPXMX5FlHiZOsL67xEMFCx9Gbnnw/T26anrgHAMGVwqGuRdAow8LeG7zFE1us2pR4VVxsBNkbuUix3TcSgf3f3K8heo/kGrH8h6ls6VUTNCdnDbwMecsf5EE1hNmZN4XQ1GQx7sMriRecdnpE6le9JFJIi8NrwJVyLWxIFaZuNWm2GFmC4yjuVp0lEuHoQXyIV/yE4tHp9GpSmSqWjOkHmNuPh72+ePVIsf1fYGl78UphLnNnLivv37S+8+5mbPhbfrEQgOu1qvIS/z2kIQWfMVzWr7OW0dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1112.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:15:02 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:15:02 +0000
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
Subject: [RFC PATCH v3 5/7] pinctrl: starfive: jh8100: add AON domain sub-driver
Date: Fri,  3 May 2024 19:14:34 +0800
Message-Id: <20240503111436.113089-6-yuklin.soo@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB1112:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b0325c-23a4-4bdc-20ea-08dc6b62470e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X9XHUFvjvhaFrx9b1VcK9CCvqUJvzKInpgbw40dfutbGhmGf/o6x9lxIpsobuccLh87CtLjyPQsGzjHwaQz72pGAyv7y/uQlegAeG8l1OilUVhF8NkURAk521kq8o8ef+4nBIYhIndhuVlKvYqZmByO/HXgwRazjmtgAQM2YGUdwQwJdPCZoRO0j0Eby3kXbki89FjD+32mGjjayJyAq76a6eehuzG2ZtTM1tqqy/1GBXFEHCuemNZFFnhRAl3ou8P57ZckxpK+4IwKC9BxB5FUCTGHgp9Wyt7VwbTMIvjoj9PKl7EX9YvSiXKwWbMgzhr7YXhse02kzfodrcIWnrpkcjV9rd7B8do2wJaPYHaDFv8p1hR6gs+QtVgoapwhhd19XR1tg8i9rGCLFK2TgZXVUn31s+W3t9sAp6PHX9xqAcGdRMlUYzcaDUSHP1bU/ywCSrSIuTLY8JoKE/C3XvDUNXeyLZrS5EVsszuqEEDCbnQnwRzctyf+fnvJZE0KyCcrbJXGbHklJXyHjXd1k6MKv988dQHCgrxWmCQnkeVnH6WYgKjUZY8BwuxcaJzmUUEgx5PZ116c2+AYFzMjsBkvsgrE+6hwmPMboXrWnB0BUuv4Nu/sGJZrNBCtIuCOfZtmmTNnGSx/ODKKopMiOHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EN12XgU1YNF2kJXW54i2HE1IzxuJmjyf3EMNyY4HRLkMHHflnezfrpLoqVRz?=
 =?us-ascii?Q?GuETS24g4TO/a4Yl9dtcpQO9tx4UkB3AxV6N0VsCDE/s+j34WpSQkEvROhBH?=
 =?us-ascii?Q?/rNyt8lRjuEaUYYOVfekhshN8ZkgH4D86/TCEQw4uvV0beu0jBhZ1jdsBUyA?=
 =?us-ascii?Q?iOtYLWzqDLM8rF6OQN6nwrcO7Zmu/wuzjSpiNxSiQmtoBOoVERdhOiL+n7NP?=
 =?us-ascii?Q?VRi6HfjlRfnkKJCEi6aJa1p4VgYNXniLbFPxqB23f8K8K3L7OPGjG41gxO6J?=
 =?us-ascii?Q?WiV9/n+DVGsawDVuK9eMst2pp+Rp3jPB1Q+JPk+8KFg3HlrQswSO/4lTN1Cb?=
 =?us-ascii?Q?91QqyCrVVELCIT1YiQiIlFwVfDe1Yc/Vi9kfGV3pXAcgDGEsWlCsxXlnYBh2?=
 =?us-ascii?Q?hqLGy5gWiEC54q008x12H2Qtn4CVJqKJhfxo/2kz9g8lZxImxuuQiYCM0p4L?=
 =?us-ascii?Q?C1pM60fBMW0EfTRfzQaTBj+2bDRJfld2EI1CWKCDwaesX/WXSwJcAPbYGUaZ?=
 =?us-ascii?Q?Lt5s4eZ74Bbwry0EXYGfEpJtO4BxCOBtISn4qEvOlvha0BgkjjnkGhEMg53U?=
 =?us-ascii?Q?vxK9P070W7tX/Y8DL+NM237ukSVYfWzO4+NKDNyrT1wm6zGHQzkkO1f597QR?=
 =?us-ascii?Q?fFW8puDUNrtFzIYhmkcsmWWtsRX+uKLjULeCx/bPT4qpZ9TcnY7we3jEBc12?=
 =?us-ascii?Q?GDkOt6nCtWksv1UncG8chKfs4MsYaDMLva2gmMNkDzX2UElIFcu0RSCSFKub?=
 =?us-ascii?Q?llujV6QBbOgBZCkFIppFqJC/zaAWIgpjyG1ANeRh+LqF80zssQL8GaDmnSjz?=
 =?us-ascii?Q?MCmMy4v/3OMC4FcsE6X1Zm36zFha8HlYRb6pOJinDJjv94Zaie4l8XuY2+Ej?=
 =?us-ascii?Q?HRYcwzUJXpJ2NXBsqE4WY4RG9ugeEaqLYdcKc1p5VvxwwYGjVNHwTWvPTj0g?=
 =?us-ascii?Q?3lIEZN2haTRTXLa/USvC4mig5ztdU8qMdTS7kCHMsrWwc74FtI04M1yJAwb8?=
 =?us-ascii?Q?mMCO8jXgbiJjL1qCH9kfn1AAymRmhFbEp6aokBPUpQRxKEmQtuzrmKKPHlXO?=
 =?us-ascii?Q?RpSub37rTlZChAtcvMRzzzVnKG7iSlZYueFREewnUInW059KDmBxf/C/9v/8?=
 =?us-ascii?Q?AgDRCemwBFFOFRuynHyUiAfZupxmC7FphNb7jYQF9jDGdNVwHYQWVTPbkfk6?=
 =?us-ascii?Q?zYVP3YPcLKu58tg38CJ433pTdmLlGqTjIXsHsBG0QCj0l91hQVDzSvfFXUt6?=
 =?us-ascii?Q?V1VazaXG8TkiaphNMp9hYBGIXzbVyxg2Qz9iJYBENtZuWQl7KcuIp5UFgU2b?=
 =?us-ascii?Q?IgQTxEqO6Cmrno8/MIUs1kCx1Wuj3KrqEOSyl3kMt++HnPHtWXKlb8ClVC7l?=
 =?us-ascii?Q?nAQ6k4G2PuVcghZ89xXo+bXE7yNqR5AjTiftWDkZr8BK80nImEKratgE4/fO?=
 =?us-ascii?Q?PH1Fa01oirWNkvoO/5bLEhT1+aS2bnzqUq+wxkgKJsLnNqwj8DwAW0LuMY9H?=
 =?us-ascii?Q?6WCsfOhunIjO1PQSQhI/HxKSuodo/82o92kghGcBVHemUazXR1p6O5BDd7Ot?=
 =?us-ascii?Q?QtA3S3Lxx4XXViMg32b7FyR6q17IEHGwEsVbJ8z0I2NVtC+3hwgyf2OgMtxt?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b0325c-23a4-4bdc-20ea-08dc6b62470e
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:15:02.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g6MGipZWrQpyuMDpTI6Joid6tA1vWrze5R7jfLwlmh3h5wJhiGlQaCZJBv8qzNveRpZq/arml4fWMIND6a2JFHeSQEoXuIMjvDhuVowbBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1112

Add AON domain sub-driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/pinctrl/starfive/Kconfig              |  14 ++
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../starfive/pinctrl-starfive-jh8100-aon.c    | 150 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.c        |   3 +
 .../starfive/pinctrl-starfive-jh8100.h        |   5 +
 6 files changed, 180 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dbd104f1f267..3f6b17688ac8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21125,6 +21125,13 @@ S:	Maintained
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
index 000000000000..3ced9f94f47a
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c
@@ -0,0 +1,150 @@
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
+#include "pinctrl-starfive-jh8100.h"
+
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
+	PINCTRL_PIN(0,	"AON_RGPIO0"),
+	PINCTRL_PIN(1,	"AON_RGPIO1"),
+	PINCTRL_PIN(2,	"AON_RGPIO2"),
+	PINCTRL_PIN(3,	"AON_RGPIO3"),
+	PINCTRL_PIN(4,	"AON_RGPIO4"),
+	PINCTRL_PIN(5,	"AON_RGPIO5"),
+	PINCTRL_PIN(6,	"AON_RGPIO6"),
+	PINCTRL_PIN(7,	"AON_RGPIO7"),
+	PINCTRL_PIN(8,	"AON_RGPIO8"),
+	PINCTRL_PIN(9,	"AON_RGPIO9"),
+	PINCTRL_PIN(10,	"AON_RGPIO10"),
+	PINCTRL_PIN(11,	"AON_RGPIO11"),
+	PINCTRL_PIN(12,	"AON_RGPIO12"),
+	PINCTRL_PIN(13,	"AON_RGPIO13"),
+	PINCTRL_PIN(14,	"AON_RGPIO14"),
+	PINCTRL_PIN(15,	"AON_RGPIO15"),
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
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
index 8c3e4a90d68d..edf2a6fb6da2 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
@@ -416,6 +416,9 @@ static int jh8100_get_padcfg_base(struct jh8100_pinctrl *sfp,
 	} else if (!strcmp(sfp->info->name, JH8100_SYS_W_DOMAIN_NAME)) {
 		if (pin < JH8100_SYS_W_NGPIO)
 			return JH8100_SYS_W_GPO_PDA_00_15_CFG;
+	} else if (!strcmp(sfp->info->name, JH8100_AON_DOMAIN_NAME)) {
+		if (pin < JH8100_AON_NGPIO)
+			return JH8100_AON_GPO_PDA_00_15_CFG;
 	}
 
 	return -ENXIO;
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 90eef6417dd7..ba44a7dd96e1 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -15,17 +15,21 @@
 #define JH8100_SYS_W_DOMAIN_NAME	"jh8100-sys-west"
 #define JH8100_SYS_E_DOMAIN_NAME	"jh8100-sys-east"
 #define JH8100_SYS_G_DOMAIN_NAME	"jh8100-sys-gmac"
+#define JH8100_AON_DOMAIN_NAME		"jh8100-aon"
 
 #define JH8100_SYS_W_NGPIO		16
 #define JH8100_SYS_E_NGPIO		48
 #define JH8100_SYS_G_NGPIO		0
+#define JH8100_AON_NGPIO		16
 
 #define JH8100_SYS_W_REG_NUM		44
 #define JH8100_SYS_E_REG_NUM		116
 #define JH8100_SYS_G_REG_NUM		19
+#define JH8100_AON_REG_NUM		65
 
 #define JH8100_SYS_W_GPO_PDA_00_15_CFG	0x074
 #define JH8100_SYS_E_GPO_PDA_00_47_CFG	0x114
+#define JH8100_AON_GPO_PDA_00_15_CFG	0x90
 
 struct jh8100_pinctrl {
 	struct device *dev;
@@ -40,6 +44,7 @@ struct jh8100_pinctrl {
 	unsigned int jh8100_sys_west_regs[JH8100_SYS_W_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_E_REG_NUM];
 	unsigned int jh8100_sys_gmac_regs[JH8100_SYS_G_REG_NUM];
+	unsigned int jh8100_aon_regs[JH8100_AON_REG_NUM];
 	/* wakeup */
 	struct irq_domain *irq_domain;
 	struct gpio_desc *wakeup_gpio;
-- 
2.25.1


