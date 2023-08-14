Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA01577B868
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjHNMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjHNMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:12:03 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64473195
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:11:57 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230814121155epoutp02269275085088ba1b9b615edf13977e6d~7PshykNwy1627516275epoutp02f
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:11:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230814121155epoutp02269275085088ba1b9b615edf13977e6d~7PshykNwy1627516275epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015115;
        bh=yQL1nCfdeC/BqfpskPcmt0HqJGCIQXaR/ZeUo/AXbvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gpc7Wtp+6TABtqU51kBm42gGh0lE9QgrpRRPXxwAXECHM4ViwZg8dCuQR2awFM9Tl
         pMIlQWyxjMYKqfS/ymafKT9NA1duxhOjWN37LgtMZwfJoWKS5fsV2DUutEbIsYAoxU
         zYFSMpy0e9n/wuoSzZeR9gUp38nrJOJaThL/KScA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230814121154epcas5p15d0c68b5386e489ea9dcf900bc25862a~7PsgrZTi82054920549epcas5p10;
        Mon, 14 Aug 2023 12:11:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RPYD85Pmsz4x9Pq; Mon, 14 Aug
        2023 12:11:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.CF.55522.80A1AD46; Mon, 14 Aug 2023 21:11:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4~7PEnQl-i12722327223epcas5p2D;
        Mon, 14 Aug 2023 11:26:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230814112612epsmtrp26dbb42a22a28601006434158a8bd5ffd~7PEnPuEhi1398813988epsmtrp2d;
        Mon, 14 Aug 2023 11:26:12 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-1e-64da1a08435f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.C5.64355.45F0AD46; Mon, 14 Aug 2023 20:26:12 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814112608epsmtip223f22b20ba46d9f0f440c05e70ffe7a7~7PEjxyWXq0830608306epsmtip2d;
        Mon, 14 Aug 2023 11:26:08 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        richardcochran@gmail.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        alim.akhtar@samsung.com, linux-fsd@tesla.com,
        pankaj.dubey@samsung.com, swathi.ks@samsung.com,
        ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Suresh Siddha <ssiddha@tesla.com>
Subject: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date:   Mon, 14 Aug 2023 16:55:37 +0530
Message-Id: <20230814112539.70453-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814112539.70453-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTbVBUZRT2vXfv3ovt0nWlfFsTaIsSlI/FZX0RIRNHL9UYkz9iHAvusFdg
        2K/ZXSSYJkxYk42IHQWJ4Uu0KBJFWDdEWAFXmjECJmAJAwOUAmUQdglLo4ll0f495znnOc85
        7weFi37mi6k0tYHTqVmlhL+WZ70eGBhMiW8pws7YX0Z/T5cANFZp5aPzbT0YKu/N46Eqew+B
        JrsmSHS7ZpZAhVPjOOqzFhKo8Y6DQOP33kP9LeV8VNprw1DlUj2BuqqfR4s/zgBUc3mBRONz
        rSQq62smkL17CkfGNjuJfp25QKCasWoCLVwaJndBxvLtMMZMfnGZZK6UjZJMdWMG01iXz2dG
        HK18pulcDvPANshnCi11gLFccwHm32MVJONq9I0XHEzfmcqxCk7nz6mTNYo0dUq05K0DibGJ
        EfIwabA0Em2X+KtZFRct2fN2fPDeNOXy6hL/I6wyY5mKZ/V6SWjMTp0mw8D5p2r0hmgJp1Uo
        tTJtiJ5V6TPUKSFqzrBDGhYWHrFcmJSe6loyY9rRuA+nTjTxjoLj0SZAUZCWwW/GUk1gLSWi
        rwJ4ve8h4QmcAPYWTWNPgwlnB98EvFYUtpFZ0pO4AuDJpau4JzBicP6rXzB3FZ8OhkaHa0Xu
        Qx/H4XnnKdydwOnTGJwpYd3m6+ndsNa6w03z6AD4R9E85qaFdDScrfH3mPnB7xraV5RedAyc
        G2rluVtCeo6CF2221Yn2wKrFGeDB6+G9HyykB4uha7ZttSYFNtmbCA9WwhPHcnEPfh22D5Tz
        3L44HQgvtoR66E2w+OYFzDOxN/z88V3Mwwthc+UT/Co8O5G/il+E9RPO1fYMHDQ289xYRJsB
        XLq7pQj4lv3vUA1AHXiB0+pVKZw+QitVc5lP7yxZo2oEK487KK4ZjI7NhXQCjAKdAFK4xEdY
        ILylEAkVbFY2p9Mk6jKUnL4TRCwfnxkXP5esWf4dakOiVBYZJpPL5bLIbXKpZIPwvrFCIaJT
        WAOXznFaTvdEh1Fe4qNY6VaZ96BTMNAwGeuTZaNrXLs/y1xnKti83xwZlbvG79LeoPs+7KfZ
        mw+JNjw4/MZGU45lW7fVPv3Km468tE1eUe+e80a233lNggZ5x8DDd/6JLS7967d91jU5xHRt
        fg4V7rp5Le6TM4o7zUtRX2bWDz96n1cQsP1GfJafeWKBH2UupsTzIZZnNjJlzoQc49nF71v6
        A3y/Pp1wuzwkW6FVnaSHuveRN+Ri9ccVVZVdai+n966YkXUCx2uY6VRMHhEqfJRECBJq22NK
        yP2Pp8K3aHyOGAcPBBVxvUDY98HWriFBh04mTEo4OPMSz1HV0zE5XxanpQ4fEuT+Kep/9ifs
        I5WEp09lpUG4Ts/+B6UwtmZlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXjeE/1aKwe9bKhY/X05jtHgwbxub
        xZq955gs5pxvYbGYf+Qcq8XTY4/YLe4tesdq0ffiIbPFhW19rBabHl9jtXj4Ktzi8q45bBYz
        zu9jspj3dy2rxbEFYhbfTr9htFi09Qu7xcMPe9gtZl3YwWpx5MwLZovWvUfYLW6/WcdqsejB
        AlaLLxtvsjtIeGxZeZPJ42n/VnaPnbPusnss2FTqsWlVJ5vHnWt72Dw2L6n3eL/vKptH35ZV
        jB5b9n9m9PjXNJfd4/MmuQCeKC6blNSczLLUIn27BK6Mz38nMhXc9ax40bGZpYGxzbaLkZND
        QsBEYt+dd+xdjFwcQgLbGSW6ty1khkjISJx8sATKFpZY+e85VFEzk8T7H4/ZQRJsAroSrdc+
        M4EkRARmMUvMm7yCGcRhFpjLJHHh2xOgKg4OYQEnieXbrEAaWARUJZ5P+MgEEuYVsJV4t0gB
        YoG8xOoNB8CWcQrYSXy4vocFxBYCKtn1dSnrBEa+BYwMqxhFUwuKc9NzkwsM9YoTc4tL89L1
        kvNzNzGC40oraAfjsvV/9Q4xMnEwHmKU4GBWEuHt4b2VIsSbklhZlVqUH19UmpNafIhRmoNF
        SZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cA05634/V2y0uf7j2/kkm+I3mf0fWthotm1KNUQ
        ry6ha/H75D6/OGgSy2fA/2rxHu2VT/m/7Otb/XGaseyeZy6rqxfxlpU3rmhm+915Jd9jrVOf
        3zMLh68O07S/Si9VNTlUvO0GZ9ArNkZvb6mwlD3PGd4tk9jmcJV5/gURf/kl138zXLv/rnyZ
        1XnvNv8u8Z877ugEGlSnCJmx1fzXdflecflo8eZbGw/WKLuVR82bydS4Y98ba6e/fTxp7/dO
        +yW1zFt5flDpVWuNp3lr1pV6X8mYzt6+zuuW2o3u064s8bMMzrRmrWZ2DRI4ZP5EbtGacuaO
        l42KU1lLPMIWaDOqe2revWI8pTGimPWD3CklluKMREMt5qLiRACfcQnkGgMAAA==
X-CMS-MailID: 20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
The binding that it uses is slightly different from existing ones because
of the integration (clocks, resets).

For FSD SoC, a mux switch is needed between internal and external clocks.
By default after reset internal clock is used but for receiving packets
properly, external clock is needed. Mux switch to external clock happens
only when the external clock is present.

Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
Signed-off-by: Suresh Siddha <ssiddha@tesla.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 172 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  28 ++-
 include/linux/stmmac.h                        |   1 +
 3 files changed, 199 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 61ebf36da13d..651a41e0dab9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/stmmac.h>
+#include <linux/regmap.h>
 
 #include "stmmac_platform.h"
 #include "dwmac4.h"
@@ -37,6 +38,45 @@ struct tegra_eqos {
 	struct gpio_desc *reset;
 };
 
+enum fsd_rxmux_clk {
+	FSD_RXCLK_MUX = 7,
+	FSD_RXCLK_EXTERNAL,
+	FSD_RXCLK_INTERNAL
+};
+
+struct fsd_eqos_plat_data {
+	const struct fsd_eqos_variant *fsd_eqos_inst_var;
+	struct clk_bulk_data *clks;
+	struct device *dev;
+};
+
+struct fsd_eqos_variant {
+	const char * const *clk_list;
+	int num_clks;
+};
+
+static const char * const fsd_eqos_instance_0_clk[] = {
+	"ptp_ref", "master_bus", "slave_bus", "tx", "rx"
+};
+
+static const char * const fsd_eqos_instance_1_clk[] = {
+	"ptp_ref", "master_bus", "slave_bus", "tx", "rx", "master2_bus",
+	"slave2_bus", "eqos_rxclk_mux", "eqos_phyrxclk", "dout_peric_rgmii_clk"
+};
+
+static const int rx_clock_skew_val[] = {0x2, 0x0};
+
+static const struct fsd_eqos_variant fsd_eqos_clk_info[] = {
+	{
+		.clk_list = fsd_eqos_instance_0_clk,
+		.num_clks = ARRAY_SIZE(fsd_eqos_instance_0_clk)
+	},
+	{
+		.clk_list = fsd_eqos_instance_1_clk,
+		.num_clks = ARRAY_SIZE(fsd_eqos_instance_1_clk)
+	},
+};
+
 static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 				   struct plat_stmmacenet_data *plat_dat)
 {
@@ -265,6 +305,132 @@ static int tegra_eqos_init(struct platform_device *pdev, void *priv)
 	return 0;
 }
 
+static int dwc_eqos_rxmux_setup(void *priv, bool external)
+{
+	struct fsd_eqos_plat_data *plat = priv;
+
+	/* doesn't support RX clock mux */
+	if (!plat->clks[FSD_RXCLK_MUX].clk)
+		return 0;
+
+	if (external)
+		return clk_set_parent(plat->clks[FSD_RXCLK_MUX].clk,
+				      plat->clks[FSD_RXCLK_EXTERNAL].clk);
+	else
+		return clk_set_parent(plat->clks[FSD_RXCLK_MUX].clk,
+				      plat->clks[FSD_RXCLK_INTERNAL].clk);
+}
+
+static int dwc_eqos_setup_rxclock(struct platform_device *pdev, int ins_num)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *syscon;
+	unsigned int reg;
+
+	if (np && of_property_read_bool(np, "fsd-rx-clock-skew")) {
+		syscon = syscon_regmap_lookup_by_phandle_args(np,
+							      "fsd-rx-clock-skew",
+							      1, &reg);
+		if (IS_ERR(syscon)) {
+			dev_err(&pdev->dev,
+				"couldn't get the rx-clock-skew syscon!\n");
+			return PTR_ERR(syscon);
+		}
+
+		regmap_write(syscon, reg, rx_clock_skew_val[ins_num]);
+	}
+
+	return 0;
+}
+
+static int fsd_eqos_clk_init(struct fsd_eqos_plat_data *plat,
+			     struct plat_stmmacenet_data *data)
+{
+	int ret = 0, i;
+
+	const struct fsd_eqos_variant *fsd_eqos_v_data =
+						plat->fsd_eqos_inst_var;
+
+	plat->clks = devm_kcalloc(plat->dev, fsd_eqos_v_data->num_clks,
+				  sizeof(*plat->clks), GFP_KERNEL);
+	if (!plat->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < fsd_eqos_v_data->num_clks; i++)
+		plat->clks[i].id = fsd_eqos_v_data->clk_list[i];
+
+	ret = devm_clk_bulk_get(plat->dev, fsd_eqos_v_data->num_clks,
+				plat->clks);
+
+	return ret;
+}
+
+static int fsd_clks_endisable(void *priv, bool enabled)
+{
+	int ret, num_clks;
+	struct fsd_eqos_plat_data *plat = priv;
+
+	num_clks = plat->fsd_eqos_inst_var->num_clks;
+
+	if (enabled) {
+		ret = clk_bulk_prepare_enable(num_clks, plat->clks);
+		if (ret) {
+			dev_err(plat->dev, "Clock enable failed, err = %d\n", ret);
+			return ret;
+		}
+	} else {
+		clk_bulk_disable_unprepare(num_clks, plat->clks);
+	}
+
+	return 0;
+}
+
+static int fsd_eqos_probe(struct platform_device *pdev,
+			  struct plat_stmmacenet_data *data,
+			  struct stmmac_resources *res)
+{
+	struct fsd_eqos_plat_data *priv_plat;
+	struct device_node *np = pdev->dev.of_node;
+	int ret = 0;
+
+	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
+	if (!priv_plat) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	priv_plat->dev = &pdev->dev;
+	data->bus_id = of_alias_get_id(np, "eth");
+
+	priv_plat->fsd_eqos_inst_var = &fsd_eqos_clk_info[data->bus_id];
+
+	ret = fsd_eqos_clk_init(priv_plat, data);
+
+	data->bsp_priv = priv_plat;
+	data->clks_config = fsd_clks_endisable;
+	data->rxmux_setup = dwc_eqos_rxmux_setup;
+
+	ret = fsd_clks_endisable(priv_plat, true);
+	if (ret)
+		goto error;
+
+	ret = dwc_eqos_setup_rxclock(pdev, data->bus_id);
+	if (ret) {
+		fsd_clks_endisable(priv_plat, false);
+		dev_err_probe(&pdev->dev, ret, "Unable to setup rxclock\n");
+	}
+
+error:
+	return ret;
+}
+
+static void fsd_eqos_remove(struct platform_device *pdev)
+{
+	struct fsd_eqos_plat_data *priv_plat = get_stmmac_bsp_priv(&pdev->dev);
+
+	fsd_clks_endisable(priv_plat, false);
+}
+
 static int tegra_eqos_probe(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *data,
 			    struct stmmac_resources *res)
@@ -411,6 +577,11 @@ static const struct dwc_eth_dwmac_data tegra_eqos_data = {
 	.remove = tegra_eqos_remove,
 };
 
+static const struct dwc_eth_dwmac_data fsd_eqos_data = {
+	.probe = fsd_eqos_probe,
+	.remove = fsd_eqos_remove,
+};
+
 static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data;
@@ -482,6 +653,7 @@ static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 static const struct of_device_id dwc_eth_dwmac_match[] = {
 	{ .compatible = "snps,dwc-qos-ethernet-4.10", .data = &dwc_qos_data },
 	{ .compatible = "nvidia,tegra186-eqos", .data = &tegra_eqos_data },
+	{ .compatible = "tesla,dwc-qos-ethernet-4.21", .data = &fsd_eqos_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 733b5e900817..3c7d55786aaa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3883,6 +3883,12 @@ static int __stmmac_open(struct net_device *dev,
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
 
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
+
 	return 0;
 
 irq_error:
@@ -3936,7 +3942,13 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 static int stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u32 chan;
+	u32 chan, ret;
+
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
 
 	if (device_may_wakeup(priv->device))
 		phylink_speed_down(priv->phylink, false);
@@ -7630,11 +7642,17 @@ int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	u32 chan;
+	u32 chan, ret;
 
 	if (!ndev || !netif_running(ndev))
 		return 0;
 
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
+
 	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
@@ -7799,6 +7817,12 @@ int stmmac_resume(struct device *dev)
 	mutex_unlock(&priv->lock);
 	rtnl_unlock();
 
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
+
 	netif_device_attach(ndev);
 
 	return 0;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 784277d666eb..69150c8c8df7 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -264,6 +264,7 @@ struct plat_stmmacenet_data {
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
+	int (*rxmux_setup)(void *priv, bool external);
 	struct mac_device_info *(*setup)(void *priv);
 	int (*clks_config)(void *priv, bool enabled);
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
-- 
2.17.1

