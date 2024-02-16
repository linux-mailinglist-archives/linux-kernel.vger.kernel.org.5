Return-Path: <linux-kernel+bounces-68402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A278579CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541311F21331
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14F71F944;
	Fri, 16 Feb 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kycKCcOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BE1C6A5;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077722; cv=none; b=UXiVWsHnhJszGHMzH0k3YAYQRtWIPue/Jg++5+TzdOk3Ai4ijtDDrcS/hSN1XjWDYy9U6KPpvMgzEbNGwJuyop2fwx84chrn0Huh/i42AAce/opP/hg9r+i/RnN6Bv2KcDLOXgHW+ZMrIRCIoNqtkDh3WqYm4cXjccEqsoL2dVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077722; c=relaxed/simple;
	bh=GMCRdqJVi47jYNIz7ZsIrbUABQBYCVbQWvncDSefusc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phe+eil23h3tEkqTYu5AGqRdj66gord7wReA2JChEJC2spaGchz1JDAIrK1kNxWQeE62DinJv2elSo2l29IOrqNTadV5eZwuy5JTJj+9JAKkei7Y+PRUwbmYPrPJO0W1TMC0p5zka/9/joaCUTHVDWMy/6vRG1DYbSwtS3eNPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kycKCcOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07BAFC43394;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077722;
	bh=GMCRdqJVi47jYNIz7ZsIrbUABQBYCVbQWvncDSefusc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kycKCcOp73DZ86vTPNTRHxThxjh0ICztbKOSqf71rkVgCXCpF8twO3SnX42gJZbLa
	 Tgpv30A77aiHgFAM+5BU5VMIiMv5IStB0tqqM2iOo8yY54ZMA7/O0jJsi4+8oVgFsU
	 d+5eYmjGltXM7fCyj7exT/jsa4CB4YGel21++Y7qb6sDqMjK/A+yN6rh2pXFuFG34l
	 2mtN9guDPiW9j3kD1jSBSneVvKovfPe6PN73QHMkSL2Ferjp0xuqj1WUiO6HNsIoon
	 5WKXyQM1Qsx2Y8SQ7a7UItunUbEI65tTQ7jqh9+6vHBwUsw2gnP9n+VE2Ej/R26ckX
	 EFIZAOgxHUUtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5CC48BEC;
	Fri, 16 Feb 2024 10:02:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:02:00 +0800
Subject: [PATCH v2 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v2-1-89bd4b7065c2@outlook.com>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
In-Reply-To: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708077720; l=7235;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=8dJ8Kax8LqH47QnvYb+Pr0sVHUo5vm2/beJQv1TSg7Y=;
 b=II9n7cTl245Y0io0Gfas6gxYLEm4+2TVRrGXri5aIbExUmEMHo96qHF4XKZGPyiRPKIvSB2RZ
 XHKSSyoYf+3DeGyzuEGazc2DET9qOyREZtOTFq+LDxIsfgq1gyRXZGy
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Considering that no users is found in the kernel, no backward
compatibility is maintained.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 90 ++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 2406263c9dd3..15e90c7d6421 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -10,8 +10,10 @@
 #include <linux/etherdevice.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -97,6 +99,13 @@ enum phy_reset_delays {
 	DELAYS_NUM,
 };
 
+enum clk_type {
+	CLK_MAC,
+	CLK_MACIF,
+	CLK_PHY,
+	CLK_NUM,
+};
+
 struct hisi_femac_queue {
 	struct sk_buff **skb;
 	dma_addr_t *dma_phys;
@@ -108,7 +117,7 @@ struct hisi_femac_queue {
 struct hisi_femac_priv {
 	void __iomem *port_base;
 	void __iomem *glb_base;
-	struct clk *clk;
+	struct clk *clks[CLK_NUM];
 	struct reset_control *mac_rst;
 	struct reset_control *phy_rst;
 	u32 phy_reset_delays[DELAYS_NUM];
@@ -116,6 +125,7 @@ struct hisi_femac_priv {
 
 	struct device *dev;
 	struct net_device *ndev;
+	struct platform_device *mdio_pdev;
 
 	struct hisi_femac_queue txq;
 	struct hisi_femac_queue rxq;
@@ -693,6 +703,7 @@ static const struct net_device_ops hisi_femac_netdev_ops = {
 static void hisi_femac_core_reset(struct hisi_femac_priv *priv)
 {
 	reset_control_assert(priv->mac_rst);
+	usleep_range(200, 300);
 	reset_control_deassert(priv->mac_rst);
 }
 
@@ -712,6 +723,10 @@ static void hisi_femac_sleep_us(u32 time_us)
 
 static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 {
+	/* MAC clock must be disabled before PHY reset
+	 */
+	clk_disable(priv->clks[CLK_MAC]);
+	clk_disable(priv->clks[CLK_MACIF]);
 	/* To make sure PHY hardware reset success,
 	 * we must keep PHY in deassert state first and
 	 * then complete the hardware reset operation
@@ -727,6 +742,9 @@ static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 	reset_control_deassert(priv->phy_rst);
 	/* delay some time to ensure later MDIO access */
 	hisi_femac_sleep_us(priv->phy_reset_delays[POST_DELAY]);
+
+	clk_enable(priv->clks[CLK_MAC]);
+	clk_enable(priv->clks[CLK_MACIF]);
 }
 
 static void hisi_femac_port_init(struct hisi_femac_priv *priv)
@@ -768,11 +786,17 @@ static void hisi_femac_port_init(struct hisi_femac_priv *priv)
 static int hisi_femac_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
+	struct device_node *node = dev->of_node, *mdio_np;
 	struct net_device *ndev;
 	struct hisi_femac_priv *priv;
 	struct phy_device *phy;
-	int ret;
+	int ret, i;
+	bool mdio_registered = false;
+	static const char * const clk_strs[] = {
+		[CLK_MAC] = "mac",
+		[CLK_MACIF] = "macif",
+		[CLK_PHY] = "phy",
+	};
 
 	ndev = alloc_etherdev(sizeof(*priv));
 	if (!ndev)
@@ -797,23 +821,20 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 		goto out_free_netdev;
 	}
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clk\n");
-		ret = -ENODEV;
-		goto out_free_netdev;
-	}
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(dev, "failed to enable clk %d\n", ret);
-		goto out_free_netdev;
+	for (i = 0; i < CLK_NUM; i++) {
+		priv->clks[i] = devm_clk_get_enabled(&pdev->dev, clk_strs[i]);
+		if (IS_ERR(priv->clks[i])) {
+			dev_err(dev, "failed to get enabled clk %s: %ld\n", clk_strs[i],
+				PTR_ERR(priv->clks[i]));
+			ret = -ENODEV;
+			goto out_free_netdev;
+		}
 	}
 
 	priv->mac_rst = devm_reset_control_get(dev, "mac");
 	if (IS_ERR(priv->mac_rst)) {
 		ret = PTR_ERR(priv->mac_rst);
-		goto out_disable_clk;
+		goto out_free_netdev;
 	}
 	hisi_femac_core_reset(priv);
 
@@ -826,15 +847,32 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 						 priv->phy_reset_delays,
 						 DELAYS_NUM);
 		if (ret)
-			goto out_disable_clk;
+			goto out_free_netdev;
 		hisi_femac_phy_reset(priv);
 	}
 
+	// Register the optional MDIO bus
+	for_each_available_child_of_node(node, mdio_np) {
+		if (of_node_name_prefix(mdio_np, "mdio")) {
+			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
+			of_node_put(mdio_np);
+			if (!priv->mdio_pdev) {
+				dev_err(dev, "failed to register MDIO bus device\n");
+				goto out_free_netdev;
+			}
+			mdio_registered = true;
+			break;
+		}
+	}
+
+	if (!mdio_registered)
+		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
+
 	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
 	if (!phy) {
 		dev_err(dev, "connect to PHY failed!\n");
 		ret = -ENODEV;
-		goto out_disable_clk;
+		goto out_unregister_mdio_bus;
 	}
 
 	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
@@ -885,8 +923,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 out_disconnect_phy:
 	netif_napi_del(&priv->napi);
 	phy_disconnect(phy);
-out_disable_clk:
-	clk_disable_unprepare(priv->clk);
+out_unregister_mdio_bus:
+	platform_device_unregister(priv->mdio_pdev);
 out_free_netdev:
 	free_netdev(ndev);
 
@@ -897,12 +935,15 @@ static void hisi_femac_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hisi_femac_priv *priv = netdev_priv(ndev);
+	int i;
 
 	netif_napi_del(&priv->napi);
 	unregister_netdev(ndev);
 
 	phy_disconnect(ndev->phydev);
-	clk_disable_unprepare(priv->clk);
+	platform_device_unregister(priv->mdio_pdev);
+	for (i = 0; i < CLK_NUM; i++)
+		clk_disable_unprepare(priv->clks[i]);
 	free_netdev(ndev);
 }
 
@@ -912,6 +953,7 @@ static int hisi_femac_drv_suspend(struct platform_device *pdev,
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hisi_femac_priv *priv = netdev_priv(ndev);
+	int i;
 
 	disable_irq(ndev->irq);
 	if (netif_running(ndev)) {
@@ -919,7 +961,8 @@ static int hisi_femac_drv_suspend(struct platform_device *pdev,
 		netif_device_detach(ndev);
 	}
 
-	clk_disable_unprepare(priv->clk);
+	for (i = 0; i < CLK_NUM; i++)
+		clk_disable_unprepare(priv->clks[i]);
 
 	return 0;
 }
@@ -928,8 +971,10 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hisi_femac_priv *priv = netdev_priv(ndev);
+	int i;
 
-	clk_prepare_enable(priv->clk);
+	for (i = 0; i < CLK_NUM; i++)
+		clk_prepare_enable(priv->clks[i]);
 	if (priv->phy_rst)
 		hisi_femac_phy_reset(priv);
 
@@ -948,6 +993,7 @@ static const struct of_device_id hisi_femac_match[] = {
 	{.compatible = "hisilicon,hisi-femac-v1",},
 	{.compatible = "hisilicon,hisi-femac-v2",},
 	{.compatible = "hisilicon,hi3516cv300-femac",},
+	{.compatible = "hisilicon,hi3798mv200-femac",},
 	{},
 };
 

-- 
2.43.0


