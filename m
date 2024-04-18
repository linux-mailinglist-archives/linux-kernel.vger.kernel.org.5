Return-Path: <linux-kernel+bounces-150098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826548A9A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60101C20BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088315FA90;
	Thu, 18 Apr 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC2DyRWQ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29D1635CF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444511; cv=none; b=CbL8RZJeiRVU2GbDafX0QDg/6LHxp+TnPuru30g+2ODaD0jrIrkJy0MLAgj9YM+H6WD+15yipCrzXNUEt67zbveBOLrxttHYNKJ0X5s9eUJA4zjsE7u/zIGC1Zu0TWrzGMI5Pvik8cQ2n7ZLO3E1bUcbBq89PxJhJvlHFkuB7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444511; c=relaxed/simple;
	bh=EawJzvmVFDkSjWoTQgwRh/wSc7NEkuBedTulxOyczkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLDT4EemdKdon/KLfIbpPZKrhznLixFE6GQUNQcAO+RI7eBjoSbFRdHeXe4nNqkqC8yjadaDDPy88Shxjgqyc+2KPfCnktslIY/Zy1/XHG3LGbSpwG+uUZ/Y1r2jAi37fr7nqigKjRMVPKRYqqCrJk44p0o3stuLwPz19u9M7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC2DyRWQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a80b190bso43941566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713444504; x=1714049304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02DHgHC5hfvxUAH6RCZ0vfGGVyvpArmC7tKJv3DPOKA=;
        b=lC2DyRWQjrM1GT3dP24qqP8CvUDQ6EIoNdumwskbnpOpB40nVLDhbAewH+gQA6uVip
         zdGv1ErXIoB/LOej1ZIA1lhWFbyUBTwEhi1qPiCEJA/Bd9t9KiTigma3AAArnz1m3Wdt
         TpFI/svNAnZxhIV5fRQR49HBoYjHHB39XuJyVv4RZvzAf0yaxkvNnXFZGj+vsvui2OuR
         Di5POP3rLi7YK2oPELH6tn+EMfJCg+XJchE7y1l4lQlmE0k5tMrb19qVrTtQx+tm+8ia
         aMZeFdKcmFGItTA2Hjr/tZr1Icel0xUuVNuwK1g0iedXwm6CBIINYwOGLc7M2W+3nQRs
         hymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444504; x=1714049304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02DHgHC5hfvxUAH6RCZ0vfGGVyvpArmC7tKJv3DPOKA=;
        b=uO4qqyFtYC3V6QIBhsx0A691lnoHqRdVvGzuZDdYpMXonu7VM9nDpUv4igHYtd5IUa
         22WITrg7PyUFhmewGw46lD7iO0QnFBGeFVP4/4CHK21JlMrtvB5f6FHmcDntq7NgXeqs
         sI29XOtkj3aehGNFQ++nC+UEhOmxjFLUjcX+P/Bg/kKwRiz6OgtVwsvUpA8EUx22qUw0
         Vsb6jvvAPCB7yHDuFwktQgqM4b+4WZ29H5OACk4XTHCinASr1/ZwYYMEJsmPosdzax09
         a33yN5/jcOb/O++YsbBYk+5yPNG6kGg2+MkpHLJobVGQoFCJh/SnqInLP/JGwnBk1MJv
         vl4w==
X-Forwarded-Encrypted: i=1; AJvYcCVcJCse2z64FbJQfJ9nNHopUcHKgYMcpM7KiReJudRpQg7Tu69dxrCg7Iw5Ty5ywcxHWfPkmzlsvmcctkgWfEFvDCfx7QioenmmNXUy
X-Gm-Message-State: AOJu0Yxa1c85C2MIMiCDqC6wMYt3CvFUjla/uTSb2rBbXvMXNgcPGJnt
	uc40vLQ8opWyfQ6z4ovtypZtleMt7xT5kzUFbkqLD9SrLxh3bO1o5qJ1bk9v8LARr97W0u1w6lS
	apiinIc/BE5+1dIdKGTmXRCTqx50=
X-Google-Smtp-Source: AGHT+IHoVoQDLTTFoju5epQHkEGecXR+kc3MK/xg6dv/EKvUPfTp2gAwCrUPxZrHpUqrOoPa5KWSFyQ37OZCmN9Xs5o=
X-Received: by 2002:a50:9faa:0:b0:570:37d:badd with SMTP id
 c39-20020a509faa000000b00570037dbaddmr2194588edf.28.1713444504271; Thu, 18
 Apr 2024 05:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418105750.98866-1-ioworker0@gmail.com> <20240418105750.98866-5-ioworker0@gmail.com>
 <2fdcee93-b8ad-4374-a8ab-7c7bed463813@redhat.com> <CAK1f24m4y0kvmdFtHoJoPZeF9aeRpw4nnr1W5BMRz_OH49dHvg@mail.gmail.com>
 <89b534ab-ce9f-4a8a-984c-8460f686980d@redhat.com>
In-Reply-To: <89b534ab-ce9f-4a8a-984c-8460f686980d@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 20:48:12 +0800
Message-ID: <CAK1f24=8k9uG7yWB2R3a_xBOuNT8dg4GCRk5i=wpGGrCvLg+ow@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:44=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.04.24 14:33, Lance Yang wrote:
> > On Thu, Apr 18, 2024 at 8:03=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 18.04.24 12:57, Lance Yang wrote:
> >>> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> >>> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> >>> splitting if the large folio is fully mapped within the target range.
> >>>
> >>> If a large folio is locked or shared, or if we fail to split it, we j=
ust
> >>> leave it in place and advance to the next PTE in the range. But note =
that
> >>> the behavior is changed; previously, any failure of this sort would c=
ause
> >>> the entire operation to give up. As large folios become more common,
> >>> sticking to the old way could result in wasted opportunities.
> >>>
> >>> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folio=
s of
> >>> the same size results in the following runtimes for madvise(MADV_FREE=
) in
> >>> seconds (shorter is better):
> >>>
> >>> Folio Size |   Old    |   New    | Change
> >>> ------------------------------------------
> >>>         4KiB | 0.590251 | 0.590259 |    0%
> >>>        16KiB | 2.990447 | 0.185655 |  -94%
> >>>        32KiB | 2.547831 | 0.104870 |  -95%
> >>>        64KiB | 2.457796 | 0.052812 |  -97%
> >>>       128KiB | 2.281034 | 0.032777 |  -99%
> >>>       256KiB | 2.230387 | 0.017496 |  -99%
> >>>       512KiB | 2.189106 | 0.010781 |  -99%
> >>>      1024KiB | 2.183949 | 0.007753 |  -99%
> >>>      2048KiB | 0.002799 | 0.002804 |    0%
> >>>
> >>> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@a=
rm.com
> >>> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@re=
dhat.com
> >>>
> >>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>> ---
> >>>    mm/madvise.c | 85 +++++++++++++++++++++++++++---------------------=
----
> >>>    1 file changed, 44 insertions(+), 41 deletions(-)
> >>>
> >>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>> index 4597a3568e7e..375ab3234603 100644
> >>> --- a/mm/madvise.c
> >>> +++ b/mm/madvise.c
> >>> @@ -643,6 +643,7 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >>>                                unsigned long end, struct mm_walk *wal=
k)
> >>>
> >>>    {
> >>> +     const cydp_t cydp_flags =3D CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY=
;
> >>>        struct mmu_gather *tlb =3D walk->private;
> >>>        struct mm_struct *mm =3D tlb->mm;
> >>>        struct vm_area_struct *vma =3D walk->vma;
> >>> @@ -697,44 +698,57 @@ static int madvise_free_pte_range(pmd_t *pmd, u=
nsigned long addr,
> >>>                        continue;
> >>>
> >>>                /*
> >>> -              * If pmd isn't transhuge but the folio is large and
> >>> -              * is owned by only this process, split it and
> >>> -              * deactivate all pages.
> >>> +              * If we encounter a large folio, only split it if it i=
s not
> >>> +              * fully mapped within the range we are operating on. O=
therwise
> >>> +              * leave it as is so that it can be marked as lazyfree.=
 If we
> >>> +              * fail to split a folio, leave it in place and advance=
 to the
> >>> +              * next pte in the range.
> >>>                 */
> >>>                if (folio_test_large(folio)) {
> >>> -                     int err;
> >>> +                     bool any_young, any_dirty;
> >>>
> >>> -                     if (folio_likely_mapped_shared(folio))
> >>> -                             break;
> >>> -                     if (!folio_trylock(folio))
> >>> -                             break;
> >>> -                     folio_get(folio);
> >>> -                     arch_leave_lazy_mmu_mode();
> >>> -                     pte_unmap_unlock(start_pte, ptl);
> >>> -                     start_pte =3D NULL;
> >>> -                     err =3D split_folio(folio);
> >>> -                     folio_unlock(folio);
> >>> -                     folio_put(folio);
> >>> -                     if (err)
> >>> -                             break;
> >>> -                     start_pte =3D pte =3D
> >>> -                             pte_offset_map_lock(mm, pmd, addr, &ptl=
);
> >>> -                     if (!start_pte)
> >>> -                             break;
> >>> -                     arch_enter_lazy_mmu_mode();
> >>> -                     pte--;
> >>> -                     addr -=3D PAGE_SIZE;
> >>> -                     continue;
> >>> +                     nr =3D madvise_folio_pte_batch(addr, end, folio=
, pte,
> >>> +                                                  ptent, &any_young,=
 NULL);
> >>> +
> >>> +                     if (nr < folio_nr_pages(folio)) {
> >>> +                             int err;
> >>> +
> >>> +                             if (folio_likely_mapped_shared(folio))
> >>> +                                     continue;
> >>> +                             if (!folio_trylock(folio))
> >>> +                                     continue;
> >>> +                             folio_get(folio);
> >>> +                             arch_leave_lazy_mmu_mode();
> >>> +                             pte_unmap_unlock(start_pte, ptl);
> >>> +                             start_pte =3D NULL;
> >>> +                             err =3D split_folio(folio);
> >>> +                             folio_unlock(folio);
> >>> +                             folio_put(folio);
> >>> +                             start_pte =3D pte =3D
> >>> +                                     pte_offset_map_lock(mm, pmd, ad=
dr, &ptl);
> >>
> >> I'd just put it on a single line.
> >
> > start_pte =3D pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
> >
> > I suddenly realized that putting it on a single line would exceed the
> > 80-char limit.
>
> Which is fine according to Documentation/process/coding-style.rst
>
> ... as long as it aids readability.
>
> Alternatively, the following might do:
>
> pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
> start_pte =3D pte;

Yep, I understood.

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

