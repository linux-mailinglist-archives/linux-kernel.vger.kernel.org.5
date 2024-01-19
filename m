Return-Path: <linux-kernel+bounces-30773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CBC832431
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B9E1F23939
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A24A0F;
	Fri, 19 Jan 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQLfISwg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27506469E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705641869; cv=none; b=Nq3hzhyzAYM2jqnwbJGwAL31+99ycR3CjJ4PBA8lth8G26VcnfF5HBg7DQHdznGGu3L/tBAVqzIqhq5TdzWDLPmzsLOZ71FqfDPCsa5HFpJId7hkwmSBRKvL5FbJSS0xlQXms1oxLz0sedaVhlIF1ldKpykQIZfjtX6U3luPj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705641869; c=relaxed/simple;
	bh=GZXH9M4vRYlIBKd2B1NBqugB5mUzmY+xYn4wpQol9Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7gQBZxlr5JcQklUJiYL7+SHnkFi5zsSJitgBaZRUl1QyKt1Gj3+O/0W/W7RvbpGdhT/mdiivQJhPNr97/djKghnQVG+FmFjecLUtqHb76WEhSdnQ9I/QwIBjofnwovx3+h0da0GIz/9lOp0s9zUXkRQAp4bVJbWq5i3rk6Ep6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQLfISwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBEFC43609
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705641868;
	bh=GZXH9M4vRYlIBKd2B1NBqugB5mUzmY+xYn4wpQol9Co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cQLfISwggyTHG7Wu7DGoNQtD4oeFqTAFtiDX8sdQzlDop8PZp5eUSB8mtNCV9TgOy
	 1KaUFy7UBDl4XFXk4VexgOhn+3+I2EfbYWX/+NfgLmaPhSmY53iCbttzrlrWYSwLbP
	 tZ4ATuPP+jZSKRLtwp4NCqYAF/Xf2LTWilQEWQdVwU/ZHhpLX1jjAfTGIlisnDB970
	 sZkSyD+wq7i9oLMMS62pMM5hJhWHQHgiwKFRNPS1CbjTNra6wJWLQ/sS3jXrO+dyaa
	 9KT5V/KjK9dQHR20MtdtCATT93x1H3aK6ohSB9GrkKRlTtSZ66AVk5x2bcknAv7uoe
	 liC2DbrXA7NOg==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28e724d9c47so310886a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:24:28 -0800 (PST)
X-Gm-Message-State: AOJu0YyWLOj91twBa7UrqfQHjIrRlf1SLLcIwA5pPBO2lg2PqkzNJE3/
	JfYvKjOHozslbPsJJvOxIj/SemDyDskkh2rQmunjcJHbR48mtJX6iWd6mD/rdmFGw2iS+hEmt3t
	7pHYILsgp2VTGAfARTiAOz6yXcfsGATZKWoM3
X-Google-Smtp-Source: AGHT+IE8GFri0v06WYstA1NMeuaRhD8fD8knkjPgfOePLZOOetmV4TfCs6TKuy2lMnpiYhZ5n76GkLIIdOlLn6IyHII=
X-Received: by 2002:a17:90a:b00c:b0:28c:a722:c587 with SMTP id
 x12-20020a17090ab00c00b0028ca722c587mr1638769pjq.42.1705641867801; Thu, 18
 Jan 2024 21:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
In-Reply-To: <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Jan 2024 21:24:16 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
Message-ID: <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Wed, Jan 17, 2024 at 10:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > The xarray tree is added alongside the zswap RB tree.
> > Checks for the xarray get the same result as the RB tree operations.
> >
> > Rename the zswap RB tree function to a more generic function
> > name without the RB part.
>
> As I mentioned in the cover letter, I believe this should be squashed
> into the second patch. I have some comments below as well on the parts
> that should remain after the squash.
>
> [..]
> >
> > @@ -462,9 +463,9 @@ static void zswap_lru_putback(struct list_lru *list=
_lru,
> >  /*********************************
> >  * rbtree functions
> >  **********************************/
> > -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff=
_t offset)
> > +static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff=
_t offset)
>
> Let's change the zswap_rb_* prefixes to zswap_tree_* instead of just
> zswap_*. Otherwise, it will be confusing to have both zswap_store and
> zswap_insert (as well as zswap_load and zswap_search).

How about zswap_xa_* ?

>
> [..]
> > @@ -1790,15 +1808,21 @@ void zswap_swapon(int type)
> >  void zswap_swapoff(int type)
> >  {
> >         struct zswap_tree *tree =3D zswap_trees[type];
> > -       struct zswap_entry *entry, *n;
> > +       struct zswap_entry *entry, *e, *n;
> > +       XA_STATE(xas, tree ? &tree->xarray : NULL, 0);
> >
> >         if (!tree)
> >                 return;
> >
> >         /* walk the tree and free everything */
> >         spin_lock(&tree->lock);
> > +
> > +       xas_for_each(&xas, e, ULONG_MAX)
>
> Why not use xa_for_each?
>
> > +               zswap_invalidate_entry(tree, e);
> > +
> >         rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, r=
bnode)
> > -               zswap_free_entry(entry);
>
> Replacing zswap_free_entry() with zswap_invalidate_entry() is a
> behavioral change that should be done separate from this series, but I
> am wondering why it's needed. IIUC, the swapoff code should be making
> sure there are no ongoing swapin/swapout operations, and there are no
> pages left in zswap to writeback.
>
> Is it the case that swapoff may race with writeback, such that
> writeback is holding the last remaining ref after zswap_invalidate()
> is called, and then zswap_swapoff() is called freeing the zswap entry
> while writeback is still accessing it?

For the RB tree the mapping is stored in the zswap entry as RB node.
That is different from xarray. Xarry stores the mapping outside of
zswap entry. Just freeing the entry does not remove the mapping from
xarray. Therefore it needs to call zswap_invalidate_entry() to remove
the entry from the xarray. I could call zswap_erase() then free entry.
I just think zswap_invalidate_entry() is more consistent with the rest
of the code.

Chris

