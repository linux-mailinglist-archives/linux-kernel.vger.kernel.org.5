Return-Path: <linux-kernel+bounces-86914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51EB86CCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46602283EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6512F362;
	Thu, 29 Feb 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7V7VvZQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1E86275
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219955; cv=none; b=LGR2FCwiTw7BJXG0Df/OP3WC/LoFOFAJ1Ore0Ncwud2bjGfXGZoIr5bmRYi35j81eJiR6Vh1lQGvxsxjLuoqq94/87ck/2UTpPg7lRvj2DOkxXFeGT1whE2Iqp/I9VhL+JH6RQ21xPJePQ7kDyhAOkVbYhh6HcicrWObtDgPOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219955; c=relaxed/simple;
	bh=8BKUzajgfT6HNmS1xP/5Vd8mKo4cmsOxiX9rNgycjXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbCu0/plD7yvroUYomVM57Adhn5fGeXZ9vvaAESnYYfFSU309rOLsPeYTE4w3fZw9pXCjS/pSSKl3j5p/cFCU07+8sfqxmKxZzp9zwC1hfhS9DXtLfg9l1EdmQn3hbjsBE2NM0K3TCj7S3lsWT8nKHL1LgzUN9vCAJXhRtG6x+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7V7VvZQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a446478b04bso45924866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709219952; x=1709824752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn1zce3bQ2qXb3y/QswXWKJ5LaLDdAUGuIwkbuGCZvU=;
        b=d7V7VvZQs3FB0yugiCm4ZBm4EEog4abnu082Bh4tJ98sPe0o5jdLzlnfjQ3gfsoVxz
         yQeNU7VLxH2T9WR+BAI4cgRmlHGtHACd+/koYQmnUopXJMHQEFwPvZs+T8wo9o1naWBO
         MdhR8KoFGP6xTNB2j0KqbfE3wQdE4+RP74PDsX2FmeJWvbJV0Ew5kUklKcHnsnxSn+/R
         7P2DLwEsPx2jPfN82mJH2HU0WDvvmT9I8hFbu4FZB8u1mUtiQz1ESRV5eiWB+pr5IajH
         tfsj9AY5OUgIU5PJ2kkMeb/6t7zou6nD/S1sJIqxgvfDspUWjh/Q7Ex7muk32oBEb+QO
         tcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219952; x=1709824752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn1zce3bQ2qXb3y/QswXWKJ5LaLDdAUGuIwkbuGCZvU=;
        b=N7M2Ak3nulZBaCP7cTR4XaFVJCb2or7QkqKOf+H+znpglU7uWCEhSCJWWS8QfYlsYy
         T4q3tMp/Mc1PM0xR7zHaQOFk7G9g+zN5nE1eJ9dfuSyuBmQWZzUVAX8NIEZ6Qk5AwsW+
         +ADkd/5XnAeiZdIQ6RDN4KaBpwPEzXOJV/Im1ZMMdc7sjbWaKJI8P27NwYPUV3DE3N+8
         A2kZvOLr9DUhvGBxZQW8ypmUgYqaHHVNHCbnPOXyvwmCIftMZ/8zyIEde6sgI9ePAR9j
         //vIQ1mwvObMHbLjqyeizwuSkh4neiBvzMHYwJtBa0RKyL+Q5JgSY13c8Z0wZcoZXyHP
         5MfA==
X-Forwarded-Encrypted: i=1; AJvYcCWE5c/w69UQVG6HheJR+HKTrHh37DgTAaum8jSq7CU0yI2P1abzsnHFU9hW+jjcuzD/mTDU0gQpHpL2+Y8lLAGwYBWHpyxtpgHSLTxm
X-Gm-Message-State: AOJu0YzeQEddfAmpmSmLugHlSiomuzoICPE+9DF2cP7GOS1ON7fm3Dbp
	gsNjS3RP71jV1KYiCIOSVS00oT+gMqoNFzAKsON6I5ACHzJ075Se4hnqeru9W0E=
X-Google-Smtp-Source: AGHT+IFrwNmwbJfrkgbJv1EeguIoo2X9D5Q/WjhOIHrpPrEivK2ywnhccAptttNke/Vdftzzg6Ltdw==
X-Received: by 2002:a17:906:fb99:b0:a44:277c:1683 with SMTP id lr25-20020a170906fb9900b00a44277c1683mr1875406ejb.53.1709219951673;
        Thu, 29 Feb 2024 07:19:11 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id tx18-20020a1709078e9200b00a431cc4bd3dsm769486ejc.182.2024.02.29.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:19:11 -0800 (PST)
Date: Thu, 29 Feb 2024 16:19:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 19/26] printk: Avoid console_lock dance if no
 legacy or boot consoles
Message-ID: <ZeCgbRkIl2q3_9uh@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-20-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:19, John Ogness wrote:
> Currently the console lock is used to attempt legacy-type
> printing even if there are no legacy or boot consoles registered.
> If no such consoles are registered, the console lock does not
> need to be taken.
> 
> Add tracking of legacy console registration and use it with
> boot console tracking to avoid unnecessary code paths, i.e.
> do not use the console lock if there are no boot consoles
> and no legacy consoles.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3958,7 +3983,11 @@ void defer_console_output(void)
>  	 * New messages may have been added directly to the ringbuffer
>  	 * using vprintk_store(), so wake any waiters as well.
>  	 */
> -	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
> +	int val = PRINTK_PENDING_WAKEUP;
> +
> +	if (printing_via_unlock)
> +		val |= PRINTK_PENDING_OUTPUT;
> +	__wake_up_klogd(val);

I was thinking about handling this in wake_up_klogd_work_func().
But then I saw that __wake_up_klogd() already handled
PRINTK_PENDING_WAKEUP a similar way. And it even did not
queue the work when there was nothing to do.

It would be nice to handle both on the same place.
It would even untangle the condition in __wake_up_klogd().
Something like:

static void __wake_up_klogd(int val)
{
	if (!printk_percpu_data_ready())
		return;

	preempt_disable();

	/*
	 * Guarantee any new records can be seen by tasks preparing to wait
	 * before this context checks if the wait queue is empty.
	 *
	 * The full memory barrier within wq_has_sleeper() pairs with the full
	 * memory barrier within set_current_state() of
	 * prepare_to_wait_event(), which is called after ___wait_event() adds
	 * the waiter but before it has checked the wait condition.
	 *
	 * This pairs with devkmsg_read:A and syslog_print:A.
	 */
	if (!wq_has_sleeper(&log_wait))		/* LMM(__wake_up_klogd:A) */
		val &= ~PRINTK_PENDING_WAKEUP;

	/*
	 * Simple read is safe. register_console() would flush a newly
	 * registered legacy console when writing the message about
	 * that it has been enabled.
	 */
	if (!printing_via_unlock)
		val &= ~PRINTK_PENDING_OUTPUT;


	if (val) {
		this_cpu_or(printk_pending, val);
		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
	}

	preempt_enable();
}

Otherwise, it looks good.

Best Regards,
Petr

