Return-Path: <linux-kernel+bounces-53809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960284A6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF0028FA5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090055E70;
	Mon,  5 Feb 2024 19:19:04 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9A54FAD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160743; cv=none; b=t3G8XVNGjjLp2jelOJOBXcOZMZTK88Jm6gr9VLNHWktjjs9vFeWQ3DhVK0vJZ/GrZR6c/57/rfSctvEWh2AfZIDB/1FdkTq/HRn5/Yqh2c3+rAFINYMsrQPx4N4zTsgvhCnBXFryq7Mh6k3DFFxy00plHjmHYGKJlGgZ+Apw+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160743; c=relaxed/simple;
	bh=lNsOXfwBd5Jg1UhnYbBG016w4D6gifAwE1Om4ooiUaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZMF/j2SVnEu4Fi/KJPnk9aIPYtMeBlgBlnqOQBgKCvhblysTq1vrIHT8viTJwEIgSwXv3VYltyxc0gFKFl3TAsISqQe/hzuY0Uq9IS9jyswen4D5P61KurMsTirT9PpDnyrqKvSG/zpkzW6FmrTKmgQMKnQq1vZbHyTnxWcQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so6840048a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160738; x=1707765538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YfrI5usOrBhq2NBpdCHSIDWPFSL+4qU1L11CadSm6A=;
        b=q/DzHxx93FTlg22LGbVc+BqK5LvklxMEXEIogvuoyncWWocL9f3KyGYDhG4Lvy5tfP
         DLdOOQpRTFtqDQmy1Y7Sv1q7hVZetzDpjSsxzzhPslS8F6LWtd5FmbnHRqLMQk40/GVn
         XHVi7p9B0Q73AqFahfjdQTwvX2XJoL6MsmFdtr4J9pYNNQpTXCB+t/LnuyC4dvrpfOIB
         kFOdWLRUJKk9Pq/bm9MFZaoen1RuOsogwqeU3U1Fvo0BdlGArW2sSz3882Af8xLuIpy9
         zkPZoKApvVI3rmlRa/5srZ/kvxIsnD9DMOcQFO8Syr23OstADrkMdN/fh/UI7Ng0zbUd
         /oAg==
X-Gm-Message-State: AOJu0YwM7BgfiRMyBlZL4FoKoxeu5B2Roy96bgvWHtwLOMG40zkHVeTE
	agI6TybYVT13PfpxDeuGkzPVsWJNg+M6YDVQvEB5SFYbSPfC8uk8
X-Google-Smtp-Source: AGHT+IFgHGSXN1+B6BcH3MtCqD1qFGb9lFA9lq3vDOdsEG6QnqMggULNf8ZrBeQOV4xk1iJaLYSJZw==
X-Received: by 2002:a17:907:7746:b0:a28:d1f9:976 with SMTP id kx6-20020a170907774600b00a28d1f90976mr228274ejc.65.1707160737874;
        Mon, 05 Feb 2024 11:18:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXVm5RKPt+Hlz22NnQj7TZfmCmCPsU/XvEaNZ9YvFqmT9hiTOEBxbGNZw9X7DUtafu4eEfhaq4K6nUvuLarSkrwmFkypvNZGY7hG96yJ7PZzbhjJLZtnmzXOjqjEQrp5aPiBokhkMhhB+dDl40ykJWzz4TeDugPTAoqJy4oRsQdUAiyiMpxskMZnvCEJLgVgWHWUpMb0kUD6GNkKfx97LTrv7PzZIWgemoQZ9XX3oX1jL7wXkGnMuJesFH0OUtC1S74UkOpFrdBMgKDHDmUuuWS4PsAOYHq/7o9vAVwvNpkrvZI9hK79X4KJPuwIP9BKcVJr2B9i0CxaPS8
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906134f00b00a372b38380csm167637ejb.13.2024.02.05.11.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:18:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mike.kravetz@oracle.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: lstoakes@gmail.com,
	willy@infradead.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v2 1/2] mm/hugetlb: Restore the reservation if needed
Date: Mon,  5 Feb 2024 11:18:41 -0800
Message-Id: <20240205191843.4009640-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205191843.4009640-1-leitao@debian.org>
References: <20240205191843.4009640-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is a bug that a huge page could be stolen, and when the
original owner tries to fault in it, it causes a page fault.

You can achieve that by:
  1) Creating a single page
	echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

  2) mmap() the page above with MAP_HUGETLB into (void *ptr1).
	* This will mark the page as reserved
  3) touch the page, which causes a page fault and allocates the page
	* This will move the page out of the free list.
	* It will also unreserved the page, since there is no more free
	  page
  4) madvise(MADV_DONTNEED) the page
	* This will free the page, but not mark it as reserved.
  5) Allocate a secondary page with mmap(MAP_HUGETLB) into (void *ptr2).
	* it should fail, but, since there is no more available page.
	* But, since the page above is not reserved, this mmap() succeed.
  6) Faulting at ptr1 will cause a SIGBUS
	* it will try to allocate a huge page, but there is none
	  available

A full reproducer is in selftest. See
https://lore.kernel.org/all/20240105155419.1939484-1-leitao@debian.org/

Fix this by restoring the reserved page if necessary.

These are the condition for the page restore:

 * The system is not using surplus pages. The goal is to reduce the
   surplus usage for this case.
 * If the VMA has the HPAGE_RESV_OWNER flag set, and is PRIVATE. This is
   safely checked using __vma_private_lock()
 * The page is anonymous

Once this is scenario is found, set the `hugetlb_restore_reserve` bit in
the folio. Then check if the resv reservations need to be adjusted
later, done later, after the spinlock, since the vma_xxxx_reservation()
might touch the file system lock.

Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/hugetlb.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..44f1e6366d04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5585,6 +5585,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
+	bool adjust_reservation = false;
 	unsigned long last_addr_mask;
 	bool force_flush = false;
 
@@ -5677,7 +5678,31 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		hugetlb_remove_rmap(page_folio(page));
 
+		/*
+		 * Restore the reservation for anonymous page, otherwise the
+		 * backing page could be stolen by someone.
+		 * If there we are freeing a surplus, do not set the restore
+		 * reservation bit.
+		 */
+		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
+		    folio_test_anon(page_folio(page))) {
+			folio_set_hugetlb_restore_reserve(page_folio(page));
+			/* Reservation to be adjusted after the spin lock */
+			adjust_reservation = true;
+		}
+
 		spin_unlock(ptl);
+
+		/*
+		 * Adjust the reservation for the region that will have the
+		 * reserve restored. Keep in mind that vma_needs_reservation() changes
+		 * resv->adds_in_progress if it succeeds. If this is not done,
+		 * do_exit() will not see it, and will keep the reservation
+		 * forever.
+		 */
+		if (adjust_reservation && vma_needs_reservation(h, vma, address))
+			vma_add_reservation(h, vma, address);
+
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
 		 * Bail out after unmapping reference page if supplied
-- 
2.34.1


