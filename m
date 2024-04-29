Return-Path: <linux-kernel+bounces-162012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB08B54A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6D81C218CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380E376FE;
	Mon, 29 Apr 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EnyKFka0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwij2dnB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F742941E;
	Mon, 29 Apr 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384770; cv=none; b=gBIaEXTOK1QB017LQOOR1yRSsaKPIUmBTHwz7vicODCt4ewiuBnxGN+jZwr7lwTopAohvcoQHHecoGk8R3B/+l+k7vrTL59Q41Xvfpp5C2nNffTIUsx4AL6eenAezNnXoakAsoRZvvtJqZTgThtaoiCyv3gxyrl9PMIDL9F3FWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384770; c=relaxed/simple;
	bh=HOUufDhAadIvE1dNC2ij4uIv1kbQ9kv7VZBvHzwlMVA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mE4ox2qrdk3BLyRYK2SIAPuSSmbTDm/gWirp7urZwh7K66fw3GMtOXsYQm3wfIr1pNEH3ClcIO/kVKQ8SRXQ4Ro7y6TeRJ2iVeyf2gpppvn3lrLqgK/tOuTptsMC0OwQULMezx9j9Mgkh7t+0ezhPYrqbBMya25FCOl8pZ7qtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EnyKFka0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwij2dnB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:59:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714384766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ6SqK+DcITrmbrGVV/86ZK7KrzTV3d8pYqbUHIskhg=;
	b=EnyKFka0pExikE5xFP+yf085aOiKyMB/6jXx88bsH+TzZFMJaTP9ETudPxBLmnht/ctQUD
	7sPDSjbRineaj6KyJ2qUZOpm17G7j8xhd2K6ujP4WI0ARGbO9K9Qul93Ap45a8U214H20m
	BOkFAoHkwxgWBiRWn6P7w9QZYSMRoTyJRRCvL/9KpIlRpFSj8nYI0fFalzhBiHbkNxrCOe
	XBISOrqg4miHi+RyFcXw/cxzoI9wIz3h+3Ow3NXqk8tFcFA5MWefCxvUZJGAtydRSdir98
	xNTIrYmWLdIStU0aRf0zmRcev2f6jGsE0OmJE4JLFm0eiDbPqteoFjPPjeTnpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714384766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ6SqK+DcITrmbrGVV/86ZK7KrzTV3d8pYqbUHIskhg=;
	b=hwij2dnBA18gLCXAXMYZUCD6NnluZFp9dWjjEQTbzYmyOUKQa1rZjOChs6a88//WLVACbk
	doyfBrmWCcZASXDw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/sev: Add callback to apply RMP table fixups for kexec
Cc: Ashish Kalra <ashish.kalra@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdf6e995ff88565262c2c7c69964883ff8aa6fc30=2E17140?=
 =?utf-8?q?90302=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cdf6e995ff88565262c2c7c69964883ff8aa6fc30=2E171409?=
 =?utf-8?q?0302=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438476623.10875.16783275868264913579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     400fea4b9651adf5d7ebd5d71e905f34f4e4e493
Gitweb:        https://git.kernel.org/tip/400fea4b9651adf5d7ebd5d71e905f34f4e4e493
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Fri, 26 Apr 2024 00:43:18 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 11:21:09 +02:00

x86/sev: Add callback to apply RMP table fixups for kexec

Handle cases where the RMP table placement in the BIOS is not 2M aligned
and the kexec-ed kernel could try to allocate from within that chunk
which then causes a fatal RMP fault.

The kexec failure is illustrated below:

  SEV-SNP: RMP table physical range [0x0000007ffe800000 - 0x000000807f0fffff]
  BIOS-provided physical RAM map:
  BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
  BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
  ...
  BIOS-e820: [mem 0x0000004080000000-0x0000007ffe7fffff] usable
  BIOS-e820: [mem 0x0000007ffe800000-0x000000807f0fffff] reserved
  BIOS-e820: [mem 0x000000807f100000-0x000000807f1fefff] usable

As seen here in the e820 memory map, the end range of the RMP table is not
aligned to 2MB and not reserved but it is usable as RAM.

Subsequently, kexec -s (KEXEC_FILE_LOAD syscall) loads it's purgatory
code and boot_param, command line and other setup data into this RAM
region as seen in the kexec logs below, which leads to fatal RMP fault
during kexec boot.

  Loaded purgatory at 0x807f1fa000
  Loaded boot_param, command line and misc at 0x807f1f8000 bufsz=0x1350 memsz=0x2000
  Loaded 64bit kernel at 0x7ffae00000 bufsz=0xd06200 memsz=0x3894000
  Loaded initrd at 0x7ff6c89000 bufsz=0x4176014 memsz=0x4176014
  E820 memmap:
  0000000000000000-000000000008efff (1)
  000000000008f000-000000000008ffff (4)
  0000000000090000-000000000009ffff (1)
  ...
  0000004080000000-0000007ffe7fffff (1)
  0000007ffe800000-000000807f0fffff (2)
  000000807f100000-000000807f1fefff (1)
  000000807f1ff000-000000807fffffff (2)
  nr_segments = 4
  segment[0]: buf=0x00000000e626d1a2 bufsz=0x4000 mem=0x807f1fa000 memsz=0x5000
  segment[1]: buf=0x0000000029c67bd6 bufsz=0x1350 mem=0x807f1f8000 memsz=0x2000
  segment[2]: buf=0x0000000045c60183 bufsz=0xd06200 mem=0x7ffae00000 memsz=0x3894000
  segment[3]: buf=0x000000006e54f08d bufsz=0x4176014 mem=0x7ff6c89000 memsz=0x4177000
  kexec_file_load: type:0, start:0x807f1fa150 head:0x1184d0002 flags:0x0

Check if RMP table start and end physical range in the e820 tables are
not aligned to 2MB and in that case map this range to reserved in all
the three e820 tables.

  [ bp: Massage. ]

Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/df6e995ff88565262c2c7c69964883ff8aa6fc30.1714090302.git.ashish.kalra@amd.com
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/mm/mem_encrypt.c  |  7 +++++++
 arch/x86/virt/svm/sev.c    | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7f57382..93ed600 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -269,6 +269,7 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
 int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
+void snp_fixup_e820_tables(void);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
@@ -282,6 +283,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
+static inline void snp_fixup_e820_tables(void) {}
 #endif
 
 #endif
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 6f3b3e0..0a120d8 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -102,6 +102,13 @@ void __init mem_encrypt_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
+	/*
+	 * Do RMP table fixups after the e820 tables have been setup by
+	 * e820__memory_setup().
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		snp_fixup_e820_tables();
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index ab0e844..0ae1053 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -163,6 +163,42 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+static void __init __snp_fixup_e820_tables(u64 pa)
+{
+	if (IS_ALIGNED(pa, PMD_SIZE))
+		return;
+
+	/*
+	 * Handle cases where the RMP table placement by the BIOS is not
+	 * 2M aligned and the kexec kernel could try to allocate
+	 * from within that chunk which then causes a fatal RMP fault.
+	 *
+	 * The e820_table needs to be updated as it is converted to
+	 * kernel memory resources and used by KEXEC_FILE_LOAD syscall
+	 * to load kexec segments.
+	 *
+	 * The e820_table_firmware needs to be updated as it is exposed
+	 * to sysfs and used by the KEXEC_LOAD syscall to load kexec
+	 * segments.
+	 *
+	 * The e820_table_kexec needs to be updated as it passed to
+	 * the kexec-ed kernel.
+	 */
+	pa = ALIGN_DOWN(pa, PMD_SIZE);
+	if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+		pr_info("Reserving start/end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	}
+}
+
+void __init snp_fixup_e820_tables(void)
+{
+	__snp_fixup_e820_tables(probed_rmp_base);
+	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP

