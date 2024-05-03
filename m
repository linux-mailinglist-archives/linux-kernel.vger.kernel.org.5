Return-Path: <linux-kernel+bounces-167574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DA8BAB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E89BB21AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60A15218F;
	Fri,  3 May 2024 11:15:19 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB51152520;
	Fri,  3 May 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734917; cv=fail; b=g3LVnVFhBuR01G7UI6zKl34XpZrjyPSqXn7nEkQkWiH/HhIUTHHi6uRUMJs53Ec3UXm1tkomXGJNoOU3xf30hizbuTBSlXhvGjB72Girda8EtwEqABt3QmEXxodS/Wzv1D9WK6htyAdk8kVTjKBRxcU22gsi5+EcNT66mzmfPu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734917; c=relaxed/simple;
	bh=fJYB7t+Ahi0DFnxlgIv4bGVXg/8yY0SVp84nwsb7K2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smlFfau7TsVfoqhtimlGh3Z32RWOvGGJ9oCV4LHz9i+41ibrODBnYjTgY6NUX+zFBUf9Xe99IGTwot5ST2tWEoQ+aVG4t824NjkhTuuxR0LBxPZX5zlCwJpgL0Jt8drdjuAuFEeGPFpugnU9MIMvBz9G6DEp10Vt0P2C4AZX5Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtSHT/InoSCjVucKDoeA2lvghwmBF1dhmokZT8CL4CZc3kK7SPXM3xw2Yx1XNXBGV154Wteh3CBDWWb9u27cx5AufiKNJX5jmZswA1awSd7B+mjFAnhiLdmDUaJ6k1k8Yde145SPqYte0A3rCeg8C2klCF4UN7iiYeUDVReQqU3MPvp8UjrxVaCXv94XHpKj4zKr4S+8ROfdr2sDAy80dtCi2cY9hpAmSNPMmu5Z5fcftoezy7+pRl5HsMvAzOgpP2QpDuYDPG/v4tiyjS5YeDEfyBCiChWG5RomkCm9etd6FWetkAmpOCVAGN5ttHk0kXwWZ/xDyaa/nCgRZJof2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+2WMphhalUbg3bUq5poKjZErBhzZcWd5MeZFGCRQfY=;
 b=bdhVVVgbIyZV93OlpJxpqXb8Nk4J3EcUglbVEE8aMsZhVoM6szoo+y+wqUY2IukYG4X97yZY4orZWLKkwxWKeRZVk/9dWrfkPs8fndyiw2CDCb0AkwP6hYWb88Y/E8XR7Ckg7te6HLqh/fQFM32tz+bTGukmfg8swuMqk25hDIoT4Tpwa4i3dp51lLtORtIeqA3kUW2BQMNZMZv9S5rzo6l8/JykuNWddr5pFeLo0jSMI7HH18bCwgEHKFpxv5pwG1hY1679XzL+fXEtezBSGFtWRGVXkv28QqX8Ft5DTEitapriUi3KVyyB1UrjXSrPSggesDDo36WKxDvvQDB88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1112.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:15:08 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:15:08 +0000
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
Subject: [RFC PATCH v3 7/7] riscv: dts: starfive: jh8100: add pinctrl device tree nodes
Date: Fri,  3 May 2024 19:14:36 +0800
Message-Id: <20240503111436.113089-8-yuklin.soo@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c011065-33a8-4ac6-872a-08dc6b624aa4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HYZBY7122z6e12k30ibXJZgqoaIYntNQTtyES0U1bEdu4+OspTEANQHuh1V1Z6tYVJK+v9NyLddVGqJvubIilWD5odVSc4LD8sY7SgGxBJBbcslasUzWTaxSzjcEg7LjI0tt6JnkwCXUZ7d2kIP8sYpyN8pIyN+Du5BJDJIRFI9ghInQ8Z9ONdVzlkxOSwW0+lK416A/jYaiR5ehLWTPtrM4arJrvUpJAW6OQg4oJrG5XchsLkRWuiUmcPEXpli+WjOFzQnAZ5OYy+82kTdUHt+f7JaH+nUTi5mspidgUdcmBPCqMCUknI3lWq2eOIXHo8ve10Xyzvh3puDnn+oj8hsl7f80TQFoLOH5TyGIAxd8KIgvud3W/uphy0ccBHYQrGIREIUxCzduGSn110rvxwzNUzwDp5aZ9imuZpkkwFcg5nvEgCdO8GpQr4yAUWUSNEDSp6shIgilYkgScEYIzERJZonZ8lIqNLaxfwhPpp0tDqFWGzJaDuRptRqRPwojkEKia0T44ZBUHxutGf8APpOxFCMGhoGM8ihNS8pi0KPcDA0nPrB52fP6aB53rbqqRl/e3QGnmO6YJtWexdweDVzXCj2CymCKaKI4KKl3HaNtbmMVv/zfWci70f5I5zn2sZ0S/xEHl+MStp/U91xurg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xR6qktZdJHshJTp64tRgVP+xgrF+x381IgrnSXpuZsvakBok5SWcsH3Pq6H2?=
 =?us-ascii?Q?OUXkSS8X+n8GnrCQK1uzNleT4QzXpM2UG16szPFDZsgHewbPt3+zqthIs2Ft?=
 =?us-ascii?Q?Jkvy7IjeN9SwtJNlqWQGZURohRn/rQ/Py2Hl8cdtqmb7eoFMzuCa/AcTa4iP?=
 =?us-ascii?Q?oLUHzq70Yvz0bfn2haWKuoPXzis7Ra9dIdnBGNz4WQ4conJSRs5yPiholz17?=
 =?us-ascii?Q?Spki2chlz1VyolCCSoe3AeM8ZC46JTFnjD5gv/YctId52JsyncjI+wla5486?=
 =?us-ascii?Q?+Q4Tr3KDGipJakg1JhfAr7Tu+irK/gVIGDBjKT0RoGzTYU3v8x/Fv74fEcOX?=
 =?us-ascii?Q?VzQbCmSnVoFPyYk8zA+K9pnonJDM4oppIa8e2vfIIKEqd6Fsk78PhBjSssc8?=
 =?us-ascii?Q?U/UyOffVHNjBJFfW/gpmVVBPKWJ89qjpTptMFJJFZGDZEDUKyr2Jdq2kBUdA?=
 =?us-ascii?Q?O9/BOhTdA4yCJ6QB7gkeSkCK5UetG5ar8MqCzr9Ih3yWuR+wtjq2qbWj0z6m?=
 =?us-ascii?Q?wen4kIDj3wMa3NhkZDELz6cHdOvIPKISPV2yUMIgHrcwcZtkxxq9O/cAozMr?=
 =?us-ascii?Q?nak3QUpPQ0yU/lAyDJena/d1f6+Xfqv9uH3TslCuhUwWkEkECzuEo6KMW81M?=
 =?us-ascii?Q?H+HKq5T8obx97pzsbmaw6Qi9eLFbBnE8SnIitwhP4XFC2MKIW/INFPY+5V3l?=
 =?us-ascii?Q?zCOLeixjMryPR8muUF/jEOxpT+IzN00Ql/1os8+V9X0b4SVuCpHvMiTJIvlF?=
 =?us-ascii?Q?nQhw2JT4d9wA7ed+ptEY8NPNDtmsw+/O0BvkDsTcjMhvmBz81ueQExD4eKRV?=
 =?us-ascii?Q?GhgfC8bHfCJ9WI33ynXLPTyZJDTVEal4IanVx1JvIZOVH+TwckKPH5Mg8wq/?=
 =?us-ascii?Q?N6P4MiEdAovQxrVfcvGHN+yMM1I7imlsCiZ1Q7yBVZ/ixW1iDOvwM3UoKlKC?=
 =?us-ascii?Q?QusjlzvqbYJo9icJ+ddL1xsDseJ8GbIUTFTm5grdWewoXMdiYxNQpsd/3lfn?=
 =?us-ascii?Q?u2Ww/0tMr4JL6oYQNYsRbeKK6dipKoh8/QTJ3A+qXSpCnlJuL0jmRHJo3zuA?=
 =?us-ascii?Q?5WKEUEvqbjXsbVqv/yVxNVGkGo9OteM4BI3W2dDVn+6aw7VkFPHEqvXKljHD?=
 =?us-ascii?Q?GJ20PiKRZq1toNNNdVR1ZJpJq8/b7/eFJZKwGn4DwQgTCrKFHCflPwPwG9Sm?=
 =?us-ascii?Q?k1teJayNw5dAhr0cfmQDb0pYeduFtaDtTt78FVlQHTe69qDuKp/PDmpJkw48?=
 =?us-ascii?Q?H0qHv0geWvVt+Ws2Epl0ttog8UjS2Y9stQws2rj9lY8eiZpAEGlpxCFU68Iu?=
 =?us-ascii?Q?vf8GAwdqd/ydu7FNZbvVl1wKc8Onq0wdu1VXc/Rw6mxsbyARxlhpg6p325VU?=
 =?us-ascii?Q?qVtaxY4/yMmJw04fg+UtSHPuLOSMLKYF1vlEzj6M6w9m9P3CkSWuDI/2+Hvu?=
 =?us-ascii?Q?eb+GvHf9OrxaYGhJF5v29E2/0JZYcN5Cvy8dYN3INHJzBQXtURN3lPvKkdDv?=
 =?us-ascii?Q?TKlMBSWv8AVgJh16qT5oUdLn04YduolCtZ2eh0Om6OKnpPICdvYuD7ewwMxA?=
 =?us-ascii?Q?WsucBNc+ixYI2z7UAQzUPtQ2fHSrF6PBPYbUp+dDmKAlVlGAScvHgKW1XBbT?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c011065-33a8-4ac6-872a-08dc6b624aa4
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:15:08.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2O9VFuQ1WWKjjjDP5L1tBeW+1ztcYchT5I10I0bUKS7ml2M7G2cd0Hxh+WSV70/KN9fbp1jNuBVAzjbLrGnVY4ZHizm1QT2snZc75RVnYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1112

Add pinctrl_east/pinctrl_west/pinctrl_gmac/pinctrl_aon device
tree nodes for JH8100 SoC.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh8100-evb.dts   |   7 +
 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h | 504 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh8100.dtsi      |  46 ++
 3 files changed, 557 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h

diff --git a/arch/riscv/boot/dts/starfive/jh8100-evb.dts b/arch/riscv/boot/dts/starfive/jh8100-evb.dts
index c16bc25d8988..dde01ed35e3e 100644
--- a/arch/riscv/boot/dts/starfive/jh8100-evb.dts
+++ b/arch/riscv/boot/dts/starfive/jh8100-evb.dts
@@ -4,6 +4,8 @@
  */
 
 #include "jh8100.dtsi"
+#include "jh8100-pinfunc.h"
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
 
 / {
 	model = "StarFive JH8100 EVB";
@@ -26,3 +28,8 @@ memory@40000000 {
 &uart0 {
 	status = "okay";
 };
+
+&pinctrl_aon {
+	wakeup-gpios = <&pinctrl_aon PAD_RGPIO1 GPIO_ACTIVE_HIGH>;
+	wakeup-source;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh8100-pinfunc.h b/arch/riscv/boot/dts/starfive/jh8100-pinfunc.h
new file mode 100644
index 000000000000..0325338dee08
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh8100-pinfunc.h
@@ -0,0 +1,504 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#ifndef __JH8100_PINFUNC_H__
+#define __JH8100_PINFUNC_H__
+
+/*
+ * mux bits:
+ *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   |  7 - 0  |
+ *  |  din    |  dout   |  doen   | function | gpio nr |
+ *
+ * dout:     output signal
+ * doen:     output enable signal
+ * din:      optional input signal, 0xff = none
+ * function:
+ * gpio nr:  gpio number, 0 - 63
+ */
+#define GPIOMUX(n, dout, doen, din) ( \
+		(((din)  & 0xff) << 24) | \
+		(((dout) & 0xff) << 16) | \
+		(((doen) & 0x3f) << 10) | \
+		((n) & 0x3f))
+
+#define PINMUX(n, func) ((1 << 10) | (((func) & 0x3) << 8) | ((n) & 0xff))
+
+/* sys_iomux_east pins */
+#define PAD_GPIO0_E				0
+#define PAD_GPIO1_E				1
+#define PAD_GPIO2_E				2
+#define PAD_GPIO3_E				3
+#define PAD_GPIO4_E				4
+#define PAD_GPIO5_E				5
+#define PAD_GPIO6_E				6
+#define PAD_GPIO7_E				7
+#define PAD_GPIO8_E				8
+#define PAD_GPIO9_E				9
+#define PAD_GPIO10_E				10
+#define PAD_GPIO11_E				11
+#define PAD_GPIO12_E				12
+#define PAD_GPIO13_E				13
+#define PAD_GPIO14_E				14
+#define PAD_GPIO15_E				15
+#define PAD_GPIO16_E				16
+#define PAD_GPIO17_E				17
+#define PAD_GPIO18_E				18
+#define PAD_GPIO19_E				19
+#define PAD_GPIO20_E				20
+#define PAD_GPIO21_E				21
+#define PAD_GPIO22_E				22
+#define PAD_GPIO23_E				23
+#define PAD_GPIO24_E				24
+#define PAD_GPIO25_E				25
+#define PAD_GPIO26_E				26
+#define PAD_GPIO27_E				27
+#define PAD_GPIO28_E				28
+#define PAD_GPIO29_E				29
+#define PAD_GPIO30_E				30
+#define PAD_GPIO31_E				31
+#define PAD_GPIO32_E				32
+#define PAD_GPIO33_E				33
+#define PAD_GPIO34_E				34
+#define PAD_GPIO35_E				35
+#define PAD_GPIO36_E				36
+#define PAD_GPIO37_E				37
+#define PAD_GPIO38_E				38
+#define PAD_GPIO39_E				39
+#define PAD_GPIO40_E				40
+#define PAD_GPIO41_E				41
+#define PAD_GPIO42_E				42
+#define PAD_GPIO43_E				43
+#define PAD_GPIO44_E				44
+#define PAD_GPIO45_E				45
+#define PAD_GPIO46_E				46
+#define PAD_GPIO47_E				47
+
+/* sys_iomux_west pins */
+#define PAD_GPIO0_W				0
+#define PAD_GPIO1_W				1
+#define PAD_GPIO2_W				2
+#define PAD_GPIO3_W				3
+#define PAD_GPIO4_W				4
+#define PAD_GPIO5_W				5
+#define PAD_GPIO6_W				6
+#define PAD_GPIO7_W				7
+#define PAD_GPIO8_W				8
+#define PAD_GPIO9_W				9
+#define PAD_GPIO10_W				10
+#define PAD_GPIO11_W				11
+#define PAD_GPIO12_W				12
+#define PAD_GPIO13_W				13
+#define PAD_GPIO14_W				14
+#define PAD_GPIO15_W				15
+
+/* aon_iomux pins */
+#define PAD_RGPIO0				0
+#define PAD_RGPIO1				1
+#define PAD_RGPIO2				2
+#define PAD_RGPIO3				3
+#define PAD_RGPIO4				4
+#define PAD_RGPIO5				5
+#define PAD_RGPIO6				6
+#define PAD_RGPIO7				7
+#define PAD_RGPIO8				8
+#define PAD_RGPIO9				9
+#define PAD_RGPIO10				10
+#define PAD_RGPIO11				11
+#define PAD_RGPIO12				12
+#define PAD_RGPIO13				13
+#define PAD_RGPIO14				14
+#define PAD_RGPIO15				15
+
+/* sys_iomux_east dout */
+#define GPOUT_LOW				0
+#define GPOUT_HIGH				1
+#define GPOUT_SYS_CAN0_STBY			2
+#define GPOUT_SYS_CAN0_TST_NEXT_BIT		3
+#define GPOUT_SYS_CAN0_TST_SAMPLE_POINT		4
+#define GPOUT_SYS_CAN0_TXD			5
+#define GPOUT_SYS_I2C0_CLK			6
+#define GPOUT_SYS_I2C0_DATA			7
+#define GPOUT_SYS_I2S0_STEREO_RSCKO		8
+#define GPOUT_SYS_I2S0_STEREO_RWSO		9
+#define GPOUT_SYS_I2S0_STEREO_SDO_0		10
+#define GPOUT_SYS_I2S0_STEREO_SDO_1		11
+#define GPOUT_SYS_I2S0_STEREO_TSCKO		12
+#define GPOUT_SYS_I2S0_STEREO_TWSO		13
+#define GPOUT_SYS_SPI0_MO			14
+#define GPOUT_SYS_SPI0_SS0			15
+#define GPOUT_SYS_SPI0_SS1			16
+#define GPOUT_SYS_SPI0_SS2			17
+#define GPOUT_SYS_SPI0_SS3			18
+#define GPOUT_SYS_SPI0_SCLK			19
+#define GPOUT_SYS_SPI0_SO			20
+#define GPOUT_SYS_UART0_DTR			21
+#define GPOUT_SYS_UART0_RTS			22
+#define GPOUT_SYS_UART0_TX			23
+#define GPOUT_SYS_USB0_DBG_DRIVE_VBUS		24
+#define GPOUT_SYS_PDM_MCLK			25
+#define GPOUT_SYS_PWM_CHANNEL0			26
+#define GPOUT_SYS_PWM_CHANNEL1			27
+#define GPOUT_SYS_PWM_CHANNEL2			28
+#define GPOUT_SYS_PWM_CHANNEL3			29
+#define GPOUT_SYS_PWM_CHANNEL4			30
+#define GPOUT_SYS_PWM_CHANNEL5			31
+#define GPOUT_SYS_PWM_CHANNEL6			32
+#define GPOUT_SYS_PWM_CHANNEL7			33
+#define GPOUT_SYS_SMBUS0_CLK			34
+#define GPOUT_SYS_SMBUS0_DATA			35
+#define GPOUT_SYS_SMBUS0_SUSPEND		36
+#define GPOUT_SYS_CLK_GCLK1			37
+#define GPOUT_SYS_CLK_GCLK2			38
+#define GPOUT_SYS_CLK_GCLK3			39
+#define GPOUT_SYS_CLK_GCLK4			40
+#define GPOUT_SYS_CLK_GCLK6			41
+#define GPOUT_SYS_CLK_GCLK7			42
+#define GPOUT_SYS_MCLK				43
+#define GPOUT_SYS_USB0_TYPEC_DRIVE_VBUS		44
+#define GPOUT_SYS_WATCHDOG0_RESET		45
+#define GPOUT_SYS_CAN1_STBY			46
+#define GPOUT_SYS_CAN1_TST_NEXT_BIT		47
+#define GPOUT_SYS_CAN1_TST_SAMPLE_POINT		48
+#define GPOUT_SYS_CAN1_TXD			49
+#define GPOUT_SYS_I2C1_CLK			50
+#define GPOUT_SYS_I2C1_DATA			51
+#define GPOUT_SYS_I2S1_RSCKO			52
+#define GPOUT_SYS_I2S1_RWSO			53
+#define GPOUT_SYS_I2S1_SDO0			54
+#define GPOUT_SYS_I2S1_SDO1			55
+#define GPOUT_SYS_I2S1_SDO2			56
+#define GPOUT_SYS_I2S1_SDO3			57
+#define GPOUT_SYS_I2S1_SDO4			58
+#define GPOUT_SYS_I2S1_SDO5			59
+#define GPOUT_SYS_I2S1_SDO6			60
+#define GPOUT_SYS_I2S1_SDO7			61
+#define GPOUT_SYS_I2S1_TSCKO			62
+#define GPOUT_SYS_I2S1_TWSO			63
+#define GPOUT_SYS_SDIO1_PU_PD_DATA2		64
+#define GPOUT_SYS_SDIO1_BUS_POWER		65
+#define GPOUT_SYS_SDIO1_RESET			66
+#define GPOUT_SYS_SDIO1_BUS_VOLTAGE_0		67
+#define GPOUT_SYS_SDIO1_BUS_VOLTAGE_1		68
+#define GPOUT_SYS_SDIO1_BUS_VOLTAGE_2		69
+#define GPOUT_SYS_SDIO1_LED			70
+#define GPOUT_SYS_SPI1_MO			71
+#define GPOUT_SYS_SPI1_SS0			72
+#define GPOUT_SYS_SPI1_SS1			73
+#define GPOUT_SYS_SPI1_SS2			74
+#define GPOUT_SYS_SPI1_SS3			75
+#define GPOUT_SYS_SPI1_SCLK			76
+#define GPOUT_SYS_SPI1_SO			77
+#define GPOUT_SYS_UART1_DTR			78
+#define GPOUT_SYS_UART1_RTS			79
+#define GPOUT_SYS_UART1_TX			80
+#define GPOUT_SYS_USB1_DBG_DRIVE_VBUS		81
+#define GPOUT_SYS_I2C2_CLK			82
+#define GPOUT_SYS_I2C2_DATA			83
+#define GPOUT_SYS_UART2_DTR			84
+#define GPOUT_SYS_UART2_RTS			85
+#define GPOUT_SYS_UART2_TX			86
+#define GPOUT_SYS_USB2_DBG_DRIVE_VBUS		87
+#define GPOUT_SYS_I2C3_CLK			88
+#define GPOUT_SYS_I2C3_DATA			89
+#define GPOUT_SYS_UART3_DTR			90
+#define GPOUT_SYS_UART3_RTS			91
+#define GPOUT_SYS_UART3_TX			92
+#define GPOUT_SYS_USB3_DBG_DRIVE_VBUS		93
+#define GPOUT_SYS_I2C4_CLK			94
+#define GPOUT_SYS_I2C4_DATA			95
+#define GPOUT_SYS_UART4_DTR			96
+#define GPOUT_SYS_UART4_RTS			97
+#define GPOUT_SYS_UART4_TX			98
+#define GPOUT_SYS_I2C5_CLK			99
+#define GPOUT_SYS_I2C5_DATA			100
+
+/* sys_iomux_west dout */
+#define GPOUT_SYS_RSVD0				2
+#define GPOUT_SYS_RSVD1				3
+#define GPOUT_SYS_RSVD2				4
+#define GPOUT_SYS_RSVD3				5
+#define GPOUT_SYS_RSVD4				6
+#define GPOUT_SYS_RSVD5				7
+#define GPOUT_SYS_RSVD6				8
+#define GPOUT_SYS_RSVD7				9
+#define GPOUT_SYS_RSVD8				10
+#define GPOUT_SYS_HD_AUDIO0_BCLK		11
+#define GPOUT_SYS_HD_AUDIO0_RST			12
+#define GPOUT_SYS_HD_AUDIO0_SDI0_O		13
+#define GPOUT_SYS_HD_AUDIO0_SDI1_O		14
+#define GPOUT_SYS_HD_AUDIO0_SDO0		15
+#define GPOUT_SYS_HD_AUDIO0_SDO1		16
+#define GPOUT_SYS_HD_AUDIO0_SYNC		17
+#define GPOUT_SYS_HIFI4_JTAG_TDO		18
+#define GPOUT_SYS_CLK_GCLK5			19
+#define GPOUT_SYS_SMBUS1_CLK			20
+#define GPOUT_SYS_SMBUS1_DATA			21
+#define GPOUT_SYS_SMBUS1_SUSPEND		22
+#define GPOUT_SYS_SPI2_MO			23
+#define GPOUT_SYS_SPI2_SS0			24
+#define GPOUT_SYS_SPI2_SS1			25
+#define GPOUT_SYS_SPI2_SS2			26
+#define GPOUT_SYS_SPI2_SS3			27
+#define GPOUT_SYS_SPI2_SCLK			28
+#define GPOUT_SYS_SPI2_SO			29
+#define GPOUT_SYS_UART5_DTR			30
+#define GPOUT_SYS_UART5_RTS			31
+#define GPOUT_SYS_UART5_TX			32
+#define GPOUT_SYS_I2C6_CLK			33
+#define GPOUT_SYS_I2C6_DATA			34
+#define GPOUT_SYS_UART6_DTR			35
+#define GPOUT_SYS_UART6_RTS			36
+#define GPOUT_SYS_UART6_TX			37
+#define GPOUT_SYS_I2C7_CLK			38
+#define GPOUT_SYS_I2C7_DATA			39
+
+/* aon_iomux dout */
+#define GPOUT_AON_CLK_32K			2
+#define GPOUT_AON_CLK_GCLK0			3
+#define GPOUT_AON_CLK_GCLK_OSC			4
+#define GPOUT_AON_SIG_STUB_POWER_EN_O		5
+#define GPOUT_AON_EMMC_PU_PD_DATA2		6
+#define GPOUT_AON_EMMC_BUS_POWER		7
+#define GPOUT_AON_EMMC_BUS_VOLTAGE_0		8
+#define GPOUT_AON_EMMC_BUS_VOLTAGE_1		9
+#define GPOUT_AON_EMMC_BUS_VOLTAGE_2		10
+#define GPOUT_AON_EMMC_LED			11
+#define GPOUT_AON_SDIO0_PU_PD_DATA2		12
+#define GPOUT_AON_SDIO0_BUS_POWER		13
+#define GPOUT_AON_SDIO0_RESET			14
+#define GPOUT_AON_SDIO0_BUS_VOLTAGE_0		15
+#define GPOUT_AON_SDIO0_BUS_VOLTAGE_1		16
+#define GPOUT_AON_SDIO0_BUS_VOLTAGE_2		17
+#define GPOUT_AON_SDIO0_LED			18
+#define GPOUT_AON_JTAG_TDO			19
+#define GPOUT_AON_SCP_POWER_EN			20
+#define GPOUT_AON_WATCHDOG1_RESET		21
+#define GPOUT_AON_UART7_TX			22
+#define GPOUT_AON_I2C8_CLK			23
+#define GPOUT_AON_I2C8_DATA			24
+
+/* sys_iomux_east doen */
+#define GPOEN_SYS_ENABLE			0
+#define GPOEN_SYS_DISABLE			1
+#define GPOEN_SYS_I2C0_CLK			2
+#define GPOEN_SYS_I2C0_DATA			3
+#define GPOEN_SYS_I2S0_STEREO_SDOE_0		4
+#define GPOEN_SYS_I2S0_STEREO_SDOE_1		5
+#define GPOEN_SYS_SPI0_N_MO_EN			6
+#define GPOEN_SYS_SPI0_N_SCLK_EN		7
+#define GPOEN_SYS_SPI0_N_SO_EN			8
+#define GPOEN_SYS_SPI0_N_SS_EN			9
+#define GPOEN_SYS_PWM_CHANNEL0			10
+#define GPOEN_SYS_PWM_CHANNEL1			11
+#define GPOEN_SYS_PWM_CHANNEL2			12
+#define GPOEN_SYS_PWM_CHANNEL3			13
+#define GPOEN_SYS_PWM_CHANNEL4			14
+#define GPOEN_SYS_PWM_CHANNEL5			15
+#define GPOEN_SYS_PWM_CHANNEL6			16
+#define GPOEN_SYS_PWM_CHANNEL7			17
+#define GPOEN_SYS_SMBUS0_CLK			18
+#define GPOEN_SYS_SMBUS0_DATA			19
+#define GPOEN_SYS_SMBUS0_ALERT			20
+#define GPOEN_SYS_I2C1_CLK			21
+#define GPOEN_SYS_I2C1_DATA			22
+#define GPOEN_SYS_I2S1_SDO0			23
+#define GPOEN_SYS_I2S1_SDO1			24
+#define GPOEN_SYS_I2S1_SDO2			25
+#define GPOEN_SYS_I2S1_SDO3			26
+#define GPOEN_SYS_I2S1_SDO4			27
+#define GPOEN_SYS_I2S1_SDO5			28
+#define GPOEN_SYS_I2S1_SDO6			29
+#define GPOEN_SYS_I2S1_SDO7			30
+#define GPOEN_SYS_SPI1_N_MO_EN			31
+#define GPOEN_SYS_SPI1_N_SCLK_EN		32
+#define GPOEN_SYS_SPI1_N_SO_EN			33
+#define GPOEN_SYS_SPI1_N_SS_EN			34
+#define GPOEN_SYS_I2C2_CLK			35
+#define GPOEN_SYS_I2C2_DATA			36
+#define GPOEN_SYS_I2C3_CLK			37
+#define GPOEN_SYS_I2C3_DATA			38
+#define GPOEN_SYS_I2C4_CLK			39
+#define GPOEN_SYS_I2C4_DATA			40
+#define GPOEN_SYS_I2C5_CLK			41
+#define GPOEN_SYS_I2C5_DATA			42
+
+/* sys_iomux_west doen */
+#define GPOEN_SYS_RSVD0				2
+#define GPOEN_SYS_RSVD1				3
+#define GPOEN_SYS_RSVD2				4
+#define GPOEN_SYS_RSVD3				5
+#define GPOEN_SYS_RSVD4				6
+#define GPOEN_SYS_RSVD5				7
+#define GPOEN_SYS_RSVD6				8
+#define GPOEN_SYS_HD_AUDIO0_SDI0		9
+#define GPOEN_SYS_HD_AUDIO0_SDI1		10
+#define GPOEN_SYS_HIFI4_JTAG_TDO		11
+#define GPOEN_SYS_SMBUS1_CLK			12
+#define GPOEN_SYS_SMBUS1_DATA			13
+#define GPOEN_SYS_SMBUS1_ALERT			14
+#define GPOEN_SYS_SPI2_MO			15
+#define GPOEN_SYS_SPI2_SCLK			16
+#define GPOEN_SYS_SPI2_SO			17
+#define GPOEN_SYS_SPI2_SS			18
+#define GPOEN_SYS_I2C6_CLK			19
+#define GPOEN_SYS_I2C6_DATA			20
+#define GPOEN_SYS_I2C7_CLK			21
+#define GPOEN_SYS_I2C7_DATA			22
+
+/* aon_iomux doen */
+#define GPOEN_AON_JTAG_TDO			2
+#define GPOEN_AON_I2C8_CLK			3
+#define GPOEN_AON_I2C8_DATA			4
+
+/* sys_iomux din */
+#define GPI_NONE				255
+
+/* sys_iomux_east din */
+#define GPI_SYS_CAN0_RXD			0
+#define GPI_SYS_I2C0_CLK			1
+#define GPI_SYS_I2C0_DATA			2
+#define GPI_SYS_SPI0_SCLK			3
+#define GPI_SYS_SPI0_MI				4
+#define GPI_SYS_SPI0_SS_N			5
+#define GPI_SYS_SPI0_SI				6
+#define GPI_SYS_UART0_CTS			7
+#define GPI_SYS_UART0_DCD			8
+#define GPI_SYS_UART0_DSR			9
+#define GPI_SYS_UART0_RI			10
+#define GPI_SYS_UART0_RX			11
+#define GPI_SYS_USB0_DBG_OVERCURRENT		12
+#define GPI_SYS_PDM_DMIC0			13
+#define GPI_SYS_PDM_DMIC1			14
+#define GPI_SYS_I2SRX0_SDIN0			15
+#define GPI_SYS_I2SRX0_SDIN1			16
+#define GPI_SYS_SMBUS0_CLK			17
+#define GPI_SYS_SMBUS0_DATA			18
+#define GPI_SYS_SMBUS0_ALERT			19
+#define GPI_SYS_JTAG_TCK			20
+#define GPI_SYS_MCLK_EXT			21
+#define GPI_SYS_I2SRX0_BCLK			22
+#define GPI_SYS_I2SRX0_LRCK			23
+#define GPI_SYS_I2STX0_BCLK			24
+#define GPI_SYS_I2STX0_LRCK			25
+#define GPI_SYS_SPI0_SCLK_IN0			26
+#define GPI_SYS_SPI0_SCLK_IN1			27
+#define GPI_SYS_I2S0_STEREO_RX_BCLK		28
+#define GPI_SYS_I2S0_STEREO_RX_LRCK		29
+#define GPI_SYS_I2S0_STEREO_TX_BCLK		30
+#define GPI_SYS_I2S0_STEREO_TX_LRCK		31
+#define GPI_SYS_I2S1_RX_BCLK			32
+#define GPI_SYS_I2S1_RX_LRCK			33
+#define GPI_SYS_I2S1_TX_BCLK			34
+#define GPI_SYS_I2S1_TX_LRCK			35
+#define GPI_SYS_USB0_TYPEC_OVERCURRENT		36
+#define GPI_SYS_CAN1_RXD			37
+#define GPI_SYS_I2C1_CLK			38
+#define GPI_SYS_I2C1_DATA			39
+#define GPI_SYS_I2S1_SDI_0			40
+#define GPI_SYS_I2S1_SDI_1			41
+#define GPI_SYS_I2S1_SDI_2			42
+#define GPI_SYS_I2S1_SDI_3			43
+#define GPI_SYS_I2S1_SDI_4			44
+#define GPI_SYS_I2S1_SDI_5			45
+#define GPI_SYS_I2S1_SDI_6			46
+#define GPI_SYS_I2S1_SDI_7			47
+#define GPI_SYS_SDIO1_CARD_DETECT		48
+#define GPI_SYS_SDIO1_WRITE_PROTECT		49
+#define GPI_SYS_SPI1_EXT_CLK			50
+#define GPI_SYS_SPI1_MI				51
+#define GPI_SYS_SPI1_SS_IN			52
+#define GPI_SYS_SPI1_SI				53
+#define GPI_SYS_UART1_CTS			54
+#define GPI_SYS_UART1_DCD			55
+#define GPI_SYS_UART1_DSR			56
+#define GPI_SYS_UART1_RI			57
+#define GPI_SYS_UART1_RX			58
+#define GPI_SYS_USB1_DBG_OVERCURRENT		59
+#define GPI_SYS_I2C2_CLK			60
+#define GPI_SYS_I2C2_DATA			61
+#define GPI_SYS_UART2_CTS			62
+#define GPI_SYS_UART2_DCD			63
+#define GPI_SYS_UART2_DSR			64
+#define GPI_SYS_UART2_RI			65
+#define GPI_SYS_UART2_RX			66
+#define GPI_SYS_USB2_DBG_OVERCURRENT		67
+#define GPI_SYS_I2C3_CLK			68
+#define GPI_SYS_I2C3_DATA			69
+#define GPI_SYS_UART3_CTS			70
+#define GPI_SYS_UART3_DCD			71
+#define GPI_SYS_UART3_DSR			72
+#define GPI_SYS_UART3_RI			73
+#define GPI_SYS_UART3_RX			74
+#define GPI_SYS_USB3_DBG_OVERCURRENT		75
+#define GPI_SYS_I2C4_CLK			76
+#define GPI_SYS_I2C4_DATA			77
+#define GPI_SYS_UART4_CTS			78
+#define GPI_SYS_UART4_DCD			79
+#define GPI_SYS_UART4_DSR			80
+#define GPI_SYS_UART4_RI			81
+#define GPI_SYS_UART4_RX			82
+#define GPI_SYS_I2C5_CLK			83
+#define GPI_SYS_I2C5_DATA			84
+
+/* sys_iomux_west din */
+#define GPI_SYS_RSVD0				0
+#define GPI_SYS_RSVD1				1
+#define GPI_SYS_RSVD2				2
+#define GPI_SYS_RSVD3				3
+#define GPI_SYS_RSVD4				4
+#define GPI_SYS_RSVD5				5
+#define GPI_SYS_RSVD6				6
+#define GPI_SYS_HD_AUDIO0_SDI0_I		7
+#define GPI_SYS_HD_AUDIO0_SDI1_I		8
+#define GPI_SYS_HIFI4_JTAG_TDI			9
+#define GPI_SYS_HIFI4_JTAG_TMS			10
+#define GPI_SYS_HIFI4_JTAG_RST			11
+#define GPI_SYS_RSVD7				12
+#define GPI_SYS_HIFI4_JTAG_TCK			13
+#define GPI_SYS_RSVD8				14
+#define GPI_SYS_SPI0_SCLK_IN2			15
+#define GPI_SYS_SMBUS1_CLK			16
+#define GPI_SYS_SMBUS1_DATA			17
+#define GPI_SYS_SMBUS1_ALERT			18
+#define GPI_SYS_SPI2_EXT_CLK			19
+#define GPI_SYS_SPI2_MI				20
+#define GPI_SYS_SPI2_SS_IN			21
+#define GPI_SYS_SPI2_SI				22
+#define GPI_SYS_UART5_CTS			23
+#define GPI_SYS_UART5_DCD			24
+#define GPI_SYS_UART5_DSR			25
+#define GPI_SYS_UART5_RI			26
+#define GPI_SYS_UART5_RX			27
+#define GPI_SYS_I2C6_CLK			28
+#define GPI_SYS_I2C6_DATA			29
+#define GPI_SYS_UART6_CTS			30
+#define GPI_SYS_UART6_DCD			31
+#define GPI_SYS_UART6_DSR			32
+#define GPI_SYS_UART6_RI			33
+#define GPI_SYS_UART6_RX			34
+#define GPI_SYS_I2C7_CLK			35
+#define GPI_SYS_I2C7_DATA			36
+
+/* aon_iomux din */
+#define GPI_AON_JTAG_TCK			0
+#define GPI_AON_SIG_STUB_RESERVED_0		1
+#define GPI_AON_SIG_STUB_RESERVED_1		2
+#define GPI_AON_SIG_STUB_RESERVED_2		3
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_0		4
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_1		5
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_2		6
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_3		7
+#define GPI_AON_SDIO0_CARD_DETECTION		8
+#define GPI_AON_SDIO0_WRITE_PROTECTION		9
+#define GPI_AON_SRC_BUF_JTAG_RST		10
+#define GPI_AON_JTAG_TDI			11
+#define GPI_AON_JTAG_TMS			12
+#define GPI_AON_UART7_RX			13
+#define GPI_AON_I2C8_CLK			14
+#define GPI_AON_I2C8_DATA			15
+
+#endif
diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/dts/starfive/jh8100.dtsi
index 5ba826e38ead..37251010d96f 100644
--- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/clock/starfive,jh8100-crg.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/reset/starfive,jh8100-crg.h>
 
 / {
@@ -563,6 +564,19 @@ uart4: serial@121a0000  {
 			status = "disabled";
 		};
 
+		pinctrl_east: pinctrl@122d0000 {
+			compatible = "starfive,jh8100-sys-pinctrl-east",
+				     "syscon", "simple-mfd";
+			reg = <0x0 0x122d0000 0x0 0x10000>;
+			clocks = <&necrg JH8100_NECLK_IOMUX_EAST_PCLK>;
+			resets = <&necrg JH8100_NERST_SYS_IOMUX_E>;
+			interrupts = <182>;
+			interrupt-controller;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_east 0 0 48>;
+		};
+
 		necrg: clock-controller@12320000 {
 			compatible = "starfive,jh8100-necrg";
 			reg = <0x0 0x12320000 0x0 0x10000>;
@@ -634,6 +648,19 @@ nwcrg: clock-controller@123c0000 {
 			#reset-cells = <1>;
 		};
 
+		pinctrl_west: pinctrl@123e0000 {
+			compatible = "starfive,jh8100-sys-pinctrl-west",
+				     "syscon", "simple-mfd";
+			reg = <0x0 0x123e0000 0x0 0x10000>;
+			clocks = <&nwcrg JH8100_NWCLK_IOMUX_WEST_PCLK>;
+			resets = <&nwcrg JH8100_NWRST_SYS_IOMUX_W>;
+			interrupts = <183>;
+			interrupt-controller;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_west 0 0 16>;
+		};
+
 		syscrg: clock-controller@126d0000 {
 			compatible = "starfive,jh8100-syscrg";
 			reg = <0x0 0x126d0000 0x0 0x10000>;
@@ -656,6 +683,13 @@ swcrg: clock-controller@12720000 {
 			#reset-cells = <1>;
 		};
 
+		pinctrl_gmac: pinctrl@12770000 {
+			compatible = "starfive,jh8100-sys-pinctrl-gmac",
+				     "syscon", "simple-mfd";
+			status = "disabled";
+			reg = <0x0 0x12770000 0x0 0x10000>;
+		};
+
 		uart5: serial@127d0000  {
 			compatible = "starfive,jh8100-uart", "cdns,uart-r1p8";
 			reg = <0x0 0x127d0000 0x0 0x10000>;
@@ -674,6 +708,18 @@ uart6: serial@127e0000  {
 			status = "disabled";
 		};
 
+		pinctrl_aon: pinctrl@1f300000 {
+			compatible = "starfive,jh8100-aon-pinctrl",
+				     "syscon", "simple-mfd";
+			reg = <0x0 0x1f300000 0x0 0x10000>;
+			resets = <&aoncrg JH8100_AONRST_AON_IOMUX_PRESETN>;
+			interrupts = <160>;
+			interrupt-controller;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aon 0 0 16>;
+		};
+
 		aoncrg: clock-controller@1f310000 {
 			compatible = "starfive,jh8100-aoncrg";
 			reg = <0x0 0x1f310000 0x0 0x10000>;
-- 
2.25.1


