Return-Path: <linux-kernel+bounces-20920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E0828761
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB561F2573A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C71439850;
	Tue,  9 Jan 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GH4SbNxa"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9F38FA3;
	Tue,  9 Jan 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wvVG2KQV/oETOX0CukFpt/vsd01F13tBQ9AIaAYqp6w=; b=GH4SbNxaChv564U3M/bDK7+b6W
	e4yuHL2BbR4aMHapx53lmIvMyxVTYAtqrdRkQYktWCIpUKceG2nUrXqGw2/b97QNGnEZNL4DgCO+j
	9qS+8VnvXTjPKZu+ILIS9TiPBkLrHFksXOg3/HhB2VxLn1JefXhhBq2PT6SUrN1OF6DY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNCSm-004pw9-Bx; Tue, 09 Jan 2024 14:48:16 +0100
Date: Tue, 9 Jan 2024 14:48:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Message-ID: <2f2328ee-205b-4b4f-a683-2df4fbb22dde@lunn.ch>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <1437d9df-2868-43f5-aebd-e0c57fe4d905@lunn.ch>
 <b75e6267-7d54-412e-8882-af4d9a0b54e6@quicinc.com>
 <841ef784-b27e-4f7a-94f2-f04f93178c61@lunn.ch>
 <07c01c11-0cc2-4837-b371-1404f2ce3359@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c01c11-0cc2-4837-b371-1404f2ce3359@quicinc.com>

> 
> __| |_______________| |__
> | PCS0 |          |PCS1 |
> |______|          |_____|
> |_______                |<---- REF clock 50MHZ
> |      |------------    |
> |NSSCC |    |clks  |rsts|<---- GPIO reset
> |______|    |      |    |
> |           V      V    |
> |_______________________|
> |     |     |     |     |
> |PHY1 |PHY2 |PHY3 |PHY4 |
> |_____|_____|_____|_____|

Not the best of improvements. So the ref clock goes to the package,
and then magically somehow gets to the NSSCC? Are there any more
blocks it goes through before reaching the NSSCC? How does the GPIO
reset get converted into multiple reset inside the package? Details,
details, details.

> There are difference clock trees generated from NSSCC for the different
> PHYs, all clocks and resets for qca8084 CHIP working are internally
> provided by the NSSCC.

So show this in the block diagram.

> Yes, Andrew, the NSSCC provider driver is probed based on the MDIO
> device, the PHY CHIP occupies the MDIO addresses, so the NSSCC is
> registered as the MDIO device.
> 
> DT of the NSSCC device node:
> mdio {
>       #address-cells = <1>;
>       #size-cells = <0>;
> 
>       clock-controller@18 {
>         compatible = "qcom,qca8084-nsscc";
>         reg = <0x18>;
>         clocks = <&qca8k_xo>,
>                  <&qca8k_uniphy0_rx>,
>                  <&qca8k_uniphy0_tx>,
>                  <&qca8k_uniphy1_rx>,
>                  <&qca8k_uniphy1_tx>,
>                  <&qca8k_uniphy1_rx312p5m>,
>                  <&qca8k_uniphy1_tx312p5m>;
>         #clock-cells = <1>;
>         #reset-cells = <1>;
>         #power-domain-cells = <1>;
>       };
>     };
 
This does not make any sense. You have one clock input, 50MHz. So why
are you listing 6 consumer clocks, not one? And where are the clocks
this clock controller provides, clock-output-names=<...>;

I give up. Please consider this PHY driver NACKed.

Get Linaro, or some other organisation with a lot of experience with
mainline to take over the work.

	 Andrew

