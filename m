Return-Path: <linux-kernel+bounces-40482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E871583E150
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7192830B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F044A20DC6;
	Fri, 26 Jan 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPDmlMpM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5F210E5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293613; cv=none; b=fvcwY3uHUirKzoLFJclHQg3W3+iFTwH1e4CVMbBChbxVhKiDOZCjMgcUejeOcGsB92/GvE3E6LimoamYavoYnVsO9+ujdqHPug88vAyPLRRNXbO9zINHxcubkH6TiDt+m+rE5JpPgo1jMtu3xXV0evjmT3aj/ZOG7Y2iiBtr3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293613; c=relaxed/simple;
	bh=6Xa4XG9oTEA84yJq6oqUTkyDqiqogThs/YLsVpkcd6s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ac+ICOf/c9wJ1UPQDCKcAjUI3a585lks1cW1U3+Tf5FOLG8QQRa1EH+/57+cUlLeRopWWjwfgB/P5fBcEoju0VA7qW7Djilz80Kojp8NI2ZtOpbXarqbOO4W2evBa5PcpZx8xErzyI1BQtPDZMnEW97X97fava11ksmxwp4/Pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPDmlMpM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-602abe779b6so9757767b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706293610; x=1706898410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y7e/0QvlOlM0ZCsxQZvvBJgZQTxVZVmdvhelyGmS3+g=;
        b=bPDmlMpMbYgkJcKtwMF0drjSQOq5ECBN9I0hKkq9XKTXyW42tOOK6t54NLVFBGn+1n
         QJV9KWCNc+hDm8BSwerbsvFBCrDOTLh1IUYSvQcvKJGwmbo/Yca11Ctu2HZXN+hwpklJ
         wiZqy6TkTjh+pQAXjvBQyxAyzgdQStZUh9FeVqloy6XSuidiCn44NoOG6AXhU7TnyKft
         QtkvcSO6HVvL32++Gm6JPW+OAww42mZ5qGPjlHLur3qxY5kD6FrxpsBeftdj+p2cdUac
         D5TqIXf7l1rjMBSbcoQ79EgX7UMjte2g4K0m509mw8rKdHIcbRADLBlVLBm2aIHPpNHL
         A4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293610; x=1706898410;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7e/0QvlOlM0ZCsxQZvvBJgZQTxVZVmdvhelyGmS3+g=;
        b=mFbXth/A2BHFpnipQTRborCXwdTmWua9QIfySVELOvwcBXz608xDQDrJdRbniwCHLj
         /artDgKtboItVxDR2qMHSyARugM3BWy297EPFWMyH2T/NemXGlxkgm6lyp+jFPYF6C43
         xsklxgYsXBuBKhxu+MOhm6FuWZKs8aBZ7HnjrGr3waY6jBlBOLBIjxx1oSkJoHiyahVQ
         KTOPssyh0le0tN8pztkaFccABI/rUkXBqTmuDn8jM4J/lNE83+aiFrZ2zBbL+IRb2mS1
         HVoxcAtefn3LX0oD/5wsczNgThwyopz/cp9Y39/7RF7q4N9KLmKpWIIRn8oRUNGlH/G3
         Vk5w==
X-Gm-Message-State: AOJu0YxaPzV/dWjMzkxcBuEMGdExTYV33cbpbGZEWign3sSxZ+xeBKoF
	dkBJZiroJ24IspFvgYzxQ3pjJ14mZ9hZIoV3zgGOP0gtabd0j8JOanPcrHY8VNpFxC7c8fZOIqI
	YBjr9Dc2Dmq0KbpIMuMzHPA==
X-Google-Smtp-Source: AGHT+IGGu9TMuAH4sSdAiyZVOl8aGB0JU71txLWu58TspTrRV1aYkawA9tmwofI0MzKad8AKt638XeV95tHjbeN3nw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:cc8a:c6c9:a475:ebf])
 (user=lokeshgidra job=sendgmr) by 2002:a05:690c:dd6:b0:5ff:82c7:1528 with
 SMTP id db22-20020a05690c0dd600b005ff82c71528mr62574ywb.5.1706293610619; Fri,
 26 Jan 2024 10:26:50 -0800 (PST)
Date: Fri, 26 Jan 2024 10:26:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126182647.2748949-1-lokeshgidra@google.com>
Subject: [PATCH 1/3] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c              | 39 -----------------------------------
 include/linux/userfaultfd_k.h | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 959551ff9a95..af5ebaad2f1d 100644
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
2.43.0.429.g432eaa2c6b-goog


