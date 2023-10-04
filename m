Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9336B7B7C31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbjJDJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbjJDJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:33:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF184A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V8IRh3MVoH/jf6GxN4kJfc6QD532DWiPW05TRpljgBE=; b=UToci7NnJ89bu/bRQAwNk2/S/h
        Pm4ebDTUK91eNB4Y8X9rgIhXgws+WkGC79lt6tglQehIcFVOjr7xdWTjZBimozrqrfZL/PLnsR2sZ
        p2exqubLSZEMPsAHIEWsTHgueSeBQC6nbjQhoYYElLAW7ppwvgl6Q3+tSTuSKZb/U6J2s0piQUPHV
        2+dhp6L71bKofG7mRAiD0ZdcmOv4LJub9Tux03BG/cCk3aNBvqlSsTxL8D+Vng2Ug5nYq8Z7XnJJN
        tRnPDq493zmjbC/oZxiayZAjEQ2U4uTKFv93ekYFddN+RrY/zk/pSDrd4N0OoeP9O4Agnpe1hJt9C
        cYUi1xMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnyFw-002dAX-7D; Wed, 04 Oct 2023 09:33:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEF37300338; Wed,  4 Oct 2023 11:33:23 +0200 (CEST)
Date:   Wed, 4 Oct 2023 11:33:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Update comment of try_invoke_on_locked_down_task()
Message-ID: <20231004093323.GK1539@noisy.programming.kicks-ass.net>
References: <20230731085759.11443-1-zhangqiao22@huawei.com>
 <ZR0w7vtVhiOVI4uD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0w7vtVhiOVI4uD@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:31:26AM +0200, Ingo Molnar wrote:
> 
> * Zhang Qiao <zhangqiao22@huawei.com> wrote:
> 
> > Since commit 9b3c4ab3045e ("sched,rcu: Rework
> > try_invoke_on_locked_down_task()") renamed
> > try_invoke_on_locked_down_task() to task_call_func().
> > Now, update some comment about it.
> > 
> > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0d18c3969f90..540ac33ddb80 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4186,7 +4186,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> >  	 * __schedule().  See the comment for smp_mb__after_spinlock().
> >  	 *
> > -	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
> > +	 * A similar smb_rmb() lives in task_call_func().
> 
> Except the matching smp_rmb() doesn't live in task_call_func() anymore, so 
> you now turned a stale comment into a misleading one ...

It moved, *again*, it's now in __task_needs_rq_lock() :-)
