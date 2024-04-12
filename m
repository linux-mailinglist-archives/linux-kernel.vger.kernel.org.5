Return-Path: <linux-kernel+bounces-142949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A925A8A326D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9039B24947
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306EA1482EE;
	Fri, 12 Apr 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O7zdx4J6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6961145B19
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935676; cv=none; b=C195SuhWJzqtguMb6b7axkysV5nj8nw3sT6RSTR8Eeoh4glj2sTgnTMQg4Ceruu+rMoMHHM95YCI50we1hpOH0u3rbkU0hMQM2XVFHOq/CM9zHFaGp4DHDXzyE9n1WzBM9/aBpyo7Vco9WAslc97BlxsjXY95ySqs/4/6Ex6oYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935676; c=relaxed/simple;
	bh=H8uUHgCe5V84VdAJGyN7BMhvLQuo5yTCRTM6OsmkT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohjpBRltBU+n2Ap4ZxxDSegq1ZLzK+85HygQUCzvHjbKkGE0Mq/bjlvHvz+xhxWLGIUtdck4U7ZXoJbMpR8fkZiiDylVil3pjF8JqqSKrrCRSLG1zOcsc/UI9/lhYzsXa4BSz34QM2O/VVFHIAxIHmLoMjduWaoN+46I+R3O4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O7zdx4J6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-415515178ceso7832365e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712935672; x=1713540472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdBdCvKKua4+f6Vw8rQAPtII7kUQEToeAXQo0dDZIG4=;
        b=O7zdx4J6BridwmkGETybCk6ZFCFafjWquDA5FPXHsqrtclg7NuxkVfysUQoxCm7k+2
         hJFWaBvATdojAYYvxlmiziptP7FbrAZtaGKdQImAzm7rbTTabAt/0tMZW1Z+Ltqjeqyj
         XTtec76DLyZk0pex3Nt+DGjByyvaITeR8nKT/3ki1Uag8Her+wAU8OeY/AAMeBrSs6c/
         71da9Nq6rzvaiDcSPsuzAMA/tqTJvsQ3+DjMnpKy1aGV7aN7wW3DZR7nwAGfNnYW9aHU
         M0PznPLQQ/h9uPVrWDd5qYfyX6uZZhTdsNfYi2JtuDA66efSHkAgDMQb14d6ADNuzsdz
         OJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935672; x=1713540472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdBdCvKKua4+f6Vw8rQAPtII7kUQEToeAXQo0dDZIG4=;
        b=SuG14vntNR738pnDVCoxqJRc/x5Tqlkcy2byq+Ffhsjf6s9LXhpoLPhND8ExNTa0AW
         wYwluevleeAiDMppsNg+cHt/G6Lko1rKb6YMa5h2RuKqLQKDOwb4XH645pfWrz1wuRRS
         V97JCrhwnkblUPIAAbBIpUqzwwcVlr7R8bZ8pU8kptCwYwhhG0nKV7G6ksahQsSunGiF
         SoRrjkrDR3fUIZSyvtg7N3dM21F5VlBbqfShlEwby4wg6OW/i2nFaR5hR90bkwH0CYjD
         7SlH3AL9/EG/59TnYbRVkN0VejAqlgWWa9UqpNt1mEaMu7XLxO8FKU0LGNOdYXo5ZT7C
         37tg==
X-Forwarded-Encrypted: i=1; AJvYcCVW5yJIGbyhU+43YWEENk1Ik0GC2uvnMMqdgdUlej2C76YLp0p3m27+kTSYCwz6qH4dIHWRM99qdoijBTnLrOC7f33KiBfAIHhlby1s
X-Gm-Message-State: AOJu0Yy//6pcB1JmTElL6lnBYZ7ikx/Y8NN2V7DiSANOdiP6IKkUPAhe
	b7Nj9VdXmQdt8XsQK7VHCicYvY9VP6cXdCwdcz7fM/3/pLJG8gWNOAJMb6fFj7I=
X-Google-Smtp-Source: AGHT+IH7uFKl/b2Kb9lEFeIy8ccvwObBdVl48B/qGToHa+gJ99PHyn328o73/aV40SsMSObOfyThlQ==
X-Received: by 2002:a05:600c:5489:b0:418:af0:3b4a with SMTP id iv9-20020a05600c548900b004180af03b4amr1047541wmb.14.1712935671959;
        Fri, 12 Apr 2024 08:27:51 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm8801617wmq.35.2024.04.12.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:27:51 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:27:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 23/27] printk: nbcon: Implement emergency
 sections
Message-ID: <ZhlS9fsKrLe242Zn@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-24-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-24-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:25, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In emergency situations (something has gone wrong but the
> system continues to operate), usually important information
> (such as a backtrace) is generated via printk(). Each
> individual printk record has little meaning. It is the
> collection of printk messages that is most often needed by
> developers and users.
> 
> In order to help ensure that the collection of printk messages
> in an emergency situation are all stored to the ringbuffer as
> quickly as possible, disable console output for that CPU while
> it is in the emergency situation. The consoles need to be
> flushed when exiting the emergency situation.
> 
> Add per-CPU emergency nesting tracking because an emergency
> can arise while in an emergency situation.
> 
> Add functions to mark the beginning and end of emergency
> sections where the urgent messages are generated.
> 
> Do not print if the current CPU is in an emergency state.
> 
> When exiting all emergency nesting, flush nbcon consoles
> directly using their atomic callback. Legacy consoles are
> triggered for flushing via irq_work because it is not known
> if the context was safe for a trylock on the console lock.
> 
> Note that the emergency state is not system-wide. While one CPU
> is in an emergency state, another CPU may continue to print
> console messages.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
> ---
>  include/linux/console.h |  4 ++
>  kernel/printk/nbcon.c   | 83 +++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c  | 13 ++++++-
>  3 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 5f1758891aec..7712e4145164 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -559,10 +559,14 @@ static inline bool console_is_registered(const struct console *con)
>  	hlist_for_each_entry(con, &console_list, node)
>  
>  #ifdef CONFIG_PRINTK
> +extern void nbcon_cpu_emergency_enter(void);
> +extern void nbcon_cpu_emergency_exit(void);
>  extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
>  extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
>  extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
>  #else
> +static inline void nbcon_cpu_emergency_enter(void) { }
> +static inline void nbcon_cpu_emergency_exit(void) { }
>  static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 47f39402a22b..4c852c2e8d89 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -936,6 +936,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	return nbcon_context_exit_unsafe(ctxt);
>  }
>  
> +/* Track the nbcon emergency nesting per CPU. */
> +static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
> +static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
> +
> +/**
> + * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
> + *
> + * Return:	Either a pointer to the per CPU emergency nesting counter of
> + *		the current CPU or to the init data during early boot.
> + */
> +static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
> +{
> +	/*
> +	 * The value of __printk_percpu_data_ready gets set in normal
> +	 * context and before SMP initialization. As a result it could
> +	 * never change while inside an nbcon emergency section.
> +	 */
> +	if (!printk_percpu_data_ready())
> +		return &early_nbcon_pcpu_emergency_nesting;
> +
> +	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
> +}
> +
>  /**
>   * nbcon_atomic_emit_one - Print one record for an nbcon console using the
>   *				write_atomic() callback
> @@ -977,9 +1000,15 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>   */
>  enum nbcon_prio nbcon_get_default_prio(void)
>  {
> +	unsigned int *cpu_emergency_nesting;
> +
>  	if (this_cpu_in_panic())
>  		return NBCON_PRIO_PANIC;
>  
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +	if (*cpu_emergency_nesting)
> +		return NBCON_PRIO_EMERGENCY;
> +
>  	return NBCON_PRIO_NORMAL;
>  }
>  
> @@ -1146,6 +1175,60 @@ void nbcon_atomic_flush_unsafe(void)
>  	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
>  }
>  
> +/**
> + * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
> + *	messages for that CPU are only stored
> + *
> + * Upon exiting the emergency section, all stored messages are flushed.
> + *
> + * Context:	Any context. Disables preemption.
> + *
> + * When within an emergency section, no printing occurs on that CPU. This
> + * is to allow all emergency messages to be dumped into the ringbuffer before
> + * flushing the ringbuffer. The actual printing occurs when exiting the
> + * outermost emergency section.
> + */
> +void nbcon_cpu_emergency_enter(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +
> +	preempt_disable();
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +	(*cpu_emergency_nesting)++;
> +}
> +
> +/**
> + * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
> + *	stored messages
> + *
> + * Flushing only occurs when exiting all nesting for the CPU.
> + *
> + * Context:	Any context. Enables preemption.
> + */
> +void nbcon_cpu_emergency_exit(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +	bool do_trigger_flush = false;
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +
> +	WARN_ON_ONCE(*cpu_emergency_nesting == 0);

We should safe the situation and make sure that the couter
does not go below zero.

Also the WARN_ON_ONCE() might be moved after the flush. IMHO, it is
not that important.


> +	if (*cpu_emergency_nesting == 1) {
> +		nbcon_atomic_flush_pending();
> +		do_trigger_flush = true;
> +	}

I wanted to reshufle the code. Then I realized that the messages
are flushed before decrementing the counter probably on purpose.

> +
> +	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
> +	(*cpu_emergency_nesting)--;

I suggest to replace the above code with something like this:

	/*
	 * Flush the messages enabling preemtion to see them ASAP.
	 *
	 * Reduce the risk of potential softlockup by using the flush_pending()
	 * variant which ignores later added messages. It is called before
	 * decrementing the couter to even prevent flushing of another nested
	 * emergency messages.
	 */
	if (*cpu_emergency_nesting == 1) {
		nbcon_atomic_flush_pending();
		do_trigger_flush = true;
	}

	(*cpu_emergency_nesting)--;

	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
		*cpu_emergency_nesting = 0;

> +
> +	preempt_enable();
>
> +	if (do_trigger_flush)
> +		printk_trigger_flush();
> +}
> +
>  /**
>   * nbcon_alloc - Allocate buffers needed by the nbcon console
>   * @con:	Console to allocate buffers for

With the above change, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

