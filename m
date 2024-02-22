Return-Path: <linux-kernel+bounces-76105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B985F2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB761F25B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B17249EE;
	Thu, 22 Feb 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MWq3E3jU"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FA241E0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590672; cv=none; b=eXFu5V9hvc03ar1scNfT7QGg1rZJ4Py/5Rljjs+6fonhvUr6MCwH27BozXh2x646ZDdN7kSxixDfsCnTh5vxPR8vtYoyeJ3TownRgaY0qRdMkc5SGGnK6H4S7IvKx6x5tmR1mniQvHbjGmpskKFqdNh6z3N9A0n2o0EGAwZbqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590672; c=relaxed/simple;
	bh=cYs24B+jpboAdkYkeMVBrxhk7csmYQxiPXi3PgJL7mc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoBGcGBClz40mCp+TIoz5IrBb8yQuCzxOw6RCZIxLA0dq+EzA1o8eGq1gL1NoV4W0ocDfVdMr3fVHc5PPhE5ZIZyiE7/VPoNZXgqICL3O5oNREFocJwCF1ct/IZg1EvXoWgvUU5tmjOZIZc/yPMlqSACfJOJlEsuxd2/ou4zy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MWq3E3jU; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47079bbb400so614518137.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708590670; x=1709195470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8jL3uYkTm+LNVdYsIt/Et/UrQilxmVNJ1Wadk+RFaQ=;
        b=MWq3E3jUheJHoAE7sAmDuaHV8+1c6cJSNZUViMXmLi0kstvlyFY3oUzG8MBfNOQwvf
         oVoZSkiwNfEoTg3zkd4SAWfQdN2Swcaa/XFvjRqCuqjanozf1GQWWz96MURRQ10Ibf16
         mJQgopnEpt2IujhQDIYdHsM5GJNKVBvLLivfiXDO7F8bYKT9d9LCTUbzL3BzLVRKFfuG
         dcLIHhSVqXDMUi/eRjVLwGYrBjGsYvA9Prq40Y5/FvGDmp8gqZMr7HR1Kxge+JWZ1TDv
         YOVJF3zo/f387X2kMx/lCVvI3ex8KZ/sLi90qvPX1JlDX10N/O/R/bLGbvECwoC9Opuv
         sWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590670; x=1709195470;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8jL3uYkTm+LNVdYsIt/Et/UrQilxmVNJ1Wadk+RFaQ=;
        b=YFHo8UEleOtmlOY17LCYghMjP4+C6SAv8EAa+Y3MogS+S/+jA+k5Z8hXQp/KkZ5Tzj
         CneG4mMhYLo7eHWvDfkNCsmPEzy3mF7Ct8aTgS5ZAj5LbfuPh4TIBfAZTcJY/ySTKt0s
         XBLaTC7c/j5B4kKLBcacfwgmtF7gyJCKsAaVuDC3agiWjUQmgSy3ahxgS0RMfPybX1Bd
         6LKGyALSFHe4cfyWwxiL6Z6VdFLF2p7mCOvVsLoo8+2KQzm3fqVeP8yBMhON+inANBPn
         L/cp217G6FJETSwDEftRVhiybjnQYIINgrRgw9MVTPjtZP9RzIr5o0FXKoj07JjYdzC7
         4hGg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFLfEgU4TwQw1bLwzN65JhdI1+zON8XMDhq99V6Y6ekb2qRAXG5SqztmZGv7KLdHbPsZ3oA8tM16mAaoKqpxmV3FqghUe6G91X+j3
X-Gm-Message-State: AOJu0YxjPTgtw8c6pnec1YHBqOXh0Wz80qDKXVoJOO9enPqlxTM8xxWa
	3oy9+LGO1rUZ2JjRXoAe4rCYVirdu0Lwj5lAC22a+C5hr4YW7obtBjMTVdCnW/xaZQvuiElWSf2
	Ii6U9Fk0d8+gt7t6eguCn4wUOoOcsgUcci67T3w==
X-Google-Smtp-Source: AGHT+IGlxAS+aeUhOv2Zd1f0luaBKqEE7591Sd+BPz9t0c5sIaDqZ5by2IaT44MkWcHBupOV01eqRQBkigZ25d0ToJE=
X-Received: by 2002:a67:fbcb:0:b0:470:3ece:b438 with SMTP id
 o11-20020a67fbcb000000b004703eceb438mr11731172vsr.1.1708590669772; Thu, 22
 Feb 2024 00:31:09 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Feb 2024 00:31:09 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20240222010530.GA11949@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com> <20240220142959.GA244726@rigel>
 <20240222005744.GA3603@rigel> <20240222010530.GA11949@rigel>
Date: Thu, 22 Feb 2024 00:31:08 -0800
Message-ID: <CAMRc=MdCm4UXMkzvG17Vd=6ajE+feihgYc66qUNTTKXhN0--dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip device
 is removed
To: Kent Gibson <warthog618@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 02:05:30 +0100, Kent Gibson <warthog618@gmail.com> said:
> On Thu, Feb 22, 2024 at 08:57:44AM +0800, Kent Gibson wrote:
>> On Tue, Feb 20, 2024 at 10:29:59PM +0800, Kent Gibson wrote:
>> > On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:
>>
>> ...
>>
>> > >  }
>> > >
>> > > +static int linereq_unregistered_notify(struct notifier_block *nb,
>> > > +				       unsigned long action, void *data)
>> > > +{
>> > > +	struct linereq *lr = container_of(nb, struct linereq,
>> > > +					  device_unregistered_nb);
>> > > +	int i;
>> > > +
>> > > +	for (i = 0; i < lr->num_lines; i++) {
>> > > +		if (lr->lines[i].desc)
>> > > +			edge_detector_stop(&lr->lines[i]);
>> > > +	}
>> > > +
>> >
>> > Firstly, the re-ordering in the previous patch creates a race,
>> > as the NULLing of the gdev->chip serves to numb the cdev ioctls, so
>> > there is now a window between the notifier being called and that numbing,
>> > during which userspace may call linereq_set_config() and re-request
>> > the irq.
>> >
>> > There is also a race here with linereq_set_config().  That can be prevented
>> > by holding the lr->config_mutex - assuming the notifier is not being called
>> > from atomic context.
>> >
>>
>> It occurs to me that the fixed reordering in patch 1 would place
>> the notifier call AFTER the NULLing of the ioctls, so there will no longer
>> be any chance of a race with linereq_set_config() - so holding the
>> config_mutex semaphore is not necessary.
>>
>
> NULLing -> numbing
>
> The gdev->chip is NULLed, so the ioctls are numbed.
> And I need to let the coffee soak in before sending.
>
>> In which case this patch is fine - it is only patch 1 that requires
>> updating.
>>
>> Cheers,
>> Kent.
>

The fix for the user-space issue may be more-or-less correct but the problem is
deeper and this won't fix it for in-kernel users.

Herve: please consider the following DT snippet:

	gpio0 {
		compatible = "foo";

		gpio-controller;
		#gpio-cells = <2>;
		interrupt-controller;
		#interrupt-cells = <1>;
		ngpios = <8>;
	};

	consumer {
		compatible = "bar";

		interrupts-extended = <&gpio0 0>;
	};

If you unbind the "gpio0" device after the consumer requested the interrupt,
you'll get the same splat. And device links will not help you here (on that
note: Saravana: is there anything we could do about it? Have you even
considered making the irqchip subsystem use the driver model in any way? Is it
even feasible?).

I would prefer this to be fixed at a lower lever than the GPIOLIB character
device.

Bartosz

