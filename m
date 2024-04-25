Return-Path: <linux-kernel+bounces-158483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54068B20C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CE31C232EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD812AAEC;
	Thu, 25 Apr 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kadmz8lA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnFBdGsw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5F84DFC;
	Thu, 25 Apr 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045934; cv=none; b=ZNpTNIaL0dCX2CwyRk8vQJUtAJg1y5b8zKvoThdOumqa6a4+j4Fef3eEGNlqWVyItU+otQ1ZKA2pZbWJh2TTNdyKnti0BTETYWI8GpUPpWzLUEeUUibL8nekFdve+Sf3D838Is6Y90y00um4BS3XD/JDvgGNM8Rslf3jOPVItAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045934; c=relaxed/simple;
	bh=ibYMa3jhzNP65WVjGG80S1ZgkEVT/nRrO3d7MImhra8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kIBN0M1sOEM7pOjsMzVXV3aa+fp22NP/flUYmB76wCejUzhR0ck5q/iH1w2g/DEcNHy5eSnIgi7P+RByELBgc/KnScspAKppnN1WR+2bj2ESOlwiXmrUxlSF2153PFMdu7dpum70SR9IiV1kaU+MgFnSJung6dhN2KPjbEFCXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kadmz8lA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnFBdGsw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714045930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fibyo5fIycycuHzgFLgvHTjArYf2fAIDmOJSGGnfeGs=;
	b=Kadmz8lAwQLU3paaGZBH65Tjdo3KhzmylFuE02Dqc7LTfpnpfS3GfwxvL1yyQGORNj17EC
	V+McuIKS7D0dxVPn3HBxgZd+D8kdby9OBv0FlQDAiCv4EiVxCvaAGQkbNtsbk9nCp1SHhN
	ditgLrxqv7LYyRUkOCd9fvSf0B+2eRN7bbf2pSKWK/I0ZoTuORnXruLjq3mmIaCzmi3bpP
	g5EYyjly4N7X9EIIFFWKmmXJYGEHXGFz3R8at4BrejfxGE4eLd6zROXFgm6g2xKQKi2Lg1
	+s9dmyG0/YgbtpqP4Pe2Mva5mxCyJZXL9dmsMThEI8py4tcqac7YdGExA6nSHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714045930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fibyo5fIycycuHzgFLgvHTjArYf2fAIDmOJSGGnfeGs=;
	b=ZnFBdGswK+ol1V8O6CB2quAGkSrJbxl+WNQir6NbIJkdiz+PDXH5C9go+QLzuDZ5g2kBW8
	aLndt7NlV0MzdbBw==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: fix overlap of allocated page and PTR_ERR
Date: Thu, 25 Apr 2024 13:52:01 +0200
Message-Id: <20240425115201.3044202-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On riscv32, it is possible for the last page in virtual address space
(0xfffff000) to be allocated. This page overlaps with PTR_ERR, so that
shouldn't happen.

There is already some code to ensure memblock won't allocate the last page.
However, buddy allocator is left unchecked.

Fix this by reserving physical memory that would be mapped at virtual
addresses greater than 0xfffff000.

Reported-by: Björn Töpel <bjorn@kernel.org>
Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.are.belong.to.us
Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org>
---
 arch/riscv/mm/init.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 968761843203..7c985435b3fc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -235,18 +235,19 @@ static void __init setup_bootmem(void)
 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 
 	/*
-	 * memblock allocator is not aware of the fact that last 4K bytes of
-	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.  For 64-bit
-	 * kernel, this problem can't happen here as the end of the virtual
-	 * address space is occupied by the kernel mapping then this check must
-	 * be done as soon as the kernel mapping base address is determined.
+	 * Reserve physical address space that would be mapped to virtual
+	 * addresses greater than (void *)(-PAGE_SIZE) because:
+	 *  - This memory would overlap with ERR_PTR
+	 *  - This memory belongs to high memory, which is not supported
+	 *
+	 * This is not applicable to 64-bit kernel, because virtual addresses
+	 * after (void *)(-PAGE_SIZE) are not linearly mapped: they are
+	 * occupied by kernel mapping. Also it is unrealistic for high memory
+	 * to exist on 64-bit platforms.
 	 */
 	if (!IS_ENABLED(CONFIG_64BIT)) {
-		max_mapped_addr = __pa(~(ulong)0);
-		if (max_mapped_addr == (phys_ram_end - 1))
-			memblock_set_current_limit(max_mapped_addr - 4096);
+		max_mapped_addr = __va_to_pa_nodebug(-PAGE_SIZE);
+		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
 	}
 
 	min_low_pfn = PFN_UP(phys_ram_base);
-- 
2.39.2


