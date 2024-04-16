Return-Path: <linux-kernel+bounces-146100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDB8A60AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A038A1F2178F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E40E555;
	Tue, 16 Apr 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb0V46Pr"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49811181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233346; cv=none; b=oOkZTio4I7Zhxs/9XC3eDrKVxwbktwDtNweestwYXiwwiCWxtPKoR4IH6ZFjgF1KsrMDxplrt8J1EURUyu3ruKin/yV8Yesdgv62eSsB5igBgXyHVVcoR5beg9A6WJCjPqchEzRt1e6Yf5/EQpDiMHALp0HalCwL9ZAn6KIokUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233346; c=relaxed/simple;
	bh=m96izRET8LgH+qHiq/ybWR8CDylb8MZnTEFjQYGurYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky/0GVuOzrBZhWaxTKAUF06IMJEe4TGgcwBstarZIGLjaFqZ6YUd/zTTvpvp1e3A9lbis8kmcOxKw3X+7xEraEeuPI2y5ez4HVMvDQnwRZzxyw9GJm1/DVJFQGYgb3FVpJuN/sXTSp4EV/SIKzXcxs3I3NMCKEXsVTzMjgLKbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb0V46Pr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-479f2922db0so995395137.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713233343; x=1713838143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1uJFPkrJK2J/fdiu3afdJXCjQfBShGSkjcoA5KyuUg=;
        b=Vb0V46PrMV5sey6HnFnzqlF3enEr0FBashZLNi/xocR3BqEkuxAMBSWBWtLQ/JFqpA
         Pcbk7yE202iBJLX3LBmglhzUGz1mB1X4v/jQzBoccsQJXPQElJk07P//Daq4a2fbYQsY
         sJ+bXN/WBBCkttY2e+KSoxYGW+Xk9eq38bWqQq1+fuD9kVBCfNzqtMdgfLw+UY56dOJH
         naJElXiVQ+IzSQDbgkaQFROlhrVoEanXsRzdgXrUfwrJlBYjGUTc9FwLue01KIVz5d2E
         aMvEoUH3jMaAvlwGLLZWK/h435h7nBr12K39QDDwk9GUz/aMmly5tP0ydRsj5OOKjI3j
         99mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713233343; x=1713838143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1uJFPkrJK2J/fdiu3afdJXCjQfBShGSkjcoA5KyuUg=;
        b=E5oY7n/8vYw+Hylblm7WQ8PeFjsWUQ8TbIzDLUr1O3jKpxXzHiSA9vgiI3XmmTU2fN
         IRMqeS5mXWL8FteWwKWP/Dj7LDrazatZyId175hmaFLAcOeQPgxhiHsr1rfv7a0Gar5H
         qknUvsYLEey1YP2O5DZZHe2V2dXaquxeaRVB9dUhN5DhBedls5FJzR2fGpmHbLSzvl2k
         dyvEEAKVPLMGC7vWP/bRRIVyAlgQFUV8zLWGynrkbY8a9tARRFuQ/0NLPhsNqUfH3V8G
         fYlXSABSXxmYZCt9GYhot2T8HI0ezTTJdhvab77N7OEwWl+RewbuQmK1wlX4bsK4IDsA
         r0ag==
X-Forwarded-Encrypted: i=1; AJvYcCVCmzMVufXf293SGN7qFIbsw0Zj7OiwCvmT7/Yi7nVEndheZbN90+AYi2n/MtczBxPRnoeAVNdEZacG8/4ZZfp6ahu9m6DH4begf/0Z
X-Gm-Message-State: AOJu0YzpwXLQeXp4MIpOcOD+VLeQagWuiXQwfVMt9POz6mFDwRAzHrnh
	e3DznTF0JlNR36E76YdRMsA/6LS/7n+NAKyMHdiVgW3cpDJemBdLvTzOVXprS3yT+9sxH7lqnWk
	ZtfplJoSfjHra39zDJFBEA7LT/H8=
X-Google-Smtp-Source: AGHT+IESykN8OJGd2YOXbwq8TTbeWRaZ0eUnH/a90kt2ReqgCootn4yz8OG1XBn7zHKG6921Z9V8woYnNq2CeaNLnAE=
X-Received: by 2002:a05:6102:50a9:b0:47a:43b4:6410 with SMTP id
 bl41-20020a05610250a900b0047a43b46410mr13647604vsb.29.1713233342096; Mon, 15
 Apr 2024 19:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
 <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
 <87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zH4RHhZembtXOqzBDL75MA5NiEjMHx7eCN-a1ifnKTBw@mail.gmail.com>
 <877cgy2ifu.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877cgy2ifu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 16 Apr 2024 14:08:50 +1200
Message-ID: <CAGsJ_4yim-PQW0JBjZD8dpGBG3FQm=xZb1V51+Nr37nJEwEPzA@mail.gmail.com>
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

On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >> >
> >> >> >> > While swapping in a large folio, we need to free swaps related=
 to the whole
> >> >> >> > folio. To avoid frequently acquiring and releasing swap locks,=
 it is better
> >> >> >> > to introduce an API for batched free.
> >> >> >> >
> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> > ---
> >> >> >> >  include/linux/swap.h |  5 +++++
> >> >> >> >  mm/swapfile.c        | 51 +++++++++++++++++++++++++++++++++++=
+++++++++
> >> >> >> >  2 files changed, 56 insertions(+)
> >> >> >> >
> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
> >> >> >> > --- a/include/linux/swap.h
> >> >> >> > +++ b/include/linux/swap.h
> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
> >> >> >> >  extern void swap_free(swp_entry_t);
> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int =
n);
> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr)=
;
> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t =
swp)
> >> >> >> >  {
> >> >> >> >  }
> >> >> >> >
> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> >> > +{
> >> >> >> > +}
> >> >> >> > +
> >> >> >> >  static inline void put_swap_folio(struct folio *folio, swp_en=
try_t swp)
> >> >> >> >  {
> >> >> >> >  }
> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
> >> >> >> > --- a/mm/swapfile.c
> >> >> >> > +++ b/mm/swapfile.c
> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >> >> >> >               __swap_entry_free(p, entry);
> >> >> >> >  }
> >> >> >> >
> >> >> >> > +/*
> >> >> >> > + * Free up the maximum number of swap entries at once to limi=
t the
> >> >> >> > + * maximum kernel stack usage.
> >> >> >> > + */
> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFIL=
E_CLUSTER)
> >> >> >> > +
> >> >> >> > +/*
> >> >> >> > + * Called after swapping in a large folio,
> >> >> >>
> >> >> >> IMHO, it's not good to document the caller in the function defin=
ition.
> >> >> >> Because this will discourage function reusing.
> >> >> >
> >> >> > ok. right now there is only one user that is why it is added. but=
 i agree
> >> >> > we can actually remove this.
> >> >> >
> >> >> >>
> >> >> >> > batched free swap entries
> >> >> >> > + * for this large folio, entry should be for the first subpag=
e and
> >> >> >> > + * its offset is aligned with nr_pages
> >> >> >>
> >> >> >> Why do we need this?
> >> >> >
> >> >> > This is a fundamental requirement for the existing kernel, folio'=
s
> >> >> > swap offset is naturally aligned from the first moment add_to_swa=
p
> >> >> > to add swapcache's xa. so this comment is describing the existing
> >> >> > fact. In the future, if we want to support swap-out folio to disc=
ontiguous
> >> >> > and not-aligned offsets, we can't pass entry as the parameter, we=
 should
> >> >> > instead pass ptep or another different data struct which can conn=
ect
> >> >> > multiple discontiguous swap offsets.
> >> >> >
> >> >> > I feel like we only need "for this large folio, entry should be f=
or
> >> >> > the first subpage" and drop "and its offset is aligned with nr_pa=
ges",
> >> >> > the latter is not important to this context at all.
> >> >>
> >> >> IIUC, all these are requirements of the only caller now, not the
> >> >> function itself.  If only part of the all swap entries of a mTHP ar=
e
> >> >> called with swap_free_nr(), can swap_free_nr() still do its work?  =
If
> >> >> so, why not make swap_free_nr() as general as possible?
> >> >
> >> > right , i believe we can make swap_free_nr() as general as possible.
> >> >
> >> >>
> >> >> >>
> >> >> >> > + */
> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> >> > +{
> >> >> >> > +     int i, j;
> >> >> >> > +     struct swap_cluster_info *ci;
> >> >> >> > +     struct swap_info_struct *p;
> >> >> >> > +     unsigned int type =3D swp_type(entry);
> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
> >> >> >> > +     int batch_nr, remain_nr;
> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >> >> >> > +
> >> >> >> > +     /* all swap entries are within a cluster for mTHP */
> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFIL=
E_CLUSTER);
> >> >> >> > +
> >> >> >> > +     if (nr_pages =3D=3D 1) {
> >> >> >> > +             swap_free(entry);
> >> >> >> > +             return;
> >> >> >> > +     }
> >> >> >>
> >> >> >> Is it possible to unify swap_free() and swap_free_nr() into one =
function
> >> >> >> with acceptable performance?  IIUC, the general rule in mTHP eff=
ort is
> >> >> >> to avoid duplicate functions between mTHP and normal small folio=
.
> >> >> >> Right?
> >> >> >
> >> >> > I don't see why.
> >> >>
> >> >> Because duplicated implementation are hard to maintain in the long =
term.
> >> >
> >> > sorry, i actually meant "I don't see why not",  for some reason, the=
 "not"
> >> > was missed. Obviously I meant "why not", there was a "but" after it =
:-)
> >> >
> >> >>
> >> >> > but we have lots of places calling swap_free(), we may
> >> >> > have to change them all to call swap_free_nr(entry, 1); the other=
 possible
> >> >> > way is making swap_free() a wrapper of swap_free_nr() always usin=
g
> >> >> > 1 as the argument. In both cases, we are changing the semantics o=
f
> >> >> > swap_free_nr() to partially freeing large folio cases and have to=
 drop
> >> >> > "entry should be for the first subpage" then.
> >> >> >
> >> >> > Right now, the semantics is
> >> >> > * swap_free_nr() for an entire large folio;
> >> >> > * swap_free() for one entry of either a large folio or a small fo=
lio
> >> >>
> >> >> As above, I don't think the these semantics are important for
> >> >> swap_free_nr() implementation.
> >> >
> >> > right. I agree. If we are ready to change all those callers, nothing
> >> > can stop us from removing swap_free().
> >> >
> >> >>
> >> >> >>
> >> >> >> > +
> >> >> >> > +     remain_nr =3D nr_pages;
> >> >> >> > +     p =3D _swap_info_get(entry);
> >> >> >> > +     if (p) {
> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, r=
emain_nr);
> >> >> >> > +
> >> >> >> > +                     ci =3D lock_cluster_or_swap_info(p, offs=
et);
> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++) {
> >> >> >> > +                             if (__swap_entry_free_locked(p, =
offset + i * SWAP_BATCH_NR + j, 1))
> >> >> >> > +                                     __bitmap_set(usage, j, 1=
);
> >> >> >> > +                     }
> >> >> >> > +                     unlock_cluster_or_swap_info(p, ci);
> >> >> >> > +
> >> >> >> > +                     for_each_clear_bit(j, usage, batch_nr)
> >> >> >> > +                             free_swap_slot(swp_entry(type, o=
ffset + i * SWAP_BATCH_NR + j));
> >> >> >> > +
> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> >> >> >> > +                     remain_nr -=3D batch_nr;
> >> >> >> > +             }
> >> >> >> > +     }
> >> >> >> > +}
> >> >> >> > +
> >> >> >> >  /*
> >> >> >> >   * Called after dropping swapcache to decrease refcnt to swap=
 entries.
> >> >> >> >   */
> >> >> >>
> >> >> >> put_swap_folio() implements batching in another method.  Do you =
think
> >> >> >> that it's good to use the batching method in that function here?=
  It
> >> >> >> avoids to use bitmap operations and stack space.
> >> >> >
> >> >> > Chuanhua has strictly limited the maximum stack usage to several
> >> >> > unsigned long,
> >> >>
> >> >> 512 / 8 =3D 64 bytes.
> >> >>
> >> >> So, not trivial.
> >> >>
> >> >> > so this should be safe. on the other hand, i believe this
> >> >> > implementation is more efficient, as  put_swap_folio() might lock=
/
> >> >> > unlock much more often whenever __swap_entry_free_locked returns
> >> >> > 0.
> >> >>
> >> >> There are 2 most common use cases,
> >> >>
> >> >> - all swap entries have usage count =3D=3D 0
> >> >> - all swap entries have usage count !=3D 0
> >> >>
> >> >> In both cases, we only need to lock/unlock once.  In fact, I didn't
> >> >> find possible use cases other than above.
> >> >
> >> > i guess the point is free_swap_slot() shouldn't be called within
> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages slots,
> >> > we'll have to unlock and lock nr_pages times?  and this is the most
> >> > common scenario.
> >>
> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUSTER (tha=
t
> >> is, nr_pages) or 0.  These are the most common cases.
> >>
> >
> > i am actually talking about the below code path,
> >
> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> > {
> >         ...
> >
> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >         ...
> >         for (i =3D 0; i < size; i++, entry.val++) {
> >                 if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_=
CACHE)) {
> >                         unlock_cluster_or_swap_info(si, ci);
> >                         free_swap_slot(entry);
> >                         if (i =3D=3D size - 1)
> >                                 return;
> >                         lock_cluster_or_swap_info(si, offset);
> >                 }
> >         }
> >         unlock_cluster_or_swap_info(si, ci);
> > }
> >
> > but i guess you are talking about the below code path:
> >
> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> > {
> >         ...
> >
> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >         if (size =3D=3D SWAPFILE_CLUSTER) {
> >                 map =3D si->swap_map + offset;
> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> >                         val =3D map[i];
> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> >                         if (val =3D=3D SWAP_HAS_CACHE)
> >                                 free_entries++;
> >                 }
> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> >                         unlock_cluster_or_swap_info(si, ci);
> >                         spin_lock(&si->lock);
> >                         mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTE=
R);
> >                         swap_free_cluster(si, idx);
> >                         spin_unlock(&si->lock);
> >                         return;
> >                 }
> >         }
> > }
>
> I am talking about both code paths.  In 2 most common cases,
> __swap_entry_free_locked() will return 0 or !0 for all entries in range.

I grasp your point, but if conditions involving 0 or non-0 values fail, we'=
ll
end up repeatedly unlocking and locking. Picture a scenario with a large
folio shared by multiple processes. One process might unmap a portion
while another still holds an entire mapping to it. This could lead to situa=
tions
where free_entries doesn't equal 0 and free_entries doesn't equal
nr_pages, resulting in multiple unlock and lock operations.

Chuanhua has invested significant effort in following Ryan's suggestion
for the current approach, which generally handles all cases, especially
partial unmapping. Additionally, the widespread use of swap_free_nr()
as you suggested across various scenarios is noteworthy.

Unless there's evidence indicating performance issues or bugs, I believe
the current approach remains preferable.

>
> > we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
> > or you want to check free_entries =3D=3D "1 << swap_entry_order(folio_o=
rder(folio))"
> > instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i++, entry=
val++)"
> > path?
>
> Just replace SWAPFILE_CLUSTER with "nr_pages" in your code.
>
> >
> >> >>
> >> >> And, we should add batching in __swap_entry_free().  That will help
> >> >> free_swap_and_cache_nr() too.
> >
> > Chris Li and I actually discussed it before, while I completely
> > agree this can be batched. but i'd like to defer this as an incremental
> > patchset later to keep this swapcache-refault small.
>
> OK.
>
> >>
> >> Please consider this too.
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

