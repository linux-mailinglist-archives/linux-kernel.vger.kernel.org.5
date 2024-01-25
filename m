Return-Path: <linux-kernel+bounces-37979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC783B919
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECBDB21135
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38113D287;
	Thu, 25 Jan 2024 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyBiAmZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7A8495
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161453; cv=none; b=mnWCxp9G14ySOQ0HQJtaA2V2bIIE16OU6ekVAdSSyMMgdibYa4deV7YmNzpJ/T5uKOYSBh5jTlXEsCb3NIIqvE3sYIfEtfE8z7ZlPTykzTHOrKrSWpKF/PqIiSAlN1HHRLT6KdCajC2R0OQrkWN8EC4cDHcAd06YqpGt5RYjjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161453; c=relaxed/simple;
	bh=sP52rUy6+iN9QS0VLcd6Pwiic1NGZEoMk9V3x/1a23Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T735JFLONz9LeKaL3JC4aS0deDEoWYPDYIu5xOwE1uRqCL6wwlMRotIlxN0hbWLLLg/YPW2hDzpPceK52k7cukQTYWDhl+ZC9lBzQv/HdYSWe9rLOA/6BYo3tBZ34HfPdJ82JluuZfj+oWlq6iQ4sQSgwWBYUAdABFLBrg+EYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyBiAmZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8071C43399
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706161452;
	bh=sP52rUy6+iN9QS0VLcd6Pwiic1NGZEoMk9V3x/1a23Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MyBiAmZrfbYvOTdCEYi3l+LxL+ewQRdUlqh3y3hhnHIKF7mMcGA30YaCpBhZJvXka
	 niIIHhmP96g+N7J1GTxL14sfFrnM27O0o06xpmZCoFAWaCBYBuNG5BRVzKEqUEa4NR
	 52qoR3vJxdU7PQIaLgidViaarYei53n9DWSAZwd64M8pxnC3hAdq/nPyARxrpxS1eq
	 QYnlhXpbdh1ODufhqxnIsg9KIJfuRXnEpzLzEIZqduwKWEd7dWV37ViFCbUKo0wRpw
	 zJSoTB5/6kaDwx7AKf6rHUGMDcE7r7Xot1C9M/0+S0RpDbFKirGfD7U1qkgeiXuSzd
	 h059cb6s8VQwQ==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so3464387a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:44:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxVD47+TdejvMozE6eVieYKWJlfOIvA5iZKCyosEUgp1K9adsyj
	oqN1rNTCRX8e0s5FDFCOSenHMgg3R9LOvjRXP77jB03Sid2VrQn2MmHliWsb3EKrgKB5dvoTgqZ
	fCj/424q9oXT8xsRGJmj9a6HF/FFmrn/l7TEK
X-Google-Smtp-Source: AGHT+IFBK3SXfs8luX9Jv606z385vOaMQRO31iqXYMrwv6gz2+OcK9wo1metGq7mLIfg3p2fm52PICtPvDwxvxCu5+8=
X-Received: by 2002:a17:90b:4b52:b0:28e:79a4:979c with SMTP id
 mi18-20020a17090b4b5200b0028e79a4979cmr263316pjb.58.1706161452171; Wed, 24
 Jan 2024 21:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
In-Reply-To: <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 24 Jan 2024 21:44:00 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOv0FHsHgp=i7ZzjTpvZ7fN8uOQ3DT=8Q2eYWzRM7Hsgw@mail.gmail.com>
Message-ID: <CAF8kJuOv0FHsHgp=i7ZzjTpvZ7fN8uOQ3DT=8Q2eYWzRM7Hsgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:21=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
> > Thanks for the great analysis, I missed the swapoff/swapon race myself =
:)
> >
> > The first solution that came to mind for me was refcounting the zswap
> > tree with RCU with percpu-refcount, similar to how cgroup refs are
> > handled (init in zswap_swapon() and kill in zswap_swapoff()). I think
> > the percpu-refcount may be an overkill in terms of memory usage
> > though. I think we can still do our own refcounting with RCU, but it
> > may be more complicated.
> Hello,
>
> I also thought about this problem for some time, maybe something like bel=
ow
> can be changed to fix it? It's likely I missed something, just some thoug=
hts.
>
> IMHO, the problem is caused by the different way in which we use zswap en=
try
> in the writeback, that should be much like zswap_load().

It is possible to keep the behavior difference and get the tree right.
Follow a few rules:
1) Always bump the zswap entry refcount after finding the entry
(inside the RCU read lock)
2) Always free entry after refcount drops to zero.
3) Swap off should just wait for the each entry ref count drop to zero
(or 1 including the swap off code holding one) then free it. Swap off
is the slow path anyway.
BTW, the swap off is where swap device locks get a lot of contention.

>
> The zswap_load() comes in with the folio locked in swap cache, so it has
> stable zswap tree to search and lock... But in writeback case, we don't,
> shrink_memcg_cb() comes in with only a zswap entry with lru list lock hel=
d,
> then release lru lock to get tree lock, which maybe freed already.
>
> So we should change here, we read swpentry from entry with lru list lock =
held,
> then release lru lock, to try to lock corresponding folio in swap cache,
> if we success, the following things is much the same like zswap_load().
> We can get tree lock, to recheck the invalidate race, if no race happened=
,
> we can make sure the entry is still right and get refcount of it, then
> release the tree lock.
>
> The main differences between this writeback with zswap_load() is the hand=
ling
> of lru entry and the tree lifetime. The whole zswap_load() function has t=
he
> stable reference of zswap tree, but it's not for shrink_memcg_cb() bottom=
 half
> after __swap_writepage() since we unlock the folio after that. So we can'=
t
> reference the tree after that.
>
> This problem is easy to fix, we can zswap_invalidate_entry(tree, entry) e=
arly
> in tree lock, since thereafter writeback can't fail. BTW, I think we shou=
ld
> also zswap_invalidate_entry() early in zswap_load() and only support the
> zswap_exclusive_loads_enabled mode, but that's another topic.
>
> The second difference is the handling of lru entry, which is easy that we
> just zswap_lru_del() in tree lock.
>
> So no any path can reference the entry from tree or lru after we release
> the tree lock, so we can just zswap_free_entry() after writeback.
>
> Thanks!
>
> // lru list lock held
> shrink_memcg_cb()
>   swpentry =3D entry->swpentry
>   // Don't isolate entry from lru list here, just use list_lru_putback()
>   spin_unlock(lru list lock)
>
>   folio =3D __read_swap_cache_async(swpentry)
>   if (!folio)
>     return
>
>   if (!folio_was_allocated)
>     folio_put(folio)
>     return
>
>   // folio is locked, swapcache is secured against swapoff
>   tree =3D get tree from swpentry
>   spin_lock(&tree->lock)

That will not work well with zswap to xarray change. We want to remove
the tree lock and only use the xarray lock.
The lookup should just hold xarray RCU read lock and return the entry
with ref count increased.

Chris

>
>   // check invalidate race? No
>   if (entry =3D=3D zswap_rb_search())
>
>   // so we can make sure this entry is still right
>   // zswap_invalidate_entry() since the below writeback can't fail
>   zswap_entry_get(entry)
>   zswap_invalidate_entry(tree, entry)
>
>   // remove from lru list
>   zswap_lru_del()
>
>   spin_unlock(&tree->lock)
>
>   __zswap_load()
>
>   __swap_writepage() // folio unlock
>   folio_put(folio)
>
>   // entry is safe to free, since it's removed from tree and lru above
>   zswap_free_entry(entry)
>
>

