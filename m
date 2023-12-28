Return-Path: <linux-kernel+bounces-12763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3081F9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFA71F2442D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6390F4FA;
	Thu, 28 Dec 2023 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3glrpVrH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42CF4E1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a236456fee1so709267366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703777721; x=1704382521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h986LuRLMj5CtBkm80VjuZOiBJzP2v2Z/obCN9xx1n4=;
        b=3glrpVrHDx5LxWi8eh+2wWeAtRFUC+CJMn5rMlUHCXDECVWyW05tTPKqi0wNc4+o4o
         ToraP8CR3+kN0hX7ipfL2zgcS+ltesf9eGu9JU5RvORGbNBLtoYuGw95b+9wMFbyV9NQ
         TYUKzrEYECsAXznXlQnrR9bl3oOhLqKlITjTtSdhk2Jr9dH96JhRznlK5mtScRqN5oKS
         DU9Bmn0HUQgupibeOy2ieXQnaIKhmRXEcY1i50So+ervrRZ7PPmb/pTYlE4EqXibCo1k
         LO5gAzhf9JLTU4PzvIs6C7zp8aJJ6SNQdBMKXaCRjhDh9hIIWTKDCZ9dCyHPiGTX9R3z
         TwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703777721; x=1704382521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h986LuRLMj5CtBkm80VjuZOiBJzP2v2Z/obCN9xx1n4=;
        b=F2PToTFc7iLxeYn28uM/xlNhLqphjCwptucUvZGW8P0C812JL3/0RPmLW6fUrOHRQz
         H0X7hUXnZXwuBAJvkZJ5unIVzXOKxJZ0vsY7Z8s15cUPpGF95phvpQQEtZhw3+uCGrOG
         X5eN/y/XyCnUgKq2apdhwl8u+63q0Zh0VFiOKJkSbjON+WZy5edonDuWXBc0ijKe5emu
         9inHUSXn0LnjrCGC4P9Na94gr6TUmPnHtGCwLW2OHQPtb66f+rhq67kOWqGnOF/bWVar
         hFrovcLZ1J4oT0JIDDfGRlFeaZSApR+m0HgY62f66TRKyQTQvrKL0+A1T5b7CJPzTdUu
         U1Qg==
X-Gm-Message-State: AOJu0YwpbiXJqarG8BXdwBPwPJGtZzSGt1N1bAXhmNBVtB5dLng3WfEc
	Et/hidUoDmRGNuppb+mE2r04my9ohrDOsbU41W9MWZPxrEfi
X-Google-Smtp-Source: AGHT+IEfAls5vgce74cxFp/jTxywNGl+RJbneQCFBbf74uuHYuQ/y2fIfTpw4sfv22RO13iub+PCicdmyvCFSGc37Js=
X-Received: by 2002:a17:906:7392:b0:a26:c758:373a with SMTP id
 f18-20020a170906739200b00a26c758373amr4171692ejl.143.1703777720699; Thu, 28
 Dec 2023 07:35:20 -0800 (PST)
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
 <d171f8a4-47ed-0e29-877d-6824d593d7ed@google.com> <CAF8kJuMhbXmqvDDa8B8daDKwdfkL9-Be12DPns5Grx68U1Rpyg@mail.gmail.com>
In-Reply-To: <CAF8kJuMhbXmqvDDa8B8daDKwdfkL9-Be12DPns5Grx68U1Rpyg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Dec 2023 07:34:44 -0800
Message-ID: <CAJD7tkZSGm+ZMZsg+pRPZr2L9uydxXZ0B9oUn-H3=dQsyrM1dg@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: Chris Li <chrisl@kernel.org>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei Xu <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, Suren Baghdasaryan <surenb@google.com>, Brain Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 2:07=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Sun, Dec 24, 2023 at 1:13=E2=80=AFPM David Rientjes <rientjes@google.c=
om> wrote:
> >
> > On Sun, 24 Dec 2023, Chris Li wrote:
> >
> > > On Sat, Dec 23, 2023 at 7:01=E2=80=AFPM David Rientjes <rientjes@goog=
le.com> wrote:
> > > >
> > > > On Sat, 23 Dec 2023, Chris Li wrote:
> > > >
> > > > > > How do you quantify the impact of the delayed swap_entry_free()=
?
> > > > > >
> > > > > > Since the free and memcg uncharge are now delayed, is there not=
 the
> > > > > > possibility that we stay under memory pressure for longer?  (As=
suming at
> > > > > > least some users are swapping because of memory pressure.)
> > > > > >
> > > > > > I would assume that since the free and uncharge itself is delay=
ed that in
> > > > > > the pathological case we'd actually be swapping *more* until th=
e async
> > > > > > worker can run.
> > > > >
> > > > > Thanks for raising this interesting question.
> > > > >
> > > > > First of all, the swap_entry_free() does not impact "memory.curre=
nt".
> > > > > It reduces "memory.swap.current". Technically it is the swap pres=
sure
> > > > > not memory pressure that suffers the extra delay.
> > > > >
> > > > > Secondly, we are talking about delaying up to 64 swap entries for=
 a
> > > > > few microseconds.
> > > >
> > > > What guarantees that the async freeing happens within a few microse=
conds?
> > >
> > > Linux kernel typically doesn't provide RT scheduling guarantees. You
> > > can change microseconds to milliseconds, my following reasoning still
> > > holds.
> > >
> >
> > What guarantees that the async freeing happens even within 10s?  Your
> > responses are implying that there is some deadline by which this freein=
g
> > absolutely must happen (us or ms), but I don't know of any strong
> > guarantees.
>
> I think we are in agreement there, there are no such strong guarantees
> in linux scheduling. However, when there are free CPU resources, the
> job will get scheduled to execute in a reasonable table time frame. If
> it does not, I consider that a bug if the CPU has idle resources and
> the pending jobs are not able to run for a long time.
> The existing code doesn't have such a guarantee either, see my point
> follows. I don't know why you want to ask for such a guarantee.
>
> > If there are no absolute guarantees about when the freeing may now occu=
r,
> > I'm asking how the impact of the delayed swap_entry_free() can be
> > quantified.
>
> Presumably each application has their own SLO metrics for monitoring
> their application behavior. I am happy to take a look if any app has
> new SLO violations caused by this change.
> If you have one metric in mind, please  name it so we can look at it
> together. During my current experiment and the chromebook benchmark, I
> haven't noticed such ill effects show up in the other metrics drops in
> a statistically significant manner. That is not the same as saying
> such drops don't exist at all. Just I haven't noticed or the SLO
> watching system hasn't caught it.
>
> > The benefit to the current implementation is that there *are* strong
> > guarantees about when the freeing will occur and cannot grow exponentia=
lly
> > before the async worker can do the freeing.
>
> I don't understand your point. Please help me. In the current code,
> for the previous swapin fault that releases the swap slots into the
> swap slot caches. Let's say the swap slot remains in the cache for X
> seconds until Nth (N < 64) swapin page fault later, the cache is full
> and finally all 64 swap slot caches are free. Are you suggesting there
> is some kind of guarantee X is less than some fixed bound seconds?
> What is that bound then? 10 second? 1 minutes?
>
> BTW, there will be no exponential growth, that is guaranteed. Until
> the 64 entries cache were freed. The swapin code will take the direct
> free path for the current swap slot in hand. The direct free path
> existed before my change.

FWIW, it's 64 * the number of CPUs.

