Return-Path: <linux-kernel+bounces-67585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD7856DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00F71F21CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FEA13A242;
	Thu, 15 Feb 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwmmPbss"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0F139563;
	Thu, 15 Feb 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025547; cv=none; b=tmn/pw9HSlcngSdxN/w6jI7p+tiWHTSE7zZcfVpsyqN36yl2mvJX6a5GNQ6fLFK+pP94Ppyn/8rmqCPkMUEmgK98wi5cei8298NWu+nRpJWnZn0EMLTGjPD07gXNfeDvDqSNd81q9ofQVh533LMN7PnPEvd07GYsWzR5iyu63Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025547; c=relaxed/simple;
	bh=4BcRq9RX6jvxRs95r4FuuTxSOinBoyMKdffw3BOH7Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoILwVFIphp2IN/GLsWbwO1zgRpSrZe1FY43cEbZhcv8VRTbDpXLm2qWKoSqC/kVPNZDSJszchrJ/cdLlia3iFErIiOKh1pUqFBbyjiZYjv2ipDtKmSdt0RkqlXBjEYqQVW2jfVJwO/AF6VCyPTkI6hcE0T/FcKJfDWo/oXwXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwmmPbss; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so1619770e87.3;
        Thu, 15 Feb 2024 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708025542; x=1708630342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4cviBjUGytaBcj0BpbY2tvrc6kLUHG8Yt6uoKR87Yo=;
        b=SwmmPbssJKmA4OhI0MB7j+Wmn3nCMib3h+gkoT1CsT6xqowttNNz/XZqcFVjtg7EGP
         Brs/+JR3FILGEgNmlODi02xWbQCw8uCow9ubliFow5iVl1XYVIj+mdTUketk98J7bGrR
         fx0CHEmnti7/z4pvclaYSssw4Mk3hUJh40HEJmgBrUYOdCNMb+HUWkp+gPOWdGYQfVOY
         LAu20eQPbSqxVahaL1skYeUXUesmdmvnfR4zRFnbvE9EUcxi9GRg9kMpwth0dTDjcylN
         kqZYMNmnqFBC90cHg4hAIs/dISUatEYbT0QAu2nm+6PAffHaybAKgjKtjYFblS9+iddR
         D8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025542; x=1708630342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4cviBjUGytaBcj0BpbY2tvrc6kLUHG8Yt6uoKR87Yo=;
        b=lvRyQUdo24W3agsWI8RErOW1RSD80AlvmrPO8NFdYybQ7LWopW9JvQT1GjVrHLco7Q
         FkB5E7Ll0GkwDtJIp0q5vKsGTivbYZwGCVcnF8YT/6ki+ISFGyqulurUT+icGfJc854D
         EA8wgnzS1C0xMkRLB7PuyWzL6eKL4nxoANG0fdF79+gOD4EMUVrMk3+QoHkq4rPBbGEX
         SAy4X9U3J3t2h7cGsFQ2Iwm3x/ksqUQWkveTKUrSU3b1DmXzNJWnKcKeqbN2MsZkq8tw
         1iHgS4jxFOOzSHU3/a3x54jo3zHMOLRNm0Hjg46AwUNiRztu/THlrv+QmYve4EWoxtyV
         ivew==
X-Forwarded-Encrypted: i=1; AJvYcCVsHT/STXXZGfugL2fsjgBM/ZYsOuoeLw12clggV4K28hsIPKbKwSEOP8DVWTEM0uGQqrjMrKWi5uUHz4xa7RJ8R5xqsaHq38eH2G7wLt6x2NZ+Vlm6Au9UVXJqRZjPdUNP9DZTRO4N4MTq
X-Gm-Message-State: AOJu0Yyz72J7FZ2YU7KW9ldhnXzkKH1jB9lAsN/7m9V/fhdUIQXn1nz4
	CwnkRQip5SaX5NyB+59ke+K3N5teoN8Hlo824j/n0Z2/2LMj9qCa
X-Google-Smtp-Source: AGHT+IERNQxo7hlRTgv+smihgExCW08qYzdRyPrURdgmn33GLfYE38cuaymZxnYxZPv3vY2YZoOERg==
X-Received: by 2002:a05:6512:6ce:b0:512:8a57:d047 with SMTP id u14-20020a05651206ce00b005128a57d047mr2139221lff.47.1708025542029;
        Thu, 15 Feb 2024 11:32:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512114900b005128d529bf0sm164982lfg.115.2024.02.15.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:32:21 -0800 (PST)
Date: Thu, 15 Feb 2024 22:32:18 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: Add 8250 port clock update method
Message-ID: <raryiklwhctwxcfj3ulbnjcl32owagiccmxpwzmszlh3vm343y@h2ehupm7uiga>
References: <20200723003357.26897-1-Sergey.Semin@baikalelectronics.ru>
 <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>
 <ZczD7KPbeRnY4CFc@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZczD7KPbeRnY4CFc@black.fi.intel.com>

Hi Andy,

On Wed, Feb 14, 2024 at 03:45:16PM +0200, Andy Shevchenko wrote:
> On Thu, Jul 23, 2020 at 03:33:54AM +0300, Serge Semin wrote:
> > Some platforms can be designed in a way so the UART port reference clock
> > might be asynchronously changed at some point. In Baikal-T1 SoC this may
> > happen due to the reference clock being shared between two UART ports, on
> > the Allwinner SoC the reference clock is derived from the CPU clock, so
> > any CPU frequency change should get to be known/reflected by/in the UART
> > controller as well. But it's not enough to just update the
> > uart_port->uartclk field of the corresponding UART port, the 8250
> > controller reference clock divisor should be altered so to preserve
> > current baud rate setting. All of these things is done in a coherent
> > way by calling the serial8250_update_uartclk() method provided in this
> > patch. Though note that it isn't supposed to be called from within the
> > UART port callbacks because the locks using to the protect the UART port
> > data are already taken in there.
> 
> ...
> 
> > +/*
> > + * Note in order to avoid the tty port mutex deadlock don't use the next method
> > + * within the uart port callbacks. Primarily it's supposed to be utilized to
> > + * handle a sudden reference clock rate change.
> > + */
> > +void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
> > +{
> > +	struct uart_8250_port *up = up_to_u8250p(port);
> > +	unsigned int baud, quot, frac = 0;
> > +	struct ktermios *termios;
> > +	unsigned long flags;
> > +
> > +	mutex_lock(&port->state->port.mutex);
> > +
> > +	if (port->uartclk == uartclk)
> > +		goto out_lock;
> > +
> > +	port->uartclk = uartclk;
> > +	termios = &port->state->port.tty->termios;
> > +
> > +	baud = serial8250_get_baud_rate(port, termios, NULL);
> > +	quot = serial8250_get_divisor(port, baud, &frac);
> > +
> > +	serial8250_rpm_get(up);
> > +	spin_lock_irqsave(&port->lock, flags);
> > +
> > +	uart_update_timeout(port, termios->c_cflag, baud);
> > +
> > +	serial8250_set_divisor(port, baud, quot, frac);
> > +	serial_port_out(port, UART_LCR, up->lcr);
> > +	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
> > +
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +	serial8250_rpm_put(up);
> > +
> > +out_lock:
> > +	mutex_unlock(&port->state->port.mutex);
> 

> While looking for something else I have stumbled over this function.
> My Q is, since it has some duplications with
> serial8250_do_set_termios(), can we actually call the latter (or
> derevative that can be called in both) in the above code instead of
> duplicating some lines?
> 
> 	if (port UART clock has to be updated)
> 	  call (unlocked version of) serial8250_do_set_termios()
> 
> Serge, what do you think?

What an old thread you've digged out.)

Well, AFAIR I didn't create a common baud-rate/clock-update method
because the baud-rate change was just a two stages action:
1. calculate divisor+quot couple based on the new clock,
2. update the divisor+quot (+ update the timeout).
The first stage didn't need to have the IRQsafe lock being held and
the runtime-PM being enabled, meanwhile the later one needed those.
So unless the nested locking or try-lock-based pattern is implemented
each stage required dedicated function introduced, which would have
been an overkill for that. But even if I got to implement the
try-lock-based solution with a single function containing both stages
I still couldn't avoid having the serial8250_get_baud_rate() and
serial8250_get_divisor() methods executed in the atomic context, which
isn't required for them and which would needlessly pro-long the CPU
executing with the IRQs disabled. As you well know it's better to
speed up the atomic context execution as much as possible. 

Secondly I didn't know much about the tty/serial subsystem internals
back then. So I was afraid to break some parts I didn't aware of if
the baud-rate/ref-clock change code had some implicit dependencies
from the surrounding code and vice-versa (like the LCR DLAB flag
state).

Finally frankly it didn't seem like that much worth bothering about.
Basically AFAICS there were only four methods which invocation I
would have needed to move to a separate function:

serial8250_get_baud_rate();
serial8250_get_divisor();
// spin-lock
uart_update_timeout(port, termios->c_cflag, baud);
serial8250_set_divisor(port, baud, quot, frac);
// spin-unlock

So I decided to take a simplest and safest path, and created a
dedicated method for the just the ref-clock updates case leaving the
baud-rate change task implemented in the framework of the standard
serial8250_do_set_termios() method.


Regarding doing vise-versa and calling the serial8250_do_set_termios()
method from serial8250_update_uartclk() instead. To be honest I didn't
consider that option. That might work though, but AFAICS the
serial8250_do_set_termios() function will do much more than it's
required in case if the ref-clock has changed.

-Serge(y)

> 
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

