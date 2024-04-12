Return-Path: <linux-kernel+bounces-142811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DAC8A3063
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3441A2817D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192886151;
	Fri, 12 Apr 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GV9wHIgg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4885958
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931688; cv=none; b=KvKm+NcNAGstiEt+EWs4s0aWgVSx4EbLPVfMGA3qhFg8wOXmwZ5z0PDQuyzn70le/hsI56iHrcD2ia7+iPNH9CUA/0Zh8AxwCN74stsEqDWUEPJx+Il3ts50m1SuG/lntpT1swUMXK7mREIxtkPUgRkl5dQyReCsIrbrHB0MH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931688; c=relaxed/simple;
	bh=SNzoGu02N1X0PfEaF5+I0n88UbtIph8/Gnfkm4/uJ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpwMKpvjRepDC/U4WeYzf0f290cedtLrkPoFxt8PV25bL36DLBMKmpwKKh+Sjf3qgwGnaIFvdVMTpvBvuKXoMmlfbOFU0P1RpC/n50UHzBFA+EkIQW+1eqQKdnKio3Gd9L/69PtQ2s/lzu4PkRV0d25YvH1GgfTPUX4oMbgcws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GV9wHIgg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-417f5268b12so8959005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712931683; x=1713536483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuGZWZWhytkU3H9RstAytyRs4qLomTBn2C5NOarPIfY=;
        b=GV9wHIgg7FF37A4k0xAOy0ETPbZF6O7pEpE8ZvVwuUPwO1opkVYL3QqYP/j2ucL6jG
         uD73K9pN/tz4Wpj32G1hpu+WzFeo+Cis0sWjQeIx90tzVXcNrnOj4Rz7SsV6oWiFZXWe
         bVbscdlJ3tXNxKLT5Ww1ix67onr4f4ZhYFn6U8NjTeawxQIeTCav7e1BSsCCGxdq1t10
         sZv3nfQZrWTPPObh14bbs40FxQNriNn7pwxVHBBFuniKf6qwhmDHgmEPZPH1jBWgtGyZ
         HNQbTrq0nFIKNGyHnXtY7EaHoNUbnbtNPaJPyEydTxwrZJ0Tc6gEa02/59PRCU8RRb20
         rKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931683; x=1713536483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuGZWZWhytkU3H9RstAytyRs4qLomTBn2C5NOarPIfY=;
        b=UUOT8+d6M2ocKNbWiyLhkCRPea1F1nTyHkvlsrQTVMmHwnfZX6JnHFBNRNKFnfY5gm
         NQd/2DKHYQlXgTz2zio0oVl7W2W4YAzwRpEIhuqoDrl7m1Z5rnZ2CuAZywoxlJ5n6xXW
         BMqhyK9wLQ4UeV1N+ge3aIivPgCLAToefTDmv/Irr8+bRDOVr3pyWZvqFrXZTaJX4Xm5
         NllWGsCGqnW5gbpPxnGflnr6Bzw0AY5AW1dNHXE3d2XYL00P+k+Fd38aw4WXzw8Mg8Gn
         oQGTEVeZ7XCNkemRg2S3hxi/HJBDpq3CtpH1lHNUV/Z3wuE/LaEUqt5LoKnhb2Wi7Ksp
         oE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUax++KTnMPxHBm7ghVB5kZS+EMmY9v7uK0wYUXCPKJRh0ZfTR57Dol+EqX7EKlcojrjqJ9s2R5ODS9+ODVuX6AW/gK/FP7XFjmnZF6
X-Gm-Message-State: AOJu0YxXJjoSJVh5TehEA0gH/a2O9ydDiqRqmE80QQ8ieqXqKElBQXA/
	1d1GLhfJzU3BEXCOtdGO1pUw8EYFUoS5AYB2BOw7ZDbz5C1F4Hwr5z7FlSXUxHw=
X-Google-Smtp-Source: AGHT+IG/NWllYtgmfGoYW6rH/AWHr1Pt63PXIyoyoSyUky/BK/w5LQIjfx9iD7/ct5erDAlcwCXX3A==
X-Received: by 2002:a05:600c:5493:b0:416:f38:727 with SMTP id iv19-20020a05600c549300b004160f380727mr2393278wmb.9.1712931682981;
        Fri, 12 Apr 2024 07:21:22 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b00416c1e7c9e7sm5875177wms.2.2024.04.12.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:21:22 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:21:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 20/27] printk: Avoid console_lock dance if no
 legacy or boot consoles
Message-ID: <ZhlDYWgEGf92xYWq@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-21-john.ogness@linutronix.de>
 <87r0fmydc3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fmydc3.fsf@jogness.linutronix.de>

On Wed 2024-04-03 12:07:32, John Ogness wrote:
> On 2024-04-03, John Ogness <john.ogness@linutronix.de> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index df84c6bfbb2d..4ff3800e8e8e 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3810,6 +3833,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >  	u64 last_diff = 0;
> >  	u64 printk_seq;
> >  	short flags;
> > +	bool locked;
> >  	int cookie;
> >  	u64 diff;
> >  	u64 seq;
> > @@ -3819,22 +3843,35 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >  	seq = prb_next_reserve_seq(prb);
> >  
> >  	/* Flush the consoles so that records up to @seq are printed. */
> > -	console_lock();
> > -	console_unlock();
> > +	if (printing_via_unlock) {
> > +		console_lock();
> > +		console_unlock();
> > +	}
> >  
> >  	for (;;) {
> >  		unsigned long begin_jiffies;
> >  		unsigned long slept_jiffies;
> >  
> > +		locked = false;
> >  		diff = 0;
> >  
> > +		if (printing_via_unlock) {
> > +			/*
> > +			 * Hold the console_lock to guarantee safe access to
> > +			 * console->seq. Releasing console_lock flushes more
> > +			 * records in case @seq is still not printed on all
> > +			 * usable consoles.
> > +			 */
> > +			console_lock();
> > +			locked = true;
> > +		}
> > +
> >  		/*
> > -		 * Hold the console_lock to guarantee safe access to
> > -		 * console->seq. Releasing console_lock flushes more
> > -		 * records in case @seq is still not printed on all
> > -		 * usable consoles.
> > +		 * Ensure the compiler does not optimize @locked to be
> > +		 * @printing_via_unlock since the latter can change at any
> > +		 * time.
> >  		 */
> > -		console_lock();
> > +		barrier();
> 
> When I originally implemented this, my objective was to force the
> compiler to use a local variable. But to be fully paranoid (which we
> should) we must also forbid the compiler from being able to do this
> nonsense:
> 
> if (printing_via_unlock) {
> 	console_lock();
> 	locked = printing_via_unlock;
> }
> 
> I suggest replacing the __pr_flush() hunks to be as follows instead
> (i.e. ensure all conditional console lock usage within the loop is using
> the local variable):
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index df84c6bfbb2d..1dbd2a837b67 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3819,22 +3842,34 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	seq = prb_next_reserve_seq(prb);
>  
>  	/* Flush the consoles so that records up to @seq are printed. */
> -	console_lock();
> -	console_unlock();
> +	if (printing_via_unlock) {
> +		console_lock();
> +		console_unlock();
> +	}
>  
>  	for (;;) {
>  		unsigned long begin_jiffies;
>  		unsigned long slept_jiffies;
> -
> -		diff = 0;
> +		bool use_console_lock = printing_via_unlock;
>  
>  		/*
> -		 * Hold the console_lock to guarantee safe access to
> -		 * console->seq. Releasing console_lock flushes more
> -		 * records in case @seq is still not printed on all
> -		 * usable consoles.
> +		 * Ensure the compiler does not optimize @use_console_lock to
> +		 * be @printing_via_unlock since the latter can change at any
> +		 * time.
>  		 */
> -		console_lock();
> +		barrier();

Indeed, this looks better. I have missed this as well.

It seems that using the barrier() is more tricky than I have expected.
I wonder if it would be better to use WRITE_ONCE()/READ_ONCE().
It would be more clear what we want to achieve. Also it would let
the compiler to optimize other things. Not that the the performance is
importnat here but...

Otherwise, the patch looks fine. With this change, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regargds,
Petr

