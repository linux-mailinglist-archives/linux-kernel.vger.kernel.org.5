Return-Path: <linux-kernel+bounces-76436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C785F755
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC1C1C23410
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861247A40;
	Thu, 22 Feb 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hVPCwmQS"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AEB405D4;
	Thu, 22 Feb 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601787; cv=none; b=b9ROeWdo0Dz5NEp+mjS1xwFHL1RYGQJ2zmSZeo1hNsex3zxQ8kHnaiM2avdVico07ax9E6bbOMM+hu9PPjp9pIzIkyBbCZ5JbXMj57AtEAbKXdArV1YI+ur75iYJIGtlYGjw4Wgwor00BFy1BXCcXy80iSdphhV+/GUcOj/0Bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601787; c=relaxed/simple;
	bh=Nq5AC/M/SyoGFJBpxXGvnqX2nW9FIGfWcanhZYMjTio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYIXuPYjEw7YdlAxODYWfcy/oi/q/7SAeHy29r0u4di4L38e2uMIZkEHToK+J0fd9WP/yg2m7yyJEJ9d8tUaBjHrw1GkKNmMoQRNtLCeXPHFrH3IJ45mov8ddBa6QjHeFiTufvIeIy3coRhShLwhlR+AuWNqYnX0/c5AtoQahHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hVPCwmQS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF9471C0003;
	Thu, 22 Feb 2024 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708601776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maOFycEoHJZpXjV4st8F3wfV32IoWjfu72XKDbdjfwo=;
	b=hVPCwmQSoeoUKbWUs1Ur9iVK0qZEx/otlw7f6S/vyZcezk6GhfjjgCPYREND+Z0VzugqP2
	rn2BMSz4GgdJ5WOkp+bCNP8sYEpwjP+kfBdY7KCTcvzXMrw7IXetqpZJOaDVtZw97oH3mu
	ZAKscrCcb7PpkbbMRRnZQS/HMTdU7gNvjdbOuusrumIaUn1lkqLnT1eE8iza+8MkM0ZP+v
	4T3F9mewzRPWMQ1g0UqcZ1wB9Y7ieo/Nb43z6VddHRfkGiDQR29wvTS8Qcpzz6xHqCODTt
	cHFwVUGXGQVCTpWzX6oZQrHG8Gs1xBsLxT76XlZma2JiaHwv6b9Ry/4kdrhcUg==
Date: Thu, 22 Feb 2024 12:36:15 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan
 <saravanak@google.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240222123615.2cbada98@bootlin.com>
In-Reply-To: <CAMRc=MdCm4UXMkzvG17Vd=6ajE+feihgYc66qUNTTKXhN0--dA@mail.gmail.com>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
	<20240220111019.133697-3-herve.codina@bootlin.com>
	<20240220142959.GA244726@rigel>
	<20240222005744.GA3603@rigel>
	<20240222010530.GA11949@rigel>
	<CAMRc=MdCm4UXMkzvG17Vd=6ajE+feihgYc66qUNTTKXhN0--dA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bartosz,

On Thu, 22 Feb 2024 00:31:08 -0800
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Thu, 22 Feb 2024 02:05:30 +0100, Kent Gibson <warthog618@gmail.com> said:
> > On Thu, Feb 22, 2024 at 08:57:44AM +0800, Kent Gibson wrote:  
> >> On Tue, Feb 20, 2024 at 10:29:59PM +0800, Kent Gibson wrote:  
> >> > On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:  
> >>
> >> ...
> >>  
> >> > >  }
> >> > >
> >> > > +static int linereq_unregistered_notify(struct notifier_block *nb,
> >> > > +				       unsigned long action, void *data)
> >> > > +{
> >> > > +	struct linereq *lr = container_of(nb, struct linereq,
> >> > > +					  device_unregistered_nb);
> >> > > +	int i;
> >> > > +
> >> > > +	for (i = 0; i < lr->num_lines; i++) {
> >> > > +		if (lr->lines[i].desc)
> >> > > +			edge_detector_stop(&lr->lines[i]);
> >> > > +	}
> >> > > +  
> >> >
> >> > Firstly, the re-ordering in the previous patch creates a race,
> >> > as the NULLing of the gdev->chip serves to numb the cdev ioctls, so
> >> > there is now a window between the notifier being called and that numbing,
> >> > during which userspace may call linereq_set_config() and re-request
> >> > the irq.
> >> >
> >> > There is also a race here with linereq_set_config().  That can be prevented
> >> > by holding the lr->config_mutex - assuming the notifier is not being called
> >> > from atomic context.
> >> >  
> >>
> >> It occurs to me that the fixed reordering in patch 1 would place
> >> the notifier call AFTER the NULLing of the ioctls, so there will no longer
> >> be any chance of a race with linereq_set_config() - so holding the
> >> config_mutex semaphore is not necessary.
> >>  
> >
> > NULLing -> numbing
> >
> > The gdev->chip is NULLed, so the ioctls are numbed.
> > And I need to let the coffee soak in before sending.
> >  
> >> In which case this patch is fine - it is only patch 1 that requires
> >> updating.
> >>
> >> Cheers,
> >> Kent.  
> >  
> 
> The fix for the user-space issue may be more-or-less correct but the problem is
> deeper and this won't fix it for in-kernel users.
> 
> Herve: please consider the following DT snippet:
> 
> 	gpio0 {
> 		compatible = "foo";
> 
> 		gpio-controller;
> 		#gpio-cells = <2>;
> 		interrupt-controller;
> 		#interrupt-cells = <1>;
> 		ngpios = <8>;
> 	};
> 
> 	consumer {
> 		compatible = "bar";
> 
> 		interrupts-extended = <&gpio0 0>;
> 	};
> 
> If you unbind the "gpio0" device after the consumer requested the interrupt,
> you'll get the same splat. And device links will not help you here (on that
> note: Saravana: is there anything we could do about it? Have you even
> considered making the irqchip subsystem use the driver model in any way? Is it
> even feasible?).
> 
> I would prefer this to be fixed at a lower lever than the GPIOLIB character
> device.

I think this use case is covered.
When the consumer device related to the consumer DT node is added, a
consumer/supplier relationship is created:
parse_interrupts() parses the 'interrups-extended' property
  https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/property.c#L1316
and so, of_link_to_phandle() creates the consumer/supplier link.
  https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/property.c#L1316

We that link present, if the supplier is removed, the consumer is removed
before.
The consumer should release the interrupt during its remove process (i.e
explicit in its .remove() or explicit because of a devm_*() call).

At least, it is my understanding.

Best regards,
Hervé

