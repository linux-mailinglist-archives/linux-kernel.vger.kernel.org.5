Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E470377BFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHNSqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHNSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7510E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K80vu1sJx9DsGDhSbLEtYPGEOnTcZDHaiO/EYxwWGMs=;
        b=fbQSv4J5KHS/2o9bfz8Lt3QMVzKIOgzNx551g2odm4L4DyPmH1Yg1SrBylhffwBGKZMLST
        9Gwg+YO8UyqP4FtGL6VIi7GlXGU9smmUKVVJjMi2QHYUoUEw/e3oXzHbAgl8U4PGHFny0l
        ARNUHPJmIDStXt/JVHUdiCKiOd9l+lc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-Va5E3wmONzmu4YhfHT9VdQ-1; Mon, 14 Aug 2023 14:44:15 -0400
X-MC-Unique: Va5E3wmONzmu4YhfHT9VdQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-64726969c8bso2206096d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038655; x=1692643455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K80vu1sJx9DsGDhSbLEtYPGEOnTcZDHaiO/EYxwWGMs=;
        b=QMUwAVCZkToQaJOnWDz+7aZX7+uKd+r2Hfo32x43/mxlBdkLqVycBc/vU0bSMQ31w4
         7UuBPHZ/51qnjDRA8EXLdcENYUmaF6sqSJMpEqj1he1kR6KhdtHx+u25GYhQIk1ngPyz
         ubPJ0XEPzTzoAsqBniVvMQwT3b1kM4KNBI+Y1h+ARJDoZADhBowX9lx12v2zDjEnCeqv
         gHc3yAf4/WdjtvZ+5V+L0buyIBYy2TrBzNCgKbzTElFso43rUzWGynrpoVFEpKx5Hdmv
         1SpIosXBvJvydRrWKSOocA/qYjZugsSGXpZoOILBU8ZPzm7CTPnIkJLkYYYL/azoAU1Y
         0KwQ==
X-Gm-Message-State: AOJu0YxwGwVz6uvNJYVpPPxuOwQe+C2McQkC5fSxLxiGD84oGfaMHsF9
        GjGJI1TdCNiv853wvI6828nQ6an47s2rTnXV8FCrU/qxA02fen36RlJISeuKXEewKqxvgzYhRAp
        YPIKZU8N9CkSCEyWNMBNRDKoy
X-Received: by 2002:a05:6214:226b:b0:626:2305:6073 with SMTP id gs11-20020a056214226b00b0062623056073mr14561417qvb.4.1692038655118;
        Mon, 14 Aug 2023 11:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWDv/pTkCgGz4dnpVLXX0rV2wACMdw+Qcy+eJSwM3xg9sOHmswZi98yBi7GjAnG22hvSrGEA==
X-Received: by 2002:a05:6214:226b:b0:626:2305:6073 with SMTP id gs11-20020a056214226b00b0062623056073mr14561409qvb.4.1692038654848;
        Mon, 14 Aug 2023 11:44:14 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cb347000000b00630c0ed6339sm3566561qvf.64.2023.08.14.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:44:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC v2 1/3] mm: Add TAIL_MAPPING_REUSED_MAX
Date:   Mon, 14 Aug 2023 14:44:09 -0400
Message-ID: <20230814184411.330496-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814184411.330496-1-peterx@redhat.com>
References: <20230814184411.330496-1-peterx@redhat.com>
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

Tail pages have a sanity check on ->mapping fields, not all of them but
only upon index>2.  It's because we reused ->mapping fields of the tail
pages index=0,1 for other things.

Define a macro for "max index of tail pages that got ->mapping field
reused" on top of folio definition, because when we grow folio tail pages
we'd want to boost this too together.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 9 +++++++++
 mm/huge_memory.c         | 6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 291c05cacd48..3f2b0d46f5d6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -248,6 +248,15 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
 	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
 }
 
+/*
+ * This macro defines the maximum tail pages (of a folio) that can have the
+ * page->mapping field reused (offset 12 for 32bits, or 24 for 64bits).
+ *
+ * When the tail page's mapping field reused, it'll be exempted from
+ * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
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
 
-- 
2.41.0

