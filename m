Return-Path: <linux-kernel+bounces-142337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6E8A2A54
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A582873D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072841C7F;
	Fri, 12 Apr 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sjk9vZMz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DE1EEF8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912831; cv=none; b=Ng+2ildDQALKMw14ISNCpVOot5HwqCQv6Z4TAi/ATpH+zG5qVbptUwGGnEcF/4AACAhSLZ6IMdcJnBbGs1LK+XXXHVyKIJKhIsMNeFvJzWwt+FkVQoRCGH1kaWTwQONxMFbCEVKlS89jYoITkd+v2KtUcAgK0e/WZpoy5eqHOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912831; c=relaxed/simple;
	bh=ewHQD6d9XMc2RloiZEV+T8DZLHfQUbRxrhEtjwDUnGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOZWSiehFNnlktfZZ8e4P1v0kp9WEftFKnRK5GMtm7SiYa7+nsM7578yv/hLDnlVS2uZnEdCSnOZ/xurDDP1AYUKq66skGxX0AyF3R3ukh6VdKEe5lcHyvEHd/OX7yNBOlbgdeA9jUN76zyvQ63vKL8z1Hp8pDIn1ruk81WIW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sjk9vZMz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so903595e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712912827; x=1713517627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYfw8Ddhw/icSKROcZTT35VYQlyDPRsq3rrDfx4Zhng=;
        b=Sjk9vZMz+lc95vWetF/wCidzpumGG/BLa0bskzg9y1t8LOePxrzHdFD6ryoxM74F31
         8dKybu6LTNOCtzpEDbHOYF6M7DYZjtaA7qJH8AREZR/QOX8XT31Uzh5/d+hjVnkpygxl
         GyLgVv4v5U+HzjVC4QpaWpTy0WWsKFVLF0I4AV0xv84atk4fR1CkAxt7pivOm7bGICfU
         K3fFZuPJy9ruBFvX8BJ+9+VbGhkljbDsdV/qkE6zUYQi8e+ffe9ciDwrdgCZXQUgXHRO
         tNcu0rC53uFSwZYx9ZybSAiwfO3Ck0hCax4IFnua1YLqtP8nnLO4GJOydrRGH3Q9yJBc
         gxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712912827; x=1713517627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYfw8Ddhw/icSKROcZTT35VYQlyDPRsq3rrDfx4Zhng=;
        b=JM2AZxMIYNUNVaitow04/kXcaHRbmtsWtYIR8dZ7B1u2/xyYDu1hfXl54B0zdTDC9z
         zFmRfdJjfTu4+ZS25xxwjBit1In1f7R26JGpN2qNB7Dae6Be4jZFOTCyHF0Cf4yRPMnj
         RJTeGCjt5pMWbgMdHbTDRuU0yHgGg87yEFqwF5P52jHOa8oylfIVXyz0Sbb4t7cfehZJ
         0JJ/s3RRfmRkAsgC6mir31mgyd7LlcfP76gTb4lUDkL5jqnBS6j3GJgzZ+DsvcnrlJ6c
         g02jR4DQouBZ1TLOBn4MXr+cC4Vc0N4rLpujE931h5NAuEflkV594h0awWV+rlqoMV92
         RF/g==
X-Forwarded-Encrypted: i=1; AJvYcCUiTpsIl1qVoTIHUoqVghMJm/V3IcKaTg0s8Oh9H1RnwvXXJ/jJhzb+U16cxFIrAteHo5m8oXaLZ6iGXjZzI1Q11FGzNPs14ck8x8S9
X-Gm-Message-State: AOJu0YzyhhaGDAnJ7KoOqKPcbQCnFO1lekdE+C5Jlx6/rM/gbwsdYJeU
	Vv+q34JkeSyCWp22irXfjQyLKQt4mZOcR8bb+lXDmxDirv3ehK7LdWtii2zRRSU=
X-Google-Smtp-Source: AGHT+IFdQOllOZIXMdAkRNw/6zVbMbdNCU2M+wikCS32nlletPZqPRaXYlhs7e/wQx7TslHmeJhvQg==
X-Received: by 2002:ac2:4e0d:0:b0:518:9362:f63 with SMTP id e13-20020ac24e0d000000b0051893620f63mr258512lfr.0.1712912827054;
        Fri, 12 Apr 2024 02:07:07 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b00417451f4f52sm5017876wmq.33.2024.04.12.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:07:06 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:07:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <Zhj5uQ-JJnlIGUXK@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
 <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhfwXsEE2Y8IPPxX@localhost.localdomain>

On Thu 2024-04-11 16:14:58, Petr Mladek wrote:
> On Wed 2024-04-03 00:17:19, John Ogness wrote:
> > Allow nbcon consoles to print messages in the legacy printk()
> > caller context (printing via unlock) by integrating them into
> > console_flush_all(). The write_atomic() callback is used for
> > printing.
> 
> Hmm, this patch tries to flush nbcon console even in context
> with NBCON_PRIO_NORMAL. Do we really want this, please?
> 
> I would expect that it would do so only when the kthread
> is not working.
> 
> > Provide nbcon_legacy_emit_next_record(), which acts as the
> > nbcon variant of console_emit_next_record(). Call this variant
> > within console_flush_all() for nbcon consoles. Since nbcon
> > consoles use their own @nbcon_seq variable to track the next
> > record to print, this also must be appropriately handled.
> 
> I have been a bit confused by all the boolean return values
> and what _exactly_ they mean. IMHO, we should make it more
> clear how it works when it can't acquire the context.
> 
> IMHO, it is is importnat because console_flush_all() interprets
> nbcon_legacy_emit_next_record() return value as @progress even when
> there is no guaranteed progress. We just expect that
> the other context is doing something.
> 
> It feels like it might get stuck forewer in some situatuon.
> It would be good to understand if it is OK or not.
> 
> 
> Later update:
> 
> Hmm, console_flush_all() is called from console_unlock().
> It might be called in atomic context. But the current
> owner might be theoretically scheduled out.
> 
> This is from documentation of nbcon_context_try_acquire()
> 
> /**
>  * nbcon_context_try_acquire - Try to acquire nbcon console
>  * @ctxt:	The context of the caller
>  *
>  * Context:	Any context which could not be migrated to another CPU.
> 
> 
> I can't find any situation where nbcon_context_try_acquire() is
> currently called in normal (schedulable) context. This is probably
> why you did not see any problems with testing.

> I see 3 possible solutions:
> 
>   1. Enforce that nbcon context can be acquired only with preemtion
>      disabled.

We actually have to make sure that preemtion is disabled because
nbcon_owner_matches() is not reliable after a wakeup.

The context might be taken by a higher priority context then
released and then taken by another task on the same CPU as
the original sleeping owner. I mean this:


CPU0				CPU1

 [ task A ]

 nbcon_context_try_acquire()
   # success with NORMAL prio
   # .unsafe == false;  // safe for takeover

 [ schedule: task A -> B ]


				WARN_ON()
				  nbcon_atomic_flush_pending()
				    nbcon_context_try_acquire()
				      # success with EMERGENCY prio
				      # .unsafe == false;  // safe for takeover

				      # flushing
				      nbcon_context_release()


 nbcon_context_try_acquire()
   # success with NORMAL prio [ task B ]
   # .unsafe == false;  // safe for takeover

 [ schedule: task B -> A ]

 nbcon_enter_unsafe()
   nbcon_context_can_proceed()

BUG: nbcon_context_can_proceed() returns "true" because
     the console is owned by a context on CPU0 with
     NBCON_PRIO_NORMAL.

     But it should return "false". The console is owned
     by a context from task B and we do the check
     in a context from task A.


I guess that most of the current code is safe because, for example:

  + __nbcon_atomic_flush_pending() disables interrupts before
    acquiring the context

  + nbcon_driver_acquire() is called under spin_lock in
    the uart_port_*lock() API.

  + Even the nbcon_kthread_func() in the current RT tree
    acquires the context under con->device_lock(). Where
    the device_lock() is a spin_lock in the only supported
    uart serial console.


To be done:

1. We should make this clear:

    + Add either preempt_disable() or cant_sleep() into
      nbcon_context_try_acquire().

    + Replace cant_migrate() with cant_sleep everywhere

    + Fix/update the documentation


2. We should make sure that the context is acquired for each
   emitted record separately at least when using the normal
   priority.

   For example,  __nbcon_atomic_flush_pending() is wrong from
   this POV. It is used also from console_unlock(). It should
   allow to schedule in between the records in this case.


Best Regards,
Petr

PS: I am still shaking my head around this. Sigh, I haven't expected
    such a big "aha moment" at this stage.

