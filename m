Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF83F79B38C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353820AbjIKVup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbjIKOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10A2EE4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694443724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S08mZGZujRDp+IOI3MWVdjZ3/JmsDA0pjLrFY+IpTTA=;
        b=ebs/ttLMCX4kODqk1Aoop3WjFbjOa4JYQagkCcdo2N4YDH+hc75CYvf8VQyvD5J7zfy9Ug
        pqCmo6dvS58LCYVjoQX532u7uCE/eRKEjQ7Ik+eJa8IjQE2AilwbAgRKpQielmBcbAfTpJ
        aAKIQVueIKsZSPwgLmVPpcBN+SlR59s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-dpNgfb8sP0u7nMPMe6x8_Q-1; Mon, 11 Sep 2023 10:48:43 -0400
X-MC-Unique: dpNgfb8sP0u7nMPMe6x8_Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a21e030751so62304466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694443722; x=1695048522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S08mZGZujRDp+IOI3MWVdjZ3/JmsDA0pjLrFY+IpTTA=;
        b=Imh6nZ8P3rQA5jEjK/lJvlUnycx1dnS1ZdPbVYIjbLoyt/v9lz8FptK88uGBCbll5K
         kPvZ22yTtrsGs2hYIqvglJW2FSc6LZVn6ZAac1Wc9kqBNR3WdbRp84BXZpWof1Sftu3q
         /x+5LtqrXCZsNoXOaF55WeID9Ljdh+ZdOb25Fw7muBO6g9WQHpMty5GrJ0MKq0eo0kxS
         qbYEL4ZJeHMAAEUYKp1KZ1t7KmXkAtP9WWDrr6JnrYY7QhuDerxMjifkBjM+1bKhZrwP
         Z2rUEjGlLaF4bhchIkaATmj26fyX8olCbRQnI2ADwzjbMSzK1k3eRhcFAHqfVcunBHmP
         QMQA==
X-Gm-Message-State: AOJu0Yx4AHSsggfpVlUkh1UOCf7GucN08ODLh2DVwkpCZGicp/moJs5n
        o16RHFuxmeh8FVdm1kRxODhwaDYcVRxElSid0TcxgHchPOWz/cUegzERr0uVKjEB6n6aifhKPvQ
        G8JwT55Zfs22LMr1GC03zidl9
X-Received: by 2002:a17:906:21b:b0:9a6:7fee:8253 with SMTP id 27-20020a170906021b00b009a67fee8253mr8314825ejd.0.1694443722048;
        Mon, 11 Sep 2023 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELSqxTm7AKsC8+9cjnj6puOU+a+SSkrs4QmFCFxCKE1q5wHn/644wAdYoHmLIY0Vr2sUQeRw==
X-Received: by 2002:a17:906:21b:b0:9a6:7fee:8253 with SMTP id 27-20020a170906021b00b009a67fee8253mr8314811ejd.0.1694443721710;
        Mon, 11 Sep 2023 07:48:41 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:807:b633:fcca:c83d:d46b:a90a])
        by smtp.gmail.com with ESMTPSA id y5-20020a170906070500b0099bcbaa242asm5452397ejb.9.2023.09.11.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:48:41 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v3] xarray: Document necessary flag in alloc-functions
Date:   Mon, 11 Sep 2023 16:48:37 +0200
Message-ID: <20230911144837.13540-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling functions that wrap __xa_alloc() or __xa_alloc_cyclic() without
the xarray previously having been initialized with the flag
XA_FLAGS_ALLOC being set in xa_init_flags() results in undefined
behavior.

Document the necessity of setting this flag in all docstrings of
functions that wrap said two functions.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
I used the time available until we can get this merged to create a
version-3, improving a few things.

Changes since v2:
- Phrase the comment differently: say "requires [...] an xarray [...]"
  instead of "must be operated on".
- Improve the commit message and use the canonical format: a) describe
  the problem, b) name the solution in imperative form.

Regards,
P.
---
 include/linux/xarray.h | 18 ++++++++++++++++++
 lib/xarray.c           |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 741703b45f61..746a17b64aa6 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -856,6 +856,9 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -886,6 +889,9 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -916,6 +922,9 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -949,6 +958,9 @@ static inline int __must_check xa_alloc_irq(struct xarray *xa, u32 *id,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
@@ -983,6 +995,9 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
@@ -1017,6 +1032,9 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
diff --git a/lib/xarray.c b/lib/xarray.c
index 2071a3718f4e..2b07c332d26b 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
-- 
2.41.0

