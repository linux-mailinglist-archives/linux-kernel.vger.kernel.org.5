Return-Path: <linux-kernel+bounces-88670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8B86E50E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0FF1F23EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703116F514;
	Fri,  1 Mar 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LrTfGtFx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDA70CB3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309535; cv=none; b=EwMMjA7ovNKHvQJs4ZXN452yDD23koyr4hCkVdG/FfXIaazSQRcOo1loM5qYn1MkZjtt6Vo0ezoyAFwjMeOFfmajr2PBzqZG/PkRwoQ8u2I8jitU0FSxkj0iDJiHR4KgUOp4nCmGKLubCc3ou+jDD7O6Z4D4dab+0eUq4LKxQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309535; c=relaxed/simple;
	bh=k+fCrivZsBWmSywDILFgBhBP9yBqxulym1H5/CYlqc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtgB9gOy/nXqYNYaJANXELizMUfU8ktiudIu16kWfrAnM2Yq7v7RkgPz0xMG07awXinnjCqf5vitaxY/yZPYzUfpSsC4D8wmuFbrrIGUfza6PZWYR9QWWWEz9O6XusdeLXKn7WZxM8+KY/puIpdPjiHIWDZPkUL2Xf0HyYCGgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LrTfGtFx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso3219791a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709309530; x=1709914330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g01FT3VfAw+lN6FWoipvcfOddXr0GZLpl04P+J1qUmE=;
        b=LrTfGtFxEVFRXRetJvWTanTdcR6Gz5WULgPrEvgUy1eOwR5oCdFl1yh4IRUvVQGO4C
         WmYyXdSqi0eKuHEma6ORZGVrm+IpOqYpoxvRHTDSUmfj9L4DsRbvMJRjAs/i/W2pgDI9
         g1A6K1+8qqEgc4ZL5NPX2yZGURWnEyZl4QRnUOOBDuB0eReRfmaW1APmd5yrQ1Fz2sZO
         jp0d2Ph7lyqubcIsh6HXJoYgYedjzzxuF1YoQu8A4Kb9daZcI7lXYrLVETWYVuvheUn2
         t/9k8h9mBgtq2Nj/l/VDGHAyoG0jvvGIt05StdFPK9SAPOrxvhefX7DmXHJlbZKbSPJt
         +Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709309530; x=1709914330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g01FT3VfAw+lN6FWoipvcfOddXr0GZLpl04P+J1qUmE=;
        b=jW+rk3ztvXpHAvUnOolSm1ful0GyoNDGidI1QnrPVS0RRHN0diVf52pMQ8UvfPIOIT
         KAQ9LVZbP5hkhgcVyMo9nxKYB9ioK730H0nfHxZQ45Io41mPwghBsWSFJSFrqdqD4eqw
         13gZ70vGdyEyp/Vl4/NwpJq+7zTtsdPqiu6+0gdoBj9lxWOGXxY5CdI8jnkXZ1KDvNtn
         PPuSKI7UtxCYGntq4RH2oncfKQpA8wEZFlaVWeacl8FZcD4u0jG6fpN0wnkg9N7CVkaP
         zwqNGzYYiWRN91VPnsZdJL78gh+2kDcv5gBfUxRJy7p0QA7qx0Y/jHmbopzXvcXtGo1+
         LceA==
X-Forwarded-Encrypted: i=1; AJvYcCVHASStXPnDvQj7QLRpB6S+/HtpmLIJ1sjbdulnk+StysNu1j0sFT6e65/SOqCIN3LSc0yKxYU5Z30/raHrpEsbf0CehiCB4uPrTb53
X-Gm-Message-State: AOJu0Yx/DsVKNXwV3wibysnE1ccOlIr/3o8YnIH+ypJHZzAjRW2L11H2
	o86wp7tIwaVUIaJr6tOiKbKL9D8qtx0qSHeXK+fk3kZGW4obEL4ufx0EDPmFBoU=
X-Google-Smtp-Source: AGHT+IFOVWxEdzQWeZgSpugUxiKv5D0Cd3iID/mm742WxT83B57bdTGgjPE7o65GTswMEiRz8S8e7Q==
X-Received: by 2002:a17:906:d045:b0:a44:4d9b:9062 with SMTP id bo5-20020a170906d04500b00a444d9b9062mr1427125ejb.69.1709309530478;
        Fri, 01 Mar 2024 08:12:10 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id s8-20020a1709066c8800b00a442369a8d0sm1799465ejr.223.2024.03.01.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:12:10 -0800 (PST)
Date: Fri, 1 Mar 2024 17:12:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: flush was: Re: [PATCH printk v2 22/26] printk: nbcon: Implement
 emergency sections
Message-ID: <ZeH-VwAdsn2Tsgr2@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-23-john.ogness@linutronix.de>
 <ZeH5IAKyNbwL9wek@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeH5IAKyNbwL9wek@alley>

On Fri 2024-03-01 16:49:54, Petr Mladek wrote:
> On Sun 2024-02-18 20:03:22, John Ogness wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > In emergency situations (something has gone wrong but the
> > system continues to operate), usually important information
> > (such as a backtrace) is generated via printk(). Each
> > individual printk record has little meaning. It is the
> > collection of printk messages that is most often needed by
> > developers and users.
> > 
> > In order to help ensure that the collection of printk messages
> > in an emergency situation are all stored to the ringbuffer as
> > quickly as possible, disable console output for that CPU while
> > it is in the emergency situation. When exiting the emergency
> > situation, trigger the consoles to be flushed.
> > 
> > Add per-CPU emergency nesting tracking because an emergency
> > can arise while in an emergency situation.
> > 
> > Add functions to mark the beginning and end of emergency
> > sections where the urgent messages are generated.
> > 
> > Do not print if the current CPU is in an emergency state.
> > 
> > Trigger console flushing when exiting all emergency nesting.
> > 
> > Note that the emergency state is not system-wide. While one CPU
> > is in an emergency state, another CPU may continue to print
> > console messages.
> > 
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1105,6 +1134,58 @@ void nbcon_atomic_flush_unsafe(void)
> >  	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), true);
> >  }
> >  
> > +/**
> > + * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
> > + *	messages for that CPU are only stored
> > + *
> > + * Upon exiting the emergency section, all stored messages are flushed.
> > + *
> > + * Context:	Any context. Disables preemption.
> > + *
> > + * When within an emergency section, no printing occurs on that CPU. This
> > + * is to allow all emergency messages to be dumped into the ringbuffer before
> > + * flushing the ringbuffer. The actual printing occurs when exiting the
> > + * outermost emergency section.
> > + */
> > +void nbcon_cpu_emergency_enter(void)
> > +{
> > +	unsigned int *cpu_emergency_nesting;
> > +
> > +	preempt_disable();
> > +
> > +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> > +	(*cpu_emergency_nesting)++;
> > +}
> > +
> > +/**
> > + * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
> > + *	stored messages
> > + *
> > + * Flushing only occurs when exiting all nesting for the CPU.
> > + *
> > + * Context:	Any context. Enables preemption.
> > + */
> > +void nbcon_cpu_emergency_exit(void)
> > +{
> > +	unsigned int *cpu_emergency_nesting;
> > +	bool do_trigger_flush = false;
> > +
> > +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> > +
> > +	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
> > +
> > +	if (*cpu_emergency_nesting == 1)
> > +		do_trigger_flush = true;
> > +
> > +	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
> > +	(*cpu_emergency_nesting)--;
> > +
> > +	preempt_enable();
> > +
> > +	if (do_trigger_flush)
> > +		printk_trigger_flush();
> 
> Just an idea. printk_trigger_flush() calls defer_console_output().
> It always moves the flushing into IRQ context.
> 
> It might make sense to add a flush() function which would try
> to flush the messages directly from this context and
> queue the IRQ work only when it fails. Something like:
> 
> void printk_emergency_flush()
> {
> 	/* nbcon consoles could be flushed in any context. */
> 	if (have_nbcon_console)
> 		nbcon_flush_all();

It seems that the previous version of the patchset called this
in nbcon_cpu_emergency_exit() before decrementing the cpu state.

Sigh, it was me who said that it was useless, see
https://lore.kernel.org/all/ZQ3R4Lz1LHQYsylw@alley/

I am sorry for this.

To my defense. It was a generic function added early in the patchset.
And it was used by both emergency and panic contexts. It is possible
that I did not know about the emergency context behavior at
the time of review.


> 	if (have_legacy_console) {
> 		if (console_trylock())
> 			console_unlock();
> 		else
> 			defer_console_output();
> 	}
> }
> 
> But wait, nbcon_flush_all() might have troubles to get the per-console
> lock because it would be called with NBCON_PRIO_NORMAL.
> 
> 
> Wait, wait, wait.
> 
> defer_console_output() schedules wake_up_klogd_work_func(). It flushes
> only legacy consoles. It means that even emergency messages would
> need to wait for the printk kthread.
> 
> By other words, it seems that the emergency context does not have any
> effect for nbcon consoles.

It should get fixed by calling nbcon_flush_all() before decrementing
cpu_emergency_nesting counter.

Best Regards,
Petr

