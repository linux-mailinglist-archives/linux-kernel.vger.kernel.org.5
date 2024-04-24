Return-Path: <linux-kernel+bounces-157788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920018B1631
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59511C21DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A477C15ECEE;
	Wed, 24 Apr 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8SXI46o"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97523BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997946; cv=none; b=EP/PYZA/BpxNveNDaFnBo5gODhS9nEft7i6QTzVjIHVymyzbNRRjpzAM/Z+AmZWbX/ku+KYOdKAQXJ2D8ozEbqupWllt615EiIBwauuThbYmAc8KKHZbmkjMekIpBCJxhyOBxQzAFUmAWb6K5TfVwo0SJSiN6xSCavyJ2tU/RYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997946; c=relaxed/simple;
	bh=EQo+zGC16IkD24HLaYmrTErmXONgg+WietHKBFzN8Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEeV3ZsJqGpj/D+CbSPttzOh/XzZs0AcqpEkd5EFO8jw9yrikeD5TeM+DRdnXqYXeIoZOuaCd3Ez5r869j0o2R0cvtzbFV8kTTp+a2V3eLKX/zhoUIeP0R+RDWnizxHUkLsuDdNv1KSO+/lJrOg0pNWrR+WjDxX4MNtbUD3nkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8SXI46o; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a55b3d57277so43267866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713997943; x=1714602743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1VSqOGp+cTDD3FwVgodoOnkI+tY2YGNCkhcEt2wmrs=;
        b=K8SXI46o5GhTsTsE7YEEvqvJpA6hSALvNY9H9s2XVc9t4yon0eL4Cf5+74A8AXZ6AC
         37UzEn4NO9hk91SFvcFg9hLRFqWtXtBMGyZBWnuGKnOYFKrHLCiYR6eBXayiTljD7oPZ
         NSCXfCJAkBiVeId8FjsXhejgM1ciLtEJUCXu0RZofwQk+nY9kchpPL/H79EAOQPqrpQo
         FTAlt4XuN4H0O9+yAoqOYxTzvKnpFzRUbqnar4mxZUPz12O81p3uXQA+73EFNkg2RSIx
         8PxyyGvDN+27mybS+RY0Avec8F4bJr1ZThJm+9CYs6oUpMXCoyJtC6bMZ2G/Z5lhSRCo
         j3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997943; x=1714602743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1VSqOGp+cTDD3FwVgodoOnkI+tY2YGNCkhcEt2wmrs=;
        b=J7Gchfn40szjyiKjeSqQuYRuAFzUK9IFohuIjCURK++E6Ah+GrXjg70EmZs2y7szSE
         ncqr1Usqfk/XQqfx45vvl/0nDfsW7qemSOmWUNVhWQbtaZYolp8Zqs5zU5OBfbW7VDBq
         QyejNH7nRUIgaRi/omsgVFcpvvh0RP4lryio3/DwrXArnVYFd59G14G7d1glyZF7Hs9z
         7OxIzXnvIUCHDwEAVLAiOaWOgeOfnEV7TDHgl8PDArpU85s1z3ZjjFD5qWYGc5WydWeo
         qCSS+dQfzhJOtf9sdtTadVs59Tx8j9epY3YN3k+Bu0Xe4YOrCo+FP5HGNMXozCcyWs6G
         bLpg==
X-Forwarded-Encrypted: i=1; AJvYcCUx1WBx4XGG9X+pTclBiw86NpAPfqJJVtycIwZkGw2WMmUZH7g1a+4coX3bxvWXuKgka4sDVQcsQVuj09WyR/Neu1NcDD5OMWZsZDqB
X-Gm-Message-State: AOJu0YwIkoAV6EYKXOqPlFBlHM98ijuXDJGbkIYW+NUnmylYimg1qpzZ
	jWIGNtEM1E6SV4IkJZ63IVtiP8drUUzm/6EG4DgboCV+Hgqlo26YSbKJIGLYdvCev0YVr4KLZJr
	K8CLT+laHbXs1OE+cO72fCA22Cx0=
X-Google-Smtp-Source: AGHT+IEqtFmD6v9c765dugMGoqkOjGlWjaNOWIqmuj7vQIcOYL0B0PAWJepn5edmJtBLhZQl5RDy339oHFM/1lING+A=
X-Received: by 2002:a17:906:f9d1:b0:a52:5d89:5f27 with SMTP id
 lj17-20020a170906f9d100b00a525d895f27mr2602963ejb.14.1713997942903; Wed, 24
 Apr 2024 15:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424211031.475756-1-zi.yan@sent.com>
In-Reply-To: <20240424211031.475756-1-zi.yan@sent.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 24 Apr 2024 15:32:11 -0700
Message-ID: <CAHbLzkq61sTeRxU23gg3kMNBunxXH3GpkL6D56xcaepsDzFCJA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:10=E2=80=AFPM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. It is possible that
> the folio is unmapped fully, but it is unnecessary to add the folio
> to deferred split list at all. Fix it by checking folio->_nr_pages_mapped
> before adding a folio to deferred split list. If the folio is already
> on the deferred split list, it will be skipped.
>
> Commit 98046944a159 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> fix everything. A fully unmapped PTE-mapped order-9 THP was also added to
> deferred split list and counted as THP_DEFERRED_SPLIT_PAGE, since nr is
> 512 (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio(=
)
> the order-9 folio is folio_test_pmd_mappable(). However, this miscount
> was present even earlier due to implementation, since PTEs are unmapped
> individually and first PTE unmapping adds the THP into the deferred split
> list.

Shall you mention the miscounting for mTHP too? There is another patch
series adding the counter support for mTHP.

>
> With commit b06dc281aa99 ("mm/rmap: introduce
> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapped
> folios in one shot without causing the miscount, hence this patch.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/rmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a7913a454028..220ad8a83589 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
> +                   list_empty(&folio->_deferred_list) &&

Do we really need this check? deferred_split_folio() does the same
check too. Bailing out earlier sounds ok too, but there may not be too
much gain.

> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped))=
 ||
> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))

IIUC, this line is used to cover the case which has both partial
PTE-mapping and PMD-mapping, then PMD mapping is unmapped fully. IIRC
this case was not handled correctly before, the THP actually skipped
deferred split queue. If so please add some description in the commit
log.

Otherwise the patch looks good to me. Reviewed-by: Yang Shi
<shy828301@gmail.com>

> +                       deferred_split_folio(folio);
>         }
>
>         /*
>
> base-commit: 2541ee5668b019c486dd3e815114130e35c1495d
> --
> 2.43.0
>

