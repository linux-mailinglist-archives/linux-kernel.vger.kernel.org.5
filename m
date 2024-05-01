Return-Path: <linux-kernel+bounces-165185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6008B8941
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CEC284F74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98227D3F4;
	Wed,  1 May 2024 11:32:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3761664;
	Wed,  1 May 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563128; cv=none; b=I0Wsz5CiAd7RYqWeRyTQs2oeJZY6d7ByomQWS3ZXrI2GtXCnE2ZuFFtnDJpwvY+AoS2IPx5tEia1dOcndpXgQmi/RVHuI9Mh253N1jwsm2YaTqURWnAaEklHjfY32l1EVB9eMLNgxo/WOUxlqeGVETYETAOJpFMWQ+UDTvoD/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563128; c=relaxed/simple;
	bh=IKkLZZ/6LHNlSiF5MEAigsdy2P81iDCz4def5PRB3/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzGMtLkWu3/BIT5pXHW/Nh6+lfVWAEj5x9LSVH9gU97VQ+mLPA9qaL/1YiTWVOmmnzPWoh2D3WAnCr3fahFRYgL+T1lRViBCHIVkJXh7jDBbLSTD0oQGBA5jJsqgd6jtr5hQrrknjesKXfBKD+ECpJkRyqovSge9iUilvJX9/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6E912F4;
	Wed,  1 May 2024 04:32:31 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE613F793;
	Wed,  1 May 2024 04:32:02 -0700 (PDT)
Date: Wed, 1 May 2024 12:32:00 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Message-ID: <ZjIoMJOAxtC-nkZO@pluto>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
 <20240424193007.GA329896-robh@kernel.org>
 <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Thu, Apr 25, 2024 at 09:06:00AM +0000, Peng Fan wrote:
> Hi Rob,
> 
> > Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
> > for i.MX95 Pinctrl OEM extensions
> > 
> > On Thu, Apr 18, 2024 at 10:53:17AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
> > > patch is to add i.MX95 Pinctrl OEM extensions properties.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
> > >  .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66
> > > ++++++++++++++++++++++
> > >  2 files changed, 72 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> 
> ....
> 
> > > +
> > > +title: i.MX System Control and Management Interface (SCMI) Pinctrl
> > > +Protocol
> > > +
> > > +maintainers:
> > > +  - Peng Fan <peng.fan@arm.com>
> > > +
> > > +patternProperties:
> > > +  '[a-f0-9]+$':
> > > +    type: object
> > > +    unevaluatedProperties: false
> > > +
> > > +    properties:
> > > +      pins:
> > > +        $ref: /schemas/types.yaml#/definitions/string
> > > +        description: name of the pin
> > > +        items:
> > > +          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotraceswo,
> > > +                  gpioio00, gpioio01, gpioio02, gpioio03, gpioio04,
> > 
> > ioio?
> 
> Yes. The name is exported from SCMI firmware.
> 
> > 
> > > +                  gpioio05, gpioio06, gpioio07, gpioio08, gpioio09,
> > > +                  gpioio10, gpioio11, gpioio12, gpioio13, gpioio14,
> > > +                  gpioio15, gpioio16, gpioio17, gpioio18, gpioio19,
> > > +                  gpioio20, gpioio21, gpioio22, gpioio23, gpioio24,
> > > +                  gpioio25, gpioio26, gpioio27, gpioio28, gpioio29,
> > > +                  gpioio30, gpioio31, gpioio32, gpioio33, gpioio34,
> > > +                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmclko2,
> > > +                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, enet1td3,
> > > +                  enet1td2, enet1td1, enet1td0, enet1txctl, enet1txc,
> > > +                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, enet1rd2,
> > > +                  enet1rd3, enet2mdc, enet2mdio, enet2td3, enet2td2,
> > > +                  enet2td1, enet2td0, enet2txctl, enet2txc, enet2rxctl,
> > > +                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet2rd3,
> > > +                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2, sd1data3,
> > > +                  sd1data4, sd1data5, sd1data6, sd1data7, sd1strobe,
> > > +                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3data1,
> > > +                  sd3data2, sd3data3, xspi1data0, xspi1data1, xspi1data2,
> > > +                  xspi1data3, xspi1data4, xspi1data5, xspi1data6,
> > > +                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, xspi1ss1b,
> > > +                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, sd2data2,
> > > +                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2scl, i2c2sda,
> > > +                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmclk,
> > > +                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1txc,
> > > +                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
> > > +
> > > +      nxp,func-id:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: Indicates the PAD connections which function
> > > + module
> > 
> > The description makes no sense...
> 
> I will use below description in v3:
> For each pin, there are up to 8 muxing options (called ALT modes). For example:
> Select 1 of 5 iomux modes to be used for pad: DAP_TCLK_SWCLK.
> 000b - Select mux mode: ALT0 mux port: JTAG_MUX_TCK of instance: jtag_mux
> 010b - Select mux mode: ALT2 mux port: CAN4_RX of instance: imx95_wakeupmix_top
> 100b - Select mux mode: ALT4 mux port: FLEXIO1_FLEXIO30 of instance: imx95_wakeupmix_top
> 101b - Select mux mode: ALT5 mux port: GPIO3_IO30 of instance: imx95_wakeupmix_top
> 110b - Select mux mode: ALT6 mux port: LPUART5_CTS_B of instance: imx95_wakeupmix_top
> The nxp,func-id property is selecting one ALT mode.
> 
> > 
> > > +
> > > +      nxp,pin-conf:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: The PAD configuration
> > 
> > PAD stands for? Or is it pin configuration as the property name says?
> 
> It is pin configuration which includes pull up/down, drive strength and etc.
> 
> > 
> > This is just a raw register values? 
> 
> Yes.
> 
> Why can't standard pinctrl properties be
> > used here. What's the point of using SCMI pinctrl if you are just shuttling
> > register values to SCMI?
> 
> Standard pinctrl properties will need more memory in our SCMI
> firmware design. We have limited on-chip memory for SCMI firmware usage.
> 

So you sort of strip-down the server due to hw constraints, but is it
the SCMI server still compliant with the spec ? (as in supporting all
the mandatory commands and features for the protocols you decided to
support)

Thanks,
Cristian

