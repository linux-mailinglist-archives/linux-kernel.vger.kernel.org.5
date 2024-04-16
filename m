Return-Path: <linux-kernel+bounces-146456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE78A6596
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ED01C224A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D7136E13;
	Tue, 16 Apr 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NV3om/Vu"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20184FDB;
	Tue, 16 Apr 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254428; cv=none; b=GeKe8My+9/MyjvgmzsV3oDWw7z/Wr1GkwHKYM7AvYsgAounKBIEK+QTOmP+bZcFZR9QbY5APozc/eGehYzoFLM46XK4JljnsG54+/D3ulrrQUCLOJ9QDUA0PVmVseb3cWbB5YJgL7pirgf/3MJBKxbgE+CozMvg7qJlUfYnyxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254428; c=relaxed/simple;
	bh=mLgxZjyAUp0NV/f8DGt9IaprdC+uRW+ysDIR4IryXvo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UlulmdxqssIt15isU3amZLBv/TrVGc7loptwQp9HrHUz/qRsgMXZF6IRyJkyg7i81bznge0MBK64EfkpZrjEjv+R7H9nQG79kMjyaBsmdAB49ZkRGR6BDD92sqxFHd1HnzusvjoHDrtxpUo3sv4gEYdq8hF7p/B79pRsdWlDvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NV3om/Vu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AA15E0012;
	Tue, 16 Apr 2024 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713254422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQNbiMLr4jYeyHOSIBnjLr8DKZRWgrbGnQddnfIMp/4=;
	b=NV3om/VuFyHBWFyV70iAztTsjeYvR15eF47iCzTxUBC4arj/TlqTMggfwQ1bwtn0jrKnds
	hBOXJLPkVFrx7JLYzsGn8GPmYvuOdd4WcWa9YmYD8SjRWGRqJqp0F+aK2G2mhIPqbxFYd2
	YabIJaRgtnLGvch8lLDpTeQXw7y+JTNz+d1t93IjjespoOk6OY/1cFNJWuKlbsDwCmPHKz
	9vtuSsO/lC3vkhnRAmLJIpCPsOkiuedFmiCVAuh/dqXD8ffX0qfZbtUjrcok2EDWPl3kw4
	8w0fCOodmzlGLIGcxmY3u/OuVK5grNjvA1NhI6CVwn4Jtg3vvfHUWmIWWVyYgA==
Date: Tue, 16 Apr 2024 10:00:56 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
    Yanteng Si <siyanteng@loongson.cn>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, Simon Horman <horms@kernel.org>, 
    Huacai Chen <chenhuacai@kernel.org>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH net 3/4] net: stmmac: Fix IP-cores specific MAC
 capabilities
In-Reply-To: <20240412180340.7965-4-fancer.lancer@gmail.com>
Message-ID: <b1c32388-f815-469f-479d-2a67e6924350@bootlin.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com> <20240412180340.7965-4-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Fri, 12 Apr 2024, Serge Semin wrote:

> Here is the list of the MAC capabilities specific to the particular DW MAC
> IP-cores currently supported by the driver:
> 
> DW MAC100: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> 	   MAC_10 | MAC_100
> 
> DW GMAC:  MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>           MAC_10 | MAC_100 | MAC_1000
> 
> Allwinner sun8i MAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>                      MAC_10 | MAC_100 | MAC_1000
> 
> DW QoS Eth: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>             MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD
> if there is more than 1 active Tx/Rx queues:
> 	   MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>            MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD
> 
> DW XGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>           MAC_1000FD | MAC_2500FD | MAC_5000FD | MAC_10000FD
> 
> DW XLGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>           MAC_1000FD | MAC_2500FD | MAC_5000FD | MAC_10000FD |
>           MAC_25000FD | MAC_40000FD | MAC_50000FD | MAC_100000FD
> 
> As you can see there are only two common capabilities:
> MAC_ASYM_PAUSE | MAC_SYM_PAUSE.
> Meanwhile what is currently implemented defines 10/100/1000 link speeds
> for all IP-cores, which is definitely incorrect for DW MAC100, DW XGMAC
> and DW XLGMAC devices.
> 
> Seeing the flow-control is implemented as a callback for each MAC IP-core
> (see dwmac100_flow_ctrl(), dwmac1000_flow_ctrl(), sun8i_dwmac_flow_ctrl(),
> etc) and since the MAC-specific setup() method is supposed to be called
> for each available DW MAC-based device, the capabilities initialization
> can be freely moved to these setup() functions, thus correctly setting up
> the MAC-capabilities for each IP-core (including the Allwinner Sun8i). A
> new stmmac_link::caps field was specifically introduced for that so to
> have all link-specific info preserved in a single structure.
> 
> Note the suggested change fixes three earlier commits at a time. The
> commit 5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC
> supports") permitted the 10-100 link speeds and 1G half-duplex mode for DW
> XGMAC IP-core even though it doesn't support them. The commit df7699c70c1b
> ("net: stmmac: Do not cut down 1G modes") incorrectly added the MAC1000
> capability to the DW MAC100 IP-core. Similarly to the DW XGMAC the commit
> 8a880936e902 ("net: stmmac: Add XLGMII support") incorrectly permitted the
> 10-100 link speeds and 1G half-duplex mode for DW XLGMAC IP-core.
> 
> Fixes: 5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC supports")
> Fixes: df7699c70c1b ("net: stmmac: Do not cut down 1G modes")
> Fixes: 8a880936e902 ("net: stmmac: Add XLGMII support")
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 ++
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c   |  2 ++
>  .../ethernet/stmicro/stmmac/dwmac100_core.c    |  2 ++
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 10 ++++------
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c    | 18 ++++++++----------
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  7 ++++---
>  7 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index a6fefe675ef1..3b7d4ac1e7be 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -553,6 +553,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
>  extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
>  
>  struct mac_link {
> +	u32 caps;
>  	u32 speed_mask;
>  	u32 speed10;
>  	u32 speed100;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index b21d99faa2d0..e1b761dcfa1d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -1096,6 +1096,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
>  
>  	priv->dev->priv_flags |= IFF_UNICAST_FLT;
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100 | MAC_1000;
>  	/* The loopback bit seems to be re-set when link change
>  	 * Simply mask it each time
>  	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> index 3927609abc44..8555299443f4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> @@ -539,6 +539,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100 | MAC_1000;
>  	mac->link.duplex = GMAC_CONTROL_DM;
>  	mac->link.speed10 = GMAC_CONTROL_PS;
>  	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> index a6e8d7bd9588..7667d103cd0e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> @@ -175,6 +175,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
>  	dev_info(priv->device, "\tDWMAC100\n");
>  
>  	mac->pcsr = priv->ioaddr;
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100;
>  	mac->link.duplex = MAC_CONTROL_F;
>  	mac->link.speed10 = 0;
>  	mac->link.speed100 = 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index ec6a13e644b3..a38226d7cc6a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -70,14 +70,10 @@ static void dwmac4_core_init(struct mac_device_info *hw,
>  
>  static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
>  {
> -	priv->phylink_config.mac_capabilities |= MAC_2500FD;
> -
>  	if (priv->plat->tx_queues_to_use > 1)
> -		priv->phylink_config.mac_capabilities &=
> -			~(MAC_10HD | MAC_100HD | MAC_1000HD);
> +		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
>  	else
> -		priv->phylink_config.mac_capabilities |=
> -			(MAC_10HD | MAC_100HD | MAC_1000HD);
> +		priv->hw->link.caps |= (MAC_10HD | MAC_100HD | MAC_1000HD);
>  }
>  
>  static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
> @@ -1385,6 +1381,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
>  	mac->link.duplex = GMAC_CONFIG_DM;
>  	mac->link.speed10 = GMAC_CONFIG_PS;
>  	mac->link.speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index e841e312077e..f8e7775bb633 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
>  	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
>  }
>  
> -static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
> -{
> -	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
> -						 MAC_10000FD | MAC_25000FD |
> -						 MAC_40000FD | MAC_50000FD |
> -						 MAC_100000FD;
> -}
> -
>  static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
>  {
>  	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
> @@ -1540,7 +1532,6 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
>  
>  const struct stmmac_ops dwxgmac210_ops = {
>  	.core_init = dwxgmac2_core_init,
> -	.phylink_get_caps = xgmac_phylink_get_caps,
>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxgmac2_rx_queue_enable,
> @@ -1601,7 +1592,6 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
>  
>  const struct stmmac_ops dwxlgmac2_ops = {
>  	.core_init = dwxgmac2_core_init,
> -	.phylink_get_caps = xgmac_phylink_get_caps,
>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
> @@ -1661,6 +1651,9 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
> +			 MAC_10000FD;
>  	mac->link.duplex = 0;
>  	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
>  	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
> @@ -1698,6 +1691,11 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
> +			 MAC_10000FD | MAC_25000FD |
> +			 MAC_40000FD | MAC_50000FD |
> +			 MAC_100000FD;
>  	mac->link.duplex = 0;
>  	mac->link.speed1000 = XLGMAC_CONFIG_SS_1000;
>  	mac->link.speed2500 = XLGMAC_CONFIG_SS_2500;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b8a1f02398ee..7c6fb14b5555 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1225,12 +1225,11 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  		xpcs_get_interfaces(priv->hw->xpcs,
>  				    priv->phylink_config.supported_interfaces);
>  
> -	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -						MAC_10 | MAC_100 | MAC_1000;
> -
>  	/* Get the MAC specific capabilities */
>  	stmmac_mac_phylink_get_caps(priv);
>  
> +	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
> +
>  	max_speed = priv->plat->max_speed;
>  	if (max_speed)
>  		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
> @@ -7344,6 +7343,8 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  
>  	stmmac_mac_phylink_get_caps(priv);
>  
> +	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
> +
>  	max_speed = priv->plat->max_speed;
>  	if (max_speed)
>  		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

