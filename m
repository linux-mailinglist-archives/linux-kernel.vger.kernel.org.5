Return-Path: <linux-kernel+bounces-143410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A638A3893
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CB41F22F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A62152503;
	Fri, 12 Apr 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4atnm/P"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775E15219C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960985; cv=none; b=CTbiCF7/kDCaFTaw1Gn8irBGdIvEOjRjXF//WcpkVjL8Yfay2cucS6uJ3bHkGnzZhIL83z+bR7t3WjC4aGwplHD546F8eBILu+LJMh5uZoc+A9OBqzeZeGA6Wo40YUDbNak6iA3cYqFKYKyIuiU18H1Y7QiZpE8ybc5wd/aORnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960985; c=relaxed/simple;
	bh=QSiHFqjxfZVP4EznNU6XA6REN21IYat5y6S3zSaOFUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+t1m2DEEpkNbEmdJUxRGtujAipC8Fl5Z4i5Q4icBxMUO/+NGoFJh8jlDeQ//X8Tm3rht5hj6lXghcw4HovBdse6mAEuSa2IjOssrzZvbROaICo3+F/Qcd2NvhmIPjnSl5UZfbenP43Hi74WGAdq4+Rn012BBu4EmqdoF237WOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4atnm/P; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d727074eso1803736e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712960981; x=1713565781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPZtO4XHR0qRUWlTbfxc5HY3HLVLbGJTxabQLOb0/Jk=;
        b=D4atnm/Ppes52F2dBEWTW/KQ2UXKzLjMcs85H+V1HlwhlJ0eYm4azI5eladEij1IOV
         yuRBOCZMFPsZzNJMY4O6incIWE8IMDi4377WrERgAQxwjCBXTkVgbSwilUvzjTWi5Orm
         sluGwcp2incuix6KSntMeWbB4QQfczV7uJ7DW8sBgT9iqekbifjr2ofRGO72fek+T9jI
         qxlD9acHOyEjvTVoUR0Cvu7iNLAyE6j756R9Mi4Ia5dURu4K6IJCdtN1Ax+toGpjHJji
         K6TacnrrmmYFaYOnnLFgFna2i5PK50FuSOV/QfKxiEyVnKoau6TD5FTgLF4R0QDkQ0tj
         Iytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712960981; x=1713565781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPZtO4XHR0qRUWlTbfxc5HY3HLVLbGJTxabQLOb0/Jk=;
        b=CPwIiZ/aXuCO54xNJZm8NG8GZQPDog3dWRWUzsHFa4daGcokAyh8MoL6XHXF1+qWMs
         /hxejwcdBlmIDhpCsTsSpPRVxrdkQTLr0spz5mccd0Y84hYsO171bCSt374YgVnJU5NH
         l/Nc594VecVcR0XszBIdw1NCTpihZS2LmJtXmUKVEqdOEo6aNCqLNO60voZwrjIq8BTV
         QS8bj5ufFU5U61uHWf3zXyNp6/Ueu0ssKrseWKsJdeazUIGldeQvOtvzKT3BX74SU5GD
         anPUZ4MdP53CX/b0iaSD3O/pmKHn3uUHyP6DLJQRoVqeGlZrkCJeWJoJ9IeXDwoqaJnb
         AbnA==
X-Forwarded-Encrypted: i=1; AJvYcCXUAzy9YP3s9ew7XmrfL9yOD1QVNyfVfCU/ilE1Pxvhnt4z2NrzyH6oP6IOjqkME+9bzhzDoqkZL6r4IjF1vgXjJvEFFZtPD49IaJe2
X-Gm-Message-State: AOJu0YzX1R8NyJp7gaP5D54mZbJ89goNmmKIZe1cB6vgy8UypHCvv+Iz
	fOVJYcDfw1zdZmOtHB6fz/2KmmqeeKZyYHyAUyPfZTpv9jxmFCIEnC2qgrMhp9slAUX79N1/+Qm
	CKLwsJaAlhy0MF9P8vlaTVSRD2fk=
X-Google-Smtp-Source: AGHT+IEOLfjNT3vVsjAHHNkO5VeMiS5C5+iqoQb0vJCRPJRQYQwQU4EIG5h4pvrCNpp/sT3ZOYJFBHj8Efpfr0cWxUc=
X-Received: by 2002:ac2:520d:0:b0:516:c3ee:5c79 with SMTP id
 a13-20020ac2520d000000b00516c3ee5c79mr2308678lfl.37.1712960981175; Fri, 12
 Apr 2024 15:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com> <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
In-Reply-To: <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 12 Apr 2024 15:29:29 -0700
Message-ID: <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 12 Apr 2024, at 15:32, David Hildenbrand wrote:
>
> > On 12.04.24 16:35, Zi Yan wrote:
> >> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
> >>
> >>> On 11.04.24 17:32, Zi Yan wrote:
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
> >>>> if any page in a folio loses its final mapping. It is possible that
> >>>> the folio is unmapped fully, but it is unnecessary to add the folio
> >>>> to deferred split list at all. Fix it by checking folio mapcount bef=
ore
> >>>> adding a folio to deferred split list.
> >>>>
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>> ---
> >>>>    mm/rmap.c | 9 ++++++---
> >>>>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>> index 2608c40dffad..d599a772e282 100644
> >>>> --- a/mm/rmap.c
> >>>> +++ b/mm/rmap.c
> >>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
> >>>>                    enum rmap_level level)
> >>>>    {
> >>>>            atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>>> -  int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>>> +  int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>>            enum node_stat_item idx;
> >>>>            __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> >>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
> >>>>                            break;
> >>>>                    }
> >>>>   -                atomic_sub(nr_pages, &folio->_large_mapcount);
> >>>> +          mapcount =3D atomic_sub_return(nr_pages,
> >>>> +                                       &folio->_large_mapcount) + 1=
;
> >>>
> >>> That becomes a new memory barrier on some archs. Rather just re-read =
it below. Re-reading should be fine here.
> >>
> >> Would atomic_sub_return_relaxed() work? Originally I was using atomic_=
read(mapped)
> >> below, but to save an atomic op, I chose to read mapcount here.
> >
> > Some points:
> >
> > (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
> > RMW that return a value -- and how they interact with memory barriers.
> > Further, how relaxed variants are only optimized on some architectures.
> >
> > atomic_read() is usually READ_ONCE(), which is just an "ordinary" memor=
y
> > access that should not be refetched. Usually cheaper than most other st=
uff
> > that involves atomics.
>
> I should have checked the actual implementation instead of being fooled
> by the name. Will read about it. Thanks.
>
> >
> > (2) We can either use folio_large_mapcount() =3D=3D 0 or !atomic_read(m=
apped)
> > to figure out if the folio is now completely unmapped.
> >
> > (3) There is one fundamental issue: if we are not batch-unmapping the w=
hole
> > thing, we will still add the folios to the deferred split queue. Migrat=
ion
> > would still do that, or if there are multiple VMAs covering a folio.
> >
> > (4) We should really avoid making common operations slower only to make
> > some unreliable stats less unreliable.
> >
> >
> > We should likely do something like the following, which might even be a=
 bit
> > faster in some cases because we avoid a function call in case we unmap
> > individual PTEs by checking _deferred_list ahead of time
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 2608c40dffad..356598b3dc3c 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >                  * page of the folio is unmapped and at least one page
> >                  * is still mapped.
> >                  */
> > -               if (folio_test_large(folio) && folio_test_anon(folio))
> > -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> > -                               deferred_split_folio(folio);
> > +               if (folio_test_large(folio) && folio_test_anon(folio) &=
&
> > +                   (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped) =
&&
> > +                   atomic_read(mapped) &&
> > +                   data_race(list_empty(&folio->_deferred_list)))
>
> data_race() might not be needed, as Ryan pointed out[1]
>
> > +                       deferred_split_folio(folio);
> >         }
> >
> > I also thought about handling the scenario where we unmap the whole
> > think in smaller chunks. We could detect "!atomic_read(mapped)" and
> > detect that it is on the deferred split list, and simply remove it
> > from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
> >
> > But it would be racy with concurrent remapping of the folio (might happ=
en with
> > anon folios in corner cases I guess).
> >
> > What we can do is the following, though:
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index dc30139590e6..f05cba1807f2 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *fol=
io)
> >         ds_queue =3D get_deferred_split_queue(folio);
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >         if (!list_empty(&folio->_deferred_list)) {
> > +               if (folio_test_pmd_mappable(folio))
> > +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
> >                 ds_queue->split_queue_len--;
> >                 list_del_init(&folio->_deferred_list);
> >         }
> >
> > Adding the right event of course.
> >
> >
> > Then it's easy to filter out these "temporarily added to the list, but =
never split
> > before the folio was freed" cases.
>
> So instead of making THP_DEFERRED_SPLIT_PAGE precise, use
> THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE instead? That shou=
ld work.

It is definitely possible that the THP on the deferred split queue are
freed instead of split. For example, 1M is unmapped for a 2M THP, then
later the remaining 1M is unmapped, or the process exits before memory
pressure happens. So how come we can tell it is "temporarily added to
list"? Then THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE
actually just counts how many pages are still on deferred split queue.
It may be useful. However the counter is typically used to estimate
how many THP are partially unmapped during a period of time. So we
just need to know the initial value and the value when we read it
again.

>
> I wonder what THP_DEFERRED_SPLIT_PAGE counts. If it counts THP deferred
> splits, why not just move the counter to deferred_split_scan(), where the=
 actual
> split happens. Or the counter has a different meaning?

The deferred_split_scan() / deferred_split_count() just can return the
number of pages on a specific queue (a specific node with a specific
memcg). But THP_DEFERRED_SPLIT_PAGE is a global counter. Did I miss
something? Or you mean traverse all memcgs and all nodes? It sounds
too overkilling.

>
>
>
> [1] https://lore.kernel.org/linux-mm/e3e14098-eade-483e-a459-e43200b87941=
@arm.com/
>
> --
> Best Regards,
> Yan, Zi

