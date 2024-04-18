Return-Path: <linux-kernel+bounces-149973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B08A989F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544CC1C22037
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E9415E808;
	Thu, 18 Apr 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T2l9eKaE"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666215E5B2;
	Thu, 18 Apr 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440019; cv=none; b=bpolx8yQ0TDv3Ukqrp9igCuEEW4APH7GV/2VKdAJdzeW0xRDXsKYPstWfgGBZN0IRUknekT0KLW+Yv9TgIieHLjFSZJX6Ax6Fj/z8Vt4XDorriDIFP9iuOFCxIXE3i+cLVd8uJHMz31JczBoGJNBodaHR7tt8kIqYxtK4j8Z+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440019; c=relaxed/simple;
	bh=S0Qtd48tNRGLbVj/o0e5qeU3ZyCGi6a1vbQ/5oxDT60=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pCI4xIfS7eDhbeIbNrwg809cyMNBEECCFo4sAyWN1on1mM6vLqUR2aBYzEAQpNysLydhwI+VjOd3mp1+bmzfqoCSMmDbADQNoIDDJ5HP84N88ySoEsIK6u6OYkkUhFEp7cdcEGMXjTR7UJ9pLZXASzZ2zdmbSGqzb23L+bFBlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T2l9eKaE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 920941BF206;
	Thu, 18 Apr 2024 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713440011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2t0MvM3jxvWGhN7eeYzckVy+rZfzBeuSxhEQgyjStA=;
	b=T2l9eKaEQOh/hyimKIEDxMZ3Pn2pDXPAXRc6Qs194CynWl621S9CfaOzn6J8yWwAChl1jW
	6Gb+U3xdQ2nN+H+Ysdo6Qx09jkQwPkQTnr6LFj7rJId12SmbDAjXcoJPII3SRN2jP1f2B+
	/dVv8tiIq2ipOXEoZzZqlVcqNnEkqRvNhaWFlN5crMPdIQBVSvUTYWNwmJFFTGMVzAar2y
	I1TVf87X3GglcePbiTlFkxGZ47pD+scs1RDbffKxXfn7A4dYhcKjcCG22uXUu9t8cEi/UZ
	n0yxF39bBWUQb+89HQW7W3WSfvdJNqlMQy/aycd3D3XMtuoTe2fKuZ4xRMlYiQ==
Date: Thu, 18 Apr 2024 13:34:06 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
    Yanteng Si <siyanteng@loongson.cn>, 
    Romain Gantois <romain.gantois@bootlin.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Simon Horman <horms@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
    Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Move MAC caps init to
 phylink MAC caps getter
In-Reply-To: <20240417140013.12575-3-fancer.lancer@gmail.com>
Message-ID: <c441691f-906d-4f44-10c8-3d8437cd3833@bootlin.com>
References: <20240417140013.12575-1-fancer.lancer@gmail.com> <20240417140013.12575-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Wed, 17 Apr 2024, Serge Semin wrote:

> After a set of recent fixes the stmmac_phy_setup() and
> stmmac_reinit_queues() methods have turned to having some duplicated code.
> Let's get rid from the duplication by moving the MAC-capabilities
> initialization to the PHYLINK MAC-capabilities getter. The getter is
> called during each network device interface open/close cycle. So the
> MAC-capabilities will be initialized in generic device open procedure and
> in case of the Tx/Rx queues re-initialization as the original code
> semantics implies.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> Link: https://lore.kernel.org/netdev/20240412180340.7965-5-fancer.lancer@gmail.com/
> Changelog v2:
> - Resubmit the patch to net-next separately from the main patchset (Paolo)
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 +++++++++----------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b810f6b69bf5..0d6cd1704e6a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
>  			priv->pause, tx_cnt);
>  }
>  
> +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> +					 phy_interface_t interface)
> +{
> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +
> +	/* Refresh the MAC-specific capabilities */
> +	stmmac_mac_update_caps(priv);
> +
> +	config->mac_capabilities = priv->hw->link.caps;
> +
> +	if (priv->plat->max_speed)
> +		phylink_limit_mac_speed(config, priv->plat->max_speed);
> +
> +	return config->mac_capabilities;
> +}
> +
>  static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
>  						 phy_interface_t interface)
>  {
> @@ -1105,6 +1121,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  }
>  
>  static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> +	.mac_get_caps = stmmac_mac_get_caps,
>  	.mac_select_pcs = stmmac_mac_select_pcs,
>  	.mac_config = stmmac_mac_config,
>  	.mac_link_down = stmmac_mac_link_down,
> @@ -1204,7 +1221,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  	int mode = priv->plat->phy_interface;
>  	struct fwnode_handle *fwnode;
>  	struct phylink *phylink;
> -	int max_speed;
>  
>  	priv->phylink_config.dev = &priv->dev->dev;
>  	priv->phylink_config.type = PHYLINK_NETDEV;
> @@ -1225,15 +1241,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  		xpcs_get_interfaces(priv->hw->xpcs,
>  				    priv->phylink_config.supported_interfaces);
>  
> -	/* Refresh the MAC-specific capabilities */
> -	stmmac_mac_update_caps(priv);
> -
> -	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
> -
> -	max_speed = priv->plat->max_speed;
> -	if (max_speed)
> -		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
> -
>  	fwnode = priv->plat->port_node;
>  	if (!fwnode)
>  		fwnode = dev_fwnode(priv->device);
> @@ -7327,7 +7334,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	int ret = 0, i;
> -	int max_speed;
>  
>  	if (netif_running(dev))
>  		stmmac_release(dev);
> @@ -7341,14 +7347,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
>  									rx_cnt);
>  
> -	stmmac_mac_update_caps(priv);
> -
> -	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
> -
> -	max_speed = priv->plat->max_speed;
> -	if (max_speed)
> -		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
> -
>  	stmmac_napi_add(dev);
>  
>  	if (netif_running(dev))
> -- 
> 2.43.0
> 
> 

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

