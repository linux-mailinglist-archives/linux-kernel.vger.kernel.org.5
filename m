Return-Path: <linux-kernel+bounces-75686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94B85ED66
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93F91C219E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA612FB30;
	Wed, 21 Feb 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUTXxe3V"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B312DDBF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559405; cv=none; b=a7AHBgRohDWCC1qW8FUNUHX/gUCufbv+00au/UBkbRYYrD2TddZ+AZl0Di4hWpQeV+Uq0bc5KMfMUYAYKCP+41Ob4Wi6KgOCoeyQKS7Ej81AaOGu+8eC1pMei7EPYLCEy4dd2BOy7/TNB6k77le7rc9TXysjpgLF71D03XZ3BmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559405; c=relaxed/simple;
	bh=XJuffzEnSNsKJ3424e4z6pRxfuv0ZSk9YKCo6w6QkXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqrnIHChCIPdoZewYYyuPCDBckhOM4QxpAV6EZp08kUZlDpbP7d8oHZihUoVzw+twwl8s/NOMEsxwWBNeK2ZxJktGcOnHbShokILeZlz2+NXAv/11czhzVjd8DYs0Gvyfr8t2+NkdvLndAyBwlGeXLJbHM/wDraOjjgDymaH0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUTXxe3V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d51ba18e1bso12930705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559403; x=1709164203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lre+UqQQHJdTu6yMn3GijLQ4gMqXOjZ+IEoJS056n7k=;
        b=JUTXxe3V3B3NiQcRIjnkJ4afoy78xQD5DeWFZUsj8s51ZGtMTbZYeSSM7ozrNym+pf
         SI6NhHXgsFpexqtsOXM330c2qSB/fuA+xCZFihB4k4elUGsMhk1lChCgL7B+HfXam3Eb
         NuA5JKCRpYvAIcyif7rTsg+j2Vh+1Ao0v61iH0KPC5B8blcWdIG56PizsiEV5/aVB76C
         EkkvpH5ZmjIMw7kA7+HSSmkAa/V1zSumR1LZzzIHWgjINiD2C7DUB3cDLpn8iZBNnbGQ
         uF86omCfk7PrfP/b/DN7toJc2WvNDaHQYwjgUyTLTViuBYk7xTRoyT21RxYfZXqxHW6j
         cPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559403; x=1709164203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lre+UqQQHJdTu6yMn3GijLQ4gMqXOjZ+IEoJS056n7k=;
        b=Ic6uMtgJeoDfNifoT7kXI/UhBjRsoMhCbMhxt2piADf+DpH514S5Nv4Y9Padj6JXM1
         uppeV5k/SPUIOSlLyvs9UPZRbpxDk0uQyLja5vCNoWYtoMVCNZaJg29VPFJCHd2+nyT5
         VTjf2wDcHPDRgB82NrmoN8uflL3RqZjB9Pqyj6KwCwiO4nbD6RSQzJmVVuy5OY9gqWu6
         jDnBxBEhelu5Oa1swgWIL+gI3tsELg33dQNO0c/WAWmVJOmCWDTz8cmuahoeOJZOMBVp
         Zix3bk0uZHp2z/G/478EkZc9+eHGXGfhhj1rL0u2WLCZI93Bq9g4lLv1avmTeQzMZXFJ
         4pxA==
X-Gm-Message-State: AOJu0YwTg62NCwMmzy+ybY0mBrgkbt1FBN/VundYkSO89Z8sqQyd1MbB
	RoWaiB0W5bZAwHR8VDdUUPChZQSvu1A1nlRvXvQpE4CrdhXvvXzkF0gs7Ua7
X-Google-Smtp-Source: AGHT+IHzBLxTwT83ejaeN5GYbEyyAPkmAr8zn2RrQRiLrYkA/4Vzbw5dz0rbMxD4XQ9QGsj2VVT/sw==
X-Received: by 2002:a17:902:ce82:b0:1db:f8ef:a9e2 with SMTP id f2-20020a170902ce8200b001dbf8efa9e2mr11700757plg.47.1708559403319;
        Wed, 21 Feb 2024 15:50:03 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm8657794plb.78.2024.02.21.15.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:50:02 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/5] hugetlb: Use vmf_anon_prepare() instead of anon_vma_prepare()
Date: Wed, 21 Feb 2024 15:47:31 -0800
Message-ID: <20240221234732.187629-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221234732.187629-1-vishal.moola@gmail.com>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb_no_page() and hugetlb_wp() call anon_vma_prepare(). In
preparation for hugetlb to safely handle faults under the VMA lock,
use vmf_anon_prepare() here instead.

Additionally, passing hugetlb_wp() the vm_fault struct from hugetlb_fault()
works toward cleaning up the hugetlb code and function stack.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70c5870e859e..ae8c8b3da981 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5826,7 +5826,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  */
 static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		       unsigned long address, pte_t *ptep, unsigned int flags,
-		       struct folio *pagecache_folio, spinlock_t *ptl)
+		       struct folio *pagecache_folio, spinlock_t *ptl,
+		       struct vm_fault *vmf)
 {
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte = huge_ptep_get(ptep);
@@ -5960,10 +5961,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
 	 */
-	if (unlikely(anon_vma_prepare(vma))) {
-		ret = VM_FAULT_OOM;
+	ret = vmf_anon_prepare(vmf);
+	if (unlikely(ret))
 		goto out_release_all;
-	}
 
 	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
 		ret = VM_FAULT_HWPOISON_LARGE;
@@ -6203,10 +6203,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			new_pagecache_folio = true;
 		} else {
 			folio_lock(folio);
-			if (unlikely(anon_vma_prepare(vma))) {
-				ret = VM_FAULT_OOM;
+
+			ret = vmf_anon_prepare(vmf);
+			if (unlikely(ret))
 				goto backout_unlocked;
-			}
 			anon_rmap = 1;
 		}
 	} else {
@@ -6273,7 +6273,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl);
+		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl, vmf);
 	}
 
 	spin_unlock(ptl);
@@ -6496,7 +6496,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
 			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_folio, ptl);
+					 pagecache_folio, ptl, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			entry = huge_pte_mkdirty(entry);
-- 
2.43.0


