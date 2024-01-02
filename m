Return-Path: <linux-kernel+bounces-14742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA6822156
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E33A284574
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9446179A1;
	Tue,  2 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqyNJBaF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB861772F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7be1c65dso6281129e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221238; x=1704826038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9/T5K2ir2OJL/EqmsqvZQ3IpaLcsXDlXwLSIHXyRwY=;
        b=QqyNJBaF17QA4zJWhIzv8GdhcGwy4f1bXtAZCGdk6P7kYdAqHjznYBUttM5nINPnlV
         GKP1dQVag6KVzs8rClS3ibWcFkC3rGcDaY0TiylGhmIZ9m/4jTN5E3IA94/RQRBGPTwQ
         e4+q9qSauuA2k6oQf2ZyO750QcK53xwVq2rpf1BzGEUDkJMVHLtFA9xhQmJmKe5AIUha
         MbHQ8x+yLbXUBZtYFi6tr9/D1wDtFhWrC0lTLiDu5aLD7oeeJqRyB7L+CxvcWMKMNNit
         xnHuDZjlawjvFqPu6fldmU0o4GNjHjerZUWFrpJJ0d7kCAZhPvHXtH5gmLoGIocDc3Sx
         wV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221238; x=1704826038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9/T5K2ir2OJL/EqmsqvZQ3IpaLcsXDlXwLSIHXyRwY=;
        b=eL9X3sdiw+2PRaxxiga9v6t8jBAcD23Mw1NuYPegMLI8E0pRZ7XPTIqvyoTwUG5exv
         r615S7va/GgYLvaEs6TCnGtvmEABmnKE8mVyewDXhyGUpKMbPRb+Ta8OwVhu1+fiehW+
         oVH/TnBU1ca7uzfBjC8/jl3k56gzO/xKUDnuG1eu6IxkFtEbB4Y/36bn+aow00jmFnPv
         cpLAo/REq3qKgWpYnoTeUQAMN05N4jl+IFv5Ya90EdpLULbra1OC/bB5sm0Za8YOepBd
         j1AcrPagFgQwXWVDWqI6tluHVnlmtTBcUb3UTVNK4eJLOsWJM7tiEPoNpe6YBqe0GcJL
         2CfQ==
X-Gm-Message-State: AOJu0Yz13Es96AYP+CdVEqSmQc6P6VsfFLABt/0qZzSOoZiXi2AQy2qj
	JgFRgVMddKkMeAI9X0fQqwQ=
X-Google-Smtp-Source: AGHT+IHRbxitAW0kY1SyrAVZNdrjS0E3Q6aU8WIW/EO9WbSw23NrRoV+q5pHLLcc7N5Pm8J6+ROD3A==
X-Received: by 2002:ac2:5fae:0:b0:50e:5f99:21f2 with SMTP id s14-20020ac25fae000000b0050e5f9921f2mr6671072lfe.37.1704221237681;
        Tue, 02 Jan 2024 10:47:17 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:47:17 -0800 (PST)
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
Subject: [PATCH v3 11/11] mm: vmalloc: Add a shrinker to drain vmap pools
Date: Tue,  2 Jan 2024 19:46:33 +0100
Message-Id: <20240102184633.748113-12-urezki@gmail.com>
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

The added shrinker is used to return back current cached
VAs into a global vmap space, when a system enters into a
low memory mode.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ef534c76daef..e30dabf68263 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4917,8 +4917,37 @@ static void vmap_init_nodes(void)
 	}
 }
 
+static unsigned long
+vmap_node_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	unsigned long count;
+	struct vmap_node *vn;
+	int i, j;
+
+	for (count = 0, i = 0; i < nr_vmap_nodes; i++) {
+		vn = &vmap_nodes[i];
+
+		for (j = 0; j < MAX_VA_SIZE_PAGES; j++)
+			count += READ_ONCE(vn->pool[j].len);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+vmap_node_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int i;
+
+	for (i = 0; i < nr_vmap_nodes; i++)
+		decay_va_pool_node(&vmap_nodes[i], true);
+
+	return SHRINK_STOP;
+}
+
 void __init vmalloc_init(void)
 {
+	struct shrinker *vmap_node_shrinker;
 	struct vmap_area *va;
 	struct vmap_node *vn;
 	struct vm_struct *tmp;
@@ -4966,4 +4995,14 @@ void __init vmalloc_init(void)
 	 */
 	vmap_init_free_space();
 	vmap_initialized = true;
+
+	vmap_node_shrinker = shrinker_alloc(0, "vmap-node");
+	if (!vmap_node_shrinker) {
+		pr_err("Failed to allocate vmap-node shrinker!\n");
+		return;
+	}
+
+	vmap_node_shrinker->count_objects = vmap_node_shrink_count;
+	vmap_node_shrinker->scan_objects = vmap_node_shrink_scan;
+	shrinker_register(vmap_node_shrinker);
 }
-- 
2.39.2


