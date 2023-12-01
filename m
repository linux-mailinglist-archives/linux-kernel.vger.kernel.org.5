Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3445880118C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378888AbjLARXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378934AbjLARXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:04 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8CF1BC5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3f951af5aso16942717b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451371; x=1702056171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSl/K3CqG4qJ2+ALOsdYPMrYYKvEmJdm3Dorq1SzizU=;
        b=RPDfH05jfJb8HnddA6pIuBB3sbMzCQqezxz+ee6Ref4G7D4uVKOVweTsk4vYX9iR8b
         CdtMj9KLSIKhQVf/LtISnLZStasNHKjit4ieqvDmG7cMJjUjK+aSFyZg9cRcrpZPY7NU
         qbjbaCbZURSbbQUr91jeliiNsVc/atwHMkJ0SSVOMHy2bWHXDzsE8TVxzPMRBHkpn5D9
         BoRGLnkRM63XhnE2yRvRKoIZBQIutkpkhbhDhQ9l+46GmeScRGb0R95FPkR7E9fHlFIR
         STFz4/kBTekr3MhSCNJ7REDU8df8v/LOcVjyiOdVgDGrwiRlklnle6dYUs7RSkC54G5d
         o75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451371; x=1702056171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSl/K3CqG4qJ2+ALOsdYPMrYYKvEmJdm3Dorq1SzizU=;
        b=Xarh6i5JJLSEoRPKHLnW26jvZZSqHfMWc+THW5CQvAUdkrjRfcSakXqDlRcMCVG0wK
         e8uvlTp+8PtIxFX99IOQSxN4wGADxz4923iy4qplgEyq+O7b0fFZwLBqxin0a7gV3wWw
         9eLhElxZs8GCai6pB/05Hks8m4wNDL/0u+NOPnE9iTVHEwFxWWUOAXS0LV2Fu0S7bqVK
         uI8iGp0jmzQPS1ayHbVBglbpVb4XyY90hwA2Bp8outleD8mu20E5d0K2iMX5OLfMZ/6H
         10qz25ZbPmlYpCl3eOzTPRgFYpXYh7MQ4OBB4VvZrJL6m84L7iRvdyzgQ5w3SKMJVOXH
         rvWg==
X-Gm-Message-State: AOJu0YxO0gljj6qYoCBMjF4qCnY62zgsa0KpBeR2YECbfXqVXAeQwPIf
        lo9f3yJWLDt34tp7fH0xGWN9rxCAjBxfTw==
X-Google-Smtp-Source: AGHT+IFVLKIFHbisXFl/Bnl5pM4xJm9FmKLup9tFJqTzbuqkdcK3PkS+3g5yXNvi2IkzaxZ017/ZbbJh932mFQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d447:0:b0:db7:d315:6643 with SMTP id
 m68-20020a25d447000000b00db7d3156643mr28161ybf.6.1701451371092; Fri, 01 Dec
 2023 09:22:51 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:37 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-9-cmllamas@google.com>
Subject: [PATCH v2 08/28] binder: remove extern from function prototypes
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alice Ryhl <aliceryhl@google.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
2.43.0.rc2.451.g8631bc7472-goog

