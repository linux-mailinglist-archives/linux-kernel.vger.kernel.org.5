Return-Path: <linux-kernel+bounces-95344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D5874C80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5081F23A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D314985297;
	Thu,  7 Mar 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="s+SxzqNB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C196563411
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807743; cv=none; b=XWhYGqaLc0WwvxX6erKbSS85OEf3CoaXE2rDiXUbsoDIL/Mq6pJbXiZe/p3gewykQaPeHLBQJNeLKjR83Uzyebu+/8NeF2wnGmnfqzSA6c+n5ekMxiQgud7ja3O7H4TzE5G7RejmsKrD1hTO7rXdjrVqYdHqeOX4IBFMFbfgwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807743; c=relaxed/simple;
	bh=zUOzHqLYT+D2RHSlBC8CrTyheSw2k5G0eVCGqvx7Tuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEELtlG97DDJ9SyxQy8lnAcCVobxevYUaLPP0FgrdzO+uN6FymumxdXcsKhf1St33E4x0QILcn8R/bW7TJZnMD9zMI6GgSUGnnXI4fMEwe2wDWb1PqIEAGVpAS9Xw47wMTgzc5XSGv4ioL68ILtlTgSSX2nchfOjYDMaoLe5uFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=s+SxzqNB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a452877ddcaso100431266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709807739; x=1710412539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NI5nB7l1zMLQUnygTej5fwUcsau3Hoemt339OESZU0=;
        b=s+SxzqNB5t1WIAeqpamu6UGg7olnQtz/U9/7MrryKznEMzwpQV5dxLdN+VtOYGerJY
         U3ozYsstdDT8RR91NO5vh09e7ubZjnr+ZXRTJwbiKDc1kDn4WfCKisyK0Ti8vQP4+UB2
         SPotG7CpEXrHdz7MAD27NJPf9SQPhix5tUKOgfalcDJYWhYMk4Rjkhgt1MSmzz/+MY0V
         bOPmbKArj7p+R47jTQV1SgcLR5A6smv5pkSv+fe3HBsQYfomXJ4H2jZL8dfyiZp/Jco8
         fzSDwgpkmCOADWlhf7iVkTWMZjwjk6nd1+vMLUPv/l8HyUi/78TjmqRiIYwpl496yr00
         cUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807739; x=1710412539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NI5nB7l1zMLQUnygTej5fwUcsau3Hoemt339OESZU0=;
        b=N0PV9MWuVr4Qj0LSwNNaWEGlRipeNDitNoA8koL9FigH1mKkJSDJFxzL/dpQ3GFnQ4
         2kRnMglGUAG2KelmZcmqBGRKDYQaQLRzCLhQoLc3aJ5WZwn+C18No8flR+zFQ38IjICe
         tBoQEGuaCVSK+R/mG/vvm6hfm094LBwN1cHdTN/M8woMnyM7H6OBHSSi8ggeKAf5NUwj
         jV3TKjpzmXWvdvBwuzDQpQJLWtDRjjS0fcofqSYAIwZkUQRAHLR2fUfrSMA8uF4gIgR7
         NkPEaejzj6oXQoPtlmnLLzIk8QtYKKe1Cxh7fr++endmakJSO2/ZJFtN7ExTKZ/toaUk
         cEOg==
X-Forwarded-Encrypted: i=1; AJvYcCVBhBga8IKsmz00KyGBcdbaIHY6u8KJlvWdPIDnnzX261bMyMaMcpkUPVrOp3VSzmQCBdSzEGKxVha1o28+8sECObHXZkhUmtifu94H
X-Gm-Message-State: AOJu0YwcDIaeVdXTs32tP0ZO/NAjSI06gKOm7D8nD45LDQu+f64Uur60
	81mJuG3X5xIvQsV4sBexdGsIk0lIueI5sGxJUUqYqUTwipfxg5D4R/TFlxdRpya+TcsJhRLZNrU
	o
X-Google-Smtp-Source: AGHT+IG5W3d1CCt18Dtuwpxk7bf8cDLqj0oeZsKjgMVha/3dKinH9O2VdObbsCeolCEvqZy187VsPg==
X-Received: by 2002:a17:906:54c7:b0:a41:3e39:b918 with SMTP id c7-20020a17090654c700b00a413e39b918mr12072318ejp.24.1709807739015;
        Thu, 07 Mar 2024 02:35:39 -0800 (PST)
Received: from airbuntu (92.40.185.219.threembb.co.uk. [92.40.185.219])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090607ce00b00a45c9945251sm773913ejc.192.2024.03.07.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:35:38 -0800 (PST)
Date: Thu, 7 Mar 2024 10:35:27 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240307103527.y5zrnkjvwoqhtyll@airbuntu>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
 <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>
 <20240303174416.7m3gv5wywcmedov4@airbuntu>
 <20240306214704.uditboboedut2lm2@airbuntu>
 <CAKfTPtBLUkZ0hEd8K=e9wjg+zn9N5jgia-7wwLa3jaeYK+qkCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBLUkZ0hEd8K=e9wjg+zn9N5jgia-7wwLa3jaeYK+qkCw@mail.gmail.com>

On 03/07/24 10:14, Vincent Guittot wrote:
> On Wed, 6 Mar 2024 at 22:47, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 03/03/24 17:44, Qais Yousef wrote:
> >
> > >       diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >       index 174687252e1a..b0e60a565945 100644
> > >       --- a/kernel/sched/fair.c
> > >       +++ b/kernel/sched/fair.c
> > >       @@ -8260,6 +8260,8 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> > >                       cpumask_t *cpumask;
> > >
> > >                       cpumask = cpu_capacity_span(entry);
> > >       +               if (!cpumask_intersects(cpu_active_mask, cpumask))
> > >       +                       continue;
> > >                       if (!cpumask_intersects(p->cpus_ptr, cpumask))
> > >                               continue;
> > >
> > >       @@ -8269,6 +8271,53 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> > >               rcu_read_unlock();
> > >        }
> > >
> > >       +static void __update_tasks_max_allowed_capacity(unsigned long capacity)
> > >       +{
> > >       +       struct task_struct *g, *p;
> > >       +
> > >       +       for_each_process_thread(g, p) {
> > >       +               if (fair_policy(p->policy) && p->max_allowed_capacity == capacity)
> >
> > This condition actually not good enough. We need to differentiate between going
> > online/offline. I didn't want to call set_task_max_allowed_capacity()
> > unconditionally and make hotplug even slower.
> 
> But should we even try to fix this ? hotplugging a cpu is a special
> case and with patch 4 you will not increase lb_interval anymore

I don't care to be honest and this was my first reaction, but I couldn't ignore
the report.

I will need to do something to handle the dynamic EM changing capacities anyway
after 6.9 merge window. Or maybe now; I still haven't thought about it. I am
hoping I can trigger the update somewhere from the topology code. Maybe that
work will make handling hotplug easier than the approach I've taken now on
rq_online/offline.

FWIW, I have a working patch that solves the problem. The only drawback is that
rq_online/offline() are not only called from sched_cpu_activate/deactivate()
path but from build_sched_domains() path which for some reasons ends up calling
rq_offline/online() for each cpu in the map.  To be even more efficient I need
to teach rq_offline/online() to differentiate between the two. Or refactor the
code. Which if you don't think it's important too I'd be happy to drop this and
replace it with a comment to see if someone cares. Only testing and dev could
end up using hotplug; so there could be a difference in behavior in regards how
often misfit migration can kick. But as you said hopefully with these fixes
it'd just end up being unnecessary work. The only potential problem maybe is
that misfit lb has a precedence over other types of lb types; so we could
end up delaying load imbalance if there's a pointless misfit lb?

I'm happy to follow the crowd. But it'd be nice if this series can be made
mergeable with follow up work. It'd make life much easier for me.


Thanks!

--
Qais Yousef

