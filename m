Return-Path: <linux-kernel+bounces-92012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21F8719AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A0DB21024
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7352F8E;
	Tue,  5 Mar 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICLDQrvL"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB24CB58;
	Tue,  5 Mar 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631319; cv=none; b=lyrus1oR7rIjRTsO9EyqMhdLcqV5EOeHj+3TRMfHAChuXRoby1oVCjkSi0RJ9X+27iUp8cu4UcnAc+GWqw7b16Ks+4h4SjCPm6/m4Od4fOj8+6uU5b5RP7smSOY01aS4SqjXU/et/JvbC/TGkTItDzQi5Vei3iMMpkV6FTIS1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631319; c=relaxed/simple;
	bh=EegVnesyloT2OmMdsIm7xlomlETc9h4Ky9HGMhp0VGE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJgcR8VZJpdP2y3OMTYfveEcBkBuBOm9s2apEPlpdXzEvG3jyQeWwCdlou+G10kIsy+nql/YXdyWDfqWZ/uvO5YoQgqZjS/QCw0ZIKlWestHa0/sfnc7CVz3HFa2UfaMhCWMmKfFdtjF4GMzISVPVrXZqf6TyKYFomgxIbjwihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICLDQrvL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51320ca689aso6548988e87.2;
        Tue, 05 Mar 2024 01:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709631316; x=1710236116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=buT7TxdGJnGtlcKHmU5wFYa7vYmMveKXoNOjPHY22Wc=;
        b=ICLDQrvLqnwxm0N98Q7zT/BWIYHanaYd2nzBm622CPVbZUzNf0/9s2dyXdtnaIQuyQ
         nstyPgATGSwOfRy8QVuXuaIXAQFIyB/IbvJoy19V/SC/1Kxe/uJifEBgl9vRCh01kHuS
         YkClI4f4xrqTQ5KyKiuRKfWMVja9Dr17+gr8Tm5qo4j0mrD0t2CFaSQ2s27yfAudM/gd
         vY8DCwgdz7XtXBanrO+7C+FAbfxjjpI6mJJGzCSid0oNYj8379u0OB4qT7pz5/rorY3g
         RYtvmZprd9tkgRsuRDEds+IAghWxDKPG0sCsrpsxAMUEKGcsdx+lIuk2D+kXjKL2HeKg
         0cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631316; x=1710236116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buT7TxdGJnGtlcKHmU5wFYa7vYmMveKXoNOjPHY22Wc=;
        b=pkMmTUFemhgbT1Xpli7r9B91OkzlYRFaTQAV/hYwcD1+/rT68qTeuAgFl69oleYIdu
         573gv792X6+SOPnSCC6oWAb8Vx6NP22n1G2/5hcUyLAE8mnq9D/J2Gqdgl0qQmTIUt5g
         DGJ04IttO2kp5PRYyI6MSgMFPEnt0l8HjrD7oir5SgdsPKDWho8Tftzfnvo1GRAJdvw9
         uUl6tOKKgWfNj1kRTeNfZ8D9fLIJVXqNGcs3EesPHRJZsfdS2zZfK80FI26Te+wANpuR
         /vHgPBRz462jusEn0OK42umnFWyHo0WQJ/U2wf3q3DyUM9vn7AlatXsqVDtaAlQphOYU
         s/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk0DdKFL0fYa5ct9JjTyOlc28f1bcBCTNC7my0RqR3EK4CMUH3fE49s0skbEjUF+yeczi7t7ETqimCIcdK4I+qgRSc70dJ0ai8GJOeimKKA03rF4rYdHkkCodU7hcDBrLd
X-Gm-Message-State: AOJu0YyL2dJzv7nii1cHJE6yXUl82HOm5cDuHi9bsCG+XuNRvj/l0pJm
	2SOtgWd92aiuNBhM5H6Ug2ETNL+XWH/e4nH2LPD2PJVwpZAJBxkW
X-Google-Smtp-Source: AGHT+IF+cgHPzTGX3OddShpQ0QNjL8qogLemASKdKBzEKiJT8a8X1oQY+54r/a88EFfyRpxQV+EORg==
X-Received: by 2002:a05:6512:2102:b0:512:e1e3:792f with SMTP id q2-20020a056512210200b00512e1e3792fmr850390lfr.3.1709631315460;
        Tue, 05 Mar 2024 01:35:15 -0800 (PST)
Received: from pc636 (host-90-235-1-20.mobileonline.telia.com. [90.235.1.20])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25bd0000000b005131c9b1aa8sm2118698lfn.82.2024.03.05.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:35:14 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 5 Mar 2024 10:35:12 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZebnUI2zFbgCDnf7@pc636>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
 <ZeW2w08WZo4yapQp@localhost.localdomain>
 <ZeX1cXWKv2kirDXg@pc638.lan>
 <aa431a31-e9a3-4a6c-b2a7-f0e09794ca4c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa431a31-e9a3-4a6c-b2a7-f0e09794ca4c@paulmck-laptop>

On Mon, Mar 04, 2024 at 12:07:43PM -0800, Paul E. McKenney wrote:
> On Mon, Mar 04, 2024 at 05:23:13PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 04, 2024 at 12:55:47PM +0100, Frederic Weisbecker wrote:
> > > Le Wed, Feb 28, 2024 at 07:04:21PM +0100, Uladzislau Rezki a écrit :
> > > > On Tue, Feb 27, 2024 at 12:07:32AM +0100, Frederic Weisbecker wrote:
> > > > > On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > > > +{
> > > > > > +	struct llist_node *done, *rcu, *next, *head;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * This work execution can potentially execute
> > > > > > +	 * while a new done tail is being updated by
> > > > > > +	 * grace period kthread in rcu_sr_normal_gp_cleanup().
> > > > > > +	 * So, read and updates of done tail need to
> > > > > > +	 * follow acq-rel semantics.
> > > > > > +	 *
> > > > > > +	 * Given that wq semantics guarantees that a single work
> > > > > > +	 * cannot execute concurrently by multiple kworkers,
> > > > > > +	 * the done tail list manipulations are protected here.
> > > > > > +	 */
> > > > > > +	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > > > +	if (!done)
> > > > > > +		return;
> > > > > > +
> > > > > > +	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > > > > > +	head = done->next;
> > > > > > +	done->next = NULL;
> > > > > 
> > > > > Can the following race happen?
> > > > > 
> > > > > CPU 0                                                   CPU 1
> > > > > -----                                                   -----
> > > > > 
> > > > > // wait_tail == HEAD1
> > > > > rcu_sr_normal_gp_cleanup() {
> > > > >     // has passed SR_MAX_USERS_WAKE_FROM_GP
> > > > >     wait_tail->next = next;
> > > > >     // done_tail = HEAD1
> > > > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > > >     queue_work() {
> > > > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > > > >         __queue_work()
> > > > >     }
> > > > > }
> > > > > 
> > > > >                                                       set_work_pool_and_clear_pending()
> > > > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > > > > // new GP, wait_tail == HEAD2
> > > > > rcu_sr_normal_gp_cleanup() {
> > > > >     // executes all completion, but stop at HEAD1
> > > > >     wait_tail->next = HEAD1;
> > > > >     // done_tail = HEAD2
> > > > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > > >     queue_work() {
> > > > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > > > >         __queue_work()
> > > > >     }
> > > > > }
> > > > >                                                           // done = HEAD2
> > > > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > >                                                           // head = HEAD1
> > > > >                                                           head = done->next;
> > > > >                                                           done->next = NULL;
> > > > >                                                           llist_for_each_safe() {
> > > > >                                                               // completes all callbacks, release HEAD1
> > > > >                                                           }
> > > > >                                                       }
> > > > >                                                       // Process second queue
> > > > >                                                       set_work_pool_and_clear_pending()
> > > > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > > > >                                                           // done = HEAD2
> > > > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > > 
> > > > > // new GP, wait_tail == HEAD3
> > > > > rcu_sr_normal_gp_cleanup() {
> > > > >     // Finds HEAD2 with ->next == NULL at the end
> > > > >     rcu_sr_put_wait_head(HEAD2)
> > > > >     ...
> > > > > 
> > > > > // A few more GPs later
> > > > > rcu_sr_normal_gp_init() {
> > > > >      HEAD2 = rcu_sr_get_wait_head();
> > > > >      llist_add(HEAD2, &rcu_state.srs_next);
> > > > >                                                           // head == rcu_state.srs_next
> > > > >                                                           head = done->next;
> > > > >                                                           done->next = NULL;
> > > > >                                                           llist_for_each_safe() {
> > > > >                                                               // EXECUTE CALLBACKS TOO EARLY!!!
> > > > >                                                           }
> > > > >                                                       }
> > > > Looks like that. To address this, we should not release the head in the GP
> > > > > kthread.
> > > 
> > > But then you have to unconditionally schedule the work, right? Otherwise the
> > > HEADs are not released. And that means dropping this patch (right now I don't
> > > have a better idea).
> > >
> > The easiest way is to drop the patch. To address it we can go with:
> > 
> > <snip>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 31f3a61f9c38..9aa2cd46583e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1661,16 +1661,8 @@ static void rcu_sr_normal_gp_cleanup(void)
> >  	 * wait-head is released if last. The worker is not kicked.
> >  	 */
> >  	llist_for_each_safe(rcu, next, wait_tail->next) {
> > -		if (rcu_sr_is_wait_head(rcu)) {
> > -			if (!rcu->next) {
> > -				rcu_sr_put_wait_head(rcu);
> > -				wait_tail->next = NULL;
> > -			} else {
> > -				wait_tail->next = rcu;
> > -			}
> > -
> > +		if (rcu_sr_is_wait_head(rcu))
> >  			break;
> > -		}
> >  
> >  		rcu_sr_normal_complete(rcu);
> >  		// It can be last, update a next on this step.
> > <snip>
> > 
> > i.e. the process of users from GP is still there. The work is triggered
> > to perform a final complete(if there are users) + releasing wait-heads
> > so we do not race anymore.
> > 
> > I am OK with both cases. Dropping the patch will make it more simple
> > for sure.
> 
> Please feel free to repost a fixed-up patch series.  I can easily replace
> the commits currently in -rcu with new ones.  Just let me know.
> 
I will submit a fix patch for the race also i will submit a patch
related to switching to our own wq. that will have WQ_MEM_RECLAIM
flag.

--
Uladzislau Rezki

