Return-Path: <linux-kernel+bounces-62612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9BC8523A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5ACB26390
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA455E78;
	Tue, 13 Feb 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g52v5K/R"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D654FA5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783588; cv=none; b=SLYK04QuKZmfMasKlnkFp6GlDTNAxIiCt6M60b0QIz1bnQqFH3iagcg7XFbjCZEkSFmGe7JDpEGEhds6CLy8BKSVSPd4Dn7OMSSigqCtGNrAzegpTq0nldDf/X2AXsD/2v9t94Vwn8e6G8Rhm1pouQ/VsNmmTF2VMwkpzPnj4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783588; c=relaxed/simple;
	bh=z41+dvNtRXeKCs53H9ygm12hU6JxKhETApVU+NXe4U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PaSnUBgVYgX8/o+ZFTTIhmnwLwxNakigz1GEEY7sL2mQPBJ2El2tknjIr/+ed8C4Z0B9aHi+Cl0HSP1cu07zRZJq2An+jqG52SOgLQ8wwQGKgJl1NTYTZkdF3f+QhSGKvJx1V4o86Eg0ryYBZz8oeVhU/+M91paZrT1SmwKkXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g52v5K/R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso576291276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707783585; x=1708388385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTp34JzZtDcGzw26Xy4JuyVdUXeLDl6wgD9/498E4U=;
        b=g52v5K/RGyVGjMvU9YqeKBjkNahzo5eqSpoHrWByHxcBSyJ7vBCWUIMWjYXjWNKdjR
         H7yDKG7ki0iVR4Jfgc6e+gGlNNzQPGaZcEWlSjC2pvvbLhsuQmZD4dkaEoMbcrDfbZRF
         wiW7IzKRAOJKg8mGObhMLWPb80z3UbOjRmmUWps+EOJvG+V/aPTRWA8yggof2FI0SiR/
         cEzPXtdPTQNH78lXR634/EEXuUxHVmzmEmUk3C8dw2tTWaUUg+Ri4GDJ+A/6UJS31pX/
         KI8cfUPgHneiCH85qFGA3iaN5iPYUhE7x+E3PRhJqbiQYE6ps5ObN9g9Cv0/IY69SKDE
         NhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783585; x=1708388385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTp34JzZtDcGzw26Xy4JuyVdUXeLDl6wgD9/498E4U=;
        b=pB1iloxBpJO5iUN64e+qSvStRyHNb3GRMRnC6CxitGikFRts/1rCLXWSTCgc4VKKAB
         I5T7Dr1NclLAXEKL4GmjqCmeJuVhrGVCNJIXsJyGQuWcXEc6Fqbvdfe9RlPA1qjZQGy9
         WKAQOq5NNOd195K5grgT81cDnbwPnJnp+R3RKJGZoM9UJU2nPHQfnvlCfYOh4lepq42n
         U1RQ46F3mxKGyoj4X/lLpcCJWDEPZ0YHRsc44e5V411Ay3HyBh5wS2tx0dxRLS+5bo6A
         j5pVRg60bqAGYALQP3QCiYBnKfnfGjwigcRdsVTC+0PWdbf1bDy9ByIGDQ9AbNUA3TkL
         sSAQ==
X-Gm-Message-State: AOJu0YzsdJOsIk15piOyhjJUCOYPc83OewUhAsNv+ylN4EuVg+geaT5Y
	RAi8ppl8TYcv2V/ouUXmjzpVlzReORA31UVwqq7adSnJjaTXejBH44ziQiMatz2/CXIAFnGLJal
	GVqFwyEVG+UI+TtnFB2P4jg==
X-Google-Smtp-Source: AGHT+IHHF8psOCpR3jPtRIweQhip+WhYFn+NGs+b1/7N2Bm+HUMlIaS9Pt1A9QzZr7uT4pBB5l5vrCPMXQlp/u7k7Q==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:fd80:ef0f:6359:fc4c])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:d2c8:6e50 with
 SMTP id w2-20020a05690210c200b00dc6d2c86e50mr1289834ybu.7.1707783585214; Mon,
 12 Feb 2024 16:19:45 -0800 (PST)
Date: Mon, 12 Feb 2024 16:19:18 -0800
In-Reply-To: <20240213001920.3551772-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213001920.3551772-2-lokeshgidra@google.com>
Subject: [PATCH v5 1/3] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 fs/userfaultfd.c              | 39 -----------------------------------
 include/linux/userfaultfd_k.h | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 05c8e8a05427..58331b83d648 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -50,45 +50,6 @@ static struct ctl_table vm_userfaultfd_table[] = {
 
 static struct kmem_cache *userfaultfd_ctx_cachep __ro_after_init;
 
-/*
- * Start with fault_pending_wqh and fault_wqh so they're more likely
- * to be in the same cacheline.
- *
- * Locking order:
- *	fd_wqh.lock
- *		fault_pending_wqh.lock
- *			fault_wqh.lock
- *		event_wqh.lock
- *
- * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
- * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
- * also taken in IRQ context.
- */
-struct userfaultfd_ctx {
-	/* waitqueue head for the pending (i.e. not read) userfaults */
-	wait_queue_head_t fault_pending_wqh;
-	/* waitqueue head for the userfaults */
-	wait_queue_head_t fault_wqh;
-	/* waitqueue head for the pseudo fd to wakeup poll/read */
-	wait_queue_head_t fd_wqh;
-	/* waitqueue head for events */
-	wait_queue_head_t event_wqh;
-	/* a refile sequence protected by fault_pending_wqh lock */
-	seqcount_spinlock_t refile_seq;
-	/* pseudo fd refcounting */
-	refcount_t refcount;
-	/* userfaultfd syscall flags */
-	unsigned int flags;
-	/* features requested from the userspace */
-	unsigned int features;
-	/* released */
-	bool released;
-	/* memory mappings are changing because of non-cooperative event */
-	atomic_t mmap_changing;
-	/* mm with one ore more vmas attached to this userfaultfd_ctx */
-	struct mm_struct *mm;
-};
-
 struct userfaultfd_fork_ctx {
 	struct userfaultfd_ctx *orig;
 	struct userfaultfd_ctx *new;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e4056547fbe6..691d928ee864 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -36,6 +36,45 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
+/*
+ * Start with fault_pending_wqh and fault_wqh so they're more likely
+ * to be in the same cacheline.
+ *
+ * Locking order:
+ *	fd_wqh.lock
+ *		fault_pending_wqh.lock
+ *			fault_wqh.lock
+ *		event_wqh.lock
+ *
+ * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
+ * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
+ * also taken in IRQ context.
+ */
+struct userfaultfd_ctx {
+	/* waitqueue head for the pending (i.e. not read) userfaults */
+	wait_queue_head_t fault_pending_wqh;
+	/* waitqueue head for the userfaults */
+	wait_queue_head_t fault_wqh;
+	/* waitqueue head for the pseudo fd to wakeup poll/read */
+	wait_queue_head_t fd_wqh;
+	/* waitqueue head for events */
+	wait_queue_head_t event_wqh;
+	/* a refile sequence protected by fault_pending_wqh lock */
+	seqcount_spinlock_t refile_seq;
+	/* pseudo fd refcounting */
+	refcount_t refcount;
+	/* userfaultfd syscall flags */
+	unsigned int flags;
+	/* features requested from the userspace */
+	unsigned int features;
+	/* released */
+	bool released;
+	/* memory mappings are changing because of non-cooperative event */
+	atomic_t mmap_changing;
+	/* mm with one ore more vmas attached to this userfaultfd_ctx */
+	struct mm_struct *mm;
+};
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /* A combined operation mode + behavior flags. */
-- 
2.43.0.687.g38aa6559b0-goog


