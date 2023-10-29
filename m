Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F047DADA9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjJ2SWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2SWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:22:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCBBA;
        Sun, 29 Oct 2023 11:22:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778999c5ecfso281294985a.2;
        Sun, 29 Oct 2023 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698603729; x=1699208529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgXhkPzx3CnvmuM4CpdLBF1UrOKSG7jk+Nhr8VtDokc=;
        b=BdiM+Rwa1EQzhn5yuLHhIBtrzxtk0CXKxb2AwZm9o6llKY7QHR/ecKDS0OR2JMzXqW
         mEQYd7Ci5Rdq/2lyUkKkvu1F6nxZOvSXFaGAVRnjSoCD//EiZDnpCeBkjEdE1qWCEFIe
         5a8dL+WjxPO5fj7ecsensWHMIdAhOPl2eqnyY3502E7SyzrFmidv7PZJ1/4DBu8pAuEj
         7D/sUwyvhXPES1dN/g/EDZpmmHbx76Rm9fG9mXwELTcJBaGeOlSokYl8pvZ7eAXZCXqy
         0ZK0fRAILz6A+jX4RLQKLdwC8sqcWyUVfL3PiVhZFR0/6l0Xp6zPnnzAg3bAWpd5XuCJ
         n/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698603729; x=1699208529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgXhkPzx3CnvmuM4CpdLBF1UrOKSG7jk+Nhr8VtDokc=;
        b=QTB8h12sEGOkPuXdzvLn7dcC3MU9la5vi/M86m3otPyQVtT+Q/LZo63RU77hLQdR6S
         +db0OxIY73nEDc0wB+rvq2cM3o8bqWFx4x+AikhrPPPNeY15bgCiBv0bnvFta92He6QQ
         NvPNcUM0lqY++uRNNERVk/0tYTu6ZjFEXqKtst08DyKSXs4DdK9mcHFNYCU3Z9UnTuNU
         PrCDyYQVbwkMat0YW3U96VsgBkOFoY6kYs/wmlu9uQpQXZO3AtFBb/DDPtOkjnrRLYbw
         SuaGKrnULndMK/69WjRRir8uQlA5RX1n2g0/eR0tqWtN7RC2fDnFkBWcHXYgvGm6y4q6
         4pDA==
X-Gm-Message-State: AOJu0YzZOC+eDX6lfw9UkvTs6iP5wthlNSQiIqf197LI01JV6pEZEKqA
        De7OQwEmg2ozyWI6ZJaowJc=
X-Google-Smtp-Source: AGHT+IGL/NexDsSH54j2q6b0CYk72D5nYVmhMjmIpTOEkj2+dcKcMskYhUmMDvjKmUU2jVnVBssuEg==
X-Received: by 2002:a05:620a:408c:b0:770:f346:e9e8 with SMTP id f12-20020a05620a408c00b00770f346e9e8mr9131098qko.10.1698603729039;
        Sun, 29 Oct 2023 11:22:09 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c1-20020ae9e201000000b0077731466526sm2665230qkc.70.2023.10.29.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 11:22:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6A92927C0054;
        Sun, 29 Oct 2023 14:22:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 14:22:08 -0400
X-ME-Sender: <xms:z6I-ZSrv7v_9UjudArwwYDs06mcY4QJkJzozDb-_CphIlPq3WuK--g>
    <xme:z6I-ZQqtSdKJ7R-5D2aNKvpxy1mEd_n5hFJM5Mj9IqvtMi5AV_QrQyb3XhBMAWACh
    CPxxznzJ65xMJ-C-Q>
X-ME-Received: <xmr:z6I-ZXMBbuPtdyFIUGqpN5tF1wYmOrOzBMEO6xSo8bP86K659STKxCNyFdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:z6I-ZR5cCwDJ208sMUs_4e0A86Rkmlv6oCeRxprff6O4W1MDeYTRPA>
    <xmx:z6I-ZR7xhGUM486dtyL5acJAswcNU8ZuU6FAEKYcjSp5rORi4akxAg>
    <xmx:z6I-ZRg6ynYHPtLNDLOKF_ZnpaXAFO5kc7gKThmVrNSZsYQPcXBgzg>
    <xmx:0KI-ZbssvJr_d69G5__v1mlCzMOWi8Hm1fecniy77QWGg6d5j3LFSg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 14:22:07 -0400 (EDT)
Date:   Sun, 29 Oct 2023 11:21:11 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZT6ilzH0HQNFLb2Y@boqun-archlinux>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTlNogQ_nWUzVJ9M@boqun-archlinux>
 <ZTpk7gvIgdHioL3c@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpk7gvIgdHioL3c@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:09:02PM +0200, Uladzislau Rezki wrote:
[...]
> > Late to the party, but I kinda wonder whether we can resolve it by:
> > 
> > 1) either introduce a separate seglist that only contains callbacks
> > queued by call_rcu_hurry(), and whenever after an GP and callbacks are
> > ready, call_rcu_hurry() callbacks will be called first.
> > 
> > 2) or make call_rcu_hurry() callbacks always inserted at the head of the
> > NEXT list instead of the tail, e.g. (untested code):
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index f71fac422c8f..89a875f8ecc7 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -338,13 +338,21 @@ bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
> >   * absolutely not OK for it to ever miss posting a callback.
> >   */
> >  void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> > -			   struct rcu_head *rhp)
> > +			   struct rcu_head *rhp,
> > +			   bool is_lazy)
> >  {
> >  	rcu_segcblist_inc_len(rsclp);
> >  	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> > -	rhp->next = NULL;
> > -	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > -	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> > +	/* If hurry and the list is not empty, put it in the front */
> > +	if (!is_lazy && rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL) > 1) {
> > +		// hurry callback, queued at front
> > +		rhp->next = READ_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL]);
> > +		WRITE_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL], rhp);
> > +	} else {
> > +		rhp->next = NULL;
> > +		WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > +		WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> > +	}
> >  }
> >  
> >  /*
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index 4fe877f5f654..459475bb8df9 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -136,7 +136,8 @@ struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
> >  struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
> >  bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
> >  void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> > -			   struct rcu_head *rhp);
> > +			   struct rcu_head *rhp,
> > +			   bool is_lazy);
> >  bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
> >  			   struct rcu_head *rhp);
> >  void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 20d7a238d675..53adf5ab9c9f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1241,7 +1241,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  		sdp = raw_cpu_ptr(ssp->sda);
> >  	spin_lock_irqsave_sdp_contention(sdp, &flags);
> >  	if (rhp)
> > -		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> > +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp, true);
> >  	rcu_segcblist_advance(&sdp->srcu_cblist,
> >  			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> >  	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 8d65f7d576a3..7dec7c68f88f 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -362,7 +362,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >  	}
> >  	if (needwake)
> >  		rtpcp->urgent_gp = 3;
> > -	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
> > +	rcu_segcblist_enqueue(&rtpcp->cblist, rhp, true);
> >  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >  	if (unlikely(needadjust)) {
> >  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index cb1caefa8bd0..e05cbff40dc7 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2670,7 +2670,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> >  		return; // Enqueued onto ->nocb_bypass, so just leave.
> >  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > -	rcu_segcblist_enqueue(&rdp->cblist, head);
> > +	rcu_segcblist_enqueue(&rdp->cblist, head, lazy_in);
> >  	if (__is_kvfree_rcu_offset((unsigned long)func))
> >  		trace_rcu_kvfree_callback(rcu_state.name, head,
> >  					 (unsigned long)func,
> > 

Surprisingly, this survives from a whole rcutorture run ;-)

> > Sure, there may be some corner cases I'm missing, but I think overall
> > this is better than (sorta) duplicating the logic of seglist (the llist
> > in sr_normal_state) or the logic of wake_rcu_gp()
> > (synchronize_rcu_normal).
> > 
> > Anyway, these are just if-you-have-time-to-try options ;-)
> > 
> Hm.. You still mix callbacks and there is a dependency in order
> of execution. The callback process time also might be varied from
> one callback to another.
> 
> If you have many *_hurry() calls we end in the same situation. Apart

I plan to resolve that by only puting a call_rcu_hurry(wakeme_after_gp)
in the front of the list.

> of that we also have !CONFIG_RCU_NOCB_CPU path that is also covered
> by the patch that is in question.

I don't see why the above approach doesn't work for
!CONFIG_RCU_NOCB_CPU, but I maybe miss something here.

Do you have a benchmark I can try out to see if my diff can achieve the
similar result? Thanks!

Regards,
Boqun

> 
> --
> Uladzislau Rezki
