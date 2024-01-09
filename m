Return-Path: <linux-kernel+bounces-21441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FE5828F27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D636E1C23F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEAA3E479;
	Tue,  9 Jan 2024 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMU/frZc"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEE3DBB9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3000605a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836916; x=1705441716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJdTYBlIjcin2bkGTmynQSumdZz3dgXoqSyf4WvSjVU=;
        b=EMU/frZc9ghxaLPm8/vy3FB7dQTwkNfWmzbzCwftv3zsVRVLm0W6vgQoVULC4Z6iDA
         dcq0k4ia0YIGTmPZ521+35/feOl68i9emy6rdKXNdga2SN7QkWbWQYo3vr/s/qoeqENL
         b/HN8hecLFIt9xce6+IUOH/qrmkdAwzFygZk+UnZP3I9BZMOrrE6OqUcqUSB6CpDTL9g
         AM/LSdamKUywJJq1I53JLE36qr2JhjCsMv8VK9nh94h5A9KlIPAFyUOmvGpS4HFecra7
         Qjixoom+ackQ3HujDnU1QMV51Wc5H6YBK5h+ppR5680QQsvMgkMyxGiKnnw8WwJ6sB2t
         7w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836916; x=1705441716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJdTYBlIjcin2bkGTmynQSumdZz3dgXoqSyf4WvSjVU=;
        b=f4LFmVyA3i5IiUWvdrsXjt237KBp7EeIii8g4PAsJm4LDWFjE/5GPSNqAi6iz110qt
         KpLdBRFsCqzLERZxjyZmT012i4RVkkMrl2RrQIvvuAvGQIW5uEdj9yQo7gjue1LrNsdu
         +X9nSam5Rv2usB3mZjpUd5UIRJV75NIVaf1w3gpnHHZ4Cm0wjvzhCZgirWOFQqJw+aMi
         az8W4DybOGvvrA+ZPu0xTFDB9tIvMF99cMj5ZVdMZyP4DahjzLYOmqffsNb1geqfXnQJ
         AoZdl0RMeDj66clVG1bz/t7tJC37ZCCm+ExM9RUVMQyWj57fGSiy4aWQmT5iUiy0HyWZ
         tXag==
X-Gm-Message-State: AOJu0YyGbUBDYanFArg29QrrqDZnORNntVvg1iCg8FjwxYKqd6PCFqmf
	fpAq3/sC6euMujBH/f+KcEk=
X-Google-Smtp-Source: AGHT+IEY1u9+C9ve/6fZCRibtMw5JhMaTqOCNq88ZBiK2dFp6YlbfQKHh/Z1I7gpE1Unn81r2htysQ==
X-Received: by 2002:a17:90a:bd84:b0:28c:afd9:5805 with SMTP id z4-20020a17090abd8400b0028cafd95805mr221013pjr.27.1704836916057;
        Tue, 09 Jan 2024 13:48:36 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fd50])
        by smtp.gmail.com with ESMTPSA id li7-20020a17090b48c700b0028cec396567sm9106374pjb.44.2024.01.09.13.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:48:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: andrea.righi@canonical.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] Revert "kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"
Date: Tue,  9 Jan 2024 11:48:02 -1000
Message-ID: <20240109214828.252092-2-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109214828.252092-1-tj@kernel.org>
References: <20240109214828.252092-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dad3fb67ca1cbef87ce700e83a55835e5921ce8a.

The commit converted kernfs_idr_lock to an IRQ-safe raw_spinlock because it
could be acquired while holding an rq lock through bpf_cgroup_from_id().
However, kernfs_idr_lock is held while doing GPF_NOWAIT allocations which
involves acquiring an non-IRQ-safe and non-raw lock leading to the following
lockdep warning:

  =============================
  [ BUG: Invalid wait context ]
  6.7.0-rc5-kzm9g-00251-g655022a45b1c #578 Not tainted
  -----------------------------
  swapper/0/0 is trying to lock:
  dfbcd488 (&c->lock){....}-{3:3}, at: local_lock_acquire+0x0/0xa4
  other info that might help us debug this:
  context-{5:5}
  2 locks held by swapper/0/0:
   #0: dfbc9c60 (lock){+.+.}-{3:3}, at: local_lock_acquire+0x0/0xa4
   #1: c0c012a8 (kernfs_idr_lock){....}-{2:2}, at: __kernfs_new_node.constprop.0+0x68/0x258
  stack backtrace:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc5-kzm9g-00251-g655022a45b1c #578
  Hardware name: Generic SH73A0 (Flattened Device Tree)
   unwind_backtrace from show_stack+0x10/0x14
   show_stack from dump_stack_lvl+0x68/0x90
   dump_stack_lvl from __lock_acquire+0x3cc/0x168c
   __lock_acquire from lock_acquire+0x274/0x30c
   lock_acquire from local_lock_acquire+0x28/0xa4
   local_lock_acquire from ___slab_alloc+0x234/0x8a8
   ___slab_alloc from __slab_alloc.constprop.0+0x30/0x44
   __slab_alloc.constprop.0 from kmem_cache_alloc+0x7c/0x148
   kmem_cache_alloc from radix_tree_node_alloc.constprop.0+0x44/0xdc
   radix_tree_node_alloc.constprop.0 from idr_get_free+0x110/0x2b8
   idr_get_free from idr_alloc_u32+0x9c/0x108
   idr_alloc_u32 from idr_alloc_cyclic+0x50/0xb8
   idr_alloc_cyclic from __kernfs_new_node.constprop.0+0x88/0x258
   __kernfs_new_node.constprop.0 from kernfs_create_root+0xbc/0x154
   kernfs_create_root from sysfs_init+0x18/0x5c
   sysfs_init from mnt_init+0xc4/0x220
   mnt_init from vfs_caches_init+0x6c/0x88
   vfs_caches_init from start_kernel+0x474/0x528
   start_kernel from 0x0

Let's rever the commit. It's undesirable to spread out raw spinlock usage
anyway and the problem can be solved by protecting the lookup path with RCU
instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <andrea.righi@canonical.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: http://lkml.kernel.org/r/CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com
---
 fs/kernfs/dir.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a62960fdf73f..bce1d7ac95ca 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -27,7 +27,7 @@ static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
  */
 static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
-static DEFINE_RAW_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
+static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
@@ -539,7 +539,6 @@ void kernfs_put(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent;
 	struct kernfs_root *root;
-	unsigned long flags;
 
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
@@ -564,9 +563,9 @@ void kernfs_put(struct kernfs_node *kn)
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
-	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
+	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
 	kn = parent;
@@ -608,7 +607,6 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	struct kernfs_node *kn;
 	u32 id_highbits;
 	int ret;
-	unsigned long irqflags;
 
 	name = kstrdup_const(name, GFP_KERNEL);
 	if (!name)
@@ -619,13 +617,13 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 		goto err_out1;
 
 	idr_preload(GFP_KERNEL);
-	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
+	spin_lock(&kernfs_idr_lock);
 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
 	if (ret >= 0 && ret < root->last_id_lowbits)
 		root->id_highbits++;
 	id_highbits = root->id_highbits;
 	root->last_id_lowbits = ret;
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
+	spin_unlock(&kernfs_idr_lock);
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
@@ -661,9 +659,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
-	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
+	spin_unlock(&kernfs_idr_lock);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -716,9 +714,8 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	struct kernfs_node *kn;
 	ino_t ino = kernfs_id_ino(id);
 	u32 gen = kernfs_id_gen(id);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
+	spin_lock(&kernfs_idr_lock);
 
 	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
@@ -742,10 +739,10 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
+	spin_unlock(&kernfs_idr_lock);
 	return kn;
 err_unlock:
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
+	spin_unlock(&kernfs_idr_lock);
 	return NULL;
 }
 
-- 
2.43.0


