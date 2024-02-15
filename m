Return-Path: <linux-kernel+bounces-66436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F6855CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72C91C2AFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89F1426B;
	Thu, 15 Feb 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l55KvUAU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C813AF0;
	Thu, 15 Feb 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986467; cv=none; b=CtvJyDZN0n49BnJDWcsAD/Ux9+RfX8ZcX/j+7aNCOPO4rQ4bf/zkavvkYiKm2Wlt9mezo/8tcF3yqvvbKIgVcD9l+r3xJG3vPGHvz2lSqXRYSbojVBS9cQNyMBBmaw8tnQm6POHmDjBoTB7Mxmmm1UikMSUxdsijzHpXDs/zHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986467; c=relaxed/simple;
	bh=xfJAiAtdOwGcuyj3soNnB/AjhKb5oEC0svUBOQX2UY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W21jIPvvcHw92N4yweJkp5t5KExclUj8KA7VSZ/sJ6A5TwcXljumchcmSAJCx/IVF+xyJjVLTmHYjqEZI6nT6A3fdhLn0sXlcSzz29BL+AvVSL8KtPd5RxBReyxwKN0gz50sfiP5VCwmmaCwDo4SYW7cJNDuj9RlV0rZaAV178c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l55KvUAU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707986465; x=1739522465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfJAiAtdOwGcuyj3soNnB/AjhKb5oEC0svUBOQX2UY4=;
  b=l55KvUAUfq1XSoY5ef95lgQWnabIa8q+RYq35pQz9HtWbNheJ9CZAbdY
   SrofNPe6nJEJavslanOBR6qcbiUXFlkdpUYe2yzqQJdPNXoCaPqlzfy9W
   WEzs5wy6fvBkVKUV5rjy19N9WKejxHdgctnU+4s4xPZLr2ISCAUJbKXjQ
   4m8DUJ1JDAKokMC60Z/uAaFkbD0FRohlez+yGnGe1FaQspdj9j8I5+Ume
   f6ejKM+zgcHGY//j6HYoYP8gKBhjoovpiJT+kG3iuln8nzu401uVC9lc0
   igaz/S+EKm35cUgjhi01BK72Ah0hTUDS/JKcgXY+uVYKM7PMcIDaBQCBX
   Q==;
X-CSE-ConnectionGUID: lRbneegbRjG0wscWWaorRg==
X-CSE-MsgGUID: QlpATd2hTxyIJ0LhmhhBsQ==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="16278838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 01:41:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 01:41:02 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 15 Feb 2024 01:41:02 -0700
Date: Thu, 15 Feb 2024 09:41:01 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>
CC: <u.kleine-koenig@pengutronix.de>, <rmk+kernel@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <yuehaibing@huawei.com>,
	<vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: sparx5: Add spinlock for frame transmission
 from CPU
Message-ID: <20240215084101.bunwttvbsx4ecmad@DEN-DL-M31836.microchip.com>
References: <20240215083333.2139380-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240215083333.2139380-1-horatiu.vultur@microchip.com>

The 02/15/2024 09:33, Horatiu Vultur wrote:
> Both registers used when doing manual injection or fdma injection are
> shared between all the net devices of the switch. It was noticed that
> when having two process which each of them trying to inject frames on
> different ethernet ports, that the HW started to behave strange, by
> sending out more frames then expected. When doing fdma injection it is
> required to set the frame in the DCB and then make sure that the next
> pointer of the last DCB is invalid. But because there is no locks for
> this, then easily this pointer between the DCB can be broken and then it
> would create a loop of DCBs. And that means that the HW will
> continuously transmit these frames in a loop. Until the SW will break
> this loop.
> Therefore to fix this issue, add a spin lock for when accessing the
> registers for manual or fdma injection.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

Argh... I forgot to add the Fixes tag:
Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")

> ---
> v1->v2:
> - target net instead of net-next
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_main.c   | 1 +
>  drivers/net/ethernet/microchip/sparx5/sparx5_main.h   | 1 +
>  drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index d1f7fc8b1b71a..3c066b62e6894 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -757,6 +757,7 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, sparx5);
>  	sparx5->pdev = pdev;
>  	sparx5->dev = &pdev->dev;
> +	spin_lock_init(&sparx5->tx_lock);
>  
>  	/* Do switch core reset if available */
>  	reset = devm_reset_control_get_optional_shared(&pdev->dev, "switch");
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> index 6f565c0c0c3dc..316fed5f27355 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> @@ -280,6 +280,7 @@ struct sparx5 {
>  	int xtr_irq;
>  	/* Frame DMA */
>  	int fdma_irq;
> +	spinlock_t tx_lock; /* lock for frame transmission */
>  	struct sparx5_rx rx;
>  	struct sparx5_tx tx;
>  	/* PTP */
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> index 6db6ac6a3bbc2..ac7e1cffbcecf 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> @@ -244,10 +244,12 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  	skb_tx_timestamp(skb);
> +	spin_lock(&sparx5->tx_lock);
>  	if (sparx5->fdma_irq > 0)
>  		ret = sparx5_fdma_xmit(sparx5, ifh, skb);
>  	else
>  		ret = sparx5_inject(sparx5, ifh, skb, dev);
> +	spin_unlock(&sparx5->tx_lock);
>  
>  	if (ret == -EBUSY)
>  		goto busy;
> -- 
> 2.34.1
> 

-- 
/Horatiu

