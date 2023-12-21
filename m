Return-Path: <linux-kernel+bounces-8249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252481B46E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747D6B22637
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91596ABB5;
	Thu, 21 Dec 2023 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxIbWDFD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29D6ABA8;
	Thu, 21 Dec 2023 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e2d00f99cso805776e87.0;
        Thu, 21 Dec 2023 02:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155957; x=1703760757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXeJSWQttpNj1maCXyG2iZVXFgkKzJKf8+HIAsLW66g=;
        b=CxIbWDFD5ILr+d7IxufYk8YEuRNtrxdFVu1Q6isLZ8L0FVIO1TuC7o2eUNupVRWvb+
         /9bglVoE37uArFflUpBwWTG69Sh2fpFsD2S4AXU7kZBgD6ccvgmft07FgU0OSc5fJLD5
         KK6bon5dGdpNYUQQWU2EnAQ8EjGok2pTacQb4HbGsB1SKtH+lmLqNL3ueMHQUFZ25mzJ
         VwY6uUFDWlPOIoqoQ5pGnRbDmqxu1sGKzT3CId7X/Pf5+LYCVKDhFIMMMkjLTd3EVyRC
         blCnH4fOcpQlpPeeR0tL5gJeVI/W2GzRohvw+MaJ1pnGD649zGI27MWwMvTFcIDiIJKb
         Y4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155957; x=1703760757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXeJSWQttpNj1maCXyG2iZVXFgkKzJKf8+HIAsLW66g=;
        b=QeUvbEo3s87azdiYPaVYITKSU0qJ3UxIo0J8UNHe/yHF8Oyw5QsQnWxDtnECHrLjjY
         ZplLkzwc6Og1zZZfXPyXC6WKy/Jnxa2XFvBb33ptj5iGKCcXPkjJCMsthoZWLYRIrOZW
         XjtbKvU/CpGng36CEoYnP7emuyZGdtZL8wciUjiqm1AVLgInrhp7o8Zi6SDlEydLq5U6
         pUkopl38bWCTQzDtxFdYhnSzSU6E71HmklMolEQaB3PYqqET/D7kAj5emBI5mwltP/Ce
         XN4xpQgYt1Y8iZeA+1PgWcaWW8ZmPqXtzRuXpOlzHUR8aVGwQRzYlqbXmdue899IZl0n
         7A+g==
X-Gm-Message-State: AOJu0YzFc3LYXyUEXYWo9j3HereaJUEb+y7X4p5IuWaTMUpVqzubSbdT
	sjnINUnpHY2qPytq8/3Osw8=
X-Google-Smtp-Source: AGHT+IFCsY4zSd6nXYXHvSGYiO+Fc4mE4T0uJLXoQGdb4VRopAw06vaFmkc3v+Ww+4SA29aL7Dqf7g==
X-Received: by 2002:a05:6512:3a8:b0:50e:6328:26c4 with SMTP id v8-20020a05651203a800b0050e632826c4mr124395lfp.78.1703155956816;
        Thu, 21 Dec 2023 02:52:36 -0800 (PST)
Received: from pc636 (host-90-233-221-204.mobileonline.telia.com. [90.233.221.204])
        by smtp.gmail.com with ESMTPSA id g14-20020a0565123b8e00b0050e40a2bc97sm238542lfv.13.2023.12.21.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:52:36 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 21 Dec 2023 11:52:33 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <ZYQY8bB3zpywfBxO@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>

On Tue, Dec 19, 2023 at 05:37:56PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 28, 2023 at 09:00:30AM +0100, Uladzislau Rezki (Sony) wrote:
> > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > 
> > Currently, processing of the next batch of rcu_synchronize nodes
> > for the new grace period, requires doing a llist reversal operation
> > to find the tail element of the list. This can be a very costly
> > operation (high number of cache misses) for a long list.
> > 
> > To address this, this patch introduces a "dummy-wait-node" entity.
> > At every grace period init, a new wait node is added to the llist.
> > This wait node is used as wait tail for this new grace period.
> > 
> > This allows lockless additions of new rcu_synchronize nodes in the
> > rcu_sr_normal_add_req(), while the cleanup work executes and does
> > the progress. The dummy nodes are removed on next round of cleanup
> > work execution.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 
> This says that Uladzislau created the patch and that Neeraj
> acted as maintainer.  I am guessing that you both worked on it,
> in which case is should have the Co-developed-by tags as shown in
> Documentation/process/submitting-patches.rst.  Could you please update
> these to reflect the actual origin?
> 
Right. We both worked on it. Neeraj is an author whereas i should mark
myself as a Co-developed-by. This is a correct way. Thank you for
pointing on it!

>
> One question below toward the end.  There are probably others that I
> should be asking, but I have to start somewhere.  ;-)
> 
Good :)

> >  
> >  /*
> >   * Helper function for rcu_gp_init().
> >   */
> > -static void rcu_sr_normal_gp_init(void)
> > +static bool rcu_sr_normal_gp_init(void)
> >  {
> > -	struct llist_node *head, *tail;
> > +	struct llist_node *first;
> > +	struct llist_node *wait_head;
> > +	bool start_new_poll = false;
> >  
> > -	if (llist_empty(&sr.srs_next))
> > -		return;
> > +	first = READ_ONCE(sr.srs_next.first);
> > +	if (!first || rcu_sr_is_wait_head(first))
> > +		return start_new_poll;
> > +
> > +	wait_head = rcu_sr_get_wait_head();
> > +	if (!wait_head) {
> > +		// Kick another GP to retry.
> > +		start_new_poll = true;
> > +		return start_new_poll;
> > +	}
> >  
> > -	tail = llist_del_all(&sr.srs_next);
> > -	head = llist_reverse_order(tail);
> > +	/* Inject a wait-dummy-node. */
> > +	llist_add(wait_head, &sr.srs_next);
> >  
> >  	/*
> > -	 * A waiting list of GP should be empty on this step,
> > -	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > +	 * A waiting list of rcu_synchronize nodes should be empty on
> > +	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> >  	 * rolls it over. If not, it is a BUG, warn a user.
> >  	 */
> > -	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > +	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
> > +	sr.srs_wait_tail = wait_head;
> > +	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> >  
> > -	WRITE_ONCE(sr.srs_wait_tail, tail);
> > -	__llist_add_batch(head, tail, &sr.srs_wait);
> > +	return start_new_poll;
> >  }
> >  
> >  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > @@ -1493,6 +1684,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  	unsigned long mask;
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp = rcu_get_root();
> > +	bool start_new_poll;
> >  
> >  	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> >  	raw_spin_lock_irq_rcu_node(rnp);
> > @@ -1517,11 +1709,15 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> >  	rcu_seq_start(&rcu_state.gp_seq);
> >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > -	rcu_sr_normal_gp_init();
> > +	start_new_poll = rcu_sr_normal_gp_init();
> >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >  	raw_spin_unlock_irq_rcu_node(rnp);
> >  
> > +	// New poll request after rnp unlock
> > +	if (start_new_poll)
> > +		(void) start_poll_synchronize_rcu();
> 
> You lost me on this one.  Anything that got moved to the wait list
> should be handled by the current grace period, right?  Or is the
> problem that rcu_sr_normal_gp_init() is being invoked after the call
> to rcu_seq_start()?  If that is the case, could it be moved ahead so
> that we don't need the extra grace period?
> 
> Or am I missing something subtle here?
> 
The problem is that, we are limited in number of "wait-heads" which we
add as a marker node for this/current grace period. If there are more clients
and there is no a wait-head available it means that a system, the deferred
kworker, is slow in processing callbacks, thus all wait-nodes are in use.

That is why we need an extra grace period. Basically to repeat our try one
more time, i.e. it might be that a current grace period is not able to handle
users due to the fact that a system is doing really slow, but this is rather
a corner case and is not a problem.

--
Uladzislau Rezki

