Return-Path: <linux-kernel+bounces-17378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4490824C77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F7A1F23328
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD720E4;
	Fri,  5 Jan 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="v/jyD0sO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CE20E6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d894764e7so11323385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 17:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704417715; x=1705022515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLTVQNFjd3Q7IaE02ahWQvVdBiZrsbuSwDbgf4ymcrU=;
        b=v/jyD0sOCpgdn9db9Fl4+RQ5h0aFyyAmgZDqfYojfIyUXLSc3m8TzyoHaKS2vll3fj
         exMFenOm+akLS1hpTmEy8mmKpscBwkifI6KfzLI1/tAaUA2QHJDjDXG4Ub8zZeEKBp+M
         Y1CnQdg02FYfqad65WK4RspkZC6WHhfX6wh0WYff3J7PjkWDKDhKSryWmJD3j2yyqErB
         V+MMp1bQjoOWvxKpoS+YiKcuk2YJWIoPpK5pxVTvreSSK9AGt4aiZnWHD7O6j1tLnDQ5
         J/Mk4WpCQz6CKsFYWKi3lBxCn4RDyOB7S0jAKWUvw1+bffFKCfs3UqLzxp0QxThx+iD8
         jEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704417715; x=1705022515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLTVQNFjd3Q7IaE02ahWQvVdBiZrsbuSwDbgf4ymcrU=;
        b=kpefcxtrdzHCjcdh7DzN9EiPSpT6NTPgSpjDDV1SczBy4kh1n66ciAIlbqtYPnHT8w
         bVCnhmc+dwr3KoQ49IP60HQDFiead2vPbHaaY856PzAn3obM9bqa0tG2ziRZEaiJjnxv
         ysQGgExv35qRxUU1qEANL0B1VYIuldGc0Z/x3o9qKHpwryI4cZREWClSGzxumuqCphvz
         2OdisSvqmHM1nNV05TtmRdN5hruxRIObLsmD8Ri3IRMglkRwX6i2+HLmKarVfbteCMB2
         n1l9LNEGkAqj9/7HfYq8ATmJktzcOur88L4ltRHlSjFSeOkinnxfE8qk7hFmPooS5YTK
         eVCg==
X-Gm-Message-State: AOJu0YyaXxBH7QWRvqMJms9Z4L+v6pHk3eyJ2WyOPklijEOT1Jfx0WOD
	M+HSteNrVE7csL6dz2o2NEA4PhsAHg8bBg==
X-Google-Smtp-Source: AGHT+IEZxaYhohWob807rbrmRBTjSCXcBPtmomg3+LjiTZ+/zShLdOzckmRM/GH1J8Cldc6uNiQSBg==
X-Received: by 2002:a05:600c:4f13:b0:40d:85b9:b64d with SMTP id l19-20020a05600c4f1300b0040d85b9b64dmr566369wmq.243.1704417715277;
        Thu, 04 Jan 2024 17:21:55 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b0040e38859c47sm140932wmb.16.2024.01.04.17.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:21:54 -0800 (PST)
Date: Fri, 5 Jan 2024 01:21:53 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH RFC 3/3] sched/fair: Implement new type of misfit
 MISFIT_POWER
Message-ID: <20240105012153.zawr4pyd4dbrk4sf@airbuntu>
References: <20231209011759.398021-1-qyousef@layalina.io>
 <20231209011759.398021-4-qyousef@layalina.io>
 <d3411602-9798-4261-8b7c-5c95d15ce455@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3411602-9798-4261-8b7c-5c95d15ce455@arm.com>

Hi Pierre

On 01/04/24 15:28, Pierre Gondois wrote:
> Hello Qais,
> 
> I tried to do as you indicated at:
>    https://lore.kernel.org/all/20231228233848.piyodw2s2ytli37a@airbuntu/
> without success. I can see that the task is migrated from a big CPU to
> smaller CPUs, but it doesn't seem to be related to the new MISFIT_POWER
> feature.

Hmmm. It is possible something went wrong while preparing these set of patches.
I do remember trying this patch quickly, but judging by the bug you found
I might have missed doing a recent run after a set of changes. So something
could have gotten broken.

Let me retry it and see what's going on.

> Indeed, if the uclamp_max value of a CPU-bound task is set to 0, isn't it
> normal have EAS/feec() migrating the task to smaller CPUs ? I added tracing
> inside is_misfit_task() and load_balance()'s misfit path and could not see
> this path being used.

I did have similar debug messages and I could see them triggered. To be honest
I spent most of the time working on this in the past against 5.10 and 5.15
kernels. And when I started the forward port I already was working on removal
max aggregation and this whole patch needed to be rewritten so I kept it as
a guideline. My focus was on getting the misfit generalization done (patch
1 and 2) and demonstrate how this can be potentially used to implement better
logic to balance based on power.

The main ideas are:

1. We need to detect the MISFIT_POWER.
2. We need to force every CPU to try to pull.
3. We need to use feec() to decide which CPU to pull.

I'm not sure if there's potentially another better way. So I was hoping to see
if there are other PoVs to consider.

> 
> On 12/9/23 02:17, Qais Yousef wrote:
> > MISFIT_POWER requires moving the task to a more efficient CPU.
> > 
> > This can happen when a big task is capped by uclamp_max, but another
> > task wakes up on this CPU that can lift the capping, in this case we
> > need to migrate it to another, likely smaller, CPU to save power.
> 
> Just to be sure, are we talking about the following path, where sugov
> decides which OPP to select ?
> sugov_get_util()
> \-effective_cpu_util()
>   \-uclamp_rq_util_with()
> 
> To try to describe the issue in my own words, IIUC, the issue comes from
> the fact that during energy estimations in feec(), we don't estimate the
> impact of enqueuing a task on the rq's UCLAMP_MAX value. So a rq with a
> little UCLAMP_MAX value might see the value grows if an uncapped task
> is enqueued, leading to raising the frequency and consuming more
> power.
> Thus, this patch tries to detect such scenario and migrate the clamped
> tasks.

Yes, to a big degree. See below.

> Maybe another approach would be to estimate the impact of enqueuing a
> task on the rq's UCLAMP_MAX value ?

I'd like to think we'll remove rq uclamp value altogether, hopefully.

Generally I'd welcome ideas on what kind of MISFIT_POWER scenarios we have.
With uclamp_max it is the fact that these tasks can be busy loops (their
util_avg is too high) and will cause anything else RUNNING to run at max
frequency regardless of their util_avg. UCLAMP_MAX tells us we have opportunity
to move them somewhere less expensive.

Detection logic will be harder without rq uclamp_max.

My first ever detection logic was actually to check if the task is running on
the smallest fitting CPU; if not then move it to that. Then I switched to
detection based on whether it is capped or not with feec() deciding which is
the best next place to go to.

There's another problem is that these tasks when they end up on a big core,
they'll make the CPU look busy and can prevent other tasks from running
'comfortably' along side it. So not only they waste power, but they're getting
in the way of other work to get their work done with less interference. I'm not
sure if this should be treated as a different type of misfit though.

We need to get MISFIT_POWER in first and then see if the interference issue is
not automatically resolved then. From power perspective, a busy loop but capped
to be able to run on a mid or little, it is wrong to keep it on the big for
extended period of time from power perspective. And by product the interference
issue should be resolved, in theory at least.

Also not sure if we can have non UCLAMP_MAX based MISFIT_POWER. I couldn't come
up with a scenario yet, but I don't think we need to restrict ourselves to
UCLAMP_MAX only ones. So ideas are welcome :-)


Thanks!

--
Qais Yousef

