Return-Path: <linux-kernel+bounces-167121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F548BA4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51721C2258B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B31171C;
	Fri,  3 May 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcU1fJOd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E3BE58
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697474; cv=none; b=daGxm3wuBAd1FpyIo0QtgS+2NSbJsQcUCcZOdO/Dli7FT+E6hFcpjHhFXQae6uAXAFc2umjPuakD1eQDca8vLmIjl+FoltgzLNyPIAG7l9VOFSm9Sd04FKwEmxCoVNBsA2DENdzQr3p79TtUiPDbC97EHb8MSIgm727j+M1gbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697474; c=relaxed/simple;
	bh=ZbPZGuPdHECEmvacz8mhsy2+SQbopck4uFKIvnD1TxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n87jm3vUznv0ADVtOwn+p1ptEh4CT6A3sDqRacrfokytJn/QlsziSZX5ImGCHDv75flsUy7m5vTy9ng2RRpx9/1HHdDr2yIdF/5xZxrchKxmHjTMWJWafSXngtJgc4NsVAKvyVsR27aunY7+7sWjk7ARoACiu800p0iJGtZmZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcU1fJOd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so17831065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697473; x=1715302273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTZWC4mSVwFMl/e34a7NVZCzCVLqGdUKErQlq6SYz3Y=;
        b=bcU1fJOd3Yo0cWsVowsNLFjY/9423bHgJUWDdKVh0UeKs5L3NBNG79MTisoR1nTQrU
         TZDVU4UEyYdfzXDo3gQFaAxCGMV4/uRvwUW6d58oUBp3NUJHs7iZmDu5kQ297kGe+xHw
         5cBx8yG2lGoxnpIxFNE8eZfdp4FDsfVp37v8SFY4gbJmGIVD7BmKKmoPcjzhPj/4HbxT
         VgFpYkmHx4MRmPUhBZ9sSQolD27+1GgDVgpNC5cFqJhhq19rwHnajoZ/xHxRaD6xUXbg
         oEw2+HycVlyT2PjIGQoHsC98scKeODMG2ySYrw79qOk0t+rHrSALBQX1evxgRXOqNbMR
         3WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697473; x=1715302273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTZWC4mSVwFMl/e34a7NVZCzCVLqGdUKErQlq6SYz3Y=;
        b=XxDyQpX9xQ2TVrTomVxbOun4kTFZwm/gQN0SziOpxPmQPG1kAun01v1OXuwJENcimF
         eBIKL6+/+RkG1iy92+gTEXD3bEgK4bdpgqK22Ok/oz8z6oz7kOW55iQAHrPXh7asxkhx
         nLY83roLP3KdW9YL8ZmFSrCD4F4YHiwRNjsE5GJ2HrHwm6zyQx/uWclGAd6gFZLsVZva
         bHPWJuoMn4ofJRJHhZjIpW6X5WxQaVlgfapBUW5ajSLtInviaO+IlOhJpKEU5ApBBKD9
         oO2ZkVBIDCRgV3kyW7GxmQ8GPyX36av2G1IgKgOIcnjRV4gUKc7Z24ojiQGX3T4GoRor
         jXfw==
X-Forwarded-Encrypted: i=1; AJvYcCWn0KvoZwK9HsL3TSl2/CMHeRzDfIK/i8K7XRn2odnc3g1XwJ+H1piJIUYo/BZCPgZBNVFfUORSD9wn4LRiV5xuakZ0Zl5eMQWDBNMu
X-Gm-Message-State: AOJu0YxvZ9YPGTBP7sJex3425459D8WU8j6MZ7KRt8NotjKVlnU6SXdV
	pJS1meOUWMVc2B3Zkrrq5xLhqTlLBSmzJ+GuFzJ4W/vHb963USw7
X-Google-Smtp-Source: AGHT+IF6KPbkDG4oPcXF3nnGu2vkHcu3vUbx1MmrFOaaiRUAVvVI/eyC0SeYLYYd7YsLphvtZmA6tw==
X-Received: by 2002:a17:902:ecc4:b0:1e4:59a2:d7c1 with SMTP id a4-20020a170902ecc400b001e459a2d7c1mr6562669plh.33.1714697472877;
        Thu, 02 May 2024 17:51:12 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:51:12 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v3 4/6] mm: introduce arch_do_swap_page_nr() which allows restore metadata for nr pages
Date: Fri,  3 May 2024 12:50:21 +1200
Message-Id: <20240503005023.174597-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503005023.174597-1-21cnbao@gmail.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Should do_swap_page() have the capability to directly map a large folio,
metadata restoration becomes necessary for a specified number of pages
denoted as nr. It's important to highlight that metadata restoration is
solely required by the SPARC platform, which, however, does not enable
THP_SWAP. Consequently, in the present kernel configuration, there
exists no practical scenario where users necessitate the restoration of
nr metadata. Platforms implementing THP_SWAP might invoke this function
with nr values exceeding 1, subsequent to do_swap_page() successfully
mapping an entire large folio. Nonetheless, their arch_do_swap_page_nr()
functions remain empty.

Cc: Khalid Aziz <khalid.aziz@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/pgtable.h | 26 ++++++++++++++++++++------
 mm/memory.c             |  3 ++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..463e84c3de26 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1084,6 +1084,15 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 })
 
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
+static inline void arch_do_swap_page_nr(struct mm_struct *mm,
+				     struct vm_area_struct *vma,
+				     unsigned long addr,
+				     pte_t pte, pte_t oldpte,
+				     int nr)
+{
+
+}
+#else
 /*
  * Some architectures support metadata associated with a page. When a
  * page is being swapped out, this metadata must be saved so it can be
@@ -1092,12 +1101,17 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
  * page as metadata for the page. arch_do_swap_page() can restore this
  * metadata when a page is swapped back in.
  */
-static inline void arch_do_swap_page(struct mm_struct *mm,
-				     struct vm_area_struct *vma,
-				     unsigned long addr,
-				     pte_t pte, pte_t oldpte)
-{
-
+static inline void arch_do_swap_page_nr(struct mm_struct *mm,
+					struct vm_area_struct *vma,
+					unsigned long addr,
+					pte_t pte, pte_t oldpte,
+					int nr)
+{
+	for (int i = 0; i < nr; i++) {
+		arch_do_swap_page(vma->vm_mm, vma, addr + i * PAGE_SIZE,
+				pte_advance_pfn(pte, i),
+				pte_advance_pfn(oldpte, i));
+	}
 }
 #endif
 
diff --git a/mm/memory.c b/mm/memory.c
index f033eb3528ba..74cdefd58f5f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4266,7 +4266,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
+			pte, vmf->orig_pte, 1);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
-- 
2.34.1


