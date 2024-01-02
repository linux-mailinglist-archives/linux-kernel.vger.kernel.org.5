Return-Path: <linux-kernel+bounces-14970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7182257C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC621C226C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6A1773F;
	Tue,  2 Jan 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlCLByts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5401773D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fbe3db16so511691239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704238034; x=1704842834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijNyREx7RmSnDkgeKzcdo1eWDZjQ758hbgo/HA1vnUs=;
        b=dlCLBytse+mtdUU4erUa4p8x53HhCIDRSSIfuCjJqVOLuYynyCFq4yz7jlS9+YVbGp
         MRU6KIqjSKHfa3y8KHFLRgEyh9MZA+3zMImSC7ferTO43qU8tSM7ZDOMe0c4ct7Owwqw
         bsDqG8JgQXKcZrtB8T9acf0rYNR4hsFvGLf37P1cPAjWfJ000f4a1/kangRUmSusn9AM
         +dEBM9GtfOA5lmE2f874lF5FXxG4i8EIWLPOSu6jrwTRHX75mTCzHYrhQjouG2DochIW
         MEqVrIVZhAIe952N7vBSD6jjJJjfZ2amBsaDfo+VSvi5FgZ9kF9Ztz8hFeLoQYDq5w1c
         Dc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704238034; x=1704842834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijNyREx7RmSnDkgeKzcdo1eWDZjQ758hbgo/HA1vnUs=;
        b=tag2jQYS6iAbsqZEn2rwY7O9PDkk/8OhHAmyg7O1aeH0weuxTCbORNMRvXmwpvt5wX
         vYGqO0LtIBLJN6tkMSH840Bnyo/wgiRSyDLEebtZ/mstNzMfUA/am+eSfeld9jzP4lxw
         n/J5VKtwULLfqVGE1KmETRxGSe+vi7R4TSFswZrPHZPJX5K+M/S1TZNOL7sgNGl9KnD0
         owgJR0t1g7LOXKAfwJTIKrH4iaxNWQJXgYw0O07AzaT7yU8SxIUNToMQzpOU6HlpohoY
         pQqI4GMH3KLbCAJHYKxNTWYNBG3iEpdki/Nwt3e+ldxlMSBiqO+G4a0IsPq5FUZ49NoB
         K6eQ==
X-Gm-Message-State: AOJu0Yx3IgPPk8rbXCdflkEjZ+dGixlN+TYFSlDPrmTLiVj9FJKfU/44
	fh/Lz/XVbCcpkXfwNdhhPutN55CuJd50RNJY0Bc=
X-Google-Smtp-Source: AGHT+IEwNx7QIYUAUpl8QWTcHIgZ7RQODDJ6nQ5b93k+gINCpn68yEpoLKtXdt9/hMw/eiAtROF65ps/nbJPWMmuySM=
X-Received: by 2002:a5d:8510:0:b0:7bb:9f7f:b790 with SMTP id
 q16-20020a5d8510000000b007bb9f7fb790mr5021266ion.28.1704238034239; Tue, 02
 Jan 2024 15:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com> <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
In-Reply-To: <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 2 Jan 2024 15:27:03 -0800
Message-ID: <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 3:39=E2=80=AFAM Zhongkun He <hezhongkun.hzk@bytedanc=
e.com> wrote:
>
> On Sat, Dec 30, 2023 at 10:09=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > On Tue, Oct 24, 2023 at 7:27=E2=80=AFAM Zhongkun He
> > <hezhongkun.hzk@bytedance.com> wrote:
> > >
> >
> > My apologies for the delayed response. I have a couple of questions.
> >
> > > The zswap_writeback_entry() will add a page to the swap cache, decomp=
ress
> > > the entry data into the page, and issue a bio write to write the page=
 back
> > > to the swap device. Move the page to the tail of lru list  through
> > > SetPageReclaim(page) and folio_rotate_reclaimable().
> > >
> > > Currently, about half of the pages will fail to move to the tail of l=
ru
> >
> > May I ask what's the downstream effect of this? i.e so what if it
> > fails? And yes, as Andrew pointed out, it'd be nice if the patch
> > changelog spells out any observable or measurable change from the
> > user's POV.
> >
>
> The swap cache page used to decompress zswap_entry should be
> moved  to the tail of the inactive list after end_writeback, We can relea=
se
> them in time.Just like the following code in zswap_writeback_entry().
>
>    /* move it to the tail of the inactive list after end_writeback */
>    SetPageReclaim(page);
>
> After the writeback is over, the function of
> folio_rotate_reclaimable() will fail
> because the page is not in the LRU list but in some of the cpu folio batc=
hes.
> Therefore we did not achieve the goal of setting SetPageReclaim(page), an=
d
> the pages could not be free in time.
>
> > > list because there is no LRU flag in page which is not in the LRU lis=
t but
> > > the cpu_fbatches. So fix it.
> >
> > This sentence is a bit confusing to me. Does this mean the page
> > currently being processed for writeback is not in the LRU list
> > (!PageLRU(page)), but IN one of the cpu folio batches? Which makes
> > folio_rotate_reclaimable() fails on this page later on in the
> > _swap_writepage() path? (hence the necessity of lru_add_drain()?)
> >
>
> Yes, exactly.
>
> > Let me know if I'm misunderstanding the intention of this patch. I
> > know it's a bit pedantic, but spelling things out (ideally in the
> > changelog itself) will help the reviewers, as well as future
> > contributors who want to study the codebase and make changes to it.
> >
>
> Sorry,my bad.
>
> > >
> > > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> >
> > Thanks and look forward to your response,
> > Nhat
> >
> > P/S: Have a nice holiday season and happy new year!
>
> Here are the steps and results of the performance test=EF=BC=9A
> 1:zswap+ zram (simplified model with on IO)
> 2:disabel zswap/parameters/same_filled_pages_enabled (stress have same pa=
ges)
> 3:stress --vm 1 --vm-bytes 2g --vm-hang 0   (2Gi anon pages)
> 4: In order to quickly release zswap_entry, I used the previous
>      patch (I will send it again later).
> https://lore.kernel.org/all/20231025095248.458789-1-hezhongkun.hzk@byteda=
nce.com/
>
> Performance result=EF=BC=9A
>    reclaim 1Gi zswap_entry
>
> time echo 1 > writeback_time_threshold
> (will release the zswap_entry,  not been accessed for more than 1 seconds=
 )
>
> Base                                 With this patch
> real    0m1.015s               real    0m1.043s
> user    0m0.000s              user    0m0.001s
> sys     0m1.013s               sys     0m1.040s
> So no obvious performance regression was found.

That's around 2.7% increase in real time, no? Admittedly, this
micro-benchmark is too small to conclude either way, but the data
doesn't seem to be in your favor.

I'm a bit concerned about the overhead here, given that with this
patch we will drain the per-cpu batch on every written-back entry.
That's quite a high frequency, especially since we're moving towards
more writeback (either with the new zswap shrinker, or your time
threshold-based writeback mechanism). For instance, there seems to be
some (local/per-cpu) locking involved, no? Could there be some form of
lock contentions there (especially since with the new shrinker, you
can have a lot of concurrent writeback contexts?)

Furthermore, note that a writeback from zswap to swap saves less
memory than a writeback from memory to swap, so the effect of the
extra overhead will be even more pronounced. That is, the amount of
extra work done (from this change) to save one unit of memory would be
even larger than if we call lru_add_drain() every time we swap out a
page (from memory -> swap). And I'm pretty sure we don't call
lru_add_drain() every time we swap out a page - I believe we call
lru_add_drain() every time we perform a shrink action. For e.g, in
shrink_inactive_list(). That's much coarser in granularity than here.

Also, IIUC, the more often we perform lru_add_drain(), the less
batching effect we will obtain. IOW, the overhead of maintaining the
batch will become higher relative to the performance gains from
batching.

Maybe I'm missing something - could you walk me through how
lru_add_drain() is fine here, from this POV? Thanks!

>
> After writeback, we perform the following steps to release the memory aga=
in
> echo 1g > memory.reclaim
>
> Base:
>                      total        used        recalim        total       =
 used
> Mem:           38Gi       2.5Gi       ---->             38Gi       1.5Gi
> Swap:         5.0Gi       1.0Gi       ---->              5Gi        1.5Gi
> used memory  -1G   swap +0.5g
> It means that  half of the pages are failed to move to the tail of lru li=
st,
> So we need to release an additional 0.5Gi anon pages to swap space.
>
> With this patch:
>                      total        used        recalim        total       =
 used
> Mem:           38Gi       2.6Gi       ---->             38Gi       1.6Gi
> Swap:         5.0Gi       1.0Gi       ---->              5Gi        1Gi
>
> used memory  -1Gi,  swap +0Gi
> It means that we release all the pages which have been add to the tail of
> lru list in zswap_writeback_entry() and folio_rotate_reclaimable().
>

OTOH, this suggests that we're onto something. Swap usage seems to
decrease quite a bit. Sounds like a real problem that this patch is
tackling.
(Please add this benchmark result to future changelog. It'll help
demonstrate the problem).

I'm inclined to ack this patch, but it'd be nice if you can assuage my
concerns above (with some justification and/or larger benchmark).

(Or perhaps, we have to drain, but less frequently/higher up the stack?)

Thanks,
Nhat

>
> Thanks for your time Nhat and Andrew. Happy New Year!

