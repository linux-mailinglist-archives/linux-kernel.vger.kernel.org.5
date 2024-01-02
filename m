Return-Path: <linux-kernel+bounces-14734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8E82214E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30641281A71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3E16404;
	Tue,  2 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV49Ep38"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933815AD0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso4333720e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221199; x=1704825999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyVIBHsk2yf4bdOQXWkGleZVntvAopzQ+wazdTKAsLk=;
        b=kV49Ep380VmNH/spQqvTmSVd5TymT2QFzj1QoI/Msf9QLHJQR9J1PxfznXwCDuGHGy
         ZfUgD9mT3GtRAGPwa1FS2wzWYeaF+RowmxvEuqW4vl6BYJXsAdcj6yV7TYFHb0ydkXf1
         5m+P8tJ+TsJI7g/NyoeFP03r+hCYB4azMd+v1V2189BMg9ccuXJ41plggayjm86ZPsZ0
         4EIdikqLIj24hAJPjTbRsPTeD9o6JSMs+zuezUi00taEVafiXJwaTtV1AOIl2FXn2meA
         y4uGjF+kpP0j0bEs6tqF6/TvcWqHZqpT6tyTkv6VSGui/fNvhVMcdkJD1JnwXPYU4n/I
         e70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221199; x=1704825999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyVIBHsk2yf4bdOQXWkGleZVntvAopzQ+wazdTKAsLk=;
        b=n9GdacAHSEt2bL2Z/ZQ5Z+0tTBihBv6x3xrMLyOZZCFWfOGXFM5TRYFwogzp6De3AR
         9yJAhuMAIFelqhRAiv7ywxEyuKpGY3rdKjv6ktubAwLZQPVo8BzRdOtbe+yYA79bFLHV
         7ujhsygdvNoxP/W2vJ8PoKMjdXUwnG5vboZgeEAfThwO5ZfqC3uTfmRc/3erctWl0J9b
         P1V5pKJCvVC/1SxkXRZH4uewuA1So0y2iskIP4c9NQDHzSpXVBrkjb5RDUNXLrPrfV3J
         VYSJKAV11y8qHXAYdUcJuNd2Nt2EmMN7LDmT/V1QVckaERDdPbk2VJhRlTo3UvmJdpu/
         B1eA==
X-Gm-Message-State: AOJu0YyRdCT4EkenlzqjM/aObnT1pETMqOxeixbF11dThTz64MK8u2Ul
	Ctt2y2vrIepbzH3XgDOaV/c=
X-Google-Smtp-Source: AGHT+IGk2c4cJ37LTpQvZZNmS0KxjEDGtzNNytmQ3n3FUXtipuMauWJG2kN4yaiFW3Ij1oRt/VBGdg==
X-Received: by 2002:ac2:4e43:0:b0:50b:c57e:1418 with SMTP id f3-20020ac24e43000000b0050bc57e1418mr6636354lfr.16.1704221199512;
        Tue, 02 Jan 2024 10:46:39 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:39 -0800 (PST)
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
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 03/11] mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
Date: Tue,  2 Jan 2024 19:46:25 +0100
Message-Id: <20240102184633.748113-4-urezki@gmail.com>
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

A vmap_init_free_space() is a function that setups a vmap space
and is considered as part of initialization phase. Since a main
entry which is vmalloc_init(), has been moved down in vmalloc.c
it makes sense to follow the pattern.

There is no a functional change as a result of this patch.

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 82 ++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 10f289e86512..06bd843d18ae 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2512,47 +2512,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static void vmap_init_free_space(void)
-{
-	unsigned long vmap_start = 1;
-	const unsigned long vmap_end = ULONG_MAX;
-	struct vmap_area *busy, *free;
-
-	/*
-	 *     B     F     B     B     B     F
-	 * -|-----|.....|-----|-----|-----|.....|-
-	 *  |           The KVA space           |
-	 *  |<--------------------------------->|
-	 */
-	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
-			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-			if (!WARN_ON_ONCE(!free)) {
-				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
-
-				insert_vmap_area_augment(free, NULL,
-					&free_vmap_area_root,
-						&free_vmap_area_list);
-			}
-		}
-
-		vmap_start = busy->va_end;
-	}
-
-	if (vmap_end - vmap_start > 0) {
-		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-		if (!WARN_ON_ONCE(!free)) {
-			free->va_start = vmap_start;
-			free->va_end = vmap_end;
-
-			insert_vmap_area_augment(free, NULL,
-				&free_vmap_area_root,
-					&free_vmap_area_list);
-		}
-	}
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
@@ -4465,6 +4424,47 @@ module_init(proc_vmalloc_init);
 
 #endif
 
+static void vmap_init_free_space(void)
+{
+	unsigned long vmap_start = 1;
+	const unsigned long vmap_end = ULONG_MAX;
+	struct vmap_area *busy, *free;
+
+	/*
+	 *     B     F     B     B     B     F
+	 * -|-----|.....|-----|-----|-----|.....|-
+	 *  |           The KVA space           |
+	 *  |<--------------------------------->|
+	 */
+	list_for_each_entry(busy, &vmap_area_list, list) {
+		if (busy->va_start - vmap_start > 0) {
+			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+			if (!WARN_ON_ONCE(!free)) {
+				free->va_start = vmap_start;
+				free->va_end = busy->va_start;
+
+				insert_vmap_area_augment(free, NULL,
+					&free_vmap_area_root,
+						&free_vmap_area_list);
+			}
+		}
+
+		vmap_start = busy->va_end;
+	}
+
+	if (vmap_end - vmap_start > 0) {
+		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+		if (!WARN_ON_ONCE(!free)) {
+			free->va_start = vmap_start;
+			free->va_end = vmap_end;
+
+			insert_vmap_area_augment(free, NULL,
+				&free_vmap_area_root,
+					&free_vmap_area_list);
+		}
+	}
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
-- 
2.39.2


