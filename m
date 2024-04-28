Return-Path: <linux-kernel+bounces-161626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C648B4EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82E41C20FE8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1681BF2F;
	Sun, 28 Apr 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gnifZcZF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4CB664;
	Sun, 28 Apr 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714346259; cv=none; b=Ic74vHarZf32p7uZI3FHrC0LWNnyggiFfCd4UP9qWCO35LCJ92J1vZ0Njl+A397mnASloFOfAEPIe97xcwX+YXO9KFn8neapzakydCEgPgE1VEjMYh3Qd20rp3f62f8qnFHBqeiDqxpNESCCtzeEj8rVgoMroOG8SMx4X9s4bPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714346259; c=relaxed/simple;
	bh=yddcab5au8dcJoHAuuTUrC0HJdHCkbWtQT1Frk4wJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5bmsJtYKkC/UO1JSuvWR+a+VdfzSeKD2BaVaW9QzhTQK2Vb5WkBow5dhmXQhi9lgkTXnaM+1sllWUooQWevt7zIUQyTLVUHINDeSRhuBXWOn99SFItOCmT03jaA4/LmGsTrf+G93vWVhjNyrkXIk2AchSVXoHAh9FH1Nl83lnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gnifZcZF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SMe0vlJFp/xalizO6Sd1gmUR5ZkmrPZTdfiEBeCz/LQ=; b=gn
	ifZcZFkS4YmYfgxdFm6pJvh18z15pOUad4fald1wPhy8iZNEjhQRtTQCyPKUmEqLum0IUIWyDtFAv
	ejkJL10FFOIALO/HmNmmV6ZGg3rBiou7Sh2ibZS/NDEaeevOqxLYwNzWth9jdnOAmTpb2dbEHHHc/
	WLsv+poAhHxnNa8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1Dlf-00ECv4-01; Mon, 29 Apr 2024 01:17:11 +0200
Date: Mon, 29 Apr 2024 01:17:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <13c38696-25ed-418d-b85e-950736384a0b@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zi68sDje4wfgftyZ@builder>

On Sun, Apr 28, 2024 at 11:16:32PM +0200, Ramón Nordin Rodriguez wrote:
> >From c65e42982684d5fd8b2294eb6acf755aa0fcab83 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?=
>  <ramon.nordin.rodriguez@ferroamp.se>
> Date: Sun, 28 Apr 2024 22:25:12 +0200
> Subject: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

You sent this patch in an odd way. We don't normally see headers like
this. I've been using b4 recently for patch management:

https://b4.docs.kernel.org/en/latest/contributor/prep.html

Using `b4 send` is a good idea. Otherwise git format-patch; git send-email

> index 9abefa8b9d9f..bed9033574b2 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/phy.h>
>  #include <linux/oa_tc6.h>
> +#include <linux/gpio/driver.h>

This is not a gpio driver, it is a gpio consumer. So you should be
using linux/gpio/consumer.h. Also, i _think_ the includes are sorted,
so it probably should go earlier.

>  
>  #define DRV_NAME			"lan865x"
>  
> @@ -33,6 +34,7 @@
>  
>  struct lan865x_priv {
>  	struct work_struct multicast_work;
> +	struct gpio_desc *reset_gpio;
>  	struct net_device *netdev;
>  	struct spi_device *spi;
>  	struct oa_tc6 *tc6;
> @@ -283,6 +285,24 @@ static int lan865x_set_zarfe(struct lan865x_priv *priv)
>  	return oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG0, regval);
>  }
>  
> +static int lan865x_probe_reset_gpio(struct lan865x_priv *priv)
> +{
> +	priv->reset_gpio = devm_gpiod_get_optional(&priv->spi->dev, "reset",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->reset_gpio))
> +		return PTR_ERR(priv->reset_gpio);
> +
> +	return 0;
> +}
> +
> +static void lan865x_hw_reset(struct lan865x_priv *priv)
> +{
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +	// section 9.6.3 RESET_N Timing specifies a minimum hold of 5us
> +	usleep_range(5, 10);
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +}

Do you see a need to do a reset at any time other than probe? If not,
i would probably combine these two functions into one. Also, since you
pass GPIOD_OUT_HIGH, you have already put it into reset. So setting
the gpio to 1 is pointless.

Does the datasheet say anything about how long you should wait after
releasing the reset?

> +
>  static int lan865x_probe(struct spi_device *spi)
>  {
>  	struct net_device *netdev;
> @@ -297,6 +317,14 @@ static int lan865x_probe(struct spi_device *spi)
>  	priv->netdev = netdev;
>  	priv->spi = spi;
>  	spi_set_drvdata(spi, priv);
> +	if (lan865x_probe_reset_gpio(priv)) {
> +		dev_err(&spi->dev, "failed to probe reset pin");
> +		ret = -ENODEV;

It is normal that a function like lan865x_probe_reset_gpio() would
return an error code. You should then return that error code, rather
than replace it with ENODEV.

     Andrew

