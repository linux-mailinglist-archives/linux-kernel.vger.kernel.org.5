Return-Path: <linux-kernel+bounces-49926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351748471A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95801F26B08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587113E20B;
	Fri,  2 Feb 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csd.uoc.gr header.i=@csd.uoc.gr header.b="G7vOWtx0"
Received: from ermis.csd.uoc.gr (ermis.csd.uoc.gr [147.52.203.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040181420A5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.52.203.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883094; cv=none; b=uhSF17/LYCl9eYD6p1vEEQHuKDlar12acQD9EC+sIOq48YB7X/Ok9K6loCunK2RLyARRXdcHgdlzLKfE0P1vQxVAwWOyTQltnMQjC+GQjXWrfmPc0oE8oTF6kjYH+cCrTjQnLezPY23iaT4nljnpGstKelUv87iHrFNOIDRvZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883094; c=relaxed/simple;
	bh=0fLShIaYA46L2v+Ga5N4MTBmAYSvwPEcuI+RHi2CSIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V4VGjRpXsdTQ7DSmRskYLRdMOGKcm9Y5goKqa9Wrgv98ewevhSl16iKJoI5VWGWGjBHSxtUnwfPWoavfhXG/JNOaLr61ajcsVgGcM5RkWD/PeHCZN+1LVAhi79/nfL4nki2tYf5C6MoF/k5Weon9VOOceqzwUG6+OtXf+hNTjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csd.uoc.gr; spf=pass smtp.mailfrom=csd.uoc.gr; dkim=pass (2048-bit key) header.d=csd.uoc.gr header.i=@csd.uoc.gr header.b=G7vOWtx0; arc=none smtp.client-ip=147.52.203.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csd.uoc.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csd.uoc.gr
Received: from cave.168.239.147 (ppp178059052035.access.hol.gr [178.59.52.35])
	by ermis.csd.uoc.gr (Postfix) with ESMTPSA id 818193C07E6;
	Fri,  2 Feb 2024 15:50:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csd.uoc.gr; s=csd;
	t=1706881833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8xiDaKPe3EcE5yGO2LEkBF3Kug+H9effrggz/KsrocE=;
	b=G7vOWtx0lFu4MpEoOLGB2l0LVjYeOEEP8SLtdxbFCuJBUsoFkr5PapgIdpBgZ9HGKHdovC
	T9hiqPlubuPwxlRkDirmTTclG7A9VLAOONzptl7QzWzQ9dbWqtHXR96D1FAmmM1qlMmu83
	EDdIJuzldAFuNP9eARfbbbaV4fk5oNai1Bb6l2WBZbaxS2s+hBADclXx0g1hSYlggOSwr7
	Ly7lT+jew6Q6ym6RuEAmFHbcOdFXSjxy+ih4dRAKwAeDtWXAbRwmm+5/Sef6rJwUt5a4G1
	6PsTMaT9EE5kGhAOaJvOYXUnUlVHi4mWS2HQksueYpcDuHaLq6A6+C/VgTcPgw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=csd4492 smtp.mailfrom=csd4492@csd.uoc.gr
From: Dimitris Vlachos <csd4492@csd.uoc.gr>
To: csd4492@csd.uoc.gr,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: clameter@sgi.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	arnd@arndb.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	mick@ics.forth.gr
Subject: [PATCH] [RFC] sparsemem: warn on out-of-bounds initialization
Date: Fri,  2 Feb 2024 15:50:30 +0200
Message-Id: <20240202135030.42265-1-csd4492@csd.uoc.gr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dimitris Vlachos <dvlachos@ics.forth.gr>

Hello all

I am sending this email with regards to a bug that I discovered in the Sparse Memory Model configuration and more specifically, the Virtual Memory Map optimization. Moreover, I would like to inquire about possible ways of fixing it.

I work as a pre-graduate research assistant at ICS-FORTH in the Computer Architecture and VLSI Systems laboratory.
We were running some tests in our prototype hardware (RISC-V), where we noticed that the Kernel crashes early in the boot process with the following setup:

We are using the default Kconfig configurations (defconfig) that includes Sparse Memory + Virtual Memory Map.
The DRAM base address of our system is : 0x800000000000
A 3-level page table is used (Sv39).

When the vmemmap optimization is enabled the macro pfn_to_page() is called, which offsets the vmemmap with the pfn argument to acquire a struct page pointer.

As our DRAM starts at 0x800000000000, the initial pfn will be 0x800000000000 divided by PAGE_SIZE. The calculation result will be:
0xffffffcf00000000 (vmemmap start) +  (0x800000000 (pfn) * 64 (sizeof(struct page))

This causes an overflow as the number is very large, the resulting address is 0x1c700000000​ which is not a valid Sv39 address (all bits above bit 38 should be set) and does not belong to the kernel’s virtual address space.

The same will happen with all valid pfns as the memory is being initialized. When the Kernel will try to access a page using pfn_to_page, a page fault will occur crashing the system.
It should be noted that when the vmemmap is disabled the system boots normally.

However, I would like to emphasize another important detail. When the DRAM base is small enough to avoid an overflow, the virtual memory map mappings will be initialized out of bounds with regard to the vmemmap address space which is 4GiB in Sv39.
The system will not crash, but the address space used for this purpose will be outside of the designated range.

Everything mentioned above holds true when Sv48 is used as well. Given a high enough DRAM base the system will either crash or perform false initializations. Given the fact that virtual memory map is not only used by RISC-V systems, this could be an issue for other architectures as well.

The kernel already contains mminit_validate_memmodel_limits() that checks memory limits.
However, it only checks physical memory ranges. I added a few checks, provided that virtual memory map is enabled, to determine whether offset start and offset end fall inside the range of virtual memory map. Otherwise, a warning will be printed.

Finally, I would like to ask you for any information/advice that could help me fix/prevent the issues that I mentioned (if it’s possible) or recover from them at runtime by disabling the optimization and reverting back to the non-vmemmap mappings.

Thank you in advance.
Best regards,
Dimitris Vlachos
---
 mm/sparse.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 338cf946d..33b57758e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -149,6 +149,26 @@ static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 		WARN_ON_ONCE(1);
 		*end_pfn = max_sparsemem_pfn;
 	}
+
+	/*check vmemmap limits*/
+	#ifdef CONFIG_SPARSEMEM_VMEMMAP
+
+	unsigned long vmemmap_offset_start = (unsigned long) pfn_to_page(*start_pfn);
+	unsigned long vmemmap_offset_end   = (unsigned long) pfn_to_page(*end_pfn);
+
+	if (vmemmap_offset_start < VMEMMAP_START) {
+		mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
+			"Start of range %lu -> %lu exceeds bounds of SPARSEMEM virtual memory map address range %lu -> %lu\n",
+			vmemmap_offset_start, vmemmap_offset_end, VMEMMAP_START,VMEMMAP_END);
+		WARN_ON_ONCE(1);
+
+	} else if (vmemmap_offset_end > VMEMMAP_END ) {
+		mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
+			"End of range %lu -> %lu exceeds bounds of SPARSEMEM virtual memory map address range %lu -> %lu\n",
+			vmemmap_offset_start, vmemmap_offset_end, VMEMMAP_START,VMEMMAP_END);
+		WARN_ON_ONCE(1);
+	}
+	#endif
 }
 
 /*
-- 
2.39.2


