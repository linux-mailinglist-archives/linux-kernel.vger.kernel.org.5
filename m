Return-Path: <linux-kernel+bounces-130201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B5897551
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8622828C627
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EB14AD15;
	Wed,  3 Apr 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="OiUSB7tm"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E817C98;
	Wed,  3 Apr 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162108; cv=none; b=dHr0oIz1nrmarOMT+t9aCth4XAlDrFhaxT2uCpE8WpCoVZP0F7maZSQSmdZeKJ2mdvafvcirAEls1bg0iHO3Wzn3DvyK3S2trOs0g1k6bBM7aJdbiNe5WeT8gdVGSk7N9Xv7LlKr35P0KkLRAnozkqGJhUD6UT0qmvd+HCoUnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162108; c=relaxed/simple;
	bh=zD4Yiw7OCi5fgq+RCSzBtrA4K1iq312b2H72yW8lIT4=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=tQwxAVWXv1PLrDC6wB+obMHQA1QjZ8i7YvW21ztFoc+PUTUOS8oSzVOerjIi3AOOi3aya+3hpUgGT0rd3EmRJ4dMv1Wcp7mDczAYo1gdvNxLKSTD7cFYweMC4+s5QutP+1vg50dytazXLBVJONIR7r+WzRqVLPRic/CxkHjknIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=OiUSB7tm; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=Be+U0t7VcjuBlMtDw/ENxuCcQmZcFzNETa3Sysptv4M=; b=OiUSB7tmeIR8B2uvc6IKt9wse4
	T+kulL5ySz0S0BP3YJzh74XtCh6sABHlnWlFn0Q+BMy+r4EuV5y2DtUjaSpUAO15xh4gabHZQ9hjW
	K9i6Ti1p0F9P0bwLzL3+iRQcObSYrxHPFkn7UzhImg2KSTNyiLie+FZWjH6cqlGix+x4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45874 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rs3Zn-0006aZ-0r; Wed, 03 Apr 2024 12:35:03 -0400
Date: Wed, 3 Apr 2024 12:35:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com>
In-Reply-To: <CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
	<20240402174353.256627-4-hugo@hugovil.com>
	<CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com>
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

On Tue, 2 Apr 2024 22:40:07 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

Hi Andy,

> On Tue, Apr 2, 2024 at 8:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Split the common code from sc16is7xx driver and move the I2C and SPI bus
> > parts into interface-specific source files.
> >
> > sc16is7xx becomes the core functions which can support multiple bus
> > interfaces like I2C and SPI.
> >
> > No functional change intended.
> 
> ...
> 
> > -config SERIAL_SC16IS7XX_CORE
> > -       tristate
> > -
> >  config SERIAL_SC16IS7XX
> >         tristate "SC16IS7xx serial support"
> >         select SERIAL_CORE
> > -       depends on (SPI_MASTER && !I2C) || I2C
> > +       depends on SPI_MASTER || I2C
> 
> Is it?

See discussion below, but I would remove the SPI/I2C depends. And I
would rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE.

> 
> >         help
> >           Core driver for NXP SC16IS7xx serial ports.
> >           Supported ICs are:
> > @@ -1042,22 +1039,18 @@ config SERIAL_SC16IS7XX
> >           drivers below.
> >
> >  config SERIAL_SC16IS7XX_I2C
> > -       bool "SC16IS7xx for I2C interface"
> > +       tristate "SC16IS7xx for I2C interface"
> >         depends on SERIAL_SC16IS7XX
> >         depends on I2C
> > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > -       select REGMAP_I2C if I2C
> > -       default y
> > +       select REGMAP_I2C
> >         help
> > -         Enable SC16IS7xx driver on I2C bus,
> > -         enabled by default to support oldconfig.
> > +         Enable SC16IS7xx driver on I2C bus.
> >
> >  config SERIAL_SC16IS7XX_SPI
> > -       bool "SC16IS7xx for spi interface"
> > +       tristate "SC16IS7xx for SPI interface"
> >         depends on SERIAL_SC16IS7XX
> >         depends on SPI_MASTER
> > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > -       select REGMAP_SPI if SPI_MASTER
> > +       select REGMAP_SPI
> >         help
> >           Enable SC16IS7xx driver on SPI bus.
> 
> Hmm... What I was thinking about is more like dropping
>  the SERIAL_SC16IS7XX and having I2C/SPI to select the core.
> 
> See many examples under drivers/iio on how it's done.

Ok, I found this example:
bf96f6e80cef ("iio: accel: kxsd9: Split out SPI transport")

In it, the SPI part doesn't select the core, but depends on it, similar
to what I have done. I find this approach more interesting for
embedded systems as you can enable/disable I2C or SPI part if you
need only one interface.

> 
> ...
> 
> > +EXPORT_SYMBOL_GPL(sc16is74x_devtype);
> 
> Is it namespaced? Please make sure we are not polluting the global
> namespace with these.

Ok, will add namespace support to all exports.


> 
> ...
> 
> > +#ifndef _SC16IS7XX_H_
> > +#define _SC16IS7XX_H_
> > +
> > +#include <linux/device.h>
> 
> Not used (by this file).

I was assuming that this file was for "struct device"?


> 
> > +#include <linux/mod_devicetable.h>
> 
> > +#include <linux/regmap.h>
> 
> > +#include <linux/serial_core.h>
> 
> Not used.

Ok, will drop for V4.


> 
> > +#include <linux/types.h>
> 
> > +extern const struct of_device_id __maybe_unused sc16is7xx_dt_ids[];
> 
> No __maybe_unused. Just have it always be added.

Ok.


> 
> > +const char *sc16is7xx_regmap_name(u8 port_id);
> > +
> > +unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id);
> > +
> > +int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
> > +                   struct regmap *regmaps[], int irq);
> 
> > +void sc16is7xx_remove(struct device *dev);
> 
> Will require forward declaration
> 
> #include ...
> 
> struct device;

Isn't it provided by <linux/device.h> ?


> 
> > +#endif /* _SC16IS7XX_H_ */
> 
> ...
> 
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> 
> Follow the IWYU principle (include what you use).

Ok, I tried to follow it, I do think those 4 includes are required in
this file, no?

and maybe I can add <linux/string.h> for memcpy().


> 
> ...
> 
> > +               return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match device\n");
> 
> + dev_printk.h

Ok.


> 
> ...
> 
> > +static int __init sc16is7xx_i2c_init(void)
> > +{
> > +       return i2c_add_driver(&sc16is7xx_i2c_driver);
> > +}
> > +module_init(sc16is7xx_i2c_init);
> > +
> > +static void __exit sc16is7xx_i2c_exit(void)
> > +{
> > +       i2c_del_driver(&sc16is7xx_i2c_driver);
> > +}
> > +module_exit(sc16is7xx_i2c_exit);
> 
> This is now module_i2c_driver().

Ok. Great, simplifies things.


> 
> ...
> 
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("SC16IS7xx I2C interface driver");
> 
> + MODULE_IMPORT_NS()

Ok.


> 
> ...
> 
> > +++ b/drivers/tty/serial/sc16is7xx_spi.c
> 
> Similar/same comments as per i2c counterpart.

Ok.


> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 


-- 
Hugo Villeneuve

