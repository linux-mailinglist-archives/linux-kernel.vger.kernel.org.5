Return-Path: <linux-kernel+bounces-91553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE1287138F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448251C23602
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E006826AF7;
	Tue,  5 Mar 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMP7FoPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E618654;
	Tue,  5 Mar 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605197; cv=none; b=foVLPbY+APt4NheLiLIU95Nlnuf6lvHzJxpx8A/4FwHOmkBDnpwNOxieR/sY9AbsHC88OkzscfMI0r6WA7vfiT4TZwL6dj3h5iEG8t9vCkiSSq/FRP7ClTBt+cqgUq96rHMoik54ANBOkHhWU5Nx0Cg3kMb9JfcqTgAadrfxtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605197; c=relaxed/simple;
	bh=ZVz6nj4UbEpZbl6tYHxFuKq/qPSaAZ9MpnOjiva0PyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsfdAI/ZQRpdVAz5sBAS553DT3QP6Q5ARvpns8MS1PuNL1vzyvwthVFq0ZTFGhHw4ebef3AzQ/ALjUbkuAvt7lRxGxHA0SGOhO1h2fh2/XBNLeAv0LbGTX8a23xaN1ncMauObm/EqW0yQCh6ZTlMgoD4RnBASvOIdzzoVomQrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMP7FoPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F512C43609;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709605196;
	bh=ZVz6nj4UbEpZbl6tYHxFuKq/qPSaAZ9MpnOjiva0PyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QMP7FoPsJ74ILNiOd7Tvaw9B9Mhf5P5Ddf0hJN8qCcLMJ6NnBlCCA3uB97pBw6Rj/
	 MJqrxQs4/2qL1hf/tPorVTigIca8M4XR7zpk9JXfBCrUCsOxry4zqBbb6wn0bbwwdA
	 NFkW858bPpUYmLqJMxyxqapPE11ZP+jSi9as41EAxguFOw6xzjcQedOPpdXB557Jly
	 WYXoonrhRAywoi7NCr/3ptmwlTGJhPtQryKiVL0sF9Xx7VIcQCgRWRnoy2+7X7F2aM
	 0ot3s1EsZsOLzDeB4cn6vpp/eXQWVg/edfWQnVhbtif1j5qkj70NpIYYuvvoBW0Uju
	 be7YeTtB7m7tQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7CBC54E58;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 10:19:50 +0800
Subject: [PATCH v4 5/5] phy: hisilicon: hisi-inno-phy: add support for
 Hi3798MV200 INNO PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-inno-phy-v4-5-a03204c9cf1c@outlook.com>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
In-Reply-To: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709605195; l=5083;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=hpWZOa3GUm+yktbgJ6FbaHA5gwAHZdlfsvDn+nR5IsE=;
 b=+qlj9H6AzcRViTrVE/rR0YLSUPKB4v0WqydB/LFfz2sNY2E2mZuHuEQ1tqHyI8EN570QJDPdr
 nJtS/tsHjFZBRuQVZ5fywvp+rsmUAyEGSPezBkDg1F1rYdeHjiOK5uP
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Direct MMIO resgiter access is used by Hi3798MV200. For other models,
of_iomap() returns NULL due to insufficient length. So they are
unaffected.

Also Hi3798MV200 INNO PHY has an extra reset required to be deasserted,
switch to reset_control_bulk_() APIs for that.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 66 ++++++++++++++++++------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b7e740eb4752..a759823b5b1e 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -24,6 +25,7 @@
 
 #define PHY_TYPE_0	0
 #define PHY_TYPE_1	1
+#define PHY_TYPE_MMIO	2
 
 #define PHY_TEST_DATA		GENMASK(7, 0)
 #define PHY_TEST_ADDR_OFFSET	8
@@ -43,6 +45,7 @@
 #define PHY_CLK_ENABLE		BIT(2)
 
 struct hisi_inno_phy_port {
+	void __iomem *base;
 	struct reset_control *utmi_rst;
 	struct hisi_inno_phy_priv *priv;
 };
@@ -50,7 +53,7 @@ struct hisi_inno_phy_port {
 struct hisi_inno_phy_priv {
 	void __iomem *mmio;
 	struct clk *ref_clk;
-	struct reset_control *por_rst;
+	struct reset_control *rsts;
 	unsigned int type;
 	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
 };
@@ -62,26 +65,31 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
 	u32 val;
 	u32 value;
 
-	if (priv->type == PHY_TYPE_0)
-		val = (data & PHY_TEST_DATA) |
-		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
-		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
-		      PHY0_TEST_WREN | PHY0_TEST_RST;
-	else
-		val = (data & PHY_TEST_DATA) |
-		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
-		      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
-		      PHY1_TEST_WREN | PHY1_TEST_RST;
-	writel(val, reg);
-
-	value = val;
-	if (priv->type == PHY_TYPE_0)
-		value |= PHY0_TEST_CLK;
-	else
-		value |= PHY1_TEST_CLK;
-	writel(value, reg);
-
-	writel(val, reg);
+	if (priv->ports[port].base)
+		/* FIXME: fill stride in priv */
+		writel(data, (u32 *)priv->ports[port].base + addr);
+	else {
+		if (priv->type == PHY_TYPE_0)
+			val = (data & PHY_TEST_DATA) |
+			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
+			      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
+			      PHY0_TEST_WREN | PHY0_TEST_RST;
+		else
+			val = (data & PHY_TEST_DATA) |
+			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
+			      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
+			      PHY1_TEST_WREN | PHY1_TEST_RST;
+		writel(val, reg);
+
+		value = val;
+		if (priv->type == PHY_TYPE_0)
+			value |= PHY0_TEST_CLK;
+		else
+			value |= PHY1_TEST_CLK;
+		writel(value, reg);
+
+		writel(val, reg);
+	}
 }
 
 static void hisi_inno_phy_setup(struct hisi_inno_phy_priv *priv)
@@ -104,7 +112,7 @@ static int hisi_inno_phy_init(struct phy *phy)
 		return ret;
 	udelay(REF_CLK_STABLE_TIME);
 
-	reset_control_deassert(priv->por_rst);
+	reset_control_deassert(priv->rsts);
 	udelay(POR_RST_COMPLETE_TIME);
 
 	/* Set up phy registers */
@@ -122,7 +130,7 @@ static int hisi_inno_phy_exit(struct phy *phy)
 	struct hisi_inno_phy_priv *priv = port->priv;
 
 	reset_control_assert(port->utmi_rst);
-	reset_control_assert(priv->por_rst);
+	reset_control_assert(priv->rsts);
 	clk_disable_unprepare(priv->ref_clk);
 
 	return 0;
@@ -158,15 +166,16 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->ref_clk))
 		return PTR_ERR(priv->ref_clk);
 
-	priv->por_rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(priv->por_rst))
-		return PTR_ERR(priv->por_rst);
+	priv->rsts = devm_reset_control_array_get(dev, false, false);
+	if (IS_ERR(priv->rsts))
+		return PTR_ERR(priv->rsts);
 
 	priv->type = (uintptr_t) of_device_get_match_data(dev);
 
 	for_each_child_of_node(np, child) {
 		struct reset_control *rst;
 		struct phy *phy;
+		void __iomem *base;
 
 		rst = of_reset_control_get_exclusive(child, NULL);
 		if (IS_ERR(rst)) {
@@ -174,7 +183,10 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(rst);
 		}
 
+		base = of_iomap(child, 0);
+
 		priv->ports[i].utmi_rst = rst;
+		priv->ports[i].base = base;
 		priv->ports[i].priv = priv;
 
 		phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
@@ -205,6 +217,8 @@ static const struct of_device_id hisi_inno_phy_of_match[] = {
 	  .data = (void *) PHY_TYPE_0 },
 	{ .compatible = "hisilicon,hi3798mv100-usb2-phy",
 	  .data = (void *) PHY_TYPE_1 },
+	{ .compatible = "hisilicon,hi3798mv200-usb2-phy",
+	  .data = (void *) PHY_TYPE_MMIO },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, hisi_inno_phy_of_match);

-- 
2.43.0


