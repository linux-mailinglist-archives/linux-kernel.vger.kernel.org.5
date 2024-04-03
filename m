Return-Path: <linux-kernel+bounces-130458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E66897873
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC58628BCF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D3154446;
	Wed,  3 Apr 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AbI0IcJG"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166615380B;
	Wed,  3 Apr 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169845; cv=none; b=q3ItjQjLQ+FVdAYJWfMzGvyWJS2UQNI3+DQ+BPyrYX7e1YvfcA78Fpx4BXCWuMbTog3azV8w7oIR02F7At4z/O/WH0+B2adO12yAf8NaDWBOhLrV88GRaHV6Qqp76HzCKbmU2+xjF/yRr2Fw1oBn7i9yPwR2RbNAYhnBwgWe0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169845; c=relaxed/simple;
	bh=wQk1+TZdbZ9d27NNtYWpI7VAcGnhFyW3udF6s9YMzqE=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=kym3i6vnHgFsAZH1GUyW/D83Yi72vf1gTLmX/kUn6Ui3BkZBGjJPg6L4C30LHfc5rCe/5BXJ1euWanzhfE7c0u/kNLnH+elwrs2o5qxQhHADn2ZGi5i6WNBb2fiKSJkAvqCgzeB3KY8/oX0GqMUUkiy7CKSzVQ9rR9yM/6UsDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=AbI0IcJG; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=UMzkfSMQqbRmqbP3R6toJqZVcXEAq1czX3NZPj6yIoY=; b=AbI0IcJGYSrv3qif0xxaUr8ug1
	c+1B3q6Ac5cUHAakZIaIq9kvrVb7TeNHE8oJCqCi5F0QoSMU3qBGu+gNhLFhf7oOgCxSLA1bcWqPS
	Mt7APWFcjuLBq72AhQA+zlVjL/I77BKY8O1l0ipn3l51SpPg4/SUQW5Mz8/Ok3mG/56s=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51750 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rs5aZ-0008OG-Ui; Wed, 03 Apr 2024 14:44:00 -0400
Date: Wed, 3 Apr 2024 14:43:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240403144359.4ec6250720cb4a461e9fb8ec@hugovil.com>
In-Reply-To: <CAHp75Vdm0RAX_xD41VvXuv3GG0SkHffqw7v=hs_6m4Ev1WZjMQ@mail.gmail.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
	<20240402174353.256627-4-hugo@hugovil.com>
	<CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com>
	<20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com>
	<CAHp75VcEj64aFb0nT8uQitkNSdWWqz7pmAqSGaGwy-tA=df0EA@mail.gmail.com>
	<20240403135910.2ef852670c184927340d08d7@hugovil.com>
	<CAHp75Vdm0RAX_xD41VvXuv3GG0SkHffqw7v=hs_6m4Ev1WZjMQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 3 Apr 2024 21:04:29 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 3, 2024 at 8:59 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Wed, 3 Apr 2024 20:44:05 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Apr 3, 2024 at 7:35 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > On Tue, 2 Apr 2024 22:40:07 +0300
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > On Tue, Apr 2, 2024 at 8:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> ...
> 
> > > > > > -config SERIAL_SC16IS7XX_CORE
> > > > > > -       tristate
> > > > > > -
> > > > > >  config SERIAL_SC16IS7XX
> > > > > >         tristate "SC16IS7xx serial support"
> > > > > >         select SERIAL_CORE
> > > > > > -       depends on (SPI_MASTER && !I2C) || I2C
> > > > > > +       depends on SPI_MASTER || I2C
> > > > >
> > > > > Is it?
> > > >
> > > > See discussion below, but I would remove the SPI/I2C depends. And I
> > > > would rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE.
> > > >
> > > > >
> > > > > >         help
> > > > > >           Core driver for NXP SC16IS7xx serial ports.
> > > > > >           Supported ICs are:
> > > > > > @@ -1042,22 +1039,18 @@ config SERIAL_SC16IS7XX
> > > > > >           drivers below.
> > > > > >
> > > > > >  config SERIAL_SC16IS7XX_I2C
> > > > > > -       bool "SC16IS7xx for I2C interface"
> > > > > > +       tristate "SC16IS7xx for I2C interface"
> > > > > >         depends on SERIAL_SC16IS7XX
> > > > > >         depends on I2C
> > > > > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > > > > -       select REGMAP_I2C if I2C
> > > > > > -       default y
> > > > > > +       select REGMAP_I2C
> > > > > >         help
> > > > > > -         Enable SC16IS7xx driver on I2C bus,
> > > > > > -         enabled by default to support oldconfig.
> > > > > > +         Enable SC16IS7xx driver on I2C bus.
> > > > > >
> > > > > >  config SERIAL_SC16IS7XX_SPI
> > > > > > -       bool "SC16IS7xx for spi interface"
> > > > > > +       tristate "SC16IS7xx for SPI interface"
> > > > > >         depends on SERIAL_SC16IS7XX
> > > > > >         depends on SPI_MASTER
> > > > > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > > > > -       select REGMAP_SPI if SPI_MASTER
> > > > > > +       select REGMAP_SPI
> > > > > >         help
> > > > > >           Enable SC16IS7xx driver on SPI bus.
> > > > >
> > > > > Hmm... What I was thinking about is more like dropping
> > > > >  the SERIAL_SC16IS7XX and having I2C/SPI to select the core.
> > > > >
> > > > > See many examples under drivers/iio on how it's done.
> > > >
> > > > Ok, I found this example:
> > > > bf96f6e80cef ("iio: accel: kxsd9: Split out SPI transport")
> > > >
> > > > In it, the SPI part doesn't select the core, but depends on it, similar
> > > > to what I have done. I find this approach more interesting for
> > > > embedded systems as you can enable/disable I2C or SPI part if you
> > > > need only one interface.
> > >
> > > Yes, but what I mean is to have i2c/spi symbols visible and if user
> > > selects one of them or both the core is automatically being selected.
> >
> > Ok, I see. But a drawback of doing this is that for each interface
> > (I2C/SPI), you would need to list (duplicate) all the devices
> > supported. For now, that list is only in one place,
> > for the generic SERIAL_SC16IS7XX_CORE section:
> >
> > ...
> > config SERIAL_SC16IS7XX_CORE
> >         tristate "SC16IS7xx serial support"
> >         select SERIAL_CORE
> >         help
> >           Core driver for NXP SC16IS7xx serial ports.
> >           Supported ICs are:
> >
> >             SC16IS740
> >             SC16IS741
> >             SC16IS750
> 
> Hmm... How do the other drivers have this separation? So, check
> several examples (and check _the recently added_) in IIO and follow
> that. If they have CORE visible, follow it.

In iio/accel, there is a roughly equal mix of everything. But all
examples that automatically select CORE do not list any specific
variants, probably because of the maintenance burden that this would
impose like I mentioned.

The most recent one is bmi088, which has only one KConfig
selection available, with I2C/SPI parts automatically selected, and
with the benefit of only having to list all variants once. The only
minor drawback of course is having to (almost always) compile an
interface (I2C or SPI) which won't be used.

I don't mind going this way for V4.


> 
> ...
> 
> > > > Isn't it provided by <linux/device.h> ?
> > >
> > > But why? Have you looked into device.h? It's a mess. You don't need it
> > > in this header.
> >
> > Yes I have looked at it, and saw that the forward declaration of
> > "struct device" opaque pointer is in it, and this is why I was
> > including it. But I will remove it if you wish.
> 
> This file doesn't use the struct device, it uses an opaque pointer. In
> C for this the forward declaration is enough, no need to include a
> whole mess from device.h.

Ok.

Hugo.


> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 


-- 
Hugo Villeneuve

