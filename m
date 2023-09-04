Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0A791DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjIDTin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjIDTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:38:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A32CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:38:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so17430795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1693856315; x=1694461115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4eCv8xune3wHHGKyjVY37Ks2yzh1o2qfNwmTMs6GJM=;
        b=yUNrPvR1yHYAUVTLNTfYdz11uPHc7omOA/CfyCGnrR+TU8fEGqnhFykSejlVj4xdgj
         Wosh3MnWocoYGM578bpMAa6krEroTXLjp2ZmLEPW2ln6dlZKY5k+lsyMUFW/J1IBZvy6
         k9hiY1FoQtCAzDJqT2iMZ8STsvlC3Cp5rweXR1Gerd5TFn4tyCgg6ljs9KPf5JJpKbam
         WJRcc5tJm1JfDow+IRcOxAHCgwoKHyuxE4VqIMkF2epS4H86avpX01MRN3ke++IJ9qxH
         v8U3TK6hT5VXXWH+omjKLAjaB1cLGOYih5StvE+zoFcUisxgkdIOry7AnBwrk84xBiPP
         VSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693856315; x=1694461115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4eCv8xune3wHHGKyjVY37Ks2yzh1o2qfNwmTMs6GJM=;
        b=RsWGjVPuYpGQ6K9qa6KfNdVW+17zguFPFLwNOGwnt1RyKItAKG7yVzZAolvTelajDC
         CEgz3lPkLV+W6RSAWtTDznX4FZv3PDjj+idEFIcPTZl9R4LUHvCIFF1GNDeNB6tN0uAw
         ZXptm19MAD/wj7515lZlltHY3gcvc1s0jstNYuIBAUetT+amjBUzxFPdwoFLE4sJaXnP
         g8f5C+gaHp/zD0yc9QlPBDrvUwWrK7o2xhqmDej+Cj4ApJEEjTXM2BcUtP58cS5fTfsF
         V+GQKwh9MEpCiDOqH9m2a+L8+m0EwSo2mc3eb8aD8UIWe7sqXP7ZASK4tX+7KqS8c2/n
         PkLw==
X-Gm-Message-State: AOJu0Yxj+OV2f2NxUwIPQHH6Ezrb4bvZU0SkpBwvHInfdPQPMtjQ8C6n
        f3/6cijnJU11+NQoMAV932Jkz5uFBAz1AuClDWQ=
X-Google-Smtp-Source: AGHT+IGKfNSdK1PNv5vpfA5L9Rh6PKc8Ossvh0UjHY3rAr+6B97KVB84/F/ErR5ndE3BwPwg+OKdbQ==
X-Received: by 2002:a1c:720c:0:b0:3fe:25b3:951d with SMTP id n12-20020a1c720c000000b003fe25b3951dmr7155613wmc.5.1693856315332;
        Mon, 04 Sep 2023 12:38:35 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003fee7b67f67sm14836856wmj.31.2023.09.04.12.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:38:34 -0700 (PDT)
Date:   Mon, 4 Sep 2023 20:38:33 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/fair: Check a task has a fitting cpu when updating
 misfit
Message-ID: <20230904193833.vv35wbxk65svefpo@airbuntu>
References: <20230820203429.568884-1-qyousef@layalina.io>
 <CAKfTPtCq+-U34WSUHjs3CkqQM769_Q+FN-5Y+uK=AzdB0YNiLQ@mail.gmail.com>
 <20230829153524.iswwflqd3iw3uybx@airbuntu>
 <2562890e-e824-7721-8dbe-8c5ae6ac42a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2562890e-e824-7721-8dbe-8c5ae6ac42a9@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/23 15:18, Dietmar Eggemann wrote:
> On 29/08/2023 17:35, Qais Yousef wrote:
> > On 08/29/23 16:10, Vincent Guittot wrote:
> >> On Sun, 20 Aug 2023 at 22:34, Qais Yousef <qyousef@layalina.io> wrote:
> 
> [...]
> 
> >>>  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++-------
> >>>  1 file changed, 43 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 0b7445cd5af9..f08c5f3bf895 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4853,17 +4853,50 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >>>
> >>>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >>>  {
> >>> +       unsigned long uclamp_min, uclamp_max;
> >>> +       unsigned long util, cap_level;
> >>> +       bool has_fitting_cpu = false;
> >>> +       int cpu = cpu_of(rq);
> >>> +
> >>>         if (!sched_asym_cpucap_active())
> >>>                 return;
> >>>
> >>> -       if (!p || p->nr_cpus_allowed == 1) {
> >>> -               rq->misfit_task_load = 0;
> >>> -               return;
> >>> -       }
> >>> +       if (!p || p->nr_cpus_allowed == 1)
> >>> +               goto out;
> >>>
> >>> -       if (task_fits_cpu(p, cpu_of(rq))) {
> >>> -               rq->misfit_task_load = 0;
> >>> -               return;
> >>> +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> >>> +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> >>> +       util = task_util_est(p);
> >>> +
> >>> +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> >>> +               goto out;
> 
> util_fits_cpu() checks fits_capacity(util, capacity_of(cpu)) but the
> capacity pressure could change between update_misfit_status() and CFS lb?

Do we need to be precise here? I think the race is not a problem as long as
we're not reading garbage values, which I don't think we do.

FWIW, task_fits_cpu() also used util_fits_cpu(), so if this is a problem it's
not something introduced by this patch at least.

The trade-off is to be lockless but live with potentially slightly outdated
value, or be precise and hold some locks to force serialization.

> 
> >>> +
> >>> +       cap_level = capacity_orig_of(cpu);
> >>> +
> >>> +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> >>> +       if (cap_level == SCHED_CAPACITY_SCALE)
> >>> +               goto out;
> >>> +
> >>> +       /*
> >>> +        * If the task affinity is not set to default, make sure it is not
> >>> +        * restricted to a subset where no CPU can ever fit it. Triggering
> >>> +        * misfit in this case is pointless as it has no where better to move
> >>> +        * to. And it can lead to balance_interval to grow too high as we'll
> >>> +        * continuously fail to move it anywhere.
> >>> +        */
> >>> +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> >>> +               for_each_cpu(cpu, p->cpus_ptr) {
> >>
> >> I haven't looked at the problem in detail and at other possibilities
> >> so far but for_each_cpu doesn't scale and update_misfit_status() being
> >> called in pick_next_task_fair() so you must find another way to detect
> >> this
> > 
> > Okay, will do.
> 
> We have LIST_HEAD(asym_cap_list) (list of cpumasks according to
> cpu_capacity_orig CPU groups) in kernel/sched/topology.c to set
> SD_ASYM_CPUCAPACITY{,_FULL} for asymmetric CPU capacity systems.
> Maybe this could be made usable in fair.c as well?

Yeah it could help to implement for_each_cap_level() iterator that can be
safely used from anywhere.

I remember looking at topology code in the past but the issue I think I found
then is that I must make sure we have something that is RCU protected to truly
allow it to be used concurrently without overhead (like we do for pd). So a bit
of rework is required.

> 
> But checking via util_fits_cpu() wouldn't work then since it's per-CPU.
> The check of p's CPU affinity, its uclamped util_avg value and the
> cpu_capacity_orig is sufficient here. Then using those cpumasks could work.

Thanks for the suggestions. Yes we can skip util_fits_cpu() and just compare
against capacity_orig directly as this is only what we truly care about here.


Thanks!

--
Qais Yousef
