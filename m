Return-Path: <linux-kernel+bounces-33654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58360836D73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F87B324B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F24D594;
	Mon, 22 Jan 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="HZRfxWW7";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="bKfCDk0H"
Received: from mailrelay4-1.pub.mailoutpod3-cph3.one.com (mailrelay4-1.pub.mailoutpod3-cph3.one.com [46.30.211.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9D64ABD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939546; cv=none; b=sxYBFYzdk43oxslr431myprvaXQbTBJVURBHsLJRRxlFmnGihynXPufWR9JGYIraZGdjZc2SHXfgp9jKFHyEIu99RghQPJow5DpteNQXh4KLFhvmyiO7GqbwirI92Yzy/6zpGpAwEE5hcLrYJ3VmztxqV2+u93/FWPs378EuM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939546; c=relaxed/simple;
	bh=z9kt8zQbM3eNnFmXEo3654lPUSRiE75PpypTs9NBlKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf/3uD5MQkLVDL1qVem8ed+5bzI3/PkouSauVW765xTMTcRnXoZ7eCUjckPbeb2lwRt3qEfCL+XSt/nFFFiZRUi9+Q9t56Yao/B+0yuwIcEW9AfXVEMkj98SIKRd2XuEEDVkY9p/WjiImSJ8nG758RyT/WSUphEx8AJba7mOL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=HZRfxWW7; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=bKfCDk0H; arc=none smtp.client-ip=46.30.211.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=xAGeSXO7EYCYJmljPUEN1rFUpiw71f4rCC8gSgFu1n8=;
	b=HZRfxWW7RKvIzlLrWQDFVCTBUG5Jn1GeeZVFbfHhTfHQ1bK6ANABb9Ao3YCp7+9OkCan+DgMbN0gB
	 7Z6KlrAcBHvLa52KHKbxsUqobDFzMYHyLl6dfJGWrIEFQIKuMaMeLya7L4Eh72a62yQva2BsUtXYIi
	 +gdaDjCy4jtdh6K9Xj57QU5JN2kgd5whs5nSSgDF4oLqiLpM91y1BC+FQTSm91Qy+iPBuudeeBL0By
	 3oqdvR5O2eBoJfSzKzc2UkKgr4HXz9su5ap3kEIpK0h0Q+C7KIITFpAYbR3Qv8tCLRpzgdQthfnm38
	 QbWPO99YbFnwplbHV2K64bQXu/dELTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=xAGeSXO7EYCYJmljPUEN1rFUpiw71f4rCC8gSgFu1n8=;
	b=bKfCDk0HafSg+g3RaIu9TrzIt2gHb++4e++SaoHzG8BuWLN7Mzyav7YHusF+tvo7FeLOMboYIg9IK
	 gXQFr1jBg==
X-HalOne-ID: ee3a7b61-b93f-11ee-a7a3-9f04b458b84a
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id ee3a7b61-b93f-11ee-a7a3-9f04b458b84a;
	Mon, 22 Jan 2024 16:04:34 +0000 (UTC)
Date: Mon, 22 Jan 2024 17:04:33 +0100
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
Message-ID: <20240122160433.GB511247@ravnborg.org>
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

Hi Dharma,
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
As already commented, this looks nice.
But as Rob said, this should be a 1:1 conversion from text to yaml,
and then clean-up can come in the second step.

	Sam

