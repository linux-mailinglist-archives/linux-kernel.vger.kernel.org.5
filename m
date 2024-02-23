Return-Path: <linux-kernel+bounces-78810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5024861925
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80741C25556
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4A12AAFA;
	Fri, 23 Feb 2024 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E92gmXBl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DD823A1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708530; cv=none; b=LE5XBB1+d8g1tfJqqPQRwyUWovQjmQMclJOYWUm5eGHXW3mNHxCobHIl5tHWkxIfsE/q76tYtDsVcK450aSbhpL68/QiBW0WsTvJbkN56pTe068YQCRv+I8439Xk4aiChGlxawM9glYRyGvuIzsXlwMQi6bgzVc9uNtpQavXcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708530; c=relaxed/simple;
	bh=kY8+owXwTk1+/3E9mvrJKMt5yL2lucedEJ4KlXu0ack=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtUR7uDCT3b6U+L15T8/WrD4AvDIbqYoCDaaZgLx6aG8yMkZHB7jGeeBPygVUEfTmWhtEMYpoBNC6TwKQQgOyox+ptZ80b4VlO7s391W9UNP9A0jn5ww93ZSRxQcmPHA0vw2mzETNvqRxvwQcLLJbRMSmfH1JezJTSS9kJX733Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E92gmXBl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso1347395e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708708523; x=1709313323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmQUUgFSEEhIsxOXnK3/N/kppHuIG9Ht0ivweiH9ieo=;
        b=E92gmXBl2UqTfRGaJGjJLIqdbIivaaL+oow8RtLB7Qp7AXFRVEE0hidztKqyFUyH8z
         5C4ZmAKkXQWEWMQ+8UZ5K8iaHVi6sktzFWWuhpjX2uBcxWRLeRFKWAHO7GWXg7MyNyCS
         7oAa4ZjdPjA3vAG/vQbE/MPUcZhxti6Mm7ttaHmDXW9ZqPWi2/QzroLXXnNDW6+iWYcF
         63JLjDNJBlBAhode9Et7w3otieZx7B+QJ9crgZVugRm+rXndnZ569/XMSGaoLQffgigE
         P37KNsW1Q66N6qmfBSHgliQ6RUP1XmAt3bt2NUVzQJbocN7bEqCQDP+T2mkkcTJu4yv5
         pbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708523; x=1709313323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmQUUgFSEEhIsxOXnK3/N/kppHuIG9Ht0ivweiH9ieo=;
        b=wMhkodzAldNdEknSJlbSFaTNtb5ukwrjpFT146XrqscvlMtZo8B9qJPCpSaJ7fkqNo
         lbFKonID67WMbtKRJW/3zw0ONNMzfyke4lKBlZjFwL+vmt8tiZU+gn9r2kHv2+Znwl98
         TB7E++uhknhb35/LelWQ3+QcpegnZwInU34y+4WHxusJbdgkZzAV3jJ9qnukL6rIRFuE
         DFqKD2cgFO0b0dazKzfoqcTq/ektuTVFxmGchiAOeMzdIVhKJiE8U27iuEIawuG91N2x
         OipmvbKObCWJ+f82+4f7L52NqcNKp/h4k0t4h8VFcAqrK6nAy5xYlmtxVxnr+3VEp2Hv
         5OPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcT1jQhXfGmmEjimhNe84mMP+RHigUHModlot+RLdRTGCtZSzni+IQzAc7B6cOtbfBloYF4ddlijW7M6fy8q5SPtvZ8tFevTm0/6zw
X-Gm-Message-State: AOJu0YxKKNx7+1eSzDh/I9p2N2gn8b27pOh62Fei7P0RvUqfWsZO2Njw
	Tibp1GChPeERo7dt2c1a4bi63EjQs5Cesog1PsxUthqM8PxGzSZx3VGK7A3B07o=
X-Google-Smtp-Source: AGHT+IG8C7msxur/Yk0akspVF7be7IMf918Xl5cA6Tp4W8o/mpcyjpsjAFXdtngrVdQFyDuTcVW72Q==
X-Received: by 2002:ac2:4c16:0:b0:512:ce7c:c99d with SMTP id t22-20020ac24c16000000b00512ce7cc99dmr238833lfq.18.1708708523577;
        Fri, 23 Feb 2024 09:15:23 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id vk7-20020a170907cbc700b00a3f29591dcdsm2927515ejc.95.2024.02.23.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:15:23 -0800 (PST)
Date: Fri, 23 Feb 2024 18:15:21 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 16/26] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <ZdjSqZH5ivCrIBpx@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-17-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-17-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:16, John Ogness wrote:
> Allow nbcon consoles to print messages in the legacy printk()
> caller context (printing via unlock) by integrating them into
> console_flush_all(). The write_atomic() callback is used for
> printing.
> 
> Provide nbcon_legacy_emit_next_record(), which acts as the
> nbcon variant of console_emit_next_record(). Call this variant
> within console_flush_all() for nbcon consoles. Since nbcon
> consoles use their own @nbcon_seq variable to track the next
> record to print, this also must be appropriately handled.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -960,6 +961,50 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>  	return ctxt->backlog;
>  }
>  
> +/**
> + * nbcon_legacy_emit_next_record - Print one record for an nbcon console
> + *					in legacy contexts
> + * @con:	The console to print on
> + * @handover:	Will be set to true if a printk waiter has taken over the
> + *		console_lock, in which case the caller is no longer holding
> + *		both the console_lock and the SRCU read lock. Otherwise it
> + *		is set to false.
> + * @cookie:	The cookie from the SRCU read lock.
> + *
> + * Context:	Any context which could not be migrated to another CPU.

This seems to be a relic after shufling the code. IMHO, it was meant
for nbcon_atomic_emit_one(). This function disables interrupts
to prevent CPU migration when calling nbcon_atomic_emit_one().

> + * Return:	True if a record could be printed, otherwise false.

A more precise might be to say "has been printed" instead of
"could be printed".

It is more problematic here. It could return false also when it was
not able to acquire nbcon console.

While console_emit_next_record() has a bit different semantic.
It returns false only when there is no new record.

Thinking loudly:

It probably is not a bit deal. console_flush_all() does not guarantee
that it flushed all messages. It might return early when
the console_lock was handovered. It means there there is
another legacy context flushing the messages.

And nbcon console could not be acquired here also when
there is another nbcon context already flushing the nbcon.

Another question is whether console_flush_all() should return "false"
when nbcon consoles were not flushed because they could not be acquired.
It might be needed so that console_unlock() does not wait until
the other context flushes the nbcon console.

> + *
> + * This function is meant to be called by console_flush_all() to print records
> + * on nbcon consoles from legacy context (printing via console unlocking).
> + * Essentially it is the nbcon version of console_emit_next_record().
> + */
> +bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> +				   int cookie)
> +{
> +	struct nbcon_write_context wctxt = { };
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +	bool progress = false;
> +	unsigned long flags;
> +
> +	*handover = false;
> +
> +	/* Use the same procedure as console_emit_next_record(). */
> +	printk_safe_enter_irqsave(flags);
> +	console_lock_spinning_enable();
> +	stop_critical_timings();
> +
> +	ctxt->console	= con;
> +	ctxt->prio	= NBCON_PRIO_NORMAL;
> +
> +	progress = nbcon_atomic_emit_one(&wctxt);
> +
> +	start_critical_timings();
> +	*handover = console_lock_spinning_disable_and_check(cookie);
> +	printk_safe_exit_irqrestore(flags);
> +
> +	return progress;
> +}
> +
>  /**
>   * __nbcon_atomic_flush_all - Flush all nbcon consoles using their
>   *					write_atomic() callback
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2948,13 +2948,22 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(con) {
>  			short flags = console_srcu_read_flags(con);
> +			u64 printk_seq;
>  			bool progress;
>  
>  			if (!console_is_usable(con, flags))
>  				continue;
>  			any_usable = true;
>  
> -			progress = console_emit_next_record(con, handover, cookie);
> +			if (flags & CON_NBCON) {
> +				progress = nbcon_legacy_emit_next_record(con, handover, cookie);
> +
> +				printk_seq = nbcon_seq_read(con);

It might looks better without the empty line. But it is just my view.
Feel free to keep it as is.

> +			} else {
> +				progress = console_emit_next_record(con, handover, cookie);
> +
> +				printk_seq = con->seq;
> +			}
>  
>  			/*
>  			 * If a handover has occurred, the SRCU read lock

Best Regards,
Petr

