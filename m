Return-Path: <linux-kernel+bounces-102637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C604C87B52A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0B11C21846
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE65DF19;
	Wed, 13 Mar 2024 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2rSZ87A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891095D724
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372288; cv=none; b=hgPF0NpsorYb683uE9KKmbHpy5oFGMnSNIKMXnZH1H3mkUSwkzIA8H1jhXDiTynpqnE+M82Rojb2p+kFUsnsQG9fJoxPrXDdn2sQf3aiY2zmLc0jutpLB9iirfQztRmyUTScayPgWNlE/f9y40ytEiTMUR7LccEzjr9AGjVTH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372288; c=relaxed/simple;
	bh=ePfFqyfxcuzWYHoB97QDAJ1VD497QbbBMW6eC6d8BPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sb9cTK65ZctA83yGzkjfE0v+hBRZm5vLJAQBxviunvim1dwPcasha/R1+E/pweaHpw0zQVvNe71shv5eugOD3UyoCavbTG4rsHSp4ECc4qkCoqUiSzMM3BQ06hF2SPIFJnFtbFsQDE0NLGi5I3jgoEz0R17XFE/kLGtWDrovL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2rSZ87A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176FCC43394
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710372288;
	bh=ePfFqyfxcuzWYHoB97QDAJ1VD497QbbBMW6eC6d8BPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A2rSZ87AHWsoWPGjy9zGKM7JyxHj+MNVY0mk+eWlpvsG7JiBoH2Gu7LxUolyEEi/P
	 0rs8neNAH8kIcrxjtUNVPTQnk/Oz+dKY9XQEINjAySnOMq7n3jUEVussIgIhfukFB0
	 zoE/JfLPMRhHkp6dEWO4zI7cZwOLunZFGs6FsHs3O/eKyTK+YVm4AR7wa8yScSD5c3
	 QFs1b3UeKU1WXwbNajkI+hM8W5sgnq8wlQq7iTjmC/2M6U7+g/phMNYHDWAMtsfDNN
	 DkYHW/TdvRmshGZGKTiqBTxgJu2XMG4BmnljfMtBo/ZsKU0cbE/EWdgt5JYwYPiPuG
	 3mfElKGik9c8A==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3662d7c79a9so2326485ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:24:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN1G2RhB9jT7OZ6Jg+BGarmk/XqoU29gliUME/FSmOt0dvAsYkmTfAxjlA5BnkeGjKXV76em5zbcIH4Pf0Vj62YalBvX/6Q9IpGo+D
X-Gm-Message-State: AOJu0Yy46+HGVTzpATJIub7gNGvn4T6I2cSQJQugJvzd8QibhlhCQEFS
	nCrg0IwajX7jVgbPFUSuUVMV5bUo3LPWYKLot2r59fENc1Rr2JXIpRn8gVessNgzX8QKVgeg0aL
	wbSqktHockVE/l6mdwO06Eb+1Qb8mpNtBGGRW
X-Google-Smtp-Source: AGHT+IHJSCudccMCWmLtz++Bwl3u1dldevDMpcVAhNTL8172hjishm+vdw8xUlc4kCTeiv3/TsWP/5hVVWlIK4LeqYI=
X-Received: by 2002:a92:60e:0:b0:365:b00e:c3ba with SMTP id
 x14-20020a92060e000000b00365b00ec3bamr65111ilg.9.1710372287384; Wed, 13 Mar
 2024 16:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org> <20240312184329.GA3501@cmpxchg.org>
In-Reply-To: <20240312184329.GA3501@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 13 Mar 2024 16:24:34 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM8YAwnNA4LJqwuM1mu9+UaBek0_K+jG4JjUmu6RRqSNg@mail.gmail.com>
Message-ID: <CAF8kJuM8YAwnNA4LJqwuM1mu9+UaBek0_K+jG4JjUmu6RRqSNg@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Barry Song <v-songbaohua@oppo.com>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Tue, Mar 12, 2024 at 11:43=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Mar 12, 2024 at 10:31:12AM -0700, Chris Li wrote:
> > Very deep RB tree requires rebalance at times. That
> > contributes to the zswap fault latencies. Xarray does not
> > need to perform tree rebalance. Replacing RB tree to xarray
> > can have some small performance gain.
> >
> > One small difference is that xarray insert might fail with
> > ENOMEM, while RB tree insert does not allocate additional
> > memory.
> >
> > The zswap_entry size will reduce a bit due to removing the
> > RB node, which has two pointers and a color field. Xarray
> > store the pointer in the xarray tree rather than the
> > zswap_entry. Every entry has one pointer from the xarray
> > tree. Overall, switching to xarray should save some memory,
> > if the swap entries are densely packed.
> >
> > Notice the zswap_rb_search and zswap_rb_insert always
> > followed by zswap_rb_erase. Use xa_erase and xa_store
> > directly. That saves one tree lookup as well.
> >
> > Remove zswap_invalidate_entry due to no need to call
> > zswap_rb_erase any more. Use zswap_free_entry instead.
> >
> > The "struct zswap_tree" has been replaced by "struct xarray".
> > The tree spin lock has transferred to the xarray lock.
> >
> > Run the kernel build testing 10 times for each version, averages:
> > (memory.max=3D2GB, zswap shrinker and writeback enabled,
> > one 50GB swapfile, 24 HT core, 32 jobs)
> >
> > mm-9a0181a3710eb             xarray v5
> > user       3532.385                   3535.658
> > sys        536.231                      530.083
> > real       200.431                      200.176
>
> This is a great improvement code and complexity wise.

Thanks!

>
> I have a few questions and comments below:
>
> What kernel version is this based on? It doesn't apply to
> mm-everything, and I can't find 9a0181a3710eb anywhere.

It is based on an old version of the mm-unstable. I can try to rebase
on mm-everything or later mm-unstable.

>
> > @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
> >  insert_entry:
> >       entry->swpentry =3D swp;
> >       entry->objcg =3D objcg;
> > -     if (objcg) {
> > -             obj_cgroup_charge_zswap(objcg, entry->length);
> > -             /* Account before objcg ref is moved to tree */
> > -             count_objcg_event(objcg, ZSWPOUT);
> > -     }
> >
> > -     /* map */
> > -     spin_lock(&tree->lock);
> >       /*
> >        * The folio may have been dirtied again, invalidate the
> >        * possibly stale entry before inserting the new entry.
> >        */
>
> The comment is now somewhat stale and somewhat out of place. It should
> be above that `if (old)` part... See below.

Ack.

>
> > -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXI=
ST) {
> > -             zswap_invalidate_entry(tree, dupentry);
> > -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry))=
;
> > +     old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> > +     if (xa_is_err(old)) {
> > +             int err =3D xa_err(old);
> > +             if (err =3D=3D -ENOMEM)
> > +                     zswap_reject_alloc_fail++;
> > +             else
> > +                     WARN_ONCE(err, "%s: xa_store failed: %d\n",
> > +                               __func__, err);
> > +             goto store_failed;
>
> No need to complicate it. If we have a bug there, an incorrect fail
> stat bump is the least of our concerns. Also, no need for __func__
> since that information is included in the WARN:
>
>         if (xa_is_err(old)) {
>                 WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
>                 zswap_reject_alloc_fail++;
>                 goto store_failed;
>         }

Ah, I see. Thanks for the simplification.

>
> I think here is where that comment above should go:

Ack.

>
>         /*
>          * We may have had an existing entry that became stale when
>          * the folio was redirtied and now the new version is being
>          * swapped out. Get rid of the old.
>          */
> > +     if (old)
> > +             zswap_entry_free(old);
> > +
> > +     if (objcg) {
> > +             obj_cgroup_charge_zswap(objcg, entry->length);
> > +             /* Account before objcg ref is moved to tree */
> > +             count_objcg_event(objcg, ZSWPOUT);
> >       }
> > +
> >       if (entry->length) {
> >               INIT_LIST_HEAD(&entry->lru);
> >               zswap_lru_add(&zswap.list_lru, entry);
> >               atomic_inc(&zswap.nr_stored);
> >       }
> > -     spin_unlock(&tree->lock);
>
> We previously relied on the tree lock to finish initializing the entry
> while it's already in tree. Now we rely on something else:
>
>         1. Concurrent stores and invalidations are excluded by folio lock=
.
>
>         2. Writeback is excluded by the entry not being on the LRU yet.
>            The publishing order matters to prevent writeback from seeing
>            an incoherent entry.
>
> I think this deserves a comment.

I will add your 1. and 2. into a comment block. Thanks for the suggestion.

>
> >       /* update stats */
> >       atomic_inc(&zswap_stored_pages);
> > @@ -1585,6 +1510,12 @@ bool zswap_store(struct folio *folio)
> >
> >       return true;
> >
> > +store_failed:
> > +     if (!entry->length) {
> > +             atomic_dec(&zswap_same_filled_pages);
> > +             goto freepage;
> > +     }
>
> It'd be good to avoid the nested goto. Why not make the pool
> operations conditional on entry->length instead:
>
> store_failed:
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
>                 zpool_free(zswap_find_zpool(...));
> put_pool:
>                 zswap_pool_put(entry->pool);
>         }
> freepage:

Sure, I have one internal version exactly like that. I later changed
again to get rid of the else. I can use your version as well.

>
> Not super pretty either, but it's a linear flow at least.

Thanks for your suggestions. I will send out a new version.

Chris

