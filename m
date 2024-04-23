Return-Path: <linux-kernel+bounces-155482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EC8AEB33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942841C21F27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B013C694;
	Tue, 23 Apr 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="t3iNJ5QE"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7817BA8;
	Tue, 23 Apr 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886484; cv=none; b=fCDs+l3kMfwKx5GCgfRBcHaRS+fd/6pvTYxqtdlaMVM7q2XrKJue5VkEmGSc+NBQ8QY7LBSSIIUb24Kathb9P0Z5PIeeDdiERFlQoSdaG5J7ADhfso4KHRQ0xuF+eUSXpLDJ0rqmhRkb3+3G8YMhdyhKQ+3fYZoDPrUTCsaAV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886484; c=relaxed/simple;
	bh=3Z022LAb/Qc9gVEiSFfHMGtWUvt0++jo6l9pERyHz6E=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=bG68m7q0Sxd1w9Otkw69/fUf8l/Jmm4WoPx86FSIJNutwcoiT8we+WwBHgUpUn2DnDu1NeL2CVRCN8n/p+ZGY0UiwB9I+E9HfWvIz/C1movpeOfJ6V6+rbcVxJcU/UISb+LctrNJkSa9XhtDEUVafsovS8luTexgSU5IO4+MdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=t3iNJ5QE; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=vNvK7sZ4T6Ritg0ROl4LFENFoZaJBNwoxwSP8BQf7Vg=; b=t3iNJ5QE6Xzk0W1MN0iF//uP7f
	2+qDfcOXW2Z/lOJP0aXmFDGdyW9VeNVcbPsbS+wQQlL1liAmpdkpYpDTiAqpdkdAWAqRflFOpu5mR
	Gc1jI1Fsdh7MIfqgjDIoaJjTzebKdOrfk2vzmNghlvJSWeaoDL9/HU2l84+5Lk203res=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40398 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rzI9w-0007G0-0X; Tue, 23 Apr 2024 11:34:17 -0400
Date: Tue, 23 Apr 2024 11:34:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, peterz@infradead.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240423113415.7e81fa1de7f98f91d244b87a@hugovil.com>
In-Reply-To: <CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
	<20240409154253.3043822-4-hugo@hugovil.com>
	<CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
	<CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com>
	<CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
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

On Tue, 23 Apr 2024 15:11:12 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

Hi Geert,

> Hi Andy,
> 
> On Tue, Apr 23, 2024 at 12:37 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Apr 23, 2024 at 1:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Apr 9, 2024 at 5:48 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > > > -config SERIAL_SC16IS7XX
> > > > -       tristate "SC16IS7xx serial support"
> > > > +       tristate "NXP SC16IS7xx UART support"
> > >
> > > Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> > > so arch/mips/configs/cu1??0-neo_defconfig needs to updated.
> >
> >         select SERIAL_CORE
> > -       depends on (SPI_MASTER && !I2C) || I2C
> > +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> > +       select SERIAL_SC16IS7XX_I2C if I2C
> >
> > > So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7XX_*
> > > subdriver can no longer be disabled?  According to
> > > https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com/
> > > you did want to support that?
> >
> > I believe it has been taken from one of the IIO drivers as an example.
> 
> Looks like a bad example to follow:
>   1. The driver question now pops up if both I2C and SPI_MASTER
>      are disabled,

True.

V3 originally had this:

>  config SERIAL_SC16IS7XX
>         tristate "SC16IS7xx serial support"
>         select SERIAL_CORE
> -       depends on (SPI_MASTER && !I2C) || I2C
> +       depends on SPI_MASTER || I2C

And Andy commented "Is it?", which I probably misinterpreted as I should
not list them as dependencies.

Reintroducing "depends on SPI_MASTER || I2C" fixes this issue.


>   2. What if SERIAL_SC16IS7XX_CORE is builtin, but I2C and/or
>      SPI_MASTER are modular?

a) SERIAL_SC16IS7XX builtin and I2C modular:
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=m
CONFIG_SERIAL_SC16IS7XX_SPI=y

SPI_MASTER is only boolean and cannot be modular.

Hugo.


> 
> I believe the only way to fix that is by letting the sub-drivers select the
> core driver, like before.
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


-- 
Hugo Villeneuve

