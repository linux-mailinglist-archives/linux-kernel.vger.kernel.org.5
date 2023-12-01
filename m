Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CC80119C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379438AbjLARYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378839AbjLARYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B011BEA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:23 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c5c8ece6c4so821527a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451403; x=1702056203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMpydcppngE+fKChZSwIHlomLcVQiLNPNu4+wVJ/ml4=;
        b=B1a/P5nLysUV6UEJd1FHQ5a7SFcqMnUJRbSFX0WLr9WBVAU209VMC7wFY2U/zugAIG
         1BOtRzW67tA/0mE0siXjfJPFMvUJkYZzJVawZsJaA/e8eXvIKIJi/W7yJbJLZOuElhwS
         elMVDXJPGVKKjaJIjAeFl3sYYR2ckS1P5svmIg0uYWGL2w6TwEOdAQmylCLuiyaXPkp0
         ru2PJPmw5dp+OxbWmbkMhhR/2iweVwIEhOyOgrkth3irmbfgupQEljuojSwkCoy8gCoh
         I3uDPuTLJa+dfkUNMTaiYBDRVGY2HuB7yK0qjbh4b9tQkMtFOnfZYdsNqhtFHd7Z4Gco
         oV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451403; x=1702056203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMpydcppngE+fKChZSwIHlomLcVQiLNPNu4+wVJ/ml4=;
        b=DZpL9YNt39869Nkr4fGvbmuwRM2u4Sq+h/0LLtCm5Xv/p845Zit2Zxy4/ySfqtFhF1
         JRCs9BEETy8DgkYfT3XWqW6KBGVQaraglEGXhWbmA8nSewMVKnZAhNE9utrQPmGIqFcI
         0kuIH7sgWcT0aXi2/thdOmztr2ZOJ9jXdu0odHPvqclP2tw19nAJQ+d/xY6WEdT6L2FO
         OnW4C3+NnHr0VHeqYh4Yj4UTQBD4xO1Hgbfq5PJapqq9c4fkf9NgRm39IaVFqXLTHSo4
         g9kA4zUdkCBTwQjYIsxJxNXQWmx3Zd+R2XKMPzXR3GHjUA8OEV7bUNnPBtnO2R9UDSlk
         cDlg==
X-Gm-Message-State: AOJu0Yy8vVyZ9ioweWUlhI3FHRyt7YBrY3wfO3r3j7UNMYK+mXcDOx6x
        qY6P8araXFMYYI8rFoOgxN3ZJENPnvXj8Q==
X-Google-Smtp-Source: AGHT+IE6PB5VkbKmApYpyZUhAjB5i4BF6xLh9cLZSwNOQGRvJp8aNdcsw4MB6fLgLpv2PS+x5AcoPiV2EaB+Tw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:903:32c8:b0:1cf:5cec:19dc with SMTP
 id i8-20020a17090332c800b001cf5cec19dcmr5399727plr.7.1701451403472; Fri, 01
 Dec 2023 09:23:23 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:51 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-23-cmllamas@google.com>
Subject: [PATCH v2 22/28] binder: rename lru shrinker utilities
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the page allocation step is done separately we should rename
the binder_free_page_range() and binder_allocate_page_range() functions
to provide a more accurate description of what they do. Lets borrow the
freelist concept used in other parts of the kernel for this.

No functional change here.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 40 ++++++++++++-------------
 drivers/android/binder_alloc.h          |  4 +--
 drivers/android/binder_alloc_selftest.c |  6 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index ad9b73c6ddb7..052a8c3b0ce1 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -26,7 +26,7 @@
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
-struct list_lru binder_alloc_lru;
+struct list_lru binder_freelist;
 
 static DEFINE_MUTEX(binder_alloc_mmap_lock);
 
@@ -190,8 +190,8 @@ binder_get_installed_page(struct binder_lru_page *lru_page)
 	return smp_load_acquire(&lru_page->page_ptr);
 }
 
-static void binder_free_page_range(struct binder_alloc *alloc,
-				   unsigned long start, unsigned long end)
+static void binder_lru_freelist_add(struct binder_alloc *alloc,
+				    unsigned long start, unsigned long end)
 {
 	struct binder_lru_page *page;
 	unsigned long page_addr;
@@ -210,7 +210,7 @@ static void binder_free_page_range(struct binder_alloc *alloc,
 
 		trace_binder_free_lru_start(alloc, index);
 
-		ret = list_lru_add(&binder_alloc_lru, &page->lru);
+		ret = list_lru_add(&binder_freelist, &page->lru);
 		WARN_ON(!ret);
 
 		trace_binder_free_lru_end(alloc, index);
@@ -299,14 +299,14 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 }
 
 /* The range of pages should exclude those shared with other buffers */
-static void binder_allocate_page_range(struct binder_alloc *alloc,
-				       unsigned long start, unsigned long end)
+static void binder_lru_freelist_del(struct binder_alloc *alloc,
+				    unsigned long start, unsigned long end)
 {
 	struct binder_lru_page *page;
 	unsigned long page_addr;
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-			   "%d: allocate pages %lx-%lx\n",
+			   "%d: pages %lx-%lx\n",
 			   alloc->pid, start, end);
 
 	trace_binder_update_page_range(alloc, true, start, end);
@@ -321,7 +321,7 @@ static void binder_allocate_page_range(struct binder_alloc *alloc,
 		if (page->page_ptr) {
 			trace_binder_alloc_lru_start(alloc, index);
 
-			on_lru = list_lru_del(&binder_alloc_lru, &page->lru);
+			on_lru = list_lru_del(&binder_freelist, &page->lru);
 			WARN_ON(!on_lru);
 
 			trace_binder_alloc_lru_end(alloc, index);
@@ -504,8 +504,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
-	binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
-				   end_page_addr);
+	binder_lru_freelist_del(alloc, PAGE_ALIGN(buffer->user_data),
+				end_page_addr);
 
 	rb_erase(&buffer->rb_node, &alloc->free_buffers);
 	buffer->free = 0;
@@ -671,8 +671,8 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 				   alloc->pid, buffer->user_data,
 				   prev->user_data,
 				   next ? next->user_data : 0);
-		binder_free_page_range(alloc, buffer_start_page(buffer),
-				       buffer_start_page(buffer) + PAGE_SIZE);
+		binder_lru_freelist_add(alloc, buffer_start_page(buffer),
+					buffer_start_page(buffer) + PAGE_SIZE);
 	}
 	list_del(&buffer->entry);
 	kfree(buffer);
@@ -706,8 +706,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 			      alloc->pid, size, alloc->free_async_space);
 	}
 
-	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
-			       (buffer->user_data + buffer_size) & PAGE_MASK);
+	binder_lru_freelist_add(alloc, PAGE_ALIGN(buffer->user_data),
+				(buffer->user_data + buffer_size) & PAGE_MASK);
 
 	rb_erase(&buffer->rb_node, &alloc->allocated_buffers);
 	buffer->free = 1;
@@ -953,7 +953,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			if (!alloc->pages[i].page_ptr)
 				continue;
 
-			on_lru = list_lru_del(&binder_alloc_lru,
+			on_lru = list_lru_del(&binder_freelist,
 					      &alloc->pages[i].lru);
 			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
@@ -1152,13 +1152,13 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 static unsigned long
 binder_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	return list_lru_count(&binder_alloc_lru);
+	return list_lru_count(&binder_freelist);
 }
 
 static unsigned long
 binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	return list_lru_walk(&binder_alloc_lru, binder_alloc_free_page,
+	return list_lru_walk(&binder_freelist, binder_alloc_free_page,
 			    NULL, sc->nr_to_scan);
 }
 
@@ -1184,13 +1184,13 @@ int binder_alloc_shrinker_init(void)
 {
 	int ret;
 
-	ret = list_lru_init(&binder_alloc_lru);
+	ret = list_lru_init(&binder_freelist);
 	if (ret)
 		return ret;
 
 	binder_shrinker = shrinker_alloc(0, "android-binder");
 	if (!binder_shrinker) {
-		list_lru_destroy(&binder_alloc_lru);
+		list_lru_destroy(&binder_freelist);
 		return -ENOMEM;
 	}
 
@@ -1205,7 +1205,7 @@ int binder_alloc_shrinker_init(void)
 void binder_alloc_shrinker_exit(void)
 {
 	shrinker_free(binder_shrinker);
-	list_lru_destroy(&binder_alloc_lru);
+	list_lru_destroy(&binder_freelist);
 }
 
 /**
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index bbc16bc6d5ac..a5181916942e 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -15,7 +15,7 @@
 #include <linux/list_lru.h>
 #include <uapi/linux/android/binder.h>
 
-extern struct list_lru binder_alloc_lru;
+extern struct list_lru binder_freelist;
 struct binder_transaction;
 
 /**
@@ -61,7 +61,7 @@ struct binder_buffer {
 /**
  * struct binder_lru_page - page object used for binder shrinker
  * @page_ptr: pointer to physical page in mmap'd space
- * @lru:      entry in binder_alloc_lru
+ * @lru:      entry in binder_freelist
  * @alloc:    binder_alloc for a proc
  */
 struct binder_lru_page {
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index ed753747e54c..fba7ab6ca451 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -158,8 +158,8 @@ static void binder_selftest_free_page(struct binder_alloc *alloc)
 	int i;
 	unsigned long count;
 
-	while ((count = list_lru_count(&binder_alloc_lru))) {
-		list_lru_walk(&binder_alloc_lru, binder_alloc_free_page,
+	while ((count = list_lru_count(&binder_freelist))) {
+		list_lru_walk(&binder_freelist, binder_alloc_free_page,
 			      NULL, count);
 	}
 
@@ -183,7 +183,7 @@ static void binder_selftest_alloc_free(struct binder_alloc *alloc,
 
 	/* Allocate from lru. */
 	binder_selftest_alloc_buf(alloc, buffers, sizes, seq);
-	if (list_lru_count(&binder_alloc_lru))
+	if (list_lru_count(&binder_freelist))
 		pr_err("lru list should be empty but is not\n");
 
 	binder_selftest_free_buf(alloc, buffers, sizes, seq, end);
-- 
2.43.0.rc2.451.g8631bc7472-goog

