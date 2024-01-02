Return-Path: <linux-kernel+bounces-14732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797D82214C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC6F1F2155C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005E015AE6;
	Tue,  2 Jan 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBGQgmxw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34B15AC7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso6706737e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221198; x=1704825998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5/Q6NIxJkZyoBWCsC5LnGeneeGSY9jSGkshkmqw6aM=;
        b=dBGQgmxwEZSTXF+hM2Sez2L2cbcv5mW7jmCqeVZHEnI8UzZCnXHETFkQVXhPjUH9fz
         eoc7JnduGEeEdbkQ8OmfWMHxg09si4QuM0YngLhs5wHuNayriqOvyCkvlpJmGSzAFymo
         W1YA0pYN9SLehNYFX4SGlSIsfbdy4kyZrNsRTItdHbNkO+Vt6Q4kps1VZQxIynoQAmuL
         wT2qKBrIBeKtxVk4RxldtnfPoP5bAKpA9LTlcRDPxDmGajz+azs/GpAgB1FAtusZ4SB/
         M9p/2SnhALuqAB9MPbLaQ/4wvXN6puC1nNXGx+P1hq+1OQdvfY750PcEBDdqwv9DkBxt
         k2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221198; x=1704825998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5/Q6NIxJkZyoBWCsC5LnGeneeGSY9jSGkshkmqw6aM=;
        b=MgR81d6vZ6d9uYF2NEr6wmLR1+DSwViR0YPlsPSBXaWEtXfjkscU37/hSgR460uvAq
         NZ3cECJfdIaVvy8UoBMiO2tZfYd6ekEVrfX+G+njaqkF8xaLRGT9JyIujJzlOHyJOos7
         uezpEKtaKYpPyRPLw36ygQGvGT/PIfjq0qHVkQ5pICIINIPHv0r6XoJCK2YLNJoxinnu
         OpkHPnhh4f01tYwO9MvJO3y0xmWqAfTfrIQJKldvnE6H1zGk0a4vW9QT7FSCAIBXxjMk
         JZNohHC2wsP5Wp/4eZuAViVIdlPTw0iD+cx8fU2JFvm+eOt9uYJyOjh6RQjirPOxELKl
         KNgw==
X-Gm-Message-State: AOJu0YxQ3iSTfm4PJ+qJotsOuwFYMH2Y11VAocCje1nrrAUxsBWUQx64
	LxL8LCAIEKfgZ8QsmVF9yhs=
X-Google-Smtp-Source: AGHT+IE9SbS94bEP8HryLcFLJIOhLEWknY4qeLso9+WpHYNNJ55PDxr0/9mn78utpteQ9g4ePL4CRw==
X-Received: by 2002:a05:6512:1055:b0:50e:7e93:4d34 with SMTP id c21-20020a056512105500b0050e7e934d34mr5999337lfb.128.1704221197571;
        Tue, 02 Jan 2024 10:46:37 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:37 -0800 (PST)
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
Subject: [PATCH v3 01/11] mm: vmalloc: Add va_alloc() helper
Date: Tue,  2 Jan 2024 19:46:23 +0100
Message-Id: <20240102184633.748113-2-urezki@gmail.com>
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

Currently __alloc_vmap_area() function contains an open codded
logic that finds and adjusts a VA based on allocation request.

Introduce a va_alloc() helper that adjusts found VA only. There
is no a functional change as a result of this patch.

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..739401a9eafc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1481,6 +1481,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
 	return 0;
 }
 
+static unsigned long
+va_alloc(struct vmap_area *va,
+		struct rb_root *root, struct list_head *head,
+		unsigned long size, unsigned long align,
+		unsigned long vstart, unsigned long vend)
+{
+	unsigned long nva_start_addr;
+	int ret;
+
+	if (va->va_start > vstart)
+		nva_start_addr = ALIGN(va->va_start, align);
+	else
+		nva_start_addr = ALIGN(vstart, align);
+
+	/* Check the "vend" restriction. */
+	if (nva_start_addr + size > vend)
+		return vend;
+
+	/* Update the free vmap_area. */
+	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
+	if (WARN_ON_ONCE(ret))
+		return vend;
+
+	return nva_start_addr;
+}
+
 /*
  * Returns a start address of the newly allocated area, if success.
  * Otherwise a vend is returned that indicates failure.
@@ -1493,7 +1519,6 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 	bool adjust_search_size = true;
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
-	int ret;
 
 	/*
 	 * Do not adjust when:
@@ -1511,18 +1536,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 	if (unlikely(!va))
 		return vend;
 
-	if (va->va_start > vstart)
-		nva_start_addr = ALIGN(va->va_start, align);
-	else
-		nva_start_addr = ALIGN(vstart, align);
-
-	/* Check the "vend" restriction. */
-	if (nva_start_addr + size > vend)
-		return vend;
-
-	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
-	if (WARN_ON_ONCE(ret))
+	nva_start_addr = va_alloc(va, root, head, size, align, vstart, vend);
+	if (nva_start_addr == vend)
 		return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
-- 
2.39.2


