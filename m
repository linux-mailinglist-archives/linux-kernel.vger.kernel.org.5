Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC17D722E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJYRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:18:11 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FE111;
        Wed, 25 Oct 2023 10:18:08 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7b91faf40so57005167b3.1;
        Wed, 25 Oct 2023 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698254288; x=1698859088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/uvOkwhxlEpkzDdPFhQxDSAIbTgXyeILVNw+kxFwq4=;
        b=UP6pDkdCV4was2SvMGbiTefza9yZ5KcGarGRScycs/w04j54BFI1DWgyqlWTr1oWba
         mciGjNvHezQ5YxYVBktmo+Nbr9+I+GpDzA52xx+uVifbeSGlAoPdfnwQT3IQhU0e9eZp
         knva3sh04M1oDEgpvt4AapfaMR3FXWswRp8zq7gy0dJYIkChAOM4Ky4LusUXBXZMvIKz
         qF3Zh5c+9T9M12QuVcRLrWx/1WB6W8IOvj48L0yt2g3RxjAvADZApyXkPTh9bpNlOhqJ
         X7htJkhMozGvlbgcKIFhSBF1BqYR9fAwPH7x88JcBPJKZFvm1NaeFH7RzpCDZx2mdBNu
         6p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698254288; x=1698859088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/uvOkwhxlEpkzDdPFhQxDSAIbTgXyeILVNw+kxFwq4=;
        b=rnuOwjSerxgn7JxWpONgkDXdXE9V9NdGJa/uHxI+j2++r9i7UP+WyTdSNwlMyTyUDa
         C7+56vaO4UMNIv9+808I5srFUb+Mo/tbL0NvdrkFjRsBNWww/SlF3/nicIs6KNVw5UFB
         9Ob0fmN/Axn5lynew4xhgFmT/ageUqagOCP1iEvHp5iBK45lONkopiZhhpVdBMYr0xED
         +/YBpKbcY1sjYKYYDLMyIHwa1HX4ZlSjc305BS7LcEivQYdq8zVuw+2CyiAXCSQTFQJd
         g2wbGve3E7r/3wIW/Tti2mOZwWOfae6kZzZcyJI09STBB+dfY8eCC/4vpUc9/WAfNdaT
         k9PA==
X-Gm-Message-State: AOJu0YyIJscQzYrCP8wg5wnipAWfFBT+hgB8UjQxDUKeookAGWlnM66n
        xFDF9u3m4YW6Mm8ZqdhfrLA=
X-Google-Smtp-Source: AGHT+IGgtUBJjDpdcpn94j2EDhiGSURlNcjaDyIDVmNUdwVVea2/754GCkqaKNr0vxpI0nr3Cz+c7g==
X-Received: by 2002:a25:d68c:0:b0:d9a:60c8:c5ff with SMTP id n134-20020a25d68c000000b00d9a60c8c5ffmr15314241ybg.65.1698254287660;
        Wed, 25 Oct 2023 10:18:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p20-20020a257414000000b00d9cb16d7749sm4587420ybc.21.2023.10.25.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:18:07 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8F4C527C0054;
        Wed, 25 Oct 2023 13:18:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 25 Oct 2023 13:18:06 -0400
X-ME-Sender: <xms:zU05ZWbsFnlpkY4KFibxZDFs-r_x1VAjT9RgFb3VlVQhcP4QjVfZ7Q>
    <xme:zU05ZZZnJNGfh-wHgECw4WXHLvfFWl4JatXMbF9rP5SjWbtDB39W4gGDr3a2RsZN-
    IY5RJII5H-K5og7QA>
X-ME-Received: <xmr:zU05ZQ83OUv7VLixvcvI9Hw1u9NdBZ5RpHqjXtxqOU6gjqVT0ynbS4E3uPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:zU05ZYpXi3eU_u35nadjKbyQPkB5r-CprRF04-3PyQnYChI-wiQyfg>
    <xmx:zU05ZRoGdrJ711ynPXw464RpTS46WNs_Rg9u19tNNlz8ALVpOtH5kg>
    <xmx:zU05ZWSRmrINNmfSqk9ytvjlxlS6wkSeTs0MWwJVwui3h7HR1V__NA>
    <xmx:zk05ZVcBcFYPR74NDKjUDgjwmUxcLTSLFpWrrQYmVoY3-uy0EcjEqA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 13:18:05 -0400 (EDT)
Date:   Wed, 25 Oct 2023 10:17:22 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTlNogQ_nWUzVJ9M@boqun-archlinux>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025140915.590390-2-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:09:13PM +0200, Uladzislau Rezki (Sony) wrote:
> A call to a synchronize_rcu() can be optimized from time point of
> view. Different workloads can be affected by this especially the
> ones which use this API in its time critical sections.
> 
> For example if CONFIG_RCU_NOCB_CPU is set, the wakeme_after_rcu()
> callback can be delayed and such delay depends on:
> 
> - where in a nocb list it is located;
> - how fast previous callbacks completed.
> 
> 1. On our Android devices i can easily trigger the scenario when
> it is a last in the list out of ~3600 callbacks:
> 

I wonder how many of the callbacks are queued via call_rcu_hurry()? If
not a lot, I wonder whether we can resolve the problem differently, see
below:

> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> <snip>
> 
> 2. We use cpuset/cgroup to classify tasks and assign them into
> different cgroups. For example "backgrond" group which binds tasks
> only to little CPUs or "foreground" which makes use of all CPUs.
> Tasks can be migrated between groups by a request if an acceleration
> is needed.
> 
> See below an example how "surfaceflinger" task gets migrated.
> Initially it is located in the "system-background" cgroup which
> allows to run only on little cores. In order to speed it up it
> can be temporary moved into "foreground" cgroup which allows
> to use big/all CPUs:
> 
> cgroup_attach_task():
>  -> cgroup_migrate_execute()
>    -> cpuset_can_attach()
>      -> percpu_down_write()
>        -> rcu_sync_enter()
>          -> synchronize_rcu()
>    -> now move tasks to the new cgroup.
>  -> cgroup_migrate_finish()
> 
> <snip>
>          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
>     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
>     PERFD-SERVER-1855    [000] d..1.  7030.530383: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
>    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> <snip>
> 
> "A moving time" depends on how fast synchronize_rcu() completes. See
> the first trace line. The migration has not occurred until the sync
> was done first. Please note, number of different callbacks to be
> invoked can be thousands.
> 
> 3. To address this drawback, maintain a separate track that consists
> of synchronize_rcu() callers only. The GP-kthread, that drivers a GP
> either wake-ups a worker to drain all list or directly wakes-up end
> user if it is one in the drain list.
> 

Late to the party, but I kinda wonder whether we can resolve it by:

1) either introduce a separate seglist that only contains callbacks
queued by call_rcu_hurry(), and whenever after an GP and callbacks are
ready, call_rcu_hurry() callbacks will be called first.

2) or make call_rcu_hurry() callbacks always inserted at the head of the
NEXT list instead of the tail, e.g. (untested code):

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index f71fac422c8f..89a875f8ecc7 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -338,13 +338,21 @@ bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
  * absolutely not OK for it to ever miss posting a callback.
  */
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
-			   struct rcu_head *rhp)
+			   struct rcu_head *rhp,
+			   bool is_lazy)
 {
 	rcu_segcblist_inc_len(rsclp);
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
-	rhp->next = NULL;
-	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
-	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
+	/* If hurry and the list is not empty, put it in the front */
+	if (!is_lazy && rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL) > 1) {
+		// hurry callback, queued at front
+		rhp->next = READ_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL]);
+		WRITE_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL], rhp);
+	} else {
+		rhp->next = NULL;
+		WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
+		WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
+	}
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 4fe877f5f654..459475bb8df9 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -136,7 +136,8 @@ struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
-			   struct rcu_head *rhp);
+			   struct rcu_head *rhp,
+			   bool is_lazy);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..53adf5ab9c9f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1241,7 +1241,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (rhp)
-		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
+		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp, true);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8d65f7d576a3..7dec7c68f88f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -362,7 +362,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	}
 	if (needwake)
 		rtpcp->urgent_gp = 3;
-	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
+	rcu_segcblist_enqueue(&rtpcp->cblist, rhp, true);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..e05cbff40dc7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2670,7 +2670,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
+	rcu_segcblist_enqueue(&rdp->cblist, head, lazy_in);
 	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,

Sure, there may be some corner cases I'm missing, but I think overall
this is better than (sorta) duplicating the logic of seglist (the llist
in sr_normal_state) or the logic of wake_rcu_gp()
(synchronize_rcu_normal).

Anyway, these are just if-you-have-time-to-try options ;-)

Regards,
Boqun

> 4. This patch improves the performance of synchronize_rcu() approximately
> by ~30% on synthetic tests. The real test case, camera launch time, shows
> below figures(time is in milliseconds):
> 
> 542 vs 489 diff: 9%
> 540 vs 466 diff: 13%
> 518 vs 468 diff: 9%
> 531 vs 457 diff: 13%
> 548 vs 475 diff: 13%
> 509 vs 484 diff: 4%
> 
> Synthetic test:
> 
> Hardware: x86_64 64 CPUs, 64GB of memory
> 
> - 60.000 tasks(simultaneous);
> - each task does(1000 loops)
>      synchronize_rcu();
>      kfree(p);
> 
> default: CONFIG_RCU_NOCB_CPU: takes 323 seconds to complete all users;
> patch: CONFIG_RCU_NOCB_CPU: takes 240 seconds to complete all users.
> 
> Please note, by default this functionality is OFF and the old way is
> still used instead, In order to activate it, please do:
> 
> echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
[...]
