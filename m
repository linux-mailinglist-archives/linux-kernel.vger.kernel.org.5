Return-Path: <linux-kernel+bounces-92446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AC0872040
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D6E1F238E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C91272A0;
	Tue,  5 Mar 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddf/esF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6686122;
	Tue,  5 Mar 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645536; cv=none; b=ZqvCn0zjkLjXQDCxhUYrEKODdxIGFBg5uEDwsTWE5vKwZNi/Tcqq9SuqIxPTevBSgf4WHYl2Pkdgr5k1xf4/q61Gab0xCFs1c4mTvbc+DcSJdYWv7aAJ8f2PDXom66s3Mf4YS+Gb/+YTYnYwbbO96xFruy3ksa7nV0gK1KpI6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645536; c=relaxed/simple;
	bh=X2pcqaEppLriKl5jH3VKRq9t3eq7W6iCl/g1gvcIKuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAM7bKYrAAl5uFYCmrqlAtEDgIatRCpmN1Eh9kweagxmYUGMgvGAqpBLAG7iCVA4g2htgwpjcGLlkfNI8fjqqgH2MQjk5nUyfhloW7rhCabzA1NlTjvI1Q8/M5wAwnjvQA+D4wp1ENMB5peA3Nfk0edGZiXsyt234ltDcctS0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddf/esF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB6A2C4166A;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709645536;
	bh=X2pcqaEppLriKl5jH3VKRq9t3eq7W6iCl/g1gvcIKuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ddf/esF4RHNLGYbfxWPPnThG8FcTTMIpL7pQKEQ8MtvItx9bP5psPKzr4ygK2HpIv
	 9mbB+TTTRPJ0/Wpg/vFomMAMQH+7PKNI3QO5CshgCq4FX3w3c/Q+9Ne1Tn75qIzgu8
	 LKpgJqnjfKxP+Dk71KhhrM/2wuZewM3UfFMYgaR6Sf+6ynR1l97r1JTB5NimAsaFd0
	 sl7alfDiNiBmNd5X9GJ1iOu0hoBNX9ZvFnE2x5U2Xa5NS11wC59RyG8QjE3+Hl9djY
	 FQdkym7/Uy07U4ntsw0Lh2148RsTkn+DFGD9gJxLW0m+XKikzCPsncSUnl9ju7Dghf
	 +ZAFbV3v8F/iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893BC54798;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 21:32:16 +0800
Subject: [PATCH v5 5/5] phy: hisilicon: hisi-inno-phy: add support for
 Hi3798MV200 INNO PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-inno-phy-v5-5-dc1cb130ea08@outlook.com>
References: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
In-Reply-To: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709645533; l=5081;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=OaNSAYqVgjaJJu2us++JYHvopTtBdTV0BeYKpDi3R0o=;
 b=Nw6brnfN8pfAgTT5KgNfkoDEJgIi9IfSnGqii81cblSeDe0Ibkqpuw5oKVIQvnRhgPN68jL/A
 mPu0JoswG5QA8TnKAg8oPMyF60N9GbjveoPKcYGp8//AYNI6kl/YYKi
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
switch to reset_control_array_*() APIs for that.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 66 ++++++++++++++++++------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b7e740eb4752..df154cd99ed8 100644
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
+	priv->rsts = devm_reset_control_array_get_exclusive(dev);
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


