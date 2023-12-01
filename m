Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475EB801192
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379055AbjLARXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378918AbjLARXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFE213F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d351694be7so36187377b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451385; x=1702056185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KXql4wc+B0IDfmvDFaObCPkY77Q514P/MmfpNkLzgI=;
        b=M+bqfT9T8evUTZ1pFdI4N6i5T8Xk0Zvwi5VEVhZOnXvtp3ZL0wTXPKHNzSBoIAq5/q
         5DCGCb/RjZULPDqEMP8vj6m7qtuOhxrdE11Em1ztze1+Dxl2yc3jJX6zl6H0WbQHIbO9
         DOxSE6DI7Gxh90UycdWhWcGfDxyKQXN5Yx3lgSG8t7X52Lu+Ai48ietxlK3lEHFNgTHU
         fhj1l6Vvxkg3flyT/H4J9WxwgjSF4xG179FTUMbbCNRtVXHTGsxFCtSLHSfvCDg5c5Ux
         PMd5prU7KXP7fIk16smzFUDo+F6I7QwZz84TXx72l+mLdNIZzSxk83GjAqyHrXx8Eiep
         pN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451385; x=1702056185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KXql4wc+B0IDfmvDFaObCPkY77Q514P/MmfpNkLzgI=;
        b=K7gtA0Odg8kbEhrEX7XPa9aN5BLImXycoDKkx0kWBfG/jRtjvoWPvKkqRvWCPkGTn8
         N3BL8hL2IRpAAC+/sbVFLGCDdFFsQdTIhtLWGCGfCzx9Vi9IK4GHd9CQdoz+smlmHfZO
         hki+QMjHB69LLHzCcrEct4xfA0QmnxhX+eLQlZqYC24wkSjTdRcP/L8q3TZmDiaCHrkM
         13VMT4t/5/h5DVjY0EFhkj6SsC7MNrvqwSI7XTj3uJZV7RP1QI0YL9exy9uWhNuoH65j
         beN1cNbGQHnqnr+gdSLW5Xv8FWoRwobmSJm40P3Yhb19/lF/Rtm0XG78zFsETfqTumBx
         NCPw==
X-Gm-Message-State: AOJu0Ywr3Ma0AyGepxtQpxM9hdJK4Uu0wP60HAqNrb+hIzBhB252ZS4V
        sXr3w9r4NE63Qc9DQ5BfbUNq/oo0AC2wGg==
X-Google-Smtp-Source: AGHT+IFhseDzf0QLmLKgkUTC0f58HJNz0EaZSlWzIkg1xf1J6ybgpA+ysszFrIFqvmXlBO38X34s0f5h4tUb6g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:2d06:b0:5d4:1e95:1e8a with SMTP
 id eq6-20020a05690c2d0600b005d41e951e8amr83602ywb.4.1701451385313; Fri, 01
 Dec 2023 09:23:05 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:43 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-15-cmllamas@google.com>
Subject: [PATCH v2 14/28] binder: relocate low space calculation
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

Move the low async space calculation to debug_low_async_space_locked().
This logic not only fits better here but also offloads some of the many
tasks currently done in binder_alloc_new_buf_locked().

No functional change in this patch.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 3dca7b199246..167ee6f871dc 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -371,6 +371,15 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc)
 	size_t num_buffers = 0;
 	struct rb_node *n;
 
+	/*
+	 * Only start detecting spammers once we have less than 20% of async
+	 * space left (which is less than 10% of total buffer size).
+	 */
+	if (alloc->free_async_space >= alloc->buffer_size / 10) {
+		alloc->oneway_spam_detected = false;
+		return false;
+	}
+
 	for (n = rb_first(&alloc->allocated_buffers); n != NULL;
 		 n = rb_next(n)) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -491,16 +500,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
-		if (alloc->free_async_space < alloc->buffer_size / 10) {
-			/*
-			 * Start detecting spammers once we have less than 20%
-			 * of async space left (which is less than 10% of total
-			 * buffer size).
-			 */
-			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc);
-		} else {
-			alloc->oneway_spam_detected = false;
-		}
+		if (debug_low_async_space_locked(alloc))
+			buffer->oneway_spam_suspect = true;
 	}
 
 	return buffer;
-- 
2.43.0.rc2.451.g8631bc7472-goog

