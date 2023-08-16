Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56677E2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbjHPNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbjHPNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:41:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612A2D73
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AvZJrYevqOe0SxYwi0hYlseZ1CJ5Fk5Gk4FXzqItAQs=; b=vXmofc+rGbDzLr/hZFbSG7KSKn
        k0/sVDjUeqSkKDigAbVCLKjKVRwul+jDZDOL4ptgVku3La6kd8YXnsAI5VzHDt8MUVChWiF+P4xy0
        5hfrOVIr58UeOD09g3kAop5HK7KpBJx0kICCmoAI8HxNFpYMGjTt16hSTg+1pb2ti5IPkJcQTH35x
        lbf6cJnj2He9l+M8LQwqVzv3kvbVlUOtb3WgDIOimoVYYqPFrQe69gK2zmwAh+Rw4ciVwHGCDfiuQ
        qc0dzZaoJnK/pLiwDcR9UdICcdJEKWDrY5l6516qzMwC6QditnMFiIARnUHWcHbbSFAwI3sjUMmAm
        VkrB7Xww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWGlg-00Ex0s-J3; Wed, 16 Aug 2023 13:41:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09C1D3001FD;
        Wed, 16 Aug 2023 15:41:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E46A9203B4384; Wed, 16 Aug 2023 15:40:59 +0200 (CEST)
Date:   Wed, 16 Aug 2023 15:40:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
 <20230814132935.GK776869@hirez.programming.kicks-ass.net>
 <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
 <20230816123716.GI980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816123716.GI980931@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:37:16PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:
> 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
> >  	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> >  		curr = NULL;
> >  
> > +	/*
> > +	 * Once selected, run the task to parity to avoid overscheduling.
> > +	 */
> > +	if (sched_feat(RUN_TO_PARITY) && curr)
> > +		return curr;
> > +
> >  	while (node) {
> >  		struct sched_entity *se = __node_2_se(node);
> >  
> 
> So I read it wrong last night... but I rather like this idea. But
> there's something missing. When curr starts a new slice it should
> probably do a full repick and not stick with it.
> 
> Let me poke at this a bit.. nice

Something like so.. it shouldn't matter much now, but might make a
difference once we start mixing different slice lengths.

---
 kernel/sched/fair.c     | 12 ++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe5be91c71c7..128a78f3f264 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -873,6 +873,13 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
+	/*
+	 * Once selected, run a task until it either becomes non-eligible or
+	 * until it gets a new slice. See the HACK in set_next_entity().
+	 */
+	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+		return curr;
+
 	while (node) {
 		struct sched_entity *se = __node_2_se(node);
 
@@ -5168,6 +5175,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		/*
+		 * HACK, stash a copy of deadline at the point of pick in vlag,
+		 * which isn't used until dequeue.
+		 */
+		se->vlag = se->deadline;
 	}
 
 	update_stats_curr_start(cfs_rq, se);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 61bcbf5e46a4..f770168230ae 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -6,6 +6,7 @@
  */
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
