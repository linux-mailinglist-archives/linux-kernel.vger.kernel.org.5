Return-Path: <linux-kernel+bounces-68681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28028857E51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A1B1C232D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0412C55A;
	Fri, 16 Feb 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EYeUR/Ay"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19D12C526;
	Fri, 16 Feb 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091933; cv=none; b=I3RjIzRHc/RRTVd9DU+N8Z4AQuR8/SLe1zkaNEMzL7lMksTirKS2xDqqmhjSpcqLg89Xh3t968hD/WuINmWlQvLyHHaLvgjDZZ6FEFB+DsNVS4bEMH0Sqw74g9kOK+1QRRKhEZwVT9wIsa+OF44ybE1MLZWFqaw1ASvaEAGBVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091933; c=relaxed/simple;
	bh=6HO5ZPvf/kyg337PuuPhKmrtQkd1Y48sLGbsQv5FD6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYdI8/GmOffEuEw14ggCV1H4j0+M9g2+Dn12h/IF+A3ji7nihLksz9a9hELwHh0oh9wQzLk0KX47UviPh+dlOAFCwa7I6ijwZPWnDv33uRH2jxLObyRwJFoIMYXjD4iXy6nFIXIoNbg0ssd+WsTXpJDJjHIWFmfki6342Y1cIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EYeUR/Ay; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hK77YppwsIsAkoVz4GVr48v1GwUIIYYl+NfWfnOgi4s=; b=EYeUR/Ayd9Ipsd1LcdLnYJfJyu
	o/Bfc70RllgqONGBrEaGSsH8RUImtaZQcKvu1Nb3+0zFUz1Cv1sthF1n9o+A1dTcH3dvY80T3IgMt
	DVv8bcVtqtAqC2kcU7PtqDSOkjoKsikDZXmiR7/+YqCw68XLN266qtXvAYLsy58DfOic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rayjp-007zBO-NB; Fri, 16 Feb 2024 14:58:49 +0100
Date: Fri, 16 Feb 2024 14:58:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
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
Message-ID: <143ee08e-e53a-41c1-8020-55b495394dd4@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
 <d3ac4638-d0bf-4c6c-bccd-519ad1f4dc5e@lunn.ch>
 <SEZPR06MB69593E00C6A69AFAC61BF2BD964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB69593E00C6A69AFAC61BF2BD964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>

On Fri, Feb 16, 2024 at 09:41:29PM +0800, Yang Xiwen wrote:
> On 2/16/2024 9:23 PM, Andrew Lunn wrote:
> > > +	// Register the optional MDIO bus
> > > +	for_each_available_child_of_node(node, mdio_np) {
> > > +		if (of_node_name_prefix(mdio_np, "mdio")) {
> > > +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
> > > +			of_node_put(mdio_np);
> > > +			if (!priv->mdio_pdev) {
> > > +				dev_err(dev, "failed to register MDIO bus device\n");
> > > +				goto out_free_netdev;
> > > +			}
> > > +			mdio_registered = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (!mdio_registered)
> > > +		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
> > I don't understand the architecture of this device yet...
> > 
> > It seems like you have an integrated PHY? In the example, you used a
> > phy-handle to bind the MAC to the PHY. So why is the MDIO bus
> > optional?
> Because the MAC can also support external PHY according to the datasheet.
> Maybe some other SoCs didn't implement this internal PHY and used an
> external PHY instead.
> > 
> > Do the MII signals from the MAC also go to SoC pins, so you could use
> > an external PHY? Is there a SERDES so you could connect to an SFP
> > cage?
> No. MII signals is not accessible outside of the SoC. The SoC only exports
> FEPHY pins (i.e. RXN(P) and TXN(P)).
> > 
> > Also, do the MDIO pins go to SoC pins? Can the MDIO bus master be used
> > to control external PHYs?
> It can, but not for Hi3798MV200. The datasheet said it can use both internal
> phy or external phy. But for Hi3798MV200, seems impossible.

So for the Hi3798MV200 this is not optional, the MDIO bus is
mandatory.

Also, it sounds like it exists in the silicon. So it is better to
always describe it in the .dtsi file.

And i took a quick look at mdio-hisi-femac.c. It has a probe function
which does:

        data->membase = devm_platform_ioremap_resource(pdev, 0);

meaning it expects to have its own address range. It is a device of
its own. That also explains the compatible. So please move the MDIO
bus to a node of its own, rather than embedding it within the MAC
node.

	Andrew

