Return-Path: <linux-kernel+bounces-14739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A6822153
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BD41F21BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0093171D8;
	Tue,  2 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY6pwNo1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA7171AB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so6464776e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221235; x=1704826035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZAvt7CkxqIe5cgK0fSSW+F0xApr58BOh4APGf1P6Lc=;
        b=FY6pwNo1H8WB+3cPzzwrc4urNP/9S3hQMHbQzgGC+zilS+ybIAbRohqzbwW1+8Kpo+
         mWnB5z+cwIpvFA+R5Klm2bOtiLWocJO713gWJ+L12TJakTfozai0erqNoPPSpL09gLzz
         NohyRAclPYHbNEax6rwrCaPZfDFoHebuQ23zTUAzqn+Sk0BsbHNg+OsK+OFEI10TJjw9
         TnP4oSvU7oMVeslq1ZXjk6ge6tpjwjT5NkkuvP6D6XuD2UxgYBdF5uu+ZyWhkjXl12hf
         8ePwPoYaD8qOs9SrAkUb5l7xBeS1RHCk5otyUVg+20kKgG/FX6nSQDSr0z+po2/GRDgd
         UErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221235; x=1704826035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZAvt7CkxqIe5cgK0fSSW+F0xApr58BOh4APGf1P6Lc=;
        b=pELx/uhrkylsAVql7LAuPk/bgLIFWXbJtzpTtFgPocVE7cSPpkx+1koWZ2O3RpZgZt
         sNdEcU5fESXHgfYNCY0vCtK83E1pYlgItkoq4pnCb5zjngy28UOBGoIlAIi2XMTzF5Al
         zOQ9ow6XrTloB0cRVITeCV5N6WX8VFeBuS2geK+ngMT2s2nezfIHeFiaHOyQmLYEV3iP
         dHzUviWeEYmki4he+S6+5Q1tySRTHcx7B/YiqknLzQjwm1nqyOrGCEg7cVBJUwxMdTM5
         aYiAc+ry4YG6/BLJmk5H7lQ58HcvZPtwXUUW31hgSteL6H0O4gciF/LsqapAA63LMLBo
         ao+g==
X-Gm-Message-State: AOJu0YzmNwkr3RBea6CTzOG6mHWJMAKYawex+4dxr7WE1/i1f8p+OO93
	sZ4bRgRjjE9CAQMiPGyoT3JXXJ1P67kcVQ==
X-Google-Smtp-Source: AGHT+IG2+hyU4AcsC7fH/iKMYGpwIo7u9xULgZSVpY4T2CGFn4/x55AJtPvIKYTpeIpe7us9O7g2tw==
X-Received: by 2002:ac2:520b:0:b0:50e:9a53:c22c with SMTP id a11-20020ac2520b000000b0050e9a53c22cmr794413lfl.126.1704221234559;
        Tue, 02 Jan 2024 10:47:14 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:47:14 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v3 08/11] mm: vmalloc: Support multiple nodes in vread_iter
Date: Tue,  2 Jan 2024 19:46:30 +0100
Message-Id: <20240102184633.748113-9-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102184633.748113-1-urezki@gmail.com>
References: <20240102184633.748113-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the vread_iter() to be able to perform a sequential
reading of VAs which are spread among multiple nodes. So a
data read over the /dev/kmem correctly reflects a vmalloc
memory layout.

Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fa4ab2bbbc5b..594ed003d44d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -906,7 +906,7 @@ unsigned long vmalloc_nr_pages(void)
 
 /* Look up the first VA which satisfies addr < va_end, NULL if none. */
 static struct vmap_area *
-find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
+__find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 {
 	struct vmap_area *va = NULL;
 	struct rb_node *n = root->rb_node;
@@ -930,6 +930,41 @@ find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 	return va;
 }
 
+/*
+ * Returns a node where a first VA, that satisfies addr < va_end, resides.
+ * If success, a node is locked. A user is responsible to unlock it when a
+ * VA is no longer needed to be accessed.
+ *
+ * Returns NULL if nothing found.
+ */
+static struct vmap_node *
+find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
+{
+	struct vmap_node *vn, *va_node = NULL;
+	struct vmap_area *va_lowest;
+	int i;
+
+	for (i = 0; i < nr_vmap_nodes; i++) {
+		vn = &vmap_nodes[i];
+
+		spin_lock(&vn->busy.lock);
+		va_lowest = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
+		if (va_lowest) {
+			if (!va_node || va_lowest->va_start < (*va)->va_start) {
+				if (va_node)
+					spin_unlock(&va_node->busy.lock);
+
+				*va = va_lowest;
+				va_node = vn;
+				continue;
+			}
+		}
+		spin_unlock(&vn->busy.lock);
+	}
+
+	return va_node;
+}
+
 static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
 {
 	struct rb_node *n = root->rb_node;
@@ -4102,6 +4137,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	struct vm_struct *vm;
 	char *vaddr;
 	size_t n, size, flags, remains;
+	unsigned long next;
 
 	addr = kasan_reset_tag(addr);
 
@@ -4111,19 +4147,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 	remains = count;
 
-	/* Hooked to node_0 so far. */
-	vn = addr_to_node(0);
-	spin_lock(&vn->busy.lock);
-
-	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
-	if (!va)
+	vn = find_vmap_area_exceed_addr_lock((unsigned long) addr, &va);
+	if (!vn)
 		goto finished_zero;
 
 	/* no intersects with alive vmap_area */
 	if ((unsigned long)addr + remains <= va->va_start)
 		goto finished_zero;
 
-	list_for_each_entry_from(va, &vn->busy.head, list) {
+	do {
 		size_t copied;
 
 		if (remains == 0)
@@ -4138,10 +4170,10 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 		WARN_ON(flags == VMAP_BLOCK);
 
 		if (!vm && !flags)
-			continue;
+			goto next_va;
 
 		if (vm && (vm->flags & VM_UNINITIALIZED))
-			continue;
+			goto next_va;
 
 		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
 		smp_rmb();
@@ -4150,7 +4182,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 		size = vm ? get_vm_area_size(vm) : va_size(va);
 
 		if (addr >= vaddr + size)
-			continue;
+			goto next_va;
 
 		if (addr < vaddr) {
 			size_t to_zero = min_t(size_t, vaddr - addr, remains);
@@ -4179,15 +4211,22 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (copied != n)
 			goto finished;
-	}
+
+	next_va:
+		next = va->va_end;
+		spin_unlock(&vn->busy.lock);
+	} while ((vn = find_vmap_area_exceed_addr_lock(next, &va)));
 
 finished_zero:
-	spin_unlock(&vn->busy.lock);
+	if (vn)
+		spin_unlock(&vn->busy.lock);
+
 	/* zero-fill memory holes */
 	return count - remains + zero_iter(iter, remains);
 finished:
 	/* Nothing remains, or We couldn't copy/zero everything. */
-	spin_unlock(&vn->busy.lock);
+	if (vn)
+		spin_unlock(&vn->busy.lock);
 
 	return count - remains;
 }
-- 
2.39.2


