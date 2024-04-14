Return-Path: <linux-kernel+bounces-143952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871758A4003
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DE81C21170
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951B17721;
	Sun, 14 Apr 2024 03:22:47 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E728E2;
	Sun, 14 Apr 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713064967; cv=none; b=bHeMfKf82VicFJ5L3wHOcJqkbM+vvJTguotfutP/NBJhdTV6VvmDCsQbHHV+jRcV3pCPIJaJt4dQC+R8zZDQcQCZoeObE/eL2Y+tNaEGu7V4LQDG5+lud9aaBggqXMQDMVjOal+xDATFHhzgsyRDNvmEL5CraZoqanPLh7cI8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713064967; c=relaxed/simple;
	bh=i7V0IVdjZPKh2lZW+Jfn2T/gp7NnIxL5lWxJPEsEsZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnGqMU9y1Fsy4LDXjQ39MOW9dgxOhHnnKUZ/bMuW676Sz8zGdFyZQrlNykqKDhF25OFY7GojO1EwkeL6fdONW6JNKIWziGsPo/eQRmMFHKR6sinwVlKgxZ7LDIQoiclH5P1017XsV2JErOeKGifTFgSMg7vHw9pJ58MiLsqtcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rvqRu-0001As-32;
	Sun, 14 Apr 2024 03:22:35 +0000
Date: Sun, 14 Apr 2024 04:22:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: simplify core operations
Message-ID: <ZhtL9zAO83HJb_Jq@makrotopia.org>
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-0-b08936df2770@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-2-b08936df2770@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-2-b08936df2770@arinc9.com>

On Sun, Apr 14, 2024 at 01:08:20AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The core_rmw() function calls core_read_mmd_indirect() to read the
> requested register, and then calls core_write_mmd_indirect() to write the
> requested value to the register. Because Clause 22 is used to access Clause
> 45 registers, some operations on core_write_mmd_indirect() are
> unnecessarily run. Get rid of core_read_mmd_indirect() and
> core_write_mmd_indirect(), and run only the necessary operations on
> core_write() and core_rmw().
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/dsa/mt7530.c | 108 +++++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index fefa6dd151fa..2650eacf87a7 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -74,116 +74,94 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
>  	MIB_DESC(1, 0xb8, "RxArlDrop"),
>  };
>  
> -/* Since phy_device has not yet been created and
> - * phy_{read,write}_mmd_indirect is not available, we provide our own
> - * core_{read,write}_mmd_indirect with core_{clear,write,set} wrappers
> - * to complete this function.
> - */
> -static int
> -core_read_mmd_indirect(struct mt7530_priv *priv, int prtad, int devad)
> +static void
> +mt7530_mutex_lock(struct mt7530_priv *priv)
> +{
> +	if (priv->bus)
> +		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +}
> +
> +static void
> +mt7530_mutex_unlock(struct mt7530_priv *priv)
> +{
> +	if (priv->bus)
> +		mutex_unlock(&priv->bus->mdio_lock);
> +}
> +
> +static void
> +core_write(struct mt7530_priv *priv, u32 reg, u32 val)
>  {
>  	struct mii_bus *bus = priv->bus;
> -	int value, ret;
> +	int ret;
> +
> +	mt7530_mutex_lock(priv);
>  
>  	/* Write the desired MMD Devad */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_CTRL, devad);
> +			 MII_MMD_CTRL, MDIO_MMD_VEND2);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Write the desired MMD register address */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_DATA, prtad);
> +			 MII_MMD_DATA, reg);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Select the Function : DATA with no post increment */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_CTRL, devad | MII_MMD_CTRL_NOINCR);
> +			 MII_MMD_CTRL, MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
>  	if (ret < 0)
>  		goto err;
>  
> -	/* Read the content of the MMD's selected register */
> -	value = bus->read(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			  MII_MMD_DATA);
> -
> -	return value;
> +	/* Write the data into MMD's selected register */
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_DATA, val);
>  err:
> -	dev_err(&bus->dev,  "failed to read mmd register\n");
> +	if (ret < 0)
> +		dev_err(&bus->dev, "failed to write mmd register\n");
>  
> -	return ret;
> +	mt7530_mutex_unlock(priv);
>  }
>  
> -static int
> -core_write_mmd_indirect(struct mt7530_priv *priv, int prtad,
> -			int devad, u32 data)
> +static void
> +core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
>  {
>  	struct mii_bus *bus = priv->bus;
> +	u32 val;
>  	int ret;
>  
> +	mt7530_mutex_lock(priv);
> +
>  	/* Write the desired MMD Devad */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_CTRL, devad);
> +			 MII_MMD_CTRL, MDIO_MMD_VEND2);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Write the desired MMD register address */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_DATA, prtad);
> +			 MII_MMD_DATA, reg);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Select the Function : DATA with no post increment */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_CTRL, devad | MII_MMD_CTRL_NOINCR);
> +			 MII_MMD_CTRL, MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
>  	if (ret < 0)
>  		goto err;
>  
> +	/* Read the content of the MMD's selected register */
> +	val = bus->read(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			MII_MMD_DATA);
> +	val &= ~mask;
> +	val |= set;
>  	/* Write the data into MMD's selected register */
>  	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> -			 MII_MMD_DATA, data);
> +			 MII_MMD_DATA, val);
>  err:
>  	if (ret < 0)
> -		dev_err(&bus->dev,
> -			"failed to write mmd register\n");
> -	return ret;
> -}
> -
> -static void
> -mt7530_mutex_lock(struct mt7530_priv *priv)
> -{
> -	if (priv->bus)
> -		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> -}
> -
> -static void
> -mt7530_mutex_unlock(struct mt7530_priv *priv)
> -{
> -	if (priv->bus)
> -		mutex_unlock(&priv->bus->mdio_lock);
> -}
> -
> -static void
> -core_write(struct mt7530_priv *priv, u32 reg, u32 val)
> -{
> -	mt7530_mutex_lock(priv);
> -
> -	core_write_mmd_indirect(priv, reg, MDIO_MMD_VEND2, val);
> -
> -	mt7530_mutex_unlock(priv);
> -}
> -
> -static void
> -core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
> -{
> -	u32 val;
> -
> -	mt7530_mutex_lock(priv);
> -
> -	val = core_read_mmd_indirect(priv, reg, MDIO_MMD_VEND2);
> -	val &= ~mask;
> -	val |= set;
> -	core_write_mmd_indirect(priv, reg, MDIO_MMD_VEND2, val);
> +		dev_err(&bus->dev, "failed to write mmd register\n");
>  
>  	mt7530_mutex_unlock(priv);
>  }
> 
> -- 
> 2.40.1
> 
> 

