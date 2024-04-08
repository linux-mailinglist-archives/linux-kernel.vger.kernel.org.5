Return-Path: <linux-kernel+bounces-135765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D943A89CAF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE6AB26B09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20B143C6A;
	Mon,  8 Apr 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGANLodJ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB385BAF0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598333; cv=none; b=okw4mzTPayNiaSy2zPIKofCmosCxS2BLMdm0b3KVGB7pon+MfxNILJa3seBe18umx2MnVKjmPaI6goVvpLD6Hd6GBMUq9Y/iUGLxBoK7OCrRlMFAFLMYyiIt09hqadijc7yq+Tfz2GhqgNTLe5BP6sgKaNU+MMGm7IdgRsPT/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598333; c=relaxed/simple;
	bh=tldR+Dm/43pLwnwmEcXYV0bpXWDMO3AQEJ+Q4bfy7qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwqsDAK6JifJ9RrdmiQFp0Fct/w/2LVilnWwhDjywCCmxhJB4v8BsihKZPpJnGV5Ai2NHsRY1tM8P4PKY8hXLLtwhx04bb1c1JmxmbOob67EMb0MnWqk0zjNUFDudobCHvBFFtpI3skkDkETBWuOKiNWdwQRioGtFJRQ9UtCRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGANLodJ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso4173243276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598331; x=1713203131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89Lw7HTouxopI6/9WS538BdZwzz/6yubYNMtG8C78zo=;
        b=jGANLodJkO9BMQ5J6Ky83csWBoxxvtjRsU2QxKbDuAqHwKB/OW/laR5nSPwZ65lC05
         kphrSe8pjIDSc+8clEbITu5lDG2GQBPYTWBLsH0mui70NoKFkzOeKEK2P7zCus6jkG58
         xqRvwg7AejYhEHBnOloKJEIXxVsYhuUB4/kmDWLeYdw4Kwej1eV3kILUKNsMe4RN7mEF
         kVCDPLoJV28Uudjo9n0aBBYsiKuafBM6NYnSK33+laZj2/NWQoSlADGf10HrFEhZM8fk
         onyzAn62RhUX6xBZIyY+pKGNTM3UJX0AnvBe8hzneCB35s7bRIkfFHmK1+Fjnnynkr70
         aA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598331; x=1713203131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89Lw7HTouxopI6/9WS538BdZwzz/6yubYNMtG8C78zo=;
        b=bV5w8jbgkQWw/SXIIUENa19PtLF6lCIVz1r3+MQ/d4vTqgSDRA/JszPkDQu54xdnhe
         MptOFmOhQ81XPU77/1rAcjtOYSChU1n6UJ2s14Dxh2W/oRVTPu15WnMAza+b9edDnwqm
         1TbF7vNXkJP0O1Q3byFAl5oW5QDFGTSc/l91JIhJL2aeMSQgo0sCxIk1/hMv4OWXzsFG
         qbq1e7/zhWWp2+yKBvga5UtosnAElluUfkmgSVQ4xULKSJieCGD+EXs54pkwYzsc5G6t
         tNmGDZXkGatgGp1ANgKAATbIchLVwATY5FAmkTp4RQxWVL8iwkCQIP202Rb4+XvN/5Tf
         G86w==
X-Forwarded-Encrypted: i=1; AJvYcCVQz4H3/rKTDRvCYcvGkwObrYGkVc3P2MLp2kUv2NKkmK6NG7DAz3b/5XeS7FLHqM/GOhmWgaVpCHg75or7BPUFskNpb+T8PjKk34cp
X-Gm-Message-State: AOJu0YwC1ywMhoIYEI9PMpc/B/vhTCRIQoUQjTw1+oY3lQxHOhdG/IJE
	pVkdVh7KMkx6fy/C7e/eXZtfE4EwWFygLxO/goehhyYn5YB0vB9Q
X-Google-Smtp-Source: AGHT+IEm6YRDHs61khG9tjG9b4v1huOlor4vb4vgaqiYYmsDaD4F+0+1tqRmf11BeO3q64bQ3mbMxQ==
X-Received: by 2002:a05:6902:c07:b0:dcd:3d6:68ad with SMTP id fs7-20020a0569020c0700b00dcd03d668admr10387292ybb.0.1712598330754;
        Mon, 08 Apr 2024 10:45:30 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id f123-20020a255181000000b00dcdba3056e9sm1475495ybb.25.2024.04.08.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:45:30 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:45:27 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 2/3] hugetlb: Convert hugetlb_no_page() to use struct
 vm_fault
Message-ID: <ZhQtN8y5zud8iI1u@fedora>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-3-vishal.moola@gmail.com>
 <Zg6iG8cxpopXuFCo@localhost.localdomain>
 <CAOzc2pyOusTc2xj2qF9MN8YeZp0dcbsrtPr96QhmJOJ+hX+CLw@mail.gmail.com>
 <73DFA2EE-0929-4801-9C7C-A393F7796CE8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oNi0RqCEoHgaKVsd"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73DFA2EE-0929-4801-9C7C-A393F7796CE8@linux.dev>


--oNi0RqCEoHgaKVsd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Apr 07, 2024 at 04:59:13PM +0800, Muchun Song wrote:
> 
> 
> > On Apr 5, 2024, at 03:58, Vishal Moola <vishal.moola@gmail.com> wrote:
> > 
> > On Thu, Apr 4, 2024 at 5:49 AM Oscar Salvador <osalvador@suse.de> wrote:
> >> 
> >> On Mon, Apr 01, 2024 at 01:26:50PM -0700, Vishal Moola (Oracle) wrote:
> >>> hugetlb_no_page() can use the struct vm_fault passed in from
> >>> hugetlb_fault(). This alleviates the stack by consolidating 7
> >>> variables into a single struct.
> >>> 
> >>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >>> ---
> >>> mm/hugetlb.c | 59 ++++++++++++++++++++++++++--------------------------
> >>> 1 file changed, 29 insertions(+), 30 deletions(-)
> >>> 
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>> index 360b82374a89..aca2f11b4138 100644
> >>> --- a/mm/hugetlb.c
> >>> +++ b/mm/hugetlb.c
> >>> @@ -6189,9 +6189,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
> >>> 
> >>> static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >>>                      struct vm_area_struct *vma,
> >>> -                     struct address_space *mapping, pgoff_t idx,
> >>> -                     unsigned long address, pte_t *ptep,
> >>> -                     pte_t old_pte, unsigned int flags,
> >>> +                     struct address_space *mapping,
> >> 
> >> AFAICS all this can be self-contained in vm_fault struct.
> >> vmf->vma->mm and vmf->vma.
> >> I mean, if we want to convert this interface, why not going all the way?
> >> 
> >> Looks a bit odd some fields yes while some others remain.
> >> 
> >> Or am I missing something?
> > 
> > Mainly just minimizing code churn, we would either unnecessarily
> > change multiple lines using vma or have to declare the variables
> > again anyways (or have extra churn I didn't like).
> 
> I don't think adding some variables is a problem. I suppose the compiler
> could do some optimization for us. So I think it is better to pass
> only one argument vmf to hugetlb_no_page(). Otherwise, LGTM.

Alright we can get rid of the vm_area_struct and mm_struct arguments as
well.

Andrew, could you please fold the attached patch into this one? 

--oNi0RqCEoHgaKVsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-hugetlb-Simplify-hugetlb_no_page-arguments.patch"

From 891e085115a06f638e238bea267d520bb2432fba Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Mon, 8 Apr 2024 10:17:54 -0700
Subject: [PATCH 1/2] hugetlb: Simplify hugetlb_no_page() arguments

To simplify the function arguments, as suggested by Oscar and Muchun.

Suggested-by: Muchun Song <muchun.song@linux.dev>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 456c81fbf8f5..05fe610f4699 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6186,11 +6186,11 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 	return same;
 }
 
-static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
-			struct vm_area_struct *vma,
-			struct address_space *mapping,
+static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
@@ -6483,7 +6483,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, &vmf);
+		return hugetlb_no_page(mapping, &vmf);
 	}
 
 	ret = 0;
-- 
2.43.0


--oNi0RqCEoHgaKVsd--

