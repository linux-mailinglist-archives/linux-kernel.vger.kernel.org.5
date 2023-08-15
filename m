Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAA77D4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjHOVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjHOVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28CB113
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692133623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kLOX7N0vMFqXo1EtRz1ImdE1j/Euy4flwOdsfxvmLk0=;
        b=GOric8T1HmQGjLFtp+PLxZkmcmbx8z/6F0CPK8Zw+eZiphDbddK8uBQ4as2dr/uZfQ+wSm
        BHbqxxm5dGXHlXdo5MoftciwgE2FghHKdcPcUy7BTOH2zfGOCAy6YywgZZQKEhF8X4mmhZ
        YG/LssYxXhkXIsL8XRw2ilaSsnwkO4g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-dh3omyljMxCPQ9TnJS85Fw-1; Tue, 15 Aug 2023 17:07:02 -0400
X-MC-Unique: dh3omyljMxCPQ9TnJS85Fw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c7cffef41so159612885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133622; x=1692738422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLOX7N0vMFqXo1EtRz1ImdE1j/Euy4flwOdsfxvmLk0=;
        b=eFkvmDDA/d/kT+kC6Rp+Aa4bX58CzCHbUr4xw0fbZ3eWCjGq59pPYE13K51qAikAYV
         bOzY89b/GSSwI7bmtCx+bzvE0/SKjBkhjhp6DXsuJsiRElis8g+kYjc6sOQitLTKK4Dj
         yLP8oGhzjuZxNxY2ywyXNbkJ5YoibCuKIanDnzyqKtxjstTSnZzjbLM+c4eKrzbDQbUA
         VtqPdCga2T1Ynd4BybthLkSWeWUrqoTy8o+Ejjr2O3rrxqrn/yxbPN6/KiOc2NYZkTib
         zrHuO7cj6J//UlnGar3riNHgn+JX9BE5Y6c1tWAPm0BrPrqCPP5SfYyGn/QiUENVBdHg
         yf2g==
X-Gm-Message-State: AOJu0YzuaU8okouJpli2VnowVjgLCxZ5s4k2ayUvJeSaZR9BDhd6mkdj
        XxwzFhb4Mb2A4QCF8pjjzE0wwyfzsD+ow2bEehbczZBpFtceIPvEccvIsT/z3beNRbGmG17Xhmv
        Vo/AFOxhCjWV4rLbHU9191I5J
X-Received: by 2002:a05:620a:468e:b0:767:f284:a3dd with SMTP id bq14-20020a05620a468e00b00767f284a3ddmr41700qkb.1.1692133621734;
        Tue, 15 Aug 2023 14:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEcCv3uoT2IKvIJjms4jW7lCugZw9SlWsaem1IA3br6gn+D7JChEUxAoSuxIzqYuGHU1tHEQ==
X-Received: by 2002:a05:620a:468e:b0:767:f284:a3dd with SMTP id bq14-20020a05620a468e00b00767f284a3ddmr41669qkb.1.1692133621386;
        Tue, 15 Aug 2023 14:07:01 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id v13-20020ae9e30d000000b0076aeeb69cb1sm4010955qkf.4.2023.08.15.14.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:07:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: Wire up tail page poisoning over ->mappings
Date:   Tue, 15 Aug 2023 17:06:59 -0400
Message-ID: <20230815210659.430010-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tail pages have a sanity check on ->mapping fields, not all of them but
only upon index>2, for now.  It's because we reused ->mapping fields of the
tail pages index=1,2 for other things.

Define a macro for "max index of tail pages that got ->mapping field
reused" on top of folio definition, because when we grow folio tail pages
we'd want to boost this too together.

Then wire everything up using that macro.

Don't try to poison the ->mapping field in prep_compound_tail() for tail
pages <=TAIL_MAPPING_REUSED_MAX because it's wrong.  For example, the 1st
tail page already reused ->mapping field as _nr_pages_mapped.  It didn't
already blow up only because we luckily always prepare tail pages before
preparing the head, then prep_compound_head() will update
folio->_nr_pages_mapped so as to void the poisoning.  This should make it
always safe again, even e.g. if we prep the head first.

Clean up free_tail_page_prepare() along the way on checking ->mapping
poisoning to also leverage the new macro.

Signed-off-by: Peter Xu <peterx@redhat.com>
---

I split this out from another rfc series.  Removed RFC tag because it
wasn't for this patch but for the documentation updates.  I'll post the rfc
part alone.  Comments welcomed, thanks.
---
 include/linux/mm_types.h | 11 +++++++++++
 mm/huge_memory.c         |  6 +++---
 mm/internal.h            |  3 ++-
 mm/page_alloc.c          | 28 +++++++++++-----------------
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 291c05cacd48..81456fa5fda5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -248,6 +248,17 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
 	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
 }
 
+/*
+ * This macro defines the maximum tail pages (of a folio) that can have the
+ * page->mapping field reused.
+ *
+ * When the tail page's mapping field reused, it'll be exempted from
+ * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
+ *
+ * When grow the folio struct, please consider growing this too.
+ */
+#define  TAIL_MAPPING_REUSED_MAX  (2)
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0b709d2c46c6..72f244e16dcb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2444,9 +2444,9 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_dirty) |
 			 LRU_GEN_MASK | LRU_REFS_MASK));
 
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
+	/* ->mapping in <=TAIL_MAPPING_REUSED_MAX tail pages are reused */
+	VM_BUG_ON_PAGE(tail > TAIL_MAPPING_REUSED_MAX &&
+		       page_tail->mapping != TAIL_MAPPING, page_tail);
 	page_tail->mapping = head->mapping;
 	page_tail->index = head->index + tail;
 
diff --git a/mm/internal.h b/mm/internal.h
index 02a6fd36f46e..a75df0bd1f89 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -428,7 +428,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 {
 	struct page *p = head + tail_idx;
 
-	p->mapping = TAIL_MAPPING;
+	if (tail_idx > TAIL_MAPPING_REUSED_MAX)
+		p->mapping = TAIL_MAPPING;
 	set_compound_head(p, head);
 	set_page_private(p, 0);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 96b7c1a7d1f2..7ab7869f3c7f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -990,7 +990,7 @@ static inline bool is_check_pages_enabled(void)
 static int free_tail_page_prepare(struct page *head_page, struct page *page)
 {
 	struct folio *folio = (struct folio *)head_page;
-	int ret = 1;
+	int ret = 1, index = page - head_page;
 
 	/*
 	 * We rely page->lru.next never has bit 0 set, unless the page
@@ -1002,9 +1002,9 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 		ret = 0;
 		goto out;
 	}
-	switch (page - head_page) {
-	case 1:
-		/* the first tail page: these may be in place of ->mapping */
+
+	/* Sanity check the first tail page */
+	if (index == 1) {
 		if (unlikely(folio_entire_mapcount(folio))) {
 			bad_page(page, "nonzero entire_mapcount");
 			goto out;
@@ -1017,20 +1017,14 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero pincount");
 			goto out;
 		}
-		break;
-	case 2:
-		/*
-		 * the second tail page: ->mapping is
-		 * deferred_list.next -- ignore value.
-		 */
-		break;
-	default:
-		if (page->mapping != TAIL_MAPPING) {
-			bad_page(page, "corrupted mapping in tail page");
-			goto out;
-		}
-		break;
 	}
+
+	/* Sanity check the rest tail pages over ->mapping */
+	if (index > TAIL_MAPPING_REUSED_MAX && page->mapping != TAIL_MAPPING) {
+		bad_page(page, "corrupted mapping in tail page");
+		goto out;
+	}
+
 	if (unlikely(!PageTail(page))) {
 		bad_page(page, "PageTail not set");
 		goto out;
-- 
2.41.0

