Return-Path: <linux-kernel+bounces-123586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC9890B60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59801F2778D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E813A258;
	Thu, 28 Mar 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqyQfO1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76FB3224;
	Thu, 28 Mar 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658073; cv=none; b=m8dTzHkxnFyfX7WoDUWQ0m0fKMndEH1iCh9l+TOs6awEhz4QvDyrIQ8zoFP4lu2/S3pPtCGtkYH4v0bgUZHO+KUOYtd4iMH8g+Feexo9n607Lkn3nMmbPl28tzfQ7SYX2y+1ZTxYBPuJm2R/CRBi8LkhhYHgCBOJEFDuebIjEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658073; c=relaxed/simple;
	bh=PNbWtH6pb1bFU8mR75ZCza2MSEsYFINscoc85iE3ivM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqbimiozqkTbVMqvt6FJHN429u0gRg37CnxlhI4ABlPFegELkA+1XztbtNuILbNwnbtRQyZJ77cVS8Hr0bI5hokuBWh058Bk5WSP2t5+Zt1G+5SRam0xcMqXZqpin9uoCSA3ZIcuDThBGjla0SxJ8ucQhee4XnfSgKLkQqFC7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqyQfO1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5468CC433C7;
	Thu, 28 Mar 2024 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658073;
	bh=PNbWtH6pb1bFU8mR75ZCza2MSEsYFINscoc85iE3ivM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqyQfO1b26epdd/+5n8N7eLLOrgVkfDQyn4sz+V8MLUGXxXLMXbOC8Ug7n3SOBGGU
	 QDBOIkLaYEhsmsfrt1g4o95UCTGblkOakcQERPyQ5HqlQ4s7cMDJIU09Aa7ICrBFxW
	 9ifYIlblCISyxVkl5wDd2k6Eh8FENilnKRYIhxl7HlfTD5vyicDngXl+9Z3S5lZAJX
	 6uqGuYJueM3Vxe+5dSewnuRiuqgNNbkoKwbJxit5MoSgrenHic7iYWA+D/OwXbzM9Q
	 Yd9+a0tOeaJHMwa+k7jAo2oX4mTejQyPsnZOgIeg3PAc6PVJBz3z6gJzXapKuYnae8
	 zly2t5zeyttWQ==
Date: Thu, 28 Mar 2024 20:34:29 +0000
From: Simon Horman <horms@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v9 17/38] net: cirrus: add DT support for Cirrus EP93xx
Message-ID: <20240328203429.GK651713@kernel.org>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-17-156e2ae5dfc8@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-ep93xx-v9-17-156e2ae5dfc8@maquefel.me>

On Tue, Mar 26, 2024 at 12:18:44PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - add OF ID match table
> - get phy_id from the device tree, as part of mdio
> - copy_addr is now always used, as there is no SoC/board that aren't
> - dropped platform header
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/net/ethernet/cirrus/ep93xx_eth.c | 63 ++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> index 1f495cfd7959..2523d9c9d1b8 100644
> --- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
> +++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> @@ -16,13 +16,12 @@
>  #include <linux/ethtool.h>
>  #include <linux/interrupt.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  
> -#include <linux/platform_data/eth-ep93xx.h>
> -
>  #define DRV_MODULE_NAME		"ep93xx-eth"
>  
>  #define RX_QUEUE_ENTRIES	64
> @@ -738,25 +737,6 @@ static const struct net_device_ops ep93xx_netdev_ops = {
>  	.ndo_set_mac_address	= eth_mac_addr,
>  };
>  
> -static struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
> -{
> -	struct net_device *dev;
> -
> -	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
> -	if (dev == NULL)
> -		return NULL;
> -
> -	eth_hw_addr_set(dev, data->dev_addr);
> -
> -	dev->ethtool_ops = &ep93xx_ethtool_ops;
> -	dev->netdev_ops = &ep93xx_netdev_ops;
> -
> -	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
> -
> -	return dev;
> -}
> -
> -
>  static void ep93xx_eth_remove(struct platform_device *pdev)
>  {
>  	struct net_device *dev;
> @@ -786,27 +766,47 @@ static void ep93xx_eth_remove(struct platform_device *pdev)
>  
>  static int ep93xx_eth_probe(struct platform_device *pdev)
>  {
> -	struct ep93xx_eth_data *data;
>  	struct net_device *dev;
>  	struct ep93xx_priv *ep;
>  	struct resource *mem;
> +	void __iomem *base_addr;
> +	struct device_node *np;
> +	u32 phy_id;
>  	int irq;
>  	int err;

Please consider preserving reverse xmas tree order - longest line to
shortest, for local variables in Networking code.

>  
>  	if (pdev == NULL)
>  		return -ENODEV;
> -	data = dev_get_platdata(&pdev->dev);
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (!mem || irq < 0)
>  		return -ENXIO;
>  
> -	dev = ep93xx_dev_alloc(data);
> +	base_addr = ioremap(mem->start, resource_size(mem));
> +	if (!base_addr)
> +		return dev_err_probe(&pdev->dev, -EIO, "Failed to ioremap ethernet registers\n");
> +
> +	np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> +	if (!np)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Please provide \"phy-handle\"\n");

This function, not entirely due to this patch, seems to leak
resources in error paths.

F.e., here base_addr is not unmapped and mem->start is not released.

I expect that to resolve this problem it would be best to move
to idiomatic error handling by:

* using a ladder of goto labels in ep93xx_eth_probe(); and
* as a clean up, remove the conditions from ep93xx_eth_remove.

> +
> +	err = of_property_read_u32(np, "reg", &phy_id);
> +	of_node_put(np);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, -ENOENT, "Failed to locate \"phy_id\"\n");
> +
> +	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
>  	if (dev == NULL) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
> +
> +	eth_hw_addr_set(dev, base_addr + 0x50);

This doesn't look right.

eth_hw_addr_set() expects it's second argument to
be a char * which represents an Ethernet address.
But the type of base_addr + 0x50 is __iomem *.

I suspect that you need some construction based on readb/readw/readl
to copy the Ethernet address from io memory into a buffer,
taking into account endiness and possibly taking into account
unaligned access.

Also, it would be good a descriptively named #define in place of 0x50.

> +	dev->ethtool_ops = &ep93xx_ethtool_ops;
> +	dev->netdev_ops = &ep93xx_netdev_ops;
> +	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
> +
>  	ep = netdev_priv(dev);
>  	ep->dev = dev;
>  	SET_NETDEV_DEV(dev, &pdev->dev);

..

