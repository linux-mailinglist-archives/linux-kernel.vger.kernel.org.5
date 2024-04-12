Return-Path: <linux-kernel+bounces-142161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C548A2858
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0069A1C23AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF194F213;
	Fri, 12 Apr 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB31oEB+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9E4D5BF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907491; cv=none; b=l2Mg5wzgibTdOfEwRmPPizlMwLQRJCBGGv2KK2sgkBzSLJB5o/Eeun6ldSynedZxfHhbjeUaZlyk2tAx8tXCHxo/6d79qk6TaBGkiXVatAqH+iPkcW1Fl/oBtpDPl9MJe3J1wt4GxJFAz7UUWvlsxsrZTWrvotLOnrG0RYjBn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907491; c=relaxed/simple;
	bh=4Hwop6FJ5nVwlMbGbX82ySoe31PuiWS/yVoZEPPvmDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXvykVSBxxZ98SMPw/iS37/+e++L5MaSGFGrjj/hS1d8bF7KzinpcznA6AkJ6BCTSP5B0q2QNAEBY1CfdQudXGYbrt/c1bBVb01hD1aeV1bmjdtUETQue5Jdn2Yu6uOd1hfw4kiSlsbkYyXFfKwyNmEwQ0B+Obvq0GQiwXOdsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB31oEB+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e40042c13eso4839875ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907490; x=1713512290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsOHXEK8Nh5pewumsjjrvdM3HKJLRrjO6yqH5K5tp/s=;
        b=fB31oEB+PAW0Vf0FvIAUqwWC9cw+L+fcQV7mb1y4xYizPKP1zRA+vWS31nYSf/JvXb
         u1opi38uyGk0L9nhtvnLY2u9dB0jX9T9VDeYqhNklBOT8UqSoUwCoamYnzPRtV2R/UeS
         X+Qj3XblBQVDr/IkKfQPilxPCblDQ0MeZCdB10zbGt6Y+mAOW0lqkW79Z/X9GfILZUe7
         XiYVyS7B3BEi4WwRmKtEpQJlC/ExnMowDiK3cwKNTfm3XJ20zBuPHSON+VLMrgcN7P5H
         xpb4HQ3KNNEZ0Tg+sYwTnPphD6bgEAZPlTWbT0S8KSyHYN9NDbEOM13mEIaxsPU14vfs
         gw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907490; x=1713512290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsOHXEK8Nh5pewumsjjrvdM3HKJLRrjO6yqH5K5tp/s=;
        b=dNnwD4+2W6hfzcY+UzSQ7iicZBzkpj+UrmhzoyVcLgu2foQGPYwSEMxTPJ84PPOaZX
         cLGTch6gbnLvbwAVO6oNHMDUtesIow5bbZzDEKiN+FV9EDTrrCF4KtSSH97v8jXF0cwE
         LoPu7NmpYZJu4DJuzxQ1suJdrlPB+bB9rVCUji8RigcYRH88bNxdwba32jpac6Nt3tPi
         2OAjnrWmDOH7bVlkbe2ud5AS7EfDknu8njS/swGQkXAtnjhpKOK00EDBVG4ssLBU3tRB
         p1KxEFSvZ+f003Z/9A1KD2EPGDcrXMt0VWWNsTL2fPUbTt/6hGXMZO5FaU6Ee7CICgy1
         rEiA==
X-Forwarded-Encrypted: i=1; AJvYcCWJOeMZ3J6NOZ9/aVoQDWe/SFPWk8n8G1j/MBE4ynJsH0si6EyWW1GRsyjpyLvpaLaPBQHYyoushO3e77uiPnP9MMK9ZmnFwHnBDZIK
X-Gm-Message-State: AOJu0YwB1mVoyLA19SRNVjZWjzWlEvfamcP16Z+9932BFlwL/jM3sJ7k
	80g9rVAA8Sb77YnD4hBXds0TZyWKkBe6ww5iS//JQRnkH9B9+Tb4
X-Google-Smtp-Source: AGHT+IHWZYew+Q9NtnWF+a6SE88ptdUjsAwDnwkkWmi3sA6yX2D3E8zqruIKdheWkebuC2R11yEKEg==
X-Received: by 2002:a17:902:9341:b0:1e2:952b:81fc with SMTP id g1-20020a170902934100b001e2952b81fcmr1436795plp.29.1712907489843;
        Fri, 12 Apr 2024 00:38:09 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001e478f359bdsm2344011plh.127.2024.04.12.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:38:09 -0700 (PDT)
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
Subject: [PATCH v5 2/4] mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters
Date: Fri, 12 Apr 2024 19:37:38 +1200
Message-Id: <20240412073740.294272-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073740.294272-1-21cnbao@gmail.com>
References: <20240412073740.294272-1-21cnbao@gmail.com>
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
index c5beb54b97cb..b69c3b3e1436 100644
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
index 21c4ac74b484..13e74724d0c3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -557,11 +557,15 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
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


