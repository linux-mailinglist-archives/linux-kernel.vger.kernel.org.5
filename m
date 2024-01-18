Return-Path: <linux-kernel+bounces-30344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB7831D55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9E3B2148A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B029422;
	Thu, 18 Jan 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VKdxLhuF"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D44A50
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594572; cv=none; b=VkXCNXJooLZdCToFUt7osJGVQrgkRKqUTQrfJ+fseI2vnLseFVhszC/ySiTTw5OAwCegiAMGT5Ut3ETDcZEQYOh0yYQCdmFoiv08HSe9lkbKDchfqozMwC/XD62bf8h0C47I/WmcJJAMAM0hYYZmHc6OsJF2QQ/h3604Wed1phY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594572; c=relaxed/simple;
	bh=UPTqnYu/2OvTjqmhgVKz/X7E/FlqTTPdr2e7dUY3mpg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=EDP3jAIMwQWvj21y11C2YqBKtcPAbR2lCfjHj+MDhcaLgnlrvv+t+9BCGmU+Vz7snhN1TbBuTIvti7wbb+TyVhwTJ47oCxk0xYQsm0/Ge1G/TjhhQyTSy3i3vu4bGyP1ylIVTVPu1a70EyhL8IU1PZRwNqPltsllGR84lfwuatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VKdxLhuF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd7c5b2439so2327359b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705594568; x=1706199368; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRkAAxwE545hdA1CHQLahd76L0FTgjCjQ9oVd5rONMw=;
        b=VKdxLhuFOjz8tL/pSwYvj1tr77WzNdHVKH+moCJmC4FJIv08vFLvZOXesGdJZG3H4T
         3RVmf2y5l6ln/Ejxhi07AWQX21bVrJB20fxoKD3zTLiT2j4ubWHrdnYI4Y9wrvQnBU0F
         HFXimRmtw8c0+7AstX8ydC0t8ur65KPGDAsdjE6pSfzBm9RJsNaa9j22dBi4EovV9wNy
         I8uVgBOgJ8C7wNd5sJZN5DZEDM0lQnozMHXEo8EZEUEKvx42OT7kJyZVSmc+we4Zdtvt
         9B5lmg7Z2egakyE+j5W6I17Dj2nRVIbDREb5HVOkkBAZ51ozjLJobVTbe3TcTolqE2p+
         FqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594568; x=1706199368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRkAAxwE545hdA1CHQLahd76L0FTgjCjQ9oVd5rONMw=;
        b=ovK17Q0MQZYTclSArado35amn3NJCoduGUVRBJgJ+I2/tnTKgmxg4KJXqGUyPuJM2x
         A2UI27KK0ORosTCmOhdER8D+XAv+UntpqBCpK8zvX0OL0L2P9+C+8bFmB8u5gLSgoosX
         3DFC/rUHlBZw9BoMYKEeZkyWjixAYHJM28KwjTfmUUK4fl8o8caym8VKaRpy8yPNxosu
         DWbJtOHRIrrOhOZPI9aGEeKIldzXDlKKeGeqpC3OopuG+kTXVJBd/HSqt/YVbsGDoxRC
         G2tFfmeZlDa1Ln+QwtdT+/EDgsZXQxNwOQiWCAPWo3mcphnMPamlVjBDgHFWKAR1I8MN
         /vEQ==
X-Gm-Message-State: AOJu0Ywy7y6yF3D8/ybQscBRzNuPRY8IhD3IT8+73iduVheymxatc7eQ
	h6rq3rxgCEDAIThuB7NYip4JTXd/DKbRBEepa64G0UUgOOh1WVhQWv0A8K2iafY=
X-Google-Smtp-Source: AGHT+IG+S1DdeH3g6eDWfi0nVMqIeHOEMSECiM1LqNNddjUCuRix8OSGJiLYFXD+hc+8VolIcbx43A==
X-Received: by 2002:a05:6808:d50:b0:3bd:a103:490b with SMTP id w16-20020a0568080d5000b003bda103490bmr65459oik.104.1705594568587;
        Thu, 18 Jan 2024 08:16:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:2fe6])
        by smtp.gmail.com with ESMTPSA id bc14-20020a05622a1cce00b00429bdddfb49sm6891681qtb.44.2024.01.18.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:16:07 -0800 (PST)
Date: Thu, 18 Jan 2024 11:16:01 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com,
	ddstreet@ieee.org, vitaly.wool@konsulko.com,
	akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
Message-ID: <20240118161601.GJ939255@cmpxchg.org>
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com>
 <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>

On Wed, Jan 17, 2024 at 11:30:50AM -0800, Yosry Ahmed wrote:
> On Wed, Jan 17, 2024 at 11:14 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Tue, Jan 16, 2024 at 5:32 AM Ronald Monthero
> > <debug.penguin32@gmail.com> wrote:
> >
> > + Johannes and Yosry
> >
> > >
> > > The core-api create_workqueue is deprecated, this patch replaces
> > > the create_workqueue with alloc_workqueue. The previous
> > > implementation workqueue of zswap was a bounded workqueue, this
> > > patch uses alloc_workqueue() to create an unbounded workqueue.
> > > The WQ_UNBOUND attribute is desirable making the workqueue
> > > not localized to a specific cpu so that the scheduler is free
> > > to exercise improvisations in any demanding scenarios for
> > > offloading cpu time slices for workqueues.
> >
> > nit: extra space between paragraph would be nice.
> >
> > > For example if any other workqueues of the same primary cpu
> > > had to be served which are WQ_HIGHPRI and WQ_CPU_INTENSIVE.
> > > Also Unbound workqueue happens to be more efficient
> > > in a system during memory pressure scenarios in comparison
> > >  to a bounded workqueue.
> > >
> > > shrink_wq = alloc_workqueue("zswap-shrink",
> > >                      WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> > >
> > > Overall the change suggested in this patch should be
> > > seamless and does not alter the existing behavior,
> > > other than the improvisation to be an unbounded workqueue.
> > >
> > > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > > ---
> > >  mm/zswap.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 74411dfdad92..64dbe3e944a2 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> > >                 zswap_enabled = false;
> > >         }
> > >
> > > -       shrink_wq = create_workqueue("zswap-shrink");
> > > +       shrink_wq = alloc_workqueue("zswap-shrink",
> > > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> >
> > Have you benchmarked this to check if there is any regression, just to
> > be safe? With an unbounded workqueue, you're gaining scheduling
> > flexibility at the cost of cache locality. My intuition is that it
> > doesn't matter too much here, but you should probably double check by
> > stress testing - run some workload with a relatively small zswap pool
> > limit (i.e heavy global writeback), and see if there is any difference
> > in performance.
> 
> I also think this shouldn't make a large difference. The global
> shrinking work is already expensive, and I imagine that it exhausts
> the caches anyway by iterating memcgs. A performance smoketest would
> be reassuring for sure, but I believe it won't make a difference.

The LRU inherently makes the shrinker work on the oldest and coldest
entries, so I doubt we benefit a lot from cache locality there.

What could make a difference though is the increased concurrency by
switching max_active from 1 to 0. This could cause a higher rate of
shrinker runs, which might increase lock contention and reclaim
volume. That part would be good to double check with the shrinker
benchmarks.

> > On a different note, I wonder if it would help to perform synchronous
> > reclaim here instead. With our current design, the zswap store failure
> > (due to global limit hit) would leave the incoming page going to swap
> > instead, creating an LRU inversion. Not sure if that's ideal.
> 
> The global shrink path keeps reclaiming until zswap can accept again
> (by default, that means reclaiming 10% of the total limit). I think
> this is too expensive to be done synchronously.

That thresholding code is a bit weird right now.

It wakes the shrinker and rejects at the same time. We're guaranteed
to see rejections, even if the shrinker has no trouble flushing some
entries a split second later.

It would make more sense to wake the shrinker at e.g. 95% full and
have it run until 90%.

But with that in place we also *should* do synchronous reclaim once we
hit 100%. Just enough to make room for the store. This is important to
catch the case where reclaim rate exceeds swapout rate. Rejecting and
going to swap means the reclaimer will be throttled down to IO rate
anyway, and the app latency isn't any worse. But this way we keep the
pipeline alive, and keep swapping out the oldest zswap entries,
instead of rejecting and swapping what would be the hottest ones.

