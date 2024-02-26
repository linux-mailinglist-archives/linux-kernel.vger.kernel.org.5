Return-Path: <linux-kernel+bounces-82328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92B8682D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5214D1C24C03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E5130E58;
	Mon, 26 Feb 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMe0CbXU"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124211E878
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982265; cv=none; b=uTDaIxa8eOJWyAAAdW/8yQ/xXCDCwWw/9KStGx+U3sXRVxpUEs4CDXNbHGOVqhobE0LDTVaMAnUBvn2HeZlFAXLP3vLCYLHCRGRoc3O7fmlBW6abBZd3bumckJVLA8KsSrc7x2PvgwdeGyrhFBRygwZv8pIRQP9DmZLI3OrgNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982265; c=relaxed/simple;
	bh=kLIqZMuH2EqYQ4rLc32ru9nL0V0s0RXExxsU0+CDQTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDD1ut6owZRR7Iq+4icMU8a6liq6B/uuVRtv2TfY0P2veeWcBL9yhsDNUz4dJ4WWIU1bYTwu70bjd1gtDLLicO15J86QSgTwBWWEtTQw/LpKFNZkP1nSsNkQf1AjuMzF5b5A/CFzMMziTwQkrLu0z+yNCqrnPJUnZeMeinpRacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMe0CbXU; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso1806832241.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982262; x=1709587062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TQ+MmPJfo/s3a/JqGkoS+XmBHvpeeHVf2ayrPsV/n4=;
        b=UMe0CbXU+eqUrjRZ7cGOTrjwX5/e14VGKSozx3XTNkExV7P9debygZZEiv+HcCw5xF
         CXwxZrUR7GjxfG5/baC32iX2JLCHDprWJvagFHfEy1rp1a4K2Klg/sTaJG1orL1QjLBI
         RmuXR3Y2+KS+F2yBUL4m0sAf8fvN20uX8t+kIp0OC1dagWfyh59M+iUHwOUNrO1Tnjk1
         mzeaGrvwKy9f/49q2fwUt4vhsswAfFZVb9QX8t8l+I3y84rZFHbX7nMdZKYKUgCzr1AU
         1o8JkyhXNB6K5Du65LdKP2BD+pm9StZu3Jl0gOPEcyFqLawqEag4BE2Rqp2eqlmFIH94
         pGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982262; x=1709587062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TQ+MmPJfo/s3a/JqGkoS+XmBHvpeeHVf2ayrPsV/n4=;
        b=jh3wJSzoRE3v9cBLtCw3Q/1tO5w58avN3i9SX2WqjCUazKgz9shhtYfqGkZAYpSij6
         PYjW7ly8NCAR5hoeOo28Em2QvgPw9y3lLpM+LuJmCj7GOzbIIVHm3BB8/PpPYnfSlAYQ
         EF52GRiC9i8QrVmRxNjxn1yZD9ERHUaWA3RQw7YzmKAX/qTk5dDtbWdfVJDJvvFG2SAi
         byoZwEUCkCguUB2SYume7VjWhZ6TOTEpP8kSIJ1wM92+k+LAK+zVtOxIzBFZLFRlFHFT
         IqTx5gn7BgDhSn+whnJWo9Ov/U5go/5jBUxQMTawRxnIHhDc2VhrQ/bXN+IltOhr00CJ
         lTtw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8T8ph2fehEMFHT/6ZBjcS+gowFKb0w5+OEZyo+H7jaOSPvTInkjMsxWSiE6FP2o8E+XfuxVbbSwkU0eTcIre5P6p4PXcJvHVVqq+
X-Gm-Message-State: AOJu0YwS1CiaodNjLQm0cUooF92mmtwMOZ8qnYZszL/odZ4ha2xISOvP
	2mXQwF1EsSof+qkSRdpEmgYNjk6MfVx6la9ROVRXQGOGf1QXeqkhOcP/9HBxDSsw9m6HXEbhb1r
	KTceyTqsgkjtaOJSCo97zbqZ/AA7af2F+x6iHlA==
X-Google-Smtp-Source: AGHT+IGrTdeGg3MeiiEt+KWIFd0JzOV1GwJm6Dbq6J6o8jBXpCOykKFMIATUeymYpLNw3rc1ZtxClcNTwXRDECitVto=
X-Received: by 2002:a05:6102:3a09:b0:471:e447:f1d5 with SMTP id
 b9-20020a0561023a0900b00471e447f1d5mr5239146vsu.13.1708982261969; Mon, 26 Feb
 2024 13:17:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221085036.105621-1-21cnbao@gmail.com> <71fa4302-2df6-4e55-a5a8-7609476c41d4@arm.com>
In-Reply-To: <71fa4302-2df6-4e55-a5a8-7609476c41d4@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 10:17:30 +1300
Message-ID: <CAGsJ_4wj_xcrMkw9+W79TpO73nPQx+rs=zPj7_5kWVMAvHUGTA@mail.gmail.com>
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>, 
	Vishal Moola <vishal.moola@gmail.com>, Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:46=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 21/02/2024 08:50, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The purpose is stopping splitting large folios whose mapcount are 2 or
> > above. Folios whose estimated_shares =3D 0 should be still perfect and
> > even better candidates than estimated_shares =3D 1.
> >
> > Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
> > the current code will split folios and reclaim them while madvise goes
> > on this folio; but if we unmap subpage 0, we will keep this folio and
> > break. This is weird.
> >
> > For pmd-mapped large folios, we can still use "=3D 1" as the condition
> > as anyway we have the entire map for it. So this patch doesn't change
> > the condition for pmd-mapped large folios.
> > This also explains why we had been using "=3D 1" for both pmd-mapped an=
d
> > pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
> > madvise_cold_or_pageout_pte_range() to use folios"), because in the
> > past, we used the mapcount of the specific subpage, since the subpage
> > had pte present, its mapcount wouldn't be 0.
> >
> > The problem can be quite easily reproduced by writing a small program,
> > unmapping the first subpage of a pte-mapped large folio vs. unmapping
> > anyone other than the first subpage.
> >
> > Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don'=
t use mapcount() against large folio for sharing check")
> > Cc: Yin Fengwei <fengwei.yin@intel.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/madvise.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index cfa5e7288261..abde3edb04f0 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >               if (folio_test_large(folio)) {
> >                       int err;
> >
> > -                     if (folio_estimated_sharers(folio) !=3D 1)
> > +                     if (folio_estimated_sharers(folio) > 1)
> >                               break;
> >                       if (pageout_anon_only_filter && !folio_test_anon(=
folio))
> >                               break;
>
> I wonder if we should change all the instances:
>
> folio_estimated_sharers() !=3D 1   ->   folio_estimated_sharers() > 1
> folio_estimated_sharers() =3D=3D 1   ->   folio_estimated_sharers() <=3D =
1
>
> It shouldn't cause a problem for the pmd case, and there are definitely o=
ther
> cases where it will help. e.g. madvise_free_pte_range().

right. My test case covered PAGEOUT only and I agree madvise_free and
others have
exactly the same issue. for pmd case, it doesn't matter whether we
change the condition
or not because we have already pmd-mapped in the page table.

And good to know David will have a wrapper in folio_mapped_shared()  to mor=
e
widely address this issue.

>
> Regardless:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>

Thanks though we might have missed your tag as this one has been
in mm-stable.

Best regards,
Barry

