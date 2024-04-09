Return-Path: <linux-kernel+bounces-136490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749889D4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A44D1C2134B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9566512BE93;
	Tue,  9 Apr 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChrZtM/o"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C427F48A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651585; cv=none; b=s79zJNmSZv1iKVnKlHv0qjjgTeX86PITkCoG9uhBuXDvSn8h9M/4GQLFxDnNveeBHKWniSIMjkE6ch6T0UwkCQ5PUgSwAkQX/2vjPNpu+aMteZCzwwXFCnxjimoEBtUAJm02gQ4vT3eqS7xtu3qUuLRr9xCU9v9xVEsBCGiB9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651585; c=relaxed/simple;
	bh=IPBKZGuj+c8jfbxCyqEu8bdvNX/QlVZOJ4Y4Wt3yG9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAe4NDp6Y9uLiifaq1rLnEHHZeLE3gy/TantlZcao6PGnqF45w1M2jt3VuDxIX7RMJEMYBjOzMx34b8+fz6T+YNdlJeHHGr7Q5ATmPTPNeJAyDTyp8mblXpU7Dip3Em+ix2OgWx5VozwhVjr/i2JFr8KlEG9b4JBU4WTuO8k1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChrZtM/o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51d0dda061so279648166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651582; x=1713256382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRayyxWk8sxum+EAahZsr+2DNEGCN3xWu7VYhar3ENY=;
        b=ChrZtM/oY4QYiqHGES7s3+Ta44KIDI9kyDKhVnKV4V6xaJl9XeLoQ4yRRld8VBlR1g
         upKvegEGduGrEvOr75xp/+4qPjDvyVFSndhxnlj4lTiB3vRs3q8qpvcG6XiONGYAX6Ze
         N1qyD4IE7vEBq/hsbeFW/7Pgi7K7GUZpYSl3qiTy56pAbV6tOzKl1VkpHzw56vhm5wVe
         duYqwmThTTwWZAkI2q/xc4dHmU8Zf3sE4dhgouwBNKTgiDKulL9k0yqdyzEs43FxIBDs
         HcgbBQOF7HiiMmmAf5ljhLbzr/mmFr840UXu3DjFfbg/VdiyZ+gYv1Lf63tdWJP7c4Ch
         WXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651582; x=1713256382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRayyxWk8sxum+EAahZsr+2DNEGCN3xWu7VYhar3ENY=;
        b=psxXD0Ad7caoFZVND6Kgxca3IoVThaYOWwl5qZB4aS6kUoY+OA5mpAHXW+gGB4tBWp
         1MUGCHMrxaWh6n4eS6obhWuIDFZ1U3p2mkxv0bLg6j3JXnZPzeFCoPXaUuocWJ5I2qAc
         wdZWsWgGc33yXViR2RyXHOmtsT3S1HIquxi+qNSynmjbHVW81oTEyhkfXWx/z+xIo//q
         I/Za/FFp9qE1RW29Wk+W+m0c00uW5IsuCja2WmytCDykE1IbxUlia5VVjITTsY0qNzno
         YY6yRbwCKzMo9UdA77yYa65EcwBcJf6zpf931D9JZP+pTDQNSoHBE1akHB7aKfOS25MV
         Mwow==
X-Gm-Message-State: AOJu0YwBcov/48fS5JjFeq8XuvbNTIo08zd3O5iOVVQj3V4JW2OrjKpn
	KgdHpLQvUXgddo44MX3ZnzfgC92nvi8km2ypETXjlA5pYILbUaCX
X-Google-Smtp-Source: AGHT+IHil8eZ6bHhIOGTyxaN7zP8KKj5C2BewkAxLa5ifPNGet4oxuX9+JS6zA4ahGWrzC+V48ZRzA==
X-Received: by 2002:a17:906:2c17:b0:a51:9c84:452a with SMTP id e23-20020a1709062c1700b00a519c84452amr1554054ejh.32.1712651581849;
        Tue, 09 Apr 2024 01:33:01 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id jg30-20020a170907971e00b00a46a9cdcfa5sm5340275ejc.162.2024.04.09.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:33:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Apr 2024 10:32:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/5] sched/fair: Rename set_next_buddy() to
 set_next_pick()
Message-ID: <ZhT9O6yd868GuAxr@gmail.com>
References: <20240407084319.1462211-1-mingo@kernel.org>
 <20240407084319.1462211-6-mingo@kernel.org>
 <20240408091605.GE21904@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408091605.GE21904@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Apr 07, 2024 at 10:43:19AM +0200, Ingo Molnar wrote:
> > This is a mechanism to set the next task_pick target,
> > 'buddy' is too ambiguous and refers to a historic feature we
> > don't have anymore.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/sched/fair.c | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 93ea653065f5..fe730f232ffd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3200,7 +3200,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	hrtick_update(rq);
> >  }
> >  
> > -static void set_next_buddy(struct sched_entity *se);
> > +static void set_next_pick(struct sched_entity *se)
> > +{
> > +	for_each_sched_entity(se) {
> > +		if (SCHED_WARN_ON(!se->on_rq))
> > +			return;
> > +		if (se_is_idle(se))
> > +			return;
> > +		cfs_rq_of(se)->next = se;
> > +	}
> > +}
> >  
> >  /*
> >   * The dequeue_task method is called before nr_running is
> > @@ -3240,7 +3249,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  			 * p is sleeping when it is within its sched_slice.
> >  			 */
> >  			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
> > -				set_next_buddy(se);
> > +				set_next_pick(se);
> >  			break;
> >  		}
> >  		flags |= DEQUEUE_SLEEP;
> > @@ -4631,17 +4640,6 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
> >  #endif /* CONFIG_SMP */
> >  
> > -static void set_next_buddy(struct sched_entity *se)
> > -{
> > -	for_each_sched_entity(se) {
> > -		if (SCHED_WARN_ON(!se->on_rq))
> > -			return;
> > -		if (se_is_idle(se))
> > -			return;
> > -		cfs_rq_of(se)->next = se;
> > -	}
> > -}
> > -
> 
> Hurmmm.. afaict the only actual user of cfs_rq->next left is task_hot(),
> no? Is that thing worth it?

Yeah, so:

1)

While you are correct in the context of my patch, I think that might be a 
bug - the yield_to() methods are intending to use ->next:

        /* Tell the scheduler that we'd really like se to run next. */
        set_next_buddy(se);

        yield_task_fair(rq);

.. and yield_to() would rather fundamentally rely on ->next overriding the 
next-task-pick selection, but it won't due to NEXT_BUDDY being false:

static struct sched_entity *
pick_next_entity(struct cfs_rq *cfs_rq)
{               
        /*      
         * Enabling NEXT_BUDDY will affect latency but not fairness.
         */
        if (sched_feat(NEXT_BUDDY) &&
            cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
                return cfs_rq->next;



> That is, should we not totally nuke the thing?

I don't think we want to nuke it - there's 3 users:

 - yield()
 - CFS bandwidth
 - wakeup

I think the yield() and CFS bandwidth ones are genuine, but non-working due 
to NEXT_BUDDY at 0. Wakeup was the original intended NEXT_BUDDY logic, but 
it got turned off due to some performance or latency considerations that 
might or might not be valid & relevant today.

2)

Even the task_hot() use of ->next isn't spurious: if a task has been marked 
as run-next, then presumably the current task is descheduling and we should 
probably not tear its ->next away in load-balancing.

3)

Side note: a set rq->next should probably reduce a candidate runqueue's 
weight both in periodic load-balancing and in idle-balancing, by rq->curr's 
weight or so?

So what I think we should do is to keep ->next and fix all its intended 
uses, and make it all unconditional by removing both NEXT_BUDDY and 
CACHE_HOT_BUDDY. I can cook up a series if you agree in principle.

Thanks,

	Ingo

