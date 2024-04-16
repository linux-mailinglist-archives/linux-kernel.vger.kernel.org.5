Return-Path: <linux-kernel+bounces-146752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281BB8A6A57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46612828EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2A12A177;
	Tue, 16 Apr 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6UDPgQ0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D2127B57;
	Tue, 16 Apr 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269372; cv=none; b=FmsIEAtTEisZ5SeLEH5+EhbPHB5R7GcP36m7jzcfcb73F7HBykuPKRIK1oft24Rp/2pGgg8kSDUpeWE6hq5pZi/s81LHN/E2kFNVFqQgtB/CY9NXJF+dGEiTKiV7xDZV2fcPTxWg5vqFzd97W8fNsJz6V46no3gY4HHW/lgnpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269372; c=relaxed/simple;
	bh=/9DPldZqbWio1+0gvzK6CYEaCP+EGJBXDMgrZtk6GVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LehvW51oEmu9ZmVG+Rsywke9lpzYCyw5s5iJsDa61UQbAbI7SRp8JZxArKo219IV9gXS9dZCmBY+fw7jXgQql+OHEq8FcCAO4FU4PkXSUxcXCg97NKGi6W4azlKDEoTlfxxKjhNZAZFXOnbY0zWd7JqD7lXu65fdyCGgCjAHv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6UDPgQ0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4266673bbso37251925ad.2;
        Tue, 16 Apr 2024 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269368; x=1713874168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdTcvMX0MA6Qf+Koh6U+bB/gDVKh29MBVCeUWNkXxss=;
        b=c6UDPgQ026jXcboKvUSRTNOcx+SnTlvmP9xuJdiGpjdni2TkDrXFeAJty4t597qvmH
         8dAt2HlK6VD9LGafURp9VT6BtKLEehjc2tdgiC/j2RSQVA0JhJtVtsrP1drMkCXeOTAq
         SYm53RWpyGPamXpTDMXsQ5ur3dWWmvR0/76rNhtkqBUm2pxnYHSjolAmaf6ZmbHcXIsj
         Jye0FYwVPwtzKhx1F3Q4UWFBGqpB63UaAizM3nyiOaZ61cgUpQEoaje+GcFp16Nr1c/u
         s03wHFG8Qbzkf4/0f5NHwUaNrYG1csJdwUH/1/h3MzPmVOJHpS2ABxW/zvyR+1WvrS5w
         UhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269368; x=1713874168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdTcvMX0MA6Qf+Koh6U+bB/gDVKh29MBVCeUWNkXxss=;
        b=lRwrSPiU6COtNsQanNE5FU/qdzNLD7xQi/58bbGA8ef0+KZkCDNWAEg1JS++zFw61l
         SFC9O8kSfN2uZF4IxvcZgea3E2H78ZFoRzIA7aZz1vqxmQtpogBnrLEmp3tVxVlLXOI4
         Iruod++x8okBc3folLwlbepTwPtrpc0Gd1r+8tETC8JQtefNE1/Vf71sgZjpd5U9R7MV
         +eIc8MEYgyKjIo4La9AZwd2Cl8wgzzpNEyi1bxzVIAUU6VmMCoeOD83JpFXGHIkCarPt
         vnzTRrjfxwh3uctdyndmpXY+b4aOosNS2wndqA0k8S1WEBpcVVaEUWEp+gtPIVEvAVkC
         47kw==
X-Forwarded-Encrypted: i=1; AJvYcCXGrf7GdD99zfxXMeVBN1tDoOWQroOBp6X7oQRjhUVFmUjgmXejPH1On1wAi5CnlL3Jb0meQZ2XxsapPNMyx3e++voHPzktwMQ6iajx
X-Gm-Message-State: AOJu0YwQnwXnWpvtbk1AWeoQN7UDZTVroAqoghi2ClpQMTgblp3rLcC8
	3kuCUFZchF2lJCPTKqWuT0RekWW+2vlB/MyQfkJg7F15bqbL1aEkBu945Q==
X-Google-Smtp-Source: AGHT+IEJ7F2Z7YWgH14O0xbmG1gNps2XW0QDAHnGf5wcGH4vLEI3r0IS9XAwzBjdZnYLFyHCkWE9lw==
X-Received: by 2002:a17:902:a511:b0:1e2:616e:2883 with SMTP id s17-20020a170902a51100b001e2616e2883mr9996647plq.24.1713269367746;
        Tue, 16 Apr 2024 05:09:27 -0700 (PDT)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001e509d4d6ddsm9813684plk.1.2024.04.16.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:09:27 -0700 (PDT)
From: skseofh@gmail.com
To: robh@kernel.org,
	saravanak@google.com,
	rppt@kernel.org,
	akpm@linux-foundation.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: [PATCH v2] memblock: add no-map alloc functions
Date: Tue, 16 Apr 2024 21:06:35 +0900
Message-Id: <20240416120635.361838-2-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416120635.361838-1-skseofh@gmail.com>
References: <linux-mm@kvack.org>
 <20240416120635.361838-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <daero_le.lee@samsung.com>

Like reserved-memory with the 'no-map' property and only 'size' property
(w/o 'reg' property), there are memory regions need to be allocated in
memblock.memory marked with the MEMBLOCK_NOMAP flag, but should not be
allocated in memblock.reserved.

example : arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                bman_fbpr: bman-fbpr {
                        compatible = "shared-dma-pool";
                        size = <0 0x1000000>;
                        alignment = <0 0x1000000>;
                        no-map;
                };

                qman_fqd: qman-fqd {
                        compatible = "shared-dma-pool";
                        size = <0 0x400000>;
                        alignment = <0 0x400000>;
                        no-map;
                };

                qman_pfdr: qman-pfdr {
                        compatible = "shared-dma-pool";
                        size = <0 0x2000000>;
                        alignment = <0 0x2000000>;
                        no-map;
                };
        };

So, functions were added that find the required memory area in
memblock.memory, but do not allocate it to memblock.reserved.

In previous patch(a7259df), early_init_dt_alloc_reserved_memory was
modified to use memblock_phys_alloc_range allocating memory in
memblock.reserved, instead of memblock_find_in_range that just find the
available region. But if there is a 'no-map' property, memory region
should not be allocated to memblock.reserved.

So, the early_init_dt_alloc_reserved_memory_arch function was modified
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


