Return-Path: <linux-kernel+bounces-130404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808C8978A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D0CB3EE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD11534EB;
	Wed,  3 Apr 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Ddh0wnWe"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E7152505;
	Wed,  3 Apr 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167161; cv=none; b=pi+eh2DqxkReHIvNJ7Kah/eKPkBa46EjA3SKULWr28TWs2BTtNvhZm83SrCUnbwppNGi2czRhRNkcYUqGMKBFL3VPLGTczoUxO4TlqIuI1kRup32rlw9a8DZ/N/J7AnaSKfwFNcIvJLF73K07zZXuXW3fhaXRC+5YwO2r5E+vrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167161; c=relaxed/simple;
	bh=U7zH5RmAzUWXjSGg3FmmSyJBJmOW5vZMmsgGta3oe9E=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=WZMTPZzW/fsxw7OgqkWr+8UPpiXZ87Qn/xQZaeiaBFBtdN044aqdEbjTip7h2JZTNLGmgDN55mpHxZnh+0PSqUv7eIvjwWjoC0wpUiT+Dhl7hv5skeccVu0iV03J9a4YYmcVha3bdiAumUIXZqSqEAmCgi8kuSjdwg4B6VhynaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Ddh0wnWe; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=XsibBNQ48v3ozljfAa2u+QdXR1ArmIMnXcbhbHkVW+8=; b=Ddh0wnWep9wQaBjokHV1drm3fr
	Ol+7FeY/UnbJuIZdwgs4rdu6W8Ix8llvZ5+x8s6zf5qDdxOmUND2bUa1GkgUPrGHBV0eyzlQ9dA4O
	P46oDm5X6EafqkmQVj/LEfJ35Onn6FZLkSwpBz0jmadcboPKfcGwTP3aJYAvtRQLrEtA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33886 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rs4tC-0007gl-IW; Wed, 03 Apr 2024 13:59:10 -0400
Date: Wed, 3 Apr 2024 13:59:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240403135910.2ef852670c184927340d08d7@hugovil.com>
In-Reply-To: <CAHp75VcEj64aFb0nT8uQitkNSdWWqz7pmAqSGaGwy-tA=df0EA@mail.gmail.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
	<20240402174353.256627-4-hugo@hugovil.com>
	<CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com>
	<20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com>
	<CAHp75VcEj64aFb0nT8uQitkNSdWWqz7pmAqSGaGwy-tA=df0EA@mail.gmail.com>
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

On Wed, 3 Apr 2024 20:44:05 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 3, 2024 at 7:35 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Tue, 2 Apr 2024 22:40:07 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Apr 2, 2024 at 8:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> ...
> 
> > > > -config SERIAL_SC16IS7XX_CORE
> > > > -       tristate
> > > > -
> > > >  config SERIAL_SC16IS7XX
> > > >         tristate "SC16IS7xx serial support"
> > > >         select SERIAL_CORE
> > > > -       depends on (SPI_MASTER && !I2C) || I2C
> > > > +       depends on SPI_MASTER || I2C
> > >
> > > Is it?
> >
> > See discussion below, but I would remove the SPI/I2C depends. And I
> > would rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE.
> >
> > >
> > > >         help
> > > >           Core driver for NXP SC16IS7xx serial ports.
> > > >           Supported ICs are:
> > > > @@ -1042,22 +1039,18 @@ config SERIAL_SC16IS7XX
> > > >           drivers below.
> > > >
> > > >  config SERIAL_SC16IS7XX_I2C
> > > > -       bool "SC16IS7xx for I2C interface"
> > > > +       tristate "SC16IS7xx for I2C interface"
> > > >         depends on SERIAL_SC16IS7XX
> > > >         depends on I2C
> > > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > > -       select REGMAP_I2C if I2C
> > > > -       default y
> > > > +       select REGMAP_I2C
> > > >         help
> > > > -         Enable SC16IS7xx driver on I2C bus,
> > > > -         enabled by default to support oldconfig.
> > > > +         Enable SC16IS7xx driver on I2C bus.
> > > >
> > > >  config SERIAL_SC16IS7XX_SPI
> > > > -       bool "SC16IS7xx for spi interface"
> > > > +       tristate "SC16IS7xx for SPI interface"
> > > >         depends on SERIAL_SC16IS7XX
> > > >         depends on SPI_MASTER
> > > > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > > > -       select REGMAP_SPI if SPI_MASTER
> > > > +       select REGMAP_SPI
> > > >         help
> > > >           Enable SC16IS7xx driver on SPI bus.
> > >
> > > Hmm... What I was thinking about is more like dropping
> > >  the SERIAL_SC16IS7XX and having I2C/SPI to select the core.
> > >
> > > See many examples under drivers/iio on how it's done.
> >
> > Ok, I found this example:
> > bf96f6e80cef ("iio: accel: kxsd9: Split out SPI transport")
> >
> > In it, the SPI part doesn't select the core, but depends on it, similar
> > to what I have done. I find this approach more interesting for
> > embedded systems as you can enable/disable I2C or SPI part if you
> > need only one interface.
> 
> Yes, but what I mean is to have i2c/spi symbols visible and if user
> selects one of them or both the core is automatically being selected.

Ok, I see. But a drawback of doing this is that for each interface
(I2C/SPI), you would need to list (duplicate) all the devices
supported. For now, that list is only in one place,
for the generic SERIAL_SC16IS7XX_CORE section:

..
config SERIAL_SC16IS7XX_CORE
	tristate "SC16IS7xx serial support"
	select SERIAL_CORE
	help
	  Core driver for NXP SC16IS7xx serial ports.
	  Supported ICs are:

	    SC16IS740
	    SC16IS741
	    SC16IS750
..


> 
> ...
> 
> > > > +#include <linux/device.h>
> > >
> > > Not used (by this file).
> >
> > I was assuming that this file was for "struct device"?
> 
> But it does not use it. It uses an opaque pointer, for which the
> forward declaration is enough to have.
> 
> ...
> 
> > > > +void sc16is7xx_remove(struct device *dev);
> > >
> > > Will require forward declaration
> > >
> > > #include ...
> > >
> > > struct device;
> >
> > Isn't it provided by <linux/device.h> ?
> 
> But why? Have you looked into device.h? It's a mess. You don't need it
> in this header.

Yes I have looked at it, and saw that the forward declaration of
"struct device" opaque pointer is in it, and this is why I was
including it. But I will remove it if you wish.


> 
> ...
> 
> > > Follow the IWYU principle (include what you use).
> >
> > Ok, I tried to follow it, I do think those 4 includes are required in
> > this file, no?
> 
> I haven't deeply checked, I believe for the next version you will
> provide a better list.

Ok

> 
> > and maybe I can add <linux/string.h> for memcpy().
> 
> For sure, yes.

Ok.

Thanks for your comments.

Hugo.

