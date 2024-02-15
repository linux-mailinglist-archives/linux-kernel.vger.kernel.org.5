Return-Path: <linux-kernel+bounces-67853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066A8571E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0FE1F241B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB2146916;
	Thu, 15 Feb 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSd7o1RE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBC53362;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=KLo15KvdfzPXz4VveMHkUhtkpoknigm/F87DKOqnbLAWIYK57GpocrqbMDGFxntvw95LL2GwMUtT080TyN3gWwweFdCwiVgL6iyqo3xrJN1ARyE7hSFSSRHRVsPG/KdBtA6wUPgPSw0z2NNRUSYcbzUVNq/K5tjtp9dkBKfjlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=Pfcpe+f2Jdbm5K/fR0SSrDTMjraZiY9d5hY2tmvWQow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pub2mPwOkcqZENnC4lXJWGSFF+iCvladcFPpLiOhvERhoWP0gFMoR/Da401uuG14qEUip9Axrcf2cWKQhocJ0iIuoiIN0pYgeGByI4wCJl8TsbJPG5wX+6Zr4rHJZAKwTxcira3mT6hXcY8ewDpH92o63H9WNivzMzoPD74IpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSd7o1RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C10D3C433F1;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040932;
	bh=Pfcpe+f2Jdbm5K/fR0SSrDTMjraZiY9d5hY2tmvWQow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iSd7o1REgbtZfHtfzNnVmB2eqGT6ltnTmq4DSzK1ppg7zeYhHqLd/tm9M37AR6mbx
	 9as4MInob3U+P8u5GdsQUe2JQAGORgR/b0nBd8sBZnfQnan755YBEyN7zA0vKgZBzB
	 NtW4JM9cQCoY30JFe13UlqGBAdtUa6zl88fG1YaA6dYqPhTFzEGHs/dkT3/h3bII+h
	 54seN2XHmu8PCqwRJb2TXBjCU3dNAhSRqmAjJOzYsifewwJCWE3rHLTilpMI1cTHQv
	 zThahYPfWhBauWdJv/cPQrv0+f/ViqtRAh5u7gGi+TZowdwEOASv4BLzHWY65+Bngl
	 deUE2xxLYZCdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ABAC48BEC;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 07:48:53 +0800
Subject: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v1-1-e0ad972cda99@outlook.com>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
In-Reply-To: <20240216-net-v1-0-e0ad972cda99@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=7225;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Ke+HNZMdcM7+6gvjPIovBNlpGzAw05BiWeWYXFjkCK8=;
 b=M3M1M8uRN/VH4jHNjdrus8DBfhRe0JcYhaliW0y5QZBLTX7GhVTB4bq7b/OUmrULQsPLtvKSj
 IIGgUBe2RpWCHcl7LEjcFUiNSoM9MAUAq4ZmCMMl1izVi04sZkvuaCh
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
index 2406263c9dd3..d72160efff9a 100644
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
+	CLK_BUS,
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
+	clk_disable(priv->clks[CLK_BUS]);
 	/* To make sure PHY hardware reset success,
 	 * we must keep PHY in deassert state first and
 	 * then complete the hardware reset operation
@@ -727,6 +742,9 @@ static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 	reset_control_deassert(priv->phy_rst);
 	/* delay some time to ensure later MDIO access */
 	hisi_femac_sleep_us(priv->phy_reset_delays[POST_DELAY]);
+
+	clk_enable(priv->clks[CLK_MAC]);
+	clk_enable(priv->clks[CLK_BUS]);
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
+		[CLK_BUS] = "bus",
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


