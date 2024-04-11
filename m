Return-Path: <linux-kernel+bounces-140789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F08A18FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0011F21258
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECDE54777;
	Thu, 11 Apr 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="blYtF2tb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3985380F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849543; cv=none; b=dN0bjFA/oQwgAtRB2xq1rR7rVQZMMbHQxwAqiC/g+UgqhqKiIpN/thrySJAIDs7xq62gIBWHetQzBnJWGBBaxPZyGY6naxyWKUWjwlkckCS/NG2IXnrYJk+s1jxO6DKnQBShd+Db6jSTss/wD/2U4PLpgiB/nDE2eWUrAQGWKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849543; c=relaxed/simple;
	bh=IyHWKfJx4/v5RJrdJq6W315oo5Lkm0Pzl3tHMfrpxRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0vxzbSm2RnGAEyUjM4+lSfTDFt+JQTPM27H1YtBtP8wZ5IggHBGPE8L3w3o436dTw2QJo659aay21tW3cEt6IVyIWGMXhuENhsdSnWpTeOfL8P4uwW3v+iI2aabvUKlSnmVguQLQvCaL9k6XIBZAdQlXHtWxezZxGcrTQpEWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=blYtF2tb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346359c8785so1916044f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712849539; x=1713454339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRsw012qwcWMh1DiphZUTwhSQZ4Q0IKZOt/xWvTpM6A=;
        b=blYtF2tbXlNKwRYp1ghzHVhBeNzXRVEfDn+W09/FDe/GqQF47/UgkEhmVSQkSf6yrq
         jWE1IiUvnUeKYXeAP2yrwsToqsd2F9IvraIM3YHzTKP28mymvtGt/O/mpuUm6b37M0d/
         PkWX7aeqpdHcarCOmZ5pNylCOPUg0y8YX8U9b3xdbEVTz6BE34F/0dKP1wVDT4zqUKZW
         lp+VXIYeFFrF/yB8l2uetMm9eQUXlGJxB/lfIT2JPZ5/6+xTQ/uEMdGs/5XoxAiJc06M
         RRogqDPs8z87IxCIqufJwWkOE6G6ainaTWlbA51PMBE/GMZL0LaCh1TH8LDZ1EEOWgDP
         VS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849539; x=1713454339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRsw012qwcWMh1DiphZUTwhSQZ4Q0IKZOt/xWvTpM6A=;
        b=f0qcjZx3wsDur25n2FmcaAs8RaXhdN0RDoPKZWUEzpjS/HjdpcA8JeabAtSYOQQXF+
         7kxsyj+RcftbvU2CgJYMmJZkycldqLZF9X5qxjC/x8g/FulSNOlgdbW7zHlaRMu2d5iD
         leo/Ttlrze8qR9sA09zCtGDwUS2IdGV9XJzpJ1VG69SRe3ahbdqI6PJiEMmZ/q/6JqxN
         QzITZDqZDKa8O1pggsQmNsQEzbkP5jkenNXCw0HFFL8tyAZxscUiXfJrj+BvSZmnygn3
         t0eKCufMc2EhxliDfSw0QIS7acCBcMI6KdryBYsNJON0YqA90yyJaFptGA6ua8omOIOk
         aBZA==
X-Forwarded-Encrypted: i=1; AJvYcCUX4RVYxBzYxp+eG1peddIt3hXzsKeagSb1GI3FnGiZEvR6PzFEPbJkrZfB5sBjbHzuqVeO27qeejl3Mo5gGgLcLWg7yzbczhXY2ZKF
X-Gm-Message-State: AOJu0YzX2yp2SHGKuHQIzDY41M/E6LZryNCQynWJWFcSMQbLTDCbjzvP
	EQRgv7Fg49s14b2A3QYDeWNwZ3GT6KLREsC2GnJyxAIh3rhGf6a2cXNBI5FGY2g=
X-Google-Smtp-Source: AGHT+IHvwhR61c0dkdEi04kStj4mnKhA3iXEO8UTTHbakFqSCQi18R+xRFxaAAY6Tnm3W8mXzRydJw==
X-Received: by 2002:a5d:65cf:0:b0:343:eb7d:760e with SMTP id e15-20020a5d65cf000000b00343eb7d760emr4316228wrw.17.1712849538668;
        Thu, 11 Apr 2024 08:32:18 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c4-20020adfa304000000b00346ea868f47sm214604wrb.21.2024.04.11.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:18 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:32:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <ZhgCgBK7JdRruvkj@localhost.localdomain>
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
> 
> I see 3 possible solutions:
> 
>   1. Enforce that nbcon context can be acquired only with preemtion
>      disabled.
> 
>   2. Enforce that nbcon context can be acquired only with
>      interrupts. It would prevent deadlock when some future
>      code interrupt flush in NBCON_PRIO_EMERGENCY context.
>      And then a potential nested console_flush_all() won't be
>      able to takeover the interrupted NBCON_PRIO_CONTEXT
>      and there will be no progress.
> 
>   3. console_flush_all() should ignore nbcon console when
>      it is not able to get the context, aka no progress.
> 
> 
> I personally prefer the 3rd solution because I have spent
> last 12 years on attempts to move printk into preemtible
> context. And it looks wrong to move into atomic context.
> 
> Warning: console_flush_all() suddenly won't guarantee flushing
> 	 all messages.
> 
> 	 I am not completely sure about all the consequences until
> 	 I see the rest of the patchset and the kthread intergration.
> 	 We will somehow need to guarantee that all messages
> 	 are flushed.

I am trying to make a full picture when and how the nbcon consoles
will get flushed. My current understanding and view is the following,
starting from the easiest priority:


  1. NBCON_PRIO_PANIC messages will be flushed by calling
     nbcon_atomic_flush_pending() directly in vprintk_emit()

     This will take care of any previously added messages.

     Non-panic CPUs are not allowed to add messages anymore
     when there is a panic in progress.

     [ALL OK]


  2. NBCON_PRIO_EMERGENCY messages will be flushed by calling
     nbcon_atomic_flush_pending() directly in nbcon_cpu_emergency_exit().

     This would cover all previously added messages, including
     the ones printed by the code between
     nbcon_cpu_emergency_enter()/exit().

     This won't cover later added messages which might be
     a problem. Let's look at this closer. Later added
     messages with:

	+ NBCON_PRIO_PANIC will be handled in vprintk_emit()
	  as explained above [OK]

	+ NBCON_PRIO_EMERGENCY() will be handled in the
	  related nbcon_cpu_emergency_exit() as described here.
	  [OK]

	+ NBCON_PRIO_NORMAL will be handled, see below. [?]

     [ PROBLEM: later added NBCON_PRIO_NORMAL messages, see below. ]


  3. NBCON_PRIO_NORMAL messages will be flushed by:

       + the printk kthread when it is available

       + the legacy loop via

	 + console_unlock()
	    + console_flush_all()
	      + console nbcon_legacy_emit_next_record() [PROBLEM]


PROBLEM: console_flush_all() does not guarantee progress with
	 nbcon consoles as explained above (previous mail).


My proposal:

	1. console_flush_all() will flush nbcon consoles only
	   in NBCON_PRIO_NORMAL and when the kthreads are not
	   available.

	   It will make it clear that this is the flusher in
	   this situation.


	2. Allow to skip nbcon consoles in console_flush_all() when
	   it can't take the context (as suggested in my previous
	   reply).

	   This won't guarantee flushing NORMAL messages added
	   while nbcon_cpu_emergency_exit() calls
	   nbcon_atomic_flush_pending().

	   Solve this problem by introducing[*] nbcon_atomic_flush_all()
	   which would flush even newly added messages and
	   call this in nbcon_cpu_emergency_exit() when the printk
	   kthread does not work. It should bail out when there
	   is a panic in progress.

	   Motivation: It does not matter which "atomic" context
		flushes NORMAL/EMERGENCY messages when
		the printk kthread is not available.

	  [*] Alternatively we could modify nbcon_atomic_flush_pending()
	      to flush even newly added messages when the kthread is
	      not working. But it might create another mess.

How does it sound, please?
Or do I miss anything?

Best Regards,
Petr

