Return-Path: <linux-kernel+bounces-144634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA78A48A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F3B230B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEB24B2A;
	Mon, 15 Apr 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9op/bIH"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586C20317
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164666; cv=none; b=rWCvo/HncQq/l5m8rkiqiYDx7+GNbvsbAIEo52HpdvAfM47HIoM3LUmAGd2rJ4rem4J5Ps801TBs36Tb2Zvntqbi3wjuocVL/YfO3kVgCX3UPvR4ILJ5GB+kUMwQUKEvX9b9nY5GBBhbmuyTwO8LKlQqs3BJSK3O0OmFfEguTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164666; c=relaxed/simple;
	bh=RGmO/elGTK70mmq/rDfNEtKFgRIalvosBoy37q8g7kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/SZ/g4wqvGw6inzmkrdpH/Hxg6bkih1dSZlpyCiy+Y5984GEbKyMMOCBbTAoH+3jq/4LnrK+ssN7aKPe3OfDmdi63ySgF07S8AVIqkoQznKp9rQQBuzzAlI7Q+VW9/bWoSRImScPnPJEctC3Wuf+1RsDIMy/rgkLdDRNDg9Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9op/bIH; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-479de34dc36so865779137.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713164661; x=1713769461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmCfKirzLXB4pHNEyVF8BmROY/YRx1yv0FznouV7Qmo=;
        b=M9op/bIHOONp+R26oaJqp3WxbAck6bWCrSxPZu1PMB0UNOwPbGySLuw5UO9CVlg3vt
         9xswPvj3Dys2HJFOcO6NVfHxOUGTWulXyq18IPF5/XY0NpujsnFaSFW7q5gWJEDyIQRz
         XNsUwCNuXC6tCHGqqfjGv3UU0Lr/YdXjjKWG84u305XrvxBmPOKeHcAEuc0vwP5Iik2h
         VX3vwJcWAW15+joqt8ZoJ9osnZ+zRczcr3eSppWjxf4JOdCH7PxRxlRKk/T9GXCBt9oe
         JlZeKtmdyaaA9qLf2el9FUnXIJK6giDTNeRSXsj8fN9/kFU3ZMm1KUwJD95F+uG/kpS9
         OU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164661; x=1713769461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmCfKirzLXB4pHNEyVF8BmROY/YRx1yv0FznouV7Qmo=;
        b=h25jQAqNOQvgVjwg4vDdpYyQ2QcnEL4PQ8JDe/IT1JthED27g4e9Llds0+vBIh2JtS
         WqX+B2u7xhLj4N19SKrQ3VkM59Tk6YPaqv0NrGKgKMo+Ep7N6hVkZsETwIzNJMV3/QmH
         vSRvqYLbworb9I7s1OOcAmQdVpl/VbS1kSj4AcXvvy30JSmJBpwlGqq0tqnONpmHV5h2
         iWVnBlFRfnPAZk13NGeol0+j5FFtpGbwCuJ8biLOFJOQQyHVF5X7lIwW5Qci31LbxyRz
         nHsggEPOPNlMbwBf95yXjiEwpzFhtR7/AHh6VMGccjsaAlTGaMfxTA2XDnRR0M+Tmh1J
         muTA==
X-Forwarded-Encrypted: i=1; AJvYcCVBFLulb/xkJLyxltH/Hp6WrC9zzXph1mevyEJ03mS7141Xsbx5XPMVGOS38TNoi+/SeAENHszG4DM+1SA013tAw5CgrrWXIAj9wKyv
X-Gm-Message-State: AOJu0Yzt4Osgfvj6YKpo7SkKcptl69KjiwUWxm9m4DZRijvunLAtjT6P
	T+adZ1mZmtVbkLWKnZqyqgW8O2KpDdrkmBVnox+UpkY1RVXng+IBAAIKm0MVlyKbSx3xL5Fr9R+
	sjE9cNb6zp5d/h6PFZnnsOrBj0Xk=
X-Google-Smtp-Source: AGHT+IE2jObFNDSF11WjaIDSfio3KBBdInbtgqMFvQMLFBl5UDL3sbN4rd1KmnHIe1bBCzbbGich6hv/BVLDFJFluf8=
X-Received: by 2002:a05:6102:dcc:b0:47a:4801:6738 with SMTP id
 e12-20020a0561020dcc00b0047a48016738mr8429860vst.18.1713164660339; Mon, 15
 Apr 2024 00:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 19:04:08 +1200
Message-ID: <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > While swapping in a large folio, we need to free swaps related to the w=
hole
> > folio. To avoid frequently acquiring and releasing swap locks, it is be=
tter
> > to introduce an API for batched free.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/swap.h |  5 +++++
> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 11c53692f65f..b7a107e983b8 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> >  extern void swap_free(swp_entry_t);
> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >  int swap_type_of(dev_t device, sector_t offset);
> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
> >  {
> >  }
> >
> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > +{
> > +}
> > +
> >  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp=
)
> >  {
> >  }
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 28642c188c93..f4c65aeb088d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >               __swap_entry_free(p, entry);
> >  }
> >
> > +/*
> > + * Free up the maximum number of swap entries at once to limit the
> > + * maximum kernel stack usage.
> > + */
> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER=
)
> > +
> > +/*
> > + * Called after swapping in a large folio,
>
> IMHO, it's not good to document the caller in the function definition.
> Because this will discourage function reusing.

ok. right now there is only one user that is why it is added. but i agree
we can actually remove this.

>
> > batched free swap entries
> > + * for this large folio, entry should be for the first subpage and
> > + * its offset is aligned with nr_pages
>
> Why do we need this?

This is a fundamental requirement for the existing kernel, folio's
swap offset is naturally aligned from the first moment add_to_swap
to add swapcache's xa. so this comment is describing the existing
fact. In the future, if we want to support swap-out folio to discontiguous
and not-aligned offsets, we can't pass entry as the parameter, we should
instead pass ptep or another different data struct which can connect
multiple discontiguous swap offsets.

I feel like we only need "for this large folio, entry should be for
the first subpage" and drop "and its offset is aligned with nr_pages",
the latter is not important to this context at all.

>
> > + */
> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > +{
> > +     int i, j;
> > +     struct swap_cluster_info *ci;
> > +     struct swap_info_struct *p;
> > +     unsigned int type =3D swp_type(entry);
> > +     unsigned long offset =3D swp_offset(entry);
> > +     int batch_nr, remain_nr;
> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> > +
> > +     /* all swap entries are within a cluster for mTHP */
> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER=
);
> > +
> > +     if (nr_pages =3D=3D 1) {
> > +             swap_free(entry);
> > +             return;
> > +     }
>
> Is it possible to unify swap_free() and swap_free_nr() into one function
> with acceptable performance?  IIUC, the general rule in mTHP effort is
> to avoid duplicate functions between mTHP and normal small folio.
> Right?

I don't see why. but we have lots of places calling swap_free(), we may
have to change them all to call swap_free_nr(entry, 1); the other possible
way is making swap_free() a wrapper of swap_free_nr() always using
1 as the argument. In both cases, we are changing the semantics of
swap_free_nr() to partially freeing large folio cases and have to drop
"entry should be for the first subpage" then.

Right now, the semantics is
* swap_free_nr() for an entire large folio;
* swap_free() for one entry of either a large folio or a small folio

>
> > +
> > +     remain_nr =3D nr_pages;
> > +     p =3D _swap_info_get(entry);
> > +     if (p) {
> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, remain_nr)=
;
> > +
> > +                     ci =3D lock_cluster_or_swap_info(p, offset);
> > +                     for (j =3D 0; j < batch_nr; j++) {
> > +                             if (__swap_entry_free_locked(p, offset + =
i * SWAP_BATCH_NR + j, 1))
> > +                                     __bitmap_set(usage, j, 1);
> > +                     }
> > +                     unlock_cluster_or_swap_info(p, ci);
> > +
> > +                     for_each_clear_bit(j, usage, batch_nr)
> > +                             free_swap_slot(swp_entry(type, offset + i=
 * SWAP_BATCH_NR + j));
> > +
> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> > +                     remain_nr -=3D batch_nr;
> > +             }
> > +     }
> > +}
> > +
> >  /*
> >   * Called after dropping swapcache to decrease refcnt to swap entries.
> >   */
>
> put_swap_folio() implements batching in another method.  Do you think
> that it's good to use the batching method in that function here?  It
> avoids to use bitmap operations and stack space.

Chuanhua has strictly limited the maximum stack usage to several
unsigned long, so this should be safe. on the other hand, i believe this
implementation is more efficient, as  put_swap_folio() might lock/
unlock much more often whenever __swap_entry_free_locked returns
0.

>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

