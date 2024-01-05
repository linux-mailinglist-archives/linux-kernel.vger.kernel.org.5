Return-Path: <linux-kernel+bounces-17586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89500824FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23571C22B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BE22311;
	Fri,  5 Jan 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mI9b+92k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A628DCA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26fa294e56so135561266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443074; x=1705047874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIhZSvbC1t+imp+JG0gpa85K6fbvbfHzf6ZDHGxPd7Q=;
        b=mI9b+92k0e5D6cwpfmNjKVrh5szMyXGA3NUA5JrZdwa4xYZd+gRCuoevyfbjVW2AOf
         0MjqUX743SmmAT6ArgG1hj7XdGEQSfMsU4GPJry8ZYQtdbggm4IYzTYZCkNV2/H5Vjua
         a6wrLIIkLUFYvCkFDJFl7hVKYvxKFCVxA8GQ2U4HT4nVzzU3nfs0K8dTNxuyy2DJm1n5
         MWxTmw0zJqYkaC6GMqghop19tRHfR5QXNq+L6R+DvWtwlzgIu/t953qQL4myRtgBwHFc
         f1GEDXZiTz4SdcKMaKvn5HTSaprQEwyyX6t3W8qN54jW1NBzfnxZ6cO+HUq3WJ3YJq6x
         3m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443074; x=1705047874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIhZSvbC1t+imp+JG0gpa85K6fbvbfHzf6ZDHGxPd7Q=;
        b=hrY/N5zH7rdmepYOpZATdx346JWymdy7U5Ko+5zLxE+T91wQ4lxg2nL/1DHCfqg0mf
         SDaW63JaQ08b4Sc7XnBdKSmNQXwoT6J+qAK8hZp0WqyskkW461zGE7cL5Mivh9P4+lt7
         j6tvqBkmPYnoJXkyeYyLUxbR+WC8ZOVpI/3M0Wmm7M/iv9n6MOFPL3M+3nBicS32chwj
         JbE2k47R2ISESCMqvXsr25yU777Lbzm5BuduI3jedraGII7Q38NsBybyh4gz7TnoQuOr
         iVQF61Ti0K/8jOCLMvMc/pPczYbofVG/1xSbyDYYkVAooZo102TOqPK5uPFL/UdCiJh6
         aUmw==
X-Gm-Message-State: AOJu0YzhHkdtOVIUwd2lZn1wYOkzDI2A56ocMdAuh6w6rE9B350Bkbyg
	huxpdkFrDyKj8SjH+pKv7OKXw0mYFDphbg==
X-Google-Smtp-Source: AGHT+IHqGwAERifRk4F6gEjWHFPG02FaM6Me/eGWK4dYcN+wlPj1NVOT+0CFzpp2TbXHH1fI+m43eQ==
X-Received: by 2002:a17:906:5fc1:b0:a28:b775:28a8 with SMTP id k1-20020a1709065fc100b00a28b77528a8mr807639ejv.90.1704443073900;
        Fri, 05 Jan 2024 00:24:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:24:33 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 07/19] net: ravb: Move reference clock enable/disable on runtime PM APIs
Date: Fri,  5 Jan 2024 10:23:27 +0200
Message-Id: <20240105082339.1468817-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reference clock could be or not part of the power domain. If it is part of
the power domain, the power domain takes care of propertly setting it. In
case it is not part of the power domain and full runtime PM support is
available in driver the clock will not be propertly disabled/enabled at
runtime. For this, keep the prepare/unprepare operations in the driver's
probe()/remove() functions and move the enable/disable in runtime PM
functions.

Along with it, the other clock request operations were moved close to
reference clock request and prepare to have all the clock requests
specific code grouped together.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- squashed with patch 17/21 ("net: ravb: Keep clock request operations grouped
  together") from v2
- collected tags

Changes in v2:
- this patch is new and follows the recommendations proposed in the
  discussion of patch 08/13 ("net: ravb: Rely on PM domain to enable refclk")
  from v2

 drivers/net/ethernet/renesas/ravb_main.c | 110 ++++++++++++-----------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 844ac3306e93..4673cc2faec0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2664,11 +2664,6 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_free_netdev;
 
-	pm_runtime_enable(&pdev->dev);
-	error = pm_runtime_resume_and_get(&pdev->dev);
-	if (error < 0)
-		goto out_rpm_disable;
-
 	if (info->multi_irqs) {
 		if (info->err_mgmt_irqs)
 			irq = platform_get_irq_byname(pdev, "dia");
@@ -2679,7 +2674,7 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	if (irq < 0) {
 		error = irq;
-		goto out_release;
+		goto out_reset_assert;
 	}
 	ndev->irq = irq;
 
@@ -2697,10 +2692,37 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		error = PTR_ERR(priv->clk);
+		goto out_reset_assert;
+	}
+
+	if (info->gptp_ref_clk) {
+		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
+		if (IS_ERR(priv->gptp_clk)) {
+			error = PTR_ERR(priv->gptp_clk);
+			goto out_reset_assert;
+		}
+	}
+
+	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
+	if (IS_ERR(priv->refclk)) {
+		error = PTR_ERR(priv->refclk);
+		goto out_reset_assert;
+	}
+	clk_prepare(priv->refclk);
+
+	platform_set_drvdata(pdev, ndev);
+	pm_runtime_enable(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_rpm_disable;
+
 	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->addr)) {
 		error = PTR_ERR(priv->addr);
-		goto out_release;
+		goto out_rpm_put;
 	}
 
 	/* The Ether-specific entries in the device structure. */
@@ -2711,7 +2733,7 @@ static int ravb_probe(struct platform_device *pdev)
 
 	error = of_get_phy_mode(np, &priv->phy_interface);
 	if (error && error != -ENODEV)
-		goto out_release;
+		goto out_rpm_put;
 
 	priv->no_avb_link = of_property_read_bool(np, "renesas,no-ether-link");
 	priv->avb_link_active_low =
@@ -2724,14 +2746,14 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, "ch24");
 		if (irq < 0) {
 			error = irq;
-			goto out_release;
+			goto out_rpm_put;
 		}
 		priv->emac_irq = irq;
 		for (i = 0; i < NUM_RX_QUEUE; i++) {
 			irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->rx_irqs[i] = irq;
 		}
@@ -2739,7 +2761,7 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->tx_irqs[i] = irq;
 		}
@@ -2748,40 +2770,19 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, "err_a");
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->erra_irq = irq;
 
 			irq = platform_get_irq_byname(pdev, "mgmt_a");
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->mgmta_irq = irq;
 		}
 	}
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		error = PTR_ERR(priv->clk);
-		goto out_release;
-	}
-
-	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
-	if (IS_ERR(priv->refclk)) {
-		error = PTR_ERR(priv->refclk);
-		goto out_release;
-	}
-	clk_prepare_enable(priv->refclk);
-
-	if (info->gptp_ref_clk) {
-		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
-		if (IS_ERR(priv->gptp_clk)) {
-			error = PTR_ERR(priv->gptp_clk);
-			goto out_disable_refclk;
-		}
-	}
-
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
@@ -2799,13 +2800,13 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_disable_gptp_clk;
+		goto out_rpm_put;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_refclk;
+			goto out_rpm_put;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2825,7 +2826,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_refclk;
+		goto out_rpm_put;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2871,8 +2872,6 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
-	platform_set_drvdata(pdev, ndev);
-
 	return 0;
 
 out_napi_del:
@@ -2888,12 +2887,12 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_refclk:
-	clk_disable_unprepare(priv->refclk);
-out_release:
+out_rpm_put:
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(priv->refclk);
+out_reset_assert:
 	reset_control_assert(rstc);
 out_free_netdev:
 	free_netdev(ndev);
@@ -2922,10 +2921,9 @@ static void ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->refclk);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
@@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_suspend(struct device *dev)
 {
-	/* Runtime PM callback shared between ->runtime_suspend()
-	 * and ->runtime_resume(). Simply returns success.
-	 *
-	 * This driver re-initializes all registers after
-	 * pm_runtime_get_sync() anyway so there is no need
-	 * to save and restore registers here.
-	 */
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	clk_disable(priv->refclk);
+
 	return 0;
 }
 
+static int ravb_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	return clk_enable(priv->refclk);
+}
+
 static const struct dev_pm_ops ravb_dev_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	RUNTIME_PM_OPS(ravb_runtime_suspend, ravb_runtime_resume, NULL)
 };
 
 static struct platform_driver ravb_driver = {
-- 
2.39.2


