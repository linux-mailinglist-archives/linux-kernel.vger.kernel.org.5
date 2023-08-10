Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8528778258
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjHJUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHJUue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB9A26B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691700588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=twG+q7cbfuF1o8nPNGdWUOVnURcUNrjYBfUqioHjJMs=;
        b=PowZlmv/OHsWTnozFA6hngcud0cDPxdTNguaVkWNXicU/GhH+CJ7ndv1JsE6vF/gPwNCxC
        w3rFm+xdpcr+KfEWssTMowtO/KQDxcTvUa0s3ccA4Rak+PyxIxrWNdg3XdzjoBas2OBjan
        Q74+RT6QcmNPeIbHi+8UJoUAiSVGWOU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-HoYJMqqiOpWsbfDm1vmKTA-1; Thu, 10 Aug 2023 16:49:46 -0400
X-MC-Unique: HoYJMqqiOpWsbfDm1vmKTA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63c9463c116so3104936d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691700586; x=1692305386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twG+q7cbfuF1o8nPNGdWUOVnURcUNrjYBfUqioHjJMs=;
        b=gmV44QBeqo81qhTli5J6BcP5Oq38QZVyRGJyu0d6vOo3zPHxRhGZZ/zcJjEwyjdJuh
         HivSHzv3tClp/0CW2CSW6jBqznK9NoALZh15vG/LNhOmgfr4irqR/14QfkjenJT7PgT3
         KLZiO3cNTTJOny5IKjE6bSUSK9RZNjhPTJlsYhbYHVzI+GcjVLSpD9Jg5+HmCvBtxXTE
         VToUNtw+Zt6qPin2pEe8JedR8Me1jB3lddT6V0cdyjPb71j6RMXsKL6/CrkolwIkiKfQ
         K4LPk5WaU/abQ8tT2TJnDAAIkSUrgutD12h8eGEO1Hgzc+lWIKpPHQgThuWipbJTRxdr
         ju7w==
X-Gm-Message-State: AOJu0YzNyeX5LSGftHJaAYOrQ9TG4wHnJob9y3A94wj/CZzHflBSkGJo
        QXojooLoRTVxOehr8UkrbSdXJ7b6d0N61JkJHC1E9hnMCjwGlWQyMYJXj5NENNIKu2ZguxSSzX1
        GJGEutqJsFGjTMRqJHs7vHzZt
X-Received: by 2002:a05:6214:27ed:b0:635:d9d0:cccf with SMTP id jt13-20020a05621427ed00b00635d9d0cccfmr4044676qvb.4.1691700586353;
        Thu, 10 Aug 2023 13:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmW/SINYdRW0UebQer9MB54j7EytzBwLKLgVYOQdYahy9ap+ZF0QtarVBAYlcOErHJsaif0g==
X-Received: by 2002:a05:6214:27ed:b0:635:d9d0:cccf with SMTP id jt13-20020a05621427ed00b00635d9d0cccfmr4044654qvb.4.1691700586007;
        Thu, 10 Aug 2023 13:49:46 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t12-20020a0cde0c000000b0062fffa42cc5sm736170qvk.79.2023.08.10.13.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:49:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH RFC] mm: Properly document tail pages for compound pages
Date:   Thu, 10 Aug 2023 16:49:44 -0400
Message-ID: <20230810204944.53471-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tail page struct reuse is over-comlicated.  Not only because we have
implicit uses of tail page fields (mapcounts, or private for thp swap
support, etc., that we _may_ still use in the page structs, but not obvious
the relationship between that and the folio definitions), but also because
we have 32/64 bits layouts for struct page so it's unclear what we can use
and what we cannot when trying to find a new spot in folio struct.

We also have tricks like page->mapping, where we can reuse only the tail
page 1/2 but nothing more than tail page 2.  It is all mostly hidden, until
someone starts to read into a VM_BUG_ON_PAGE() of __split_huge_page_tail().

Let's document it clearly on what we can use and what we can't, with 100%
explanations on each of them.  Hopefully this will make:

  (1) Any reader to know exactly what field is where and for what, the
      relationships between folio tail pages and struct page definitions,

  (2) Any potential new fields to be added to a large folio, so we're clear
      which field one can still reuse (look for _reserved* ones).

This is assuming WORD is defined as sizeof(void *) on any archs, just like
the other comment in struct page we already have.

One pitfall is I'll need to split part of the tail page 1 definition into
32/64 bits differently, that introduced some duplications on the fields.
But hopefully that's worthwhile as it makes everything crystal clear.  Not
to mention that "pitfall" also brings a benefit that we can actually define
fields in different order for 32/64 bits when we want.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 76 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 291c05cacd48..3e40e1b9fec3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -313,41 +313,99 @@ struct folio {
 		};
 		struct page page;
 	};
+	/*
+	 * Some of the tail page fields (out of 8 WORDs for either 32/64
+	 * bits archs) may not be reused by the folio object because
+	 * they're already been used by the page struct:
+	 *
+	 * |-------+---------------|
+	 * | Index | Field         |
+	 * |-------+---------------|
+	 * |     0 | flag          |
+	 * |     1 | compound_head |
+	 * |     2 | N/A [0]       |
+	 * |     3 | mapping [1]   |
+	 * |     4 | N/A [0]       |
+	 * |     5 | private [2]   |
+	 * |     6 | mapcount      |
+	 * |     7 | N/A [0]       |
+	 * |-------+---------------|
+	 *
+	 * [0] "N/A" marks fields that are available to leverage for the
+	 *     large folio.
+	 *
+	 * [1] "mapping" field is only used for sanity check, see
+	 *     TAIL_MAPPING.  Still valid to use for tail pages 1/2.
+	 *     (for that, see __split_huge_page_tail()).
+	 *
+	 * [2] "private" field is used when THP_SWAP is on (disabled on 32
+	 *     bits, or on hugetlb folios) .
+	 */
 	union {
 		struct {
+	/* WORD 0-1: not valid to reuse */
 			unsigned long _flags_1;
 			unsigned long _head_1;
-	/* public: */
+	/* WORD 2 */
 			unsigned char _folio_dtor;
 			unsigned char _folio_order;
+			unsigned char _holes_1[2];
+#ifdef CONFIG_64BIT
 			atomic_t _entire_mapcount;
+	/* WORD 3 */
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
-#ifdef CONFIG_64BIT
+	/* WORD 4 */
 			unsigned int _folio_nr_pages;
+			unsigned int _reserved_1_1;
+	/* WORD 5-6: not valid to reuse */
+			unsigned long _used_1_2[2];
+	/* WORD 7 */
+			unsigned long _reserved_1_2;
+#else
+	/* WORD 3 */
+			atomic_t _entire_mapcount;
+	/* WORD 4 */
+			atomic_t _nr_pages_mapped;
+	/* WORD 5: only valid for 32bits */
+			atomic_t _pincount;
+	/* WORD 6: not valid to reuse */
+			unsigned long _used_1_2;
+	/* WORD 7 */
+			unsigned long _reserved_1;
 #endif
-	/* private: the union with struct page is transitional */
 		};
+	/* private: the union with struct page is transitional */
 		struct page __page_1;
 	};
 	union {
 		struct {
+	/* WORD 0-1: not valid to reuse */
 			unsigned long _flags_2;
 			unsigned long _head_2;
-	/* public: */
+	/* WORD 2-5 */
 			void *_hugetlb_subpool;
 			void *_hugetlb_cgroup;
 			void *_hugetlb_cgroup_rsvd;
 			void *_hugetlb_hwpoison;
-	/* private: the union with struct page is transitional */
+	/* WORD 6: not valid to reuse */
+			unsigned long _used_2_2;
+	/* WORD 7: */
+			unsigned long _reserved_2_1;
 		};
 		struct {
-			unsigned long _flags_2a;
-			unsigned long _head_2a;
-	/* public: */
+	/* WORD 0-1: not valid to reuse */
+			unsigned long _used_2_3[2];
+	/* WORD 2-3: */
 			struct list_head _deferred_list;
-	/* private: the union with struct page is transitional */
+	/* WORD 4: */
+			unsigned long _reserved_2_2;
+	/* WORD 5-6: not valid to reuse */
+			unsigned long _used_2_4[2];
+	/* WORD 7: */
+			unsigned long _reserved_2_3;
 		};
+	/* private: the union with struct page is transitional */
 		struct page __page_2;
 	};
 };
-- 
2.41.0

