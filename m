Return-Path: <linux-kernel+bounces-10841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8F81DCDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399FF1C21477
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FEC101E4;
	Sun, 24 Dec 2023 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD6Tj7Qp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0343BFC1A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3e4637853so289455ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 14:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703456456; x=1704061256; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LD140+Xgkenp9ciiR1m/6SC0DrA959WMgfk0mFXyRk=;
        b=BD6Tj7QpwYRUdefUv8zKl0C7e9CFmftPhUMZo5Aj1FUCJKANDEV6k8sN3hRPi8ZMRX
         2ygeJXRQ5P9l4pVIv/32bn6qJugvq6Qz5FWcHlwfRZaq9j0shlxAwjvwpwHgVCqTbOOo
         nAaRBJO61naORxYP56peQbDY1eG5oMMbWzUachn//iN+65vtBPGExOVpDxirF/gPg8lZ
         qvn4E6fWVGZh7cdjo1tM+lsaEfZpzk/4nAqQ0EOImqwlpd8EDsP9XJmok5HlU87hi7dL
         B6eSVfAsacIXJTKFnNct3WdgUkpcWrso+OsLY3vo+WesDMzQRHtdz7AMLwEJomhUeVI2
         EHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703456456; x=1704061256;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LD140+Xgkenp9ciiR1m/6SC0DrA959WMgfk0mFXyRk=;
        b=lc29Rqsbq9cftNMPu3VVk8IGeWenj0CgpXteeNDnn161FmsIjOadogm8mpYWowSKYo
         CukfK422ixLfP5u4OgAI8UcQk4oKDmmf57K/gjcM3jGYu4KXLbdBCvhKqNCj/zfIs1Qo
         bBntPmuTN2NYMWfe1hroJjt73rJ94Nc2Wpk6WAjUNvV9tyHDxDDy0ThjrDNkopH7Vl1u
         QrAhAr+KngSqQgSjQYImstQ3QtI8l7UMiNWubWQcGqIWGP72OqHnN56msMyfADAdLYqX
         /gQ1idDcLMORYoQDpU/vdRkgH659jvTtLfyckY6JCcDiLnMIyMbwcK/WBjrp1/UaPBDj
         CGAg==
X-Gm-Message-State: AOJu0YzC+onbh0PvhEtyYtgN+QSkcpgZtlTEWL7dBY8C/C2fwBTb3dI2
	cNEjdcq4Hx7p6q28LMvqnb3dmT3n6Qm9
X-Google-Smtp-Source: AGHT+IHDCDsQKo8TkgmKnfoJ90RsBFmNqQ8nt9FOQZmtwXMiUyrVc0Z600567/ZOEgcDu3sinHqLdg==
X-Received: by 2002:a17:903:41cd:b0:1d4:f4:bd18 with SMTP id u13-20020a17090341cd00b001d400f4bd18mr302116ple.20.1703456456102;
        Sun, 24 Dec 2023 14:20:56 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001d0b4693539sm6947242plx.189.2023.12.24.14.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 14:20:55 -0800 (PST)
Date: Sun, 24 Dec 2023 14:20:54 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Chris Li <chrisl@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Wei Xu <weixugc@google.com>, 
    Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
    Chun-Tse Shao <ctshao@google.com>, Suren Baghdasaryan <surenb@google.com>, 
    Yosry Ahmed <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, 
    Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
    Zhongkun He <hezhongkun.hzk@bytedance.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>, 
    Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
In-Reply-To: <CAF8kJuMhbXmqvDDa8B8daDKwdfkL9-Be12DPns5Grx68U1Rpyg@mail.gmail.com>
Message-ID: <7454d4e3-a2dd-0571-5ac1-99e99dabcaf0@google.com>
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org> <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org> <ZYYY1VBKdLHH-Kl3@google.com> <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com> <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
 <0a052cb1-a5c5-4bee-5bd5-fd5569765012@google.com> <CAF8kJuM59_12VNZ9d4oXZiLbAQC4LGLXODHqZw+7jiCJYva6YQ@mail.gmail.com> <d171f8a4-47ed-0e29-877d-6824d593d7ed@google.com> <CAF8kJuMhbXmqvDDa8B8daDKwdfkL9-Be12DPns5Grx68U1Rpyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 24 Dec 2023, Chris Li wrote:

> > > > > > How do you quantify the impact of the delayed swap_entry_free()?
> > > > > >
> > > > > > Since the free and memcg uncharge are now delayed, is there not the
> > > > > > possibility that we stay under memory pressure for longer?  (Assuming at
> > > > > > least some users are swapping because of memory pressure.)
> > > > > >
> > > > > > I would assume that since the free and uncharge itself is delayed that in
> > > > > > the pathological case we'd actually be swapping *more* until the async
> > > > > > worker can run.
> > > > >
> > > > > Thanks for raising this interesting question.
> > > > >
> > > > > First of all, the swap_entry_free() does not impact "memory.current".
> > > > > It reduces "memory.swap.current". Technically it is the swap pressure
> > > > > not memory pressure that suffers the extra delay.
> > > > >
> > > > > Secondly, we are talking about delaying up to 64 swap entries for a
> > > > > few microseconds.
> > > >
> > > > What guarantees that the async freeing happens within a few microseconds?
> > >
> > > Linux kernel typically doesn't provide RT scheduling guarantees. You
> > > can change microseconds to milliseconds, my following reasoning still
> > > holds.
> > >
> >
> > What guarantees that the async freeing happens even within 10s?  Your
> > responses are implying that there is some deadline by which this freeing
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

I'm simply trying to compare the pros and cons of the approach.  As 
pointed out previously by Andrew, this approach actually results in *more* 
work to do freeing.  Then, we could have a significant time delay before 
the freeing is actually done, in addition to the code complexity.  And 
nothing safeguards us from an exponentially increasing amount of freeing 
that will be done sometime in the future.

The current implementation provides strong guarantees that you will do 
batched freeing that will not accumulate beyond a pre-defined threshold 
which is proven to work well in practice.

My only question was about how we can quantify the impact of the delayed 
free.  We've come to the conclusion that it hasn't been quantified and 
there is no guarantees on when it will be freed.

I'll leave it to those more invested in this path in the page fault 
handler to provide feedback.  Thanks!

