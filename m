Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121DC799F69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjIJTG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIJTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:06:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7FBCDD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:06:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c3726cc45so3899080f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694372769; x=1694977569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdQssOCQrUsOB2Nfsez55dBWY7lSg5+WyRaDataAp9w=;
        b=rFXj0RElHH6SMBa3O5LD0XWuk01egkfeWqVg1QAhCSAYuOiiWxvxyG3yZAI7zuVzEr
         SR6lgq7O2eqBxgNoktLn7kcnUSreeePlo3pWSgcs39KzyOZohJsbGebnM6sAFDji2P35
         j4hb7mclevWecrr7QnY3SSdLQ+hQm9nEV6Jlz6IQOI9lhOLih511ZpDBmy2j+bD+6QP7
         F67tw9cf/sziGrH39a7aBe4hagHULkB440T8/arCwRJ0yXgA0q2DoTe14Xy+UeLiY3DP
         HuRuHMUThekCyIToLaiLyMCd304k3Qe83fFsM2WkMVorV9l8gw79mOdc8JuIS+yP4xoa
         VnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694372769; x=1694977569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdQssOCQrUsOB2Nfsez55dBWY7lSg5+WyRaDataAp9w=;
        b=JKSA3Su1vosZSPF/OTTmF9mZw2gTtcudxXwmxNrqFf3okECXiCTTigi6DjkopeYzQc
         Y3UlWw6NsDpPf3/xGHfLbjE5SNU5sAFIa+ASfSVa1JbU1BiWGLm5RptTuR6Yi/mcKDhc
         iLsBJo9gWVCPah6RK82BtHEWF01Pc2shy7n09zQ/hBStm+EHxoJgpfgXYbenXvGX9BIt
         F3EEDOH5kcKZYZhANTV35+BVDZfuG1ryzLSkhpHT3eGTRSgnObwqCdm2rNPlKjuKizFm
         5ccEKi5hVqDSjxvhlMGLkonPDuZMQNBTuVxEib8XUXEuKW7+gEQcysmZeuqbUwoiRmHs
         vHiQ==
X-Gm-Message-State: AOJu0YxcRy9S98El+UmEXy0rZaY/LP6lVcNLdkNbR/BtMVsF8tvmKZ+I
        HGGQlivuf/6qHS5A6x2BOkrWlsf+6GuBgR90b4U=
X-Google-Smtp-Source: AGHT+IGP9FSomXJNOjZ/vzk1cgJcDcVFky1kzGq+5M+D8aIljQgWA8Uo901CmNQs5ega9Qwweqj4/A==
X-Received: by 2002:a5d:4309:0:b0:317:ef76:b773 with SMTP id h9-20020a5d4309000000b00317ef76b773mr5486595wrq.45.1694372768659;
        Sun, 10 Sep 2023 12:06:08 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm7893052wrm.103.2023.09.10.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:06:08 -0700 (PDT)
Date:   Sun, 10 Sep 2023 20:06:06 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230910190606.6gpnnplix2ybqe3k@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
 <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
 <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 15:42, Lukasz Luba wrote:
> 
> 
> On 9/7/23 15:29, Peter Zijlstra wrote:
> > On Thu, Sep 07, 2023 at 02:57:26PM +0100, Lukasz Luba wrote:
> > > 
> > > 
> > > On 9/7/23 14:26, Peter Zijlstra wrote:
> > > > On Wed, Sep 06, 2023 at 10:18:50PM +0100, Qais Yousef wrote:
> > > > 
> > > > > This is probably controversial statement. But I am not in favour of util_est.
> > > > > I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
> > > > > default instead. But I will need to do a separate investigation on that.
> > > > 
> > > > I think util_est makes perfect sense, where PELT has to fundamentally
> > > > decay non-running / non-runnable tasks in order to provide a temporal
> > > > average, DVFS might be best served with a termporal max filter.
> > > > 
> > > > 
> > > 
> > > Since we are here...
> > > Would you allow to have a configuration for
> > > the util_est shifter: UTIL_EST_WEIGHT_SHIFT ?
> > > 
> > > I've found other values than '2' better in some scenarios. That helps
> > > to prevent a big task to 'down' migrate from a Big CPU (1024) to some
> > > Mid CPU (~500-700 capacity) or even Little (~120-300).
> > 
> > Larger values, I'm thinking you're after? Those would cause the new
> > contribution to weight less, making the function more smooth, right?
> 
> Yes, more smooth, because we only use the 'ewma' goodness for decaying
> part (not the raising [1]).
> 
> > 
> > What task characteristic is tied to this? That is, this seems trivial to
> > modify per-task.
> 
> In particular Speedometer test and the main browser task, which reaches
> ~900util, but sometimes vanish and waits for other background tasks
> to do something. In the meantime it can decay and wake-up on
> Mid/Little (which can cause a penalty to score up to 5-10% vs. if
> we pin the task to big CPUs). So, a longer util_est helps to avoid
> at least very bad down migration to Littles...

Warning, this is not a global win! We do want tasks in general to downmigrate
when they sleep. Would be great to avoid biasing towards perf first by default
to fix these special cases.

As I mentioned in other reply, there's a perf/power/thermal impact of these
decisions and it's not a global win. Some might want this to improve their
scores, others might not want that and rather get the worse score but keep
their power budget in check. And it will highly depend on the workload and the
system. Which we can't test everyone of them :(

We did give the power to userspace via uclamp which should make this problem
fixable. And this is readily available. We can't basically know in the kernel
when one way is better than the other without being told explicitly IMHO.

If you try to boot with faster PELT HALFLIFE, would this give you the same
perf/power trade-off?


Thanks

--
Qais Yousef

> 
> [1] https://elixir.bootlin.com/linux/v6.5.1/source/kernel/sched/fair.c#L4442
