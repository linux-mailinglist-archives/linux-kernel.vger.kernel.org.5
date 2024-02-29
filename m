Return-Path: <linux-kernel+bounces-86912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B986CCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E678C1C20C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F61474A8;
	Thu, 29 Feb 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XSu+wV/o"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFE137753;
	Thu, 29 Feb 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219861; cv=none; b=EUt/Kdzcj+tx8zkchWMbtCy8SmWX2ak74DBfwq2ZaS9BvQnJ5kOST8lNjowgYE4n7xQIxKF4sWJ7ukr43jr7vGM69zIR0TSm4TS1JNFL1uVfGg/yCx8NAxGJa3nQeGjSspCfYDRZwUsyc+shENx2M1JWoPHVYRTA1D8UsGVr+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219861; c=relaxed/simple;
	bh=br/HWN6lmANGcA8lXtzi6rpYYGeQsWi3eahucRslWvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMyULDPc+mxwlmB1X8yIulhrDpB9ChyALM4kPFiJFu/ugXAWxq3OZ8JJ0H7Cexg6bI6bJaGE+BMLQKdWPbbnNPQsc/AEMsh8EKkhDY/rr28JasSChqu6lGxmhCBpND5V+919SSbSP6coy/W08zY9ETbQiRqtZHki+4tvWzw5V4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XSu+wV/o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+c7Vmm6KMU5zSvglgfqufPHeSuGV1yw9KPRb+vUHbSs=; b=XSu+wV/oCNilQemLKrLXtUYJun
	ZFsAIYQS4CPzcvXULpppRYMnMQAOaPDTBOQp4Fi0W33U9liiMEbP4aNMLs9Uom5a3ibtYmpr3Rxaf
	Is3E4P5BVtL/4LPvUhWtCVpzV4TPKJ+aj8EJCpuSkF/AKfVbnwVkDlRKpXa4h+PFJb9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfiAN-0093D1-J5; Thu, 29 Feb 2024 16:17:47 +0100
Date: Thu, 29 Feb 2024 16:17:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 2/6] leds: trigger: Create a new LED netdev trigger
 for collision
Message-ID: <9dd1b2d0-4ba5-4d34-a892-a6cc8c01df28@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-3-bastien.curutchet@bootlin.com>
 <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
 <e1936774-14bf-4ae5-9754-e21f5a0c59b3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1936774-14bf-4ae5-9754-e21f5a0c59b3@bootlin.com>

> > How useful is collision? How did you test this? How did you cause
> > collisions to see if the LED actually worked?
> Indeed I am not able to generate collision on my setup so I did not test
> this
> collision part.
> My use case is that the hardware strap configuration that selects the LED
> output mode
> can not be trusted so I have to force configuration with software. I added
> this collision
> part because I wanted to cover all the LED configuration modes offered by
> the PHY.

There are a few things i want to avoid here:

1) Vendor SDK mentality. The hardware can do this, lets add a knob to
make use of it. We end up with 100 of configuration knobs which nobody
ever uses. Do you actually have a board where the strapping is wrong?
Are you going to submit a .dts file making use of this option?

2) LEDs are the wild west, because it is not part of 802.3. Every
vendor does it differently, and has their own special blinking
patterns. My preference is to keep it simple to what people actually
use. You cannot actually generate a collision, the developer who wants
to add support for collision. I have to ask, is collision actually
useful?

> > As far as i can see, this is just a normal 100Base-T PHY. Everybody
> > uses that point-to-point nowadays. If it was an 100Base-T1, with a
> > shared medium, good old CSMA/CD then collision might actually be
> > useful.
> > 
> > I also disagree with not having software fallback:
> > 
> > ip -s link show eth0
> > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
> >      link/ether 80:ee:73:83:60:27 brd ff:ff:ff:ff:ff:ff
> >      RX:     bytes    packets errors dropped  missed   mcast
> >      4382213540983 2947876747      0       0       0  154890
> >      TX:     bytes    packets errors dropped carrier collsns
> >        18742773651  197507119      0       0       0       0
> > 
> > collsns = 0. The information is there in a standard format. However,
> > when did you last see it not 0?
> 
> Ok, I could add the software callback but I will not be able to test it ...

My personal experience is, anything not tested is broken...

Think about what Russell actually said. That should give you a clue
how to cause collisions. If not, go study history books about CSMA/CD.

   Andrew

