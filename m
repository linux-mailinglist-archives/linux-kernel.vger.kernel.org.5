Return-Path: <linux-kernel+bounces-150255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FE8A9C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39981C22070
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDE1635CC;
	Thu, 18 Apr 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjoTD9wk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B9165FB6;
	Thu, 18 Apr 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449578; cv=none; b=CS+yeg3BRh76HlTfRlwtPJ4TtnYcEtaAlddwvKmltnSexwVrZ0mjqQQhjNkPfHM4HlaRiX6q6YNludC0+5i0qYZZhm4+EjR2/CxYGrlCNsXjN7GDEceByLBuL1PHcMkMuvOtIlIKVD97eiOkEeziioJlhk3BqElwrH1Slr0mYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449578; c=relaxed/simple;
	bh=dDJBIbheszt6UH1AuLlY0BZNKZfHib1iokm8ntPIIQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFwMFteMmbHE6iusexvdBdEazuhThbPij9oRFAR13h8YaCJuj7MOACoiUSe/VJ/nVv7Dut3OBBGkmJipLGnlqG2ruzLZyFJ3IJyvJLRBxM55+OopnVh9YJTxkTR309PtQNqoD1Tj5X/KvlN2UK/+mSgPsG4LoNUmwWF80k7ci2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjoTD9wk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so13804951fa.2;
        Thu, 18 Apr 2024 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713449571; x=1714054371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sf2v7BoXI0tVMGsUD8eOGlIIA/lRJLZkvnPM+Dzrr4=;
        b=cjoTD9wkrshMrp7gcxQvVF1lTonh7M5l35TdBHCLC5cCIfhM4TfUtYEyDIoNnsLOcE
         0lbf6b76nR4MKKyo33cua8b8/rUP2SqnmP5UCxRuJbk36AXAf21seXMByMXgwwhbfhOb
         CBEfDzhC/AaVSng8aHSYmoFPnDc+aQD7Itfmj5scn+/EDMx8QhGeqRJCjWO6Lo5qshKx
         wX7zaUdnRc/IZeNMjiaN92o3XxCqe42Y+mUuQOZq1/28COGuIKCwx8XIXvhj7Kx3+I4K
         xnwqrONNKEu2bOQcIQE7PZfJqVLW2ePqA2uW28cpDMEZyJTjw39DcYxUO2AyrE/fF85B
         vqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449571; x=1714054371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sf2v7BoXI0tVMGsUD8eOGlIIA/lRJLZkvnPM+Dzrr4=;
        b=VrcKBp/yNN7rUcUjjW7BsiykrhLIpbdnDATdt5WZQtcT2nja97MNfGeXIKwkwvgy0O
         0QTVaINyOMIHvF0s+63zamvtBnMRwR8Hom8AQ/qqWJIvXVk4CTRZJS0FOYFGLyN2XH4D
         f9ebRC3JWjWGRu8uAxhhWuk/Pz5Q7qftyz2G0sfOzMRAfe5zbSeA320qpyC0qjhm70h9
         q53ZuQkDVd6hOcSxz1Igs8DfF/MM6MY9SHR6I1UaZ0uMMddctgZmHJGxR+de2BnUpV66
         F9fAe5ir4Uzx7CzO8W3uadyZ1A7nDL2wXHe+rIIQcymVAn4cYpMKAwYZn4sQsaSL/3e+
         /ihw==
X-Forwarded-Encrypted: i=1; AJvYcCUPxlhEy94G6mI4/uJ+pj08aqBonWhiPOEJfN5jqcdkd0mOtFkKDnSmGNeGANJO3wn3r6dvC5tIma9kgBXdfDTW2SEf64KJqgd79w6VkH1Hbq/nzFdAFUpoEbiMdY50inB7xUryNpdk
X-Gm-Message-State: AOJu0YwCPaHkDs7a5TmNBcYJKuUO+9b6ren8rAl0DFvqxGK+L4n2Yce3
	PLfEMJ+EQ5yog6Nkl31yLkQe3sjFP92uU04qpGI5HkCg87S5EAw8
X-Google-Smtp-Source: AGHT+IEPr9pze8LJrFo06YnXXjfIw/OY5qHq9WxYuyqbQM7f9MlR9k1AYRFKV3II8Y15KQZtj6umLQ==
X-Received: by 2002:a2e:b6d0:0:b0:2dc:b467:cb35 with SMTP id m16-20020a2eb6d0000000b002dcb467cb35mr176685ljo.32.1713449570796;
        Thu, 18 Apr 2024 07:12:50 -0700 (PDT)
Received: from dellarbn.yandex.net ([109.245.231.121])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e854f000000b002db706ec5f7sm206637ljj.98.2024.04.18.07.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:12:50 -0700 (PDT)
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
	Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	kasan-dev@googlegroups.com,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: [PATCH] stackdepot: respect __GFP_NOLOCKDEP allocation flag
Date: Thu, 18 Apr 2024 16:11:33 +0200
Message-ID: <20240418141133.22950-1-ryabinin.a.a@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>
References: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If stack_depot_save_flags() allocates memory it always drops
__GFP_NOLOCKDEP flag. So when KASAN tries to track __GFP_NOLOCKDEP
allocation we may end up with lockdep splat like bellow:

======================================================
 WARNING: possible circular locking dependency detected
 6.9.0-rc3+ #49 Not tainted
 ------------------------------------------------------
 kswapd0/149 is trying to acquire lock:
 ffff88811346a920
(&xfs_nondir_ilock_class){++++}-{4:4}, at: xfs_reclaim_inode+0x3ac/0x590
[xfs]

 but task is already holding lock:
 ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0x5d9/0xad0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:
 -> #1 (fs_reclaim){+.+.}-{0:0}:
        __lock_acquire+0x7da/0x1030
        lock_acquire+0x15d/0x400
        fs_reclaim_acquire+0xb5/0x100
 prepare_alloc_pages.constprop.0+0xc5/0x230
        __alloc_pages+0x12a/0x3f0
        alloc_pages_mpol+0x175/0x340
        stack_depot_save_flags+0x4c5/0x510
        kasan_save_stack+0x30/0x40
        kasan_save_track+0x10/0x30
        __kasan_slab_alloc+0x83/0x90
        kmem_cache_alloc+0x15e/0x4a0
        __alloc_object+0x35/0x370
        __create_object+0x22/0x90
 __kmalloc_node_track_caller+0x477/0x5b0
        krealloc+0x5f/0x110
        xfs_iext_insert_raw+0x4b2/0x6e0 [xfs]
        xfs_iext_insert+0x2e/0x130 [xfs]
        xfs_iread_bmbt_block+0x1a9/0x4d0 [xfs]
        xfs_btree_visit_block+0xfb/0x290 [xfs]
        xfs_btree_visit_blocks+0x215/0x2c0 [xfs]
        xfs_iread_extents+0x1a2/0x2e0 [xfs]
 xfs_buffered_write_iomap_begin+0x376/0x10a0 [xfs]
        iomap_iter+0x1d1/0x2d0
 iomap_file_buffered_write+0x120/0x1a0
        xfs_file_buffered_write+0x128/0x4b0 [xfs]
        vfs_write+0x675/0x890
        ksys_write+0xc3/0x160
        do_syscall_64+0x94/0x170
 entry_SYSCALL_64_after_hwframe+0x71/0x79

Always preserve __GFP_NOLOCKDEP to fix this.

Fixes: cd11016e5f52 ("mm, kasan: stackdepot implementation. Enable stackdepot for SLAB")
Reported-by: Xiubo Li <xiubli@redhat.com>
Closes: https://lore.kernel.org/all/a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com/
Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Closes: https://lore.kernel.org/all/f9ff999a-e170-b66b-7caf-293f2b147ac2@opensource.wdc.com/
Suggested-by: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 lib/stackdepot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 68c97387aa54..cd8f23455285 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -627,10 +627,10 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
-		 * contexts and I/O.
+		 * contexts, I/O, nolockdep.
 		 */
 		alloc_flags &= ~GFP_ZONEMASK;
-		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL);
+		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL | __GFP_NOLOCKDEP);
 		alloc_flags |= __GFP_NOWARN;
 		page = alloc_pages(alloc_flags, DEPOT_POOL_ORDER);
 		if (page)
-- 
2.43.2


