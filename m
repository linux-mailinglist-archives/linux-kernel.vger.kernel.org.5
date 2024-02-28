Return-Path: <linux-kernel+bounces-84330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6686A4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06CA1F230F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C11852;
	Wed, 28 Feb 2024 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bli5iBaD"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D122619
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083420; cv=none; b=bp2beJpSFoIdL3zdAgjZc4RlZdJiz8E4r0pRWzByDseof2zByMQ1uTe3f/U/9jIAPeXSFrVWPxsTAdKTUfpLDBmViINWndeA2PKrZfrH4L+TPWUYAEltE75+cJmozAq3Y3BLIqqdpa83h1iE3tNyypOCYmePRg3fDDtuZ2sDVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083420; c=relaxed/simple;
	bh=g52w9/5TYuX1hG+woI8mpHIaYYJEmuhhpoW8My3twkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mi1pfFbKjopSgKiorgmitXTm91ypfCUs2+raSvPO1pUI+cZP0Yw1NVM/lNf70gDYqz8YeS6VRgAOu1M7yxwfy5fjVAwwc82bDPW/JcB5y08jUsa8lctGYlnDiPknH0ptwMqh+RU8+A2pppBVNYEy7jwUob9QNJ0Ojykpq8CGhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bli5iBaD; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d147f87bb6so901077e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709083417; x=1709688217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY52hhOkWrTeKEaam0U/0mVI5iX9IF4eoJj+VESfF20=;
        b=Bli5iBaDrtd6hnnoVByjwvhM/VEykwR6sjekww+2OdFiexEJntB8b2GYiBBoUCc2ox
         q/Xs/geGztzy7nLR25LEkhF+fubpnD8w/47GlR/8zeWxEUJknTnGmiwUr+pZyMWqmKmu
         8iNPT4Vl+U/rzG3Q+cWG35LWil27xpEr7Xip4+R3DHnybMwD6ZbDHJYdNH78s1rGqfZS
         Xx4Xy7tRS9zsLhvyK5rW04yvvWOXwzEUyn2CTBqv9jU8crwIIoteFXSJ/YwL8JSoJJlz
         PW9D6RSp16Se0G0umaTtnDiey4AcjQJaMlojodWPDHIik7O9HZKW+gyWSrd01R+vUanw
         wY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083417; x=1709688217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QY52hhOkWrTeKEaam0U/0mVI5iX9IF4eoJj+VESfF20=;
        b=donBm9Q3bW2nPRWaCcsjUDfkczjCH85CLnhaCa6KNbTGr6sTWZK0UccbP3f0qDyxyr
         BnrczfIfM5jW4Ffg0ablz/oBOVo6TkmhEQqk3f/5BL48miUZ695kiakCXGLNUIVI/pKy
         rQMkt9EbiZ2hWG7KJinKsEJRhBDtEXLQGUql0kgJfsQUAAEuwdsmMJB8OYltVuOlJ6xP
         2039pVGmBqcRLXZENjIS7QhR11CPi27ISkSlhKBnszD1th4fyVgPGvWiY3nQPS1mHGDl
         nqoRhyQJnFAWh5x8x0ewYlrjUfYF4Q4Njd7Lq4IpclRRo1BkZREXT2luLGXIi2vIHM7C
         sLyg==
X-Forwarded-Encrypted: i=1; AJvYcCWvyw6AmS3V6es4G3Gby81OBPxT7/DCdNmR4kSN5g436ALInIZKCCCGipgnUS93eMwGjy2UoOskRjn0gt96f/b6slq8LqQhnBy8IKPp
X-Gm-Message-State: AOJu0Yyaymr7zGetfknE+kNDri29+4quwpTIremXXBLy5/oSNEdKuxc5
	r3ttdevIX1CeSzXo19Z1ABoODxnFYbP7Nin4NtiTYEf5GS7VZVL1UHl/za9z0o/oK+EtpcBdbfW
	MhPwrWcjb1M3sNy09Diu7qyAG3sM=
X-Google-Smtp-Source: AGHT+IGkATYCBvpBNYs60EvUtc722Cjcoy3ozBYbvmNMiNwWJe1HdmNLmXY6krlBKINsOBpP/0QzyAScHEsLOChfGw0=
X-Received: by 2002:a1f:c442:0:b0:4d3:3446:6bc7 with SMTP id
 u63-20020a1fc442000000b004d334466bc7mr2200639vkf.14.1709083416712; Tue, 27
 Feb 2024 17:23:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-5-ryan.roberts@arm.com> <20240222070544.133673-1-21cnbao@gmail.com>
 <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com> <CAGsJ_4zWU91J_71zVjKua-RTO4hDUJMkL7z_RP1GnYf3W1dNEA@mail.gmail.com>
 <a4a9054f-2040-4f70-8d10-a5af4972e5aa@arm.com>
In-Reply-To: <a4a9054f-2040-4f70-8d10-a5af4972e5aa@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 14:23:25 +1300
Message-ID: <CAGsJ_4zEKDVM==0KaFOb_UgO3GZ7ag2DW3sBLA-t9Tf0gAAnww@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org, 
	surenb@google.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 23/02/2024 09:46, Barry Song wrote:
> > On Thu, Feb 22, 2024 at 11:09=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 22.02.24 08:05, Barry Song wrote:
> >>> Hi Ryan,
> >>>
> >>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>> index 2cc0cb41fb32..ea19710aa4cd 100644
> >>>> --- a/mm/vmscan.c
> >>>> +++ b/mm/vmscan.c
> >>>> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct=
 list_head *folio_list,
> >>>>                                      if (!can_split_folio(folio, NUL=
L))
> >>>>                                              goto activate_locked;
> >>>>                                      /*
> >>>> -                                     * Split folios without a PMD m=
ap right
> >>>> -                                     * away. Chances are some or al=
l of the
> >>>> -                                     * tail pages can be freed with=
out IO.
> >>>> +                                     * Split PMD-mappable folios wi=
thout a
> >>>> +                                     * PMD map right away. Chances =
are some
> >>>> +                                     * or all of the tail pages can=
 be freed
> >>>> +                                     * without IO.
> >>>>                                       */
> >>>> -                                    if (!folio_entire_mapcount(foli=
o) &&
> >>>> +                                    if (folio_test_pmd_mappable(fol=
io) &&
> >>>> +                                        !folio_entire_mapcount(foli=
o) &&
> >>>>                                          split_folio_to_list(folio,
> >>>>                                                              folio_l=
ist))
> >>>>                                              goto activate_locked;
> >>>
> >>> I ran a test to investigate what would happen while reclaiming a part=
ially
> >>> unmapped large folio. for example, for 64KiB large folios, MADV_DONTN=
EED
> >>> 4KB~64KB, and keep the first subpage 0~4KiB.
> >>
> >> IOW, something that already happens with ordinary THP already IIRC.
> >>
> >>>
> >>> My test wants to address my three concerns,
> >>> a. whether we will have leak on swap slots
> >>> b. whether we will have redundant I/O
> >>> c. whether we will cause races on swapcache
> >>>
> >>> what i have done is printing folio->_nr_pages_mapped and dumping 16 s=
wap_map[]
> >>> at some specific stage
> >>> 1. just after add_to_swap   (swap slots are allocated)
> >>> 2. before and after try_to_unmap   (ptes are set to swap_entry)
> >>> 3. before and after pageout (also add printk in zram driver to dump a=
ll I/O write)
> >>> 4. before and after remove_mapping
> >>>
> >>> The below is the dumped info for a particular large folio,
> >>>
> >>> 1. after add_to_swap
> >>> [   27.267357] vmscan: After add_to_swap shrink_folio_list 1947 mapnr=
:1
> >>> [   27.267650] vmscan: offset:101b0 swp_map 40-40-40-40-40-40-40-40-4=
0-40-40-40-40-40-40-40
> >>>
> >>> as you can see,
> >>> _nr_pages_mapped is 1 and all 16 swap_map are SWAP_HAS_CACHE (0x40)
> >>>
> >>>
> >>> 2. before and after try_to_unmap
> >>> [   27.268067] vmscan: before try to unmap shrink_folio_list 1991 map=
nr:1
> >>> [   27.268372] try_to_unmap_one address:ffff731f0000 pte:e8000103cd0b=
43 pte_p:ffff0000c36a8f80
> >>> [   27.268854] vmscan: after try to unmap shrink_folio_list 1997 mapn=
r:0
> >>> [   27.269180] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-4=
0-40-40-40-40-40-40-40
> >>>
> >>> as you can see, one pte is set to swp_entry, and _nr_pages_mapped bec=
omes
> >>> 0 from 1. The 1st swp_map becomes 0x41, SWAP_HAS_CACHE + 1
> >>>
> >>> 3. before and after pageout
> >>> [   27.269602] vmscan: before pageout shrink_folio_list 2065 mapnr:0
> >>> [   27.269880] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-4=
0-40-40-40-40-40-40-40
> >>> [   27.270691] zram: zram_write_page page:fffffc00030f3400 index:101b=
0
> >>> [   27.271061] zram: zram_write_page page:fffffc00030f3440 index:101b=
1
> >>> [   27.271416] zram: zram_write_page page:fffffc00030f3480 index:101b=
2
> >>> [   27.271751] zram: zram_write_page page:fffffc00030f34c0 index:101b=
3
> >>> [   27.272046] zram: zram_write_page page:fffffc00030f3500 index:101b=
4
> >>> [   27.272384] zram: zram_write_page page:fffffc00030f3540 index:101b=
5
> >>> [   27.272746] zram: zram_write_page page:fffffc00030f3580 index:101b=
6
> >>> [   27.273042] zram: zram_write_page page:fffffc00030f35c0 index:101b=
7
> >>> [   27.273339] zram: zram_write_page page:fffffc00030f3600 index:101b=
8
> >>> [   27.273676] zram: zram_write_page page:fffffc00030f3640 index:101b=
9
> >>> [   27.274044] zram: zram_write_page page:fffffc00030f3680 index:101b=
a
> >>> [   27.274554] zram: zram_write_page page:fffffc00030f36c0 index:101b=
b
> >>> [   27.274870] zram: zram_write_page page:fffffc00030f3700 index:101b=
c
> >>> [   27.275166] zram: zram_write_page page:fffffc00030f3740 index:101b=
d
> >>> [   27.275463] zram: zram_write_page page:fffffc00030f3780 index:101b=
e
> >>> [   27.275760] zram: zram_write_page page:fffffc00030f37c0 index:101b=
f
> >>> [   27.276102] vmscan: after pageout and before needs_release shrink_=
folio_list 2124 mapnr:0
> >>>
> >>> as you can see, obviously, we have done redundant I/O - 16 zram_write=
_page though
> >>> 4~64KiB has been zap_pte_range before, we still write them to zRAM.
> >>>
> >>> 4. before and after remove_mapping
> >>> [   27.276428] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-4=
0-40-40-40-40-40-40-40
> >>> [   27.277485] vmscan: after remove_mapping shrink_folio_list 2169 ma=
pnr:0 offset:0
> >>> [   27.277802] vmscan: offset:101b0 01-00-00-00-00-00-00-00-00-00-00-=
00-00-00-00-00
> >>>
> >>> as you can see, swp_map 1-15 becomes 0 and only the first swp_map is =
1.
> >>> all SWAP_HAS_CACHE has been removed. This is perfect and there is no =
swap
> >>> slot leak at all!
> >>>
> >>> Thus, only two concerns are left for me,
> >>> 1. as we don't split anyway, we have done 15 unnecessary I/O if a lar=
ge folio
> >>> is partially unmapped.
>
> So the cost of this is increased IO and swap storage, correct? Is this a =
big
> problem in practice? i.e. do you see a lot of partially mapped large foli=
os in
> your workload? (I agree the proposed fix below is simple, so I think we s=
hould
> do it anyway - I'm just interested in the scale of the problem).
>
> >>> 2. large folio is added as a whole as a swapcache covering the range =
whose
> >>> part has been zapped. I am not quite sure if this will cause some pro=
blems
> >>> while some concurrent do_anon_page, swapin and swapout occurs between=
 3 and
> >>> 4 on zapped subpage1~subpage15. still struggling.. my brain is explod=
ing...
>
> Yes mine too. I would only expect the ptes that map the folio will get re=
placed
> with swap entries? So I would expect it to be safe. Although I understand=
 the
> concern with the extra swap consumption.

yes. it should still be safe. just more I/O and more swap spaces. but they =
will
be removed while remove_mapping happens if try_to_unmap_one makes
the folio unmapped.

but with the potential possibility even mapped PTEs can be skipped by
try_to_unmap_one (reported intermediate PTEs issue - PTL is held till
a valid PTE, some PTEs might be skipped by try_to_unmap without being
set to swap entries), we could have the possibility folio_mapped() is still=
 true
after try_to_unmap_one. so we can't get to __remove_mapping() for a long
time. but it still doesn't cause a crash.

>
> [...]
> >>>
> >>> To me, it seems safer to split or do some other similar optimization =
if we find a
> >>> large folio has partial map and unmap.
> >>
> >> I'm hoping that we can avoid any new direct users of _nr_pages_mapped =
if
> >> possible.
> >>
> >
> > Is _nr_pages_mapped < nr_pages a reasonable case to split as we
> > have known the folio has at least some subpages zapped?
>
> I'm not sure we need this - the folio's presence on the split list will t=
ell us
> everything we need to know I think?

I agree, this is just one question to David, not my proposal.  if
deferred_list is sufficient,
I prefer we use deferred_list.

I actually don't quite understand why David dislikes _nr_pages_mapped being=
 used
though I do think _nr_pages_mapped cannot precisely reflect how a
folio is mapped
by multi-processes. but _nr_pages_mapped < nr_pages seems be safe to
tell the folio
is partially unmapped :-)

>
> >
> >> If we find that the folio is on the deferred split list, we might as
> >> well just split it right away, before swapping it out. That might be a
> >> reasonable optimization for the case you describe.
>
> Yes, agreed. I think there is still chance of a race though; Some other t=
hread
> could be munmapping in parallel. But in that case, I think we just end up=
 with
> the increased IO and swap storage? That's not the end of the world if its=
 a
> corner case.

I agree. btw, do we need a spinlock ds_queue->split_queue_lock for checking
the list? deferred_split_folio(), for itself, has no spinlock while checkin=
g
 if (!list_empty(&folio->_deferred_list)), but why? the read and write
need to be exclusive.....

void deferred_split_folio(struct folio *folio)
{
        ...

        if (!list_empty(&folio->_deferred_list))
                return;

        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
        if (list_empty(&folio->_deferred_list)) {
                count_vm_event(THP_DEFERRED_SPLIT_PAGE);
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queu=
e);
                ds_queue->split_queue_len++;
#ifdef CONFIG_MEMCG
                if (memcg)
                        set_shrinker_bit(memcg, folio_nid(folio),
                                         deferred_split_shrinker->id);
#endif
        }
        spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
}

>
> >
> > i tried to change Ryan's code as below
> >
> > @@ -1905,11 +1922,12 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >                                          * PMD map right away. Chances =
are some
> >                                          * or all of the tail pages can=
 be freed
> >                                          * without IO.
> > +                                        * Similarly, split PTE-mapped =
folios if
> > +                                        * they have been already
> > deferred_split.
> >                                          */
> > -                                       if (folio_test_pmd_mappable(fol=
io) &&
> > -                                           !folio_entire_mapcount(foli=
o) &&
> > -                                           split_folio_to_list(folio,
> > -                                                               folio_l=
ist))
> > +                                       if
> > (((folio_test_pmd_mappable(folio) && !folio_entire_mapcount(folio)) ||
> > +
> > (!folio_test_pmd_mappable(folio) &&
> > !list_empty(&folio->_deferred_list)))
>
> I'm not sure we need the different tests for pmd_mappable vs !pmd_mappabl=
e. I
> think presence on the deferred list is a sufficient indicator that there =
are
> unmapped subpages?

I don't think there are fundamental differences for pmd and pte. i was
testing pte-mapped folio at that time, so kept the behavior of pmd as is.

>
> I'll incorporate this into my next version.

Great!

>
> > +                                           &&
> > split_folio_to_list(folio, folio_list))
> >                                                 goto activate_locked;
> >                                 }
> >                                 if (!add_to_swap(folio)) {
> >
> > It seems to work as expected. only one I/O is left for a large folio
> > with 16 PTEs
> > but 15 of them have been zapped before.
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
> >

Thanks
Barry

