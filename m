Return-Path: <linux-kernel+bounces-155261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EFB8AE7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B18A1C22E74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C74134CC8;
	Tue, 23 Apr 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="WdZOXfQ3"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778B82C60;
	Tue, 23 Apr 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878062; cv=none; b=CflSstppbyQ3RVsPTKiEoORNpG26mGSk+tbxoPMDcOV0LmJUPYBd5W+tw7UJLyQGd4pgaP+DdxehQMJ3Up2Zbig+CgbuAFKwGt1TxKa7wsxZ5/vGQQqjUnoGInmjx6ShPAN+xEHem4eS8ok2iT+tvV4qqYTclUD/gkWOpmYppmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878062; c=relaxed/simple;
	bh=g5AdFiO1hQzEvA2vNbi2IQtgLhDgcEJVHVwunkxnVBI=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=CAxiFRmMYqfxOwxg6aFsbhgrP6sMW83H3KuxJw2ZDw5HQKZA7zaem8692cTUgpP+oj4og9H74dMoi0KnCdKGVHJ5M0LG+Z+taXb79berBQ3WJlqxXrx+U696QAqwA5MOCSG5qkoZJ16n9KWsOEdNlpH2tZYntDT/EfByws7fY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=WdZOXfQ3; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=yN9w8dcRKyV4B2a7kq5NoFJXmJV7PjaLk1tBuxc/bes=; b=WdZOXfQ3C7NGdmcm3mZbTvOTB+
	7ztxSVPMhrABmG+q9hkAPfDrxO/2KX4QIUSnownQWHP8CrfyADA0bMlR33e1/CYaJ3nVt07hTAu5H
	WVtBiSF5HEO9iLNbYMfw+8rMkxIm10/T7/CFyT4lm8FIy/794rdY9mJTdQQfCN0CAv0U=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41504 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rzFyN-0006im-Bw; Tue, 23 Apr 2024 09:14:11 -0400
Date: Tue, 23 Apr 2024 09:14:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, andy.shevchenko@gmail.com, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240423091410.28cb286b212789250b1485dd@hugovil.com>
In-Reply-To: <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
	<20240409154253.3043822-4-hugo@hugovil.com>
	<CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
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
	* -2.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 23 Apr 2024 12:01:23 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Tue, Apr 9, 2024 at 5:48 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Split the common code from sc16is7xx driver and move the I2C and SPI bus
> > parts into interface-specific source files.
> >
> > sc16is7xx becomes the core functions which can support multiple bus
> > interfaces like I2C and SPI.
> >
> > No functional changes intended.
> >
> > Also simplify and improve Kconfig entries.
> >   - Capitalize SPI keyword for consistency
> >   - Display list of supported ICs each on a separate line (and aligned) to
> >     facilitate locating a specific IC model
> >   - Add Manufacturer name at start of description string
> >   - Add UART keyword to description string
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thanks for your patch, which is now commit d49216438139bca0
> ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
> in tty-next (next-20240415 and later).
> 
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1021,41 +1021,30 @@ config SERIAL_SCCNXP_CONSOLE
> >           Support for console on SCCNXP serial ports.
> >
> >  config SERIAL_SC16IS7XX_CORE
> > -       tristate
> > -
> > -config SERIAL_SC16IS7XX
> > -       tristate "SC16IS7xx serial support"
> > +       tristate "NXP SC16IS7xx UART support"
> 
> Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> so arch/mips/configs/cu1??0-neo_defconfig needs to updated.

Hi Geert,
yes you are right, sorry I missed that.

> 
> >         select SERIAL_CORE
> > -       depends on (SPI_MASTER && !I2C) || I2C
> > +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> > +       select SERIAL_SC16IS7XX_I2C if I2C
> 
> So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7XX_*
> subdriver can no longer be disabled?  According to
> https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com/
> you did want to support that?

Just to clarify, SPI subdriver will be disabled if
SPI_MASTER is disabled, even if I2C is enabled, and vice versa.

It was not my original intention, V1 of the patch offered the
possibility to enable/disable each subdriver individually, but Andy
pointed out that was maybe not the standard/usual/recommended way of
defining it, and to look into what other subsystems were doing,
especially iio. After some research, I settled on this approach as a
compromise.


Hugo.

> 
> >         help
> > -         This selects support for SC16IS7xx serial ports.
> > -         Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
> > -         SC16IS760 and SC16IS762. Select supported buses using options below.
> > +         Core driver for NXP SC16IS7xx UARTs.
> > +         Supported ICs are:
> > +
> > +           SC16IS740
> > +           SC16IS741
> > +           SC16IS750
> > +           SC16IS752
> > +           SC16IS760
> > +           SC16IS762
> > +
> > +         The driver supports both I2C and SPI interfaces.
> >
> >  config SERIAL_SC16IS7XX_I2C
> > -       bool "SC16IS7xx for I2C interface"
> > -       depends on SERIAL_SC16IS7XX
> > -       depends on I2C
> > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > -       select REGMAP_I2C if I2C
> > -       default y
> > -       help
> > -         Enable SC16IS7xx driver on I2C bus,
> > -         If required say y, and say n to i2c if not required,
> > -         Enabled by default to support oldconfig.
> > -         You must select at least one bus for the driver to be built.
> > +       tristate
> > +       select REGMAP_I2C
> >
> >  config SERIAL_SC16IS7XX_SPI
> > -       bool "SC16IS7xx for spi interface"
> > -       depends on SERIAL_SC16IS7XX
> > -       depends on SPI_MASTER
> > -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> > -       select REGMAP_SPI if SPI_MASTER
> > -       help
> > -         Enable SC16IS7xx driver on SPI bus,
> > -         If required say y, and say n to spi if not required,
> > -         This is additional support to existing driver.
> > -         You must select at least one bus for the driver to be built.
> > +       tristate
> > +       select REGMAP_SPI
> >
> >  config SERIAL_TIMBERDALE
> >         tristate "Support for timberdale UART"
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

