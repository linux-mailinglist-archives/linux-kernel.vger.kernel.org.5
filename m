Return-Path: <linux-kernel+bounces-33648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F3836CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4766E1F26D02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430696312A;
	Mon, 22 Jan 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="qUQJeHqi";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="O+VHH8W5"
Received: from mailrelay3-1.pub.mailoutpod3-cph3.one.com (mailrelay3-1.pub.mailoutpod3-cph3.one.com [46.30.211.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C24D58D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939434; cv=none; b=oNVfnjXyE3KT67MD6502BnEG2gpxbUTM8SRVBUDXCu2dCa7iRV76IVY1lG6w08PdaapvsWf/gXTkE8uBNVJZ2+uIG7zdmVnqYdrCeeDrxdwRGpp8mvfR1xJuOYdjYe/h2Zd5wdEyQzAPpiUTeJ5ZhQMXqql7TiwTfMoC0/ZNdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939434; c=relaxed/simple;
	bh=9D6ZQ2OZuJf5dffwus791inA7wfTVtusm8V+mFb8C0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osiTA+D9UzZQwLQSX8/f+dfGiK3Su0wg7OTrWq5Oo+/ecplArPM32YAgJJRNvbrRjfu3SWZqcMkoYW8LojToNkqqKHBtkew/Xnu5RrJROGcpDDGKU3dA/aR+GFwtZfYKPV+3gVT87wZOgd9VIfxn0Bol1WY/1JhAQHNrz+xOtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=qUQJeHqi; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=O+VHH8W5; arc=none smtp.client-ip=46.30.211.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=laeWsP4RFv5KrL7g+IvrtMdtqBtJukqz8LuUfm2cqgI=;
	b=qUQJeHqi1WuJ4lhrw5ihDWeVdSiAgtYVgv81VZBeIjSglVSVFt/ADgsBl119lt2Dnphw3ttzVhafa
	 uSZD4IeWk9lam27GfjTB9sXT6/ItVF6PVJe6Qygg3RUiqKGhe1+JDjPfHXCNJ7/gas8D67bQ0rY0ut
	 8g6fo9wB6JkO8jxXfdGTqT2OrwUYGFuQMfwFC1tXEW6eN9FZ/VcIlvgvONHlLuKVpMIJhLrR6hIh2K
	 km5+6hPxyTD7lTrOLkdMmXJAGWbE5je92oOEPRxcDz3nG9Wn8ROy/q9pKw+FUlSyiP5eoPhlM5oaae
	 Nc2A//Qhcf/lsvmY8q1ck6Y/vGBrDmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=laeWsP4RFv5KrL7g+IvrtMdtqBtJukqz8LuUfm2cqgI=;
	b=O+VHH8W5rEReTZpoQlWdBy6/b3ITx3LfYx2BE0xKkB0xpp/q+ziY5fGddcGdfTcRLuU5v7gq3TkFe
	 H8KNl7ZAA==
X-HalOne-ID: aac18610-b93f-11ee-b8c2-ff813d2dbafc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id aac18610-b93f-11ee-b8c2-ff813d2dbafc;
	Mon, 22 Jan 2024 16:02:42 +0000 (UTC)
Date: Mon, 22 Jan 2024 17:02:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dharma.B@microchip.com
Cc: robh@kernel.org, Linux4Microchip@microchip.com,
	linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
	dri-devel@lists.freedesktop.org, Nicolas.Ferre@microchip.com,
	Conor.Dooley@microchip.com, thierry.reding@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@tuxon.dev,
	airlied@gmail.com, lee@kernel.org, u.kleine-koenig@pengutronix.de,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	tzimmermann@suse.de, mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org, bbrezillon@kernel.org,
	linux-kernel@vger.kernel.org, daniel@ffwll.ch
Subject: Re: [PATCH v3 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240122160240.GA511247@ravnborg.org>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118193040.GA223383@ravnborg.org>
 <20240119195151.GB938671-robh@kernel.org>
 <20240120132356.GA345206@ravnborg.org>
 <6c6e4ddc-b3df-484e-961f-6efbd52defd6@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6e4ddc-b3df-484e-961f-6efbd52defd6@microchip.com>

Hi Dharma
On Mon, Jan 22, 2024 at 03:52:17AM +0000, Dharma.B@microchip.com wrote:
> On 20/01/24 6:53 pm, Sam Ravnborg wrote:
> > [You don't often get email from sam@ravnborg.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > Hi Sam & Rob,
> > Hi Dharma & Rob.
> > 
> >>> To make the DT binding backward compatible you likely need to add a few
> >>> compatible that otherwise would have been left out - but that should do
> >>> the trick.
> >>>
> >>> The current atmel hlcdc driver that is split in three is IMO an
> >>> over-engineering, and the driver could benefit merging it all in one.
> >>> And the binding should not prevent this.
> >>
> >> I agree on all this, but a conversion is not really the time to redesign
> >> things. Trust me, I've wanted to on lots of conversions. It should be
> >> possible to simplify the driver side while keeping the DT as-is. Just
> >> make the display driver bind to the MFD node instead. After that, then
> >> one could look at flattening everything to 1 node.
> > 
> > Understood and thinking a bit about it fully agreed as well.
> > Dharma - please see my comments only as ideas for the future, and
> > ignore them in this fine rewrite you do.
> > 
> >          Sam
> Based on your insights, I'm contemplating the decision to merge Patch 2 
> [PWM binding] with Patch 3[MFD binding]. It seems redundant given that 
> we already have a PWM node example in the MFD binding.
> 
> Instead of introducing a new PWM binding,
>    pwm:
>      $ref: /schemas/pwm/atmel,hlcdc-pwm.yaml
> 
> I will update the existing MFD binding as follows:
> 
> properties:
>    compatible:
>      const: atmel,hlcdc-pwm
> 
>    "#pwm-cells":
>      const: 3
> 
> required:
>    - compatible
>    - "#pwm-cells"
> 
Good idea, this looks like a nice simplification.

	Sam

