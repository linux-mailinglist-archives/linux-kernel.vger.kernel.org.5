Return-Path: <linux-kernel+bounces-127629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F669894EA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FDE1F23899
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893955823A;
	Tue,  2 Apr 2024 09:24:04 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2133.outbound.protection.partner.outlook.cn [139.219.146.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928C5822A;
	Tue,  2 Apr 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049843; cv=fail; b=W3PhOYyWgAGvq7EuIdk9KglRtdOKMadtkiBxLH4cTII35NaHD71kgqY36qGTGdqzGN3dV5zcQGBb66AgopB71pzEx131OLepwkRbFvhGkyPZ+WEmMwl0OhnePpI+AmpxH3iSC1Qk1JD9XmzaYOCe4Min49S5tjvKjQ3XZYOs9mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049843; c=relaxed/simple;
	bh=1dpn5VLl2z/31hps5juhDCakxcHoEoZoqYX5hbcmD3E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jqemQ207NNP0zNpYBrm73FCcTjL1gL0Z1397wsr+QQ5wotUC1yT7ASZEBAXQmUP2gCG/y9Cyb5NFVbloF8SLOq0BGVLQnPMsGDi3bqE+ffSRxWX330i9QktQ2ZUySTX7fG9Ri64E7bv76oejd4fVOZ/rlozGptzo6SKeOk3IPB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQqasdNgBdIZpy61rr1Wnsc14xikEb6UyYnAIPJo00i4TdojX/AqqLlCJXfA8sT37iTfHPlzMZiXhk0eZFOpBOY9CDBfJw1qka3NwqKINfXSEfQUVu5U0gbmY3y4AuoFZvKpXH/GX89Sy1q2tGXDDGFIYmmPm2XAXM7o4O6w7vARenWudI2IMTE9zK9XdSnEPKJb/Qjh2JO5WCQLkLtH4WE/eaO0dFN8w+hsJTM0GO6sost5OW09VkQ6fVx+nN1aebi2d2dCzmFZakjQj2ZfgYu3xe6mQGleoOaTWYZvYFbpejE5qc46Jml15kpEdxZi6KngRePKLJcS+c0xL0KP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Saiki2wT3CoksisJ5IXcjCDjgCzhBC/lclja/GFo7Bg=;
 b=TNUb2fuXM+jylSBAtPZoNLbPI5N4aDjtDhidxleldk86wg+jm49vlQ99neBs0Ja8Y0cZePTAS5NShLadrBaf0dgXiBVub9Kc1gfyn+oxC70EOGKtNcriXZxeIFTycgSifkMdPnV/8LVA7cigVplYH8xzes74ym0heXg1lP4x7ggoXJVmg4UAl2G3G/ahG72D1gKjvfQ++s23k5UpaEpsCAxkx4PbHCe7hvidrY5QLTgkdk5SSIsbga5PwKA43Bx+k04oPR6lweaYpKHr2+6q/VKL6pzS0WATV1AKoPZLrQ8AEUcde2t8AjehRz1RinhszT9RJysA7irKMXNF1HWy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1116.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Tue, 2 Apr
 2024 09:09:37 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Tue, 2 Apr 2024 09:09:37 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
Date: Tue,  2 Apr 2024 17:09:20 +0800
Message-Id: <20240402090920.11627-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::16) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1116:EE_
X-MS-Office365-Filtering-Correlation-Id: 5610efe1-0bb8-4c0d-f05f-08dc52f49f27
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m0dMNkeYTqN+/wAWoAwy1lPNkaGU7OH90K9XyO9Ks1kifI7lCe12xJStaTovd7kOFp1VpFHH6i5u9GWeN+GWmLPtbD2LC6u2dYXPIwI4XbYjqV5EgvRTHlqW0trERglKakwhK2ubmpHcCqwlst4v+C1ldVcIXIqHAxVkVqmUv/G/zDnhhaEipjM80bPQ8Vv/Ht5xNsNzaR82TDIQP1R8b8HMyGN3KfHJaFiFUAvPdmGv5WTxK9Yx9kwmEs1wmJLr8I4XKNKY+GcWW4G3cly/0N3APbiVp/85JFNx6BHHoXawd6MXs85aw3q5PH6jQDHlIzBF705+PMbNyZCZ27eQ6GqmvCSIoTVMSn4PXP1n2rJiezictpyOlCelFi8OIOmX+gj4PKJF1rl8t5e2wjI5trZfo4krWcUYKZd8exnGNzp/9tPSr9ikbHmpJVE8zYxspjU2JtWRl4bRNQdJMWCDPTdBPsqk3dY5ceWxXd76cgC0A8xJI30Km+DpD7ti6IqRfeLQQYoHwTv/8vuN06ykOO0/QP2b+oE9VrTR6cBwanUoYEufAQDldwbPNE6nmawwCJ153pBqQnpZuCJK0ONUUlmGjyeT4UEUw99WNxXHrKFPLjYwVfef0ONOygupIvE/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7qnbm7D7mp0vBq0JEkutMQ/zld92jreMStPDbV7BvXmY+G4cVSkS2ZkNcD+a?=
 =?us-ascii?Q?jpzKuWkN+K9Q31ffhKs1Uw8xJT/8dOtmaqW0rLDPx3HXb7MF2R/StBcBwYrU?=
 =?us-ascii?Q?iq60sgbzCB+8fZvrS52fUxZtxvZLE4TS5gyZqirmjXUXPEjI9+UaDWvlYfIX?=
 =?us-ascii?Q?2RLuw9BRcDz6e5CsK7+QI0DIO0OFBLQSI+cRC2+3n+aBd/IhOPM39+eN0PsT?=
 =?us-ascii?Q?dnla3Wuprh8ZGzHMWjlZiPmFJd4uKOuwC4mrzPeAVgUaom3hQ/ZsFd3Qlndu?=
 =?us-ascii?Q?CIzEK2IhYUOC5vn7GKeEJCb/cNuCjmZm3+oqItOyvtw1oNTV7Q61yU05d6Kf?=
 =?us-ascii?Q?QJWQd35PQTXVa/jYqSzTPbyZLS0p+w5C/bjQ8X9Z/P4SWwfpQPZaeMwMEaGR?=
 =?us-ascii?Q?CdKK7hsWhwOmKBO7YbKMmqMoONRbO0nPh25ALjSal7hHENMaX2MwOnbb59L5?=
 =?us-ascii?Q?WlfJB5Y7RCYctFYapFTbeJ/eVh496BNSMAfmmt9dILn+4rhpG9UdNH7ai0fn?=
 =?us-ascii?Q?DunljroWv6gjkceDYAwm3nitR3LFiC43dwqNmzH694d/SGLO1R9mBH2saPcE?=
 =?us-ascii?Q?ZtW0FDLnD5hLopA/QE6UFg4E+ph+rFO2lxiC2q3ZM3uTmLYjbg3spCyyfZJt?=
 =?us-ascii?Q?zfVMDFraAIY4biW/J+dOhZUQ6hIxzMNvpIxCaJxa3dYY/fhNODMi5QxXJj7F?=
 =?us-ascii?Q?2jlD/ntkOEr2aMaFyo0wx6miYWpsfq9gtsHn7/N/1R3f6S/l9X09G7SSePQY?=
 =?us-ascii?Q?C8Hg0e47grvCCLzc3k1lFy9qhLBy+yTq/3I69mX7R9fhilQs6Z7vSTj3Yl5e?=
 =?us-ascii?Q?JH61Tsb8O9oZqxlqilsqAdYeAqbAXw7RZETAZEK9Y311CnCkXUb+dnipJkrV?=
 =?us-ascii?Q?ZJc611YqaVsn4VRpkDeN1PvNqKxUX5L0PaJNw26n9RdwfTJE7xMRmD1gDOJq?=
 =?us-ascii?Q?Cq9Dr1Gkm6xs0WYa/WVyOcCZdeBU32obKsurZc8c7lXkcfGQ5ZNnyVeKVN2x?=
 =?us-ascii?Q?7hqv31TZoWWI8LcQzTjORmmwYTmh+q07FROUj0MUYuDbVFkCe8CaFH6ur6Fy?=
 =?us-ascii?Q?FuVUSNTmIagxayV+HaFIwn6uz+B47VOX45cL/of1CLlhtokjp1HtvFzTWnIJ?=
 =?us-ascii?Q?zA1U3nO/GzDAhFIjTIHuyHwxJK+RNOAHFR/tQnlHWyGmylIj5BIXRdH5c7fS?=
 =?us-ascii?Q?3F4JXN6OqFNRxOjTk15RDdGl97UqGMxmJWiNw33F7yGxO7fjMceiR0r87nIT?=
 =?us-ascii?Q?D2luMlnxjmVy1o0mKv5ydC5fMOVgumDJgMIXB8htbRuO/E4YlCHxre0/k2rm?=
 =?us-ascii?Q?ySfONpqp1Lx/IF4/xgmDy9g8UVi1XWJRW64J60DtW/UmDuAKWZxsTRdlyQbW?=
 =?us-ascii?Q?4P2DTxmdXtpACEH9Ssu2N+6cUv0zmqDiY78RDwmfbLYhjxqXpjWf4rVSBo3j?=
 =?us-ascii?Q?FyTWGdcB1n0S3DPmVr/d4nWBOEGqQ3MEQ7Jm0ENorvm5ElfS1LcZ3wBTZFk3?=
 =?us-ascii?Q?kKOTiELKIGkCH+1iFGDZTUp1NUV7GetZuBLSLh3U30HIdGWF87jTN+Sl4FXT?=
 =?us-ascii?Q?NwNmVWv7hkcj425vYsg1B31fSV3SvWleHlIriKBH4hIqIon4RPHEzjMPtYYU?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5610efe1-0bb8-4c0d-f05f-08dc52f49f27
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:09:37.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npPvWFcxCyKYcBdK0pXebCR7yunGJFdYLezx66weH6UoqsdribqXHISrktKfiwMmNeuZNgWvUWvUZmhNdUhKXSKE22A5tMiFgVEQRve81z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1116

CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
But now PLL0 rate is 1GHz and the cpu frequency loads become
333/500/500/1000MHz in fact.

So PLL0 rate should be default set to 1.5GHz. But setting the
PLL0 rate need certain steps:

1. Change the parent of cpu_root clock to OSC clock.
2. Change the divider of cpu_core if PLL0 rate is higher than
   1.25GHz before CPUfreq boot.
3. Change the parent of cpu_root clock back to PLL0 clock.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---

Hi Stephen and Emil,

This patch fixes the issue about lower rate of CPUfreq[1] by setting PLL0
rate to 1.5GHz.

In order not to affect the cpu operation, setting the PLL0 rate need
certain steps. The cpu_root's parent clock should be changed first. And
the divider of the cpu_core clock should be set to 2 so they won't crash
when setting 1.5GHz without voltage regulation. Due to PLL driver boot
earlier than SYSCRG driver, cpu_core and cpu_root clocks are using by
ioremap(). 

[1]: https://github.com/starfive-tech/VisionFive2/issues/55

Previous patch link:
v2: https://lore.kernel.org/all/20230821152915.208366-1-xingyu.wu@starfivetech.com/
v1: https://lore.kernel.org/all/20230811033631.160912-1-xingyu.wu@starfivetech.com/

Thanks,
Xingyu Wu
---
 .../jh7110-starfive-visionfive-2.dtsi         |   5 +
 .../clk/starfive/clk-starfive-jh7110-pll.c    | 102 ++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 45b58b6f3df8..0c57d833fb29 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -336,6 +336,11 @@ &pwmdac {
 	status = "okay";
 };
 
+&pllclk {
+	assigned-clocks = <&pllclk JH7110_PLLCLK_PLL0_OUT>;
+	assigned-clock-rates = <1500000000>;
+};
+
 &qspi {
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
index 3598390e8fd0..7a53ded8d526 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -24,11 +24,14 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/starfive,jh7110-crg.h>
 
+#include "clk-starfive-jh7110.h"
+
 /* this driver expects a 24MHz input frequency from the oscillator */
 #define JH7110_PLL_OSC_RATE		24000000UL
 
@@ -72,6 +75,9 @@
 #define JH7110_PLL_PREDIV_SHIFT		0
 #define JH7110_PLL_PREDIV_MASK		GENMASK(5, 0)
 
+#define JH7110_CPU_ROOT_MUX_OSC		0
+#define JH7110_CPU_ROOT_MUX_PLL0	1
+
 enum jh7110_pll_mode {
 	JH7110_PLL_MODE_FRACTION,
 	JH7110_PLL_MODE_INTEGER,
@@ -140,6 +146,8 @@ struct jh7110_pll_data {
 struct jh7110_pll_priv {
 	struct device *dev;
 	struct regmap *regmap;
+	void __iomem *syscrg_base;
+	bool is_first_set;
 	struct jh7110_pll_data pll[JH7110_PLLCLK_END];
 };
 
@@ -275,6 +283,25 @@ static struct jh7110_pll_priv *jh7110_pll_priv_from(struct jh7110_pll_data *pll)
 	return container_of(pll, struct jh7110_pll_priv, pll[pll->idx]);
 }
 
+static void jh7110_pll_syscrg_update_div(void __iomem *base,
+					 unsigned int id,
+					 unsigned int div)
+{
+	unsigned int reg = readl(base + id * 4);
+
+	writel((reg & ~JH71X0_CLK_DIV_MASK) | div, (base + id * 4));
+}
+
+static void jh7110_pll_syscrg_update_mux(void __iomem *base,
+					 unsigned int id,
+					 unsigned int mux)
+{
+	unsigned int reg = readl(base + id * 4);
+
+	writel((reg & ~JH71X0_CLK_MUX_MASK) | (mux << JH71X0_CLK_MUX_SHIFT),
+	       (base + id * 4));
+}
+
 static void jh7110_pll_regvals_get(struct regmap *regmap,
 				   const struct jh7110_pll_info *info,
 				   struct jh7110_pll_regvals *ret)
@@ -352,6 +379,47 @@ static int jh7110_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request
 	return 0;
 }
 
+static bool jh7110_pll0_is_assigned_clock(struct device_node *node)
+{
+	struct of_phandle_args clkspec;
+	int ret;
+
+	ret = of_parse_phandle_with_args(node, "assigned-clocks",
+					 "#clock-cells", 0, &clkspec);
+	if (ret < 0 || clkspec.np != node)
+		return false;
+
+	if (clkspec.args[0] == JH7110_PLLCLK_PLL0_OUT)
+		return true;
+
+	return false;
+}
+
+/*
+ * In order to not affect the cpu when the PLL0 rate is changing,
+ * we need to switch the parent of cpu_root clock to osc clock first,
+ * and then switch back after setting the PLL0 rate.
+ *
+ * If cpu rate rather than 1.25GHz, PMIC need to be set higher voltage.
+ * But the PMIC is controlled by CPUfreq and I2C, which boot later than
+ * PLL driver when using assigned_clock to set PLL0 rate. So set the
+ * CPU_CORE divider to 2(default 1) first and make sure the cpu rate is
+ * lower than 1.25G when pll0 rate will be set more than 1.25G.
+ */
+static void jh7110_pll0_rate_preset(struct jh7110_pll_priv *priv,
+				    unsigned long rate)
+{
+	if (rate > 1250000000 && priv->is_first_set &&
+	    jh7110_pll0_is_assigned_clock(priv->dev->of_node))
+		jh7110_pll_syscrg_update_div(priv->syscrg_base,
+					     JH7110_SYSCLK_CPU_CORE, 2);
+
+	jh7110_pll_syscrg_update_mux(priv->syscrg_base,
+				     JH7110_SYSCLK_CPU_ROOT,
+				     JH7110_CPU_ROOT_MUX_OSC);
+	priv->is_first_set = false;
+}
+
 static int jh7110_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long parent_rate)
 {
@@ -372,6 +440,9 @@ static int jh7110_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return -EINVAL;
 
 found:
+	if (pll->idx == JH7110_PLLCLK_PLL0_OUT)
+		jh7110_pll0_rate_preset(priv, rate);
+
 	if (val->mode == JH7110_PLL_MODE_FRACTION)
 		regmap_update_bits(priv->regmap, info->offsets.frac, JH7110_PLL_FRAC_MASK,
 				   val->frac << JH7110_PLL_FRAC_SHIFT);
@@ -387,6 +458,12 @@ static int jh7110_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	regmap_update_bits(priv->regmap, info->offsets.frac, JH7110_PLL_POSTDIV1_MASK,
 			   (u32)val->postdiv1 << JH7110_PLL_POSTDIV1_SHIFT);
 
+	/* Set parent of cpu_root back to PLL0 */
+	if (pll->idx == JH7110_PLLCLK_PLL0_OUT)
+		jh7110_pll_syscrg_update_mux(priv->syscrg_base,
+					     JH7110_SYSCLK_CPU_ROOT,
+					     JH7110_CPU_ROOT_MUX_PLL0);
+
 	return 0;
 }
 
@@ -458,6 +535,8 @@ static int jh7110_pll_probe(struct platform_device *pdev)
 	struct jh7110_pll_priv *priv;
 	unsigned int idx;
 	int ret;
+	struct device_node *np;
+	struct resource res;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -489,6 +568,29 @@ static int jh7110_pll_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	priv->is_first_set = true;
+	np = of_find_compatible_node(NULL, NULL, "starfive,jh7110-syscrg");
+	if (!np) {
+		ret = PTR_ERR(np);
+		dev_err(priv->dev, "failed to get syscrg node\n");
+		goto np_put;
+	}
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(priv->dev, "failed to get syscrg resource\n");
+		goto np_put;
+	}
+
+	priv->syscrg_base = ioremap(res.start, resource_size(&res));
+	if (!priv->syscrg_base)
+		ret = -ENOMEM;
+
+np_put:
+	of_node_put(np);
+	if (ret)
+		return ret;
+
 	return devm_of_clk_add_hw_provider(&pdev->dev, jh7110_pll_get, priv);
 }
 
-- 
2.25.1


