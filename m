Return-Path: <linux-kernel+bounces-5558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA0818C37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E38B226BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD801F94C;
	Tue, 19 Dec 2023 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uU7BX3KM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75A1DDD4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e4637853so81285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703003372; x=1703608172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mixo7iUxV6o/jYjn2ndFmri3aSLyepPelmkXRCU4Bdk=;
        b=uU7BX3KMzBmPMtiszDpOKOiY6y6T3k9MWpcvr5eeWL9GVxKE24s9xiCEOlWg9C3T2c
         n29me1uU10d3jr6kcGPvkBRkRdSkuY1ckIDJLFFdXJ5QwpGPSNpbzoLk5UR48yQelGWw
         H9JWFf4xLFbTaFZ2Eq/e8juN1RqQpNPjBp73Kry36rREtokSWvbo8Dv23c3oJev5EWH4
         OgOnYLvEWllFzIfuVMvITwGBm9gZpxSN9bWDsscWEMgV7O0u6v2RS0WERk9aFdKap44W
         hTeBbfDS9FDTTqncGeood+ZXa2+lZOPOTrv8jPRflzWxr1qUCtHVdCLjZnkqkFRwRn+M
         /eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003372; x=1703608172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mixo7iUxV6o/jYjn2ndFmri3aSLyepPelmkXRCU4Bdk=;
        b=KXLjLJVsLWuT01iplxXROvyA3r0hsxEwpObWIfYG/a8gUjepGQyublMM3vJvgTCD2w
         qvDvFyVudr0BRZofTCzkjkU0oQNZGWB8QfW1LW4vSp9g08Mu4orV5aXo/9LsgJBk41fn
         62iF0Gp/Ee3baJNJxaEHZssrst+lD6LusvlLZCRzRa8XGKoVyMDLDyeV/O4a+YYLoGkF
         DISiSIsCM7yVV15XnTVGXqeWyAqPE6Wib5PHz6FyWoSvw/Qm/T1CuQGwI+B6jTCDAJUi
         osqH5neLL1FyPFZX7DCr9VFZNlmSZLS7QUflvwhdB6fssRmBtCJzfMRoZ5RTPPo5s1h/
         aRHQ==
X-Gm-Message-State: AOJu0YzU9+lOodXmp6jzobdY3gNvBsfwYde05Dv4VRIciowIodFGKT4B
	Yif3NoYXigJs0kL7zE/xRUNwWZltUKYLgt+IxKuivAjB8bbw
X-Google-Smtp-Source: AGHT+IHsUCKcb2E2CdUkTme7eOaB4IQH5pN/t3v8iJPHV1wyflbtqaQHKC/n6HfeqRwG5WgkpoxHQLlIZyM4Gm88XNg=
X-Received: by 2002:a17:902:e5cc:b0:1d3:7db1:388b with SMTP id
 u12-20020a170902e5cc00b001d37db1388bmr204446plf.11.1703003371391; Tue, 19 Dec
 2023 08:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219075538.414708-1-peterx@redhat.com> <20231219075538.414708-10-peterx@redhat.com>
In-Reply-To: <20231219075538.414708-10-peterx@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 19 Dec 2023 11:28:54 -0500
Message-ID: <CADrL8HVu8=-DdAwXN_pO91g1A1+F7bKfBRpm6jYfYMk1QZcRFA@mail.gmail.com>
Subject: Re: [PATCH 09/13] mm/gup: Cache *pudp in follow_pud_mask()
To: peterx@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Jones <andrew.jones@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Kirill A . Shutemov" <kirill@shutemov.name>, linuxppc-dev@lists.ozlabs.org, 
	Rik van Riel <riel@surriel.com>, linux-riscv@lists.infradead.org, 
	Yang Shi <shy828301@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:57=E2=80=AFAM <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> Introduce "pud_t pud" in the function, so the code won't dereference *pud=
p
> multiple time.  Not only because that looks less straightforward, but als=
o
> because if the dereference really happened, it's not clear whether there
> can be race to see different *pudp values if it's being modified at the
> same time.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 6c0d82fa8cc7..97e87b7a15c3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -753,26 +753,27 @@ static struct page *follow_pud_mask(struct vm_area_=
struct *vma,
>                                     unsigned int flags,
>                                     struct follow_page_context *ctx)
>  {
> -       pud_t *pud;
> +       pud_t *pudp, pud;
>         spinlock_t *ptl;
>         struct page *page;
>         struct mm_struct *mm =3D vma->vm_mm;
>
> -       pud =3D pud_offset(p4dp, address);
> -       if (pud_none(*pud))
> +       pudp =3D pud_offset(p4dp, address);
> +       pud =3D *pudp;

I think you might want a READ_ONCE() on this so that the compiler
doesn't actually read the pud multiple times.

> +       if (pud_none(pud))
>                 return no_page_table(vma, flags, address);
> -       if (pud_devmap(*pud)) {
> -               ptl =3D pud_lock(mm, pud);
> -               page =3D follow_devmap_pud(vma, address, pud, flags, &ctx=
->pgmap);
> +       if (pud_devmap(pud)) {
> +               ptl =3D pud_lock(mm, pudp);
> +               page =3D follow_devmap_pud(vma, address, pudp, flags, &ct=
x->pgmap);
>                 spin_unlock(ptl);
>                 if (page)
>                         return page;
>                 return no_page_table(vma, flags, address);
>         }
> -       if (unlikely(pud_bad(*pud)))
> +       if (unlikely(pud_bad(pud)))
>                 return no_page_table(vma, flags, address);

Not your change, but reading this, it's not clear to me that
`pud_present(*pudp)` (and non-leaf) would necessarily be true at this
point -- like, I would prefer to see `!pud_present(pud)` instead of
`pud_bad()`. Thank you for adding that in the next patch. :)

Feel free to add:

Acked-by: James Houghton <jthoughton@google.com>

