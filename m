Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F57987EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbjIHNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjIHNdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:33:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BFB1BF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:33:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f853f2f3aso109627f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694180019; x=1694784819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=joeU9X2o2afqwXlDEexVmj+q2gNMuVR1pRxUUt8KS9I=;
        b=T2NKHAPcB4Zm66HrmgOGqd5RqtXaW5Ddv8NJnJttifvJQebBY2ebxCe4sNWX77PcQr
         ltR5OYc9315uPLTGleTsIiMH767fEw+FVXoPmPRZFe19W3yw+WJHrZHM7I6YJnkSuN3b
         3QQ1KKuJyvF096krS2oInqm4x9olMuch5xTF922XJblWrVUGaXqTc3mDYVtJ/p0FqEHy
         pIvD6P5mSYjFBd6ytD8r6C6bEeW9EVW5emkNJsotSxgTy861vdSp1Hz4r6WGTvmpWdch
         Q8MhI1xXMeqtm2I7ETf1jK6OnIu/b2mkfa2ChsfrkjT9THZZAk4JKzHzb/dbdhoA1aJo
         Druw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694180019; x=1694784819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joeU9X2o2afqwXlDEexVmj+q2gNMuVR1pRxUUt8KS9I=;
        b=sn80eDODtN2aWyeWh2AUSi3WfAQZrd4wtXZ7lxDx+seg6FNOb4AloMvqX0Lpj8OjOP
         C5xuosQSrPMwubqRghye4uwF54ZIukfdW8hQ08U7BkkMiiE1YtS57ZmuFvOnHZ3ZvmEO
         n0D1/LIvszlqyT4OlWcyXrg9M+blNc/RPBJgb1EIpVxo+0MAPFAKEUM7HbHKNWgyW3Na
         ZTjkQjeCobyOxlJZVKhjKefrKLOeRLLvVNQAqSDEngHBxe9rC/Mn77lCF59vpSs97t4d
         bGVPnrQoOQpOJJbuSwyPFlDLWAWKfetqx9leladbzyXrlQI8yJsaaEr8DANsyqBeF3rC
         J+lQ==
X-Gm-Message-State: AOJu0Yzx1USl/SShGl40cKvwkz9uqAyak1fX49I+O0Vmy/xtxk50DfzY
        3GMpbLiW0eOX+olejzTg9i/Zjw==
X-Google-Smtp-Source: AGHT+IGq3KSX1uCkf4fEt/m7tAhbX7vuGT9Imb16yiR8pYMM0N9JdXKw5qL8YRMJnHk0+nTt5ikGOA==
X-Received: by 2002:adf:f24d:0:b0:30f:c1fa:7901 with SMTP id b13-20020adff24d000000b0030fc1fa7901mr1710891wrp.5.1694180018568;
        Fri, 08 Sep 2023 06:33:38 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id o14-20020adfeace000000b003197869bcd7sm2131144wrn.13.2023.09.08.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:33:38 -0700 (PDT)
Date:   Fri, 8 Sep 2023 14:33:36 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908133336.uge4hcnx4cum3lg5@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <20230908102511.GA24372@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908102511.GA24372@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 12:25, Peter Zijlstra wrote:
> On Fri, Sep 08, 2023 at 01:17:25AM +0100, Qais Yousef wrote:
> 
> > Just to be clear, my main issue here with the current hardcoded values of the
> > 'margins'. And the fact they go too fast is my main problem.
> 
> So I stripped the whole margin thing from my reply because I didn't want
> to comment on that yet, but yes, I can see how those might be a problem,
> and you're changing them into something dynamic, not just removing them.

The main difficulty is that if you try to apply those patches on their own, I'm
sure you'll notice a difference. So if we were to take this alone and put them
on linux-next; I expect a few regression reports for those who run with
schedutil. Any ST oriented workload will not be happy. But if we compensate to
reduce the regression, my problem will re-appear, just for a different reason.
So whack-a-mole.

I didn't know how to make both happy without being dynamic, hence the RFC to
hopefully get some help and insights on how to resolve this. I think I'm
hovering around the right solutions, but not sure if I'm there yet. Some
implementation details certainly still need ironing out.

I genuinely think that we should be more conservative in adding those hardcoded
numbers without making them a function of real limitation.

TEO util threshold for instance has a similar problem to these margins.
I backported them to 5.10 and 5.15 and not long after I had to introduce knobs
to allow tuning them as power regression reports surfaced. The good news it
wasn't a full revert; the bad news those numbers seemed best for a class for
workloads on a particular system, but on another system and different
workloads, the reality will be different. And of course because Android has out
of tree patches; I need to spend a good amount of time before I can report back
properly to ensure the root cause is identified correctly. I will risk
a potentially incorrect statement, but I do hold to question the validity of
these hardcoded numbers on all systems and all workloads.

I am not sure we can avoid being dynamic; and personally I prefer to delegate
more to userspace and make it their problem to manage this dynamism. But by
providing the right tools of course :) I think they need to earn their best
perf/watt too; not let the kernel do all the dirty work, hehe.

> The tunables is what I worry most about. The moment we expose knobs it
> becomes really hard to change things later.

I'm not particularly attached to them to be honest. But at the same time I am
not sure if we can get away without giving the user some power to decide. What
I propose what seemed the most sensible way to do it. But really open to
explore alternatives and I do indeed need help to find this.

Generally; I think userspace expects too much automagic and the programming
model is ancient and not portable and we end up overcompensating for that in
the kernel. So giving them some power is necessary the way I see it, but the
shape and form it should take is debatable for sure. I don't claim to have the
right answer but happy to explore and experiment to get the right ones
identified and done :-)

> 
> > UTIL_EST_FASTER moves in one direction. And it's a constant response too, no?
> 
> The idea of UTIL_EST_FASTER was that we run a PELT sum on the current
> activation runtime, all runtime since wakeup and take the max of this
> extra sum and the regular thing.
> 
> On top of that this extra PELT sum can/has a time multiplier and thus
> ramps up faster (this multiplies could be per task). Nb.:
> 
> 	util_est_fast = faster_est_approx(delta * 2);
> 
> is a state-less expression -- by making
> 
> 	util_est_fast = faster_est_approx(delta * curr->se.faster_mult);
> 
> only the current task is affected.

Okay; maybe I didn't understand this fully and will go back and study it more.

Maybe the word faster is what makes me worried as I really see faster is not
what people want on a class of systems; or at least CPUs if you think of HMP.
Taming the beast is a more difficult problem in this class of systems.

So if I get it correctly; we will slow things down by removing these margins,
but people who suffer from this slow down will need to use util_est_faster to
regain the difference, right?

> 
> > I didn't get the per-task configurability part. AFAIU we can't turn off these
> > sched-features if they end up causing power issues. That what makes me hesitant
> > about them. 
> 
> See above, the extra sum is (fundamentally) per task, the multiplier
> could be per task, if you set the multiplier to <=1, you'll never gain on
> the existing sum and the max filter makes that the feature is
> effectively disabled for the one task.

Gotch ya. I think this could work, but it also seems to overlap with what we
can get already with uclamp. If we can tell this task needs a faster
multiplier, we can tell that it needs better uclamp_min and do that instead?
When should we use one over the other if we add both?

The challenging bit in practice is when we need to get some generic auto
response for all these workloads that just expect the system to give them what
they want without collaboration. I really do hope we can provide alternative to
make these expectations obselete and just be able to tell userspace your app is
not portable, go fix it; but we're not there yet.

And another selfish reason; analysing workloads is harder with these. We have
a lot of mechanisms on top of each others and reasoning about a cause of
a power issue in particular becomes a lot harder when something goes wrong on
one of these and gets bubbled up in subtle ways. Perf issues tend to be more
obvious; but if something cause power or bad thermals, then finding out if
there's sub optimality is hard. And if I find one, fixing it will be hard too.

> It of course gets us the problem of how to set the new multiplier... ;-)

I am actually trying to write a proposal for a generic QoS interface that we
potentially can plumb these things into (main motivation is wake up latency
control with eevdf - but seems you might be pushing something out soon). My
perception of the reality is that userspace is stuck on old programming model
and *a lot* of bad habits. But I think it is about time for it to get smarter
and more collaborative. But this necessities we give some mechanisms to enable
this smarter approach.

> 
> > There's a bias towards perf. But some systems prefer to save power
> > at the expense of perf. There's a lot of grey areas in between to what
> > perceived as a suitable trade-off for perf vs power. There are cases like above
> > where actually you can lower freqs without hit on perf. But most of the time
> > it's a trade-off; and some do decide to drop perf in favour of power. Keep in
> > mind battery capacity differs between systems with the same SoC even. Some ship
> > to enable more perf, others are more constrained and opt to be more efficient.
> 
> It always depends on the workload too -- you want different trade-offs
> for different tasks.

Indeed. We are trying to push for better classification of workloads so that we
can tell with reasonable confidence a certain trade-off is better for them.
Which what it really helps with is enable better use of resources with the
pre-knowledge that the current user experience won't be impacted.

Again, I really ultimately would love to see userspace becoming smarter and
delegate the task of writing portable and scalable software that works across
systems without the need for guess work and hand tuning. I think we're making
good steps in that direction, but we still need a lot more effort.

> 
> > > I'm *really* hesitant on adding all these mostly random knobs -- esp.
> > > without strong justification -- which you don't present. You mostly seem
> > > to justify things with: people do random hack, we should legitimize them
> > > hacks.
> > 
> > I share your sentiment and I am trying to find out what's the right thing to do
> > really. I am open to explore other territories. But from what I see there's
> > a real need to give users the power to tune how responsive their system needs
> > to be. I can't see how we can have one size that fits all here given the
> > different capabilities of the systems and the desired outcome (I want more perf
> > vs more efficiency).
> 
> This is true; but we also cannot keep adding random knobs. Knobs that
> are very specific are hard constraints we've got to live with. Take for
> instance uclamp, that's not something we can ever get rid of I think
> (randomly picking on uclamp, not saying I'm hating on it).

I'm really open to explore alterantives. But need help to find them. I'm also
trying to simplify kernel responsibilities by delegating more to uerspace.
It could be a personal mental hung up, but I can't see how can we have one size
fits all. Almost all types of systems are expected to do a lot of varying
workloads and both hardware and software are moving at faster pace, but
programming model is pretty much the same.

The response_time_ms in schedutil seemed a reasonable knob to me as it directly
tells the user how fast they rampup for that policy. It can be done once at
boot, or if someone has knowledge about workloads they can be smart and find
the best ones for them on a particular system. The good news for us in the
kernel is that we won't care. uclamp for really smart per task control, and
this knob for some hand tuning for those who don't have alternatives is the way
I see it.

> 
> From an actual interface POV, the unit-less generic energy-vs-perf knob

I can see this working for mobile as SoC vendors/OEM can get energy for their
systems and define these curves properly.

But average joe will lose out. For example M1 mac mini doesn't have energy
model actually defined. I do have energy meter so I hope to be able to do some
measurement, but not sure if I can get accurate numbers out.

x86 and other archs don't tend to produce as good energy-vs-perf curves like we
tend to see in mobile world (maybe they do and I'm just ignorant, apologies if
this ends up being a bad blanket statement).

Don't you think we could end up making the bar high to define this knob? It is
less intuitive too, but this is less of a problem maybe.

> is of course ideal, one global and one per task and then we can fill out
> the details as we see fit.  System integrators (you say users, but

Can certainly look at that and it sounds reasonable to me, par the issues above
about it requires more effort and good class of Linux users might not see these
definitions on their systems as there's no real system integrators for a large
class of desktop/laptop systems. It'd be nice to make the programming
experience coherent and readily available, if possible. I think these systems
are losing out.

> really, not a single actual user will use any of this) can muck about
> and see what works for them.

Yes I mean system integrator. I use users maybe bcause I do think of desktops
too as the integrator for them is the end users. I do hope to see more vendors
do ship tuned Linux desktops/laptops like we see in Android world. Servers
probably have an army of people managing them anyway.

> 
> (even hardware has these things today, we get 0-255 values that do
> 'something' uarch specific)

Ah, could I get some pointers please?

> 
> > The problem is that those 0.8 and 1.25 margins forces unsuitable default. The
> > case I see the most is it is causing wasting power that tuning it down regains
> > this power at no perf cost or small one. Others actually do tune it for faster
> > response, but I can't cover this case in detail. All I know is lower end
> > systems do struggle as they don't have enough oomph. I also saw comparison on
> > phoronix where schedutil is not doing as good still - which tells me it seems
> > server systems do prefer to ramp up faster too. I think that PELT thread is
> > a variation of the same problem.
> > 
> > So one of the things I saw is a workload where it spends majority of the time
> > in 600-750 util_avg range. Rarely ramps up to max. But the workload under uses
> > the medium cores and runs at a lot higher freqs than it really needs on bigs.
> > We don't end up utilizing our resources properly.
> 
> So that is actually a fairly solid argument for changing things up, if
> the margin causes us to neglect mid cores then that needs fixing. But I
> don't think that means we need a tunable. After all, the system knows it
> has 3 capacities, it just needs to be better at mapping workloads to
> them.

We can fix the misfit capacity without a tunable, I believe. I just know from
past discussions that those low end systems like these to be large. And the
PELT boot time is to help address this potential issue. Happy to leave it out
and leave it to someone who cares to come and complain. But from theoertical
point of view I can see the problem of slow response on those systems. And
capacities don't tell us much if this is a high end SoC or lower end SoC. Nor
util or anything else we have in the system today, to my knowledge at least.

> 
> It knows how much 'room' there is between a mid and a large. If 1.25*mid

Ideally we should end up distributing on mids and bigs for the capacity region
that overlaps.

I do see that the needs to have the margin is related to misfit migration and
we can fix it by improving the definition of this relationship. I'm not sure if
I implemented it in the best way, but I think the definition I'm proposing
makes sense and removes guess work. If the task is 600 and fits in both mids
and bigs, why should we skip the mids as a candidate if no misfit can happen
very soon by next tick? If current implementation is expensive I think I can
make it cheaper. But if no misfit can happen within tick, I think we need to
consider those CPUs as candidates.

On a slightly related problem that I avoided bringing up but maybe a good time
now. I see the definition of overutilized is stale too. It is a wrapper around
fits_capacity(), or misfit detection. It is very easy for a single busy task to
trigger overutilized. And if this task is background and capped by cpuset to
little cores, then we end up overutilized until it decides to go back to sleep.
Not ideal. I think the definition needs revisiting too, but I have no idea how
yet. It should be more of a function of the current system state rather than
tightly coupled with misfit detection. EAS is disabled when we're overutilized
and default spreading behavior can be expensive in terms of power.

> > large we in trouble etc..
> 
> > There's a question that I'm struggling with if I may ask. Why is it perceived
> > our constant response time (practically ~200ms to go from 0 to max) as a good
> > fit for all use cases? Capability of systems differs widely in terms of what
> > performance you get at say a util of 512. Or in other words how much work is
> > done in a unit of time differs between system, but we still represent that work
> > in a constant way. A task ran for 10ms on powerful System A would have done
> > a lot more work than running on poor System B for the same 10ms. But util will
> > still rise the same for both cases. If someone wants to allow this task to be
> > able to do more on those 10ms, it seems natural to be able to control this
> > response time. It seems this thinking is flawed for some reason and I'd
> > appreciate a help to understand why. I think a lot of us perceive this problem
> > this way.
> 
> I think part of the problem is that todays servers are tomorrow's
> smartphones. Back when we started all this PELT nonsense computers in
> general were less powerful than they are now, yet todays servers are no
> less busy than they were back then.
> 
> Give us compute, we'll fill it.

Hehe, yep!

> 
> Now, smartphones in particular are media devices, but a large part of
> the server farms are indirectly interactive too, you don't want your
> search query to take too long, or your bookface page stuck loading, or
> you twatter message about your latest poop not being insta read by your
> mates.
> 
> That is, much of what we do with the computers, ever more powerful or
> not, is eventually measured in human time perception.

Sadly I do think a lot of workloads make bad assumptions about hardware and
kernel services and I think the past trend has been to compensate for this in
the kernel but the true problem IMHO is that our current programming model is
stale and programs are carrying old bad habits that are no longer valid.

As a simple example a lot has struggled with HMP systems as they were assuming
if I have X cores then I can spawn X threads and do my awesome parallel work.

They of course got caught out badly. They used affinity later to be smart about
which cores, but then as noted earlier the bigs are power hungry and now they
can easily end up in power and thermal issues because the past assumptions are
no longer true.

By the way even the littles can be power hungry at top frequencies. So any form
of pinning done is causing problems. They just can't make assumptions. But what
to do instead then?

ADPF and uclamp is the way to address this and make portable software and
that's what being pushed for. But flushing these old habits out will take time.
Beside I think we still have ironing out work to be done.

Generally even in desktop/laptop/server, programmers seem to think they're the
only active app and get greedy when creating tasks ending up tripping over
themselves. We need a smart middleware to manage these; or a new programming
model to abstract these details. I don't know how, but the status queue is
that programming model is lagging behind.

I think Windows and Mac OS/iOS do provide some more tightly integrated
interfaces for apps; see Grand Central Dispatcher for instance on apple OSes.

> 
> So yeah, 200ms.
> 
> Remember, all this PELT nonsense was created for cgroups, to distribute
> shared between CPUs as load demanded. I think for that purpose it still
> sorta makes sense.
> 
> Ofc we've added a few more users over time, because if you have this
> data, might as well use it etc. I'm not sure we really sat down and
> analyzed if the timing all made sense.

I think if we want to distill the problems to its basic form, it's a timing
issue. Too fast, we lose power. Too slow, we lose perf. And we don't have a way
to scale perf per systems. ie; what absolute perf we end up getting we don't
know and I'm not sure if we can provide at all without hardware extensions. So
that's why we end up scaling time, and end up with those related knobs.

> 
> And as I argued elsewhere, PELT is a running average, but DVFS might be
> better suited with a max filter.

Sorry didn't catch up with all other replies yet, but I will think how to
incorporate all of that in. I think the major issue is that we do need to both
speed up and slow down. And as long as we are able to achieve that I'm really
fine to explore options. What I'm presenting here is what truly seemed to me
the best. But I need help and feedback to do better :-)

> 
> > Happy to go and try to dig more info if this is still not clear enough.
> 
> So I'm not generally opposed to changing things -- but I much prefer to
> have an actual problem driving that change :-)

Good to know. If you think the info I shared are still not good enough, I can
look for more examples. I think my main goal here is really to discuss the
problem, and my proposed solution is a way to demonstrate both the problem and
a possible way to fix it so I'm not just complaining, but actively looking for
fixes too :-) I don't claim to have all the right answers, but certainly happy
to follow this through to make sure we fix the problem properly. Hopefully not
just for me, but for all those who've been struggling with similar problems.


Thanks!

--
Qais Yousef
