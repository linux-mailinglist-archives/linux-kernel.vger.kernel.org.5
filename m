Return-Path: <linux-kernel+bounces-31582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65683305B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930F81C216D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8F158121;
	Fri, 19 Jan 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="GjhB6wRa";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="5hc1wO07"
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE757330
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700100; cv=none; b=ju5SLLUWmmgnTnytQf7b49NChEP97a+E0Ck8ZLzmtbVw9FGz9YG5Bk1s9MEICoLhFFmolVipj9q59PZX8Kf+LerrNdp0NY0Q3JZaNvn3XH8j1qRnejGeq6vcIFosXgC6IUJcd6DX7BAQp7Aq0JJ03eloYgGiJKjlubQFzIGkDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700100; c=relaxed/simple;
	bh=UNNRJRbDTngtJ5Pl/++i0CkHx4pdPunpIhyAAGeoHB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3luCX10OyqU7rj34xIwAkbIq6lGeo+vWWjA+rXLfGJXTOt/0Av1l/UaoCIiYRWyZ3m8MpSPxDo25tlWhn1r3dq399opUD8kAGvw4DxyRikzOD0ARTS6HTHDPFSlYIB9QUgk2zD3AfFv8GDNWrUfDc9U5H52Ms8n7Ztr2xhZBzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=GjhB6wRa; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=5hc1wO07; arc=none smtp.client-ip=46.30.211.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=pO8iBfnjG9hH6vbSRTnXqbEv232F90DY50ha8PvFEd8=;
	b=GjhB6wRaysDcllp1zsaNynkQl6JNvD+hw2s6dm55JB+H5rGwsfSuOcZwCpp/lTxl/tW2aDNE3z5MN
	 cCvOWaF/N+ToEspVuSSnuBo8lOkUaVrjwSwe9Mao6GtlEfGoyVttyZq4CzBCuxJBNVPwITHT+XDF/d
	 xCmbQtnQjMmh5WAe3LGVVn7hMkGrIbRdPEifGr3r3e5Vk0aYqyWLs8EoJEg0BLnf0pRNxtqOpifSLP
	 DVUq8fj27NFfrJ8Zz/XqxG80zSTseJDWRryFpPf4WZbhGKwSVmENvDTHhLLoa0JpcuEViBFLJCmpXh
	 r9GP2gowfi3qn7OXJhAZxLkYdx+O+5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=pO8iBfnjG9hH6vbSRTnXqbEv232F90DY50ha8PvFEd8=;
	b=5hc1wO07ZIzFI0AGFuC0N6Bpa19KNWG4JJyX/eWazj1u2M5PzREmbIABVmM0wXHM4e5cZxcwJvtgo
	 tXdJqTLCQ==
X-HalOne-ID: 6d92ffab-b712-11ee-b81e-dfbeffc51846
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 6d92ffab-b712-11ee-b81e-dfbeffc51846;
	Fri, 19 Jan 2024 21:33:48 +0000 (UTC)
Date: Fri, 19 Jan 2024 22:33:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dharma.B@microchip.com
Cc: Linux4Microchip@microchip.com, linux-pwm@vger.kernel.org,
	alexandre.belloni@bootlin.com, dri-devel@lists.freedesktop.org,
	Nicolas.Ferre@microchip.com, Conor.Dooley@microchip.com,
	thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	claudiu.beznea@tuxon.dev, airlied@gmail.com, lee@kernel.org,
	u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
	conor+dt@kernel.org, tzimmermann@suse.de, mripard@kernel.org,
	robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
	daniel@ffwll.ch
Subject: Re: [PATCH v3 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240119213347.GA304371@ravnborg.org>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118193040.GA223383@ravnborg.org>
 <e308b833-8cfe-41c0-954e-f1470108394a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e308b833-8cfe-41c0-954e-f1470108394a@microchip.com>

Hi Dharma,

On Fri, Jan 19, 2024 at 08:41:04AM +0000, Dharma.B@microchip.com wrote:
> Hi Sam,
> On 19/01/24 1:00 am, Sam Ravnborg wrote:
> > [You don't often get email from sam@ravnborg.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Dharma et al.
> > 
> > On Thu, Jan 18, 2024 at 02:56:09PM +0530, Dharma Balasubiramani wrote:
> >> Converted the text bindings to YAML and validated them individually using following commands
> >>
> >> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> >> $ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> >>
> >> changelogs are available in respective patches.
> >>
> >> Dharma Balasubiramani (3):
> >>    dt-bindings: display: convert Atmel's HLCDC to DT schema
> >>    dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
> >>    dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> > 
> > I know this is a bit late to ask - sorry in advance.
> > 
> > The binding describes the single IP block as a multi functional device,
> > but it is a single IP block that includes the display controller and a
> > simple pwm that can be used for contrast or backlight.
> yes.
> > 
> > If we ignore the fact that the current drivers for hlcdc uses an mfd
> > abstraction, is this then the optimal way to describe the HW?
> > 
> > 
> > In one of my stale git tree I converted atmel lcdc to DT, and here
> Are you referring the "bindings/display/atmel,lcdc.txt"?
Correct.

> > I used:
> > 
> > +  "#pwm-cells":
> > +    description:
> > +      This PWM chip use the default 3 cells bindings
> > +      defined in ../../pwm/pwm.yaml.
> > +    const: 3
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    maxItems: 2
> > +    items:
> > +      - const: lcdc_clk
> > +      - const: hclk
> > 
> > This proved to be a simple way to describe the HW.
> > 
> > To make the DT binding backward compatible you likely need to add a few
> > compatible that otherwise would have been left out - but that should do
> > the trick.
> again you mean the compatibles from atmel,lcdc binding?

If the new binding describes the full IP, as I suggest, then I assume
you need to add the compatible "atmel,hlcdc-pwm" to be backward
compatible. Otherwise users assuming the old binding will fail to find
the pwm info. I am not sure how important this is - but at least then
the device trees can be updated out of sync with the current users.

I hope this explains what I tried to say, otherwise do not hesitate to
get back to me.

	Sam

