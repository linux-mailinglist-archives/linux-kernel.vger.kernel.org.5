Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADC781E04
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHTNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjHTNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:54:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0F4C09
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:52:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee843b44cso7453035e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692539553; x=1693144353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7APu8pBAy7TmDzZAeeaJHe8lZS9TnsCJAG5DgLrVZc=;
        b=GOgBGAhn6DVhQuKsNOtHgmBHrCYe1hGSfKnh5FFv5ZKRfvu7gwiHZYM17CtrFuf+1a
         7Q2GqZTrQKfRktDZBZhyD703FNhmEWK1HBwIiClDI+B1U+sECXq8qSq6tn5KiPlchjPN
         pC8MK68/nFvvfeu5z0Gy9XaEmb1K6lFltinQ9qlntLNVY95M8+O04yh/FfRDTzhsqGKA
         NUxdOCQVy76k6IyHkTe9vvWoqFd/L3zCWftWjoNfmVgZktPe756xrHemUE+JqlqiqTYD
         R0C3IxpGQumMZQC4mqXSzNmdd6YlN53u0Qbp87qJhTXMDDfH48RqtycG3CpnBye6uf3G
         5Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692539553; x=1693144353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7APu8pBAy7TmDzZAeeaJHe8lZS9TnsCJAG5DgLrVZc=;
        b=UKbWSvBPBx4CEPYOpXoGtGdVbsPRVCE4CugL0jmuKnFY+O53krEurDp6pDtvfgl2U5
         EBWUh1+FW4tJW1rlTM2iKZrXw6JRJhJGHAvJDdJm01eleXGQxMvC4Y5qFjbqL/wVM1Wo
         d0KRzu65V9+JImDL833xiRkTSPhw9yA3R34IQR454KlNzXul/eeHC+HZdTA7iWUqbBbS
         fykWUWl0GGhZNm6pSrFckDeJQ0wJ5r8pRhNvW2f9HZNY54UQccV4wYrpOGML1BOj5iGg
         YhIJfEvCG63EuHnLmD9TrIqlXz0Sw/X3vjK7opXBfMJBKnUvHduqZlQquOC7qJzEWszX
         r9Ow==
X-Gm-Message-State: AOJu0Yww61fqMMFu89hJJS9HmSyCK9E9MoAtxeGbxRlt8q2QkT7AaLcD
        ZHH4BYbTb+34J19tBQIHWBxF2A==
X-Google-Smtp-Source: AGHT+IG1KogoVQ2XGFK/3tA5WzgiCvIqdcAb+XXFyOX4Z5AIMUfHjtu/rRnM27svq5syGNjpOCjuIQ==
X-Received: by 2002:a05:600c:3781:b0:3fb:bc6d:41f1 with SMTP id o1-20020a05600c378100b003fbbc6d41f1mr2977671wmr.17.1692539553035;
        Sun, 20 Aug 2023 06:52:33 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c0b4900b003fbd9e390e1sm12860713wmr.47.2023.08.20.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 06:52:32 -0700 (PDT)
Date:   Sun, 20 Aug 2023 14:52:31 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH v3 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
Message-ID: <20230820135231.qcfphadn2kc4nxpa@airbuntu>
References: <20230717215717.309174-1-qyousef@layalina.io>
 <20230717215717.309174-3-qyousef@layalina.io>
 <CAKfTPtCAs5_LDkaxVBHW1wHZzpOHvgsL7Tz1PyDDqDHN2UU5Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCAs5_LDkaxVBHW1wHZzpOHvgsL7Tz1PyDDqDHN2UU5Xw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/23 11:57, Vincent Guittot wrote:
> On Mon, 17 Jul 2023 at 23:57, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > find_energy_efficient_cpu() bails out early if effective util of the
> > task is 0 as the delta at this point will be zero and there's nothing
> > for EAS to do. When uclamp is being used, this could lead to wrong
> > decisions when uclamp_max is set to 0. In this case the task is capped
> > to performance point 0, but it is actually running and consuming energy
> > and we can benefit from EAS energy calculations.
> >
> > Rework the condition so that it bails out for when util is actually 0 or
> > uclamp_min is requesting a higher performance point.
> >
> > We can do that without needing to use uclamp_task_util(); remove it.
> >
> > Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks Vincent!

Ping in case this has fallen through the cracks. I hope it's good to be picked
up now.


Thanks!

--
Qais Yousef

> 
> > ---
> >  kernel/sched/fair.c | 18 +-----------------
> >  1 file changed, 1 insertion(+), 17 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d489eece5a0d..c701f490ca4c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4348,22 +4348,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
> >         return max(task_util(p), _task_util_est(p));
> >  }
> >
> > -#ifdef CONFIG_UCLAMP_TASK
> > -static inline unsigned long uclamp_task_util(struct task_struct *p,
> > -                                            unsigned long uclamp_min,
> > -                                            unsigned long uclamp_max)
> > -{
> > -       return clamp(task_util_est(p), uclamp_min, uclamp_max);
> > -}
> > -#else
> > -static inline unsigned long uclamp_task_util(struct task_struct *p,
> > -                                            unsigned long uclamp_min,
> > -                                            unsigned long uclamp_max)
> > -{
> > -       return task_util_est(p);
> > -}
> > -#endif
> > -
> >  static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> >                                     struct task_struct *p)
> >  {
> > @@ -7588,7 +7572,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >         target = prev_cpu;
> >
> >         sync_entity_load_avg(&p->se);
> > -       if (!uclamp_task_util(p, p_util_min, p_util_max))
> > +       if (!task_util_est(p) && p_util_min == 0)
> >                 goto unlock;
> >
> >         eenv_task_busy_time(&eenv, p, prev_cpu);
> > --
> > 2.25.1
> >
