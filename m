Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AA794506
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbjIFVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjIFVTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:19:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC63E172C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:18:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so3288025e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694035132; x=1694639932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ404al4WDQD3mH0iDuVts7w8k2DZJ9BRW045r0DG3s=;
        b=sqrqa+oNtkTDwfJ48wpz1xZkYlLjrsjZpsbSn9Xu+hOLTKwQgGyyLmiPy4s7J0MH5K
         lC15rICOtehlmDddPiiUy1N2niygg3kGOVe8/ubYbWaQUe8R4ujuxwfH3gNJYsmlp/ZM
         srjPmt7f81Zv6wkod/EwaOJdSUTMKkSqko1Km2ZAXUXuWN7yPCzIYVWDChCa5GSjjDec
         nkOTkYuUftFYXUJvztG04XZ5ll8pxYtQ794JyRCG39K11Pm2J5iJkzlTzEEXVKHTGSrx
         vZXUw767su21eHjVnFiO5YccFLcYyjMNHUxhgRMA4zWO9gDaNRjzKL2+ULHp19JHKqTS
         hKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694035132; x=1694639932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ404al4WDQD3mH0iDuVts7w8k2DZJ9BRW045r0DG3s=;
        b=ccnbR8xJYmZbszoy6W75LvtPAqNVD7F1SeBoioJUgTO4Khf6UZZCgCCUIV8qVdu5Id
         JiJeHL7PUNWOMOB5ps2sjly0sw5tE4KOhWQ6PyEkTBNrjTzqc3pwRisUgZZZRWSZZ1+U
         HVj4pKxsr3lhX7sk8wzjfCmFNrrenyWzniDRT/NgRzCpLkmrVxjlhidCITmgtPhxwW0p
         fO9PVtRQc+j12hexQCaZHo1abzCFhJ/sUEpBdevj0RGwvL1IADyI+LzAic24RkD4zAKV
         OmuPEG6ovG0xNCbwBQYNT/48dY4mQgFI49V3oWbifamTpLSEXlTg+fmUiZEPFz8VlEQg
         FPEA==
X-Gm-Message-State: AOJu0YwfTqMu6neMndyULg6T2tJztGvfTEmtwpcgX8hZJMaup1wEBfJr
        wHSGewPGgTD0eHp2AntpG88GUw==
X-Google-Smtp-Source: AGHT+IHIC9xo+qy2JSUyVNWgZgRalSRXOIOp7lDXK6uc1KMIpTujD/zrrNw2Yq2rRnqau8G53oKNXA==
X-Received: by 2002:a5d:6508:0:b0:319:7ac6:5161 with SMTP id x8-20020a5d6508000000b003197ac65161mr2891753wru.43.1694035132089;
        Wed, 06 Sep 2023 14:18:52 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003fef6881350sm599302wme.25.2023.09.06.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:18:51 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:18:50 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz

On 09/06/23 10:18, Lukasz Luba wrote:
> Hi Qais,
> 
> On 8/28/23 00:31, Qais Yousef wrote:
> > Since the introduction of EAS and schedutil, we had two magic 0.8 and 1.25
> > margins applied in fits_capacity() and apply_dvfs_headroom().
> > 
> > As reported two years ago in
> > 
> > 	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/
> > 
> > these values are not good fit for all systems and people do feel the need to
> > modify them regularly out of tree.
> 
> That is true, in Android kernel those are known 'features'. Furthermore,
> in my game testing it looks like higher margins do help to shrink
> number of dropped frames, while on other types of workloads (e.g.
> those that you have in the link above) the 0% shows better energy.

Do you keep margins high for all types of CPU? I think the littles are the
problematic ones which higher margins helps as this means you move away from
them quickly.

> 
> I remember also the results from MTK regarding the PELT HALF_LIFE
> 
> https://lore.kernel.org/all/0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com/
> 
> The numbers for 8ms half_life where showing really nice improvement
> for the 'min fps' metric. I got similar with higher margin.
> 
> IMO we can derive quite important information from those different
> experiments:
> More sustainable workloads like "Yahoo browser" don't need margin.
> More unpredictable workloads like "Fortnite" (shooter game with 'open
> world') need some decent margin.

Yeah. So the point is that while we should have a sensible default, but there
isn't a one size fits all. But the question is how the user/sysadmin should
control this? This series is what I propose of course :)

I also think the current forced/fixed margin values enforce a policy that is
clearly not a good default on many systems. With no alternative in hand but to
hack their own solutions.

> 
> The problem is that the periodic task can be 'noisy'. The low-pass

Hehe. That's because they're not really periodic ;-)

I think the model of a periodic task is not suitable for most workloads. All
of them are dynamic and how much they need to do at each wake up can very
significantly over 10s of ms.

> filter which is our exponentially weighted moving avg PELT will
> 'smooth' the measured values. It will block sudden 'spikes' since
> they are high-frequency changes. Those sudden 'spikes' are
> the task activations where we need to compute a bit longer, e.g.
> there was explosion in the game. The 25% margin helps us to
> be ready for this 'noisy' task - the CPU frequency is higher
> (and capacity). So if a sudden need for longer computation
> is seen, then we have enough 'idle time' (~25% idle) to serve this
> properly and not loose the frame.
> 
> The margin helps in two ways for 'noisy' workloads:
> 1. in fits_capacity() to avoid a CPU which couldn't handle it
>    and prefers CPUs with higher capacity
> 2. it asks for longer 'idle time' e.g. 25-40% (depends on margin) to
>    serve sudden computation need
> 
> IIUC, your proposal is to:
> 1. extend the low-pass filter to some higher frequency, so we
>    could see those 'spikes' - that's the PELT HALF_LIFE boot
>    parameter for 8ms

That's another way to look at it, yes. We can control how reactive we'd like
the system to be for changes.

> 1.1. You are likely to have a 'gift' from the Util_est
>      which picks the max util_avg values and maintains them
>      for a while. That's why the 8ms PELT information can last longer
>      and you can get higher frequency and longer idle time.

This is probably controversial statement. But I am not in favour of util_est.
I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
default instead. But I will need to do a separate investigation on that.

> 2. Plumb in this new idea of dvfs_update_delay as the new
>    'margin' - this I don't understand
> 
> For the 2. I don't see that the dvfs HW characteristics are best
> for this problem purpose. We can have a really fast DVFS HW,
> but we need some decent spare idle time in some workloads, which
> are two independent issues IMO. You might get the higher
> idle time thanks to 1.1. but this is a 'side effect'.
> 
> Could you explain a bit more why this dvfs_update_delay is
> crucial here?

I'm not sure why you relate this to idle time. And the word margin is a bit
overloaded here. so I suppose you're referring to the one we have in
map_util_perf() or apply_dvfs_headroom(). And I suppose you assume this extra
headroom will result in idle time, but this is not necessarily true IMO.

My rationale is simply that DVFS based on util should follow util_avg as-is.
But as pointed out in different discussions happened elsewhere, we need to
provide a headroom for this util to grow as if we were to be exact and the task
continues to run, then likely the util will go above the current OPP before we
get a chance to change it again. If we do have an ideal hardware that takes
0 time to change frequency, then this headroom IMO is not needed because
frequency will follow us as util grows. Assuming here that util updates
instantaneously as the task continues to run.

So instead of a constant 25% headroom; I redefine this to be a function of the
hardware delay. If we take a decision now to choose which OPP, then it should
be based on util_avg value after taking into account how much it'll grow before
we take the next decision (which the dvfs_update_delay). We don't need any more
than that.

Maybe we need to take into account how often we call update_load_avg(). I'm not
sure about this yet.

If the user wants to have faster response time, then the new knobs are the way
to control that. But the headroom should be small enough to make sure we don't
overrun until the next decision point. Not less, and not more.


Thanks!

--
Qais Yousef
