Return-Path: <linux-kernel+bounces-99288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC9878608
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06494281E76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7B4AEFA;
	Mon, 11 Mar 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Pb7nL1u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N14hTbon"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84E4879E;
	Mon, 11 Mar 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176945; cv=none; b=L2kF7Ei5+sCsZ6j+6ArYWN217j4mrLoukgHT0gknp14QCFQVyZfi+q94mMfyznwbCcKyeqScwYfjdJbKEWrjWax1HqQUufVJMV64Jc8YSMBGErgpyrslkCxckUEhj77z+6S9a76+CyVNGTxc4ZP9Pmr1vBmdmXT8J1hlq93ooho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176945; c=relaxed/simple;
	bh=TTbvqXWR6nWc/MsNEekN815JYhHFt7v4LSNzAZdhZFg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=KNap6jWSwVkmcFA/EHF+66iY+AOobblO9y6ZN4fa9H2UUuC57zUD2zQZQh32TW9/9vJGO7eUUntmn0lZBzrQtASISsX+J469uF9lxPe39IGQqOMJoaKEw0wh2CnUcSQSJblFgaIUUP6zW8AkblHHX43Mg8HFaFtLPlbAXsyqtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Pb7nL1u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N14hTbon; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710176941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Pc+jEfFefB7uqRYli5YEqbddwRCfK3q/jPl/mANg1eQ=;
	b=4Pb7nL1uZluXsXaQXj9+fIHoxOv3BfquNGMVyD6ru3GEVOxqbStueZSx5QRFlti7OEvqd3
	kAdC3qhErTPer/VSXHM6UlH1NgDx5HavOMg5rboq8ncKxPR97TlSNCK+dppdIwtBxkzcA5
	ZEfBpmGFuc2UIxYOM9cLMWxv7b8EKFU+pSl45vgmLP25A1iW5zU/OXw9UU2TmtYTlsiSDV
	xVgnXON8/j+Ze+shGDs8Am215nnwCOOA28thtSY8E5pkwMTpVp6fTcBDc+aQ0k9JZYO1Rn
	ulhXg44nhaqpMERou3O2WmhePZfW9ynNJky7W9XIp4DczoAZn4rnMlQ4LkAxoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710176941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Pc+jEfFefB7uqRYli5YEqbddwRCfK3q/jPl/mANg1eQ=;
	b=N14hTbonYxEhKhXubgvcXK1awp8V2a/10ZS63H+v9z+0tsYFO09l8Wzr3zZQXr1wICTCMb
	MfmRcVpcpWmwxPDQ==
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
In-Reply-To: <Zdh4eEJJpasEWqa5@alley>
Date: Mon, 11 Mar 2024 18:14:19 +0106
Message-ID: <87le6oy9vg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

Thanks for the detailed feedback. Here is a lengthy response. I hope it
clarifies the uart port and console fields. And I think you identified a
bug relating to the setup() callback.

On 2024-02-23, Petr Mladek <pmladek@suse.com> wrote:
> My main (only) concern was the synchronization of the various accessed
> variables, especially, port->cons.

The only issue is if port->cons disappears between lock and unlock. I
see there is code setting port->cons to NULL, although I do not know
why. Once port->cons is set, there is never a reason to unset it.

Regardless, I will add port->lock synchronization when modifying
port->cons. There are only a few code sites and they are all during
driver setup.

> Note: I am not completely sure how the early and valid console drivers
>       share the same struct uart_port. So, maybe I miss some important
>       guarantee.

The struct uart_port is _not_ shared between the early and normal
consoles. However, the struct console is shared for normal consoles
amoung various ports of a particular driver.

> Anyway. synchronization of port->cons looks like a shade area.
> IMHO, the existing code expects that it is used _only when the console
> is registered_. But this patch wants to access it _even before
> the console is registered_!

Indeed. It is not enough for uart_is_nbcon() to check if it is an
NBCON. It must also check if it is registered, locklessly:

    hlist_unhashed_lockless(&con->node);

Most importantly to be sure that nbcon_init() has already been called.
register_console() clears the nbcon state after cons->index has been
set, but before the console has been added to the list.

> For example, it took me quite a lot of time to shake my head around:
>
> #define uart_console(port) \
> 	((port)->cons && (port)->cons->index == (port)->line)
>
>   + port->cons and port->line are updated in the uart code.
>     It seems that the update is not serialized by port->lock.
>     Something might be done under port->mutex.
>
>   + cons->index is updated in register_console() under
>     console_list_lock.
>
> Spoiler: I propose a solution which does not use uart_console().

This check is necessary because multiple ports of a driver will set and
share the same port->cons value, even if they are not really the
console. I looked into enforcing that port->cons is NULL if it is not a
registered console, but this is tricky. port->cons is driver-internal
and hidden from printk. The driver will set port->cons in case it
becomes the console and printk will set cons->index once it has chosen
which port will be the actual console. But there is no way to unset
port->cons if a port was not chosen by printk.

The various fields have the following meaning (AFAICT):

port->line: An identifier to represent a particular port supported by a
driver.

port->cons: The struct console to use if this port is chosen to be a
console.

port->console: Boolean, true if this port was chosen to be a
console. (Used only by the tty layer.)

cons->index: The port chosen by printk to be a console.

None of those fields specify if the port is currently registered as a
console. For that you would need to check if port->cons->node is hashed
and then verify that port->line matches port->cons->index. This is what
uart_nbcon_acquire() needs to do (as well as check if it is an nbcon
console).

>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -3284,6 +3284,7 @@ void serial8250_init_port(struct uart_8250_port *up)
>>  	struct uart_port *port = &up->port;
>>  
>>  	spin_lock_init(&port->lock);
>> +	port->nbcon_locked_port = false;
>
> I am not sure if the variable really helps anything:
>
>    + nbcon_context release() must handle the case when it
>      lost the ownership anyway.

uart_nbcon_release() must first check if the provided port is a
registered nbcon console. A simple boolean check is certainly faster
than the 4 checks mentioned above. After all, if it was never locked,
there is no reason to unlock it.

>    + nbcon_acquire() is called under port->lock. It means that
>      nbcon_release() should always be called when the acquire
>      succeeded earlier.

Same answer as above.

> We just need to make sure that port->cons can be cleared only
> under port->lock. But this would be required even with
> port->nbcon_locked_port.

Agreed. I will add this.

>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -995,3 +996,79 @@ void nbcon_free(struct console *con)
>>  
>>  	con->pbufs = NULL;
>>  }
>> +
>> +static inline bool uart_is_nbcon(struct uart_port *up)
>> +{
>> +	int cookie;
>> +	bool ret;
>> +
>> +	if (!uart_console(up))
>
> This function accesses up->cons. I am not completely sure how
> this value is synchronized, for example:
>
>   + serial_core_add_one_port() sets uport->cons under port->mutex.
>     The function is called uart_add_one_port() in various probe()
>     or init() calls.

I will add port->lock synchronization.

>   + univ8250_console_setup() sets and clears port->cons with
>     no explicit synchronization. The function is called from
>     try_enable_preferred_console() under console_list_lock.

I will add port->lock synchronization.

> IMHO, the assignment is done when the drivers are being initialized.
> It is done when the port might already be used by early consoles.
>
> Especially, according to my understanding, newcon->setup() callbacks
> are responsible for using the same port by early and real console drivers.
>
> I guess that uart_port_lock() API is used by early consoles as well.
> It means that they might access up->cons here while it is being
> manipulated by the proper driver.

Note that port->lock does not synchronize early and normal
consoles. Only the console lock can do that. But you bring up a very
good point with setup(). serial8250_console_setup() can call
probe_baud(), which will write to the hardware.

I think that con->setup() needs to be called under the console lock
(just as already with unblank() and device()).

>> +		return false;
>> +
>> +	cookie = console_srcu_read_lock();
>> +	ret = (console_srcu_read_flags(up->cons) & CON_NBCON);
>> +	console_srcu_read_unlock(cookie);
>
> Hmm, console_srcu_read_flags(con) is called under
> console_srcu_read_lock() to make sure that it does not
> disappear. It makes sense when it is used by registered consoles.
>
> But uart_port_lock() might be called even when the console
> is not registered.
>
> I suggest to remove the SRCU lock here. In this code path,
> it does not guarantee anything and is rather misleading.

Agreed.

> I would use a READ_ONCE(), for example by splitting:
>
> /*
>  * Locklessly reading console->flags provides a consistent
>  * read value because there is at most one CPU modifying
>  * console->flags and that CPU is using only read-modify-write
>  * operations to do so.
>  *
>  * The caller must make sure that @con does not disappear.
>  * It can be done by console_srcu_read_lock() when used
>  * only for registered consoles.
>  */
> static inline short console_read_flags(const struct console *con)
> {
> 	return data_race(READ_ONCE(con->flags));
> }
>
> /* Locklessly reading console->flags for registered consoles */
> static inline short console_srcu_read_flags(const struct console *con)
> {
> 	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
>
> 	console_read_flags();
> }

OK.

>> +void uart_nbcon_acquire(struct uart_port *up)
>> +{
>> +	struct console *con = up->cons;
>> +	struct nbcon_context ctxt;
>
> I would add:
>
> 	lockdep_assert_held(&up->lock);

OK.

>> +
>> +	if (!uart_is_nbcon(up))
>> +		return;
>> +
>> +	WARN_ON_ONCE(up->nbcon_locked_port);
>> +
>> +	do {
>> +		do {
>> +			memset(&ctxt, 0, sizeof(ctxt));
>> +			ctxt.console	= con;
>> +			ctxt.prio	= NBCON_PRIO_NORMAL;
>> +		} while (!nbcon_context_try_acquire(&ctxt));
>> +
>> +	} while (!nbcon_context_enter_unsafe(&ctxt));
>> +
>> +	up->nbcon_locked_port = true;
>> +}
>> +EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
>
> I would prefer to split the uart and nbcon specific code, for example:

Can you explain why? This code will not be used anywhere else.

> /**
>  * nbcon_normal_context_acquire - Acquire a generic context with
>  *	the normal priority for nbcon console
>  * @con:	nbcon console
>  *
>  * Context:	Any context which could not be migrated to another CPU.
>  *
>  * Acquire a generic context with the normal priority for the given console.
>  * Prevent the release by entering the unsafe state.
>  *
>  * Note: The console might still loose the ownership by a hostile takeover.
>  *	 But it can be done only by the final flush in panic() when other
>  *	 CPUs should be stopped and other contexts interrupted.
>  */
> static void nbcon_normal_context_acquire(struct console *con)
> {
> 	struct nbcon_context ctxt;
>
> 	do {
> 		do {
> 			memset(&ctxt, 0, sizeof(ctxt));
> 			ctxt.console	= con;
> 			ctxt.prio	= NBCON_PRIO_NORMAL;
> 		} while (!nbcon_context_try_acquire(&ctxt));
>
> 	} while (!nbcon_context_enter_unsafe(&ctxt));
> }
>
> /**
>  * uart_nbcon_acquire - Acquire nbcon console associated with the gived port.
>  * @up:		uart port
>  *
>  * Context:	Must be called under up->lock to prevent manipulating
>  *		up->cons and migrating to another CPU.
>  *
>  * Note: The console might still loose the ownership by a hostile takeover.
>  *	 But it can be done only by the final flush in panic() when other
>  *	 CPUs should be stopped and other contexts interrupted.
>  */
> void uart_nbcon_acquire(struct uart_port *up)
> {
> 	struct console *con; = up->cons;
>
> 	lockdep_assert_held(&up->lock);
>
> 	/*
> 	 * FIXME: This would require adding WRITE_ONCE()
> 	 * on the write part.
> 	 *
> 	 * Or even better, the value should be modified under
> 	 * port->lock so that simple read would be enough here.
> 	 */
> 	con = data_race(READ_ONCE(up->cons));
>
> 	if (!con)
> 		return;
>
> 	if (!console_read_flags(con) & CON_NBCON)
> 		return;
>
> 	nbcon_normal_context_acquire(con);
> }
>
> Note that I did not use up->nbcon_locked_port as explained above.

Note that it will not work because other ports will share the same
up->cons value even though they are not consoles. up->cons only
specifies which struct console to use _if_ printk chooses that port as a
console. It does _not_ mean that printk has chosen that port.

>> +void uart_nbcon_release(struct uart_port *up)
>> +{
>> +	struct console *con = up->cons;
>> +	struct nbcon_context ctxt = {
>> +		.console	= con,
>> +		.prio		= NBCON_PRIO_NORMAL,
>> +	};
>> +
>
> I would add here as well.
>
> 	lockdep_assert_held(&up->lock);

OK.

> This deserves a comment why we do not complain when this function
> is called for nbcon and it is not locked. Something like:
>
> 	/*
> 	 * Even port used by nbcon console might be seen unlocked
> 	 * when it was locked and the console has been registered
> 	 * at the same time.
> 	 */

I think a more appropriate comment would be:

	/*
	 * This function is called for ports that are not consoles
	 * and for ports that may be consoles but are not nbcon
	 * consoles. In those the cases the nbcon console was
	 * never locked and this context must not unlock.
	 */

>> +	if (!up->nbcon_locked_port)
>> +		return;
>> +
>> +	if (nbcon_context_exit_unsafe(&ctxt))
>> +		nbcon_context_release(&ctxt);
>> +
>> +	up->nbcon_locked_port = false;
>> +}
>
> Again I would better split the nbcon and uart part and create:

I can do the split, but I do not see the reason for it.

John

