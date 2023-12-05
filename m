Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48B8051E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442047AbjLELSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjLELS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:18:29 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EC9E;
        Tue,  5 Dec 2023 03:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYI9QJcEwQpaHSdsmCjZ9nh4krzwOs6xa23uXdnw5oNirqZ4qKTJzyvpK6iGZ9MTq7sXJBTrK0dnVA6P/6rBViqH73ZzHV6y2YcmvOZmgLddXZ6MDr3QNwFlrS32IQcwO0m7r2d10OJVq20628VsmEvjFIEuaXm1xZSAAJUYtGPe0ymHKfsCRBI1iUr6xYQjxvIWqo+wm08IyeJKBKXZQDk3oMeFABkxTK1JzPb2WSQOr0rGoxXDh4y2bwOO4raeHu7Fw7ibOxYf4ekre0r/ZbJaeHklVauLHkFiEI+nnVprOpPYq/wPWLRfLYe4pm4/Ms7vsCxp0viUBxehb0yg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3UqRXdEe7d4GDSYX+AH+ARyjY//vGQDidiUpYWNS30=;
 b=GEUDVYSf/0Y2rpoJA7B0fWPESSe293uwURq4NWoTCQ6N0yDTjtosyWoR/3+XCumeO57RgOxxjMjlAguBx+Hl9PkRDh8eyMy2IFKOavhHQaEg5HlSVE6F0ePHl1RtoXBAG4TtMLTFj8/b5muB4QCx1XTAWbpk+i+7L3wDphQoAx9Fquar1XhpszGQBd4LzNv2ED1sXnntHKtxXrEDdcTTdT6QaFm/VIPPpYWZr4z62dspvN3lYJEQjx6+RWtsClBoORqEsA4pl2vxKP0uTvIS96KlqvobciW3bJ0Sfj/2wIEHbuQXvIRx6v0XDRexh14QaqU9TjbehSmwxQ1PxfpzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3UqRXdEe7d4GDSYX+AH+ARyjY//vGQDidiUpYWNS30=;
 b=IdPaVN/IUsYKJ5kx/Penb+KVI5ruiTyNDfZ8xXiN1sly9AEyZzit3Z0XJrAsVzOrEKIJzMMwqvB+vim4/NPiIzldlddd5FY0DqRcntpW9k4lY5tFOgAZs2exXiNg/o36oqDfRhFHJ81N/GLBo66gArUbE/GxoSvPVE/fzjm0kI8=
Received: from SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) by SEZPR03MB6715.apcprd03.prod.outlook.com
 (2603:1096:101:7f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:18:26 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:40:cafe::e1) by SG2PR01CA0115.outlook.office365.com
 (2603:1096:4:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 11:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:18:25 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 5
 Dec 2023 19:18:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 5 Dec 2023 19:18:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 1E2A85F5B2;
        Tue,  5 Dec 2023 13:18:24 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id EDDB3235CE11; Tue,  5 Dec 2023 13:18:23 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v21] clk: npcm8xx: add clock controller
Date:   Tue, 5 Dec 2023 13:18:22 +0200
Message-ID: <20231205111822.3036375-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR03MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebed69f-b1f5-4eec-3505-08dbf583e687
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVQwZkSTAw3uu7qXAo6HSww0JvIKbJtk65a2/vH1YCxQ6JGbpAKvFH49k5YbPL5ZMWc8+fCJcsu/zIzkrs7uj5MGL9N3MPezv5r/jWUufiakpWLtjZ2PEqNa6jbl8op0kK9QQhLHQhN3rYgFMi1wKMxMihPnqMatyJm6EGkZbaYDmsZjt3AGUBY43Myl3uLrpWSPno3Zq2FSI4G3ZiReYxn0dBr46YMyZozK1r3bdpD8NLt8ZksD9aiXyry9Z5jTSYXt3QG4YJ+l/8lvvhA6dZ5SqhamTCTnYNmBdW0TwSj1XMVuNgmGoiU3VrRUfIZA07D+E8PyGM4MUjt8kz4n6u4DRo5fkB1Sc50wtqIPnkYkg9+qe3obwJet9Ew5aHLKICULqTM84IMIMWbYYKmEtngDzccIVytFGZFqM1ICK/9KfthFynD3T6CuqXbROYM7JXO2B9WYlSYYVYTtWWoEo3C1QqJwEbTqChCr6BlKInoNZZof+MunqC2RIaZmrrMqlmMSGR6OJSd7gmKWdv2NtcS8eT0cJ3TvYghuS5UsErQoLUD3cHHMsWnDTHPLKir2mifPZ7z+jD4rRiG0QUbZn+yi8mtgRF9iC+vSQglC67Fkm/4FjkR7LXIqf1gHdd704iw2pGuHnjQB51xKM2vcpxi6iJU4nQw+mhDDnlGLJhlkso8ZNVqvjjSeq+h1Zy2ZtiGdBNE0otbyDaDwF+i36KGO3xsgmAYBq9jrHtD3wKRu0UFgbSfNhjpb41CyQ/+03f5kjb07oTF/JgvN+n/zEIYjtQ1uolf0YaAx3KYij6CGbXSOjwFuzTDAmwQcnWZMC/+gljzsFVvxWAgHuKDLUs2WPf4CyooXf7WCQy+S0Ds+WBckAlTzYLzjnr9XFd4LDJwG/BtLyiKw5M+FNEgT5A==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(186009)(451199024)(61400799012)(48200799006)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(7416002)(2906002)(30864003)(966005)(40460700003)(478600001)(8936002)(4326008)(8676002)(110136005)(70586007)(55446002)(54906003)(70206006)(42186006)(316002)(5660300002)(76482006)(336012)(73392003)(6266002)(42882007)(1076003)(82202003)(26005)(82740400003)(81166007)(356005)(47076005)(36860700001)(83170400001)(83380400001)(40480700001)(41300700001)(2616005)(36756003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:18:25.8948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebed69f-b1f5-4eec-3505-08dbf583e687
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6715
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.33.0

