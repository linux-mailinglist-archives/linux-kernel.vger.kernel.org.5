Return-Path: <linux-kernel+bounces-59774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ADB84FB9F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4921F23EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6712838C;
	Fri,  9 Feb 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="dJtVXP3I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyQd+xvN"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3341272BB;
	Fri,  9 Feb 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502091; cv=none; b=htwYeVMI02mACs/jP2cMnKrf//lkfbCfcwuhZ9AOaU8VgGijK1GuzVKjIdWfhGOQwE+qn7cM66vxiy9o3AgeH4piFsg7e7Tdfo+41z+bhptO6oLbo4cJP4Qk9spVe4yn3s3P+/MPsBTEuoV1Dvexj3HpiL6GLJjkoeVrJuOzW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502091; c=relaxed/simple;
	bh=MaH8rb72siRqvxGQH5GM7y7eYI8vkxwQjIvIvcGPBp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=js46ak1dAXFfcpUhfNZM5Uxq5m14nGPERRBk0TTUZe7wVl/ZYdWqomXNJgPb/XIkXsHFdhl9MpWEav1RPQMor2G0E7EsYsekHeSQplw7drIBuiVTY0HdXOOs13fRfQjPfxWnuM1PHjjqApkZObV//iI0h//gKnWbcUGjOlcmLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=dJtVXP3I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyQd+xvN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1A017114008D;
	Fri,  9 Feb 2024 13:08:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 13:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502087;
	 x=1707588487; bh=+h28cftFDnEy+YGP5d1XKvTvZ9JGxznokSL/6sNf/hw=; b=
	dJtVXP3IDWDI0G9xfG3Y8xNghSqIbs7WSt5srX6cDUfvl1AkBqLe6PNtsIulU8Hm
	AR1GjaLda59CeoMHkDXbJWyi8EiHC7xHXFMToH32bM6cVPr5kv0F0xXjk1AHLQXN
	6VDPlNayBnHTFY07QwnQUom/66igf2OAARyHz9dCVVjav/nZ6JoR44cmkN1rWOu1
	eglTKt9P0vt3z3kyC+bTzbEsWxiC2aRWYwxZ8Ae4U2Zr7Ci0LBm9MAF26G0uY0yY
	7cKzNFW0wdBqbmjgmil3Opo6Be531hoFgQOSozelKT1d7/nhXFMZ2uLPUBxqIw74
	iNyYKt92S6/ykjjuJ7pBeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502087; x=
	1707588487; bh=+h28cftFDnEy+YGP5d1XKvTvZ9JGxznokSL/6sNf/hw=; b=D
	yQd+xvNABsD8+EYUKR6sR+U0hT/VMuHIpGdK2/DX7rtta1nJ8MHE/rTRfFPRjl1g
	vh9UdMlX7zblxyFBRMPc5XZg7kZqno1goKJavwHKZT4OBdFNxyAScOA8unOpCEWv
	kic5x3u+4fNYj1YvitdpBfEFmX4MTVglBQe3nCXuWpHZ4kwzSMNNf0FH2DGyHzyh
	DDC1OO40riLOsFtHtn3+rj2ZbnV5fPuXZiW3uafsIRRAPpzlU1aPKN/LMC62yLvC
	z1YdQ0tqV2jyyp0en+GxNgeGPVOF5qdzmy2acUgnJNhHRhnImErrOn3V5Bvl59ry
	SDz5yLHM8AEid0YO+YkIw==
X-ME-Sender: <xms:BmrGZdjHbq3Tn_y12fmdgHtOEduFzpiqhRcrnNKth80kpLRBorX49g>
    <xme:BmrGZSBDzTLlm_0sxnmvqnhShi7eqKDqjhnc3gsLcSCx7SKLCpbjTy3DAy7o3GzDO
    jiXrVWcuG1HHhQdk9U>
X-ME-Received: <xmr:BmrGZdGslKT0tBBD1pTq7bAlHS3frgkLSAbzGlmT7pfWpVnvV_QN3_inF_9d9y7YwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:BmrGZSTHIHqoQq46dKEI3S1DZ06_39ctUs5fOAREYTu63rTdw9DEzw>
    <xmx:BmrGZazmUnx1EUGzcsliGITsPfemt1vPTRZwaaqpP3mCjpDiakJFCg>
    <xmx:BmrGZY5bAbrVtvNfh4o1L3WI8hrpHTjATx6uF_EWBIVmquecEBBZgQ>
    <xmx:B2rGZRrPimvZHEbF78659Bdc3YaT8XNu2uV1KxUjvRlnp9ObyDd_9A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:06 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:53 +0000
Subject: [PATCH 7/8] MIPS: kvm/entry: Use GPR number macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-7-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=27907;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=MaH8rb72siRqvxGQH5GM7y7eYI8vkxwQjIvIvcGPBp0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX8/lN9xTWB2iU71/vZf9dtPyUXLTHeVTCy/Etp+7
 omATZl2RykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEykgJeRoXum88kqvT+y/lN+
 zcja/+PD1LPsunw/4iyeeeXoZWsEPWBkeKfFrcDx20usYU38mWfirTLXbhXIn7whGZiyPWNuTI8
 4PwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Use GPR number macros in uasm code generation parts to
reduce code duplication.

No functional change.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/entry.c | 404 +++++++++++++++++++++++---------------------------
 1 file changed, 187 insertions(+), 217 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 96f64a95f51b..ac8e074c6bb7 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -16,41 +16,11 @@
 #include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
 #include <asm/msa.h>
+#include <asm/regdef.h>
 #include <asm/setup.h>
 #include <asm/tlbex.h>
 #include <asm/uasm.h>
 
-/* Register names */
-#define ZERO		0
-#define AT		1
-#define V0		2
-#define V1		3
-#define A0		4
-#define A1		5
-
-#if _MIPS_SIM == _MIPS_SIM_ABI32
-#define T0		8
-#define T1		9
-#define T2		10
-#define T3		11
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
-
-#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
-#define T0		12
-#define T1		13
-#define T2		14
-#define T3		15
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
-
-#define S0		16
-#define S1		17
-#define T9		25
-#define K0		26
-#define K1		27
-#define GP		28
-#define SP		29
-#define RA		31
-
 #define CALLFRAME_SIZ   32
 
 static unsigned int scratch_vcpu[2] = { C0_DDATALO };
@@ -189,60 +159,60 @@ void *kvm_mips_build_vcpu_run(void *addr)
 	unsigned int i;
 
 	/*
-	 * A0: vcpu
+	 * GPR_A0: vcpu
 	 */
 
 	/* k0/k1 not being used in host kernel context */
-	UASM_i_ADDIU(&p, K1, SP, -(int)sizeof(struct pt_regs));
+	UASM_i_ADDIU(&p, GPR_K1, GPR_SP, -(int)sizeof(struct pt_regs));
 	for (i = 16; i < 32; ++i) {
 		if (i == 24)
 			i = 28;
-		UASM_i_SW(&p, i, offsetof(struct pt_regs, regs[i]), K1);
+		UASM_i_SW(&p, i, offsetof(struct pt_regs, regs[i]), GPR_K1);
 	}
 
 	/* Save host status */
-	uasm_i_mfc0(&p, V0, C0_STATUS);
-	UASM_i_SW(&p, V0, offsetof(struct pt_regs, cp0_status), K1);
+	uasm_i_mfc0(&p, GPR_V0, C0_STATUS);
+	UASM_i_SW(&p, GPR_V0, offsetof(struct pt_regs, cp0_status), GPR_K1);
 
 	/* Save scratch registers, will be used to store pointer to vcpu etc */
-	kvm_mips_build_save_scratch(&p, V1, K1);
+	kvm_mips_build_save_scratch(&p, GPR_V1, GPR_K1);
 
 	/* VCPU scratch register has pointer to vcpu */
-	UASM_i_MTC0(&p, A0, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MTC0(&p, GPR_A0, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Offset into vcpu->arch */
-	UASM_i_ADDIU(&p, K1, A0, offsetof(struct kvm_vcpu, arch));
+	UASM_i_ADDIU(&p, GPR_K1, GPR_A0, offsetof(struct kvm_vcpu, arch));
 
 	/*
 	 * Save the host stack to VCPU, used for exception processing
 	 * when we exit from the Guest
 	 */
-	UASM_i_SW(&p, SP, offsetof(struct kvm_vcpu_arch, host_stack), K1);
+	UASM_i_SW(&p, GPR_SP, offsetof(struct kvm_vcpu_arch, host_stack), GPR_K1);
 
 	/* Save the kernel gp as well */
-	UASM_i_SW(&p, GP, offsetof(struct kvm_vcpu_arch, host_gp), K1);
+	UASM_i_SW(&p, GPR_GP, offsetof(struct kvm_vcpu_arch, host_gp), GPR_K1);
 
 	/*
 	 * Setup status register for running the guest in UM, interrupts
 	 * are disabled
 	 */
-	UASM_i_LA(&p, K0, ST0_EXL | KSU_USER | ST0_BEV | ST0_KX_IF_64);
-	uasm_i_mtc0(&p, K0, C0_STATUS);
+	UASM_i_LA(&p, GPR_K0, ST0_EXL | KSU_USER | ST0_BEV | ST0_KX_IF_64);
+	uasm_i_mtc0(&p, GPR_K0, C0_STATUS);
 	uasm_i_ehb(&p);
 
 	/* load up the new EBASE */
-	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
-	build_set_exc_base(&p, K0);
+	UASM_i_LW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, guest_ebase), GPR_K1);
+	build_set_exc_base(&p, GPR_K0);
 
 	/*
 	 * Now that the new EBASE has been loaded, unset BEV, set
 	 * interrupt mask as it was but make sure that timer interrupts
 	 * are enabled
 	 */
-	uasm_i_addiu(&p, K0, ZERO, ST0_EXL | KSU_USER | ST0_IE | ST0_KX_IF_64);
-	uasm_i_andi(&p, V0, V0, ST0_IM);
-	uasm_i_or(&p, K0, K0, V0);
-	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_addiu(&p, GPR_K0, GPR_ZERO, ST0_EXL | KSU_USER | ST0_IE | ST0_KX_IF_64);
+	uasm_i_andi(&p, GPR_V0, GPR_V0, ST0_IM);
+	uasm_i_or(&p, GPR_K0, GPR_K0, GPR_V0);
+	uasm_i_mtc0(&p, GPR_K0, C0_STATUS);
 	uasm_i_ehb(&p);
 
 	p = kvm_mips_build_enter_guest(p);
@@ -273,15 +243,15 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	memset(relocs, 0, sizeof(relocs));
 
 	/* Set Guest EPC */
-	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, pc), K1);
-	UASM_i_MTC0(&p, T0, C0_EPC);
+	UASM_i_LW(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, pc), GPR_K1);
+	UASM_i_MTC0(&p, GPR_T0, C0_EPC);
 
 	/* Save normal linux process pgd (VZ guarantees pgd_reg is set) */
 	if (cpu_has_ldpte)
-		UASM_i_MFC0(&p, K0, C0_PWBASE);
+		UASM_i_MFC0(&p, GPR_K0, C0_PWBASE);
 	else
-		UASM_i_MFC0(&p, K0, c0_kscratch(), pgd_reg);
-	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_pgd), K1);
+		UASM_i_MFC0(&p, GPR_K0, c0_kscratch(), pgd_reg);
+	UASM_i_SW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, host_pgd), GPR_K1);
 
 	/*
 	 * Set up KVM GPA pgd.
@@ -289,24 +259,24 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	 * - call tlbmiss_handler_setup_pgd(mm->pgd)
 	 * - write mm->pgd into CP0_PWBase
 	 *
-	 * We keep S0 pointing at struct kvm so we can load the ASID below.
+	 * We keep GPR_S0 pointing at struct kvm so we can load the ASID below.
 	 */
-	UASM_i_LW(&p, S0, (int)offsetof(struct kvm_vcpu, kvm) -
-			  (int)offsetof(struct kvm_vcpu, arch), K1);
-	UASM_i_LW(&p, A0, offsetof(struct kvm, arch.gpa_mm.pgd), S0);
-	UASM_i_LA(&p, T9, (unsigned long)tlbmiss_handler_setup_pgd);
-	uasm_i_jalr(&p, RA, T9);
+	UASM_i_LW(&p, GPR_S0, (int)offsetof(struct kvm_vcpu, kvm) -
+			  (int)offsetof(struct kvm_vcpu, arch), GPR_K1);
+	UASM_i_LW(&p, GPR_A0, offsetof(struct kvm, arch.gpa_mm.pgd), GPR_S0);
+	UASM_i_LA(&p, GPR_T9, (unsigned long)tlbmiss_handler_setup_pgd);
+	uasm_i_jalr(&p, GPR_RA, GPR_T9);
 	/* delay slot */
 	if (cpu_has_htw)
-		UASM_i_MTC0(&p, A0, C0_PWBASE);
+		UASM_i_MTC0(&p, GPR_A0, C0_PWBASE);
 	else
 		uasm_i_nop(&p);
 
 	/* Set GM bit to setup eret to VZ guest context */
-	uasm_i_addiu(&p, V1, ZERO, 1);
-	uasm_i_mfc0(&p, K0, C0_GUESTCTL0);
-	uasm_i_ins(&p, K0, V1, MIPS_GCTL0_GM_SHIFT, 1);
-	uasm_i_mtc0(&p, K0, C0_GUESTCTL0);
+	uasm_i_addiu(&p, GPR_V1, GPR_ZERO, 1);
+	uasm_i_mfc0(&p, GPR_K0, C0_GUESTCTL0);
+	uasm_i_ins(&p, GPR_K0, GPR_V1, MIPS_GCTL0_GM_SHIFT, 1);
+	uasm_i_mtc0(&p, GPR_K0, C0_GUESTCTL0);
 
 	if (cpu_has_guestid) {
 		/*
@@ -315,13 +285,13 @@ static void *kvm_mips_build_enter_guest(void *addr)
 		 */
 
 		/* Get current GuestID */
-		uasm_i_mfc0(&p, T0, C0_GUESTCTL1);
+		uasm_i_mfc0(&p, GPR_T0, C0_GUESTCTL1);
 		/* Set GuestCtl1.RID = GuestCtl1.ID */
-		uasm_i_ext(&p, T1, T0, MIPS_GCTL1_ID_SHIFT,
+		uasm_i_ext(&p, GPR_T1, GPR_T0, MIPS_GCTL1_ID_SHIFT,
 			   MIPS_GCTL1_ID_WIDTH);
-		uasm_i_ins(&p, T0, T1, MIPS_GCTL1_RID_SHIFT,
+		uasm_i_ins(&p, GPR_T0, GPR_T1, MIPS_GCTL1_RID_SHIFT,
 			   MIPS_GCTL1_RID_WIDTH);
-		uasm_i_mtc0(&p, T0, C0_GUESTCTL1);
+		uasm_i_mtc0(&p, GPR_T0, C0_GUESTCTL1);
 
 		/* GuestID handles dealiasing so we don't need to touch ASID */
 		goto skip_asid_restore;
@@ -330,65 +300,65 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	/* Root ASID Dealias (RAD) */
 
 	/* Save host ASID */
-	UASM_i_MFC0(&p, K0, C0_ENTRYHI);
-	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_entryhi),
-		  K1);
+	UASM_i_MFC0(&p, GPR_K0, C0_ENTRYHI);
+	UASM_i_SW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, host_entryhi),
+		  GPR_K1);
 
 	/* Set the root ASID for the Guest */
-	UASM_i_ADDIU(&p, T1, S0,
+	UASM_i_ADDIU(&p, GPR_T1, GPR_S0,
 		     offsetof(struct kvm, arch.gpa_mm.context.asid));
 
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	/* smp_processor_id */
-	uasm_i_lw(&p, T2, offsetof(struct thread_info, cpu), GP);
+	uasm_i_lw(&p, GPR_T2, offsetof(struct thread_info, cpu), GPR_GP);
 	/* index the ASID array */
-	uasm_i_sll(&p, T2, T2, ilog2(sizeof(long)));
-	UASM_i_ADDU(&p, T3, T1, T2);
-	UASM_i_LW(&p, K0, 0, T3);
+	uasm_i_sll(&p, GPR_T2, GPR_T2, ilog2(sizeof(long)));
+	UASM_i_ADDU(&p, GPR_T3, GPR_T1, GPR_T2);
+	UASM_i_LW(&p, GPR_K0, 0, GPR_T3);
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
 	/*
 	 * reuse ASID array offset
 	 * cpuinfo_mips is a multiple of sizeof(long)
 	 */
-	uasm_i_addiu(&p, T3, ZERO, sizeof(struct cpuinfo_mips)/sizeof(long));
-	uasm_i_mul(&p, T2, T2, T3);
+	uasm_i_addiu(&p, GPR_T3, GPR_ZERO, sizeof(struct cpuinfo_mips)/sizeof(long));
+	uasm_i_mul(&p, GPR_T2, GPR_T2, GPR_T3);
 
-	UASM_i_LA_mostly(&p, AT, (long)&cpu_data[0].asid_mask);
-	UASM_i_ADDU(&p, AT, AT, T2);
-	UASM_i_LW(&p, T2, uasm_rel_lo((long)&cpu_data[0].asid_mask), AT);
-	uasm_i_and(&p, K0, K0, T2);
+	UASM_i_LA_mostly(&p, GPR_AT, (long)&cpu_data[0].asid_mask);
+	UASM_i_ADDU(&p, GPR_AT, GPR_AT, GPR_T2);
+	UASM_i_LW(&p, GPR_T2, uasm_rel_lo((long)&cpu_data[0].asid_mask), GPR_AT);
+	uasm_i_and(&p, GPR_K0, GPR_K0, GPR_T2);
 #else
-	uasm_i_andi(&p, K0, K0, MIPS_ENTRYHI_ASID);
+	uasm_i_andi(&p, GPR_K0, GPR_K0, MIPS_ENTRYHI_ASID);
 #endif
 
 	/* Set up KVM VZ root ASID (!guestid) */
-	uasm_i_mtc0(&p, K0, C0_ENTRYHI);
+	uasm_i_mtc0(&p, GPR_K0, C0_ENTRYHI);
 skip_asid_restore:
 	uasm_i_ehb(&p);
 
 	/* Disable RDHWR access */
-	uasm_i_mtc0(&p, ZERO, C0_HWRENA);
+	uasm_i_mtc0(&p, GPR_ZERO, C0_HWRENA);
 
 	/* load the guest context from VCPU and return */
 	for (i = 1; i < 32; ++i) {
 		/* Guest k0/k1 loaded later */
-		if (i == K0 || i == K1)
+		if (i == GPR_K0 || i == GPR_K1)
 			continue;
-		UASM_i_LW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), K1);
+		UASM_i_LW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), GPR_K1);
 	}
 
 #ifndef CONFIG_CPU_MIPSR6
 	/* Restore hi/lo */
-	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, hi), K1);
-	uasm_i_mthi(&p, K0);
+	UASM_i_LW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, hi), GPR_K1);
+	uasm_i_mthi(&p, GPR_K0);
 
-	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, lo), K1);
-	uasm_i_mtlo(&p, K0);
+	UASM_i_LW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, lo), GPR_K1);
+	uasm_i_mtlo(&p, GPR_K0);
 #endif
 
 	/* Restore the guest's k0/k1 registers */
-	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
-	UASM_i_LW(&p, K1, offsetof(struct kvm_vcpu_arch, gprs[K1]), K1);
+	UASM_i_LW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, gprs[GPR_K0]), GPR_K1);
+	UASM_i_LW(&p, GPR_K1, offsetof(struct kvm_vcpu_arch, gprs[GPR_K1]), GPR_K1);
 
 	/* Jump to guest */
 	uasm_i_eret(&p);
@@ -421,13 +391,13 @@ void *kvm_mips_build_tlb_refill_exception(void *addr, void *handler)
 	memset(relocs, 0, sizeof(relocs));
 
 	/* Save guest k1 into scratch register */
-	UASM_i_MTC0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
+	UASM_i_MTC0(&p, GPR_K1, scratch_tmp[0], scratch_tmp[1]);
 
 	/* Get the VCPU pointer from the VCPU scratch register */
-	UASM_i_MFC0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MFC0(&p, GPR_K1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Save guest k0 into VCPU structure */
-	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu, arch.gprs[K0]), K1);
+	UASM_i_SW(&p, GPR_K0, offsetof(struct kvm_vcpu, arch.gprs[GPR_K0]), GPR_K1);
 
 	/*
 	 * Some of the common tlbex code uses current_cpu_type(). For KVM we
@@ -436,13 +406,13 @@ void *kvm_mips_build_tlb_refill_exception(void *addr, void *handler)
 	preempt_disable();
 
 #ifdef CONFIG_CPU_LOONGSON64
-	UASM_i_MFC0(&p, K1, C0_PGD);
-	uasm_i_lddir(&p, K0, K1, 3);  /* global page dir */
+	UASM_i_MFC0(&p, GPR_K1, C0_PGD);
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
 #else
 	/*
@@ -457,27 +427,27 @@ void *kvm_mips_build_tlb_refill_exception(void *addr, void *handler)
 	 */
 
 #ifdef CONFIG_64BIT
-	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
+	build_get_pmde64(&p, &l, &r, GPR_K0, GPR_K1); /* get pmd in GPR_K1 */
 #else
-	build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
+	build_get_pgde32(&p, GPR_K0, GPR_K1); /* get pgd in GPR_K1 */
 #endif
 
 	/* we don't support huge pages yet */
 
-	build_get_ptep(&p, K0, K1);
-	build_update_entries(&p, K0, K1);
+	build_get_ptep(&p, GPR_K0, GPR_K1);
+	build_update_entries(&p, GPR_K0, GPR_K1);
 	build_tlb_write_entry(&p, &l, &r, tlb_random);
 #endif
 
 	preempt_enable();
 
 	/* Get the VCPU pointer from the VCPU scratch register again */
-	UASM_i_MFC0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MFC0(&p, GPR_K1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Restore the guest's k0/k1 registers */
-	UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu, arch.gprs[K0]), K1);
+	UASM_i_LW(&p, GPR_K0, offsetof(struct kvm_vcpu, arch.gprs[GPR_K0]), GPR_K1);
 	uasm_i_ehb(&p);
-	UASM_i_MFC0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
+	UASM_i_MFC0(&p, GPR_K1, scratch_tmp[0], scratch_tmp[1]);
 
 	/* Jump to guest */
 	uasm_i_eret(&p);
@@ -507,14 +477,14 @@ void *kvm_mips_build_exception(void *addr, void *handler)
 	memset(relocs, 0, sizeof(relocs));
 
 	/* Save guest k1 into scratch register */
-	UASM_i_MTC0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
+	UASM_i_MTC0(&p, GPR_K1, scratch_tmp[0], scratch_tmp[1]);
 
 	/* Get the VCPU pointer from the VCPU scratch register */
-	UASM_i_MFC0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
-	UASM_i_ADDIU(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
+	UASM_i_MFC0(&p, GPR_K1, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_ADDIU(&p, GPR_K1, GPR_K1, offsetof(struct kvm_vcpu, arch));
 
 	/* Save guest k0 into VCPU structure */
-	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
+	UASM_i_SW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, gprs[GPR_K0]), GPR_K1);
 
 	/* Branch to the common handler */
 	uasm_il_b(&p, &r, label_exit_common);
@@ -562,85 +532,85 @@ void *kvm_mips_build_exit(void *addr)
 	/* Start saving Guest context to VCPU */
 	for (i = 0; i < 32; ++i) {
 		/* Guest k0/k1 saved later */
-		if (i == K0 || i == K1)
+		if (i == GPR_K0 || i == GPR_K1)
 			continue;
-		UASM_i_SW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), K1);
+		UASM_i_SW(&p, i, offsetof(struct kvm_vcpu_arch, gprs[i]), GPR_K1);
 	}
 
 #ifndef CONFIG_CPU_MIPSR6
 	/* We need to save hi/lo and restore them on the way out */
-	uasm_i_mfhi(&p, T0);
-	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, hi), K1);
+	uasm_i_mfhi(&p, GPR_T0);
+	UASM_i_SW(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, hi), GPR_K1);
 
-	uasm_i_mflo(&p, T0);
-	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, lo), K1);
+	uasm_i_mflo(&p, GPR_T0);
+	UASM_i_SW(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, lo), GPR_K1);
 #endif
 
 	/* Finally save guest k1 to VCPU */
 	uasm_i_ehb(&p);
-	UASM_i_MFC0(&p, T0, scratch_tmp[0], scratch_tmp[1]);
-	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K1]), K1);
+	UASM_i_MFC0(&p, GPR_T0, scratch_tmp[0], scratch_tmp[1]);
+	UASM_i_SW(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, gprs[GPR_K1]), GPR_K1);
 
 	/* Now that context has been saved, we can use other registers */
 
 	/* Restore vcpu */
-	UASM_i_MFC0(&p, S0, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MFC0(&p, GPR_S0, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/*
 	 * Save Host level EPC, BadVaddr and Cause to VCPU, useful to process
 	 * the exception
 	 */
-	UASM_i_MFC0(&p, K0, C0_EPC);
-	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, pc), K1);
+	UASM_i_MFC0(&p, GPR_K0, C0_EPC);
+	UASM_i_SW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, pc), GPR_K1);
 
-	UASM_i_MFC0(&p, K0, C0_BADVADDR);
-	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_cp0_badvaddr),
-		  K1);
+	UASM_i_MFC0(&p, GPR_K0, C0_BADVADDR);
+	UASM_i_SW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, host_cp0_badvaddr),
+		  GPR_K1);
 
-	uasm_i_mfc0(&p, K0, C0_CAUSE);
-	uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch, host_cp0_cause), K1);
+	uasm_i_mfc0(&p, GPR_K0, C0_CAUSE);
+	uasm_i_sw(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, host_cp0_cause), GPR_K1);
 
 	if (cpu_has_badinstr) {
-		uasm_i_mfc0(&p, K0, C0_BADINSTR);
-		uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch,
-					   host_cp0_badinstr), K1);
+		uasm_i_mfc0(&p, GPR_K0, C0_BADINSTR);
+		uasm_i_sw(&p, GPR_K0, offsetof(struct kvm_vcpu_arch,
+					   host_cp0_badinstr), GPR_K1);
 	}
 
 	if (cpu_has_badinstrp) {
-		uasm_i_mfc0(&p, K0, C0_BADINSTRP);
-		uasm_i_sw(&p, K0, offsetof(struct kvm_vcpu_arch,
-					   host_cp0_badinstrp), K1);
+		uasm_i_mfc0(&p, GPR_K0, C0_BADINSTRP);
+		uasm_i_sw(&p, GPR_K0, offsetof(struct kvm_vcpu_arch,
+					   host_cp0_badinstrp), GPR_K1);
 	}
 
 	/* Now restore the host state just enough to run the handlers */
 
 	/* Switch EBASE to the one used by Linux */
 	/* load up the host EBASE */
-	uasm_i_mfc0(&p, V0, C0_STATUS);
+	uasm_i_mfc0(&p, GPR_V0, C0_STATUS);
 
-	uasm_i_lui(&p, AT, ST0_BEV >> 16);
-	uasm_i_or(&p, K0, V0, AT);
+	uasm_i_lui(&p, GPR_AT, ST0_BEV >> 16);
+	uasm_i_or(&p, GPR_K0, GPR_V0, GPR_AT);
 
-	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_mtc0(&p, GPR_K0, C0_STATUS);
 	uasm_i_ehb(&p);
 
-	UASM_i_LA_mostly(&p, K0, (long)&ebase);
-	UASM_i_LW(&p, K0, uasm_rel_lo((long)&ebase), K0);
-	build_set_exc_base(&p, K0);
+	UASM_i_LA_mostly(&p, GPR_K0, (long)&ebase);
+	UASM_i_LW(&p, GPR_K0, uasm_rel_lo((long)&ebase), GPR_K0);
+	build_set_exc_base(&p, GPR_K0);
 
 	if (raw_cpu_has_fpu) {
 		/*
 		 * If FPU is enabled, save FCR31 and clear it so that later
 		 * ctc1's don't trigger FPE for pending exceptions.
 		 */
-		uasm_i_lui(&p, AT, ST0_CU1 >> 16);
-		uasm_i_and(&p, V1, V0, AT);
-		uasm_il_beqz(&p, &r, V1, label_fpu_1);
+		uasm_i_lui(&p, GPR_AT, ST0_CU1 >> 16);
+		uasm_i_and(&p, GPR_V1, GPR_V0, GPR_AT);
+		uasm_il_beqz(&p, &r, GPR_V1, label_fpu_1);
 		 uasm_i_nop(&p);
-		uasm_i_cfc1(&p, T0, 31);
-		uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.fcr31),
-			  K1);
-		uasm_i_ctc1(&p, ZERO, 31);
+		uasm_i_cfc1(&p, GPR_T0, 31);
+		uasm_i_sw(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, fpu.fcr31),
+			  GPR_K1);
+		uasm_i_ctc1(&p, GPR_ZERO, 31);
 		uasm_l_fpu_1(&l, p);
 	}
 
@@ -649,22 +619,22 @@ void *kvm_mips_build_exit(void *addr)
 		 * If MSA is enabled, save MSACSR and clear it so that later
 		 * instructions don't trigger MSAFPE for pending exceptions.
 		 */
-		uasm_i_mfc0(&p, T0, C0_CONFIG5);
-		uasm_i_ext(&p, T0, T0, 27, 1); /* MIPS_CONF5_MSAEN */
-		uasm_il_beqz(&p, &r, T0, label_msa_1);
+		uasm_i_mfc0(&p, GPR_T0, C0_CONFIG5);
+		uasm_i_ext(&p, GPR_T0, GPR_T0, 27, 1); /* MIPS_CONF5_MSAEN */
+		uasm_il_beqz(&p, &r, GPR_T0, label_msa_1);
 		 uasm_i_nop(&p);
-		uasm_i_cfcmsa(&p, T0, MSA_CSR);
-		uasm_i_sw(&p, T0, offsetof(struct kvm_vcpu_arch, fpu.msacsr),
-			  K1);
-		uasm_i_ctcmsa(&p, MSA_CSR, ZERO);
+		uasm_i_cfcmsa(&p, GPR_T0, MSA_CSR);
+		uasm_i_sw(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, fpu.msacsr),
+			  GPR_K1);
+		uasm_i_ctcmsa(&p, MSA_CSR, GPR_ZERO);
 		uasm_l_msa_1(&l, p);
 	}
 
 	/* Restore host ASID */
 	if (!cpu_has_guestid) {
-		UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, host_entryhi),
-			  K1);
-		UASM_i_MTC0(&p, K0, C0_ENTRYHI);
+		UASM_i_LW(&p, GPR_K0, offsetof(struct kvm_vcpu_arch, host_entryhi),
+			  GPR_K1);
+		UASM_i_MTC0(&p, GPR_K0, C0_ENTRYHI);
 	}
 
 	/*
@@ -673,56 +643,56 @@ void *kvm_mips_build_exit(void *addr)
 	 * - call tlbmiss_handler_setup_pgd(mm->pgd)
 	 * - write mm->pgd into CP0_PWBase
 	 */
-	UASM_i_LW(&p, A0,
-		  offsetof(struct kvm_vcpu_arch, host_pgd), K1);
-	UASM_i_LA(&p, T9, (unsigned long)tlbmiss_handler_setup_pgd);
-	uasm_i_jalr(&p, RA, T9);
+	UASM_i_LW(&p, GPR_A0,
+		  offsetof(struct kvm_vcpu_arch, host_pgd), GPR_K1);
+	UASM_i_LA(&p, GPR_T9, (unsigned long)tlbmiss_handler_setup_pgd);
+	uasm_i_jalr(&p, GPR_RA, GPR_T9);
 	/* delay slot */
 	if (cpu_has_htw)
-		UASM_i_MTC0(&p, A0, C0_PWBASE);
+		UASM_i_MTC0(&p, GPR_A0, C0_PWBASE);
 	else
 		uasm_i_nop(&p);
 
 	/* Clear GM bit so we don't enter guest mode when EXL is cleared */
-	uasm_i_mfc0(&p, K0, C0_GUESTCTL0);
-	uasm_i_ins(&p, K0, ZERO, MIPS_GCTL0_GM_SHIFT, 1);
-	uasm_i_mtc0(&p, K0, C0_GUESTCTL0);
+	uasm_i_mfc0(&p, GPR_K0, C0_GUESTCTL0);
+	uasm_i_ins(&p, GPR_K0, GPR_ZERO, MIPS_GCTL0_GM_SHIFT, 1);
+	uasm_i_mtc0(&p, GPR_K0, C0_GUESTCTL0);
 
 	/* Save GuestCtl0 so we can access GExcCode after CPU migration */
-	uasm_i_sw(&p, K0,
-		  offsetof(struct kvm_vcpu_arch, host_cp0_guestctl0), K1);
+	uasm_i_sw(&p, GPR_K0,
+		  offsetof(struct kvm_vcpu_arch, host_cp0_guestctl0), GPR_K1);
 
 	if (cpu_has_guestid) {
 		/*
 		 * Clear root mode GuestID, so that root TLB operations use the
 		 * root GuestID in the root TLB.
 		 */
-		uasm_i_mfc0(&p, T0, C0_GUESTCTL1);
+		uasm_i_mfc0(&p, GPR_T0, C0_GUESTCTL1);
 		/* Set GuestCtl1.RID = MIPS_GCTL1_ROOT_GUESTID (i.e. 0) */
-		uasm_i_ins(&p, T0, ZERO, MIPS_GCTL1_RID_SHIFT,
+		uasm_i_ins(&p, GPR_T0, GPR_ZERO, MIPS_GCTL1_RID_SHIFT,
 			   MIPS_GCTL1_RID_WIDTH);
-		uasm_i_mtc0(&p, T0, C0_GUESTCTL1);
+		uasm_i_mtc0(&p, GPR_T0, C0_GUESTCTL1);
 	}
 
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
-	uasm_i_addiu(&p, AT, ZERO, ~(ST0_EXL | KSU_USER | ST0_IE));
-	uasm_i_and(&p, V0, V0, AT);
-	uasm_i_lui(&p, AT, ST0_CU0 >> 16);
-	uasm_i_or(&p, V0, V0, AT);
+	uasm_i_addiu(&p, GPR_AT, GPR_ZERO, ~(ST0_EXL | KSU_USER | ST0_IE));
+	uasm_i_and(&p, GPR_V0, GPR_V0, GPR_AT);
+	uasm_i_lui(&p, GPR_AT, ST0_CU0 >> 16);
+	uasm_i_or(&p, GPR_V0, GPR_V0, GPR_AT);
 #ifdef CONFIG_64BIT
-	uasm_i_ori(&p, V0, V0, ST0_SX | ST0_UX);
+	uasm_i_ori(&p, GPR_V0, GPR_V0, ST0_SX | ST0_UX);
 #endif
-	uasm_i_mtc0(&p, V0, C0_STATUS);
+	uasm_i_mtc0(&p, GPR_V0, C0_STATUS);
 	uasm_i_ehb(&p);
 
-	/* Load up host GP */
-	UASM_i_LW(&p, GP, offsetof(struct kvm_vcpu_arch, host_gp), K1);
+	/* Load up host GPR_GP */
+	UASM_i_LW(&p, GPR_GP, offsetof(struct kvm_vcpu_arch, host_gp), GPR_K1);
 
 	/* Need a stack before we can jump to "C" */
-	UASM_i_LW(&p, SP, offsetof(struct kvm_vcpu_arch, host_stack), K1);
+	UASM_i_LW(&p, GPR_SP, offsetof(struct kvm_vcpu_arch, host_stack), GPR_K1);
 
 	/* Saved host state */
-	UASM_i_ADDIU(&p, SP, SP, -(int)sizeof(struct pt_regs));
+	UASM_i_ADDIU(&p, GPR_SP, GPR_SP, -(int)sizeof(struct pt_regs));
 
 	/*
 	 * XXXKYMA do we need to load the host ASID, maybe not because the
@@ -730,12 +700,12 @@ void *kvm_mips_build_exit(void *addr)
 	 */
 
 	/* Restore host scratch registers, as we'll have clobbered them */
-	kvm_mips_build_restore_scratch(&p, K0, SP);
+	kvm_mips_build_restore_scratch(&p, GPR_K0, GPR_SP);
 
 	/* Restore RDHWR access */
-	UASM_i_LA_mostly(&p, K0, (long)&hwrena);
-	uasm_i_lw(&p, K0, uasm_rel_lo((long)&hwrena), K0);
-	uasm_i_mtc0(&p, K0, C0_HWRENA);
+	UASM_i_LA_mostly(&p, GPR_K0, (long)&hwrena);
+	uasm_i_lw(&p, GPR_K0, uasm_rel_lo((long)&hwrena), GPR_K0);
+	uasm_i_mtc0(&p, GPR_K0, C0_HWRENA);
 
 	/* Jump to handler */
 	/*
@@ -743,10 +713,10 @@ void *kvm_mips_build_exit(void *addr)
 	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
 	 * with this in the kernel
 	 */
-	uasm_i_move(&p, A0, S0);
-	UASM_i_LA(&p, T9, (unsigned long)kvm_mips_handle_exit);
-	uasm_i_jalr(&p, RA, T9);
-	 UASM_i_ADDIU(&p, SP, SP, -CALLFRAME_SIZ);
+	uasm_i_move(&p, GPR_A0, GPR_S0);
+	UASM_i_LA(&p, GPR_T9, (unsigned long)kvm_mips_handle_exit);
+	uasm_i_jalr(&p, GPR_RA, GPR_T9);
+	 UASM_i_ADDIU(&p, GPR_SP, GPR_SP, -CALLFRAME_SIZ);
 
 	uasm_resolve_relocs(relocs, labels);
 
@@ -776,7 +746,7 @@ static void *kvm_mips_build_ret_from_exit(void *addr)
 	memset(relocs, 0, sizeof(relocs));
 
 	/* Return from handler Make sure interrupts are disabled */
-	uasm_i_di(&p, ZERO);
+	uasm_i_di(&p, GPR_ZERO);
 	uasm_i_ehb(&p);
 
 	/*
@@ -785,15 +755,15 @@ static void *kvm_mips_build_ret_from_exit(void *addr)
 	 * guest, reload k1
 	 */
 
-	uasm_i_move(&p, K1, S0);
-	UASM_i_ADDIU(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
+	uasm_i_move(&p, GPR_K1, GPR_S0);
+	UASM_i_ADDIU(&p, GPR_K1, GPR_K1, offsetof(struct kvm_vcpu, arch));
 
 	/*
 	 * Check return value, should tell us if we are returning to the
 	 * host (handle I/O etc)or resuming the guest
 	 */
-	uasm_i_andi(&p, T0, V0, RESUME_HOST);
-	uasm_il_bnez(&p, &r, T0, label_return_to_host);
+	uasm_i_andi(&p, GPR_T0, GPR_V0, RESUME_HOST);
+	uasm_il_bnez(&p, &r, GPR_T0, label_return_to_host);
 	 uasm_i_nop(&p);
 
 	p = kvm_mips_build_ret_to_guest(p);
@@ -820,24 +790,24 @@ static void *kvm_mips_build_ret_to_guest(void *addr)
 	u32 *p = addr;
 
 	/* Put the saved pointer to vcpu (s0) back into the scratch register */
-	UASM_i_MTC0(&p, S0, scratch_vcpu[0], scratch_vcpu[1]);
+	UASM_i_MTC0(&p, GPR_S0, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Load up the Guest EBASE to minimize the window where BEV is set */
-	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, guest_ebase), K1);
+	UASM_i_LW(&p, GPR_T0, offsetof(struct kvm_vcpu_arch, guest_ebase), GPR_K1);
 
 	/* Switch EBASE back to the one used by KVM */
-	uasm_i_mfc0(&p, V1, C0_STATUS);
-	uasm_i_lui(&p, AT, ST0_BEV >> 16);
-	uasm_i_or(&p, K0, V1, AT);
-	uasm_i_mtc0(&p, K0, C0_STATUS);
+	uasm_i_mfc0(&p, GPR_V1, C0_STATUS);
+	uasm_i_lui(&p, GPR_AT, ST0_BEV >> 16);
+	uasm_i_or(&p, GPR_K0, GPR_V1, GPR_AT);
+	uasm_i_mtc0(&p, GPR_K0, C0_STATUS);
 	uasm_i_ehb(&p);
-	build_set_exc_base(&p, T0);
+	build_set_exc_base(&p, GPR_T0);
 
 	/* Setup status register for running guest in UM */
-	uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
-	UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX | ST0_SX | ST0_UX));
-	uasm_i_and(&p, V1, V1, AT);
-	uasm_i_mtc0(&p, V1, C0_STATUS);
+	uasm_i_ori(&p, GPR_V1, GPR_V1, ST0_EXL | KSU_USER | ST0_IE);
+	UASM_i_LA(&p, GPR_AT, ~(ST0_CU0 | ST0_MX | ST0_SX | ST0_UX));
+	uasm_i_and(&p, GPR_V1, GPR_V1, GPR_AT);
+	uasm_i_mtc0(&p, GPR_V1, C0_STATUS);
 	uasm_i_ehb(&p);
 
 	p = kvm_mips_build_enter_guest(p);
@@ -861,31 +831,31 @@ static void *kvm_mips_build_ret_to_host(void *addr)
 	unsigned int i;
 
 	/* EBASE is already pointing to Linux */
-	UASM_i_LW(&p, K1, offsetof(struct kvm_vcpu_arch, host_stack), K1);
-	UASM_i_ADDIU(&p, K1, K1, -(int)sizeof(struct pt_regs));
+	UASM_i_LW(&p, GPR_K1, offsetof(struct kvm_vcpu_arch, host_stack), GPR_K1);
+	UASM_i_ADDIU(&p, GPR_K1, GPR_K1, -(int)sizeof(struct pt_regs));
 
 	/*
 	 * r2/v0 is the return code, shift it down by 2 (arithmetic)
 	 * to recover the err code
 	 */
-	uasm_i_sra(&p, K0, V0, 2);
-	uasm_i_move(&p, V0, K0);
+	uasm_i_sra(&p, GPR_K0, GPR_V0, 2);
+	uasm_i_move(&p, GPR_V0, GPR_K0);
 
 	/* Load context saved on the host stack */
 	for (i = 16; i < 31; ++i) {
 		if (i == 24)
 			i = 28;
-		UASM_i_LW(&p, i, offsetof(struct pt_regs, regs[i]), K1);
+		UASM_i_LW(&p, i, offsetof(struct pt_regs, regs[i]), GPR_K1);
 	}
 
 	/* Restore RDHWR access */
-	UASM_i_LA_mostly(&p, K0, (long)&hwrena);
-	uasm_i_lw(&p, K0, uasm_rel_lo((long)&hwrena), K0);
-	uasm_i_mtc0(&p, K0, C0_HWRENA);
+	UASM_i_LA_mostly(&p, GPR_K0, (long)&hwrena);
+	uasm_i_lw(&p, GPR_K0, uasm_rel_lo((long)&hwrena), GPR_K0);
+	uasm_i_mtc0(&p, GPR_K0, C0_HWRENA);
 
-	/* Restore RA, which is the address we will return to */
-	UASM_i_LW(&p, RA, offsetof(struct pt_regs, regs[RA]), K1);
-	uasm_i_jr(&p, RA);
+	/* Restore GPR_RA, which is the address we will return to */
+	UASM_i_LW(&p, GPR_RA, offsetof(struct pt_regs, regs[GPR_RA]), GPR_K1);
+	uasm_i_jr(&p, GPR_RA);
 	 uasm_i_nop(&p);
 
 	return p;

-- 
2.43.0


