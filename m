Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3014794570
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbjIFVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjIFVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:52:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B5E7C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:52:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-402e7968042so3171045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694037142; x=1694641942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaOpd7rKwkNWd/NacwCollMXoUTLMbCO6PfeyOGcxS0=;
        b=J2WfZCB8dAuu/qUFuUfG66snP2s+l66CCRjrsfGsiALoLXyTlksc+DW/2kON3XzBiS
         i3YO2Ww8ZfoOomMAadiYsDHokdnknl4xbGaw8MHl5s+VuSVuyFQWRrGrXSDggztD6zxr
         MFRxtBqh686X0romGnWVe5dg70u0CzPxoFCwLliTx6OSdQFalVjDt2XmRlA4KaIw9in4
         cHfEo89udhu+UAPORKWuHx6+mQSsl/Av/H9QvxncfkxiXR5gVpQN1zZBVdynhEg1Z0ki
         Xin/luxOlyUlPuOWtyXYrtsCdyZGBgDknp4qQEpPyMJAUsrIwXpQkBdhlSCCT2UHL23Q
         pXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694037142; x=1694641942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaOpd7rKwkNWd/NacwCollMXoUTLMbCO6PfeyOGcxS0=;
        b=bOosZOganxEsM+qCz4qDFYfDaPsWQAlBHhOIYjeaeYqi+qxrKor5OyDb8HiGb4dZI5
         Bwt8Mb7GUNj88ined3WKNU6uJ9moNtygOVlZkFx+PxXVpM3cmJ8BZsQ2diZvgnnTRaOY
         YDGLFu3yL7bMo6ysS2dnGn2Bkd14PZDm8GJVBO6u+xGPOPpWNgYVMIIXM5uknoYWzSil
         BDZ1YciOVLX6iYXZ9lu/cULRmcKlDtL8W1GzKKFzy5c+wwDvWaF1WbhrLJVfdr4yZjap
         PQV9kgcrFPQ3vP6sdEnR9wVy/LtVQJU++1j5Z5hXeb5407ZaTXKGgUDDZzdWwTZiQiGw
         xjtA==
X-Gm-Message-State: AOJu0YylIRn4YhP+aphjRWjHd1QZ5NdOngX1x+g+XZO9GEbNpXSlBKwq
        CTxP/0q/+Qv9hQW3WdkOcDx2rJnlXTlUm/8IHwE=
X-Google-Smtp-Source: AGHT+IEwJpSWusxjZ/VtGbSCIGhpWnvlPBwm2Ot9wm7HAQvMUvQ2Pjj652nC190bRuijgqWi9GsXGQ==
X-Received: by 2002:a7b:cd1a:0:b0:3f9:255e:ee3b with SMTP id f26-20020a7bcd1a000000b003f9255eee3bmr3031793wmj.30.1694037142295;
        Wed, 06 Sep 2023 14:52:22 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fe24441e23sm658599wmj.24.2023.09.06.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:52:21 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:52:20 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 5/7] sched/schedutil: Add a new tunable to dictate
 response time
Message-ID: <20230906215220.65em2kgyr76s7sz2@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-6-qyousef@layalina.io>
 <60a21021-87c5-b93d-4312-d41fbcd4ec43@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a21021-87c5-b93d-4312-d41fbcd4ec43@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 23:13, Dietmar Eggemann wrote:
> On 28/08/2023 01:32, Qais Yousef wrote:
> 
> [...]
> 
> > @@ -427,6 +427,23 @@ This governor exposes only one tunable:
> >  	The purpose of this tunable is to reduce the scheduler context overhead
> >  	of the governor which might be excessive without it.
> >  
> > +``respone_time_ms``
> > +	Amount of time (in milliseconds) required to ramp the policy from
> > +	lowest to highest frequency. Can be decreased to speed up the
> > +	responsiveness of the system, or increased to slow the system down in
> > +	hope to save power. The best perf/watt will depend on the system
> > +	characteristics and the dominant workload you expect to run. For
> > +	userspace that has smart context on the type of workload running (like
> > +	in Android), one can tune this to suite the demand of that workload.
> > +
> > +	Note that when slowing the response down, you can end up effectively
> > +	chopping off the top frequencies for that policy as the util is capped
> > +	to 1024. On HMP systems where some CPUs have a capacity less than 1024,
> 
> HMP isn't used in mainline AFAIK. IMHO, the term `asymmetric CPU
> capacity` systems is used.

It's a shorter name and less mouthful and typeful; I think we should start to
use it :)

> 
> [...]
> 
> > @@ -59,6 +61,45 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> >  
> >  /************************ Governor internals ***********************/
> >  
> > +static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
> > +{
> > +	int cpu = cpumask_first(sg_policy->policy->cpus);
> > +	unsigned long cap = capacity_orig_of(cpu);
> > +
> > +	return approximate_runtime(cap);
> > +}
> 
> I can see the potential issue of schedutil being earlier initialized
> than the `max frequency scaling of cpu_capacity_orig` happens in
> drivers/base/arch_topology.c.
> 
> So the response_time_ms setup for a little CPU on Juno-r0 wouldn't
> happen on cpu_capacity_orig = 446 -> 26ms but on on the raw capacity
> value from dt:
> 
>     capacity-dmips-mhz = <578>
> 
> So I would expect to see t = 32ms * ln(1 - 578/1024)/ln(0.5) = 38ms instead.
> 
> We have a similar dependency between `max frequency scaled
> cpu_capacity_orig` and the EM setup code.

Hmm thanks for the pointer! That might help explain why I see wrong values for
the big core in my setup.

Should using arch_scale_cpu_capacity() help instead? Or I need to find a way to
plug the race instead?


Thanks!

--
Qais Yousef
