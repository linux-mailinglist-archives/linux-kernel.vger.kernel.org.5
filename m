Return-Path: <linux-kernel+bounces-159485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6F8B2F37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8590C1C20862
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA678C70;
	Fri, 26 Apr 2024 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj8Kcqvv"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890D7604D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103143; cv=none; b=Ocsh+b2ZTL2y0BPQKtB9yTkXHxfGqQs/9coH20Xsj5IbFQi/sQZeJe4FgglJ/9Hwum1pXjTbC/BJgujHHJF6qvJLBmCvSYK1stRcGlNiY9SWSLp77am3ivD5Gk5l1axC4CeFNVWCdW0UWeC7UN3MYh/tmfOfX6Y3z+2TI/5ExyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103143; c=relaxed/simple;
	bh=SBoJUcu4sSQmD0xRGqmL918bSyiw5pBvnGWMP/HuT6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUlSU083q/+WmQr0K8jR6e48EL2rsBnZGj/PBWpjDn2elaAb8o0UBlCbg67a4+5eWxh7eovddYA2AfcDn/8Gkaq9EM1C1wxvFRqtbOxXH9eI2wXMBu3M4xs5Sb6VomgFKGltdUbx2Wm757Ks/hLIjr0zKINgSaZYbKmXcH7dNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj8Kcqvv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572347c2c16so2071777a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714103140; x=1714707940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lCcs8nxi939WWR9MSQdpKH4Z/MiLVAwZBmNZPf46as=;
        b=aj8KcqvvQykt0+sooxNGktfwJ5i3L/mtIg50CGavPmHP6x0JJ8xqnoEUG4CwP4fG2q
         ywiStAp4OPj993K47oVujTc+FgMJcFjVTZ+0/PPSssvKUcqAy8cRbGs7MMjQWoswHb9w
         VkeswYbd1seAWunOqDm8aaYTrI50DrlEzV1mIjcACbbLR3kzZGMlEF+3vyVAPGGVoQVi
         0LZ8ukvC/4Tb4nruvGad31v1dHhRs+ZEBsrPg6afnxOJ6i/UECnqVIUYSeLk7SypNVBL
         oHD174uvTgaz7e9l+/3yb0nihPHNuwcs06fZiJXRkvUvyWg778qJhtU1L1RvCQW7Xwht
         6dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103140; x=1714707940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lCcs8nxi939WWR9MSQdpKH4Z/MiLVAwZBmNZPf46as=;
        b=jjSzNB3TVez2ue1kCxvGqNFi/QiqF9x+YVCr1yhbXO2Qz2Dz+RNM9JMDCZdhRAEbBW
         Vnl6li9Kpz+xxsqKCN/gHfHxjg0TyGh2h6eHA6MPcRA0qzq6+/8rJPixx5/LGqDzSj+j
         MvYrP9Bf67twMQt9/LGoeWk+i4BYuqpzJA7Qus5jRBN2pO8H/QaDA3D0D66F/8Pl+iEL
         Yf5adKmQvBTp1uM1PO/OUnzjVhw6jQqiBE9Axydn/u5xDEYbAoMPInjEQnku+z7SFyIK
         4CXrfXB5XoNQcIcNtrTdmXrnzF3/ZUDRf7+1bqPA40MfIcdDZst6uFDFYYs9YAeIWZAu
         teZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKhik6Sx8nKfBz7mf3fJPNuM8S8Nd2N3a5PL1VaXM4LRjfDB+uXoJ6zJa5AJ+ZcL6JvgqlAUCN5UJaNoI9jNz+STeEb+2eS5D3mve+
X-Gm-Message-State: AOJu0YyBR+CBJeMx/f7xz9bly/VuTwr2zmASRQidTDeLIVAJ6MHAqK2V
	wKgliUtZiSriBfO76nBxtaMon0zysIpNE5yjASlViNmNauNlAKgBu9Dy8mT1Jo8m/bH3AY5Whyd
	hD283ruoH0ALKt+trJan88OW0t4Y=
X-Google-Smtp-Source: AGHT+IGVM8XpR50yzQ/CA6d8mEu/7+uRnmB5Fm71BQdyIRl/Sw81s5gEsqF1EArohpRiATN+qE5qiZwdgaDRTrhjBqQ=
X-Received: by 2002:a50:951e:0:b0:56e:2b31:b111 with SMTP id
 u30-20020a50951e000000b0056e2b31b111mr867490eda.7.1714103139552; Thu, 25 Apr
 2024 20:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com>
In-Reply-To: <20240425211136.486184-1-zi.yan@sent.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 26 Apr 2024 11:45:25 +0800
Message-ID: <CAK1f24nZFJKAyEX3A8DsFA8_VkdtYiB251WxvTa9fcnmi01aOg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
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
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
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

FWIW

Perhaps it would achieve the same check, ensuring that at least one
page of the folio is unmapped while at least one page remains mapped.

 +                   atomic_read(mapped) && nr < folio_nr_pages(folio))
 -                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped)) =
||
 -                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))

Thanks,
Lance


> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped))=
 ||
> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
> +                       deferred_split_folio(folio);
>         }
>
>         /*
>
> base-commit: 66313c66dd90e8711a8b63fc047ddfc69c53636a
> --
> 2.43.0
>

