Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEBB794507
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbjIFVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjIFVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:19:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54510DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:19:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4018af103bcso1269205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694035178; x=1694639978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTk4fQkjzkLPlExwStkwtcKGb9ynOb6VnOA9ptrSjH4=;
        b=vWsUlGr35cwTAy+4mLlR3iuI6534sWeinDXy+YkR0mf5gMEbm3hOufvdHNrVjQR0BR
         E8GlcjN6371IyetSV4KgAMveIITjK+Sqec5U3Q4dt1VtGbZKmc5I0+umuDcLUbs13Dy/
         krf/mHYmgssAyfTdN/22ECh3aR1WN3gBhTVA1fhlOqsqQvyP3TMN+aP/YTR6bWyTUKYg
         hPVvDCrkmFA3KzGzCUc1u5DF9Ma9Mn0weqA849Bi32egXqyDOuLiVhzQcCR+eXpZTCOc
         ADYP8IeH6cETNiyKm9HhzwLIp26x4Re5JgSoh2qfY8c7f/FKX7aNlkAFwBjhsLIppvQi
         hRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694035178; x=1694639978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTk4fQkjzkLPlExwStkwtcKGb9ynOb6VnOA9ptrSjH4=;
        b=MZAhbp09azyUZ3B8c22202O0hHBR7O18WVf8kQlIjblyOkQpU8Qwim+L24xLaO97X0
         ZJ7fgO78Vv9oe/OS3mMaL5xRt2X2XMDme6qcKG2mq5R0s7ipYLj9dtalmLY5fEfRQqdu
         XoQmVOCglSdfon2f5VfvTG7IpRLhE2rLECzlm+EYLmd+oYlcpDSCpQSc00AgOiOWKSHz
         5+zwsa+nwR1g+rIK4DAeFdRrHWp4HppoSaIH9TwpLmtkir5nQ5lDi3CVsFVw31d69Pex
         tyA9oaOXzKnVGCRuBzomC8pk/ZLL/cMnQU6S8UtZcCB/FsMYt3m98skUzUgquG8ksJ6o
         6u5g==
X-Gm-Message-State: AOJu0Yw1BAM5Cb5cNUU03t+4Z/rhtDg+0VyV4Cs5oyodU4RxOGJfnaA+
        suwNvClaBu/DRsUMp2VpTfvJTg==
X-Google-Smtp-Source: AGHT+IF/qpCs3vHa9I97wD03zSgTjWT8Vvf0CUxhK6cBlFEypXbByVnyZZAovmz27c3gbALcDqfaMg==
X-Received: by 2002:a05:600c:3b8f:b0:402:b8:d022 with SMTP id n15-20020a05600c3b8f00b0040200b8d022mr485755wms.16.1694035177444;
        Wed, 06 Sep 2023 14:19:37 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003fe3674bb39sm612550wml.2.2023.09.06.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:19:37 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:19:36 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 1/7] sched/pelt: Add a new function to approximate
 the future util_avg value
Message-ID: <20230906211936.yqejc25czc6tddm6@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-2-qyousef@layalina.io>
 <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 14:56, Dietmar Eggemann wrote:
> On 28/08/2023 01:31, Qais Yousef wrote:
> > Given a util_avg value, the new function will return the future one
> > given a runtime delta.
> > 
> > This will be useful in later patches to help replace some magic margins
> > with more deterministic behavior.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/pelt.c  | 22 +++++++++++++++++++++-
> >  kernel/sched/sched.h |  3 +++
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index 0f310768260c..50322005a0ae 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -466,4 +466,24 @@ int update_irq_load_avg(struct rq *rq, u64 running)
> >  
> >  	return ret;
> >  }
> > -#endif
> > +#endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
> > +
> > +/*
> > + * Approximate the new util_avg value assuming an entity has continued to run
> > + * for @delta us.
> > + */
> > +unsigned long approximate_util_avg(unsigned long util, u64 delta)
> > +{
> > +	struct sched_avg sa = {
> > +		.util_sum = util * PELT_MIN_DIVIDER,
> > +		.util_avg = util,
> > +	};
> > +
> > +	if (unlikely(!delta))
> > +		return util;
> > +
> > +	accumulate_sum(delta, &sa, 0, 0, 1);
> 
> IMHO, you miss the handling of `periods != 0`. load = 0 eclipses this
> code in accumulate_sum().

Yes. For some reason I got blank registered when I saw if this codepath can
impact util_avg..

> 
> > +	___update_load_avg(&sa, 0);
> > +
> > +	return sa.util_avg;
> > +}
> 
> We already discussed something similar like this in Nov 22, the so
> called UTIL_EST_FASTER thing.
> 
> https://lkml.kernel.org/r/Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net
> 
> +/*
> + * Compute a pelt util_avg assuming no history and @delta runtime.
> + */
> +unsigned long faster_est_approx(u64 delta)
> +{
> +	unsigned long contrib = (unsigned long)delta; /* p == 0 -> delta < 1024 */
> +	u64 periods = delta / 1024;
> +
> +	if (periods) {
> +		delta %= 1024;
> +		contrib = __accumulate_pelt_segments(periods, 1024, delta);
> +	}
> +
> +	return (contrib << SCHED_CAPACITY_SHIFT) / PELT_MIN_DIVIDER;
> +}
> +

I could look at using this version instead. This misses the decay part though?


Thanks!

--
Qais Yousef
