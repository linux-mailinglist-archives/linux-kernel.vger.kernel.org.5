Return-Path: <linux-kernel+bounces-146432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216398A652D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5B71F22650
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B077FBC6;
	Tue, 16 Apr 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GA0sZrWA"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71C3B78B;
	Tue, 16 Apr 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252761; cv=none; b=Culvy7hYLI11XvgYSj2kcN9O3BXdrGaWHWulX/cGd9BSbDuoap6QOlLnj/eW0jtAKwvuu8PNlPuTaiyG+EHbsWeEWIt6seUzxoiKFkghFVTmW6UWfmsLmUgDuS/tFlCKuP7KKtaEg9anae6yZebdcfsYCwdiVZH3BBxaBcNHW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252761; c=relaxed/simple;
	bh=FIgGURLFLfp2cIyxqCz3adqRLXcVtc3KCQ+iVrL+UIg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MhQKoNdtT7H5Py4AYQjg4U4XIL/oDcX6pR1ZtSUYhizWI7Bx3M7wzAV31zj9p4T6JDaqMwzafRWJTE76VNDNf4YPkWtbIRXcKd/BEniORIWi8xQPZjnYFU82yw6HEBiFp1irvHyIL+o2YvHRYTocfQQdbaSti6zzeYgKjSzchqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GA0sZrWA; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 275042000A;
	Tue, 16 Apr 2024 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713252749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d+J9a1XsY9wVIqCw//2fmPUH+b6/wrcvkVKiCmqi9U0=;
	b=GA0sZrWAe9372nqCrt2w7l3ynepzPOSCskMsWstQkbv2DpTvZPxFBHPt7qJ4ExbwTtq4ip
	CrFWLht6zyQ7ZUwa91cwhKzBzmzZJ/kMkknRvUEC++beLzXMd2Xkwkc9HQWcQ3CzyGvIbL
	xJPQyVQJRa3SUg1V8XXeJyu71kDHv5JbYQZeBFFy+1IvQNn93U7ruseGnNfN3kUTJTV7Q3
	WBLULJmsDOZ/h82mvh+w+Il0JRcinK2JiAIYmxgh6puuvM3F7h9QlIiaey91hR/8x/QzKO
	NNK9c6LTOEc0ftlg4mAc8IFuOIuYAXv/OfZFlWyppJh5aPCWzmG3P/goyDrRKg==
Date: Tue, 16 Apr 2024 09:33:04 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
    Yanteng Si <siyanteng@loongson.cn>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>, 
    "Gan, Yi Fang" <yi.fang.gan@intel.com>, Simon Horman <horms@kernel.org>, 
    Huacai Chen <chenhuacai@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] net: stmmac: Fix max-speed being ignored on
 queue re-init
In-Reply-To: <20240412180340.7965-3-fancer.lancer@gmail.com>
Message-ID: <c9b9a88b-f6ab-25ca-74c2-474c2f1c891f@bootlin.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com> <20240412180340.7965-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com


On Fri, 12 Apr 2024, Serge Semin wrote:

> It's possible to have the maximum link speed being artificially limited on
> the platform-specific basis. It's done either by setting up the
> plat_stmmacenet_data::max_speed field or by specifying the "max-speed"
> DT-property. In such cases it's required that any specific
> MAC-capabilities re-initializations would take the limit into account. In
> particular the link speed capabilities may change during the number of
> active Tx/Rx queues re-initialization. But the currently implemented
> procedure doesn't take the speed limit into account.
> 
> Fix that by calling phylink_limit_mac_speed() in the
> stmmac_reinit_queues() method if the speed limitation was required in the
> same way as it's done in the stmmac_phy_setup() function.
> 
> Fixes: 95201f36f395 ("net: stmmac: update MAC capabilities when tx queues are updated")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index dd58c21b53ee..b8a1f02398ee 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7328,6 +7328,7 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	int ret = 0, i;
> +	int max_speed;
>  
>  	if (netif_running(dev))
>  		stmmac_release(dev);
> @@ -7343,6 +7344,10 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  
>  	stmmac_mac_phylink_get_caps(priv);
>  
> +	max_speed = priv->plat->max_speed;
> +	if (max_speed)
> +		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
> +
>  	stmmac_napi_add(dev);
>  
>  	if (netif_running(dev))
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

