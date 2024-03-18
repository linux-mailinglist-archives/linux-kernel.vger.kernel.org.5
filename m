Return-Path: <linux-kernel+bounces-106828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C5087F439
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F7B2270D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FEE5F86C;
	Mon, 18 Mar 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS7xkBed"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816455F859
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805643; cv=none; b=jTs4/CP5WqVQ8nxJ2nnWZWSc6G8sb29zZ6jeJKQqbg/yD9751Vyz7mAeOzHz3QgME8NYeXsLE0YVKgScz4OfFh8kjumXPbPlyMkzHAxauk7mVwn0Svy1OMFyYxoAobDP5pAWf57XUZVDR9Tlfxo1ZL7b5BDcVEU1yC36gY4J0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805643; c=relaxed/simple;
	bh=z292jqOuplhcWmBQQ3PF0nT7+tjM16vi3F/ibeHaULE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qSdj5uqfIKaAbfcK4L3YocKXgfoHejoh0yy+uCslWIiICNGqSl9j7R5inM8hpTgZ8Qow4l5BxTZK4bF4Iy0VjDanmihR5MMWrCbn+6UdAkPEumuaj+83bZZ7/FhFZTGvRJEqsi5bKWXLIhlEr4z1sanKav9050MDP3qPgTds7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS7xkBed; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e032fc60a0so9167115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710805641; x=1711410441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b46t3m+Om2McMuf3OxsBOpQLJn68hsde+QwzsoCwudA=;
        b=lS7xkBedGGLtcLJ6vZ2uBDaaJpNI6Vkpx1hO5wHbpKyxzg0oIHmP/pWAfRPu11ng3u
         dWc2B3yJD8nLikdCtqR33ZCiMzHYpxdAfnfzgfIxfWS0U2Ji5Q+7w1thqk+C+koMKUgB
         TjaibJIM9lE4Bni5o9hGFlJTIqCJwM6eIct4KqGEPk57Us3NocN//DM5uCQcqMqzMWyU
         tBqCKt9TDLpON2DzLdeHlvi7Ak74OssCKbw2GpvcqrcjLQmdZ2yxR+Te4DdBqE3ampGL
         V0nury6EXkqqzPtttTK4yUhgEKM8SzYSukmhLis76kDw7r9+BBc++6FZ9WqOgr2TiAEw
         EFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805641; x=1711410441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b46t3m+Om2McMuf3OxsBOpQLJn68hsde+QwzsoCwudA=;
        b=tMKBqbSqAH5KEjWtp2LKdtX46vsSto63vdxebGFka9zUR0Bgrg1BnM9J1Sv94i9ghT
         vF4pXZlIwE9YWFwYxBMbGtoqP3ZOBJMmC9vdsG4KZtRR/tKoSczK72LRsNmSYIZ11NzT
         PvZpM9CYz7AL+jujj5ppsX+SSaZN4ZmChBhYjsdakI59TyPqXydjh4twavMGJgKG+Mio
         3HdlRi15Bij6ebMc2R1L02yycb7JVpJxfTMEbuw5RBB+NHeM6BhBt0RbC6IdCmYGn4zP
         wIMDHXG3333RRXViGDNYgwOZ/9qPiVC8OMRE/Up0AynpAoKvYv39q4R17OCRZbq1A9Y1
         hdyA==
X-Gm-Message-State: AOJu0YzhWmbhOt+llhnQkfoSk0JGnAiGxDILxZQ1vCrYZ9OOM98fSDgz
	JlxrP75oXZ7czmkBeHfjTH8+mScv7nIvWOiE0lIQRaX3vZ2QqDFe
X-Google-Smtp-Source: AGHT+IGDQIxgBrXQaIe3vsXRe70mIiCJf2egWj462e/G5Z0VOlH3OtdnBE+5Ze+cvrQvqIiorZdqAA==
X-Received: by 2002:a17:903:2291:b0:1dd:69bb:7f96 with SMTP id b17-20020a170903229100b001dd69bb7f96mr1456190plh.6.1710805640677;
        Mon, 18 Mar 2024 16:47:20 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id mh5-20020a17090309c500b001dd998927c6sm4961903plb.26.2024.03.18.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:47:20 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	v-songbaohua@oppo.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	ira.weiny@intel.com,
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Subject: [PATCH v2] mm: zswap: fix kernel BUG in sg_init_one
Date: Tue, 19 Mar 2024 12:47:06 +1300
Message-Id: <20240318234706.95347-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

sg_init_one() relies on linearly mapped low memory for the safe
utilization of virt_to_page(). Otherwise, we trigger a kernel
BUG,

kernel BUG at include/linux/scatterlist.h:187!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 2997 Comm: syz-executor198 Not tainted 6.8.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at sg_set_buf include/linux/scatterlist.h:187 [inline]
PC is at sg_init_one+0x9c/0xa8 lib/scatterlist.c:143
LR is at sg_init_table+0x2c/0x40 lib/scatterlist.c:128
Backtrace: 
[<807e16ac>] (sg_init_one) from [<804c1824>] (zswap_decompress+0xbc/0x208 mm/zswap.c:1089)
 r7:83471c80 r6:def6d08c r5:844847d0 r4:ff7e7ef4
[<804c1768>] (zswap_decompress) from [<804c4468>] (zswap_load+0x15c/0x198 mm/zswap.c:1637)
 r9:8446eb80 r8:8446eb80 r7:8446eb84 r6:def6d08c r5:00000001 r4:844847d0
[<804c430c>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498 mm/page_io.c:518)
 r9:844ac800 r8:835e6c00 r7:00000000 r6:df955d4c r5:00000001 r4:def6d08c
[<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahead+0x1c4/0x34c mm/swap_state.c:684)
 r10:00000000 r9:00000007 r8:df955d4b r7:00000000 r6:00000000 r5:00100cca
 r4:00000001
[<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahead+0x68/0x4a8 mm/swap_state.c:904)
 r10:df955eb8 r9:00000000 r8:00100cca r7:84476480 r6:00000001 r5:00000000
 r4:00000001
[<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0xcc4 mm/memory.c:4046)
 r10:00000040 r9:00000000 r8:844ac800 r7:84476480 r6:00000001 r5:00000000
 r4:df955eb8
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memory.c:5301 [inline])
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/memory.c:5439 [inline])
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x12b8 mm/memory.c:5604)
 r10:00000040 r9:842b3900 r8:7eb0d000 r7:84476480 r6:7eb0d000 r5:835e6c00
 r4:00000254
[<8047e2ec>] (handle_mm_fault) from [<80215d28>] (do_page_fault+0x148/0x3a8 arch/arm/mm/fault.c:326)
 r10:00000007 r9:842b3900 r8:7eb0d000 r7:00000207 r6:00000254 r5:7eb0d9b4
 r4:df955fb0
[<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 arch/arm/mm/fault.c:558)
 r10:7eb0da7c r9:00000000 r8:80215be0 r7:df955fb0 r6:7eb0d9b4 r5:00000207
 r4:8261d0e0
[<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/arm/kernel/entry-armv.S:427)
Exception stack(0xdf955fb0 to 0xdf955ff8)
5fa0:                                     00000000 00000000 22d5f800 0008d158
5fc0: 00000000 7eb0d9a4 00000000 00000109 00000000 00000000 7eb0da7c 7eb0da3c
5fe0: 00000000 7eb0d9a0 00000001 00066bd4 00000010 ffffffff
 r8:824a9044 r7:835e6c00 r6:ffffffff r5:00000010 r4:00066bd4
Code: 1a000004 e1822003 e8860094 e89da8f0 (e7f001f2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	1a000004 	bne	0x18
   4:	e1822003 	orr	r2, r2, r3
   8:	e8860094 	stm	r6, {r2, r4, r7}
   c:	e89da8f0 	ldm	sp, {r4, r5, r6, r7, fp, sp, pc}
* 10:	e7f001f2 	udf	#18 <-- trapping instruction

Consequently, we have two choices: either employ kmap_to_page() alongside
sg_set_page(), or resort to copying high memory contents to a temporary
buffer residing in low memory. However, considering the introduction
of the WARN_ON_ONCE in commit ef6e06b2ef870 ("highmem: fix kmap_to_page()
for kmap_local_page() addresses"), which specifically addresses high
memory concerns, it appears that memcpy remains the sole viable
option.

Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google.com/
Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleepable")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
   add comments according to Yosry 

 mm/zswap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9dec853647c8..dbd9f745fa8f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1080,7 +1080,17 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
+	/*
+	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
+	 * to do crypto_acomp_decompress() which might sleep. In such cases, we must
+	 * resort to copying the buffer to a temporary one.
+	 * Meanwhile, zpool_map_handle() might return a non-linearly mapped buffer,
+	 * such as a kmap address of high memory or even ever a vmap address.
+	 * However, sg_init_one is only equipped to handle linearly mapped low memory.
+	 * In such cases, we also must copy the buffer to a temporary and lowmem one.
+	 */
+	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
+	    !virt_addr_valid(src)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1094,7 +1104,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
+	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


