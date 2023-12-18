Return-Path: <linux-kernel+bounces-4119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035E817819
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBA81F242A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F04FF65;
	Mon, 18 Dec 2023 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="BgWzy7kQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E74237E;
	Mon, 18 Dec 2023 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzGHcJARfjhd0xDrCNANQxhu8t6PXP+wWHC6HZhXvhPAwdC3VByMx/hMipLeQkj6Q5URGE8XJ5ulT4A4OLhSfqOT3lTJtJfAuqRMXHTP4q/h5ONiDKROsfMDypPtC9f0hFLhe8Kvc7nIMao6Qxdt1jRYvrsWHtBtnik90EvI6aVJ6KKIhNQp9T7LJpaJmrlIL0yH6A93D+/oSlAtK65Q68CjNU3EPlVAHEuUysxDt8zmuezMEmYw+AM6Bd5NNiMVhyq4oOF7oknq4f8wKIMs8e3DO1q9Q0ETImcdqhPau5wcsbVC5go9goTcbvCdeKzc5OBkUTa6LEUCIrfhW91egA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5+MuqFV3+syjLR7O+vAYOl/uS8NbWRYyb0/CtYUSgg=;
 b=Irh4F7+6h4qPqDFg3xXcnoRz5Si2CF5ale61UBK9PPVHf22F7M43tC7Okbl1sFL1eqXP9R5u+WDTPHQI79oh8yYNv4wlKeDLv5dgkjCvgT8WHkdP7gp6TA29n8hVvAadOikFZI2U5hyNTgM2Sn0byfDit+WWcv0bHXj4b7d7L7+9TuoPeQDStg7e7dejjzMeRHppoDdYkWudeCjpgx9SkV2RlIQ8I43ZA8BLzPGKGe8C0DcBUQWHhLqnkUnIzcByhBld2/LoXpI/M3LQI5YwAl7TYItAtH2UHKzE8X5hhiW4iUO2/+yeUyzTUmpr0mMK6vzYnYex0C2xhj2GPNa6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5+MuqFV3+syjLR7O+vAYOl/uS8NbWRYyb0/CtYUSgg=;
 b=BgWzy7kQ1zHxENPRbGua/6FNkkznBgEiDHkJnqsvaV+KnifwR2DKzz3ouwnu6Z7wDPwYD4KGkDkT8yFZYiPL1qWk8liS9HHpZAivu9Pvpzr5Q3FlyN0e+tLAic6xIlkfhZkzIsxsrOoNpY3fZj+sQemk3iakW9Eg7QWAMoejwjE=
Received: from SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18) by
 TYZPR03MB7847.apcprd03.prod.outlook.com (2603:1096:400:464::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Mon, 18 Dec 2023 17:04:20 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:4:b6:cafe::96) by SGAP274CA0006.outlook.office365.com
 (2603:1096:4:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 17:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 17:04:17 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 19 Dec
 2023 01:04:17 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Dec
 2023 01:04:16 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 19 Dec 2023 01:04:16 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 979945F607;
	Mon, 18 Dec 2023 19:04:15 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 80972DC1E33; Mon, 18 Dec 2023 19:04:15 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <avifishman70@gmail.com>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v21] clk: npcm8xx: add clock controller
Date: Mon, 18 Dec 2023 19:04:04 +0200
Message-ID: <20231218170404.910153-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|TYZPR03MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 125b09f3-e42d-414b-7011-08dbffeb5f22
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OW+So9IH7W20BVm7SzQRnuTi1ilg9/FYJAR0xGA/SJsyC3pRJan5QE7or+C6cSnJ7k67AGGjo4v3xYeZuqPmtAU4ok5E36u1VX9z4/TFmlB3gtAPyIzvELfN7K5WFX89b/CxPjP4sjmAx4wvg+g87B05HY9K/LERAt9RBe8ww8XJ6xajxmH/3NL+jAvK6Uh6HfVuSXRy+zy3qsC3ChXqZr7+QH1c97kKBYE++G+a9rl3frcsewz71YK+Ub0S96aYPM0JWNteCHZYFS8IbIdvIt3yIPh6aB+3bj3vrBSYtMW9yrSgaPmRWbevNv7g3OKNMdAtotuZaZXZzQbwnoYEjF+VKCMrI6viIzAfrLQlKGL9+7PwwDY6+KZ2defnKccDYe3oXVfneIq8Y/zoHeTWXKxh5G4QqOsszIG/r2P9dGTv8AacDXFZEMPi/kNAfxQp588R1Zev6t+JcppDi2nG0s0W96HxLdgejc2CpoIuMd947zp0r4pV111J5hO0u9IDuP0Tc9XXsekYfrbIb+GlQ27eWqixbNE99s1ufcuk+52h808gf3g+2cpbqB6ayAlcleftJQo4N4wetMLXUZMDgsehW+fKiN4P1V+3Vj1+OEJJoCObmgQHSJBHqSB67em4D0tHgyNdHVZevmgcI2PJtpOL+CBEgzwG84R319pgTReNVZj14Z0AUyLkJWSheLm5od7Nii2EzpZDSe5+uYDHP/AYZ7cPoqOIVD5XM3KmILvRP5GHVbqRKuvPbgn2BRUXVzYj5LPcPWdcvwbOZaR6I5KPjG3WTqVL476LiDQ61kieNhTiPcb/1TMeHOs+qFhQ12UHD17xJ7uo/IXde/5p/VOtLG65zIIkAG09CAfIRM4jHV9vZmXvg0abVkna1KgJSzSc2981VfzFuTWCtW+3HQ==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(82310400011)(451199024)(61400799012)(48200799006)(40470700004)(46966006)(40480700001)(40460700003)(70586007)(76482006)(110136005)(83170400001)(55446002)(81166007)(356005)(82740400003)(36756003)(35950700001)(63350400001)(47076005)(83380400001)(73392003)(82202003)(2616005)(42882007)(26005)(6266002)(1076003)(336012)(498600001)(54906003)(966005)(70206006)(2906002)(30864003)(42186006)(6666004)(8936002)(8676002)(316002)(7416002)(41300700001)(4326008)(5660300002)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:04:17.9672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125b09f3-e42d-414b-7011-08dbffeb5f22
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7847

Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
generates and supplies clocks to all modules within the BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
---
Addressed comments from:
 - Stephen Boyd : https://www.spinics.net/lists/kernel/msg5016941.html

Changes since version 20:
 - Using regmap instead of ioremap.
   the clock and reset modules are sharing the same memory region 
   and cause failure when using devm_platform_ioremap_resource
   function, this version uses regmap to handle shared 
   reset and clock memory region, in case it is approved I will
   modify the reset driver to use the regmap as well.
 - Using clk_hw instead of clk_parent_data structre.
 - Divider clock definition to one line

Changes since version 19:
 - Remove unnecessary free command.
 - Defining pr_fmt().
 - Using dev_err_probe.
 - Return zero in the end of the probe function.

Changes since version 18:
 - NPCM8XX clock driver did not changed from version 18 only build and tested under kernel 6.6-rc1.

Changes since version 17:
 - NPCM8XX clock driver did not changed from version 17 only build and tested under kernel 6.5-rc3.

Changes since version 16:
 - NPCM8XX clock driver
	- Using devm_kzalloc instead kzalloc.
	- Remove unnecessary parenthesis.
	- Modify incorrect spelling.

Changes since version 15:
 - NPCM8XX clock driver
	- Remove unused regs parameter from npcm8xx_pll_data structure.
	- Using index and clk_hw parameters to set the clock parent in the clock structures.

Changes since version 14:
 - NPCM8XX clock driver
	- Remove unnecessary register definitions.
	- Remove the internal reference clock, instead use the external DT reference clock.
	- rearrange the driver.
	- using .names parameter in DT to define clock (refclk).

Changes since version 13:
 - NPCM8XX clock driver
	- Remove unnecessary definitions and add module.h define
	- Use in clk_parent_data struct.fw_name and .name.
	- Add module_exit function.
	- Add const to divider clock names.
	- Add MODULE_DESCRIPTION and MODULE_LICENSE

Changes since version 12:
 - NPCM8XX clock driver
	- Use clk_parent_data in mux and div clock structure.
	- Add const to mux tables.
	- Using devm_clk_hw_register_fixed_rate function.
	- use only .name clk_parent_data instead .name and .fw_name.
	- Modify mask values in mux clocks. 

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 10:
 - NPCM8XX clock driver
	- Fix const warning.

Changes since version 9:
 - NPCM8XX clock driver
	- Move configuration place.
	- Using clk_parent_data instead of parent_name
	- using devm_ioremap instead of ioremap. deeply sorry, I know we had
	 a long discussion on what should the driver use, from other examples 
	 (also in other clock drivers) I see the combination of 
	 platform_get_resource and devm_ioremap are commonly used and it answer
	 the reset and clock needs.

Changes since version 8:
 - NPCM8XX clock driver
	- Move configuration place.
	- Add space before and aftre '{' '}'.
	- Handle devm_of_clk_add_hw_provider function error.

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.

Changes since version 2:
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.

 drivers/clk/clk-npcm8xx.c | 552 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 552 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
new file mode 100644
index 000000000000..e6c5111cc255
--- /dev/null
+++ b/drivers/clk/clk-npcm8xx.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM8xx Clock Generator
+ * All the clocks are initialized by the bootloader, so this driver allows only
+ * reading of current settings directly from the hardware.
+ *
+ * Copyright (C) 2020 Nuvoton Technologies
+ * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
+ */
+
+#define pr_fmt(fmt) "npcm8xx_clk: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
+
+/* npcm8xx clock registers*/
+#define NPCM8XX_CLKSEL		0x04
+#define NPCM8XX_CLKDIV1		0x08
+#define NPCM8XX_CLKDIV2		0x2C
+#define NPCM8XX_CLKDIV3		0x58
+#define NPCM8XX_CLKDIV4		0x7C
+#define NPCM8XX_PLLCON0		0x0C
+#define NPCM8XX_PLLCON1		0x10
+#define NPCM8XX_PLLCON2		0x54
+#define NPCM8XX_PLLCONG		0x60
+#define NPCM8XX_THRTL_CNT	0xC0
+
+#define PLLCON_LOKI	BIT(31)
+#define PLLCON_LOKS	BIT(30)
+#define PLLCON_FBDV	GENMASK(27, 16)
+#define PLLCON_OTDV2	GENMASK(15, 13)
+#define PLLCON_PWDEN	BIT(12)
+#define PLLCON_OTDV1	GENMASK(10, 8)
+#define PLLCON_INDV	GENMASK(5, 0)
+
+struct npcm8xx_clk {
+	struct regmap	*clk_regmap;
+	unsigned int	offset;
+	const char	*name;
+	const u32	*table;
+	u32		mask;
+	u8		shift;
+	unsigned long	width;
+	unsigned long	flags;
+	struct clk_hw	hw;
+};
+
+#define to_npcm8xx_clk(_hw) container_of(_hw, struct npcm8xx_clk, hw)
+
+struct npcm8xx_clk_pll_data {
+	const char *name;
+	struct clk_parent_data parent;
+	unsigned int reg;
+	unsigned long flags;
+	struct clk_hw hw;
+};
+
+struct npcm8xx_clk_div_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+	const char *name;
+	const struct clk_hw *parent_hw;
+	unsigned long clk_divider_flags;
+	unsigned long flags;
+	int onecell_idx;
+	struct clk_hw hw;
+};
+
+struct npcm8xx_clk_mux_data {
+	u8 shift;
+	u32 mask;
+	const u32 *table;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 num_parents;
+	unsigned long flags;
+	struct clk_hw hw;
+};
+
+/* external clock definition */
+#define NPCM8XX_CLK_S_REFCLK	"refclk"
+
+/* pll definition */
+#define NPCM8XX_CLK_S_PLL0	"pll0"
+#define NPCM8XX_CLK_S_PLL1	"pll1"
+#define NPCM8XX_CLK_S_PLL2	"pll2"
+#define NPCM8XX_CLK_S_PLL_GFX	"pll_gfx"
+
+/* early divider definition */
+#define NPCM8XX_CLK_S_PLL2_DIV2		"pll2_div2"
+#define NPCM8XX_CLK_S_PLL_GFX_DIV2	"pll_gfx_div2"
+#define NPCM8XX_CLK_S_PLL1_DIV2		"pll1_div2"
+
+/* mux definition */
+#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
+#define NPCM8XX_CLK_S_PIX_MUX     "gfx_pixel_mux"
+#define NPCM8XX_CLK_S_SD_MUX      "sd_mux"
+#define NPCM8XX_CLK_S_UART_MUX    "uart_mux"
+#define NPCM8XX_CLK_S_SU_MUX      "serial_usb_mux"
+#define NPCM8XX_CLK_S_MC_MUX      "mc_mux"
+#define NPCM8XX_CLK_S_ADC_MUX     "adc_mux"
+#define NPCM8XX_CLK_S_GFX_MUX     "gfx_mux"
+#define NPCM8XX_CLK_S_CLKOUT_MUX  "clkout_mux"
+#define NPCM8XX_CLK_S_GFXM_MUX    "gfxm_mux"
+#define NPCM8XX_CLK_S_DVC_MUX     "dvc_mux"
+#define NPCM8XX_CLK_S_RG_MUX	  "rg_mux"
+#define NPCM8XX_CLK_S_RCP_MUX	  "rcp_mux"
+
+/* div definition */
+#define NPCM8XX_CLK_S_MC          "mc"
+#define NPCM8XX_CLK_S_AXI         "axi"
+#define NPCM8XX_CLK_S_AHB         "ahb"
+#define NPCM8XX_CLK_S_SPI0        "spi0"
+#define NPCM8XX_CLK_S_SPI1        "spi1"
+#define NPCM8XX_CLK_S_SPI3        "spi3"
+#define NPCM8XX_CLK_S_SPIX        "spix"
+#define NPCM8XX_CLK_S_APB1        "apb1"
+#define NPCM8XX_CLK_S_APB2        "apb2"
+#define NPCM8XX_CLK_S_APB3        "apb3"
+#define NPCM8XX_CLK_S_APB4        "apb4"
+#define NPCM8XX_CLK_S_APB5        "apb5"
+#define NPCM8XX_CLK_S_APB19       "apb19"
+#define NPCM8XX_CLK_S_TOCK        "tock"
+#define NPCM8XX_CLK_S_CLKOUT      "clkout"
+#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
+#define NPCM8XX_CLK_S_UART        "uart"
+#define NPCM8XX_CLK_S_UART2       "uart2"
+#define NPCM8XX_CLK_S_TIMER       "timer"
+#define NPCM8XX_CLK_S_MMC         "mmc"
+#define NPCM8XX_CLK_S_SDHC        "sdhc"
+#define NPCM8XX_CLK_S_ADC         "adc"
+#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
+#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
+#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
+#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
+#define NPCM8XX_CLK_S_PCI         "pci"
+#define NPCM8XX_CLK_S_TH          "th"
+#define NPCM8XX_CLK_S_ATB         "atb"
+#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
+#define NPCM8XX_CLK_S_RG	  "rg"
+#define NPCM8XX_CLK_S_RCP	  "rcp"
+
+static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
+static struct npcm8xx_clk_pll_data npcm8xx_pll_clks[] = {
+	{ NPCM8XX_CLK_S_PLL0, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON0, 0 },
+	{ NPCM8XX_CLK_S_PLL1, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON1, 0 },
+	{ NPCM8XX_CLK_S_PLL2, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON2, 0 },
+	{ NPCM8XX_CLK_S_PLL_GFX, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCONG, 0 },
+};
+
+static const u32 cpuck_mux_table[] = { 0, 1, 2, 7 };
+static const struct clk_parent_data cpuck_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 pixcksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data pixcksel_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[3].hw },
+	{ .index = 0 }
+};
+
+static const u32 default_mux_table[] = { 0, 1, 2, 3 };
+static const struct clk_parent_data default_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 sucksel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data sucksel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 mccksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data mccksel_mux_parents[] = {
+	{ .hw = &hw_pll1_div2 },
+	{ .index = 0 }
+};
+
+static const u32 clkoutsel_mux_table[] = { 0, 1, 2, 3, 4 };
+static const struct clk_parent_data clkoutsel_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &hw_gfx_div2 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 gfxmsel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data gfxmsel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 dvcssel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data dvcssel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 default3_mux_table[] = { 0, 1, 2 };
+static const struct clk_parent_data default3_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 }
+};
+
+static struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
+	{ 0, 7, cpuck_mux_table, NPCM8XX_CLK_S_CPU_MUX, cpuck_mux_parents,
+		ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL },
+	{ 4, 3, pixcksel_mux_table, NPCM8XX_CLK_S_PIX_MUX, pixcksel_mux_parents,
+		ARRAY_SIZE(pixcksel_mux_parents), 0 },
+	{ 6, 3, default_mux_table, NPCM8XX_CLK_S_SD_MUX, default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 8, 3, default_mux_table, NPCM8XX_CLK_S_UART_MUX, default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 10, 3, sucksel_mux_table, NPCM8XX_CLK_S_SU_MUX, sucksel_mux_parents,
+		ARRAY_SIZE(sucksel_mux_parents), 0 },
+	{ 12, 3, mccksel_mux_table, NPCM8XX_CLK_S_MC_MUX, mccksel_mux_parents,
+		ARRAY_SIZE(mccksel_mux_parents), 0 },
+	{ 14, 3, default_mux_table, NPCM8XX_CLK_S_ADC_MUX, default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 16, 3, default_mux_table, NPCM8XX_CLK_S_GFX_MUX, default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 18, 7, clkoutsel_mux_table, NPCM8XX_CLK_S_CLKOUT_MUX, clkoutsel_mux_parents,
+		ARRAY_SIZE(clkoutsel_mux_parents), 0 },
+	{ 21, 3, gfxmsel_mux_table, NPCM8XX_CLK_S_GFXM_MUX, gfxmsel_mux_parents,
+		ARRAY_SIZE(gfxmsel_mux_parents), 0 },
+	{ 23, 3, dvcssel_mux_table, NPCM8XX_CLK_S_DVC_MUX, dvcssel_mux_parents,
+		ARRAY_SIZE(dvcssel_mux_parents), 0 },
+	{ 25, 3, default3_mux_table, NPCM8XX_CLK_S_RG_MUX, default3_mux_parents,
+		ARRAY_SIZE(default3_mux_parents), 0 },
+	{ 27, 3, default3_mux_table, NPCM8XX_CLK_S_RCP_MUX, default3_mux_parents,
+		ARRAY_SIZE(default3_mux_parents), 0 },
+};
+
+static struct npcm8xx_clk_div_data npcm8xx_pre_divs[] = {
+	{ NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC, &npcm8xx_muxes[6].hw, CLK_DIVIDER_READ_ONLY, 0, -1 },
+	{ NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, &hw_pre_clk, CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
+};
+
+/* configurable dividers: */
+static struct npcm8xx_clk_div_data npcm8xx_divs[] = {
+	{ NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC, &npcm8xx_pre_divs[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
+	{ NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART, &npcm8xx_muxes[3].hw, 0, 0, NPCM8XX_CLK_UART },
+	{ NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC, &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC },
+	{ NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3, &npcm8xx_pre_divs[1].hw, 0, 0, NPCM8XX_CLK_SPI3 },
+	{ NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI, &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI },
+
+	{ NPCM8XX_CLKDIV2, 30, 2, NPCM8XX_CLK_S_APB4, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB4 },
+	{ NPCM8XX_CLKDIV2, 28, 2, NPCM8XX_CLK_S_APB3, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB3 },
+	{ NPCM8XX_CLKDIV2, 26, 2, NPCM8XX_CLK_S_APB2, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB2 },
+	{ NPCM8XX_CLKDIV2, 24, 2, NPCM8XX_CLK_S_APB1, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB1 },
+	{ NPCM8XX_CLKDIV2, 22, 2, NPCM8XX_CLK_S_APB5, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB5 },
+	{ NPCM8XX_CLKDIV2, 16, 5, NPCM8XX_CLK_S_CLKOUT, &npcm8xx_muxes[8].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT },
+	{ NPCM8XX_CLKDIV2, 13, 3, NPCM8XX_CLK_S_GFX, &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX },
+	{ NPCM8XX_CLKDIV2, 8, 5, NPCM8XX_CLK_S_USB_BRIDGE, &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU },
+	{ NPCM8XX_CLKDIV2, 4, 4, NPCM8XX_CLK_S_USB_HOST, &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48 },
+	{ NPCM8XX_CLKDIV2, 0, 4, NPCM8XX_CLK_S_SDHC, &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC },
+
+	{ NPCM8XX_CLKDIV3, 16, 8, NPCM8XX_CLK_S_SPI1, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
+	{ NPCM8XX_CLKDIV3, 11, 5, NPCM8XX_CLK_S_UART2, &npcm8xx_muxes[3].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2 },
+	{ NPCM8XX_CLKDIV3, 6, 5, NPCM8XX_CLK_S_SPI0, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
+	{ NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX, &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
+
+	{ NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, &npcm8xx_muxes[11].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG },
+	{ NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, &npcm8xx_muxes[12].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP },
+
+	{ NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, &npcm8xx_muxes[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
+};
+
+static struct clk_hw *
+npcm8xx_clk_register(struct device *dev, const char *name,
+		     struct regmap *clk_regmap, unsigned int offset,
+		     unsigned long flags, const struct clk_ops *npcm8xx_clk_ops,
+		     const struct clk_parent_data *parent_data,
+		     const struct clk_hw *parent_hw, u8 num_parents,
+		     u8 shift, u32 mask, unsigned long width,
+		     const u32 *table, unsigned long clk_flags)
+{
+	struct npcm8xx_clk *clk;
+	struct clk_init_data init = {};
+	int ret;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = npcm8xx_clk_ops;
+	init.parent_data = parent_data;
+	init.parent_hws = parent_hw ? &parent_hw : NULL;
+	init.num_parents = num_parents;
+	init.flags = flags;
+
+	clk->clk_regmap = clk_regmap;
+	clk->hw.init = &init;
+	clk->offset = offset;
+	clk->shift = shift;
+	clk->mask = mask;
+	clk->width = width;
+	clk->table = table;
+	clk->flags = clk_flags;
+
+	ret = devm_clk_hw_register(dev, &clk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &clk->hw;
+}
+
+static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct npcm8xx_clk *pll = to_npcm8xx_clk(hw);
+	unsigned long fbdv, indv, otdv1, otdv2;
+	unsigned int val;
+	u64 ret;
+
+	if (parent_rate == 0) {
+		pr_debug("%s: parent rate is zero\n", __func__);
+		return 0;
+	}
+
+	regmap_read(pll->clk_regmap, pll->offset, &val);
+
+	indv = FIELD_GET(PLLCON_INDV, val);
+	fbdv = FIELD_GET(PLLCON_FBDV, val);
+	otdv1 = FIELD_GET(PLLCON_OTDV1, val);
+	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
+
+	ret = (u64)parent_rate * fbdv;
+	do_div(ret, indv * otdv1 * otdv2);
+
+	return ret;
+}
+
+static const struct clk_ops npcm8xx_clk_pll_ops = {
+	.recalc_rate = npcm8xx_clk_pll_recalc_rate,
+};
+
+static u8 npcm8xx_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct npcm8xx_clk *mux = to_npcm8xx_clk(hw);
+	u32 val;
+
+	regmap_read(mux->clk_regmap, mux->offset, &val);
+	val = val >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
+}
+
+static const struct clk_ops npcm8xx_clk_mux_ops = {
+	.get_parent = npcm8xx_clk_mux_get_parent,
+};
+
+static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct npcm8xx_clk *div = to_npcm8xx_clk(hw);
+	unsigned int val;
+
+	regmap_read(div->clk_regmap, div->offset, &val);
+	val = val >> div->shift;
+	val &= clk_div_mask(div->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
+				   div->width);
+}
+
+static const struct clk_ops npcm8xx_clk_div_ops = {
+	.recalc_rate = npcm8xx_clk_div_get_parent,
+};
+
+static int npcm8xx_clk_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *npcm8xx_clk_data;
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct regmap *clk_regmap;
+	struct clk_hw *hw;
+	unsigned int i;
+
+	npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
+							 NPCM8XX_NUM_CLOCKS),
+					GFP_KERNEL);
+	if (!npcm8xx_clk_data)
+		return -ENOMEM;
+
+	clk_regmap = syscon_regmap_lookup_by_phandle(np, "nuvoton,sysclk");
+	if (IS_ERR(clk_regmap)) {
+		dev_err(&pdev->dev, "Failed to find nuvoton,sysclk\n");
+		return PTR_ERR(clk_regmap);
+	}
+
+	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
+
+	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
+		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	/* Register plls */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
+		struct npcm8xx_clk_pll_data *pll_clk = &npcm8xx_pll_clks[i];
+
+		hw = npcm8xx_clk_register(dev, pll_clk->name, clk_regmap,
+					  pll_clk->reg, pll_clk->flags,
+					  &npcm8xx_clk_pll_ops, &pll_clk->parent,
+					  NULL, 1, 0, 0, 0, NULL, 0);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll\n");
+		pll_clk->hw = *hw;
+	}
+
+	/* Register fixed dividers */
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_DIV2,
+					       NPCM8XX_CLK_S_PLL1, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register fixed div\n");
+	hw_pll1_div2 = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_DIV2,
+					       NPCM8XX_CLK_S_PLL2, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll2 div2\n");
+	hw_pll2_div2 = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL_GFX_DIV2,
+					       NPCM8XX_CLK_S_PLL_GFX, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register gfx div2\n");
+	hw_gfx_div2 = *hw;
+
+	/* Register muxes */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
+		struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
+
+		hw = npcm8xx_clk_register(dev, mux_data->name, clk_regmap,
+					  NPCM8XX_CLKSEL, mux_data->flags,
+					  &npcm8xx_clk_mux_ops,
+					  mux_data->parent_data, NULL,
+					  mux_data->num_parents,
+					  mux_data->shift, mux_data->mask, 0,
+					  mux_data->table, 0);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register mux\n");
+		mux_data->hw = *hw;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_CLK,
+					       NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre clk div2\n");
+	hw_pre_clk = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
+					       NPCM8XX_CLK_S_TH, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register axi div2\n");
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_AXI] = hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
+					       NPCM8XX_CLK_S_AXI, 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register atb div2\n");
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_ATB] = hw;
+
+	/* Register clock pre dividers specified in npcm8xx_divs */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pre_divs); i++) {
+		struct npcm8xx_clk_div_data *div_data = &npcm8xx_pre_divs[i];
+
+		hw = npcm8xx_clk_register(dev, div_data->name, clk_regmap,
+					  div_data->reg, div_data->flags,
+					  &npcm8xx_clk_div_ops, NULL,
+					  div_data->parent_hw, 1,
+					  div_data->shift, 0, div_data->width,
+					  NULL, div_data->clk_divider_flags);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre div table\n");
+		div_data->hw = *hw;
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	/* Register clock dividers specified in npcm8xx_divs */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
+		struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
+
+		hw = npcm8xx_clk_register(dev, div_data->name, clk_regmap,
+					  div_data->reg, div_data->flags,
+					  &npcm8xx_clk_div_ops, NULL,
+					  div_data->parent_hw, 1,
+					  div_data->shift, 0, div_data->width,
+					  NULL, div_data->clk_divider_flags);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register div table\n");
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   npcm8xx_clk_data);
+}
+
+static const struct of_device_id npcm8xx_clk_dt_ids[] = {
+	{ .compatible = "nuvoton,npcm845-clk", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
+
+static struct platform_driver npcm8xx_clk_driver = {
+	.probe  = npcm8xx_clk_probe,
+	.driver = {
+		.name = "npcm8xx_clk",
+		.of_match_table = npcm8xx_clk_dt_ids,
+	},
+};
+
+static int __init npcm8xx_clk_driver_init(void)
+{
+	return platform_driver_register(&npcm8xx_clk_driver);
+}
+arch_initcall(npcm8xx_clk_driver_init);
+
+static void __exit npcm8xx_clk_exit(void)
+{
+	platform_driver_unregister(&npcm8xx_clk_driver);
+}
+module_exit(npcm8xx_clk_exit);
+
+MODULE_DESCRIPTION("Clock driver for Nuvoton NPCM8XX BMC SoC");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
2.34.1


