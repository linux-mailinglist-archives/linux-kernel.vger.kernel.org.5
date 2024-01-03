Return-Path: <linux-kernel+bounces-15005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A913D82260B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EE12848F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272515B0;
	Wed,  3 Jan 2024 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNhMo3kl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2041363
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 00:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F5C433C8;
	Wed,  3 Jan 2024 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704242418;
	bh=5FrbYJemPMp2y99/3fOzl4jP9vxlpR35ILbhDN2tPiw=;
	h=From:To:Cc:Subject:Date:From;
	b=VNhMo3klg7uHcdhFSiDQypyZZKVOgS5jaAkZmoK3l05W4YR86FJM+rg1DluGWwWdu
	 DMmq672FVkmIgceq0gEo7XsqbOxqfDVE+WzHhbsF+7aROby46ya7Ma3sHosyYsw7ql
	 dH2zAlYAs3DUcsqESVGacITiNU9OR0Wqklpja3dAhE5ts5+GVcVDFaWNAyRSVfqnmI
	 mxKd4a0Nhjz8pkp+MRcaXRJcCxGbdF/eMp6IzgOx7pOj0xqW4lWFr1ba6SmCsgov3u
	 d6Z0Hn1pf8e/ivOb+iCbLQYCzQ+97GxqlYOpI+uax2mJdI8EaRexMD1YSYqj7Jm8rB
	 JAnzCwG13X6Sw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] arch/x86: Fix typos
Date: Tue,  2 Jan 2024 18:40:11 -0600
Message-Id: <20240103004011.1758650-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/x86".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/boot/compressed/Makefile            | 2 +-
 arch/x86/boot/compressed/mem.c               | 2 +-
 arch/x86/coco/tdx/tdx.c                      | 2 +-
 arch/x86/crypto/aesni-intel_asm.S            | 2 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S     | 2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 2 +-
 arch/x86/crypto/sha512-avx-asm.S             | 2 +-
 arch/x86/crypto/sha512-ssse3-asm.S           | 2 +-
 arch/x86/events/amd/brs.c                    | 2 +-
 arch/x86/events/amd/core.c                   | 2 +-
 arch/x86/events/intel/core.c                 | 2 +-
 arch/x86/hyperv/hv_apic.c                    | 2 +-
 arch/x86/hyperv/irqdomain.c                  | 2 +-
 arch/x86/hyperv/ivm.c                        | 2 +-
 arch/x86/include/asm/amd_nb.h                | 2 +-
 arch/x86/include/asm/extable_fixup_types.h   | 2 +-
 arch/x86/include/asm/fpu/types.h             | 2 +-
 arch/x86/include/asm/iosf_mbi.h              | 2 +-
 arch/x86/include/asm/kvm_host.h              | 2 +-
 arch/x86/include/asm/nospec-branch.h         | 4 ++--
 arch/x86/include/asm/pgtable_64.h            | 2 +-
 arch/x86/include/asm/uv/uv_hub.h             | 2 +-
 arch/x86/include/asm/vdso/gettimeofday.h     | 2 +-
 arch/x86/include/asm/xen/interface_64.h      | 2 +-
 arch/x86/include/uapi/asm/amd_hsmp.h         | 2 +-
 arch/x86/kernel/alternative.c                | 2 +-
 arch/x86/kernel/amd_gart_64.c                | 2 +-
 arch/x86/kernel/apic/Makefile                | 2 +-
 arch/x86/kernel/apic/apic.c                  | 2 +-
 arch/x86/kernel/apic/vector.c                | 2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c              | 2 +-
 arch/x86/kernel/fpu/core.c                   | 2 +-
 arch/x86/kernel/head_64.S                    | 4 ++--
 arch/x86/kernel/hpet.c                       | 4 ++--
 arch/x86/kernel/kvm.c                        | 2 +-
 arch/x86/kernel/kvmclock.c                   | 2 +-
 arch/x86/kernel/ldt.c                        | 6 +++---
 arch/x86/kernel/process.c                    | 2 +-
 arch/x86/kernel/sev-shared.c                 | 2 +-
 arch/x86/kvm/cpuid.c                         | 2 +-
 arch/x86/kvm/mmu/mmu.c                       | 4 ++--
 arch/x86/kvm/mmu/tdp_iter.c                  | 2 +-
 arch/x86/kvm/svm/svm.c                       | 2 +-
 arch/x86/kvm/vmx/nested.c                    | 2 +-
 arch/x86/kvm/vmx/vmx.c                       | 2 +-
 arch/x86/kvm/x86.c                           | 6 +++---
 arch/x86/lib/delay.c                         | 2 +-
 arch/x86/mm/init_64.c                        | 6 +++---
 arch/x86/mm/pat/memtype.c                    | 2 +-
 arch/x86/mm/pat/set_memory.c                 | 4 ++--
 arch/x86/mm/pti.c                            | 2 +-
 arch/x86/mm/tlb.c                            | 2 +-
 arch/x86/net/bpf_jit_comp.c                  | 2 +-
 arch/x86/net/bpf_jit_comp32.c                | 2 +-
 arch/x86/platform/intel-quark/imr_selftest.c | 2 +-
 arch/x86/platform/pvh/head.S                 | 2 +-
 arch/x86/platform/uv/uv_nmi.c                | 2 +-
 arch/x86/platform/uv/uv_time.c               | 2 +-
 arch/x86/realmode/init.c                     | 2 +-
 arch/x86/xen/mmu_pv.c                        | 2 +-
 60 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 71fc531b95b4..f19c038409aa 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -53,7 +53,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
-# sev.c indirectly inludes inat-table.h which is generated during
+# sev.c indirectly includes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
 CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index b3c3a4be7471..dbba332e4a12 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -8,7 +8,7 @@
 
 /*
  * accept_memory() and process_unaccepted_memory() called from EFI stub which
- * runs before decompresser and its early_tdx_detect().
+ * runs before decompressor and its early_tdx_detect().
  *
  * Enumerate TDX directly from the early users.
  */
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1b5d17a9f70d..4f06e6721c0a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -886,7 +886,7 @@ void __init tdx_early_init(void)
 	 * there.
 	 *
 	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
-	 * implemented seperately in the low level startup ASM code.
+	 * implemented separately in the low level startup ASM code.
 	 * Until that is in place, disable parallel bringup for TDX.
 	 */
 	x86_cpuinit.parallel_bringup = false;
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 187f913cc239..411d8c83e88a 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -666,7 +666,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 
 .ifc \operation, dec
 	movdqa	%xmm1, %xmm3
-	pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+	pxor	%xmm1, %xmm9		# Ciphertext XOR E(K, Yn)
 
 	mov	\PLAIN_CYPH_LEN, %r10
 	add	%r13, %r10
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 74dd230973cf..8c9749ed0651 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -747,7 +747,7 @@ VARIABLE_OFFSET = 16*8
 
 .if  \ENC_DEC ==  DEC
         vmovdqa	%xmm1, %xmm3
-        pxor	%xmm1, %xmm9		# Cyphertext XOR E(K, Yn)
+        pxor	%xmm1, %xmm9		# Ciphertext XOR E(K, Yn)
 
         mov	\PLAIN_CYPH_LEN, %r10
         add	%r13, %r10
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 81ce0f4db555..bbcff1fb78cb 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -184,7 +184,7 @@ SYM_FUNC_START(crc_pcl)
 	xor     crc1,crc1
 	xor     crc2,crc2
 
-	# Fall thruogh into top of crc array (crc_128)
+	# Fall through into top of crc array (crc_128)
 
 	################################################################
 	## 3) CRC Array:
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index d902b8ea0721..5bfce4b045fd 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -84,7 +84,7 @@ frame_size = frame_WK + WK_SIZE
 
 # Useful QWORD "arrays" for simpler memory references
 # MSG, DIGEST, K_t, W_t are arrays
-# WK_2(t) points to 1 of 2 qwords at frame.WK depdending on t being odd/even
+# WK_2(t) points to 1 of 2 qwords at frame.WK depending on t being odd/even
 
 # Input message (arg1)
 #define MSG(i)    8*i(msg)
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index 65be30156816..30a2c4777f9d 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -82,7 +82,7 @@ frame_size = frame_WK + WK_SIZE
 
 # Useful QWORD "arrays" for simpler memory references
 # MSG, DIGEST, K_t, W_t are arrays
-# WK_2(t) points to 1 of 2 qwords at frame.WK depdending on t being odd/even
+# WK_2(t) points to 1 of 2 qwords at frame.WK depending on t being odd/even
 
 # Input message (arg1)
 #define MSG(i)    8*i(msg)
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index ed308719236c..780acd3dff22 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -125,7 +125,7 @@ int amd_brs_hw_config(struct perf_event *event)
 	 * Where X is the number of taken branches due to interrupt
 	 * skid. Skid is large.
 	 *
-	 * Where Y is the occurences of the event while BRS is
+	 * Where Y is the occurrences of the event while BRS is
 	 * capturing the lbr_nr entries.
 	 *
 	 * By using retired taken branches, we limit the impact on the
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e24976593a29..25ad6fd98166 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1184,7 +1184,7 @@ static void amd_put_event_constraints_f17h(struct cpu_hw_events *cpuc,
  * period of each one and given that the BRS saturates, it would not be possible
  * to guarantee correlated content for all events. Therefore, in situations
  * where multiple events want to use BRS, the kernel enforces mutual exclusion.
- * Exclusion is enforced by chosing only one counter for events using BRS.
+ * Exclusion is enforced by choosing only one counter for events using BRS.
  * The event scheduling logic will then automatically multiplex the
  * events and ensure that at most one event is actively using BRS.
  *
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794a0e79..fdfcd5112884 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4027,7 +4027,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 /*
  * Currently, the only caller of this function is the atomic_switch_perf_msrs().
- * The host perf conext helps to prepare the values of the real hardware for
+ * The host perf context helps to prepare the values of the real hardware for
  * a set of msrs that need to be switched atomically in a vmx transaction.
  *
  * For example, the pseudocode needed to add a new msr should look like:
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 97bfe5f0531f..5fc45543e955 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -209,7 +209,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 
 		/*
 		 * This particular version of the IPI hypercall can
-		 * only target upto 64 CPUs.
+		 * only target up to 64 CPUs.
 		 */
 		if (vcpu >= 64)
 			goto do_ex_hypercall;
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 42c70d28ef27..3215a4a07408 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -212,7 +212,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 * This interrupt is already mapped. Let's unmap first.
 		 *
 		 * We don't use retarget interrupt hypercalls here because
-		 * Microsoft Hypervisor doens't allow root to change the vector
+		 * Microsoft Hypervisor doesn't allow root to change the vector
 		 * or specify VPs outside of the set that is initially used
 		 * during mapping.
 		 */
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 02e55237d919..7dcbf153ad72 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -144,7 +144,7 @@ void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)
 	/* Tell the hypervisor what went wrong. */
 	val |= GHCB_SEV_TERM_REASON(set, reason);
 
-	/* Request Guest Termination from Hypvervisor */
+	/* Request Guest Termination from Hypervisor */
 	wr_ghcb_msr(val);
 	VMGEXIT();
 
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index ed0eaf65c437..5c37944c8a5e 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -104,7 +104,7 @@ static inline bool amd_gart_present(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return false;
 
-	/* GART present only on Fam15h, upto model 0fh */
+	/* GART present only on Fam15h, up to model 0fh */
 	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
 	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
 		return true;
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 991e31cfde94..fe6312045042 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -4,7 +4,7 @@
 
 /*
  * Our IMM is signed, as such it must live at the top end of the word. Also,
- * since C99 hex constants are of ambigious type, force cast the mask to 'int'
+ * since C99 hex constants are of ambiguous type, force cast the mask to 'int'
  * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
  */
 #define EX_DATA_TYPE_MASK		((int)0x000000FF)
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb810074f1e7..f1fadc318a88 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -415,7 +415,7 @@ struct fpu_state_perm {
 	 *
 	 * This master permission field is only to be used when
 	 * task.fpu.fpstate based checks fail to validate whether the task
-	 * is allowed to expand it's xfeatures set which requires to
+	 * is allowed to expand its xfeatures set which requires to
 	 * allocate a larger sized fpstate buffer.
 	 *
 	 * Do not access this field directly.  Use the provided helper
diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index a1911fea8739..af7541c11821 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -111,7 +111,7 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask);
  * This function will block all kernel access to the PMIC I2C bus, so that the
  * P-Unit can safely access the PMIC over the shared I2C bus.
  *
- * Note on these systems the i2c-bus driver will request a sempahore from the
+ * Note on these systems the i2c-bus driver will request a semaphore from the
  * P-Unit for exclusive access to the PMIC bus when i2c drivers are accessing
  * it, but this does not appear to be sufficient, we still need to avoid making
  * certain P-Unit requests during the access window to avoid problems.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7036982332e..6711da000bb7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1652,7 +1652,7 @@ struct kvm_x86_ops {
 	/* Whether or not a virtual NMI is pending in hardware. */
 	bool (*is_vnmi_pending)(struct kvm_vcpu *vcpu);
 	/*
-	 * Attempt to pend a virtual NMI in harware.  Returns %true on success
+	 * Attempt to pend a virtual NMI in hardware.  Returns %true on success
 	 * to allow using static_call_ret0 as the fallback.
 	 */
 	bool (*set_vnmi_pending)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f93e9b96927a..262e65539f83 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -49,7 +49,7 @@
  * but there is still a cushion vs. the RSB depth. The algorithm does not
  * claim to be perfect and it can be speculated around by the CPU, but it
  * is considered that it obfuscates the problem enough to make exploitation
- * extremly difficult.
+ * extremely difficult.
  */
 #define RET_DEPTH_SHIFT			5
 #define RSB_RET_STUFF_LOOPS		16
@@ -208,7 +208,7 @@
 
 /*
  * Abuse ANNOTATE_RETPOLINE_SAFE on a NOP to indicate UNRET_END, should
- * eventually turn into it's own annotation.
+ * eventually turn into its own annotation.
  */
 .macro VALIDATE_UNRET_END
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index a629b1b9f65a..24af25b1551a 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -203,7 +203,7 @@ static inline void native_pgd_clear(pgd_t *pgd)
  * F (2) in swp entry is used to record when a pagetable is
  * writeprotected by userfaultfd WP support.
  *
- * E (3) in swp entry is used to rememeber PG_anon_exclusive.
+ * E (3) in swp entry is used to remember PG_anon_exclusive.
  *
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 5fa76c2ced51..ea877fd83114 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -653,7 +653,7 @@ static inline int uv_blade_to_node(int blade)
 	return uv_socket_to_node(blade);
 }
 
-/* Blade number of current cpu. Numnbered 0 .. <#blades -1> */
+/* Blade number of current cpu. Numbered 0 .. <#blades -1> */
 static inline int uv_numa_blade_id(void)
 {
 	return uv_hub_info->numa_blade_id;
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index c81858d903dc..923053f366d7 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -321,7 +321,7 @@ static __always_inline
 u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
 	/*
-	 * Due to the MSB/Sign-bit being used as invald marker (see
+	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
 	 */
 	u64 delta = (cycles - last) & S64_MAX;
diff --git a/arch/x86/include/asm/xen/interface_64.h b/arch/x86/include/asm/xen/interface_64.h
index c599ec269a25..c10f279aae93 100644
--- a/arch/x86/include/asm/xen/interface_64.h
+++ b/arch/x86/include/asm/xen/interface_64.h
@@ -61,7 +61,7 @@
  *   RING1 -> RING3 kernel mode.
  *   RING2 -> RING3 kernel mode.
  *   RING3 -> RING3 user mode.
- * However RING0 indicates that the guest kernel should return to iteself
+ * However RING0 indicates that the guest kernel should return to itself
  * directly with
  *      orb   $3,1*8(%rsp)
  *      iretq
diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
index fce22686c834..e5d182c7373c 100644
--- a/arch/x86/include/uapi/asm/amd_hsmp.h
+++ b/arch/x86/include/uapi/asm/amd_hsmp.h
@@ -238,7 +238,7 @@ static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
 	/*
 	 * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
 	 * input: args[0] = DIMM address[7:0]
-	 * output: args[0] = temperature in degree celcius[31:21] + update rate in ms[16:8] +
+	 * output: args[0] = temperature in degree celsius[31:21] + update rate in ms[16:8] +
 	 * DIMM address[7:0]
 	 */
 	{1, 1, HSMP_GET},
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..0c7fc2b92302 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1896,7 +1896,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
  * Note that the caller must ensure that if the modified code is part of a
  * module, the module would not be removed during poking. This can be achieved
  * by registering a module notifier, and ordering module removal and patching
- * trough a mutex.
+ * through a mutex.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 56a917df410d..2ae98f754e59 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -776,7 +776,7 @@ int __init gart_iommu_init(void)
 				iommu_size >> PAGE_SHIFT);
 	/*
 	 * Tricky. The GART table remaps the physical memory range,
-	 * so the CPU wont notice potential aliases and if the memory
+	 * so the CPU won't notice potential aliases and if the memory
 	 * is remapped to UC later on, we might surprise the PCI devices
 	 * with a stray writeout of a cacheline. So play it sure and
 	 * do an explicit, full-scale wbinvd() _after_ having marked all
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index 2ee867d796d9..3bf0487cf3b7 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -4,7 +4,7 @@
 #
 
 # Leads to non-deterministic coverage that is not a function of syscall inputs.
-# In particualr, smp_apic_timer_interrupt() is called in random places.
+# In particular, smp_apic_timer_interrupt() is called in random places.
 KCOV_INSTRUMENT		:= n
 
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o apic_common.o apic_noop.o ipi.o vector.o init.o
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 41093cf20acd..4667bc4b00ab 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -782,7 +782,7 @@ bool __init apic_needs_pit(void)
 
 	/*
 	 * If interrupt delivery mode is legacy PIC or virtual wire without
-	 * configuration, the local APIC timer wont be set up. Make sure
+	 * configuration, the local APIC timer won't be set up. Make sure
 	 * that the PIT is initialized.
 	 */
 	if (apic_intr_mode == APIC_PIC ||
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 319448d87b99..dbd15a67e9df 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -738,7 +738,7 @@ int __init arch_probe_nr_irqs(void)
 void lapic_assign_legacy_vector(unsigned int irq, bool replace)
 {
 	/*
-	 * Use assign system here so it wont get accounted as allocated
+	 * Use assign system here so it won't get accounted as allocated
 	 * and moveable in the cpu hotplug check and it prevents managed
 	 * irq reservation from touching it.
 	 */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d390df21440..b65ab214bdf5 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -581,7 +581,7 @@ static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
  *
  * Flush any outstanding enqueued EADD operations and perform EINIT.  The
  * Launch Enclave Public Key Hash MSRs are rewritten as necessary to match
- * the enclave's MRSIGNER, which is caculated from the provided sigstruct.
+ * the enclave's MRSIGNER, which is calculated from the provided sigstruct.
  *
  * Return:
  * - 0:		Success.
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a21a4d0ecc34..520deb411a70 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -308,7 +308,7 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  * Must be invoked from KVM after a VMEXIT before enabling interrupts when
  * XFD write emulation is disabled. This is required because the guest can
  * freely modify XFD and the state at VMEXIT is not guaranteed to be the
- * same as the state on VMENTER. So software state has to be udpated before
+ * same as the state on VMENTER. So software state has to be updated before
  * any operation which depends on it can take place.
  *
  * Note: It can be invoked unconditionally even when write emulation is
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3aaaa0..9996c0cf2f63 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -205,9 +205,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * Switch to new page-table
 	 *
 	 * For the boot CPU this switches to early_top_pgt which still has the
-	 * indentity mappings present. The secondary CPUs will switch to the
+	 * identity mappings present. The secondary CPUs will switch to the
 	 * init_top_pgt here, away from the trampoline_pgd and unmap the
-	 * indentity mapped ranges.
+	 * identity mapped ranges.
 	 */
 	movq	%rax, %cr3
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 41eecf180b7f..8ff2bf921519 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -707,7 +707,7 @@ static void __init hpet_select_clockevents(void)
 
 	hpet_base.nr_clockevents = 0;
 
-	/* No point if MSI is disabled or CPU has an Always Runing APIC Timer */
+	/* No point if MSI is disabled or CPU has an Always Running APIC Timer */
 	if (hpet_msi_disable || boot_cpu_has(X86_FEATURE_ARAT))
 		return;
 
@@ -965,7 +965,7 @@ static bool __init mwait_pc10_supported(void)
  * and per CPU timer interrupts.
  *
  * The probability that this problem is going to be solved in the
- * forseeable future is close to zero, so the kernel has to be cluttered
+ * foreseeable future is close to zero, so the kernel has to be cluttered
  * with heuristics to keep up with the ever growing amount of hardware and
  * firmware trainwrecks. Hopefully some day hardware people will understand
  * that the approach of "This can be fixed in software" is not sustainable.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 0ddb3bd0f1aa..8b57e020614c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -942,7 +942,7 @@ static void __init kvm_init_platform(void)
 		 * Reset the host's shared pages list related to kernel
 		 * specific page encryption status settings before we load a
 		 * new kernel by kexec. Reset the page encryption status
-		 * during early boot intead of just before kexec to avoid SMP
+		 * during early boot instead of just before kexec to avoid SMP
 		 * races during kvm_pv_guest_cpu_reboot().
 		 * NOTE: We cannot reset the complete shared pages list
 		 * here as we need to retain the UEFI/OVMF firmware
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index fb8f52149be9..a95d0900e8c6 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -42,7 +42,7 @@ static int __init parse_no_kvmclock_vsyscall(char *arg)
 }
 early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 
-/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
+/* Aligned to page sizes to match what's mapped via vsyscalls to userspace */
 #define HVC_BOOT_ARRAY_SIZE \
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index adc67f98819a..7a814b41402d 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -7,7 +7,7 @@
  * This handles calls from both 32bit and 64bit mode.
  *
  * Lock order:
- *	contex.ldt_usr_sem
+ *	context.ldt_usr_sem
  *	  mmap_lock
  *	    context.lock
  */
@@ -49,7 +49,7 @@ void load_mm_ldt(struct mm_struct *mm)
 	/*
 	 * Any change to mm->context.ldt is followed by an IPI to all
 	 * CPUs with the mm active.  The LDT will not be freed until
-	 * after the IPI is handled by all such CPUs.  This means that,
+	 * after the IPI is handled by all such CPUs.  This means that
 	 * if the ldt_struct changes before we return, the values we see
 	 * will be safe, and the new values will be loaded before we run
 	 * any user code.
@@ -685,7 +685,7 @@ SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
 	}
 	/*
 	 * The SYSCALL_DEFINE() macros give us an 'unsigned long'
-	 * return type, but tht ABI for sys_modify_ldt() expects
+	 * return type, but the ABI for sys_modify_ldt() expects
 	 * 'int'.  This cast gives us an int-sized value in %rax
 	 * for the return code.  The 'unsigned' is necessary so
 	 * the compiler does not try to sign-extend the negative
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e8399fca..ab49ade31b0d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -477,7 +477,7 @@ void native_tss_update_io_bitmap(void)
 	/*
 	 * Make sure that the TSS limit is covering the IO bitmap. It might have
 	 * been cut down by a VMEXIT to 0x67 which would cause a subsequent I/O
-	 * access from user space to trigger a #GP because tbe bitmap is outside
+	 * access from user space to trigger a #GP because the bitmap is outside
 	 * the TSS limit.
 	 */
 	refresh_tss_limit();
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..1d24ec679915 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -96,7 +96,7 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 	/* Tell the hypervisor what went wrong. */
 	val |= GHCB_SEV_TERM_REASON(set, reason);
 
-	/* Request Guest Termination from Hypvervisor */
+	/* Request Guest Termination from Hypervisor */
 	sev_es_wr_ghcb_msr(val);
 	VMGEXIT();
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dda6fc4cfae8..42d3f47f4c07 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -105,7 +105,7 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
 
 		/*
 		 * If the index isn't significant, use the first entry with a
-		 * matching function.  It's userspace's responsibilty to not
+		 * matching function.  It's userspace's responsibility to not
 		 * provide "duplicate" entries in all cases.
 		 */
 		if (!(e->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX) || e->index == index)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c57e181bba21..0b1f991b9a31 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -987,7 +987,7 @@ static void pte_list_desc_remove_entry(struct kvm *kvm,
 
 	/*
 	 * The head descriptor is empty.  If there are no tail descriptors,
-	 * nullify the rmap head to mark the list as emtpy, else point the rmap
+	 * nullify the rmap head to mark the list as empty, else point the rmap
 	 * head at the next descriptor, i.e. the new head.
 	 */
 	if (!head_desc->more)
@@ -6544,7 +6544,7 @@ void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
 	kvm_tdp_mmu_try_split_huge_pages(kvm, memslot, start, end, target_level, false);
 
 	/*
-	 * A TLB flush is unnecessary at this point for the same resons as in
+	 * A TLB flush is unnecessary at this point for the same reasons as in
 	 * kvm_mmu_slot_try_split_huge_pages().
 	 */
 }
diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index bd30ebfb2f2c..04c247bfe318 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -146,7 +146,7 @@ static bool try_step_up(struct tdp_iter *iter)
  * Step to the next SPTE in a pre-order traversal of the paging structure.
  * To get to the next SPTE, the iterator either steps down towards the goal
  * GFN, if at a present, non-last-level SPTE, or over to a SPTE mapping a
- * highter GFN.
+ * higher GFN.
  *
  * The basic algorithm is as follows:
  * 1. If the current SPTE is a non-last-level SPTE, step down into the page
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 712146312358..7097954904cb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4741,7 +4741,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	 * Emulation is possible for SEV guests if and only if a prefilled
 	 * buffer containing the bytes of the intercepted instruction is
 	 * available. SEV guest memory is encrypted with a guest specific key
-	 * and cannot be decrypted by KVM, i.e. KVM would read cyphertext and
+	 * and cannot be decrypted by KVM, i.e. KVM would read ciphertext and
 	 * decode garbage.
 	 *
 	 * If KVM is NOT trying to simply skip an instruction, inject #UD if
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c5ec0ef51ff7..65826fe23f33 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6561,7 +6561,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 		 * code was changed such that flag signals vmcs12 should
 		 * be copied into eVMCS in guest memory.
 		 *
-		 * To preserve backwards compatability, allow user
+		 * To preserve backwards compatibility, allow user
 		 * to set this flag even when there is no VMXON region.
 		 */
 		if (kvm_state->flags & ~KVM_STATE_NESTED_EVMCS)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index be20a60047b1..e0f86f11c345 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1809,7 +1809,7 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 		 * do generate error codes with bits 31:16 set, and so KVM's
 		 * ABI lets userspace shove in arbitrary 32-bit values.  Drop
 		 * the upper bits to avoid VM-Fail, losing information that
-		 * does't really exist is preferable to killing the VM.
+		 * doesn't really exist is preferable to killing the VM.
 		 */
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, (u16)ex->error_code);
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c924075f6f1..b43b37c414d6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10165,7 +10165,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
  *
  * But, if a VM-Exit occurs during instruction execution, and KVM does NOT skip
  * the instruction or inject an exception, then KVM can incorrecty inject a new
- * asynchrounous event if the event became pending after the CPU fetched the
+ * asynchronous event if the event became pending after the CPU fetched the
  * instruction (in the guest).  E.g. if a page fault (#PF, #NPF, EPT violation)
  * occurs and is resolved by KVM, a coincident NMI, SMI, IRQ, etc... can be
  * injected on the restarted instruction instead of being deferred until the
@@ -10186,7 +10186,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 	int r;
 
 	/*
-	 * Process nested events first, as nested VM-Exit supercedes event
+	 * Process nested events first, as nested VM-Exit supersedes event
 	 * re-injection.  If there's an event queued for re-injection, it will
 	 * be saved into the appropriate vmc{b,s}12 fields on nested VM-Exit.
 	 */
@@ -10884,7 +10884,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		/*
 		 * Assert that vCPU vs. VM APICv state is consistent.  An APICv
 		 * update must kick and wait for all vCPUs before toggling the
-		 * per-VM state, and responsing vCPUs must wait for the update
+		 * per-VM state, and responding vCPUs must wait for the update
 		 * to complete before servicing KVM_REQ_APICV_UPDATE.
 		 */
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 0e65d00e2339..23f81ca3f06b 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -128,7 +128,7 @@ static void delay_halt_mwaitx(u64 unused, u64 cycles)
 
 	delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
 	/*
-	 * Use cpu_tss_rw as a cacheline-aligned, seldomly accessed per-cpu
+	 * Use cpu_tss_rw as a cacheline-aligned, seldom accessed per-cpu
 	 * variable as the monitor target.
 	 */
 	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8ceaf..a0dffaca6d2b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1013,7 +1013,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	/* free a pte talbe */
+	/* free a pte table */
 	free_pagetable(pmd_page(*pmd), 0);
 	spin_lock(&init_mm.page_table_lock);
 	pmd_clear(pmd);
@@ -1031,7 +1031,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	/* free a pmd talbe */
+	/* free a pmd table */
 	free_pagetable(pud_page(*pud), 0);
 	spin_lock(&init_mm.page_table_lock);
 	pud_clear(pud);
@@ -1049,7 +1049,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	/* free a pud talbe */
+	/* free a pud table */
 	free_pagetable(p4d_page(*p4d), 0);
 	spin_lock(&init_mm.page_table_lock);
 	p4d_clear(p4d);
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index de10800cd4dd..0904d7e8e126 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -14,7 +14,7 @@
  * memory ranges: uncached, write-combining, write-through, write-protected,
  * and the most commonly used and default attribute: write-back caching.
  *
- * PAT support supercedes and augments MTRR support in a compatible fashion: MTRR is
+ * PAT support supersedes and augments MTRR support in a compatible fashion: MTRR is
  * a hardware interface to enumerate a limited number of physical memory ranges
  * and set their caching attributes explicitly, programmed into the CPU via MSRs.
  * Even modern CPUs have MTRRs enabled - but these are typically not touched
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..e9b448d1b1b7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1621,7 +1621,7 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 
 		/*
 		 * We need to keep the pfn from the existing PTE,
-		 * after all we're only going to change it's attributes
+		 * after all we're only going to change its attributes
 		 * not the memory it points to
 		 */
 		new_pte = pfn_pte(pfn, new_prot);
@@ -2447,7 +2447,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 	/*
 	 * The typical sequence for unmapping is to find a pte through
 	 * lookup_address_in_pgd() (ideally, it should never return NULL because
-	 * the address is already mapped) and change it's protections. As pfn is
+	 * the address is already mapped) and change its protections. As pfn is
 	 * the *target* of a mapping, it's not useful while unmapping.
 	 */
 	struct cpa_data cpa = {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5dd733944629..669ba1c345b3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -6,7 +6,7 @@
  *
  *	https://github.com/IAIK/KAISER
  *
- * The original work was written by and and signed off by for the Linux
+ * The original work was written by and signed off by for the Linux
  * kernel by:
  *
  *   Signed-off-by: Richard Fellner <richard.fellner@student.tugraz.at>
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..5768d386efab 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -355,7 +355,7 @@ static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
 
 	/*
 	 * Validate that it is not running on an SMT sibling as this would
-	 * make the excercise pointless because the siblings share L1D. If
+	 * make the exercise pointless because the siblings share L1D. If
 	 * it runs on a SMT sibling, notify it with SIGBUS on return to
 	 * user/guest
 	 */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..75ae6e5777e4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2143,7 +2143,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 		} else {
 			/* Only copy the arguments on-stack to current
 			 * 'stack_size' and ignore the regs, used to
-			 * prepare the arguments on-stack for orign call.
+			 * prepare the arguments on-stack for origin call.
 			 */
 			if (for_call_origin) {
 				nr_regs += arg_regs;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..b18ce19981ec 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1194,7 +1194,7 @@ struct jit_context {
 #define PROLOGUE_SIZE 35
 
 /*
- * Emit prologue code for BPF program and check it's size.
+ * Emit prologue code for BPF program and check its size.
  * bpf_tail_call helper will skip it while jumping into another program.
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth)
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 761f3689f60a..84ba715f44d1 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -6,7 +6,7 @@
  * Copyright(c) 2015 Bryan O'Donoghue <pure.logic@nexus-software.ie>
  *
  * IMR self test. The purpose of this module is to run a set of tests on the
- * IMR API to validate it's sanity. We check for overlapping, reserved
+ * IMR API to validate its sanity. We check for overlapping, reserved
  * addresses and setup/teardown sanity.
  *
  */
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a05ab83..bc27be467b96 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -41,7 +41,7 @@
  *             Bit 8 (TF) must be cleared. Other bits are all unspecified.
  *
  * All other processor registers and flag bits are unspecified. The OS is in
- * charge of setting up it's own stack, GDT and IDT.
+ * charge of setting up its own stack, GDT and IDT.
  */
 
 #define PVH_GDT_ENTRY_CS	1
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index e03207de2880..5c50e550ab63 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -741,7 +741,7 @@ static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
 	this_cpu_write(uv_cpu_nmi.state, UV_NMI_STATE_DUMP_DONE);
 }
 
-/* Trigger a slave CPU to dump it's state */
+/* Trigger a slave CPU to dump its state */
 static void uv_nmi_trigger_dump(int cpu)
 {
 	int retry = uv_nmi_trigger_delay;
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index ff5afc8a5a41..3712afc3534d 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -270,7 +270,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
  * Read the RTC.
  *
  * Starting with HUB rev 2.0, the UV RTC register is replicated across all
- * cachelines of it's own page.  This allows faster simultaneous reads
+ * cachelines of its own page.  This allows faster simultaneous reads
  * from a given socket.
  */
 static u64 uv_read_rtc(struct clocksource *cs)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 788e5559549f..f9bc444a3064 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -61,7 +61,7 @@ void __init reserve_real_mode(void)
 		set_real_mode_mem(mem);
 
 	/*
-	 * Unconditionally reserve the entire fisrt 1M, see comment in
+	 * Unconditionally reserve the entire first 1M, see comment in
 	 * setup_arch().
 	 */
 	memblock_reserve(0, SZ_1M);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b6830554ff69..72af496a160c 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -34,7 +34,7 @@
  * would need to validate the whole pagetable before going on.
  * Naturally, this is quite slow.  The solution is to "pin" a
  * pagetable, which enforces all the constraints on the pagetable even
- * when it is not actively in use.  This menas that Xen can be assured
+ * when it is not actively in use.  This means that Xen can be assured
  * that it is still valid when you do load it into %cr3, and doesn't
  * need to revalidate it.
  *
-- 
2.34.1


