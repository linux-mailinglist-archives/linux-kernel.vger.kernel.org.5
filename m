Return-Path: <linux-kernel+bounces-91931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624128718B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BA21F22E24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C074F207;
	Tue,  5 Mar 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOJPeEmp"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786ED1EF1A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628977; cv=none; b=TYSCVF6vkjVB0nC9NLFD48jnPapDx+sy1NuW79Q5/HiHriVU+1RkWkUvEOJIoc0MkIB+ZyrQpp3rdjLmHKbmkschnOUDwpft2eeKBO+9fbM+/wxgx+QH8XMj+xAleNF21IrAy5Yfu4sjwHwnJ8yhx/pKAP62ZbZWjIYvQhWtsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628977; c=relaxed/simple;
	bh=j5+9JzPeNa+J8GdabbLupRfk09uumrzdco525tHsul4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtGrrYYyXuKpsmh/VI/hOHNB+Va0o9nYbEOSdHqT5dP95HLps5tCP5ZgZu48aDZAW5AMCjmnrIsiD06+s/zsz6GXUXzyzzOzU0iepg/DuKyB9Gca0ac6kiN5sU0z3CueM9zZOVlmNjbdZhf6MigmwNXiqp76Qd/fj7Nbb56rO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOJPeEmp; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7dacc916452so1617884241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628974; x=1710233774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf7eeKiUo+Z6E3AtxwZ6h2eHT+M9RMwHIVhw9daL31I=;
        b=jOJPeEmpL4aN0jpsxqJnQfnUIQ3Wd2mnGMJJ5x0ACFEMde1sCO45UU5GT+/05EME8Q
         PzFQFe25HpFkyPAgupa1hA5JlGTn9JPYLC9r1azrJfYYtIeS0QJXsLUYAUQTs7AmjVfp
         65yr1kXEuI4xCe9cMqL9vJU48KvVqZ63z0CrFQjbUM8sW3vDKljC/pieuOl+qxV1sE4H
         DTzCmy2Z9quzpeRx9X0OVXxeC9xDA6JG4DDhqX/niUT9++YPcewmFwJzMrGOGmr9dy/c
         6rJoX+towulnDSoQgO3PS3EDWw/Sg496xNUZe05n+Or6MXqTxFiwgzH7D8Imk5hq+bP8
         Ne8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628974; x=1710233774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xf7eeKiUo+Z6E3AtxwZ6h2eHT+M9RMwHIVhw9daL31I=;
        b=K6qFhtbsaiYd75sTkHXEMHsKDhtRUCNxd8F5GrwnqEoEwtoC1Ry8+ktBmlFVwIhHYM
         8Pi7K8IlWrtVdKS+Kb/OUm2kVtc6QheptJu84f54lwKcLI8uquTZ3DLWmpy/IwEVqgXk
         98dzH7hDMdk2vVl/64qNNoSjRwChNJifdFfoWxW3JyRnMLolJ6GSHhll0q4/An0ajUfd
         kskUN9BoPvTBKdDhfNLA4A6tIP6wR0637R2kbP/qwj7lajkWVxuGIwr55dtp/iBxoKiX
         MvMEZLQbUaDrshHn00yiRFRimbbzju49aZLvmH1H8/3Kllz9X71ecMAH/BgIk9VOY2tZ
         i0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCULmpVekht7jpISNgHDDLOO/RxrhyQTzCaPjXr/X6Vs0E5vEa9tiIIUVqHkSEr8bdK9yA2jY2SPyUBLSHwYOPE3R8V5nqmz5yj9Flnr
X-Gm-Message-State: AOJu0Yw1jZUcdkasonRTLS9WjaPHIrb2Wfn7dpOLxX3zM958ZPgqgAmN
	0hIzwTN0AFC8w6FiR6yfACYHt/jJM3c/QZ8TBj2+IkyhZYnvCS0GTl/h7qQwMKv0UvOgPywFSWH
	Qmp5Vcw9P5Gl+ILOgi33Rk39GFfw=
X-Google-Smtp-Source: AGHT+IH27VErZkiLtO2IdHog333rbZI3ycr1XH26aXwrNf1p+sK4n3gGZBqRc/BxEFNaQi/YkEnS/mfqo1Q98C8D+GE=
X-Received: by 2002:ac5:ce02:0:b0:4cd:20ea:35b1 with SMTP id
 j2-20020ac5ce02000000b004cd20ea35b1mr874707vki.2.1709628974288; Tue, 05 Mar
 2024 00:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <878r2x9ly3.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878r2x9ly3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 21:56:02 +1300
Message-ID: <CAGsJ_4yKhoztyA1cuSjGEeVwJfNdhNPNidrX-D_dRazRL7D5hg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com, 
	ryan.roberts@arm.com, chrisl@kernel.org, yuzhao@google.com, 
	hanchuanhua@oppo.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 8:30=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > page_vma_mapped_walk() within try_to_unmap_one() races with other
> > PTEs modification such as break-before-make, while iterating PTEs
>
> Sorry, I don't know what is "break-before-make", can you elaborate?
> IIUC, ptep_modify_prot_start()/ptep_modify_prot_commit() can clear PTE
> temporarily, which may cause race with page_vma_mapped_walk().  Is that
> the issue that you try to fix?

we are writing pte to zero(break) before writing a new value(make). while
this behavior is within PTL in another thread,  page_vma_mapped_walk()
of try_to_unmap_one thread won't take PTL till it meets a present PTE.
for example, if another threads are modifying nr_pages PTEs under PTL,
but we don't hold PTL, we might skip one or two PTEs at the beginning of
a large folio.
For a large folio, after try_to_unmap_one(), we may result in PTE0 and PTE1
untouched but PTE2~nr_pages-1 are set to swap entries.

by holding PTL from PTE0 for large folios, we won't get these intermediate
values. At the moment we get PTL, other threads have done.

>
> --
> Best Regards,
> Huang, Ying
>
> > of a large folio, it will only begin to acquire PTL after it gets
> > a valid(present) PTE. break-before-make intermediately sets PTEs
> > to pte_none. Thus, a large folio's PTEs might be partially skipped
> > in try_to_unmap_one().
> > For example, for an anon folio, after try_to_unmap_one(), we may
> > have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
> > So folio will be still mapped, the folio fails to be reclaimed.
> > What=E2=80=99s even more worrying is, its PTEs are no longer in a unifi=
ed
> > state. This might lead to accident folio_split() afterwards. And
> > since a part of PTEs are now swap entries, accessing them will
> > incur page fault - do_swap_page.
> > It creates both anxiety and more expense. While we can't avoid
> > userspace's unmap to break up unified PTEs such as CONT-PTE for
> > a large folio, we can indeed keep away from kernel's breaking up
> > them due to its code design.
> > This patch is holding PTL from PTE0, thus, the folio will either
> > be entirely reclaimed or entirely kept. On the other hand, this
> > approach doesn't increase PTL contention. Even w/o the patch,
> > page_vma_mapped_walk() will always get PTL after it sometimes
> > skips one or two PTEs because intermediate break-before-makes
> > are short, according to test. Of course, even w/o this patch,
> > the vast majority of try_to_unmap_one still can get PTL from
> > PTE0. This patch makes the number 100%.
> > The other option is that we can give up in try_to_unmap_one
> > once we find PTE0 is not the first entry we get PTL, we call
> > page_vma_mapped_walk_done() to end the iteration at this case.
> > This will keep the unified PTEs while the folio isn't reclaimed.
> > The result is quite similar with small folios with one PTE -
> > either entirely reclaimed or entirely kept.
> > Reclaiming large folios by holding PTL from PTE0 seems a better
> > option comparing to giving up after detecting PTL begins from
> > non-PTE0.
> >
> > Cc: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/vmscan.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 0b888a2afa58..e4722fbbcd0c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct lis=
t_head *folio_list,
> >
> >                       if (folio_test_pmd_mappable(folio))
> >                               flags |=3D TTU_SPLIT_HUGE_PMD;
> > +                     /*
> > +                      * if page table lock is not held from the first =
PTE of
> > +                      * a large folio, some PTEs might be skipped beca=
use of
> > +                      * races with break-before-make, for example, PTE=
s can
> > +                      * be pte_none intermediately, thus one or more P=
TEs
> > +                      * might be skipped in try_to_unmap_one, we might=
 result
> > +                      * in a large folio is partially mapped and parti=
ally
> > +                      * unmapped after try_to_unmap
> > +                      */
> > +                     if (folio_test_large(folio))
> > +                             flags |=3D TTU_SYNC;
> >
> >                       try_to_unmap(folio, flags);
> >                       if (folio_mapped(folio)) {

Thanks
Barry

