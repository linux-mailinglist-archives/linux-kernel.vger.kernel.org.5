Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51307DFA82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377440AbjKBTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbjKBTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D321A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b0c27d504fso10412047b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951645; x=1699556445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bo8i4YOQ1Wx4e8B0eeo6gXTR86rAjm5MF1i8+KtSUbY=;
        b=NBsHm0DT/xAS/gzD1DuvEGeIVckyF2g6VKnZeW5jnRwv0V30FUEo9H8JprUxchYwOC
         cGyUQr9/+JOsHjm9MZsLfiF9HrJxlNG3pfuFowrpNtiq0p0OO8Ob3TpqNOdlngcm+mqw
         zvNdLzPUbf+JWZ7T/bFmZQDuYJBbJgjAiGiXdEHsfILDEIa49aELRaAQi5g6Ft+O1h6U
         KiQYPk9V2LAjEGmJDZgeN3j493XEV3KKJMrufYGpPoWzEL/aqVnPTX2Kf6whmxBA5qEc
         JJUNeAMqpgV0fLSWlOGLorQ3AvxZjJjvIHnOLxCUNMNti+qwcyLJmSkvtjnzoMbR7gFx
         fFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951645; x=1699556445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bo8i4YOQ1Wx4e8B0eeo6gXTR86rAjm5MF1i8+KtSUbY=;
        b=rvb4DokKuOhpVGVnniMWo0FZ8XzrXiHrLI4j+WUduLAAeeNtkCFFbaSn4y9Is1wOVm
         L0Jqnfiop5BvlZJbaTMs0gSYB82Yspi+xGwqGIVTj9bXU008UNjXLIQ+J2XTvAFyeaFv
         H5UbSH+OuwzUfDyWYlMTVolwlnBeDYyUxeDCANzKeFu13YY2GR5THtv8cg5HZU9DqbmH
         PypvTYwtK4tifkkNe6YPEwdGa4dv0RizoFDxsrxWGBOnWLqcbA4uyDE7orvXo4xFY0iY
         wv/TOFayquQgV3YkA0udA2I9OoMU3EKw4NSpyNEGHdDfoH+9H4pX4AXX2kQOxa7qCuOg
         yGpg==
X-Gm-Message-State: AOJu0Yz/JG2gdAXNuf+Fq5uexxpXPd8aRA2pEhjap2d3vnl/q3fpLVjB
        MP1Kl1MSMyz3GCJbefXPxcFEaPVbka9JVw==
X-Google-Smtp-Source: AGHT+IEwEiDccqPZUOwa1kj1GeP3gwcWvJ8tMlyGIN/Wcyt6KCo+6OJhNrlCDQ1V2W+H4tBrDz6vdRMtHmD7hw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:84ce:0:b0:5a7:b4d5:5f27 with SMTP id
 u197-20020a8184ce000000b005a7b4d55f27mr10784ywf.5.1698951645354; Thu, 02 Nov
 2023 12:00:45 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:08 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-8-cmllamas@google.com>
Subject: [PATCH 07/21] binder: remove extern from function prototypes
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

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from drivers/android/binder_alloc.h as they
are not needed.

No functional changes in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.h | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index dc1e2b01dd64..82380febdd85 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -121,27 +121,27 @@ static inline void binder_selftest_alloc(struct binder_alloc *alloc) {}
 enum lru_status binder_alloc_free_page(struct list_head *item,
 				       struct list_lru_one *lru,
 				       spinlock_t *lock, void *cb_arg);
-extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
-						  size_t data_size,
-						  size_t offsets_size,
-						  size_t extra_buffers_size,
-						  int is_async,
-						  int pid);
-extern void binder_alloc_init(struct binder_alloc *alloc);
-extern int binder_alloc_shrinker_init(void);
-extern void binder_alloc_shrinker_exit(void);
-extern void binder_alloc_vma_close(struct binder_alloc *alloc);
-extern struct binder_buffer *
+struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
+					   size_t data_size,
+					   size_t offsets_size,
+					   size_t extra_buffers_size,
+					   int is_async,
+					   int pid);
+void binder_alloc_init(struct binder_alloc *alloc);
+int binder_alloc_shrinker_init(void);
+void binder_alloc_shrinker_exit(void);
+void binder_alloc_vma_close(struct binder_alloc *alloc);
+struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 			     uintptr_t user_ptr);
-extern void binder_alloc_free_buf(struct binder_alloc *alloc,
-				  struct binder_buffer *buffer);
-extern int binder_alloc_mmap_handler(struct binder_alloc *alloc,
-				     struct vm_area_struct *vma);
-extern void binder_alloc_deferred_release(struct binder_alloc *alloc);
-extern int binder_alloc_get_allocated_count(struct binder_alloc *alloc);
-extern void binder_alloc_print_allocated(struct seq_file *m,
-					 struct binder_alloc *alloc);
+void binder_alloc_free_buf(struct binder_alloc *alloc,
+			   struct binder_buffer *buffer);
+int binder_alloc_mmap_handler(struct binder_alloc *alloc,
+			      struct vm_area_struct *vma);
+void binder_alloc_deferred_release(struct binder_alloc *alloc);
+int binder_alloc_get_allocated_count(struct binder_alloc *alloc);
+void binder_alloc_print_allocated(struct seq_file *m,
+				  struct binder_alloc *alloc);
 void binder_alloc_print_pages(struct seq_file *m,
 			      struct binder_alloc *alloc);
 
-- 
2.42.0.869.gea05f2083d-goog

