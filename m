Return-Path: <linux-kernel+bounces-139180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00E89FF99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F65C283AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597417B517;
	Wed, 10 Apr 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="K2t/6UA1"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BF180A97
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772942; cv=none; b=qb1JSLYdkLTynDyMEWYbm6xSXWM32xpWll3rqScoVOap6l4K01y1i6JW9K3TiqwPAJ3a7db2twGyUb4Rq/vxYYcQik7aX+jAhVwu+Vf2LSLHBonJ3o2Sg4zwzWDPlNzRjJTFnaENG//G0B7CtCrq/SpH7cOhHDRgW89Bjh+zsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772942; c=relaxed/simple;
	bh=I7w75JKCRyKbAmEW3pStOguyIrdpPPhkqLTig6UY8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj1YRYbTG4XpKpDfgDCndgMeB6vJ0Bi/qb6dc0ELdjYa0OWO5LJIIIQRdrKvYz7kcRjH7puKEo7bad++RBqlhNuiWQs1b26ZgGc6j+RX4MgmxQb4mE9GLrneiM0rNdT1YDuudK4yKL1He5AIEtKF+lp11/NOCJec5U71W0ijTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=K2t/6UA1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso4960257b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712772939; x=1713377739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UCu3vAa+tXcoFNa1tysLxOJ5zWMnnTVGFp6Jd0UonFc=;
        b=K2t/6UA10SQIPe3bYIl6dzI/OdAncXmidrYgpsEJf8x9WH/bdYlVLh2/dutIuNUB3I
         8ofirz+72by3iYq3Ffn3qkRT+gIR1+oxNvHnGxXG5G3Fi+/Myyx3MEfIybsHCfoapa/l
         /uS2olH/gKal27COqaLPjl9jQ84AZjZWM0EHeZZWnyx3Gnl1BRIaE5SWKRrewbPV15S4
         1F8/FAb6STLt8seijc2/oWS5KwTgtabDUde7559Bsx/hAV7BtIvXNeBz8jeUkdp27U2I
         hDgKgkJefZj7QoIgUX5yrkQw0kPLrU8bKNwSMAin3URbfrKgNquPeNEIQzPNlMIRCbiF
         4NQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772939; x=1713377739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCu3vAa+tXcoFNa1tysLxOJ5zWMnnTVGFp6Jd0UonFc=;
        b=Z4C2CsFCxnRQ7CRFz/kWf+NOcMfFaxU+MLfVd1FmoBeazpX5ckvapJIaXe6ObFO2tR
         Ene7vL71sbz4JWne3sR57Lr+EnkoTHSOmIsuLCpsacMq5Q+7nuXnjN119/uzRUAPgPGp
         Dcr2XVRd/WBEcqr2YVbYroTY94bTmnQkl7sgFHtDxZQYV7+15GdIgX9lfs10v36GQ5Fx
         9229jT/ZVJsUBdn65exnKgZp1lfdFtdwcsrjEMNGGoEwR2zkoeahgjeGTaFqjdw3MerA
         tfjsQMSfstcHfx4BiWoPkl1+pFsjlSJKQI98VFU+AUE/BTdsi/XSJMTzaYnYCIc0lWCa
         yf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSvIOecrw0asMgA5UPxxTMOBvUzwvhEALRezAb2PtrfRFlA9r95XVf3v1z7a8fT/lj4f1y9FJFdW+8Y9U9yalkNa8Urk9QyViWdisM
X-Gm-Message-State: AOJu0Yw/RSp9k6htdHt23flFzvjJH6XhzQv4DDXiQP+zuZ7Rxk3BKtQ9
	cJ+SXDN3xevuzW5cF8lp8EKN8CL+j6x4F0mJQOuRyuFW/oHdVJQj6jXkTjDaGo0=
X-Google-Smtp-Source: AGHT+IEYs1FkUZ/HZ0wZiL1iLIrRzC0Z3BEge6bs6qjHNR5sPLQMAjNa7/usFj5Mm9nVIbWuqhT+Fw==
X-Received: by 2002:a05:6a20:4391:b0:1a1:878d:d3f6 with SMTP id i17-20020a056a20439100b001a1878dd3f6mr4316748pzl.26.1712772939458;
        Wed, 10 Apr 2024 11:15:39 -0700 (PDT)
Received: from airbuntu ([104.132.0.101])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006ecca2f2a32sm10322177pfp.168.2024.04.10.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:15:39 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:15:37 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240410181537.fqpix44uo43jvwct@airbuntu>
References: <20240404220500.dmfl2krll37znbi5@airbuntu>
 <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
 <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
 <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
 <20240409061909.tb3vxc27h2eawiwg@airbuntu>
 <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>
 <20240410065901.ruzhjsmtmpsnl4qe@airbuntu>
 <CANDhNCr=S8b5MyDa9xp9D08FcsG6VGrHQjkj5CW3iFzuFO-4Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCr=S8b5MyDa9xp9D08FcsG6VGrHQjkj5CW3iFzuFO-4Xg@mail.gmail.com>

On 04/10/24 10:30, John Stultz wrote:
> On Tue, Apr 9, 2024 at 11:59 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 04/09/24 14:35, Vincent Guittot wrote:
> > > On Tue, 9 Apr 2024 at 08:19, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 04/08/24 12:51, John Stultz wrote:
> > > > > On Mon, Apr 8, 2024 at 12:17 AM Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > > >
> > > > > > > On 04/05/24 18:16, Qais Yousef wrote:
> > > > > > >
> > > > > > > > >
> > > > > > > > > All that to say that I think the weight is not applied on purpose.
> > > > > > > > > This might work for your particular case but there are more changes to
> > > > > > > > > be done if you want to apply prio inheritance between cfs tasks.
> > > > > > > > >
> > > > > > > > > As an example, what about the impact of cgroup on the actual weight
> > > > > > > > > and the inherited priority of a task ? If the owner and the waiter
> > > > > > > > > don't belong to the same cgroup their own prio is meaningless... task
> > > > > > > > > nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> > > > > > > > > in a group with a weight equals to nice -20
> > > > > > > >
> > > > > > > > That is on my mind actually. But I thought it's a separate problem. That has to
> > > > > > > > do with how we calculate the effective priority of the pi_task. And probably
> > > > > > > > the sorting order to if we agree we need to revert the above. If that is done
> > > > > > >
> > > > > > > Thinking more about it the revert is not the right thing to do. We want fair
> > > > > > > tasks to stay ordered in FIFO for better fairness and avoid potential
> > > > > > > starvation issues. It's just the logic for searching the top_waiter need to be
> > > > > > > different. If the top_waiter is fair, then we need to traverse the tree to find
> > > > > > > the highest nice value. We probably can keep track of this while adding items
> > > > > > > to the tree to avoid the search.
> > > > > > >
> > > > > > > For cgroup; is it reasonable (loosely speaking) to keep track of pi_cfs_rq and
> > > > > > > detach_attach_task_cfs_rq() before the reweight? This seems the most
> > > > > > > straightforward solution and will contain the complexity to keeping track of
> > > > > > > cfs_rq. But it'll have similar issue to proxy execution where a task that
> > > > > > > doesn't belong to the cgroup will consume its share..
> > > > > >
> > > > > > That's a good point, Would proxy execution be the simplest way to fix all this ?
> > > >
> > > > Is it? Over 4.5 years ago Unity reported to me about performance inversion
> > > > problem and that's when proxy execution work was revived as simplest way to fix
> > > > all of this. But still no end in sight from what I see. I was and still think
> > > > an interim solution in rt_mutex could help a lot of use cases already without
> > > > being too complex. Not as elegant and comprehensive like proxy execution, but
> > > > given the impact on both userspace and out of tree kernel hacks are growing
> > > > waiting for this to be ready, the cost of waiting is high IMHO.
> > > >
> > > > FWIW, I already heard several feedbacks that PTHREAD_PRIO_INHERIT does nothing.
> > > > I think this reweight issue is more serious problem and likely why I heard this
> > > > feedback. I could be underestimating the complexity of the fix though. So I'll
> > >
> > > Without cgroup, the solution could be straightforward but android uses
> > > extensively cgroup AFAICT and update_cfs_group() makes impossible to
> > > track the top cfs waiter and its "prio"
> >
> > :(
> >
> > IIUC the issue is that we can't easily come up with a single number of
> > 'effective prio' for N level hierarchy and compare it with another M level
> > hierarchy..
> >
> > Does proxy execution fix this problem then? If we can't find the top waiter,
> > I can't see how proxy execution would work here too. To my understanding it's
> > more about how we apply inheritance (by donating execution context of the top
> > waiter) instead of manually applying inheritance like we're doing now.
> 
> So, while proxy provides a sort of generalized inheritance, it isn't
> deep enough in the class scheduler logic to need to really think about
> priority/cgroups.
> 
> It just looks at what gets selected to run. That's the most important
> task at that moment. It doesn't really need to care about how/why,
> that's left to pick_next_task().
> 
> Since it leaves mutex blocked tasks on the RQ, it allows the class
> scheduler logic to pick the most important task (mutex-blocked or not)
> to run. Then if a mutex-blocked task gets selected, we will then find
> the mutex owner and run it instead so it can release the lock.  When
> locks are released, if the owner has a "donor" task, the lock is
> handed off to the donor.  So, this basically uses the
> pick_next_task()'s evaluation of what it wanted to run to effectively
> provide the "top waiter".

Thanks John. So there's no top waiter and all tasks are left runnable, makes
sense.

