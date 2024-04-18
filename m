Return-Path: <linux-kernel+bounces-149967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E198A9887
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7975B20E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007E615E7F0;
	Thu, 18 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jkNRx4Xq"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CB15E5CF;
	Thu, 18 Apr 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439734; cv=none; b=PqobPgp9q+heto02+ERQXRFGAbLqq+UwQSUlk/djH1bA3wmXqPlaxdhxkwNaqDffZmMp/rI+77lczz/eOchsLHPbEf+LWPaby/l4kam9QLXUYpFZCzRWYJqojE9UdzSx/q+VqQ99WvocVOyyHlJ5ay30kmIpp/I3nbnr4ZmEdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439734; c=relaxed/simple;
	bh=3Bh5oclFR3QPm4tVo625Fl3eZk/+YVvGQI5CcaxWhts=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XuWdpX0UYvqqYSjbVtu/8WBRrV7YQ2UylUvgOiCW6Wm3xfF0TW8XEdzfljY/BG27FRy7h67LgD80HejyMloGmkkygP16GRL8IO+28uhli41vEg3WhefuTUVpQyBtFg4vOeJuC+AwJFfDARu996qiu0DMP0yLXSwT9R9rcyTJL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jkNRx4Xq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EBCEE0005;
	Thu, 18 Apr 2024 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713439729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0leo610WlDW38GlBTuA6KaiVJk/RBRpUySYdLn+9iHg=;
	b=jkNRx4XqaIlhhBjnuPtotUoFCPFp47uFHMSteuYl9/ut4lYhjbBR7khEc2/pPzfflHEaY8
	o6TDjg9x7jB0QJQablKWQmhWRnjSfR+9pj5yzq8qS9et35nPEwtLPYRNs2jcL50iew6RrZ
	jy2WZE7e4PWPBm+22/Hcce2tW6xtUXqyvyQIY5h8EWeNOEed8qDfS8rr4IYJnJBhv2ZsIb
	ag7yIGnRm+vZ87IV2yrX5h+Zkwk3ohHCvZTKgrHQeFgiLMaYp3dAQ+po+yulLsm9aao/rC
	846ulilKBsOI6cvveqEg+X2s7xT1jIDXMo/SlXT76QZVQ99TlEqSbVf05I4pYQ==
Date: Thu, 18 Apr 2024 13:29:25 +0200 (CEST)
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
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Rename phylink_get_caps()
 callback to update_caps()
In-Reply-To: <20240417140013.12575-2-fancer.lancer@gmail.com>
Message-ID: <8f893436-018e-73d8-15b1-8037af5b4f04@bootlin.com>
References: <20240417140013.12575-1-fancer.lancer@gmail.com> <20240417140013.12575-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Wed, 17 Apr 2024, Serge Semin wrote:

> Since recent commits the stmmac_ops::phylink_get_caps() callback has no
> longer been responsible for the phylink MAC capabilities getting, but
> merely updates the MAC capabilities in the mac_device_info::link::caps
> field. Rename the callback to comply with the what the method does now.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> Link: https://lore.kernel.org/netdev/20240412180340.7965-5-fancer.lancer@gmail.com/
> Changelog v2:
> - This is a new patch created based on the discussion around patch #4 in
>   the series above.
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 8 ++++----
>  drivers/net/ethernet/stmicro/stmmac/hwif.h        | 8 ++++----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index a38226d7cc6a..b25774d69195 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -68,7 +68,7 @@ static void dwmac4_core_init(struct mac_device_info *hw,
>  		init_waitqueue_head(&priv->tstamp_busy_wait);
>  }
>  
> -static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
> +static void dwmac4_update_caps(struct stmmac_priv *priv)
>  {
>  	if (priv->plat->tx_queues_to_use > 1)
>  		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
> @@ -1190,7 +1190,7 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
>  
>  const struct stmmac_ops dwmac4_ops = {
>  	.core_init = dwmac4_core_init,
> -	.phylink_get_caps = dwmac4_phylink_get_caps,
> +	.update_caps = dwmac4_update_caps,
>  	.set_mac = stmmac_set_mac,
>  	.rx_ipc = dwmac4_rx_ipc_enable,
>  	.rx_queue_enable = dwmac4_rx_queue_enable,
> @@ -1235,7 +1235,7 @@ const struct stmmac_ops dwmac4_ops = {
>  
>  const struct stmmac_ops dwmac410_ops = {
>  	.core_init = dwmac4_core_init,
> -	.phylink_get_caps = dwmac4_phylink_get_caps,
> +	.update_caps = dwmac4_update_caps,
>  	.set_mac = stmmac_dwmac4_set_mac,
>  	.rx_ipc = dwmac4_rx_ipc_enable,
>  	.rx_queue_enable = dwmac4_rx_queue_enable,
> @@ -1284,7 +1284,7 @@ const struct stmmac_ops dwmac410_ops = {
>  
>  const struct stmmac_ops dwmac510_ops = {
>  	.core_init = dwmac4_core_init,
> -	.phylink_get_caps = dwmac4_phylink_get_caps,
> +	.update_caps = dwmac4_update_caps,
>  	.set_mac = stmmac_dwmac4_set_mac,
>  	.rx_ipc = dwmac4_rx_ipc_enable,
>  	.rx_queue_enable = dwmac4_rx_queue_enable,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7be04b54738b..90384db228b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -308,8 +308,8 @@ struct stmmac_est;
>  struct stmmac_ops {
>  	/* MAC core initialization */
>  	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
> -	/* Get phylink capabilities */
> -	void (*phylink_get_caps)(struct stmmac_priv *priv);
> +	/* Update MAC capabilities */
> +	void (*update_caps)(struct stmmac_priv *priv);
>  	/* Enable the MAC RX/TX */
>  	void (*set_mac)(void __iomem *ioaddr, bool enable);
>  	/* Enable and verify that the IPC module is supported */
> @@ -430,8 +430,8 @@ struct stmmac_ops {
>  
>  #define stmmac_core_init(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, core_init, __args)
> -#define stmmac_mac_phylink_get_caps(__priv) \
> -	stmmac_do_void_callback(__priv, mac, phylink_get_caps, __priv)
> +#define stmmac_mac_update_caps(__priv) \
> +	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
>  #define stmmac_mac_set(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, set_mac, __args)
>  #define stmmac_rx_ipc(__priv, __args...) \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7c6fb14b5555..b810f6b69bf5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1225,8 +1225,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  		xpcs_get_interfaces(priv->hw->xpcs,
>  				    priv->phylink_config.supported_interfaces);
>  
> -	/* Get the MAC specific capabilities */
> -	stmmac_mac_phylink_get_caps(priv);
> +	/* Refresh the MAC-specific capabilities */
> +	stmmac_mac_update_caps(priv);
>  
>  	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
>  
> @@ -7341,7 +7341,7 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
>  									rx_cnt);
>  
> -	stmmac_mac_phylink_get_caps(priv);
> +	stmmac_mac_update_caps(priv);
>  
>  	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
>  
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

