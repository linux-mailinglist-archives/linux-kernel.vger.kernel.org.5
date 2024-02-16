Return-Path: <linux-kernel+bounces-68638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6A857DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DC91C24895
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BEE12AACB;
	Fri, 16 Feb 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jr0VUsRK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570811292C0;
	Fri, 16 Feb 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089803; cv=none; b=LenKCqSxYwR+Jmd93Mz7OxWLPMRXajVRO7fXENipZylZQcjbioOjISGOBy5fmd8ny17ynRHjQY6XcQcsL09hBoImaDsWAq46ykr5/WLs1f8kRsQ7AHRR7zny02NulT3N9lTaFOSP+mnBkWM7vTsce9gE5iU3PsoSiiAKntTNSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089803; c=relaxed/simple;
	bh=yNQ47maJB06kRaj+kJ7yhxyB60a9jxG4VEfPnqmenu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I17KNW1oFsjkn0OiOocJ637HFSr7s4nnRh30zG59kpUCRbYbDkQy9xZ0JyqgfcKO8x14QOrTkDJkT9fMoSHoEmq8RoMFclIGVL7ImbPrpdyC6Gy6EYl+smH2zGHe6O8jQz69S8/iIRznKEOnA7wykqoWkINfLz4vaCNWlt832pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jr0VUsRK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w3M4oAZ4DS3UO3u36YB3/CxaaPZ2YrBpIFI0Wh30A8A=; b=Jr0VUsRK/IE1qd+RR0bfCqslUG
	/AAontTXkjJGmQmM5wYdqZ84LRD3Cv01F10N+CG9BqseU/yglDZx9644msAASwczuNvpap8YpKiVp
	9s4MfpLm1MVCEGLOG0a0bI2UhZrAyrqS6fLxDnJrmj7TX0+dC+IwFooMtbU2/vdeVDvY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rayBR-007yxp-SG; Fri, 16 Feb 2024 14:23:17 +0100
Date: Fri, 16 Feb 2024 14:23:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Message-ID: <d3ac4638-d0bf-4c6c-bccd-519ad1f4dc5e@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v1-1-e0ad972cda99@outlook.com>

> +	// Register the optional MDIO bus
> +	for_each_available_child_of_node(node, mdio_np) {
> +		if (of_node_name_prefix(mdio_np, "mdio")) {
> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
> +			of_node_put(mdio_np);
> +			if (!priv->mdio_pdev) {
> +				dev_err(dev, "failed to register MDIO bus device\n");
> +				goto out_free_netdev;
> +			}
> +			mdio_registered = true;
> +			break;
> +		}
> +	}
> +
> +	if (!mdio_registered)
> +		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");

I don't understand the architecture of this device yet...

It seems like you have an integrated PHY? In the example, you used a
phy-handle to bind the MAC to the PHY. So why is the MDIO bus
optional?

Do the MII signals from the MAC also go to SoC pins, so you could use
an external PHY? Is there a SERDES so you could connect to an SFP
cage?

Also, do the MDIO pins go to SoC pins? Can the MDIO bus master be used
to control external PHYs?

If everything is internal, fixed in silicon, no variation possible,
you don't need to describe the MDIO bus in DT. The MAC driver can
register it, and then get the PHY at the hard coded address it uses.

	 Andrew

