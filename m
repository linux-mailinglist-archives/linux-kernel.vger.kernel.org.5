Return-Path: <linux-kernel+bounces-129671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF6896E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CD11C25311
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40604142E87;
	Wed,  3 Apr 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JH3JfN6o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K5frRWXH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D455142E82;
	Wed,  3 Apr 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144164; cv=none; b=oDB9Fj8mImHnwNAdNZQ0fiuIqzIH3SOJn5accc3AFyVTh+761tv4um+GPHt45dRIwhu3+B70SCjMNLMiJia9dEqP+YT7AFNMd84RSQrzoDNv3LCMN2MSbhD+TxY8G04MlfYOLW2RDtscJkLHYQI6MrnNnylAp6Atw9Cu1wWom2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144164; c=relaxed/simple;
	bh=t18WbamfCv19fhu0p/T4b+utaHreGFY0yfyl+Y4YJhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2DcFWrYK+DwFgPF1lp06br/Its9rOnFsfFZ2SL65t8IfPPTvULN+gO3fxZxjejCgp2g4tAuOJmugzJvN01TAL3rl1gCEa1M6tbT6eTfN+nCh99mGEQFMbnMKDuY9XTDmlPkUhbJwWPqt+lIWdxOJcwdoZwLtT2SiZ7PPbYFaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JH3JfN6o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K5frRWXH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712144159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwOgCCV+cQRD/xaqFLHbohMfDMRq7iMVCXN+izSf/FE=;
	b=JH3JfN6otUW/3RhGkD/vbOB9GI5MO9vk1GD+EssaV5ajEO0GTD8s8rA142kdX6SvBw3lgJ
	iX+rKGiW9DzSliLGVQ7lM1TtawMvTrVgiJjaYrK/6aGTocYgXVy4rcvIiq0bVAkPcpH9WU
	U2HS/Mni+6URhCqkvm03o1B2d/qQBhpEKYNbnrodk8jr9fRLSxTmVPywai/vDcSVsj8j87
	iC7dNY0ELzYizUGYHIrdzP+1dv8BMr7VzlQLBmZp3vk97ZbEqIC5EwYSjd00Ehg9rBZ5Y3
	Qt/5/IRHHMaus2myWEIieTCbMb2mYah+I8DIr51HpxgeJH3G3cjpawQTKi7Ynw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712144159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwOgCCV+cQRD/xaqFLHbohMfDMRq7iMVCXN+izSf/FE=;
	b=K5frRWXHLVFBs3ZMv26aoVB8lQ2Qp2HLp/+1xlk6R/kFn+KKF3fn7fbxCnVu5vNtmDWa6+
	0Gbt7TkH5cgUMxDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Fabio Estevam <festevam@denx.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-serial@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v4 09/27] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <20240402221129.2613843-10-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-10-john.ogness@linutronix.de>
Date: Wed, 03 Apr 2024 13:41:56 +0206
Message-ID: <87cyr6y8yr.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-03, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index d6a58a9e072a..2652b4d5c944 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3146,7 +3146,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>  	uport->state = state;
>  
>  	state->pm_state = UART_PM_STATE_UNDEFINED;
> -	uport->cons = drv->cons;
> +	uart_port_set_cons(uport, drv->cons);
>  	uport->minor = drv->tty_driver->minor_start + uport->line;
>  	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
>  				drv->tty_driver->name_base + uport->line);

Sebastian Siewior pointed out that the port lock is initialized shortly
after this code. Since uart_port_set_cons() uses the port lock, the
spinlock initialization must come first. The changes for serial_core.c
should be:

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a..0c13ea6a3afa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3145,8 +3145,15 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->uart_port = uport;
 	uport->state = state;
 
+	/*
+	 * If this port is in use as a console then the spinlock is already
+	 * initialised.
+	 */
+	if (!uart_console_registered(uport))
+		uart_port_spin_lock_init(uport);
+
 	state->pm_state = UART_PM_STATE_UNDEFINED;
-	uport->cons = drv->cons;
+	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
@@ -3155,13 +3162,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 		goto out;
 	}
 
-	/*
-	 * If this port is in use as a console then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_registered(uport))
-		uart_port_spin_lock_init(uport);
-
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 

