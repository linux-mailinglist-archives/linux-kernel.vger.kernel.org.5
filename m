Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD78E7CE908
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjJRUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjJRUdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57DAFA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso3846614b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661189; x=1698265989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/rAUjlYbudj5wnw8lHkufWutUwYDRgsClPJWjawwgo=;
        b=MKd7LRLb6+ZMZprnyBlKS4S+XjCnoMmygPQog3kGNI4uLAsu9cBckzlC6MUMCOb/Vw
         pZqOh+xDE032cHk9gMgAkK0MCQ0OHsNaf/4cvzih3HhNfbKIz10VLmdqfsT38G+E1DAV
         VnRfmmv5bwMBfqa2bt+WfUA1RA5hci54RZQMFiuWaF9r7L3Xma9jDfmTTA4QJ+2362Bz
         fEEDoDOgxYM0eGHGQBECF3roZcIgtkS9+F+X70OTQ/v7kzhJaoHs6bmbw2/4akYsmU6j
         2SV3jS2sVB7iQb0GusvOIBT5Ebpgv+BNjoa/KLo/CPyqq04FLtXpRiww1lSGgTxGoNYF
         Q9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661189; x=1698265989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/rAUjlYbudj5wnw8lHkufWutUwYDRgsClPJWjawwgo=;
        b=r38T5YNIhBDWJa02SisyJJ+yfvpnHL1o49XLqimR8uYPIENUp+zblOsql7fJmbUlzV
         +eGnpnYwf/woguOspcJwmr9P/ImrtdmnfmTfu3f/kTIlCGB3mhEnGHpxdde/+T+5Mkpa
         PLtTzqC0ggYb/kqMtkF+Ggmk1fImpqeiAuiUNCy2H2UyDSUTeitanhSC9NJNoHhqI5il
         uEUhbk9sObtD2JtmXLAR5F33eaf+H/vKT+VNMAcEIHzIcuQfOm92VMdMb1divDx2rKSi
         oby3JE9Rym04KChgf0nwYqsTwOGQaLZzdpKwXhhPomIE0B3cbU0xk7hvIfZ9GHc0XpXz
         GE4A==
X-Gm-Message-State: AOJu0YyrLBLoZGJL3YVqrJJFXAp4Fkk9btvBZPgUVLr+R4/mIndgJ57D
        fdQMv+La5O96wtr+BVpHG6k=
X-Google-Smtp-Source: AGHT+IHHKufGkhuDo4UJftnY7SwsN1FFsHrItzDWiS842QRY9mPhF1ZSrMfqcuvk3t7Vnjm0ZSWi9g==
X-Received: by 2002:a05:6a21:3e0b:b0:171:c88a:890c with SMTP id bk11-20020a056a213e0b00b00171c88a890cmr269714pzc.25.1697661189243;
        Wed, 18 Oct 2023 13:33:09 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id w12-20020a170902d3cc00b001c61e628e9dsm354412plb.77.2023.10.18.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:33:08 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/5] mm/khugepaged: Convert is_refcount_suitable() to use folios
Date:   Wed, 18 Oct 2023 13:32:11 -0700
Message-Id: <20231018203213.50224-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018203213.50224-1-vishal.moola@gmail.com>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
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

Both callers of is_refcount_suitable() have been converted to use
folios, so convert it to take in a folio. Both callers only operate on
head pages of folios so mapcount/refcount conversions here are trivial.

Removes 3 calls to compound head, and removes 315 bytes of kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c4b5af43371..9efd8ff68f06 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -524,15 +524,15 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	}
 }
 
-static bool is_refcount_suitable(struct page *page)
+static bool is_refcount_suitable(struct folio *folio)
 {
 	int expected_refcount;
 
-	expected_refcount = total_mapcount(page);
-	if (PageSwapCache(page))
-		expected_refcount += compound_nr(page);
+	expected_refcount = folio_mapcount(folio);
+	if (folio_test_swapcache(folio))
+		expected_refcount += folio_nr_pages(folio);
 
-	return page_count(page) == expected_refcount;
+	return folio_ref_count(folio) == expected_refcount;
 }
 
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
@@ -625,7 +625,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * but not from this process. The other process cannot write to
 		 * the page, only trigger CoW.
 		 */
-		if (!is_refcount_suitable(&folio->page)) {
+		if (!is_refcount_suitable(folio)) {
 			folio_unlock(folio);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
 		 * will be done again later the risk seems low.
 		 */
-		if (!is_refcount_suitable(&folio->page)) {
+		if (!is_refcount_suitable(folio)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
-- 
2.40.1

