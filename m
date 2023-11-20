Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31D7F11C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjKTLTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjKTLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:18:42 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DF19A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:17:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso55427541fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700479051; x=1701083851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDZoUdX4vDe/9rtS1iTlpRn5rfopwSjoTNNEwdu9Oa4=;
        b=HGRntJYexibDQfZOY152dHp4oZvuKHrc+tKc5B4eveRqitiRlA31TP20nco15u23QV
         Xtoc2Df14VD0UOPyM1liDrj3L1IORtqZTIN+iqiVLoVcjOvIU0jJqaN/nid9N2aa8uY1
         Otmd6dpejGQJrvaR9D3Q5VY+b+DdO9pV+14EHW4pUdCi/FgxRsfr4Iw+R4BZZZi/VfgB
         h6z/AFWo6dvFu7eDzuHfuas/11AUrW6JtrQS9V+v/Sao3cjcvq9hWdBWdMgF4I7sx0y1
         ZqoezJNkve2VLfuo8HsVEcVdHY+PmNgV4bjED1skkZx68x2KVhpbFvnJUprirgHSBBmq
         kegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479051; x=1701083851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDZoUdX4vDe/9rtS1iTlpRn5rfopwSjoTNNEwdu9Oa4=;
        b=Ih2evFtATpIn4BiyaHZivgl6EPsijDLQ6dcHAkAoU7amCcRXd9QSZSlox2DXdlqPNy
         iypOOiHvmVee+CkhHg3+iqR73/5zRMMe0rhgufoc2S+YrB/cEOHsQFO3T69yLMLQNQuv
         k+DByWTIDYx/JNSYENb9IZBo2072pRO4FYVGGhoRyp984UPVELw3WrYs4x6dIiYRr3Mt
         EVGqDrbjzP02JCbTOXmq28ZVxla7755tK1YpEIkz5cMl2Nj1+3q3EymGO8Lbmyx1/wML
         bkTkRVRGADBebVKaF8zjteKGLt4NDg/NozfgMO8/F+WELmBp4wvV2FYMX2XcAid1mpfA
         mthQ==
X-Gm-Message-State: AOJu0YzKtPqdBXxoAIbYF0CXI1DpPZZ4gNd4twBGnpMGADLiepDKwLS4
        9rtTmHJhBJtMylsJw9ZWeoDIveg4SybS499MwYo=
X-Google-Smtp-Source: AGHT+IHomPjWkWUdW5xd/cNQ6emVfgNli8c6njptdxJJ5v8+119fycBeIFgjYKG04P59AlH3kkql6ZJE7+P6ZnnP7Y0=
X-Received: by 2002:a05:651c:200b:b0:2c8:742a:5a66 with SMTP id
 s11-20020a05651c200b00b002c8742a5a66mr4567531ljo.48.1700479050776; Mon, 20
 Nov 2023 03:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-9-ryncsn@gmail.com>
 <87r0klarjp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87r0klarjp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:17:12 +0800
Message-ID: <CAMgjq7DX30BpNR4kFPUMRat37F11rpnmb8ia2RetAaf7oZbE+g@mail.gmail.com>
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 14:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently VMA readahead is globally disabled when any rotate disk is
> > used as swap backend. So multiple swap devices are enabled, if a slower
> > hard disk is set as a low priority fallback, and a high performance SSD
> > is used and high priority swap device, vma readahead is disabled global=
ly.
> > The SSD swap device performance will drop by a lot.
> >
> > Check readahead policy per entry to avoid such problem.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index ff6756f2e8e4..fb78f7f18ed7 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -321,9 +321,9 @@ static inline bool swap_use_no_readahead(struct swa=
p_info_struct *si, swp_entry_
> >       return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(=
entry) =3D=3D 1;
> >  }
> >
> > -static inline bool swap_use_vma_readahead(void)
> > +static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
> >  {
> > -     return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate=
_swap);
> > +     return data_race(si->flags & SWP_SOLIDSTATE) && READ_ONCE(enable_=
vma_readahead);
> >  }
> >
> >  /*
> > @@ -341,7 +341,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entr=
y,
> >
> >       folio =3D filemap_get_folio(swap_address_space(entry), swp_offset=
(entry));
> >       if (!IS_ERR(folio)) {
> > -             bool vma_ra =3D swap_use_vma_readahead();
> > +             bool vma_ra =3D swap_use_vma_readahead(swp_swap_info(entr=
y));
> >               bool readahead;
> >
> >               /*
> > @@ -920,16 +920,18 @@ static struct page *swapin_no_readahead(swp_entry=
_t entry, gfp_t gfp_mask,
> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> >                             struct vm_fault *vmf, bool *swapcached)
> >  {
> > +     struct swap_info_struct *si;
> >       struct mempolicy *mpol;
> >       struct page *page;
> >       pgoff_t ilx;
> >       bool cached;
> >
> > +     si =3D swp_swap_info(entry);
> >       mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> > -     if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> > +     if (swap_use_no_readahead(si, entry)) {
> >               page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
vmf->vma->vm_mm);
> >               cached =3D false;
> > -     } else if (swap_use_vma_readahead()) {
> > +     } else if (swap_use_vma_readahead(si)) {
>
> It's possible that some pages are swapped out to SSD while others are
> swapped out to HDD in a readahead window.
>
> I suspect that there are practical requirements to use swap on SSD and
> HDD at the same time.

Hi Ying,

Thanks for the review!

For the first issue "fragmented readahead window", I was planning to
do an extra check in readahead path to skip readahead entries that are
on different swap devices, which is not hard to do, but this series is
growing too long so I thought it will be better done later.

For the second issue, "is there any practical use for multiple swap",
I think actually there are. For example we are trying to use multi
layer swap for offloading memory of different hotness on servers. And
we also tried to implement a mechanism to migrate long sleep swap
entries from high performance SSD/RAMDISK swap to cheap HDD swap
device, with more than two layers of swap, which worked except the
upstream issue, that readahead policy will no longer work as expected.


>
> >               page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, v=
mf);
> >               cached =3D true;
> >       } else {
>
> --
> Best Regards,
> Huang, Ying
