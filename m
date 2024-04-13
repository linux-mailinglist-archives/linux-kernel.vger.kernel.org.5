Return-Path: <linux-kernel+bounces-143460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6D8A3971
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69E11F22850
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3074C97;
	Sat, 13 Apr 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j91zbUdJ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C9442C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969472; cv=none; b=jfwIlF+clWTCifjNQvGFfhl+Nc8A4jSgH2RRWXYlEmTTh3OcnZC1vABiLBCaG7n4CEJwL3ZkHuNwnEOC3rzbg4wpGX3QQ/1GsYkMWA9SfYK77lIaCwfjC4VnqkMfR9BM2Qw9cpEOXIAyoHpI6dEBLWg2FiJczYGxEfHtGZGWFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969472; c=relaxed/simple;
	bh=sX7WsVGNnSSRzcMcuJsLiMsgkSJor1iYlOzzqNwqPH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GisfUfZDrsfKf74PI7e1mvrJ5KxrU+3GXoX4Dxo57sAldB5HiKzQmPe/SPuVRCczADzRSn82MrLeXccKl6AeUm7UBrT6EUqSK7b2Smq26OrRxMQyXCl5Vp49wRtLMEgUSZDMINA2nxL9Fb+/k00bq1gWlSkMu7UgT9RqUwEh3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j91zbUdJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso1575478a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712969469; x=1713574269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbYS3aC9uGvkjYk6/cLeqdOFTEci2uZlTd3WzZKqoXw=;
        b=j91zbUdJXb/XDwDlj4j7nPDeyolCFPoUS0aGgZrNsEaDjJUzg4gn6SGflQs/wnOob4
         m6BwZATik3I6Xa0h+/aXcxlDUXWWPD0/AQ/+1+wcgfMFzNWd2Cd0TLRaNpzOPYQ7jccu
         BzIlqPh0V0LfbnZ1fp/jDiLTTKHJW01BhzBHTHZ/wKYkheOL7gdT8PAOFD/gvtGbpe8p
         8gttQOIWZc0DVXV0f+Lwn0E7EdMpQYzgPF4zEaXxRBqvMXniJzp7RJCqqsjRRyhm8UOs
         YFYiEjW/OCzA/wYdlH0iqwW+Y4uvHwcJwEd19BHsub1MSNfBCy++ZHfOA/SRiZhZU8Pu
         IuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712969469; x=1713574269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbYS3aC9uGvkjYk6/cLeqdOFTEci2uZlTd3WzZKqoXw=;
        b=i4qZWbJUTqnfdNKpIZufH/ZwlwfEI6Cm9/Wknrm/xDdnEyinF94dMOrZjAsw8ROMYe
         HXkyK9zscrksuUZAmEPbGgYdCA2FsR2E/cvY+GIBDvufLWs8QZM7qYIRuQk2aagp3edl
         uNRzNo+VnmSham32IE8/Dtmr0CckxGXjnPKIsQWPlPwGkJWH00QOdxTm43l54TnCvqH3
         PJLtFkfuVc9OxedjzgXrv1NM1OBX51qv3xiqA05G27jEbKU5cYs1hw+hk9sdqCq8mBNH
         innClb12inI5uUMAnTHyz2S2sgf79/z2yG1YR/TFtfX9D8yC/fIg6O51WXBEKPVhiobm
         BYYw==
X-Forwarded-Encrypted: i=1; AJvYcCWD0ObfBRGgT5K6uBhZCYmcEeQVpPUDO2mPrcE749hPdjJcVmw70D+udHksjBT7fRhAJUEXxIbKCQghONXIQ+g0xYW+VMbDVJm7x8BP
X-Gm-Message-State: AOJu0YwrHFgIjAJLwjlHwyPSzNR6o0UdWZXRJoTFHf/3ocY5aJeU8oit
	wGTjOohnreTzMjj/skBL8WF+qEogw44B6IuaxCVnoVduDyn+tdQhwH2K8tG9D/1RsGZTtNXCb+9
	uXkjcBgseDaiPwGlXLc2U8ONSNf97Gg==
X-Google-Smtp-Source: AGHT+IFK+kfekIP4WtA4fPXnB2LXRkQRlXC+1IOk8rSIah8aqbpb9YgJ0njZnDg9FhY2WCvVs8umWiOrLp+Hvq6ZvMM=
X-Received: by 2002:a17:907:972a:b0:a51:827d:c99b with SMTP id
 jg42-20020a170907972a00b00a51827dc99bmr3143961ejc.14.1712969468567; Fri, 12
 Apr 2024 17:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com> <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com> <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
 <2BE605BB-F474-48E3-A54F-1E9371BF59E5@nvidia.com>
In-Reply-To: <2BE605BB-F474-48E3-A54F-1E9371BF59E5@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 12 Apr 2024 17:50:56 -0700
Message-ID: <CAHbLzkpKBzRUv+QVwsfSxMw7kuSkZhyYo9yjWS5x28fk8j_hRA@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:59=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 12 Apr 2024, at 18:29, Yang Shi wrote:
>
> > On Fri, Apr 12, 2024 at 2:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 12 Apr 2024, at 15:32, David Hildenbrand wrote:
> >>
> >>> On 12.04.24 16:35, Zi Yan wrote:
> >>>> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
> >>>>
> >>>>> On 11.04.24 17:32, Zi Yan wrote:
> >>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>
> >>>>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
> >>>>>> if any page in a folio loses its final mapping. It is possible tha=
t
> >>>>>> the folio is unmapped fully, but it is unnecessary to add the foli=
o
> >>>>>> to deferred split list at all. Fix it by checking folio mapcount b=
efore
> >>>>>> adding a folio to deferred split list.
> >>>>>>
> >>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>> ---
> >>>>>>    mm/rmap.c | 9 ++++++---
> >>>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>> index 2608c40dffad..d599a772e282 100644
> >>>>>> --- a/mm/rmap.c
> >>>>>> +++ b/mm/rmap.c
> >>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                    enum rmap_level level)
> >>>>>>    {
> >>>>>>            atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>>>>> -  int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>>>>> +  int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>>>>            enum node_stat_item idx;
> >>>>>>            __folio_rmap_sanity_checks(folio, page, nr_pages, level=
);
> >>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                            break;
> >>>>>>                    }
> >>>>>>   -                atomic_sub(nr_pages, &folio->_large_mapcount);
> >>>>>> +          mapcount =3D atomic_sub_return(nr_pages,
> >>>>>> +                                       &folio->_large_mapcount) +=
 1;
> >>>>>
> >>>>> That becomes a new memory barrier on some archs. Rather just re-rea=
d it below. Re-reading should be fine here.
> >>>>
> >>>> Would atomic_sub_return_relaxed() work? Originally I was using atomi=
c_read(mapped)
> >>>> below, but to save an atomic op, I chose to read mapcount here.
> >>>
> >>> Some points:
> >>>
> >>> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
> >>> RMW that return a value -- and how they interact with memory barriers=
.
> >>> Further, how relaxed variants are only optimized on some architecture=
s.
> >>>
> >>> atomic_read() is usually READ_ONCE(), which is just an "ordinary" mem=
ory
> >>> access that should not be refetched. Usually cheaper than most other =
stuff
> >>> that involves atomics.
> >>
> >> I should have checked the actual implementation instead of being foole=
d
> >> by the name. Will read about it. Thanks.
> >>
> >>>
> >>> (2) We can either use folio_large_mapcount() =3D=3D 0 or !atomic_read=
(mapped)
> >>> to figure out if the folio is now completely unmapped.
> >>>
> >>> (3) There is one fundamental issue: if we are not batch-unmapping the=
 whole
> >>> thing, we will still add the folios to the deferred split queue. Migr=
ation
> >>> would still do that, or if there are multiple VMAs covering a folio.
> >>>
> >>> (4) We should really avoid making common operations slower only to ma=
ke
> >>> some unreliable stats less unreliable.
> >>>
> >>>
> >>> We should likely do something like the following, which might even be=
 a bit
> >>> faster in some cases because we avoid a function call in case we unma=
p
> >>> individual PTEs by checking _deferred_list ahead of time
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 2608c40dffad..356598b3dc3c 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
> >>>                  * page of the folio is unmapped and at least one pag=
e
> >>>                  * is still mapped.
> >>>                  */
> >>> -               if (folio_test_large(folio) && folio_test_anon(folio)=
)
> >>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pm=
dmapped)
> >>> -                               deferred_split_folio(folio);
> >>> +               if (folio_test_large(folio) && folio_test_anon(folio)=
 &&
> >>> +                   (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped=
) &&
> >>> +                   atomic_read(mapped) &&
> >>> +                   data_race(list_empty(&folio->_deferred_list)))
> >>
> >> data_race() might not be needed, as Ryan pointed out[1]
> >>
> >>> +                       deferred_split_folio(folio);
> >>>         }
> >>>
> >>> I also thought about handling the scenario where we unmap the whole
> >>> think in smaller chunks. We could detect "!atomic_read(mapped)" and
> >>> detect that it is on the deferred split list, and simply remove it
> >>> from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
> >>>
> >>> But it would be racy with concurrent remapping of the folio (might ha=
ppen with
> >>> anon folios in corner cases I guess).
> >>>
> >>> What we can do is the following, though:
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index dc30139590e6..f05cba1807f2 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *f=
olio)
> >>>         ds_queue =3D get_deferred_split_queue(folio);
> >>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >>>         if (!list_empty(&folio->_deferred_list)) {
> >>> +               if (folio_test_pmd_mappable(folio))
> >>> +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
> >>>                 ds_queue->split_queue_len--;
> >>>                 list_del_init(&folio->_deferred_list);
> >>>         }
> >>>
> >>> Adding the right event of course.
> >>>
> >>>
> >>> Then it's easy to filter out these "temporarily added to the list, bu=
t never split
> >>> before the folio was freed" cases.
> >>
> >> So instead of making THP_DEFERRED_SPLIT_PAGE precise, use
> >> THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE instead? That s=
hould work.
> >
> > It is definitely possible that the THP on the deferred split queue are
> > freed instead of split. For example, 1M is unmapped for a 2M THP, then
> > later the remaining 1M is unmapped, or the process exits before memory
> > pressure happens. So how come we can tell it is "temporarily added to
> > list"? Then THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE
> > actually just counts how many pages are still on deferred split queue.
> > It may be useful. However the counter is typically used to estimate
> > how many THP are partially unmapped during a period of time. So we
> > just need to know the initial value and the value when we read it
> > again.
> >
> >>
> >> I wonder what THP_DEFERRED_SPLIT_PAGE counts. If it counts THP deferre=
d
> >> splits, why not just move the counter to deferred_split_scan(), where =
the actual
> >> split happens. Or the counter has a different meaning?
> >
> > The deferred_split_scan() / deferred_split_count() just can return the
> > number of pages on a specific queue (a specific node with a specific
> > memcg). But THP_DEFERRED_SPLIT_PAGE is a global counter. Did I miss
> > something? Or you mean traverse all memcgs and all nodes? It sounds
> > too overkilling.
>
> I mean instead of increasing THP_DEFERRED_SPLIT_PAGE when a folio is adde=
d
> to the split list, increase it when a folio is split in deferred_split_sc=
an(),
> regardless which list the folio is on.

It will have overlap with thp_split_page. And what if memory pressure
doesn't happen? The counter will be 0 even though thousands THP have
been partially unmapped.

>
> --
> Best Regards,
> Yan, Zi

