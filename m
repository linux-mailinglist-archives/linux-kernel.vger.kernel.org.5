Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6B757D58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGRNYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGRNYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:24:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF74F4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:24:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso52453485e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689686674; x=1692278674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2l5FFah3jYSjLqjstwHtrt0TcczEdVlcCTTyaq83Sg=;
        b=ftXHGk6UZloCTM5CHVkVaUMgSOZSoH/5XZb0S0HvhrL7aDA53rwSmAQlBAzggptsHr
         KUg6fKmD95BI9Y91zjkPvW7fjNWvQjRsPAe7FmLApMDkubA/xTUsWHi/SINu6UFiVhor
         QLxIuyMRE5vMfOYAFB/mhTjyaocD5BIKOSp3Eoltd9vtNBX3s/FkwfCEKS7bCW56tVeO
         J2GhBau//K8k88kFeHaBCRnr0mTXk3leIMdTPMHum+WOl34eFbdbXVjajRlyk34M1HMC
         Y3kkYZsGU1aK1hJ8IBlI3dd5XC9uqkoKJJhqgqbmv45EyM+Ubs1FnmUvDyJ8HOTyhfD+
         ZU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686674; x=1692278674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2l5FFah3jYSjLqjstwHtrt0TcczEdVlcCTTyaq83Sg=;
        b=Qk4ZRJkZAIMMyzU9sy/XT2w0WGWCFk1E0IxE4Jir/GsMghCou9Vz2ZyKQ9h8gncxKO
         5ew2Vk0/Mz5okBBUP708R7SDGwRGzIRWKgWjGsMT/dXeBFRqThE2+5A0Ur5YYjtNStzU
         zyNlP28+lD8RlM7jsu9ZxzPpuwYrUZL2vgEvXerSN0rlSyRb3P/YWcYNNfQybmEM16PN
         Cf+2YEPjCFby1aBUkkEsv5KJ8sIyRw5GSMAwURn8hsptQKp/DJv0Y3uNwqa8oa9o2g+6
         DijN3XwZragA22n8S4561sGPZKwDFGIuuNbXt85erma19Lw6dpV7mkT+O6G5MLUlqwXW
         32Ng==
X-Gm-Message-State: ABy/qLZr7s7YwerCo05oYxmTvbJF2E0pvNzSdkbmGUqKQgYr8wkbWdfL
        w5L+diy1DMi9N7lxrCy0q4lllg==
X-Google-Smtp-Source: APBJJlGWv+ToOegiIFCS4/7/NEShK0AVDTUYaUjvklN4Utdi52zX5czKAgj4+Rl0H0Ag46DDceEHbg==
X-Received: by 2002:a7b:c3cf:0:b0:3fc:f9c:a3e2 with SMTP id t15-20020a7bc3cf000000b003fc0f9ca3e2mr2012392wmj.6.1689686673879;
        Tue, 18 Jul 2023 06:24:33 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c230c00b003fc01189b0dsm2162775wmo.42.2023.07.18.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:24:33 -0700 (PDT)
Date:   Tue, 18 Jul 2023 14:24:32 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/23 13:02, Kajetan Puchalski wrote:
> Hi Qais,
> 
> On Tue, Jul 11, 2023 at 06:58:14PM +0100, Qais Yousef wrote:
> > Hi Kajetan
> > 
> > On 01/05/23 14:51, Kajetan Puchalski wrote:
> > 
> > [...]
> > 
> > > @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> > >  			     struct cpuidle_device *dev)
> > >  {
> > >  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > > +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
> > >  	int i;
> > >  
> > >  	memset(cpu_data, 0, sizeof(*cpu_data));
> > > +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > 
> > Given that utilization is invariant, why do we set the threshold based on
> > cpu capacity?
> 
> Conceptually, the threshold is meant to represent a level at which the
> core is considered 'utilized'. I appreciate the definitions here can get
> a little fuzzy but I think of it as "generally doing a non-insignificant
> amount of work" even if there are currently no tasks scheduled on the core.
> This comes in handy in real-world workloads where the core will go
> through multiple cycles of busy-idle-busy-idle within each second.
> The intention here is to be able to distinguish a scenario of "going
> into idle for a few us because of the nature of the workload" from
> "going into idle for longer because there is no workload".
> 
> I set the threshold based on capacity because I think conceptually it
> makes more sense to say "every CPU is consireded to be utilized if the
> util is above X% of its capacity" than to effectively have a varying
> percentage based on the size of the core. 60 util is not that
> much work for a 1024-util big core but it's almost half the capacity of
> a little one, using a percentage/shift on capacity lets us account for that
> while using a raw value would not.

Thanks for the explanation.

I did try the busy perspective, but I think I still view this as 60util means
we've are running on average for X ms. which I think what matters more than how
much this is of a work to the big core. I look at this; we still have few ms
worth of runtime on the CPU and it's not worth going to deeper idle state
yet.

I can appreciate you think that this percentage of runtime should be lower for
smaller cores. My doubt (which again is not backed by real problem - so I'm not
questioning but rather trying to understand :)) is that if this becomes too low
is it better than letting usual TEO logic to operate. The series in its current
shape is great and offers good improvement already, no doubt :)

By the way, by default big will get a threshold of 16, the little will get
a threshold of around 2. I think the latter will translate to few hundreds of
us of activity (haven't done proper measurement to be honest, so this could be
off but I don't think  by much).

> 
> There's also very practical issues but I'll describe those below.
> 
> > I'm not sure if this is a problem, but on little cores this threshold would be
> > too low. Given that util is invariant - I wondered if we need to have a single
> > threshold for all type of CPUs instead. Have you tried something like that
> > while developing the patch?
> 
> Yes, the problem there is that it's very difficult to define what "too low"
> actually means :)

target residency maybe?

> Namely, do we define 'too low' based on the effects it has on
> performance in terms of latency, on the resulting power usage or on the
> prediction accuracy? In terms of the prediction accuracy, how do we
> weigh the two possible types of mispredictions? I'll just try to explain
> my thinking and how I got to my conclusions.
> 
> Based on my tests, on the types of platforms we both work with our
> state0/wfi is very power efficient to stay in, very power efficient
> to enter/exit and also very fast so it has very little impact on
> latency. On the other hand, state1 is power efficient to *stay in* but
> very costly to enter/exit in terms of *both* power and latency. The
> effect this has is that there's many cases where going through a cycle
> of busy-state1-busy-state1-busy and so on will actually use up more
> power than if you only kept the core in wfi.
> 
> I had some tests done with effectively making the governor do "return 0"
> in state selection, never using any state1 and the results were still
> pretty good, only slightly worse than e.g. menu. The problem there was
> that not using state1 on big cores would not leave them time to cool
> down and we'd burn through the thermal budget too quickly then tank the
> performance.
> 
> I don't have the numbers on hand but even completely disabling state1 on
> the entire little cluster will work perfectly fine - your latency for
> tasks that run on littles will improve and the thermal budget/power
> won't take a particularly noticeable hit because of how small they are
> in the first place.
> 
> This is why the governor is intentionally skewed towards shallower
> states, they just work better most of the time. If you try to skew it
> the other way the results just come out much worse because even a
> relatively small amount of mispredicted state1 entries can completely
> nullify any benefits that selecting state1 could bring.
> 
> The percentage approach does make the threshold for littles pretty small
> but as desccribed above that's perfectly fine, could say a feature not a
> bug :) If we tried setting a fixed one across all CPUs then we'd need to

I didn't think it's a bug. But it seemed too low, hence the question.
I actually thought a single value is enough for all CPUs since util is
invariant and the tipping point where TEO normal predictions should work should
be the same.

Thanks for the detailed explanation :)

> pick one high enough for the big cores which would end up being too high
> for the littles, lead to excessive state1 entries and all the issues
> I've just described. TLDR: there's just more downsides on the other side.

This is an artifact of the shifting algorithm you used to derive it. It is not
a real restriction. But I appreciate that simple approach proved to be good
enough, and I have nothing against it.

> 
> In development I just had a sysctl to set the threshold shift and iirc I
> tested values from 3 to 10-12 eventually arriving at 6 being the one
> with best results across different metrics and benchmarks. If you're
> backporting the patch somewhere and have a specific platform feel free
> to test it with different shift values, it's possible that different
> platforms will behave differently with this. I doubt there's any
> appetite to make the shift tweakable at runtime rather than a
> compile-time constant but if you'd like to push for that I'm happy to
> sign off on it, would work just as well as it does now.

These patches are in GKI. So we'll if there are uncaught problems I guess :)

No appetite for a knob, but the very low value for littles did strike me and
thought I better ask at least. Today's littles are too tiny for their own good
and it seemed the threshold could end up being too aggressive especially in low
activity state. You effectively are saying that if we have few 100us of
activity, normal TEO predictions based on timers are no good and better to stay
shallower anyway.

Note that due to NOHZ, if we go to idle for an extended period the util value
might not decay for a while and miss some opportunities. Especially that when
it next wakes up, it's enough for this wake up to run for few 100s us to block
a deeper state before going back to sleep for extended period of time.

But we shall see. I got the answer I was looking for for now.


Thanks for the help!

--
Qais Yousef
