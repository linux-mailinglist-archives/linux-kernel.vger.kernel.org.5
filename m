Return-Path: <linux-kernel+bounces-19544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F4826E99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4073A28334E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2045BF6;
	Mon,  8 Jan 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ72iHxx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997A44C8C;
	Mon,  8 Jan 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a271a28aeb4so167625666b.2;
        Mon, 08 Jan 2024 04:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704717287; x=1705322087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=InaA6S2R9U+w0dMzKJ26FvYihdPWx+aFSXWaCzGQox0=;
        b=JQ72iHxxYpci5xVG9jt9PjYzsrOR2fXpjLTLTKo1JkPdjfFAQQtCWAYF2AK698Wwi6
         POsQrDdDCUPBYpAFQut+eR0VUmp3qTvq9lZEf+WO2uBrBx4+GIDQpKacuF+ncCzc6h6i
         Ufbdp9SbCDRBwqCSqN4T6CZVBe5rM4J+C5sR930AYF08wfgWHWct0TM1FHsv97nnCaU2
         ozt8ZnxJ9bBR7doliVFib7z+9aSiema/dk/+pR0hzCDSq9ct6JSz+NDL4kRSAqMS+5N3
         xnnv6oYf6RlIFLuvYJ6/eAUE9vA7iQfLCo6OPoxhfLtWRdwEJfXas3AbkucJNdZZ03RF
         0txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717287; x=1705322087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InaA6S2R9U+w0dMzKJ26FvYihdPWx+aFSXWaCzGQox0=;
        b=Ab1JebeeJuoFPkWLmTnXzlZKSf41ADcElo/p1PWf1UA7gH8gfU57ZhRBJmbQ66B4Cq
         EV/RxitOuu3cfH8QgVKJi2xG8Ux0qgHrOSr3MjU7J+WxC2OteIYbS9jq8J6FweaGlhyx
         cYreaqBaBwOnnDHdiqEA7ohdHABmxliQBP4dQEbgSD9bz2bZlTjk385uahost8vz2f6p
         o0FhqFtzwE3PZcZw6fFbizMBO+2Vu3UPIetTGf6Qtgmj0BvqakE/KzJjlsI1mKzqSbJR
         PjFH5gunmS+gjFjDyR5+uM17/ZHcy5bk7RhFhKQf/Njs3pSEF+wjyZ7zeHz0X8ez3S23
         hWqg==
X-Gm-Message-State: AOJu0YxDGAG6lTDrOnr4YsQ0mBZNDI3SnKcynNneszUGXsAZpqO1xDgg
	FFCE6FtkbKw9eYxtFeu4nA8jgTgbEvSLqQ==
X-Google-Smtp-Source: AGHT+IGUddrnY5+YKbCei4noQYPHLM7BkRkB2zZCINU5UYnRktijbOTfd3LtC/AkKciXs9PFqbp8wQ==
X-Received: by 2002:a17:907:770c:b0:a28:e441:7998 with SMTP id kw12-20020a170907770c00b00a28e4417998mr1222461ejc.108.1704717287040;
        Mon, 08 Jan 2024 04:34:47 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b00a2a632e4eebsm1439209ejy.119.2024.01.08.04.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:34:46 -0800 (PST)
Date: Mon, 8 Jan 2024 14:34:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration
 of switch MDIO bus
Message-ID: <20240108123444.r3k4mhgii2yontc4@skbuf>
References: <20240106122142.235389-1-arinc.unal@arinc9.com>
 <20240107195241.GB132648@kernel.org>
 <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>
 <20240108110000.aujqhlufehngtkjj@skbuf>
 <20240106122142.235389-1-arinc.unal@arinc9.com>
 <20240107195241.GB132648@kernel.org>
 <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>
 <20240108110000.aujqhlufehngtkjj@skbuf>
 <7e89034c-afbd-4180-98e5-50d8cd07f924@arinc9.com>
 <7e89034c-afbd-4180-98e5-50d8cd07f924@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e89034c-afbd-4180-98e5-50d8cd07f924@arinc9.com>
 <7e89034c-afbd-4180-98e5-50d8cd07f924@arinc9.com>

On Mon, Jan 08, 2024 at 03:14:45PM +0300, Arınç ÜNAL wrote:
> I realised that I also miss these:
> 
> - run of_node_put(mnp) if bus = devm_mdiobus_alloc(dev) fails
> - don't run mt7530_free_mdio_irq if MDIO bus is described on OF
> 
> Please let me know if this addresses everything:
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 391c4dbdff42..cf2ff7680c15 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2146,24 +2146,40 @@ mt7530_free_irq_common(struct mt7530_priv *priv)
>  static void
>  mt7530_free_irq(struct mt7530_priv *priv)
>  {
> -	mt7530_free_mdio_irq(priv);
> +	struct device_node *mnp, *np = priv->dev->of_node;
> +
> +	mnp = of_get_child_by_name(np, "mdio");
> +	if (!mnp)
> +		mt7530_free_mdio_irq(priv);
> +	of_node_put(mnp);
> +
>  	mt7530_free_irq_common(priv);
>  }
>  static int
>  mt7530_setup_mdio(struct mt7530_priv *priv)
>  {
> +	struct device_node *mnp, *np = priv->dev->of_node;
>  	struct dsa_switch *ds = priv->ds;
>  	struct device *dev = priv->dev;
>  	struct mii_bus *bus;
>  	static int idx;
> -	int ret;
> +	int ret = 0;
> +
> +	mnp = of_get_child_by_name(np, "mdio");
> +
> +	if (mnp && !of_device_is_available(mnp))
> +		goto out;
>  	bus = devm_mdiobus_alloc(dev);
> -	if (!bus)
> -		return -ENOMEM;
> +	if (!bus) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (!mnp)
> +		ds->user_mii_bus = bus;
> -	ds->user_mii_bus = bus;
>  	bus->priv = priv;
>  	bus->name = KBUILD_MODNAME "-mii";
>  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> @@ -2174,16 +2190,18 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	bus->parent = dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;
> -	if (priv->irq)
> +	if (priv->irq && !mnp)
>  		mt7530_setup_mdio_irq(priv);
> -	ret = devm_mdiobus_register(dev, bus);
> +	ret = devm_of_mdiobus_register(dev, bus, mnp);
>  	if (ret) {
>  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
> -		if (priv->irq)
> +		if (priv->irq && !mnp)
>  			mt7530_free_mdio_irq(priv);
>  	}
> +out:
> +	of_node_put(mnp);
>  	return ret;
>  }

Looks ok.

Please note that net-next has now closed. Sorry that I couldn't bring
myself to review more during the weekend and the holidays.
https://lore.kernel.org/netdev/20240107172221.733a7a44@kernel.org/

