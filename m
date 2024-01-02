Return-Path: <linux-kernel+bounces-14737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E051822151
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B1A28454E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5AB168CC;
	Tue,  2 Jan 2024 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVYvPRCJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6E15EBF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7c76897dso6612588e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221202; x=1704826002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/i8ZfJzhOkgwpvB6heisf6dptNqD+Kyc9OPs5waPNM=;
        b=gVYvPRCJDEf9ckww0mLZ4FpWF4/pTHnlf7W2ZVYuAEafpgYZ9v1vKFMDdLBACv2bmr
         hzchWlQLU61auRhlCofw6eAE/KhZnSvngHLhVsqEeFw7N207/U8TaJ7COI2mgEeO0Awv
         UlzvG2nVIyui8eJuQVLqRb1kSs785XktKbLWGihz3SiCZUjzHnFtbLtglR4EWqFQa3ji
         wn8J/HNFuaRhvXrlrZSHssYIaZUMLoBTmSaJymK9CT8MNypEi5tLN5idqGCtPHYLntkH
         jT+w8h8wTwo2Y3LrN0vnzKYVHIw4fE+iLQdTHi2HFFHWSeZCseb+OxFn8FbxL2i5js6M
         9Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221202; x=1704826002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/i8ZfJzhOkgwpvB6heisf6dptNqD+Kyc9OPs5waPNM=;
        b=I0CnXPi8D8uK87pd2jz9q9y7vVVMGElknyZBgy5QwbDsqh33IGybidQkGevb9KQiJu
         3univqlhwnOm6sprREgqFAdlyxzAw+WsBKpDtLw840i6CewmqPbGIPk4UdYIg5S5PZgR
         uLTiaNc01s6yH3PKiqQuwLdRRnona4xbAsy+BdNK/CCtJagNLrmQz7By8l1ayQGKYJ5V
         9EhwtW6sCDtCBjotAlET4UK4Ed3JtcaE/FWKg4lHwloqLqf44TbggvpoDWlAU1Uo9euj
         EUg/HCTR1sQo/lPrei3jvT2Pll54/BSzPpSaaTCNk2JxDLTSJtgNa8XRlzInaqJH/LY/
         NQ5w==
X-Gm-Message-State: AOJu0Yxd4JS0jJ37pXvVDltG7SPsbR7Wlwz8E8MI8kG7Ceqjb3ksqP2P
	PEmv2oZf1ppCpjYgjIyEgY4=
X-Google-Smtp-Source: AGHT+IEsu7Urp6TRXfcpo6ncKQnZwNhBJ5A87G0DxmsMgN27G74Ggz2BQ1tsbpUPmeUAXXarv+DFCQ==
X-Received: by 2002:a05:6512:5d5:b0:50e:7b70:b9cb with SMTP id o21-20020a05651205d500b0050e7b70b9cbmr2003145lfo.218.1704221201423;
        Tue, 02 Jan 2024 10:46:41 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:41 -0800 (PST)
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
Subject: [PATCH v3 05/11] mm/vmalloc: remove vmap_area_list
Date: Tue,  2 Jan 2024 19:46:27 +0100
Message-Id: <20240102184633.748113-6-urezki@gmail.com>
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

From: Baoquan He <bhe@redhat.com>

Earlier, vmap_area_list is exported to vmcoreinfo so that makedumpfile
get the base address of vmalloc area. Now, vmap_area_list is empty, so
export VMALLOC_START to vmcoreinfo instead, and remove vmap_area_list.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 8 ++++----
 arch/arm64/kernel/crash_core.c                 | 1 -
 arch/riscv/kernel/crash_core.c                 | 1 -
 include/linux/vmalloc.h                        | 1 -
 kernel/crash_core.c                            | 4 +---
 kernel/kallsyms_selftest.c                     | 1 -
 mm/nommu.c                                     | 2 --
 mm/vmalloc.c                                   | 2 --
 8 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 78e4d2e7ba14..df54fbeaaa16 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -65,11 +65,11 @@ Defines the beginning of the text section. In general, _stext indicates
 the kernel start address. Used to convert a virtual address from the
 direct kernel map to a physical address.
 
-vmap_area_list
---------------
+VMALLOC_START
+-------------
 
-Stores the virtual area list. makedumpfile gets the vmalloc start value
-from this variable and its value is necessary for vmalloc translation.
+Stores the base address of vmalloc area. makedumpfile gets this value
+since is necessary for vmalloc translation.
 
 mem_map
 -------
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 66cde752cd74..2a24199a9b81 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -23,7 +23,6 @@ void arch_crash_save_vmcoreinfo(void)
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
 	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
-	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index 8706736fd4e2..d18d529fd9b9 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -8,7 +8,6 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_NUMBER(phys_ram_base);
 
 	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
-	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
 #ifdef CONFIG_MMU
 	VMCOREINFO_NUMBER(VA_BITS);
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..91810b4e9510 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -253,7 +253,6 @@ extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
 /*
  *	Internals.  Don't use..
  */
-extern struct list_head vmap_area_list;
 extern __init void vm_area_add_early(struct vm_struct *vm);
 extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..b427f4a3b156 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -759,7 +759,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
 #endif
 	VMCOREINFO_SYMBOL(_stext);
-	VMCOREINFO_SYMBOL(vmap_area_list);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 
 #ifndef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(mem_map);
@@ -800,8 +800,6 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(free_area, free_list);
 	VMCOREINFO_OFFSET(list_head, next);
 	VMCOREINFO_OFFSET(list_head, prev);
-	VMCOREINFO_OFFSET(vmap_area, va_start);
-	VMCOREINFO_OFFSET(vmap_area, list);
 	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
 	log_buf_vmcoreinfo_setup();
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index b4cac76ea5e9..8a689b4ff4f9 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -89,7 +89,6 @@ static struct test_item test_items[] = {
 	ITEM_DATA(kallsyms_test_var_data_static),
 	ITEM_DATA(kallsyms_test_var_bss),
 	ITEM_DATA(kallsyms_test_var_data),
-	ITEM_DATA(vmap_area_list),
 #endif
 };
 
diff --git a/mm/nommu.c b/mm/nommu.c
index b6dc558d3144..5ec8f44e7ce9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -131,8 +131,6 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL(follow_pfn);
 
-LIST_HEAD(vmap_area_list);
-
 void vfree(const void *addr)
 {
 	kfree(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 786ecb18ae22..8c01f2225ef7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -729,8 +729,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 
 
 static DEFINE_SPINLOCK(free_vmap_area_lock);
-/* Export for kexec only */
-LIST_HEAD(vmap_area_list);
 static bool vmap_initialized __read_mostly;
 
 static struct rb_root purge_vmap_area_root = RB_ROOT;
-- 
2.39.2


