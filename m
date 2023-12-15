Return-Path: <linux-kernel+bounces-1033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7F814987
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5990B1F235B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE02E3FE;
	Fri, 15 Dec 2023 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lG7viCNz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808ED30321;
	Fri, 15 Dec 2023 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pv0AaHgjkAy6u95Pj8OOH2/guQb3Aq8ffCZaWiu1IRg=; b=lG7viCNzqAjzgDF7gJwFPmDEJ4
	LjsCYZjzFLR2bZTBYmuCcgLYwjT2eW9VGwCO+J8AgkzFFivO5Y7jx6u5khrCR4Kkl4tlxWeuARR2b
	zMIyXm8Iw1VWdmpe0o5eNSF6ZWnuBYXaG/cztXM6PEZZy1ymzgxCUOZO8jZncwaeoMOr4oanxJXn0
	ll8PMs9VoKw1NBUkvId0gijqpyLdeSttPDx6Hl4oRPmhTqnfP67dt0/H46tVkz+qs4X+J+xnZk4Bs
	4Ai6ePEieplGWO8h2S/Ebeqd8RRMMEukMDHCztZcjftHBa+R5107awrpcm5Sl6NPywXQdXVA6PY8f
	/E2uAr8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rE8Sd-0002hd-1H;
	Fri, 15 Dec 2023 13:42:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rE8Sc-0003em-Gu; Fri, 15 Dec 2023 13:42:38 +0000
Date: Fri, 15 Dec 2023 13:42:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <ZXxXzm8hP68KrXYs@shell.armlinux.org.uk>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
 <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
 <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 15, 2023 at 08:16:53PM +0800, Jie Luo wrote:
> On 12/15/2023 7:25 PM, Andrew Lunn wrote:
> > > The "maxItems: 1" of the property resets is defined in ethernet-phy.yaml
> > > that is referenced by qca,ar803x.yaml, but i have 11 reset instances
> > > used for qca8084 PHY
> > 
> > 11!?!?? Really? Why?
> > 
> > I assume the order and timer matters, otherwise why would you need
> > 11? So the PHY driver needs to handle this, not phylib framework. So
> > you will be adding vendor properties to describe all 11 of them. So
> > ethernet-phy.yaml does not matter.
> > 
> > 	Andrew
> 
> Since these resets need to be configured in the special sequence, and
> these clocks need to be configured with different clock rate.
> 
> But the clock instance get, the property name is fixed to "clock-names"
> according to the function of_parse_clkspec, and the reset property name
> is also fixed to "reset-names" from function __of_reset_control_get.

I think you need to give more details about this.

Where are these 11 resets located? What is the sequence? Why does the
PHY driver need to deal with each individual reset?

IMHO, a PHY driver should _not_ be dealing with the resets outside of
the PHY device itself, and I find it hard to imagine that qca8084
would have 11 external resets.

If these are 11 internal resets (to qca8084) then why are you using the
reset subsystem, and why do you need to describe them in DT? Surely if
they are internal to the PHY, that can be encapsulated within the PHY
driver?

This is an example of why it is useful to have an _example_ of the use
of this binding, because it would answer some of the above questions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

