Return-Path: <linux-kernel+bounces-16110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E594823913
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFDE1C24990
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC521208B3;
	Wed,  3 Jan 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uja1Gff7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFC208A5;
	Wed,  3 Jan 2024 23:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477F5C433C9;
	Wed,  3 Jan 2024 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323783;
	bh=sqy9aC7H0/x8lEnV3p+cfivSEeKK30zPeIpc2NygEFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uja1Gff7v+6SEJKhRUrsx9BCnzxNDoqv7uUUk/4m2Mg2KT4IoGul5Gm14hTFYaDHJ
	 Nn0niG962K5X9tWoG0vxKkWFDNfjslqAkp77oc4aW2+0nD//27alIS5oxUS6jHMQMR
	 YHBdL99SZjljExOgC3Mo8GdHKbekDqEdDQW3v/AR5irR0ZSBpW9SMTpSxFCfRE8kPx
	 OXort1Rno1Ay/vPPsHfTgl/XmVZ5SQTHpHyEfBiX6QjxqI+B9eoV6mZHf1Tm6PT/Ld
	 U+U1xzHM1WoJplnnYWyao+Q5FXB2bj0praIJtadlES6F83rjmOIfTyVkL7zJFyw6Pm
	 saqFOrc0cVAfA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Subject: [PATCH 5/8] KVM: arm64: Fix typos
Date: Wed,  3 Jan 2024 17:16:02 -0600
Message-Id: <20240103231605.1801364-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103231605.1801364-1-helgaas@kernel.org>
References: <20240103231605.1801364-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
---
 arch/arm64/include/asm/kvm_hyp.h | 2 +-
 arch/arm64/kvm/arch_timer.c      | 2 +-
 arch/arm64/kvm/fpsimd.c          | 2 +-
 arch/arm64/kvm/hyp/nvhe/host.S   | 2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c     | 4 ++--
 arch/arm64/kvm/inject_fault.c    | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c  | 2 +-
 arch/arm64/kvm/vgic/vgic-its.c   | 4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 145ce73fc16c..3e2a1ac0c9bb 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -70,7 +70,7 @@ DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 /*
  * Without an __arch_swab32(), we fall back to ___constant_swab32(), but the
  * static inline can allow the compiler to out-of-line this. KVM always wants
- * the macro version as its always inlined.
+ * the macro version as it's always inlined.
  */
 #define __kvm_swab32(x)	___constant_swab32(x)
 
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 13ba691b848f..ded8063b8813 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -746,7 +746,7 @@ static void kvm_timer_vcpu_load_nested_switch(struct kvm_vcpu *vcpu,
 		WARN_ON_ONCE(ret);
 
 		/*
-		 * The virtual offset behaviour is "interresting", as it
+		 * The virtual offset behaviour is "interesting", as it
 		 * always applies when HCR_EL2.E2H==0, but only when
 		 * accessed from EL1 when HCR_EL2.E2H==1. So make sure we
 		 * track E2H when putting the HV timer in "direct" mode.
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8c1d0d4853df..571cf6eef1e1 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -117,7 +117,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 }
 
 /*
- * Called just before entering the guest once we are no longer preemptable
+ * Called just before entering the guest once we are no longer preemptible
  * and interrupts are disabled. If we have managed to run anything using
  * FP while we were preemptible (such as off the back of an interrupt),
  * then neither the host nor the guest own the FP hardware (and it was the
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 7693a6757cd7..135cfb294ee5 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -110,7 +110,7 @@ SYM_FUNC_END(__host_enter)
  * 				  u64 elr, u64 par);
  */
 SYM_FUNC_START(__hyp_do_panic)
-	/* Prepare and exit to the host's panic funciton. */
+	/* Prepare and exit to the host's panic function. */
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, lr
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 65a7a186d7b2..daf91a7989d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -155,7 +155,7 @@ int hyp_back_vmemmap(phys_addr_t back)
 		start = hyp_memory[i].base;
 		start = ALIGN_DOWN((u64)hyp_phys_to_page(start), PAGE_SIZE);
 		/*
-		 * The begining of the hyp_vmemmap region for the current
+		 * The beginning of the hyp_vmemmap region for the current
 		 * memblock may already be backed by the page backing the end
 		 * the previous region, so avoid mapping it twice.
 		 */
@@ -408,7 +408,7 @@ static void *admit_host_page(void *arg)
 	return pop_hyp_memcache(host_mc, hyp_phys_to_virt);
 }
 
-/* Refill our local memcache by poping pages from the one provided by the host. */
+/* Refill our local memcache by popping pages from the one provided by the host. */
 int refill_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages,
 		    struct kvm_hyp_memcache *host_mc)
 {
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 0bd93a5f21ce..a640e839848e 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -134,7 +134,7 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
 	if (vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
 		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
 	} else {
-		/* no need to shuffle FS[4] into DFSR[10] as its 0 */
+		/* no need to shuffle FS[4] into DFSR[10] as it's 0 */
 		fsr = DFSR_FSC_EXTABT_nLPAE;
 	}
 
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index c8c3cb812783..a0a9badaa91c 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -309,7 +309,7 @@ int vgic_init(struct kvm *kvm)
 		vgic_lpi_translation_cache_init(kvm);
 
 	/*
-	 * If we have GICv4.1 enabled, unconditionnaly request enable the
+	 * If we have GICv4.1 enabled, unconditionally request enable the
 	 * v4 support so that we get HW-accelerated vSGIs. Otherwise, only
 	 * enable it if we present a virtual ITS to the guest.
 	 */
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 2dad2d095160..39d8c15202e7 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1337,8 +1337,8 @@ static int vgic_its_cmd_handle_inv(struct kvm *kvm, struct vgic_its *its,
 }
 
 /**
- * vgic_its_invall - invalidate all LPIs targetting a given vcpu
- * @vcpu: the vcpu for which the RD is targetted by an invalidation
+ * vgic_its_invall - invalidate all LPIs targeting a given vcpu
+ * @vcpu: the vcpu for which the RD is targeted by an invalidation
  *
  * Contrary to the INVALL command, this targets a RD instead of a
  * collection, and we don't need to hold the its_lock, since no ITS is
-- 
2.34.1


