Return-Path: <linux-kernel+bounces-98910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0668780F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700FC1F22F92
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C53341C9D;
	Mon, 11 Mar 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FCjhUJjY"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F841C75;
	Mon, 11 Mar 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165115; cv=none; b=RescJhxne2pyf5noKID8yVYVj7JD91SHftaZzXHU7aTxWNlDo3a417UWO3B/mwM2b5MP1ETofOFq5HBDuihQ45T0OtIW5AclgMP3rk8CD/jdhptnbWVeBV+/UoFQkwikF13MVEcsxOYeFzBTfwpLSbPM5HItDVE9Moq1qqQMUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165115; c=relaxed/simple;
	bh=fk8+pHNwZ+V+8pwYHpfe6hlSCZDViN8UYNJwkK5pIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7QQ6yAs+8tP55lJf+5t0stY9AmG6wtBBxByo5FEtX6OXOl4QR+ijB58tKEIzI2CUjSx97YfrW9eS/m97cPjC8rWpVVn3SbWRZkbbAuPYfA0gwibAudAMXJo75Ptyn6E3r01QaD5uIyQMVLpKImwVcVowlw/afBW90ct1G0hjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FCjhUJjY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F01160008;
	Mon, 11 Mar 2024 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710165105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqvBp7CTjNGNq3lMlyQxO2tIzGlpj4RvXf7GeO4YvHI=;
	b=FCjhUJjYOsF7o6Jhz1pQAUlOve06jtPRI2fntcRFQib57uk4O0EB4Z/CglfIikkxVE3n36
	d7dPrWLhsQUtFQv3SMXP+OaUKe+zOOjLmTx/j4/479JILNcx2IH2GE2Jkiap444Qhgec83
	SeB9i01Ba7IFvYq9L+IhaqHpCZvaAXahfddUkn+nftyciIdk/bVDlAmcknKd/+mTeIT7tu
	0XU9sp6r6m17WlWaviKMvaEVFwEWV4h6j/e85A7r0VKWkN1zI99GDsb5m+25w+AbJNex6D
	Ybh9Frhz+vfRTwshaSfudbJ/6UUoI+BijEgHdQiWT98ykGl/acXo0T8LNGdiRw==
Date: Mon, 11 Mar 2024 14:51:43 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: thomas.perrot@bootlin.com
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: macb: remove change_mtu callback
Message-ID: <20240311145143.2d0e492a@device-28.home>
In-Reply-To: <20240311091211.720789-1-thomas.perrot@bootlin.com>
References: <20240311091211.720789-1-thomas.perrot@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Thomas,

On Mon, 11 Mar 2024 10:12:11 +0100
thomas.perrot@bootlin.com wrote:

> Subject: [PATCH v2] net: macb: remove change_mtu callback

You need to specify in the subject whether this patch targets net (for
bug fixes, in which case you need a Fixes: tag) or net-next for new
features/improvements.

You can use this parameter in your git format-patch command to have it
set properly :

--subject-prefix="PATCH net-next" (or net)

Thanks,

Maxime

> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> Because it doesn't allow MTU changes when the interface is up, although
> it is not necessary.
> 
> This callback has been added to add in a first implementation of the Jumbo
> support [1],since it has been reworked and moved to the probe [2].
> 
> With this patch the core will set the MTU, regardless of if the interface
> is up or not.
> 
> [1] commit a5898ea09aad ("net: macb: Add change_mtu callback with
>     jumbo support")
> [2] commit 44770e1180de ("ethernet: use core min/max MTU checking")
> 
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
> 
> Changes since v2:
>  - Update the commit message.
> 
>  drivers/net/ethernet/cadence/macb_main.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 898debfd4db3..0532215e5236 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3017,16 +3017,6 @@ static int macb_close(struct net_device *dev)
>  	return 0;
>  }
> 
> -static int macb_change_mtu(struct net_device *dev, int new_mtu)
> -{
> -	if (netif_running(dev))
> -		return -EBUSY;
> -
> -	dev->mtu = new_mtu;
> -
> -	return 0;
> -}
> -
>  static int macb_set_mac_addr(struct net_device *dev, void *addr)
>  {
>  	int err;
> @@ -3897,7 +3887,6 @@ static const struct net_device_ops macb_netdev_ops = {
>  	.ndo_get_stats		= macb_get_stats,
>  	.ndo_eth_ioctl		= macb_ioctl,
>  	.ndo_validate_addr	= eth_validate_addr,
> -	.ndo_change_mtu		= macb_change_mtu,
>  	.ndo_set_mac_address	= macb_set_mac_addr,
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  	.ndo_poll_controller	= macb_poll_controller,
> --
> 2.44.0
> 


