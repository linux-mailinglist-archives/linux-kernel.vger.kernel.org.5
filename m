Return-Path: <linux-kernel+bounces-47445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB1844E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53811F2B528
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C43D64;
	Thu,  1 Feb 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acZ/v7pp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FC3C24
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748198; cv=none; b=lr3MTzi0g43Zy2/OTYiLY9fj2V88XnkSbcHEL1V0demqjXmQKlQmuMz8nl1udmLbhrcUvpkH3PKiRxpzCRLH3nj4GcFkdgiYV/OY4tDH3CoZzbmqV+NeveZxAnnOLMS1ttPoXhbtPhv5teZPyoOi2z0YcasAcL2823dfsF0j++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748198; c=relaxed/simple;
	bh=SAKZoIcbXQBhVU/XPjInF6+T+qpKARwlN1qzK6xE+uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDZsowYorR6xoePsP9EtchK2eY4xwo/93PWNCkhFKUDkFz+NH+MvgoHVcPpTk1WZzL8/+3Sf3g5mxF1Ce50dz0/ixmhk1KCCXkq78m18ZnKW10bn4tgWzv7AG2t2VsgWrTeEmgbh9lbVTWB/Z0G3wD4Y6qR7LB6wgVzl0OpKJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acZ/v7pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D716C433F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706748198;
	bh=SAKZoIcbXQBhVU/XPjInF6+T+qpKARwlN1qzK6xE+uA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=acZ/v7ppW2j+V2QYbN4IPPvvf9H6a7QoZRMjBpSkVeizW6EmPz4EDjVdSC3i33T1S
	 NRHKX6yW045sRFKDq3mBlnlMdViMgVZfg7BfLP+vJMnUIlEyc43aLyo2uPLBuvp+En
	 8waF7O4Mg/zESlH5//p+C8HmnS6bziHpjfcVGO/pYUw4oDKY1Q+hEqWehH7lWaAy/+
	 sV5I+MFRxzkpGfzfPWVUxfORStQ+f3ujdMnPDxuXs7utcJJ7A/E+7rX6v0hid4VgsC
	 f85qTZBbt1viNIiXoL4p5maOCFA06/7bbcCW+DQnm8lRoviwALl9uv2Ge4jz96TXbV
	 BTIQCWL2T3/AA==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3637860f03bso1458965ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:43:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxLHPiyNgAY906oP4I+95amFcm5eTBISrUD1UzLpyEwe2gBxsDe
	6Cbfnnt4FhmpLgNjRBjlzveIAhPqJwvk3EUrHDxEoYelb+tWAfscKMHRdX5sXii9QYScsPvPuc/
	zfaEGVuKNZ3DTABGYJHAtZGzfSkepI3Kp1LSh
X-Google-Smtp-Source: AGHT+IGB7oLJrmaP/aXwop9ABqv4dDhMbyhMzCapn/Tj3EXZBP4RineWW6y0EDYIXROFb6PYeUXWZWt7R/5EYthupYg=
X-Received: by 2002:a92:c74f:0:b0:363:8594:350 with SMTP id
 y15-20020a92c74f000000b0036385940350mr3537392ilp.1.1706748197388; Wed, 31 Jan
 2024 16:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
 <ZYYY1VBKdLHH-Kl3@google.com> <87o7eeg3ow.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o7eeg3ow.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 31 Jan 2024 16:43:05 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPh=J9k=kSCSYzvdzdH4tSWtubzgQS9EtGAwZaAgRPn7g@mail.gmail.com>
Message-ID: <CAF8kJuPh=J9k=kSCSYzvdzdH4tSWtubzgQS9EtGAwZaAgRPn7g@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

Sorry for the late reply.

On Sun, Dec 24, 2023 at 11:10=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Fri, Dec 22, 2023 at 11:52:08AM -0800, Andrew Morton wrote:
> >> On Thu, 21 Dec 2023 22:25:39 -0800 Chris Li <chrisl@kernel.org> wrote:
> >>
> >> > We discovered that 1% swap page fault is 100us+ while 50% of
> >> > the swap fault is under 20us.
> >> >
> >> > Further investigation show that a large portion of the time
> >> > spent in the free_swap_slots() function for the long tail case.
> >> >
> >> > The percpu cache of swap slots is freed in a batch of 64 entries
> >> > inside free_swap_slots(). These cache entries are accumulated
> >> > from previous page faults, which may not be related to the current
> >> > process.
> >> >
> >> > Doing the batch free in the page fault handler causes longer
> >> > tail latencies and penalizes the current process.
> >> >
> >> > Move free_swap_slots() outside of the swapin page fault handler into=
 an
> >> > async work queue to avoid such long tail latencies.
> >>
> >> This will require a larger amount of total work than the current
> >
> > Yes, there will be a tiny little bit of extra overhead to schedule the =
job
> > on to the other work queue.
> >
> >> scheme.  So we're trading that off against better latency.
> >>
> >> Why is this a good tradeoff?
> >
> > That is a very good question. Both Hugh and Wei had asked me similar qu=
estions
> > before. +Hugh.
> >
> > The TL;DR is that it makes the swap more palleralizedable.
> >
> > Because morden computers typically have more than one CPU and the CPU u=
tilization
> > is rarely reached to 100%. We are actually not trading the latency for =
some one
> > run slower. Most of the time the real impact is that the current swapin=
 page fault
> > can return quicker so more work can submit to the kernel sooner, at the=
 same time
> > the other idle CPU can pick up the non latency critical work of freeing=
 of the
> > swap slot cache entries. The net effect is that we speed things up and =
increase
> > the overall system utilization rather than slow things down.
>
> You solution depends on there is enough idle time in the system.  This
> isn't always true.
>
> In general, all async solutions have 2 possible issues.
>
> a) Unrelated applications may be punished.  Because they may wait for
> CPU which is running the async operations.  In the original solution,
> the application swap more will be punished.

The typical time to perform on the async free is very brief, at about
100ms level.
So the amount of punishment would be small.

The original behavior was already delaying the freeing of swap slots
due to batching.
Adding a tiny bit of time does not change the overall behavior too much.
Another thing is that, if the async free is pending, it will go
through the direct free path.

> b) The CPU time cannot be charged to appropriate applications.  The
> original behavior isn't perfect too.  But it's better than async worker.

Yes, the original behavior will free other cgroups' swap entries.

> Given the runtime of worker is at 100us level, these issues may be not
> severe.  But I think that you may need to explain them at least.

Thanks for the suggestion. Will do in V2.

>
> And, when swap slots freeing batching was introduced, it was mainly used
> to reduce the lock contention of sis->lock (via swap_info_get_cont()).
> So, we may move some operations (e.g., mem_cgroup_uncharge_swap,
> clear_shadow_from_swap_cache(), etc.) out of batched operation (before
> calling free_swap_slot()) to reduce the latency impact.

That is good to know. Thanks for the explanation.

Chris

>
> > The test result of chromebook and Google production server should be ab=
le to show
> > that it is beneficial to both laptop and server workloads, making them =
more responsive
> > in swap related workload.
>
> --
> Best Regards,
> Huang, Ying
>

