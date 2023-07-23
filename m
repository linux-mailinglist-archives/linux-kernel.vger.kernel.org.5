Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122B75E3A6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGWQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGWQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899E199E;
        Sun, 23 Jul 2023 09:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C84D60DD4;
        Sun, 23 Jul 2023 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E87C433CC;
        Sun, 23 Jul 2023 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690129346;
        bh=bFmeinZ7Kd4jdsovg/FRP0oCfQ9tMqtvHuGgUp87Sic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUlutc8Wq9RHTJHU8NiAqatca/TXHO/zzlW/NhU0GQlQUU+9AZTz4ZIxmiPOq7XG2
         Y3T8vqTs4kUXZ0m9EFID3JyhefavnkPjFCqzbVA98JgxHueVALbPjdz8nK8KufVmY2
         Md55N/DMOllcQeh/Nt0mkPcYr2deyq/jAF9xKRgh4atvgP4cXxkNLcns+gRRKPG6tE
         r00R4th71LVs0jWurX5gq00mgvyYkEcbi7ITdatKx1aMRulWUrFQpFxGU7oMexkNyK
         u/0NPq/G2QRg9SMVCbD+vdCTz4HD7QZr4N6kiuxkC32rPnGbYveukqgQEHmOep6i1q
         TApI19ohxdilw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 05/10] net: stmmac: rename multi_msi_en to perch_irq_en
Date:   Mon, 24 Jul 2023 00:10:24 +0800
Message-Id: <20230723161029.1345-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP supports per channel interrupt, when intel adds the per channel
interrupt support, the per channel irq is from MSI vector, but this
feature can also be supported on non-MSI platforms. Renaming
multi_msi_en to perch_irq_en to reflects this fact.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 include/linux/stmmac.h                            | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 0ffae785d8bd..99a072907008 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -953,7 +953,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
 
 	res->irq = pci_irq_vector(pdev, 0);
 	res->wol_irq = res->irq;
-	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags &= ~STMMAC_FLAG_PERCH_IRQ_EN;
 	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
 		 __func__);
 
@@ -1005,7 +1005,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
 
-	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
 	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..9bf8adf466a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
 
 	value = readl(ioaddr + DMA_BUS_MODE);
 
-	if (dma_cfg->multi_msi_en) {
+	if (dma_cfg->perch_irq_en) {
 		value &= ~DMA_BUS_MODE_INTM_MASK;
 		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 15ed3947361b..c97bebfd04f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3722,7 +3722,7 @@ static int stmmac_request_irq(struct net_device *dev)
 	int ret;
 
 	/* Request the IRQ lines */
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
+	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN)
 		ret = stmmac_request_irq_multi_msi(dev);
 	else
 		ret = stmmac_request_irq_single(dev);
@@ -6007,7 +6007,7 @@ static void stmmac_poll_controller(struct net_device *dev)
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return;
 
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
+	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN) {
 		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
 			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
 
@@ -7278,8 +7278,8 @@ int stmmac_dvr_probe(struct device *device,
 	priv->plat = plat_dat;
 	priv->ioaddr = res->addr;
 	priv->dev->base_addr = (unsigned long)res->addr;
-	priv->plat->dma_cfg->multi_msi_en =
-		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
+	priv->plat->dma_cfg->perch_irq_en =
+		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 11671fd6adee..76249117c0ff 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -96,7 +96,7 @@ struct stmmac_dma_cfg {
 	int mixed_burst;
 	bool aal;
 	bool eame;
-	bool multi_msi_en;
+	bool perch_irq_en;
 	bool dche;
 };
 
@@ -211,7 +211,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_TSO_EN			BIT(4)
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
-#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
+#define STMMAC_FLAG_PERCH_IRQ_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
-- 
2.40.1

