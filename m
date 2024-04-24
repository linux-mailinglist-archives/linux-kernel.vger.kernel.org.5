Return-Path: <linux-kernel+bounces-157611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493538B138C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D91C22D68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD477A03;
	Wed, 24 Apr 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX9+L10y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6661CD23;
	Wed, 24 Apr 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987009; cv=none; b=rq+bENb13ckjqj1aPf4O5rwCS3XsO5TXSeHOf0asiJ2XIuK+9B6fkNC7n/rK8CGdbe9rVFvQIrMvrb8TDOu9/0N4YlbNrrVXNpzVo3A7WjmMDEtCdlzL1ILAfhdd9+h0X00cW78UHSDKIFzUpzhB1lyviJFKe9meA7ddLzp6Hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987009; c=relaxed/simple;
	bh=Wk+gwE5ehkKwjW4/Y27fgFajy225vRzlpOwadmoSOKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eai8p0OgqeWlEnRtN3CEWRNfPewlojJUSDGAeU34y8HpHPGM0piFprTNOouCnaPJcP0NjUTuu+JYxzf2QFXPe8BERV2Uwsqj7wOe0qL6Y6LDnl2Z6bCgUmy5pkbWTeRn7cqUPi1jSlI+F8ZIfPic1Oo3O0V3FsOjqX62EajfXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX9+L10y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C089C113CD;
	Wed, 24 Apr 2024 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713987009;
	bh=Wk+gwE5ehkKwjW4/Y27fgFajy225vRzlpOwadmoSOKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eX9+L10yAooMM4/Cvm95YwxgpjJkB+reJYSrqqlKxztC2/tWDoFDE9RMuzL37f5pN
	 3YdGsUohZZ/gStHYQEXxVQlDXpUs6dCmd2hhDtrwA36+bav+jIBhREKECzxGxMDrqX
	 MJGDP1EVmXM4DrGinfbB/2DMoC9G2IjDKzM48O0OrxVaIhsJxWt80YL3bcF08XL+H8
	 /xEdCBWlMR7KDFe2bUviG5eHyRwmdbftEknYbtyzltZZzPvvgUSoDDDvQnlATCgaR0
	 1GyfhLIj7NHw5o2nAuzqaGyUl4XbdnQrDU3WTgSyJjY4jJIQXYvifbrRIclKIvQuwG
	 djSkO89fBcRVQ==
Date: Wed, 24 Apr 2024 14:30:07 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Message-ID: <20240424193007.GA329896-robh@kernel.org>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>

On Thu, Apr 18, 2024 at 10:53:17AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
> patch is to add i.MX95 Pinctrl OEM extensions properties.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
>  .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index e9d3f043c4ed..e530bfff141a 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -262,9 +262,12 @@ properties:
>      patternProperties:
>        '-pins$':
>          type: object
> -        allOf:
> -          - $ref: /schemas/pinctrl/pincfg-node.yaml#
> -          - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +        anyOf:
> +          - $ref: /schemas/firmware/nxp,imx95-scmi-pinctrl.yaml
> +          - allOf:
> +              - $ref: /schemas/pinctrl/pincfg-node.yaml#
> +              - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +
>          unevaluatedProperties: false
>  
>          description:
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
> new file mode 100644
> index 000000000000..f6c18e9fafec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
> +
> +maintainers:
> +  - Peng Fan <peng.fan@arm.com>
> +
> +patternProperties:
> +  '[a-f0-9]+$':
> +    type: object
> +    unevaluatedProperties: false
> +
> +    properties:
> +      pins:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: name of the pin
> +        items:
> +          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotraceswo,
> +                  gpioio00, gpioio01, gpioio02, gpioio03, gpioio04,

ioio?

> +                  gpioio05, gpioio06, gpioio07, gpioio08, gpioio09,
> +                  gpioio10, gpioio11, gpioio12, gpioio13, gpioio14,
> +                  gpioio15, gpioio16, gpioio17, gpioio18, gpioio19,
> +                  gpioio20, gpioio21, gpioio22, gpioio23, gpioio24,
> +                  gpioio25, gpioio26, gpioio27, gpioio28, gpioio29,
> +                  gpioio30, gpioio31, gpioio32, gpioio33, gpioio34,
> +                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmclko2,
> +                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, enet1td3,
> +                  enet1td2, enet1td1, enet1td0, enet1txctl, enet1txc,
> +                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, enet1rd2,
> +                  enet1rd3, enet2mdc, enet2mdio, enet2td3, enet2td2,
> +                  enet2td1, enet2td0, enet2txctl, enet2txc, enet2rxctl,
> +                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet2rd3,
> +                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2, sd1data3,
> +                  sd1data4, sd1data5, sd1data6, sd1data7, sd1strobe,
> +                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3data1,
> +                  sd3data2, sd3data3, xspi1data0, xspi1data1, xspi1data2,
> +                  xspi1data3, xspi1data4, xspi1data5, xspi1data6,
> +                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, xspi1ss1b,
> +                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, sd2data2,
> +                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2scl, i2c2sda,
> +                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmclk,
> +                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1txc,
> +                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
> +
> +      nxp,func-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Indicates the PAD connections which function module

The description makes no sense...

> +
> +      nxp,pin-conf:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The PAD configuration

PAD stands for? Or is it pin configuration as the property name says?

This is just a raw register values? Why can't standard pinctrl 
properties be used here. What's the point of using SCMI pinctrl if you 
are just shuttling register values to SCMI?

> +
> +      nxp,daisy-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The select input register ID
> +
> +      nxp,daisy-conf:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The select input register value

I remember some daisy chaining stuff in iomuxc, but otherwise 

What's the relationship between these 2 properties? Is it valid if only 
1 is present? I doubt it. Looks like an address and value pair. Either 
the schema needs to define allowed combinations or design the properties 
in a way you don't have too. IOW, make a single property that's a tuple 
of register ID and value.

Rob

