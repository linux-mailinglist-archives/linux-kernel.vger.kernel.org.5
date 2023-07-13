Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E470752420
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjGMNqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjGMNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:46:01 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC337AA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:45:59 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 756833F71A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689255956;
        bh=OISdSbIRHeqAVpn1Q65It/xjmRXvWdsGR3LrX1oU/l0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=DWIlbA/+W3+FucN3XVDTARFlTr7FDwNHs9xgTaE7tzZg1uEQbMnA3ke2uL/dHcIMH
         OaMnGdY3pp12JsjYESaMg2lDieHhx9oOjQosngH21H5baYRLdvo4wwLehsoSt0OL7G
         td5ZfA8mtsp+DZTkaGlvdGztqB1r3IQOKJe6VoQm4B1xkjBlvYvcs7YXQLc1+T+VZ+
         cgzjdL/y0hyuH4e0eTshiNNH3SDr6oTofyzoYEUubc4uRYJIBRAYSM/i9ZDuG8uj7T
         YLmO2Ioc4FUY4QY6MLCL4omgL86IlBvCm0iJyC45W+onUao94Y2i043eh52QgXiFwp
         xEXVbj4hxbWHw==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b70bfcd15aso7298151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689255956; x=1691847956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OISdSbIRHeqAVpn1Q65It/xjmRXvWdsGR3LrX1oU/l0=;
        b=l0MswT8xKlczkQuSRa4NELeMHnYv8NO2AllsVkvmI3Fcu/jbM7xL9aHsrvdnIi6qzc
         Y7NTxhYF1diBzngMF6qcNVG2SsbV3yi6rMoxCxvCk79dBsvO6YfyJBTc/9g4v/BWHfA+
         u5udjGRxrFyeLwaOqaTEn2PsiRHjgQYADG6wdMpmyZsYOLiwrC9SQ5+vG6go9AOi0wvQ
         YYYrFn4VI2vZdMkzBKPRZHOoYWtbMcxFuQEhnC9V889iUfAD+4cocrO2hkL220ykp03C
         XarF+AsKk4ERvstjxh5ROAW6mFfIDtYuDrHRJbfjSqLbFYW7dVn9dc1JgXoDkRWL41wB
         UQzA==
X-Gm-Message-State: ABy/qLZBdBlV595WF4iBMaBJW8lgRFqSAhcgekSjjM/UcUK5KCP+CNdU
        FDJkZ6fjiiY0YdaCaX0Xd65uCtVXZ3WdQKsxbxiv5RRJmwHfx/30SzO9RaemcCH/1rSzoYgXAom
        LbKRSi8Uli21upHQPEDQYY+y0D8uhYXo85+EBZzpPuA==
X-Received: by 2002:a2e:981a:0:b0:2b6:db9b:aadc with SMTP id a26-20020a2e981a000000b002b6db9baadcmr1584679ljj.32.1689255955960;
        Thu, 13 Jul 2023 06:45:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2dpAIUyE2fHjrVG/n8WiIgznzDLplWQKMUeTqw6wLHiRrapaxTb3XySPXwgpFPGrCmMoBkg==
X-Received: by 2002:a2e:981a:0:b0:2b6:db9b:aadc with SMTP id a26-20020a2e981a000000b002b6db9baadcmr1584640ljj.32.1689255955562;
        Thu, 13 Jul 2023 06:45:55 -0700 (PDT)
Received: from localhost (host-95-234-206-203.retail.telecomitalia.it. [95.234.206.203])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b0098e422d6758sm3974713eju.219.2023.07.13.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:45:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:45:54 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 27/34] sched_ext: Implement SCX_KICK_WAIT
Message-ID: <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-28-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711011412.100319-28-tj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:13:45PM -1000, Tejun Heo wrote:
...
> +	for_each_cpu_andnot(cpu, this_rq->scx.cpus_to_wait,
> +			    cpumask_of(this_cpu)) {
> +		/*
> +		 * Pairs with smp_store_release() issued by this CPU in
> +		 * scx_notify_pick_next_task() on the resched path.
> +		 *
> +		 * We busy-wait here to guarantee that no other task can be
> +		 * scheduled on our core before the target CPU has entered the
> +		 * resched path.
> +		 */
> +		while (smp_load_acquire(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
> +			cpu_relax();
> +	}
> +

...

> +static inline void scx_notify_pick_next_task(struct rq *rq,
> +					     const struct task_struct *p,
> +					     const struct sched_class *active)
> +{
> +#ifdef CONFIG_SMP
> +	if (!scx_enabled())
> +		return;
> +	/*
> +	 * Pairs with the smp_load_acquire() issued by a CPU in
> +	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> +	 * resched.
> +	 */
> +	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> +#endif
> +}

We can't use smp_load_acquire()/smp_store_release() with a u64 on
32-bit architectures.

For example, on armhf the build is broken:

In function ‘scx_notify_pick_next_task’,
    inlined from ‘__pick_next_task’ at /<<PKGBUILDDIR>>/kernel/sched/core.c:6106:4,
    inlined from ‘pick_next_task’ at /<<PKGBUILDDIR>>/kernel/sched/core.c:6605:9,
    inlined from ‘__schedule’ at /<<PKGBUILDDIR>>/kernel/sched/core.c:6750:9:
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:397:45: error: call to ‘__compiletime_assert_597’ declared with attribute error: Need native word sized stores/loads for atomicity.
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:378:25: note: in definition of macro ‘__compiletime_assert’
  378 |                         prefix ## suffix();                             \
      |                         ^~~~~~
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:397:9: note: in expansion of macro ‘_compiletime_assert’
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:400:9: note: in expansion of macro ‘compiletime_assert’
  400 |         compiletime_assert(__native_word(t),                            \
      |         ^~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/include/asm-generic/barrier.h:141:9: note: in expansion of macro ‘compiletime_assert_atomic_type’
  141 |         compiletime_assert_atomic_type(*p);                             \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/include/asm-generic/barrier.h:172:55: note: in expansion of macro ‘__smp_store_release’
  172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
      |                                                       ^~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/kernel/sched/ext.h:159:9: note: in expansion of macro ‘smp_store_release’
  159 |         smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);

There's probably a better way to fix this, but for now I've temporarily
solved this using cmpxchg64() - see patch below.

I'm not sure if we already have an equivalent of
smp_store_release_u64/smp_load_acquire_u64(). Otherwise, it may be worth
to add them to a more generic place.

-Andrea

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 051c79fa25f7..5da72b1cf88d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3667,7 +3667,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		 * scheduled on our core before the target CPU has entered the
 		 * resched path.
 		 */
-		while (smp_load_acquire(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
+		while (smp_load_acquire_u64(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
 			cpu_relax();
 	}
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 405037a4e6ce..ef4a24d77d30 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -144,6 +144,40 @@ void __scx_notify_pick_next_task(struct rq *rq,
 				 struct task_struct *p,
 				 const struct sched_class *active);
 
+#ifdef CONFIG_64BIT
+static inline u64 smp_load_acquire_u64(u64 *ptr)
+{
+	return smp_load_acquire(ptr);
+}
+
+static inline void smp_store_release_u64(u64 *ptr, u64 val)
+{
+	smp_store_release(ptr, val);
+}
+#else
+static inline u64 smp_load_acquire_u64(u64 *ptr)
+{
+	u64 prev, next;
+
+	do {
+		prev = *ptr;
+		next = prev;
+	} while (cmpxchg64(ptr, prev, next) != prev);
+
+	return prev;
+}
+
+static inline void smp_store_release_u64(u64 *ptr, u64 val)
+{
+	u64 prev, next;
+
+	do {
+		prev = *ptr;
+		next = val;
+	} while (cmpxchg64(ptr, prev, next) != prev);
+}
+#endif
+
 static inline void scx_notify_pick_next_task(struct rq *rq,
 					     struct task_struct *p,
 					     const struct sched_class *active)
@@ -156,7 +190,7 @@ static inline void scx_notify_pick_next_task(struct rq *rq,
 	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
 	 * resched.
 	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+	smp_store_release_u64(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 #endif
 	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
 		return;
-- 
2.40.1

