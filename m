Return-Path: <linux-kernel+bounces-90899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38161870690
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA75FB24B07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1844BA94;
	Mon,  4 Mar 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mzHOxqSV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D85481DE;
	Mon,  4 Mar 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568383; cv=none; b=D7wFpFnGJ20qdFAqEtlv7P+d9GsThZBiuhdmXnwD1WRp5EA+X6Mmlhn1LP3/EhmOEPOjfWPLOAHc+Z5Z3G8wZTemnm7R/TKIE4fKGpFRFQbB5OB5cwce3KXsTyr/ljUBk5RBAAztczyTuDpbh+AKkIevRcD+nYPtof/9cE7+54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568383; c=relaxed/simple;
	bh=AlNDwPISgBcM6OVPgM4WaoPIp68689qJHcWCy+OYqyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpOvEWSpQPoe9/JzQY4AKNkVpmlAF8KFEY5FzVEFPtRw1H5QuLWewF8Qs0ogeiYrxQ3s6sqML9N9KYI4L3I6CWZjNy1RBSMNGCdStTcLAKl5hPAFLLLHWcWJTzdEylxlwS/A7ui3iGjO2Hv0R6EgmiInl3BoT1yhhbV/8VnKLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mzHOxqSV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ESWzfwNLBdRiQerL5+aFQnFwsh7Ey/Kqyb4OBW7amg=; b=mzHOxqSVyQhSjRX4F5gBr6b//K
	Z13FzT+KYEs/6y4GhaVF3Cxf3GvoUDAwYIFi2bOvk03KYDyQnzQog1PBU94N/pl4HYEfz9hQ9GMFa
	g8UhNBtV7mfJ7oeTgjJr/9+0RaPwlq+vn3lEdEe2qlfmBEK9SOggUO/STE6swk31S/5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhApo-009LBC-Gj; Mon, 04 Mar 2024 17:06:36 +0100
Date: Mon, 4 Mar 2024 17:06:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dp83822: support
 configuring RMII master/slave mode
Message-ID: <d994001c-dff2-402d-bd19-7ddb0c148805@lunn.ch>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
 <20240222103117.526955-2-jeremie.dautheribes@bootlin.com>
 <d14ba685-dc7e-4f99-a21e-bae9f3e6bc79@lunn.ch>
 <860648fa-11f5-4e0d-ac4e-e81ea111ef31@bootlin.com>
 <68112ecb-532f-4799-912d-16d6ceb9a6f3@lunn.ch>
 <021dbe50-5eb9-4552-b2bb-80d58d3eb076@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021dbe50-5eb9-4552-b2bb-80d58d3eb076@bootlin.com>

> > We are normally interested in this 50Mhz reference clock. So i would
> > drop all references to 25Mhz. It is not relevant to the binding, since
> > it is nothing to do with connecting the PHY to the MAC, and it has a
> > fixed value.
> > 
> > So you can simplify this down to:
> > 
> > RMII Master: Outputs a 50Mhz Reference clock which can be connected to the MAC.
> > 
> > RMII Slave: Expects a 50MHz Reference clock input, shared with the
> > MAC.
> > 
> > > That said, would you like me to include this description (or some parts) in
> > > the binding in addition to what I've already written? Or would you prefer me
> > > to use a more meaningful property name?
> > 
> > We don't really have any vendor agnostic consistent naming. dp83867
> > and dp83869 seems to call this ti,clk-output-sel. Since this is
> > another dp83xxx device, it would be nice if there was consistency
> > between all these TI devices. So could you check if the concept is the
> > same, and if so, change dp83826 to follow what other TI devices do.
> 
> 
> So I had a look at this ti,clk-output-sel property on the TI DP8386x
> bindings, but unfortunately it does not correspond to our use case. In their
> case, it is used to select one of the various internal clocks to output on
> the CLK_OUT pin.
> In our case, we would prefer to describe the direction of the clock (OUT in
> master mode, IN in slave mode).

I would suggest we keep with the current property name, but simplify
the description. Focus on the reference clock, and ignore the crystal.

    Andrew

