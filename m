Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4A799A6C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjIISYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjIISYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:24:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B41B1;
        Sat,  9 Sep 2023 11:24:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99357737980so376571666b.2;
        Sat, 09 Sep 2023 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283855; x=1694888655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jYkVVzxchQ/jvYzUJH0KXfajovzBr8JajkB6P5mHS8=;
        b=UXespIooOrtN4iEPxbs6t8dByE41nn14FfX116EONWPRtKUe+jn+SXa7taUJZDQZFI
         lOa0ov45AjUJC4MBSB4OgZT8VIDCROfEiqpKv0BQHXAokZLP/tE/HYYvsh6GnkFBhdrp
         Rdg42hTIUJWVWGNcDxvojkykjNdNmkSVznMxdr2VfqFP/TTRwcYt/7ee4SIHevc+FQ4g
         mzKqNLqGbSmkhWAIQ7MqrDz/NG7iyyCn+POBz7n1A1wXkFmvW3dr5sDX9JtOj8LgW6W0
         sbuqHlwqNLaNjmlHPGi5mJm0ToQE1tQZHUWtnPQSpdsuQCN/fx/Yz1aA+440O3EDZk1j
         /VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283855; x=1694888655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jYkVVzxchQ/jvYzUJH0KXfajovzBr8JajkB6P5mHS8=;
        b=KQdTIh3FyVBa9T606BOREtNzNcayIH+bDcqyJQH95THf7tFKgCcsIsfePkglsldVmu
         RBc6c+L7BzIAKpgoccqQ1ghfHpwvM6Jah1KXn1gS61lFQkFrq5ZGSBEptPw0Zsj/xWR9
         xOAYLSOaB8pBNOH/iaJNi3SjuCt05hkp+EBGLjYolE5TGHEQ6s4Uhp2Hj5kDpAma85iV
         pmX8k1ViQ55wvTZFv9EarHCZyLPe1GZZpmPlud0x0uoOpA+tewfKqa2agb2f0IbekuYh
         vctz09qscHFYwj3bVOgKcvu1noIzw64L0DaWuaE5BTwqo7DgTWbNRDdKGtnOalNyALWM
         tyBQ==
X-Gm-Message-State: AOJu0YzotTEk84aUByOGZ2qX5HFP2ed+1AXhR0EuEH6ThJDpThZfs6Rd
        X81Z5+t/fIZCt2bOqbGW0Uk=
X-Google-Smtp-Source: AGHT+IEpNUcH3+mmN1ltcg3wFOHvJNTJFOq3QX7cp8abBc/6YEvWbaTa+08LJ4bI1TPCZAaaFIkYjw==
X-Received: by 2002:a17:906:1011:b0:9a2:2635:daa8 with SMTP id 17-20020a170906101100b009a22635daa8mr4536000ejm.56.1694283854840;
        Sat, 09 Sep 2023 11:24:14 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o21-20020a1709062e9500b0099ddc81903asm2645374eji.221.2023.09.09.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:24:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 614BF27C0054;
        Sat,  9 Sep 2023 14:24:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 09 Sep 2023 14:24:12 -0400
X-ME-Sender: <xms:TLj8ZIuB3K6hJoRprOH4j08nQ8s2zh9MthksoiQEv0ytOj0-ex2mlA>
    <xme:TLj8ZFcmYM6X6PtZVcVXapp6icKyUFoC9XQUb0W_IAMlSsBqNLqsa9pgVxnkR4Nxe
    6tMXRdmP-KvaPv9-Q>
X-ME-Received: <xmr:TLj8ZDzV9gIl64i8iDq1bnNcFq6yx_nWDnfJjyV9y42yyalZSI10JZ2jllKZmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TLj8ZLMe4ObNP3lU5YUwE9q14QwbD6GW4DaBNqlIrhouBVuRITWp6Q>
    <xmx:TLj8ZI-oSWwLGFFPNrhuGOlnlvgCihTa7yrldPFpWBj_FIEaMqXpSQ>
    <xmx:TLj8ZDXbhy8f7HvKb73YMi7O3_leXH2JFR5XsGaiVL4aWmPx9soDTA>
    <xmx:TLj8ZIxfaZ1BzWr0Qo2Mja1Y-1r8RWpRADlcrtgaDiOUOhpoVsrUtQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 14:24:11 -0400 (EDT)
Date:   Sat, 9 Sep 2023 11:22:48 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: Re: [PATCH 04/10] rcu/nocb: Remove needless full barrier after
 callback advancing
Message-ID: <ZPy3-MS7uOJfmJhs@boqun-archlinux>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-5-frederic@kernel.org>
 <20230909043125.GA3920383@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909043125.GA3920383@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 04:31:25AM +0000, Joel Fernandes wrote:
> On Fri, Sep 08, 2023 at 10:35:57PM +0200, Frederic Weisbecker wrote:
> > A full barrier is issued from nocb_gp_wait() upon callbacks advancing
> > to order grace period completion with callbacks execution.
> > 
> > However these two events are already ordered by the
> > smp_mb__after_unlock_lock() barrier within the call to
> > raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
> > happen.
> > 
> > The following litmus test shows the kind of guarantee that this barrier
> > provides:
> > 
> > 	C smp_mb__after_unlock_lock
> > 
> > 	{}
> > 
> > 	// rcu_gp_cleanup()
> > 	P0(spinlock_t *rnp_lock, int *gpnum)
> > 	{
> > 		// Grace period cleanup increase gp sequence number
> > 		spin_lock(rnp_lock);
> > 		WRITE_ONCE(*gpnum, 1);
> > 		spin_unlock(rnp_lock);
> > 	}
> > 
> > 	// nocb_gp_wait()
> > 	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
> > 	{
> > 		int r1;
> > 
> > 		// Call rcu_advance_cbs() from nocb_gp_wait()
> > 		spin_lock(nocb_lock);
> > 		spin_lock(rnp_lock);
> > 		smp_mb__after_unlock_lock();
> > 		r1 = READ_ONCE(*gpnum);
> > 		WRITE_ONCE(*cb_ready, 1);
> > 		spin_unlock(rnp_lock);
> > 		spin_unlock(nocb_lock);
> > 	}
> > 
> > 	// nocb_cb_wait()
> > 	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
> > 	{
> > 		int r2;
> > 
> > 		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
> > 		spin_lock(nocb_lock);
> > 		r2 = READ_ONCE(*cb_ready);
> > 		spin_unlock(nocb_lock);
> > 
> > 		// Actual callback execution
> > 		WRITE_ONCE(*cb_executed, 1);
> 
> So related to this something in the docs caught my attention under "Callback
> Invocation" [1]
> 
> <quote>
> However, if the callback function communicates to other CPUs, for example,
> doing a wakeup, then it is that function's responsibility to maintain
> ordering. For example, if the callback function wakes up a task that runs on
> some other CPU, proper ordering must in place in both the callback function
> and the task being awakened. To see why this is important, consider the top
> half of the grace-period cleanup diagram. The callback might be running on a
> CPU corresponding to the leftmost leaf rcu_node structure, and awaken a task
> that is to run on a CPU corresponding to the rightmost leaf rcu_node
> structure, and the grace-period kernel thread might not yet have reached the
> rightmost leaf. In this case, the grace period's memory ordering might not
> yet have reached that CPU, so again the callback function and the awakened
> task must supply proper ordering.
> </quote>
> 
> I believe this text is for non-nocb but if we apply that to the nocb case,
> lets see what happens.
> 
> In the litmus, he rcu_advance_cbs() happened on P1, however the callback is
> executing on P2. That sounds very similar to the non-nocb world described in
> the text where a callback tries to wake something up on a different CPU and
> needs to take care of all the ordering.
> 
> So unless I'm missing something (quite possible), P2 must see the update to
> gpnum as well. However, per your limus test, the only thing P2  does is
> acquire the nocb_lock. I don't see how it is guaranteed to see gpnum == 1.

Because P1 writes cb_ready under nocb_lock, and P2 reads cb_ready under
nocb_lock as well and if P2 read P1's write, then we know the serialized
order of locking is P1 first (i.e. the spin_lock(nocb_lock) on P2 reads
from the spin_unlock(nocb_lock) on P1), in other words:

(fact #1)

	unlock(nocb_lock) // on P1
	->rfe
	lock(nocb_lock) // on P2

so if P1 reads P0's write on gpnum

(assumption #1)

	W(gpnum)=1 // on P0
	->rfe
	R(gpnum)=1 // on P1

and we have

(fact #2)

	R(gpnum)=1 // on P1
	->(po; [UL])
	unlock(nocb_lock) // on P1

combine them you get

	W(gpnum)=1 // on P0
	->rfe           // fact #1
	->(po; [UL])    // fact #2
	->rfe           // assumption #1
	lock(nocb_lock) // on P2
	->([LKR]; po)
	M // any access on P2 after spin_lock(nocb_lock);

so
	W(gpnum)=1 // on P0
	->rfe ->po-unlock-lock-po
	M // on P2

and po-unlock-lock-po is A-culum, hence "->rfe ->po-unlock-lock-po" or
"rfe; po-unlock-lock-po" is culum-fence, hence it's a ->prop, which
means the write of gpnum on P0 propagates to P2 before any memory
accesses after spin_lock(nocb_lock)?

Of course, I haven't looked into the bigger picture here (whether the
barrier is for something else, etc.) ;-)

Regards,
Boqun

> I am curious what happens in your litmus if you read gpnum in a register and
> checked for it.
> 
> So maybe the memory barriers you are deleting need to be kept in place? Idk.
> 
> thanks,
> 
>  - Joel
> 
> [1] https://docs.kernel.org/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html#callback-invocation
> 
