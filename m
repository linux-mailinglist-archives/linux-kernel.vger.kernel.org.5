Return-Path: <linux-kernel+bounces-48818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EC846200
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9383B22577
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6829403;
	Thu,  1 Feb 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L49oVJEB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1031733986
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819880; cv=none; b=XXzuT7i2GNRc5/gCy6Wwub/tR2tbHQHBs3A+kLKHj9xz8p616mWyQTNXdXo5xLkaUEt/BgR/nCzgsQdwkLh0FxXQQ3Wwe0+c1vMS9i8IL/G9xQTVuIoXBXKGMRsbvlOCuFpFI8xdteM9KBGNJVq4vAt+oKucxNHVYzJoeo+sXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819880; c=relaxed/simple;
	bh=K8EvmUOXnREfVGggbngxVZ2IfmnroNsFbo76Tx4cDWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2j9jLxOlXueYZlOqGA93fLjOHRXue6jk+LuRi0tq0i6Se9d5QkUbjljtL45BhBOWQ6DrQdhmvgjUIPB1bqkBFy1W85r4xMHuov5Btg1dYYisaUX80cV7CY/8Ih2ToEI44r+s4IU5eXvH++TvlDF6pX9/n1jYX8H88615yA/qXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L49oVJEB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddb129350cso984695b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706819878; x=1707424678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVQAdkYwWaZIRq7f/GgaZUQN4RdS31peSm7+ApO0u8M=;
        b=L49oVJEBuvm23FxU5qMBpOM1y5FyjQYd2D8MITLjWMEZWfpDH4r2AGYj0FUt1mKFik
         GoHTuAwXeig4svVygHkq7Jr2zXkKjDi5yxfG/cMXd5ZTzfmg/aFiXT0HnXLqAbukTpPP
         rY8zZ5eeP+K3PvIBUjollgjCTJoaKzb7GFBuDpCXvHhk15WRzl16KkhcKr8pfZCNEdTn
         R+JKzKcZiwYdzBjTobvFopYIMBFh+Nh2rUt/dl7oif7mwjFmqMBBvaCDQ6mYq162rPCX
         pTOgD44wwoWE5LnOrrnSTH+pgSG2oH5deZcGNewolQGxBY7IR9357NbaGW1Xm0WbaNEO
         pSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819878; x=1707424678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVQAdkYwWaZIRq7f/GgaZUQN4RdS31peSm7+ApO0u8M=;
        b=Q+r+HJI2KPLYGOJjs0MAPR0O1uOTzDxyegUScGBZltdsneIRIQiP/U6IkWFfDsq29J
         h1fUbjRLwyKkPusI7TXAFnAyxZsm1uKlIAn8jKxIBQJxEGBXLEFETFd5541v3b1dk/tV
         vyaU9/qQUNFdrygfG8LeXt7Cgrvqdrs0ScucZJKPfyjtDj/cIv3SK3VDCP1P4SH1pqfq
         6Ieos7s+B7Xy+wsa/IMgyoJaUGhwEUx49qwuVJcU84QdrhpWOZ6YWX8Pf3cqzfJT4JXb
         RMaHFfjDJe4MfXR4CQAhc1NBDdIqI2fR+Z1XR6GTUolBYsnbId5VaCIr51toAYZqaU6D
         /C8g==
X-Gm-Message-State: AOJu0YxzAkjg9XYuWTWPeskbG5bZWmx9Z1+KW0/2dAkB4+h74KnseluM
	TB97RVYjLfYxpml8hDWtPnGFz7LYJR2aIo7tpJpW4BY9Ta/9GmaghRJdH3C4NoNrywH+a+ux+Yf
	jikElGg4iLNWMg29Ak0rMj6wSUWyoUODr
X-Google-Smtp-Source: AGHT+IF2her2WRCa1VTjbbFWF6VH0KNfeEIpm6T5opSnPGtCDL4vQI27qXy7/VJZsuPDwrbshxFkE6GSqjlWGvz7ey0=
X-Received: by 2002:a05:6a00:ccb:b0:6df:e229:8f16 with SMTP id
 b11-20020a056a000ccb00b006dfe2298f16mr5802679pfv.17.1706819878240; Thu, 01
 Feb 2024 12:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com>
In-Reply-To: <20240201125226.28372-1-ioworker0@gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 1 Feb 2024 12:37:45 -0800
Message-ID: <CAHbLzkqUyYy67Fp6Zv2oeGyawHZuHqkiDGruivcRMcCGj6a-_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> The collapsing behavior of khugepaged with pages
> marked using MADV_FREE might cause confusion
> among users.
>
> For instance, allocate a 2MB chunk using mmap and
> later release it by MADV_FREE. Khugepaged will not
> collapse this chunk. From the user's perspective,
> it treats lazyfree pages as pte_none. However,
> for some pages marked as lazyfree with MADV_FREE,
> khugepaged might collapse this chunk and copy
> these pages to a new huge page. This inconsistency
> in behavior could be confusing for users.
>
> After a successful MADV_FREE operation, if there is
> no subsequent write, the kernel can free the pages
> at any time. Therefore, in my opinion, counting
> lazyfree pages in max_pte_none seems reasonable.
>
> Perhaps treating MADV_FREE like MADV_DONTNEED, not
> copying lazyfree pages when khugepaged collapses
> huge pages in the background better aligns with
> user expectations.
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/khugepaged.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..6cbf46d42c6a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -777,6 +777,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
>                                      pmd_t orig_pmd,
>                                      struct vm_area_struct *vma,
>                                      unsigned long address,
> +                                    struct collapse_control *cc,
>                                      spinlock_t *ptl,
>                                      struct list_head *compound_pagelist)
>  {
> @@ -797,6 +798,13 @@ static int __collapse_huge_page_copy(pte_t *pte,
>                         continue;
>                 }
>                 src_page =3D pte_page(pteval);
> +
> +               if (cc->is_khugepaged
> +                               && !folio_test_swapbacked(page_folio(src_=
page))) {
> +                       clear_user_highpage(page, _address);
> +                       continue;

If the page was written before khugepaged collapsed it, and khugepaged
collapsed the page before memory reclaim kicked in, didn't this
somehow cause data corruption?

> +               }
> +
>                 if (copy_mc_user_highpage(page, src_page, _address, vma) =
> 0) {
>                         result =3D SCAN_COPY_MC;
>                         break;
> @@ -1205,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct *mm,=
 unsigned long address,
>         anon_vma_unlock_write(vma->anon_vma);
>
>         result =3D __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
> -                                          vma, address, pte_ptl,
> +                                          vma, address, cc, pte_ptl,
>                                            &compound_pagelist);
>         pte_unmap(pte);
>         if (unlikely(result !=3D SCAN_SUCCEED))
> --
> 2.33.1
>

