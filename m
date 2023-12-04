Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE380367A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345126AbjLDOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbjLDOYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018F2105
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hz7uaUsseOxwoTHd/q5qxZ6Zu8cM7Yp8tdIii7iwU6Q=;
        b=H6z3m8e/e40vfDeqZdC7U3FCCiHPCMX7LDc/oO8/KuJ6P3IEOCSfj8AD039JZ2oWoKM6CB
        vElj8bSoXa1Y8AMgHlqOAW9bZQy/zjV2OAX7XMlngvjNB23D59wuZt8cblWG8mhNWhu1pC
        J62Y6ioxuGAkYXI9HPcCRgRXFTCLZL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-2PY8J7EQOv2OTifGixg-kQ-1; Mon, 04 Dec 2023 09:22:48 -0500
X-MC-Unique: 2PY8J7EQOv2OTifGixg-kQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F0CD8314FB;
        Mon,  4 Dec 2023 14:22:47 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01FC72026D68;
        Mon,  4 Dec 2023 14:22:45 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH RFC 31/39] Documentation: stop referring to page_remove_rmap()
Date:   Mon,  4 Dec 2023 15:21:38 +0100
Message-ID: <20231204142146.91437-32-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to folio_remove_rmap_*() instaed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst       | 2 +-
 Documentation/mm/unevictable-lru.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 9a607059ea11c..cf81272a6b8b6 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -156,7 +156,7 @@ Partial unmap and deferred_split_folio()
 
 Unmapping part of THP (with munmap() or other way) is not going to free
 memory immediately. Instead, we detect that a subpage of THP is not in use
-in page_remove_rmap() and queue the THP for splitting if memory pressure
+in folio_remove_rmap_*() and queue the THP for splitting if memory pressure
 comes. Splitting will free up unused subpages.
 
 Splitting the page right away is not an option due to locking context in
diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 67f1338440a50..b6a07a26b10d5 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -486,7 +486,7 @@ munlock the pages if we're removing the last VM_LOCKED VMA that maps the pages.
 Before the unevictable/mlock changes, mlocking did not mark the pages in any
 way, so unmapping them required no processing.
 
-For each PTE (or PMD) being unmapped from a VMA, page_remove_rmap() calls
+For each PTE (or PMD) being unmapped from a VMA, folio_remove_rmap_*() calls
 munlock_vma_folio(), which calls munlock_folio() when the VMA is VM_LOCKED
 (unless it was a PTE mapping of a part of a transparent huge page).
 
@@ -511,7 +511,7 @@ userspace; truncation even unmaps and deletes any private anonymous pages
 which had been Copied-On-Write from the file pages now being truncated.
 
 Mlocked pages can be munlocked and deleted in this way: like with munmap(),
-for each PTE (or PMD) being unmapped from a VMA, page_remove_rmap() calls
+for each PTE (or PMD) being unmapped from a VMA, folio_remove_rmap_*() calls
 munlock_vma_folio(), which calls munlock_folio() when the VMA is VM_LOCKED
 (unless it was a PTE mapping of a part of a transparent huge page).
 
-- 
2.41.0

