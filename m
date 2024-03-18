Return-Path: <linux-kernel+bounces-105619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93E87E1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2222E282A74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDB1E867;
	Mon, 18 Mar 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxKlK1jU"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D711CD1D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725311; cv=none; b=Z2GrolKk+Pv4kZtIMau5x0vAKrUu9UU10+mN+Ke8MTh9Aaoz7JKiTYb90bxTTsnC75ZstMucOkiSsOQeM6YmFc2p2Fabt5Rw1uLYoPtK3xda6G5osB1Qs3Ne7Pvq+OIifz5YJuaLiioURbFhKirv+kXTOSufwMaRviJaUSOtES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725311; c=relaxed/simple;
	bh=3VcSlon8hejjc1/Pma872ytoVEL+FXrp209cySQOcnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0NTepoLDJju54a89Ww1kQiEoXEquN/P4oIYkZl5HR3/5Pcuh8uYNIaN2mvUQElz3p/rXP3PNyFFQFEZ86NDbwmqebPSh9oKlAYRV2FBOhZOGIca1vWRVUYRwvklnbhWWQ7MyOerHGdIGcQcN/rTUR/oduyyWd4fYpEMvXNQNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxKlK1jU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d49ca33dcaso19744671fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710725307; x=1711330107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJJWEPgNKuQe2IAdyvbQuuADni5SrmjiNQjHK6NUUtk=;
        b=SxKlK1jUTzNFNDFVGp5l55a4Vce4tZAw7GjJGX9zdxCgxfxryUXGq/3MC6WtzRDpGo
         5Vnnqoj4pKA+jUHQRaUM3XiTo2vDJLQLDBWSbfTwaApG8Ae1BoBoHVdw3UsqRpixDw0c
         z4rSOgViFkTEsKiovKpDilX/iG16Lk8t2er04lLXIqFT4yr/15P4F9lVCfkaVAZ492yI
         8iK9fhF135MoXHcV2R2urJ9T9+Y3IquPrTyZ38DTYDaTKIwnv6emgk/1fldREE+PKULR
         6WYZz8lfrYruqjra0GI0hw8mxq+FUqtvSIM2XXORlYvkfBv5YCiP2mzOd8ua1CxMKDEr
         AHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710725307; x=1711330107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJJWEPgNKuQe2IAdyvbQuuADni5SrmjiNQjHK6NUUtk=;
        b=nGTn8FgQMgxs4YKWdwRHMaeICCmx9Mpgrsu5jZ4tZfsLs4OWwOgbBz9VdgiKAcgJ9n
         QVS/WHUmQDBz1OMmXND8KulMIDeGv1LweiARyZbKzGiusDDhVkkEpRVFaG6OeBUhaGZX
         rBCpS8ad0xj5ukN9MStXNYsS9jcKWXxNivNAizqqZo5C/wtveNAQOz2QkEqZnxqaQ3/N
         p3w6Okrfq1dhum1OWstxK5a2l7oRZ9vMM4ZTuabrliR7wmBuqOOySI8LDxr+m++wxsUo
         yXxamVWdPo9JyTj+wo45Qv9ut/j8R72KVi1M9+one35zck9tT9TZvWj5GCM3KoAbfoPO
         suPA==
X-Forwarded-Encrypted: i=1; AJvYcCVdP3xGpHcBVW0cGnSk9Y0v8J7OKBTaSQXfqyBi2eDovB3stgrY3p2EcyuPQ8xQnczQJn5acjxDkLeP9B2KqeYDju4Nnj79w7hWPtX+
X-Gm-Message-State: AOJu0YxIP9RR4Of0zLV8wFe8Er3tl0OJFuLSJikvlIMD9QR05/S6ycrx
	tg8BQ7P8QbidA9aO4gAs6gMTFuAZqyX/ElAlacB6rf5yt4fnSds4ovUkGjIhJzabfHuKrfta8d4
	FQFgGWTknBqr15ppE8e08VCgp9vs=
X-Google-Smtp-Source: AGHT+IEE9GatBuUUXuitxUWFfO+HovAUwrNnaBRQFHWjWGs84tWsorg5/o1AY3CnbzqX0QSIi4soDV5M1YhtOkOQS5Q=
X-Received: by 2002:a2e:6a19:0:b0:2d3:f464:2274 with SMTP id
 f25-20020a2e6a19000000b002d3f4642274mr6144642ljc.37.1710725306960; Sun, 17
 Mar 2024 18:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-3-21cnbao@gmail.com>
 <499a60c6-eeb8-4bbd-8563-9717c0d2e43d@arm.com> <CANzGp4+kSxc_JbOsOcvm6vXfu2KORaqqGyuKK_eJwCLTK5X__Q@mail.gmail.com>
 <716bb29c-d2a2-4eef-b300-b037f08f458f@arm.com> <CANzGp4KC4ucxJv_h2CZCgLUZ=x8J5sp4i46C02Gx9ddvF3sKrg@mail.gmail.com>
 <76c16222-78fd-4d96-b9f7-13264bb37747@arm.com>
In-Reply-To: <76c16222-78fd-4d96-b9f7-13264bb37747@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Mon, 18 Mar 2024 09:28:15 +0800
Message-ID: <CANzGp4KY1z-EJVp+oYV9Ku7c=z=-gJMRt1wdYzKOMbKrLepizA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] mm: swap: introduce swap_nr_free() for batched swap_free()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=94 18:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On 15/03/2024 08:34, Chuanhua Han wrote:
> > Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 21:43=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 14/03/2024 13:12, Chuanhua Han wrote:
> >>> Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=BA=8C 02:51=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 04/03/2024 08:13, Barry Song wrote:
> >>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>>
> >>>>> While swapping in a large folio, we need to free swaps related to t=
he whole
> >>>>> folio. To avoid frequently acquiring and releasing swap locks, it i=
s better
> >>>>> to introduce an API for batched free.
> >>>>>
> >>>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> ---
> >>>>>  include/linux/swap.h |  6 ++++++
> >>>>>  mm/swapfile.c        | 35 +++++++++++++++++++++++++++++++++++
> >>>>>  2 files changed, 41 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>>>> index 2955f7a78d8d..d6ab27929458 100644
> >>>>> --- a/include/linux/swap.h
> >>>>> +++ b/include/linux/swap.h
> >>>>> @@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >>>>>  extern int swap_duplicate(swp_entry_t);
> >>>>>  extern int swapcache_prepare(swp_entry_t);
> >>>>>  extern void swap_free(swp_entry_t);
> >>>>> +extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> >>>>
> >>>> nit: In my swap-out v4 series, I've created a batched version of
> >>>> free_swap_and_cache() and called it free_swap_and_cache_nr(). Perhap=
s it is
> >>>> preferable to align the naming schemes - i.e. call this swap_free_nr=
(). Your
> >>>> scheme doesn't really work when applied to free_swap_and_cache().
> >>> Thanks for your suggestions, and for the next version, we'll see whic=
h
> >>> package is more appropriate!
> >>>>
> >>>>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >>>>>  extern int free_swap_and_cache(swp_entry_t);
> >>>>>  int swap_type_of(dev_t device, sector_t offset);
> >>>>> @@ -561,6 +562,11 @@ static inline void swap_free(swp_entry_t swp)
> >>>>>  {
> >>>>>  }
> >>>>>
> >>>>> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> >>>>> +{
> >>>>> +
> >>>>> +}
> >>>>> +
> >>>>>  static inline void put_swap_folio(struct folio *folio, swp_entry_t=
 swp)
> >>>>>  {
> >>>>>  }
> >>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>>>> index 3f594be83b58..244106998a69 100644
> >>>>> --- a/mm/swapfile.c
> >>>>> +++ b/mm/swapfile.c
> >>>>> @@ -1341,6 +1341,41 @@ void swap_free(swp_entry_t entry)
> >>>>>               __swap_entry_free(p, entry);
> >>>>>  }
> >>>>>
> >>>>> +/*
> >>>>> + * Called after swapping in a large folio, batched free swap entri=
es
> >>>>> + * for this large folio, entry should be for the first subpage and
> >>>>> + * its offset is aligned with nr_pages
> >>>>> + */
> >>>>> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> >>>>> +{
> >>>>> +     int i;
> >>>>> +     struct swap_cluster_info *ci;
> >>>>> +     struct swap_info_struct *p;
> >>>>> +     unsigned type =3D swp_type(entry);
> >>>>
> >>>> nit: checkpatch.py will complain about bare "unsigned", preferring "=
unsigned
> >>>> int" or at least it did for me when I did something similar in my sw=
ap-out patch
> >>>> set.
> >>> Gee, thanks for pointing that out!
> >>>>
> >>>>> +     unsigned long offset =3D swp_offset(entry);
> >>>>> +     DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) =3D { 0 };
> >>>>
> >>>> I don't love this, as it could blow the stack if SWAPFILE_CLUSTER ev=
er
> >>>> increases. But the only other way I can think of is to explicitly lo=
op over
> >>>> fixed size chunks, and that's not much better.
> >>> Is it possible to save kernel stack better by using bit_map here?  If
> >>> SWAPFILE_CLUSTER=3D512, we consume only (512/64)*8=3D 64 bytes.
> >>
> >> I'm not sure I've understood what you are saying? You're already using
> >> DECLARE_BITMAP(), so its already consuming 64 bytes if SWAPFILE_CLUSTE=
R=3D512, no?
> >>
> >> I actually did a bad job of trying to express a couple of different po=
ints:
> >>
> >> - Are there any configurations today where SWAPFILE_CLUSTER > 512? I'm=
 not sure.
> >> Certainly not for arm64, but not sure about other architectures. For e=
xample if
> >> an arch had 64K pages with 8192 entries per THP and supports SWAP_THP,=
 that's 1K
> >> for the bitmap, which is now looking pretty big for the stack.
> > I agree with you.The current bit_map grows linearly with the
> > SWAPFILE_CLUSTER, which may cause the kernel stack to swell.
> > I need to think of a way to save more memory .
> >>
> >> - Would it be better to decouple stack usage from SWAPFILE_CLUSTER and=
 instead
> >> define a fixed stack size (e.g. 64 bytes -> 512 entries). Then free th=
e range of
> >> entries in batches no bigger than this size. This approach could also =
allow
> >> removing the constraint that the range has to be aligned and fit in a =
single
> >> cluster. Personally I think an approach like this would be much more r=
obust, in
> >> return for a tiny bit more complexity.
> > Because we cannot determine how many swap entries a cluster has in an
> > architecture or a configuration, we do not know how large the variable
> > needs to be defined=EF=BC=9F
>
> My point is that we could define a fixed size, then loop through the pass=
ed in
> range, operating on batches of that fixed size. You could even take into
> consideration the cluster boundaries so that you take the correct lock fo=
r every
> batch and can drop the "must be naturally aligned, must be no bigger than
> cluster size" constraint.

Thank you. I understand it=EF=BC=81

>
>
> >>
> >>>>
> >>>>> +
> >>>>> +     /* all swap entries are within a cluster for mTHP */
> >>>>> +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLU=
STER);
> >>>>> +
> >>>>> +     if (nr_pages =3D=3D 1) {
> >>>>> +             swap_free(entry);
> >>>>> +             return;
> >>>>> +     }
> >>>>> +
> >>>>> +     p =3D _swap_info_get(entry);
> >>>>
> >>>> You need to handle this returning NULL, like swap_free() does.
> >>> Yes, you're right! We did forget to judge NULL here.
> >>>>
> >>>>> +
> >>>>> +     ci =3D lock_cluster(p, offset);
> >>>>
> >>>> The existing swap_free() calls lock_cluster_or_swap_info(). So if sw=
ap is backed
> >>>> by rotating media, and clusters are not in use, it will lock the who=
le swap
> >>>> info. But your new version only calls lock_cluster() which won't loc=
k anything
> >>>> if clusters are not in use. So I think this is a locking bug.
> >>> Again, you're right, it's bug!
> >>>>
> >>>>> +     for (i =3D 0; i < nr_pages; i++) {
> >>>>> +             if (__swap_entry_free_locked(p, offset + i, 1))
> >>>>> +                     __bitmap_set(usage, i, 1);
> >>>>> +     }
> >>>>> +     unlock_cluster(ci);
> >>>>> +
> >>>>> +     for_each_clear_bit(i, usage, nr_pages)
> >>>>> +             free_swap_slot(swp_entry(type, offset + i));
> >>>>> +}
> >>>>> +
> >>>>>  /*
> >>>>>   * Called after dropping swapcache to decrease refcnt to swap entr=
ies.
> >>>>>   */
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>
> >>>
> >>>
> >>
> >
> >
>


--=20
Thanks,
Chuanhua

