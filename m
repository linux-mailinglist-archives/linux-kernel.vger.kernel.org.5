Return-Path: <linux-kernel+bounces-82861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BB868AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4625C288187
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868605646B;
	Tue, 27 Feb 2024 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HPa8SG1g"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B15380F;
	Tue, 27 Feb 2024 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022394; cv=none; b=s7/2vwDJ2iPI68C13+fSwXqr0Zf++YPLvU4u0MX/zO7VnYYKN+b2S6lfj+vRi6OV6ddBQ+kxoNR0X2m2ozdTlg2niKyeLPN8BHS2iTECQuQIPNFZ93Ny52SGZPl7SrkXIyHlKZ2VVLDj3bkim3Fhiuui8zAFzfURxEE+S/z470A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022394; c=relaxed/simple;
	bh=KAuIHPXGoMr08+UmMoqAbTtZUnHXBoqJWfTMLOUO4Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/Sd9El+tx/X9mD+v4+H6l+QocoV1mi0fBB6t0gRUEdg/0KvSnIAgy5hHx9bqxtkAW1vk/JSCI80lKHsdurGgi7UzrHh5c5gsK3mBDicbKarMt2IV1bY1HTGdRPrPr7cd+8MsxjHT4VhDonqUhXLu4+3Jrri6vGHluyk772Q6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HPa8SG1g; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0695F4000C;
	Tue, 27 Feb 2024 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709022388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0sG1VtgE73QC07jrlA2cghwd9sO1spHGldFaWOgSDY=;
	b=HPa8SG1gzofjEXTtvQECub3nbC1pFlaSg/+s67PXpFqKkfoD5aZXRxT7+rPHBAbZvtOtI+
	t7xUqR0wmGJ/+aA4w3C695A+NHZaOHZEjpMga2ndipUcx8aVuS90weh/0NKGhErr/APgmx
	lc6gmcVj/U5zScde6aA5jTPJil8NCJYM1+URLMbFXt8/e0FD0FqV0ooXLpdQkoeYW36o4k
	MWaoFQKo422hYYZYBCbx5u5Mnvi8fcaoI1QvofnjMRWP8911R/ZbKiH0STRRrG6Fj6qaT9
	/okK8KNJe0tTPfYdnBsEj+5EF0FOKd9x4kK8Ng1lkQans63k8KVRMCBZD8iKDw==
Date: Tue, 27 Feb 2024 09:26:27 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Saravana Kannan <saravanak@google.com>, Kent Gibson
 <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240227092627.23b883c5@bootlin.com>
In-Reply-To: <CAGETcx_j4613QjHgX5AJ96Ux6MJSxxhT7DL36yzNv1JCsoxTAA@mail.gmail.com>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
	<20240220111019.133697-3-herve.codina@bootlin.com>
	<20240220142959.GA244726@rigel>
	<20240222005744.GA3603@rigel>
	<20240222010530.GA11949@rigel>
	<CAMRc=MdCm4UXMkzvG17Vd=6ajE+feihgYc66qUNTTKXhN0--dA@mail.gmail.com>
	<20240222123615.2cbada98@bootlin.com>
	<CAMRc=McTkVPD-1_5vvPcM2Q15=w+ocki2xTmvQzU-o395A930w@mail.gmail.com>
	<CAGETcx_j4613QjHgX5AJ96Ux6MJSxxhT7DL36yzNv1JCsoxTAA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bartosz

On Thu, 22 Feb 2024 15:51:15 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Thu, Feb 22, 2024 at 4:21 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
..
> > > >
> > > > The fix for the user-space issue may be more-or-less correct but the problem is
> > > > deeper and this won't fix it for in-kernel users.
> > > >
> > > > Herve: please consider the following DT snippet:
> > > >
> > > >       gpio0 {
> > > >               compatible = "foo";
> > > >
> > > >               gpio-controller;
> > > >               #gpio-cells = <2>;
> > > >               interrupt-controller;
> > > >               #interrupt-cells = <1>;
> > > >               ngpios = <8>;
> > > >       };
> > > >
> > > >       consumer {
> > > >               compatible = "bar";
> > > >
> > > >               interrupts-extended = <&gpio0 0>;
> > > >       };
> > > >
> > > > If you unbind the "gpio0" device after the consumer requested the interrupt,
> > > > you'll get the same splat. And device links will not help you here (on that
> > > > note: Saravana: is there anything we could do about it? Have you even
> > > > considered making the irqchip subsystem use the driver model in any way? Is it
> > > > even feasible?).  
> 
> I did add support to irqchip to use the driver model. See
> IRQCHIP_PLATFORM_DRIVER_BEGIN() and uses of it.  So this makes sure
> the probe ordering is correct.
> 
> But when I added that support, there was some pushback on making the
> modules removable[1]. But that's why you'll see that the
> IRQCHIP_PLATFORM_DRIVER_BEGIN() macro set .suppress_bind_attrs = true.
> 
> Do you have a way to unregister an interrupt controller in your
> example? If so, how do you unregister it? It shouldn't be too hard to
> extend those macros to add removal support. We could add a
> IRQCHIP_MATCH2() that also takes in an exit() function op that gets
> called on device unbind.
> 
> [1] - https://lore.kernel.org/lkml/86sghas7so.wl-maz@kernel.org/#t
> 
> > > >
> > > > I would prefer this to be fixed at a lower lever than the GPIOLIB character
> > > > device.  
> > >
> > > I think this use case is covered.
> > > When the consumer device related to the consumer DT node is added, a
> > > consumer/supplier relationship is created:
> > > parse_interrupts() parses the 'interrups-extended' property
> > >   https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/property.c#L1316
> > > and so, of_link_to_phandle() creates the consumer/supplier link.
> > >   https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/property.c#L1316
> > >
> > > We that link present, if the supplier is removed, the consumer is removed
> > > before.
> > > The consumer should release the interrupt during its remove process (i.e
> > > explicit in its .remove() or explicit because of a devm_*() call).
> > >
> > > At least, it is my understanding.  
> >
> > Well, then it doesn't work, because I literally just tried it before
> > sending my previous email.  
> 
> For your gpio0 device, can you see why __device_release_driver()
> doesn't end up calling device_links_unbind_consumers()?
> 
> Also, can you look at
> /sys/class/devlink/<bus:gpio0-devicename>--<consumer device name>
> folders and see what the status file says before you try to unbind the
> gpio0 device? It should say "active".
> 
> > Please try it yourself, you'll see.
> >
> > Also: an interrupt controller may not even have a device consuming its
> > DT node (see IRQCHIP_DECLARE()), what happens then?  
> 
> Yeah, we are screwed in those cases. Ideally we are rejecting all
> submissions for irqchip drivers that use IRQCHIP_DECLARE().
> 

I have the feeling that this issue related to your gpio0 driver unbind is out of
the scope of this series.

Let move forward with the user-space fix (cdev) related to this series.
I will sent the v2 to cover the cdev case.

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

