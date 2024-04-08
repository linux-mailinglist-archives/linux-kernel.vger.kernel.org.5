Return-Path: <linux-kernel+bounces-135767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD1E89CAFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E42288AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E946143C7B;
	Mon,  8 Apr 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRyoao0d"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A8143C60
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598437; cv=none; b=jqamoloJzzx72hnv7R3wJ6njYt1D6dzzUSzSYAtJ64euMHt3BiMXDMGl7mXISACkNPbt3zCyb10iHozd+A5cCaV+vO0WHbYMlJTe3vVrEkOPKSwbbrpzuIAu1wv6opLch10Hn7aFSWbyAnqS8YivhAtyHGEVxmlAfdRYhUUsMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598437; c=relaxed/simple;
	bh=k0I48xbj0CgJ7BlKugyWyUCzinIRhnZdjBOIeS4yRow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtqWN2mwfcmzXpI3pzcS6Znw/PA4+PHywFtBbR5q/Qbiw9dxCPkUwA5M2b3GhWN+BAiohtlTTIXu2vzzfh/4w9bMEtIMRZLEUNhwqFRByubJd2yyDKz9U3w8+Pg1lb3MCMHHWKH7Z4qDYv6uZ9Bu4per2zW0rSc0jnEZCPx//M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRyoao0d; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61587aa9f4cso47970807b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598435; x=1713203235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfIU0QpVZIF15lgnDsRjIW2TgpMzwN1OGssI0N0VgFo=;
        b=mRyoao0dd4ycCjyoefabEtwZ/lsjWm9Vas2fCyl6eWFNFBrPHHupUfVQ9bqeKoXEJo
         7rGSwWkg5mrxv8oz3LDgFJSVQXaImcIPnRi929LQ15D9k8m8eVqNoazLHA4YlTdC9U93
         tlD5CY1IMFP2R/gCEKsRmxY3tzS8BU4nmdUH/BeJcTe79/V5mCPRgquPczIvx3l+2CJv
         Fs/VjxL/UYDWATZ14h4JIIBZt15OC/8VmfV9ip1RTRUVoudZ+RCXZGRyLJ/2n16jpdXX
         GCJtHcXqfipx+DQmBwy6AyAQR6vZQl4cFQYURUbTepxKZlrBeHw7/FHF1mKmGfhtHtMK
         k1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598435; x=1713203235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfIU0QpVZIF15lgnDsRjIW2TgpMzwN1OGssI0N0VgFo=;
        b=O9bbzsxONLjjyrjDX3M4GgM3znUp9DvuenktQ0R2H2SxRxDLH4BYjaeWqHwE96yl6X
         s6m3v0De1g7WMXcLKzm00Wm7dgx91fRoUbefJ2ZR34wvEFRiUuj9oegskkgl03lKFX5S
         NN4vSXOyfdrOzGu45sE2Me4eQb59rdilzUQVlX7406Yuc6WPVq4nb/kK2tjX5OEuoC6W
         FI0CNuvD/YhuCgWaUjP4pQg1fd592O6ZU6WEI4vAQnA9Gx0a5STnDRsKGUWzj/5QUuK6
         OY8V1It89fgZlj9R1jk9iZdeyygQvV0wvZUhWSO7yQGoyybE5kmYB7nQH7t+ftjCIVMW
         UJkQ==
X-Gm-Message-State: AOJu0YxZDNjvDvGxADcw7dXB+zkVBekIrbsZz4l2y2plh/XWMwKn4osc
	JSB09IbsBrWU6eMY1SG4Gvy6nOikw8JrLAHHyPglJpfgYm59WUR1
X-Google-Smtp-Source: AGHT+IHNzcjSy8N90qb0o5QWVigXYw7QeFbxDb9CyChIMBJFJiVFLSEzN7YPaTW3goGfIziB2Q2Log==
X-Received: by 2002:a0d:f402:0:b0:611:7186:bb70 with SMTP id d2-20020a0df402000000b006117186bb70mr7731199ywf.38.1712598434975;
        Mon, 08 Apr 2024 10:47:14 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id k6-20020a81ff06000000b0061575978d53sm1773869ywn.55.2024.04.08.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:47:14 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:47:12 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] hugetlb: Convert hugetlb_wp() to use struct
 vm_fault
Message-ID: <ZhQtoFNZBNwBCeXn@fedora>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-4-vishal.moola@gmail.com>
 <7d001108-157d-4139-bfa9-5b4102166f17@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bzqOPz8R0NrpdQb6"
Content-Disposition: inline
In-Reply-To: <7d001108-157d-4139-bfa9-5b4102166f17@linux.dev>


--bzqOPz8R0NrpdQb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 07, 2024 at 05:12:42PM +0800, Muchun Song wrote:
> 
> 
> On 2024/4/2 04:26, Vishal Moola (Oracle) wrote:
> > hugetlb_wp() can use the struct vm_fault passed in from hugetlb_fault().
> > This alleviates the stack by consolidating 5 variables into a single
> > struct.
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >   mm/hugetlb.c | 61 ++++++++++++++++++++++++++--------------------------
> >   1 file changed, 30 insertions(+), 31 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index aca2f11b4138..d4f26947173e 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5918,18 +5918,16 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
> >    * Keep the pte_same checks anyway to make transition from the mutex easier.
> >    */
> >   static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> > -		       unsigned long address, pte_t *ptep, unsigned int flags,
> > -		       struct folio *pagecache_folio, spinlock_t *ptl,
> > +		       struct folio *pagecache_folio,
> 
> The same as comment in the previous thread.

And fold the attached patch into here as well please Andrew? 

--bzqOPz8R0NrpdQb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-hugetlb-Simplyfy-hugetlb_wp-arguments.patch"

From f4adcf13ecc15a6733af43649756e53457078221 Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Mon, 8 Apr 2024 10:21:44 -0700
Subject: [PATCH 2/2] hugetlb: Simplyfy hugetlb_wp() arguments

To simplify the function arguments, as suggested by Oscar and Muchun.

Suggested-by: Muchun Song <muchun.song@linux.dev>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 05fe610f4699..0d96a41efde8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5915,10 +5915,11 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  * cannot race with other handlers or page migration.
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
-static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
-		       struct folio *pagecache_folio,
+static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 		       struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	pte_t pte = huge_ptep_get(vmf->pte);
 	struct hstate *h = hstate_vma(vma);
@@ -6364,7 +6365,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, folio, vmf);
+		ret = hugetlb_wp(folio, vmf);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6577,7 +6578,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(mm, vma, pagecache_folio, &vmf);
+			ret = hugetlb_wp(pagecache_folio, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
-- 
2.43.0


--bzqOPz8R0NrpdQb6--

