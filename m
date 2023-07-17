Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6975633B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGQMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:52:35 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2403D1B0;
        Mon, 17 Jul 2023 05:52:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5TsJu020476;
        Mon, 17 Jul 2023 05:52:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=1BFeljk/Xu16TpDvpPjo7fVmgH1xWGHjLKmZjHDjzns=;
 b=jil63MCbVRFfrAPv3XrlbFUqKWqMD0w0vs7s0O5TdLOra2RABLkqeLjCjYwDHrs3vcmi
 tDVEH/jjohQ3+VfkdkNiISjBQcKUfieZHTjyhpjZuVXVjm/vm8coPgyRvk0sq87t/wZ3
 82ubRN6F0YYRj+nnBaDpdD090ZJbG/Fa16H/VCthpI07opxupgvrU21H+Zw8flbECgOr
 +2TLOhWLqsG93lbtFNV22s5OyJsOylk6zBJ2rxvOWV4zTLGmebjYuk9sX07+3aBJTLh2
 Oh8CGUnyTCEp/NmmXH2NEmvBtqKW1yeQqPt7VjpAFkj7KLQsBLa0Hfnv/2VrsUUl9o9/ 0g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx18kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:52:23 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 05:52:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 05:52:22 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 093293F70A4;
        Mon, 17 Jul 2023 05:52:22 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Dhananjay Kangude <dkangude@cadence.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v4 1/6] mmc: sdhci-cadence: Rename functions/structures to SD4 specific
Date:   Mon, 17 Jul 2023 05:51:41 -0700
Message-ID: <20230717125146.16791-2-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717125146.16791-1-pmalgujar@marvell.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: akx7PtFYbmdeSvORIIbOvj_ySMiVNsez
X-Proofpoint-ORIG-GUID: akx7PtFYbmdeSvORIIbOvj_ySMiVNsez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_10,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhananjay Kangude <dkangude@cadence.com>

Renaming the functions and structures specific to SD4 so
that it can be separated from upcoming SD6 related
functionality.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 92 ++++++++++++++++----------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index d2f62505468932b069e3411f2a4b7418ffece517..9bb38281bcb244b0be91ef579046c40de7a06e1f 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -16,14 +16,14 @@
 
 #include "sdhci-pltfm.h"
 
-/* HRS - Host Register Set (specific to Cadence) */
-#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
-#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
-#define   SDHCI_CDNS_HRS04_RD			BIT(25)
-#define   SDHCI_CDNS_HRS04_WR			BIT(24)
-#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
-#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
-#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
+/* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */
+#define SDHCI_CDNS_HRS04			0x10	/* PHY access port */
+#define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
+#define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
+#define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
+#define SDHCI_CDNS_SD4_HRS04_RDATA		GENMASK(23, 16)
+#define SDHCI_CDNS_SD4_HRS04_WDATA		GENMASK(15, 8)
+#define SDHCI_CDNS_SD4_HRS04_ADDR		GENMASK(5, 0)
 
 #define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
 #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
@@ -39,7 +39,7 @@
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
 
-/* PHY */
+/* PHY registers for SD4 controller */
 #define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
 #define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
 #define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
@@ -60,7 +60,7 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
-struct sdhci_cdns_phy_param {
+struct sdhci_cdns_sd4_phy_param {
 	u8 addr;
 	u8 data;
 };
@@ -73,10 +73,10 @@ struct sdhci_cdns_priv {
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[];
+	struct sdhci_cdns_sd4_phy_param phy_params[];
 };
 
-struct sdhci_cdns_phy_cfg {
+struct sdhci_cdns_sd4_phy_cfg {
 	const char *property;
 	u8 addr;
 };
@@ -86,7 +86,7 @@ struct sdhci_cdns_drv_data {
 	const struct sdhci_pltfm_data pltfm_data;
 };
 
-static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
+static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
 	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
@@ -106,76 +106,76 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
 	writel(val, reg);
 }
 
-static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
-				    u8 addr, u8 data)
+static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
+					u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
 	int ret;
 
-	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
 				 0, 10);
 	if (ret)
 		return ret;
 
-	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
-	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
+	tmp = FIELD_PREP(SDHCI_CDNS_SD4_HRS04_WDATA, data) |
+	      FIELD_PREP(SDHCI_CDNS_SD4_HRS04_ADDR, addr);
 	priv->priv_writel(priv, tmp, reg);
 
-	tmp |= SDHCI_CDNS_HRS04_WR;
+	tmp |= SDHCI_CDNS_SD4_HRS04_WR;
 	priv->priv_writel(priv, tmp, reg);
 
-	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
+	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_SD4_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
-	tmp &= ~SDHCI_CDNS_HRS04_WR;
+	tmp &= ~SDHCI_CDNS_SD4_HRS04_WR;
 	priv->priv_writel(priv, tmp, reg);
 
-	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
 				 0, 10);
 
 	return ret;
 }
 
-static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
+static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
 {
 	unsigned int count = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
-		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++)
+		if (of_property_read_bool(np, sdhci_cdns_sd4_phy_cfgs[i].property))
 			count++;
 
 	return count;
 }
 
-static void sdhci_cdns_phy_param_parse(struct device_node *np,
-				       struct sdhci_cdns_priv *priv)
+static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
+					   struct sdhci_cdns_priv *priv)
 {
-	struct sdhci_cdns_phy_param *p = priv->phy_params;
+	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
 	u32 val;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
-		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++) {
+		ret = of_property_read_u32(np, sdhci_cdns_sd4_phy_cfgs[i].property,
 					   &val);
 		if (ret)
 			continue;
 
-		p->addr = sdhci_cdns_phy_cfgs[i].addr;
+		p->addr = sdhci_cdns_sd4_phy_cfgs[i].addr;
 		p->data = val;
 		p++;
 	}
 }
 
-static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
+static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
 
 	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
-					       priv->phy_params[i].data);
+		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
+						   priv->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -218,7 +218,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
 }
 
-static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
+static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
@@ -271,7 +271,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return 0;
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
-		if (sdhci_cdns_set_tune_val(host, i) ||
+		if (sdhci_cdns_sd4_set_tune_val(host, i) ||
 		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
 			cur_streak = 0;
 		} else { /* good */
@@ -288,7 +288,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	return sdhci_cdns_sd4_set_tune_val(host, end_of_streak - max_streak / 2);
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
@@ -410,7 +410,7 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct sdhci_ops sdhci_cdns_ops = {
+static const struct sdhci_ops sdhci_cdns_sd4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -421,7 +421,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	.pltfm_data = {
-		.ops = &sdhci_cdns_ops,
+	.ops = &sdhci_cdns_sd4_ops,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
 };
@@ -433,9 +433,9 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
 	},
 };
 
-static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
+static const struct sdhci_cdns_drv_data sdhci_cdns_sd4_drv_data = {
 	.pltfm_data = {
-		.ops = &sdhci_cdns_ops,
+		.ops = &sdhci_cdns_sd4_ops,
 	},
 };
 
@@ -497,9 +497,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_drv_data;
+		data = &sdhci_cdns_sd4_drv_data;
 
-	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
+	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
 	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
@@ -532,9 +532,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	sdhci_cdns_phy_param_parse(dev->of_node, priv);
+	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns_sd4_phy_init(priv);
 	if (ret)
 		goto free;
 
@@ -574,7 +574,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns_sd4_phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
-- 
2.17.1

