Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB667CB3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjJPUHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjJPUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:07:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503BFA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27d18475ed4so3662601a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486817; x=1698091617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMefHNBDnWRPz8cjT6IRO34+spfB9/Lnaff9PAvwfj8=;
        b=Dzj5XIv8vdJdQHYaNnsOumoGm/nf1e2caHaM9fSBZi8iPbI1L6/WqXdb9va6k7c9ir
         qlbBEup8DLp63//3WVhhnoeg8GODyn6XLvo2d7aaoDUs671QjAWxRbfnnQ9jAUoNgPJc
         YvvmfNkLb3q04feTqLtOOmYy7GBu0aHrP9fdKjIUMknbfWoytWAao7emkagad6V8s6dP
         0m0raf+GxbiaOkUdikHFSncKuzbyXSVarJh7MLkTSRRjO0bXSTj4lD7H9nwdQXBVCkQ+
         IJl56ixYcW2ySqnmVn9cPPmY3Us7+rzZr0o7G17WIVE+9ZlFqilJ/8U8nn/zx+M7Isp+
         aqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486817; x=1698091617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMefHNBDnWRPz8cjT6IRO34+spfB9/Lnaff9PAvwfj8=;
        b=Vt98qR5CkSvUzL1+4o0jcX/ccwnhP8EuKBs6dkn+8i9boCnZmCoMEqu+CJMjlGiFDM
         luRcSygpnCYW//5SukAtH/34pSSBF82aZB14AMfSN4Tm8EiCRf+gksKAlP+IHcMuX2vg
         8iRc5LxjbRd7W+QhlzS5kLiDG8skAba84R7OMqo2XJVRsBsmHafTS2MMRjmBOciZUIDt
         h7FQVBgfb0mF5SA7WjXuT2pH4VKNOsHZH4dNhF5WJ7EQHLaqznGQZcrnyUR29hjewcZv
         aY6QJ6nJpRLQWPcuw/q3Z36odGPqNhdhECkHWNR94EZK5+qPkfcVPym3LvxViKcIeqiO
         bWAg==
X-Gm-Message-State: AOJu0Yz590taUqgQuuF2reGU9uJAFylP4AJ8C/roayi7QSzLtaBnUKUa
        GJFBjx5hvUyBhtwAzbyh53k=
X-Google-Smtp-Source: AGHT+IHA265DKTJz97l5pSxxF6Sh4mCEGazOefOWWexfxpvvfFDKrwesNxGieo7cqzTIX0SPaOQ/3w==
X-Received: by 2002:a17:90a:1959:b0:27d:10ab:2325 with SMTP id 25-20020a17090a195900b0027d10ab2325mr161116pjh.27.1697486817436;
        Mon, 16 Oct 2023 13:06:57 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090b019000b002772faee740sm5162367pjs.5.2023.10.16.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:06:57 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/5] mm/khugepaged: Convert hpage_collapse_scan_pmd() to use folios
Date:   Mon, 16 Oct 2023 13:05:07 -0700
Message-Id: <20231016200510.7387-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016200510.7387-1-vishal.moola@gmail.com>
References: <20231016200510.7387-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces 5 calls to compound_head(), and removes 1466 bytes of kernel
text.

Previously, to determine if any pte was shared, the page mapcount
corresponding exactly to the pte was checked. This gave us a precise
number of shared ptes. Using folio_estimated_sharers() instead uses
the mapcount of the head page, giving us an estimate for tail page ptes.

This means if a tail page's mapcount is greater than its head page's
mapcount, folio_estimated_sharers() would be underestimating the number of
shared ptes, and vice versa.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7a552fe16c92..67aac53b31c8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1245,7 +1245,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	pte_t *pte, *_pte;
 	int result = SCAN_FAIL, referenced = 0;
 	int none_or_zero = 0, shared = 0;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	unsigned long _address;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
@@ -1316,13 +1316,13 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		if (pte_write(pteval))
 			writable = true;
 
-		page = vm_normal_page(vma, _address, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		folio = vm_normal_folio(vma, _address, pteval);
+		if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
 
-		if (page_mapcount(page) > 1) {
+		if (folio_estimated_sharers(folio) > 1) {
 			++shared;
 			if (cc->is_khugepaged &&
 			    shared > khugepaged_max_ptes_shared) {
@@ -1332,29 +1332,27 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			}
 		}
 
-		page = compound_head(page);
-
 		/*
 		 * Record which node the original page is from and save this
 		 * information to cc->node_load[].
 		 * Khugepaged will allocate hugepage from the node has the max
 		 * hit record.
 		 */
-		node = page_to_nid(page);
+		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
 			goto out_unmap;
 		}
 		cc->node_load[node]++;
-		if (!PageLRU(page)) {
+		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
 			goto out_unmap;
 		}
-		if (PageLocked(page)) {
+		if (folio_test_locked(folio)) {
 			result = SCAN_PAGE_LOCK;
 			goto out_unmap;
 		}
-		if (!PageAnon(page)) {
+		if (!folio_test_anon(folio)) {
 			result = SCAN_PAGE_ANON;
 			goto out_unmap;
 		}
@@ -1369,7 +1367,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
 		 * will be done again later the risk seems low.
 		 */
-		if (!is_refcount_suitable(page)) {
+		if (!is_refcount_suitable(&folio->page)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
@@ -1379,8 +1377,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * enough young pte to justify collapsing the page
 		 */
 		if (cc->is_khugepaged &&
-		    (pte_young(pteval) || page_is_young(page) ||
-		     PageReferenced(page) || mmu_notifier_test_young(vma->vm_mm,
+		    (pte_young(pteval) || folio_test_young(folio) ||
+		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
 								     address)))
 			referenced++;
 	}
@@ -1402,7 +1400,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		*mmap_locked = false;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }
-- 
2.40.1

