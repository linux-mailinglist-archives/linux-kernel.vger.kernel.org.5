Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA807A3270
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjIPUae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjIPUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:30:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD7CE3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:30:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32008e339adso310749f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694896203; x=1695501003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mv4crFclQdEkZGsP8km6uD1B/Et729oV33YEvfH1Us=;
        b=mmbyU89odPstwynsAjdTzeZ0rxhsX9aWML8hUKhYx4mZT+r3eYHjBtmsRtIyrTZ5RN
         6KjHOFrt9Lc6C3aglTOSNEHwOP2miysik6VBUqppJLIKigHxRRDh2eUnlVWqDhZ+dbhi
         1uNiPEQVH7Nw9T4RoxY215JHbPUK1U388j1aaqEi35bkx5iP/Bm3br5hni+q4pBukBau
         ASRbpQmAOnhatcmng7lIA06or+0yU+VdNjU4zVkE60IWywzjWgNbI8sdRxggM6s/pppj
         rXhhaXRiJVMMD6x8Ggqm6BW1AWLnNDKwzaiCuImZhlQQo9c+WURATGT1wl/iypDtOzos
         3BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694896203; x=1695501003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mv4crFclQdEkZGsP8km6uD1B/Et729oV33YEvfH1Us=;
        b=QFSFaQsVptyNzIUHmPCf3L+/JljYqLhqCqz1CE0p5vmz1L0lPVFCceQBD8Uvj/rdKf
         5fDxu4lDXFBMfkCS6iTHY48gTtCmYAmJ9hb+0u2c33m2U268HlYVEs9KHfTEVWCXYbnH
         En+Wi6JAYZGZA30o7vCdjeVGKPmrdUWhoXnl9FSUBbXEnSgb6bdsilx6WaMM7ZjhjNfT
         XOSBFXkbGjIE8LAiOZKGaZZlh+vHpJYORl4jc4bGSmDAQgIB66oRnh40L04szgTdSair
         5TS8VkyIG892tcnP6YCsmKCtXwvnn1k+3kn0VYJhcY52UZPEOr8OKb14Au7UrtqdsCko
         dKeg==
X-Gm-Message-State: AOJu0YxbZBrWZDnnytNImi5187lR4FmoWqStOyTJJ+ObI6kgJmZ1v12K
        2Itm7yTq97VeYLr7FVNMHhGaGg==
X-Google-Smtp-Source: AGHT+IFhZjAVFGkFjpwnV99v5Q1I2ryBCXVW3gFbSyjtkwV3ZkbK8w+QJzpwIdshXWfKVm7OG77/yQ==
X-Received: by 2002:a5d:484a:0:b0:319:f9d6:a769 with SMTP id n10-20020a5d484a000000b00319f9d6a769mr4118351wrs.45.1694896202693;
        Sat, 16 Sep 2023 13:30:02 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id q2-20020adff782000000b00317f70240afsm7940655wrp.27.2023.09.16.13.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 13:30:02 -0700 (PDT)
Date:   Sat, 16 Sep 2023 21:30:00 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230916203000.ulngn5huefndb2cq@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <7839dd5f-e7fd-7065-934d-436d012ac9d6@arm.com>
 <20230826200829.gnha7xcrjbyipjr2@airbuntu>
 <ecbd165e-4213-8dd4-d5b5-309256cc64a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecbd165e-4213-8dd4-d5b5-309256cc64a9@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/23 16:34, Dietmar Eggemann wrote:

> No that's not what I wanted to say here.
> 
> I wanted to highlight the different treatment of `(1) a task with
> (natural) util = 800` and `(2) a task with uclamp_max = 800`.
> 
> (1) util = 800
> 
> util = (1.25 * 800 * (1024 - irq) / 1024 + ...
> 
>         <-      ->
>         uclamped(cfs+rt+headroom(cfs+rt))
> 
> 
> (2) uclamp_max = 800
> 
> util = (800 * (1024 - irq) / 1024 + ...
> 
>         <->
>         uclamped(cfs+rt+headroom(cfs+rt))
> 
> So for (1) the scheduler would ask for more than in (2).

Yes, which is the intention IMHO. If they behave the same, then uclamp_max is
not doing anything. And really this is the critical region in the system as
this is where the expensive OPPs lie.

> 
> That's essentially the same question which was raised here:
> 
> https://lkml.kernel.org/r/CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com
> 
> >>> Note that similar problem exist for uclamp_min. If util was 50, and
> >>> uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> >>> constraints, we'll end up with util of 125 instead of 100. IOW, we get
> >>> boosted twice, first time by uclamp_min, and second time by dvfs
> >>> headroom.
> >>
> >> I see what you want to change here but:
> >>
> >> So far we have `util -> uclamp -> map_util_to_perf()`
> > 
> > :-O
> > 
> > So when I set the system uclamp_max to 800 it will still run at max; and this
> > is normal?!!
> 
> No that's an issue (A) as well. But the diff between (1) and (2) is IMHO a
> new issue introduced by this patch-set.

It is also the problem to fix :-)

> 
> >> which is fine when we see uclamp as an entity which constrains util, not
> >> the util after being mapped to a capacity constraint.
> > 
> > -ENOPARSE.
> 
> What I meant is 'clamping the util' before scheduler hands over to
> 'cpufreq' is fine:
> 
>     util -> uclamp -> map_util_to_perf()
>                
>     scheduler    -->|<-- cpufreq
> 
> I do understand that you guys are already discussing a new
> cpufreq_give_me_freq_for_this_utilization_ctx() between EM and CPUfreq
> in the other thread of this patch to maybe sort out (A).

This will help with abstraction. But behavior wise, I still think that if
a task (or a cgroup, the system) has uclamp_max to 800, then we should not run
faster than this because of dvfs headroom.

If we don't do this then max performance is effectively mapped at anything at
800 and above. And likely less than that.

For example if

	util@OPP[Fmax-1] = 950

then any util value at

	util = 950 * 0.8 = 760

will saturate the system and run at Fmax, because all values from above 950
will map to Fmax, and because of the headroom this becomes all values at 760 or
above.

This mean from user's perspective uclamp_min and uclamp_max is from 0-760 on
that system. But the abstraction we're providing is that the performance range
is from 0-1024.

If uclamp_min is set to 512 and the task has a util of 100, why should we run
at 512*1.25?

Similarly if uclamp_max wants to cap the task/cgroup/system from consuming the
top resources, why it needs the 1.25 headroom? If there are two tasks running
on the CPU and one of them is not capped, then yeah the headroom will be
applied. But if the rq->uclamp[UCLAMP_MAX] = 800, then the vote from freq from
this CPU should not exceed this. I don't see what the headroom is for in this
case.

As another example, do you expect a task that has a util of 1024 but uclamp_max
= 800 to run at max or at an OPP equivalent to 800 which would be 2 or 3 below
Fmax usually? The latter is the expectation from the interface. Users shouldn't
need to know there's a dvfs headroom and cater for that when they set
uclamp_max or uclamp_min.


Thanks!

--
Qais Yousef
