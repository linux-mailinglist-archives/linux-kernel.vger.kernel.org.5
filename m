Return-Path: <linux-kernel+bounces-17181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDA824938
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6FFB23E61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A7F2D61A;
	Thu,  4 Jan 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+NklfIb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34A2D610
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3606ad581a5so2041705ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704397389; x=1705002189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usIKlCrnp0i3uK40dHHaJigAXDYBuDn6Lo+eszj4SqA=;
        b=J+NklfIbe1fCOWe4DOBkOlJwemIa06G3oYuftDRl0u6vcF4mSiGKazIi2PLh8WFw/o
         S3Kpk5C6ApgsqyoKNQhnaBt0bs8BZsqDboOUDVrNPFEvIIHqUhmw2aXcFyKj2IItXHRB
         ypPFmkh7r4OlIbQZhp98cRrUnNWYdkrrLTEbNH+4DfnJF5J/j2L0L0zDxTXjdQOJ5ZSY
         LTC58fiALVQQ4NijYjEPXP4MezY5WLM9KIA0wJbtHPFEyLvam8N8xW6kyNyqo9ZcMjcF
         xL17BGLpMyUAA/WonCq+o5JzECdppXVZJxLJnGcH0hp7nI5MlcCLHzehl7ClWPa4Mahc
         c6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397389; x=1705002189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usIKlCrnp0i3uK40dHHaJigAXDYBuDn6Lo+eszj4SqA=;
        b=LtHJTo/UywrcnttcqdfomdhaGWRvkdnUdoZfYfX/w/A8MlGi9W6l7ElCmsrRLJf5ZN
         y6B6vFQ9dSQlWEz453L/yOcb8hVE1xq2leeTsk8Hd0f6wtweGyctmaJJQUOnvr5I7c1e
         my3J+F0tVo5NonHIC5D0xm4JW4Y56qX42nHxsNPgcBofylNu96qjqw9vsCheboLOy/Xy
         TBmLcvGOmCETKhAm9B9h164bh0N8KzuTxviwG7b28GcOllAm3enXLS5BQ+A+QCNKTxek
         kKX8WQkKyOL3X5BgknhSRZhRZI9PC4Ap6tp7Aa8DXOmcx1YUL9acVodgGpqjt64cxaE6
         yGug==
X-Gm-Message-State: AOJu0Yx9f4x95DQgn+Na7ozbZLPrdgzXRfv3bXT6B7juW5CVcdth7CVn
	OceTX2NYo/dFPX1Y/rYZEli6vkRgn8hwIqtl11pz4w9e3iyaTA==
X-Google-Smtp-Source: AGHT+IH9abU05gCc5ulyR08ynDAmb1I3QyVbDaJ1OWegfX8aTjJxyomOQilQOOJo3Q7MMV9Vlo1bTOTiHbh+lAXew0s=
X-Received: by 2002:a05:6e02:1525:b0:35d:61b6:a9e1 with SMTP id
 i5-20020a056e02152500b0035d61b6a9e1mr1049490ilu.54.1704397389200; Thu, 04 Jan
 2024 11:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com> <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
In-Reply-To: <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 4 Jan 2024 11:42:58 -0800
Message-ID: <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:12=E2=80=AFAM Zhongkun He <hezhongkun.hzk@bytedanc=
e.com> wrote:
>
> > That's around 2.7% increase in real time, no? Admittedly, this
> > micro-benchmark is too small to conclude either way, but the data
> > doesn't seem to be in your favor.
> >
> > I'm a bit concerned about the overhead here, given that with this
> > patch we will drain the per-cpu batch on every written-back entry.
> > That's quite a high frequency, especially since we're moving towards
> > more writeback (either with the new zswap shrinker, or your time
> > threshold-based writeback mechanism). For instance, there seems to be
> > some (local/per-cpu) locking involved, no? Could there be some form of
> > lock contentions there (especially since with the new shrinker, you
> > can have a lot of concurrent writeback contexts?)
> >
> > Furthermore, note that a writeback from zswap to swap saves less
> > memory than a writeback from memory to swap, so the effect of the
> > extra overhead will be even more pronounced. That is, the amount of
> > extra work done (from this change) to save one unit of memory would be
> > even larger than if we call lru_add_drain() every time we swap out a
> > page (from memory -> swap). And I'm pretty sure we don't call
> > lru_add_drain() every time we swap out a page - I believe we call
> > lru_add_drain() every time we perform a shrink action. For e.g, in
> > shrink_inactive_list(). That's much coarser in granularity than here.
> >
> > Also, IIUC, the more often we perform lru_add_drain(), the less
> > batching effect we will obtain. IOW, the overhead of maintaining the
> > batch will become higher relative to the performance gains from
> > batching.
> >
> > Maybe I'm missing something - could you walk me through how
> > lru_add_drain() is fine here, from this POV? Thanks!
> >
> > >
> > > After writeback, we perform the following steps to release the memory=
 again
> > > echo 1g > memory.reclaim
> > >
> > > Base:
> > >                      total        used        recalim        total   =
     used
> > > Mem:           38Gi       2.5Gi       ---->             38Gi       1.=
5Gi
> > > Swap:         5.0Gi       1.0Gi       ---->              5Gi        1=
.5Gi
> > > used memory  -1G   swap +0.5g
> > > It means that  half of the pages are failed to move to the tail of lr=
u list,
> > > So we need to release an additional 0.5Gi anon pages to swap space.
> > >
> > > With this patch:
> > >                      total        used        recalim        total   =
     used
> > > Mem:           38Gi       2.6Gi       ---->             38Gi       1.=
6Gi
> > > Swap:         5.0Gi       1.0Gi       ---->              5Gi        1=
Gi
> > >
> > > used memory  -1Gi,  swap +0Gi
> > > It means that we release all the pages which have been add to the tai=
l of
> > > lru list in zswap_writeback_entry() and folio_rotate_reclaimable().
> > >
> >
> > OTOH, this suggests that we're onto something. Swap usage seems to
> > decrease quite a bit. Sounds like a real problem that this patch is
> > tackling.
> > (Please add this benchmark result to future changelog. It'll help
> > demonstrate the problem).
>
> Yes
>
> >
> > I'm inclined to ack this patch, but it'd be nice if you can assuage my
> > concerns above (with some justification and/or larger benchmark).
> >
>
> OK=EF=BC=8Cthanks.
>
> > (Or perhaps, we have to drain, but less frequently/higher up the stack?=
)
> >
>
> I've reviewed the code again and have no idea. It would be better if
> you have any suggestions.

Hmm originally I was thinking of doing an (unconditional)
lru_add_drain() outside of zswap_writeback_entry() - once in
shrink_worker() and/or zswap_shrinker_scan(), before we write back any
of the entries. Not sure if it would work/help here tho - haven't
tested that idea yet.

>
> New test:
> This patch will add the execution of folio_rotate_reclaimable(not execute=
d
> without this patch) and lru_add_drain,including percpu lock competition.
> I bind a new task to allocate memory and use the same batch lock to compe=
te
> with the target process, on the same CPU.
> context:
> 1:stress --vm 1 --vm-bytes 1g    (bind to cpu0)
> 2:stress --vm 1 --vm-bytes 5g --vm-hang 0=EF=BC=88bind to cpu0=EF=BC=89
> 3:reclaim pages, and writeback 5G zswap_entry in cpu0 and node 0.
>
> Average time of five tests
>
> Base      patch            patch + compete
> 4.947      5.0676          5.1336
>                 +2.4%          +3.7%
> compete means: a new stress run in cpu0 to compete with the writeback pro=
cess.
> PID USER        %CPU  %MEM     TIME+ COMMAND                         P
>  1367 root         49.5      0.0       1:09.17 bash     =EF=BC=88writebac=
k=EF=BC=89            0
>  1737 root         49.5      2.2       0:27.46 stress      (use percpu
> lock)    0
>
> around 2.4% increase in real time,including the execution of
> folio_rotate_reclaimable(not executed without this patch) and lru_add_dra=
in,but
> no lock contentions.

Hmm looks like the regression is still there, no?

>
> around 1.3% additional  increase in real time with lock contentions on th=
e same
> cpu.
>
> There is another option here, which is not to move the page to the
> tail of the inactive
> list after end_writeback and delete the following code in
> zswap_writeback_entry(),
> which did not work properly. But the pages will not be released first.
>
> /* move it to the tail of the inactive list after end_writeback */
> SetPageReclaim(page);

Or only SetPageReclaim on pages on LRU?

>
> Thanks=EF=BC=8C
> Zhongkun
>
> > Thanks,
> > Nhat
> >
> > >
> > > Thanks for your time Nhat and Andrew. Happy New Year!

