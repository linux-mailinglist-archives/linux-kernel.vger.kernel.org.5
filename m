Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036C794548
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjIFVpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjIFVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:45:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35E19AD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:45:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so3413935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694036737; x=1694641537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyCVp/F/ThCRbj27KuhajP5SpO/oz50VxcPxPw4wux4=;
        b=GzVJX2PWRml7fmw5TI6M9xxcDZdfszs/udq/0Gy8dL/AxCB+MoQrTf4zdQXPwmMv+Y
         91QWoVDb9GFZch2UzqxDx5/zICSdp9pHijX8d8tOQYNReXuuNpeIM96S3VlgJPgwQpPt
         3ItJwB0zRH2Y+ymO7HNhIZwobgH1QNX0Rwedk/vD9hj2INr+K1uW1lqSj50rJ4r/qeOE
         /3t/atiYOQI5LtQGgGYVijbLYnFQ05rtnhy/VS3LykDVVd260m0AVsmibwDCubDia7Si
         MD4xBvalOKIYuXKvAYyPCMI5tE7HAPHVA22WwbHRCsp2SPDT9oLDrVuzN0WzPvxq6yoJ
         A+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036737; x=1694641537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyCVp/F/ThCRbj27KuhajP5SpO/oz50VxcPxPw4wux4=;
        b=KppIAq8prghm85/w90+DcPflOf9p/W4YJsy4VetkDXpcgFypPPc/BR3JAB294S5GzR
         OrrS1Pv/TwGBKeBpZozrYAJDVHgyKnraEmrggeXbuBCBrfb0B/9DF8lTjVISaKfqnAfA
         ONf11sLqnSBGPveLSdIAWwRMcO/Eq77w4wm5ynTedUj+DlQYdUD679M+onYYBQkOfyE8
         jvJUhJQuMdZhjwcpic95PS0q8t/WkF2IBzLMTEp1eyFiiSo868Jcd19vqbwx9izDat/d
         e2lYGR/iv8uobgvL3U94bEN/iTGEVJaasRstZIMBo3QXKR46l+zKBBESih5iWYCE0wDN
         GgOg==
X-Gm-Message-State: AOJu0YzMYn1iNunRST/8DtqjxZ2ubtUf5z1bDg4lMfn0ohYGqQUV4uiS
        1Xd/nRacU/+LnWrAso8RN8Zuvw==
X-Google-Smtp-Source: AGHT+IEU2jMMGX4tq3chgsn92r65KmTUDSy4JiT6I83180aiFG4Va4GStd7rV9oCBMLRwsuqZcTcPA==
X-Received: by 2002:a05:600c:2986:b0:401:aa8f:7562 with SMTP id r6-20020a05600c298600b00401aa8f7562mr3308615wmd.11.1694036736712;
        Wed, 06 Sep 2023 14:45:36 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c204d00b00402d7105035sm640601wmg.26.2023.09.06.14.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:45:36 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:45:35 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 3/7] sched/fair: Remove magic margin in
 fits_capacity()
Message-ID: <20230906214535.y4m5rtmi6zz24wvx@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-4-qyousef@layalina.io>
 <e2c161dc-381a-4cd6-9b46-6810fab58222@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2c161dc-381a-4cd6-9b46-6810fab58222@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 16:38, Dietmar Eggemann wrote:
> On 28/08/2023 01:31, Qais Yousef wrote:
> > 80% margin is a magic value that has served its purpose for now, but it
> > no longer fits the variety of systems exist today. If a system is over
> > powered specifically, this 80% will mean we leave a lot of capacity
> > unused before we decide to upmigrate on HMP system.
> > 
> > The upmigration behavior should rely on the fact that a bad decision
> > made will need load balance to kick in to perform misfit migration. And
> > I think this is an adequate definition for what to consider as enough
> > headroom to consider whether a util fits capacity or not.
> > 
> > Use the new approximate_util_avg() function to predict the util if the
> > task continues to run for TICK_US. If the value is not strictly less
> > than the capacity, then it must not be placed there, ie considered
> > misfit.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0b7445cd5af9..facbf3eb7141 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -109,16 +109,31 @@ int __weak arch_asym_cpu_priority(int cpu)
> >  }
> >  
> >  /*
> > - * The margin used when comparing utilization with CPU capacity.
> > + * The util will fit the capacity if it has enough headroom to grow within the
> > + * next tick - which is when any load balancing activity happens to do the
> > + * correction.
> >   *
> > - * (default: ~20%)
> > + * If util stays within the capacity before tick has elapsed, then it should be
> > + * fine. If not, then a correction action must happen shortly after it starts
> > + * running, hence we treat it as !fit.
> > + *
> > + * TODO: TICK is not actually accurate enough. balance_interval is the correct
> > + * one to use as the next load balance doesn't not happen religiously at tick.
> > + * Accessing balance_interval might be tricky and will require some refactoring
> > + * first.
> >   */
> 
> I understand that you want to have a more intelligent margin (depending
> on the util value) but why you want to use the time value of TICK_USEC
> (or the balance_interval)?
> 
> We call fits_capacity() e.g. in wakeup and the next lb can just happen
> immediately after it.

If it happens immediately, then current values we're considering without margin
are enough to make a correct decision. But worst case scenario if the task
doesn't go to sleep shortly after and continues to run, then we'll have to wait
for TICK_USEC for lb to kick off again and handle a misfit lb.

So we only need to add margin (or headroom which I think is a better word) to
account for the fact that a worst case scenario is that the task will run for
a full tick on this CPU. And what I'm trying to say/do here is that as long as
the task doesn't grow beyond the capacity of the CPU within tick, then it's
fine for it to run there as it won't cause misfit or require misfit lb to run.

If the value goes beyond capacity of the CPU before the end of the tick, then
this means the task had to run at lower capacity for sometime. Which is what
we're trying to avoid IIUC.


Thanks!

--
Qais Yousef

> 
> > -#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
> > +static inline bool fits_capacity(unsigned long util, unsigned long capacity)
> > +{
> > +	return approximate_util_avg(util, TICK_USEC) < capacity;
> > +}
> 
> [...]
> 
