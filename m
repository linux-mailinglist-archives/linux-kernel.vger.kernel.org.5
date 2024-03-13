Return-Path: <linux-kernel+bounces-102268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AE87B003
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A1D28CA81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1F86255;
	Wed, 13 Mar 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3pHXiar"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE0634FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351093; cv=none; b=qMNdxiwrR6wdw0UcdIZYHyA3Pwg3XxyjlaXHNEUjqgYDPpVAdB3dmdgmf42HvVm+TbOv1l7OLU2VLPSekJxDlZ4ow1cEKe1DiCxyKawjwqEUJkku1e9UVwWDP8mS0vM3vyxBHs1R1IcQ3lNU3a6GPdd8n45V3MgsAy7YAbiU/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351093; c=relaxed/simple;
	bh=GWANjV8MPosZMudkYmWwAdXHm3I7Rfz0GYSZJhw8r6o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GHMmp73A8IGXyAKyqv+R0edvB1nkM4OH0N73oCR8G4a7HwQYLRl0PhPCGovIkJR55VzW44nVAwDCe2yhxQgX0E17n0pZyDvQ+VhJmvBaLGkogH7RncSlb6WkTo/eQQms3u4UlVRqWW/Z5pb/yack9Hu8k6ECxms8R099G/OVHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3pHXiar; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609f4d8551eso12444427b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710351090; x=1710955890; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yb4/do1pROjeTju1s/xyNesTFTYE8gM2f/me0LbmaOw=;
        b=P3pHXiarU/BMho1vE3WdMkbKq1Mn27fMPTqG3GygJ3XH+a+N+zpbslACpYblsZCgrc
         +0PNw6m9RCFuVp+x5qjfUzemX/cPgntzzTxT2hXZ3SnoJxNfSJm/upedptPkxATs5A9n
         ox0e7f9RIjRiWicgk6HRF8h33+ojOjnxi5pUnP34jItF2+5TQELSFFaB4aRU5W/uoGDo
         bziR8vtuWCGTwtBMDMC1wJ3JPlU+Wc2WrbfQ4ry3HhNfbJZOMsqGJelDoUpCB+Hl6519
         ABVwAH33g6S3oFeSfE/erRZdtGSkARAh3K8/6x4Nz26WR5oyAoC19PwLQgWzEHDbUkrs
         Mhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351090; x=1710955890;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yb4/do1pROjeTju1s/xyNesTFTYE8gM2f/me0LbmaOw=;
        b=ILCng7Z2Owb/gAxEoJOqFME9GU0/FZ7WLHvvYcMtjt8NqXUdItFVK+vc+dFrk028gz
         ZygfoKyN0t8lBXbYHsRcuPAHezmEPYlLqOXcTbsobnDl730VwhN4n81oSZfGYnk+DLWm
         qmd/PtOi5SGhPreulvvSphHEmNp8wnhtQTMaoACzl2UFOHX6/Y41TSyxXW3sE25/FU3H
         eQILIeOa1aJe+DqtfhUaSL+GAA34QYt5sQFBK6IUw8BWu8qczAkzViPskSdrA289W6uu
         nX5qJkI2HlKDTF6bIn9gQ2s/PrgdhMiyxCcoa3r+zYtkio4YwpqgrpWPqe8Y5zTuze/Y
         S0tA==
X-Gm-Message-State: AOJu0YzKFi88yPhrnCsXmNsiyJ8nKnmVC5Nf2h3qIZ0TuAmQ2vvlhGtg
	enLtUj033bp9k0xC+lQzpxZZ/7bsRAot4qK3VR8s7ey5F8GCpqhcDrqGGv0sRA==
X-Google-Smtp-Source: AGHT+IHIxyeZrRDcA0+VGiUFeh7A7NOw0l84hWBqdGKwSNmlmn1RVN2dpsnyBZxM1nruchewFxHtOg==
X-Received: by 2002:a81:4011:0:b0:609:b1ec:3ffb with SMTP id l17-20020a814011000000b00609b1ec3ffbmr2321912ywn.6.1710351090126;
        Wed, 13 Mar 2024 10:31:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l31-20020a81ad1f000000b0060a3ac68cfasm1772032ywh.61.2024.03.13.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:31:29 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:31:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Matthew Wilcox <willy@infradead.org>, "Huang, Ying" <ying.huang@intel.com>, 
    David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
    Mike Kravetz <mike.kravetz@oracle.com>, Zi Yan <ziy@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6 06/60] mm: migrate: remove THP mapcount check in
 numamigrate_isolate_page()
In-Reply-To: <20240313163707.615000-7-sashal@kernel.org>
Message-ID: <320639a0-74fe-9a9b-864b-b0c5ab6ff15d@google.com>
References: <20240313163707.615000-1-sashal@kernel.org> <20240313163707.615000-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2024, Sasha Levin wrote:

> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> [ Upstream commit 728be28fae8c838d52c91dce4867133798146357 ]
> 
> The check of THP mapped by multiple processes was introduced by commit
> 04fa5d6a6547 ("mm: migrate: check page_count of THP before migrating") and
> refactor by commit 340ef3902cf2 ("mm: numa: cleanup flow of transhuge page
> migration"), which is out of date, since migrate_misplaced_page() is now
> using the standard migrate_pages() for small pages and THPs, the reference
> count checking is in folio_migrate_mapping(), so let's remove the special
> check for THP.
> 
> Link: https://lkml.kernel.org/r/20230913095131.2426871-3-wangkefeng.wang@huawei.com
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")

No it is not: that one is appropriate to include, this one is not.

Hugh

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/migrate.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6f8ad6b64c9bc..c9fabb960996f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2506,10 +2506,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
>  
> -	/* Do not migrate THP mapped by multiple processes */
> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
> -		return 0;
> -
>  	/* Avoid migrating to a node that is nearly full */
>  	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>  		int z;
> -- 
> 2.43.0
> 
> 

