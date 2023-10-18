Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ABD7CD438
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbjJRGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbjJRGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:18:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED3FD47
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:17:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qszrx-0001Zk-7l; Wed, 18 Oct 2023 08:17:25 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qszrq-002UXt-MX; Wed, 18 Oct 2023 08:17:18 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <sha@pengutronix.de>)
        id 1qszrq-00Evi1-1v;
        Wed, 18 Oct 2023 08:17:18 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Chanwoo Choi <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 03/26] PM / devfreq: rockchip-dfi: use consistent name for private data struct
Date:   Wed, 18 Oct 2023 08:16:51 +0200
Message-Id: <20231018061714.3553817-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018061714.3553817-1-s.hauer@pengutronix.de>
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable name for the private data struct is 'info' in some
functions and 'data' in others. Both names do not give a clue what
type the variable has, so consistently use 'dfi'.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 72 ++++++++++++++--------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 467f9f42d38f7..e19e5acaa362c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -59,13 +59,13 @@ struct rockchip_dfi {
 
 static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 {
-	struct rockchip_dfi *info = devfreq_event_get_drvdata(edev);
-	void __iomem *dfi_regs = info->regs;
+	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
+	void __iomem *dfi_regs = dfi->regs;
 	u32 val;
 	u32 ddr_type;
 
 	/* get ddr type */
-	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
+	regmap_read(dfi->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
 	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
 		    RK3399_PMUGRF_DDRTYPE_MASK;
 
@@ -84,28 +84,28 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 
 static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
 {
-	struct rockchip_dfi *info = devfreq_event_get_drvdata(edev);
-	void __iomem *dfi_regs = info->regs;
+	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
+	void __iomem *dfi_regs = dfi->regs;
 
 	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
 }
 
 static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
 {
-	struct rockchip_dfi *info = devfreq_event_get_drvdata(edev);
+	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	u32 tmp, max = 0;
 	u32 i, busier_ch = 0;
-	void __iomem *dfi_regs = info->regs;
+	void __iomem *dfi_regs = dfi->regs;
 
 	rockchip_dfi_stop_hardware_counter(edev);
 
 	/* Find out which channel is busier */
 	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
-		info->ch_usage[i].access = readl_relaxed(dfi_regs +
+		dfi->ch_usage[i].access = readl_relaxed(dfi_regs +
 				DDRMON_CH0_DFI_ACCESS_NUM + i * 20) * 4;
-		info->ch_usage[i].total = readl_relaxed(dfi_regs +
+		dfi->ch_usage[i].total = readl_relaxed(dfi_regs +
 				DDRMON_CH0_COUNT_NUM + i * 20);
-		tmp = info->ch_usage[i].access;
+		tmp = dfi->ch_usage[i].access;
 		if (tmp > max) {
 			busier_ch = i;
 			max = tmp;
@@ -118,20 +118,20 @@ static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
 
 static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
 {
-	struct rockchip_dfi *info = devfreq_event_get_drvdata(edev);
+	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 
 	rockchip_dfi_stop_hardware_counter(edev);
-	clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(dfi->clk);
 
 	return 0;
 }
 
 static int rockchip_dfi_enable(struct devfreq_event_dev *edev)
 {
-	struct rockchip_dfi *info = devfreq_event_get_drvdata(edev);
+	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	int ret;
 
-	ret = clk_prepare_enable(info->clk);
+	ret = clk_prepare_enable(dfi->clk);
 	if (ret) {
 		dev_err(&edev->dev, "failed to enable dfi clk: %d\n", ret);
 		return ret;
@@ -149,13 +149,13 @@ static int rockchip_dfi_set_event(struct devfreq_event_dev *edev)
 static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 				  struct devfreq_event_data *edata)
 {
-	struct rockchip_dfi *info = devfreq_event_get_drvdata(edev);
+	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	int busier_ch;
 
 	busier_ch = rockchip_dfi_get_busier_ch(edev);
 
-	edata->load_count = info->ch_usage[busier_ch].access;
-	edata->total_count = info->ch_usage[busier_ch].total;
+	edata->load_count = dfi->ch_usage[busier_ch].access;
+	edata->total_count = dfi->ch_usage[busier_ch].total;
 
 	return 0;
 }
@@ -176,47 +176,47 @@ MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
 static int rockchip_dfi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct rockchip_dfi *data;
+	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
 
-	data = devm_kzalloc(dev, sizeof(struct rockchip_dfi), GFP_KERNEL);
-	if (!data)
+	dfi = devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
+	if (!dfi)
 		return -ENOMEM;
 
-	data->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->regs))
-		return PTR_ERR(data->regs);
+	dfi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dfi->regs))
+		return PTR_ERR(dfi->regs);
 
-	data->clk = devm_clk_get(dev, "pclk_ddr_mon");
-	if (IS_ERR(data->clk))
-		return dev_err_probe(dev, PTR_ERR(data->clk),
+	dfi->clk = devm_clk_get(dev, "pclk_ddr_mon");
+	if (IS_ERR(dfi->clk))
+		return dev_err_probe(dev, PTR_ERR(dfi->clk),
 				     "Cannot get the clk pclk_ddr_mon\n");
 
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (!node)
 		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
 
-	data->regmap_pmu = syscon_node_to_regmap(node);
+	dfi->regmap_pmu = syscon_node_to_regmap(node);
 	of_node_put(node);
-	if (IS_ERR(data->regmap_pmu))
-		return PTR_ERR(data->regmap_pmu);
+	if (IS_ERR(dfi->regmap_pmu))
+		return PTR_ERR(dfi->regmap_pmu);
 
-	data->dev = dev;
+	dfi->dev = dev;
 
-	desc = &data->desc;
+	desc = &dfi->desc;
 	desc->ops = &rockchip_dfi_ops;
-	desc->driver_data = data;
+	desc->driver_data = dfi;
 	desc->name = np->name;
 
-	data->edev = devm_devfreq_event_add_edev(&pdev->dev, desc);
-	if (IS_ERR(data->edev)) {
+	dfi->edev = devm_devfreq_event_add_edev(&pdev->dev, desc);
+	if (IS_ERR(dfi->edev)) {
 		dev_err(&pdev->dev,
 			"failed to add devfreq-event device\n");
-		return PTR_ERR(data->edev);
+		return PTR_ERR(dfi->edev);
 	}
 
-	platform_set_drvdata(pdev, data);
+	platform_set_drvdata(pdev, dfi);
 
 	return 0;
 }
-- 
2.39.2

