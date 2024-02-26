Return-Path: <linux-kernel+bounces-81286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303DC86735F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D91F27DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13E14A990;
	Mon, 26 Feb 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3gQ/FSS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Pcj5SVw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B02376A;
	Mon, 26 Feb 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947440; cv=none; b=HKf2Yka++FTRo+8UelImnOF4bOSPGvujGAYqK2o6i5XDg5cQ5BnC4WqzEoIcqAckdvgjz2Vbs/0BLOLXyn94XwC6+M2//UETKKaEIfVpSc/Wv1h8ySVwVtQM1pfM2tBU2YcgMBgldKcNr/ZUw65ACCnyuLLPIMhGyx9XnUh/v60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947440; c=relaxed/simple;
	bh=zAAJLho0cCO/HNTiCV3588QnktmmlyE4Z01Qd0pjWN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dahxsfpc51RiBY3Mcdt4QfCSlJTvtCowSdcm1jfb03zUUkTB4z0ZnUGIrgJj6YT4OBp17oCyOiFAbmUOuhGwJ7rWvfU/MOcUjR3Nv6U9i22zpoTC/0SSKhNZ3lK/6fnDIfgZARDUXiR4t04VepQ+MgXIguETQBpuISji7JmdWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3gQ/FSS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Pcj5SVw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708947431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BT9tAymdgF12edcAn5jaXSRSblrBPjimcTyWY1gKVQ=;
	b=r3gQ/FSS8tZI+vRzbrg42znqs4XhLBKCA3FHP41fG49mpUAKYPSFTBfnwBI0vl9DvSJth+
	3s1nQcIMV4JRDi19ntwTmgiZIHCBaYuyXsnx/y+ZF97BO2GjRQSNSTvBXB9DuS2aqSiatR
	T2z9z4DEzFaIVG+B5fGgyYXOSvvka49c0Mm1mDuLVbsd4Qfj9jPD3DNSxflBjlrhvdS5DL
	UyrO/18gCgb9Kj5Jy+n/V2yvL41DWIZ0lJ3g6XGwly4eY/youC3cBprwjDWNIYXIoseLl7
	mhBUJbsHaHusHD6fTVcYodfe7/s9cOfeuIn+qonaNq6TNEnX3hrzaPrkyJdEsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708947431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BT9tAymdgF12edcAn5jaXSRSblrBPjimcTyWY1gKVQ=;
	b=0Pcj5SVwVRMEILNtAi9Fm3gU1VFrH64Z4wHM04nWiSG26uri1Nb1O4aYF3UpFIrbYKJvx+
	/zO9Y0UcNtwM0yAg==
To: Peter Collingbourne <pcc@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: Lock console when calling into driver before
 registration
In-Reply-To: <20240222192329.1047386-1-pcc@google.com>
References: <20240222192329.1047386-1-pcc@google.com>
Date: Mon, 26 Feb 2024 12:42:43 +0106
Message-ID: <878r37mp84.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-22, Peter Collingbourne <pcc@google.com> wrote:
> During the handoff from earlycon to the real console driver, we have
> two separate drivers operating on the same device concurrently. In the
> case of the 8250 driver these concurrent accesses cause problems due
> to the driver's use of banked registers, controlled by LCR.DLAB. It is
> possible for the setup(), config_port(), pm() and set_mctrl() callbacks
> to set DLAB, which can cause the earlycon code that intends to access
> TX to instead access DLL, leading to missed output and corruption on
> the serial line due to unintended modifications to the baud rate.
>
> In particular, for setup() we have:
>
> univ8250_console_setup()
> -> serial8250_console_setup()
> -> uart_set_options()
> -> serial8250_set_termios()
> -> serial8250_do_set_termios()
> -> serial8250_do_set_divisor()
>
> For config_port() we have:
>
> serial8250_config_port()
> -> autoconfig()
>
> For pm() we have:
>
> serial8250_pm()
> -> serial8250_do_pm()
> -> serial8250_set_sleep()
>
> For set_mctrl() we have (for some devices):
>
> serial8250_set_mctrl()
> -> omap8250_set_mctrl()
> -> __omap8250_set_mctrl()
>
> To avoid such problems, let's make it so that the console is locked
> during pre-registration calls to these callbacks, which will prevent
> the earlycon driver from running concurrently.

Even after the current atomic/threaded print rework is completed, the
console lock will be used to synchronize boot consoles with non-boot
consoles. I am fine with this solution.

Comments below...

> Remove the partial solution to this problem in the 8250 driver
> that locked the console only during autoconfig_irq(), as this would
> result in a deadlock with the new approach. The console continues
> to be locked during autoconfig_irq() because it can only be called
> through uart_configure_port().
>
> Although this patch introduces more locking than strictly necessary
> (and in particular it also locks during the call to rs485_config()
> which is not affected by this issue as far as I can tell), it follows
> the principle that it is the responsibility of the generic console
> code to manage the earlycon handoff by ensuring that earlycon and real
> console driver code cannot run concurrently, and not the individual
> drivers.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee543fa5b25532de55d8
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/8250/8250_port.c |  6 ------
>  drivers/tty/serial/serial_core.c    | 10 ++++++++++
>  kernel/printk/printk.c              | 20 +++++++++++++++++---
>  3 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 8ca061d3bbb9..1d65055dde27 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  		inb_p(ICP);
>  	}
>  
> -	if (uart_console(port))
> -		console_lock();
> -
>  	/* forget possible initially masked and pending IRQ */
>  	probe_irq_off(probe_irq_on());
>  	save_mcr = serial8250_in_MCR(up);
> @@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	if (port->flags & UPF_FOURPORT)
>  		outb_p(save_ICP, ICP);
>  
> -	if (uart_console(port))
> -		console_unlock();
> -
>  	port->irq = (irq > 0) ? irq : 0;
>  }
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index d6a58a9e072a..128aa0e0ae24 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2608,7 +2608,11 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  			port->type = PORT_UNKNOWN;
>  			flags |= UART_CONFIG_TYPE;
>  		}

It would be nice to add a comment here mentioning why the console_lock
is taken. Even if it is something brief like:

     /* Sychronize with possible boot console. */

> +		if (uart_console(port))
> +			console_lock();
>  		port->ops->config_port(port, flags);
> +		if (uart_console(port))
> +			console_unlock();
>  	}
>  
>  	if (port->type != PORT_UNKNOWN) {
> @@ -2616,6 +2620,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  
>  		uart_report_port(drv, port);
>  

Also, here a brief comment.

> +		if (uart_console(port))
> +			console_lock();
> +
>  		/* Power up port for set_mctrl() */
>  		uart_change_pm(state, UART_PM_STATE_ON);
>  
> @@ -2632,6 +2639,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  
>  		uart_rs485_config(port);
>  
> +		if (uart_console(port))
> +			console_unlock();
> +
>  		/*
>  		 * If this driver supports console, and it hasn't been
>  		 * successfully registered yet, try to re-register it.
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f2444b581e16..db69545e6250 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3263,6 +3263,20 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  

And here. Maybe slightly more verbose since there is an entire wrapper
function created for the purpose.

> +static int console_call_setup(struct console *newcon, char *options)
> +{
> +	int err;
> +
> +	if (!newcon->setup)
> +		return 0;
> +
> +	console_lock();
> +	err = newcon->setup(newcon, options);
> +	console_unlock();
> +
> +	return err;
> +}
> +
>  /*
>   * This is called by register_console() to try to match
>   * the newly registered console with any of the ones selected
> @@ -3298,8 +3312,8 @@ static int try_enable_preferred_console(struct console *newcon,
>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  
> -			if (newcon->setup &&
> -			    (err = newcon->setup(newcon, c->options)) != 0)
> +			err = console_call_setup(newcon, c->options);
> +			if (err != 0)
>  				return err;
>  		}
>  		newcon->flags |= CON_ENABLED;
> @@ -3325,7 +3339,7 @@ static void try_enable_default_console(struct console *newcon)
>  	if (newcon->index < 0)
>  		newcon->index = 0;
>  
> -	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
> +	if (console_call_setup(newcon, NULL) != 0)
>  		return;
>  
>  	newcon->flags |= CON_ENABLED;
> -- 
> 2.44.0.rc1.240.g4c46232300-goog

With comments added:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

