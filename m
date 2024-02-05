Return-Path: <linux-kernel+bounces-53802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9784A6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F941C265AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFC50A87;
	Mon,  5 Feb 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQS+aQHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F2481B1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160218; cv=none; b=cQA/OSXNU+AHTWadod8+LSKYxzgyXa5FgOos6VWLGBGT49zujv4+9PgmEctXA9rOAzLJNcsprYpoFBSGLEYL/GUGoIkmWR0o1iCgO7B01ipAzQ85TVmcov46ifRqelmrJHFLkKR4h0zJImEZnQNetqjYLq0ZU1P/FWbBweWPSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160218; c=relaxed/simple;
	bh=hij6B8VGtK1pSryB447Ft+fwG96XyyxlWl+9lohUqa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbdoM9Mxx9DgXoYviDEDXXdZT9ZFs3qB7I+b4BNvkCzrNyVBUygAwhIsdoiF2lcrfSit11WnFBmDkLdSc6Iqf3s8sWidb2ol6x3GcROU+705iI2alYCk7W9Xm8FYue11CpR09M+3TbtXmXsy2qjVIomXBprKvq1ZVB0dWHofVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQS+aQHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A144C433B1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160218;
	bh=hij6B8VGtK1pSryB447Ft+fwG96XyyxlWl+9lohUqa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bQS+aQHGiX0CP69WXDzZVS9EJJuEBJoio7Sdbe3T1nBnFY6pcXuLL6YhM0Oopr2l+
	 g4EhOzF2SWpjfe1eK9p05uc+xWUF3ACHGQs2UT9let+kfyNEKmAMA8HVK5QKR+U8uC
	 KcnE2FawKJ/n1Hi6ysTeEfVUIpaOMRcT8q2Kvc3FM0JPqIqznKbbwa1eeKUIElmjsh
	 WQDE+y6OcYGX6DCpwFIi29lyWZ9fK3phz8QhqQBiP13cjNmCKKYJ5xP7WCmt/WrmY8
	 nhWE4OraEBUTAhH9g01Rr3M7mfJE8RGXUBljUSlTTtDkLv0aYlWq2jBv9M+udHcx0p
	 qw8Ceit06cRpg==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-363ca193a36so3465595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:10:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyYyPE5Q3hPjwwljA3Skwq5Hre2V08eg66cZOXnWODEzRgFrz+U
	JUk6YI37QSrr1p8HEx4ZZTGJPjVGGHG1fRp0DMBGdwWF8Rbg7v0txAm6IQmMhckSzy0PSRHlFMd
	TP3rPRuJkgdQe3QEvC/F0o8crdi0UGAKnt9cA
X-Google-Smtp-Source: AGHT+IFusXsgvprxeOT0A1F3MeVTCBZmkJ2RkoAHmdXXdohbcIpozfkRmTCmWdFPDaEZngS01GAFMfV30cFMW8ZNP8o=
X-Received: by 2002:a05:6e02:1d1d:b0:363:8030:e98a with SMTP id
 i29-20020a056e021d1d00b003638030e98amr434324ila.0.1707160217525; Mon, 05 Feb
 2024 11:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com> <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
 <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com> <1fa1da19b0b929efec46bd02a6fc358fef1b9c42.camel@linux.intel.com>
In-Reply-To: <1fa1da19b0b929efec46bd02a6fc358fef1b9c42.camel@linux.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 5 Feb 2024 11:10:05 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMz+HCHkPUQhum32EPB7E1uVvN-E-TffOS7SSHxJNwNmQ@mail.gmail.com>
Message-ID: <CAF8kJuMz+HCHkPUQhum32EPB7E1uVvN-E-TffOS7SSHxJNwNmQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	=?UTF-8?B?WXUgWmhhb++/vA==?= <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	=?UTF-8?B?WW9zcnkgQWhtZWTvv7w=?= <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:15=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Sat, 2024-02-03 at 10:12 -0800, Chris Li wrote:
> >
> > > > >  {
> > > > >     struct swap_slots_cache *cache;
> > > > > @@ -282,17 +298,14 @@ void free_swap_slot(swp_entry_t entry)
> > > > >                     goto direct_free;
> > > > >             }
> > > > >             if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE) {
> > > > > -                   /*
> > > > > -                    * Return slots to global pool.
> > > > > -                    * The current swap_map value is SWAP_HAS_CAC=
HE.
> > > > > -                    * Set it to 0 to indicate it is available fo=
r
> > > > > -                    * allocation in global pool
> > > > > -                    */
> > > > > -                   swapcache_free_entries(cache->slots_ret, cach=
e->n_ret);
> > > > > -                   cache->n_ret =3D 0;
> > > > > +                   spin_unlock_irq(&cache->free_lock);
> > > > > +                   schedule_work(&cache->async_free);
> > > > > +                   goto direct_free;
> > > > >             }
> > > > >             cache->slots_ret[cache->n_ret++] =3D entry;
> > > > >             spin_unlock_irq(&cache->free_lock);
> > > > > +           if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE)
> > > > > +                   schedule_work(&cache->async_free);
> > >
> > >
> > > I have some concerns about the current patch with the change above.
> > > We could hit the direct_free path very often.
> > >
> > > By delaying the freeing of entries in the return
> > > cache, we have to do more freeing of swap entry one at a time. When
> > > we try to free an entry, we can find the return cache still full, wai=
ting to be freed.
> >
> > You are describing the async free is not working. In that case it will =
always
> > hit the direct free path one by one.
> >
> > >
> > > So we have fewer batch free of swap entries, resulting in an increase=
 in
> > > number of sis->lock acquisitions overall. This could have the
> > > effect of reducing swap throughput overall when swap is under heavy
> > > operations and sis->lock is contended.
> >
> > I  can change the direct free path to free all entries. If the async
> > free hasn't freed up the batch by the time the next swap fault comes in=
.
> > The new swap fault will take the hit, just free the whole batch. It wil=
l behave
> > closer to the original batch free behavior in this path.
> >
> Will that negate the benefit you are looking for?

It should not. In our deployment, the rate of swap faults isn't that
high. It is one of the matrices that gets monitored and controlled. If
the swap fault gets that busy, the app's performance most likely
already starts to suffer from it. We should back off from swapping out
that much.
I expect the normal case, the async free already free up the 64
entries before the next swap fault on the same CPU hits.

> A hack is to double the SWAP_SLOTS_CACHE_SIZE to 128, and trigger the
> background reclaim when entries reach 64. This will allow you to avoid
> the one by one relcaim direct path and hopefully the delayed job
> would have done its job when slots accumulate between 64 and 128.

I would have some concern on that due to higher per CPU memory usage.
We have machines with high CPU count. That would mean more memory
reserved. I actually have a variant of the patch that starts the async
free before it reaches the 64 entries limit. e.g. 60 entries. It will
give some head room to avoid the direct free path for another 4
entries. I did not include that in the patch because it makes things
more complicated, also this code path isn't taking much at all. If it
helps I can resurrect that in the patch as V3.
>
> However, I am unsure how well this hack is under really heavy
> swap load.  It means that the background reclaim will need to

In our system, a really heavy swap load is rare and it means something
is already wrong. At that point the app's SLO is likely at risk,
regardless of long tail swap latency. It is already too late to
address it at the swap fault end. We need to address the source of the
problem which is swapping out too much.

> work through a larger backlog and
> hold the sis->lock longer. So if you hit the direct path while
> the background reclaim is underway, you may have longer tail latency
> to acquire the sis->lock.

Chris

