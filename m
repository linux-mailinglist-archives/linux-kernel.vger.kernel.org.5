Return-Path: <linux-kernel+bounces-59775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9495F84FB9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46C61C2525B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46A128389;
	Fri,  9 Feb 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="eT4rm1BT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CS36Ks/5"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C31272D4;
	Fri,  9 Feb 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502091; cv=none; b=X0FqbYwtIZ3GS1d9R8SicZ7WkQZi4Cwojh8y4NRtDA44eTg7llCGUe5VrdOKYG6wntm9hk1pEr/qeKrt5W6J0ZxDa1EKUuB0wKe1os6PZ/okYtmk2iZHaeK5MVKwp5dIHULXpobicUt3SC2B7PWVS0V5fzWKldR9Hsr+wnSDHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502091; c=relaxed/simple;
	bh=ogCOAZX2NXN9A243dzILDExre06o072M6R8BIadrlQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SV3+ecnWAtGoWmUCsBGNVg6EcnoY9QnFiArinb72yJ4d9zt/xNkmQxXZn+7oPQHDKVPuwQgjjwgpUf2DqIuER1+h+mjlqFfF5+eN/wMYvu2fYBpv+RJ4TPEtkmgcEAL8Y2sDVUXHyzwg3IDqTLMvQQzEnJYEs+zV5S4yNc7nPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=eT4rm1BT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CS36Ks/5; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 404125C00DB;
	Fri,  9 Feb 2024 13:08:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 13:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502088;
	 x=1707588488; bh=5OEoS0A3LR4JS3bmwdfD5QA/dA50Ddny3vlr09nGCQg=; b=
	eT4rm1BTPv3BLErxkfkLnxD4ZrxuBopp4NP+MoLM9vtEdIsSGAERg4EFOJLpgvBT
	m3epCh5i0tpsWtLgmC1vtrA6oR1lqIbnvP9NPg0NE11xHqQQfYFByH1475g3bx73
	fwUot1PF1LF2SECHP5N/4FR0d5u3ibRzNXmmvWAUr04BY8107Z7kWgiz5dqHVXg7
	19YK/w6G8yBpLpOmZKbY7N7u3YJE4Rz91bvVOymKHCA9AoVO9K5Llt4hv8wmewyU
	pKaL4JRRsOKbxvrJlyyhpfQi2ZaMVNWqRUSxi3fFMURKmTAoW+U4uofzGbhcJcfL
	pzcCFPkp9jjOcjNpEdjHtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502088; x=
	1707588488; bh=5OEoS0A3LR4JS3bmwdfD5QA/dA50Ddny3vlr09nGCQg=; b=C
	S36Ks/5qOQSaM12xhStZsdROgYXcha6viUceQQsnyDlyh4i3iUkh9bk8KKOutohr
	Ja5Ne5WGPS7HhiGYpz0wC8BhSFUXoSD/bPBeDxpKjziAtPbcdHsYu48U7lKNXXQy
	h82KKtWflXXgp1VT8oJpTHCwCnV/3SD2rmWb7xhVmYVZhyWAQ9iKLvsnnVx2llzi
	X9s9KPTZqwGJgktAB7T5mFeSQlOwDx9KSH4B+5PkvJbrcMOiYvpSRq431XJ0GOsX
	6/7uMx7224JAzXPtHXlTPMWu4g4nSdoX6Gzjto5CORo71p1+971mNqaynnb57dhk
	/9y79ABaoRjI75DFJ2Zhg==
X-ME-Sender: <xms:CGrGZQmNQJ7CGDFb844HrwL8kC7PZ8uLbTRPPb4xbeeYu9dlalh-Jg>
    <xme:CGrGZf0-dHpCRo73Qbl172AXsRkbPnYkai1G2LBfyumSyzCC4lnQHw8FOeU0ISvrZ
    4P3Nif3AMSDKdBLo4k>
X-ME-Received: <xmr:CGrGZep3sgKw71ZX-xUA-YMNyNGd_qnrb_mWWKRKJuKqu_2ToEFBj58viNuXpfmT8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:CGrGZcm2VDqR8OzbXxsFjo5iRFWqCEZYaZinPI7zBOuvrGBnL1w7_g>
    <xmx:CGrGZe0t2v3iCNz3SgPw7tlhiTknqu5Jn9uUfCXGPSzKFgy6-sosyg>
    <xmx:CGrGZTsYi3h3Cbha35ONG7hGU4RSBwAX1X6sA02XAfyUj1Oe-qPYKA>
    <xmx:CGrGZRSDychSllF3Rpj0TrMEFRxUQJ_oaA0W5-t4-xtBaezelseKHg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:07 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:54 +0000
Subject: [PATCH 8/8] MIPS: pm-cps: Use GPR number macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-8-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=12857;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ogCOAZX2NXN9A243dzILDExre06o072M6R8BIadrlQY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX+//U+Xn3tytfnJN5tneIpz90wX4S2N/+d2QlWNe
 Z9F1YOEjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIUjdGhgsMJpfNjFyuaJpF
 f4g8c/K7ShDHo0X7Xp77Yf9x5QRm7kZGhrdXFe5WtPH6X/08rS7nrLT+/7C2rXxHJky3XVTztKD
 sKhMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Use GPR number macros in uasm code generation parts to
reduce code duplication.

There are functional change due to difference in register
symbolic names between OABI and NABI, while existing code
is only using definitions from OABI.

Code pieces are carefully inspected to ensure register
usages are safe on NABI as well.

We changed register allocation of r_pcohctl from T7 to T8
as T7 is not available on NABI and we just want a caller
saved scratch register here.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/pm-cps.c | 134 ++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 70 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 9bf60d7d44d3..d09ca77e624d 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -18,6 +18,7 @@
 #include <asm/mipsmtregs.h>
 #include <asm/pm.h>
 #include <asm/pm-cps.h>
+#include <asm/regdef.h>
 #include <asm/smp-cps.h>
 #include <asm/uasm.h>
 
@@ -69,13 +70,6 @@ DEFINE_PER_CPU_ALIGNED(struct mips_static_suspend_state, cps_cpu_state);
 static struct uasm_label labels[32];
 static struct uasm_reloc relocs[32];
 
-enum mips_reg {
-	zero, at, v0, v1, a0, a1, a2, a3,
-	t0, t1, t2, t3, t4, t5, t6, t7,
-	s0, s1, s2, s3, s4, s5, s6, s7,
-	t8, t9, k0, k1, gp, sp, fp, ra,
-};
-
 bool cps_pm_support_state(enum cps_pm_state state)
 {
 	return test_bit(state, state_support);
@@ -203,13 +197,13 @@ static void cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
 		return;
 
 	/* Load base address */
-	UASM_i_LA(pp, t0, (long)CKSEG0);
+	UASM_i_LA(pp, GPR_T0, (long)CKSEG0);
 
 	/* Calculate end address */
 	if (cache_size < 0x8000)
-		uasm_i_addiu(pp, t1, t0, cache_size);
+		uasm_i_addiu(pp, GPR_T1, GPR_T0, cache_size);
 	else
-		UASM_i_LA(pp, t1, (long)(CKSEG0 + cache_size));
+		UASM_i_LA(pp, GPR_T1, (long)(CKSEG0 + cache_size));
 
 	/* Start of cache op loop */
 	uasm_build_label(pl, *pp, lbl);
@@ -217,19 +211,19 @@ static void cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
 	/* Generate the cache ops */
 	for (i = 0; i < unroll_lines; i++) {
 		if (cpu_has_mips_r6) {
-			uasm_i_cache(pp, op, 0, t0);
-			uasm_i_addiu(pp, t0, t0, cache->linesz);
+			uasm_i_cache(pp, op, 0, GPR_T0);
+			uasm_i_addiu(pp, GPR_T0, GPR_T0, cache->linesz);
 		} else {
-			uasm_i_cache(pp, op, i * cache->linesz, t0);
+			uasm_i_cache(pp, op, i * cache->linesz, GPR_T0);
 		}
 	}
 
 	if (!cpu_has_mips_r6)
 		/* Update the base address */
-		uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
+		uasm_i_addiu(pp, GPR_T0, GPR_T0, unroll_lines * cache->linesz);
 
 	/* Loop if we haven't reached the end address yet */
-	uasm_il_bne(pp, pr, t0, t1, lbl);
+	uasm_il_bne(pp, pr, GPR_T0, GPR_T1, lbl);
 	uasm_i_nop(pp);
 }
 
@@ -275,25 +269,25 @@ static int cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 	 */
 
 	/* Preserve perf counter setup */
-	uasm_i_mfc0(pp, t2, 25, (perf_counter * 2) + 0); /* PerfCtlN */
-	uasm_i_mfc0(pp, t3, 25, (perf_counter * 2) + 1); /* PerfCntN */
+	uasm_i_mfc0(pp, GPR_T2, 25, (perf_counter * 2) + 0); /* PerfCtlN */
+	uasm_i_mfc0(pp, GPR_T3, 25, (perf_counter * 2) + 1); /* PerfCntN */
 
 	/* Setup perf counter to count FSB full pipeline stalls */
-	uasm_i_addiu(pp, t0, zero, (perf_event << 5) | 0xf);
-	uasm_i_mtc0(pp, t0, 25, (perf_counter * 2) + 0); /* PerfCtlN */
+	uasm_i_addiu(pp, GPR_T0, GPR_ZERO, (perf_event << 5) | 0xf);
+	uasm_i_mtc0(pp, GPR_T0, 25, (perf_counter * 2) + 0); /* PerfCtlN */
 	uasm_i_ehb(pp);
-	uasm_i_mtc0(pp, zero, 25, (perf_counter * 2) + 1); /* PerfCntN */
+	uasm_i_mtc0(pp, GPR_ZERO, 25, (perf_counter * 2) + 1); /* PerfCntN */
 	uasm_i_ehb(pp);
 
 	/* Base address for loads */
-	UASM_i_LA(pp, t0, (long)CKSEG0);
+	UASM_i_LA(pp, GPR_T0, (long)CKSEG0);
 
 	/* Start of clear loop */
 	uasm_build_label(pl, *pp, lbl);
 
 	/* Perform some loads to fill the FSB */
 	for (i = 0; i < num_loads; i++)
-		uasm_i_lw(pp, zero, i * line_size * line_stride, t0);
+		uasm_i_lw(pp, GPR_ZERO, i * line_size * line_stride, GPR_T0);
 
 	/*
 	 * Invalidate the new D-cache entries so that the cache will need
@@ -301,9 +295,9 @@ static int cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 	 */
 	for (i = 0; i < num_loads; i++) {
 		uasm_i_cache(pp, Hit_Invalidate_D,
-			     i * line_size * line_stride, t0);
+			     i * line_size * line_stride, GPR_T0);
 		uasm_i_cache(pp, Hit_Writeback_Inv_SD,
-			     i * line_size * line_stride, t0);
+			     i * line_size * line_stride, GPR_T0);
 	}
 
 	/* Barrier ensuring previous cache invalidates are complete */
@@ -311,16 +305,16 @@ static int cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 	uasm_i_ehb(pp);
 
 	/* Check whether the pipeline stalled due to the FSB being full */
-	uasm_i_mfc0(pp, t1, 25, (perf_counter * 2) + 1); /* PerfCntN */
+	uasm_i_mfc0(pp, GPR_T1, 25, (perf_counter * 2) + 1); /* PerfCntN */
 
 	/* Loop if it didn't */
-	uasm_il_beqz(pp, pr, t1, lbl);
+	uasm_il_beqz(pp, pr, GPR_T1, lbl);
 	uasm_i_nop(pp);
 
 	/* Restore perf counter 1. The count may well now be wrong... */
-	uasm_i_mtc0(pp, t2, 25, (perf_counter * 2) + 0); /* PerfCtlN */
+	uasm_i_mtc0(pp, GPR_T2, 25, (perf_counter * 2) + 0); /* PerfCtlN */
 	uasm_i_ehb(pp);
-	uasm_i_mtc0(pp, t3, 25, (perf_counter * 2) + 1); /* PerfCntN */
+	uasm_i_mtc0(pp, GPR_T3, 25, (perf_counter * 2) + 1); /* PerfCntN */
 	uasm_i_ehb(pp);
 
 	return 0;
@@ -330,12 +324,12 @@ static void cps_gen_set_top_bit(u32 **pp, struct uasm_label **pl,
 				struct uasm_reloc **pr,
 				unsigned r_addr, int lbl)
 {
-	uasm_i_lui(pp, t0, uasm_rel_hi(0x80000000));
+	uasm_i_lui(pp, GPR_T0, uasm_rel_hi(0x80000000));
 	uasm_build_label(pl, *pp, lbl);
-	uasm_i_ll(pp, t1, 0, r_addr);
-	uasm_i_or(pp, t1, t1, t0);
-	uasm_i_sc(pp, t1, 0, r_addr);
-	uasm_il_beqz(pp, pr, t1, lbl);
+	uasm_i_ll(pp, GPR_T1, 0, r_addr);
+	uasm_i_or(pp, GPR_T1, GPR_T1, GPR_T0);
+	uasm_i_sc(pp, GPR_T1, 0, r_addr);
+	uasm_il_beqz(pp, pr, GPR_T1, lbl);
 	uasm_i_nop(pp);
 }
 
@@ -344,9 +338,9 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 	u32 *buf, *p;
-	const unsigned r_online = a0;
-	const unsigned r_nc_count = a1;
-	const unsigned r_pcohctl = t7;
+	const unsigned r_online = GPR_A0;
+	const unsigned r_nc_count = GPR_A1;
+	const unsigned r_pcohctl = GPR_T8;
 	const unsigned max_instrs = 256;
 	unsigned cpc_cmd;
 	int err;
@@ -383,8 +377,8 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		 * with the return address placed in v0 to avoid clobbering
 		 * the ra register before it is saved.
 		 */
-		UASM_i_LA(&p, t0, (long)mips_cps_pm_save);
-		uasm_i_jalr(&p, v0, t0);
+		UASM_i_LA(&p, GPR_T0, (long)mips_cps_pm_save);
+		uasm_i_jalr(&p, GPR_V0, GPR_T0);
 		uasm_i_nop(&p);
 	}
 
@@ -399,11 +393,11 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		/* Increment ready_count */
 		uasm_i_sync(&p, __SYNC_mb);
 		uasm_build_label(&l, p, lbl_incready);
-		uasm_i_ll(&p, t1, 0, r_nc_count);
-		uasm_i_addiu(&p, t2, t1, 1);
-		uasm_i_sc(&p, t2, 0, r_nc_count);
-		uasm_il_beqz(&p, &r, t2, lbl_incready);
-		uasm_i_addiu(&p, t1, t1, 1);
+		uasm_i_ll(&p, GPR_T1, 0, r_nc_count);
+		uasm_i_addiu(&p, GPR_T2, GPR_T1, 1);
+		uasm_i_sc(&p, GPR_T2, 0, r_nc_count);
+		uasm_il_beqz(&p, &r, GPR_T2, lbl_incready);
+		uasm_i_addiu(&p, GPR_T1, GPR_T1, 1);
 
 		/* Barrier ensuring all CPUs see the updated r_nc_count value */
 		uasm_i_sync(&p, __SYNC_mb);
@@ -412,7 +406,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		 * If this is the last VPE to become ready for non-coherence
 		 * then it should branch below.
 		 */
-		uasm_il_beq(&p, &r, t1, r_online, lbl_disable_coherence);
+		uasm_il_beq(&p, &r, GPR_T1, r_online, lbl_disable_coherence);
 		uasm_i_nop(&p);
 
 		if (state < CPS_PM_POWER_GATED) {
@@ -422,13 +416,13 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 			 * has been disabled before proceeding, which it will do
 			 * by polling for the top bit of ready_count being set.
 			 */
-			uasm_i_addiu(&p, t1, zero, -1);
+			uasm_i_addiu(&p, GPR_T1, GPR_ZERO, -1);
 			uasm_build_label(&l, p, lbl_poll_cont);
-			uasm_i_lw(&p, t0, 0, r_nc_count);
-			uasm_il_bltz(&p, &r, t0, lbl_secondary_cont);
+			uasm_i_lw(&p, GPR_T0, 0, r_nc_count);
+			uasm_il_bltz(&p, &r, GPR_T0, lbl_secondary_cont);
 			uasm_i_ehb(&p);
 			if (cpu_has_mipsmt)
-				uasm_i_yield(&p, zero, t1);
+				uasm_i_yield(&p, GPR_ZERO, GPR_T1);
 			uasm_il_b(&p, &r, lbl_poll_cont);
 			uasm_i_nop(&p);
 		} else {
@@ -438,16 +432,16 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 			 */
 			if (cpu_has_mipsmt) {
 				/* Halt the VPE via C0 tchalt register */
-				uasm_i_addiu(&p, t0, zero, TCHALT_H);
-				uasm_i_mtc0(&p, t0, 2, 4);
+				uasm_i_addiu(&p, GPR_T0, GPR_ZERO, TCHALT_H);
+				uasm_i_mtc0(&p, GPR_T0, 2, 4);
 			} else if (cpu_has_vp) {
 				/* Halt the VP via the CPC VP_STOP register */
 				unsigned int vpe_id;
 
 				vpe_id = cpu_vpe_id(&cpu_data[cpu]);
-				uasm_i_addiu(&p, t0, zero, 1 << vpe_id);
-				UASM_i_LA(&p, t1, (long)addr_cpc_cl_vp_stop());
-				uasm_i_sw(&p, t0, 0, t1);
+				uasm_i_addiu(&p, GPR_T0, GPR_ZERO, 1 << vpe_id);
+				UASM_i_LA(&p, GPR_T1, (long)addr_cpc_cl_vp_stop());
+				uasm_i_sw(&p, GPR_T0, 0, GPR_T1);
 			} else {
 				BUG();
 			}
@@ -482,9 +476,9 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		* defined by the interAptiv & proAptiv SUMs as ensuring that the
 		*  operation resulting from the preceding store is complete.
 		*/
-		uasm_i_addiu(&p, t0, zero, 1 << cpu_core(&cpu_data[cpu]));
-		uasm_i_sw(&p, t0, 0, r_pcohctl);
-		uasm_i_lw(&p, t0, 0, r_pcohctl);
+		uasm_i_addiu(&p, GPR_T0, GPR_ZERO, 1 << cpu_core(&cpu_data[cpu]));
+		uasm_i_sw(&p, GPR_T0, 0, r_pcohctl);
+		uasm_i_lw(&p, GPR_T0, 0, r_pcohctl);
 
 		/* Barrier to ensure write to coherence control is complete */
 		uasm_i_sync(&p, __SYNC_full);
@@ -492,8 +486,8 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	}
 
 	/* Disable coherence */
-	uasm_i_sw(&p, zero, 0, r_pcohctl);
-	uasm_i_lw(&p, t0, 0, r_pcohctl);
+	uasm_i_sw(&p, GPR_ZERO, 0, r_pcohctl);
+	uasm_i_lw(&p, GPR_T0, 0, r_pcohctl);
 
 	if (state >= CPS_PM_CLOCK_GATED) {
 		err = cps_gen_flush_fsb(&p, &l, &r, &cpu_data[cpu],
@@ -515,9 +509,9 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		}
 
 		/* Issue the CPC command */
-		UASM_i_LA(&p, t0, (long)addr_cpc_cl_cmd());
-		uasm_i_addiu(&p, t1, zero, cpc_cmd);
-		uasm_i_sw(&p, t1, 0, t0);
+		UASM_i_LA(&p, GPR_T0, (long)addr_cpc_cl_cmd());
+		uasm_i_addiu(&p, GPR_T1, GPR_ZERO, cpc_cmd);
+		uasm_i_sw(&p, GPR_T1, 0, GPR_T0);
 
 		if (state == CPS_PM_POWER_GATED) {
 			/* If anything goes wrong just hang */
@@ -564,12 +558,12 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	 * will run this. The first will actually re-enable coherence & the
 	 * rest will just be performing a rather unusual nop.
 	 */
-	uasm_i_addiu(&p, t0, zero, mips_cm_revision() < CM_REV_CM3
+	uasm_i_addiu(&p, GPR_T0, GPR_ZERO, mips_cm_revision() < CM_REV_CM3
 				? CM_GCR_Cx_COHERENCE_COHDOMAINEN
 				: CM3_GCR_Cx_COHERENCE_COHEN);
 
-	uasm_i_sw(&p, t0, 0, r_pcohctl);
-	uasm_i_lw(&p, t0, 0, r_pcohctl);
+	uasm_i_sw(&p, GPR_T0, 0, r_pcohctl);
+	uasm_i_lw(&p, GPR_T0, 0, r_pcohctl);
 
 	/* Barrier to ensure write to coherence control is complete */
 	uasm_i_sync(&p, __SYNC_full);
@@ -579,11 +573,11 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		/* Decrement ready_count */
 		uasm_build_label(&l, p, lbl_decready);
 		uasm_i_sync(&p, __SYNC_mb);
-		uasm_i_ll(&p, t1, 0, r_nc_count);
-		uasm_i_addiu(&p, t2, t1, -1);
-		uasm_i_sc(&p, t2, 0, r_nc_count);
-		uasm_il_beqz(&p, &r, t2, lbl_decready);
-		uasm_i_andi(&p, v0, t1, (1 << fls(smp_num_siblings)) - 1);
+		uasm_i_ll(&p, GPR_T1, 0, r_nc_count);
+		uasm_i_addiu(&p, GPR_T2, GPR_T1, -1);
+		uasm_i_sc(&p, GPR_T2, 0, r_nc_count);
+		uasm_il_beqz(&p, &r, GPR_T2, lbl_decready);
+		uasm_i_andi(&p, GPR_V0, GPR_T1, (1 << fls(smp_num_siblings)) - 1);
 
 		/* Barrier ensuring all CPUs see the updated r_nc_count value */
 		uasm_i_sync(&p, __SYNC_mb);
@@ -612,7 +606,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	}
 
 	/* The core is coherent, time to return to C code */
-	uasm_i_jr(&p, ra);
+	uasm_i_jr(&p, GPR_RA);
 	uasm_i_nop(&p);
 
 gen_done:

-- 
2.43.0


