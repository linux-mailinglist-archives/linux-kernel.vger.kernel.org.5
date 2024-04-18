Return-Path: <linux-kernel+bounces-150096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3F8A9A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06611F21A75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F015FA60;
	Thu, 18 Apr 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lo0Di+ey"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F828161B53
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444463; cv=none; b=NPuegujbWRuurVCnVEhQGBJ/UNHILqErvOopc9W59xeS91nNe/s1uHkuZ0WLTx+PL2lNyEvQQVLik32KR277tj1E2Nrs1B6h9rAwZjTxaKL0c1JIMQ4p/j7oSJB85OIWQ9ZOnyMNgqhxj5Ct1dTTS+yehbZIvFHBO4bYYLkt0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444463; c=relaxed/simple;
	bh=fXwFAffAo8kCGdiVlrMcpoDGdDC3lUT8sWS6fHL//6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMreW6IRK9IxaTgPIFlMjq0pMzB/1yGQbcCjtB3HXvgAgWqx+hA6RhH7gga5dcf5DmabeeuG8InsyJ10Nei536YyUZMR3LZvR83IJJxzINYTrJNtFD7tdK0z3Ljxyao/cp4U0XihP2nmOoz/uKmGqj4QC1h+5YzYrdtTXALz7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lo0Di+ey; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-418e06c0ef4so6915245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713444459; x=1714049259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pe4i76QGMsgnmNTahhKPZUvHd7doKMZbCBBwLxJsRU=;
        b=Lo0Di+eyUhacjlT5cOC9bRVnz9zIv1FYip4yQAkNIfnTtLWregyKENutV+syVYPITd
         2AOPN54X/MJ8ALangeK8MAlVB6SDjIK3bMCcGfuct8k1mpYOPby/jqkS3r2mPzTJ2eSi
         oaeMYdfePlazIb8DWhY1sT+0vMH5qNB2ykqbZVGSppTzoc7VuUGl9F8s2Fbe4vAeK2x5
         /FncIm7x6rPInPyDdjnfpmOsgLYjcs9959DJOssctby4rLvHNiOQ/6Uq1yCBj3168z6a
         4UaMXKjCvE9YkoAwvvm0O1VE6iYKArtunAJGHFT51sf9fadKC01A8S/srXvelNiaCnNb
         79Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444459; x=1714049259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pe4i76QGMsgnmNTahhKPZUvHd7doKMZbCBBwLxJsRU=;
        b=amj+EyVwi/xpGJDxchw7L8TfZTY3ombCjdb9W7q8X7i0kREHQ8XrMUTIDq8089aYS6
         +OvGYp8uptNod4/TcTLkPqBsjbgn/xFbovu4I19L9iSbFjZXjvs3vokQ0zNQ4v3Ztogl
         vCY2o0u4FgKXHgBQ1/TsyDgWnwi87DdsQ9YlzcV2NJ6ooKGjZzIum8Pt2DEgeZKTeYNJ
         rkjoWsLdGc7aPltKaF1Hx8eBwTvtoLnuhA/vynKWLJPEjPpJzhJWG+9hMqueIFQo44z8
         QFvVcpjyPuWg4x6S0uDcj6V8dDxBo8ftXRKNbch1NtHTiOkYnXYs4B6s2+fKFu8SqF6X
         n6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLBmjPQinNPlvEIC9m1U/q4u5ysQX+ccFJo65yI1D9bb4bVsBLDj/NzvWb9wySD3uFbPz02alnC9g2j/yy74/bVNVg/7uEm7azS50
X-Gm-Message-State: AOJu0YwjFoHo4nHYfGVEXFV3qwMg9+SvUnV47Cl8ZUKeYJGeynMdjJRY
	RMIgIjcnL1tLiiAhc42jxp+jDnEohRwtcqikxVPBfxOqi7AvYAGr4D6HpyKTtd0=
X-Google-Smtp-Source: AGHT+IHEZbhJUXt8YUSPehLxlRQv4Yew3Oog7bSfi+qzLLGpi/13ZZE7mu2ypsykqonguKp5MUprUg==
X-Received: by 2002:a05:600c:45cf:b0:418:e3d5:5c28 with SMTP id s15-20020a05600c45cf00b00418e3d55c28mr1630674wmo.10.1713444458738;
        Thu, 18 Apr 2024 05:47:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b00418accde252sm2630088wmo.30.2024.04.18.05.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:47:38 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:47:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <ZiEWaA3CeQsccEdj@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
 <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
 <ZhgCgBK7JdRruvkj@localhost.localdomain>
 <87plunoai0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plunoai0.fsf@jogness.linutronix.de>

On Thu 2024-04-18 01:11:59, John Ogness wrote:
> On 2024-04-11, Petr Mladek <pmladek@suse.com> wrote:
> > I am trying to make a full picture when and how the nbcon consoles
> > will get flushed. My current understanding and view is the following,
> > starting from the easiest priority:
> >
> >
> >   1. NBCON_PRIO_PANIC messages will be flushed by calling
> >      nbcon_atomic_flush_pending() directly in vprintk_emit()
> >
> >      This will take care of any previously added messages.
> >
> >      Non-panic CPUs are not allowed to add messages anymore
> >      when there is a panic in progress.
> >
> >      [ALL OK]
> 
> OK, because the end of panic will perform unsafe takeovers if necessary.
> 
> >   2. NBCON_PRIO_EMERGENCY messages will be flushed by calling
> >      nbcon_atomic_flush_pending() directly in nbcon_cpu_emergency_exit().
> >
> >      This would cover all previously added messages, including
> >      the ones printed by the code between
> >      nbcon_cpu_emergency_enter()/exit().
> 
> This is best effort. If the console is owned by another context and is
> marked unsafe, nbcon_atomic_flush_pending() will do nothing.
> 
> [ PROBLEM: In this case, who will flush the emergency messages? ]

They should get flushed by the current owner when the system is still
living. Or the system is ready for panic() and the messages would
be emitted bu the final unsafe flush.

IMPORTANT: The optimistic scenario would work only when the current
	   owner really flushes everything. More on this below.


> >      This won't cover later added messages which might be
> >      a problem. Let's look at this closer. Later added
> >      messages with:
> >
> > 	+ NBCON_PRIO_PANIC will be handled in vprintk_emit()
> > 	  as explained above [OK]
> >
> > 	+ NBCON_PRIO_EMERGENCY() will be handled in the
> > 	  related nbcon_cpu_emergency_exit() as described here.
> > 	  [OK]
> >
> > 	+ NBCON_PRIO_NORMAL will be handled, see below. [?]
> >
> >      [ PROBLEM: later added NBCON_PRIO_NORMAL messages, see below. ]
> 
> Yes, this is also an issue, although the solution may be the same for
> this and the above problem.

This is a bit different. There was an existing console owner in the
above scenario. In this case, the code relies on the printk kthread.
But we need a solution for situations when the kthread is not working,
e.g. early boot.


> >   3. NBCON_PRIO_NORMAL messages will be flushed by:
> >
> >        + the printk kthread when it is available
> >
> >        + the legacy loop via
> >
> > 	 + console_unlock()
> > 	    + console_flush_all()
> > 	      + console nbcon_legacy_emit_next_record() [PROBLEM]
> >
> > PROBLEM: console_flush_all() does not guarantee progress with
> > 	 nbcon consoles as explained above (previous mail).
> 
> Not only this. If there is no kthread available, no printing will occur
> until the _next_ printk(), whenever that is.

> Above we have listed 3 problems:
> 
> - emergency messages will not flush if owned by another context and
>   unsafe
>
> - normal messages will not flush if owned by another context
> 
> - for the above 2 problems, if there is no kthread, nobody will flush
>   the messages

All this goes down to the problem who is would flush "ignored"
messages when the system continues working in "normal" mode.


> My question: Is this really a problem?

IMHO, it is. For example, early boot consoles exists for a reason.
People want to debug early boot problems using printk.
We should not break the reliability too much by introducing kthreads.

Later update: It is basically only about early boot debugging.

	The kthreads should always be created later. And
	we assume that they work, except for the emergency
	and panic context.

	So, this is not a problem as long as the boot consoles
	are using the legacy code paths.

	Well, I guess that they might use the "atomic_write()"
	callback in the future. And then this "bug" might hurt.


> The main idea behind the rework is that printing is deferred. The
> kthreads exist for this. If the kthreads are not available (early boot
> or shutdown) or the kthreads are not reliable enough (emergency
> messages), a best-safe-effort is made to print in the caller
> context. Only the panic situation is designed to force output (unsafely,
> if necessary). Is that not enough?

Simple answer: No, primary because the early boot behavior.

Longer answer: I tried to separate all the variants and point out
	a particular problem. The above paragraph mixes everything
	into "Wave this away" proposal.


> > My proposal:
> >
> > 	1. console_flush_all() will flush nbcon consoles only
> > 	   in NBCON_PRIO_NORMAL and when the kthreads are not
> > 	   available.
> >
> > 	   It will make it clear that this is the flusher in
> > 	   this situation.
> 
> This is the current PREEMPT_RT implementation.
> 
> > 	2. Allow to skip nbcon consoles in console_flush_all() when
> > 	   it can't take the context (as suggested in my previous
> > 	   reply).
> >
> > 	   This won't guarantee flushing NORMAL messages added
> > 	   while nbcon_cpu_emergency_exit() calls
> > 	   nbcon_atomic_flush_pending().
> 
> This was the previous version. And I agree that we need to go back to
> that.
> 
> > 	   Solve this problem by introducing[*] nbcon_atomic_flush_all()
> > 	   which would flush even newly added messages and
> > 	   call this in nbcon_cpu_emergency_exit() when the printk
> > 	   kthread does not work. It should bail out when there
> > 	   is a panic in progress.
> >
> > 	   Motivation: It does not matter which "atomic" context
> > 		flushes NORMAL/EMERGENCY messages when
> > 		the printk kthread is not available.
> 
> I do not think that solves the problem. If the console is in an unsafe
> section, nothing can be printed.

IMHO, it solves the problem.

The idea is simple:

  "The current nbcon console owner will be responsible for flushing
   all messages when the printk kthread does not exist."

The prove is more complicated:

   1. Let's put aside panic. We already do the best effort there.

   2. Emergency mode currently violates the rule because
      nbcon_atomic_flush_pending() ignores the simple rule.

      => FIX: improve nbcon_cpu_emergency_exit() to flush
	      all messages when kthreads are not ready.


   3. Normal mode flushes nbcon consoles via
      nbcon_legacy_emit_next_record() from console_unlock()
      before the kthreads are started.

      It is not reliable when nbcon_try_acquire() fails.
      But it would fail only when there is another user.
      The other owner might be:

	+ panic: will handle everything

	+ emergency: should flush everything [*]

	+ normal: can't happen because of con->device() lock.

=> The only remaining problem is to fix nbcon_atomic_flush_pending()
   to flush everything when the kthreads are not started yet.


> > 	  [*] Alternatively we could modify nbcon_atomic_flush_pending()
> > 	      to flush even newly added messages when the kthread is
> > 	      not working. But it might create another mess.
> 
> This discussion is about when kthreads are not available. If this is a
> concern, I wonder if maybe in this situation an irq_work should be
> triggered upon release of the console.

Calling irq_work() would solve the problem as well. It would move
flushing to context with "normal" priority which is serialized
by con->device_lock(). It works for me.

Does this make any sense?

It is possible that you already knew all this. And it is possible
that you did not see it as a problem because there was no plan
to convert boot consoles to nbcon variant. Maybe, it does
not even make sense because boot consoles could not use
kthreads. The only motivation would be code sharing and
simplification of the legacy loop but this is far away dream.

Sigh, all this is so complicated. I wonder how to document
this so that other people do not have to discover these
dependencies again and again. Is it even possible?

Well, I still think that it makes sense to improve
nbcon_cpu_emergency_exit() to fill the potential hole.
And ideally mention all these details somewhere
(commit message, comments, Documentation/...)

Best Regards,
Petr

