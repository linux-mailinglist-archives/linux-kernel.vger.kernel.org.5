Return-Path: <linux-kernel+bounces-33833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E02836F21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7025528EE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A257877;
	Mon, 22 Jan 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlUvs5AI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AE58232;
	Mon, 22 Jan 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944951; cv=none; b=R87iEXBAFjo6RW2gI/Kdu59W/NwHJIPLvsnj+/hEp/RgN6zpxd43Vy0W3kLWI1FBrwv1NLBTl46lgYXbxlxHg8LQ/a7y4m7GfZ2/cYnFMTP/PcrXKNa2CCuevs+ZIkmzP0TSeY9pr11wTJryaK4FNZgGI5ZCbwyODI4ZLN+M2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944951; c=relaxed/simple;
	bh=2ezm21UhVsfWyVD0K7wIOdA+EFCXPwA1dLgFPeqrm8M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYWOXnYk7xKORT2JhvVjtPUqdI+aiO0tgPSd/fmw6dDolDCwO3B907R0IkW4JSahOSTiuDr3OJT9yD0A6/sofRIPhRzJNguibW5x32HyIlt+2IBe5GLzpoNEKtAchf1XCVFU2z3VZkljAcYBZAY7pfUagLu9qHkF1X+AvbGZW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlUvs5AI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7af5f618so3717170e87.1;
        Mon, 22 Jan 2024 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705944948; x=1706549748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dqBSyIgv8sSm/20jSASMnqFiyWpISklvDh6ge1jYog=;
        b=nlUvs5AIwwstM5JvvuG3N1ePBCnjREGPRCNZYZO8/TeCYJ10xmX3C/qxR2pJOvOIdQ
         sRvsNRtyyWUVvjLiLZuw35FvqG9h+bW1X1beHTy6A1n0TsTOdTDwfaTh36reYx+Ouz9H
         tYhrZmq77HiF977IdNYHU5qYu8VEF2dcOnfKXr/Mpn2zT712VMWov5mdBr7mruXUL+hb
         FMokSNPRk4NCkpjtbs5QUO8saUdMDnuVyKlPscIPuFz5tfgp0fZWjSaQpucv2ATmLMiO
         wOqnKmZLZcFljQ1gdPzUaka02pRQuZGZX0xgjr9dPQktJshWKlYp/qRcLMHRs6vAk0ih
         ZgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944948; x=1706549748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dqBSyIgv8sSm/20jSASMnqFiyWpISklvDh6ge1jYog=;
        b=JvqMmCvr5cMo4njAAP6AbR9VWAiiZxDqhiCXTULQgBazrK5U/rvRRlq4G/2ealImoZ
         yqJv/HYhevVjNFY56lhG2mOZmTh8HlWL0q3ScD/f4ayNJPMbYVGOq8ZJA1ZPB4FONMXe
         aYPgPT/D9Rg0IObCbXPdgGMlcerR+VAM5Ozqup8JQwPkNktMFe+yrKwfcIQEquynQIXD
         iiwVHA7y+KXJIg1dG05fUWVW+6t3H6O7bj1JDit7SNzIzlRKFT97AZD+UfcNI+SI8vYd
         Jjr1NTIQvU8MItKR60b7b/lXnuao5PpraW4iIJjuwbBut9orjJUmK4jok4kYOmpWqHFg
         WciA==
X-Gm-Message-State: AOJu0Yy18GXojL8U4bZJgqw58bFg3m77XqAz1sCV5U5F32EZWIjPYGBJ
	Z0rX1ysg5N5gVxy/g/pQkOFbCGNjDDyv45LrAgY8dMnwETExHcmK
X-Google-Smtp-Source: AGHT+IHu6QxNqFmdW+7H+WraW1Eyynq0iBKN4KUMQ1uJftnLW0BdFScxR57nlk1ISy8h6On0wKc4Vw==
X-Received: by 2002:a05:6512:3c8c:b0:50e:e5be:af8d with SMTP id h12-20020a0565123c8c00b0050ee5beaf8dmr2292326lfv.25.1705944947362;
        Mon, 22 Jan 2024 09:35:47 -0800 (PST)
Received: from pc636 (host-90-235-23-195.mobileonline.telia.com. [90.235.23.195])
        by smtp.gmail.com with ESMTPSA id a25-20020ac25e79000000b0050ffb24cf99sm436374lfr.101.2024.01.22.09.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:35:46 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 22 Jan 2024 18:35:44 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Za6ncL59KPy3nuDF@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
 <8edf32ff-ea10-43f3-8820-b67f1691bad2@paulmck-laptop>
 <ZafHa37MS_eYMEr6@pc636>
 <0280b920-65d0-4b95-ba5c-f533bc18d036@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0280b920-65d0-4b95-ba5c-f533bc18d036@paulmck-laptop>

On Fri, Jan 19, 2024 at 07:24:28AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 17, 2024 at 01:26:19PM +0100, Uladzislau Rezki wrote:
> > > > +/*
> > > > + * There are three lists for handling synchronize_rcu() users.
> > > > + * A first list corresponds to new coming users, second for users
> > > > + * which wait for a grace period and third is for which a grace
> > > > + * period is passed.
> > > > + */
> > > > +static struct sr_normal_state {
> > > > +	struct llist_head srs_next;	/* request a GP users. */
> > > > +	struct llist_head srs_wait;	/* wait for GP users. */
> > > > +	struct llist_head srs_done;	/* ready for GP users. */
> > > > +
> > > > +	/*
> > > > +	 * In order to add a batch of nodes to already
> > > > +	 * existing srs-done-list, a tail of srs-wait-list
> > > > +	 * is maintained.
> > > > +	 */
> > > > +	struct llist_node *srs_wait_tail;
> > > > +} sr;
> > > 
> > > Please put this in the rcu_state structure.  Having the separate structure
> > > is fine (it does group the fields nicely, plus you can take a pointer
> > > to it in the functions using this state), but it is good to have the
> > > state in one place.
> > > 
> > > Also, please add the data structures in a separate patch.  This might
> > > save someone a lot of time and effort should someone breaks the kernel
> > > in a way that depends on data-structure size.  It would be much easier
> > > for us if their bisection converged on the commit that adds the data
> > > structures instead of the commit that also adds a lot of code.
> > > 
> > I put the data under rcu_state in the patch-3 in this series. But i can
> > create a separate patch for this purpose. Should i split it or not?
> 
> Bisection is best if the data-structure changes come first, keeping in
> mind the example where the change in data size triggers some unrelated
> bug.  Better to have that bisection converge on a data-structure only
> commit than on a more complex commit.
> 
> So it would be much better if the data started out in rcu_state.
> 
OK. Then i will also combine two patches into one:

rcu: Improve handling of synchronize_rcu() users
rcu: Reduce synchronize_rcu() latency

to reduce the mess.

> > > > +	/* Finally. */
> > > > +	complete(&rs->completion);
> > > > +}
> > > > +
> > > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > +{
> > > > +	struct llist_node *done, *rcu, *next;
> > > > +
> > > > +	done = llist_del_all(&sr.srs_done);
> > > > +	if (!done)
> > > > +		return;
> > > > +
> > > > +	llist_for_each_safe(rcu, next, done)
> > > > +		rcu_sr_normal_complete(rcu);
> > > > +}
> > > > +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> > > 
> > > Why not put this into the sr_normal_state structure?  You can use
> > > __WORK_INITIALIZER() to initialize it, as is done in a number of other
> > > places in the kernel.
> > > 
> > It is not a big problem. I can move it under "rcu_state" also!
> 
> Very good, thank you!
> 
> > > > +/*
> > > > + * Helper function for rcu_gp_cleanup().
> > > > + */
> > > > +static void rcu_sr_normal_gp_cleanup(void)
> > > > +{
> > > > +	struct llist_node *head, *tail;
> > > > +
> > > > +	if (llist_empty(&sr.srs_wait))
> > > > +		return;
> > > > +
> > > > +	tail = READ_ONCE(sr.srs_wait_tail);
> > > > +	head = __llist_del_all(&sr.srs_wait);
> > > > +
> > > > +	if (head) {
> > > > +		/* Can be not empty. */
> > > > +		llist_add_batch(head, tail, &sr.srs_done);
> > > > +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > > > +	}
> > > > +}
> > > > +
> > > > +/*
> > > > + * Helper function for rcu_gp_init().
> > > > + */
> > > > +static void rcu_sr_normal_gp_init(void)
> > > > +{
> > > > +	struct llist_node *head, *tail;
> > > > +
> > > > +	if (llist_empty(&sr.srs_next))
> > > > +		return;
> > > > +
> > > > +	tail = llist_del_all(&sr.srs_next);
> > > > +	head = llist_reverse_order(tail);
> > > 
> > > Again, reversing the order is going to cause trouble on large systems.
> > > Let's please not do that.  (I could have sworn that this was not present
> > > in the last series...)
> > > 
> > > > +	/*
> > > > +	 * A waiting list of GP should be empty on this step,
> > > > +	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > > +	 * rolls it over. If not, it is a BUG, warn a user.
> > > > +	 */
> > > > +	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > > > +
> > > > +	WRITE_ONCE(sr.srs_wait_tail, tail);
> > > > +	__llist_add_batch(head, tail, &sr.srs_wait);
> > > > +}
> > > > +
> > > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > +{
> > > > +	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Initialize a new grace period.  Return false if no grace period required.
> > > >   */
> > > > @@ -1456,6 +1556,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> > > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > >  	rcu_seq_start(&rcu_state.gp_seq);
> > > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > +	rcu_sr_normal_gp_init();
> > > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > > @@ -1825,6 +1926,9 @@ static noinline void rcu_gp_cleanup(void)
> > > >  	}
> > > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > >  
> > > > +	// Make synchronize_rcu() users aware of the end of old grace period.
> > > > +	rcu_sr_normal_gp_cleanup();
> > > > +
> > > >  	// If strict, make all CPUs aware of the end of the old grace period.
> > > >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> > > >  		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > > @@ -3561,6 +3665,38 @@ static int rcu_blocking_is_gp(void)
> > > >  	return true;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Helper function for the synchronize_rcu() API.
> > > > + */
> > > > +static void synchronize_rcu_normal(void)
> > > > +{
> > > > +	struct rcu_synchronize rs;
> > > > +
> > > > +	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> > > > +		wait_rcu_gp(call_rcu_hurry);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	init_rcu_head_on_stack(&rs.head);
> > > > +	init_completion(&rs.completion);
> > > > +
> > > > +	/*
> > > > +	 * This code might be preempted, therefore take a GP
> > > > +	 * snapshot before adding a request.
> > > > +	 */
> > > > +	if (IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP))
> > > > +		rs.head.func = (void *) get_state_synchronize_rcu();
> > > > +
> > > > +	rcu_sr_normal_add_req(&rs);
> > > > +
> > > > +	/* Kick a GP and start waiting. */
> > > > +	(void) start_poll_synchronize_rcu();
> > > 
> > > It is unfortunate that the debugging requires an extra timestamp.
> > > The ways I can think of to avoid this have problems, though.  If this
> > > thing was replicated per leaf rcu_node structure, the usual approach
> > > would be to protect it with that structure's ->lock.
> > > 
> > Hmm.. a per-node approach can be deployed later. As discussed earlier :)
> 
> Agreed!
> 
> > Debugging part i do not follow, could you please elaborate a bit?
> 
> Let's not worry about this unless and until we need per-rcu_node lists
> of tasks waiting on grace periods.  At that point, we will know more
> and things will be more clear.
> 
Good and thank you :)

--
Uladzislau Rezki

