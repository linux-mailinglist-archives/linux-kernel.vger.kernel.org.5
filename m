Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7D7DBF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjJ3SAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjJ3SAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:00:16 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23719E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:00:13 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5a92782615dso47306487b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698688813; x=1699293613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/PfKGKxrLr/LG7lEcZ9aG7jDMR5OafORf+0DY7p08E=;
        b=Gxz55oML9cMruDUiYEzilYrEFr/i3qvVPBZcpeFowIzl70eIoNwWbsImWrHel4Br33
         ST8pckmjEb50BQWuOQKA89eLq68BGdpi9H9RabxCkx7JVN0KS8NGwrplX48qhZqTDPue
         Sk/LDZzO5a1FQVC9QPVNskEPXL0Evbwlcmpfog4Z+OLbGq4HdWobfxFIQ3CWXGZe+eO9
         eP7mUjVXW8xeSYyd93HjjWWFgRyKmtYTQbjm78qPda0EnrDtMNU0q4BPGw3wVJrwGiAJ
         X0YZSyFNqpVhOJaGWMCDGARMtq2UfPkAdgV5Z4Eudfz7Ev1ExsExWibNW0ZsdbAhsudk
         IlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698688813; x=1699293613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/PfKGKxrLr/LG7lEcZ9aG7jDMR5OafORf+0DY7p08E=;
        b=irl3PzhhUL9B1c/cC8IMs582dc5vEs1l3A5R6eHJinF7+WSg40ESueihuSRLDl3/Jp
         rTvGumI77LZ/c8hO/RLeeHw/pP6EVxEB6biE87c5slhuBtqHV+qbuEnSGjmRY0ff5071
         ihLulb1nIrlinVV2g1k5LMHkr5zRI9Ccun79bFVex2uj0QhWKJa7gjlMvg8H3llSyzLc
         eUfzZG6L7MAa24ubJ3AhsPEVoxYAkyYHECmQkZOTzZsWxtZTgVHHmOy29w9v8peLG5WW
         pMNKPE9srnxzn3H/WAk8VyQFHo7AOUz8ak2PaABGdcQx/VirlveY9krsrnQYw38skVCc
         I82w==
X-Gm-Message-State: AOJu0Yz27Z8nv9jlau4JSgyz6TD+Ny8Fk8B8LCuG4GVXaLA+SWsbqFdT
        P1SPLq67+JvR0Ibl4FPFXw==
X-Google-Smtp-Source: AGHT+IFslyrl+kcQF1WhWsNueBlKSCaBTpYEavHi+WsJF2Y4+kdx3kL9o14FBcR2GdbFlew0Uz2a3g==
X-Received: by 2002:a81:c946:0:b0:5a8:7375:af6b with SMTP id c6-20020a81c946000000b005a87375af6bmr10238889ywl.44.1698688813060;
        Mon, 30 Oct 2023 11:00:13 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bz4-20020a05690c084400b005a7be2919a1sm4588545ywb.14.2023.10.30.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:00:12 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        vbabka@suse.cz, naoya.horiguchi@linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v2] kpageflags: respect folio head-page flag placement
Date:   Mon, 30 Oct 2023 14:00:05 -0400
Message-Id: <20231030180005.2046-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kpageflags reads page-flags directly from the page, even when the
respective flag is only updated on the headpage of a folio.

Update bitchecks to use PAGEFLAG() interfaces to check folio for the
referenced, dirty, lru, active, and unevictable bits.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 fs/proc/page.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..1dceecb8018a 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -111,6 +111,7 @@ u64 stable_page_flags(struct page *page)
 {
 	u64 k;
 	u64 u;
+	struct folio *folio;
 
 	/*
 	 * pseudo flag: KPF_NOPAGE
@@ -119,6 +120,8 @@ u64 stable_page_flags(struct page *page)
 	if (!page)
 		return 1 << KPF_NOPAGE;
 
+	folio = page_folio(page);
+
 	k = page->flags;
 	u = 0;
 
@@ -188,20 +191,31 @@ u64 stable_page_flags(struct page *page)
 		u |= 1 << KPF_SLAB;
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
-	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
+
+	if (folio_test_dirty(folio))
+		u |= 1 << KPF_DIRTY;
+
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
 	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
 
-	u |= kpf_copy_bit(k, KPF_LRU,		PG_lru);
-	u |= kpf_copy_bit(k, KPF_REFERENCED,	PG_referenced);
-	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
+	if (folio_test_lru(folio))
+		u |= 1 << KPF_LRU;
+
+	if (folio_test_referenced(folio))
+		u |= 1 << KPF_REFERENCED;
+
+	if (folio_test_active(folio))
+		u |= 1 << KPF_ACTIVE;
+
 	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
 
 	if (PageSwapCache(page))
 		u |= 1 << KPF_SWAPCACHE;
 	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 
-	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
+	if (folio_test_unevictable(folio))
+		u |= 1 << KPF_UNEVICTABLE;
+
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
 #ifdef CONFIG_MEMORY_FAILURE
-- 
2.39.1

