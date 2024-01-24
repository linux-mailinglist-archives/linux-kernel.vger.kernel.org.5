Return-Path: <linux-kernel+bounces-37474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95C83B090
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB4D1F22DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1677A73E;
	Wed, 24 Jan 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="PIyp9u/K"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E61272D0;
	Wed, 24 Jan 2024 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118919; cv=none; b=HZl+KbwgI9xbOJnKmnrVo2GFa4WRKMdlbWBw3uBN7hWhldNDhRfFo06NJX8yyptEwwaydCNMh4KpZ+mNV5Cfv+8jtmZf1Fv6TdMIriHI2J7cVzIxo7bUlk7ZmclvZQLNfle5y+PLFjcwhEik+Ncpajp+eajkqCANyas/Hk8Lf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118919; c=relaxed/simple;
	bh=g3iI6NPiDTdkLc/YeKvXWbu/B9SLOYxdwsZhhVTmZLg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSm3zvuKXahaDZzsZ4RI1qjA8Y7RiO+SFHTZqX5aUZrOcZ1R0hQj7WyMcSntmPhHIqLb5joSJM0dtRUiKt3nEoemJBng40WgPxdwbU3NZxTmZ+MEwzPj69oIvnl9pSlXFRYgv/aOK/dbrB4xYZ7w1yE2yRMrYzBpJVXn2FMYAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=PIyp9u/K; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1706118913; bh=g3iI6NPiDTdkLc/YeKvXWbu/B9SLOYxdwsZhhVTmZLg=;
	h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
	b=PIyp9u/KIJpFSGroPUHp5KofhpOHYqwMsp842js94LJEv1RULsu7CByZ+RsDhIfse
	 8Fwx0cVwz2k0TDSkJw65M5d/Bxuj8AItjLT9E4W280KtWGgxMvrjDk+xJWU557MQ9c
	 T1l8jEdP85Zt7r374zIGe38EL7EsUqf8nZzah4Y4=
Date: Wed, 24 Jan 2024 18:55:12 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alain Volmat <alain.volmat@foss.st.com>, Pavel Machek <pavel@ucw.cz>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add front/back cameras
Message-ID: <7cj2ggvglwmzm6svmmci6jgb2hhfim7p7nyvqumfutescotfis@2auzzlttdu6e>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alain Volmat <alain.volmat@foss.st.com>, Pavel Machek <pavel@ucw.cz>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>
 <rkx4iuuudkk7iaaudmr3ccwpatps7kz2qyjalcfzp4ongmbaby@rcosajd6c746>
 <ZbEB0TCTkzIYnLZD@skv.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbEB0TCTkzIYnLZD@skv.local>

Hey Andrey,

On Wed, Jan 24, 2024 at 03:25:53PM +0300, Andrey Skvortsov wrote:
> Hi Ondrey,
> 
> On 24-01-23 23:01, Ondřej Jirman wrote:
> > Hi Andrey,
> > 
> > On Wed, Jan 24, 2024 at 12:47:29AM +0300, Andrey Skvortsov wrote:
> > > From: Ondřej Jirman <megi@xff.cz>
> > > 
> > > Pinephone has OV5640 back camera and GC2145 front camera. Add support
> > > for both.
> > 
> > The upstream driver doesn't support multiple endpoints per port. See:
> > 
> > https://elixir.bootlin.com/linux/v6.8-rc1/source/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml#L43
> > 
> > Only one endpoint is allowed/supported. Looking throught LKML, I don't
> > see the support for multiple parallel interface endpoints being added
> > recently...
> >
> > So this patch will not work, and will cause DTS validation errors.
> 
> Thank you! I've not run dtb validation before submission, sorry for that.
> I've ran 'make dtbs_check' and have several question now.
> 
> 1. I don't see any complaints about multiple endpoints definitions.
> 
> IMHO, it looks okay from binding point of view according to that
> video-interfaces.yaml [1].

Allright, I've checked allwinner,sun6i-a31-csi.yaml and there I see:

  port:
    $ref: /schemas/graph.yaml#/$defs/port-base
    description: Parallel input port, connect to a parallel sensor

    properties:
      endpoint:
        $ref: video-interfaces.yaml#
        unevaluatedProperties: false

        properties:
          bus-width:
            enum: [ 8, 10, 12, 16 ]

          pclk-sample: true
          hsync-active: true
          vsync-active: true

        required:
          - bus-width

    unevaluatedProperties: false

Which looks like a single endpoint node reference without any @somethnig suffix
possible, but I guess in reality it means any number of those with arbitrary
@something suffix.

My bad.

> I know that currently multiple endpoint implementation for parallel
> interface is missing in sun6i_csi. Current out-of-tree implementation
> doesn't require any change in bindings (Hopefully it will be upstream one
> day) Or do you mean this change has to be submitted upstream only once
> sun6i_csi gets fixed?

If bindings are proper, then it's ok. I don't see a reason for them changing.
It's a single physical port that has two cameras connected to it. So having two
enpoints under one port describes reality well.

A good thing is that the patch for multiple cameras is quite small
against 6.7/6.8. It should be easy to merge, especially when it looks like
now that I see there are not even DT changes needed.

> 
> 2. dtbs_check complaints about missing link-frequencies for recently
> submitted gc2145. [2]
> ```
> front-camera@3c: port:endpoint: 'link-frequencies' is a required property
> ```
> 
> I've looked at other drivers and link-frequencies are used only
> mostly for CSI-2 endpoints. Should it be required for CPI/DVP ?
> 
> Not many mainline drivers support CSI-2 and DVP: ov5640, s5k5baf,
> mt9mt114. Only mt9mt114 uses link-frequencies property for DVP and it
> should match PCLK (double pixelrate). [3]
>
> 
> Should I define link-frequencies for DVP as a double pixelrate here as
> well and handle that in the driver?

No.

Pixel clock is generated by the sensor via some PLL based on master clock
generated from the SoC (in this case). It will depend on pixel format
and pixel rate, which in turn depends on selected format and frame rate. I
don't see why this should be a predefined list of values in DT. The driver
should use the lowest PCLK possible for a selected mode, to save power.

Parallel interface on Pinephone goes up to maybe 50 MHz and is a slave
interface with no adjustables based on PCLK frequency. So there's no in-kernel
consumer for the sensor chosen PCLK (V4L2_CID_LINK_FREQ) information.

What makes sense to me practically is to have a per board ability to specify
a maximum PCLK frequency in DT, based on how well the routing and termination
of signals went on a particular SBC/Phone/whatever or what SoC receiver port
supports.

The sensor driver could use this to limit the top PCLK frequency it uses,
becuase it's a bus master. (eg. by limiting the modes or framerates it offers to
userspace, because if mode would require say 70MHz PCLK, it would be
unrealizable on Pinephone, even if sensor can happily produce 70MHz PCLK and
other signals).

Fixed list of link-frequencies in DT is meaningless for this situation. You can
have sensor use any frequency up to a certain limit. What matters is the top bus
frequency limit. (Around 50MHz on Pinephone)

> Currently gc2145 doesn't support DVP, but I have basic working support
> for DVP for the upstreamed driver for a long time and waited for it to be merged
> into mainline. I'd like to submit it for review. Until now I thought,
> that submitted gc2145 bindings will be the same for DVP and CSI-2
> support and therefore submitted this change.
> 
> Are they? Or should I introduce bus-type and conditionally
> handle requirements in yaml if link-frequencies can be ignored for DVP?
> 
> Something link this
> ```
>         properties:
>           link-frequencies: true
> 
>           bus-type:
>             enum:
>               - 4 # CSI-2 D-PHY
>               - 5 # Parallel
> 
>         required:
>           - bus-type
> 
>         allOf:
>           - if:
>               properties:
>                 bus-type:
>                   const: 4
>             then:
>               required:
>                 - link-frequencies
> ```
> 
> Should I better submit DVP support to the gc2145 driver first and only then
> submit this change? 

That sounds like a good approach.

> > >
> > >  [...]
> > >
> > > +&i2c_csi {
> > > +	gc2145: front-camera@3c {
> > > +		compatible = "galaxycore,gc2145";
> > > +		reg = <0x3c>;
> > > +		clocks = <&ccu CLK_CSI_MCLK>;
> > > +		clock-names = "xclk";
> 
> That should be removed to fix
> ```
> front-camera@3c: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> ```

Yes. The driver uses gc2145->xclk = devm_clk_get(dev, NULL); without a clock
name. So setting one here is superfluous.

kind regards,
	o.

