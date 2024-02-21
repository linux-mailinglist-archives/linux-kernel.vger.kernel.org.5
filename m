Return-Path: <linux-kernel+bounces-75203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E538885E4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCA283CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903983CD6;
	Wed, 21 Feb 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYeUEHaZ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FA7FBD5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536945; cv=none; b=hVOIvi0UWVz4+b5Qjr77mBOIP7t6e3hKuu22v3SmT/IaZGfCiewHZSvqDGjWgVylDeh6qOY7YuGY1C2vzzCO+Sr/y15GUTtAyc3Kzgm1iHmGsYKrxrUM1TH957CwBvv3zlDfZnODgpjWmZlAznHtwtGdNejxvsfxkohWihEWSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536945; c=relaxed/simple;
	bh=fmaJOjuiuzc1I3VG7/Ti8gqDkhSjfOTOI4oFIBZuQIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRDBkldRWUa5cLEoeZo1WUvocGDjoWkBooVrqF9oSVawKm4w6vLU0BCmI4/gbxbTN+NngqslfhTdPU3hXnu4hlCo0h21yoFSGYh6Uhs0+pi1c5JX2qE2BjxceOkfvE/tnDfeJS7Zig4OT7GGYc8DS5v9mpPIKIGcLzPUbUAZskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYeUEHaZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607fc3e69adso60010127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536943; x=1709141743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfPBj9b71D+eNY1wEvQoyUsDBy3rVhDy4LnJT91Hn+w=;
        b=cYeUEHaZes2HH/6oLmUEM7Yr/jAywwDAJzBIln0NyPQuPkYjSq8IzGTiKzEbiZ7OeK
         PA6sNOtU3ZNyyVyfK6DkamkAW7iffY1rVl72RMeZBTaPKoR3LFt8lDIOZz+rhBIO2Cc0
         9f8KrxPwo/tCiuJK6jd+u5Mx3vyXyyrPYPwrQ637l9e7w9pjkvDeQEzZdh7JXQHwgqq9
         cD/WngNBObNEXjB5m35wDxlNk96rb1+YhL0QAE7pwpvIZyvlD1goj5fABENGe1EJXJ/Y
         wwZbgnPvQvGcreI+Z6SiSuDbE4ugA9w6FxbjaVBd5dQJlt18xvFm+wi1h4gorlANrkJs
         vCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536943; x=1709141743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfPBj9b71D+eNY1wEvQoyUsDBy3rVhDy4LnJT91Hn+w=;
        b=GU5q+FKpip0iimN13MpHbIxNCtN6benIHhHrH+ZgV5Ir70UI+79aOXropfkwxvYyjj
         ikq6rE3++lyzCCRbgKf+MHd3hUASqiS87yumE1+/akZuLgTKfwL2TbP75JHQplU3Ur/F
         N+TK9z+TD0gcbvTFtiM7QCS5MpZImCi8PR6MkAUp/HpdpZ56vdT/PQ0eLWoH2s+OLEDy
         DpU0JFXeaBejyrAZL3akYWDVnSTaFpT6y3c3sgzTHYs0UgaUQZIQKta401+ewKDtH1ZU
         llP19ah5tUcbWATh0W+vaeviDVn9abzMvTkwU+zwaF7hEMjVW3Qq9yZSaHoA1m/R2LZj
         9c6w==
X-Forwarded-Encrypted: i=1; AJvYcCUADJPDpiUWVhi/P4yBBx3kfqJ3WUw92D7HetxqvumGdsVctvporpq3XG4HqN+igfa0hwCnSWWFaUpN9RRylscQ1OMHcstYo8YhDIqC
X-Gm-Message-State: AOJu0YzkUFFJT1LZM0EFOjmLlKV4HQmIzuJ8MGyJqVha9CaS2y6Wyw3S
	FqHK5uXlDxTje0rL/1wMo2uLbxlTlOFl5OwU9ECZV6KXWY4o+6fnadxrM1wBg7axc4gCvJpUUZW
	563FYn9dzfTI2TJ0uyLaKhGfJnjY=
X-Google-Smtp-Source: AGHT+IHPzGgeVebYi5e5XGY212SUvxo7txV8bzERYstCFCs9yobH6mfd8vu3+8VNXVU7DnbhLkANMq/J4WzIHMCFe4A=
X-Received: by 2002:a81:9a47:0:b0:607:57c5:41fc with SMTP id
 r68-20020a819a47000000b0060757c541fcmr18443898ywg.15.1708536942761; Wed, 21
 Feb 2024 09:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221085036.105621-1-21cnbao@gmail.com>
In-Reply-To: <20240221085036.105621-1-21cnbao@gmail.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 21 Feb 2024 09:35:31 -0800
Message-ID: <CAOzc2pwZO4xg8TBvt2dpPNT8TeHDnWod6iJh-LJ50hfTn4ua3A@mail.gmail.com>
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:50=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> The purpose is stopping splitting large folios whose mapcount are 2 or
> above. Folios whose estimated_shares =3D 0 should be still perfect and
> even better candidates than estimated_shares =3D 1.
>
> Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
> the current code will split folios and reclaim them while madvise goes
> on this folio; but if we unmap subpage 0, we will keep this folio and
> break. This is weird.
> For pmd-mapped large folios, we can still use "=3D 1" as the condition
> as anyway we have the entire map for it. So this patch doesn't change
> the condition for pmd-mapped large folios.
> This also explains why we had been using "=3D 1" for both pmd-mapped and
> pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
> madvise_cold_or_pageout_pte_range() to use folios"), because in the
> past, we used the mapcount of the specific subpage, since the subpage
> had pte present, its mapcount wouldn't be 0.
> The problem can be quite easily reproduced by writing a small program,
> unmapping the first subpage of a pte-mapped large folio vs. unmapping
> anyone other than the first subpage.
>
> Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't =
use mapcount() against large folio for sharing check")
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cfa5e7288261..abde3edb04f0 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 if (folio_test_large(folio)) {
>                         int err;
>
> -                       if (folio_estimated_sharers(folio) !=3D 1)
> +                       if (folio_estimated_sharers(folio) > 1)
>                                 break;
>                         if (pageout_anon_only_filter && !folio_test_anon(=
folio))
>                                 break;
> --
> 2.34.1
>

