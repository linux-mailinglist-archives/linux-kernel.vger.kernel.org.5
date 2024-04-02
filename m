Return-Path: <linux-kernel+bounces-128292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC058958E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88A8B2236B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C29135A55;
	Tue,  2 Apr 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yVIFvZCq"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68161350FB;
	Tue,  2 Apr 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073124; cv=none; b=m/GR5xXuNuh7Tq37sr/1pyjO/QxwG6mkE9ioyRnT5bUpscyo/lfAk0hS2LHB6qxuMqNNIzMiLQhvEwr+rS89oNW+EVTs8dDUlocbWpFsUPoX1fix2A9o0zfctEgwU+stqFdox1bbofDB/8yR4NBLvX0MBfC1p+P0Tu+e1wKyWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073124; c=relaxed/simple;
	bh=2j4Xeog3NYFtg9ZvjgJqhpn/krnNgk1T7F6OIubpOTw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NC/Uiko3kHqWt9Lb98pdpN2Gktw3rxIfpvTOA10PTw5xTFktOt0YVYvRlOPZpCv4KdGyHKLO2uz47+g1xy7Bx6xOXLbtxfNhRya8yJSpnTGA6izyAu2CdxSQVRkMnCCKIG8LCTd9x0ZxT+VnfNrN0BNXCA+GL7WEp9LsM+R167Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yVIFvZCq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RvfXLwxzoiDRSX+2p4VdbeCbmA1uTdKtDMO1TwE8wKQ=; b=yVIFvZCqRAA0hdk4pfGWRpOJKu
	E70QhvJ1PrTPpPdH6hAZkVEFw9TI+L+5uYvzipMacY+H5ceFkcXFL6cWOmDOLrcfpnD4cY6jua1os
	isLKYuTBpJ39VD+6i8ptPBsXw5e/COXEBdL9K5iaUZ23RYVVl5N09Jwnt1glNeiePPqBqEbPtFDME
	D1scf8Gz0HX7g2lCdZx8vkM7tzBgTwFhJfB3eJmwxjT0CmaL6pwJuZ0Qk1RakauJxbkD0gJzCe3UA
	QLLF/ElOOBoL87IqUHQNL/52zdA+Ab/UqLE2THtF5Kzh/2IxL0Pc8TRB8v0QvZQ5mlozDmcT0Jybr
	tj5kzhOQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55416 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rrgQO-000715-1J;
	Tue, 02 Apr 2024 16:51:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rrgQO-005ZOA-KT; Tue, 02 Apr 2024 16:51:48 +0100
In-Reply-To: <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
References: <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	 Eric Dumazet <edumazet@google.com>,
	 Jakub Kicinski <kuba@kernel.org>,
	 Paolo Abeni <pabeni@redhat.com>,
	 Rob Herring <robh@kernel.org>,
	 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	 Conor Dooley <conor+dt@kernel.org>,
	 Geert Uytterhoeven <geert+renesas@glider.be>,
	 Magnus Damm <magnus.damm@gmail.com>,
	 Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>,
	 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	 =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	 netdev@vger.kernel.org,
	 devicetree@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-renesas-soc@vger.kernel.org,
	 linux-stm32@st-md-mailman.stormreply.com,
	 linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: use
 pcs_init/pcs_exit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rrgQO-005ZOA-KT@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 02 Apr 2024 16:51:48 +0100

Use the newly introduced pcs_init() and pcs_exit() operations to
create and destroy the PCS instance at a more appropriate moment during
the driver lifecycle, thereby avoiding publishing a network device to
userspace that has not yet finished its PCS initialisation.

There are other similar issues with this driver which remain
unaddressed, but these are out of scope for this patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 109 +++++++++---------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 12b4a80ea3aa..67ca163936c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -379,6 +379,58 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	return 0;
 }
 
+static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv,
+				  struct mac_device_info *hw)
+{
+	struct socfpga_dwmac *dwmac = priv->plat->bsp_priv;
+	struct regmap_config pcs_regmap_cfg = {
+		.reg_bits = 16,
+		.val_bits = 16,
+		.reg_shift = regmap_upshift(1),
+	};
+	struct mdio_regmap_config mrc;
+	struct regmap *pcs_regmap;
+	struct phylink_pcs *pcs;
+	struct mii_bus *pcs_bus;
+
+	if (!dwmac->tse_pcs_base)
+		return 0;
+
+	pcs_regmap = devm_regmap_init_mmio(priv->device, dwmac->tse_pcs_base,
+					   &pcs_regmap_cfg);
+	if (IS_ERR(pcs_regmap))
+		return PTR_ERR(pcs_regmap);
+
+	memset(&mrc, 0, sizeof(mrc));
+	mrc.regmap = pcs_regmap;
+	mrc.parent = priv->device;
+	mrc.valid_addr = 0x0;
+	mrc.autoscan = false;
+
+	/* Can't use ndev->name here because it will not have been initialised,
+	 * and in any case, the user can rename network interfaces at runtime.
+	 */
+	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii",
+		 dev_name(priv->device));
+	pcs_bus = devm_mdio_regmap_register(priv->device, &mrc);
+	if (IS_ERR(pcs_bus))
+		return PTR_ERR(pcs_bus);
+
+	pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
+
+	hw->phylink_pcs = pcs;
+	return 0;
+}
+
+static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv,
+				   struct mac_device_info *hw)
+{
+	if (hw->phylink_pcs)
+		lynx_pcs_destroy(hw->phylink_pcs);
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -426,6 +478,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	dwmac->ops = ops;
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
+	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
+	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -444,48 +498,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dvr_remove;
 
-	/* Create a regmap for the PCS so that it can be used by the PCS driver,
-	 * if we have such a PCS
-	 */
-	if (dwmac->tse_pcs_base) {
-		struct regmap_config pcs_regmap_cfg;
-		struct mdio_regmap_config mrc;
-		struct regmap *pcs_regmap;
-		struct mii_bus *pcs_bus;
-
-		memset(&pcs_regmap_cfg, 0, sizeof(pcs_regmap_cfg));
-		memset(&mrc, 0, sizeof(mrc));
-
-		pcs_regmap_cfg.reg_bits = 16;
-		pcs_regmap_cfg.val_bits = 16;
-		pcs_regmap_cfg.reg_shift = REGMAP_UPSHIFT(1);
-
-		pcs_regmap = devm_regmap_init_mmio(&pdev->dev, dwmac->tse_pcs_base,
-						   &pcs_regmap_cfg);
-		if (IS_ERR(pcs_regmap)) {
-			ret = PTR_ERR(pcs_regmap);
-			goto err_dvr_remove;
-		}
-
-		mrc.regmap = pcs_regmap;
-		mrc.parent = &pdev->dev;
-		mrc.valid_addr = 0x0;
-		mrc.autoscan = false;
-
-		snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", ndev->name);
-		pcs_bus = devm_mdio_regmap_register(&pdev->dev, &mrc);
-		if (IS_ERR(pcs_bus)) {
-			ret = PTR_ERR(pcs_bus);
-			goto err_dvr_remove;
-		}
-
-		stpriv->hw->phylink_pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
-		if (IS_ERR(stpriv->hw->phylink_pcs)) {
-			ret = PTR_ERR(stpriv->hw->phylink_pcs);
-			goto err_dvr_remove;
-		}
-	}
-
 	return 0;
 
 err_dvr_remove:
@@ -494,17 +506,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void socfpga_dwmac_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct phylink_pcs *pcs = priv->hw->phylink_pcs;
-
-	stmmac_pltfr_remove(pdev);
-
-	lynx_pcs_destroy(pcs);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int socfpga_dwmac_resume(struct device *dev)
 {
@@ -576,7 +577,7 @@ MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
 
 static struct platform_driver socfpga_dwmac_driver = {
 	.probe  = socfpga_dwmac_probe,
-	.remove_new = socfpga_dwmac_remove,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
 		.pm		= &socfpga_dwmac_pm_ops,
-- 
2.30.2


