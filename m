Return-Path: <linux-kernel+bounces-87573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01686D610
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED641F23D88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642516FF56;
	Thu, 29 Feb 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dj8QYvH1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA016FF29;
	Thu, 29 Feb 2024 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241804; cv=none; b=F97uurudg30h4ZVWfEh4yTp6bHI8XgGO8atKbH/p8oLqGf1FPZnuLJLDOkGYMKZt8WqONZj60MO2oNdvOxX1NuTPTdXTYvP6KYNMIfeIBurv3fEHIvrCdfPPazY+VPmTviStSyjr8pk7LoTQSnzz0ftWmlyGjUZvLSkAmAvpffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241804; c=relaxed/simple;
	bh=dr2CETLPDzvOjfQ+4hzjizFIOCRZWKH7BMDF5xNDmVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4jEtRJFgpMh3AK1mPN9FWazMoiUuODpTmrd7KhsSyBwlmkR2AcWI7GuNeHjKom9RG5qYh7O0dt/Fq19/kIGeECfZVllomqCiXkGleX+qbArTYOi4BMT2PXbgCFNSVYLDX4uN4yfLe+CbS3c+pEaK3U+hk/xmBXOtI/bGMhI9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dj8QYvH1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WV/j6Y5N6otWN1tEplJm/8ekXe3vxnN6/ZPGGpf+w6U=; b=Dj
	8QYvH1CsV06IW27X93TYnqspsw8At9LX7YmY9g02ojJYhZ/sAkNZIeV+PLXzWsijdZLjujg45/JAa
	l46mK7WWfEvLzGG+J3rBMyelnG3levKWyzWgilnVHaSo2jI18G3Dru47kP9brEN94JpD4VNrfEqnc
	Ce0PcYvCybZ6IrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfnsH-0095Hf-8S; Thu, 29 Feb 2024 22:23:29 +0100
Date: Thu, 29 Feb 2024 22:23:29 +0100
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
Message-ID: <68112ecb-532f-4799-912d-16d6ceb9a6f3@lunn.ch>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
 <20240222103117.526955-2-jeremie.dautheribes@bootlin.com>
 <d14ba685-dc7e-4f99-a21e-bae9f3e6bc79@lunn.ch>
 <860648fa-11f5-4e0d-ac4e-e81ea111ef31@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <860648fa-11f5-4e0d-ac4e-e81ea111ef31@bootlin.com>

> > > --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> > > @@ -80,6 +80,22 @@ properties:
> > >              10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
> > >       default: 10000
> > > +  ti,rmii-mode:
> > > +    description: |
> > > +       If present, select the RMII operation mode. Two modes are
> > > +       available:
> > > +         - RMII master, where the PHY operates from a 25MHz clock reference,
> > > +         provided by a crystal or a CMOS-level oscillator
> > > +         - RMII slave, where the PHY operates from a 50MHz clock reference,
> > > +         provided by a CMOS-level oscillator
> > 
> > What has master and slave got to do with this?
> > 
> > Sometimes, the MAC provides a clock to the PHY, and all data transfer
> > over the RMII bus is timed by that.
> > 
> > Sometimes, the PHY provides a clock to the MAC, and all data transfer
> > over the RMII bus is timed by that.
> > 
> > Here there is a clear master/slave relationship, who is providing the
> > clock, who is consuming the clock. However, what you describe does not
> > fit that. Maybe look at other PHY bindings, and copy what they do for
> > clocks.
> 
> In fact, I hesitated a lot before choosing this master/slave designation
> because of the same reasoning as you. But the TI DP83826 datasheet [1] uses
> this name for two orthogonal yet connected meanings, here's a copy of the
> corresponding § (in section 9.3.10):
> 
> "The DP83826 offers two types of RMII operations: RMII Slave and RMII
> Master. In RMII Master operation, the DP83826 operates from either a 25-MHz
> CMOS-level oscillator connected to XI pin, a 25-MHz crystal connected across
> XI and XO pins. A 50-MHz output clock referenced from DP83826 can be
> connected to the MAC. In RMII Slave operation, the DP83826 operates from a
> 50-MHz CMOS-level oscillator connected to the XI pin and shares the same
> clock as the MAC. Alternatively, in RMII slave mode, the PHY can operate
> from a 50-MHz clock provided by the Host MAC."
> 
> So it seems that in some cases this also fits the master/slave relationship
> you describe.

We are normally interested in this 50Mhz reference clock. So i would
drop all references to 25Mhz. It is not relevant to the binding, since
it is nothing to do with connecting the PHY to the MAC, and it has a
fixed value.

So you can simplify this down to:

RMII Master: Outputs a 50Mhz Reference clock which can be connected to the MAC.

RMII Slave: Expects a 50MHz Reference clock input, shared with the
MAC.

> That said, would you like me to include this description (or some parts) in
> the binding in addition to what I've already written? Or would you prefer me
> to use a more meaningful property name?

We don't really have any vendor agnostic consistent naming. dp83867
and dp83869 seems to call this ti,clk-output-sel. Since this is
another dp83xxx device, it would be nice if there was consistency
between all these TI devices. So could you check if the concept is the
same, and if so, change dp83826 to follow what other TI devices do.

> BTW, this series has already been merged into the net-next tree, I'm not
> sure what procedure to follow in such cases.

KAPI don't become fixed until published as a release kernel. We can
rework bindings until then. So just submit patches on top of what is
already in net-next.

	Andrew

