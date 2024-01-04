Return-Path: <linux-kernel+bounces-16742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925D682432C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076031F253F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC4224DD;
	Thu,  4 Jan 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FgLCAT7+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F1224C1;
	Thu,  4 Jan 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lwfKVVx7X4nlA2hPQXF4+V6T0p8TvsOTKoeOLz3fkv4=; b=FgLCAT7+PCX2erOAbptE1TsR3G
	fBMJFNMH/TOX7AXKwZu3cpsOohCW7t3zRlStq+NNVkokdz6+V9OAaGOXE+QNOb7wklGKyQ77qgLGN
	NwDsk4QIUIb0/xJGN3Oa9AtFJ4CITRID5ENOiLZ6D+8AclTwYT7VNfYLHFhrXazmUXT8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLODb-004Lvc-37; Thu, 04 Jan 2024 14:57:07 +0100
Date: Thu, 4 Jan 2024 14:57:07 +0100
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
Message-ID: <50252a5a-e4fb-42d3-b838-9ef04faf4c5c@lunn.ch>
References: <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
 <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
 <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
 <c5263daa-b5f4-4b9c-a216-73d68493a802@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5263daa-b5f4-4b9c-a216-73d68493a802@quicinc.com>

> 1. For IPQ SoC series, there are only ipq4019, ipq5018, ipq6018,
> ipq8074 documented in the current dt-bindings doc qcom,ipq4019-mdio.yaml
> and ipq9574, ipq5332 that are being added by the MDIO patch, and one
> more ipq8064 whose MDIO driver is mdio-ipq8064.c, on more others.
> 
> 2. For qca8084(pure PHY chip), which is the quad-phy chip, which is just
>    like qca8081 PHY(single port PHY), each port can be linked to maximum
>    speed 2.5G.
> 
>    For qca8386(switch chip), which includes the same PHY CHIP as qca8084
>    (4 physical ports and two CPU ports), qca8386 switch can work with
>    the current qca8k.c DSA driver with the supplement patches.

Is the qca8386 purely a switch plus integrated PHYs? There is no CPU
on it? What is the management path? MDIO?

> 
>    Both qca8084 and qca8386 includes same network clock controller(let's
>    call it NSSCC, since this clock controller is located in the
>    Ethernet chip qca8084 and qca8386), they have the same clock initial
>    configuration sequence to initialize the Ethernet chip.

You said For "qca8084(pure PHY chip)". Here you just called it an
Ethernet chip? To me, and Ethernet chip is a MAC, Intel e1000e etc.
Do you now see how your explanations are confusing. Is it s pure PHY,
or is it an Ethernet chip?

O.K. Since we are getting nowhere at the moment, lets take just the
pure PHY chip, and ignore the rest for the moment.

For any pure PHY, there is generally one clock input, which might be a
crystal, or an actual clock. If you look at other DT bindings for
PHYs, it is only listed if the clock is expected to come from
somewhere else, like a SoC, and it needs to be turned on before the
PHY will work. And generally, a pure PHY has one defined clock
frequency input. If that is true, there is no need to specify the
clock. If multiple clock input frequencies are supported, then you do
need to specify the clock, so its possible to work out what frequency
it is using. How that clock input is then used internally in the PHY
is not described in DT, but the driver can set any dividers, PLLs
needed etc.

So, for the pure PHY chip, what is the pinout? Is there one clock
input? Or 4 clock inputs, one per PHY in the quad package? Typically,
where does this/these clocks come from? Is the frequency fixed by the
design, or are a number of input frequencies supported?

>   The Ethernet chip qca8084 and qca8386 are only connected with IPQ SoC,
>   Currently qca8084 is connected with IPQ SoC by 10G-QXGMII mode.
>   the 4 PHYs of qca8386 are connected with the internal MAC of qca8386
>   by GMII, the maximum speed is also 2.5G.
>   The port4 of qca8084 or qca8386 is optionally be able to connected
>   with IPQ SoC by sgmii.

To some extent, this does not matter. The DT binding and the driver
should not care what the pure PHY is connected to. It has standardised
ports, so in theory it could be connected to any vendors MAC.

Please be very careful with your wording. Because computers
instructions should be unambiguous, it does what it is told, we also
expect computer scientists to be unambiguous. Wording is very
important.

       Andrew

