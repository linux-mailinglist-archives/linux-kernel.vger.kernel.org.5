Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0C782554
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjHUIWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjHUIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B298
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692606094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+eaf9HwLmG8Bo3tyWjnYsW92xTAurT4+tOAPq2I/GiY=;
        b=TRU971VVrOZ5tvAxfbO88QZ6CJ3jf+/hT6dFQ2JH11QWmyiUnL4Q5mPT5FuuseaTlM+RbF
        MRklW7ujXEhDdahRoKLc1y07IT4hFYyvxjueX31YXSyvEYPaLwWfZrNjkljE89FIqZDXiS
        8na8EpzIOXMZe/l9HBla3keDloVC098=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-5QOCwucPMPS0e_d7xYGiDg-1; Mon, 21 Aug 2023 04:21:31 -0400
X-MC-Unique: 5QOCwucPMPS0e_d7xYGiDg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31c5ce917eeso2708f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692606090; x=1693210890;
        h=content-transfer-encoding:mime-version:organization:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eaf9HwLmG8Bo3tyWjnYsW92xTAurT4+tOAPq2I/GiY=;
        b=ixpYjVCE8njwReve27zHxi8ziXM6FiVglY7R8f1YxOvFGH/bayc7oD3VTBR97tPJtm
         OH/JqBWDB0nSl1MvPaZNoQB69mQCRUpPigKKn5wyMyrlWckUKn+QQYZoNb4gG6tNuSnG
         vGQ7gknc01/I79wnWo4/QeTiupfML5DtjUmbxQ9H4IzKJrTwdJMBeT4Todxjy4yO3oWI
         p88e8YOmqvb5hd1I6JrFt8E4i35njfv8kJGlTd7qidTAyhl5FQUGIa+DGyME1EBaBJ5a
         0iPN7Tu6ZjkN33RzBUnPLbfyy4tj6RMrnkTFjtTAj2mt3VpkTBduznOhzPwUx0KDQ1ik
         Orlw==
X-Gm-Message-State: AOJu0YwwIwPmD388Vd7A3L0JQQZZmwscB2SDFrZa+rRhA2DloVzrLNpK
        DE3XnNdekFm74P4mRpDMKfn5ALTtuX4dOK6y3qD9EBIxFdMgP8Tm7QnlorlIxM/E9akeP1ootbw
        13yK258n3pIskblOaRoeKu2w6
X-Received: by 2002:adf:fc42:0:b0:31a:e29f:5eab with SMTP id e2-20020adffc42000000b0031ae29f5eabmr4087039wrs.7.1692606090669;
        Mon, 21 Aug 2023 01:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsre/x3MLBsL5h49evDSmd6yBoDNK6JitjuNuABkbeKnCbSrpYrljgyoW50Q+J3SiwlkxZiw==
X-Received: by 2002:adf:fc42:0:b0:31a:e29f:5eab with SMTP id e2-20020adffc42000000b0031ae29f5eabmr4087031wrs.7.1692606090366;
        Mon, 21 Aug 2023 01:21:30 -0700 (PDT)
Received: from dhcp-64-2.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b003188358e08esm11533705wrm.42.2023.08.21.01.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 01:21:29 -0700 (PDT)
Message-ID: <6486c31d21584cec01b4f1bc147dd7f06744243a.camel@redhat.com>
Subject: [RESEND PATCH v2] xarray: Document necessary flag in alloc functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Date:   Mon, 21 Aug 2023 10:21:29 +0200
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new line to the docstrings of functions wrapping __xa_alloc() and
__xa_alloc_cyclic(), informing about the necessity of flag XA_FLAGS_ALLOC
being set previously.

The documentation so far says that functions wrapping __xa_alloc() and
__xa_alloc_cyclic() are supposed to return either -ENOMEM or -EBUSY in
case of an error. If the xarray has been initialized without the flag
XA_FLAGS_ALLOC, however, they fail with a different, undocumented error
code.

As hinted at in Documentation/core-api/xarray.rst, wrappers around these
functions should only be invoked when the flag has been set. The
functions' documentation should reflect that as well.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Version 2 of the proposed documentation update. As Matthew requested, I
added the sentence to all functions wrapping the above mentioned two
core functions.
Additionally, I added it to themselves, too, as these functions can also
be called by the user directly.
I also rephrased the commit message so that the implemented change is
mentioned first.
---
 include/linux/xarray.h | 18 ++++++++++++++++++
 lib/xarray.c           |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 741703b45f61..cb571dfcf4b1 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -856,6 +856,9 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -886,6 +889,9 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -916,6 +922,9 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -949,6 +958,9 @@ static inline int __must_check xa_alloc_irq(struct xarray *xa, u32 *id,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
@@ -983,6 +995,9 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
@@ -1017,6 +1032,9 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
diff --git a/lib/xarray.c b/lib/xarray.c
index 2071a3718f4e..73b3f8b33a56 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the

