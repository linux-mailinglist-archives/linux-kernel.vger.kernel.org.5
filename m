Return-Path: <linux-kernel+bounces-144811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4268A4B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCD81F21BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C43B297;
	Mon, 15 Apr 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPKnMlDb"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32973A1DA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171694; cv=none; b=ihjc322jE4RzLMDpwJh04vE+d7bs9oi6XFdkoM1gX06hsXSLHQy6kfLKZL2dvh34MmDwyECIAOFeErkFB+CaZLkLNUlRYJGyt9kaoFRVa1570dfQFSZUFgxccQsG3JAx5CA2w7zb3Zf9R162IO0uxep6VJhrhRsF2KrwPx/Qpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171694; c=relaxed/simple;
	bh=KSrlhOrUpY4sKiN79nUABrR8ZE1WdVNus4E/bWPQr/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJs3tavmTG2lKC3NymWYe6rRGzcgOOv89sDWuRqLo4UcfRhh7JJHNZuQw0kxQoMqMLO2QseCGoDKHyTr/5+3AVnxHpc2OcgXQjKmF0gBXrbEC5aqYh+FVWmmgrFhoXvSqCAfSjNoxJ4d+ykygVooW6zGcEavz4Jek5roKXGJe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPKnMlDb; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4dad331b828so1199274e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713171688; x=1713776488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AftYN0D42u8gxKw8ofiGJ1Yy9e6/C1aoGJ66ySgQIEk=;
        b=NPKnMlDbL0X+ZEkOfay49NLOvv8IDYRicafQ9LNVP7iIK1QCuDIzim9MdjSaxPY5H/
         SDysaYGE+tCJB4bNNiEyFb+luwsxTx1+jaFi7Wj3tsVZ8KAvxFZm9npw9Boz4UGYIX/u
         3PhDs1zGnqlqneNDPBjDLGUElfScGpo13x3MM8eiS46URujK86RmukErsmkLxx9ZRduu
         la7vjnPrUyR4NZ6POZrF3okacDxMtU1ufWNgjIgHJ7HCdtGLuzvNWHkhVRvXRmuhSnpw
         7E8ssIZJyGUgw7g5rdlvMHkNCKrKQFUwkbPkpylT4YWMIUzYz6JJ5VNEMVdym87xwixS
         zkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171688; x=1713776488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AftYN0D42u8gxKw8ofiGJ1Yy9e6/C1aoGJ66ySgQIEk=;
        b=CRhhQGIKAo1sIbbJEJV8Qv4iQOpYv8P9O5xQTZFK7Gszb6trvy6u1Ci01xcCpes/hl
         Z3Od6VtGdgrA1B20e3tZrrZhf8sMtI+JTsmyRKlKq1KWdxNKISB0Jvbk0UtTcLWD2Ukj
         sCc5SSpQd/b+eofwTyn7FOMm9vxyo27UGyPicJgaVp8BBLZakTyLo4LmqkvRcu6zrUvp
         h2YGEfTS12oO0OfXTnw8YJWGID+SezCx1nFHzzPp/MaaAAmtPr0PuP2ryowFnLVB/t3y
         ZiEkkosbtHUzYDnu8yBVgNZfM0J63pZEhwjJVeBvrVLCgMkovZJ4cdiZIrNe/wijMutO
         FaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO9oKYK6FFMvog6SoLeEMsZFADf2Q2FBFTdV1PE6nDNM8vg1DkQGOW3h2c5eO3bVo6IW9dQaReKEXiNyyhHK8mBON4fnwDNcFcz9IG
X-Gm-Message-State: AOJu0YxTlx+6/pPLGDYjI9SXF0FhyOcjHeu9k63RnW14JfgcHO490e3X
	VSzoMC0XMn4hx1wbf2r1j9aLsKy2sjAjr3g3xGdONYvqhB8F7sz04KsCRWp9Bh4AoZSq1N9cw6E
	xeRhZlvGueUhBcmTZdFliTxCKuFE=
X-Google-Smtp-Source: AGHT+IH618bXsxW4Bii6DlKFO8Z7fwdW5rXKj2ChWf9kgtiaII2cgrUtgzxst9HurH4HQWPEYsFh4TE3AhJT+egY+UM=
X-Received: by 2002:a05:6122:2023:b0:4d3:3b1b:aa92 with SMTP id
 l35-20020a056122202300b004d33b1baa92mr6756178vkd.11.1713171688433; Mon, 15
 Apr 2024 02:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
 <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
 <87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 21:01:16 +1200
Message-ID: <CAGsJ_4zH4RHhZembtXOqzBDL75MA5NiEjMHx7eCN-a1ifnKTBw@mail.gmail.com>
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

On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >
> >> >> > While swapping in a large folio, we need to free swaps related to=
 the whole
> >> >> > folio. To avoid frequently acquiring and releasing swap locks, it=
 is better
> >> >> > to introduce an API for batched free.
> >> >> >
> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> > ---
> >> >> >  include/linux/swap.h |  5 +++++
> >> >> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++=
++++++
> >> >> >  2 files changed, 56 insertions(+)
> >> >> >
> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> > index 11c53692f65f..b7a107e983b8 100644
> >> >> > --- a/include/linux/swap.h
> >> >> > +++ b/include/linux/swap.h
> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> >> >  extern int swapcache_prepare(swp_entry_t);
> >> >> >  extern void swap_free(swp_entry_t);
> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >> >> >  int swap_type_of(dev_t device, sector_t offset);
> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp=
)
> >> >> >  {
> >> >> >  }
> >> >> >
> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> > +{
> >> >> > +}
> >> >> > +
> >> >> >  static inline void put_swap_folio(struct folio *folio, swp_entry=
_t swp)
> >> >> >  {
> >> >> >  }
> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> > index 28642c188c93..f4c65aeb088d 100644
> >> >> > --- a/mm/swapfile.c
> >> >> > +++ b/mm/swapfile.c
> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >> >> >               __swap_entry_free(p, entry);
> >> >> >  }
> >> >> >
> >> >> > +/*
> >> >> > + * Free up the maximum number of swap entries at once to limit t=
he
> >> >> > + * maximum kernel stack usage.
> >> >> > + */
> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_C=
LUSTER)
> >> >> > +
> >> >> > +/*
> >> >> > + * Called after swapping in a large folio,
> >> >>
> >> >> IMHO, it's not good to document the caller in the function definiti=
on.
> >> >> Because this will discourage function reusing.
> >> >
> >> > ok. right now there is only one user that is why it is added. but i =
agree
> >> > we can actually remove this.
> >> >
> >> >>
> >> >> > batched free swap entries
> >> >> > + * for this large folio, entry should be for the first subpage a=
nd
> >> >> > + * its offset is aligned with nr_pages
> >> >>
> >> >> Why do we need this?
> >> >
> >> > This is a fundamental requirement for the existing kernel, folio's
> >> > swap offset is naturally aligned from the first moment add_to_swap
> >> > to add swapcache's xa. so this comment is describing the existing
> >> > fact. In the future, if we want to support swap-out folio to discont=
iguous
> >> > and not-aligned offsets, we can't pass entry as the parameter, we sh=
ould
> >> > instead pass ptep or another different data struct which can connect
> >> > multiple discontiguous swap offsets.
> >> >
> >> > I feel like we only need "for this large folio, entry should be for
> >> > the first subpage" and drop "and its offset is aligned with nr_pages=
",
> >> > the latter is not important to this context at all.
> >>
> >> IIUC, all these are requirements of the only caller now, not the
> >> function itself.  If only part of the all swap entries of a mTHP are
> >> called with swap_free_nr(), can swap_free_nr() still do its work?  If
> >> so, why not make swap_free_nr() as general as possible?
> >
> > right , i believe we can make swap_free_nr() as general as possible.
> >
> >>
> >> >>
> >> >> > + */
> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> > +{
> >> >> > +     int i, j;
> >> >> > +     struct swap_cluster_info *ci;
> >> >> > +     struct swap_info_struct *p;
> >> >> > +     unsigned int type =3D swp_type(entry);
> >> >> > +     unsigned long offset =3D swp_offset(entry);
> >> >> > +     int batch_nr, remain_nr;
> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >> >> > +
> >> >> > +     /* all swap entries are within a cluster for mTHP */
> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_C=
LUSTER);
> >> >> > +
> >> >> > +     if (nr_pages =3D=3D 1) {
> >> >> > +             swap_free(entry);
> >> >> > +             return;
> >> >> > +     }
> >> >>
> >> >> Is it possible to unify swap_free() and swap_free_nr() into one fun=
ction
> >> >> with acceptable performance?  IIUC, the general rule in mTHP effort=
 is
> >> >> to avoid duplicate functions between mTHP and normal small folio.
> >> >> Right?
> >> >
> >> > I don't see why.
> >>
> >> Because duplicated implementation are hard to maintain in the long ter=
m.
> >
> > sorry, i actually meant "I don't see why not",  for some reason, the "n=
ot"
> > was missed. Obviously I meant "why not", there was a "but" after it :-)
> >
> >>
> >> > but we have lots of places calling swap_free(), we may
> >> > have to change them all to call swap_free_nr(entry, 1); the other po=
ssible
> >> > way is making swap_free() a wrapper of swap_free_nr() always using
> >> > 1 as the argument. In both cases, we are changing the semantics of
> >> > swap_free_nr() to partially freeing large folio cases and have to dr=
op
> >> > "entry should be for the first subpage" then.
> >> >
> >> > Right now, the semantics is
> >> > * swap_free_nr() for an entire large folio;
> >> > * swap_free() for one entry of either a large folio or a small folio
> >>
> >> As above, I don't think the these semantics are important for
> >> swap_free_nr() implementation.
> >
> > right. I agree. If we are ready to change all those callers, nothing
> > can stop us from removing swap_free().
> >
> >>
> >> >>
> >> >> > +
> >> >> > +     remain_nr =3D nr_pages;
> >> >> > +     p =3D _swap_info_get(entry);
> >> >> > +     if (p) {
> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> >> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, rema=
in_nr);
> >> >> > +
> >> >> > +                     ci =3D lock_cluster_or_swap_info(p, offset)=
;
> >> >> > +                     for (j =3D 0; j < batch_nr; j++) {
> >> >> > +                             if (__swap_entry_free_locked(p, off=
set + i * SWAP_BATCH_NR + j, 1))
> >> >> > +                                     __bitmap_set(usage, j, 1);
> >> >> > +                     }
> >> >> > +                     unlock_cluster_or_swap_info(p, ci);
> >> >> > +
> >> >> > +                     for_each_clear_bit(j, usage, batch_nr)
> >> >> > +                             free_swap_slot(swp_entry(type, offs=
et + i * SWAP_BATCH_NR + j));
> >> >> > +
> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> >> >> > +                     remain_nr -=3D batch_nr;
> >> >> > +             }
> >> >> > +     }
> >> >> > +}
> >> >> > +
> >> >> >  /*
> >> >> >   * Called after dropping swapcache to decrease refcnt to swap en=
tries.
> >> >> >   */
> >> >>
> >> >> put_swap_folio() implements batching in another method.  Do you thi=
nk
> >> >> that it's good to use the batching method in that function here?  I=
t
> >> >> avoids to use bitmap operations and stack space.
> >> >
> >> > Chuanhua has strictly limited the maximum stack usage to several
> >> > unsigned long,
> >>
> >> 512 / 8 =3D 64 bytes.
> >>
> >> So, not trivial.
> >>
> >> > so this should be safe. on the other hand, i believe this
> >> > implementation is more efficient, as  put_swap_folio() might lock/
> >> > unlock much more often whenever __swap_entry_free_locked returns
> >> > 0.
> >>
> >> There are 2 most common use cases,
> >>
> >> - all swap entries have usage count =3D=3D 0
> >> - all swap entries have usage count !=3D 0
> >>
> >> In both cases, we only need to lock/unlock once.  In fact, I didn't
> >> find possible use cases other than above.
> >
> > i guess the point is free_swap_slot() shouldn't be called within
> > lock_cluster_or_swap_info? so when we are freeing nr_pages slots,
> > we'll have to unlock and lock nr_pages times?  and this is the most
> > common scenario.
>
> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUSTER (that
> is, nr_pages) or 0.  These are the most common cases.
>

i am actually talking about the below code path,

void put_swap_folio(struct folio *folio, swp_entry_t entry)
{
        ...

        ci =3D lock_cluster_or_swap_info(si, offset);
        ...
        for (i =3D 0; i < size; i++, entry.val++) {
                if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACH=
E)) {
                        unlock_cluster_or_swap_info(si, ci);
                        free_swap_slot(entry);
                        if (i =3D=3D size - 1)
                                return;
                        lock_cluster_or_swap_info(si, offset);
                }
        }
        unlock_cluster_or_swap_info(si, ci);
}

but i guess you are talking about the below code path:

void put_swap_folio(struct folio *folio, swp_entry_t entry)
{
        ...

        ci =3D lock_cluster_or_swap_info(si, offset);
        if (size =3D=3D SWAPFILE_CLUSTER) {
                map =3D si->swap_map + offset;
                for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
                        val =3D map[i];
                        VM_BUG_ON(!(val & SWAP_HAS_CACHE));
                        if (val =3D=3D SWAP_HAS_CACHE)
                                free_entries++;
                }
                if (free_entries =3D=3D SWAPFILE_CLUSTER) {
                        unlock_cluster_or_swap_info(si, ci);
                        spin_lock(&si->lock);
                        mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTER);
                        swap_free_cluster(si, idx);
                        spin_unlock(&si->lock);
                        return;
                }
        }
}

we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
or you want to check free_entries =3D=3D "1 << swap_entry_order(folio_order=
(folio))"
instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i++, entry.val=
++)"
path?


> >>
> >> And, we should add batching in __swap_entry_free().  That will help
> >> free_swap_and_cache_nr() too.

Chris Li and I actually discussed it before, while I completely
agree this can be batched. but i'd like to defer this as an incremental
patchset later to keep this swapcache-refault small.

>
> Please consider this too.
>
> --
> Best Regards,
> Huang, Ying

