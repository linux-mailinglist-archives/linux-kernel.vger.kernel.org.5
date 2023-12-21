Return-Path: <linux-kernel+bounces-8498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8081B8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7132A1C22ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2076DD6;
	Thu, 21 Dec 2023 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfMRnHIw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A39276DCB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d40eec5e12so2686945ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165849; x=1703770649; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8TLE2kUuGCG2w8SZOBe9ZxqNJOdz1Kg/CbBvyN0PpE=;
        b=IfMRnHIwmf1a+4/uYjLK1b1swC3/TGJR+H3FLiK4f//gU9Pav6KYgbqG/6Yi8M924F
         hv1sJTN95TbIToNBXoo6nNja88cc2LZ+aAG/YXvFgEp8khjIHPsgO5aEmo1jlJAN9bqZ
         zX51zISdV7oWuUFc+XAeNSzeiLwu9kHZttLOWdYlRVxYA44Lo3OP7G9KlBphbXA5gvI+
         zsBLm7jY8CVcYwQlgJgrxV+6+3sp+w7VEQihtV4hXNHQC/rOK8bbv9mp02UbJDMez/La
         cWWQKMpZ5KKE434N3FDuuTlZ2TDk5Z3hj9cJ9l6tvXLsxyMJPPP0DU46j3qM7HTWh7By
         Hvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165849; x=1703770649;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8TLE2kUuGCG2w8SZOBe9ZxqNJOdz1Kg/CbBvyN0PpE=;
        b=JfpXERpP+nVGpxr8DHv3X1o1750R6DdE192lXOXnpTbgELiKLzt0XcJn5PTvE7uEoI
         YRb7veRTusMMqkNYAdiMf86zKZPMSNuT4XeXQVMmGD/G2rK7+zWtUEfAkKaRWt/OO3zo
         JGs56PoSdFLObrfiLs4oOOubx7WGBtgOQoh9LggfIBHqQL0D0DZ/mTxE8wGpUZbiblj/
         ZO99wTSrtg/Tqg9A76Ee37hJ/q+H4hCgmiCuXp+NzGcXvGYHfCFsjzod1ZEuHRMDe1qP
         ZDBDMdvFj+Emw8R+L1P3G/s5VYvtHI8Tv/0zDdjo0wjubBj3JbblSfy62mvoP8882AGG
         gmyw==
X-Gm-Message-State: AOJu0Yx0mA59ADa4Q8PkxmMZnXslzLRMnx8CoOTA639+ei89tNHm2uJh
	Hr7h65/ddURgv4AOrjEmOPWC10O2kP8=
X-Google-Smtp-Source: AGHT+IG1VZkMuki8ILhK8wkgFhj53kOB6dgGstwuC7zuTi0EnqIDuB2kQP7HxWEuA6GDaVY+kHNlPA==
X-Received: by 2002:a17:902:d2cb:b0:1d3:4af3:2e75 with SMTP id n11-20020a170902d2cb00b001d34af32e75mr18726806plc.81.1703165849442;
        Thu, 21 Dec 2023 05:37:29 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001d06df5c1absm1636297plg.86.2023.12.21.05.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:37:28 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz
Cc: roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	qiruipeng <qiruipeng@lixiang.com>
Subject: [RFC PATCH 6/7] mm/slub: make slab data more observable
Date: Thu, 21 Dec 2023 21:37:17 +0800
Message-Id: <20231221133717.882-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is interested in data stored within slab subsystem. Add full list
back into corresponding struct, and record full list within respective
functions instead of enabling SLUB_DEBUG directly, which will intruduce
sensible overhead.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 mm/slab.h |  2 ++
 mm/slub.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 3d07fb428393..a42a54c9c5de 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -799,6 +799,8 @@ struct kmem_cache_node {
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
 	struct list_head full;
+#elif defined(CONFIG_OS_MINIDUMP)
+	struct list_head full;
 #endif
 #endif
 
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..1a496ec945b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1730,10 +1730,26 @@ static inline int check_object(struct kmem_cache *s, struct slab *slab,
 static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
 			     enum track_item alloc, unsigned long addr) {}
+#ifndef CONFIG_OS_MINIDUMP
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
+#else
+static inline void add_full(struct kmem_cache *s,
+	struct kmem_cache_node *n, struct slab *slab)
+{
+	lockdep_assert_held(&n->list_lock);
+	list_add(&slab->slab_list, &n->full);
+}
+
+static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct slab *slab)
+{
+	lockdep_assert_held(&n->list_lock);
+	list_del(&slab->slab_list);
+}
+#endif
+
 slab_flags_t kmem_cache_flags(unsigned int object_size,
 	slab_flags_t flags, const char *name)
 {
@@ -2570,6 +2586,14 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		spin_lock_irqsave(&n->list_lock, flags);
 	} else {
 		mode = M_FULL_NOLIST;
+#ifdef CONFIG_OS_MINIDUMP
+		/*
+		 * Taking the spinlock removes the possibility that
+		 * acquire_slab() will see a slab that is frozen
+		 */
+		spin_lock_irqsave(&n->list_lock, flags);
+
+#endif
 	}
 
 
@@ -2577,7 +2601,11 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab")) {
+#ifndef CONFIG_OS_MINIDUMP
 		if (mode == M_PARTIAL)
+#else
+		if (mode != M_FREE)
+#endif
 			spin_unlock_irqrestore(&n->list_lock, flags);
 		goto redo;
 	}
@@ -2592,6 +2620,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
 	} else if (mode == M_FULL_NOLIST) {
+#ifdef CONFIG_OS_MINIDUMP
+		add_full(s, n, slab);
+		spin_unlock_irqrestore(&n->list_lock, flags);
+#endif
 		stat(s, DEACTIVATE_FULL);
 	}
 }
@@ -4202,6 +4234,9 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 	atomic_long_set(&n->nr_slabs, 0);
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
+#elif defined(CONFIG_OS_MINIDUMP)
+	INIT_LIST_HEAD(&n->full);
+
 #endif
 }
 
@@ -5009,7 +5044,8 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 		list_for_each_entry(p, &n->partial, slab_list)
 			p->slab_cache = s;
 
-#ifdef CONFIG_SLUB_DEBUG
+#if defined(CONFIG_SLUB_DEBUG) || \
+	defined(CONFIG_OS_MINIDUMP)
 		list_for_each_entry(p, &n->full, slab_list)
 			p->slab_cache = s;
 #endif
-- 
2.17.1


