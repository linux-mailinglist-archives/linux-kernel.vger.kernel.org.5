Return-Path: <linux-kernel+bounces-78607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3418615CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6915C2836AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27ED82864;
	Fri, 23 Feb 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="BU34EUMB"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112C10A3E;
	Fri, 23 Feb 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702143; cv=none; b=d++wb8kO1fBJZS4DRlxcBwpRN5pNUX5FskHyLq3YrANuv9pk/m2CClJ6fiiD3bC0lcAKN3zs5jGjcPGExwPgnBFhkaUhiJOgJn2fTmAz4N9Bi8SOQLBd0/bBd50J6nR+gABvTcnmJmz6Vhms/KprKk017ic9ehbIrBbbJtFljvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702143; c=relaxed/simple;
	bh=25P7JcxoGTkRa2dDDX/BuiwaEg9vmsf9zGtQolf4VMo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhowyCPTbwQVW8dtIL2jho4sIQ4pG9mGqdo84sFp1lH28z6zUTlkvSkHD1VA3joa4ub6PIGaH3OtD+umdbsPd2ms7fa43uixti/mlNAsJb4JakoKG79CSW9uIdhpq4WKlNvl14v313jM5hwbiv1kmZTjSpnVQLWpptkfMVStCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=BU34EUMB; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 46802401E9;
	Fri, 23 Feb 2024 15:22:38 +0000 (UTC)
Date: Fri, 23 Feb 2024 10:22:36 -0500
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor
 led node
Message-ID: <5hqfabcolgqcu22hs3xnaimojwuz26tzi63px3rvbsgxa6kjss@ik42w7k26see>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-3-aren@peacevolution.org>
 <sixgkkllo7medcjwjnmbkpqkgfvnmrtlhlwarwuxid5oqwrht5@gl65b6fetq2b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sixgkkllo7medcjwjnmbkpqkgfvnmrtlhlwarwuxid5oqwrht5@gl65b6fetq2b>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1708701759;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=/xPGKWu8KokBiTM1Ns88qRxeRkPSchgepjKoxnDo5og=;
	b=BU34EUMBKkMZj9cFgixCr6e8kpnC8CmyEaBxEXatlZ2lG+RNvZsrr/0A4pL7+pm6xSWq+Q
	hOCt2IrL/F7WJ5gastagvM/VAtEtUP5tI4RV7wNQSsFi4M2uBQR51LvKarznrxWXngCX+x
	ZaHL352QGXXAhOgqBatwFmIpHh816mM=

On Fri, Feb 23, 2024 at 09:46:25AM +0100, Ondřej Jirman wrote:
> Hello Aren,
> 
> On Tue, Feb 06, 2024 at 01:13:19PM -0500, Aren Moynihan wrote:
> > The red, green, and blue leds currently in the device tree represent a
> > single rgb led on the front of the PinePhone.
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > 
> > Changes in v2:
> >  - remove function property from individual led nodes
> > 
> >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index ad2476ee01e4..e53e0d4579a7 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -39,28 +39,32 @@ chosen {
> >  	leds {
> >  		compatible = "gpio-leds";
> >  
> > -		led-0 {
> > -			function = LED_FUNCTION_INDICATOR;
> 
> This looks like a needless change that will just break people's current scripts
> and setup. It does mine, and there sure are others that will be surprised, too.
> 
> This leads to a change in sysfs path from:
> 
>   /sys/class/leds/blue:indicator
> 
> to
> 
>   /sys/class/leds/blue:
> 
> which is 1) a weird name and 2) a backwards compatibility break for seemingly
> no apparent reason. Any reaons for the change?

Leds-group-multicolor will make those read-only, so that will break when
it's enabled either way. Removing the function property makes it less
likely that programs attempting to discover leds will use the wrong
path.

I left these in v1 of this patch, but was recommended to remove them.
https://lore.kernel.org/lkml/k26bellccok4tj3kz2nrtp2vth2rnsiea677e2kzm56m767wjx@pnkqiz5hmiyb/

Thanks for taking a look at this
 - Aren

> People normally hardcode these paths in eg. /etc/tmpfiles.d to apply LED triggers
> to particular LEDs.
> 
> Kind regards,
> 	o.
> 
> > +		led0: led-0 {
> >  			color = <LED_COLOR_ID_BLUE>;
> >  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> >  			retain-state-suspended;
> >  		};
> >  
> > -		led-1 {
> > -			function = LED_FUNCTION_INDICATOR;
> > +		led1: led-1 {
> >  			color = <LED_COLOR_ID_GREEN>;
> >  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> >  			retain-state-suspended;
> >  		};
> >  
> > -		led-2 {
> > -			function = LED_FUNCTION_INDICATOR;
> > +		led2: led-2 {
> >  			color = <LED_COLOR_ID_RED>;
> >  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> >  			retain-state-suspended;
> >  		};
> >  	};
> >  
> > +	multi-led {
> > +		compatible = "leds-group-multicolor";
> > +		color = <LED_COLOR_ID_RGB>;
> > +		function = LED_FUNCTION_INDICATOR;
> > +		leds = <&led0>, <&led1>, <&led2>;
> > +	};
> > +
> >  	reg_ps: ps-regulator {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "ps";
> > -- 
> > 2.43.0
> > 

