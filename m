Return-Path: <linux-kernel+bounces-31526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF3832F86
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E991C234B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972F5646F;
	Fri, 19 Jan 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM2M331s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221265644C;
	Fri, 19 Jan 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693914; cv=none; b=qrYbkd/dK+sqOlp8YygoE6/LJF9QvGAIZfYRVUXs06175JW0N6Ah+f9//Ssm6E8DKiBXNDkGHsmLB32HgJFOWJOChRLA45OIp9Dnb0ogrIGg9m++L+wZ3nvnrDcYnt/E1yxOfRqswj7LsbYN1tOLZdhiBU2lRBvf020Do7X3VUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693914; c=relaxed/simple;
	bh=V/giPsLnDjrj1zV7DERx2IXZKAyhH88rKKkf5QFcqUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP7ut4h4FsRUYabQ+8qfOMmAse6Rx7YKcu9NvvsSChjtVBPc8q2V/8yE5ER073PjvYh3+dVmj//KYf63qce1527hh/4/7EoIQ/Bej/dxAqhT78ArU7S58c2Oj21ef+00ujOigzTElyzdNFpp3XMlLTFjN/aZLxzN/jtD1KoEf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM2M331s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB04C433F1;
	Fri, 19 Jan 2024 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705693913;
	bh=V/giPsLnDjrj1zV7DERx2IXZKAyhH88rKKkf5QFcqUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MM2M331sZCqze2pBHsSkXYXRwFFz+7F13kgvKu8biiY3cZoImBNdsLDtQVpOFlK1p
	 +Szq70+Q4GmioBk5W1BC34gr/z4wheZ6OCJ2Bmcj7MBaoso/yTbf630iIPDj9643gS
	 ilHqJeQdFLF8lvBudaYjWpyIlMBkHG5I9fWzg9lhd5daZHla2oHwkfXGEzGA84uEjt
	 sDlfFUkV34VFBQSdTXkP/t02fnQ6BMWMP4ydsU5yVjCMUqzV0ZGGDRPXJb669zxPX0
	 sPOrTcK1LxKGpVfO2SmPe/pfILd08TaHie75ZHIS7U9FqYBXwgtefpOzyXsYVpEmFu
	 TFrFSybHeB9PA==
Date: Fri, 19 Jan 2024 13:51:51 -0600
From: Rob Herring <robh@kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>,
	conor.dooley@microchip.com, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, linux4microchip@microchip.com
Subject: Re: [PATCH v3 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240119195151.GB938671-robh@kernel.org>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118193040.GA223383@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118193040.GA223383@ravnborg.org>

On Thu, Jan 18, 2024 at 08:30:40PM +0100, Sam Ravnborg wrote:
> Hi Dharma et al.
> 
> On Thu, Jan 18, 2024 at 02:56:09PM +0530, Dharma Balasubiramani wrote:
> > Converted the text bindings to YAML and validated them individually using following commands
> > 
> > $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> > $ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> > 
> > changelogs are available in respective patches.
> > 
> > Dharma Balasubiramani (3):
> >   dt-bindings: display: convert Atmel's HLCDC to DT schema
> >   dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
> >   dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> 
> I know this is a bit late to ask - sorry in advance.
> 
> The binding describes the single IP block as a multi functional device,
> but it is a single IP block that includes the display controller and a
> simple pwm that can be used for contrast or backlight.
> 
> If we ignore the fact that the current drivers for hlcdc uses an mfd
> abstraction, is this then the optimal way to describe the HW?
> 
> 
> In one of my stale git tree I converted atmel lcdc to DT, and here
> I used:
> 
> +  "#pwm-cells":
> +    description:
> +      This PWM chip use the default 3 cells bindings
> +      defined in ../../pwm/pwm.yaml.
> +    const: 3
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    maxItems: 2
> +    items:
> +      - const: lcdc_clk
> +      - const: hclk
> 
> This proved to be a simple way to describe the HW.
> 
> To make the DT binding backward compatible you likely need to add a few
> compatible that otherwise would have been left out - but that should do
> the trick.
> 
> The current atmel hlcdc driver that is split in three is IMO an
> over-engineering, and the driver could benefit merging it all in one.
> And the binding should not prevent this.

I agree on all this, but a conversion is not really the time to redesign 
things. Trust me, I've wanted to on lots of conversions. It should be 
possible to simplify the driver side while keeping the DT as-is. Just 
make the display driver bind to the MFD node instead. After that, then 
one could look at flattening everything to 1 node.

Rob

