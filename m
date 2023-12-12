Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A053880EB45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjLLMKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjLLMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:10:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89BC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:10:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so30762285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702383025; x=1702987825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqFH+oXtPJzwgBpoVNZnokoMTw6/cExkaaGTM4d3Nbo=;
        b=j50qnq5nisbWIKeqe1aq7yLm2vNU1xy410j0lUxXYgqGMPGOUJ7fsSTgMerVLKpja6
         LEMOr5WDwt6OWUKQNG8Dg2y9zOIb8bRFEHD/1Z4YWUvOaSZfAeeHNJ+jOWPtsgGNh9w/
         EXFtWRKzF0SOX6/iiYc3D8T1sDBsF8ZLtXD684GA2nln+fKMj3HrYZPhvLU3wK3IfL/M
         UlIhk040co+Vcs91Uq0ueUCL84D5jJsBZby+yzlLviZBlBXGL1CsHeQMjBIViHTV73C7
         I++MoAkOXs5cd7BvjG8lOyCy4mV4yGigmL/GfNMHWCgCKUY/vAZQQn5RChr80xslzP6W
         AH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383025; x=1702987825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqFH+oXtPJzwgBpoVNZnokoMTw6/cExkaaGTM4d3Nbo=;
        b=idP/qE/L+hiy9TlQy6Q6dhiQgc3RyXAKWUVSYzNI7vSV5NXIx14np6rmimKO5fcEa0
         EvSR7OJYxzajamguOZGs5H3UdoeY4HNMZYeNtE7NUfGZIwlbSi9+de5Bgq4bl848ISEX
         vsRLbECTKS6OshF9R1yrp0vepY50joEHWJ/5KsvmzHDhXiaSVZyNVTY0F6J/4UY6tTda
         nv6vBewgBk4ZkZ0MGJ34C4QFAlz2W/t66zH914kVci6M70O/z8M/m0QhwYLRuD49016S
         FlHw5nmekOU8PgIN5P8e3UAOJm3/a7CQ8ghDOSkC5uW9dnyktzR1kY4Rb0JP53LksgaA
         4XCQ==
X-Gm-Message-State: AOJu0Yz2VjVJJMhJgpimGo9+njQulULKof4V4hqq9AoX88x8fS6d3Zge
        +70cZNA6PPnNgoJxpbHJVwkcOQ==
X-Google-Smtp-Source: AGHT+IHxmkHsB45t4kksg3Zado7hMjvNhUr6X3TbSiIUJKXCu+mzV9EE0v5THi7znuGCo+8wAgNE0w==
X-Received: by 2002:a05:600c:4447:b0:40c:46eb:e6ae with SMTP id v7-20020a05600c444700b0040c46ebe6aemr1789965wmn.116.1702383025472;
        Tue, 12 Dec 2023 04:10:25 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b0040c4535f1a2sm8432400wmo.39.2023.12.12.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:10:25 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:10:23 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212121023.mehtligcuwcmjtz4@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
 <20231210205156.kausxdcwsydggwie@airbuntu>
 <8ee6425a-0a0e-4391-9fd3-8fe74c809772@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ee6425a-0a0e-4391-9fd3-8fe74c809772@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 07:56, Lukasz Luba wrote:
> 
> 
> On 12/10/23 20:51, Qais Yousef wrote:
> > On 12/08/23 10:05, Lukasz Luba wrote:
> > > Hi Qais,
> > > 
> > > On 12/8/23 01:52, Qais Yousef wrote:
> > > 
> > > [snip]
> > > 
> > > > @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >    	 */
> > > >    	util_est_enqueue(&rq->cfs, p);
> > > > -	/*
> > > > -	 * If in_iowait is set, the code below may not trigger any cpufreq
> > > > -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > > > -	 * passed.
> > > > -	 */
> > > > -	if (p->in_iowait)
> > > > -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > > > -
> > > 
> > > Why this io wait boost is considered as the $subject says 'aggressive'
> > > calling?
> > 
> > This will trigger a frequency update along with the iowait boost. Did I miss
> > something?
> 
> Yes, it will change CPU freq and it was the main goal for this code
> path. We have tests which check how that works on different memory
> types.
> 
> Why do you want to remove it?

It seems you missed this hunk? I of course didn't remove it altogether if
that's what you mean :)

	@@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
	 enqueue_throttle:
		assert_list_leaf_cfs_rq(rq);

	+       cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
	+
		hrtick_update(rq);
	 }

> 
> Did you run some tests (e.g. fio, gallery, etc) to check if you still
> have a decent performance out some new ufs/nvme memories?

PCMark storage gives

before*: 29681
after: 30014

* no patches applied including remove-margins one


Cheers

--
Qais Yousef

> 
> Beata & Dietmar have presented at LPC2021 a proposal to have a per-task
> io boost, with a bit more controllable way of the trade off power vs.
> performance [1]. IMO the io wait boost could evolve, not simply die.
> 
> Regards,
> Lukasz
> 
> [1] https://lpc.events/event/11/contributions/1042/
