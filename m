Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636D17D7540
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJYUMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:12:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB4136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:12:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso102534a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698264763; x=1698869563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfZqbBPDt9YW5gpQ19AuecfZ/UwVOFBirFqhS2+TgdY=;
        b=mWpQV9rjTO/NFg3bfZLDHhfRlOMp7IoJDqC3oGJWjvgQslWggpcFnI6VshoxDAt8Pr
         xPaBRygO4/lno1w/2TtOxiZufcm9G8He3LY/Znenfus/EWzsuQUZ7MXZAa/F7Muu26ph
         YlJUCNEutaYVIFSklXiG5N1jaKBsJB8Pv/lVCIst2upRZ4+Yg7OZOGeBtwCz4yAuxMYJ
         D/7Acb/2Evmv1gSfI+ODIrhRUtFQl9/tsf1czcgfs9Wia+4sA6pMb+Uw3YSlrItgnjRk
         EIbCx1NavKlG5XW9a4d7oUGY4iJl5y9Kw2XMDb7apfjIRZq/LkJRRIfLymI8ztmLAHpe
         UO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698264763; x=1698869563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfZqbBPDt9YW5gpQ19AuecfZ/UwVOFBirFqhS2+TgdY=;
        b=lDiXSXzogZ3tAZ7CMnQ556iAugEeV+h+vknKUDOOETufXJxffpmOKOIThCvFD46sSu
         9ojemm1xDyKPNFSkeFz+Z2LMNakPQ4j+t6CZJeLKB9wcxim6LjLYwHTxIaHR36aohtdf
         y93daJgqNEr26GQPD7nBaNv7y7bvHePQHuqIs0ZbDjwP5J4rpc11GtuxjYD2oeltkmBy
         x723RY97PK8PSZUsUTRQk1C3rxn/wM4Dm/y/TJbHYoAl0uoBoffa7rUyJTlxqZCKyNll
         SVWZslR7kmvWD4n1F5CpGbou6XPL0AmGVpuZ3e6D4NjaDwgQHfr08boqMcX5le8qC40V
         CWqQ==
X-Gm-Message-State: AOJu0YxwO+wHAj1v8dVjF2PZccocy+TiS1A2KzmUtxhuGXtTZGj8SrDN
        4E7Bm4EBMdzOkBIDz9vsbA==
X-Google-Smtp-Source: AGHT+IHKO2keZsxnyC2gRGZxJPxOiMMDcNjtUVnne3MFD7NareZ1ReXAfwCnFkLgIvbmb3KMwQk7Dw==
X-Received: by 2002:a9d:6d91:0:b0:6bd:b0c9:a8d with SMTP id x17-20020a9d6d91000000b006bdb0c90a8dmr17046190otp.25.1698264763510;
        Wed, 25 Oct 2023 13:12:43 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id t62-20020a818341000000b005a7bbd713ddsm5274739ywf.108.2023.10.25.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:12:43 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        vbabka@suse.cz, naoya.horiguchi@linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH] kpageflags: respect folio head-page flag placement
Date:   Wed, 25 Oct 2023 16:12:37 -0400
Message-Id: <20231025201237.948993-1-gregory.price@memverge.com>
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
 fs/proc/page.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..958fb2311108 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -188,20 +188,31 @@ u64 stable_page_flags(struct page *page)
 		u |= 1 << KPF_SLAB;
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
-	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
+
+	if (PageDirty(page))
+		u |= 1 << KPF_DIRTY;
+
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
 	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
 
-	u |= kpf_copy_bit(k, KPF_LRU,		PG_lru);
-	u |= kpf_copy_bit(k, KPF_REFERENCED,	PG_referenced);
-	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
+	if (PageLRU(page))
+		u |= 1 << KPF_LRU;
+
+	if (PageReferenced(page))
+		u |= 1 << KPF_REFERENCED;
+
+	if (PageActive(page))
+		u |= 1 << KPF_ACTIVE;
+
 	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
 
 	if (PageSwapCache(page))
 		u |= 1 << KPF_SWAPCACHE;
 	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 
-	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
+	if (PageUnevictable(page))
+		u |= 1 << KPF_UNEVICTABLE;
+
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
 #ifdef CONFIG_MEMORY_FAILURE
-- 
2.39.1

