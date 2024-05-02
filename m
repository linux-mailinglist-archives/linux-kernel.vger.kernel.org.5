Return-Path: <linux-kernel+bounces-167006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9C8BA351
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487531F219B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25121171E71;
	Thu,  2 May 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRfn4VTs"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C72C1A5;
	Thu,  2 May 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689230; cv=none; b=aBRI48WsGZvkmKKbF0LvC3ivsYTg8kM1QOwUGfDq9Tp4y3Cwk+34rGB/NseD/HAN8ELlMcZWTn6hgCmszvC2nZklo3t6Ja9ui0MLRGyLcLXl6Z7dB1RL6POxG8JM0xX4/9i/pqw8GZMi4dkrWZruGkq0DsK2wNrzoR6tSpJn99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689230; c=relaxed/simple;
	bh=Un8DsDqzrcHTNchH+A46k/QnEWFZlX9cICUVd/GwMe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTV1skRFI/VgQP/n+X0xDAX04ndtPnDT6elHPMGtjizFyjkEtagxC2TbHxXHfzBoVYSAIYCO9prsV/oepFosVTowGt//Ilec4xMCBcDp6PbxcXQXy44Ky8SXc/UjiXJR+i4RkNSsNQ9ZY9XJFy1uroAlCSPUdjT42PRyBXqjEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRfn4VTs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f174e316eso1492043e87.0;
        Thu, 02 May 2024 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714689227; x=1715294027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuymcIiJPiemZlanqz0KZDKUioJ+R0OZ4+MGq8AhvEg=;
        b=KRfn4VTsHPB45VOMZIVR1+JVg6aM2/EbXf5WUL8TvHNNTD6N0xfwGmvl/FF+rhuU13
         AZ1BUFO85qyniai1+jlaPu4U7So54cy17+N0FpDJKcKARh6Bkx7TiHFiS94rizi8TQjX
         4jFqntMw5KKq0X8HZnEa/OFiCGYbFTSGYm6lt+SGqtM8E0xEMo+MnnYiEonS3Qx5NhKp
         DQOLEUZYR8Qr44TYRmZIiL3vSMFyme/WVmhZVRBJBZcmNk0cMpyy7/PPaaTZobgshYMr
         Hw3o6MXV8H3R7lULoH+sb1chS4w1eKDneXIoYnFdTi9WDQA7A+cZqNsy3kZqoBLFE7LQ
         0sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689227; x=1715294027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuymcIiJPiemZlanqz0KZDKUioJ+R0OZ4+MGq8AhvEg=;
        b=dl5Ars9uGmmwd6MB44e3+x/urKdu58SQdqrHMYowcsv27590m91rnuaXfyHwj4+KBi
         WRZkvQMGXX8ClbvVUhfsvuX7mlTVkhuLEpseMSw1hdR3tD6804/CjoFxLbDU6t7MDeiE
         FNqTM2TJ4RbRwQd+pFbb4MHSd/4eZHn0rG1utOLpGUvohjQRz6hG+PSGN+aDSuV6Kxvb
         K6mywzapittwTHJXOF6X5aZw4leYSNX2/t1DglJNQTBu6ewwAZWR82ANqZO/ptQ+PkP0
         VvECkFBkr0Yur+AMsc9nLLKqE8RSNACDHHbPuQXmae5hma1AOMhugfgLgYm5xHIKXxIw
         O+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU9wKzCo1928ctX8YrWCVvMvhcyU8PznmnprTnr6XYCwcj2LE795uXwSGoH+G2bamjF0Qv4z3kB4+IpPKT3J7275oMwxp4DNm+SPu/WJnzUr8XBN2vyCu/s83DUEwCyDR/VD3wS4YSufBbrLYGjWiUMrcLP1O30bCrPbJAHrATYKrUuOohno8qEx2u0x5J5Gv2n/nr3GKVYJgYNkmJsUoW9pFIl
X-Gm-Message-State: AOJu0Yz8CmQIXTbBN6KwMFoUg3A8kNnG+vdf9pBnvHapswEjtcs2qFCH
	qi9c4HOhEqWWFxb6NeLZUVgttXqv7d3iNc/BD75mcLC2901JZJLH
X-Google-Smtp-Source: AGHT+IGbFfFzXlP47A82vaBo8QSPa7wJ1Xkts6SMGSKXY0Bak5fwBUFDwrThIgMWZJyGR0yaLaiBOQ==
X-Received: by 2002:ac2:4d97:0:b0:519:2c84:2405 with SMTP id g23-20020ac24d97000000b005192c842405mr643387lfe.44.1714689226346;
        Thu, 02 May 2024 15:33:46 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id y13-20020a19914d000000b0051b59171ba9sm327335lfj.96.2024.05.02.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:45 -0700 (PDT)
Date: Fri, 3 May 2024 01:33:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 2/7] net: stmmac: Add dedicated XPCS cleanup
 method
Message-ID: <4wdcmcb2yxneynxtppestl6cp25z5xge3hfv7o47bxwpafn4cg@mtvc3ls2cxij>
References: <20240430-rzn1-gmac1-v5-0-62f65a84f418@bootlin.com>
 <20240430-rzn1-gmac1-v5-2-62f65a84f418@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-rzn1-gmac1-v5-2-62f65a84f418@bootlin.com>

Hi Romain

On Tue, Apr 30, 2024 at 09:29:42AM +0200, Romain Gantois wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Currently the XPCS handler destruction is performed in the
> stmmac_mdio_unregister() method. It doesn't look good because the handler
> isn't originally created in the corresponding protagonist
> stmmac_mdio_unregister(), but in the stmmac_xpcs_setup() function. In
> order to have more coherent MDIO and XPCS setup/cleanup procedures,
> let's move the DW XPCS destruction to the dedicated stmmac_pcs_clean()
> method.
> 
> This method will also be used to cleanup PCS hardware using the
> pcs_exit() callback that will be introduced to stmmac in a subsequent
> patch.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Co-developed-by: Romain Gantois <romain.gantois@bootlin.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 12 +++++++++---
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index dddcaa9220cc3..7e0d727ed795b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -361,6 +361,7 @@ int stmmac_mdio_unregister(struct net_device *ndev);
>  int stmmac_mdio_register(struct net_device *ndev);
>  int stmmac_mdio_reset(struct mii_bus *mii);
>  int stmmac_xpcs_setup(struct mii_bus *mii);
> +void stmmac_pcs_clean(struct stmmac_priv *priv);
>  void stmmac_set_ethtool_ops(struct net_device *netdev);
>  
>  int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 59bf83904b62d..2a55c5d07f6b8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7789,8 +7789,9 @@ int stmmac_dvr_probe(struct device *device,
>  
>  error_netdev_register:
>  	phylink_destroy(priv->phylink);
> -error_xpcs_setup:
>  error_phy_setup:
> +	stmmac_pcs_clean(priv);
> +error_xpcs_setup:
>  	if (priv->hw->pcs != STMMAC_PCS_TBI &&
>  	    priv->hw->pcs != STMMAC_PCS_RTBI)
>  		stmmac_mdio_unregister(ndev);
> @@ -7832,6 +7833,9 @@ void stmmac_dvr_remove(struct device *dev)
>  	if (priv->plat->stmmac_rst)
>  		reset_control_assert(priv->plat->stmmac_rst);
>  	reset_control_assert(priv->plat->stmmac_ahb_rst);
> +
> +	stmmac_pcs_clean(priv);
> +
>  	if (priv->hw->pcs != STMMAC_PCS_TBI &&
>  	    priv->hw->pcs != STMMAC_PCS_RTBI)
>  		stmmac_mdio_unregister(ndev);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 0542cfd1817e6..508bd39cbe2b3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -523,6 +523,15 @@ int stmmac_xpcs_setup(struct mii_bus *bus)
>  	return 0;
>  }
>  

> +void stmmac_pcs_clean(struct stmmac_priv *priv)

Ideally it would have been great to have the entire driver fixed to
accept the stmmac_priv pointer as the functions argument. But this
would be too tiresome. Anyway seeing the PCS-setup protagonist method
has the net_device pointer passed I would implement the same prototype
for the antagonist even though it would require an additional local
variable. That will make the MDIO and PCS local interface-functions
looking alike and as if unified. That is the reason of why I made
stmmac_xpcs_clean() accepting the net_device pointer. 

Alternatively both stmmac_pcs_setup() and stmmac_pcs_clean() could be
converted to just accepting a pointer to the stmmac_priv instance.

-Serge(y)

> +{
> +	if (!priv->hw->xpcs)
> +		return;
> +
> +	xpcs_destroy(priv->hw->xpcs);
> +	priv->hw->xpcs = NULL;
> +}
> +
>  /**
>   * stmmac_mdio_register
>   * @ndev: net device structure
> @@ -679,9 +688,6 @@ int stmmac_mdio_unregister(struct net_device *ndev)
>  	if (!priv->mii)
>  		return 0;
>  
> -	if (priv->hw->xpcs)
> -		xpcs_destroy(priv->hw->xpcs);
> -
>  	mdiobus_unregister(priv->mii);
>  	priv->mii->priv = NULL;
>  	mdiobus_free(priv->mii);
> 
> -- 
> 2.44.0
> 

