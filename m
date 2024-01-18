Return-Path: <linux-kernel+bounces-29982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518B83162C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8281C24E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143D1F939;
	Thu, 18 Jan 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Tkc+Aan";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBaZ9J2s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DF1F60B;
	Thu, 18 Jan 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571365; cv=none; b=Cnxjt+gH6FkEBPPwMHeFRw8BQN8Cv7ewMnQwpg53c91fq0nCixXA57pD7wN9wx7vswaUwPTuFNDkI5Y8YEIXIf3V7ikrU5kT2Oyqbr4qOrACR5mobiusL0Pm5NpK/RtdQFPV7tWGKFZU5PK7hC6A484LzrUYmAIypdzvXf6mDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571365; c=relaxed/simple;
	bh=6RYJFETgVonwoGrQdeArVdOIAHrlPJkKtpVNefoLqX4=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=im6oORTZ8D5gUYToyWmEZllxU7VWhcE9J3UGd5xB3EoEyPQvONSFv5Ifsk8z7oKYzxTInbZaXolOGd/FK+0gGGnWTLbN1Pyz+C93cG8iTglHWHYPKwPeQ3PDh+wwWdi3/RIBZhp/4RdgjlBDzA54NghCGhRtVZjVEoDQMjj2Zm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Tkc+Aan; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBaZ9J2s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705571361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtJSfvK3A5y9mI+37S4oOkJ0KbwWzw9oQsjQrL2qHqU=;
	b=1Tkc+AanrMIgQXX3igCznWvNO/Fj6EFNr+LYADjegXxaQmaBj8OFO5Gt6Ll4GlJlBlZZHS
	5YPpXWhg5auO1XGdHN81X4Mh8YCjSpUq/RFBtctb2RcMFm5IBOi5BSMhzZCgqmWhr/4yx8
	0jAhfsBqxO1eUKSq8UgRTMEAhuhzDRkojiWb7po36F2CqtMFjZhGc64NPYqBu3KE74R6J/
	KeQGxqXq5Zb1aG/HCJNZW6h1oGbcsCLz50vZPGPHAen+9EyUATCjH3vpPUOEIjiNoFs+Q2
	qplyjcP43vvPM1eofiR1j+gmMQeVQ2A1xx/SmSc5AXUSx6xHgjnFGzvBOpuVJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705571361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtJSfvK3A5y9mI+37S4oOkJ0KbwWzw9oQsjQrL2qHqU=;
	b=SBaZ9J2sRh2gSBU7w/itcinMraeWuHjBcVY6j1xo5aRoS0oz3ZdAPtiXXljxBYWj85uXIV
	V3ZByeISsGui2iCw==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, rdunlap@infradead.org,
 pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v3 1/2] printk: Add function to dump printk buffer
 directly to consoles
In-Reply-To: <402f0cbc3a573503c7cc794113aa5137ed7f276c.1705331453.git.sreenath.vijayan@sony.com>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
 <402f0cbc3a573503c7cc794113aa5137ed7f276c.1705331453.git.sreenath.vijayan@sony.com>
Date: Thu, 18 Jan 2024 10:55:20 +0106
Message-ID: <87le8nas4f.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-17, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> It is useful to be able to dump the printk buffer directly to
> consoles in some situations so as to not flood the buffer.
> This needs access to private items of printk like PRINTK_MESSAGE_MAX.
> Add function in printk.c to accomplish this.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> ---
>  include/linux/printk.h |  4 ++++
>  kernel/printk/printk.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 8ef499ab3c1e..0896745f31e2 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
>  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>  extern asmlinkage void dump_stack(void) __cold;
>  void printk_trigger_flush(void);
> +void dump_printk_buffer(void);
>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
> @@ -271,6 +272,9 @@ static inline void dump_stack(void)
>  static inline void printk_trigger_flush(void)
>  {
>  }
> +static inline void dump_printk_buffer(void)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_SMP
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f2444b581e16..5b11fb377f8f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4259,6 +4259,39 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
> +/**
> + * Dump the printk ring buffer directly to consoles
> + */
> +void dump_printk_buffer(void)
> +{
> +	struct kmsg_dump_iter iter;
> +	struct console *con;
> +	char *buf;
> +	size_t len;
> +	int cookie;
> +
> +	buf = kmalloc(PRINTK_MESSAGE_MAX, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	kmsg_dump_rewind(&iter);
> +	while (kmsg_dump_get_line(&iter, 1, buf, PRINTK_MESSAGE_MAX, &len)) {

Although using the kmsg_dump interface will provide you the messages,
they will not necessarily be in the correct format. Consoles can be set
to use extended format.

We probably should respect that console setting.

> +		/*
> +		 * Since using printk() or pr_*() will append the message to the
> +		 * printk ring buffer, they cannot be used to display the retrieved
> +		 * message. Hence console_write() of serial drivers is used.
> +		 */
> +		console_lock();
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(con) {
> +			if ((console_srcu_read_flags(con) & CON_ENABLED) && con->write)

console_is_usable() should be used instead. It makes the correct checks.

> +				con->write(con, buf, len);
> +		}
> +		console_srcu_read_unlock(cookie);
> +		console_unlock();
> +	}
> +	kfree(buf);
> +}

We could do something like this:

void dump_printk_buffer(void)
{
	console_lock();
	console_flush_on_panic(CONSOLE_REPLAY_ALL);
	console_unlock();
}

This version respects all the console features (formatting, handovers),
but console_flush_on_panic() does not to allow cond_resched(), which we
would want in this case.

We could take the console sequence-resetting code out into its own
helper function. Then it would look like this (comments removed to keep
things short):

static void console_rewind_all(void)
{
	struct console *c;
	short flags;
	int cookie;
	u64 seq;

	seq = prb_first_valid_seq(prb);

	cookie = console_srcu_read_lock();
	for_each_console_srcu(c) {
		flags = console_srcu_read_flags(c);

		if (flags & CON_NBCON)
			nbcon_seq_force(c, seq);
		else
			c->seq = seq;
	}
	console_srcu_read_unlock(cookie);
}

void console_flush_on_panic(enum con_flush_mode mode)
{
	bool handover;
	u64 next_seq;

	console_may_schedule = 0;

	if (mode == CONSOLE_REPLAY_ALL)
		console_rewind_all();

	console_flush_all(false, &next_seq, &handover);
}

void dump_printk_buffer(void)
{
	bool handover;
	u64 next_seq;

	console_lock();
	console_rewind_all();
	console_flush_all(true, &next_seq, &handover);
	console_unlock();
}

Any thoughts?

John

