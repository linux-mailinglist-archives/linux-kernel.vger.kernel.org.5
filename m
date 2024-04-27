Return-Path: <linux-kernel+bounces-160886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 967528B440B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F931F2217F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F33BBFB;
	Sat, 27 Apr 2024 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py9iYIM2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98B37149
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714190991; cv=none; b=Xs9XA3mEVfpKRwaLKWHA1v4L/KEYs1RaqbnQrNNSS4I5gr2iUriLdG90XHTSGbkIAiMn2sFJVLgGK3/+dJ7T5fZAfcKuwBslkJUrpkiJ7b2AXuJfPngrD0FzpGF/cxD+dF0SOKxXbkf9Hk1bjpJ+hnxkXRDU7zBmoLhWZwf/Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714190991; c=relaxed/simple;
	bh=cJUfrbt2aJ+QSi0ndaH/tOkz5KQq/SP1EaFfqRxRCdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdnJC597WE2kugaT3yd288O5X0K8c7Jn5HP/Jrp05xkOdCspFN/X/Wp6YYZ3aFlhgb9kwZnGLGMV3dfYxeTHy9Oj3IxeD+sLLt4b6Y6OjqKi6BHpoZYgZf7Eip77vX4lVq3zqFob+smVg5ztvPxpyAy7yZcoqfLKKb4flEuiC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py9iYIM2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so3807409a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714190988; x=1714795788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+VD8NR2nmR9VlrDK1vK/6rmR6SJWVAnV9ol8Jd8pWs=;
        b=Py9iYIM2Btn+8mNy+qQ5nEUnJl3+39/X2owAPmqRUEDbyDXtOE7vUGk+mnPAmO4dGf
         gIKzQjZtUxVtJS5I3QOu96x4Xt7p7/Urwf2oscXER3IBHi653nn++6WROKGVF7xnD0qB
         unbje+PsMUxuqwhwbgms9ltVKNKrtN+RSqGTqeXqLO/5d51aXSL7QpTXVpG9v/ORAnk1
         rX7/oNkAU83PeIB7Eute+v2hp5LlgakdMq+/Q7mTX5szroeDvASHpzM0+h55s7yfD1KU
         5huPxxTcLTFMGUny4OItM5ZyBKa+6RWHRQJB6C/Te8tNBG2c1sVeILIgiUcX9zjaiRJ8
         mT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714190988; x=1714795788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+VD8NR2nmR9VlrDK1vK/6rmR6SJWVAnV9ol8Jd8pWs=;
        b=dZzsCn+zT1sjUPWgETLW3BXEJtDHTtffmHbLHnX5KuJhBzoPOLAyegYFQObbe93JKu
         bLeTYPfPw3xPKRG1Mi+LXAepdjhpTdM3Ch6DQQ8VfqTaes8F6RTm84FSYqZuRsvE/oel
         wRduX81bNxdF3g5lNf2N8TrVHm8jK4xwoLvSTmKGEytxan8lb4kRa2eHSc0Xo6wRUKmH
         ZpTXNDQacar2ENVoQuBa4d1xI/z0ZiziX/zfuv53WurfiobTa4HOmIdUuXd7+14mg9OU
         6AeCeJlVF7YTHOCXFBynj489juA/r0ZLAP2/MiFyVZzneo9K6r25HQMAsNnxKoELBKh0
         iwLg==
X-Forwarded-Encrypted: i=1; AJvYcCXNPb4DUkbGDl9jtGGj42qi9M1c1R269I3IYek8GrXZ8Qt1iwZECds10h8XN2NxVyrQK/DHiHDvdS7Zieqs/d7s7SOxSDf74iOfAtP/
X-Gm-Message-State: AOJu0YxrVR/AoIJi72Ox+8wwSeK777gB2z6aYSUhtgeqsEF37q3doU5D
	Qtml2nt06hLCfjPfuym54OqOfRyyWhxPPC0d4PODWNQg/o3eORYlnwO17MD0Oemex3Jhcarw0WP
	NmdnZFJvoeKuoiHbOZDnw/u/1RvU=
X-Google-Smtp-Source: AGHT+IHoZYZAUssannC89cQym75/j253SnDQv61PWt0Qv3KGT6eE9NSanFmv6FLTpjtwIzedf/VcuIVdNIPEXCyQXMU=
X-Received: by 2002:a50:8ac4:0:b0:571:cb02:418a with SMTP id
 k4-20020a508ac4000000b00571cb02418amr2271168edk.40.1714190987872; Fri, 26 Apr
 2024 21:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426190253.541419-1-zi.yan@sent.com>
In-Reply-To: <20240426190253.541419-1-zi.yan@sent.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 27 Apr 2024 12:09:36 +0800
Message-ID: <CAK1f24kArHcT3y5uXTvZAra3jgwcz8d9f=y2_W=oi2Zms5e6mg@mail.gmail.com>
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 3:02=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. But it is possible that
> the folio is fully unmapped and adding it to deferred split list is
> unnecessary.
>
> For PMD-mapped THPs, that was not really an issue, because removing the
> last PMD mapping in the absence of PTE mappings would not have added the
> folio to the deferred split queue.
>
> However, for PTE-mapped THPs, which are now more prominent due to mTHP,
> they are always added to the deferred split queue. One side effect
> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> unintentionally increased, making it look like there are many partially
> mapped folios -- although the whole folio is fully unmapped stepwise.
>
> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapped
> folio is unmapped in one go and can avoid being added to deferred split
> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still be
> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> -- or where this type of batching is not implemented yet, e.g., migration=
.
>
> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> to tell if the whole folio is unmapped. If the folio is already on
> deferred split list, it will be skipped, too.
>
> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
>  mm/rmap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..a9bd64ebdd9a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>  {
>         atomic_t *mapped =3D &folio->_nr_pages_mapped;
>         int last, nr =3D 0, nr_pmdmapped =3D 0;
> +       bool partially_mapped =3D false;
>         enum node_stat_item idx;
>
>         __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                                         nr++;
>                         }
>                 } while (page++, --nr_pages > 0);
> +
> +               partially_mapped =3D !!nr && !!atomic_read(mapped);
>                 break;
>         case RMAP_LEVEL_PMD:
>                 atomic_dec(&folio->_large_mapcount);
> @@ -1532,6 +1535,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                                 nr =3D 0;
>                         }
>                 }
> +
> +               partially_mapped =3D nr < nr_pmdmapped;
>                 break;
>         }
>
> @@ -1553,9 +1558,10 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_anon(folio) &&
> +                   list_empty(&folio->_deferred_list) &&
> +                   partially_mapped)
> +                       deferred_split_folio(folio);
>         }
>
>         /*
>
> base-commit: 3dba658670af22074cc6f26dc92efe0013ac3359
> --
> 2.43.0
>

