Return-Path: <linux-kernel+bounces-157075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0D8B0C89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F111F25A13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAC15ECC7;
	Wed, 24 Apr 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv+LpWMD"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626815D5CF;
	Wed, 24 Apr 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968997; cv=none; b=dwdxY3oVlnuF1bs/NlftwQDY8XnU1NO1i5JvOwjLW7LwKX8iFue9os9y1r+7mjgylAI09BdBNvw4C9RsBAN2B2KtqAORmsJnqqSo45thnCjuQkR8vBjP34G9Rmmn0sDoy2jMyIyQb8cUoiTY3QfoIcmgU4RrY1cOWMCpVSFc8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968997; c=relaxed/simple;
	bh=5VASxw1dn4Co6Whvp/wfFs/BmV+C01GmRrU1Zwyen5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci0EXedJ4Wumh59weGucd3NG1y1agYmM90z4Vv96IPrlLNSpf2y/zctypYDfrgQsQA1ihs3wvtQEhJPLSzQExJykzx8AwhexwNbmHNxxk9yVjuIlR6fFbkwICsvD0S3YJ9yWVM6yJM2MnbHL25Rl7X7K/aOtAYzH4ElDscDU2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv+LpWMD; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36b146836d7so26405155ab.3;
        Wed, 24 Apr 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713968995; x=1714573795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKrtiFG0UE+ikFKGmO4FtGR8vkeqkLcj1oUGJzlR1fw=;
        b=Iv+LpWMDu6ULRY9DYIco2k2RKam5ZL3FfqxgqSrtCJCf3qSniyvC8XPkfzSNWB1foo
         iBPS2+5Zu+e8gz1Sby3LOn8L045a9XlYWnBfbe5K6CABXdY5K3c1ZMj5LLiNTARKyvrF
         X5d+1kt0R3USmLdOeNzHYvd6zAuiEZGlHEthZG4Zk0lS+ksWIcVqLq8C/fzjnH0RMiiL
         rq01gzdW9dSMO9RkhA8i5elsdHOyNIZOps4OvFCfvNBGjXTJxsSazu04macG6IyulLrD
         7Zxu4CRrqEIi0ls4IUq12Y+6JmdZucfofdwKspFhb3kVz36j8m0wINtBvOfwi7rnwWkH
         4szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968995; x=1714573795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKrtiFG0UE+ikFKGmO4FtGR8vkeqkLcj1oUGJzlR1fw=;
        b=auauX2sitasu5hp7dWXCydm41nkOG4Fh11Pi3sMMIhwH+f0QgDkzNhlg5P4kWXNL23
         PlfETHa8gR8jmw/ml1msTdkD37vyeEyLALv5z1o9nGNt9RYn46KKJmNhQedOFiJXd+wr
         GRLvJPLKzAP8MzSEC39Lki2euan3Mdz44ZPFsJxTku2ctvhbsvgArlx+A+xRpGqUr4vR
         eSjU2+7+ugyx8HXyDyHj0Qr2qYXRhPHRHNX2i8jYfubSn6f8/yeJYTIbxDG44/Vt0oL7
         ytVQgIo+U+G9CCpmxNi29L+rajuxEolb1WLqx9CIRFojGehXHOipGaw+mwIDUWIgIIv2
         /XCw==
X-Forwarded-Encrypted: i=1; AJvYcCVvxkXF7M4X9G/zvO3nIf8l4ygY3ZhqDkxhdLhWcutaNOXEDPtepmSuCBoKlwxXlftoagnQmbdzYhk9k9/fCFnzSok59wHnrKJXErThkKqPrKbXt9gHCi70+5rJqVbzlpfltR6XrCXkKPgzDn6JGnci2HcOKsS2LgkdDmNbZh0Is2BoycptdnscJ2wb9G7iv0WpporTjg2La/d3XmKudicrUIhX
X-Gm-Message-State: AOJu0YzSy6RTKCFxy7m89p9igpe/KLeCniurbUn01eBFS5dropVnlmLi
	GAIUL3wRf3pWg+HECE776IVYUCHUYI1L2dA37qEeSRiqSShrCyM3
X-Google-Smtp-Source: AGHT+IH5nG+woSZE5slYDOLAGQomRFgwgnnIIYEPGWVZEfq0Lp6lq6bTwAH998gKRg6GsNujcv7Hgw==
X-Received: by 2002:a05:6e02:1568:b0:36c:b88:e492 with SMTP id k8-20020a056e02156800b0036c0b88e492mr2924351ilu.19.1713968994873;
        Wed, 24 Apr 2024 07:29:54 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id r13-20020a056638300d00b00482b12a0776sm4232950jak.27.2024.04.24.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:29:54 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:29:46 +0300
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
Subject: Re: [PATCH net-next v4 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Message-ID: <qf637dtkakxbumefbei3qrhbpyxgerjwn72ixp5xh6mc6yjbda@6z6tm6hk7fki>
References: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
 <20240424-rzn1-gmac1-v4-2-852a5f2ce0c0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-rzn1-gmac1-v4-2-852a5f2ce0c0@bootlin.com>

Hi Romain

On Wed, Apr 24, 2024 at 11:06:20AM +0200, Romain Gantois wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Introduce a mechanism whereby platforms can create their PCS instances
> prior to the network device being published to userspace, but after
> some of the core stmmac initialisation has been completed. This means
> that the data structures that platforms need will be available.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> [rgantois: removed second parameters of new callbacks]
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++++
>  include/linux/stmmac.h                            |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 59bf83904b62d..bee9c9ab31a88 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7200,6 +7200,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	if (ret)
>  		return ret;
>  
> +	if (priv->plat->pcs_init) {
> +		ret = priv->plat->pcs_init(priv);
> +		if (ret)
> +			return ret;
> +	}
> +

Once again. There is a ready-to-use stmmac_xpcs_setup() method. Which
is currently intended for the XPCS setups. Let's collect all the
PCS-related stuff in a single place there. That will make code cleaner
and easier to read. This was discussed on v3:

https://lore.kernel.org/netdev/42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf/

You agreed to do that, but just ignored in result. I'll repeat what I
said in v3:

On Tue, 16 Apr 2024 16:41:33 +0300, Serge Semin wrote:
> I am currently working on my Memory-mapped DW XPCS patchset cooking:
> https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com/
> The changes in this series seems to intersect to what is/will be
> introduced in my patchset. In particular as before I am going to
> use the "pcs-handle" property for getting the XPCS node. If so what
> about collecting PCS-related things in a single place. Like this:
>
> int stmmac_xpcs_setup(struct net_device *ndev)
> {
> 	...
> 
> 	if (priv->plat->pcs_init) {
> 		return priv->plat->pcs_init(priv); /* Romain' part */
> 	} else if (fwnode_property_present(priv->plat->port_node, "pcs-handle")) {
> 		/* My DW XPCS part */
> 	} else if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
> 		/* Currently implemented procedure */
> 	}
> 
> 	...
> }
>
> void stmmac_xpcs_clean(struct net_device *ndev)
> {
> 	...
> 
> 	if (priv->plat->pcs_exit) {
> 		priv->plat->pcs_exit(priv);
> 		return;
> 
> 	}
> 
> 	xpcs_destroy(priv->hw->xpcs);
> 	priv->hw->xpcs = NULL;
> }
> 
> Please see the last two patches in my series:
> https://lore.kernel.org/netdev/20231205103559.9605-16-fancer.lancer@gmail.com/
> https://lore.kernel.org/netdev/20231205103559.9605-17-fancer.lancer@gmail.com/
> as a reference of how the changes could be provided.

You replied it was a good idea, but the function names should be
renamed. That's not a problem. Just create a pre-requisite patch which
does that. So the patch in the subject could be replaced with four
subsequent patches:

1. Move the conditional XPCS-setup execution into the
stmmac_xpcs_setup() method. This change is partly implemented here
https://lore.kernel.org/netdev/20231205103559.9605-17-fancer.lancer@gmail.com/

2. Rename stmmac_xpcs_setup() method to just stmmac_pcs_setup() as a
preparation before adding the platform-specific PCS init()/exit()
callbacks.

3. Introduce the PCS-cleanup method. You can pick it up from here, but
use the stmmac_pcs_clean() name:
https://lore.kernel.org/netdev/20231205103559.9605-16-fancer.lancer@gmail.com/

4. Add pcc_init()/pcs_exit() callbacks as it's done in this patch but
call them in the stmmac_pcs_setup()/stmmac_pcs_clean() methods
instead of open-coding in the more generic
stmmac_hw_init()/stmmac_hw_exit() functions.

It doesn't look as that much hard thing to do, but will cause having a
better readable code by providing a single coherent function for all
PCS'es.

-Serge(y)

>  	/* Get the HW capability (new GMAC newer than 3.50a) */
>  	priv->hw_cap_support = stmmac_get_hw_features(priv);
>  	if (priv->hw_cap_support) {
> @@ -7282,6 +7288,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	return 0;
>  }
>  
> +static void stmmac_hw_exit(struct stmmac_priv *priv)
> +{
> +	if (priv->plat->pcs_exit)
> +		priv->plat->pcs_exit(priv);
> +}
> +
>
> [...]

