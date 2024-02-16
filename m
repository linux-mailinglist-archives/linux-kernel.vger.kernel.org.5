Return-Path: <linux-kernel+bounces-69060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA448583FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AAF1F2953C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A64131725;
	Fri, 16 Feb 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYmfGGwy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC087132477;
	Fri, 16 Feb 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103984; cv=none; b=YPw37EmvQFNN50scF7zfPMab8yNtNpfMDET33OtSvsahCistzRv5fOCQeMKTWTZ3ODncznot9Bglypoyv2Ny+LrXpf5oP5EvgItiaoS9iZdagnaR1ttdIBiLiyjIVvaRCrpE9u0xbZ+NeDzuypnm24So3J62BWE9mcpLGpnL/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103984; c=relaxed/simple;
	bh=4b03AODyXw2dhcerB3q+8kAAZmMbrpPoAq/Cd681M34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiSvviNdw+TGTgvObmYBhVzoPq7NGcDLfa6Vh0nKz1of9oOfVwk9bfFtIS8UZiBnNgPrDkTXVKuWd5yFpvdF+tbI/WQN6uFmmGwJaxgY7YFNQLEgVF/c8R4Dul7cRerKOQrJzD9grim1W6BL54Ef2Z3MPeDTwFrGhRn5u1qweiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYmfGGwy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5129ece824aso212615e87.3;
        Fri, 16 Feb 2024 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103981; x=1708708781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjuIYZ2/nQytOSznRzBhBURn9kSW68YW2INNoMo6hf8=;
        b=HYmfGGwyHPNaHURe8sSawZH7ZIHMtwAteKDzzDjF31cF+NQEz7G9PtGh/e6YW/VCF8
         C1mCm8oXxrUymBhTU4VkRv1gRJaTInxOgey6RfNNo0rXLyYlg5slZQeaRSC++2Op0waa
         vpdrGaOLUjEEK4wrrjWp0INOS/hS2eeOjJkx1HPUr13A/z0KYSrIr1M/JRl2zdzHoj0Y
         mS//YF9BkilTQRsdf8860B3iPzzhy+563OF/R9dWj83UK52HdCZyflZu/KcD0CHA81As
         lMbtVUApX3ksacxjWVaXuvWIGvJLVIsyqWzkDkibvH9w3DBN8VN3cVPHPDNytkQmpXy3
         5SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103981; x=1708708781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjuIYZ2/nQytOSznRzBhBURn9kSW68YW2INNoMo6hf8=;
        b=Pv1QnykzwRlgD1SAGWl0XVjNjcfdLt2dFQRnGqogcmL1OaimdcluIaxMS68NOhviw+
         9cipR7Q/KdVJm67SnGYMXY568vP2M2EKpwYbYgEumjC4riHIm0/nSa/YwRSJSeX7MFau
         84MKABjO5W5+u8z6Cltj9q/eq9SVKIyK30kzw1XPKlE3f/ZyOiLWxXPfZWA04ksCSyFM
         b3EOZIT9eRXt5T4HX6JKEXcmW+wWAdRbz4SQ+t2WQycHKvFgwo1N1GDpPDYlbH6gN05c
         T7eGuV9m1UhW96MMpG6KK4uhcWfyfClEiZtJaBn3w/CjPor9lSRZGuW3tF0YlhthRtle
         YcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXJX92sndfJc7dKYL9qqB+QijkAApp83lrVxlaQ51OPcpfSpC3JRNTSdvRGUlUSF9gsBzk+1zS41q5tg5VKd78E/gKoDSyBLx/XqG34l4Yvhcv8e52AGNV29Vum21ORoukYpDrtFnzAStg9
X-Gm-Message-State: AOJu0YyzmiVgWHksFn7n08liXMQK1cda5dwP5Mj7r/TEPw/P3CxNfjpP
	yBbY67zLelo6NwJBjZiLWVW+o+Bz/MDfnc2VxQGEFhHmdo4qWaYzeU4ocJRL
X-Google-Smtp-Source: AGHT+IFitoiWW83Gkkzgm8QQaYKAB1Unqq6nI7A3Lq7nXl00tis9G69Rk6sgaR44qTdIHEAZ2P+IPQ==
X-Received: by 2002:a05:6512:3c9d:b0:511:9d36:18a8 with SMTP id h29-20020a0565123c9d00b005119d3618a8mr4805581lfv.2.1708103980598;
        Fri, 16 Feb 2024 09:19:40 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q4-20020a19a404000000b005117c7159a0sm21237lfc.169.2024.02.16.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:19:40 -0800 (PST)
Date: Fri, 16 Feb 2024 20:19:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@black.fi.intel.com>, 
	Serge Semin <Sergey.Semin@baikalelectronics.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jslaby@suse.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>, Maxime Ripard <mripard@kernel.org>, 
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: Add 8250 port clock update method
Message-ID: <ow5mvkxa4g7mub3faiytsij4cyaaralcbzyn675jny5355han7@azw65mhkpwjz>
References: <20200723003357.26897-1-Sergey.Semin@baikalelectronics.ru>
 <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>
 <ZczD7KPbeRnY4CFc@black.fi.intel.com>
 <raryiklwhctwxcfj3ulbnjcl32owagiccmxpwzmszlh3vm343y@h2ehupm7uiga>
 <Zc5oYJY6W_MCpwhN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5oYJY6W_MCpwhN@smile.fi.intel.com>

On Thu, Feb 15, 2024 at 09:39:12PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 10:32:18PM +0300, Serge Semin wrote:
> > On Wed, Feb 14, 2024 at 03:45:16PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jul 23, 2020 at 03:33:54AM +0300, Serge Semin wrote:
> > > > Some platforms can be designed in a way so the UART port reference clock
> > > > might be asynchronously changed at some point. In Baikal-T1 SoC this may
> > > > happen due to the reference clock being shared between two UART ports, on
> > > > the Allwinner SoC the reference clock is derived from the CPU clock, so
> > > > any CPU frequency change should get to be known/reflected by/in the UART
> > > > controller as well. But it's not enough to just update the
> > > > uart_port->uartclk field of the corresponding UART port, the 8250
> > > > controller reference clock divisor should be altered so to preserve
> > > > current baud rate setting. All of these things is done in a coherent
> > > > way by calling the serial8250_update_uartclk() method provided in this
> > > > patch. Though note that it isn't supposed to be called from within the
> > > > UART port callbacks because the locks using to the protect the UART port
> > > > data are already taken in there.
> 
> ...
> 
> > > > +/*
> > > > + * Note in order to avoid the tty port mutex deadlock don't use the next method
> > > > + * within the uart port callbacks. Primarily it's supposed to be utilized to
> > > > + * handle a sudden reference clock rate change.
> > > > + */
> > > > +void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
> > > > +{
> > > > +	struct uart_8250_port *up = up_to_u8250p(port);
> > > > +	unsigned int baud, quot, frac = 0;
> > > > +	struct ktermios *termios;
> > > > +	unsigned long flags;
> > > > +
> > > > +	mutex_lock(&port->state->port.mutex);
> > > > +
> > > > +	if (port->uartclk == uartclk)
> > > > +		goto out_lock;
> > > > +
> > > > +	port->uartclk = uartclk;
> > > > +	termios = &port->state->port.tty->termios;
> > > > +
> > > > +	baud = serial8250_get_baud_rate(port, termios, NULL);
> > > > +	quot = serial8250_get_divisor(port, baud, &frac);
> > > > +
> > > > +	serial8250_rpm_get(up);
> > > > +	spin_lock_irqsave(&port->lock, flags);
> > > > +
> > > > +	uart_update_timeout(port, termios->c_cflag, baud);
> > > > +
> > > > +	serial8250_set_divisor(port, baud, quot, frac);
> > > > +	serial_port_out(port, UART_LCR, up->lcr);
> > > > +	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
> > > > +
> > > > +	spin_unlock_irqrestore(&port->lock, flags);
> > > > +	serial8250_rpm_put(up);
> > > > +
> > > > +out_lock:
> > > > +	mutex_unlock(&port->state->port.mutex);
> > > 
> > 
> > > While looking for something else I have stumbled over this function.
> > > My Q is, since it has some duplications with
> > > serial8250_do_set_termios(), can we actually call the latter (or
> > > derevative that can be called in both) in the above code instead of
> > > duplicating some lines?
> > > 
> > > 	if (port UART clock has to be updated)
> > > 	  call (unlocked version of) serial8250_do_set_termios()
> > > 
> > > Serge, what do you think?
> > 
> > What an old thread you've digged out.)
> 
> Indeed :-)
> 
> > Well, AFAIR I didn't create a common baud-rate/clock-update method
> > because the baud-rate change was just a two stages action:
> > 1. calculate divisor+quot couple based on the new clock,
> > 2. update the divisor+quot (+ update the timeout).
> > The first stage didn't need to have the IRQsafe lock being held and
> > the runtime-PM being enabled, meanwhile the later one needed those.
> > So unless the nested locking or try-lock-based pattern is implemented
> > each stage required dedicated function introduced, which would have
> > been an overkill for that. But even if I got to implement the
> > try-lock-based solution with a single function containing both stages
> > I still couldn't avoid having the serial8250_get_baud_rate() and
> > serial8250_get_divisor() methods executed in the atomic context, which
> > isn't required for them and which would needlessly pro-long the CPU
> > executing with the IRQs disabled. As you well know it's better to
> > speed up the atomic context execution as much as possible. 
> > 
> > Secondly I didn't know much about the tty/serial subsystem internals
> > back then. So I was afraid to break some parts I didn't aware of if
> > the baud-rate/ref-clock change code had some implicit dependencies
> > from the surrounding code and vice-versa (like the LCR DLAB flag
> > state).
> > 
> > Finally frankly it didn't seem like that much worth bothering about.
> > Basically AFAICS there were only four methods which invocation I
> > would have needed to move to a separate function:
> > 
> > serial8250_get_baud_rate();
> > serial8250_get_divisor();
> > // spin-lock
> > uart_update_timeout(port, termios->c_cflag, baud);
> > serial8250_set_divisor(port, baud, quot, frac);
> > // spin-unlock
> > 
> > So I decided to take a simplest and safest path, and created a
> > dedicated method for the just the ref-clock updates case leaving the
> > baud-rate change task implemented in the framework of the standard
> > serial8250_do_set_termios() method.
> > 
> > 
> > Regarding doing vise-versa and calling the serial8250_do_set_termios()
> > method from serial8250_update_uartclk() instead. To be honest I didn't
> > consider that option. That might work though, but AFAICS the
> > serial8250_do_set_termios() function will do much more than it's
> > required in case if the ref-clock has changed.
> 

> My point here is that the idea behind clock change is most likely to be
> followed up by ->set_termios(). Why to do it differently if it's the case?

Not always. IIUC what you say is just a one path of the code executed
within the chain:

dw8250_set_termios()->dw8250_do_set_termios()->serial8250_do_set_termios()

But another code-path will be taken if the DW UART port
ref-clock is suddenly and asynchronously changed. In that case the
driver is notified by means of the dw8250_clk_notifier_cb() callback,
which doesn't need the entire set_termios() callback execution but
only what is defined in the serial8250_update_uartclk() method:

dw8250_clk_notifier_cb()
+-> worker:: dw8250_clk_work_cb()->serial8250_update_uartclk().

> And note, ->set_termios() can be called as many times as needed, so if nothing
> changes in between it's also fine. But this makes intention much clearer.
> Do you agree?

If what you suggest is to replace the serial8250_update_uartclk() body
with a direct uart_port::set_termios() invocation then I don't find it
being much clearer really. The serial8250_update_uartclk() is
currently specialized on doing one thing: adjusting the divider in
case of the UART-clock change. If instead the entire
serial8250_set_termios() method is called then for a reader it won't
be easy to understand what is really required for a 8250 serial port
to perceive the ref-clock change. But from the maintainability point
of view I guess that it might be safer to just call
serial8250_set_termios() indeed, since among the other things the
later method implies the divider update too. Thus the maintainer won't
need to support the two clock divider update implementations. From
that perspective I agree, directly calling serial8250_set_termios()
might be more suitable despite of it' doing more than required.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

