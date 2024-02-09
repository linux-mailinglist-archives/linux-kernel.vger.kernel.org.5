Return-Path: <linux-kernel+bounces-59773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2471284FB98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FA21F23D04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B05128369;
	Fri,  9 Feb 2024 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JXf60UWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7qKG67F"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503A86AD8;
	Fri,  9 Feb 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502089; cv=none; b=lECCfHaxap0CGnBtDypt7Zf8201mLSeiPKGXgGpe7qO+IWhRdQ465PpzPxzP7QHkbsiKmKRVuQAEOwpJUE9mEK9mJYuNnVjwhezv7T2R/vh03nmaibjbOzankXjTn4rH90rgE3bkGH1hu0Q7lwLv5/5iPkRhwYeVXkh0Z7Wkfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502089; c=relaxed/simple;
	bh=rzATakOEyyJuBm/TJ8ceDcgUlVU73mkl+ivq91jSATg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EI5LxpTCVfMhjxh4W4Lx2E23LEwQCUuIcvsVXlJDKSiE/pe9IaPmybgsr2hE+Rsjq7yzi5tzsj81EW/bvbixNzm5hfnNzrA/kOcLzHwzSFclLF6v4Jj/y5soEzu985h+pSFcLQ8bJ2HDIlIoOCYCnKOz4G1/mibYbliKgmaX1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=JXf60UWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7qKG67F; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F2F7813800B9;
	Fri,  9 Feb 2024 13:08:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 13:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502085;
	 x=1707588485; bh=jv8EYuj3bWvaUTuv8bEn7Jt6jV5x+VSuR/EwKaxASlY=; b=
	JXf60UWhy+6hSRqJuipBqixrh+53MvI2fNEAuanaJ+5Woo02bYq70BIAvj4UE3xe
	Phbn9z3SOV3KnFrDyz/8DOf6FE6llD2MOIav9WUedSRroD4GYABrCm+L6DRnKX22
	ey2ESnZeubD/nlCwWcs3AdOPkOVabqpHJS+xDfw9SdHRgWnfCCLYPM6Ue6EUZrgx
	q+Gs67EH5Q95bHWU6d3UqYhbI8sHmCFX7JJ9V6fIg5ScxdPGQ6+xwvavPuEEVabf
	556MwkTU9+xDlAPjhobfEw3BMrQLOdfwmnoJzQjC1wRdYU8Xlf0AQnkyCXFJspJo
	RM5EfWocqVEp32tqEDGoGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502085; x=
	1707588485; bh=jv8EYuj3bWvaUTuv8bEn7Jt6jV5x+VSuR/EwKaxASlY=; b=K
	7qKG67FL2ol9yy9JlYbOZfIYYKQMWXhsot9IyjLVJ9itKvHgkQaJhCM/XLqD1VsG
	mNxT/Ol8/TWvd/LYZHFNsRFRrT8FUce8PtaaXaiy9Vlg+hxsmLuTnEVLcteEWdBZ
	WeIx8/woXW89fH35ePKmVectkvBPM1lsnkVruBvh2xzfiLe683ovW6j4gv7/2mlY
	h9JmwNW1GsXt+qaJ6Dlz8Naq+0Q3Pqorwr3ySrZNEEbeNSjmIxDn0M4RSaV2LKZj
	u2vwSJ9/obs3fzgrdPjFOoNvwVILQzqYOsotWZIJzYW+NV2C6vHJTBNoZjvnN75P
	80QdHKHmcrVlaKl+fT+Pg==
X-ME-Sender: <xms:BWrGZQi_JpHU0nDtJkSQMj44S0Twl2csNCl1erF0TRPrwxj7Z4a5Qg>
    <xme:BWrGZZCidvA789U8ax5nEUyDxBqmlIjhBA_p5h6Dp9xxREm_4M3wwvXuHkyrHtxpn
    QnKv_V-dP4aS1nV8TY>
X-ME-Received: <xmr:BWrGZYHvsKw7KDjc9c_e5kh7m3smf32rpL_F0RjKWowv7CRteshqcdNK7b8xnoTH7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:BWrGZRRMU2xjYfMMx95Ueemhr1TXbeJ9hFR4JSW5yXXFDCxkcF0y0Q>
    <xmx:BWrGZdwghaxZGojrPHdk28BdiYLRVtb3incAPOfkv0rcau7-xAPxXw>
    <xmx:BWrGZf5B66NvlgsxBDVnRMUwhgUUtTm0fHdZktvLCCGl1o3Oc8DK4w>
    <xmx:BWrGZQpBuWft3x09MjrxnRyula-8H33tT78kutt_QKI44RJ05pOJDw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:04 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:52 +0000
Subject: [PATCH 6/8] MIPS: tlbex: Use GPR number macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-6-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14697;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=rzATakOEyyJuBm/TJ8ceDcgUlVU73mkl+ivq91jSATg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX/PbxWultM1uXJ/7tLgrM+OYYxLL/I/V7kZILjZR
 +i7yRrXjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjILWWG/56WU/5YMxSrfZqn
 UHV6/aoUTkcuA1/TqvP2nX931vh4zWL4n6q0c4GJ+zUZ5WzNJ7xbcvlXyW7nnrr+4Inq+aXL2fZ
 c4gAA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Use GPR number macros in uasm code generation parts to
reduce code duplication.

No functional change.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/mm/tlbex.c | 196 +++++++++++++++++++++++++--------------------------
 1 file changed, 97 insertions(+), 99 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index c9d00d9cb3c8..69ea54bdc0c3 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -34,6 +34,7 @@
 #include <asm/cpu-type.h>
 #include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
+#include <asm/regdef.h>
 #include <asm/uasm.h>
 #include <asm/setup.h>
 #include <asm/tlbex.h>
@@ -277,10 +278,6 @@ static inline void dump_handler(const char *symbol, const void *start, const voi
 	pr_debug("\tEND(%s)\n", symbol);
 }
 
-/* The only general purpose registers allowed in TLB handlers. */
-#define K0		26
-#define K1		27
-
 #ifdef CONFIG_64BIT
 # define GET_CONTEXT(buf, reg) UASM_i_MFC0(buf, reg, C0_XCONTEXT)
 #else
@@ -340,30 +337,30 @@ static struct work_registers build_get_work_registers(u32 **p)
 	if (scratch_reg >= 0) {
 		/* Save in CPU local C0_KScratch? */
 		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
-		r.r1 = K0;
-		r.r2 = K1;
-		r.r3 = 1;
+		r.r1 = GPR_K0;
+		r.r2 = GPR_K1;
+		r.r3 = GPR_AT;
 		return r;
 	}
 
 	if (num_possible_cpus() > 1) {
 		/* Get smp_processor_id */
-		UASM_i_CPUID_MFC0(p, K0, SMP_CPUID_REG);
-		UASM_i_SRL_SAFE(p, K0, K0, SMP_CPUID_REGSHIFT);
+		UASM_i_CPUID_MFC0(p, GPR_K0, SMP_CPUID_REG);
+		UASM_i_SRL_SAFE(p, GPR_K0, GPR_K0, SMP_CPUID_REGSHIFT);
 
-		/* handler_reg_save index in K0 */
-		UASM_i_SLL(p, K0, K0, ilog2(sizeof(struct tlb_reg_save)));
+		/* handler_reg_save index in GPR_K0 */
+		UASM_i_SLL(p, GPR_K0, GPR_K0, ilog2(sizeof(struct tlb_reg_save)));
 
-		UASM_i_LA(p, K1, (long)&handler_reg_save);
-		UASM_i_ADDU(p, K0, K0, K1);
+		UASM_i_LA(p, GPR_K1, (long)&handler_reg_save);
+		UASM_i_ADDU(p, GPR_K0, GPR_K0, GPR_K1);
 	} else {
-		UASM_i_LA(p, K0, (long)&handler_reg_save);
+		UASM_i_LA(p, GPR_K0, (long)&handler_reg_save);
 	}
-	/* K0 now points to save area, save $1 and $2  */
-	UASM_i_SW(p, 1, offsetof(struct tlb_reg_save, a), K0);
-	UASM_i_SW(p, 2, offsetof(struct tlb_reg_save, b), K0);
+	/* GPR_K0 now points to save area, save $1 and $2  */
+	UASM_i_SW(p, 1, offsetof(struct tlb_reg_save, a), GPR_K0);
+	UASM_i_SW(p, 2, offsetof(struct tlb_reg_save, b), GPR_K0);
 
-	r.r1 = K1;
+	r.r1 = GPR_K1;
 	r.r2 = 1;
 	r.r3 = 2;
 	return r;
@@ -376,9 +373,9 @@ static void build_restore_work_registers(u32 **p)
 		UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 		return;
 	}
-	/* K0 already points to save area, restore $1 and $2  */
-	UASM_i_LW(p, 1, offsetof(struct tlb_reg_save, a), K0);
-	UASM_i_LW(p, 2, offsetof(struct tlb_reg_save, b), K0);
+	/* GPR_K0 already points to save area, restore $1 and $2  */
+	UASM_i_LW(p, 1, offsetof(struct tlb_reg_save, a), GPR_K0);
+	UASM_i_LW(p, 2, offsetof(struct tlb_reg_save, b), GPR_K0);
 }
 
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
@@ -397,22 +394,22 @@ static void build_r3000_tlb_refill_handler(void)
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	p = tlb_handler;
 
-	uasm_i_mfc0(&p, K0, C0_BADVADDR);
-	uasm_i_lui(&p, K1, uasm_rel_hi(pgdc)); /* cp0 delay */
-	uasm_i_lw(&p, K1, uasm_rel_lo(pgdc), K1);
-	uasm_i_srl(&p, K0, K0, 22); /* load delay */
-	uasm_i_sll(&p, K0, K0, 2);
-	uasm_i_addu(&p, K1, K1, K0);
-	uasm_i_mfc0(&p, K0, C0_CONTEXT);
-	uasm_i_lw(&p, K1, 0, K1); /* cp0 delay */
-	uasm_i_andi(&p, K0, K0, 0xffc); /* load delay */
-	uasm_i_addu(&p, K1, K1, K0);
-	uasm_i_lw(&p, K0, 0, K1);
+	uasm_i_mfc0(&p, GPR_K0, C0_BADVADDR);
+	uasm_i_lui(&p, GPR_K1, uasm_rel_hi(pgdc)); /* cp0 delay */
+	uasm_i_lw(&p, GPR_K1, uasm_rel_lo(pgdc), GPR_K1);
+	uasm_i_srl(&p, GPR_K0, GPR_K0, 22); /* load delay */
+	uasm_i_sll(&p, GPR_K0, GPR_K0, 2);
+	uasm_i_addu(&p, GPR_K1, GPR_K1, GPR_K0);
+	uasm_i_mfc0(&p, GPR_K0, C0_CONTEXT);
+	uasm_i_lw(&p, GPR_K1, 0, GPR_K1); /* cp0 delay */
+	uasm_i_andi(&p, GPR_K0, GPR_K0, 0xffc); /* load delay */
+	uasm_i_addu(&p, GPR_K1, GPR_K1, GPR_K0);
+	uasm_i_lw(&p, GPR_K0, 0, GPR_K1);
 	uasm_i_nop(&p); /* load delay */
-	uasm_i_mtc0(&p, K0, C0_ENTRYLO0);
-	uasm_i_mfc0(&p, K1, C0_EPC); /* cp0 delay */
+	uasm_i_mtc0(&p, GPR_K0, C0_ENTRYLO0);
+	uasm_i_mfc0(&p, GPR_K1, C0_EPC); /* cp0 delay */
 	uasm_i_tlbwr(&p); /* cp0 delay */
-	uasm_i_jr(&p, K1);
+	uasm_i_jr(&p, GPR_K1);
 	uasm_i_rfe(&p); /* branch delay */
 
 	if (p > tlb_handler + 32)
@@ -1260,11 +1257,11 @@ static void build_r4000_tlb_refill_handler(void)
 	memset(final_handler, 0, sizeof(final_handler));
 
 	if (IS_ENABLED(CONFIG_64BIT) && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
-		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
+		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, GPR_K0, GPR_K1,
 							  scratch_reg);
 		vmalloc_mode = refill_scratch;
 	} else {
-		htlb_info.huge_pte = K0;
+		htlb_info.huge_pte = GPR_K0;
 		htlb_info.restore_scratch = 0;
 		htlb_info.need_reload_pte = true;
 		vmalloc_mode = refill_noscratch;
@@ -1274,29 +1271,29 @@ static void build_r4000_tlb_refill_handler(void)
 		if (bcm1250_m3_war()) {
 			unsigned int segbits = 44;
 
-			uasm_i_dmfc0(&p, K0, C0_BADVADDR);
-			uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
-			uasm_i_xor(&p, K0, K0, K1);
-			uasm_i_dsrl_safe(&p, K1, K0, 62);
-			uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
-			uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
-			uasm_i_or(&p, K0, K0, K1);
-			uasm_il_bnez(&p, &r, K0, label_leave);
+			uasm_i_dmfc0(&p, GPR_K0, C0_BADVADDR);
+			uasm_i_dmfc0(&p, GPR_K1, C0_ENTRYHI);
+			uasm_i_xor(&p, GPR_K0, GPR_K0, GPR_K1);
+			uasm_i_dsrl_safe(&p, GPR_K1, GPR_K0, 62);
+			uasm_i_dsrl_safe(&p, GPR_K0, GPR_K0, 12 + 1);
+			uasm_i_dsll_safe(&p, GPR_K0, GPR_K0, 64 + 12 + 1 - segbits);
+			uasm_i_or(&p, GPR_K0, GPR_K0, GPR_K1);
+			uasm_il_bnez(&p, &r, GPR_K0, label_leave);
 			/* No need for uasm_i_nop */
 		}
 
 #ifdef CONFIG_64BIT
-		build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
+		build_get_pmde64(&p, &l, &r, GPR_K0, GPR_K1); /* get pmd in GPR_K1 */
 #else
-		build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
+		build_get_pgde32(&p, GPR_K0, GPR_K1); /* get pgd in GPR_K1 */
 #endif
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-		build_is_huge_pte(&p, &r, K0, K1, label_tlb_huge_update);
+		build_is_huge_pte(&p, &r, GPR_K0, GPR_K1, label_tlb_huge_update);
 #endif
 
-		build_get_ptep(&p, K0, K1);
-		build_update_entries(&p, K0, K1);
+		build_get_ptep(&p, GPR_K0, GPR_K1);
+		build_update_entries(&p, GPR_K0, GPR_K1);
 		build_tlb_write_entry(&p, &l, &r, tlb_random);
 		uasm_l_leave(&l, p);
 		uasm_i_eret(&p); /* return from trap */
@@ -1304,14 +1301,14 @@ static void build_r4000_tlb_refill_handler(void)
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
 	if (htlb_info.need_reload_pte)
-		UASM_i_LW(&p, htlb_info.huge_pte, 0, K1);
-	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
-	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
+		UASM_i_LW(&p, htlb_info.huge_pte, 0, GPR_K1);
+	build_huge_update_entries(&p, htlb_info.huge_pte, GPR_K1);
+	build_huge_tlb_write_entry(&p, &l, &r, GPR_K0, tlb_random,
 				   htlb_info.restore_scratch);
 #endif
 
 #ifdef CONFIG_64BIT
-	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1, vmalloc_mode);
+	build_get_pgd_vmalloc64(&p, &l, &r, GPR_K0, GPR_K1, vmalloc_mode);
 #endif
 
 	/*
@@ -1484,34 +1481,35 @@ static void build_loongson3_tlb_refill_handler(void)
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 
 	if (check_for_high_segbits) {
-		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
-		uasm_i_dsrl_safe(&p, K1, K0, PGDIR_SHIFT + PGD_TABLE_ORDER + PAGE_SHIFT - 3);
-		uasm_il_beqz(&p, &r, K1, label_vmalloc);
+		uasm_i_dmfc0(&p, GPR_K0, C0_BADVADDR);
+		uasm_i_dsrl_safe(&p, GPR_K1, GPR_K0,
+				PGDIR_SHIFT + PGD_TABLE_ORDER + PAGE_SHIFT - 3);
+		uasm_il_beqz(&p, &r, GPR_K1, label_vmalloc);
 		uasm_i_nop(&p);
 
-		uasm_il_bgez(&p, &r, K0, label_large_segbits_fault);
+		uasm_il_bgez(&p, &r, GPR_K0, label_large_segbits_fault);
 		uasm_i_nop(&p);
 		uasm_l_vmalloc(&l, p);
 	}
 
-	uasm_i_dmfc0(&p, K1, C0_PGD);
+	uasm_i_dmfc0(&p, GPR_K1, C0_PGD);
 
-	uasm_i_lddir(&p, K0, K1, 3);  /* global page dir */
+	uasm_i_lddir(&p, GPR_K0, GPR_K1, 3);  /* global page dir */
 #ifndef __PAGETABLE_PMD_FOLDED
-	uasm_i_lddir(&p, K1, K0, 1);  /* middle page dir */
+	uasm_i_lddir(&p, GPR_K1, GPR_K0, 1);  /* middle page dir */
 #endif
-	uasm_i_ldpte(&p, K1, 0);      /* even */
-	uasm_i_ldpte(&p, K1, 1);      /* odd */
+	uasm_i_ldpte(&p, GPR_K1, 0);      /* even */
+	uasm_i_ldpte(&p, GPR_K1, 1);      /* odd */
 	uasm_i_tlbwr(&p);
 
 	/* restore page mask */
 	if (PM_DEFAULT_MASK >> 16) {
-		uasm_i_lui(&p, K0, PM_DEFAULT_MASK >> 16);
-		uasm_i_ori(&p, K0, K0, PM_DEFAULT_MASK & 0xffff);
-		uasm_i_mtc0(&p, K0, C0_PAGEMASK);
+		uasm_i_lui(&p, GPR_K0, PM_DEFAULT_MASK >> 16);
+		uasm_i_ori(&p, GPR_K0, GPR_K0, PM_DEFAULT_MASK & 0xffff);
+		uasm_i_mtc0(&p, GPR_K0, C0_PAGEMASK);
 	} else if (PM_DEFAULT_MASK) {
-		uasm_i_ori(&p, K0, 0, PM_DEFAULT_MASK);
-		uasm_i_mtc0(&p, K0, C0_PAGEMASK);
+		uasm_i_ori(&p, GPR_K0, 0, PM_DEFAULT_MASK);
+		uasm_i_mtc0(&p, GPR_K0, C0_PAGEMASK);
 	} else {
 		uasm_i_mtc0(&p, 0, C0_PAGEMASK);
 	}
@@ -1520,8 +1518,8 @@ static void build_loongson3_tlb_refill_handler(void)
 
 	if (check_for_high_segbits) {
 		uasm_l_large_segbits_fault(&l, p);
-		UASM_i_LA(&p, K1, (unsigned long)tlb_do_page_fault_0);
-		uasm_i_jr(&p, K1);
+		UASM_i_LA(&p, GPR_K1, (unsigned long)tlb_do_page_fault_0);
+		uasm_i_jr(&p, GPR_K1);
 		uasm_i_nop(&p);
 	}
 
@@ -1887,11 +1885,11 @@ static void build_r3000_tlb_load_handler(void)
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_present(&p, &r, K0, K1, -1, label_nopage_tlbl);
+	build_r3000_tlbchange_handler_head(&p, GPR_K0, GPR_K1);
+	build_pte_present(&p, &r, GPR_K0, GPR_K1, -1, label_nopage_tlbl);
 	uasm_i_nop(&p); /* load delay */
-	build_make_valid(&p, &r, K0, K1, -1);
-	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
+	build_make_valid(&p, &r, GPR_K0, GPR_K1, -1);
+	build_r3000_tlb_reload_write(&p, &l, &r, GPR_K0, GPR_K1);
 
 	uasm_l_nopage_tlbl(&l, p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
@@ -1917,11 +1915,11 @@ static void build_r3000_tlb_store_handler(void)
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_writable(&p, &r, K0, K1, -1, label_nopage_tlbs);
+	build_r3000_tlbchange_handler_head(&p, GPR_K0, GPR_K1);
+	build_pte_writable(&p, &r, GPR_K0, GPR_K1, -1, label_nopage_tlbs);
 	uasm_i_nop(&p); /* load delay */
-	build_make_write(&p, &r, K0, K1, -1);
-	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
+	build_make_write(&p, &r, GPR_K0, GPR_K1, -1);
+	build_r3000_tlb_reload_write(&p, &l, &r, GPR_K0, GPR_K1);
 
 	uasm_l_nopage_tlbs(&l, p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
@@ -1947,11 +1945,11 @@ static void build_r3000_tlb_modify_handler(void)
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_modifiable(&p, &r, K0, K1,  -1, label_nopage_tlbm);
+	build_r3000_tlbchange_handler_head(&p, GPR_K0, GPR_K1);
+	build_pte_modifiable(&p, &r, GPR_K0, GPR_K1,  -1, label_nopage_tlbm);
 	uasm_i_nop(&p); /* load delay */
-	build_make_write(&p, &r, K0, K1, -1);
-	build_r3000_pte_reload_tlbwi(&p, K0, K1);
+	build_make_write(&p, &r, GPR_K0, GPR_K1, -1);
+	build_r3000_pte_reload_tlbwi(&p, GPR_K0, GPR_K1);
 
 	uasm_l_nopage_tlbm(&l, p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
@@ -2067,14 +2065,14 @@ static void build_r4000_tlb_load_handler(void)
 	if (bcm1250_m3_war()) {
 		unsigned int segbits = 44;
 
-		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
-		uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
-		uasm_i_xor(&p, K0, K0, K1);
-		uasm_i_dsrl_safe(&p, K1, K0, 62);
-		uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
-		uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
-		uasm_i_or(&p, K0, K0, K1);
-		uasm_il_bnez(&p, &r, K0, label_leave);
+		uasm_i_dmfc0(&p, GPR_K0, C0_BADVADDR);
+		uasm_i_dmfc0(&p, GPR_K1, C0_ENTRYHI);
+		uasm_i_xor(&p, GPR_K0, GPR_K0, GPR_K1);
+		uasm_i_dsrl_safe(&p, GPR_K1, GPR_K0, 62);
+		uasm_i_dsrl_safe(&p, GPR_K0, GPR_K0, 12 + 1);
+		uasm_i_dsll_safe(&p, GPR_K0, GPR_K0, 64 + 12 + 1 - segbits);
+		uasm_i_or(&p, GPR_K0, GPR_K0, GPR_K1);
+		uasm_il_bnez(&p, &r, GPR_K0, label_leave);
 		/* No need for uasm_i_nop */
 	}
 
@@ -2217,9 +2215,9 @@ static void build_r4000_tlb_load_handler(void)
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
-		uasm_i_lui(&p, K0, uasm_rel_hi((long)tlb_do_page_fault_0));
-		uasm_i_addiu(&p, K0, K0, uasm_rel_lo((long)tlb_do_page_fault_0));
-		uasm_i_jr(&p, K0);
+		uasm_i_lui(&p, GPR_K0, uasm_rel_hi((long)tlb_do_page_fault_0));
+		uasm_i_addiu(&p, GPR_K0, GPR_K0, uasm_rel_lo((long)tlb_do_page_fault_0));
+		uasm_i_jr(&p, GPR_K0);
 	} else
 #endif
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
@@ -2273,9 +2271,9 @@ static void build_r4000_tlb_store_handler(void)
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-		uasm_i_lui(&p, K0, uasm_rel_hi((long)tlb_do_page_fault_1));
-		uasm_i_addiu(&p, K0, K0, uasm_rel_lo((long)tlb_do_page_fault_1));
-		uasm_i_jr(&p, K0);
+		uasm_i_lui(&p, GPR_K0, uasm_rel_hi((long)tlb_do_page_fault_1));
+		uasm_i_addiu(&p, GPR_K0, GPR_K0, uasm_rel_lo((long)tlb_do_page_fault_1));
+		uasm_i_jr(&p, GPR_K0);
 	} else
 #endif
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
@@ -2330,9 +2328,9 @@ static void build_r4000_tlb_modify_handler(void)
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-		uasm_i_lui(&p, K0, uasm_rel_hi((long)tlb_do_page_fault_1));
-		uasm_i_addiu(&p, K0, K0, uasm_rel_lo((long)tlb_do_page_fault_1));
-		uasm_i_jr(&p, K0);
+		uasm_i_lui(&p, GPR_K0, uasm_rel_hi((long)tlb_do_page_fault_1));
+		uasm_i_addiu(&p, GPR_K0, GPR_K0, uasm_rel_lo((long)tlb_do_page_fault_1));
+		uasm_i_jr(&p, GPR_K0);
 	} else
 #endif
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);

-- 
2.43.0


