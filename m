Return-Path: <linux-kernel+bounces-138822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D989FAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8933C1F2A9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7942C16D4FC;
	Wed, 10 Apr 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WFaIOWo2"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9815EFAD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760970; cv=none; b=cGOcYYkG93xZpo+yi49lUZ+0qeRXCIIfxN/yDUgzeqYKbvObfyU0wZYENaiX9eTSFm7+mBdw7HI96SIHiWvWKqzxVxALgeEzQS26oZgRrmyi8f7RKScktC83+ThVyko7jau3+kmmpntQWqaS3ekTg0Jm+yAwLeFhkV9mCfT2PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760970; c=relaxed/simple;
	bh=8y6aJLQJFNTCYKBEwrA/el6sAWkSK75D6s9dHi9u9P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLQGgfSEli3zFSDpsE6r9Hg/mlS/dTr4ykYVJfNUbIxWKhABpy5X5x0AfjspOV8UjLrX0y/OfHZq2FYGjXK0BshFmhkNhIOte+M/HK2TgokuIY0j/5u7e9oB/6Uf8friq9cEeFJhUxTo/ei8USjDXpE49RY24c3vZfjlddYROFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WFaIOWo2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso48225601fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712760966; x=1713365766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOMgZHXd2d3QtqWlQYeAdAIzKrW8zTg+VWUROVrFdvo=;
        b=WFaIOWo28s9bLr2nQ43VO+lMMaN0wHr5FPxWAgdbyCfT7ztURaaEa8EAiYJgcC7SX0
         YvdmfSRS436EJlJQx+Gr7vY7RIhfCAVp0rSY0ZUOJqFXLkEzDyWjmrODG0NiurpDIMHy
         XQaaQ7HicBWVeQgfWlu72LNbTWhuh2+r8gbfpx6SbCgDcbcCY6JRwtRKzgEI7pBXmjCi
         wJMWl/edvENr7KYbqX8OVZUpR4g7V1wH2q+/aHMPGytrrSW7n658eezaxg/ZErRVynKF
         gWPBlc5tA+vrwiz1l3Oy1nvsgRNo7U3FIwkqMLFSpsMPvsJ4IqsfgK+TYds6l8A1VjQK
         s3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760966; x=1713365766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOMgZHXd2d3QtqWlQYeAdAIzKrW8zTg+VWUROVrFdvo=;
        b=PAjJ/iwnM3AaRqvetLvWkdVKVQ96kQiYE1a8aAWiG4yHFkPaNvZ/ENKO080+MH5Evk
         TLKvh/0ZjMYIuxAzkysa0Kdws0yzQBxuH31d1Gmp3SjoXtufPSN7saMdOKBFtWHRIlpI
         Ue1NUHTlkY4/1mxrGcLpvaqZRlDdpdpj5PoIMA+CXyySdbaSsEqH8dyi8zT5T02R42GY
         sRVOW7zuJFl7LEs2mMhNjmY8kb+yXFs6UfMvEFePvh1zpVNdGEouuVsURkhwjTGBJJoH
         3CecAGmiiT9QpNoHodsonmkJfQVSXZqD5wbSBR0k/kdsYjQ3BUO+p5iuvmApcyr/9a5N
         z7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcTVYB8AU/8x4HQ1+V4E3R5+NkesANq4uKf5oCDywm7hi5/H6eQ2Wj4WRVxo6CCirXyA3f46jb8KJlbPzUhnDU4fA3VgFEzcpcv+K7
X-Gm-Message-State: AOJu0YwsupOWx4IsJFnoBowU5ka3AQgXQf5F8zzDBAe/jyEYY/OzsJtw
	pTJ1vaOoCcaYDFmFYffAExkMZfASWay4vSJK7xpX1y4qUuwmd81Fn4bwcWcEMgrC11YQmw/OrTm
	B
X-Google-Smtp-Source: AGHT+IHGxyynyRGNZPnVi5xHfg3CxA3FY/ieLUVPbDu9qxk8Hk3uLFuv17WP+DuYeHUTeWNvMKlj3Q==
X-Received: by 2002:a2e:9191:0:b0:2d8:7fa5:5034 with SMTP id f17-20020a2e9191000000b002d87fa55034mr1980873ljg.43.1712760965778;
        Wed, 10 Apr 2024 07:56:05 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id iv6-20020a05600c548600b00417bc4820acsm1470519wmb.0.2024.04.10.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:56:05 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:56:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 15/27] printk: nbcon: Provide function to flush
 using write_atomic()
Message-ID: <Zhaog95-FDGaAU36@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-16-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:17, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide nbcon_atomic_flush_pending() to perform flushing of all
> registered nbcon consoles using their write_atomic() callback.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> only flush up through the newest record at the time of the
> call. This prevents a CPU from printing unbounded when other
> CPUs are adding records.
> 
> Also unlike console_flush_all(), nbcon_atomic_flush_pending()
> will fully flush one console before flushing the next. This
> helps to guarantee that a block of pending records (such as
> a stack trace in an emergency situation) can be printed
> atomically at once before releasing console ownership.
> 
> nbcon_atomic_flush_pending() is safe in any context because it
> uses write_atomic() and acquires with unsafe_takeover disabled.
> 
> Use it in console_flush_on_panic() before flushing legacy
> consoles. The legacy write() callbacks are not fully safe when
> oops_in_progress is set.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

See few nits below.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -937,6 +935,108 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	return nbcon_context_exit_unsafe(ctxt);
>  }
>  
> +/**
> + * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
> + *					write_atomic() callback
> + * @con:			The nbcon console to flush
> + * @stop_seq:			Flush up until this record
> + *
> + * Return:	True if taken over while printing. Otherwise false.
> + *
> + * If flushing up to @stop_seq was not successful, it only makes sense for the
> + * caller to try again when true was returned. When false is returned, either
> + * there are no more records available to read or this context is not allowed
> + * to acquire the console.
> + */
> +static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> +{
> +	struct nbcon_write_context wctxt = { };
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +
> +	ctxt->console			= con;
> +	ctxt->spinwait_max_us		= 2000;
> +	ctxt->prio			= NBCON_PRIO_NORMAL;

Nit: It looks strange to harcode NBCON_PRIO_NORMAL and call it from
     console_flush_on_panic() in the same patch.

     I see. It will get replaced by nbcon_get_default_prio() later.
     I guess that it is just a relic from several reworks and
     shufling. I know that it is hard.

     It might have been better to either add the call in
     console_flush_in_panic() later. Or introduce nbcon_get_default_prio()
     earlier so that we could use it here.


> +
> +	if (!nbcon_context_try_acquire(ctxt))
> +		return false;
> +
> +	while (nbcon_seq_read(con) < stop_seq) {
> +		/*
> +		 * nbcon_emit_next_record() returns false when the console was
> +		 * handed over or taken over. In both cases the context is no
> +		 * longer valid.
> +		 */
> +		if (!nbcon_emit_next_record(&wctxt))
> +			return true;
> +
> +		if (!ctxt->backlog)
> +			break;
> +	}
> +
> +	nbcon_context_release(ctxt);
> +
> +	return false;
> +}
> +
> +/**
> + * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
> + *					write_atomic() callback
> + * @stop_seq:			Flush up until this record
> + */
> +static void __nbcon_atomic_flush_pending(u64 stop_seq)
> +{
> +	struct console *con;
> +	bool should_retry;
> +	int cookie;
> +
> +	do {
> +		should_retry = false;
> +
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(con) {
> +			short flags = console_srcu_read_flags(con);
> +			unsigned long irq_flags;
> +
> +			if (!(flags & CON_NBCON))
> +				continue;
> +
> +			if (!console_is_usable(con, flags))
> +				continue;
> +
> +			if (nbcon_seq_read(con) >= stop_seq)
> +				continue;
> +
> +			/*
> +			 * Atomic flushing does not use console driver
> +			 * synchronization (i.e. it does not hold the port
> +			 * lock for uart consoles). Therefore IRQs must be
> +			 * disabled to avoid being interrupted and then
> +			 * calling into a driver that will deadlock trying
> +			 * to acquire console ownership.
> +			 */
> +			local_irq_save(irq_flags);
> +
> +			should_retry |= __nbcon_atomic_flush_pending_con(con, stop_seq);

Nit: I have to say that this is quite cryptic. The "true" return value
     usually means success. But it sets "should_retry" here.

     It would mean sligtly more code but it would be much more clear
     when __nbcon_atomic_flush_pending_con() returns:

	+ 0 on success
	+ -EAGAIN when lost the owenership
	+ -EPERM when can't get the owner ship like nbcon_context_try_acquire_direct()

     and we make the decision here.

> +
> +			local_irq_restore(irq_flags);
> +		}
> +		console_srcu_read_unlock(cookie);
> +	} while (should_retry);
> +}

Neither of the nits is a blocker. They are basically just about potential
complications for the future code archaeologists.

Best Regards,
Petr

