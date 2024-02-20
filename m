Return-Path: <linux-kernel+bounces-73122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239285BDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EB31C22F46
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E96BFD6;
	Tue, 20 Feb 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr9Oo1/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42B6A351;
	Tue, 20 Feb 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437318; cv=none; b=MSS783cWrFGip1Msd3LGb86g29HI3Mg3ijVZ8Kxow4jkyV0UQ30BuxaFqwO/eTk5lfFe+u7U9IVKb7ZNCoUuXBfQRxiI53ncAgF8d7AA78q6FbM3LNh3Joc73nKlFwWmCbcTtH+8lQrpvfzpNOqXPGkgk2LV9UneCwLiFw2fv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437318; c=relaxed/simple;
	bh=8YnGjvzKa113QUkH5s6sw06FvhJW/phsnrHheYilx8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSI8GUkE/qNuCOcjxRqD63Cj0fPc6DYV0idQ58P3vzto/RVdp9ExGgQxkkLHDsTm8uDrpB3bh3cOFqlK3Q2MPvE5GoiIaYXK8PXXh63q6h0IYsNRwCQFKV8Jd/HlQte3LTYyvT8OE6JpTvxKtXrMqtIq3p8/6xoysojjIyRhJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr9Oo1/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69139C433C7;
	Tue, 20 Feb 2024 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708437317;
	bh=8YnGjvzKa113QUkH5s6sw06FvhJW/phsnrHheYilx8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hr9Oo1/j4JEobgRky8HGIzxdyV4q3xownd5IQWW36y9N4d1D8PAGUv47/9RUt8JvD
	 5krmDY3Rt5Wks6psU1BSYZCjaNfQL3MBpTak2amSuE4CM4R95MRXubOg8bPX0x/4Ug
	 BQkY5xF3B91AdXuodd8nGjsLdCIoinY3J7P9JJTPR+u8GiBrkygDiBhExpIm9REd19
	 Td1bkmwV5PVknDul2hwkGmbsHMYvsYbTdB7BS6Q9CNlRVEOBMvQmzfAJU6RCN638io
	 cZa0F/mzqeCtT9DM6s9X+RG69H6iFFVSTYL354xPsAr0Q4AIwJKz2MZc8nDtZ0eAvk
	 DORZb/gj2YDXg==
Date: Tue, 20 Feb 2024 13:55:12 +0000
From: Simon Horman <horms@kernel.org>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Message-ID: <20240220135512.GN40273@kernel.org>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-net-v3-3-b68e5b75e765@outlook.com>

On Tue, Feb 20, 2024 at 03:57:38AM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Register the sub MDIO bus if it is found. Also implement the internal
> PHY reset procedure as needed.
> 
> Note it's unable to put the MDIO bus node outside of MAC controller
> (i.e. at the same level in the parent bus node). Because we need to
> control all clocks and resets in FEMAC driver due to the phy reset
> procedure. So the clocks can't be assigned to MDIO bus device, which is
> an essential resource for the MDIO bus to work.
> 
> No backward compatibility is maintained since the only existing
> user(Hi3516DV300) has not received any updates from HiSilicon for about
> 8 years already. And till today, no mainline dts for this SoC is found.
> It seems unlikely that there are still existing mainline Hi3516DV300
> users. The effort to maintain the old binding seems gain a little.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/net/ethernet/hisilicon/hisi_femac.c | 77 +++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c

..

> @@ -826,15 +844,34 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  						 priv->phy_reset_delays,
>  						 DELAYS_NUM);
>  		if (ret)
> -			goto out_disable_clk;
> +			goto out_free_netdev;
>  		hisi_femac_phy_reset(priv);
>  	}
>  
> +	// Register the optional MDIO bus
> +	for_each_available_child_of_node(node, mdio_np) {
> +		if (of_node_name_prefix(mdio_np, "mdio")) {
> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
> +			of_node_put(mdio_np);
> +			if (!priv->mdio_pdev) {
> +				dev_err(dev, "failed to register MDIO bus device\n");
> +				ret = -ENODEV;
> +				goto out_free_netdev;
> +			}
> +			mdio_registered = true;
> +			break;
> +		}
> +		of_node_put(mdio_np);

Sorry for not noticing this earlier.

I think that of_node_put() only needs to be called in the
case of terminating the loop (via break, goto, return, etc...).
But should not be called otherwise (when the loop cycles) as
for_each_available_child_of_node() calls of_node_put().

Flagged by Coccinelle.

> +	}
> +
> +	if (!mdio_registered)
> +		dev_warn(dev, "MDIO subnode not found. This is usually a bug.\n");
> +
>  	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>  	if (!phy) {
>  		dev_err(dev, "connect to PHY failed!\n");
>  		ret = -ENODEV;
> -		goto out_disable_clk;
> +		goto out_unregister_mdio_bus;
>  	}
>  
>  	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",

..

