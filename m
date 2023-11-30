Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71A37FF320
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbjK3PCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjK3PCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:02:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3661A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:02:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2860f7942b0so1036558a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701356536; x=1701961336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uE+1XqCxbAKbHngnWjE9Izc6x6SIjBE0R2sOtz+x7s=;
        b=SYi3x5wnJKWZo6+zb7nAdrcoirNjmrALwiQYrUn3xsDPO3hxEasI5LHgCn0a4Kqah+
         fKQjZyQGoij1PAQLab49WqxnkwaepgQ2i/1HsL0vQEUUuBFaJnk5AhnWJEbxm7H/5DmJ
         YhlgV9xnusBrDwc/ic2vtScTh4c5V+N6JyqxvbsDdS1KKaJAyxzlwBxNhlQVwh7Sn3JK
         UhaLZEv470p0hjFJvGxFyulo5aIPxb4QuLTSLCCfqnpgfqh5pOwiMVAqil5TLwN4dors
         p6/zjsqQFWHAkiWpHolP3IyjmNSrFmYmnme5HIvHeSoIGQ7TPxyo9pEMJOSSXylBIQhX
         7WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356536; x=1701961336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uE+1XqCxbAKbHngnWjE9Izc6x6SIjBE0R2sOtz+x7s=;
        b=ohZnepDVRtPSDvxvUeyPCKl2zVM8s0/sq4P8HpGtS/UTSucNEBDNrUIEpXHdE89EOR
         KtpHXLEkKgcummJVTK+JLOOPVmc+MUCHv1SCPsBCAfCYL8Y/xPohsmgGgkrqs1zNPQ9h
         bkraSHTBxRL+F3oFQvveLvHwHtslDCwOCKdVA0lrfYhTqW+c32t9XXmS/0OenTuMhlnl
         I1i8HVTm35RMlP07Zw5oaugdH2wqC5r9aKkXVCwSOjxJTf0skp0bM3KT7Zydvozr0mph
         fWSIlQeCdXXjXERRCJ29yUSMTT31mtYoP4BBbQ8ty30TVzhCjEKZ9x6Sspqm+ji1Ie6G
         taLA==
X-Gm-Message-State: AOJu0YyjXRwKZvrLW7+tS4BbpKWT9pMdxYNPe7xqiFL0ZKEzY96oU2ur
        ln+NMgb/fEitcILkj0PkSurImv8mIJxl0v5Rn/g8pQ==
X-Google-Smtp-Source: AGHT+IFaqNlTBs/qF2aYYbzgwapt6Q8onBKcsYu1BVl6l1HKKGb4SjsjPhEmhX/XklsuyJQCf9LnTnER2+TodslNR+g=
X-Received: by 2002:a17:90b:1e45:b0:285:ade1:cbfa with SMTP id
 pi5-20020a17090b1e4500b00285ade1cbfamr20761775pjb.16.1701356536256; Thu, 30
 Nov 2023 07:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
 <20231127143238.1216582-3-vincent.guittot@linaro.org> <b5d83fcd-09fb-4680-a594-d4848fddc50a@arm.com>
In-Reply-To: <b5d83fcd-09fb-4680-a594-d4848fddc50a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Nov 2023 16:02:02 +0100
Message-ID: <CAKfTPtC44Quvppj4ZVWp7R837CUFA_FtEXjN_z8aAfMuSEOS3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Simplify util_est
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, corbet@lwn.net,
        alexs@kernel.org, siyanteng@loongson.cn, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        lukasz.luba@arm.com, hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 at 14:42, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 27/11/2023 15:32, Vincent Guittot wrote:
> > With UTIL_EST_FASTUP now being permanent, we can take advantage of the
> > fact that the ewma jumps directly to a higher utilization at dequeue to
> > simplify util_est and remove the enqueued field.
> >
>
> Did some simple test with a ramp-up/ramp_down (10-80-10%) task affine to
> a CPU.
>
> https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/util_est_fastup.ipynb
>
> LGTM.

Thanks

>
> [...]
>
> > @@ -4879,27 +4865,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >        * Skip update of task's estimated utilization when its members are
> >        * already ~1% close to its last activation value.
> >        */
> > -     last_ewma_diff = ue.enqueued - ue.ewma;
> > -     last_enqueued_diff -= ue.enqueued;
> > -     if (within_margin(last_ewma_diff, UTIL_EST_MARGIN)) {
> > -             if (!within_margin(last_enqueued_diff, UTIL_EST_MARGIN))
> > -                     goto done;
> > -
> > -             return;
> > -     }
> > +     last_ewma_diff = ewma - dequeued;
> > +     if (last_ewma_diff < UTIL_EST_MARGIN)
> > +             goto done;
> >
> >       /*
> >        * To avoid overestimation of actual task utilization, skip updates if
> >        * we cannot grant there is idle time in this CPU.
> >        */
> > -     if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> > +     if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> >               return;
>
> Not directly related to the changes: Should we not use `goto done` here
> is well to rearm UTIL_AVG_UNCHANGED?

I noticed this as well but didn't want to mix 2 topics.

>
> >       /*
> >        * To avoid underestimate of task utilization, skip updates of EWMA if
> >        * we cannot grant that thread got all CPU time it wanted.
> >        */
> > -     if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> > +     if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
> >               goto done;
> >
> >
> > @@ -4914,18 +4895,18 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >        *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
> >        *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
> >        *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
> > -      *          = w * (      last_ewma_diff            ) +     ewma(t-1)
> > -      *          = w * (last_ewma_diff  +  ewma(t-1) / w)
> > +      *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
> > +      *          = w * (-last_ewma_diff +  ewma(t-1) / w)
> >        *
> >        * Where 'w' is the weight of new samples, which is configured to be
> >        * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
> >        */
>
> The text above still mentioned ue.enqueued and that we store the current
> PELT value ... which isn't the case anymore.

argh, I missed this one

>
>
> > -     ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
> > -     ue.ewma  += last_ewma_diff;
> > -     ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
> > +     ewma <<= UTIL_EST_WEIGHT_SHIFT;
> > +     ewma  -= last_ewma_diff;
> > +     ewma >>= UTIL_EST_WEIGHT_SHIFT;
> >  done:
> > -     ue.enqueued |= UTIL_AVG_UNCHANGED;
> > -     WRITE_ONCE(p->se.avg.util_est, ue);
> > +     ewma |= UTIL_AVG_UNCHANGED;
> > +     WRITE_ONCE(p->se.avg.util_est, ewma);
> >
> >       trace_sched_util_est_se_tp(&p->se);
> >  }
>
> [...]
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks
