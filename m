Return-Path: <linux-kernel+bounces-142609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826C8A2DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44D61F23D44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44555E4A;
	Fri, 12 Apr 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyhRuWbx"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D654FBE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922565; cv=none; b=ryxWyZqPjw6PUoy4BPt9auuM/xcBmg9x1fGKEuktrAWehRjcwkXR6eEB2GCkytN31p14pRRCiB2Am5PfT4xGth33zX4rPAejoSOgeYlmVKnEpafmxjNk8Xwbj8Nh01KfsCKu7GMEmbzNbVCfYGxzKqhNFOEbVMXVA8b/9mlDgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922565; c=relaxed/simple;
	bh=S6XPYVNWwHAZsyPPLbqtfAowLOKQYeJfl0zecQgrprE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvvIbjxEXvH/W2M6B7gI/Y9tBThmv/SpNCgccR7JI27kdojWFKpMgB7ngjRqhuwMvSRRdYs/R86TclrOUOJmVqNdT1Laq3HD2DaxoTwRC+kCSqopEDZtcdxshVrsE8Btb7ZSeOCXh3GhVEzbuougTE+ELma6jcx1DvU6OSL1CFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyhRuWbx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ee12766586so553303b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712922563; x=1713527363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsGNE4XVP3pLkOAKr41E6LqkIK87UvM+YC6wxpcMFv8=;
        b=hyhRuWbxHsUXDlOA1ozuuqJILYLSXaotKAR+MNCTamLBwr6AMNg6xoDuW+C3A322EN
         2N47NNwUNNca/r7uU/Yjt88IukpyDMi0YT60VqpgdwlB9/K+lbLeZRk+smGFRgFMIHyx
         LGb8FCUnpy4b1are5GMJzb5PS9oX0vFVDY1PODpxUJisZsw8zHmo+WUlGRxpBw+r0AlC
         uuJiuAXil9K1tcC6nzjRKEd5m7bkDgjfUA76YhxHTor86ieb4ZnikuPrGsax2YNi/oJ/
         8CeYeTz9g8rwAZl182JP2uRaUP5gsoJy8dAAryc6uSrxquXjueBE24Op515K0w4+RWDc
         +iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922563; x=1713527363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsGNE4XVP3pLkOAKr41E6LqkIK87UvM+YC6wxpcMFv8=;
        b=Ov9ATtS3RnacgNJm9eRDnkr0bSbaJrIUi4Hd6XCuzFLYeIJ7VaccmpLPq6GSlorfGs
         nEQ5X78YcXpH5Djjaw8NRbU0l1B6dK84eFLpixUgvdtrVZOt/Q1FbCiGfqBBz0K3vB7e
         y7J3h9zGRuVoZyDoeUEbllq1p9kMjgbziFTo19rU+Rl3IAXDp4Acou5JCTtGUqHssfQP
         9H5O6tfjjbvjvc00NN9uky09lDe90hO8TfVSngvTiSE2qzFz7TppvJNC605s+CLYkHy0
         pqD0zGSoH6+A74h+KMEMCACRwXwm7g8w5aCD5l9uV8BYAt1Hr7Orq8OKwz4H1KkWRDvG
         oEvw==
X-Forwarded-Encrypted: i=1; AJvYcCUPvTV3u/Q7uvFWIXf1LGgiO8xpZYVZ3Dt+4d0uGYcZ4+wPnL508FSW2ums1FIFVmc77tzwsM7qZ9g0Z3CS9Vhea0eDNfG+/jNQMDnF
X-Gm-Message-State: AOJu0Yy21LGYaCLp64PQTyZZWUHNvJXwIxNLFx8hs9bb4v8+9B2bHYAe
	eYsLYq8KyuKlc2BAI+9fgPI9/kDhH11fkXeP8N7LgP/YhxtdE2lnTw0tlW7W
X-Google-Smtp-Source: AGHT+IGT5HsRUdIKeuS97P1LcQaXZ4m6uHGIP6/+AXNUFnrOjD3L9oLUEEO5s/R9jaTkOrY3eJcOCw==
X-Received: by 2002:a05:6a00:10c7:b0:6ed:825b:30c0 with SMTP id d7-20020a056a0010c700b006ed825b30c0mr7228196pfu.15.1712922563594;
        Fri, 12 Apr 2024 04:49:23 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id q1-20020a634301000000b005e43cce33f8sm2541048pga.88.2024.04.12.04.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:49:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	corbet@lwn.net
Subject: [PATCH v6 2/4] mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters
Date: Fri, 12 Apr 2024 23:48:56 +1200
Message-Id: <20240412114858.407208-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412114858.407208-1-21cnbao@gmail.com>
References: <20240412114858.407208-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This helps to display the fragmentation situation of the swapfile, knowing
the proportion of how much we haven't split large folios.  So far, we only
support non-split swapout for anon memory, with the possibility of
expanding to shmem in the future.  So, we add the "anon" prefix to the
counter names.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 include/linux/huge_mm.h | 2 ++
 mm/huge_memory.c        | 4 ++++
 mm/page_io.c            | 1 +
 mm/vmscan.c             | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index d4fdb2641070..7cd07b83a3d0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -268,6 +268,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ANON_SWPOUT,
+	MTHP_STAT_ANON_SWPOUT_FALLBACK,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dfc38cc83a04..58f2c4745d80 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,11 +555,15 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
+DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
+	&anon_swpout_attr.attr,
+	&anon_swpout_fallback_attr.attr,
 	NULL,
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index a9a7c236aecc..46c603dddf04 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -217,6 +217,7 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
+	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bca2d9981c95..49bd94423961 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1231,6 +1231,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 						goto activate_locked;
 				}
 				if (!add_to_swap(folio)) {
+					int __maybe_unused order = folio_order(folio);
+
 					if (!folio_test_large(folio))
 						goto activate_locked_split;
 					/* Fallback to swap normal pages */
@@ -1242,6 +1244,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 							THP_SWPOUT_FALLBACK, 1);
 						count_vm_event(THP_SWPOUT_FALLBACK);
 					}
+					count_mthp_stat(order, MTHP_STAT_ANON_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
 						goto activate_locked_split;
-- 
2.34.1


