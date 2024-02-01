Return-Path: <linux-kernel+bounces-48955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0D846399
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801011C258F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015141236;
	Thu,  1 Feb 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfVCH8Ee"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A841208;
	Thu,  1 Feb 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827522; cv=none; b=PQ1edMt3HLvTasSLD4t9F25mqGtEDnqQFRRh8Ndp4J9lMa5DZG9/ZPUeI/1bcCS/k3kEexaS+KiW4Yz4DXquvLQSDz38kKEtqMVDKfbPsFqHVhouf2QD2dJQ8RggQNP3Y9QkKklcfcI312iGQ8YsXfi3ZkcVJcvoXus8kxgR0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827522; c=relaxed/simple;
	bh=MTnSrMq8i1x++ESn+SIH1QLN42cjYh/PlfT7IxAwwC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oABoTQQ90as1xFJ/oVdR4Q9F+aFCL0j2SlAXTp6BNd/GJYfZfeKSzSQ0yuvA7DqAyKcO71M2M3gKMHlbSe2dPichUcK4h2eZbg/RLM/uY+wykO78tXBNOene8g4n9VtU84dEzXQ5hmYguV16vBh3SpFSVIhEebrdlw8F5yaUAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfVCH8Ee; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so1891660a12.1;
        Thu, 01 Feb 2024 14:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706827519; x=1707432319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fGYdKfwHRpUOUYn273X9Mhr4fH/tkJBZxTmCbsLDgg=;
        b=UfVCH8EeIEhkrpMfeTfeTqpdHlxzSp7CUXq6Vo34t9osNcRUFiid6axY00xrCmrAD+
         XaVLb/XKtsxeJ61dqrw2aM4em3qlqFpOxn9yZ0XdAPIB9kQT4sCcCPp1D4Ts0XuRlA1L
         q3TrKr6WxSCp6vTg3j6sK436xcboF6ClygXe6O8rYd+GI/T8/AsCf+E70cKmJL3ONyAQ
         ISbGeeDbxznaVWxpo4Pztf+lQTztNkgMuBCN1MPS91dprsm9p6lQQ9JJqqu8tNueeJSr
         n+GIrydYcRK8LabUVEgDg7wNKqErQg/QvB0aa27NfK3SBmnEAQ7QxB/YaCdfv1Uc2XZC
         wXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706827519; x=1707432319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fGYdKfwHRpUOUYn273X9Mhr4fH/tkJBZxTmCbsLDgg=;
        b=agB0g32ei63XodOZpoRLgemElaUm+Ww1r7Uic4iFzD6ffZ/TytNYePlJylav2SK5cc
         bbYXyd9kXFEHZ/wwJTgJYYXNKblz1nKFDXhVoilsBO7bxqLxDo/B0+ltNsyzD7LPpzIq
         bjLCPKwkZW0dNXCj15haKolLCaVRHLBN6PfuC4WBRCOc+ua+GBNw3ydbGMnjuPlRAwt9
         IcBhhaA8o93MfUDwi2YIgnJFcur7RDEVAeXpZI9QqxbSmZ9IihPm0RgqQHCTfD3Ua70t
         aYoupzmIB6fTvwntpKRQba5zeiywYj9MwGxLGWFXmlJCB/VBr3JbEzi8xUo+H4YUq07R
         9Udg==
X-Gm-Message-State: AOJu0YyQxcm1QcTLuQI6UkXfplYRwMXd0F+Nh5JApIDsPL4pkPSg06wU
	9khutpUwnjHUHCJqc7ew/MtyQMWfdSgT/vQyWCc/YY0MD8e39vYZ
X-Google-Smtp-Source: AGHT+IHrRG6KdcJoOWJ0ti2YqgpNxWeeibbNcSidMyvWTpFC/vNgQCl+H7ng+V7cQGc6eT8gxBX8Sw==
X-Received: by 2002:a05:6402:160c:b0:55f:d80a:d641 with SMTP id f12-20020a056402160c00b0055fd80ad641mr1032641edv.9.1706827519072;
        Thu, 01 Feb 2024 14:45:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGsDSrtt8pCql64mwXFDMszUWKQdycnC6Oy2HR18d0q9+zQrrd8ZhC8Gt35m3zcdraLS5ZNNE9HD5oVwtmEcGG/I3bbOO4qBBeEuHwh4BAhsfharD0holKKSm2i3FWREjVc9LSs7jzno409WhAZ2dYpvljPiqkWjUuvIaNcr9rIf7r5auQ2nTQU7WBNRrOt/n6kGDG55468oc4Qa7uYH5Ag+KMR78xYjZDYVt1b7Yn0xHLmzMB6cqRvo6qKiobUECllz2Q3vkzRXc+VjnzAtwrjXfDe/tjXU2yrltKqwfT204kkhzW3j3jgYoCVfwR5enL6Ixmv0qLaGhV9K91oswn8uh9PA4=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id cn21-20020a0564020cb500b0055f98c703easm247632edb.6.2024.02.01.14.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:45:18 -0800 (PST)
Date: Fri, 2 Feb 2024 00:45:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/11] net: dsa: realtek: migrate
 user_mii_bus setup to realtek-dsa
Message-ID: <20240201224516.pujapjenqtyejihg@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-9-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-9-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-realtek_reverse-v5-9-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-9-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:28PM -0300, Luiz Angelo Daros de Luca wrote:
> +/**
> + * rtl83xx_setup_user_mdio() - register the user mii bus driver
> + * @ds: DSA switch associated with this user_mii_bus
> + *
> + * This function first gets and mdio node under the dev OF node, aborting
> + * if missing. That mdio node describing an mdio bus is used to register a
> + * new mdio bus.

The description has the overall feel of "Family Guy - Peter narrates his life"
(https://www.youtube.com/watch?v=zw8zUMjEW0I).

You could be a bit more succinct and say something like "Registers the
MDIO bus for built-in Ethernet PHYs, and associates it with the
mandatory 'mdio' child OF node of the switch".

> + *
> + * Context: Can sleep.
> + * Return: 0 on success, negative value for failure.
> + */
> +int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct device_node *mdio_np;
> +	struct mii_bus *bus;
> +	int ret = 0;
> +
> +	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> +	if (!mdio_np) {
> +		dev_err(priv->dev, "no MDIO bus node\n");
> +		return -ENODEV;
> +	}
> +
> +	bus = devm_mdiobus_alloc(priv->dev);
> +	if (!bus) {
> +		ret = -ENOMEM;
> +		goto err_put_node;
> +	}
> +
> +	bus->priv = priv;
> +	bus->name = "Realtek user MII";
> +	bus->read = rtl83xx_user_mdio_read;
> +	bus->write = rtl83xx_user_mdio_write;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s:user_mii", dev_name(priv->dev));
> +	bus->parent = priv->dev;
> +
> +	ret = devm_of_mdiobus_register(priv->dev, bus, mdio_np);
> +	if (ret) {
> +		dev_err(priv->dev, "unable to register MDIO bus %s\n",
> +			bus->id);
> +		goto err_put_node;
> +	}
> +
> +	priv->user_mii_bus = bus;
> +
> +err_put_node:
> +	of_node_put(mdio_np);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(rtl83xx_setup_user_mdio, REALTEK_DSA);

