Return-Path: <linux-kernel+bounces-28957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB9830525
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E92B22015
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F101EA74;
	Wed, 17 Jan 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6ye0WbO"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE681E89E;
	Wed, 17 Jan 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494386; cv=none; b=RiptsqIlgXJy4+XFlww+7Lrv2y5aKkxhrhpB5ie+q0fI0MYd/a+g8GqluSHxA6jBbg+1/BQ6Hrg/qCeKVPNKxN+CzVx5RYnX8zn9iPT/eeXawveAobZWCmcbM5pB+knk+/fVFJVEl0WhJ68rR5N3ve9+R8fSUMh6XHaAWpNR26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494386; c=relaxed/simple;
	bh=dMRPNMfnZdbmEGK6soJL6Xz1KLZ8SkRSDkiKqO49UNg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=KP+gVB4u3z35sSTJjMXDrnYBt0fuj8l9/wevWaSlyGdOjm0J35iNjNNjVCQU3ohCRF52UnBCf/h16V36JzUAXENW8+hR7Cy1u7g7A30ZdAHbC/WOoZuW4hey0thNwqCih4oxDugisRkKzasOXU1QrDHs3JJaMBPy2E5Or+6C6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6ye0WbO; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so126497861fa.3;
        Wed, 17 Jan 2024 04:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705494383; x=1706099183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIIWT/IwddEjV/+NQCreP/WJZ3qm+exSEEdJpu8py0I=;
        b=c6ye0WbOsOAhJevuZwqFKy8hl2MgS4oYGlIyQuEpfDuLqB1BE/+HmvmSEfXdFwvhzA
         QEX2DQaedMOJcxgoAmYWrMV5Kmdql8cLIN8Ynib8hr/BsZBd0k5tTFepATQjYy/qqmmQ
         QoJCa0TSG6zY6cUTH1otZqKcWkJ+NkNbhttw4PeFjpgTJ9H53CS61STqyuLQzFpvusUs
         RPcJbRuSU+R7XMlVbxNWaePRpdkSI6bnDNxDmAlrbf2B9YirIu8/Ktg1VSjeUiLpf6xd
         yNyfYBM0L12gs5wGof2FCqL6HUbg6sMOPMa4PtYodpN0Sy3dIk3eScaVZtUvf/SSt7Ou
         eskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705494383; x=1706099183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIIWT/IwddEjV/+NQCreP/WJZ3qm+exSEEdJpu8py0I=;
        b=Vb+jGRFORvHfiN5MK4BVOi+rYFKMPbu86TXJt/43KVNBqmea8YwF13bUSYOeQpLJHN
         mxyo/javkspm/SSwCT1vmjXNZB0yjHn70vvlgqMrFTNg5cM8fBAO4F6AxxH0j8RX+eWC
         SoeiBIfxuhwayIBTMV8xqiH+SjztRBZOwokxXyNcSKsYE09qQjie0tx399x1cjr440mA
         kAsMA8sK3XdHTX+OVXPvtf/KnYjwROx7XTnMs2G7+RdCPJaSwQcPFhnx+sWixG59kC8D
         5O6Sn01mtdBPLUd483aNgMX6psZtrcezdFwTUCMo7wQ4vEufODw0f0560nlN+sJtDasy
         djFg==
X-Gm-Message-State: AOJu0Yx4th74YHW9J5qHW2UFpZBmh9XvFmyjjsEm3HNRvlcPKfVlyESO
	Nm84Yxz6ZW5hZhtSqvmrSwI=
X-Google-Smtp-Source: AGHT+IH04Dhy+IcBK3g3YpdoPAtLwrds9n6xYVLzNmpNU02GKxauyyc5Vl900ghZfaRlcXGzL4XucA==
X-Received: by 2002:a05:6512:488e:b0:50d:1c9d:59e4 with SMTP id eq14-20020a056512488e00b0050d1c9d59e4mr3708593lfb.47.1705494382623;
        Wed, 17 Jan 2024 04:26:22 -0800 (PST)
Received: from pc636 (host-90-235-20-191.mobileonline.telia.com. [90.235.20.191])
        by smtp.gmail.com with ESMTPSA id p3-20020a056512312300b0050e7fe17591sm240685lfd.137.2024.01.17.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:26:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 17 Jan 2024 13:26:19 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZafHa37MS_eYMEr6@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
 <8edf32ff-ea10-43f3-8820-b67f1691bad2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edf32ff-ea10-43f3-8820-b67f1691bad2@paulmck-laptop>

> > +/*
> > + * There are three lists for handling synchronize_rcu() users.
> > + * A first list corresponds to new coming users, second for users
> > + * which wait for a grace period and third is for which a grace
> > + * period is passed.
> > + */
> > +static struct sr_normal_state {
> > +	struct llist_head srs_next;	/* request a GP users. */
> > +	struct llist_head srs_wait;	/* wait for GP users. */
> > +	struct llist_head srs_done;	/* ready for GP users. */
> > +
> > +	/*
> > +	 * In order to add a batch of nodes to already
> > +	 * existing srs-done-list, a tail of srs-wait-list
> > +	 * is maintained.
> > +	 */
> > +	struct llist_node *srs_wait_tail;
> > +} sr;
> 
> Please put this in the rcu_state structure.  Having the separate structure
> is fine (it does group the fields nicely, plus you can take a pointer
> to it in the functions using this state), but it is good to have the
> state in one place.
> 
> Also, please add the data structures in a separate patch.  This might
> save someone a lot of time and effort should someone breaks the kernel
> in a way that depends on data-structure size.  It would be much easier
> for us if their bisection converged on the commit that adds the data
> structures instead of the commit that also adds a lot of code.
> 
I put the data under rcu_state in the patch-3 in this series. But i can
create a separate patch for this purpose. Should i split it or not?

> > +	/* Finally. */
> > +	complete(&rs->completion);
> > +}
> > +
> > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > +{
> > +	struct llist_node *done, *rcu, *next;
> > +
> > +	done = llist_del_all(&sr.srs_done);
> > +	if (!done)
> > +		return;
> > +
> > +	llist_for_each_safe(rcu, next, done)
> > +		rcu_sr_normal_complete(rcu);
> > +}
> > +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> 
> Why not put this into the sr_normal_state structure?  You can use
> __WORK_INITIALIZER() to initialize it, as is done in a number of other
> places in the kernel.
> 
It is not a big problem. I can move it under "rcu_state" also!

> > +/*
> > + * Helper function for rcu_gp_cleanup().
> > + */
> > +static void rcu_sr_normal_gp_cleanup(void)
> > +{
> > +	struct llist_node *head, *tail;
> > +
> > +	if (llist_empty(&sr.srs_wait))
> > +		return;
> > +
> > +	tail = READ_ONCE(sr.srs_wait_tail);
> > +	head = __llist_del_all(&sr.srs_wait);
> > +
> > +	if (head) {
> > +		/* Can be not empty. */
> > +		llist_add_batch(head, tail, &sr.srs_done);
> > +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > +	}
> > +}
> > +
> > +/*
> > + * Helper function for rcu_gp_init().
> > + */
> > +static void rcu_sr_normal_gp_init(void)
> > +{
> > +	struct llist_node *head, *tail;
> > +
> > +	if (llist_empty(&sr.srs_next))
> > +		return;
> > +
> > +	tail = llist_del_all(&sr.srs_next);
> > +	head = llist_reverse_order(tail);
> 
> Again, reversing the order is going to cause trouble on large systems.
> Let's please not do that.  (I could have sworn that this was not present
> in the last series...)
> 
> > +	/*
> > +	 * A waiting list of GP should be empty on this step,
> > +	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > +	 * rolls it over. If not, it is a BUG, warn a user.
> > +	 */
> > +	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > +
> > +	WRITE_ONCE(sr.srs_wait_tail, tail);
> > +	__llist_add_batch(head, tail, &sr.srs_wait);
> > +}
> > +
> > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > +{
> > +	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> > +}
> > +
> >  /*
> >   * Initialize a new grace period.  Return false if no grace period required.
> >   */
> > @@ -1456,6 +1556,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> >  	rcu_seq_start(&rcu_state.gp_seq);
> >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > +	rcu_sr_normal_gp_init();
> >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >  	raw_spin_unlock_irq_rcu_node(rnp);
> > @@ -1825,6 +1926,9 @@ static noinline void rcu_gp_cleanup(void)
> >  	}
> >  	raw_spin_unlock_irq_rcu_node(rnp);
> >  
> > +	// Make synchronize_rcu() users aware of the end of old grace period.
> > +	rcu_sr_normal_gp_cleanup();
> > +
> >  	// If strict, make all CPUs aware of the end of the old grace period.
> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> >  		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > @@ -3561,6 +3665,38 @@ static int rcu_blocking_is_gp(void)
> >  	return true;
> >  }
> >  
> > +/*
> > + * Helper function for the synchronize_rcu() API.
> > + */
> > +static void synchronize_rcu_normal(void)
> > +{
> > +	struct rcu_synchronize rs;
> > +
> > +	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> > +		wait_rcu_gp(call_rcu_hurry);
> > +		return;
> > +	}
> > +
> > +	init_rcu_head_on_stack(&rs.head);
> > +	init_completion(&rs.completion);
> > +
> > +	/*
> > +	 * This code might be preempted, therefore take a GP
> > +	 * snapshot before adding a request.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP))
> > +		rs.head.func = (void *) get_state_synchronize_rcu();
> > +
> > +	rcu_sr_normal_add_req(&rs);
> > +
> > +	/* Kick a GP and start waiting. */
> > +	(void) start_poll_synchronize_rcu();
> 
> It is unfortunate that the debugging requires an extra timestamp.
> The ways I can think of to avoid this have problems, though.  If this
> thing was replicated per leaf rcu_node structure, the usual approach
> would be to protect it with that structure's ->lock.
> 
Hmm.. a per-node approach can be deployed later. As discussed earlier :)

Debugging part i do not follow, could you please elaborate a bit?

Thanks!

--
Uladzislau Rezki

