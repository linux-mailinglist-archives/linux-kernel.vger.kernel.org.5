Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7CE77A2FD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHLU7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHLU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:59:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96029171F;
        Sat, 12 Aug 2023 13:59:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcf2de59cso408567266b.0;
        Sat, 12 Aug 2023 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691873951; x=1692478751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fpHAAfOIYw8Q2A8VCNevqqdkg9pCoMX8n/hYuxW/Mg=;
        b=BTxTvNPwwlvM3rb9XC30PKPegmtCkLgJryDe1V2K1UMvC3HEbGIpP19jNS+YWmDZob
         Dg5krXQaLQdISaS8xM8bEpQRRdpn1U103N9z6jRHqEVaSiShU+3bbeqyQjX8zgigJWVI
         etrpjkEHdqfULC6YaM9GBOcJsFeJ740TIQTiJ8vAPWOtDZXXtjF67xNme2fxmzKrr+BA
         WvJpVzf0ZNGp98Fyqk73fBhzQomrjfF2Tt2mZ5Qnwo+pbWd8fwSqaKtdd+hVtOzZ653B
         lCkao2reT4lWG7zql7JzCQOobvj+wG7z64Y+pwe6RsnvVvYUCIoLDqyybtFGzRnc6WqK
         QAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691873951; x=1692478751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fpHAAfOIYw8Q2A8VCNevqqdkg9pCoMX8n/hYuxW/Mg=;
        b=SiNEQEGJWX3jJ93cgb9B10QoU/7yr8+pr03dsCEWfqTUVavWLINuam7RddupjP/wKL
         eL3Kwh1ni1RaNswLLkeF2ClzQTPBcaweV2Yfhj6UWrLJgCsZWJ06hfYV2ZiMCylkwEUl
         esqn6Z7Cp2O1ZH5oMNmM40GLjkQBw2fmq95RUz+4T2Q3DUHbfx8OsMZVh83Nxvf0cQ3z
         N/T4PEHUEHpBQUmYQldNvuSIB/p0j6Wd0IaRqyGzT8BiQgdp8HMqlzKiAniwRvy86Qnl
         4YuI2UstoiCIcVQHs+RcjTUww8rAptEDUxcnLKMGCEermdarb5mDJnjm3xc7JC7d7X96
         cqWQ==
X-Gm-Message-State: AOJu0YxBAOw22K2YzWJxQqBTvmcaM1JfoNW5wfg1voWKDvw10zCVmFEV
        XCLBnGrRdUCAeGOv9G8vs0U=
X-Google-Smtp-Source: AGHT+IFiHXaQXywYSkgx4QRnIVWokNlo+ZVMnMnTKejM7qHuqHLGFruSM2p1qd9lxfDTxFuSmnKVlA==
X-Received: by 2002:a17:906:73d5:b0:99b:4bab:2838 with SMTP id n21-20020a17090673d500b0099b4bab2838mr4487291ejl.0.1691873950882;
        Sat, 12 Aug 2023 13:59:10 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qc1-20020a170906d8a100b0099d9bc9bfd9sm499016ejb.48.2023.08.12.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 13:59:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id DD1AA27C0054;
        Sat, 12 Aug 2023 16:59:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 12 Aug 2023 16:59:08 -0400
X-ME-Sender: <xms:nPLXZDO5KxwrjezqxRrtmLLJmvlcMqHFREgqayCnjx9BjJiEFLS88Q>
    <xme:nPLXZN_I-4Pa44ZSMMxPT4e14hpQL6pnguZRGGead-MdjXSdd1Ax-Zkb-vwmkVPah
    xk8RzezpXFyD0F3aA>
X-ME-Received: <xmr:nPLXZCQ5oe_2SSC5IJVhtG9ctgparMCKN9mEpkTnPGpcCPP1Rl6segfYvVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:nPLXZHsYDwuuzxwrOfCNPTsndb7mV5Yu4b2Vw4Dvs4d9lXJoqzCXoA>
    <xmx:nPLXZLeyE72VeEsvI8tCfweP_2LQzT_dULbSvJI_UXUnfzL1UJMz1Q>
    <xmx:nPLXZD0ejid6D2Yj5_S2jfycUA1dGVWY_3yREIUkF_B-2oqDEUVqdg>
    <xmx:nPLXZC6fKxTV-MlpfzYL45T7lWL1bpYob6HSImfib5HP1eccqbYpvw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Aug 2023 16:59:07 -0400 (EDT)
Date:   Sat, 12 Aug 2023 13:58:58 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] bcachefs: six locks: Fix missing barrier on
 wait->lock_acquired
Message-ID: <ZNfykqAGhT6RT8BH@boqun-archlinux>
References: <20230812192720.2703874-1-kent.overstreet@linux.dev>
 <ZNfkaqfGwM8fIG7q@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNfkaqfGwM8fIG7q@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:58:34PM -0700, Boqun Feng wrote:
> On Sat, Aug 12, 2023 at 03:27:20PM -0400, Kent Overstreet wrote:
> > Six locks do lock handoff via the wakeup path: the thread doing the
> > wakeup also takes the lock on behalf of the waiter, which means the
> > waiter only has to look at its waitlist entry, and doesn't have to touch
> > the lock cacheline while another thread is using it.
> > 
> > Linus noticed that this needs a real barrier, which this patch fixes.
> > 
> > Also add a comment for the should_sleep_fn() error path.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: linux-bcachefs@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  fs/bcachefs/six.c | 33 +++++++++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
> > index 581aee565e..b6ca53c852 100644
> > --- a/fs/bcachefs/six.c
> > +++ b/fs/bcachefs/six.c
> > @@ -223,14 +223,16 @@ static void __six_lock_wakeup(struct six_lock *lock, enum six_lock_type lock_typ
> >  		if (ret <= 0)
> >  			goto unlock;
> >  
> > -		__list_del(w->list.prev, w->list.next);
> >  		task = w->task;
> > +		__list_del(w->list.prev, w->list.next);
> >  		/*
> > -		 * Do no writes to @w besides setting lock_acquired - otherwise
> > -		 * we would need a memory barrier:
> > +		 * The release barrier here ensures the ordering of the
> > +		 * __list_del before setting w->lock_acquired; @w is on the
> > +		 * stack of the thread doing the waiting and will be reused
> > +		 * after it sees w->lock_acquired with no other locking:
> > +		 * pairs with smp_load_acquire() in six_lock_slowpath()
> >  		 */
> > -		barrier();
> > -		w->lock_acquired = true;
> > +		smp_store_release(&w->lock_acquired, true);
> >  		wake_up_process(task);

Given the whole percpu counters for readers thing is similar to
percpu_rw_semaphore, I took a look at percpu_rwsem and wonder there is
a path to combine that with SIX lock. And that makes me realize another
fix may be needed here, considering the following case:

	Task A					Task B
	======					======
	__six_lock_wakeup():
	  task = w->task;
	  ...
	  smp_store_release(&w->locked_acquire, true);
	  					six_lock_slowpath():
						  while (1) {
						    if (smp_load_acquire(->lock_acquired))
						      break;
						  }

						six_unlock();
						do_exit(); // Task B ends its life :(

	  wake_up_process(task); // @task is a dangling task pointer!!!

Looks like get_task_struct() and put_task_struct() are needed here:
similar to percpu_rwsem_wake_function().

[Copy Peter as well]

Regards,
Boqun

> >  	}
> >  
> > @@ -502,17 +504,32 @@ static int six_lock_slowpath(struct six_lock *lock, enum six_lock_type type,
> >  	while (1) {
> >  		set_current_state(TASK_UNINTERRUPTIBLE);
> >  
> > -		if (wait->lock_acquired)
> > +		/*
> > +		 * Ensures that writes to the waitlist entry happen after we see
> 
> Maybe my English, but "happen after" here is a little confusing: writes
> happen after the read of ->lock_acquired? How about
> 
> 		/*
> 		 * Ensures once we observe the write to
> 		 * wait->lock_acquired, we must observe the writes to
> 		 * the waitlist entry: pairs with smp_store_release in
> 		 * __six_lock_wakeup
> 		 */
> 
> ?
> 
> I haven't finished my review on the SIX lock, but this patch looks good
> to me, feel free to add:
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Regards,
> Boqun
> 
> > +		 * wait->lock_acquired: pairs with the smp_store_release in
> > +		 * __six_lock_wakeup
> > +		 */
> > +		if (smp_load_acquire(&wait->lock_acquired))
> >  			break;
> >  
> >  		ret = should_sleep_fn ? should_sleep_fn(lock, p) : 0;
> >  		if (unlikely(ret)) {
> > +			bool acquired;
> > +
> > +			/*
> > +			 * If should_sleep_fn() returns an error, we are
> > +			 * required to return that error even if we already
> > +			 * acquired the lock - should_sleep_fn() might have
> > +			 * modified external state (e.g. when the deadlock cycle
> > +			 * detector in bcachefs issued a transaction restart)
> > +			 */
> >  			raw_spin_lock(&lock->wait_lock);
> > -			if (!wait->lock_acquired)
> > +			acquired = wait->lock_acquired;
> > +			if (!acquired)
> >  				list_del(&wait->list);
> >  			raw_spin_unlock(&lock->wait_lock);
> >  
> > -			if (unlikely(wait->lock_acquired))
> > +			if (unlikely(acquired))
> >  				do_six_unlock_type(lock, type);
> >  			break;
> >  		}
> > -- 
> > 2.40.1
> > 
