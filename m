Return-Path: <linux-kernel+bounces-47497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D928E844EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B791C2AC50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAB4A2E;
	Thu,  1 Feb 2024 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="XwksY1+h"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A061442A;
	Thu,  1 Feb 2024 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750918; cv=none; b=HFj2DR9tOd8dNPLUaIU30c3/7LbNPA7GMIxpSmgmZin6LlQys3LEMyD7qiTeGTrH23a4KLj7/FL2VdFBwQTRb/ikndx10EEeI+1EWrajJ2HNdsLYe5UqM2qXkb/gEmC7Oy0S8r33Buf5wbDMbv67xCPIwSI8DNHgwGjzufWopj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750918; c=relaxed/simple;
	bh=DKwMhOah1OGnoYC5YOW3jNwpZGhwqN1yjEEOJIn4jyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFRxcp+ppP4c1L9STFfFxV+MfH7Z+xOpodoB0w+2OmieCLviA4u5IqRcp2Ux6P2OsHGuzXMGhPI2WrrI3pSkb0601DHMx6FJOAHvhIB5LGT2PKF74vnulme70/5iRrYPQMXJMe2vgjm1wtNDtvlhDG8DUbXw5mZNpvsH1A+SDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=XwksY1+h; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 25A3E4661F;
	Thu,  1 Feb 2024 01:28:28 +0000 (UTC)
Date: Wed, 31 Jan 2024 20:28:25 -0500
From: Aren <aren@peacevolution.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miles Alan <m@milesalan.com>, 
	Ondrej Jirman <megi@xff.cz>, Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor led
 node
Message-ID: <k26bellccok4tj3kz2nrtp2vth2rnsiea677e2kzm56m767wjx@pnkqiz5hmiyb>
References: <20240128204740.2355092-1-aren@peacevolution.org>
 <20240128204740.2355092-3-aren@peacevolution.org>
 <4864457.GXAFRqVoOG@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4864457.GXAFRqVoOG@jernej-laptop>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706750909;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=PPAWFE9Bpec9jEfmyA4G2telwXR9/4WoySxFZmwvO+w=;
	b=XwksY1+hGkHS+kXrChX85zoriu+GswucV939ztBtj7VLQC0OPz0dwlWKuZvJH1TlQRIi2l
	1Gjf3ZwIYWUYBvF8yFdN82tavjLHH4iWy3Wrv0fsTbxLlrhlEHJ1FRod+AHb2bhyqZbSWU
	MxD0r1vLZQDdd5KWeyzp0kOAs4XVxiQ=

On Tue, Jan 30, 2024 at 08:41:14PM +0100, Jernej Škrabec wrote:
> Dne nedelja, 28. januar 2024 ob 21:45:09 CET je Aren Moynihan napisal(a):
> > The red, green, and blue leds currently in the device tree represent a
> > single rgb led on the front of the PinePhone.
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > 
> >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi    | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index ad2476ee01e4..6eab61a12cd8 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -39,21 +39,21 @@ chosen {
> >  	leds {
> >  		compatible = "gpio-leds";
> >  
> > -		led-0 {
> > +		led0: led-0 {
> >  			function = LED_FUNCTION_INDICATOR;
> >  			color = <LED_COLOR_ID_BLUE>;
> >  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> >  			retain-state-suspended;
> >  		};
> >  
> > -		led-1 {
> > +		led1: led-1 {
> >  			function = LED_FUNCTION_INDICATOR;
> >  			color = <LED_COLOR_ID_GREEN>;
> >  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> >  			retain-state-suspended;
> >  		};
> >  
> > -		led-2 {
> > +		led2: led-2 {
> >  			function = LED_FUNCTION_INDICATOR;
> >  			color = <LED_COLOR_ID_RED>;
> >  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> > @@ -61,6 +61,13 @@ led-2 {
> >  		};
> >  	};
> >  
> > +	multi-led {
> > +		compatible = "leds-group-multicolor";
> > +		color = <LED_COLOR_ID_RGB>;
> > +		function = LED_FUNCTION_INDICATOR;
> 
> Does it make sense to have function specified here and above? Example
> specifies it only in multi-led node.

I'm not sure it makes much of a difference, besides perhaps confusing
userspace. From what I can tell the only thing it'll change is the name
of the directory in sysfs from "<color>:status" to "<color>:". I'll
change this in v2 unless anyone has a reason not to.

Thanks
 - Aren

> Best regards,
> Jernej
> 
> > +		leds = <&led0>, <&led1>, <&led2>;
> > +	};
> > +
> >  	reg_ps: ps-regulator {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "ps";

