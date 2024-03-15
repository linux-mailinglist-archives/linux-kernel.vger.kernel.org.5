Return-Path: <linux-kernel+bounces-104555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE487CFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2666AB22EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F03CF5D;
	Fri, 15 Mar 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EXttC0Fv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z14PxYy5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067836B16;
	Fri, 15 Mar 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515107; cv=none; b=d804UX0qlkMd2fEZxlacS98w0ZuWgolC/t8ldmf28jYc0aBR7hxXmng50PFOWH+07Hujs0idNBlE2mrd6jCrqNU6pO6WC+EkMOXsCXJxlpq6HOa1XDKfp7TCpM15vCr4u61nVP0jGK3yfuxHUV9Wdik74QXfOktnnjo+94HzSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515107; c=relaxed/simple;
	bh=ju+n9ZomxU1jNHoeJ4GZimkTA1Tghkr8Pg0B3Z0iPSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgCb49kNK3umfmpkCQ1WIkoCZBrh/KuflghnEcPAMZIOsXMcFOwgM7oopa6GnZdO/QzYljxF0NIYkLzjlUAgCFtvre81KUBPH7hQsMjeIoVuUeFHvZdtW41+yh8pAwRWmfeVInYQUXiJdY6GNNce7pCk45hNJU4FPLcdbWazjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EXttC0Fv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z14PxYy5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710515104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCdevXmF6DjSTLCuUUCIdYW8QHC/CXmZ3QEqhDdEWIE=;
	b=EXttC0FvY9qojcc5DNQNk5mtD1j/BdL2Gl14cbBd9BUH1Hh2lJ+s4SZ2lINwEq0aNcjcWS
	h+ASzOJvXkNOGjwqp7lBRsfBCH6Uqvy0H5giGZ4Ondaz896urce9mbBxDKTqrF34O/Ootw
	iblvIINiEWHEtdeY3NvLVraGcJ3dpOGpQaIvdZiybWv66omamuzmxLIwleJ90lgFsmNcMI
	UBh3DtL1N285KnFC7BPXdPVaCLqno6nkUw1umBGpSmv2XgXSp+VZfLfyY4p6VSRqaCVSMX
	X9ROituhrOKplSS6zNQTrrTGNgA80o7L9aF3XO8I8aLJhfX1G3e5kTLXVD9gnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710515104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCdevXmF6DjSTLCuUUCIdYW8QHC/CXmZ3QEqhDdEWIE=;
	b=z14PxYy530yka2FvZ8qieyP2wa27BGrL1IddvHiI9rSdnG1rGJEAV6O7RzEZl4pkO46G3U
	XyPHZhNwnmJofvDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Justin Chen
 <justin.chen@broadcom.com>, Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
In-Reply-To: <ZfMIX8bsftsDNdlm@alley>
References: <Zdh4eEJJpasEWqa5@alley> <87le6oy9vg.fsf@jogness.linutronix.de>
 <ZfMIX8bsftsDNdlm@alley>
Date: Fri, 15 Mar 2024 16:10:18 +0106
Message-ID: <87sf0rbkp9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-03-14, Petr Mladek <pmladek@suse.com> wrote:
> Well, it brings another question. Does this allow to have
> the following situation?
>
> CPU0				CPU1
>
>   some_function()
>     uart_port_lock()
>       // locked just with up->lock
>       // doing something with the port
>
> 				register_console()
> 				  // add struct console using the same
> 				  // port as CPU0
> 				  printk()
> 				    console_try_lock()
> 				    console_unlock()
> 				      console_flush_all()
> 					// acquire context for the newly
> 					// registered nbcon
> 					nbcon_context_try_acquire(ctxt)
> 					  con->write()
>
> BANG: Both CPU0 and CPU1 are writing to the same port.
>
> Reason: CPU0 locked only via port->lock.
> 	CPU1 locked only by acquiring nbcon context.

Great catch! Yes, this is possible. :-/

When the kthread series part is introduced, there will be additional
callbacks that nbcon consoles must implement
(driver_enter()/driver_exit()). These provide driver-level
synchronization. In the case of serial uarts, the callbacks map to
locking/unlocking the port lock.

If I were to introduce those callbacks in _this_ series, they can be
used when adding a console to the list in register_console(). This
changes your example to:

CPU0				CPU1

  some_function()
    uart_port_lock()
      // locked just with up->lock
      // doing something with the port

				register_console()
				  // add struct console using the same
				  // port as CPU0
				  newcon->driver_enter()
				    spin_lock(port_lock)
				    // spin on CPU0
    uart_port_unlock()
				  // add new console to console list
				  newcon->driver_exit()
				    spin_unlock(port_lock)
				  ...

If any other CPUs come in and call uart_port_lock(), they will see the
console as registered and will acquire the nbcon to avoid the BANG.

> Maybe, this is not possible because the console is registered when
> the struct uart_port is being initialized and nobody could
> use the same port in parallel, except for the early console.
> Where the early console is serialized using the console_lock().

Yes, it is possible. Just check out:

    find /sys/ -name console -type f

If you echo 'Y' or 'N' into any of those files, you can dynamically
register and unregister those consoles, respectively.

I just ran some tests to verify this and was even able to trigger a
mainline bug because probe_baud() of the 8250 driver is not called under
the port lock. This is essentially the same scenario you
illustrated. But the 8250 probe_baud() issue is a driver bug and not
related to this series.

Getting back to this series, my proposal would change register_console()
like this:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 68657d4d6649..25a0a81e8397 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3733,6 +3733,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	unsigned long flags;
 	int err;
 
 	console_list_lock();
@@ -3831,6 +3832,19 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT)
 		have_boot_console = true;
 
+	/*
+	 * If another context is actively using the hardware of this new
+	 * console, it will not be aware of the nbcon synchronization. This
+	 * is a risk that two contexts could access the hardware
+	 * simultaneously if this new console is used for atomic printing
+	 * and the other context is still using the hardware.
+	 * 
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this new console transitions to being registered.
+	 */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->driver_enter(newcon, &flags);
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3855,6 +3869,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->driver_exit(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*

> One solution would be to add nbcon consoles into the console_list
> under uart_port_lock().

This is what I have proposed and I think it is the most straight forward
solution.

> Another solution would be to make sure that any code serialized
> by uart_port_lock() will be already synchronized by nbcon context
> while the nbcon is added into the console_list.

I do not think this would be acceptable. It would mean that non-console
ports would need to lock the nbcon. Not only will that slow down the
non-console ports, but it will also cause serious contention between the
ports. (Remember, all the ports share the same struct console.)

> Maybe, we could do this in con->setup() callback. Something like:

This proposal would work, but IMHO it adds too much complexity by
requiring console drivers to implement the callbacks and do special
things in those callbacks.

>> The various fields have the following meaning (AFAICT):
>> 
>> port->line: An identifier to represent a particular port supported by a
>> driver.
>> 
>> port->cons: The struct console to use if this port is chosen to be a
>> console.
>> 
>> port->console: Boolean, true if this port was chosen to be a
>> console. (Used only by the tty layer.)
>> 
>> cons->index: The port chosen by printk to be a console.
>> 
> This is a great description. It would be great to have it somewhere in
> the sources. Maybe, above the locking/acquire functions.

OK.

John

