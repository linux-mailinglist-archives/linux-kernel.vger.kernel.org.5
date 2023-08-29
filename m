Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6778C6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjH2N76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbjH2N7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:59:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0041199;
        Tue, 29 Aug 2023 06:59:30 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TAwOc6032638;
        Tue, 29 Aug 2023 13:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iYIfnZjbUYHSVE6a/sufjuTA2RHeOr3JWu/ffsRIzm4=;
 b=Ds0AF28LDcCpXYhzFj3cJuUqYQ1iDdd5wCdN4RZ/a+NMj3LlY1DcKsDT5q4zJEpxKLcf
 Es5UxRvsd25+c9bJokNkB8yEBat+r59eyCoTsiU24k/MfB2OF590UihckpnXGAk7CoAa
 XRcDC4uDXZym00gGOoNY5HzkGdbPMa1+eU/nhGiusosBsNUxlz4f+NGMxr/65GcDB0dh
 p7xvbljbEs+s+7mj5227xMg8uVOh3pWNIPwhU+J7D3Hl+h1Uc29+ReE1J/CeJWtosSzk
 CioCi5JDF+ntdpgLdvWyERXgACy4hrW47Q2WYanfcD+Ra/EF8MKcwYzusKcgdcHl4Lsy 4Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sruhntt1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:59:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDx0YN001964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:59:00 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 29 Aug 2023 06:58:52 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <quic_ipkumar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 3/9] phy: qcom: uniphy: Update UNIPHY driver to be a common driver
Date:   Tue, 29 Aug 2023 19:28:12 +0530
Message-ID: <20230829135818.2219438-4-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nK0B03q0KWuQBG4Yw8u5kGd0WR1J8AvU
X-Proofpoint-ORIG-GUID: nK0B03q0KWuQBG4Yw8u5kGd0WR1J8AvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=970 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the UNIPHY driver to be a common driver to
accommodate all UNIPHY / Combo PHY. This driver can be used for
both USB and PCIe UNIPHY. Using phy-mul-sel from DTS MUX selection
for USB / PCIe can be acheived.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-uniphy.c | 401 +++++++++++++++++++++----
 1 file changed, 335 insertions(+), 66 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.c b/drivers/phy/qualcomm/phy-qcom-uniphy.c
index da6f290af722..eb71588f5417 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy.c
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy.c
@@ -5,141 +5,410 @@
  * Based on code from
  * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
  *
+ * Modified the driver to be common for Qualcomm UNIPHYs
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
-struct ipq4019_usb_phy {
+struct uniphy_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+};
+
+#define UNIPHY_INIT_CFG(o, v)		\
+	{				\
+		.offset = o,		\
+		.val = v,		\
+	}
+
+struct uniphy_cfg {
+	const struct uniphy_init_tbl *init_seq;
+	int num_init_seq;
+	const char * const *clk_list;
+	int num_clks;
+	const char * const *reset_list;
+	int num_resets;
+	const char * const *vreg_list;
+	int num_vregs;
+	unsigned int pipe_clk_rate;
+	unsigned int reset_udelay;
+	unsigned int autoload_udelay;
+};
+
+struct qcom_uniphy {
 	struct device		*dev;
+	const struct uniphy_cfg	*cfg;
 	struct phy		*phy;
 	void __iomem		*base;
-	struct reset_control	*por_rst;
-	struct reset_control	*srif_rst;
+	struct clk_bulk_data	*clks;
+	struct reset_control_bulk_data	*resets;
+	struct regulator_bulk_data *vregs;
+	struct clk_fixed_rate pipe_clk_fixed;
+};
+
+static const char * const ipq4019_ssphy_reset_l[] = {
+	"por_rst",
+};
+
+static const struct uniphy_cfg ipq4019_usb_ssphy_cfg = {
+	.reset_list	= ipq4019_ssphy_reset_l,
+	.num_resets	= ARRAY_SIZE(ipq4019_ssphy_reset_l),
+	.reset_udelay	= 10000,
+
 };
 
-static int ipq4019_ss_phy_power_off(struct phy *_phy)
+static const char * const ipq4019_hsphy_reset_l[] = {
+	"por_rst", "srif_rst",
+};
+
+static const struct uniphy_cfg ipq4019_usb_hsphy_cfg = {
+	.reset_list	= ipq4019_hsphy_reset_l,
+	.num_resets	= ARRAY_SIZE(ipq4019_hsphy_reset_l),
+	.reset_udelay	= 10000,
+};
+
+static int phy_mux_sel(struct phy *phy)
+{
+	struct qcom_uniphy *uniphy = phy_get_drvdata(phy);
+	struct device *dev = uniphy->dev;
+	struct regmap *tcsr;
+	unsigned int args[2];
+	int ret;
+
+	tcsr = syscon_regmap_lookup_by_phandle_args(dev->of_node, "qcom,phy-mux-sel",
+						    ARRAY_SIZE(args), args);
+	if (IS_ERR(tcsr)) {
+		ret = PTR_ERR(tcsr);
+		if (ret == -ENOENT)
+			return 0;
+
+		dev_err(dev, "failed to lookup syscon for phy mux %d\n", ret);
+		return ret;
+	}
+
+	/* PHY MUX registers only have this BIT0 */
+	ret = regmap_write(tcsr, args[0], args[1]);
+	if (ret < 0) {
+		dev_err(dev, "PHY Mux selection failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int uniphy_enable(struct phy *phy)
 {
-	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+	struct qcom_uniphy *uniphy = phy_get_drvdata(phy);
+	const struct uniphy_cfg *cfg = uniphy->cfg;
+	const struct uniphy_init_tbl *tbl;
+	void __iomem *base = uniphy->base;
+	int i, ret;
 
-	reset_control_assert(phy->por_rst);
-	msleep(10);
+	ret = regulator_bulk_enable(cfg->num_vregs, uniphy->vregs);
+	if (ret) {
+		dev_err(uniphy->dev, "failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	/* Assert all available resets */
+	for (i = 0; i < cfg->num_resets; i++) {
+		ret = reset_control_assert(uniphy->resets[i].rstc);
+		if (ret) {
+			dev_err(uniphy->dev, "reset assert failed: %d\n", ret);
+			goto err_assert_reset;
+		}
+		if (cfg->reset_udelay)
+			usleep_range(cfg->reset_udelay, cfg->reset_udelay + 10);
+	}
+
+	/* Deassert all available resets */
+	for (i = 0; i < cfg->num_resets; i++) {
+		ret = reset_control_deassert(uniphy->resets[i].rstc);
+		if (ret) {
+			dev_err(uniphy->dev, "reset deassert failed: %d\n", ret);
+			goto err_assert_reset;
+		}
+		if (cfg->reset_udelay)
+			usleep_range(cfg->reset_udelay, cfg->reset_udelay + 10);
+	}
+
+	ret = phy_mux_sel(phy);
+	if (ret < 0)
+		goto err_assert_reset;
+
+	ret = clk_bulk_prepare_enable(cfg->num_clks, uniphy->clks);
+	if (ret) {
+		dev_err(uniphy->dev, "failed to enable clocks: %d\n", ret);
+		goto err_assert_reset;
+	}
+
+	if (cfg->autoload_udelay)
+		usleep_range(cfg->autoload_udelay, cfg->autoload_udelay + 10);
+
+	if (cfg->num_init_seq) {
+		tbl = cfg->init_seq;
+		for (i = 0; i < cfg->num_init_seq; i++, tbl++)
+			writel(tbl->val, base + tbl->offset);
+	}
 
 	return 0;
+
+err_assert_reset:
+	/* Assert all available resets */
+	for (i = 0; i < cfg->num_resets; i++) {
+		reset_control_assert(uniphy->resets[i].rstc);
+		if (cfg->reset_udelay)
+			usleep_range(cfg->reset_udelay, cfg->reset_udelay + 10);
+	}
+
+	return ret;
 }
 
-static int ipq4019_ss_phy_power_on(struct phy *_phy)
+static int uniphy_disable(struct phy *phy)
 {
-	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+	struct qcom_uniphy *uniphy = phy_get_drvdata(phy);
+	const struct uniphy_cfg *cfg = uniphy->cfg;
+	int i;
 
-	ipq4019_ss_phy_power_off(_phy);
+	/* Assert all available resets */
+	for (i = 0; i < cfg->num_resets; i++) {
+		reset_control_assert(uniphy->resets[i].rstc);
+		if (cfg->reset_udelay)
+			usleep_range(cfg->reset_udelay, cfg->reset_udelay + 10);
+	}
 
-	reset_control_deassert(phy->por_rst);
+	clk_bulk_disable_unprepare(cfg->num_clks, uniphy->clks);
+
+	regulator_bulk_disable(cfg->num_vregs, uniphy->vregs);
 
 	return 0;
 }
 
-static const struct phy_ops ipq4019_usb_ss_phy_ops = {
-	.power_on	= ipq4019_ss_phy_power_on,
-	.power_off	= ipq4019_ss_phy_power_off,
+static const struct phy_ops uniphy_phy_ops = {
+	.power_on	= uniphy_enable,
+	.power_off	= uniphy_disable,
+	.owner		= THIS_MODULE,
 };
 
-static int ipq4019_hs_phy_power_off(struct phy *_phy)
+static int qcom_uniphy_vreg_init(struct qcom_uniphy *uniphy)
+{
+	const struct uniphy_cfg *cfg = uniphy->cfg;
+	struct device *dev = uniphy->dev;
+	int i, ret;
+
+	uniphy->vregs = devm_kcalloc(dev, cfg->num_vregs,
+				     sizeof(*uniphy->vregs), GFP_KERNEL);
+	if (!uniphy->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->num_vregs; i++)
+		uniphy->vregs[i].supply = cfg->vreg_list[i];
+
+	ret = devm_regulator_bulk_get(dev, cfg->num_vregs, uniphy->vregs);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
+	return 0;
+}
+
+static int qcom_uniphy_reset_init(struct qcom_uniphy *uniphy)
 {
-	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+	const struct uniphy_cfg *cfg = uniphy->cfg;
+	struct device *dev = uniphy->dev;
+	int i, ret;
+
+	uniphy->resets = devm_kcalloc(dev, cfg->num_resets,
+				      sizeof(*uniphy->resets), GFP_KERNEL);
+	if (!uniphy->resets)
+		return -ENOMEM;
 
-	reset_control_assert(phy->por_rst);
-	msleep(10);
+	for (i = 0; i < cfg->num_resets; i++)
+		uniphy->resets[i].id = cfg->reset_list[i];
 
-	reset_control_assert(phy->srif_rst);
-	msleep(10);
+	ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_resets, uniphy->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get resets\n");
 
 	return 0;
 }
 
-static int ipq4019_hs_phy_power_on(struct phy *_phy)
+static int qcom_uniphy_clk_init(struct qcom_uniphy *uniphy)
 {
-	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+	const struct uniphy_cfg *cfg = uniphy->cfg;
+	struct device *dev = uniphy->dev;
+	int i, ret;
 
-	ipq4019_hs_phy_power_off(_phy);
 
-	reset_control_deassert(phy->srif_rst);
-	msleep(10);
+	uniphy->clks = devm_kcalloc(dev, cfg->num_clks,
+				    sizeof(*uniphy->clks), GFP_KERNEL);
+	if (!uniphy->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->num_clks; i++)
+		uniphy->clks[i].id = cfg->clk_list[i];
 
-	reset_control_deassert(phy->por_rst);
+	ret = devm_clk_bulk_get(dev, cfg->num_clks, uniphy->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
 	return 0;
 }
 
-static const struct phy_ops ipq4019_usb_hs_phy_ops = {
-	.power_on	= ipq4019_hs_phy_power_on,
-	.power_off	= ipq4019_hs_phy_power_off,
-};
+static void phy_clk_release_provider(void *res)
+{
+	of_clk_del_provider(res);
+}
 
-static const struct of_device_id ipq4019_usb_phy_of_match[] = {
-	{ .compatible = "qcom,usb-hs-ipq4019-phy", .data = &ipq4019_usb_hs_phy_ops},
-	{ .compatible = "qcom,usb-ss-ipq4019-phy", .data = &ipq4019_usb_ss_phy_ops},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, ipq4019_usb_phy_of_match);
+/*
+ * Register a fixed rate pipe clock.
+ *
+ * The <s>_pipe_clksrc generated by PHY goes to the GCC that gate
+ * controls it. The <s>_pipe_clk coming out of the GCC is requested
+ * by the PHY driver for its operations.
+ * We register the <s>_pipe_clksrc here. The gcc driver takes care
+ * of assigning this <s>_pipe_clksrc as parent to <s>_pipe_clk.
+ * Below picture shows this relationship.
+ *
+ *         +---------------+
+ *         |   PHY block   |<<---------------------------------------+
+ *         |               |                                         |
+ *         |   +-------+   |                   +-----+               |
+ *   I/P---^-->|  PLL  |---^--->pipe_clksrc--->| GCC |--->pipe_clk---+
+ *    clk  |   +-------+   |                   +-----+
+ *         +---------------+
+ */
+static int phy_pipe_clk_register(struct qcom_uniphy *uniphy, struct device_node *np)
+{
+	struct clk_fixed_rate *fixed = &uniphy->pipe_clk_fixed;
+	const struct uniphy_cfg *cfg = uniphy->cfg;
+	struct device *dev = uniphy->dev;
+	struct clk_init_data init = { };
+	int ret;
+
+	ret = of_property_read_string(np, "clock-output-names", &init.name);
+	if (ret) {
+		dev_err(dev, "%pOFn: No clock-output-names\n", np);
+		return ret;
+	}
+
+	init.ops = &clk_fixed_rate_ops;
+
+	fixed->fixed_rate = cfg->pipe_clk_rate;
+	fixed->hw.init = &init;
 
-static int ipq4019_usb_phy_probe(struct platform_device *pdev)
+	ret = devm_clk_hw_register(dev, &fixed->hw);
+	if (ret)
+		return ret;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
+	if (ret)
+		return ret;
+
+	/*
+	 * Roll a devm action because the clock provider is the child node, but
+	 * the child node is not actually a device.
+	 */
+	return devm_add_action_or_reset(dev, phy_clk_release_provider, np);
+}
+
+static int qcom_uniphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
-	struct ipq4019_usb_phy *phy;
+	struct qcom_uniphy *uniphy;
+	struct device_node *np;
+	int ret;
 
-	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
+	uniphy = devm_kzalloc(dev, sizeof(*uniphy), GFP_KERNEL);
+	if (!uniphy)
 		return -ENOMEM;
 
-	phy->dev = &pdev->dev;
-	phy->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(phy->base)) {
-		dev_err(dev, "failed to remap register memory\n");
-		return PTR_ERR(phy->base);
-	}
+	uniphy->dev = dev;
 
-	phy->por_rst = devm_reset_control_get(phy->dev, "por_rst");
-	if (IS_ERR(phy->por_rst)) {
-		if (PTR_ERR(phy->por_rst) != -EPROBE_DEFER)
-			dev_err(dev, "POR reset is missing\n");
-		return PTR_ERR(phy->por_rst);
+	uniphy->cfg = of_device_get_match_data(dev);
+	if (!uniphy->cfg)
+		return -EINVAL;
+
+	uniphy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(uniphy->base)) {
+		ret = PTR_ERR(uniphy->base);
+		dev_err_probe(dev, ret, "failed to remap register memory\n");
+		return ret;
 	}
 
-	phy->srif_rst = devm_reset_control_get_optional(phy->dev, "srif_rst");
-	if (IS_ERR(phy->srif_rst))
-		return PTR_ERR(phy->srif_rst);
+	ret = qcom_uniphy_clk_init(uniphy);
+	if (ret)
+		return ret;
+
+	ret = qcom_uniphy_reset_init(uniphy);
+	if (ret)
+		return ret;
+
+	ret = qcom_uniphy_vreg_init(uniphy);
+	if (ret < 0)
+		return ret;
+
+	if (uniphy->cfg->pipe_clk_rate) {
+		np = of_node_get(dev->of_node);
+		ret = phy_pipe_clk_register(uniphy, np);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to register pipe clk\n");
+			goto err;
+		}
+	}
 
-	phy->phy = devm_phy_create(dev, NULL, of_device_get_match_data(dev));
-	if (IS_ERR(phy->phy)) {
-		dev_err(dev, "failed to create PHY\n");
-		return PTR_ERR(phy->phy);
+	uniphy->phy = devm_phy_create(dev, NULL, &uniphy_phy_ops);
+	if (IS_ERR(uniphy->phy)) {
+		ret = PTR_ERR(uniphy->phy);
+		dev_err_probe(dev, ret, "failed to create PHY\n");
+		goto err;
 	}
-	phy_set_drvdata(phy->phy, phy);
+
+	phy_set_drvdata(uniphy->phy, uniphy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
-	return PTR_ERR_OR_ZERO(phy_provider);
+	ret = PTR_ERR_OR_ZERO(phy_provider);
+
+err:
+	if (uniphy->cfg->pipe_clk_rate)
+		of_node_put(np);
+	return ret;
 }
 
-static struct platform_driver ipq4019_usb_phy_driver = {
-	.probe	= ipq4019_usb_phy_probe,
+static const struct of_device_id qcom_uniphy_of_match[] = {
+	{ .compatible = "qcom,usb-hs-ipq4019-phy", .data = &ipq4019_usb_hsphy_cfg},
+	{ .compatible = "qcom,usb-ss-ipq4019-phy", .data = &ipq4019_usb_ssphy_cfg},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_uniphy_of_match);
+
+static struct platform_driver qcom_uniphy_driver = {
+	.probe	= qcom_uniphy_probe,
 	.driver = {
-		.of_match_table	= ipq4019_usb_phy_of_match,
-		.name  = "ipq4019-usb-phy",
+		.of_match_table	= qcom_uniphy_of_match,
+		.name  = "qcom-uniphy",
 	}
 };
-module_platform_driver(ipq4019_usb_phy_driver);
+module_platform_driver(qcom_uniphy_driver);
 
-MODULE_DESCRIPTION("QCOM/IPQ4019 USB phy driver");
+MODULE_DESCRIPTION("QCOM uniphy driver");
 MODULE_AUTHOR("John Crispin <john@phrozen.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1

