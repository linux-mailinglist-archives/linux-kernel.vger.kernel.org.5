Return-Path: <linux-kernel+bounces-29260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE7830BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26EC1C24C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2022EFC;
	Wed, 17 Jan 2024 17:11:18 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C45219F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511477; cv=none; b=Pt5V2rBrG//JYjkV96bShddfe4xXD14/4KSDZcwVlbJhwFrnOGElv7wNU/4nTG0W5Z4kNPhJgpQAwZpz107l4u6Tb36ZZ8/0SCafuASZr9ZnCeltw1noIVDdFE4v5gyC3Aog0nl6KmrVFHqFbvz5syNpL8yKP8rtYv+GZl+Ecow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511477; c=relaxed/simple;
	bh=yRA1Nvwd9G6y3dgBa4YVeXvCTThqtHdsWY4phzrl/lU=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=ETRoc3nAzSX6BsotQ4rv7t2KIggpG/5P6nTC1Fdx+0+KtltJbCbrgjjWfqebaxGDWJ39MlpfEbvi/EQl+5xx4tbqziEFkuAqhATFtiXmCln7zwuneqxiTlDYkCsrFyVYWrPkL0YgThC/GJ2MuW6znBK5DQi8WA+juHGz+jwC2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so45619051fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511470; x=1706116270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJ2+XhKbom46b/fZIunrod77ylLhDHU0KUj29SPzLh4=;
        b=vwdWkgtHd4seFqFnUmJlABO4C3L8YNkXaReU8LVSlF31/uivSN/5sphvM4gSSjhG1e
         tq4S4g6cUcha00b7nAJEv7ME44guUvYva3vg63mKcbUAVrS1ZWXSNk64vSzQC3Bfeto8
         YG56LzyaxOjpaYaXuCKQ5V0H2crcq31gbIm90zkALlMusTvBs/mWtV+EMFqKu0pZ0J40
         wG+tXGbp4xi7awBiUx+p74rk+J7LET3iwnBPXh9n9tdK8u1e/A364I7bwSQIZse4f5v5
         PVU+00DHqYV9Oz+n85ibrMKPoP+R7JXL0wCIlqqvqygi8XqI2gBH9nKZ+wq1AoRVcOtx
         G4Gw==
X-Gm-Message-State: AOJu0YxduqKDx6P+1npHO5/GrU6Z/HPpwRvJ07kE15XKqa+3uYf2sPzV
	V/mp4lEWfV5tjleDB81a/0Q/yTuNzTc=
X-Google-Smtp-Source: AGHT+IFnH/+Zuk1XVIOMFL+q8gzXbBl2P9gmGhC9CO69p0IDBMTR+CLJKJ8hp3Wk4bGMy/MrxkhFTg==
X-Received: by 2002:a2e:7d12:0:b0:2cd:98e3:42b3 with SMTP id y18-20020a2e7d12000000b002cd98e342b3mr3866977ljc.24.1705511469837;
        Wed, 17 Jan 2024 09:11:09 -0800 (PST)
Received: from localhost (fwdproxy-cln-025.fbsv.net. [2a03:2880:31ff:19::face:b00c])
        by smtp.gmail.com with ESMTPSA id i13-20020a05640200cd00b00559c71e70e3sm1547951edu.79.2024.01.17.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:11:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: lstoakes@gmail.com,
	willy@infradead.org,
	mike.kravetz@oracle.com,
	Rik van Riel <riel@surriel.com>,
	linux-mm@kvack.org (open list:HUGETLB SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] mm/hugetlb: Restore the reservation if needed
Date: Wed, 17 Jan 2024 09:10:57 -0800
Message-Id: <20240117171058.2192286-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
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

Fix this by restoring the reserved page if necessary. If the page being
unmapped has HPAGE_RESV_OWNER set, and needs a reservation, set the
restore_reserve flag, which will move the page from free to reserved.

Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..fa2c17767e44 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5677,6 +5677,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		hugetlb_remove_rmap(page_folio(page));
 
+		if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
+		    vma_needs_reservation(h, vma, start)) {
+			/*
+			 * Restore the reservation if needed, otherwise the
+			 * backing page could be stolen by someone.
+			 */
+			folio_set_hugetlb_restore_reserve(page_folio(page));
+			vma_add_reservation(h, vma, address);
+		}
+
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
-- 
2.34.1


