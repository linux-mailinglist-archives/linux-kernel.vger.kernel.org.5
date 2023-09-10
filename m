Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449D799F78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjIJTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjIJTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:25:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA60184
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:25:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f7400cb74so2918664f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694373902; x=1694978702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxa0537b1RUooeMFgOQd/d+dCKp1o61lGhIEpATiYB0=;
        b=Epw/k7kNBIkLDo8DGX2eyKiwiviezEkn3i4UbE7Pp3A9RYWfO2o11ExoWLmHczGKRz
         H0cTUUIhRfc7QAZyt1wmMQ3e6MnMhpicGeWXHNdC9fQk1qJ/nNiMmVbG9q0Yo+/YfmBe
         5carXTRyvnNmYXNErNxrkUzO5Mh4cB1GxORUrlTGElODSKfv9dJ/1ng9wVbFuljbvwCT
         sy1IwGiaYNGvqZN3Q1R2d0LrU5KXHkwMNvODzAMMZU8agyOM8C0MQ74ByhoN/Wp0skgy
         RKnfS+QO6EufBfyJP/FRqAnBGgU350DKO8n07oZJwTLaYk8V8Umf9z75Toxh47jlwiwt
         c2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694373902; x=1694978702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxa0537b1RUooeMFgOQd/d+dCKp1o61lGhIEpATiYB0=;
        b=TC5Yd8Wmd9iCkZhcmHXpXwx3GkS0i2gWu18RxRlG5u56pH4ZbiB90BSEUiMShyvYrP
         2dGcZvYGCIF8kVoO4tRIHaaeVWV+cGPiWtd9zvZKL2Dsm5HvhGKNhySaAG51a57uqIXL
         FhE+4vH+r+imau45IKRWqOYX8k/Ht3U5sZld0hUjq4C25Xt1kOt7XBAFUr8Kb4jg+qop
         p9Xxnghv3XdIFzwO50E0Gl6p/1d3+1GTj2bzJf4Hp1EkW4v0CXlgGUNIMc1f1MvNWPO4
         NRCZujbh7nlx6h+K73R2sqNMLWXUR6dV3qLnH4lRzspLhzDUHspJiUAT8IFWrukgCpu0
         CWeQ==
X-Gm-Message-State: AOJu0Yz0hgql9wLeqMPOb4pBH4Ntm7sLR/vY7zh+908cNoW5v6QSYVMx
        9q2Dh2pgdcCMHyfsxiLyKWWNfw==
X-Google-Smtp-Source: AGHT+IHN7QgXpILxQMdbz0wWQLDLZTmKAQaS/LrpT9Afx/CUNwd3Ed2RM4NGk86MSear5S1KNTKGdw==
X-Received: by 2002:adf:b188:0:b0:31f:a79c:2120 with SMTP id q8-20020adfb188000000b0031fa79c2120mr660316wra.68.1694373902659;
        Sun, 10 Sep 2023 12:25:02 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id z7-20020adfe547000000b0031c71693449sm8026673wrm.1.2023.09.10.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:25:02 -0700 (PDT)
Date:   Sun, 10 Sep 2023 20:25:01 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 5/7] sched/schedutil: Add a new tunable to dictate
 response time
Message-ID: <20230910192501.5gjytpiubiizu2uh@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-6-qyousef@layalina.io>
 <20230907114420.GC10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907114420.GC10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 13:44, Peter Zijlstra wrote:
> On Mon, Aug 28, 2023 at 12:32:01AM +0100, Qais Yousef wrote:
> > +static inline unsigned long
> > +sugov_apply_response_time(struct sugov_policy *sg_policy, unsigned long util)
> > +{
> > +	unsigned long mult;
> > +
> > +	if (sg_policy->freq_response_time_ms == sg_policy->tunables->response_time_ms)
> > +		return util;
> > +
> > +	mult = sg_policy->freq_response_time_ms * SCHED_CAPACITY_SCALE;
> > +	mult /=	sg_policy->tunables->response_time_ms;
> > +	mult *= util;
> > +
> > +	return mult >> SCHED_CAPACITY_SHIFT;
> > +}
> > +
> >  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  {
> >  	s64 delta_ns;
> > @@ -143,6 +184,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  	unsigned int freq = arch_scale_freq_invariant() ?
> >  				policy->cpuinfo.max_freq : policy->cur;
> >  
> > +	util = sugov_apply_response_time(sg_policy, util);
> >  	freq = map_util_freq(util, freq, max);
> >  
> >  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> 
> Urgh, so instead of caching the multiplier you keep computing what is
> essentially a constant over and over and over and over again :/
> 
> That is, compute the whole 'freq_response_time_ms * SCHED_CAPACITY_SCALE
> / response_time_ms' thing *once*, when that file is written to, and then
> reduce the whole thing to:
> 
> 	return (freq_response_mult * util) >> SCHED_CAPACITY_SHIFT;
> 
> No need for that special case, no need for divisions, just go.

Yes! I was too focused am I doing the right thing, I didn't stop to think this
is actually a constant and can be done once too. I will fix it if this knobs
ends up hanging around.


Thanks!

--
Qais Yousef
