Return-Path: <linux-kernel+bounces-12666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62ED81F8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2F285AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5679C1;
	Thu, 28 Dec 2023 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o6sofZMd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2105.outbound.protection.outlook.com [40.92.40.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470F7498;
	Thu, 28 Dec 2023 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5j9XwcJHfABrWdiA6XLpDQcTs6K+p9dLU5N9oHkiteVcFKJLQdRrw3dDZIY8SXBKlkSuu5i4MqjQXiElRhn8qyO9ZPxjyiobjVMw+QnvPZ1U7SERM+zFtOnzpEt+MzeRPIDoNUzP6afncJ/5uX4oQusO9AvXMNANj0TmcbntFKlWMKrT1E4O/4Ue8sF/0Vjqcnc6t5av5KKeKe7IJr1Ijh6iwHbIM/tEn7X0Y6KADgFMkzYbUBiaBIv/yVzIdW8GxGTiWeunRY3cUkDjXMT2g/k6fJXPZV7WDNPZIYLotKHZ3G7UlHNCLB+t4/dhINvBR1+FxcV3wj6HM0KqAgdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6UzIB+wLZKKQ75JJe8RHU2JXu+uUrn02grEBRGj7ws=;
 b=WJ85UC0aZTCgUuy450IaQSdNqVs3sPD5VWGMaU9zlrimuIxitk3H0+7+I7NKwr4FK0YJq+05eWoOzKD9bzh5+g/aqaybSHcHtqF0xLW1P5/PVq8PZlU7cxlUEfeS6ar8GnycBiH2Ldrn1ikZxmdkta/yYrSwFrrAnbAQAz5N8Gj49E9LpGMHJrEfSzJ8Mk55XPthDefDTmI2rw12qHPWPI1V3Nv5Zb5R4bTIsYbKrhdRwtQ2AdG+nIHcH7dAHXyovXZjgWJSu93YHBq9XKjLywQ/aTmr10xhcocXevNBklTBQLmTTz0GL3IT96vfyEEkmxOlaluH/op3eiIXLX2rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6UzIB+wLZKKQ75JJe8RHU2JXu+uUrn02grEBRGj7ws=;
 b=o6sofZMdQLYPgC9ZXcWSUdnS/t7kW4Y5YBGfC35Xbq+tkTipYxVI6XC4iTQWXTSNsBypiryHfA5QlPxh2z/I0Ey1u4j/euG1tIIHKP6vqXBS9MzbXzypsuZLI9i3ws1ylHqNKftGPGOqD6fpm5YrT6Y+xfkMJutMZea+GqdQsI1pPCE4Y/fFq9o6sdzrJdtJLIH9Z1nI5qexqNST0NE929bvY/dC83ji94rgG71AK8OJ1wNXbrsNRuiaqeynOjARjUSS1A7tPirYaL0RgPnOEMwX+FPdeeWwmPs+MQVWq6HzxY+l/4/LdkS1DWUisOZVlF8hPcUFVwozFW9g9vOQdw==
Received: from DM6PR20MB2316.namprd20.prod.outlook.com (2603:10b6:5:1a8::28)
 by IA1PR20MB4897.namprd20.prod.outlook.com (2603:10b6:208:3e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 13:08:38 +0000
Received: from DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::1d59:b3c8:8763:a672]) by DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::1d59:b3c8:8763:a672%4]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 13:08:38 +0000
From: AnnanLiu <annan.liu.xdu@outlook.com>
To: chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	AnnanLiu <annan.liu.xdu@outlook.com>
Subject: [PATCH] riscv: dts: sophgo: add watchdog dt node for CV1800
Date: Thu, 28 Dec 2023 21:08:17 +0800
Message-ID:
 <DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [eLR18H4/ZkT24SA4bhpgdGTI9DfOG6HJBRj3ckCWrao=]
X-ClientProxiedBy: TYAPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::29) To DM6PR20MB2316.namprd20.prod.outlook.com
 (2603:10b6:5:1a8::28)
X-Microsoft-Original-Message-ID:
 <20231228130817.182221-1-annan.liu.xdu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR20MB2316:EE_|IA1PR20MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb100b0-0594-41cf-b96b-08dc07a61b14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1567hFodunfvJTMfYsPR4vU4RF+htqYWqL/YBCL6V4Ltlxh+O04p26dqY65j8PsXx754O3cC5ZrSPGDLFDHEir39ELD8yMbI+sxpMt+bFmS/h1254dL+3F9lzGRT5vjoiS36CbbZm8bsZCPSY1oCzATmi5TbPT9DV1WCVUUbFppHxmvS47n+y4L74GnTe4nSVoqZFq1BdNLXe00kdcQrvmGARXGxYGaZ0D35QQwyVq+vFr2xkuObMb4gJapDi7c/tBp7ujeJd99t2OVdXnKinx+Hb1q8fefjPxEyhcCN/yngQIrjcKydmwIX6yvdlDVA2Z0uaSnSAwzKhFKWokAa6HCZ5MioJFnAaBIGo3wvkwDwNSpWqb35hBwDeb8uLT2XAZpZe+l3KcuuvD2cpuIIdw3JJ2pBOhRATCfO2v0Zg2Gb5Hv009tRpwZ2ZFMlkVwrWcc7Yz5TtVVMseZokq0HCZMHrx+g+gfN0Ml+lESO8bdQ0WLLyOLJ9+H6S7ioXAnRCeWji65z3OENSvQ9pGjTgewVTSV9xz0JPBY0RuGj/tqKFTgAB0tzxoJcSEMPhMLZvZb68l7Lfx0JzSad/15f2aFMqQSpKqKZ0U3dZCns/7t/fw1FyhSO7yV4Ho2BtUZcz3LBYOixsBVTchGI1SqmXNbc1WFk5F47yNJMXxEjPvQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ddiagOmzc+JhAklHYhZM9fKJfWT2DgRB1m2pF5W3eZQx1rRlPAq2NIw/9Q4?=
 =?us-ascii?Q?IEqHhjzkUujpXAYwBvfhs5mhj8UjadlLcb+WHH+I2c92RGVHn3rnAl1tjjLt?=
 =?us-ascii?Q?rp58db6nvu7lbrSGD6sLfFnIjbSNKUUBtbhZtPew4CxkqU4r3XYgSa6t9Mtr?=
 =?us-ascii?Q?dge3z2qDEU9eGUNEul1EEEatAwhPgIq/OqK4ViPvFWAZmdTMPXjogA95G3ck?=
 =?us-ascii?Q?dTdVatvaY2zJ+RiXtovezcazEkoW4eK/4XFBETqtYz0KziHaBGbq/8HLtqqT?=
 =?us-ascii?Q?0he4Z0RNfColqSoaCrZ2iYydJwXha0RA/tA0j1eAN5jx8DtV9fLD+iYiC40j?=
 =?us-ascii?Q?gpjaBlh5eMDFASq4KRLe+xpBCRb4bGe3VYepPBKOwN266C1HQhC7Q6FB5FFu?=
 =?us-ascii?Q?3jRXFQzDPlPcVf631xbeC26IkvI2EO66FdrqhcC3Kc1rviAs9P6SakrcXn38?=
 =?us-ascii?Q?5c6HyrcdN1qMve5PQlsHpsTf+mBDuAAZSJQT4+O6cQc4HLMeqDUJ+5jKipE8?=
 =?us-ascii?Q?++gKZmW3pQq79R+j/jPNOXerV2Aw/qyUI9eRyMt8htycRY6j0iuSZYERunJr?=
 =?us-ascii?Q?Xqo6CwfZ9C2BES3S9mE/QYeVNtSPJQXm9OfbDXciq8pObwseu/6P8uXt/Ubb?=
 =?us-ascii?Q?v9CeVf41Hf805Sa6/s0JDZEIo2A1d6ogp1hIjQEWN22mYNtHLO0uiZt/dhbr?=
 =?us-ascii?Q?kiXNdFFGx5U9rowyHuv2sgYU244xWPcNzkGImyoXQqvmB4NlsTBtRIFXv0w7?=
 =?us-ascii?Q?SGnl4NZf00xNtdFrJWpk2hYfubl4oUJJ8Ac9cMtQNTB1qPJG8iYFDi3fs7dv?=
 =?us-ascii?Q?wajv1ya7i0S9O+vYaRUG/RaNJsrzex+MkwXEkI1x7mqu5PAE4dZiR7qKArP7?=
 =?us-ascii?Q?jfrJLcdhD6k1y0jA3pVp8tVXUdo9BH7hSvRZkAkotgqcYAOe/ATVUysaYCKq?=
 =?us-ascii?Q?SMO+ybrHnSJGwoxOnInL55JxALg/g4SSJEs9yscDEWbJPXAKM2w8y54d5NJD?=
 =?us-ascii?Q?HmlFbIVj2B+5kvOCkDNkJVAswer/kXBjAnr8H4qFY+jUV5c0mU/ehHZfftSe?=
 =?us-ascii?Q?iSePpQ9/0fpbYkqW+AKywKxPIoNSqs8VE2W4XL5PWRSjmqiw856lKjBgGHMG?=
 =?us-ascii?Q?nITD2HwHbasZNmrEVafMyN0ThRYNa6qQs64ANM2K61JhaVG5yiCZpd6aW8D+?=
 =?us-ascii?Q?0VGAR+yOlgTRoULigEBpH/m1hWT2Xp5FmaM8Y8Wy0ZZUxv/JyVpMpcyM3A4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb100b0-0594-41cf-b96b-08dc07a61b14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR20MB2316.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 13:08:38.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB4897

Add the watchdog device tree node to cv1800 SoC.
This patch depends on the clk driver and reset driver.
Clk driver link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
Reset driver link:
https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/

Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index 3af9e34b3bc7..f3103de4a8cc 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -36,3 +36,7 @@ &osc {
 &uart0 {
 	status = "okay";
 };
+
+&watchdog0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index aec6401a467b..a0a6b6fc6bc5 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Annan Liu <annan.liu.xdu@outlook.com>
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -103,6 +104,20 @@ uart4: serial@41c0000 {
 			status = "disabled";
 		};
 
+		watchdog0: watchdog@3010000{
+			compatible = "snps,dw-wdt";
+			reg = <0x3010000 0x100>;
+			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk>;
+			resets = <&rst RST_WDT>;
+		};
+
+		pclk: pclk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+		};
+
 		plic: interrupt-controller@70000000 {
 			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
 			reg = <0x70000000 0x4000000>;
-- 
2.34.1


