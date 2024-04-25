Return-Path: <linux-kernel+bounces-158124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D668B1BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86D21C23BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E26CDC1;
	Thu, 25 Apr 2024 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7DTF6GB"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B610134A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030064; cv=none; b=pgqfLRpJuHdU/2fj2CDxf9eWBXK5+r/hsj5OU37eRSBnx8PZtX8IQS0NsjZn1t7sAVX9aRQJXDSEmIovKjueRMYfSbXjDiCBHWcZG7RzxHxZAjHfn+xc3058RzDNkg9KvrjQIe9jhSqydul0A50XK2lUgkog1mzN30YRViQ3gJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030064; c=relaxed/simple;
	bh=/QY7cLIc7OYA55brXdj7bScKa7WaRCG8YneMxeLduMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITEM4pcrE8xpkWHAor1bHI1n1mGUZNEmZ0M3iGzZGhQh4YVq8IeEFfrRvIiX4+02sDiKN5lTPRs+Kia/NRfIxBuy90QewsO3S1wBWcoXltlVzXmj5SzjZnDwZgO5Vh4irTFDiUmAqCHea0oCBGmQcnRb+CoIQgRLcu+XR8iS3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7DTF6GB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572347c2ba8so611268a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714030061; x=1714634861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxuVfL2Zyw6cKo0nF1CV5taOl0JsDHqcVQE/hlTCDsk=;
        b=M7DTF6GB4NWCSHJ7ZP/WWsN/Rh9q3wptIFbeRNhkn+hqy4f4jMxXCtiL6Y5+cHOKHH
         JmzgSetGXWvjMA3UZLCc/WSs+TeiKGk4Vx+qxNFdenJhSQAJW8OaQzWyBH335xuZJSFv
         ZEHsiZwwMHMnR/+wDYuvQNfS1+q6Gd8XgEL/Rez19ZAuzgiPwRflVkTObpvQ2LIVX+s9
         VMRNKpR4OVwW7esJNPiAPu6dKi/3CoPHZs9McKGpxBr8Brx21JGzItQ/GgKSa0YCSiXK
         4UpINi2xlSlvwjAy3jzORCfcKEUtg3GNdl9FN7O7soe1NUlThgQjgeJFHwZ04dXJZPvw
         pW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030061; x=1714634861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxuVfL2Zyw6cKo0nF1CV5taOl0JsDHqcVQE/hlTCDsk=;
        b=bDDGIqnCYtk8KYDiYZo9NRK61azP8bnyELhWm69eCa/iIhLBOcm6ciMZihyyBdwRLO
         2bi+OxqrInyHiMs38fCi5dGSrStUqtD28UHGur1C9CDm/oBFFUvBKujzPPABi2kzdfES
         EGNuQrmQkDh2JYFnzgWbKeJT+brNPWArIliAqXZu3aoFX5okF286lWisnpY0AXFOGNop
         CeHpTV4F3tAJJ1OLyIPwfvSCGhfauvqqhG9Baz0O26k9Lax9+p4EJJEjO4TSgwUUo5yo
         FYjHdYXJqE2VpUbsz4DHKgWsVs0Rj8sXPPuqZ7M9NPPoKVpS/LvOVporeb7nFXwAxupi
         QQyw==
X-Forwarded-Encrypted: i=1; AJvYcCXqPqApBRimwEzvf5e/5+O98UBtb5lddAKCweX4YX9ebUpNkP13JFGWbvd5tkTGx/wSf9gtw1EOfKyQPPJGpgGVcohy6qSeGLoAQBuI
X-Gm-Message-State: AOJu0YyPZxn+LMYEVnUL9SSNo1x4UEkxe3+zX8aK1QtvFbt+Y4syigH9
	D6WK++XcIwTzdftjYpt1Xl5szqp4kAa2cK7FT1NzJlG/TtE7cBG0/XrehScR0v3tb95F52+s16U
	XMiRep1YLVo+GpUHGhHXrjHYOjoc=
X-Google-Smtp-Source: AGHT+IEHBaxooT3I1wuxcVgbc/J+Kw2QPTVmZoNt4veeoBKvhbc5Hi0jWh93/aRXtdHY7ajapV3A9nUEG28nHLV7y+o=
X-Received: by 2002:a50:8752:0:b0:56b:ec47:a846 with SMTP id
 18-20020a508752000000b0056bec47a846mr2800988edv.25.1714030061009; Thu, 25 Apr
 2024 00:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224614.477221-1-zi.yan@sent.com> <CAK1f24mHG+CZL38CAp++9urMkciWqd0wAgyFi+QjfCTAVk3Rew@mail.gmail.com>
 <5e6bf4c6-c4a5-4be3-b203-ecc77ba4e5d9@redhat.com>
In-Reply-To: <5e6bf4c6-c4a5-4be3-b203-ecc77ba4e5d9@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 15:27:29 +0800
Message-ID: <CAK1f24n3SBcMm=VrKEcMSn3VQ6qMpjE=Lg3fh3_QxFt8wtaSWQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:21=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.04.24 05:45, Lance Yang wrote:
> > Hey Zi,
> >
> > On Thu, Apr 25, 2024 at 6:46=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
> >>
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
> >> if any page in a folio loses its final mapping. It is possible that
> >> the folio is unmapped fully, but it is unnecessary to add the folio
> >
> > Agreed. If a folio is fully unmapped, then that's unnecessary to add
> > to the deferred split list.
> >
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
> >> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> >> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> >> However, this miscount was present even earlier due to implementation,
> >> since PTEs are unmapped individually and first PTE unmapping adds the =
THP
> >> into the deferred split list.
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
> >>                   * page of the folio is unmapped and at least one pag=
e
> >>                   * is still mapped.
> >>                   */
> >> -               if (folio_test_large(folio) && folio_test_anon(folio))
> >> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmd=
mapped)
> >> -                               deferred_split_folio(folio);
> >> +               if (folio_test_large(folio) && folio_test_anon(folio) =
&&
> >> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mappe=
d)) ||
> >> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped=
)))
> >
> > Perhaps we only need to check the mapcount?
> >
> > IIUC, if a large folio that was PMD/PTE mapped is fully unmapped here,
> > then folio_mapcount() will return 0.
>
> See discussion on v1. folio_large_mapcount() would achieve the same
> without another folio_test_large() check, but in the context of this
> patch it doesn't really matter.

Got it. Thanks for pointing that out!
I'll take a closer look at the discussion in v1.

Thanks,
Lance


>
> --
> Cheers,
>
> David / dhildenb
>

