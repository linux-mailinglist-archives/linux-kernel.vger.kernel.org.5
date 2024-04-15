Return-Path: <linux-kernel+bounces-145343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBC8A532C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732AAB22420
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E234176036;
	Mon, 15 Apr 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2BpsHAg"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C471B51;
	Mon, 15 Apr 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191100; cv=none; b=pRsENGBzMjDtGHZv755mfAkU/I1SczZYRyhYgI2PEG6dDiUVgldyU3ZEu/CYHdNSi1JEZOaHL9IrmwXpzuoliH3sWCTT35gZynGRnVXYI/mSi9NN3dMp9t01yvD1ARZFUYKaZn6smO1dX9UH4wRkG+vBK0nfATxQuMWU7mp+fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191100; c=relaxed/simple;
	bh=bVa86gqv3PARO3f+Z3E8jfDXIaHMHfg6rFINKeTnzN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9sQsabhwDeKtq+uImOrgJHtvI3NawvUWzxv5qu1JjVpubQlZf8TWGMBnwCbxZxSooG9iXx5unI1UFyfbQ5WFPY7D1h7SiGWaXdSQ5/eUV+HIgwIHIIDST9+1AYx3oM0PF6SeEYgqEIfFodrpNS+SsjNGByJozjph6TKNBsYBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2BpsHAg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed054f282aso2224832b3a.0;
        Mon, 15 Apr 2024 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191098; x=1713795898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwI3ikGV8bbQKlQb5tgKDZE5mmiKSYxR+j/zmva83hc=;
        b=B2BpsHAg+o+7VsHav62O1AyBwVNc0ua9vXf4pduBJ6EdNYpKzyvVjrg94E/GL0zirh
         QBBsI9mmVGIr20E500k5SEEnsgbNeFMBxsHRVqgxkgO1MOT91gcps/+30FqHPnmUe99y
         U8BbATTDYb00qha9PsiTQPIEjGCDdkI4jrDon1Wi6wDXXE30Q91nNasWZJSPuJqWZ3WF
         wwPzGdM2i1psQLRhX9KCI9iwiftgmlwb06kMZniC9B44KY2pZgFwZjSbSCvJKATVkMyR
         EgVp38loW62WvohxOHlZ3HSxU2m3IKtcGtxOuzKc78g9vT5jcWdKyJWnD5ufwjDGw6IM
         UNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191098; x=1713795898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwI3ikGV8bbQKlQb5tgKDZE5mmiKSYxR+j/zmva83hc=;
        b=vhx28bwugW6GeblW1z+KHmme/RUfk7ln4BWMm3Ot1XPj36bt0RhefrhJUInwGy6HSZ
         AZFpaAn+gZqaWeYtvi4sAemfEDE+2+Mcb1NHZxsv3DC1BADmvE2ezgq0wqKAu9zN7tvg
         HpwhZwLR6iI4DS1zOO/qBsisvOwhK8O8GIk97PGAQlhueBYnIuddl7orc38aT10HF38A
         Ik+mqtGcxCg8tPXmwceEKwndS/d7WADuA5i6Grq9F9JFELCDil7XXk2VJF5LnRUtkbOy
         iFzjhCs0Ch4LVWAhlxz9oWLUd8LQ0DrY7o26H18lZanXn/7X/DLn6OxjCdyA+bAYwR/j
         fcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoX/M6h5aapqOWIWQI3OKtWIXzl0MkCOniSTyVwYu/2ee6ebFucbYHjmfTCVfO32igcW0amaq4f+lD+MxATMNQhMeOUd7wWTtp7ssA
X-Gm-Message-State: AOJu0YxKoN0K8R6mf1VM4lJxSnZaUR7mUtGOXI1uvhOG1UxP5WSY2wmk
	cprF+jW6Bcp1DF6r5cc8sV+9w5PEehnzdSpijB4AwUEErPmiFdAawALusw==
X-Google-Smtp-Source: AGHT+IFsQN+LB3mh/jEm1d2fe5hkLQN7T98rFJzdJ4KZHRIWX8LGoqxdqu605fUCbmTPQ9gXCq2dDw==
X-Received: by 2002:a05:6a20:6a20:b0:1a9:22b9:754a with SMTP id p32-20020a056a206a2000b001a922b9754amr10200952pzk.7.1713191095575;
        Mon, 15 Apr 2024 07:24:55 -0700 (PDT)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id x13-20020aa784cd000000b006ea81423c65sm482906pfn.148.2024.04.15.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:24:55 -0700 (PDT)
From: skseofh@gmail.com
To: robh@kernel.org,
	saravanak@google.com,
	rppt@kernel.org,
	akpm@linux-foundation.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: [PATCH] memblock: add no-map alloc functions
Date: Mon, 15 Apr 2024 23:24:48 +0900
Message-Id: <20240415142448.333271-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <daero_le.lee@samsung.com>

Like reserved-memory with the no-map property, there are memory regions
need to be allocated in memblock.memory marked with the
MEMBLOCK_NOMAP flag, but sholud not be allocated in memblock.reserved.

So, functions were added that find the required memory area in
memblock.memory, but do not allocate it to memblock.reserved.

The early_init_dt_alloc_reserved_memory_arch function was modified
using the no-map alloc function.

Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
---
 drivers/of/of_reserved_mem.c |  9 +++--
 mm/memblock.c                | 78 ++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..504f2f60689c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -40,15 +40,18 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = memblock_phys_alloc_range(size, align, start, end);
+	if (nomap) {
+		base = memblock_phys_alloc_range_nomap(size, align, start, end);
+	} else {
+		base = memblock_phys_alloc_range(size, align, start, end);
+	}
+	
 	if (!base)
 		return -ENOMEM;
 
 	*res_base = base;
 	if (nomap) {
 		err = memblock_mark_nomap(base, size);
-		if (err)
-			memblock_phys_free(base, size);
 	}
 
 	kmemleak_ignore_phys(base);
diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..f103f1ecbfad 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1506,6 +1506,72 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	return found;
 }
 
+phys_addr_t __init memblock_alloc_range_nid_nomap(phys_addr_t size,
+                                        phys_addr_t align, phys_addr_t start,
+                                        phys_addr_t end, int nid,
+                                        bool exact_nid)
+{
+        enum memblock_flags flags = choose_memblock_flags();
+        phys_addr_t found;
+
+        if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
+                nid = NUMA_NO_NODE;
+
+        if (!align) {
+                /* Can't use WARNs this early in boot on powerpc */
+                dump_stack();
+                align = SMP_CACHE_BYTES;
+        }
+
+again:
+        found = memblock_find_in_range_node(size, align, start, end, nid,
+                                            flags);
+        if (found)
+                goto done;
+
+        if (nid != NUMA_NO_NODE && !exact_nid) {
+                found = memblock_find_in_range_node(size, align, start,
+                                                    end, NUMA_NO_NODE,
+                                                    flags);
+                if (found)
+                        goto done;
+        }
+
+        if (flags & MEMBLOCK_MIRROR) {
+                flags &= ~MEMBLOCK_MIRROR;
+                pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
+                        &size);
+                goto again;
+        }
+
+        return 0;
+
+done:
+        /*
+         * Skip kmemleak for those places like kasan_init() and
+         * early_pgtable_alloc() due to high volume.
+         */
+        if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
+                /*
+                 * Memblock allocated blocks are never reported as
+                 * leaks. This is because many of these blocks are
+                 * only referred via the physical address which is
+                 * not looked up by kmemleak.
+                 */
+                kmemleak_alloc_phys(found, size, 0);
+
+        /*
+         * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
+         * require memory to be accepted before it can be used by the
+         * guest.
+         *
+         * Accept the memory of the allocated buffer.
+         */
+        accept_memory(found, found + size);
+
+        return found;
+}
+
 /**
  * memblock_phys_alloc_range - allocate a memory block inside specified range
  * @size: size of memory block to be allocated in bytes
@@ -1530,6 +1596,18 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 					false);
 }
 
+phys_addr_t __init memblock_phys_alloc_range_nomap(phys_addr_t size,
+                                                   phys_addr_t align,
+                                                   phys_addr_t start,
+                                                   phys_addr_t end)
+{
+        memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
+                     __func__, (u64)size, (u64)align, &start, &end,
+                     (void *)_RET_IP_);
+        return memblock_alloc_range_nid_nomap(size, align, start, end, 
+					      NUMA_NO_NODE, false);
+}
+
 /**
  * memblock_phys_alloc_try_nid - allocate a memory block from specified NUMA node
  * @size: size of memory block to be allocated in bytes
-- 
2.25.1


