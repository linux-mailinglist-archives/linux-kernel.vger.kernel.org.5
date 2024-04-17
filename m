Return-Path: <linux-kernel+bounces-149111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD78A8BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903611F22E31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A9241E7;
	Wed, 17 Apr 2024 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIZHqRuU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B657364AE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381322; cv=none; b=bK4mr7aMQcGfhdbEU41zQdvoZ/mzr8Q70rXJQusn/AapelKk6mXD8HEp7Hxjg58bidZRYdBfo2WG2F8j8tj8o7QRSmz1tKxD1EhphaZy9IojJPtZCfN6iSplcfyVh87uJpxFMpl5c26u+33+HyAZ11s16MNPPMNBtbGaYodBEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381322; c=relaxed/simple;
	bh=XDRUCy/tblmy0O5EO2E0OEsZFi4P01wqWmDopqbyHAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rE1UZDmHPGX2bmENgSubHZEbC2spknPpZHtgdpIjtIaPdO96QLulvBvNfVsUYbSOZWrO2BYQlM/M4AqtvI2z9bE9oSVbt9y4+1++0a0rRld4XwYx0tESY8TMEdodvbapVtR9BDet7YXmz1k8Hft4Id8FFfyOKc0Ke5T5+RBMDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIZHqRuU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615372710c4so322997b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713381319; x=1713986119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgzviX8tertEbO58FSXLy5axm5X38SqIZ9fho1sI7Is=;
        b=vIZHqRuU9xNT6QPG8WrveBugqzL15nIhIQUTFe5z82/K81q38ivU6wbt6SZtw37wWf
         8SkGd4S/11c0Af7WeQDj5VScY/r4EAVeNU+791aQhFJkegVA1Xf6d5u3AR1xe0943IBg
         VZu7HZyxg4jJNmXLCxHCZ3vtScQn4oVArZ3NIvXK5bpHK7i2UMQZ9E0mRMK3UORrR9xU
         2cxX3zdaY6HzPZuw3+znfibp/DLuwHFC0goDn+rBWu0o0gGsxgftLDxcWmrzg12n0PkL
         IWU1l8yyVLuGsMvDEWA3d5UfOJ9bGvTRhfZ37mabiFjpZg4gp/PJwvNlLDeMFmYdxlQz
         c+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381319; x=1713986119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgzviX8tertEbO58FSXLy5axm5X38SqIZ9fho1sI7Is=;
        b=OMf+/kK0ItG4Hm+lnW+zCawKfgcjNOVxDT0HgsMNzq0mnDOndy1Av3si+nT/andvXz
         DFRAqMckKVc60KEKF/7dF3JlDbo9ExbKGzOqIrtRwPUQKeT/QPD3P/SCUfeJEBs0Z+E7
         EHPM9+fk3ovVmq/Prl06JptuFOsaveojw47+w3F+q23uSCHU7geKpPvM9O4Cj3B9N51x
         6kN+YaDbZdh+I5E/9QC3fiSoYLSGifZOfd6WKT7CbbrdxZ7xZscTSvwFq0F8NjfSwYBN
         VR40TfNBCknqpOcMoM48LnN2b+wvwvnQZ9WaGeenoJxropayyfihar1kUgWdD3tA5iMh
         BP5Q==
X-Gm-Message-State: AOJu0YyjDTNWm5Gba9Om1r7jHuc/D8sdXoTA6Lu7sTh8LqyW7Fuc72ij
	zMJVbbk/QtKJkZ5MjCF3QQN+XtpLkiPUrcp02OKWaw6tV1a7zm9dTTI8MPFu73WuV30oF4ROoNc
	c8DT1uZK+vg==
X-Google-Smtp-Source: AGHT+IH48BhlnuGsixBDdQqgsIeKhJr8qbkwL4npU8TNJdkUNG+s71onx1n6kkhZfSloJbxdb2GnbZHlgExmFw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a0d:d94d:0:b0:618:8e4b:f4b0 with SMTP id
 b74-20020a0dd94d000000b006188e4bf4b0mr27664ywe.9.1713381319484; Wed, 17 Apr
 2024 12:15:19 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:13:43 +0000
In-Reply-To: <20240417191418.1341988-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417191418.1341988-1-cmllamas@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417191418.1341988-4-cmllamas@google.com>
Subject: [PATCH 3/4] binder: add support for PF_LARGE_HANDLES
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the PF_LARGE_HANDLES flag to enable the use of monotonically
increasing counters to generate handles. This improves performance in
transactions when dealing with a large number of references.

The legacy logic performs an inorder traversal of an rbtree to find the
smallest unused handle. This limitation is due to userspace using the
handles as indexes (e.g. in vectors). The new logic scales much better
but requires userspace to support large handle numbers.

The benchmark below with 100,000 references shows the performance gains
in binder_get_ref_for_node_olocked() calls with PF_LARGE_HANDLES.

  [  167.855945] binder_get_ref_for_node_olocked: 17us (flag on)
  [  237.088072] binder_get_ref_for_node_olocked: 18178us (flag off)

Suggested-by: Tim Murray <timmurray@google.com>
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c            | 44 ++++++++++++++++++++++-------
 drivers/android/binder_internal.h   |  3 ++
 include/uapi/linux/android/binder.h |  3 +-
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 54d27dbf1de2..f120a24c9ae6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1045,6 +1045,35 @@ static struct binder_ref *binder_get_ref_olocked(struct binder_proc *proc,
 	return NULL;
 }
 
+static u32 next_ref_desc(struct binder_proc *proc, struct binder_node *node)
+{
+	struct binder_ref *ref;
+	struct rb_node *n;
+	u32 desc;
+
+	/* Handle 0 is reserved for context manager refs */
+	if (node == proc->context->binder_context_mgr_node)
+		return 0;
+
+	/* Get the next handle (non-zero) */
+	if (proc->flags & PF_LARGE_HANDLES)
+		return proc->next_ref_desc++ ? : proc->next_ref_desc++;
+
+	/*
+	 * Userspace doesn't support large handles. Find the smallest
+	 * unused descriptor by doing an in-order traversal (slow).
+	 */
+	desc = 1;
+	for (n = rb_first(&proc->refs_by_desc); n; n = rb_next(n)) {
+		ref = rb_entry(n, struct binder_ref, rb_node_desc);
+		if (ref->data.desc > desc)
+			break;
+		desc = ref->data.desc + 1;
+	}
+
+	return desc;
+}
+
 /**
  * binder_get_ref_for_node_olocked() - get the ref associated with given node
  * @proc:	binder_proc that owns the ref
@@ -1068,11 +1097,9 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 					struct binder_node *node,
 					struct binder_ref *new_ref)
 {
-	struct binder_context *context = proc->context;
 	struct rb_node **p = &proc->refs_by_node.rb_node;
 	struct rb_node *parent = NULL;
 	struct binder_ref *ref;
-	struct rb_node *n;
 
 	while (*p) {
 		parent = *p;
@@ -1095,14 +1122,8 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 	rb_link_node(&new_ref->rb_node_node, parent, p);
 	rb_insert_color(&new_ref->rb_node_node, &proc->refs_by_node);
 
-	new_ref->data.desc = (node == context->binder_context_mgr_node) ? 0 : 1;
-	for (n = rb_first(&proc->refs_by_desc); n != NULL; n = rb_next(n)) {
-		ref = rb_entry(n, struct binder_ref, rb_node_desc);
-		if (ref->data.desc > new_ref->data.desc)
-			break;
-		new_ref->data.desc = ref->data.desc + 1;
-	}
-
+retry:
+	new_ref->data.desc = next_ref_desc(proc, node);
 	p = &proc->refs_by_desc.rb_node;
 	while (*p) {
 		parent = *p;
@@ -1112,6 +1133,8 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 			p = &(*p)->rb_left;
 		else if (new_ref->data.desc > ref->data.desc)
 			p = &(*p)->rb_right;
+		else if (proc->flags & PF_LARGE_HANDLES)
+			goto retry;
 		else
 			BUG();
 	}
@@ -5663,6 +5686,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
 	proc->cred = get_cred(filp->f_cred);
+	proc->next_ref_desc = 1;
 	INIT_LIST_HEAD(&proc->todo);
 	init_waitqueue_head(&proc->freeze_wait);
 	proc->default_priority = task_nice(current);
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 3312fe93a306..221ab7a6384a 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -337,6 +337,8 @@ struct binder_ref {
  *                        (protected by @outer_lock)
  * @refs_by_node:         rbtree of refs ordered by ref->node
  *                        (protected by @outer_lock)
+ * @next_ref_desc:        monotonic wrap-around counter to get the next handle
+ *                        (protected by @outer_lock)
  * @waiting_threads:      threads currently waiting for proc work
  *                        (protected by @inner_lock)
  * @pid                   PID of group_leader of process
@@ -407,6 +409,7 @@ struct binder_proc {
 	struct rb_root nodes;
 	struct rb_root refs_by_desc;
 	struct rb_root refs_by_node;
+	u32 next_ref_desc;
 	struct list_head waiting_threads;
 	int pid;
 	struct task_struct *tsk;
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 972f402415c2..d257ab8689ce 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -254,8 +254,9 @@ struct binder_extended_error {
 /* Used with BINDER_SET_PROC_FLAGS ioctl */
 enum proc_flags {
 	PF_SPAM_DETECTION	= (1 << 0), /* enable oneway spam detection */
+	PF_LARGE_HANDLES	= (1 << 1), /* use large reference handles */
 
-	PF_SUPPORTED_FLAGS_MASK = PF_SPAM_DETECTION,
+	PF_SUPPORTED_FLAGS_MASK = (PF_SPAM_DETECTION | PF_LARGE_HANDLES),
 };
 
 enum {
-- 
2.44.0.683.g7961c838ac-goog


