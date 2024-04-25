Return-Path: <linux-kernel+bounces-157977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA708B19AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39591C21362
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1A29408;
	Thu, 25 Apr 2024 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux/vNoVH"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90571199BC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016748; cv=none; b=P/J3D/zr+4cfKsVUd8jcH17lT50CtB7kzq92xLJj8KUqo+viTuYW6s+swpCY0Vs8FMEAEBd3K+KMy1saLUq4PDnIK2J8pcqkYWH4Ajk9Aqi34RTriJkV1QuYO8gEG/qyBETlCry9vxxXKx9BuS8wYnkzNygw8/Xgd4wNAHqX1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016748; c=relaxed/simple;
	bh=3wiy6p6CNyk/Ga/V/ig0sSA3z9IL32moAG77P03rwN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDTBut8a+CEd7J94q0hXEgEkcxwXFu14jnRRAfydp9DYzDQNqkQ27r75FoktJoj4cmEiwUrhPB5eZKm2MUlxYkbIc/c6nzb9XBVyx5SYw6l9/g8DKk8QzYEy6Oj/zA8weKoUSImiUvUveXDiSDjSXrT9uETW6XzIXu/VxW/tKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux/vNoVH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b4ff36277so432705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714016745; x=1714621545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYp/Zt/Vz1rh4t2A6hBeOpmR/pnEahF8TAkSRflBIyQ=;
        b=Ux/vNoVHA82hgtWdit1g3grnSFuVpLnGXII7TfMjDGg4ZmQYeL19j33jsOe/cas9Oz
         JodW9oFvw6RBk3c8614xEUZ6xZPO2SPbNIH7d9deS9O43GehK1wCHj1D2giZ9YcSNL91
         V/mEG5ZWfYDXFghhUfEhiVo+s+OMd17KOiEKg/GwCCtb/f4aLqnqRqgqs1UBDWDswlXB
         NIbfcOaejZ87e1IrjXrieUh3Aa07UixymbhIJz97dzddBr8Vrx8R0xjYUu/PXK1MFv3Y
         DewJznUfO59551kspfRnIpSe4nuU5yjDeqmFscvpTtNuTPwCgYEz0n0zqgREGuMZdeKQ
         FiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714016745; x=1714621545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYp/Zt/Vz1rh4t2A6hBeOpmR/pnEahF8TAkSRflBIyQ=;
        b=DfuN+XRmMtWK7apuU3v8dEROnLkwujlIzc5km60OpkeMpEOoVDO+AN9SE9WpggCCk1
         my7rrd3Qk/Gj8HQ0WoITWFoe9TQLE6CBXuu2t8mATHUrqknnH8aU4LIm8fKeUAqCAqvd
         pfbE7vYzPClJffD3q52pgs3NZw5DWop13c00FsjjdTazAfBPn3EBZaRmVju/a9noU8gZ
         FK522AiiwD5g6DmsZFuHIVztX7hCxpC3dKNJA7iuIVzXa2BsNX6VVhWxsZiqhjAUqRDx
         XW9Df7tLWsDA05q8997Cso1vE3c9/SuLEe7vchkCeDzXyVUWNnYIKLLNHh6xMWKDFdaW
         PzbA==
X-Forwarded-Encrypted: i=1; AJvYcCVSOYLWAckjRQQMw0IvmtBbcq81rn2zrkKTSQGvIBRL4DM30FnM5SRA+VzV8Y1F5wcyS7MwMh7z3VcPBlhtvVlwraXaVz3GWMIMyUOX
X-Gm-Message-State: AOJu0Yzd07P9W1Mgkb3RmEsuN14yNUP8Gw6TOJcMi9MVB3dxlPd08Ppo
	Q/kROTz//M9roZ4+n8aD8egnVYBaiDJyJbmPX188kQ7VbQLLvKJ4r0GvIny4SN5AfMct2wwTk2y
	1bETAnMik4jDV/4018gM3rJt0MPw=
X-Google-Smtp-Source: AGHT+IG4/hvvTUG/JmgKLeC71M/cbYszULFla++OUA5mdi903ctCNrHqkUTC6dUzgh5we974dDlPwgJmWJhiR9eEDiE=
X-Received: by 2002:a05:600c:354d:b0:419:f088:249c with SMTP id
 i13-20020a05600c354d00b00419f088249cmr3133032wmq.12.1714016744574; Wed, 24
 Apr 2024 20:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224614.477221-1-zi.yan@sent.com>
In-Reply-To: <20240424224614.477221-1-zi.yan@sent.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 11:45:33 +0800
Message-ID: <CAK1f24mHG+CZL38CAp++9urMkciWqd0wAgyFi+QjfCTAVk3Rew@mail.gmail.com>
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zi,

On Thu, Apr 25, 2024 at 6:46=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. It is possible that
> the folio is unmapped fully, but it is unnecessary to add the folio

Agreed. If a folio is fully unmapped, then that's unnecessary to add
to the deferred split list.

> to deferred split list at all. Fix it by checking folio->_nr_pages_mapped
> before adding a folio to deferred split list. If the folio is already
> on the deferred split list, it will be skipped. This issue applies to
> both PTE-mapped THP and mTHP.
>
> Commit 98046944a159 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> However, this miscount was present even earlier due to implementation,
> since PTEs are unmapped individually and first PTE unmapping adds the THP
> into the deferred split list.
>
> With commit b06dc281aa99 ("mm/rmap: introduce
> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapped
> folios in one shot without causing the miscount, hence this patch.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/rmap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a7913a454028..2809348add7b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1553,9 +1553,10 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped))=
 ||
> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))

Perhaps we only need to check the mapcount?

IIUC, if a large folio that was PMD/PTE mapped is fully unmapped here,
then folio_mapcount() will return 0.

-               if (folio_test_large(folio) && folio_test_anon(folio))
-                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmappe=
d)
-                               deferred_split_folio(folio);
+               if (folio_test_large(folio) && folio_test_anon(folio) &&
+                   folio_mapcount(folio))
+                       deferred_split_folio(folio);

Thanks,
Lance




> +                       deferred_split_folio(folio);
>         }
>
>         /*
>
> base-commit: 2541ee5668b019c486dd3e815114130e35c1495d
> --
> 2.43.0
>

