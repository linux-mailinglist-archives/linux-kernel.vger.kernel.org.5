Return-Path: <linux-kernel+bounces-128291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D228958E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23C5B21C72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D651353E2;
	Tue,  2 Apr 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xdmmtHtw"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93032131750;
	Tue,  2 Apr 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073121; cv=none; b=Wi9lVZ5xjM/OKjH0Pz3zHxxRQ5tKVbOTYV25LNEhJ3Conw/sr4nybQmMbmTFwC3E4BwdaEAH/2W9FH2Wznd03QUl/pM47zz681IT/D3vMiC+YRxaMqY2yZa+n4ubSL0gMnb0Un1PgYnXzk1nUy4ijLlUdCySUZg0DTNp6rCjFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073121; c=relaxed/simple;
	bh=L5QGc/wHh7ih1payKh5DQ6wM8WxgsGe+ZBegw9ypRf4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pcFTZkli/OZJxUKoyIoJ1IEvzrDvQjYSjIMXtV2aQ0bKq42uQeCc0zkIWC/MicXznZwMRugKhBgGpM6B30NqANIOnWVubbg7nrHRjl/6ax/9E2MV3hSSxznkDezYY5W0CnjxUT7noWiEbO4XBX8bUVsdWcGLZuY6TgxONZT4+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xdmmtHtw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PXpSDMwoudBQQUvwRwf46Fwc8o8+Vle+EwFXwBBNUhQ=; b=xdmmtHtwZUS1EkgJDhgYJ6230L
	V63f79UsEb3MsGPvSllt3H5Qm+Fc6YCzpMj/hqAu2+gjF+Xdic6CT0A/6auASKucYVgXo3d/6u7df
	P/dIDT0l3M1vTZDs93ghl+HPeTGusJ3Rn6yn3m/6D7t4P/G3cLv8B7M941Kh9EKjUVTXMndA1o1jA
	8Gk+XQpGTTpXPR9h6tChpvpP8bH0XLfC9VZanN5kio5JbfT0Mkh4ilGb5unrWw9dvNhOMWS/7BbHB
	fr9+HbxscnxX17YgI3ZNqYrVOUAsb1izzEQXkYs06E4F0Y41j6yE894m5IWGlLYmR+qALVPtj1bAo
	zU6ZoNJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55404 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rrgQJ-00070v-06;
	Tue, 02 Apr 2024 16:51:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rrgQJ-005ZO4-GB; Tue, 02 Apr 2024 16:51:43 +0100
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
Subject: [PATCH net-next 1/2] net: stmmac: introduce pcs_init/pcs_exit stmmac
 operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rrgQJ-005ZO4-GB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 02 Apr 2024 16:51:43 +0100

Introduce a mechanism whereby platforms can create their PCS instances
prior to the network device being published to userspace, but after
some of the core stmmac initialisation has been completed. This means
that the data structures that platforms need will be available.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++++
 include/linux/stmmac.h                            |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe3498e86de9..25fa33ae7017 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7208,6 +7208,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (ret)
 		return ret;
 
+	if (priv->plat->pcs_init) {
+		ret = priv->plat->pcs_init(priv, priv->hw);
+		if (ret)
+			return ret;
+	}
+
 	/* Get the HW capability (new GMAC newer than 3.50a) */
 	priv->hw_cap_support = stmmac_get_hw_features(priv);
 	if (priv->hw_cap_support) {
@@ -7290,6 +7296,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	return 0;
 }
 
+static void stmmac_hw_exit(struct stmmac_priv *priv)
+{
+	if (priv->plat->pcs_exit)
+		priv->plat->pcs_exit(priv, priv->hw);
+}
+
 static void stmmac_napi_add(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -7804,6 +7816,7 @@ int stmmac_dvr_probe(struct device *device,
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	stmmac_hw_exit(priv);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
@@ -7844,6 +7857,7 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
+	stmmac_hw_exit(priv);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..941fde506e51 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -285,6 +285,8 @@ struct plat_stmmacenet_data {
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
 			   void *ctx);
 	void (*dump_debug_regs)(void *priv);
+	int (*pcs_init)(struct stmmac_priv *priv, struct mac_device_info *hw);
+	void (*pcs_exit)(struct stmmac_priv *priv, struct mac_device_info *hw);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;
-- 
2.30.2


