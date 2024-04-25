Return-Path: <linux-kernel+bounces-158841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17E8B25A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE461F21100
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0147E14BFB1;
	Thu, 25 Apr 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLr57kxr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA61CF8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060184; cv=none; b=DX0HPTxnPhKLUdXr1Q+Hf+B7yGPcXf/V4SbxrOqo7xW02VC7HhdUyCmygf7vAMXWhFdOGkXgIgXPBZspiU6vLQ5d1uAv1HaiuwC0jhQwOieGexqYxhRfAL8fWZ3CBLyLgr8LYkOMVT2fQKEi5BwuDFeNVC5vMir9h+gvRWYOozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060184; c=relaxed/simple;
	bh=eTRdMiIzbFJiY044uoPo3iB5pc68b6NWF4QUau8oLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lr4svKUUF/ubzXvHfIDr4VQ3NJ85ZZuDx6TfoVooNloYiP/8CyvZGFINbO8XfZ7SvYErb72Jj6JeT5rfSDbokGn1Fq5df2kh5nAg33ypz5W0ZBltYFEFk481nHKdosCAxXfii46p0s5Uzw9avX9EI+PrQJLyVJxHlfd3kob/9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLr57kxr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a556d22fa93so140108166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714060181; x=1714664981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdaYc28NfSSIwvDCT2trYkwv6gETCtD+XOdfA1chXyo=;
        b=KLr57kxr/e/hU3IH5eN8MSeb5bLpYJu0WVrW3MzzSfQ9dl/VjFzunyPl4+OAReVw8c
         egeHSadLcdOPshUurFJtdvozL9bxjH3DPXV8DNAf9bfqhLDd3WlV1pIH21HbSG9Vn/5g
         IV5NNMgMgdrQR3I48n4ygYGV+3xbc8HAJJmCkk0lvtSbK6XZ95qnwJ7m938QQ0748ORM
         Zk0ty78fZEfhWmvdauxZNUmmY+qXqRfJjr3sKkcR94kLGUD5E0EXonGxYIMfCXo32sXg
         gPmSNVAhURYeIAfM+KRwi58+JRsDv9BuwcO268Gl9d+MSKp6wykKTIQXNcbxKvQRuQkZ
         E+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060181; x=1714664981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdaYc28NfSSIwvDCT2trYkwv6gETCtD+XOdfA1chXyo=;
        b=KFWeVSTF8Kr5nTj6Yg93vMmV5vN5SbCghsI4Swp7XSEF+f8fEFn7tM5GoY2hBuG5BB
         r8JRVHaukYUa3QDRHMD5D9ao+lWt+IiH9EOiiMC55TfJ8qFfe0CAXr52+oUxerxsn1jE
         pTeosmzH5qZCIQ4lZImhaUKV21eOUfjF1KWeBACpSp2FZctj+0jd6225nioPXMF0oVOl
         lygtwK1Fnel2pu2yVTWMVQG2LkSYwb8IjRzcNmJ+siIy8saiBi+4WuIUzro2GCV16C+n
         BlD7itCCpG+Pr1zo3NmusgzI2+tY/L3sh7DaqWddp5NrmN4WRHkWL39EZHcCFHUZ5Hnm
         k5ew==
X-Forwarded-Encrypted: i=1; AJvYcCWvAQl9Lyu6WqwspVh8t8SrLzPH60CwMxES1U8TOpy9nCY/WBxLfojpFO3PbS0NMTLiNSJzoIGvcx1W2AcPhoVkEu5MpcSPQy8YPYK3
X-Gm-Message-State: AOJu0Yyj0dfeIk7DFYGXPqSuRZnrsTu0CcNtHN8mSEA/uU2hjGZ83eKH
	tMkPb+pnkxlPzQ76smB8kpadMEStWehAbj5A2qhBWN1bEwOZfCw4lRRT0OUpYkC+IHfdE3cHCFS
	htBshZ2tamwN8cwVShVFHIFQJRzQ=
X-Google-Smtp-Source: AGHT+IGaHxGwdnM5nZI2aKxLKrXpQXSFs7i9n9saiyw3KBDwzyb/3lV3rxpO3qi1z7hyNoNnotBmpJttQXL7jsHQqzw=
X-Received: by 2002:a17:906:544c:b0:a52:3adb:e407 with SMTP id
 d12-20020a170906544c00b00a523adbe407mr85188ejp.37.1714060180625; Thu, 25 Apr
 2024 08:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224614.477221-1-zi.yan@sent.com> <a5426fa6-442a-453f-a234-63d89675ea79@redhat.com>
 <8BBD1B75-135D-42AA-8937-53B259803AA7@nvidia.com>
In-Reply-To: <8BBD1B75-135D-42AA-8937-53B259803AA7@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 25 Apr 2024 08:49:29 -0700
Message-ID: <CAHbLzkqSWws335461iw=aJxXGuFxQood_UYo5bthJ+YWN4q9cg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:53=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 25 Apr 2024, at 3:19, David Hildenbrand wrote:
>
> > On 25.04.24 00:46, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
> >> if any page in a folio loses its final mapping. It is possible that
> >> the folio is unmapped fully, but it is unnecessary to add the folio
> >> to deferred split list at all. Fix it by checking folio->_nr_pages_map=
ped
> >> before adding a folio to deferred split list. If the folio is already
> >> on the deferred split list, it will be skipped. This issue applies to
> >> both PTE-mapped THP and mTHP.
> >>
> >> Commit 98046944a159 ("mm: huge_memory: add the missing
> >> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> >> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
> >> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> >
> > Once again: your patch won't fix it either.
> >
> >> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> >> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> >> However, this miscount was present even earlier due to implementation,
> >> since PTEs are unmapped individually and first PTE unmapping adds the =
THP
> >> into the deferred split list.
> >
> > It will still be present. Just less frequently.
>
> OK. Let me reread the email exchanges between you and Yang and clarify
> the details in the commit log.

There are still some places which may unmap PTE-mapped THP in page
granularity, for example, migration.

>
> >
> >>
> >> With commit b06dc281aa99 ("mm/rmap: introduce
> >> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapp=
ed
> >> folios in one shot without causing the miscount, hence this patch.
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >> ---
> >>   mm/rmap.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index a7913a454028..2809348add7b 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1553,9 +1553,10 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>               * page of the folio is unmapped and at least one page
> >>               * is still mapped.
> >>               */
> >> -            if (folio_test_large(folio) && folio_test_anon(folio))
> >> -                    if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmap=
ped)
> >> -                            deferred_split_folio(folio);
> >> +            if (folio_test_large(folio) && folio_test_anon(folio) &&
> >> +                ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped))=
 ||
> >> +                 (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
> >> +                    deferred_split_folio(folio);
> >
> > Please refrain from posting a new patch before the discussion on the ol=
d one is done.
> >
> > See my comments on v2 why optimizing out the function call is a reasona=
ble thing to do *where we cannot batch* and the misaccounting will still ha=
ppen. But it can be done independently.
>
> Got it. Will keep the deferred list checking here and send a new one with=
 commit
> log changes too.
>
> Thank you for the reviews.
>
>
> --
> Best Regards,
> Yan, Zi

