Return-Path: <linux-kernel+bounces-167009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB98BA35C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60372811D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D21CD15;
	Thu,  2 May 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs5tHHeh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071341B947;
	Thu,  2 May 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689331; cv=none; b=mdRs31SGAfjYFD9l/wI9fzbZSRThTivjdLmzvPeD8+9XU79Fb2iWRv4nHATp6k4v7fZe7Y31jlS+tc7aTS8l8gOqnvGHViEb98mn3eC5b9KjtCp8C48aZQ3dk3L5lEB/KOeHu9GS2KDPYOYVQivfXYPCDmSbTDfg4J1PyrcIHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689331; c=relaxed/simple;
	bh=nbBfbJyWw1EHyOJzEU6DhxA0SfnHoP9Tqo8l76+1JoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnS8ZJkJukvj+yvQ8oV/I6GYvL8/t/flFAukNxmaiS7BjFymgMa5ZbKvD6bzfXcdlD/r2wF+Vcdsgi0bSPIct3IQSAxDQdXJI40xmWqXXbIW7UNfjmgRyjNj68gRq8MmykYe8kCZH83EqghLg3n8fyfBXWGLAN70ACct+3vJSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs5tHHeh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e1fa824504so14676021fa.0;
        Thu, 02 May 2024 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714689328; x=1715294128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvheITl3IOmOnUb9pD5ukdBgjTFDZhV45ZiqqHS1lC8=;
        b=fs5tHHehKgb4pFPhqrYY8pMa8GMKCF8TeeN48DsCpMyTKaEYXZLXABX7hCFhyr+TxR
         ell+GlNDcBurTgpdo69GhQNDLTHz1ocWzwcQ2gVO4Jk4kz/fnyLNaUOjQjziEg3kp58g
         wzrAJGgD85VgzAwMRNFUvAZRNlQ5BnGIndjLFQMtId3YO4dD5WQ0ax1HI4r5V+gb53U7
         Mvt/cSxx4YgiHCPWbechynIZucJIjRHAHS1wcvTvNEA/ly6fCBLLENZKMTY7KGG8rlfd
         dYMQc5Zm735I8NIeBoE5IflSYiVGu0GBGPl871FlYrKAeymdHtF6eJIHIh22XxDlTonn
         TX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689328; x=1715294128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvheITl3IOmOnUb9pD5ukdBgjTFDZhV45ZiqqHS1lC8=;
        b=w21MtxCvaTVFHdJrCx7twiyEp2uH4+FyorgKwpxW77sEpM+3Nvabc9Z8cz+GIWvEwU
         QKlup8FsKmOrJQcHnda4pwglEwFYpBojQId8OR9qkERdrEjiv8T1e8WPTQt+CxZbWOq9
         Ge4SAQsnlyU3qcPkH0VwnhaqApHpL6OrNRF/Cilhx4MdSXvxgh0MeesxVjhOlV7I861F
         3DY5YdUdoG+bEv8xuJtJavHL8J6T9hhscna/aMnEK1F440ebvFFFf9KUwpfTiXUFlGTT
         UCJaBl+DIVGJupPPZp3IV5iAQAzFszxL1DDsZ6r4hhvKq3tWVH88Talc42jQE4VayfrG
         kyDw==
X-Forwarded-Encrypted: i=1; AJvYcCX/QwqjV1G9mrczbELKCDiBsLHh6C6gKoAoR2xEEGvUJjxPsE5qmcH4Wz/ThVKGeyuIhGNAFQdps6pfq3VaksS6GEW49iqONRUqhasBZu6DjWRo4BwQxgZMGgoZg9S3BiuP22xPMGcMOGF+HOggHvIQ8w1JiNHsf75CsMF83W9jyejG8Qm+2+elNi+jSrU7N2+83honeeHVWYcqLC2zTnMjMXZz
X-Gm-Message-State: AOJu0YwN2j7lSspBQlgBlkLIYFB6TVaTWPpC7QRxcyXk+OCrWEInlXxm
	H6e/U9Cm/I/U+GPjMIGRVpc9ekHad6aoI07lpjrZ8em3VM2TO9iD
X-Google-Smtp-Source: AGHT+IE+RRNfYrBA3kuTddhvlt5WggN/PhqusvrPB/Y3CSAEVYjC9nt3P4uZkm4BFPRlh+f+nPyCNQ==
X-Received: by 2002:a05:6512:4886:b0:51f:6132:2803 with SMTP id eq6-20020a056512488600b0051f61322803mr604261lfb.17.1714689327994;
        Thu, 02 May 2024 15:35:27 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id bi5-20020a0565120e8500b0051cb300265dsm320741lfb.109.2024.05.02.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:35:27 -0700 (PDT)
Date: Fri, 3 May 2024 01:35:25 +0300
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
	linux-arm-kernel@lists.infradead.org, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 4/7] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Message-ID: <jdqitzxy7lymkn2mizkvvycttxb4prxhevoqhwsatikceja5ph@sor2bnlaopre>
References: <20240430-rzn1-gmac1-v5-0-62f65a84f418@bootlin.com>
 <20240430-rzn1-gmac1-v5-4-62f65a84f418@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-rzn1-gmac1-v5-4-62f65a84f418@bootlin.com>

On Tue, Apr 30, 2024 at 09:29:44AM +0200, Romain Gantois wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Introduce a mechanism whereby platforms can create their PCS instances
> prior to the network device being published to userspace, but after
> some of the core stmmac initialisation has been completed. This means
> that the data structures that platforms need will be available.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Co-developed-by: Romain Gantois <romain.gantois@bootlin.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
>  include/linux/stmmac.h                            | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index af8ad9768da10..1c788caea0cfb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -505,7 +505,10 @@ int stmmac_pcs_setup(struct net_device *ndev)
>  	priv = netdev_priv(ndev);
>  	mode = priv->plat->phy_interface;
>  
> -	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
> +	if (priv->plat->pcs_init) {
> +		ret = priv->plat->pcs_init(priv);
> +	} else if (priv->plat->mdio_bus_data &&
> +		   priv->plat->mdio_bus_data->has_xpcs) {
>  		/* Try to probe the XPCS by scanning all addresses */
>  		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
>  			xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
> @@ -531,6 +534,9 @@ int stmmac_pcs_setup(struct net_device *ndev)
>  
>  void stmmac_pcs_clean(struct stmmac_priv *priv)
>  {
> +	if (priv->plat->pcs_exit)
> +		priv->plat->pcs_exit(priv);
> +
>  	if (!priv->hw->xpcs)
>  		return;
>  
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756a..4a24a246c617d 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -285,6 +285,8 @@ struct plat_stmmacenet_data {
>  	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
>  			   void *ctx);
>  	void (*dump_debug_regs)(void *priv);
> +	int (*pcs_init)(struct stmmac_priv *priv);
> +	void (*pcs_exit)(struct stmmac_priv *priv);
>  	void *bsp_priv;
>  	struct clk *stmmac_clk;
>  	struct clk *pclk;
> 
> -- 
> 2.44.0
> 

