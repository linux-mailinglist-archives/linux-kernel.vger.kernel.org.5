Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A497BC15F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjJFVkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjJFVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:40:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C378D62;
        Fri,  6 Oct 2023 14:40:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CFBC433C9;
        Fri,  6 Oct 2023 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628408;
        bh=U+v1bDX876I+IqgVMBfBBhar56/4ZmnjiDESPdx1WkY=;
        h=From:To:Cc:Subject:Date:From;
        b=Yxd8EXS7TQ31GKHO6UP24p+vYelfNwyO9jV3wuL9tiw+orNn21Csfp3/QWT8qOzAT
         2MxzMhcuhpnButRi1ZFpb6FPpDVs/RoABodd0WD6P6T9s9p8tLUga6d8MeJhwznU43
         wzIvF6nxCiyhD06hBuGOgwGhI7smf2ViJYaSgsu2veEGc6T8l5zDPOLmr0YPj/NSYe
         jtNMI4d7XmvTu/W7ufclp9pgyE2jxq5mGXx2t8w7myPF1OBlrLoCd/iMFATYNK4S14
         lMDXLwN1kbWSlkCK5AMa9bmuzL4G6XskFEgbPelwpGLvhJOo/WqBluxjzW6QSadits
         A0F3BOe+aUWQw==
Received: (nullmailer pid 334605 invoked by uid 1000);
        Fri, 06 Oct 2023 21:40:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] clk: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:39:58 -0500
Message-Id: <20231006213959.334439-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/clk-lochnagar.c             |  9 ++-------
 drivers/clk/davinci/da8xx-cfgchip.c     |  8 +++-----
 drivers/clk/davinci/pll.c               | 10 +++-------
 drivers/clk/davinci/psc.c               | 10 +++-------
 drivers/clk/qcom/gcc-msm8960.c          | 13 +++++--------
 drivers/clk/qcom/gcc-msm8974.c          | 10 +++-------
 drivers/clk/qcom/kpss-xcc.c             |  9 ++-------
 drivers/clk/qcom/krait-cc.c             | 14 +++++---------
 drivers/clk/qcom/mmcc-msm8960.c         | 16 +++++-----------
 drivers/clk/qcom/mmcc-sdm660.c          |  8 ++------
 drivers/clk/rockchip/clk-rk3399.c       |  9 ++-------
 drivers/clk/samsung/clk-exynos-clkout.c |  8 +++-----
 drivers/clk/ti/adpll.c                  | 14 ++++----------
 13 files changed, 42 insertions(+), 96 deletions(-)

diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
index db468a62c8d7..5561a2c66b69 100644
--- a/drivers/clk/clk-lochnagar.c
+++ b/drivers/clk/clk-lochnagar.c
@@ -12,8 +12,8 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/lochnagar1_regs.h>
@@ -242,22 +242,17 @@ static int lochnagar_clk_probe(struct platform_device *pdev)
 	};
 	struct device *dev = &pdev->dev;
 	struct lochnagar_clk_priv *priv;
-	const struct of_device_id *of_id;
 	struct lochnagar_clk *lclk;
 	struct lochnagar_config *conf;
 	int ret, i;
 
-	of_id = of_match_device(lochnagar_of_match, dev);
-	if (!of_id)
-		return -EINVAL;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->regmap = dev_get_regmap(dev->parent, NULL);
-	conf = (struct lochnagar_config *)of_id->data;
+	conf = (struct lochnagar_config *)device_get_match_data(dev);
 
 	memcpy(priv->lclks, conf->clks, sizeof(priv->lclks));
 
diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index e5b2cdfe88ce..ad2d0df43dc6 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -11,10 +11,10 @@
 #include <linux/init.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -744,15 +744,13 @@ static int da8xx_cfgchip_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct da8xx_cfgchip_clk_platform_data *pdata = dev->platform_data;
-	const struct of_device_id *of_id;
 	da8xx_cfgchip_init clk_init = NULL;
 	struct regmap *regmap = NULL;
 
-	of_id = of_match_device(da8xx_cfgchip_of_match, dev);
-	if (of_id) {
+	clk_init = device_get_match_data(dev);
+	if (clk_init) {
 		struct device_node *parent;
 
-		clk_init = of_id->data;
 		parent = of_get_parent(dev->of_node);
 		regmap = syscon_node_to_regmap(parent);
 		of_node_put(parent);
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 87bdf8879045..5bbbb3a66477 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -18,11 +18,10 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/notifier.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_data/clk-davinci-pll.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -892,14 +891,11 @@ static int davinci_pll_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct davinci_pll_platform_data *pdata;
-	const struct of_device_id *of_id;
 	davinci_pll_init pll_init = NULL;
 	void __iomem *base;
 
-	of_id = of_match_device(davinci_pll_of_match, dev);
-	if (of_id)
-		pll_init = of_id->data;
-	else if (pdev->id_entry)
+	pll_init = device_get_match_data(dev);
+	if (!pll_init && pdev->id_entry)
 		pll_init = (void *)pdev->id_entry->driver_data;
 
 	if (!pll_init) {
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index cd85d9f158b0..355d1be0b5d8 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -18,10 +18,9 @@
 #include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
@@ -517,15 +516,12 @@ static const struct platform_device_id davinci_psc_id_table[] = {
 static int davinci_psc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	const struct davinci_psc_init_data *init_data = NULL;
 	void __iomem *base;
 	int ret;
 
-	of_id = of_match_device(davinci_psc_of_match, dev);
-	if (of_id)
-		init_data = of_id->data;
-	else if (pdev->id_entry)
+	init_data = device_get_match_data(dev);
+	if (!init_data && pdev->id_entry)
 		init_data = (void *)pdev->id_entry->driver_data;
 
 	if (!init_data) {
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index dbc7093ab9cc..6236a458e4eb 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -7,9 +7,10 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -3716,14 +3717,10 @@ MODULE_DEVICE_TABLE(of, gcc_msm8960_match_table);
 static int gcc_msm8960_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct platform_device *tsens;
+	const struct qcom_cc_desc *desc = device_get_match_data(dev);
 	int ret;
 
-	match = of_match_device(gcc_msm8960_match_table, &pdev->dev);
-	if (!match)
-		return -EINVAL;
-
 	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 19200000);
 	if (ret)
 		return ret;
@@ -3732,11 +3729,11 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qcom_cc_probe(pdev, match->data);
+	ret = qcom_cc_probe(pdev, desc);
 	if (ret)
 		return ret;
 
-	if (match->data == &gcc_apq8064_desc) {
+	if (desc == &gcc_apq8064_desc) {
 		hfpll1.d = &hfpll1_8064_data;
 		hfpll_l2.d = &hfpll_l2_8064_data;
 	}
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index 0231c1efd286..b32e66714951 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -7,9 +7,9 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -2875,14 +2875,10 @@ static int gcc_msm8974_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *id;
-
-	id = of_match_device(gcc_msm8974_match_table, dev);
-	if (!id)
-		return -ENODEV;
+	const void *data = device_get_match_data(dev);
 
 	if (!of_device_is_compatible(dev->of_node, "qcom,gcc-msm8974")) {
-		if (id->data == &gcc_msm8226_desc)
+		if (data == &gcc_msm8226_desc)
 			msm8226_clock_override();
 		else
 			msm8974_pro_clock_override();
diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
index 97358c98c6c9..23b0b11f0007 100644
--- a/drivers/clk/qcom/kpss-xcc.c
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -5,10 +5,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 
@@ -32,20 +32,15 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
 static int kpss_xcc_driver_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *id;
 	void __iomem *base;
 	struct clk_hw *hw;
 	const char *name;
 
-	id = of_match_device(kpss_xcc_match_table, dev);
-	if (!id)
-		return -ENODEV;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	if (id->data) {
+	if (device_get_match_data(&pdev->dev)) {
 		if (of_property_read_string_index(dev->of_node,
 						  "clock-output-names",
 						  0, &name))
diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 410ae8390f1c..ae325f4e1047 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -5,10 +5,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
@@ -347,22 +347,18 @@ MODULE_DEVICE_TABLE(of, krait_cc_match_table);
 static int krait_cc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *id;
 	unsigned long cur_rate, aux_rate;
 	int cpu;
 	struct clk_hw *mux, *l2_pri_mux;
 	struct clk *clk, **clks;
-
-	id = of_match_device(krait_cc_match_table, dev);
-	if (!id)
-		return -ENODEV;
+	bool unique_aux = !!device_get_match_data(dev);
 
 	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
 	clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	if (!id->data) {
+	if (!unique_aux) {
 		clk = clk_register_fixed_factor(dev, "acpu_aux",
 						"gpll0_vote", 0, 1, 2);
 		if (IS_ERR(clk))
@@ -375,13 +371,13 @@ static int krait_cc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
-		mux = krait_add_clks(dev, cpu, id->data);
+		mux = krait_add_clks(dev, cpu, unique_aux);
 		if (IS_ERR(mux))
 			return PTR_ERR(mux);
 		clks[cpu] = mux->clk;
 	}
 
-	l2_pri_mux = krait_add_clks(dev, -1, id->data);
+	l2_pri_mux = krait_add_clks(dev, -1, unique_aux);
 	if (IS_ERR(l2_pri_mux))
 		return PTR_ERR(l2_pri_mux);
 	clks[l2_mux] = l2_pri_mux->clk;
diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index 6bf908a51f53..50638ab341ec 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -8,9 +8,9 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
@@ -3105,30 +3105,24 @@ MODULE_DEVICE_TABLE(of, mmcc_msm8960_match_table);
 
 static int mmcc_msm8960_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct regmap *regmap;
-	bool is_8064;
 	struct device *dev = &pdev->dev;
+	const struct qcom_cc_desc *desc = device_get_match_data(dev);
 
-	match = of_match_device(mmcc_msm8960_match_table, dev);
-	if (!match)
-		return -EINVAL;
-
-	is_8064 = of_device_is_compatible(dev->of_node, "qcom,mmcc-apq8064");
-	if (is_8064) {
+	if (desc == &mmcc_apq8064_desc) {
 		gfx3d_src.freq_tbl = clk_tbl_gfx3d_8064;
 		gfx3d_src.clkr.hw.init = &gfx3d_8064_init;
 		gfx3d_src.s[0].parent_map = mmcc_pxo_pll8_pll2_pll15_map;
 		gfx3d_src.s[1].parent_map = mmcc_pxo_pll8_pll2_pll15_map;
 	}
 
-	regmap = qcom_cc_map(pdev, match->data);
+	regmap = qcom_cc_map(pdev, desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
 	clk_pll_configure_sr(&pll15, regmap, &pll15_config, false);
 
-	return qcom_cc_really_probe(pdev, match->data, regmap);
+	return qcom_cc_really_probe(pdev, desc, regmap);
 }
 
 static struct platform_driver mmcc_msm8960_driver = {
diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
index bc19a23e13f8..996bd01fb9ac 100644
--- a/drivers/clk/qcom/mmcc-sdm660.c
+++ b/drivers/clk/qcom/mmcc-sdm660.c
@@ -9,9 +9,9 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -2828,14 +2828,10 @@ static void sdm630_clock_override(void)
 
 static int mmcc_660_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *id;
 	struct regmap *regmap;
 	bool is_sdm630;
 
-	id = of_match_device(mmcc_660_match_table, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-	is_sdm630 = !!(id->data);
+	is_sdm630 = !!device_get_match_data(&pdev->dev);
 
 	regmap = qcom_cc_map(pdev, &mmcc_660_desc);
 	if (IS_ERR(regmap))
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 9ebd6c451b3d..9316e5c8a0ea 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -9,8 +9,8 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <dt-bindings/clock/rk3399-cru.h>
 #include "clk.h"
@@ -1634,14 +1634,9 @@ static const struct of_device_id clk_rk3399_match_table[] = {
 static int __init clk_rk3399_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	const struct clk_rk3399_inits *init_data;
 
-	match = of_match_device(clk_rk3399_match_table, &pdev->dev);
-	if (!match || !match->data)
-		return -EINVAL;
-
-	init_data = match->data;
+	init_data = device_get_match_data(&pdev->dev);
 	if (init_data->inits)
 		init_data->inits(np);
 
diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 72b6cf83aff4..3484e6cc80ad 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -13,9 +13,9 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 
 #define EXYNOS_CLKOUT_NR_CLKS		1
 #define EXYNOS_CLKOUT_PARENTS		32
@@ -84,19 +84,17 @@ MODULE_DEVICE_TABLE(of, exynos_clkout_ids);
 static int exynos_clkout_match_parent_dev(struct device *dev, u32 *mux_mask)
 {
 	const struct exynos_clkout_variant *variant;
-	const struct of_device_id *match;
 
 	if (!dev->parent) {
 		dev_err(dev, "not instantiated from MFD\n");
 		return -EINVAL;
 	}
 
-	match = of_match_device(exynos_clkout_ids, dev->parent);
-	if (!match) {
+	variant = device_get_match_data(dev->parent);
+	if (!variant) {
 		dev_err(dev, "cannot match parent device\n");
 		return -EINVAL;
 	}
-	variant = match->data;
 
 	*mux_mask = variant->mux_mask;
 
diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index ff42ea75cb43..6121020b4b38 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -8,7 +8,9 @@
 #include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/string.h>
 
 #define ADPLL_PLLSS_MMR_LOCK_OFFSET	0x00	/* Managed by MPPULL */
@@ -860,24 +862,16 @@ static int ti_adpll_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
-	const struct ti_adpll_platform_data *pdata;
 	struct ti_adpll_data *d;
 	struct resource *res;
 	int err;
 
-	match = of_match_device(ti_adpll_match, dev);
-	if (match)
-		pdata = match->data;
-	else
-		return -ENODEV;
-
 	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 	d->dev = dev;
 	d->np = node;
-	d->c = pdata;
+	d->c = device_get_match_data(dev);
 	dev_set_drvdata(d->dev, d);
 	spin_lock_init(&d->lock);
 
-- 
2.40.1

