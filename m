Return-Path: <linux-kernel+bounces-68706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5EC857EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED351F218CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857512C7F5;
	Fri, 16 Feb 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TemEtxZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE959B5F;
	Fri, 16 Feb 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092519; cv=none; b=cdwhpkZuYRatqSRMhFjzxwUKrGUKADNhgxZ5lNjc+OQtAYBZ8FpsH3EuWysCgnxDWV5N+DAAGMMVaSP7ZL16ZNKAgwA1MzGmA0od4N2ng1Lqb6/8+XH5QF23npOTEMWWFmLJILIY6dsVwsZrKm8TMgVWu9bB5gPFbEY1b+QCP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092519; c=relaxed/simple;
	bh=URft1yFNooeHjgEuV5zJYSSsgebVw7/oaikTAzwc7HY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzDJe8gzJBdWxantCJJFbvqNNAUQnLAxr3F5g0eZUIJQaNW5Ycj7EoRuidv8cL81tnJBU0crkKZ/+bAk1aFTbNofrV9IrqE3LXb0Q+oe4hQ97ztQQMQ/kdy01e1Y2sU44N4gTjFOo8cq2ScDF0yMPMCly8Xten53y6FQhca60z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TemEtxZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A7CC433F1;
	Fri, 16 Feb 2024 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092518;
	bh=URft1yFNooeHjgEuV5zJYSSsgebVw7/oaikTAzwc7HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TemEtxZvXL3MtNaqtsE44bHlpFma7OYlRBd7d9HhpQx5e5uUjFuec2rr/BPGaoA9b
	 qKXRUN1VIJlE6UV6N7Vg1HduKnWyHxBliIiw4js/LhN2C+p9mRd8zVSXOMyzH8uTs7
	 kpuCoCP4a6qBIq6fvj+6OHq6Tori37riWp2JYLyXxO4CJT/uT0V44SYy6nDRMWNBOE
	 YWrRYVOXsw9lxHEZIImnFdXSlf6XnMDCPguDceCO31PiMwFud7OXqqG80CIv3Rmi2U
	 NndgxRpehHGvOMjozYXlP6JIhVGEpoFlE3Xifi9ix+QXgNAyLzecSNPWvXLWHiYR/i
	 oy1DHzBsMpbhg==
Date: Fri, 16 Feb 2024 14:08:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240216140826.58b3318d@jic23-huawei>
In-Reply-To: <CAMknhBF8HKDftjBuwuA4GWUmn4j36Zut84d7xLKgZPDaiY87kA@mail.gmail.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	<20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
	<20240210174022.7a0c7cdc@jic23-huawei>
	<CAMknhBF8HKDftjBuwuA4GWUmn4j36Zut84d7xLKgZPDaiY87kA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +  adi,spi-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ 3-wire, 4-wire, chain ]
> > > +    default: 4-wire
> > > +    description:
> > > +      This chip can operate in a 3-wire mode where SDI is tied to VIO, a 4-wire
> > > +      mode where SDI acts as the CS line, or a chain mode where SDI of one chip
> > > +      is tied to the SDO of the next chip in the chain and the SDI of the last
> > > +      chip in the chain is tied to GND.  
> >
> > there is a standard property in spi-controller.yaml for 3-wire. Does that cover
> > the selection between 3-wire and 4-wire here?  Seems like this might behave
> > differently from that (and so perhaps we shouldn't use 3-wire as the description
> > to avoid confusion, normally 3-wire is a half duplex link I think).  
> 
> I used "3-wire" because that is what the datasheet calls it. But yes,
> I see the potential for confusion here since this "3-wire" is
> completely unrelated to the standard "spi-3wire" property.
Maybe we fall back on a comment that says something like.

"This is not the same as spi-3wire." :)

Whatever we end up with here, I'd like everyone to agree it's
obviously different enough from existing SPI bindings that there won't
be any confusion. 

> 
> >
> > Chain mode is more fun.  We've had that before and I'm trying to remember what
> > the bindings look like. Devices like ad7280a do a different form of chaining.  
> 
> If there isn't a clear precedent for how to write bindings for chained
> devices, this may be something better left for when there is an actual
> use case to be sure we get it right.

Agreed.  Let us kick that into the future.

> 
> >
> > Anyhow, main thing here is we need to be careful that the terms don't overlap
> > with other possible interpretations.
> >
> > I think what this really means is:
> >
> > 3-wire - no chip select, exclusive use of the SPI bus (yuk)  
> 
> This can actually be done two ways. One where there is no CS and we
> use cnv-gpios to control the conversion. The other is where CS of the
> SPI controller is connected to the CNV pin on the ADC and cnv-gpios is
> omitted. This requires very creative use of spi xfers to get the right
> signal but does work.
> 
> In any case to achieve max sample rate these chips need to use this
> "3-wire" mode and have exclusive use of the bus whether is is using
> proper CS or not.
> 
> So maybe it would be more clear to split this one into two modes?
> 3-wire with CS and 3-wire without CS?
OK.

I'm not sure if the standard SPI bindings have an option for
CS tied active?  If so we should reuse that bit of [psson;e/

> 
> > 4-write - conventional SPI with CS  
> 
> Yes.
> 
> > chained - the 3 wire mode really but with some timing effects?  
> 
> Correct. With the exception that the SPI CS line can't be used in
> chain mode (unless maybe if you had an inverted CS signal since the
> CNV pin has to be high during the data transfer).
> 
> >
> > Can we figure out if chained is going on at runtime?  
> 
> No. We would always need the devicetree to at least say how many chips
> are in the chain. Also, in theory, each chip could have independent
> supplies and therefore different reference voltages.
That's one I think we only bother supporting when we actually see it.
For previous chained devices I don't think we've ever needed to do
it because they tend to be used for 'more of the same' rather than
measuring different things.  Supplies so far have always been wired
to single regulator (or single control anyway).


> >
> > If we are going to rule you supplying refin and ref supplies.  
> 
> Not sure what you mean here, but we can get rid of the adi,reference
> property and just add a check to not allow both ref-supply and
> refin-supply at the same time.

I think that is simplest route.

> 
> >  
> > > +
> > > +  cnv-gpios:
> > > +    description:
> > > +      The Convert Input (CNV). This input has multiple functions. It initiates
> > > +      the conversions and selects the SPI mode of the device (chain or CS). In
> > > +      3-wire mode, this property is omitted if the CNV pin is connected to the
> > > +      CS line of the SPI controller.
> > > +    maxItems: 1  
> >
> > ah, that's exciting - so in 3-wire mode, we basically put the CS on a different pin...  
> 
> I explained this above already, but just to have it in context here as
> well... In what the datasheet calls "3-wire" mode, we can either have
> CS connected and no cnv-gpios or we can have no CS and have cnv-gpios
> connected.
> 
> So the intention here was to make cnv-gpios required all other modes
> but in 3-wire mode, make it optional.

Seems reasonable. Thanks for the various explanations. This chip is just odd :)

> 
> 
> >
> > Mark, perhaps you can suggest how to handle this complex family of spi variants?
> >
> > Jonathan
> >  


