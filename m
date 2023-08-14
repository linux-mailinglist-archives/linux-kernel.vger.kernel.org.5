Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2477BFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHNSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHNSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:33:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A45E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:32:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so6267347a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037976; x=1692642776;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+BpmMd9DCnNsopJ62AvbT/bgZJHPIb6r70TIq9xOz8E=;
        b=Uymj+6di+pNNTu6K6E9TRQrnWfY6YEMmKLn3RgGCY/elyt1ebNb7U4/n4r4sckrxJr
         pAKXkdsHdhRC2+RIsPCBKj7SWg1gQOKLBSozY+fw+hARWvaqT72whad9h9Sd6f0nQdJu
         QiXkxqT9mKKoKXv24fV/eNOYbmu067ZnnyyGMF6OCfRpuCT9d52kbq0XhfzSjyWomYtd
         t6JjReEjkYwuGHlzoynobG5SDN8S2bMcFSMLbI0HxaDg1pBbKi9tx+fK3FJsC6ek6j/T
         Egc06shIdY7Z6uYHO43nqnMZRMyp3q44A1vCjtWuOKvJ7EVN7AK6AgYMmrWq1bbdtsG1
         Zr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037976; x=1692642776;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BpmMd9DCnNsopJ62AvbT/bgZJHPIb6r70TIq9xOz8E=;
        b=VyC3wr1Abjkwuk0E+PUxoNjDuAkMCMOUU582LC9U82cXx+HaMXvexjKXejrh4HpMDX
         15CmMw9vM0g8Udu3g4w0KiVVl3oFq1LyPMbIAjQS7iI+a9/QvRkqxA/1fnSAUraeM253
         fS/JRsmaT8odoYKdETPir2wwy6WDhtIRp6+cIuK8gmCq+VacO42F2pk193KMfcsz1t83
         y9vHbE8GUpaUaf7BxfC3dqCQX3TQpnVb/jrn2JWACuFursAWyCRBO6oPThBIDfE5hTjK
         wvu3+P8ULmAxKS2mkjqdhKShxR2sndq8yrIA7kogu6hN6idD7EjEEaj1V/UFIu3LHi3m
         LPIA==
X-Gm-Message-State: AOJu0Yx6W+H3JPIwAkdBlsE11CRuYKeZhAf6oR3gFsAC520vl0CZPPqF
        li3BcUDweYO12oSVQwwxFDF6e8HeJ/p/2g==
X-Google-Smtp-Source: AGHT+IGzZzTr/nhp1QdpwulYBBSdiz7yl56tPp2xbyf/XIkeFmv9llvKhhlwYtFrPyIuGyjfNh5f9w==
X-Received: by 2002:aa7:da06:0:b0:525:69ec:e1c8 with SMTP id r6-20020aa7da06000000b0052569ece1c8mr1858219eds.40.1692037976312;
        Mon, 14 Aug 2023 11:32:56 -0700 (PDT)
Received: from homer.fritz.box ([185.221.151.76])
        by smtp.googlemail.com with ESMTPSA id f10-20020a056402150a00b00525727db542sm104045edw.54.2023.08.14.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:32:56 -0700 (PDT)
Message-ID: <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Date:   Mon, 14 Aug 2023 20:32:55 +0200
In-Reply-To: <20230814132935.GK776869@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
         <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
         <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
         <20230814132935.GK776869@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-14 at 15:29 +0200, Peter Zijlstra wrote:
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe5be91c71c7..16d24e5dda8f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8047,6 +8047,15 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>         cfs_rq = cfs_rq_of(se);
>         update_curr(cfs_rq);
>  
> +       if (sched_feat(WAKEUP_DEADLINE)) {
> +               /*
> +                * Only allow preemption if the virtual deadline of the new
> +                * task is before the virtual deadline of the existing task.
> +                */
> +               if (deadline_gt(deadline, pse, se))
> +                       return;
> +       }
> +
>         /*
>          * XXX pick_eevdf(cfs_rq) != se ?
>          */
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 61bcbf5e46a4..e733981b32aa 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -24,6 +24,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
>   * Allow wakeup-time preemption of the current task:
>   */
>  SCHED_FEAT(WAKEUP_PREEMPTION, true)
> +SCHED_FEAT(WAKEUP_DEADLINE, true)
>  
>  SCHED_FEAT(HRTICK, false)
>  SCHED_FEAT(HRTICK_DL, false)

I don't have that phoronix thingy, but the above didn't seem to do
anything for hackbench here.

I whack eevdf with the stick below to dampen its scheduling enthusiasm
a little, and it did help the hackbench deficit some.

(yup, it's all rob Peter to pay Paul.. this game has no winner:)

hackbench -l 10000
                                           avg
6.4.10-cfs       5.575   5.565   5.575   5.571
                                               v cfs
6.4.10-eevdf     6.106   6.078   6.103   6.095 1.094
                 5.888   5.890   5.889   5.889 1.057 +RUN_TO_PARITY

---
 kernel/sched/fair.c     |    6 ++++++
 kernel/sched/features.h |    1 +
 2 files changed, 7 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
+	/*
+	 * Once selected, run the task to parity to avoid overscheduling.
+	 */
+	if (sched_feat(RUN_TO_PARITY) && curr)
+		return curr;
+
 	while (node) {
 		struct sched_entity *se = __node_2_se(node);
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,6 +7,7 @@
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_FUDGE, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed

