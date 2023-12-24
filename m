Return-Path: <linux-kernel+bounces-10840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E8081DCD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCC01F215F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A3101CA;
	Sun, 24 Dec 2023 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jsf/SXha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC07FBEF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C7C433A9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703455623;
	bh=Nk2FrYMqgaYmbhuSwjleZKW0X7pw9egeGLSDxiFxB0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jsf/SXha3n86BTW3jvu6ruXABlJQEQhPdbsv8I5uNAWmJ76hED/bWLasw3z0mRUDH
	 Q8RuHtPbrfAkCQoqHN4cjdU91A2wdc/48vjPs2XSDEPYx9KQikRVti4Xihe7jyZbSY
	 mTGwUGhMpm8cqdm0GnvGlzuW3yesibQgQQgsl3mOW506GzrxYEBxqlGlLDth1yFCZh
	 RnYgtDtJxNcRWAscyJc6Tmt/6a62RMYJ44g6k25+i0ZXjpvIrOXsjXoeVnxPVk8GJs
	 3x22OjXx/xNw3qiLMY3BBYVS14THXzC/a7yQw2LLwEmr9/TIXpVCUU/U9O/US8XHN1
	 +5PqGs15oOH+Q==
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9a7233133so211640b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 14:07:03 -0800 (PST)
X-Gm-Message-State: AOJu0YzJHLVPDxGcN50q0EaPhdzPzQ6VC7P3VGy3TgmilKCEF8k4646u
	VsbmT3xD/+a8deOoWtjeL243AwdjZ62gW9pd1+pmvXNuMRui
X-Google-Smtp-Source: AGHT+IGw5KTuIs+jEjEsKIXIQ428uRz6x09URbQZ4va5bdbBI9yGc9Cn7ASlSAcocbh1ql7JUcj/ofJtQLXcyLAyEU0=
X-Received: by 2002:a05:6a00:1acf:b0:6d9:a865:7fb7 with SMTP id
 f15-20020a056a001acf00b006d9a8657fb7mr710403pfv.13.1703455622282; Sun, 24 Dec
 2023 14:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
 <ZYYY1VBKdLHH-Kl3@google.com> <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com>
 <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
 <0a052cb1-a5c5-4bee-5bd5-fd5569765012@google.com> <CAF8kJuM59_12VNZ9d4oXZiLbAQC4LGLXODHqZw+7jiCJYva6YQ@mail.gmail.com>
 <d171f8a4-47ed-0e29-877d-6824d593d7ed@google.com>
In-Reply-To: <d171f8a4-47ed-0e29-877d-6824d593d7ed@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 24 Dec 2023 14:06:50 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMhbXmqvDDa8B8daDKwdfkL9-Be12DPns5Grx68U1Rpyg@mail.gmail.com>
Message-ID: <CAF8kJuMhbXmqvDDa8B8daDKwdfkL9-Be12DPns5Grx68U1Rpyg@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 1:13=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Sun, 24 Dec 2023, Chris Li wrote:
>
> > On Sat, Dec 23, 2023 at 7:01=E2=80=AFPM David Rientjes <rientjes@google=
.com> wrote:
> > >
> > > On Sat, 23 Dec 2023, Chris Li wrote:
> > >
> > > > > How do you quantify the impact of the delayed swap_entry_free()?
> > > > >
> > > > > Since the free and memcg uncharge are now delayed, is there not t=
he
> > > > > possibility that we stay under memory pressure for longer?  (Assu=
ming at
> > > > > least some users are swapping because of memory pressure.)
> > > > >
> > > > > I would assume that since the free and uncharge itself is delayed=
 that in
> > > > > the pathological case we'd actually be swapping *more* until the =
async
> > > > > worker can run.
> > > >
> > > > Thanks for raising this interesting question.
> > > >
> > > > First of all, the swap_entry_free() does not impact "memory.current=
".
> > > > It reduces "memory.swap.current". Technically it is the swap pressu=
re
> > > > not memory pressure that suffers the extra delay.
> > > >
> > > > Secondly, we are talking about delaying up to 64 swap entries for a
> > > > few microseconds.
> > >
> > > What guarantees that the async freeing happens within a few microseco=
nds?
> >
> > Linux kernel typically doesn't provide RT scheduling guarantees. You
> > can change microseconds to milliseconds, my following reasoning still
> > holds.
> >
>
> What guarantees that the async freeing happens even within 10s?  Your
> responses are implying that there is some deadline by which this freeing
> absolutely must happen (us or ms), but I don't know of any strong
> guarantees.

I think we are in agreement there, there are no such strong guarantees
in linux scheduling. However, when there are free CPU resources, the
job will get scheduled to execute in a reasonable table time frame. If
it does not, I consider that a bug if the CPU has idle resources and
the pending jobs are not able to run for a long time.
The existing code doesn't have such a guarantee either, see my point
follows. I don't know why you want to ask for such a guarantee.

> If there are no absolute guarantees about when the freeing may now occur,
> I'm asking how the impact of the delayed swap_entry_free() can be
> quantified.

Presumably each application has their own SLO metrics for monitoring
their application behavior. I am happy to take a look if any app has
new SLO violations caused by this change.
If you have one metric in mind, please  name it so we can look at it
together. During my current experiment and the chromebook benchmark, I
haven't noticed such ill effects show up in the other metrics drops in
a statistically significant manner. That is not the same as saying
such drops don't exist at all. Just I haven't noticed or the SLO
watching system hasn't caught it.

> The benefit to the current implementation is that there *are* strong
> guarantees about when the freeing will occur and cannot grow exponentiall=
y
> before the async worker can do the freeing.

I don't understand your point. Please help me. In the current code,
for the previous swapin fault that releases the swap slots into the
swap slot caches. Let's say the swap slot remains in the cache for X
seconds until Nth (N < 64) swapin page fault later, the cache is full
and finally all 64 swap slot caches are free. Are you suggesting there
is some kind of guarantee X is less than some fixed bound seconds?
What is that bound then? 10 second? 1 minutes?

BTW, there will be no exponential growth, that is guaranteed. Until
the 64 entries cache were freed. The swapin code will take the direct
free path for the current swap slot in hand. The direct free path
existed before my change.

Chris

