Return-Path: <linux-kernel+bounces-96121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C986687575E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC341F222DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A7137C42;
	Thu,  7 Mar 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsHzQbB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A101369BB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840399; cv=none; b=a6e1MUa79QXv7UfVANu2W1Bb3TMEkruWEXSwhCwcMmjU6YXiePOsO17kS8/UD8ksTFAZiLSu506S9IpbqVdOMwNP2lY6CG5IiyycbejX/qPmP57GckKMfbrDA41AI8e59DHWhH6/wWJihZdcBEPTKF4UlORuq3LmH1jXybZwm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840399; c=relaxed/simple;
	bh=dbSDSP87aOpNhXjwy73SCHo6YnTZVMEbbAWCLS71F6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AruE4xryoIV/3WV2irY/GG2VQYhc1LX3KToBnPWXKZxllkaOghTKid6n8LvkeB7KHfAYUeFVXUBt3cjAaOALLKRhnrUS30dOOKjSAbiZcQnb7smCdfDN10AC5NPTDf1s12KOHY0Q0rdyduUw6p68fUph7U9CBWqEy7nOb0zO+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsHzQbB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B524C433B1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709840398;
	bh=dbSDSP87aOpNhXjwy73SCHo6YnTZVMEbbAWCLS71F6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CsHzQbB3Jjs/hYrDTUJ+i67+9xj676FsJPoUBXhOqmdoWLKE2r3jLlCDknCHL9s5v
	 yE2eS5lzyRgGHuI3nYsIewk98VZJyBwuwl9pLM/k8Apqe3Qx94B+ECqkW/Aw78QwIY
	 yyzP29/XBdsnbgemrpq95tAychyRSW9/V879GAjhOEBwrDwnHN/aGu7Peg8ARWsERT
	 8d31YENEGEQocPWtNq+ZQ7H2xk9JGqUiZI8Wu1Dw37EfiMrvguKhlUFHVa1EAWLEBx
	 BAj3s15RvhyhKfLhcT63LSLbobj9L/zyWBM1z1pBd60MJv5a34Mj4M32BQFMpTBftf
	 Idg5Vl5+euG/g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so18403681fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC7qOe3sVnPU1HIcCiujtllAtzIsa/OBEhEGa1g7QV34HOJ2tN+HAWLQmgyu/wclDr70Yv3226xifcV5qBiHKViGeAofWmADaRlPcC
X-Gm-Message-State: AOJu0YxmDcgbdC8MI992PJztUSWLWeHUpXSroAdyyCatxg0NxQEX9/D7
	yzShMNs2L0vqxsISLmC4LcYXmpIfEa2svf1/uOI/a5jcRYfDp4UIgPyopSi/oB1Gb/3xJqNA2kt
	UHpvELkMo/yo7x5YVeViisr3sEQ==
X-Google-Smtp-Source: AGHT+IG+BED309zCe22CXbXsl6ZPs+MTfzxKDzdARwSb9OwQ0AwD46EYi/X5zcv9Z4GAnfAoAchhDOyEn0+NyWr83k4=
X-Received: by 2002:a2e:b5a4:0:b0:2d3:c197:ad40 with SMTP id
 f4-20020a2eb5a4000000b002d3c197ad40mr1777002ljn.46.1709840396462; Thu, 07 Mar
 2024 11:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
 <ZeaotMlpMl88lSlc@google.com> <CAF8kJuPcPi22hWhJFGAf0RW2Q8PS_WHKXfUYrcwnpHY2VDVhYg@mail.gmail.com>
 <ZemDuW25YxjqAjm-@google.com>
In-Reply-To: <ZemDuW25YxjqAjm-@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 7 Mar 2024 11:39:44 -0800
X-Gmail-Original-Message-ID: <CANeU7QkFMo0WbFkXV6yKGKAUOYywye3ZVc0VT+fiXnzOfHJP2A@mail.gmail.com>
Message-ID: <CANeU7QkFMo0WbFkXV6yKGKAUOYywye3ZVc0VT+fiXnzOfHJP2A@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 1:07=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > > > -static void zswap_rb_erase(struct rb_root *root, struct zswap_entr=
y *entry)
> > > > -{
> > > > -     rb_erase(&entry->rbnode, root);
> > > > -     RB_CLEAR_NODE(&entry->rbnode);
> > > > +     e =3D xa_store(tree, offset, entry, GFP_KERNEL);
> > > > +     err =3D xa_err(e);
> > > > +
> > > > +     if (err) {
> > > > +             e =3D xa_erase(tree, offset);
> > > > +             if (err =3D=3D -ENOMEM)
> > > > +                     zswap_reject_alloc_fail++;
> > > > +             else
> > > > +                     zswap_reject_xarray_fail++;
> > >
> > > I think this is too complicated, and as Chengming pointed out, I beli=
eve
> > > we can use xa_store() directly in zswap_store().
> >
> > Sure.
> >
> > > I am also not sure what the need for zswap_reject_xarray_fail is. Are
> > > there any reasons why the store here can fail other than -ENOMEM? The
> > > docs say the only other option is -EINVAL, and looking at __xa_store(=
),
> > > it seems like this is only possible if xa_is_internal() is true (whic=
h
> > > means we are not passing in a properly aligned pointer IIUC).
> >
> > Because the xa_store document said it can return two error codes. I
> > see zswap try to classify the error count it hit, that is why I add
> > the zswap_reject_xarray_fail.
>
> Right, but I think we should not get -EINVAL in this case. I think it
> would be more appropriate to have WARN_ON() or VM_WARN_ON() in this
> case?

In the context of the existing zswap code, it seems the zswap keeps
track of different failure reason counters. So that we can read the
failure counter and have a good clue where the source code causes the
failure.

If the document said it can return -EINVAL, I wouldn't just look at
the current implementation and assume it does not generate -EINVAL.
What if the zswap entry allocation has a bug that returns some strange
alignment that makes xarray not happy? There is a lot of assumption
that some error code can or can show up. Just to be consistent with
the other part of the zswap code, I give it a counter to indicate it
is the xarray causing the fail and error. That is the safe thing to
do. It is a good thing this kind of error branch never hits. But if it
does, it gives better information for debugging. It is just following
the same spirit of the rest of the zswap error handling. What do you
say?

>
> [..]
> > > > @@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_ent=
ry *entry, struct page *page)
> > > >  static int zswap_writeback_entry(struct zswap_entry *entry,
> > > >                                swp_entry_t swpentry)
> > > >  {
> > > > -     struct zswap_tree *tree;
> > > > +     struct xarray *tree;
> > > > +     pgoff_t offset =3D swp_offset(swpentry);
> > > > +     struct zswap_entry *e;
> > > >       struct folio *folio;
> > > >       struct mempolicy *mpol;
> > > >       bool folio_was_allocated;
> > > > @@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zsw=
ap_entry *entry,
> > > >        * be dereferenced.
> > > >        */
> > > >       tree =3D swap_zswap_tree(swpentry);
> > > > -     spin_lock(&tree->lock);
> > > > -     if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) !=3D=
 entry) {
> > > > -             spin_unlock(&tree->lock);
> > > > +     e =3D xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
> > > > +     if (e !=3D entry) {
> > >
> > > I think we can avoid adding 'e' and 'offset' local variables here and
> > > just do everything in the if condition. If you want to avoid the line
> > > break, then introducing 'offset' is fine, but I don't see any value f=
rom
> > > 'e'.
> >
> > As I said in my other email. I don't think having this type of local
> > variable affects the compiler negatively. The compiler generally uses
> > their own local variable to track the expression anyway. So I am not
> > sure about the motivation to remove local variables alone, if it helps
> > the reading. I feel the line  "if (xa_cmpxchg(tree, offset, entry,
> > NULL, GFP_KERNEL) !=3D entry)" is too long and complicated inside the i=
f
> > condition. That is just me. Not a big deal.
>
> I just think 'e' is not providing any readability improvements. If
> anything, people need to pay closer attention to figure out 'e' is only
> a temp variable and 'entry' is the real deal.

Well, 'e' is assigned in the previous line and used in the very next
line (only once).
I hardly can see this impact any one understands what it is doing. I
can also come up with a reason (for the argument sake) that this maps
out to the machine code better.  In the machine code it generates, you
see xa_cmpxchg first then "if" branch. You can also ask the debugger
what is the current value of "e", which register is currently mapped
to if it is still in the frame context. But that is not important.

There are also C Macro symbols that define something else, just once.
Are we following the rule to remove all symbols that only define and
use once?

Anyway, the bottom line is that it generates the exact same machine
code. Readability is subjective, there is some personal preference in
it. IMHO the difference in readability is so trivial here that it does
not justify having to flip one way or the other in this case.

>
> I vote for:
>         if (entry !=3D xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL))

I heard you.

>
> [..]
> > > > @@ -1471,10 +1423,12 @@ bool zswap_store(struct folio *folio)
> > > >  {
> > > >       swp_entry_t swp =3D folio->swap;
> > > >       pgoff_t offset =3D swp_offset(swp);
> > > > -     struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > > > -     struct zswap_entry *entry, *dupentry;
> > > > +     struct xarray *tree =3D swap_zswap_tree(swp);
> > > > +     struct zswap_entry *entry, *old;
> > > >       struct obj_cgroup *objcg =3D NULL;
> > > >       struct mem_cgroup *memcg =3D NULL;
> > > > +     int err;
> > > > +     bool old_erased =3D false;
> > > >
> > > >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > >       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > > > @@ -1526,6 +1480,7 @@ bool zswap_store(struct folio *folio)
> > > >                       kunmap_local(src);
> > > >                       entry->length =3D 0;
> > > >                       entry->value =3D value;
> > > > +                     entry->pool =3D NULL;
> > >
> > > Why do we need to initialize the pool here? Is this is a bug fix for =
an
> > > existing problem or just keeping things clean? Either way I think it
> > > should be done separately, unless it is related to a change in this
> > > patch.
> >
> > I notice the entry->pool will leave uninitialized. I think it should
> > be cleaned up. It is a clean up, it does not need to happen in this
> > patch. I can do that as a separate patch.
>
> Yes please.
>
> [..]
> > >
> > > >       /*
> > > >        * The folio may have been dirtied again, invalidate the
> > > >        * possibly stale entry before inserting the new entry.
> > > >        */
> > > > -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -=
EEXIST) {
> > > > -             zswap_invalidate_entry(tree, dupentry);
> > > > -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupent=
ry));
> > > > +     err =3D zswap_xa_insert(tree, entry, &old);
> > > > +     if (old)
> > > > +             zswap_entry_free(old);
> > > > +     if (err) {
> > > > +             old_erased =3D true;
> > >
> > > I think this can be made simpler if we open code xa_store() here,
> > > especially that we already have cleanup code below under 'check_old'
> > > that removes the exisitng old entry. So zswap_xa_insert() replicates
> > > this cleanup, then we add this 'old_erased' boolean to avoid doing th=
e
> > > cleanup below. It seems like it would much more straightforward with
> > > open-coding xa_store() here and relying on the existing cleanup for t=
he
> > > old entry.  Also, if we initialize 'old' to NULL, we can use its valu=
e
> > > to figure out whether any cleanup is needed under 'check_old' or not.
> >
> > I think that is very similar to what Chengming was suggesting.
> >
> > >
> > > Taking a step back, I think we can further simplify this. What if we
> > > move the tree insertion to right after we allocate the zswap entry? I=
n
> > > this case, if the tree insertion fails, we don't need to decrement th=
e
> > > same filled counter. If the tree insertion succeeds and then somethin=
g
> > > else fails, the existing cleanup code under 'check_old' will already
> > > clean up the tree insertion for us.
> >
> > That will create complications that, if the zswap compression fails
> > the compression ratio, you will have to remove the entry from the tree
> > as clean up. You have both xa_store() and xa_erase() where the current
> > code just does one xa_erase() on compression failure.
>
> Not really. If xa_store() fails because of -ENOMEM, then I think by
> definition we do not need xa_erase() as there shouldn't be any stale
> entries. I also think -ENOMEM should be the only valid errno from
> xa_store() in this context. So we can avoid the check_old code if
> xa_store() is called (whether it fails or succeeds) IIUC.
>
> I prefer calling xa_store() entry and avoiding the extra 'insert_failed'
> cleanup code, especially that unlike other cleanup code, it has its own
> branching based on entry->length. I am also planning a cleanup for
> zswap_store() to split the code better for the same_filled case and
> avoid some unnecessary checks and failures, so it would be useful to
> keep the common code path together.

I would like to point out that, in real world usage, we will likely
see more pages fail due to compress rather than xa_store failure.
There is a non zero percentage of pages that are not compressible.
The -ENOMEM for xa_store are very rare, much much rarer than the non
compressible page. So in the real work running, insert first will have
one more "xa_store" than compression first. I would argue compression
first will perform slightly better, because "xa_store" will need to
take the spin lock. Avoid the extra "xa_store" and avoid taking the
lock all together. There is simply more compression failure than
xa_store failure.
It also feels slightly strange when inserting the entry into xarray
when the entry is not ready to use. I don't think that is triggeriable
as a bug right now, but that makes me feel a little bit strange.

>
> >
> > >
> > > If this works, we don't need to add extra cleanup code or move any co=
de
> > > around. Something like:
> >
> > Due to the extra xa_insert() on compression failure, I think
> > Chengming's or your earlier suggestion is better.
> >
> > BTW, while you are here, can you confirm this race discussed in
> > earlier email can't happen? Chengming convinced me this shouldn't
> > happen. Like to hear your thoughts.
> >
> >  CPU1                         CPU2
> >
> > xa_store()
> >                                    entry =3D xa_erase()
> >                                    zswap_free_entry(entry)
> >
> > if (entry->length)
> >      ...
> > CPU1 is using entry after free.
>
> IIUC, CPU1 is in zswap_store(), CPU2 could either in zswap_invalidate()
> or zswap_load().
>
> For zswap_load(), I think synchronization is done in the core swap code
> ensure we are not doing parallel swapin/swapout at the same entry,
> right? In this specific case, I think the folio would be in the
> swapcache while swapout (i.e. zswap_store()) is ongoing, so any swapins
> will read the folio and not call zswap_load().
>
> Actually, if we do not prevent parallel swapin/swapou at the same entry,
> I suspect we may have problems even outside of zswap. For example, we
> may read a partially written swap entry from disk, right? Or does the
> block layer synchronize this somehow?

I don't think the block layer is doing the synchronization here. Zswap
does not go to the block layer at all.
I think after looking up from the swap cache, the filio will be
locked, that is preventing others' path. I would like to hear others'
thoughts on that. Need more audits.

>
> For zswap_invalidate(), the core swap code calls it when the swap entry
> is no longer used and before we free it for reuse, so IIUC parallel
> swapouts (i.e. zswap_store()) should not be possible here as well.

There is also the write back path, I don't think it is triggerable due
to entry not being inserted into the LRU list yet.

Chris

