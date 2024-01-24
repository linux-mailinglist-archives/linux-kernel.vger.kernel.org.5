Return-Path: <linux-kernel+bounces-36839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768083A794
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F202A282971
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2F1AAD2;
	Wed, 24 Jan 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg0foj8h"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091D1AAB1;
	Wed, 24 Jan 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095157; cv=none; b=R91zDBohULUC9m1hJ6eJ8ZB5TDsRuvutIxo9MKwvodVxh+liO7jBH1G9rGRsezvYaImkYX9orJ17lCXTvsu08pydtPF8tyKicIUahZoHEtXdsKsRwi7RSMJmZbDuyKGSxmIKGeknc7Rq0ncWfBNiUnDWDIvMBVZn4/zt1byCzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095157; c=relaxed/simple;
	bh=5jTFMkVQhPK7g3HGR/4LstOjZdNhgG5VgwuT7R8QRIQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDyniR3/YpU5Nq1UB3w2uqn5DdUOQZArenvwgauXMwJhJF/cqXUinWgeMSYA0KAtN/fJ4G0m8nsRtT1+8geqEoQBfumNL+MgV/wCk4nTarcgNg7zAAW+In1j5ZsLWQFEUWpdCrgdfcwszdF0/65TOj28J6H0zkXvy2liOkszBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg0foj8h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e76626170so58912535e9.2;
        Wed, 24 Jan 2024 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706095153; x=1706699953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ax2WAgA+IWHYbycpjwhzRdnKEjPRyvd6ox/DAOqjIDc=;
        b=Sg0foj8hS7CGXyES5AIaXCIrvoh8ap8etdk9T3Y7b6q1oRYezhV8DW8B6uUtQjwpQL
         wxjZTCz2Dm96M66JOvxBuELZD5GwjKgjyltFkn5x8Em1z+RneOrBKUTOGbRBJxiYz+Wr
         gSn609ochAsdNm+XqkyvtSexnQoDYNgAfV6AIq2JnmJxtSYRAtrF9OyOTP1zrfUNP9Tm
         khuMtmdwTeBpBNLL0hQhlcPlzNM01cZNpBFo9Xev9abwfOVz59tPmY+WDSirdVDInPJ2
         BR79Il5jjug7BAA5duGeUu2H2eRlB+sg11R5M497TLnW+Pf+JIdMBiPt4TuM0KyhcKLe
         ReNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095153; x=1706699953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax2WAgA+IWHYbycpjwhzRdnKEjPRyvd6ox/DAOqjIDc=;
        b=NswKLeJJWqIEM7TWusRWK8fvll5Q3rj7XS1YkyU5y7/lJz/1EoZCAS01EXgDfRNOcc
         9oJiwBdNMiBCsxTH5mIAlxqJqwIahYnCplxrV1ZOgvde7FTkMOYmIJK76plHlJ/ZBuu2
         +LiZ74rtAu/R/u/6n78951QYDIs4oK05ZXJLPw30ILvblHVxK3rDK5Za1i403yOLYxwQ
         SZC+smzT+yaNuH2iWSp36fbseiQFjsyL2ZH/LqwU5f5LCc5QhGMsSbzMHKTMFivtiqAd
         ta0kMMRGvE7aLcVIL8eEJ0Olb31yQBrt16eMz2GSPS2KO0Ak9qkx4JDjUWguR+GoqpnH
         TCrw==
X-Gm-Message-State: AOJu0YzEUuaqAs8Mbl5mXWviGaPBV7dVG1DNWdN2KILRPFZbxUsJep+/
	yTKG4yv4n6DhXO3QuVvpkNh3iwKGZhkDoGTFRZKiXzrRGuA8uw1J
X-Google-Smtp-Source: AGHT+IEHrYSNYEV1+Dcij+tz/QoBsH6YJTLbxoqlNBdasWoDuViAcRoyJDbwKwUowv7rYDqrt1memg==
X-Received: by 2002:a05:600c:3145:b0:40e:b93c:940f with SMTP id h5-20020a05600c314500b0040eb93c940fmr966856wmo.28.1706095153415;
        Wed, 24 Jan 2024 03:19:13 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm49817817wmo.42.2024.01.24.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:19:13 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jan 2024 12:19:11 +0100
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Jiri Olsa <olsajiri@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	"Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Itaru Kitayama <itaru.kitayama@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Message-ID: <ZbDyLzoIm0GdQzZA@krava>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com>
 <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>
 <ZaRKMwKJIBmh8-lD@krava>
 <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
 <yt9d1qa7x9qv.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d1qa7x9qv.fsf@linux.ibm.com>

On Wed, Jan 24, 2024 at 12:15:52PM +0100, Sven Schnelle wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
> > On 14/01/2024 20:55, Jiri Olsa wrote:
> >> On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
> >>> On 13.01.24 23:42, Jiri Olsa wrote:
> >>>> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
> >>>>> In preparation for supporting anonymous multi-size THP, improve
> >>>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> >>>>> passed to it. In this case, all contained pages are accounted using the
> >>>>> order-0 folio (or base page) scheme.
> >>>>>
> >>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
> >>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> >>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
> >>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> ---
> >>>>>   mm/rmap.c | 28 ++++++++++++++++++++--------
> >>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>> index 2a1e45e6419f..846fc79f3ca9 100644
> >>>>> --- a/mm/rmap.c
> >>>>> +++ b/mm/rmap.c
> >>>>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
> >>>>>    * This means the inc-and-test can be bypassed.
> >>>>>    * The folio does not have to be locked.
> >>>>>    *
> >>>>> - * If the folio is large, it is accounted as a THP.  As the folio
> >>>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
> >>>>>    * is new, it's assumed to be mapped exclusively by a single process.
> >>>>>    */
> >>>>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> >>>>>   		unsigned long address)
> >>>>>   {
> >>>>> -	int nr;
> >>>>> +	int nr = folio_nr_pages(folio);
> >>>>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> >>>>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> >>>>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> >>>>
> >>>> hi,
> >>>> I'm hitting this bug (console output below) with adding uprobe
> >>>> on simple program like:
> >>>>
> >>>>    $ cat up.c
> >>>>    int main(void)
> >>>>    {
> >>>>       return 0;
> >>>>    }
> >>>>
> >>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
> >>>>
> >>>>    $ ./up
> >>>>
> >>>> it's on top of current linus tree master:
> >>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> >>>>
> >>>> before this patch it seems to work, I can send my .config if needed
> >
> > Thanks for the bug report!
> 
> I just hit the same bug in our CI, but can't find the fix in -next. Is
> this in the queue somewhere?

we hit it as well, but I can see the fix in linux-next/master

  4c137bc28064 uprobes: use pagesize-aligned virtual address when replacing pages

jirka

