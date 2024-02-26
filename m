Return-Path: <linux-kernel+bounces-82442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E468684A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDDEB2298C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF4136645;
	Mon, 26 Feb 2024 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECOrLYuO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="68wQGVNR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C45135A4F;
	Mon, 26 Feb 2024 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708990306; cv=none; b=WDbx8/56nVZApB8z0A+opdhO86c2rSqarYANKbuWJidytkSp5mFyGDXVuVdFuLr9yx8gCsHcGKENGpANOmkiLqPzCba/kISZggm8L8XzT7DredAqmcp3vawuishTx1EH8f0QLhG3NUisdmI4MH4Gn8NwyYCUw/TN8cs4pkX/UfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708990306; c=relaxed/simple;
	bh=z2ywbXyOOgJiYA4sntkJPE1bSwMyHyBurrDA+kDnimA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=it7oaMYTmACyiH91hB76KpXnCathD43HNXXNpxV69qum3l+/j8pMU1+5IIKe9CMLYM4z2uFrAOxbZX4Ff8wofH7HUIXKeRCin57ChT84kv3PIgb5/yEkuDkcqpFtcjQD+Vrt11ohR43LT+hRSBFBXspSSLv5jNroqD6aefVhfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECOrLYuO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=68wQGVNR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 23:31:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708990302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0YfnfUMeyQNB0+7zfgcCYMBvY0vr9BLNrtqmnKo2kw=;
	b=ECOrLYuOTaxN3vDRMdiMHFJUKbZqTnrrG+SYdLvbTE7x9sifYj3ajSsQdFeqwCOLZXFdHk
	FWqW9lswVG5oUhJ9jRqcPTxk7QnDlIzduGragBDQLz3TQoJLu3RksIM0z4Nph/Avm7zaaX
	6dhqZUFtewEQhSJHBmrG7TcX37wH+PJ+qIn1j23Vf7ccFBXVCFEKa2jEjE/2VAiBe0sm5w
	hSDMYGTEl02gAc3hhS3L+fJrDtJKhYsokuzxSKjM7/F0wLZ4U9GViCuqAoD21oBYqWOUIh
	cjaQhjaPZ6eLcmayCUBCGcoH35r9532noOR02IePb9/K12m0X8YoxzlzKbbX5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708990302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0YfnfUMeyQNB0+7zfgcCYMBvY0vr9BLNrtqmnKo2kw=;
	b=68wQGVNRc0YkbO1ys4PZIDzS4VohviBb7L9/GtGa58jZoaslNDL4dajZzMy/anMZQC3VaQ
	9uBTKSWONUdJCbBg==
From: "tip-bot2 for Daniel Micay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/vdso: Move vDSO to mmap region
Cc: Daniel Micay <danielmicay@gmail.com>, Kees Cook <keescook@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210091827.work.233-kees@kernel.org>
References: <20240210091827.work.233-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170899030198.398.14097946092277859696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3c6539b4c177695aaa77893c4ce91d21dea7bb3d
Gitweb:        https://git.kernel.org/tip/3c6539b4c177695aaa77893c4ce91d21dea7bb3d
Author:        Daniel Micay <danielmicay@gmail.com>
AuthorDate:    Sat, 10 Feb 2024 01:18:35 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 00:23:55 +01:00

x86/vdso: Move vDSO to mmap region

The vDSO (and its initial randomization) was introduced in commit 2aae950b21e4
("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu"), but
had very low entropy. The entropy was improved in commit 394f56fe4801
("x86_64, vdso: Fix the vdso address randomization algorithm"), but there
is still improvement to be made.

In principle there should not be executable code at a low entropy offset
from the stack, since the stack and executable code having separate
randomization is part of what makes ASLR stronger.

Remove the only executable code near the stack region and give the vDSO
the same randomized base as other mmap mappings including the linker
and other shared objects. This results in higher entropy being provided
and there's little to no advantage in separating this from the existing
executable code there. This is already how other architectures like
arm64 handle the vDSO.

As an side, while it's sensible for userspace to reserve the initial mmap
base as a region for executable code with a random gap for other mmap
allocations, along with providing randomization within that region, there
isn't much the kernel can do to help due to how dynamic linkers load the
shared objects.

This was extracted from the PaX RANDMMAP feature.

[kees: updated commit log with historical details and other tweaks]

Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://github.com/KSPP/linux/issues/280
Link: https://lore.kernel.org/r/20240210091827.work.233-kees@kernel.org
---
 arch/x86/entry/vdso/vma.c    | 57 +----------------------------------
 arch/x86/include/asm/elf.h   |  1 +-
 arch/x86/kernel/sys_x86_64.c |  7 +----
 3 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 7645730..6d83ceb 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -274,59 +274,6 @@ up_fail:
 	return ret;
 }
 
-#ifdef CONFIG_X86_64
-/*
- * Put the vdso above the (randomized) stack with another randomized
- * offset.  This way there is no hole in the middle of address space.
- * To save memory make sure it is still in the same PTE as the stack
- * top.  This doesn't give that many random bits.
- *
- * Note that this algorithm is imperfect: the distribution of the vdso
- * start address within a PMD is biased toward the end.
- *
- * Only used for the 64-bit and x32 vdsos.
- */
-static unsigned long vdso_addr(unsigned long start, unsigned len)
-{
-	unsigned long addr, end;
-	unsigned offset;
-
-	/*
-	 * Round up the start address.  It can start out unaligned as a result
-	 * of stack start randomization.
-	 */
-	start = PAGE_ALIGN(start);
-
-	/* Round the lowest possible end address up to a PMD boundary. */
-	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= DEFAULT_MAP_WINDOW)
-		end = DEFAULT_MAP_WINDOW;
-	end -= len;
-
-	if (end > start) {
-		offset = get_random_u32_below(((end - start) >> PAGE_SHIFT) + 1);
-		addr = start + (offset << PAGE_SHIFT);
-	} else {
-		addr = start;
-	}
-
-	/*
-	 * Forcibly align the final address in case we have a hardware
-	 * issue that requires alignment for performance reasons.
-	 */
-	addr = align_vdso_addr(addr);
-
-	return addr;
-}
-
-static int map_vdso_randomized(const struct vdso_image *image)
-{
-	unsigned long addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
-
-	return map_vdso(image, addr);
-}
-#endif
-
 int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
@@ -369,7 +316,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (!vdso64_enabled)
 		return 0;
 
-	return map_vdso_randomized(&vdso_image_64);
+	return map_vdso(&vdso_image_64, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -380,7 +327,7 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 	if (x32) {
 		if (!vdso64_enabled)
 			return 0;
-		return map_vdso_randomized(&vdso_image_x32);
+		return map_vdso(&vdso_image_x32, 0);
 	}
 #endif
 #ifdef CONFIG_IA32_EMULATION
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1e16bd5..1fb83d4 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -392,5 +392,4 @@ struct va_alignment {
 } ____cacheline_aligned;
 
 extern struct va_alignment va_align;
-extern unsigned long align_vdso_addr(unsigned long);
 #endif /* _ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index c783aeb..cb9fa1d 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -52,13 +52,6 @@ static unsigned long get_align_bits(void)
 	return va_align.bits & get_align_mask();
 }
 
-unsigned long align_vdso_addr(unsigned long addr)
-{
-	unsigned long align_mask = get_align_mask();
-	addr = (addr + align_mask) & ~align_mask;
-	return addr | get_align_bits();
-}
-
 static int __init control_va_addr_alignment(char *str)
 {
 	/* guard against enabling this on other CPU families */

