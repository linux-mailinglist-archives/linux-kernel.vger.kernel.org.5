Return-Path: <linux-kernel+bounces-40570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F483E28F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A293EB214BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F522EF2;
	Fri, 26 Jan 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYilvmId"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835AF22EE9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297514; cv=none; b=VNz/NdKwmWNWQkaS151UT6vkFyoR/2AN4XbdO/3k/C0eAbD7fdgIr41hAelxCdtQtIVKHX41jYbi9h2OZOxxgDSlyYXD0I0w83iwfNpoBHrsD+lzFxA5+3E9XMrLgwFeD1V0bW8s1OQsBUH0f6KQ8s3bBg7ErrjJkk/dpfLHtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297514; c=relaxed/simple;
	bh=RY52HxmvIS0+bFhBuUK05xzxww2g7j3hiSauDU3uiGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/gGUm0mLnmemIm+AJSqSjKHzbLhCrcpHrHgZ/IVxIdUINi8asHBldzsDokNbFXePlQMk6JIB7rYlTY2P4sVHtCcrYq6V209BSYCmxkhdjpvDJ5/BFDsHc+2ix6BxKfrNo/3xh4HJ3FG5Ug5B+9ffa9Mk2+i/deiX1z8/olTTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYilvmId; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-362a0aa2a33so1181755ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706297511; x=1706902311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwIyM2FU0QQ1VJvtvKXZch6o5WvkSz5Affa1c3xEM6M=;
        b=nYilvmIdgkDyOD9TVS+f9Ut3Ag9qf308k/IJaarI1OWnIrjcIGGWNHrnGIk6xUc1NX
         YCpitTozXF5w7s7NoqNv+6T4vWDBJwGnf1mm/h9pOZWCtZKRpFUhgGgAZBBghpoSqyQp
         gfyce8M6MC1M32DYrdlM+Q3dHN/cWLCKYne0PvPqDDoCtsfCeWi0FWzj//mJnQkyr55o
         eVYIs0ZPDO0yC6fcKY8sLvQMqHrpkaEy2/q8K6JMwxqE0qqmvw/PM4Q0g42UqlSUcN1N
         85Vh01kNwYdNB16p6g6W9kvxUvblCDoykPC7h1+UONpOehXE8uDLGmnw937dVowBMI/Z
         NpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297511; x=1706902311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwIyM2FU0QQ1VJvtvKXZch6o5WvkSz5Affa1c3xEM6M=;
        b=Toe2I3KscbEHHfxZRvupckvHOv7kDX5NmwcupGBIYWcHzkTHYklM3fiDPuxcCHRrTc
         ChEtwnqxwjkmhIdv2+oY50qYLsHqs++xFKY/z/2yDXMVosEhJXQ11wwAkQDFksSwm3eS
         SArh4cv6ocA1TI2d1b9oa8orgd19UCBpgKsr8HXPBDO7OvrwvDATkBKuUGT+3BJzwe2r
         wVU+edihKoOXkSkiyGpFAxo+p6UzW7GIwgv7OuGPj/oRaoGLpZ80FcE4+BWZ6lSz3VIv
         tkR35rCa5D4FK2JDIxxWPU4MPEVvEDbuoSsSbaX+28TgyUo6z8yqkQkAwYV9WOhJ56ZC
         lumQ==
X-Gm-Message-State: AOJu0Yy+MeKUD1ssPaIuN6bR/z/rSAu4WzzIoa7ezWgCzWycZhmOgu9s
	8QsHFaD1krJpKdszfzFoUGtUc1I8ndugSYOFj6GWHH3Gfy0nyFkE0fqedZuo0UzcWY1q7XgrMpB
	1dQq+6zwLP0rUAdtIpKckWlV1ldI=
X-Google-Smtp-Source: AGHT+IHnokpwiyO2PEGJ0drytSWXqc8hb8A1r4TGMfX17/4JXY76I/rZuYobCRxWx17ZoIzcrqBtGL7Epl/2JLEQlhA=
X-Received: by 2002:a92:cd09:0:b0:362:ad7c:bbdf with SMTP id
 z9-20020a92cd09000000b00362ad7cbbdfmr272383iln.16.1706297511416; Fri, 26 Jan
 2024 11:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
 <20240126083015.3557006-2-chengming.zhou@linux.dev> <20240126153126.GG1567330@cmpxchg.org>
In-Reply-To: <20240126153126.GG1567330@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jan 2024 11:31:40 -0800
Message-ID: <CAKEwX=OOf2M0Zm50Vkv6nBUzHR1p7dSGoQ99EofBPxZpxQHKHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: fix race between lru writeback and swapoff
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: chengming.zhou@linux.dev, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 7:31=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Jan 26, 2024 at 08:30:15AM +0000, chengming.zhou@linux.dev wrote:
> > From: Chengming Zhou <zhouchengming@bytedance.com>
> >
> > LRU writeback has race problem with swapoff, as spotted by Yosry[1]:
> >
> > CPU1                  CPU2
> > shrink_memcg_cb               swap_off
> >   list_lru_isolate      zswap_invalidate
> >                         zswap_swapoff
> >                           kfree(tree)
> >   // UAF
> >   spin_lock(&tree->lock)
> >
> > The problem is that the entry in lru list can't protect the tree from
> > being swapoff and freed, and the entry also can be invalidated and free=
d
> > concurrently after we unlock the lru lock.
> >
> > We can fix it by moving the swap cache allocation ahead before
> > referencing the tree, then check invalidate race with tree lock,
> > only after that we can safely deref the entry. Note we couldn't
> > deref entry or tree anymore after we unlock the folio, since we
> > depend on this to hold on swapoff.
>
> This is a great simplification on top of being a bug fix.
>
> > So this patch moves all tree and entry usage to zswap_writeback_entry()=
,
> > we only use the copied swpentry on the stack to allocate swap cache
> > and return with folio locked, after which we can reference the tree.
> > Then check invalidate race with tree lock, the following things is
> > much the same like zswap_load().
> >
> > Since we can't deref the entry after zswap_writeback_entry(), we
> > can't use zswap_lru_putback() anymore, instead we rotate the entry
> > in the LRU list so concurrent reclaimers have little chance to see it.
> > Or it will be deleted from LRU list if writeback success.
> >
> > Another confusing part to me is the update of memcg nr_zswap_protected
> > in zswap_lru_putback(). I'm not sure why it's needed here since
> > if we raced with swapin, memcg nr_zswap_protected has already been
> > updated in zswap_folio_swapin(). So not include this part for now.
>
> Good observation.
>
> Technically, it could also fail on -ENOMEM, but in practice these size
> allocations don't fail, especially since the shrinker runs in
> PF_MEMALLOC context. The shrink_worker might be affected, since it
> doesn't But the common case is -EEXIST, which indeed double counts.

Yup. At the time, I was thinking more along the lines of what
mechanisms should trigger protection size increase. "swapin" and "LRU
list rotations" were two different mechanisms in my head. I was aware
that there could be double counting, but deemed it OK, as the cost of
over-shrinking (increase in swapin) was fairly serious, and if we have
a fairly aggressive decaying strategy if we protect too much.

But yes, I doubt it mattered that much in hindsight :) And the case
where it is double counted far outnumber the case where it does not,
so I'm fine with removing it here.

>
> To make it "correct", you'd have to grab an objcg reference with the
> LRU lock, and also re-order the objcg put on entry freeing after the
> LRU del. This is probably not worth doing. But it could use a comment.
>
> I was going to ask if you could reorder objcg uncharging after LRU
> deletion to make it more robust for future changes in that direction.
> However, staring at this, I notice this is a second UAF bug:
>
>         if (entry->objcg) {
>                 obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>                 obj_cgroup_put(entry->objcg);
>         }
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
>                 zswap_lru_del(&entry->pool->list_lru, entry);
>
> zswap_lru_del() uses entry->objcg to determine the list_lru memcg, but
> the put may have killed it. I'll send a separate patch on top.
>
> > @@ -860,40 +839,34 @@ static enum lru_status shrink_memcg_cb(struct lis=
t_head *item, struct list_lru_o
> >  {
> >       struct zswap_entry *entry =3D container_of(item, struct zswap_ent=
ry, lru);
> >       bool *encountered_page_in_swapcache =3D (bool *)arg;
> > -     struct zswap_tree *tree;
> > -     pgoff_t swpoffset;
> > +     swp_entry_t swpentry;
> >       enum lru_status ret =3D LRU_REMOVED_RETRY;
> >       int writeback_result;
> >
> > +     /*
> > +      * First rotate to the tail of lru list before unlocking lru lock=
,
> > +      * so the concurrent reclaimers have little chance to see it.
> > +      * It will be deleted from the lru list if writeback success.
> > +      */
> > +     list_move_tail(item, &l->list);
>
> We don't hold a reference to the object, so there could also be an
> invalidation waiting on the LRU lock, which will free the entry even
> when writeback fails.
>
> It would also be good to expand on the motivation, because it's not
> clear WHY you'd want to hide it from other reclaimers.
>
> Lastly, maybe mention the story around temporary failures? Most
> shrinkers have a lock inversion pattern (object lock -> LRU lock for
> linking versus LRU lock -> object trylock during reclaim) that can
> fail and require the same object be tried again before advancing.
>
> How about this?
>
>         /*
>          * Rotate the entry to the tail before unlocking the LRU,
>          * so that in case of an invalidation race concurrent
>          * reclaimers don't waste their time on it.
>          *
>          * If writeback succeeds, or failure is due to the entry
>          * being invalidated by the swap subsystem, the invalidation
>          * will unlink and free it.
>          *
>          * Temporary failures, where the same entry should be tried
>          * again immediately, almost never happen for this shrinker.
>          * We don't do any trylocking; -ENOMEM comes closest,
>          * but that's extremely rare and doesn't happen spuriously
>          * either. Don't bother distinguishing this case.
>          *
>          * But since they do exist in theory, the entry cannot just
>          * be unlinked, or we could leak it. Hence, rotate.
>          */
>
> Otherwise, looks great to me.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

