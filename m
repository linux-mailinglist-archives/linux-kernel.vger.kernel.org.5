Return-Path: <linux-kernel+bounces-6311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE681970B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAAB2813DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2778F51;
	Wed, 20 Dec 2023 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MyZ5PtdH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4A8C09
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42784b919b9so4008571cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1703041317; x=1703646117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XD0gRaE/GD7TBRGiqCrx3DHZEddpSttePAQKexu8u2g=;
        b=MyZ5PtdHHMrnCJPPWjiVPfCB1ZOP4dKIkP/RBV9QCU2Wn1xINNjGDf1FXJb/sl5bir
         Gmr69laeBabo0o1dkh9pti30IV5cbepcnISd/N0SWVU25dvKxncTxi2oEL+nnZMr3TXt
         4BURLFDUmS+J00kH2L5ETYNr9MbjrKt4ZllNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041317; x=1703646117;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD0gRaE/GD7TBRGiqCrx3DHZEddpSttePAQKexu8u2g=;
        b=fuDYGoJ5yR0/AqmZTdEF5XFim7XhNuQUSSGg9/rr5zGEElvSVsNJhdmgvsAhq2SwIj
         AnWhJ3oQVY+amkFfF8XPlqbMbgsrJdEbaeCC4iNZ5er7RWQwFz0GEFcNuiug/KUG4/Ac
         bf4VMA0bJYTIBFL2Ann4nQyFKIp7GGv0FNXTeXYMenp73V67s1ZZRVSUhrdQj0yKL6Mr
         V5gACBJv5/LbPE7rEkO2PbbUJDnpPqDIss8N97qMyT3Vivl5SLn1E6p+FeMtqyd6U9sk
         V0QHsHl8MrEcMociYWXsRP4RGPR4Lsllt6nrzQRgLNkmzIhebwgL4U/RnSIteVn95Raj
         QHgQ==
X-Gm-Message-State: AOJu0YxclUwDBuNaKpypgrCMjEPB5lROHLyIsnSvfOxR9G9C8bij7eRk
	p012PyrDrCQww55QAuzIzoECaA==
X-Google-Smtp-Source: AGHT+IFORiDdgAptC4EJWMmUY2s0Y9J6QOiHZTyxxA3nCQ7IANNK0EYU39Z6CGmXMP2SYUWDdfDkTQ==
X-Received: by 2002:a05:622a:490:b0:425:a07f:6ca2 with SMTP id p16-20020a05622a049000b00425a07f6ca2mr27096673qtx.58.1703041316804;
        Tue, 19 Dec 2023 19:01:56 -0800 (PST)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id br6-20020a05622a1e0600b00425962ee7bdsm7792215qtb.18.2023.12.19.19.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:01:56 -0800 (PST)
Message-ID: <65825924.050a0220.222f1.dc9d@mx.google.com>
X-Google-Original-Message-ID: <20231220030155.GA56328@JoelBox.>
Date: Tue, 19 Dec 2023 22:01:55 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <65811051.d40a0220.75c79.66cf@mx.google.com>
 <ZYGFAtLNQsLUWGPr@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYGFAtLNQsLUWGPr@lothringen>

On Tue, Dec 19, 2023 at 12:56:50PM +0100, Frederic Weisbecker wrote:
> On Mon, Dec 18, 2023 at 10:38:52PM -0500, Joel Fernandes wrote:
> > On Tue, Dec 19, 2023 at 12:19:15AM +0100, Frederic Weisbecker wrote:
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 3ac3c846105f..157f3ca2a9b5 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1013,6 +1013,38 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
> > >  	return needmore;
> > >  }
> > >  
> > > +static void swake_up_one_online_ipi(void *arg)
> > > +{
> > > +	struct swait_queue_head *wqh = arg;
> > > +
> > > +	swake_up_one(wqh);
> > > +}
> > 
> > Speaking of, the scheduler refuses to do remote-IPI-style wakeups
> > (TTWU_QUEUE) whenever the destination CPU is in a hotplug state.
> > 
> > static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
> > {
> > 	/*
> > 	 * Do not complicate things with the async wake_list while the CPU is
> > 	 * in hotplug state.
> > 	 */
> > 	if (!cpu_active(cpu))
> > 		return false;
> > 	...
> > }
> 
> Yes, because all irrelevant tasks must be migrated out upon
> CPUHP_AP_SCHED_WAIT_EMPTY, thanks to balance_push_set().

Ah, got it.

> (Though right now I'm missing the flush_smp_call_function_queue() call that flushes
> the ttwu queue between sched_cpu_deactivate() and sched_cpu_wait_empty())

Possible. I saw your IRC message to Peter on that as well, thanks for
following up. I need to find some time to look more into that, but that does
sound concerning.

> > Along these lines, I wonder if, it is safe to do a wakeup in this fashion (as
> > done by this patch) if the destination CPU was also going down.
> > 
> > Also the same ttwu_queue_cond() checks for CPU affinities before deciding to
> > not do the IPI-style queue.
> > 
> > 	/* Ensure the task will still be allowed to run on the CPU. */
> > 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> > 		return false;
> > 
> > Not that anyone should be changing RCU thread priorities around while the IPI
> > is in flight, but...
> > 
> > I wonder if the reason TTWU is excessively paranoid is that the IPI can be
> > delayed for example, leading to race conditions.
> 
> It's because nothing irrelevant must be queued after sched_cpu_wait_empty().

Makes sense.

> But note this patch does something different, it doesn't defer the runqueue
> enqueue like ttwu queue does. It defers the whole actual wakeup. This means that the
> decision as to where to queue the task is delegated to an online CPU. So it's
> not the same constraints. Waking up a task _from_ a CPU that is active or not but
> at least online is supposed to be fine.

Agreed, thanks for the clarifications. But along similar lines (and at the
risk of oversimplifying), is it not possible to send an IPI to an online CPU
to queue the hrtimer locally there if you detect that the current CPU is
going down? In the other thread to Hilf, you mentioned the hrtimer infra has
to have equal or earlier deadline, but you can just queue the hrtimer from
the IPI handler and that should take care of it?

Let me know if I missed something which should make for some good holiday
reading material. ;-)

thanks,

 - Joel


