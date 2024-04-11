Return-Path: <linux-kernel+bounces-141645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2C8A2124
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDBDB20FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D73A8D8;
	Thu, 11 Apr 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKswkRon"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3DF9DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872385; cv=none; b=uM+VI9Dzme2B50m9cvlHpFwOf0fBO8efqNI1kI0N6a7A3dYgs8sebBACM9jlYqdBMzoFDtkJw/3uDC7Oa9uzlp6oy1HP++P8UhI1+9InPRVwlwaYL2TSjpbf76ChP5plCTI8LT/uf1sZgXo7brdYTHsIXNbk/qnGZODOzpHzJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872385; c=relaxed/simple;
	bh=6uqZKltuhQN0zzCkW8ltZaBpgzrwaJwjotMmDvrPlUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFGZ6B5tuBPzMK/f/B/sgsuozgIB3CIjcxUTgVAlxCJyKw3JtwyYiACg7McSyIaPFyrYMKZeELgG1MzudZyxD76XLxC3FQ3t6M+0NfaOag2nxneSr+UXIpTis48KQslGGfGezfcMJ5uP/zEdTy+CO+XdZbwWht3EYZlPolDVf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKswkRon; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4db123c762aso148416e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712872383; x=1713477183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIELaLTboomXZUeMU12UHwD50A8VFQDDFF5xPAO2rn4=;
        b=MKswkRon8+qtXersNyLzV+Wh3Ag73XPAym9tpJXuWL3MAqcxGhh1bsojoulTOuDpYT
         deHYmhRYio/GgTqLLBKzb12PrG/zc68NKD0MUytJ2hsvhtN8K90eP2y6t5jWqpCJWmHp
         2Jxm0QlYGFme9hHCxOYiNveyBPpQrmXNEE/0G+mf14APChdTBtK2DvdwKy2Bgkiwl+eN
         xfvxoFDLeTdgXObR1WA6r1k3WcUVuab+iqmz5M5o6KlDi+fo6zDZ7ERqTOrRCIkLaij9
         6geFdiBfLMn2/moGOQ4MWD4tlrmOSYH0KDCMHQEZ0K07hhEV0Iz0LeGiKQSrlDjODCAs
         rnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872383; x=1713477183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIELaLTboomXZUeMU12UHwD50A8VFQDDFF5xPAO2rn4=;
        b=Zwmh0k5G22KmhcHzRUv/hMxafefU21NLsf0WlPJY9bc4qDeBov4J6sAsPB1/TnmHqq
         D4SJEZi5vo5LVHK32oaybdkpFbYGi+MI/9Dj2Q1h3MqH4gdBGM/8nf5g2lpor8Q60hAf
         NWcYfvB/mfWA12mpPBnm+F5GT5BhaTdyKhG3Af/4RVY4fpYCRG0BxbzXVg4DMKoV+Z0Q
         SKATtZhBb+/cu6YOG0TW8z0NlnAA1EI0KqTKd5X0+xzN+iehNv3d6PRCx9zC3LMJsTCG
         6nVks2e03xzdn1AiXPqBbAHBdy8JN7JC6hjwm3DjGBaM0EVx2suBxAsfvWR8btPPHDB4
         MPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnFHKow8Z7uLqsC8bfr4Y4hrs6eZ8X3Nc/IvaGy3pKyITQqzMI4zjULaIkjOVOTIA+dQr61Lpxr/uUkThq6595hdTpTpZmwdbIVqUb
X-Gm-Message-State: AOJu0Yw1lI7ZI450Revgyg9/36QhxBS5XSWXMlH/NLiw2WZSol/gDFag
	ZEM6Nx9H+5qNAxcMNMZrbf446XqLafVwk8lZminRQ8iqTWnYriUAN4ek3hb4ZiZFPXOd7fYE/Pj
	LvGW53ErKQpWiKUP8SE5KYdNZ0tI=
X-Google-Smtp-Source: AGHT+IFVLzJacWc+nayN7I1PL/6pV8Y/Q9w+UKsuhKg/1XQffOkG8wJKosJDT1NbOKaN5f5B9TsQWFmeO8XYHVYr6DQ=
X-Received: by 2002:a05:6122:1881:b0:4d5:f28b:2c2c with SMTP id
 bi1-20020a056122188100b004d5f28b2c2cmr2925179vkb.3.1712872382771; Thu, 11 Apr
 2024 14:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102704.77559-1-21cnbao@gmail.com> <20240405102704.77559-3-21cnbao@gmail.com>
 <f56d3f42-c7c9-4c0a-9e1a-b89e92a3cc97@arm.com>
In-Reply-To: <f56d3f42-c7c9-4c0a-9e1a-b89e92a3cc97@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 09:52:51 +1200
Message-ID: <CAGsJ_4x_PKu5QyvPsiX9mz_oH22NyqGjf-XMX=Mm9qN4fSC2WA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm: add per-order mTHP anon_swpout and
 anon_swpout_fallback counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com, 
	peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 4:43=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/04/2024 11:27, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This helps to display the fragmentation situation of the swapfile,
> > knowing the proportion of how much we haven't split large folios.
> > So far, we only support non-split swapout for anon memory, with
> > the possibility of expanding to shmem in the future.  So, we add
> > the "anon" prefix to the counter names.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/huge_mm.h | 2 ++
> >  mm/huge_memory.c        | 4 ++++
> >  mm/page_io.c            | 6 +++++-
> >  mm/vmscan.c             | 3 +++
> >  4 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index c5d33017a4dd..1d893a358df6 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -267,6 +267,8 @@ unsigned long thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
> >  enum mthp_stat_item {
> >       MTHP_STAT_ANON_ALLOC,
> >       MTHP_STAT_ANON_ALLOC_FALLBACK,
> > +     MTHP_STAT_ANON_SWPOUT,
> > +     MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5b875f0fc923..28113f8fdf18 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -554,10 +554,14 @@ static struct kobj_attribute _name##_attr =3D __A=
TTR_RO(_name)
> >
> >  DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
> >  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBA=
CK);
> > +DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> > +DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALL=
BACK);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >       &anon_alloc_attr.attr,
> >       &anon_alloc_fallback_attr.attr,
> > +     &anon_swpout_attr.attr,
> > +     &anon_swpout_fallback_attr.attr,
> >       NULL,
> >  };
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index a9a7c236aecc..7669452e8b4d 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -212,13 +212,17 @@ int swap_writepage(struct page *page, struct writ=
eback_control *wbc)
> >
> >  static inline void count_swpout_vm_event(struct folio *folio)
> >  {
> > +     long nr_pages =3D folio_nr_pages(folio);
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >       if (unlikely(folio_test_pmd_mappable(folio))) {
> >               count_memcg_folio_events(folio, THP_SWPOUT, 1);
> >               count_vm_event(THP_SWPOUT);
> >       }
> > +     if (nr_pages > 0)
> > +             count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT=
);
>
> I think you mean "nr_pages > 1"? Although as established in my comments a=
gainst
> patch 1, its safe to call for order-0, so could just unconditionally call=
 this
> (as you effectively are at the moment).

yes. nr_pages > 1 is the correct condition. though it doesn't cause
any crash for
nr_pages > 0 as we have memory for order-0. but it is a useless job to coun=
t
for nr_pages=3D=3D1 as there is no place to show it in sysfs.

>
> >  #endif
> > -     count_vm_events(PSWPOUT, folio_nr_pages(folio));
> > +     count_vm_events(PSWPOUT, nr_pages);
> >  }
> >
> >  #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ffc4553c8615..b30e6294f82a 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1247,6 +1247,9 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >                                               count_vm_event(
> >                                                       THP_SWPOUT_FALLBA=
CK);
> >                                       }
> > +                                     if (nr_pages > 0)
> > +                                             count_mthp_stat(get_order=
(nr_pages * PAGE_SIZE),
> > +                                                     MTHP_STAT_ANON_SW=
POUT_FALLBACK);
>
> Same comment.

agreed.  Also, it doesn't cause any crash as we have memory in mthp_stats f=
or
order-0.
i will totally remove  if (nr_pages > 0) and as we are certainly in large f=
olios
cases.

>
> >  #endif
> >                                       if (!add_to_swap(folio))
> >                                               goto activate_locked_spli=
t;
>

Thanks
Barry

