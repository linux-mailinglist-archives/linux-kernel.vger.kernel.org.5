Return-Path: <linux-kernel+bounces-150361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81C8A9DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833E11F22A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299216ABEE;
	Thu, 18 Apr 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EujSt0qI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB11649DE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452637; cv=none; b=M0myg/0xDGo5QLRJwOAJfSM51LpH+EZ1sZeU6Tq7ojX0BTxxTLgeZJADfyCDsnDsHWV5MuGdW5So8GHUo/0LRbEaQ7p72wCV3lWFVzfsJs1ofAMmptcAVCiDWvPK0bjEh/P3xS7ckEwnIIwJ2K+RyH7OTw3wt/jTCO76EQUrPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452637; c=relaxed/simple;
	bh=xGfPRY1qTmJ7gvR6rws0haqyz6KMxDGzBv7XztbhHGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN4mZE98pcrZC89QpoVBlm2m/MZHscAfT7FEKpDIexvaE2U+64Wft6PbQgUVETUAFaEfPbX3IhS0YbrIyKOkJRY7FT6iPfAb9wqfh69Wuf/puNEshu6JQ2MXNR+Udj+T/JEYbFq6QfBbLk5i6tJOeoX3Eq4Nu70j54Q9t0accfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EujSt0qI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418dde387a3so7543965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713452630; x=1714057430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iG0C4gcrx0ejEYPefXn/oJdDvpEFVh0exY1ffll4kg=;
        b=EujSt0qISzEfrsI2PqPfiQX1mzI28CU+OXIHz/+xfnagDqmkD87bFDo5bR1veKButk
         IyYji2SgCkCgclxd17bXFh+ScV/ifdQl0P6UrOxvMWcCWKgIPLYg2aT0g+C7SjrR3JHq
         v10SWyQiLz8z7SJff24hbc4bwLyfKS+7VGBjtAkK69nYpvS5dvHMRcTd7O0I8dgXk6KA
         sjsf60YwcuTx5mqkYeWhv/NQ6IzQconZrV0wa6MUB1mCvvMqaAYAFle689MopSVnxKGT
         jbnUVzR1row0EbXlFyVcVFxwOINg+jcJLA4ctM6Wgq+C/HzI6SnNsO3jACsH+Jt38SJe
         TGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452630; x=1714057430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iG0C4gcrx0ejEYPefXn/oJdDvpEFVh0exY1ffll4kg=;
        b=SqNP970K9n6EqRIXKU3CRWJnA0JMpBdJ9gnN59iMTKe7CN1EpVoLPvSYWpgwSTHTH2
         5ez7FbhHDTfIbl8aEKffyugH7tkXJKrKOkhFCsmkDi1trKyBubS12moXB5msArRBZ8km
         VvSCiVmV4luQ7LpenF/TQB8X0UAgZqE8eheyXSwhWut/PH1rlr0zDaZUMaUMf4n73BGq
         NiGHuVRdPGnE1C1wr5HZHaczUgq8LfLGQR/Qiy50QeVOne3szY9pPKTbfbY/B7p+uqql
         FarSLaJVXzeaXGzEZLp31B/cAoA6T4ZVT4ys4rX7NQaUkufdpHOaG8xtFe5C+7j/KNcJ
         RYOw==
X-Forwarded-Encrypted: i=1; AJvYcCXTP/cBqfLkBw68p5vsW24i3qPZ7ziOTl3CNKvnLPQE/JjzK850JI7VnNWaq9Zw25QYQ2V3vg8nfjYu3yRq8J2DJzvArPv04tFhy1to
X-Gm-Message-State: AOJu0YwPvVWWDUY/hz8j0RxBSrJbs/RQNbFPQOZf6sbGVXzHwFSj/eoZ
	WFD5gjXaL5LYXmf2Es9zg0syfig9KHmaGYD/HBzB2bEVEn9XDTwckiaRhX27kHo=
X-Google-Smtp-Source: AGHT+IE07HzTBUUk6cHsSABxdSCMqvtNsGxapy+8fEBxDBZ8dapr7sEIHtnyquqaF8VQ77kvjBTG5A==
X-Received: by 2002:a05:600c:1c03:b0:418:2e93:163e with SMTP id j3-20020a05600c1c0300b004182e93163emr2678761wms.31.1713452630240;
        Thu, 18 Apr 2024 08:03:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b00343daeddcb2sm2031301wrt.45.2024.04.18.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:03:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:03:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
Message-ID: <ZiE2VO9Q03TvHJ_t@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
 <ZhUIatzxietD4F-m@localhost.localdomain>
 <87y19djqr0.fsf@jogness.linutronix.de>
 <Zh_IrB4MyHwU8OJE@pathway.suse.cz>
 <87bk68niod.fsf@jogness.linutronix.de>
 <ZiD3FNBZh_iMOVWY@pathway.suse.cz>
 <87h6fyswgn.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6fyswgn.fsf@jogness.linutronix.de>

On Thu 2024-04-18 14:16:16, John Ogness wrote:
> On 2024-04-18, Petr Mladek <pmladek@suse.com> wrote:
> > I am not sure how it is done in other parts of kernel code where
> > RT needed to introduce some tricks. But I think that we should
> > really start mentioning RT behavior in the commit messages and
> > and comments where the RT mode makes huge changes.
> 
> Yes, our motivation is RT. But these semantics are not RT-specific. They
> apply to the general kernel locking model.

Yes, but RT is a nice example where it is clear what want to achieve.
IMHO, a clear example is always better then a scientific formulation
where every word might be important. Especially when different people
might understand some words different ways.


> For example, even for a !RT system, it is semantically incorrect to
> take a spin_lock while holding a raw_spin_lock.

Really? I am not aware of it. I know that lockdep complains even
in no-RT configuration. But I have expected that it only helps
to catch potential problems when the same code is used with
RT enabled.

Is there any difference between spin_lock() and raw_spin_lock()
when RT is disabled. I do not see any. This is from
include/linux/spinlock.h:

	/* Non PREEMPT_RT kernel, map to raw spinlocks: */
	#ifndef CONFIG_PREEMPT_RT
	[...]
	static __always_inline void spin_lock(spinlock_t *lock)
	{
		raw_spin_lock(&lock->rlock);
	}

Would raw_spinlock() API exist without CONFIG_PREEMPT_RT?

Maybe, you do not understand what I suggest. Let's talk about
particular comments in the code.


> In the full PREEMPT_RT series I have tried to be careful about only
> mentioning PREEMPT_RT when it is really PREEMPT_RT-specific. For example
> [0][1][2].
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.9.y-rt-rebase&id=1564af55a92c32fe215af35cf55cb9359c5fff30
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.9.y-rt-rebase&id=033b416ad25b17dc60d5f71c1a0b33a5fbc17639
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.9.y-rt-rebase&id=7929ba9e5c110148a1fcd8bd93d6a4eff37aa265
> 
> > The race could NOT happen in:
> >
> >    + NBCON_PRIO_PANIC context because it does not schedule
> 
> Yes.
> 
> >    + NBCON_PRIO_EMERGENCY context because we explicitly disable
> >      preemption there
> 
> Yes.
> 
> >    + NBCON_NORMAL_PRIO context when we ALWAYS do nbcon_try_acquire()
> >      under con->device() lock. Here the con->device_lock() serializes
> >      nbcon_try_acquire() calls even between running tasks.
> 
> The nbcon_legacy_emit_next_record() printing as NBCON_NORMAL_PRIO is a
> special situation where write_atomic() is used. It is safe because it
> disables hard interrupts and is never called from NMI context.
> 
> nbcon_atomic_flush_pending() as NBCON_NORMAL_PRIO is safe in !NMI
> because it also disables hard interrupts. However,
> nbcon_atomic_flush_pending() could be called in NMI with
> NBCON_NORMAL_PRIO. I need to think about this case.

It is safe. The race scenario requires _double_ scheduling (A->B->A):

 1. [CPU 0]: process A acquires the context and is scheduled (CPU 0)

 2. [CPU 1] The nbcon context is taken over and released in emergency.

 3. [CPU 0] process B acquires the context and is scheduled

 4. [CPU 0] process A thinks that it still owns the context
	    and continue when it ended.


This could not happen with the current code when:

   + nbcon_try_acquire() is serialized by con->device_lock()
     because process B would get blocked on this lock.

   + nbcon_try_acquire() is called in atomic context
     because the context is always released before scheduling.


I would say that this is far from obvious and we really need
to document this somehow. I would mention these details above
nbcon_context_try_acquire().

Best Regards,
Petr

