Return-Path: <linux-kernel+bounces-1020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC88814950
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE3B23DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03C62DB8E;
	Fri, 15 Dec 2023 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xbHp58+g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CB2DB7E;
	Fri, 15 Dec 2023 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zcGhs/MR386LURyyPrPAXA8pXRQ9HDSgaEfMslprAcM=; b=xbHp58+graqC9tBpU0Op9Qo4iO
	tccIY15VinrpgENUDgmioCuVXP+RDvoX/PZ2z4Aq5hpGdb4CGgZQFcsZA2bYg8+ZvMaWGu0BCHbJm
	mV6xl79t+iVlPSfNX40rJk1Mhf+g6H8fevB7Xt+h7/hkQZg4ApOa6okdiBkx7URoPCmI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE8HZ-0031fG-0t; Fri, 15 Dec 2023 14:31:13 +0100
Date: Fri, 15 Dec 2023 14:31:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>

On Fri, Dec 15, 2023 at 08:33:00PM +0800, Jie Luo wrote:
> 
> 
> On 12/15/2023 8:12 PM, Andrew Lunn wrote:
> > > +  clocks:
> > > +    items:
> > > +      - description: APB bridge clock
> > > +      - description: AHB clock
> > > +      - description: Security control clock
> > > +      - description: TLMM clock
> > > +      - description: TLMM AHB clock
> > > +      - description: CNOC AHB clock
> > > +      - description: MDIO AHB clock
> > > +      - description: MDIO master AHB clock
> > > +      - description: PCS0 system clock
> > > +      - description: PCS1 system clock
> > > +      - description: EPHY0 system clock
> > > +      - description: EPHY1 system clock
> > > +      - description: EPHY2 system clock
> > > +      - description: EPHY3 system clock

> Hi Andrew,
> These clocks are for the whole PHY package including quad PHYs, since
> these clocks & resets need to be initialized at one point, i put it
> the previous MDIO driver code, these clocks & resets are configured
> after GPIO hardware reset, after these clocks and resets sequences
> configured, each PHY capabilities can be acquired correctly in the PHY
> probe function.

I really expect the hardware is hierarchical. Its unlikely that EPHY0
is connected to all four PHYs in the package. Its specific to one
PHY. So it should be in the DT properties for that one specific PHY. I
expect the resets are the same. It seems there is a soft and hard
reset per PHY, so i would expect these to be in the node for one PHY.

Do the two PCS instances take up two MDIO address? They can be
considered devices on the bus, so could have a DT node, and hence you
can place the PCS clocks on that node?

What exactly do the two MDIO clocks do? I assume these are not for the
MDIO bus master, but the MDIO slave block within the PHY package?
There is one MDIO slave block shared by the four PHYs. So these are
package properties and should be in the package node in DT.

Look at all the other clocks and decide, are they package clocks, or
specific to one block on the MDIO bus? Do the properties go in the
package node, or the per PHY node?

	Andrew

