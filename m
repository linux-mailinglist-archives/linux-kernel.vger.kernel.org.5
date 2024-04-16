Return-Path: <linux-kernel+bounces-146901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CF8A6CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129391F20F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931A12C53B;
	Tue, 16 Apr 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFL0eeVS"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD412C49C;
	Tue, 16 Apr 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274899; cv=none; b=LqF0eulw1+VeR23DXnqMJREI2QOxog1tSCxAAvBZuntn6X4TLk5dwxPE1n9uTWIW9V1DgbaFfWVYRc+msCNnT+gyQ0p1abmMCkllXROS+qJMUpbk0tdJ2sefv1r0x8iq/wHspg4fSBqJP69JUUuv+cRppHvd8i19qSiN+K8O9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274899; c=relaxed/simple;
	bh=YJJUfd4jr/wf+NqVzJgTp9ROozx0cPdT0Jm6mCpIowM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPkL7iR/AUfRCAAJhlKAxsBDPFrLm7Kvcso1Yg/GSLGRgX9RcbTkaOUGi4uBC6g0cN+2E41Q2EaXRK496x1/RC4fFhWnse226Diz1SJ3XvtDdaTfoNoE1UZC/PsDs2grEfL7pYYtFNWvCPVv3YC2WafTv3viUzbYGoQeJ8wAonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFL0eeVS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso47170281fa.2;
        Tue, 16 Apr 2024 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713274896; x=1713879696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nItft6gjoHuRS9giH3fTnlakGsKJ/3yHC4ii5RtOabA=;
        b=VFL0eeVSd5hNj0cvrj43YWm/gvODG+APGEE/IdUqyVAfomdhU1nkY97sbgf0mB8UIX
         Rs7Bx9mEra8BHP6ZDacW0T6eU+GG6o+tCTXqsBn/5k/u/v2XJ8dMW15vPQZM07OglqBD
         lMZV0Xm8JDheyqaQ8BmojSNGpokvbx7THK0FpRtOkh/E3L8m9/pYtdfQ/G99PulpoqE1
         VNbupvgzQrwljw9Ebuxpp70ppbAo8t7KNFAmLuqFzmlBjTHAOrFV9uYfTCU2RSaPc84v
         Bxj9E071xulChaNrjwHYTEVR6GtY76GSGQ5GN4KqSldOo0FsqhZfwngFhw4NSlrRN4ll
         2qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274896; x=1713879696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nItft6gjoHuRS9giH3fTnlakGsKJ/3yHC4ii5RtOabA=;
        b=W1h7tycgdX2FID+4gdhQJdyb0WdUuZgD4tIHoOnXyfb5CD9WSDWqJSWGBrWoGF/rMl
         IhmtNZEcORoCLNWhL4MIyykf1qVXOXoR0MSQG9KKgvC7CCVoqkSdO8zxiPj/GZMANi3t
         /GuVaXP0fag8ir4JUyd/kx5OencNsHK1o4KYdgexNzu4BeaRPnFbMJLCvQ6SsdxLdt+C
         KhQ6I98Z7CKLzWozTjlhrYcIiu3zSefk/whh7bmzHNfuIl1+fmYxWiSrH0/ybpB0Clt+
         5/NgHHSWG+OZjcmnbXQwihOaJKrjLuQO7lofqu86bWdE6ZgXmTzn5QUJFBsGt2Xa6uDJ
         e08Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOmuZO8p8MzKBoRgkzbcL8mUU+DbVOzx/eEYgAJlE7AtPVJ0FsLUAFIEycOLv2LOsGB5qT+YcuACmFRCBuwO9KEdEj1mp0OOlyV0OCjA+ZcS1GukzpNY2j9IdXYgG+/hNWh5it866JJnxy0E/9az1cAQ2DlC+OJfW3bnfiPNBw+vFJG7Va5orF++i9v6xv6NrOUe68vDEYGcai56fgQ3zrrx8L
X-Gm-Message-State: AOJu0Yzq1vQNC8VMk4lBy6DOqyge7IHlL3ewuy4BK29YXN1qEXvZWzei
	QUOO2WOj0nVsiDXt9+02PgOa2OjLhSF4mkI6fv5Wesa2MB7EejwN
X-Google-Smtp-Source: AGHT+IGy2KUFbhI6AaWFOmsemnnvP81uRkcNjM8jwXDSPhTQ3CP4mbDjx7oSLqi6TS3lljjR2AgDcg==
X-Received: by 2002:a05:651c:620:b0:2d9:f68a:d82c with SMTP id k32-20020a05651c062000b002d9f68ad82cmr7690751lje.41.1713274895863;
        Tue, 16 Apr 2024 06:41:35 -0700 (PDT)
Received: from mobilestation (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id x21-20020a05651c105500b002d893f9fc22sm1556573ljm.57.2024.04.16.06.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:41:35 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:41:33 +0300
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
Subject: Re: [PATCH net-next v3 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Message-ID: <42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com>
 <20240415-rzn1-gmac1-v3-2-ab12f2c4401d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-rzn1-gmac1-v3-2-ab12f2c4401d@bootlin.com>

Hi Romain, Russell

On Mon, Apr 15, 2024 at 11:18:42AM +0200, Romain Gantois wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Introduce a mechanism whereby platforms can create their PCS instances
> prior to the network device being published to userspace, but after
> some of the core stmmac initialisation has been completed. This means
> that the data structures that platforms need will be available.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++++
>  include/linux/stmmac.h                            |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index fe3498e86de9d..25fa33ae7017b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7208,6 +7208,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	if (ret)
>  		return ret;
>  
> +	if (priv->plat->pcs_init) {
> +		ret = priv->plat->pcs_init(priv, priv->hw);
> +		if (ret)
> +			return ret;
> +	}
> +

I am currently working on my Memory-mapped DW XPCS patchset cooking:
https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com/
The changes in this series seems to intersect to what is/will be
introduced in my patchset. In particular as before I am going to
use the "pcs-handle" property for getting the XPCS node. If so what
about collecting PCS-related things in a single place. Like this:

int stmmac_xpcs_setup(struct net_device *ndev)
{
	...

	if (priv->plat->pcs_init) {
		return priv->plat->pcs_init(priv); /* Romain' part */
	} else if (fwnode_property_present(priv->plat->port_node, "pcs-handle")) {
		/* My DW XPCS part */
	} else if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
		/* Currently implemented procedure */
	}

	...
}

void stmmac_xpcs_clean(struct net_device *ndev)
{
	...

	if (priv->plat->pcs_exit) {
		priv->plat->pcs_exit(priv);
		return;

	}

	xpcs_destroy(priv->hw->xpcs);
	priv->hw->xpcs = NULL;
}

Please see the last two patches in my series:
https://lore.kernel.org/netdev/20231205103559.9605-16-fancer.lancer@gmail.com/
https://lore.kernel.org/netdev/20231205103559.9605-17-fancer.lancer@gmail.com/
as a reference of how the changes could be provided.

-Serge(y)

>  	/* Get the HW capability (new GMAC newer than 3.50a) */
>  	priv->hw_cap_support = stmmac_get_hw_features(priv);
>  	if (priv->hw_cap_support) {
> @@ -7290,6 +7296,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	return 0;
>  }
>  
> +static void stmmac_hw_exit(struct stmmac_priv *priv)
> +{
> +	if (priv->plat->pcs_exit)
> +		priv->plat->pcs_exit(priv, priv->hw);
> +}
> +
>  static void stmmac_napi_add(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> @@ -7804,6 +7816,7 @@ int stmmac_dvr_probe(struct device *device,
>  	    priv->hw->pcs != STMMAC_PCS_RTBI)
>  		stmmac_mdio_unregister(ndev);
>  error_mdio_register:
> +	stmmac_hw_exit(priv);
>  	stmmac_napi_del(ndev);
>  error_hw_init:
>  	destroy_workqueue(priv->wq);
> @@ -7844,6 +7857,7 @@ void stmmac_dvr_remove(struct device *dev)
>  	if (priv->hw->pcs != STMMAC_PCS_TBI &&
>  	    priv->hw->pcs != STMMAC_PCS_RTBI)
>  		stmmac_mdio_unregister(ndev);
> +	stmmac_hw_exit(priv);
>  	destroy_workqueue(priv->wq);
>  	mutex_destroy(&priv->lock);
>  	bitmap_free(priv->af_xdp_zc_qps);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756a..941fde506e514 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -285,6 +285,8 @@ struct plat_stmmacenet_data {
>  	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
>  			   void *ctx);
>  	void (*dump_debug_regs)(void *priv);
> +	int (*pcs_init)(struct stmmac_priv *priv, struct mac_device_info *hw);
> +	void (*pcs_exit)(struct stmmac_priv *priv, struct mac_device_info *hw);
>  	void *bsp_priv;
>  	struct clk *stmmac_clk;
>  	struct clk *pclk;
> 
> -- 
> 2.44.0
> 
> 

