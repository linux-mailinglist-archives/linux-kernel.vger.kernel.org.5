Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDFC7F322E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjKUPRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjKUPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:17:48 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B70BD;
        Tue, 21 Nov 2023 07:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2Xx9uvBEkrbza76HreBZ3sNmlQ4SG7aTB8tng6ZWlreQZ5TxAbJNcSJNTVO8Wj+U0IALTIly2OHMnAzL+/12boa0pdOBUsBNN+AW5n7B7mM4uOtK0ThKF7VA9q89/sQ6RzIknOZCBUZQmtcl/PL4UHzCxN1Oh1ne16pB0s0OCtAtK8vtR1w5qAYgYNDK7dOmrDvpmG44gO6otYRk5u/Wfi35Ox5WtQvhp771h6C5iGR1o1GCd/ZE0l5faJ87vT3/lBVQ5olaiBwbZnsYOmOy26axHGYkIpGlsNPT8lu9v/BsXwWpl2GrkMjKmPuA7xCfmJVLfCAUe7VSaAR1GT/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsxyS+EBEcMh9D/3MoDQ5Q14lf8Ya3LsFxMz39xL6fw=;
 b=eWkRpvurgtzO25rFQy7+z0YmglukL+THi0E8SwSK35YOBThLNLeKI00stv+tEjf1Im4g0UCWSahK95EqgKd1cCGDPvxiP/S7f103uMjml4YcHXrYdz6lxqCjAgCQdcIq3ErBAK9F//MQQYXEIPMlcAZZWPap533cwgy+B7vm7KYiNWzLNDkQh+/R0ci86I3iLLUzljSMtWUtxtuaej2+sX0FyaOkphdGAneQcIMfSCeYDZujiPQ+DIpqyvTkoinIZJqXI00E9atHlSPDGaPWs82mMsx7UEbCIxeLmqXDu6rbhNB904+rM8ihybTudYdj6UcQXyf9uR+Bwjge9F8VZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsxyS+EBEcMh9D/3MoDQ5Q14lf8Ya3LsFxMz39xL6fw=;
 b=AX4qUv5oO2du1g15ihaO11If6lwBk4KsfycwVIwmRnXVtd/AgtAB8sfg2LpNJvgkHwtoeFnGGdGqTazS2eLIZJx5L9MMYMm0eHcrX9elWf3+KAat326+9pqVVTdJKdbUff5BOWluTuu3qFHr772YlSBhrP1LZxgG151kbN4HDAY=
Received: from SG2PR04CA0200.apcprd04.prod.outlook.com (2603:1096:4:187::15)
 by SI6PR03MB8705.apcprd03.prod.outlook.com (2603:1096:4:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 15:17:40 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:187:cafe::6b) by SG2PR04CA0200.outlook.office365.com
 (2603:1096:4:187::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 15:17:40 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 21
 Nov 2023 23:17:39 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 21 Nov
 2023 23:17:39 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 23:17:39 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id B26A35F63F;
        Tue, 21 Nov 2023 17:17:37 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 9EC7B235CE27; Tue, 21 Nov 2023 17:17:36 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] net: stmmac: Add NPCM support
Date:   Tue, 21 Nov 2023 17:17:33 +0200
Message-ID: <20231121151733.2015384-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231121151733.2015384-1-tmaimon77@gmail.com>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SI6PR03MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae92dbe-d3bc-4f90-22b0-08dbeaa500ab
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLF0PbdKo4Rl1isfDncngsA0ttranzlel9Hhh8KQV27l/ljw0hza7C0LRLcl9lRJat/mW1LJd0FIVJV3VtUkbqRRDwgP4q6J0MUu/dQcZsDctVeZtlzUb1/J/csdFwsKChmyTCKiol9saqBK5BRdOBtHjF476OLgPZ+R03a3lZV9A3LIL+w2vUtRg862LD+D71AkvBqRm4gCSjv2Pq1l4KBGxFDil4KQPLIYDs4kr8w912knuQngRijYaK7kKCBtlIj/QpVwyu+MjnxwoQfHGOvaLWncJ69E52oycw4Chn5a0I/v8eDqsQzOmSf76a/+a/Do3dnLLq6BArmaA3HDZSijAl4hJQGZ/IteFDsYzjlo5MhxHiNKZISkSDA2uW6k1Jk4rGt/xorrAUVrYoBvOp5pNLKejHAKzVwlQlMUIkYVwLjVl2+LczjB3OkjnQXkb6FfajCigLGea/xbl5oY6/AW0am1EftpeY5xEfN0YSprKT7O+VzdVTJ7pB1705JNCRiGP2ItEBGyH9KlYdpKTjwp7JrWC4pKGDN4fE6Kf8GWWnu3GJjA/m97rClTO2JfOmRcoYOL185hJd1A5TFgwX4FvQRUiefRen27hf4OpD3cOCy3A3LSDojsZh2Ljb0K0XqYa46LIurtBYEBgKNMZ1aOmYbUtG6BZRaYu1UfxHw15WPnZDXc1dR+oLsu4MRxPtS60fKvg8MDeQSNUH4eQvMSwiCDf/N+SaVIx0oEY0XQCcpXsHQFGfFHW/Ymhc6Ef+cxbtN/nJz0/EyQ0H0MlfDcBgTDOzfbKbg/ylpelm5En7TphsYzi32FcjOWfbKkcP4Xb4L3siiPOowZ5gP4/zlZl/52yobW/bNHvLYi5ws=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(48200799006)(61400799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(40480700001)(2906002)(8936002)(41300700001)(4326008)(8676002)(7416002)(5660300002)(316002)(42186006)(110136005)(54906003)(76482006)(40460700003)(70586007)(47076005)(55446002)(478600001)(1076003)(26005)(82202003)(73392003)(83170400001)(6666004)(36756003)(70206006)(2616005)(6266002)(42882007)(336012)(81166007)(921008)(83380400001)(36860700001)(356005)(82740400003)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:17:40.3682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae92dbe-d3bc-4f90-22b0-08dbeaa500ab
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8705
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

Add Nuvoton NPCM BMC SoCs support to STMMAC dwmac driver.

And modify MAINTAINERS to add a new F: entry for this driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-npcm.c  | 121 ++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c9f868e13b6..43059c7d00c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2507,6 +2507,7 @@ F:	arch/arm64/boot/dts/nuvoton/
 F:	drivers/*/*/*npcm*
 F:	drivers/*/*npcm*
 F:	drivers/rtc/rtc-nct3018y.c
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 F:	include/dt-bindings/clock/nuvoton,npcm845-clk.h
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index a2b9e289aa36..2487a674d0d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -121,6 +121,15 @@ config DWMAC_MESON
 	  the stmmac device driver. This driver is used for Meson6,
 	  Meson8, Meson8b and GXBB SoCs.
 
+config DWMAC_NPCM
+	tristate "Nuvoton NPCM dwmac support"
+	depends on OF && (ARCH_NPCM || COMPILE_TEST)
+	help
+	  Support for Ethernet controller on Nuvoton NPCM BMC SoCs.
+
+	  This selects the Nuvoton NPCM BMC SoC glue layer support for
+	  the stmmac device driver. This driver is used for NPCM8xx SoCs.
+
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 80e598bd4255..1c86c8ca39f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
 obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
 obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
+obj-$(CONFIG_DWMAC_NPCM)	+= dwmac-npcm.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+= dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c
new file mode 100644
index 000000000000..dbb857661142
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2023 Nuvoton Technology corporation.
+
+#include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/stmmac.h>
+
+#include "stmmac_platform.h"
+
+#define IND_AC_BA_REG		0x1FE
+#define SR_MII_CTRL		0x3E0000
+
+#define PCS_SR_MII_CTRL_REG	0x0
+#define PCS_SPEED_SELECT6	BIT(6)
+#define PCS_AN_ENABLE		BIT(12)
+#define PCS_SPEED_SELECT13	BIT(13)
+#define PCS_RST			BIT(15)
+
+#define PCS_MASK_SPEED		0xDFBF
+
+struct npcm_dwmac {
+	void __iomem	*reg;
+};
+
+static void npcm_dwmac_fix_mac_speed(void *priv, unsigned int speed,
+				     unsigned int mode)
+{
+	struct npcm_dwmac *dwmac = priv;
+	u16 val;
+
+	iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
+	val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
+	val &= PCS_MASK_SPEED;
+
+	switch (speed) {
+	case SPEED_1000:
+		val |= PCS_SPEED_SELECT6;
+		break;
+	case SPEED_100:
+		val |= PCS_SPEED_SELECT13;
+		break;
+	case SPEED_10:
+		break;
+	}
+
+	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
+}
+
+void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
+			 struct plat_stmmacenet_data *plat_dat)
+{
+	u16 val;
+
+	iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
+	val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
+	val |= PCS_RST;
+	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
+
+	while (val & PCS_RST)
+		val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
+
+	val &= ~(PCS_AN_ENABLE);
+	iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
+}
+
+static int npcm_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct npcm_dwmac *dwmac;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
+	if (!dwmac)
+		ret = -ENOMEM;
+
+	dwmac->reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(dwmac->reg))
+		ret = PTR_ERR(dwmac->reg);
+
+	npcm_dwmac_pcs_init(dwmac, &pdev->dev, plat_dat);
+
+	plat_dat->has_gmac = true;
+	plat_dat->bsp_priv = dwmac;
+	plat_dat->fix_mac_speed = npcm_dwmac_fix_mac_speed;
+
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id npcm_dwmac_match[] = {
+	{ .compatible = "nuvoton,npcm8xx-sgmii" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm_dwmac_match);
+
+static struct platform_driver npcm_dwmac_driver = {
+	.probe  = npcm_dwmac_probe,
+	.remove_new = stmmac_pltfr_remove,
+	.driver = {
+		.name           = "npcm-dwmac",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = npcm_dwmac_match,
+	},
+};
+module_platform_driver(npcm_dwmac_driver);
+
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton NPCM DWMAC glue layer");
+MODULE_LICENSE("GPL v2");
-- 
2.33.0

