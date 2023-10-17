Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62BE7CB770
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJQAfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJQAfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:35:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E895
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:35:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c88b467ef8so34766605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697502921; x=1698107721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAwiYt7jZ0jTSch20EJdCPnumHKLIIb6QfY26Jbdiok=;
        b=XXOp45Gwy2C7xObjMRPiSi+xfkBoW6tPnUB75Fb4Dt/i3SoaU3tVMQ2fyykv8Oi/X9
         Eomh0tU/kONxa+auC3ermrpEaPy1vSMLc2k6SVCV6W81oM2I7fCB1kMeK0/Y5qCxSx7e
         GblyC4chYcnPOuKvY1kpETtkQO56uWtZOgViSttMZeHvlHz1m7RuqcsUcXHeH44NqRir
         1buQg2r8m4ZrpVavIA4St8FLV2psoTQtzgOcYCxIx5qzvkex2add4E/+eN0CgH721Rm5
         IF1JNlFzjSxUn+qwptOyXB3QyH3MvnV2BIBdVwcbGssRBM3H49ynr3+/qGrbUsRMqYc0
         XAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697502921; x=1698107721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAwiYt7jZ0jTSch20EJdCPnumHKLIIb6QfY26Jbdiok=;
        b=BRQv4FKU4jjNAzqokkYcKg+4i1a+4KZmRVjyw2iwFIk3Tetx47o8jBPIWJvODbz1Ss
         NevVOocsdDvoxAsL7b4qekXPkoTzQOJhUIkdreUS3Am7KJR6qPArs/BP/LJrt/FSAJPN
         Xuj0hCRAshZxV/ZxW/kPBWykntZJJefDOXuP9r36hkwjL7/T8Ql9JodRxGh49PT7iSp3
         o/Dsw1Q7XrlsY14lw3ZC+IdkGlSd/ZDyxTivKnaXw3AKQVW0kczM4HvDYvV83iAiGW1J
         2hYeQaXH+o6SyE/BohSKsg8983hrUxL78gOjiijzUFPnDEDLyktkqXd1bfYu7TlSXn1s
         QphA==
X-Gm-Message-State: AOJu0YzaimTpxXOEX0nucEBuccD0cZ9kVN3ka4ZUEIYF+thIMrdmkoCx
        2FXcPvjsavAV9Z1DBZSxogw=
X-Google-Smtp-Source: AGHT+IHetkovzeS4CXVvYSqkxsOsLDksqAtX486TpH5iBtoG7n3TfpIRVgIp+F/1WP2Fk4nkn72LRQ==
X-Received: by 2002:a17:903:23cf:b0:1ca:4ad7:6878 with SMTP id o15-20020a17090323cf00b001ca4ad76878mr763231plh.8.1697502920631;
        Mon, 16 Oct 2023 17:35:20 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b001b7f40a8959sm201875ple.76.2023.10.16.17.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 17:35:20 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz
Subject: [PATCH 1/2] swap: allows swap bypassing on zswap store failure
Date:   Mon, 16 Oct 2023 17:35:18 -0700
Message-Id: <20231017003519.1426574-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017003519.1426574-1-nphamcs@gmail.com>
References: <20231017003519.1426574-1-nphamcs@gmail.com>
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

During our experiment with zswap, we sometimes observe swap IOs even
though the zswap pool limit is never hit. This is due to occasional
zswap store failures, in which case the page will be written straight to
the swapping device. This prevents many users who cannot tolerate
swapping from adopting zswap to save memory where possible.

This patch adds the option to bypass swap when a zswap store fails. The
feature is disabled by default (to preserve the existing behavior), and
can be enabled via a new zswap module parameter. When enabled, swapping
is all but prevented (except for when the zswap pool is full and have to
write pages back to swap).

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst | 9 +++++++++
 include/linux/zswap.h                  | 9 +++++++++
 mm/page_io.c                           | 6 ++++++
 mm/shmem.c                             | 8 ++++++--
 mm/zswap.c                             | 4 ++++
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index ae8597a67804..82fa8148a65a 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,15 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+Many users cannot tolerate the swapping that comes with zswap store failures,
+due to the IO incurred if these pages are needed later on. In this scenario,
+users can bypass swapping when zswap store attempts fail (and keep the pages
+in memory) as follows:
+
+	echo Y > /sys/module/zswap/parameters/bypass_swap_when_store_fail_enabled
+
+Note that swapping due to writeback is not disabled with this option.
+
 When there is a sizable amount of cold memory residing in the zswap pool, it
 can be advantageous to proactively write these cold pages to swap and reclaim
 the memory for other use cases. By default, the zswap shrinker is disabled.
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 04f80b64a09b..c67da5223894 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -7,6 +7,7 @@
 
 extern u64 zswap_pool_total_size;
 extern atomic_t zswap_stored_pages;
+extern bool zswap_bypass_swap_when_store_fail_enabled;
 
 #ifdef CONFIG_ZSWAP
 
@@ -18,6 +19,10 @@ void zswap_swapoff(int type);
 bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry);
 void zswap_insert_swpentry_into_lru(swp_entry_t swpentry);
 
+static inline bool zswap_bypass_swap_when_store_fail(void)
+{
+	return zswap_bypass_swap_when_store_fail_enabled;
+}
 #else
 
 static inline bool zswap_store(struct folio *folio)
@@ -41,6 +46,10 @@ static inline bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry)
 
 static inline void zswap_insert_swpentry_into_lru(swp_entry_t swpentry) {}
 
+static inline bool zswap_bypass_swap_when_store_fail(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/page_io.c b/mm/page_io.c
index cb559ae324c6..482f56d27bcd 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_end_writeback(folio);
 		return 0;
 	}
+
+	if (zswap_bypass_swap_when_store_fail()) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(&folio->page, wbc);
 	return 0;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 6503910b0f54..8614d7fbe18c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1514,8 +1514,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
-		swap_writepage(&folio->page, wbc);
-		return 0;
+		/*
+		 * Seeing AOP_WRITEPAGE_ACTIVATE here indicates swapping is disabled on
+		 * zswap store failure. Note that in that case the folio is already
+		 * re-marked dirty by swap_writepage()
+		 */
+		return swap_writepage(&folio->page, wbc);
 	}
 
 	mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/zswap.c b/mm/zswap.c
index d545516fb5de..db2674548670 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -138,6 +138,10 @@ static bool zswap_non_same_filled_pages_enabled = true;
 module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
 		   bool, 0644);
 
+bool zswap_bypass_swap_when_store_fail_enabled;
+module_param_named(bypass_swap_when_store_fail_enabled,
+		   zswap_bypass_swap_when_store_fail_enabled, bool, 0644);
+
 static bool zswap_exclusive_loads_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
 module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
-- 
2.34.1

