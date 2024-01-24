Return-Path: <linux-kernel+bounces-36946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F077D83A93C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6997E1F21FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99198629F7;
	Wed, 24 Jan 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpnVD25K"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8B629F5;
	Wed, 24 Jan 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098024; cv=none; b=WEVTvlnMpBnAt3OtftkbfBTPkqvD2vwsxJ20dy/RCfxHAssH/dgXDhAE9OFgHS9H0jDhlb9rwjhubOKurasYjElPMe9fQ4Ri9HRag5v06zI+ly8lfsvN0T279v3rQw6D64Q+R6fp1cAMkwmI4DVkp3HkMgLM+Ng8U9vlgT2ffm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098024; c=relaxed/simple;
	bh=EqGYeH3FYs27aZY1bDyzT4fuEU0UUgDfJZqY6tJdwA0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaAfJ7np9NkOe529vXM2WeZjIGo5erA3f5Iw1ovGM1gxCQsad+4Xz3UOjaqVJOeFIJ1ARjifWvAYLOCP5xTdrZrdmR0ipQpqLSy7lftKa2L3M/vaXu3vEFX+4NKzv4SDVLumb7vsCxUo/GEQmvUlB3rAye5UTgXTA+SffilNENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpnVD25K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e80046264so67587765e9.0;
        Wed, 24 Jan 2024 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706098020; x=1706702820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHQXrQZm7ePexKbK+DrR/AWby1OxOJCAQLEUzKUQttg=;
        b=YpnVD25KBd4LorZ4IG0Dg03OPq3qnTARYcBwBBegqSuaOq61e8D/ABTnUxmS89ObBS
         r6db+UG6nSpTmHM48XPZPJ2P1EZVCQtA/3CvXBqJMGASakxhl7JB8j3w/uz/iwJrKlXG
         EhlSaxPBEEu4LNw4NBiECY7sb6fudH4dW4t54dwWU7wCKp1hn+pJpjWhyuuwiOVb/Nyg
         GHBdp9Srk94MPCsShAwnwzWgBrkogzX1jdPfMi5vqhby4Y0Wwb3sR7Jvobso+LxPB9xt
         C2qm+buWW8KThLbjPdlhm9ZixJxeC6r8W8T9DkWoN0WiYpXFaUY+7udMNEkKFF+t4s25
         MwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098020; x=1706702820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHQXrQZm7ePexKbK+DrR/AWby1OxOJCAQLEUzKUQttg=;
        b=sMEe1Rs2olEoIWJ/vP4VDMepSMm2LoiNU2zsItMRSSkwcsRDJ5wYqqVno+lZ/skLsO
         /9x6m0x2MXJJwtNKzHSLl+AC4FPEgeAvwxfYl/GbKjvs+akPBhaLzdLR7O6izihHEwbv
         csonH+t9kdmn287FBJjiId/8gRggN8mvHV9WbDfxH68qnpFVkle5+FKszW15Py+P6VQk
         eREBjpDhYAHtHYWExd5ysgW8gfh8FF5FUbUMIDX+A53MTrJyvHlw1JM0weQIX5uwV1zG
         sFgvpuQ/lBgfZ4uKBAjO9prTinF2KFIZQVeEz88FpmjIkOOVsA6y+F4mDG10k9tpurvb
         mIVA==
X-Gm-Message-State: AOJu0YyQ3uukPbBPN3LelSCGs3e8Xzwoumg1H6IKiu43JuqPQIgYNmwi
	lsUx5azPQ43+MctDObBa0yJyD4R6SJk3f70/hb5NSM90QQiPkKYD
X-Google-Smtp-Source: AGHT+IFkNvD40vJ0a1mrsGf7S5l+J9ij556hvdrCOjt5RYOPGErcAQgD0x471iQCkK6f4ZjjEVIRqQ==
X-Received: by 2002:a05:600c:444:b0:40e:70fe:e179 with SMTP id s4-20020a05600c044400b0040e70fee179mr1149407wmb.182.1706098019848;
        Wed, 24 Jan 2024 04:06:59 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n4-20020adffe04000000b00339272c885csm11436040wrr.87.2024.01.24.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:06:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jan 2024 13:06:57 +0100
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Sven Schnelle <svens@linux.ibm.com>,
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
Message-ID: <ZbD9YdCmZ3_uTj_k@krava>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com>
 <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>
 <ZaRKMwKJIBmh8-lD@krava>
 <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
 <yt9d1qa7x9qv.fsf@linux.ibm.com>
 <ZbDyLzoIm0GdQzZA@krava>
 <6caaced7-a9d7-4fe4-823a-11b96be83e46@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6caaced7-a9d7-4fe4-823a-11b96be83e46@arm.com>

On Wed, Jan 24, 2024 at 12:02:53PM +0000, Ryan Roberts wrote:
> On 24/01/2024 11:19, Jiri Olsa wrote:
> > On Wed, Jan 24, 2024 at 12:15:52PM +0100, Sven Schnelle wrote:
> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>
> >>> On 14/01/2024 20:55, Jiri Olsa wrote:
> >>>> On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
> >>>>> On 13.01.24 23:42, Jiri Olsa wrote:
> >>>>>> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
> >>>>>>> In preparation for supporting anonymous multi-size THP, improve
> >>>>>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> >>>>>>> passed to it. In this case, all contained pages are accounted using the
> >>>>>>> order-0 folio (or base page) scheme.
> >>>>>>>
> >>>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
> >>>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> >>>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
> >>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>>> ---
> >>>>>>>   mm/rmap.c | 28 ++++++++++++++++++++--------
> >>>>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>>> index 2a1e45e6419f..846fc79f3ca9 100644
> >>>>>>> --- a/mm/rmap.c
> >>>>>>> +++ b/mm/rmap.c
> >>>>>>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
> >>>>>>>    * This means the inc-and-test can be bypassed.
> >>>>>>>    * The folio does not have to be locked.
> >>>>>>>    *
> >>>>>>> - * If the folio is large, it is accounted as a THP.  As the folio
> >>>>>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
> >>>>>>>    * is new, it's assumed to be mapped exclusively by a single process.
> >>>>>>>    */
> >>>>>>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> >>>>>>>   		unsigned long address)
> >>>>>>>   {
> >>>>>>> -	int nr;
> >>>>>>> +	int nr = folio_nr_pages(folio);
> >>>>>>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> >>>>>>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> >>>>>>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> >>>>>>
> >>>>>> hi,
> >>>>>> I'm hitting this bug (console output below) with adding uprobe
> >>>>>> on simple program like:
> >>>>>>
> >>>>>>    $ cat up.c
> >>>>>>    int main(void)
> >>>>>>    {
> >>>>>>       return 0;
> >>>>>>    }
> >>>>>>
> >>>>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
> >>>>>>
> >>>>>>    $ ./up
> >>>>>>
> >>>>>> it's on top of current linus tree master:
> >>>>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> >>>>>>
> >>>>>> before this patch it seems to work, I can send my .config if needed
> >>>
> >>> Thanks for the bug report!
> >>
> >> I just hit the same bug in our CI, but can't find the fix in -next. Is
> >> this in the queue somewhere?
> > 
> > we hit it as well, but I can see the fix in linux-next/master
> > 
> >   4c137bc28064 uprobes: use pagesize-aligned virtual address when replacing pages
> 
> Yes that's the one. Just to confirm: you are still hitting the VM_BUG_ON despite
> having this change in your kernel? Could you please send over the full bug log?

ah sorry.. I meant the change fixes the problem for us, it just did not
yet propagate through the merge cycle into bpf trees.. but I can see it
in linux-next tree, so it's probably just matter of time

jirka

