Return-Path: <linux-kernel+bounces-161358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7718B4B19
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F7B1C20B19
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A458220;
	Sun, 28 Apr 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHZpaHQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FB5787B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298587; cv=none; b=sEVfQXyZuZWIj9BvLPivS2L2MO+zJIkwzY82u5dzzQgogQMa5Nrbv1sBfpco3WlEpgZOTi/8qYq2/Yx0DhkqXGJ3w6UJ7yI5WEZ5jmyVNLkXA9UPVct4wlVeZ4vUjkD5u/z7xXWBOT9ys0cXI1IwOLV4cPnMBM9EInn5/tqis74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298587; c=relaxed/simple;
	bh=6NaeJS6g/wwJcO+tv0UtdUMqIwpCmkMz82u9EWAXHVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/VEGy6z5pc9cFy8e8upNUwtVDEpHR1jG8FhIkyHhreqDGXhbXLDQvhxNFTlC7jOqzAlzycjAASbiu94YRYvYAmZPz/dzqu6yzNkaqyDsnYfjeeViehk1x5PhnUB1v5Lxm1NTGVyu+o5BCh+ULuBR55lkyIAxh0gsMofKIUkOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHZpaHQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853CFC113CC;
	Sun, 28 Apr 2024 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714298586;
	bh=6NaeJS6g/wwJcO+tv0UtdUMqIwpCmkMz82u9EWAXHVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHZpaHQw0NiprNOe28G7se+SVJiyPdlJhU8CWRJ2a4QNmIC/hl3c+5CHxEpr5DPsy
	 IZj2AB4522Pf8x6xc4qTo49zUnsbWUAFKEp/EuP5FLntwsfwt2cNsfuNKHOAW3Bfdy
	 C10rwXQTGeCtu/Y5WTkoo5e5iHLgnmGk5ccK/az25EZQK0Y6lc2eXXOGQivBvfe4Ph
	 fVIP8CvUqtTo/RPZV07iQw08sF+mr471F1fuwmFRwfRGTlojYDAs9KVkK+c7VKc6yX
	 CayzVw1bnbhu9cS0jjTBVL3xT16C1Pm5HrB/yBiGAbL5wXlz9NW5saTbpoTVhGHX9Y
	 doazHpmYqihTQ==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	izik.eidus@ravellosystems.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 3/4] mm/ksm: rename mm_slot_cache to ksm_slot_cache
Date: Sun, 28 Apr 2024 18:06:17 +0800
Message-ID: <20240428100619.3332036-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240428100619.3332036-1-alexs@kernel.org>
References: <20240428100619.3332036-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

To distinguish ksm_mm_slot and mm_slot for better code readability,
rename mm_slot_cache as ksm_slot_cache. No function change.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6efa33c48381..22d2132f83a4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -247,7 +247,7 @@ static struct ksm_scan ksm_scan = {
 
 static struct kmem_cache *rmap_item_cache;
 static struct kmem_cache *stable_node_cache;
-static struct kmem_cache *mm_slot_cache;
+static struct kmem_cache *ksm_slot_cache;
 
 /* Default number of pages to scan per batch */
 #define DEFAULT_PAGES_TO_SCAN 100
@@ -502,8 +502,8 @@ static int __init ksm_slab_init(void)
 	if (!stable_node_cache)
 		goto out_free1;
 
-	mm_slot_cache = KSM_KMEM_CACHE(ksm_mm_slot, 0);
-	if (!mm_slot_cache)
+	ksm_slot_cache = KSM_KMEM_CACHE(ksm_mm_slot, 0);
+	if (!ksm_slot_cache)
 		goto out_free2;
 
 	return 0;
@@ -518,10 +518,10 @@ static int __init ksm_slab_init(void)
 
 static void __init ksm_slab_free(void)
 {
-	kmem_cache_destroy(mm_slot_cache);
+	kmem_cache_destroy(ksm_slot_cache);
 	kmem_cache_destroy(stable_node_cache);
 	kmem_cache_destroy(rmap_item_cache);
-	mm_slot_cache = NULL;
+	ksm_slot_cache = NULL;
 }
 
 static __always_inline bool is_stable_node_chain(struct ksm_stable_node *chain)
@@ -1244,7 +1244,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			list_del(&ksm_slot->slot.mm_node);
 			spin_unlock(&ksm_mmlist_lock);
 
-			mm_slot_free(mm_slot_cache, ksm_slot);
+			mm_slot_free(ksm_slot_cache, ksm_slot);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 			mmdrop(mm);
@@ -2713,7 +2713,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		list_del(&ksm_slot->slot.mm_node);
 		spin_unlock(&ksm_mmlist_lock);
 
-		mm_slot_free(mm_slot_cache, ksm_slot);
+		mm_slot_free(ksm_slot_cache, ksm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
@@ -2972,7 +2972,7 @@ int __ksm_enter(struct mm_struct *mm)
 	struct mm_slot *slot;
 	int needs_wakeup;
 
-	ksm_slot = mm_slot_alloc(mm_slot_cache);
+	ksm_slot = mm_slot_alloc(ksm_slot_cache);
 	if (!ksm_slot)
 		return -ENOMEM;
 
@@ -3040,7 +3040,7 @@ void __ksm_exit(struct mm_struct *mm)
 	spin_unlock(&ksm_mmlist_lock);
 
 	if (easy_to_free) {
-		mm_slot_free(mm_slot_cache, ksm_slot);
+		mm_slot_free(ksm_slot_cache, ksm_slot);
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		mmdrop(mm);
-- 
2.43.0


