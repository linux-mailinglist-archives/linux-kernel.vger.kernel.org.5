Return-Path: <linux-kernel+bounces-159484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870558B2F36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C528316B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F7278C6F;
	Fri, 26 Apr 2024 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZzvR2Mf"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C57604D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103089; cv=none; b=cgP670agTApa40UUgxzq1bqce4BtJfD8yFnoOEcxloLOKmnv5QDe5vW5cEQcm1HgI+sgRHqQWdUmvss6mRbClA9pgcLVt8mRvbQvCPGjBziDn3PxDsy+AvrjsZsWLc5K35rvmQCv0sNL8Nm1xTMfVuXiy7m8Rj2/WeuAgLDDS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103089; c=relaxed/simple;
	bh=7U5kFqomoJhcxvzbvTNSnxwlqSlc2l8ca4UxoI+vWCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFDgERtoqH5YqSXVaN/I/FRSEzMYfvwGjItefP0tneqkm3OW07d+KDaUQAxE/xSsFxxpzh2dDhfe11IE2RQ8C6C05uJbCbZEGnkcWIaroLwD1H60bCo9WfYjvD3jV30pK+t7+9HggVfiz2445PeNHaQSbUTIQK7NBh+bFjQiIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZzvR2Mf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4daab3cf090so852189e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714103087; x=1714707887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl+KwHwGCvopYJe2xXkZJXc+dLxXvy+2rqA7eH7DOaI=;
        b=KZzvR2MfMdVjv+aCcQHD5s4O5XEmVDMLGytG4YiscYnFaZ4BY0Gh+VuG4M+syS7Ltu
         2aSp3TbaPRTTA5t3cAUMUBuomxZKwoSYMSpB6VizParDkHklWpL7azr6ZSQKyRqE8kn5
         P7G3mjnGxCurQE5EtA3nH96ST7RvK9e/iqCKIpK234p/6pxdllQtOchG5Pkyoz3mYego
         yxhUIv6K6HutTlqhUevqmIot+FSaZH7n2S7JxBow4rrRVUPKHWRithpchheDtfnbjT2y
         PdnyXPnG+w5njAeMorkaflzyFnClDmC8lPxk5VEh9EB2zh7dM4DATDV2zzTP6+1iHtaQ
         /xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103087; x=1714707887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hl+KwHwGCvopYJe2xXkZJXc+dLxXvy+2rqA7eH7DOaI=;
        b=SpZ30jzeUqruuoU++SwBqD6O5OZFL1CGiyu677+5dYxiyWBdIIV/Z+T31UHvjgsN0k
         CvfN4BqzDbfpxA3iLpckcodvwJ8GcU9815noZdxgWe56ZxyTqqLdKG+t8CktjqAtNShT
         IHkcEpEtzdojrjttdrbkfp2cYnbPbA5iHzLYopcryTeehZJaS6EP/LUa0PV2iJKdSqws
         NfO6/3362/gFffB9p4MdRrh65lE2rgZGAADBHOvpa3rx6nyE6Lag9+pcqj5x0rvVzJs/
         2hHuWL7G3qXnrdrRSp8SeU8zLen5xOo0w+sPmEHqLeGSrpq01Czty+49HZShlq20nm1c
         qJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvpOxVyACc8r4C9ixOREa24SjYtRbZxZx22/TpLi1kpivFcZ464fQj3yniZ9EOW1jnykm4BxfJOscc86fvU85UNknTp/InL7fJLoiv
X-Gm-Message-State: AOJu0Yz+I3ogtz2SO8qTdYCQ6tPmBv7ofk4XPV+H6vCkYzVUoWLrSz4U
	0YECyyALmn+Mj+CvG0SBJA0Gmj0l5LI3W/AmgWxLOdZX7F78KVDa3Ip9NUB+dqUW6LM8Yq7zkVK
	juvYSJI99kaPhl7GqOFwocmQ8WHb/RLV0H957ug==
X-Google-Smtp-Source: AGHT+IFx+1ecCbTS9p2WDOgrOlJuG+TMhRgBlPkAaar7fKSVClUxULAMdrigbpw5toyOS4O+8OB60bBFZjxl0Z+cR2g=
X-Received: by 2002:a05:6122:986:b0:4d3:34f4:7e99 with SMTP id
 g6-20020a056122098600b004d334f47e99mr2185296vkd.0.1714103087010; Thu, 25 Apr
 2024 20:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
 <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com> <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
 <730660D2-E1BA-4A2E-B99C-2F160F9D9A9B@nvidia.com> <CAGsJ_4yNSKdft-G=4X2Dr5HJ-axh-8SohGW7nkUfTYrsNFr9_Q@mail.gmail.com>
 <FAE058F4-7D2A-4760-9D24-A7D931062200@nvidia.com>
In-Reply-To: <FAE058F4-7D2A-4760-9D24-A7D931062200@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Apr 2024 11:44:35 +0800
Message-ID: <CAGsJ_4xNARZg29Ay6BWFZ99PnH1k0M2SdPV=jo6gW-uReLfk6Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:37=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 25 Apr 2024, at 23:28, Barry Song wrote:
>
> > On Fri, Apr 26, 2024 at 10:50=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 25 Apr 2024, at 22:23, Barry Song wrote:
> >>
> >>> On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote=
:
> >>>>
> >>>> On 25 Apr 2024, at 21:45, Barry Song wrote:
> >>>>
> >>>>> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wr=
ote:
> >>>>>>
> >>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>
> >>>>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
> >>>>>> if any page in a folio loses its final mapping. But it is possible=
 that
> >>>>>> the folio is fully unmapped and adding it to deferred split list i=
s
> >>>>>> unnecessary.
> >>>>>>
> >>>>>> For PMD-mapped THPs, that was not really an issue, because removin=
g the
> >>>>>> last PMD mapping in the absence of PTE mappings would not have add=
ed the
> >>>>>> folio to the deferred split queue.
> >>>>>>
> >>>>>> However, for PTE-mapped THPs, which are now more prominent due to =
mTHP,
> >>>>>> they are always added to the deferred split queue. One side effect
> >>>>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio ca=
n be
> >>>>>> unintentionally increased, making it look like there are many part=
ially
> >>>>>> mapped folios -- although the whole folio is fully unmapped stepwi=
se.
> >>>>>>
> >>>>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped T=
HPs
> >>>>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introd=
uce
> >>>>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE=
-mapped
> >>>>>> folio is unmapped in one go and can avoid being added to deferred =
split
> >>>>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will s=
till be
> >>>>>> noise when we cannot batch-unmap a complete PTE-mapped folio in on=
e go
> >>>>>> -- or where this type of batching is not implemented yet, e.g., mi=
gration.
> >>>>>>
> >>>>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is chec=
ked
> >>>>>> to tell if the whole folio is unmapped. If the folio is already on
> >>>>>> deferred split list, it will be skipped, too.
> >>>>>>
> >>>>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> >>>>>> folio_test_pmd_mappable() for THP split statistics") tried to excl=
ude
> >>>>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it doe=
s not
> >>>>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was s=
till
> >>>>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAG=
E,
> >>>>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >>>>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappabl=
e().
> >>>>>>
> >>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >>>>>> ---
> >>>>>>  mm/rmap.c | 8 +++++---
> >>>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>> index a7913a454028..220ad8a83589 100644
> >>>>>> --- a/mm/rmap.c
> >>>>>> +++ b/mm/rmap.c
> >>>>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_=
rmap(struct folio *folio,
> >>>>>>                  * page of the folio is unmapped and at least one =
page
> >>>>>>                  * is still mapped.
> >>>>>>                  */
> >>>>>> -               if (folio_test_large(folio) && folio_test_anon(fol=
io))
> >>>>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr=
_pmdmapped)
> >>>>>> -                               deferred_split_folio(folio);
> >>>>>> +               if (folio_test_large(folio) && folio_test_anon(fol=
io) &&
> >>>>>> +                   list_empty(&folio->_deferred_list) &&
> >>>>>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(m=
apped)) ||
> >>>>>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdma=
pped)))
> >>>>>> +                       deferred_split_folio(folio);
> >>>>>
> >>>>> Hi Zi Yan,
> >>>>> in case a mTHP is mapped by two processed (forked but not CoW yet),=
 if we
> >>>>> unmap the whole folio by pte level in one process only, are we stil=
l adding this
> >>>>> folio into deferred list?
> >>>>
> >>>> No. Because the mTHP is still fully mapped by the other process. In =
terms of code,
> >>>> nr will be 0 in that case and this if condition is skipped. nr is on=
ly increased
> >>>> from 0 when one of the subpages in the mTHP has no mapping, namely p=
age->_mapcount
> >>>> becomes negative and last is true in the case RMAP_LEVEL_PTE.
> >>>
> >>> Ok. i see, so "last" won't be true?
> >>>
> >>> case RMAP_LEVEL_PTE:
> >>> do {
> >>> last =3D atomic_add_negative(-1, &page->_mapcount);
> >>>    if (last && folio_test_large(folio)) {
> >>>        last =3D atomic_dec_return_relaxed(mapped);
> >>>        last =3D (last < ENTIRELY_MAPPED);
> >>> }
> >>>
> >>> if (last)
> >>>      nr++;
> >>> } while (page++, --nr_pages > 0);
> >>> break;
> >>
> >> Right, because for every subpage its corresponding
> >> last =3D atomic_add_negative(-1, &page->_mapcount); is not true after =
the unmapping.2
> >
> > if a mTHP is mapped only by one process, and we unmap it entirely, we w=
ill
> > get nr > 0, then we are executing adding it into deferred_list? so it s=
eems
> > atomic_read(mapped) is preventing this case from adding deferred_list?
>
> Yes, that is what this patch is doing. When a mTHP is mapped by one proce=
ss
> and later unmapped fully, there is no need to add it to deferred_list.
> The mTHP will be freed right afterwards.

thanks. I understand. i feel fixing up nr earlier can make the code
more readable.
 case RMAP_LEVEL_PTE:
..
+ if (!atomic_read(mapped))
+     nr =3D 0;
break;

as I have been struggling for a long time to understand the code, especiall=
y
the one with many conditions in the =E2=80=9Cif=E2=80=9D    :-)

+               if (folio_test_large(folio) && folio_test_anon(folio) &&
+                   list_empty(&folio->_deferred_list) &&
+                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped)) |=
|
+                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
+                       deferred_split_folio(folio);
        }

>
> >
> > I wonder if  it is possible to fixup nr to 0 from the first place?
> > for example
> > /* we are doing an entire unmapping */
> > if (page=3D=3D&folio->page && nr_pages =3D=3D  folio_nr_pages(folio))
> > ...
> >
> >>
> >>
> >> --
> >> Best Regards,
> >> Yan, Zi
>
>
> --
> Best Regards,
> Yan, Zi

