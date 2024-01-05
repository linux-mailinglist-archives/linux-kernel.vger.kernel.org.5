Return-Path: <linux-kernel+bounces-17881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE482548A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06391F22A66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160522D7AF;
	Fri,  5 Jan 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hb6pTDsO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2492D7AD;
	Fri,  5 Jan 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xsZkrjSLGS2hapVRqmxgnJelDcefZub/b13sHJ7frcI=; b=Hb6pTDsOIy4wBDb+tkE2theanc
	ayw7Yf1xwJa4EJsBWXpQ1yiHD/bPva0LkBH2klxeJLo7H/RpAPtnaUjznLE9sz/yIviOB3541TuYi
	X+/quRAzrkvzTF+4oc4yzu2NmWG6KvYNcvJohq8mCyf93t6QbNpbxWlBEh6DOfHaKndc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLkNw-004SM2-Dx; Fri, 05 Jan 2024 14:37:16 +0100
Date: Fri, 5 Jan 2024 14:37:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <864b0867-06c0-4c6d-ae71-9b5025c8d93a@lunn.ch>
References: <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
 <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
 <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
 <c5263daa-b5f4-4b9c-a216-73d68493a802@quicinc.com>
 <50252a5a-e4fb-42d3-b838-9ef04faf4c5c@lunn.ch>
 <b427c89a-81a9-439f-905e-2a6632065b78@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b427c89a-81a9-439f-905e-2a6632065b78@quicinc.com>

> > O.K. Since we are getting nowhere at the moment, lets take just the
> > pure PHY chip, and ignore the rest for the moment.
> > 
> > For any pure PHY, there is generally one clock input, which might be a
> > crystal, or an actual clock. If you look at other DT bindings for
> > PHYs, it is only listed if the clock is expected to come from
> > somewhere else, like a SoC, and it needs to be turned on before the
> > PHY will work. And generally, a pure PHY has one defined clock
> > frequency input. If that is true, there is no need to specify the
> > clock. If multiple clock input frequencies are supported, then you do
> > need to specify the clock, so its possible to work out what frequency
> > it is using. How that clock input is then used internally in the PHY
> > is not described in DT, but the driver can set any dividers, PLLs
> > needed etc.
> 
> Yes, Andrew, there is only one clock input to qca8084(same as qca8386),
> this input clock rate is 50MHZ, which is from the output clock of CMN
> PLL block that is configured by the MDIO bus driver patch under review.

Lets concentrate on the pure PHY. All it sees is a clock. It does not
care where it come from. All you need in the device tree for the pure
PHY is a clock consumer.

There is one clock input, so its shared by all four instances in the
pure PHY package. So you need to use Christians code which extends the
PHY DT bindings to allow DT properties for a package of PHYs.

What about resets. Is there one reset pin for the pure PHY package, or
one per PHY?

Go find Christians code, understand it, and propose a DT binding for
the pure PHY. Include the clock provider and the reset
provider. Forget about the MDIO controller, and the PHY integrated
into the switch, etc. Baby steps...

> In qca8084(same as qca8386), there is a clock controller, let's call it
> as NSSCC, the logic of NSSCC is same as qualcomm GCC(located in SoC),
> the NSSCC provides the clocks to the quad PHYs, the initial clocks for
> quad PHYs need to be configured before PHY to work.

You said above, there is one clock input to the qca8084. Here you use
the word clocks, plural. Is there one clock, or multiple clocks?

    Andrew

