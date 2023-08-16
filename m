Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723577E54B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbjHPPi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbjHPPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:38:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7526A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:38:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso903406566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692200301; x=1692805101;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrMrEjSD5O6M353I1H2xKh6LAOtsP+e9kUfVNrj6nQw=;
        b=S3LJgZzUaprjtW+YHecwMBWFucUDfVvf8lauTGYI4vH2TpkJMTZeGmlFoXnDCXlNZE
         UIIX30ErJ3DhxY/qd+YdiLsByU5YF/JnfJqPh/JNfCyQjIXdGvV/dy0qPIjKWC3NVsu/
         n0hwCABVGPB3DcK0qEE3nyL5t8ReDeeB+uz1oBgxh8eVPBvVsl3fjersjMNlqfqItsdd
         4yQmwqjU6AC4EATwFmjWIJ/9ToRBdAn9jYDU/Jge3iTWROz0/ssfmjtGdbME88J13urG
         T4a5mNE7OG7OoydZwWEXULMaLZkfEYUTRofMGgg9G/eT8X9FxLmFPO850yjS2kKT9bP4
         RIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200301; x=1692805101;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrMrEjSD5O6M353I1H2xKh6LAOtsP+e9kUfVNrj6nQw=;
        b=QUVnUYoEGfm7BNDhCwRaVRHxMVwzJ8UsIDMLYlwfjfMCihyLLYIOmlb2ANTmxcRSly
         i4khOianGoOrEkdudgWZk5I7UhNXkse2yn3gaLAYGlpEHy3gXdnl66riGX0eb5X+4Sjg
         nkOOmPq/YT8MyUcJyUPLJGQoICmvLgv/KSQcaoimxkru7i2Ymyi9wQ3krJN7eWxJI2/i
         0p+l97bt5bsquYTAp4rJhhoeK827unO2HdZ7XfGeJBTRDALNxmT15UVJJUZUQBEhBquU
         o6n7bLiu8v6kHQNukk4wOJVyS1UUVlRJs7j83++ylGEAMHtd8j9+FpOzxWAYZR+8ttUm
         RAkA==
X-Gm-Message-State: AOJu0YyIa/uALmkALkrI72gPpEpVYDW5dc0yn5qTyGo5UACgS5mVoz84
        IKycxdNhhJksC6ypWAS67p8=
X-Google-Smtp-Source: AGHT+IFOZRTiNwDqdqhRuKNh28Wi6CXzO7shnwHZCKEBp0Nd03KAc/h84roVEXIgOO5R6fENycTjhQ==
X-Received: by 2002:a17:907:2724:b0:992:ab3a:f0d4 with SMTP id d4-20020a170907272400b00992ab3af0d4mr1653874ejl.17.1692200301404;
        Wed, 16 Aug 2023 08:38:21 -0700 (PDT)
Received: from homer.fritz.box ([185.191.217.218])
        by smtp.googlemail.com with ESMTPSA id c17-20020a170906695100b0099297782aa9sm8611996ejs.49.2023.08.16.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:38:21 -0700 (PDT)
Message-ID: <3d10fbfb0171cc017e19adf39fa97a3160a76206.camel@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Date:   Wed, 16 Aug 2023 17:38:20 +0200
In-Reply-To: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
         <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
         <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
         <20230814132935.GK776869@hirez.programming.kicks-ass.net>
         <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
         <20230816123716.GI980931@hirez.programming.kicks-ass.net>
         <20230816134059.GC982867@hirez.programming.kicks-ass.net>
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

On Wed, 2023-08-16 at 15:40 +0200, Peter Zijlstra wrote:
> On Wed, Aug 16, 2023 at 02:37:16PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:
> > 
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
> > >         if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > >                 curr = NULL;
> > >  
> > > +       /*
> > > +        * Once selected, run the task to parity to avoid overscheduling.
> > > +        */
> > > +       if (sched_feat(RUN_TO_PARITY) && curr)
> > > +               return curr;
> > > +
> > >         while (node) {
> > >                 struct sched_entity *se = __node_2_se(node);
> > >  
> > 
> > So I read it wrong last night... but I rather like this idea. But
> > there's something missing. When curr starts a new slice it should
> > probably do a full repick and not stick with it.
> > 
> > Let me poke at this a bit.. nice
> 
> Something like so.. it shouldn't matter much now, but might make a
> difference once we start mixing different slice lengths.

Hm, that stash the deadline trick _seems_ to have cured the reason I
was inspired to added that XXX hunk.. no 'ew, that's a tad harsh'
latency penalty in sight <knocks wood>.

Here's hoping test bots don't have a cow. 

> 
> ---
>  kernel/sched/fair.c     | 12 ++++++++++++
>  kernel/sched/features.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe5be91c71c7..128a78f3f264 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -873,6 +873,13 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>         if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>                 curr = NULL;
>  
> +       /*
> +        * Once selected, run a task until it either becomes non-eligible or
> +        * until it gets a new slice. See the HACK in set_next_entity().
> +        */
> +       if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
> +               return curr;
> +
>         while (node) {
>                 struct sched_entity *se = __node_2_se(node);
>  
> @@ -5168,6 +5175,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 update_stats_wait_end_fair(cfs_rq, se);
>                 __dequeue_entity(cfs_rq, se);
>                 update_load_avg(cfs_rq, se, UPDATE_TG);
> +               /*
> +                * HACK, stash a copy of deadline at the point of pick in vlag,
> +                * which isn't used until dequeue.
> +                */
> +               se->vlag = se->deadline;
>         }
>  
>         update_stats_curr_start(cfs_rq, se);
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 61bcbf5e46a4..f770168230ae 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -6,6 +6,7 @@
>   */
>  SCHED_FEAT(PLACE_LAG, true)
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
> +SCHED_FEAT(RUN_TO_PARITY, true)
>  
>  /*
>   * Prefer to schedule the task we woke last (assuming it failed

