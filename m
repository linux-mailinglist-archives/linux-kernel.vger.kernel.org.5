Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324876E57D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjHCKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjHCKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05764691;
        Thu,  3 Aug 2023 03:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640F061D1F;
        Thu,  3 Aug 2023 10:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78267C433C8;
        Thu,  3 Aug 2023 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691057994;
        bh=/F+frcDIKRtYxB7ZasvuNwbxNwGIVtZunvfTAzMBIUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrV1y9wAPPuxDY8SpKlvI4Mu15E6xbEoCjoHuQCuEUrLSNBUC4errF1klqinvz6oJ
         pV2Wu71Ejb5S9SnbRlGuDHaZVRnC+JaebtCIHlu2eRJzrYAA17UqRcC56OlVtchKa9
         GFqqViRQYKOzwSkp0l0N1pUgum8tB3KJmZ9uwk0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.124
Date:   Thu,  3 Aug 2023 12:19:41 +0200
Message-ID: <2023080341-shrank-punctual-38d8@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080341-curliness-salary-4158@gregkh>
References: <2023080341-curliness-salary-4158@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 82e29837d589..5a6993795bd2 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -63,31 +63,28 @@ information submitted to the security list and any followup discussions
 of the report are treated confidentially even after the embargo has been
 lifted, in perpetuity.
 
-Coordination
-------------
-
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+Coordination with other groups
+------------------------------
+
+The kernel security team strongly recommends that reporters of potential
+security issues NEVER contact the "linux-distros" mailing list until
+AFTER discussing it with the kernel security team.  Do not Cc: both
+lists at once.  You may contact the linux-distros mailing list after a
+fix has been agreed on and you fully understand the requirements that
+doing so will impose on you and the kernel community.
+
+The different lists have different goals and the linux-distros rules do
+not contribute to actually fixing any potential security problems.
 
 CVE assignment
 --------------
 
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+The security team does not assign CVEs, nor do we require them for
+reports or fixes, as this can needlessly complicate the process and may
+delay the bug handling.  If a reporter wishes to have a CVE identifier
+assigned, they should find one by themselves, for example by contacting
+MITRE directly.  However under no circumstances will a patch inclusion
+be delayed to wait for a CVE identifier to arrive.
 
 Non-disclosure agreements
 -------------------------
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index b175d88f31eb..15e4bfa2bd83 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,8 +58,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string", "ustring" and bitfield
-		  are supported.
+		  (x8/x16/x32/x64), "string", "ustring", "symbol", "symstr"
+                  and bitfield are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
   (\*2) only for return probe.
@@ -96,6 +96,10 @@ offset, and container-size (usually 32). The syntax is::
 
 Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
 which shows given pointer in "symbol+offset" style.
+On the other hand, symbol-string type ('symstr') converts the given address to
+"symbol+offset/symbolsize" style and stores it as a null-terminated string.
+With 'symstr' type, you can filter the event with wildcard pattern of the
+symbols, and you don't need to solve symbol name by yourself.
 For $comm, the default type is "string"; any other type is invalid.
 
 .. _user_mem_access:
diff --git a/MAINTAINERS b/MAINTAINERS
index 2bf1ad0fb2a6..e6b53e76651b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4666,6 +4666,7 @@ T:	git git://git.samba.org/sfrench/cifs-2.6.git
 F:	Documentation/admin-guide/cifs/
 F:	fs/cifs/
 F:	fs/smbfs_common/
+F:	include/uapi/linux/cifs
 
 COMPACTPCI HOTPLUG CORE
 M:	Scott Murray <scott@spiteful.org>
diff --git a/Makefile b/Makefile
index 38ef4f11f530..6fb94face8d7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 123
+SUBLEVEL = 124
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index ff40bf92db43..a2c872de29a6 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2791,6 +2791,7 @@ int s390_replace_asce(struct gmap *gmap)
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
+	page->index = 0;
 	table = page_to_virt(page);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 23ea8a25cbbe..4bdcb91478a5 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -34,6 +34,7 @@ KVM_X86_OP(get_segment)
 KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP_NULL(get_cs_db_l_bits)
+KVM_X86_OP(is_valid_cr0)
 KVM_X86_OP(set_cr0)
 KVM_X86_OP(is_valid_cr4)
 KVM_X86_OP(set_cr4)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9e800d4d323c..08cfc26ee7c6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1333,8 +1333,9 @@ struct kvm_x86_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
+	bool (*is_valid_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
-	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0611dac70c25..302a4669c5a1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1734,6 +1734,11 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	vmcb_mark_dirty(svm->vmcb, VMCB_DT);
 }
 
+static bool svm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	return true;
+}
+
 void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4596,6 +4601,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_segment = svm_set_segment,
 	.get_cpl = svm_get_cpl,
 	.get_cs_db_l_bits = kvm_get_cs_db_l_bits,
+	.is_valid_cr0 = svm_is_valid_cr0,
 	.set_cr0 = svm_set_cr0,
 	.is_valid_cr4 = svm_is_valid_cr4,
 	.set_cr4 = svm_set_cr4,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ec56ed91b503..89744ee06101 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1416,6 +1416,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long old_rflags;
 
+	/*
+	 * Unlike CR0 and CR4, RFLAGS handling requires checking if the vCPU
+	 * is an unrestricted guest in order to mark L2 as needing emulation
+	 * if L1 runs L2 as a restricted guest.
+	 */
 	if (is_unrestricted_guest(vcpu)) {
 		kvm_register_mark_available(vcpu, VCPU_EXREG_RFLAGS);
 		vmx->rflags = rflags;
@@ -2889,6 +2894,15 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(vcpu->kvm);
 
+	/*
+	 * KVM should never use VM86 to virtualize Real Mode when L2 is active,
+	 * as using VM86 is unnecessary if unrestricted guest is enabled, and
+	 * if unrestricted guest is disabled, VM-Enter (from L1) with CR0.PG=0
+	 * should VM-Fail and KVM should reject userspace attempts to stuff
+	 * CR0.PG=0 when L2 is active.
+	 */
+	WARN_ON_ONCE(is_guest_mode(vcpu));
+
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
@@ -3079,6 +3093,17 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 #define CR3_EXITING_BITS (CPU_BASED_CR3_LOAD_EXITING | \
 			  CPU_BASED_CR3_STORE_EXITING)
 
+static bool vmx_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (is_guest_mode(vcpu))
+		return nested_guest_cr0_valid(vcpu, cr0);
+
+	if (to_vmx(vcpu)->nested.vmxon)
+		return nested_host_cr0_valid(vcpu, cr0);
+
+	return true;
+}
+
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3088,7 +3113,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	old_cr0_pg = kvm_read_cr0_bits(vcpu, X86_CR0_PG);
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
@@ -3116,7 +3141,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+	if (enable_ept && !enable_unrestricted_guest) {
 		/*
 		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
 		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
@@ -3239,7 +3264,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	unsigned long hw_cr4;
 
 	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr4 |= KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else if (vmx->rmode.vm86_active)
 		hw_cr4 |= KVM_RMODE_VM_CR4_ALWAYS_ON;
@@ -3259,7 +3284,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	vcpu->arch.cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
-	if (!is_unrestricted_guest(vcpu)) {
+	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
 			if (!is_paging(vcpu)) {
 				hw_cr4 &= ~X86_CR4_PAE;
@@ -5022,18 +5047,11 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 		val = (val & ~vmcs12->cr0_guest_host_mask) |
 			(vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask);
 
-		if (!nested_guest_cr0_valid(vcpu, val))
-			return 1;
-
 		if (kvm_set_cr0(vcpu, val))
 			return 1;
 		vmcs_writel(CR0_READ_SHADOW, orig_val);
 		return 0;
 	} else {
-		if (to_vmx(vcpu)->nested.vmxon &&
-		    !nested_host_cr0_valid(vcpu, val))
-			return 1;
-
 		return kvm_set_cr0(vcpu, val);
 	}
 }
@@ -7739,6 +7757,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_segment = vmx_set_segment,
 	.get_cpl = vmx_get_cpl,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
+	.is_valid_cr0 = vmx_is_valid_cr0,
 	.set_cr0 = vmx_set_cr0,
 	.is_valid_cr4 = vmx_is_valid_cr4,
 	.set_cr4 = vmx_set_cr4,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e1e3bc74562..285ba12be8ce 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -876,6 +876,22 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 }
 EXPORT_SYMBOL_GPL(load_pdptrs);
 
+static bool kvm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+#ifdef CONFIG_X86_64
+	if (cr0 & 0xffffffff00000000UL)
+		return false;
+#endif
+
+	if ((cr0 & X86_CR0_NW) && !(cr0 & X86_CR0_CD))
+		return false;
+
+	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
+		return false;
+
+	return static_call(kvm_x86_is_valid_cr0)(vcpu, cr0);
+}
+
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
@@ -898,20 +914,13 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 	unsigned long pdptr_bits = X86_CR0_CD | X86_CR0_NW | X86_CR0_PG;
 
-	cr0 |= X86_CR0_ET;
-
-#ifdef CONFIG_X86_64
-	if (cr0 & 0xffffffff00000000UL)
+	if (!kvm_is_valid_cr0(vcpu, cr0))
 		return 1;
-#endif
-
-	cr0 &= ~CR0_RESERVED_BITS;
 
-	if ((cr0 & X86_CR0_NW) && !(cr0 & X86_CR0_CD))
-		return 1;
+	cr0 |= X86_CR0_ET;
 
-	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
-		return 1;
+	/* Write to CR0 reserved bits are ignored, even on Intel. */
+	cr0 &= ~CR0_RESERVED_BITS;
 
 #ifdef CONFIG_X86_64
 	if ((vcpu->arch.efer & EFER_LME) && !is_paging(vcpu) &&
@@ -10643,7 +10652,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			return false;
 	}
 
-	return kvm_is_valid_cr4(vcpu, sregs->cr4);
+	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
+	       kvm_is_valid_cr0(vcpu, sregs->cr0);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 757a98f6d7a2..1696700fd2fb 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -53,6 +53,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
+	s32 qos_value;
+	int index;
 	int ret;
 
 	if (!pr)
@@ -72,17 +74,30 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		}
 	}
 
+	index = ppc;
+
+	if (pr->performance_platform_limit == index ||
+	    ppc >= pr->performance->state_count)
+		return 0;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
-		       (int)ppc, ppc ? "" : "not");
+		 index, index ? "is" : "is not");
 
-	pr->performance_platform_limit = (int)ppc;
+	pr->performance_platform_limit = index;
 
-	if (ppc >= pr->performance->state_count ||
-	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
+	if (unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = freq_qos_update_request(&pr->perflib_req,
-			pr->performance->states[ppc].core_frequency * 1000);
+	/*
+	 * If _PPC returns 0, it means that all of the available states can be
+	 * used ("no limit").
+	 */
+	if (index == 0)
+		qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		qos_value = pr->performance->states[index].core_frequency * 1000;
+
+	ret = freq_qos_update_request(&pr->perflib_req, qos_value);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
 			pr->id, ret);
@@ -165,9 +180,16 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 		if (!pr)
 			continue;
 
+		/*
+		 * Reset performance_platform_limit in case there is a stale
+		 * value in it, so as to make it match the "no limit" QoS value
+		 * below.
+		 */
+		pr->performance_platform_limit = 0;
+
 		ret = freq_qos_add_request(&policy->constraints,
-					   &pr->perflib_req,
-					   FREQ_QOS_MAX, INT_MAX);
+					   &pr->perflib_req, FREQ_QOS_MAX,
+					   FREQ_QOS_MAX_DEFAULT_VALUE);
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 9dd6bffefb48..602472d4e693 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a4188825bd19..c269c552a43a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3851,51 +3851,82 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
 	list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);
 }
 
-static int get_lock_owner_info(struct rbd_device *rbd_dev,
-			       struct ceph_locker **lockers, u32 *num_lockers)
+static bool locker_equal(const struct ceph_locker *lhs,
+			 const struct ceph_locker *rhs)
+{
+	return lhs->id.name.type == rhs->id.name.type &&
+	       lhs->id.name.num == rhs->id.name.num &&
+	       !strcmp(lhs->id.cookie, rhs->id.cookie) &&
+	       ceph_addr_equal_no_type(&lhs->info.addr, &rhs->info.addr);
+}
+
+static void free_locker(struct ceph_locker *locker)
+{
+	if (locker)
+		ceph_free_lockers(locker, 1);
+}
+
+static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_locker *lockers;
+	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
+	u64 handle;
 	int ret;
 
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
-				 &lock_type, &lock_tag, lockers, num_lockers);
-	if (ret)
-		return ret;
+				 &lock_type, &lock_tag, &lockers, &num_lockers);
+	if (ret) {
+		rbd_warn(rbd_dev, "failed to retrieve lockers: %d", ret);
+		return ERR_PTR(ret);
+	}
 
-	if (*num_lockers == 0) {
+	if (num_lockers == 0) {
 		dout("%s rbd_dev %p no lockers detected\n", __func__, rbd_dev);
+		lockers = NULL;
 		goto out;
 	}
 
 	if (strcmp(lock_tag, RBD_LOCK_TAG)) {
 		rbd_warn(rbd_dev, "locked by external mechanism, tag %s",
 			 lock_tag);
-		ret = -EBUSY;
-		goto out;
+		goto err_busy;
 	}
 
-	if (lock_type == CEPH_CLS_LOCK_SHARED) {
-		rbd_warn(rbd_dev, "shared lock type detected");
-		ret = -EBUSY;
-		goto out;
+	if (lock_type != CEPH_CLS_LOCK_EXCLUSIVE) {
+		rbd_warn(rbd_dev, "incompatible lock type detected");
+		goto err_busy;
 	}
 
-	if (strncmp((*lockers)[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
-		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
+	WARN_ON(num_lockers != 1);
+	ret = sscanf(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu",
+		     &handle);
+	if (ret != 1) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
-			 (*lockers)[0].id.cookie);
-		ret = -EBUSY;
-		goto out;
+			 lockers[0].id.cookie);
+		goto err_busy;
 	}
+	if (ceph_addr_is_blank(&lockers[0].info.addr)) {
+		rbd_warn(rbd_dev, "locker has a blank address");
+		goto err_busy;
+	}
+
+	dout("%s rbd_dev %p got locker %s%llu@%pISpc/%u handle %llu\n",
+	     __func__, rbd_dev, ENTITY_NAME(lockers[0].id.name),
+	     &lockers[0].info.addr.in_addr,
+	     le32_to_cpu(lockers[0].info.addr.nonce), handle);
 
 out:
 	kfree(lock_tag);
-	return ret;
+	return lockers;
+
+err_busy:
+	kfree(lock_tag);
+	ceph_free_lockers(lockers, num_lockers);
+	return ERR_PTR(-EBUSY);
 }
 
 static int find_watcher(struct rbd_device *rbd_dev,
@@ -3949,51 +3980,68 @@ static int find_watcher(struct rbd_device *rbd_dev,
 static int rbd_try_lock(struct rbd_device *rbd_dev)
 {
 	struct ceph_client *client = rbd_dev->rbd_client->client;
-	struct ceph_locker *lockers;
-	u32 num_lockers;
+	struct ceph_locker *locker, *refreshed_locker;
 	int ret;
 
 	for (;;) {
+		locker = refreshed_locker = NULL;
+
 		ret = rbd_lock(rbd_dev);
 		if (ret != -EBUSY)
-			return ret;
+			goto out;
 
 		/* determine if the current lock holder is still alive */
-		ret = get_lock_owner_info(rbd_dev, &lockers, &num_lockers);
-		if (ret)
-			return ret;
-
-		if (num_lockers == 0)
+		locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(locker)) {
+			ret = PTR_ERR(locker);
+			locker = NULL;
+			goto out;
+		}
+		if (!locker)
 			goto again;
 
-		ret = find_watcher(rbd_dev, lockers);
+		ret = find_watcher(rbd_dev, locker);
 		if (ret)
 			goto out; /* request lock or error */
 
+		refreshed_locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(refreshed_locker)) {
+			ret = PTR_ERR(refreshed_locker);
+			refreshed_locker = NULL;
+			goto out;
+		}
+		if (!refreshed_locker ||
+		    !locker_equal(locker, refreshed_locker))
+			goto again;
+
 		rbd_warn(rbd_dev, "breaking header lock owned by %s%llu",
-			 ENTITY_NAME(lockers[0].id.name));
+			 ENTITY_NAME(locker->id.name));
 
 		ret = ceph_monc_blocklist_add(&client->monc,
-					      &lockers[0].info.addr);
+					      &locker->info.addr);
 		if (ret) {
-			rbd_warn(rbd_dev, "blocklist of %s%llu failed: %d",
-				 ENTITY_NAME(lockers[0].id.name), ret);
+			rbd_warn(rbd_dev, "failed to blocklist %s%llu: %d",
+				 ENTITY_NAME(locker->id.name), ret);
 			goto out;
 		}
 
 		ret = ceph_cls_break_lock(&client->osdc, &rbd_dev->header_oid,
 					  &rbd_dev->header_oloc, RBD_LOCK_NAME,
-					  lockers[0].id.cookie,
-					  &lockers[0].id.name);
-		if (ret && ret != -ENOENT)
+					  locker->id.cookie, &locker->id.name);
+		if (ret && ret != -ENOENT) {
+			rbd_warn(rbd_dev, "failed to break header lock: %d",
+				 ret);
 			goto out;
+		}
 
 again:
-		ceph_free_lockers(lockers, num_lockers);
+		free_locker(refreshed_locker);
+		free_locker(locker);
 	}
 
 out:
-	ceph_free_lockers(lockers, num_lockers);
+	free_locker(refreshed_locker);
+	free_locker(locker);
 	return ret;
 }
 
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 365761055df3..d7c440ac465f 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -314,6 +314,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0;
 	int status;
 	u32 expected;
+	int rc;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -333,8 +334,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
+	rc = recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE);
+	if (rc < 0) {
+		size = rc;
+		goto out;
+	}
+	size += rc;
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2f5063db2f1f..736cb2cfcbb0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -448,20 +448,6 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 			 (u32) cpu->acpi_perf_data.states[i].control);
 	}
 
-	/*
-	 * The _PSS table doesn't contain whole turbo frequency range.
-	 * This just contains +1 MHZ above the max non turbo frequency,
-	 * with control value corresponding to max turbo ratio. But
-	 * when cpufreq set policy is called, it will call with this
-	 * max frequency, which will cause a reduced performance as
-	 * this driver uses real max turbo frequency as the max
-	 * frequency. So correct this frequency in _PSS table to
-	 * correct max turbo frequency based on the turbo state.
-	 * Also need to convert to MHz as _PSS freq is in MHz.
-	 */
-	if (!global.turbo_disabled)
-		cpu->acpi_perf_data.states[0].core_frequency =
-					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
 	pr_debug("_PPC limits will be enforced\n");
 
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a245bfd5a617..b965513f44fe 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -874,7 +874,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 
 	spin_lock_init(&mvpwm->lock);
 
-	return pwmchip_add(&mvpwm->chip);
+	return devm_pwmchip_add(dev, &mvpwm->chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1112,6 +1112,13 @@ static int mvebu_gpio_probe_syscon(struct platform_device *pdev,
 	return 0;
 }
 
+static void mvebu_gpio_remove_irq_domain(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
 static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
@@ -1244,17 +1251,21 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
-		err = -ENODEV;
-		goto err_pwm;
+		return -ENODEV;
 	}
 
+	err = devm_add_action_or_reset(&pdev->dev, mvebu_gpio_remove_irq_domain,
+				       mvchip->domain);
+	if (err)
+		return err;
+
 	err = irq_alloc_domain_generic_chips(
 	    mvchip->domain, ngpios, 2, np->name, handle_level_irq,
 	    IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_LEVEL, 0, 0);
 	if (err) {
 		dev_err(&pdev->dev, "couldn't allocate irq chips %s (DT).\n",
 			mvchip->chip.label);
-		goto err_domain;
+		return err;
 	}
 
 	/*
@@ -1294,13 +1305,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_domain:
-	irq_domain_remove(mvchip->domain);
-err_pwm:
-	pwmchip_remove(&mvchip->mvpwm->chip);
-
-	return err;
 }
 
 static struct platform_driver mvebu_gpio_driver = {
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
index 423b7bc30ae8..03a523a6d6fa 100644
--- a/drivers/gpio/gpio-tps68470.c
+++ b/drivers/gpio/gpio-tps68470.c
@@ -91,13 +91,13 @@ static int tps68470_gpio_output(struct gpio_chip *gc, unsigned int offset,
 	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
 	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
 
+	/* Set the initial value */
+	tps68470_gpio_set(gc, offset, value);
+
 	/* rest are always outputs */
 	if (offset >= TPS68470_N_REGULAR_GPIO)
 		return 0;
 
-	/* Set the initial value */
-	tps68470_gpio_set(gc, offset, value);
-
 	return regmap_update_bits(regmap, TPS68470_GPIO_CTL_REG_A(offset),
 				 TPS68470_GPIO_MODE_MASK,
 				 TPS68470_GPIO_MODE_OUT_CMOS);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 65744c3bd364..f305a0f8e9b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -341,11 +341,11 @@ static int psp_sw_init(void *handle)
 	return 0;
 
 failed2:
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-failed1:
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+failed1:
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 7d58bf410be0..4e8274de8fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -16,6 +16,8 @@
 #include "ivsrcid/ivsrcid_vislands30.h"
 #include "amdgpu_vkms.h"
 #include "amdgpu_display.h"
+#include "atom.h"
+#include "amdgpu_irq.h"
 
 /**
  * DOC: amdgpu_vkms
@@ -41,20 +43,20 @@ static const u32 amdgpu_vkms_formats[] = {
 
 static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 {
-	struct amdgpu_vkms_output *output = container_of(timer,
-							 struct amdgpu_vkms_output,
-							 vblank_hrtimer);
-	struct drm_crtc *crtc = &output->crtc;
+	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
+	struct drm_crtc *crtc = &amdgpu_crtc->base;
+	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	u64 ret_overrun;
 	bool ret;
 
-	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
+	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
 	WARN_ON(ret_overrun != 1);
 
 	ret = drm_crtc_handle_vblank(crtc);
+	/* Don't queue timer again when vblank is disabled. */
 	if (!ret)
-		DRM_ERROR("amdgpu_vkms failure on handling vblank");
+		return HRTIMER_NORESTART;
 
 	return HRTIMER_RESTART;
 }
@@ -65,22 +67,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *crtc)
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function = &amdgpu_vkms_vblank_simulate;
 	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
+	hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns, HRTIMER_MODE_REL);
 
 	return 0;
 }
 
 static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
-	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
@@ -92,13 +93,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 	unsigned int pipe = crtc->index;
 	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	if (!READ_ONCE(vblank->enabled)) {
 		*vblank_time = ktime_get();
 		return true;
 	}
 
-	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
+	*vblank_time = READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);
 
 	if (WARN_ON(*vblank_time == vblank->time))
 		return true;
@@ -166,6 +168,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
 static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 			  struct drm_plane *primary, struct drm_plane *cursor)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int ret;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
@@ -177,6 +181,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);
 
+	amdgpu_crtc->crtc_id = drm_crtc_index(crtc);
+	adev->mode_info.crtcs[drm_crtc_index(crtc)] = amdgpu_crtc;
+
+	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
+	amdgpu_crtc->encoder = NULL;
+	amdgpu_crtc->connector = NULL;
+	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
+
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	amdgpu_crtc->vblank_timer.function = &amdgpu_vkms_vblank_simulate;
+
 	return ret;
 }
 
@@ -402,7 +417,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,
 {
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
-	struct drm_crtc *crtc = &output->crtc;
+	struct drm_crtc *crtc = &output->crtc.base;
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
 
@@ -505,8 +520,8 @@ static int amdgpu_vkms_sw_fini(void *handle)
 	int i = 0;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++)
-		if (adev->amdgpu_vkms_output[i].vblank_hrtimer.function)
-			hrtimer_cancel(&adev->amdgpu_vkms_output[i].vblank_hrtimer);
+		if (adev->mode_info.crtcs[i])
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	kfree(adev->mode_info.bios_hardcoded_edid);
 	kfree(adev->amdgpu_vkms_output);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
index 97f1b79c0724..4f8722ff37c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
@@ -10,15 +10,14 @@
 #define YRES_MAX  16384
 
 #define drm_crtc_to_amdgpu_vkms_output(target) \
-	container_of(target, struct amdgpu_vkms_output, crtc)
+	container_of(target, struct amdgpu_vkms_output, crtc.base)
 
 extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;
 
 struct amdgpu_vkms_output {
-	struct drm_crtc crtc;
+	struct amdgpu_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
 };
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index ef62900b0612..e9c8111122bd 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -90,7 +90,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 			 * since we've already mapped it once in
 			 * submit_reloc()
 			 */
-			if (WARN_ON(!ptr))
+			if (WARN_ON(IS_ERR_OR_NULL(ptr)))
 				return;
 
 			for (i = 0; i < dwords; i++) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 2fb58b7098e4..3bd2065a9d30 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -200,7 +200,7 @@ static const struct a6xx_shader_block {
 	SHADER(A6XX_SP_LB_3_DATA, 0x800),
 	SHADER(A6XX_SP_LB_4_DATA, 0x800),
 	SHADER(A6XX_SP_LB_5_DATA, 0x200),
-	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
+	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
 	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
 	SHADER(A6XX_SP_UAV_DATA, 0x80),
 	SHADER(A6XX_SP_INST_TAG, 0x80),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
index cf4b9b5964c6..cd6c3518ba02 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
@@ -14,19 +14,6 @@
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
-/**
- * enum dpu_core_perf_data_bus_id - data bus identifier
- * @DPU_CORE_PERF_DATA_BUS_ID_MNOC: DPU/MNOC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_LLCC: MNOC/LLCC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_EBI: LLCC/EBI data bus
- */
-enum dpu_core_perf_data_bus_id {
-	DPU_CORE_PERF_DATA_BUS_ID_MNOC,
-	DPU_CORE_PERF_DATA_BUS_ID_LLCC,
-	DPU_CORE_PERF_DATA_BUS_ID_EBI,
-	DPU_CORE_PERF_DATA_BUS_ID_MAX,
-};
-
 /**
  * struct dpu_core_perf_params - definition of performance parameters
  * @max_per_pipe_ib: maximum instantaneous bandwidth request
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d5a2b69489e7..4d0ef5ab2531 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -552,17 +552,18 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 		goto out;
 	}
 
-bounce:
-	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
-	if (ret == -EMULTIHOP) {
+	do {
+		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
+		if (ret != -EMULTIHOP)
+			break;
+
 		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
-		if (ret) {
+	} while (!ret);
+
+	if (ret) {
+		ttm_resource_free(bo, &evict_mem);
+		if (ret != -ERESTARTSYS && ret != -EINTR)
 			pr_err("Buffer eviction failed\n");
-			ttm_resource_free(bo, &evict_mem);
-			goto out;
-		}
-		/* try and move to final place now. */
-		goto bounce;
 	}
 out:
 	return ret;
@@ -603,6 +604,12 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 {
 	bool ret = false;
 
+	if (bo->pin_count) {
+		*locked = false;
+		*busy = false;
+		return false;
+	}
+
 	if (bo->base.resv == ctx->resv) {
 		dma_resv_assert_held(bo->base.resv);
 		if (ctx->allow_res_evict)
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index e7ba05c50e61..f3cff6c9f745 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -97,6 +97,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F19H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
 #define F19H_M01H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
 
+/*
+ * AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
+ * Use the model name to identify 3255 CPUs and set a flag to display negative temperature.
+ * Do not round off to zero for negative Tctl or Tdie values if the flag is set
+ */
+#define AMD_I3255_STR				"3255"
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -106,6 +113,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative;
 };
 
 #define TCTL_BIT	0
@@ -220,12 +228,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 2 ... 9:		/* Tccd{1-8} */
@@ -417,6 +425,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 &&
+	    strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
+		data->disp_negative = true;
+	}
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 604af2f6103a..88eddb8d61d3 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -708,7 +708,7 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 46 && !(reg & 0x02))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 9f71daf6db64..c073f5b8833a 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -694,10 +694,8 @@ static int iic_probe(struct platform_device *ofdev)
 	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&ofdev->dev, "failed to allocate device data\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(ofdev, dev);
 
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a2d12a5b1c34..9c5d66bd6dc1 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -970,12 +970,10 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&adev->dev, "cannot allocate memory\n");
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
 	dev->vendor = vendor;
 	dev->adev = adev;
 	nmk_i2c_of_probe(np, dev);
@@ -996,30 +994,21 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
 				resource_size(&adev->res));
-	if (!dev->virtbase) {
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	if (!dev->virtbase)
+		return -ENOMEM;
 
 	dev->irq = adev->irq[0];
 	ret = devm_request_irq(&adev->dev, dev->irq, i2c_irq_handler, 0,
 				DRIVER_NAME, dev);
 	if (ret) {
 		dev_err(&adev->dev, "cannot claim the irq %d\n", dev->irq);
-		goto err_no_mem;
+		return ret;
 	}
 
-	dev->clk = devm_clk_get(&adev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&adev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
-		dev_err(&adev->dev, "could not get i2c clock\n");
-		ret = PTR_ERR(dev->clk);
-		goto err_no_mem;
-	}
-
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		dev_err(&adev->dev, "can't prepare_enable clock\n");
-		goto err_no_mem;
+		dev_err(&adev->dev, "could enable i2c clock\n");
+		return PTR_ERR(dev->clk);
 	}
 
 	init_hw(dev);
@@ -1042,22 +1031,15 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	ret = i2c_add_adapter(adap);
 	if (ret)
-		goto err_no_adap;
+		return ret;
 
 	pm_runtime_put(&adev->dev);
 
 	return 0;
-
- err_no_adap:
-	clk_disable_unprepare(dev->clk);
- err_no_mem:
-
-	return ret;
 }
 
 static void nmk_i2c_remove(struct amba_device *adev)
 {
-	struct resource *res = &adev->res;
 	struct nmk_i2c_dev *dev = amba_get_drvdata(adev);
 
 	i2c_del_adapter(&dev->adap);
@@ -1066,8 +1048,6 @@ static void nmk_i2c_remove(struct amba_device *adev)
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	clk_disable_unprepare(dev->clk);
-	release_mem_region(res->start, resource_size(res));
 }
 
 static struct i2c_vendor_data vendor_stn8815 = {
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 319d1fa617c8..051b904cb35f 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -443,9 +443,8 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 		goto out0;
 	}
 
-	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
-		dev_err(&pdev->dev, "no mem for private data\n");
 		ret = -ENOMEM;
 		goto out0;
 	}
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 7279ca0eaa2d..d1fa9ff5aeab 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -226,10 +226,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!dev)
 		goto error;
-	}
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 843d0b5d99ac..87ee616e6938 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -792,7 +792,10 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
 	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_re_dev *rdev = qp->rdev;
+	struct bnxt_qplib_nq *scq_nq = NULL;
+	struct bnxt_qplib_nq *rcq_nq = NULL;
 	unsigned int flags;
 	int rc;
 
@@ -826,6 +829,15 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
+	/* Flush all the entries of notification queue associated with
+	 * given qp.
+	 */
+	scq_nq = qplib_qp->scq->nq;
+	rcq_nq = qplib_qp->rcq->nq;
+	bnxt_re_synchronize_nq(scq_nq);
+	if (scq_nq != rcq_nq)
+		bnxt_re_synchronize_nq(rcq_nq);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d44b6a5c90b5..f1aa3e19b6de 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -386,6 +386,24 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 	spin_unlock_bh(&hwq->lock);
 }
 
+/* bnxt_re_synchronize_nq - self polling notification queue.
+ * @nq      -     notification queue pointer
+ *
+ * This function will start polling entries of a given notification queue
+ * for all pending  entries.
+ * This function is useful to synchronize notification entries while resources
+ * are going away.
+ */
+
+void bnxt_re_synchronize_nq(struct bnxt_qplib_nq *nq)
+{
+	int budget = nq->budget;
+
+	nq->budget = nq->hwq.max_elements;
+	bnxt_qplib_service_nq(&nq->nq_tasklet);
+	nq->budget = budget;
+}
+
 static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 {
 	struct bnxt_qplib_nq *nq = dev_instance;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index f859710f9a7f..49d89c080827 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -548,6 +548,7 @@ int bnxt_qplib_process_flush_list(struct bnxt_qplib_cq *cq,
 				  struct bnxt_qplib_cqe *cqe,
 				  int num_cqes);
 void bnxt_qplib_flush_cqn_wq(struct bnxt_qplib_qp *qp);
+void bnxt_re_synchronize_nq(struct bnxt_qplib_nq *nq);
 
 static inline void *bnxt_qplib_get_swqe(struct bnxt_qplib_q *que, u32 *swq_idx)
 {
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 1ac7067e21be..ad14c2404e94 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2741,13 +2741,13 @@ irdma_sc_cq_modify(struct irdma_sc_cq *cq, struct irdma_modify_cq_info *info,
  */
 void irdma_check_cqp_progress(struct irdma_cqp_timeout *timeout, struct irdma_sc_dev *dev)
 {
-	if (timeout->compl_cqp_cmds != dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]) {
-		timeout->compl_cqp_cmds = dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	u64 completed_ops = atomic64_read(&dev->cqp->completed_ops);
+
+	if (timeout->compl_cqp_cmds != completed_ops) {
+		timeout->compl_cqp_cmds = completed_ops;
 		timeout->count = 0;
-	} else {
-		if (dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] !=
-		    timeout->compl_cqp_cmds)
-			timeout->count++;
+	} else if (timeout->compl_cqp_cmds != dev->cqp->requested_ops) {
+		timeout->count++;
 	}
 }
 
@@ -2790,7 +2790,7 @@ static enum irdma_status_code irdma_cqp_poll_registers(struct irdma_sc_cqp *cqp,
 		if (newtail != tail) {
 			/* SUCCESS */
 			IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-			cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+			atomic64_inc(&cqp->completed_ops);
 			return 0;
 		}
 		udelay(cqp->dev->hw_attrs.max_sleep_count);
@@ -3152,8 +3152,8 @@ enum irdma_status_code irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 	info->dev->cqp = cqp;
 
 	IRDMA_RING_INIT(cqp->sq_ring, cqp->sq_size);
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] = 0;
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS] = 0;
+	cqp->requested_ops = 0;
+	atomic64_set(&cqp->completed_ops, 0);
 	/* for the cqp commands backlog. */
 	INIT_LIST_HEAD(&cqp->dev->cqp_cmd_head);
 
@@ -3306,7 +3306,7 @@ __le64 *irdma_sc_cqp_get_next_send_wqe_idx(struct irdma_sc_cqp *cqp, u64 scratch
 	if (ret_code)
 		return NULL;
 
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS]++;
+	cqp->requested_ops++;
 	if (!*wqe_idx)
 		cqp->polarity = !cqp->polarity;
 	wqe = cqp->sq_base[*wqe_idx].elem;
@@ -3395,6 +3395,9 @@ enum irdma_status_code irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	if (polarity != ccq->cq_uk.polarity)
 		return IRDMA_ERR_Q_EMPTY;
 
+	/* Ensure CEQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	get_64bit_val(cqe, 8, &qp_ctx);
 	cqp = (struct irdma_sc_cqp *)(unsigned long)qp_ctx;
 	info->error = (bool)FIELD_GET(IRDMA_CQ_ERROR, temp);
@@ -3429,7 +3432,7 @@ enum irdma_status_code irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	dma_wmb(); /* make sure shadow area is updated before moving tail */
 
 	IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-	ccq->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+	atomic64_inc(&cqp->completed_ops);
 
 	return ret_code;
 }
@@ -4046,13 +4049,17 @@ enum irdma_status_code irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	u8 polarity;
 
 	aeqe = IRDMA_GET_CURRENT_AEQ_ELEM(aeq);
-	get_64bit_val(aeqe, 0, &compl_ctx);
 	get_64bit_val(aeqe, 8, &temp);
 	polarity = (u8)FIELD_GET(IRDMA_AEQE_VALID, temp);
 
 	if (aeq->polarity != polarity)
 		return IRDMA_ERR_Q_EMPTY;
 
+	/* Ensure AEQE contents are read after valid bit is checked */
+	dma_rmb();
+
+	get_64bit_val(aeqe, 0, &compl_ctx);
+
 	print_hex_dump_debug("WQE: AEQ_ENTRY WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     aeqe, 16, false);
 
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index b8c10a6ccede..afd16a93ac69 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -190,32 +190,30 @@ enum irdma_cqp_op_type {
 	IRDMA_OP_MANAGE_VF_PBLE_BP		= 25,
 	IRDMA_OP_QUERY_FPM_VAL			= 26,
 	IRDMA_OP_COMMIT_FPM_VAL			= 27,
-	IRDMA_OP_REQ_CMDS			= 28,
-	IRDMA_OP_CMPL_CMDS			= 29,
-	IRDMA_OP_AH_CREATE			= 30,
-	IRDMA_OP_AH_MODIFY			= 31,
-	IRDMA_OP_AH_DESTROY			= 32,
-	IRDMA_OP_MC_CREATE			= 33,
-	IRDMA_OP_MC_DESTROY			= 34,
-	IRDMA_OP_MC_MODIFY			= 35,
-	IRDMA_OP_STATS_ALLOCATE			= 36,
-	IRDMA_OP_STATS_FREE			= 37,
-	IRDMA_OP_STATS_GATHER			= 38,
-	IRDMA_OP_WS_ADD_NODE			= 39,
-	IRDMA_OP_WS_MODIFY_NODE			= 40,
-	IRDMA_OP_WS_DELETE_NODE			= 41,
-	IRDMA_OP_WS_FAILOVER_START		= 42,
-	IRDMA_OP_WS_FAILOVER_COMPLETE		= 43,
-	IRDMA_OP_SET_UP_MAP			= 44,
-	IRDMA_OP_GEN_AE				= 45,
-	IRDMA_OP_QUERY_RDMA_FEATURES		= 46,
-	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 47,
-	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 48,
-	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 49,
-	IRDMA_OP_CQ_MODIFY			= 50,
+	IRDMA_OP_AH_CREATE			= 28,
+	IRDMA_OP_AH_MODIFY			= 29,
+	IRDMA_OP_AH_DESTROY			= 30,
+	IRDMA_OP_MC_CREATE			= 31,
+	IRDMA_OP_MC_DESTROY			= 32,
+	IRDMA_OP_MC_MODIFY			= 33,
+	IRDMA_OP_STATS_ALLOCATE			= 34,
+	IRDMA_OP_STATS_FREE			= 35,
+	IRDMA_OP_STATS_GATHER			= 36,
+	IRDMA_OP_WS_ADD_NODE			= 37,
+	IRDMA_OP_WS_MODIFY_NODE			= 38,
+	IRDMA_OP_WS_DELETE_NODE			= 39,
+	IRDMA_OP_WS_FAILOVER_START		= 40,
+	IRDMA_OP_WS_FAILOVER_COMPLETE		= 41,
+	IRDMA_OP_SET_UP_MAP			= 42,
+	IRDMA_OP_GEN_AE				= 43,
+	IRDMA_OP_QUERY_RDMA_FEATURES		= 44,
+	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 45,
+	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 46,
+	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 47,
+	IRDMA_OP_CQ_MODIFY			= 48,
 
 	/* Must be last entry*/
-	IRDMA_MAX_CQP_OPS			= 51,
+	IRDMA_MAX_CQP_OPS			= 49,
 };
 
 /* CQP SQ WQES */
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 2159470d7f7f..70dffa9a9f67 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -191,6 +191,7 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
 	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
 	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
+	case IRDMA_AE_AMP_MWBIND_VALID_STAG:
 		qp->flush_code = FLUSH_MW_BIND_ERR;
 		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
@@ -2084,7 +2085,7 @@ void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq)
 			cqp_request->compl_info.error = info.error;
 
 			if (cqp_request->waiting) {
-				cqp_request->request_done = true;
+				WRITE_ONCE(cqp_request->request_done, true);
 				wake_up(&cqp_request->waitq);
 				irdma_put_cqp_request(&rf->cqp, cqp_request);
 			} else {
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 454b4b370386..f2e2bc50c6f7 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -160,8 +160,8 @@ struct irdma_cqp_request {
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
+	bool request_done; /* READ/WRITE_ONCE macros operate on it */
 	bool waiting:1;
-	bool request_done:1;
 	bool dynamic:1;
 };
 
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 58e7d875643b..197eba5eb78f 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -235,6 +235,9 @@ irdma_puda_poll_info(struct irdma_sc_cq *cq, struct irdma_puda_cmpl_info *info)
 	if (valid_bit != cq_uk->polarity)
 		return IRDMA_ERR_Q_EMPTY;
 
+	/* Ensure CQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	if (cq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 		ext_valid = (bool)FIELD_GET(IRDMA_CQ_EXTCQE, qword3);
 
@@ -248,6 +251,9 @@ irdma_puda_poll_info(struct irdma_sc_cq *cq, struct irdma_puda_cmpl_info *info)
 		if (polarity != cq_uk->polarity)
 			return IRDMA_ERR_Q_EMPTY;
 
+		/* Ensure ext CQE contents are read after ext valid bit is checked */
+		dma_rmb();
+
 		IRDMA_RING_MOVE_HEAD_NOCHECK(cq_uk->cq_ring);
 		if (!IRDMA_RING_CURRENT_HEAD(cq_uk->cq_ring))
 			cq_uk->polarity = !cq_uk->polarity;
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 1241e5988c10..8b75e2610e5b 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -411,6 +411,8 @@ struct irdma_sc_cqp {
 	struct irdma_dcqcn_cc_params dcqcn_params;
 	__le64 *host_ctx;
 	u64 *scratch_array;
+	u64 requested_ops;
+	atomic64_t completed_ops;
 	u32 cqp_id;
 	u32 sq_size;
 	u32 hw_sq_size;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a348f0c010ab..4b00a9adbe3a 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1549,6 +1549,9 @@ void irdma_uk_clean_cq(void *q, struct irdma_cq_uk *cq)
 		if (polarity != temp)
 			break;
 
+		/* Ensure CQE contents are read after valid bit is checked */
+		dma_rmb();
+
 		get_64bit_val(cqe, 8, &comp_ctx);
 		if ((void *)(unsigned long)comp_ctx == q)
 			set_64bit_val(cqe, 8, 0);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 1d9280d46d08..a47eedb6df82 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -481,7 +481,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		cqp_request->request_done = false;
+		WRITE_ONCE(cqp_request->request_done, false);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 
@@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		cqp_request->request_done = true;
+		WRITE_ONCE(cqp_request->request_done, true);
 		wake_up(&cqp_request->waitq);
 	}
 	wait_event_timeout(cqp->remove_wq,
@@ -567,11 +567,11 @@ static enum irdma_status_code irdma_wait_event(struct irdma_pci_f *rf,
 	bool cqp_error = false;
 	enum irdma_status_code err_code = 0;
 
-	cqp_timeout.compl_cqp_cmds = rf->sc_dev.cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	cqp_timeout.compl_cqp_cmds = atomic64_read(&rf->sc_dev.cqp->completed_ops);
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-				       cqp_request->request_done,
+				       READ_ONCE(cqp_request->request_done),
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index ec545b8858cc..43b2aad84591 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -530,15 +530,15 @@ static int set_qp_rss(struct mlx4_ib_dev *dev, struct mlx4_ib_rss *rss_ctx,
 		return (-EOPNOTSUPP);
 	}
 
-	if (ucmd->rx_hash_fields_mask & ~(MLX4_IB_RX_HASH_SRC_IPV4	|
-					  MLX4_IB_RX_HASH_DST_IPV4	|
-					  MLX4_IB_RX_HASH_SRC_IPV6	|
-					  MLX4_IB_RX_HASH_DST_IPV6	|
-					  MLX4_IB_RX_HASH_SRC_PORT_TCP	|
-					  MLX4_IB_RX_HASH_DST_PORT_TCP	|
-					  MLX4_IB_RX_HASH_SRC_PORT_UDP	|
-					  MLX4_IB_RX_HASH_DST_PORT_UDP  |
-					  MLX4_IB_RX_HASH_INNER)) {
+	if (ucmd->rx_hash_fields_mask & ~(u64)(MLX4_IB_RX_HASH_SRC_IPV4	|
+					       MLX4_IB_RX_HASH_DST_IPV4	|
+					       MLX4_IB_RX_HASH_SRC_IPV6	|
+					       MLX4_IB_RX_HASH_DST_IPV6	|
+					       MLX4_IB_RX_HASH_SRC_PORT_TCP |
+					       MLX4_IB_RX_HASH_DST_PORT_TCP |
+					       MLX4_IB_RX_HASH_SRC_PORT_UDP |
+					       MLX4_IB_RX_HASH_DST_PORT_UDP |
+					       MLX4_IB_RX_HASH_INNER)) {
 		pr_debug("RX Hash fields_mask has unsupported mask (0x%llx)\n",
 			 ucmd->rx_hash_fields_mask);
 		return (-EOPNOTSUPP);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 69bba0ef4a5d..53f43649f7d0 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1393,7 +1393,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index ebc3a253f735..7c5d8b791592 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -82,6 +82,7 @@ struct bcm6345_l1_chip {
 };
 
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -115,17 +116,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l1_chip *intc,
 
 static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 {
-	struct bcm6345_l1_chip *intc = irq_desc_get_handler_data(desc);
-	struct bcm6345_l1_cpu *cpu;
+	struct bcm6345_l1_cpu *cpu = irq_desc_get_handler_data(desc);
+	struct bcm6345_l1_chip *intc = cpu->intc;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
-#ifdef CONFIG_SMP
-	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
-#else
-	cpu = intc->cpus[0];
-#endif
-
 	chained_irq_enter(chip, desc);
 
 	for (idx = 0; idx < intc->n_words; idx++) {
@@ -257,6 +252,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu)
 		return -ENOMEM;
 
+	cpu->intc = intc;
 	cpu->map_base = ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -272,7 +268,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 59a5d06b2d3e..490e6cfe510e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -267,13 +267,23 @@ static void vpe_to_cpuid_unlock(struct its_vpe *vpe, unsigned long flags)
 	raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
 }
 
+static struct irq_chip its_vpe_irq_chip;
+
 static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
 	int cpu;
 
-	if (map) {
-		cpu = vpe_to_cpuid_lock(map->vpe, flags);
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
+
+	if (vpe) {
+		cpu = vpe_to_cpuid_lock(vpe, flags);
 	} else {
 		/* Physical LPIs are already locked via the irq_desc lock */
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -287,10 +297,18 @@ static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 
 static void irq_to_cpuid_unlock(struct irq_data *d, unsigned long flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
+
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
 
-	if (map)
-		vpe_to_cpuid_unlock(map->vpe, flags);
+	if (vpe)
+		vpe_to_cpuid_unlock(vpe, flags);
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -1427,14 +1445,29 @@ static void wait_for_syncr(void __iomem *rdbase)
 		cpu_relax();
 }
 
-static void direct_lpi_inv(struct irq_data *d)
+static void __direct_lpi_inv(struct irq_data *d, u64 val)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
 	unsigned long flags;
-	u64 val;
 	int cpu;
 
+	/* Target the redistributor this LPI is currently routed to */
+	cpu = irq_to_cpuid_lock(d, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
+	wait_for_syncr(rdbase);
+
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	irq_to_cpuid_unlock(d, flags);
+}
+
+static void direct_lpi_inv(struct irq_data *d)
+{
+	struct its_vlpi_map *map = get_vlpi_map(d);
+	u64 val;
+
 	if (map) {
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
@@ -1447,15 +1480,7 @@ static void direct_lpi_inv(struct irq_data *d)
 		val = d->hwirq;
 	}
 
-	/* Target the redistributor this LPI is currently routed to */
-	cpu = irq_to_cpuid_lock(d, &flags);
-	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
-	gic_write_lpir(val, rdbase + GICR_INVLPIR);
-
-	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	irq_to_cpuid_unlock(d, flags);
+	__direct_lpi_inv(d, val);
 }
 
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
@@ -3936,18 +3961,10 @@ static void its_vpe_send_inv(struct irq_data *d)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 
-	if (gic_rdists->has_direct_lpi) {
-		void __iomem *rdbase;
-
-		/* Target the redistributor this VPE is currently known on */
-		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
-		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
-		wait_for_syncr(rdbase);
-		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-	} else {
+	if (gic_rdists->has_direct_lpi)
+		__direct_lpi_inv(d, d->parent_data->hwirq);
+	else
 		its_vpe_send_cmd(vpe, its_send_inv);
-	}
 }
 
 static void its_vpe_mask_irq(struct irq_data *d)
diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index b61aac00ff40..859073193f5b 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -854,7 +854,13 @@ struct smq_policy {
 
 	struct background_tracker *bg_work;
 
-	bool migrations_allowed;
+	bool migrations_allowed:1;
+
+	/*
+	 * If this is set the policy will try and clean the whole cache
+	 * even if the device is not idle.
+	 */
+	bool cleaner:1;
 };
 
 /*----------------------------------------------------------------*/
@@ -1133,7 +1139,7 @@ static bool clean_target_met(struct smq_policy *mq, bool idle)
 	 * Cache entries may not be populated.  So we cannot rely on the
 	 * size of the clean queue.
 	 */
-	if (idle) {
+	if (idle || mq->cleaner) {
 		/*
 		 * We'd like to clean everything.
 		 */
@@ -1716,11 +1722,9 @@ static void calc_hotspot_params(sector_t origin_size,
 		*hotspot_block_size /= 2u;
 }
 
-static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
-					    sector_t origin_size,
-					    sector_t cache_block_size,
-					    bool mimic_mq,
-					    bool migrations_allowed)
+static struct dm_cache_policy *
+__smq_create(dm_cblock_t cache_size, sector_t origin_size, sector_t cache_block_size,
+	     bool mimic_mq, bool migrations_allowed, bool cleaner)
 {
 	unsigned i;
 	unsigned nr_sentinels_per_queue = 2u * NR_CACHE_LEVELS;
@@ -1807,6 +1811,7 @@ static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
 		goto bad_btracker;
 
 	mq->migrations_allowed = migrations_allowed;
+	mq->cleaner = cleaner;
 
 	return &mq->policy;
 
@@ -1830,21 +1835,24 @@ static struct dm_cache_policy *smq_create(dm_cblock_t cache_size,
 					  sector_t origin_size,
 					  sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, true, false);
 }
 
 static struct dm_cache_policy *mq_create(dm_cblock_t cache_size,
 					 sector_t origin_size,
 					 sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, true, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    true, true, false);
 }
 
 static struct dm_cache_policy *cleaner_create(dm_cblock_t cache_size,
 					      sector_t origin_size,
 					      sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, false);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, false, true);
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index eba277bb8a1f..8d489933d579 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3258,8 +3258,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	r = md_start(&rs->md);
 	if (r) {
 		ti->error = "Failed to start raid array";
-		mddev_unlock(&rs->md);
-		goto bad_md_start;
+		goto bad_unlock;
 	}
 
 	/* If raid4/5/6 journal mode explicitly requested (only possible with journal dev) -> set it */
@@ -3267,8 +3266,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		r = r5c_journal_mode_set(&rs->md, rs->journal_dev.mode);
 		if (r) {
 			ti->error = "Failed to set raid4/5/6 journal mode";
-			mddev_unlock(&rs->md);
-			goto bad_journal_mode_set;
+			goto bad_unlock;
 		}
 	}
 
@@ -3279,14 +3277,14 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
 		if (r)
-			goto bad_stripe_cache;
+			goto bad_unlock;
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
 		if (r)
-			goto bad_check_reshape;
+			goto bad_unlock;
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3295,7 +3293,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
-				goto bad_check_reshape;
+				goto bad_unlock;
 			}
 		}
 	}
@@ -3306,11 +3304,9 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	mddev_unlock(&rs->md);
 	return 0;
 
-bad_md_start:
-bad_journal_mode_set:
-bad_stripe_cache:
-bad_check_reshape:
+bad_unlock:
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 bad:
 	raid_set_free(rs);
 
@@ -3321,7 +3317,9 @@ static void raid_dtr(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
+	mddev_lock_nointr(&rs->md);
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 	raid_set_free(rs);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5a21aeedc1ba..89a270d29369 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6281,6 +6281,8 @@ static void __md_stop(struct mddev *mddev)
 
 void md_stop(struct mddev *mddev)
 {
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 739838623cf6..50e60852f128 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
-obj-$(CONFIG_VXLAN) += vxlan.o
+obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
 obj-$(CONFIG_GTP) += gtp.o
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7b0b4049bd29..69cc36c0840f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1482,6 +1482,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5a43e542b302..5d6062fbebfc 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -734,6 +734,8 @@ static int gs_can_close(struct net_device *netdev)
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(dev);
 	if (rc < 0)
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 753973ac922e..db13311e77e7 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1642,8 +1642,11 @@ static int atl1e_tso_csum(struct atl1e_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 3ccb955eb6f2..c14a3dbd075c 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1139,7 +1139,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto tx_drop;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 375ebf105a9a..87640a2e1794 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -52,7 +52,10 @@ static void hclge_tm_info_to_ieee_ets(struct hclge_dev *hdev,
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		ets->prio_tc[i] = hdev->tm_info.prio_tc[i];
-		ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		if (i < hdev->tm_info.num_tc)
+			ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		else
+			ets->tc_tx_bw[i] = 0;
 
 		if (hdev->tm_info.tc_info[i].tc_sch_mode ==
 		    HCLGE_SCH_MODE_SP)
@@ -123,7 +126,8 @@ static u8 hclge_ets_tc_changed(struct hclge_dev *hdev, struct ieee_ets *ets,
 }
 
 static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
-				       struct ieee_ets *ets, bool *changed)
+				       struct ieee_ets *ets, bool *changed,
+				       u8 tc_num)
 {
 	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
@@ -137,6 +141,13 @@ static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
 				*changed = true;
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
+			if (i >= tc_num) {
+				dev_err(&hdev->pdev->dev,
+					"tc%u is disabled, cannot set ets bw\n",
+					i);
+				return -EINVAL;
+			}
+
 			/* The hardware will switch to sp mode if bandwidth is
 			 * 0, so limit ets bandwidth must be greater than 0.
 			 */
@@ -176,7 +187,7 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	if (ret)
 		return ret;
 
-	ret = hclge_ets_sch_mode_validate(hdev, ets, changed);
+	ret = hclge_ets_sch_mode_validate(hdev, ets, changed, tc_num);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 9cda8b3562b8..dd8b73aebe6a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -677,8 +677,7 @@ static int hclge_dbg_dump_tc(struct hclge_dev *hdev, char *buf, int len)
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		sch_mode_str = ets_weight->tc_weight[i] ? "dwrr" : "sp";
 		pos += scnprintf(buf + pos, len - pos, "%u     %4s    %3u\n",
-				 i, sch_mode_str,
-				 hdev->tm_info.pg_info[0].tc_dwrr[i]);
+				 i, sch_mode_str, ets_weight->tc_weight[i]);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 97a6864f60ef..e7cb6a81e5b6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -732,6 +732,7 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
 static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 {
 #define BW_PERCENT	100
+#define DEFAULT_BW_WEIGHT	1
 
 	u8 i;
 
@@ -753,7 +754,7 @@ static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 		for (k = 0; k < hdev->tm_info.num_tc; k++)
 			hdev->tm_info.pg_info[i].tc_dwrr[k] = BW_PERCENT;
 		for (; k < HNAE3_MAX_TC; k++)
-			hdev->tm_info.pg_info[i].tc_dwrr[k] = 0;
+			hdev->tm_info.pg_info[i].tc_dwrr[k] = DEFAULT_BW_WEIGHT;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index c057343165a5..7c5f874ef335 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1839,7 +1839,7 @@ void i40e_dbg_pf_exit(struct i40e_pf *pf)
 void i40e_dbg_init(void)
 {
 	i40e_dbg_root = debugfs_create_dir(i40e_driver_name, NULL);
-	if (!i40e_dbg_root)
+	if (IS_ERR(i40e_dbg_root))
 		pr_info("init of debugfs failed\n");
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index bcceb2ddfea6..a87f4f1ae684 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2532,9 +2532,6 @@ static void iavf_adminq_task(struct work_struct *work)
 	u32 val, oldval;
 	u16 pending;
 
-	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
-		goto out;
-
 	if (!mutex_trylock(&adapter->crit_lock)) {
 		if (adapter->state == __IAVF_REMOVE)
 			return;
@@ -2543,10 +2540,13 @@ static void iavf_adminq_task(struct work_struct *work)
 		goto out;
 	}
 
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
+		goto unlock;
+
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf)
-		goto out;
+		goto unlock;
 
 	do {
 		ret = iavf_clean_arq_element(hw, &event, &pending);
@@ -2561,7 +2561,6 @@ static void iavf_adminq_task(struct work_struct *work)
 		if (pending != 0)
 			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
 	} while (pending);
-	mutex_unlock(&adapter->crit_lock);
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES)) {
 		if (adapter->netdev_registered ||
@@ -2619,6 +2618,8 @@ static void iavf_adminq_task(struct work_struct *work)
 
 freedom:
 	kfree(event.msg_buf);
+unlock:
+	mutex_unlock(&adapter->crit_lock);
 out:
 	/* re-enable Admin queue interrupt cause */
 	iavf_misc_irq_enable(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 16de603b280c..0106ea3519a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1135,16 +1135,21 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 				     ICE_FLOW_FLD_OFF_INVAL);
 	}
 
-	/* add filter for outer headers */
 	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+
+	assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);
+
+	/* add filter for outer headers */
 	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
 					ICE_FD_HW_SEG_NON_TUN);
-	if (ret == -EEXIST)
-		/* Rule already exists, free memory and continue */
-		devm_kfree(dev, seg);
-	else if (ret)
+	if (ret == -EEXIST) {
+		/* Rule already exists, free memory and count as success */
+		ret = 0;
+		goto err_exit;
+	} else if (ret) {
 		/* could not write filter, free memory */
 		goto err_exit;
+	}
 
 	/* make tunneled filter HW entries if possible */
 	memcpy(&tun_seg[1], seg, sizeof(*seg));
@@ -1159,18 +1164,13 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		devm_kfree(dev, tun_seg);
 	}
 
-	if (perfect_filter)
-		set_bit(fltr_idx, hw->fdir_perfect_fltr);
-	else
-		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
-
 	return ret;
 
 err_exit:
 	devm_kfree(dev, tun_seg);
 	devm_kfree(dev, seg);
 
-	return -EOPNOTSUPP;
+	return ret;
 }
 
 /**
@@ -1684,7 +1684,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
 
 	/* input struct is added to the HW filter list */
-	ice_fdir_update_list_entry(pf, input, fsp->location);
+	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
+	if (ret)
+		goto release_lock;
 
 	ret = ice_fdir_write_all_fltr(pf, input, true);
 	if (ret)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index bcc1c428b4cc..a47dce10d3a7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -316,6 +316,33 @@ static void igc_clean_all_tx_rings(struct igc_adapter *adapter)
 			igc_clean_tx_ring(adapter->tx_ring[i]);
 }
 
+static void igc_disable_tx_ring_hw(struct igc_ring *ring)
+{
+	struct igc_hw *hw = &ring->q_vector->adapter->hw;
+	u8 idx = ring->reg_idx;
+	u32 txdctl;
+
+	txdctl = rd32(IGC_TXDCTL(idx));
+	txdctl &= ~IGC_TXDCTL_QUEUE_ENABLE;
+	txdctl |= IGC_TXDCTL_SWFLUSH;
+	wr32(IGC_TXDCTL(idx), txdctl);
+}
+
+/**
+ * igc_disable_all_tx_rings_hw - Disable all transmit queue operation
+ * @adapter: board private structure
+ */
+static void igc_disable_all_tx_rings_hw(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		igc_disable_tx_ring_hw(tx_ring);
+	}
+}
+
 /**
  * igc_setup_tx_resources - allocate Tx resources (Descriptors)
  * @tx_ring: tx descriptor ring (for a specific queue) to setup
@@ -4975,6 +5002,7 @@ void igc_down(struct igc_adapter *adapter)
 	/* clear VLAN promisc flag so VFTA will be updated if necessary */
 	adapter->flags &= ~IGC_FLAG_VLAN_PROMISC;
 
+	igc_disable_all_tx_rings_hw(adapter);
 	igc_clean_all_tx_rings(adapter);
 	igc_clean_all_rx_rings(adapter);
 }
@@ -7124,18 +7152,6 @@ void igc_enable_rx_ring(struct igc_ring *ring)
 		igc_alloc_rx_buffers(ring, igc_desc_unused(ring));
 }
 
-static void igc_disable_tx_ring_hw(struct igc_ring *ring)
-{
-	struct igc_hw *hw = &ring->q_vector->adapter->hw;
-	u8 idx = ring->reg_idx;
-	u32 txdctl;
-
-	txdctl = rd32(IGC_TXDCTL(idx));
-	txdctl &= ~IGC_TXDCTL_QUEUE_ENABLE;
-	txdctl |= IGC_TXDCTL_SWFLUSH;
-	wr32(IGC_TXDCTL(idx), txdctl);
-}
-
 void igc_disable_tx_ring(struct igc_ring *ring)
 {
 	igc_disable_tx_ring_hw(ring);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6fb9c18297bc..af824370a2f6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8398,7 +8398,7 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 		struct ixgbe_adapter *adapter = q_vector->adapter;
 
 		if (unlikely(skb_tail_pointer(skb) < hdr.network +
-			     VXLAN_HEADROOM))
+			     vxlan_headroom(0)))
 			return;
 
 		/* verify the port is recognized as VXLAN */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 9292a1fab7d3..7011c08d2e01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -207,13 +207,15 @@ void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, u8 addr[6],
 void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 old_val = value;
 
 	if (enable)
 		value |= GMAC_CONFIG_RE | GMAC_CONFIG_TE;
 	else
 		value &= ~(GMAC_CONFIG_TE | GMAC_CONFIG_RE);
 
-	writel(value, ioaddr + GMAC_CONFIG);
+	if (value != old_val)
+		writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void stmmac_dwmac4_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index df33637c5269..1caa6d943a7b 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -307,6 +307,13 @@ static int mv3310_power_up(struct phy_device *phydev)
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
 				 MV_V2_PORT_CTRL_PWRDOWN);
 
+	/* Sometimes, the power down bit doesn't clear immediately, and
+	 * a read of this register causes the bit not to clear. Delay
+	 * 100us to allow the PHY to come out of power down mode before
+	 * the next access.
+	 */
+	udelay(100);
+
 	if (phydev->drv->phy_id != MARVELL_PHY_ID_88X3310 ||
 	    priv->firmware_ver < 0x00030000)
 		return ret;
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d9386d614a94..4dfa9c610974 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2130,6 +2130,15 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
+		    (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |= (IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0351f86494f1..af335f8266c2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3319,6 +3319,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3339,8 +3341,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
deleted file mode 100644
index 129e270e9a7c..000000000000
--- a/drivers/net/vxlan.c
+++ /dev/null
@@ -1,4834 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * VXLAN: Virtual eXtensible Local Area Network
- *
- * Copyright (c) 2012-2013 Vyatta Inc.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/udp.h>
-#include <linux/igmp.h>
-#include <linux/if_ether.h>
-#include <linux/ethtool.h>
-#include <net/arp.h>
-#include <net/ndisc.h>
-#include <net/ipv6_stubs.h>
-#include <net/ip.h>
-#include <net/icmp.h>
-#include <net/rtnetlink.h>
-#include <net/inet_ecn.h>
-#include <net/net_namespace.h>
-#include <net/netns/generic.h>
-#include <net/tun_proto.h>
-#include <net/vxlan.h>
-#include <net/nexthop.h>
-
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/ip6_tunnel.h>
-#include <net/ip6_checksum.h>
-#endif
-
-#define VXLAN_VERSION	"0.1"
-
-#define PORT_HASH_BITS	8
-#define PORT_HASH_SIZE  (1<<PORT_HASH_BITS)
-#define FDB_AGE_DEFAULT 300 /* 5 min */
-#define FDB_AGE_INTERVAL (10 * HZ)	/* rescan interval */
-
-/* UDP port for VXLAN traffic.
- * The IANA assigned port is 4789, but the Linux default is 8472
- * for compatibility with early adopters.
- */
-static unsigned short vxlan_port __read_mostly = 8472;
-module_param_named(udp_port, vxlan_port, ushort, 0444);
-MODULE_PARM_DESC(udp_port, "Destination UDP port");
-
-static bool log_ecn_error = true;
-module_param(log_ecn_error, bool, 0644);
-MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
-
-static unsigned int vxlan_net_id;
-static struct rtnl_link_ops vxlan_link_ops;
-
-static const u8 all_zeros_mac[ETH_ALEN + 2];
-
-static int vxlan_sock_add(struct vxlan_dev *vxlan);
-
-static void vxlan_vs_del_dev(struct vxlan_dev *vxlan);
-
-/* per-network namespace private data for this module */
-struct vxlan_net {
-	struct list_head  vxlan_list;
-	struct hlist_head sock_list[PORT_HASH_SIZE];
-	spinlock_t	  sock_lock;
-	struct notifier_block nexthop_notifier_block;
-};
-
-/* Forwarding table entry */
-struct vxlan_fdb {
-	struct hlist_node hlist;	/* linked list of entries */
-	struct rcu_head	  rcu;
-	unsigned long	  updated;	/* jiffies */
-	unsigned long	  used;
-	struct list_head  remotes;
-	u8		  eth_addr[ETH_ALEN];
-	u16		  state;	/* see ndm_state */
-	__be32		  vni;
-	u16		  flags;	/* see ndm_flags and below */
-	struct list_head  nh_list;
-	struct nexthop __rcu *nh;
-	struct vxlan_dev  __rcu *vdev;
-};
-
-#define NTF_VXLAN_ADDED_BY_USER 0x100
-
-/* salt for hash table */
-static u32 vxlan_salt __read_mostly;
-
-static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
-{
-	return vs->flags & VXLAN_F_COLLECT_METADATA ||
-	       ip_tunnel_collect_metadata();
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static inline
-bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
-{
-	if (a->sa.sa_family != b->sa.sa_family)
-		return false;
-	if (a->sa.sa_family == AF_INET6)
-		return ipv6_addr_equal(&a->sin6.sin6_addr, &b->sin6.sin6_addr);
-	else
-		return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
-}
-
-static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
-{
-	if (nla_len(nla) >= sizeof(struct in6_addr)) {
-		ip->sin6.sin6_addr = nla_get_in6_addr(nla);
-		ip->sa.sa_family = AF_INET6;
-		return 0;
-	} else if (nla_len(nla) >= sizeof(__be32)) {
-		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
-		ip->sa.sa_family = AF_INET;
-		return 0;
-	} else {
-		return -EAFNOSUPPORT;
-	}
-}
-
-static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
-			      const union vxlan_addr *ip)
-{
-	if (ip->sa.sa_family == AF_INET6)
-		return nla_put_in6_addr(skb, attr, &ip->sin6.sin6_addr);
-	else
-		return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
-}
-
-#else /* !CONFIG_IPV6 */
-
-static inline
-bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
-{
-	return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
-}
-
-static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
-{
-	if (nla_len(nla) >= sizeof(struct in6_addr)) {
-		return -EAFNOSUPPORT;
-	} else if (nla_len(nla) >= sizeof(__be32)) {
-		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
-		ip->sa.sa_family = AF_INET;
-		return 0;
-	} else {
-		return -EAFNOSUPPORT;
-	}
-}
-
-static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
-			      const union vxlan_addr *ip)
-{
-	return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
-}
-#endif
-
-/* Virtual Network hash table head */
-static inline struct hlist_head *vni_head(struct vxlan_sock *vs, __be32 vni)
-{
-	return &vs->vni_list[hash_32((__force u32)vni, VNI_HASH_BITS)];
-}
-
-/* Socket hash table head */
-static inline struct hlist_head *vs_head(struct net *net, __be16 port)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-
-	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
-}
-
-/* First remote destination for a forwarding entry.
- * Guaranteed to be non-NULL because remotes are never deleted.
- */
-static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
-{
-	if (rcu_access_pointer(fdb->nh))
-		return NULL;
-	return list_entry_rcu(fdb->remotes.next, struct vxlan_rdst, list);
-}
-
-static inline struct vxlan_rdst *first_remote_rtnl(struct vxlan_fdb *fdb)
-{
-	if (rcu_access_pointer(fdb->nh))
-		return NULL;
-	return list_first_entry(&fdb->remotes, struct vxlan_rdst, list);
-}
-
-/* Find VXLAN socket based on network namespace, address family, UDP port,
- * enabled unshareable flags and socket device binding (see l3mdev with
- * non-default VRF).
- */
-static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
-					  __be16 port, u32 flags, int ifindex)
-{
-	struct vxlan_sock *vs;
-
-	flags &= VXLAN_F_RCV_FLAGS;
-
-	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
-		if (inet_sk(vs->sock->sk)->inet_sport == port &&
-		    vxlan_get_sk_family(vs) == family &&
-		    vs->flags == flags &&
-		    vs->sock->sk->sk_bound_dev_if == ifindex)
-			return vs;
-	}
-	return NULL;
-}
-
-static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs, int ifindex,
-					   __be32 vni)
-{
-	struct vxlan_dev_node *node;
-
-	/* For flow based devices, map all packets to VNI 0 */
-	if (vs->flags & VXLAN_F_COLLECT_METADATA)
-		vni = 0;
-
-	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
-		if (node->vxlan->default_dst.remote_vni != vni)
-			continue;
-
-		if (IS_ENABLED(CONFIG_IPV6)) {
-			const struct vxlan_config *cfg = &node->vxlan->cfg;
-
-			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
-			    cfg->remote_ifindex != ifindex)
-				continue;
-		}
-
-		return node->vxlan;
-	}
-
-	return NULL;
-}
-
-/* Look up VNI in a per net namespace table */
-static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
-					__be32 vni, sa_family_t family,
-					__be16 port, u32 flags)
-{
-	struct vxlan_sock *vs;
-
-	vs = vxlan_find_sock(net, family, port, flags, ifindex);
-	if (!vs)
-		return NULL;
-
-	return vxlan_vs_find_vni(vs, ifindex, vni);
-}
-
-/* Fill in neighbour message in skbuff. */
-static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
-			  const struct vxlan_fdb *fdb,
-			  u32 portid, u32 seq, int type, unsigned int flags,
-			  const struct vxlan_rdst *rdst)
-{
-	unsigned long now = jiffies;
-	struct nda_cacheinfo ci;
-	bool send_ip, send_eth;
-	struct nlmsghdr *nlh;
-	struct nexthop *nh;
-	struct ndmsg *ndm;
-	int nh_family;
-	u32 nh_id;
-
-	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
-	if (nlh == NULL)
-		return -EMSGSIZE;
-
-	ndm = nlmsg_data(nlh);
-	memset(ndm, 0, sizeof(*ndm));
-
-	send_eth = send_ip = true;
-
-	rcu_read_lock();
-	nh = rcu_dereference(fdb->nh);
-	if (nh) {
-		nh_family = nexthop_get_family(nh);
-		nh_id = nh->id;
-	}
-	rcu_read_unlock();
-
-	if (type == RTM_GETNEIGH) {
-		if (rdst) {
-			send_ip = !vxlan_addr_any(&rdst->remote_ip);
-			ndm->ndm_family = send_ip ? rdst->remote_ip.sa.sa_family : AF_INET;
-		} else if (nh) {
-			ndm->ndm_family = nh_family;
-		}
-		send_eth = !is_zero_ether_addr(fdb->eth_addr);
-	} else
-		ndm->ndm_family	= AF_BRIDGE;
-	ndm->ndm_state = fdb->state;
-	ndm->ndm_ifindex = vxlan->dev->ifindex;
-	ndm->ndm_flags = fdb->flags;
-	if (rdst && rdst->offloaded)
-		ndm->ndm_flags |= NTF_OFFLOADED;
-	ndm->ndm_type = RTN_UNICAST;
-
-	if (!net_eq(dev_net(vxlan->dev), vxlan->net) &&
-	    nla_put_s32(skb, NDA_LINK_NETNSID,
-			peernet2id(dev_net(vxlan->dev), vxlan->net)))
-		goto nla_put_failure;
-
-	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->eth_addr))
-		goto nla_put_failure;
-	if (nh) {
-		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
-			goto nla_put_failure;
-	} else if (rdst) {
-		if (send_ip && vxlan_nla_put_addr(skb, NDA_DST,
-						  &rdst->remote_ip))
-			goto nla_put_failure;
-
-		if (rdst->remote_port &&
-		    rdst->remote_port != vxlan->cfg.dst_port &&
-		    nla_put_be16(skb, NDA_PORT, rdst->remote_port))
-			goto nla_put_failure;
-		if (rdst->remote_vni != vxlan->default_dst.remote_vni &&
-		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
-			goto nla_put_failure;
-		if (rdst->remote_ifindex &&
-		    nla_put_u32(skb, NDA_IFINDEX, rdst->remote_ifindex))
-			goto nla_put_failure;
-	}
-
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->vni &&
-	    nla_put_u32(skb, NDA_SRC_VNI,
-			be32_to_cpu(fdb->vni)))
-		goto nla_put_failure;
-
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
-	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
-	ci.ndm_refcnt	 = 0;
-
-	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
-		goto nla_put_failure;
-
-	nlmsg_end(skb, nlh);
-	return 0;
-
-nla_put_failure:
-	nlmsg_cancel(skb, nlh);
-	return -EMSGSIZE;
-}
-
-static inline size_t vxlan_nlmsg_size(void)
-{
-	return NLMSG_ALIGN(sizeof(struct ndmsg))
-		+ nla_total_size(ETH_ALEN) /* NDA_LLADDR */
-		+ nla_total_size(sizeof(struct in6_addr)) /* NDA_DST */
-		+ nla_total_size(sizeof(__be16)) /* NDA_PORT */
-		+ nla_total_size(sizeof(__be32)) /* NDA_VNI */
-		+ nla_total_size(sizeof(__u32)) /* NDA_IFINDEX */
-		+ nla_total_size(sizeof(__s32)) /* NDA_LINK_NETNSID */
-		+ nla_total_size(sizeof(struct nda_cacheinfo));
-}
-
-static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			       struct vxlan_rdst *rd, int type)
-{
-	struct net *net = dev_net(vxlan->dev);
-	struct sk_buff *skb;
-	int err = -ENOBUFS;
-
-	skb = nlmsg_new(vxlan_nlmsg_size(), GFP_ATOMIC);
-	if (skb == NULL)
-		goto errout;
-
-	err = vxlan_fdb_info(skb, vxlan, fdb, 0, 0, type, 0, rd);
-	if (err < 0) {
-		/* -EMSGSIZE implies BUG in vxlan_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
-	return;
-errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
-}
-
-static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
-			    const struct vxlan_fdb *fdb,
-			    const struct vxlan_rdst *rd,
-			    struct netlink_ext_ack *extack,
-			    struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	fdb_info->info.dev = vxlan->dev;
-	fdb_info->info.extack = extack;
-	fdb_info->remote_ip = rd->remote_ip;
-	fdb_info->remote_port = rd->remote_port;
-	fdb_info->remote_vni = rd->remote_vni;
-	fdb_info->remote_ifindex = rd->remote_ifindex;
-	memcpy(fdb_info->eth_addr, fdb->eth_addr, ETH_ALEN);
-	fdb_info->vni = fdb->vni;
-	fdb_info->offloaded = rd->offloaded;
-	fdb_info->added_by_user = fdb->flags & NTF_VXLAN_ADDED_BY_USER;
-}
-
-static int vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
-					      struct vxlan_fdb *fdb,
-					      struct vxlan_rdst *rd,
-					      bool adding,
-					      struct netlink_ext_ack *extack)
-{
-	struct switchdev_notifier_vxlan_fdb_info info;
-	enum switchdev_notifier_type notifier_type;
-	int ret;
-
-	if (WARN_ON(!rd))
-		return 0;
-
-	notifier_type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE
-			       : SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE;
-	vxlan_fdb_switchdev_notifier_info(vxlan, fdb, rd, NULL, &info);
-	ret = call_switchdev_notifiers(notifier_type, vxlan->dev,
-				       &info.info, extack);
-	return notifier_to_errno(ret);
-}
-
-static int vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			    struct vxlan_rdst *rd, int type, bool swdev_notify,
-			    struct netlink_ext_ack *extack)
-{
-	int err;
-
-	if (swdev_notify && rd) {
-		switch (type) {
-		case RTM_NEWNEIGH:
-			err = vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
-								 true, extack);
-			if (err)
-				return err;
-			break;
-		case RTM_DELNEIGH:
-			vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
-							   false, extack);
-			break;
-		}
-	}
-
-	__vxlan_fdb_notify(vxlan, fdb, rd, type);
-	return 0;
-}
-
-static void vxlan_ip_miss(struct net_device *dev, union vxlan_addr *ipa)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb f = {
-		.state = NUD_STALE,
-	};
-	struct vxlan_rdst remote = {
-		.remote_ip = *ipa, /* goes to NDA_DST */
-		.remote_vni = cpu_to_be32(VXLAN_N_VID),
-	};
-
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
-}
-
-static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
-{
-	struct vxlan_fdb f = {
-		.state = NUD_STALE,
-	};
-	struct vxlan_rdst remote = { };
-
-	memcpy(f.eth_addr, eth_addr, ETH_ALEN);
-
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
-}
-
-/* Hash Ethernet address */
-static u32 eth_hash(const unsigned char *addr)
-{
-	u64 value = get_unaligned((u64 *)addr);
-
-	/* only want 6 bytes */
-#ifdef __BIG_ENDIAN
-	value >>= 16;
-#else
-	value <<= 16;
-#endif
-	return hash_64(value, FDB_HASH_BITS);
-}
-
-static u32 eth_vni_hash(const unsigned char *addr, __be32 vni)
-{
-	/* use 1 byte of OUI and 3 bytes of NIC */
-	u32 key = get_unaligned((u32 *)(addr + 2));
-
-	return jhash_2words(key, vni, vxlan_salt) & (FDB_HASH_SIZE - 1);
-}
-
-static u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni)
-{
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)
-		return eth_vni_hash(mac, vni);
-	else
-		return eth_hash(mac);
-}
-
-/* Hash chain to use given mac address */
-static inline struct hlist_head *vxlan_fdb_head(struct vxlan_dev *vxlan,
-						const u8 *mac, __be32 vni)
-{
-	return &vxlan->fdb_head[fdb_head_index(vxlan, mac, vni)];
-}
-
-/* Look up Ethernet address in forwarding table */
-static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
-					  const u8 *mac, __be32 vni)
-{
-	struct hlist_head *head = vxlan_fdb_head(vxlan, mac, vni);
-	struct vxlan_fdb *f;
-
-	hlist_for_each_entry_rcu(f, head, hlist) {
-		if (ether_addr_equal(mac, f->eth_addr)) {
-			if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
-				if (vni == f->vni)
-					return f;
-			} else {
-				return f;
-			}
-		}
-	}
-
-	return NULL;
-}
-
-static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
-					const u8 *mac, __be32 vni)
-{
-	struct vxlan_fdb *f;
-
-	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
-
-	return f;
-}
-
-/* caller should hold vxlan->hash_lock */
-static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
-					      union vxlan_addr *ip, __be16 port,
-					      __be32 vni, __u32 ifindex)
-{
-	struct vxlan_rdst *rd;
-
-	list_for_each_entry(rd, &f->remotes, list) {
-		if (vxlan_addr_equal(&rd->remote_ip, ip) &&
-		    rd->remote_port == port &&
-		    rd->remote_vni == vni &&
-		    rd->remote_ifindex == ifindex)
-			return rd;
-	}
-
-	return NULL;
-}
-
-int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
-		      struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	u8 eth_addr[ETH_ALEN + 2] = { 0 };
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	int rc = 0;
-
-	if (is_multicast_ether_addr(mac) ||
-	    is_zero_ether_addr(mac))
-		return -EINVAL;
-
-	ether_addr_copy(eth_addr, mac);
-
-	rcu_read_lock();
-
-	f = __vxlan_find_mac(vxlan, eth_addr, vni);
-	if (!f) {
-		rc = -ENOENT;
-		goto out;
-	}
-
-	rdst = first_remote_rcu(f);
-	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
-
-out:
-	rcu_read_unlock();
-	return rc;
-}
-EXPORT_SYMBOL_GPL(vxlan_fdb_find_uc);
-
-static int vxlan_fdb_notify_one(struct notifier_block *nb,
-				const struct vxlan_dev *vxlan,
-				const struct vxlan_fdb *f,
-				const struct vxlan_rdst *rdst,
-				struct netlink_ext_ack *extack)
-{
-	struct switchdev_notifier_vxlan_fdb_info fdb_info;
-	int rc;
-
-	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, extack, &fdb_info);
-	rc = nb->notifier_call(nb, SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
-			       &fdb_info);
-	return notifier_to_errno(rc);
-}
-
-int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
-		     struct notifier_block *nb,
-		     struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	unsigned int h;
-	int rc = 0;
-
-	if (!netif_is_vxlan(dev))
-		return -EINVAL;
-	vxlan = netdev_priv(dev);
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_bh(&vxlan->hash_lock[h]);
-		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
-			if (f->vni == vni) {
-				list_for_each_entry(rdst, &f->remotes, list) {
-					rc = vxlan_fdb_notify_one(nb, vxlan,
-								  f, rdst,
-								  extack);
-					if (rc)
-						goto unlock;
-				}
-			}
-		}
-		spin_unlock_bh(&vxlan->hash_lock[h]);
-	}
-	return 0;
-
-unlock:
-	spin_unlock_bh(&vxlan->hash_lock[h]);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
-
-void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	unsigned int h;
-
-	if (!netif_is_vxlan(dev))
-		return;
-	vxlan = netdev_priv(dev);
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_bh(&vxlan->hash_lock[h]);
-		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
-			if (f->vni == vni)
-				list_for_each_entry(rdst, &f->remotes, list)
-					rdst->offloaded = false;
-		spin_unlock_bh(&vxlan->hash_lock[h]);
-	}
-
-}
-EXPORT_SYMBOL_GPL(vxlan_fdb_clear_offload);
-
-/* Replace destination of unicast mac */
-static int vxlan_fdb_replace(struct vxlan_fdb *f,
-			     union vxlan_addr *ip, __be16 port, __be32 vni,
-			     __u32 ifindex, struct vxlan_rdst *oldrd)
-{
-	struct vxlan_rdst *rd;
-
-	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
-	if (rd)
-		return 0;
-
-	rd = list_first_entry_or_null(&f->remotes, struct vxlan_rdst, list);
-	if (!rd)
-		return 0;
-
-	*oldrd = *rd;
-	dst_cache_reset(&rd->dst_cache);
-	rd->remote_ip = *ip;
-	rd->remote_port = port;
-	rd->remote_vni = vni;
-	rd->remote_ifindex = ifindex;
-	rd->offloaded = false;
-	return 1;
-}
-
-/* Add/update destinations for multicast */
-static int vxlan_fdb_append(struct vxlan_fdb *f,
-			    union vxlan_addr *ip, __be16 port, __be32 vni,
-			    __u32 ifindex, struct vxlan_rdst **rdp)
-{
-	struct vxlan_rdst *rd;
-
-	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
-	if (rd)
-		return 0;
-
-	rd = kmalloc(sizeof(*rd), GFP_ATOMIC);
-	if (rd == NULL)
-		return -ENOMEM;
-
-	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
-		kfree(rd);
-		return -ENOMEM;
-	}
-
-	rd->remote_ip = *ip;
-	rd->remote_port = port;
-	rd->offloaded = false;
-	rd->remote_vni = vni;
-	rd->remote_ifindex = ifindex;
-
-	list_add_tail_rcu(&rd->list, &f->remotes);
-
-	*rdp = rd;
-	return 1;
-}
-
-static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
-					  unsigned int off,
-					  struct vxlanhdr *vh, size_t hdrlen,
-					  __be32 vni_field,
-					  struct gro_remcsum *grc,
-					  bool nopartial)
-{
-	size_t start, offset;
-
-	if (skb->remcsum_offload)
-		return vh;
-
-	if (!NAPI_GRO_CB(skb)->csum_valid)
-		return NULL;
-
-	start = vxlan_rco_start(vni_field);
-	offset = start + vxlan_rco_offset(vni_field);
-
-	vh = skb_gro_remcsum_process(skb, (void *)vh, off, hdrlen,
-				     start, offset, grc, nopartial);
-
-	skb->remcsum_offload = 1;
-
-	return vh;
-}
-
-static struct sk_buff *vxlan_gro_receive(struct sock *sk,
-					 struct list_head *head,
-					 struct sk_buff *skb)
-{
-	struct sk_buff *pp = NULL;
-	struct sk_buff *p;
-	struct vxlanhdr *vh, *vh2;
-	unsigned int hlen, off_vx;
-	int flush = 1;
-	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
-	__be32 flags;
-	struct gro_remcsum grc;
-
-	skb_gro_remcsum_init(&grc);
-
-	off_vx = skb_gro_offset(skb);
-	hlen = off_vx + sizeof(*vh);
-	vh   = skb_gro_header_fast(skb, off_vx);
-	if (skb_gro_header_hard(skb, hlen)) {
-		vh = skb_gro_header_slow(skb, hlen, off_vx);
-		if (unlikely(!vh))
-			goto out;
-	}
-
-	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
-
-	flags = vh->vx_flags;
-
-	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
-		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
-				       vh->vx_vni, &grc,
-				       !!(vs->flags &
-					  VXLAN_F_REMCSUM_NOPARTIAL));
-
-		if (!vh)
-			goto out;
-	}
-
-	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
-
-	list_for_each_entry(p, head, list) {
-		if (!NAPI_GRO_CB(p)->same_flow)
-			continue;
-
-		vh2 = (struct vxlanhdr *)(p->data + off_vx);
-		if (vh->vx_flags != vh2->vx_flags ||
-		    vh->vx_vni != vh2->vx_vni) {
-			NAPI_GRO_CB(p)->same_flow = 0;
-			continue;
-		}
-	}
-
-	pp = call_gro_receive(eth_gro_receive, head, skb);
-	flush = 0;
-
-out:
-	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
-
-	return pp;
-}
-
-static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
-{
-	/* Sets 'skb->inner_mac_header' since we are always called with
-	 * 'skb->encapsulation' set.
-	 */
-	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
-}
-
-static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
-					 __u16 state, __be32 src_vni,
-					 __u16 ndm_flags)
-{
-	struct vxlan_fdb *f;
-
-	f = kmalloc(sizeof(*f), GFP_ATOMIC);
-	if (!f)
-		return NULL;
-	f->state = state;
-	f->flags = ndm_flags;
-	f->updated = f->used = jiffies;
-	f->vni = src_vni;
-	f->nh = NULL;
-	RCU_INIT_POINTER(f->vdev, vxlan);
-	INIT_LIST_HEAD(&f->nh_list);
-	INIT_LIST_HEAD(&f->remotes);
-	memcpy(f->eth_addr, mac, ETH_ALEN);
-
-	return f;
-}
-
-static void vxlan_fdb_insert(struct vxlan_dev *vxlan, const u8 *mac,
-			     __be32 src_vni, struct vxlan_fdb *f)
-{
-	++vxlan->addrcnt;
-	hlist_add_head_rcu(&f->hlist,
-			   vxlan_fdb_head(vxlan, mac, src_vni));
-}
-
-static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			       u32 nhid, struct netlink_ext_ack *extack)
-{
-	struct nexthop *old_nh = rtnl_dereference(fdb->nh);
-	struct nexthop *nh;
-	int err = -EINVAL;
-
-	if (old_nh && old_nh->id == nhid)
-		return 0;
-
-	nh = nexthop_find_by_id(vxlan->net, nhid);
-	if (!nh) {
-		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
-		goto err_inval;
-	}
-
-	if (nh) {
-		if (!nexthop_get(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
-			nh = NULL;
-			goto err_inval;
-		}
-		if (!nexthop_is_fdb(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop is not a fdb nexthop");
-			goto err_inval;
-		}
-
-		if (!nexthop_is_multipath(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop is not a multipath group");
-			goto err_inval;
-		}
-
-		/* check nexthop group family */
-		switch (vxlan->default_dst.remote_ip.sa.sa_family) {
-		case AF_INET:
-			if (!nexthop_has_v4(nh)) {
-				err = -EAFNOSUPPORT;
-				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
-				goto err_inval;
-			}
-			break;
-		case AF_INET6:
-			if (nexthop_has_v4(nh)) {
-				err = -EAFNOSUPPORT;
-				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
-				goto err_inval;
-			}
-		}
-	}
-
-	if (old_nh) {
-		list_del_rcu(&fdb->nh_list);
-		nexthop_put(old_nh);
-	}
-	rcu_assign_pointer(fdb->nh, nh);
-	list_add_tail_rcu(&fdb->nh_list, &nh->fdb_list);
-	return 1;
-
-err_inval:
-	if (nh)
-		nexthop_put(nh);
-	return err;
-}
-
-static int vxlan_fdb_create(struct vxlan_dev *vxlan,
-			    const u8 *mac, union vxlan_addr *ip,
-			    __u16 state, __be16 port, __be32 src_vni,
-			    __be32 vni, __u32 ifindex, __u16 ndm_flags,
-			    u32 nhid, struct vxlan_fdb **fdb,
-			    struct netlink_ext_ack *extack)
-{
-	struct vxlan_rdst *rd = NULL;
-	struct vxlan_fdb *f;
-	int rc;
-
-	if (vxlan->cfg.addrmax &&
-	    vxlan->addrcnt >= vxlan->cfg.addrmax)
-		return -ENOSPC;
-
-	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-	f = vxlan_fdb_alloc(vxlan, mac, state, src_vni, ndm_flags);
-	if (!f)
-		return -ENOMEM;
-
-	if (nhid)
-		rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
-	else
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-	if (rc < 0)
-		goto errout;
-
-	*fdb = f;
-
-	return 0;
-
-errout:
-	kfree(f);
-	return rc;
-}
-
-static void __vxlan_fdb_free(struct vxlan_fdb *f)
-{
-	struct vxlan_rdst *rd, *nd;
-	struct nexthop *nh;
-
-	nh = rcu_dereference_raw(f->nh);
-	if (nh) {
-		rcu_assign_pointer(f->nh, NULL);
-		rcu_assign_pointer(f->vdev, NULL);
-		nexthop_put(nh);
-	}
-
-	list_for_each_entry_safe(rd, nd, &f->remotes, list) {
-		dst_cache_destroy(&rd->dst_cache);
-		kfree(rd);
-	}
-	kfree(f);
-}
-
-static void vxlan_fdb_free(struct rcu_head *head)
-{
-	struct vxlan_fdb *f = container_of(head, struct vxlan_fdb, rcu);
-
-	__vxlan_fdb_free(f);
-}
-
-static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
-			      bool do_notify, bool swdev_notify)
-{
-	struct vxlan_rdst *rd;
-
-	netdev_dbg(vxlan->dev, "delete %pM\n", f->eth_addr);
-
-	--vxlan->addrcnt;
-	if (do_notify) {
-		if (rcu_access_pointer(f->nh))
-			vxlan_fdb_notify(vxlan, f, NULL, RTM_DELNEIGH,
-					 swdev_notify, NULL);
-		else
-			list_for_each_entry(rd, &f->remotes, list)
-				vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH,
-						 swdev_notify, NULL);
-	}
-
-	hlist_del_rcu(&f->hlist);
-	list_del_rcu(&f->nh_list);
-	call_rcu(&f->rcu, vxlan_fdb_free);
-}
-
-static void vxlan_dst_free(struct rcu_head *head)
-{
-	struct vxlan_rdst *rd = container_of(head, struct vxlan_rdst, rcu);
-
-	dst_cache_destroy(&rd->dst_cache);
-	kfree(rd);
-}
-
-static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
-				     union vxlan_addr *ip,
-				     __u16 state, __u16 flags,
-				     __be16 port, __be32 vni,
-				     __u32 ifindex, __u16 ndm_flags,
-				     struct vxlan_fdb *f, u32 nhid,
-				     bool swdev_notify,
-				     struct netlink_ext_ack *extack)
-{
-	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
-	struct vxlan_rdst *rd = NULL;
-	struct vxlan_rdst oldrd;
-	int notify = 0;
-	int rc = 0;
-	int err;
-
-	if (nhid && !rcu_access_pointer(f->nh)) {
-		NL_SET_ERR_MSG(extack,
-			       "Cannot replace an existing non nexthop fdb with a nexthop");
-		return -EOPNOTSUPP;
-	}
-
-	if (nhid && (flags & NLM_F_APPEND)) {
-		NL_SET_ERR_MSG(extack,
-			       "Cannot append to a nexthop fdb");
-		return -EOPNOTSUPP;
-	}
-
-	/* Do not allow an externally learned entry to take over an entry added
-	 * by the user.
-	 */
-	if (!(fdb_flags & NTF_EXT_LEARNED) ||
-	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
-		if (f->state != state) {
-			f->state = state;
-			f->updated = jiffies;
-			notify = 1;
-		}
-		if (f->flags != fdb_flags) {
-			f->flags = fdb_flags;
-			f->updated = jiffies;
-			notify = 1;
-		}
-	}
-
-	if ((flags & NLM_F_REPLACE)) {
-		/* Only change unicasts */
-		if (!(is_multicast_ether_addr(f->eth_addr) ||
-		      is_zero_ether_addr(f->eth_addr))) {
-			if (nhid) {
-				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
-				if (rc < 0)
-					return rc;
-			} else {
-				rc = vxlan_fdb_replace(f, ip, port, vni,
-						       ifindex, &oldrd);
-			}
-			notify |= rc;
-		} else {
-			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
-			return -EOPNOTSUPP;
-		}
-	}
-	if ((flags & NLM_F_APPEND) &&
-	    (is_multicast_ether_addr(f->eth_addr) ||
-	     is_zero_ether_addr(f->eth_addr))) {
-		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-
-		if (rc < 0)
-			return rc;
-		notify |= rc;
-	}
-
-	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
-
-	if (notify) {
-		if (rd == NULL)
-			rd = first_remote_rtnl(f);
-
-		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
-				       swdev_notify, extack);
-		if (err)
-			goto err_notify;
-	}
-
-	return 0;
-
-err_notify:
-	if (nhid)
-		return err;
-	if ((flags & NLM_F_REPLACE) && rc)
-		*rd = oldrd;
-	else if ((flags & NLM_F_APPEND) && rc) {
-		list_del_rcu(&rd->list);
-		call_rcu(&rd->rcu, vxlan_dst_free);
-	}
-	return err;
-}
-
-static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
-				   const u8 *mac, union vxlan_addr *ip,
-				   __u16 state, __u16 flags,
-				   __be16 port, __be32 src_vni, __be32 vni,
-				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
-				   bool swdev_notify,
-				   struct netlink_ext_ack *extack)
-{
-	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
-	struct vxlan_fdb *f;
-	int rc;
-
-	/* Disallow replace to add a multicast entry */
-	if ((flags & NLM_F_REPLACE) &&
-	    (is_multicast_ether_addr(mac) || is_zero_ether_addr(mac)))
-		return -EOPNOTSUPP;
-
-	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-	rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
-			      vni, ifindex, fdb_flags, nhid, &f, extack);
-	if (rc < 0)
-		return rc;
-
-	vxlan_fdb_insert(vxlan, mac, src_vni, f);
-	rc = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
-			      swdev_notify, extack);
-	if (rc)
-		goto err_notify;
-
-	return 0;
-
-err_notify:
-	vxlan_fdb_destroy(vxlan, f, false, false);
-	return rc;
-}
-
-/* Add new entry to forwarding table -- assumes lock held */
-static int vxlan_fdb_update(struct vxlan_dev *vxlan,
-			    const u8 *mac, union vxlan_addr *ip,
-			    __u16 state, __u16 flags,
-			    __be16 port, __be32 src_vni, __be32 vni,
-			    __u32 ifindex, __u16 ndm_flags, u32 nhid,
-			    bool swdev_notify,
-			    struct netlink_ext_ack *extack)
-{
-	struct vxlan_fdb *f;
-
-	f = __vxlan_find_mac(vxlan, mac, src_vni);
-	if (f) {
-		if (flags & NLM_F_EXCL) {
-			netdev_dbg(vxlan->dev,
-				   "lost race to create %pM\n", mac);
-			return -EEXIST;
-		}
-
-		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
-						 vni, ifindex, ndm_flags, f,
-						 nhid, swdev_notify, extack);
-	} else {
-		if (!(flags & NLM_F_CREATE))
-			return -ENOENT;
-
-		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
-					       port, src_vni, vni, ifindex,
-					       ndm_flags, nhid, swdev_notify,
-					       extack);
-	}
-}
-
-static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
-				  struct vxlan_rdst *rd, bool swdev_notify)
-{
-	list_del_rcu(&rd->list);
-	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, swdev_notify, NULL);
-	call_rcu(&rd->rcu, vxlan_dst_free);
-}
-
-static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
-			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
-			   __be32 *vni, u32 *ifindex, u32 *nhid)
-{
-	struct net *net = dev_net(vxlan->dev);
-	int err;
-
-	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
-	    tb[NDA_PORT]))
-		return -EINVAL;
-
-	if (tb[NDA_DST]) {
-		err = vxlan_nla_get_addr(ip, tb[NDA_DST]);
-		if (err)
-			return err;
-	} else {
-		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
-
-		if (remote->sa.sa_family == AF_INET) {
-			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
-			ip->sa.sa_family = AF_INET;
-#if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			ip->sin6.sin6_addr = in6addr_any;
-			ip->sa.sa_family = AF_INET6;
-#endif
-		}
-	}
-
-	if (tb[NDA_PORT]) {
-		if (nla_len(tb[NDA_PORT]) != sizeof(__be16))
-			return -EINVAL;
-		*port = nla_get_be16(tb[NDA_PORT]);
-	} else {
-		*port = vxlan->cfg.dst_port;
-	}
-
-	if (tb[NDA_VNI]) {
-		if (nla_len(tb[NDA_VNI]) != sizeof(u32))
-			return -EINVAL;
-		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
-	} else {
-		*vni = vxlan->default_dst.remote_vni;
-	}
-
-	if (tb[NDA_SRC_VNI]) {
-		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32))
-			return -EINVAL;
-		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
-	} else {
-		*src_vni = vxlan->default_dst.remote_vni;
-	}
-
-	if (tb[NDA_IFINDEX]) {
-		struct net_device *tdev;
-
-		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
-			return -EINVAL;
-		*ifindex = nla_get_u32(tb[NDA_IFINDEX]);
-		tdev = __dev_get_by_index(net, *ifindex);
-		if (!tdev)
-			return -EADDRNOTAVAIL;
-	} else {
-		*ifindex = 0;
-	}
-
-	if (tb[NDA_NH_ID])
-		*nhid = nla_get_u32(tb[NDA_NH_ID]);
-	else
-		*nhid = 0;
-
-	return 0;
-}
-
-/* Add static entry (via netlink) */
-static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			 struct net_device *dev,
-			 const unsigned char *addr, u16 vid, u16 flags,
-			 struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	/* struct net *net = dev_net(vxlan->dev); */
-	union vxlan_addr ip;
-	__be16 port;
-	__be32 src_vni, vni;
-	u32 ifindex, nhid;
-	u32 hash_index;
-	int err;
-
-	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
-		pr_info("RTM_NEWNEIGH with invalid state %#x\n",
-			ndm->ndm_state);
-		return -EINVAL;
-	}
-
-	if (!tb || (!tb[NDA_DST] && !tb[NDA_NH_ID]))
-		return -EINVAL;
-
-	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
-			      &nhid);
-	if (err)
-		return err;
-
-	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
-		return -EAFNOSUPPORT;
-
-	hash_index = fdb_head_index(vxlan, addr, src_vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
-			       port, src_vni, vni, ifindex,
-			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
-			       nhid, true, extack);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-static int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
-			      const unsigned char *addr, union vxlan_addr ip,
-			      __be16 port, __be32 src_vni, __be32 vni,
-			      u32 ifindex, bool swdev_notify)
-{
-	struct vxlan_rdst *rd = NULL;
-	struct vxlan_fdb *f;
-	int err = -ENOENT;
-
-	f = vxlan_find_mac(vxlan, addr, src_vni);
-	if (!f)
-		return err;
-
-	if (!vxlan_addr_any(&ip)) {
-		rd = vxlan_fdb_find_rdst(f, &ip, port, vni, ifindex);
-		if (!rd)
-			goto out;
-	}
-
-	/* remove a destination if it's not the only one on the list,
-	 * otherwise destroy the fdb entry
-	 */
-	if (rd && !list_is_singular(&f->remotes)) {
-		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
-		goto out;
-	}
-
-	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
-
-out:
-	return 0;
-}
-
-/* Delete entry (via netlink) */
-static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr, u16 vid)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	union vxlan_addr ip;
-	__be32 src_vni, vni;
-	u32 ifindex, nhid;
-	u32 hash_index;
-	__be16 port;
-	int err;
-
-	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
-			      &nhid);
-	if (err)
-		return err;
-
-	hash_index = fdb_head_index(vxlan, addr, src_vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	err = __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
-				 true);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-/* Dump forwarding table */
-static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
-			  struct net_device *dev,
-			  struct net_device *filter_dev, int *idx)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	unsigned int h;
-	int err = 0;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct vxlan_fdb *f;
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(f, &vxlan->fdb_head[h], hlist) {
-			struct vxlan_rdst *rd;
-
-			if (rcu_access_pointer(f->nh)) {
-				if (*idx < cb->args[2])
-					goto skip_nh;
-				err = vxlan_fdb_info(skb, vxlan, f,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWNEIGH,
-						     NLM_F_MULTI, NULL);
-				if (err < 0) {
-					rcu_read_unlock();
-					goto out;
-				}
-skip_nh:
-				*idx += 1;
-				continue;
-			}
-
-			list_for_each_entry_rcu(rd, &f->remotes, list) {
-				if (*idx < cb->args[2])
-					goto skip;
-
-				err = vxlan_fdb_info(skb, vxlan, f,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWNEIGH,
-						     NLM_F_MULTI, rd);
-				if (err < 0) {
-					rcu_read_unlock();
-					goto out;
-				}
-skip:
-				*idx += 1;
-			}
-		}
-		rcu_read_unlock();
-	}
-out:
-	return err;
-}
-
-static int vxlan_fdb_get(struct sk_buff *skb,
-			 struct nlattr *tb[],
-			 struct net_device *dev,
-			 const unsigned char *addr,
-			 u16 vid, u32 portid, u32 seq,
-			 struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb *f;
-	__be32 vni;
-	int err;
-
-	if (tb[NDA_VNI])
-		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
-	else
-		vni = vxlan->default_dst.remote_vni;
-
-	rcu_read_lock();
-
-	f = __vxlan_find_mac(vxlan, addr, vni);
-	if (!f) {
-		NL_SET_ERR_MSG(extack, "Fdb entry not found");
-		err = -ENOENT;
-		goto errout;
-	}
-
-	err = vxlan_fdb_info(skb, vxlan, f, portid, seq,
-			     RTM_NEWNEIGH, 0, first_remote_rcu(f));
-errout:
-	rcu_read_unlock();
-	return err;
-}
-
-/* Watch incoming packets to learn mapping between Ethernet address
- * and Tunnel endpoint.
- * Return true if packet is bogus and should be dropped.
- */
-static bool vxlan_snoop(struct net_device *dev,
-			union vxlan_addr *src_ip, const u8 *src_mac,
-			u32 src_ifindex, __be32 vni)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb *f;
-	u32 ifindex = 0;
-
-#if IS_ENABLED(CONFIG_IPV6)
-	if (src_ip->sa.sa_family == AF_INET6 &&
-	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
-		ifindex = src_ifindex;
-#endif
-
-	f = vxlan_find_mac(vxlan, src_mac, vni);
-	if (likely(f)) {
-		struct vxlan_rdst *rdst = first_remote_rcu(f);
-
-		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
-			   rdst->remote_ifindex == ifindex))
-			return false;
-
-		/* Don't migrate static entries, drop packets */
-		if (f->state & (NUD_PERMANENT | NUD_NOARP))
-			return true;
-
-		/* Don't override an fdb with nexthop with a learnt entry */
-		if (rcu_access_pointer(f->nh))
-			return true;
-
-		if (net_ratelimit())
-			netdev_info(dev,
-				    "%pM migrated from %pIS to %pIS\n",
-				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
-
-		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
-		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
-	} else {
-		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
-
-		/* learned new entry */
-		spin_lock(&vxlan->hash_lock[hash_index]);
-
-		/* close off race between vxlan_flush and incoming packets */
-		if (netif_running(dev))
-			vxlan_fdb_update(vxlan, src_mac, src_ip,
-					 NUD_REACHABLE,
-					 NLM_F_EXCL|NLM_F_CREATE,
-					 vxlan->cfg.dst_port,
-					 vni,
-					 vxlan->default_dst.remote_vni,
-					 ifindex, NTF_SELF, 0, true, NULL);
-		spin_unlock(&vxlan->hash_lock[hash_index]);
-	}
-
-	return false;
-}
-
-/* See if multicast group is already in use by other ID */
-static bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *sock4;
-#if IS_ENABLED(CONFIG_IPV6)
-	struct vxlan_sock *sock6;
-#endif
-	unsigned short family = dev->default_dst.remote_ip.sa.sa_family;
-
-	sock4 = rtnl_dereference(dev->vn4_sock);
-
-	/* The vxlan_sock is only used by dev, leaving group has
-	 * no effect on other vxlan devices.
-	 */
-	if (family == AF_INET && sock4 && refcount_read(&sock4->refcnt) == 1)
-		return false;
-#if IS_ENABLED(CONFIG_IPV6)
-	sock6 = rtnl_dereference(dev->vn6_sock);
-	if (family == AF_INET6 && sock6 && refcount_read(&sock6->refcnt) == 1)
-		return false;
-#endif
-
-	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
-		if (!netif_running(vxlan->dev) || vxlan == dev)
-			continue;
-
-		if (family == AF_INET &&
-		    rtnl_dereference(vxlan->vn4_sock) != sock4)
-			continue;
-#if IS_ENABLED(CONFIG_IPV6)
-		if (family == AF_INET6 &&
-		    rtnl_dereference(vxlan->vn6_sock) != sock6)
-			continue;
-#endif
-
-		if (!vxlan_addr_equal(&vxlan->default_dst.remote_ip,
-				      &dev->default_dst.remote_ip))
-			continue;
-
-		if (vxlan->default_dst.remote_ifindex !=
-		    dev->default_dst.remote_ifindex)
-			continue;
-
-		return true;
-	}
-
-	return false;
-}
-
-static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
-{
-	struct vxlan_net *vn;
-
-	if (!vs)
-		return false;
-	if (!refcount_dec_and_test(&vs->refcnt))
-		return false;
-
-	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
-	spin_lock(&vn->sock_lock);
-	hlist_del_rcu(&vs->hlist);
-	udp_tunnel_notify_del_rx_port(vs->sock,
-				      (vs->flags & VXLAN_F_GPE) ?
-				      UDP_TUNNEL_TYPE_VXLAN_GPE :
-				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
-
-	return true;
-}
-
-static void vxlan_sock_release(struct vxlan_dev *vxlan)
-{
-	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
-#if IS_ENABLED(CONFIG_IPV6)
-	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
-
-	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
-#endif
-
-	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
-	synchronize_net();
-
-	vxlan_vs_del_dev(vxlan);
-
-	if (__vxlan_sock_release_prep(sock4)) {
-		udp_tunnel_sock_release(sock4->sock);
-		kfree(sock4);
-	}
-
-#if IS_ENABLED(CONFIG_IPV6)
-	if (__vxlan_sock_release_prep(sock6)) {
-		udp_tunnel_sock_release(sock6->sock);
-		kfree(sock6);
-	}
-#endif
-}
-
-/* Update multicast group membership when first VNI on
- * multicast address is brought up
- */
-static int vxlan_igmp_join(struct vxlan_dev *vxlan)
-{
-	struct sock *sk;
-	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
-	int ifindex = vxlan->default_dst.remote_ifindex;
-	int ret = -EINVAL;
-
-	if (ip->sa.sa_family == AF_INET) {
-		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
-		struct ip_mreqn mreq = {
-			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
-			.imr_ifindex		= ifindex,
-		};
-
-		sk = sock4->sock->sk;
-		lock_sock(sk);
-		ret = ip_mc_join_group(sk, &mreq);
-		release_sock(sk);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
-
-		sk = sock6->sock->sk;
-		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
-						   &ip->sin6.sin6_addr);
-		release_sock(sk);
-#endif
-	}
-
-	return ret;
-}
-
-/* Inverse of vxlan_igmp_join when last VNI is brought down */
-static int vxlan_igmp_leave(struct vxlan_dev *vxlan)
-{
-	struct sock *sk;
-	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
-	int ifindex = vxlan->default_dst.remote_ifindex;
-	int ret = -EINVAL;
-
-	if (ip->sa.sa_family == AF_INET) {
-		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
-		struct ip_mreqn mreq = {
-			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
-			.imr_ifindex		= ifindex,
-		};
-
-		sk = sock4->sock->sk;
-		lock_sock(sk);
-		ret = ip_mc_leave_group(sk, &mreq);
-		release_sock(sk);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
-
-		sk = sock6->sock->sk;
-		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
-						   &ip->sin6.sin6_addr);
-		release_sock(sk);
-#endif
-	}
-
-	return ret;
-}
-
-static bool vxlan_remcsum(struct vxlanhdr *unparsed,
-			  struct sk_buff *skb, u32 vxflags)
-{
-	size_t start, offset;
-
-	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
-		goto out;
-
-	start = vxlan_rco_start(unparsed->vx_vni);
-	offset = start + vxlan_rco_offset(unparsed->vx_vni);
-
-	if (!pskb_may_pull(skb, offset + sizeof(u16)))
-		return false;
-
-	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
-			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
-out:
-	unparsed->vx_flags &= ~VXLAN_HF_RCO;
-	unparsed->vx_vni &= VXLAN_VNI_MASK;
-	return true;
-}
-
-static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
-				struct sk_buff *skb, u32 vxflags,
-				struct vxlan_metadata *md)
-{
-	struct vxlanhdr_gbp *gbp = (struct vxlanhdr_gbp *)unparsed;
-	struct metadata_dst *tun_dst;
-
-	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
-		goto out;
-
-	md->gbp = ntohs(gbp->policy_id);
-
-	tun_dst = (struct metadata_dst *)skb_dst(skb);
-	if (tun_dst) {
-		tun_dst->u.tun_info.key.tun_flags |= TUNNEL_VXLAN_OPT;
-		tun_dst->u.tun_info.options_len = sizeof(*md);
-	}
-	if (gbp->dont_learn)
-		md->gbp |= VXLAN_GBP_DONT_LEARN;
-
-	if (gbp->policy_applied)
-		md->gbp |= VXLAN_GBP_POLICY_APPLIED;
-
-	/* In flow-based mode, GBP is carried in dst_metadata */
-	if (!(vxflags & VXLAN_F_COLLECT_METADATA))
-		skb->mark = md->gbp;
-out:
-	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
-}
-
-static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
-				__be16 *protocol,
-				struct sk_buff *skb, u32 vxflags)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
-
-	/* Need to have Next Protocol set for interfaces in GPE mode. */
-	if (!gpe->np_applied)
-		return false;
-	/* "The initial version is 0. If a receiver does not support the
-	 * version indicated it MUST drop the packet.
-	 */
-	if (gpe->version != 0)
-		return false;
-	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
-	 * processing MUST occur." However, we don't implement OAM
-	 * processing, thus drop the packet.
-	 */
-	if (gpe->oam_flag)
-		return false;
-
-	*protocol = tun_p_to_eth_p(gpe->next_protocol);
-	if (!*protocol)
-		return false;
-
-	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
-	return true;
-}
-
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
-{
-	union vxlan_addr saddr;
-	u32 ifindex = skb->dev->ifindex;
-
-	skb_reset_mac_header(skb);
-	skb->protocol = eth_type_trans(skb, vxlan->dev);
-	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
-
-	/* Ignore packet loops (and multicast echo) */
-	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
-
-	/* Get address from the outer IP header */
-	if (vxlan_get_sk_family(vs) == AF_INET) {
-		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
-		saddr.sa.sa_family = AF_INET;
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
-		saddr.sa.sa_family = AF_INET6;
-#endif
-	}
-
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
-	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
-
-	return true;
-}
-
-static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
-				  struct sk_buff *skb)
-{
-	int err = 0;
-
-	if (vxlan_get_sk_family(vs) == AF_INET)
-		err = IP_ECN_decapsulate(oiph, skb);
-#if IS_ENABLED(CONFIG_IPV6)
-	else
-		err = IP6_ECN_decapsulate(oiph, skb);
-#endif
-
-	if (unlikely(err) && log_ecn_error) {
-		if (vxlan_get_sk_family(vs) == AF_INET)
-			net_info_ratelimited("non-ECT from %pI4 with TOS=%#x\n",
-					     &((struct iphdr *)oiph)->saddr,
-					     ((struct iphdr *)oiph)->tos);
-		else
-			net_info_ratelimited("non-ECT from %pI6\n",
-					     &((struct ipv6hdr *)oiph)->saddr);
-	}
-	return err <= 1;
-}
-
-/* Callback from net/ipv4/udp.c to receive packets */
-static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *vs;
-	struct vxlanhdr unparsed;
-	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
-	__be16 protocol = htons(ETH_P_TEB);
-	bool raw_proto = false;
-	void *oiph;
-	__be32 vni = 0;
-
-	/* Need UDP and VXLAN header to be present */
-	if (!pskb_may_pull(skb, VXLAN_HLEN))
-		goto drop;
-
-	unparsed = *vxlan_hdr(skb);
-	/* VNI flag always required to be set */
-	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
-		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
-			   ntohl(vxlan_hdr(skb)->vx_flags),
-			   ntohl(vxlan_hdr(skb)->vx_vni));
-		/* Return non vxlan pkt */
-		goto drop;
-	}
-	unparsed.vx_flags &= ~VXLAN_HF_VNI;
-	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
-
-	vs = rcu_dereference_sk_user_data(sk);
-	if (!vs)
-		goto drop;
-
-	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
-
-	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
-	if (!vxlan)
-		goto drop;
-
-	/* For backwards compatibility, only allow reserved fields to be
-	 * used by VXLAN extensions if explicitly requested.
-	 */
-	if (vs->flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
-			goto drop;
-		raw_proto = true;
-	}
-
-	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
-		goto drop;
-
-	if (vs->flags & VXLAN_F_REMCSUM_RX)
-		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
-			goto drop;
-
-	if (vxlan_collect_metadata(vs)) {
-		struct metadata_dst *tun_dst;
-
-		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), TUNNEL_KEY,
-					 key32_to_tunnel_id(vni), sizeof(*md));
-
-		if (!tun_dst)
-			goto drop;
-
-		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
-
-		skb_dst_set(skb, (struct dst_entry *)tun_dst);
-	} else {
-		memset(md, 0, sizeof(*md));
-	}
-
-	if (vs->flags & VXLAN_F_GBP)
-		vxlan_parse_gbp_hdr(&unparsed, skb, vs->flags, md);
-	/* Note that GBP and GPE can never be active together. This is
-	 * ensured in vxlan_dev_configure.
-	 */
-
-	if (unparsed.vx_flags || unparsed.vx_vni) {
-		/* If there are any unprocessed flags remaining treat
-		 * this as a malformed packet. This behavior diverges from
-		 * VXLAN RFC (RFC7348) which stipulates that bits in reserved
-		 * in reserved fields are to be ignored. The approach here
-		 * maintains compatibility with previous stack code, and also
-		 * is more robust and provides a little more security in
-		 * adding extensions to VXLAN.
-		 */
-		goto drop;
-	}
-
-	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
-			goto drop;
-	} else {
-		skb_reset_mac_header(skb);
-		skb->dev = vxlan->dev;
-		skb->pkt_type = PACKET_HOST;
-	}
-
-	oiph = skb_network_header(skb);
-	skb_reset_network_header(skb);
-
-	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
-		++vxlan->dev->stats.rx_frame_errors;
-		++vxlan->dev->stats.rx_errors;
-		goto drop;
-	}
-
-	rcu_read_lock();
-
-	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
-		rcu_read_unlock();
-		atomic_long_inc(&vxlan->dev->rx_dropped);
-		goto drop;
-	}
-
-	dev_sw_netstats_rx_add(vxlan->dev, skb->len);
-	gro_cells_receive(&vxlan->gro_cells, skb);
-
-	rcu_read_unlock();
-
-	return 0;
-
-drop:
-	/* Consume bad packet */
-	kfree_skb(skb);
-	return 0;
-}
-
-/* Callback from net/ipv{4,6}/udp.c to check that we have a VNI for errors */
-static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *vs;
-	struct vxlanhdr *hdr;
-	__be32 vni;
-
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + VXLAN_HLEN))
-		return -EINVAL;
-
-	hdr = vxlan_hdr(skb);
-
-	if (!(hdr->vx_flags & VXLAN_HF_VNI))
-		return -EINVAL;
-
-	vs = rcu_dereference_sk_user_data(sk);
-	if (!vs)
-		return -ENOENT;
-
-	vni = vxlan_vni(hdr->vx_vni);
-	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
-	if (!vxlan)
-		return -ENOENT;
-
-	return 0;
-}
-
-static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct arphdr *parp;
-	u8 *arpptr, *sha;
-	__be32 sip, tip;
-	struct neighbour *n;
-
-	if (dev->flags & IFF_NOARP)
-		goto out;
-
-	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev->stats.tx_dropped++;
-		goto out;
-	}
-	parp = arp_hdr(skb);
-
-	if ((parp->ar_hrd != htons(ARPHRD_ETHER) &&
-	     parp->ar_hrd != htons(ARPHRD_IEEE802)) ||
-	    parp->ar_pro != htons(ETH_P_IP) ||
-	    parp->ar_op != htons(ARPOP_REQUEST) ||
-	    parp->ar_hln != dev->addr_len ||
-	    parp->ar_pln != 4)
-		goto out;
-	arpptr = (u8 *)parp + sizeof(struct arphdr);
-	sha = arpptr;
-	arpptr += dev->addr_len;	/* sha */
-	memcpy(&sip, arpptr, sizeof(sip));
-	arpptr += sizeof(sip);
-	arpptr += dev->addr_len;	/* tha */
-	memcpy(&tip, arpptr, sizeof(tip));
-
-	if (ipv4_is_loopback(tip) ||
-	    ipv4_is_multicast(tip))
-		goto out;
-
-	n = neigh_lookup(&arp_tbl, &tip, dev);
-
-	if (n) {
-		struct vxlan_fdb *f;
-		struct sk_buff	*reply;
-
-		if (!(n->nud_state & NUD_CONNECTED)) {
-			neigh_release(n);
-			goto out;
-		}
-
-		f = vxlan_find_mac(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
-			/* bridge-local neighbor */
-			neigh_release(n);
-			goto out;
-		}
-
-		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
-				n->ha, sha);
-
-		neigh_release(n);
-
-		if (reply == NULL)
-			goto out;
-
-		skb_reset_mac_header(reply);
-		__skb_pull(reply, skb_network_offset(reply));
-		reply->ip_summed = CHECKSUM_UNNECESSARY;
-		reply->pkt_type = PACKET_HOST;
-
-		if (netif_rx_ni(reply) == NET_RX_DROP)
-			dev->stats.rx_dropped++;
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
-		union vxlan_addr ipa = {
-			.sin.sin_addr.s_addr = tip,
-			.sin.sin_family = AF_INET,
-		};
-
-		vxlan_ip_miss(dev, &ipa);
-	}
-out:
-	consume_skb(skb);
-	return NETDEV_TX_OK;
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static struct sk_buff *vxlan_na_create(struct sk_buff *request,
-	struct neighbour *n, bool isrouter)
-{
-	struct net_device *dev = request->dev;
-	struct sk_buff *reply;
-	struct nd_msg *ns, *na;
-	struct ipv6hdr *pip6;
-	u8 *daddr;
-	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
-	int ns_olen;
-	int i, len;
-
-	if (dev == NULL || !pskb_may_pull(request, request->len))
-		return NULL;
-
-	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
-		sizeof(*na) + na_olen + dev->needed_tailroom;
-	reply = alloc_skb(len, GFP_ATOMIC);
-	if (reply == NULL)
-		return NULL;
-
-	reply->protocol = htons(ETH_P_IPV6);
-	reply->dev = dev;
-	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
-	skb_push(reply, sizeof(struct ethhdr));
-	skb_reset_mac_header(reply);
-
-	ns = (struct nd_msg *)(ipv6_hdr(request) + 1);
-
-	daddr = eth_hdr(request)->h_source;
-	ns_olen = request->len - skb_network_offset(request) -
-		sizeof(struct ipv6hdr) - sizeof(*ns);
-	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
-		if (!ns->opt[i + 1]) {
-			kfree_skb(reply);
-			return NULL;
-		}
-		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
-			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
-			break;
-		}
-	}
-
-	/* Ethernet header */
-	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
-	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
-	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
-	reply->protocol = htons(ETH_P_IPV6);
-
-	skb_pull(reply, sizeof(struct ethhdr));
-	skb_reset_network_header(reply);
-	skb_put(reply, sizeof(struct ipv6hdr));
-
-	/* IPv6 header */
-
-	pip6 = ipv6_hdr(reply);
-	memset(pip6, 0, sizeof(struct ipv6hdr));
-	pip6->version = 6;
-	pip6->priority = ipv6_hdr(request)->priority;
-	pip6->nexthdr = IPPROTO_ICMPV6;
-	pip6->hop_limit = 255;
-	pip6->daddr = ipv6_hdr(request)->saddr;
-	pip6->saddr = *(struct in6_addr *)n->primary_key;
-
-	skb_pull(reply, sizeof(struct ipv6hdr));
-	skb_reset_transport_header(reply);
-
-	/* Neighbor Advertisement */
-	na = skb_put_zero(reply, sizeof(*na) + na_olen);
-	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
-	na->icmph.icmp6_router = isrouter;
-	na->icmph.icmp6_override = 1;
-	na->icmph.icmp6_solicited = 1;
-	na->target = ns->target;
-	ether_addr_copy(&na->opt[2], n->ha);
-	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
-	na->opt[1] = na_olen >> 3;
-
-	na->icmph.icmp6_cksum = csum_ipv6_magic(&pip6->saddr,
-		&pip6->daddr, sizeof(*na)+na_olen, IPPROTO_ICMPV6,
-		csum_partial(na, sizeof(*na)+na_olen, 0));
-
-	pip6->payload_len = htons(sizeof(*na)+na_olen);
-
-	skb_push(reply, sizeof(struct ipv6hdr));
-
-	reply->ip_summed = CHECKSUM_UNNECESSARY;
-
-	return reply;
-}
-
-static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct in6_addr *daddr;
-	const struct ipv6hdr *iphdr;
-	struct inet6_dev *in6_dev;
-	struct neighbour *n;
-	struct nd_msg *msg;
-
-	rcu_read_lock();
-	in6_dev = __in6_dev_get(dev);
-	if (!in6_dev)
-		goto out;
-
-	iphdr = ipv6_hdr(skb);
-	daddr = &iphdr->daddr;
-	msg = (struct nd_msg *)(iphdr + 1);
-
-	if (ipv6_addr_loopback(daddr) ||
-	    ipv6_addr_is_multicast(&msg->target))
-		goto out;
-
-	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
-
-	if (n) {
-		struct vxlan_fdb *f;
-		struct sk_buff *reply;
-
-		if (!(n->nud_state & NUD_CONNECTED)) {
-			neigh_release(n);
-			goto out;
-		}
-
-		f = vxlan_find_mac(vxlan, n->ha, vni);
-		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
-			/* bridge-local neighbor */
-			neigh_release(n);
-			goto out;
-		}
-
-		reply = vxlan_na_create(skb, n,
-					!!(f ? f->flags & NTF_ROUTER : 0));
-
-		neigh_release(n);
-
-		if (reply == NULL)
-			goto out;
-
-		if (netif_rx_ni(reply) == NET_RX_DROP)
-			dev->stats.rx_dropped++;
-
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
-		union vxlan_addr ipa = {
-			.sin6.sin6_addr = msg->target,
-			.sin6.sin6_family = AF_INET6,
-		};
-
-		vxlan_ip_miss(dev, &ipa);
-	}
-
-out:
-	rcu_read_unlock();
-	consume_skb(skb);
-	return NETDEV_TX_OK;
-}
-#endif
-
-static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct neighbour *n;
-
-	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
-		return false;
-
-	n = NULL;
-	switch (ntohs(eth_hdr(skb)->h_proto)) {
-	case ETH_P_IP:
-	{
-		struct iphdr *pip;
-
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return false;
-		pip = ip_hdr(skb);
-		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
-			union vxlan_addr ipa = {
-				.sin.sin_addr.s_addr = pip->daddr,
-				.sin.sin_family = AF_INET,
-			};
-
-			vxlan_ip_miss(dev, &ipa);
-			return false;
-		}
-
-		break;
-	}
-#if IS_ENABLED(CONFIG_IPV6)
-	case ETH_P_IPV6:
-	{
-		struct ipv6hdr *pip6;
-
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return false;
-		pip6 = ipv6_hdr(skb);
-		n = neigh_lookup(ipv6_stub->nd_tbl, &pip6->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
-			union vxlan_addr ipa = {
-				.sin6.sin6_addr = pip6->daddr,
-				.sin6.sin6_family = AF_INET6,
-			};
-
-			vxlan_ip_miss(dev, &ipa);
-			return false;
-		}
-
-		break;
-	}
-#endif
-	default:
-		return false;
-	}
-
-	if (n) {
-		bool diff;
-
-		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
-		if (diff) {
-			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
-				dev->addr_len);
-			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
-		}
-		neigh_release(n);
-		return diff;
-	}
-
-	return false;
-}
-
-static void vxlan_build_gbp_hdr(struct vxlanhdr *vxh, u32 vxflags,
-				struct vxlan_metadata *md)
-{
-	struct vxlanhdr_gbp *gbp;
-
-	if (!md->gbp)
-		return;
-
-	gbp = (struct vxlanhdr_gbp *)vxh;
-	vxh->vx_flags |= VXLAN_HF_GBP;
-
-	if (md->gbp & VXLAN_GBP_DONT_LEARN)
-		gbp->dont_learn = 1;
-
-	if (md->gbp & VXLAN_GBP_POLICY_APPLIED)
-		gbp->policy_applied = 1;
-
-	gbp->policy_id = htons(md->gbp & VXLAN_GBP_ID_MASK);
-}
-
-static int vxlan_build_gpe_hdr(struct vxlanhdr *vxh, u32 vxflags,
-			       __be16 protocol)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)vxh;
-
-	gpe->np_applied = 1;
-	gpe->next_protocol = tun_p_from_eth_p(protocol);
-	if (!gpe->next_protocol)
-		return -EPFNOSUPPORT;
-	return 0;
-}
-
-static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
-			   int iphdr_len, __be32 vni,
-			   struct vxlan_metadata *md, u32 vxflags,
-			   bool udp_sum)
-{
-	struct vxlanhdr *vxh;
-	int min_headroom;
-	int err;
-	int type = udp_sum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
-	__be16 inner_protocol = htons(ETH_P_TEB);
-
-	if ((vxflags & VXLAN_F_REMCSUM_TX) &&
-	    skb->ip_summed == CHECKSUM_PARTIAL) {
-		int csum_start = skb_checksum_start_offset(skb);
-
-		if (csum_start <= VXLAN_MAX_REMCSUM_START &&
-		    !(csum_start & VXLAN_RCO_SHIFT_MASK) &&
-		    (skb->csum_offset == offsetof(struct udphdr, check) ||
-		     skb->csum_offset == offsetof(struct tcphdr, check)))
-			type |= SKB_GSO_TUNNEL_REMCSUM;
-	}
-
-	min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len
-			+ VXLAN_HLEN + iphdr_len;
-
-	/* Need space for new headers (invalidates iph ptr) */
-	err = skb_cow_head(skb, min_headroom);
-	if (unlikely(err))
-		return err;
-
-	err = iptunnel_handle_offloads(skb, type);
-	if (err)
-		return err;
-
-	vxh = __skb_push(skb, sizeof(*vxh));
-	vxh->vx_flags = VXLAN_HF_VNI;
-	vxh->vx_vni = vxlan_vni_field(vni);
-
-	if (type & SKB_GSO_TUNNEL_REMCSUM) {
-		unsigned int start;
-
-		start = skb_checksum_start_offset(skb) - sizeof(struct vxlanhdr);
-		vxh->vx_vni |= vxlan_compute_rco(start, skb->csum_offset);
-		vxh->vx_flags |= VXLAN_HF_RCO;
-
-		if (!skb_is_gso(skb)) {
-			skb->ip_summed = CHECKSUM_NONE;
-			skb->encapsulation = 0;
-		}
-	}
-
-	if (vxflags & VXLAN_F_GBP)
-		vxlan_build_gbp_hdr(vxh, vxflags, md);
-	if (vxflags & VXLAN_F_GPE) {
-		err = vxlan_build_gpe_hdr(vxh, vxflags, skb->protocol);
-		if (err < 0)
-			return err;
-		inner_protocol = skb->protocol;
-	}
-
-	skb_set_inner_protocol(skb, inner_protocol);
-	return 0;
-}
-
-static struct rtable *vxlan_get_route(struct vxlan_dev *vxlan, struct net_device *dev,
-				      struct vxlan_sock *sock4,
-				      struct sk_buff *skb, int oif, u8 tos,
-				      __be32 daddr, __be32 *saddr, __be16 dport, __be16 sport,
-				      struct dst_cache *dst_cache,
-				      const struct ip_tunnel_info *info)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct rtable *rt = NULL;
-	struct flowi4 fl4;
-
-	if (!sock4)
-		return ERR_PTR(-EIO);
-
-	if (tos && !info)
-		use_cache = false;
-	if (use_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
-			return rt;
-	}
-
-	memset(&fl4, 0, sizeof(fl4));
-	fl4.flowi4_oif = oif;
-	fl4.flowi4_tos = RT_TOS(tos);
-	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_proto = IPPROTO_UDP;
-	fl4.daddr = daddr;
-	fl4.saddr = *saddr;
-	fl4.fl4_dport = dport;
-	fl4.fl4_sport = sport;
-
-	rt = ip_route_output_key(vxlan->net, &fl4);
-	if (!IS_ERR(rt)) {
-		if (rt->dst.dev == dev) {
-			netdev_dbg(dev, "circular route to %pI4\n", &daddr);
-			ip_rt_put(rt);
-			return ERR_PTR(-ELOOP);
-		}
-
-		*saddr = fl4.saddr;
-		if (use_cache)
-			dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
-	} else {
-		netdev_dbg(dev, "no route to %pI4\n", &daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	return rt;
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
-					  struct net_device *dev,
-					  struct vxlan_sock *sock6,
-					  struct sk_buff *skb, int oif, u8 tos,
-					  __be32 label,
-					  const struct in6_addr *daddr,
-					  struct in6_addr *saddr,
-					  __be16 dport, __be16 sport,
-					  struct dst_cache *dst_cache,
-					  const struct ip_tunnel_info *info)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct dst_entry *ndst;
-	struct flowi6 fl6;
-
-	if (!sock6)
-		return ERR_PTR(-EIO);
-
-	if (tos && !info)
-		use_cache = false;
-	if (use_cache) {
-		ndst = dst_cache_get_ip6(dst_cache, saddr);
-		if (ndst)
-			return ndst;
-	}
-
-	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_oif = oif;
-	fl6.daddr = *daddr;
-	fl6.saddr = *saddr;
-	fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tos), label);
-	fl6.flowi6_mark = skb->mark;
-	fl6.flowi6_proto = IPPROTO_UDP;
-	fl6.fl6_dport = dport;
-	fl6.fl6_sport = sport;
-
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(vxlan->net, sock6->sock->sk,
-					       &fl6, NULL);
-	if (IS_ERR(ndst)) {
-		netdev_dbg(dev, "no route to %pI6\n", daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-
-	if (unlikely(ndst->dev == dev)) {
-		netdev_dbg(dev, "circular route to %pI6\n", daddr);
-		dst_release(ndst);
-		return ERR_PTR(-ELOOP);
-	}
-
-	*saddr = fl6.saddr;
-	if (use_cache)
-		dst_cache_set_ip6(dst_cache, ndst, saddr);
-	return ndst;
-}
-#endif
-
-/* Bypass encapsulation if the destination is local */
-static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
-			       struct vxlan_dev *dst_vxlan, __be32 vni,
-			       bool snoop)
-{
-	struct pcpu_sw_netstats *tx_stats, *rx_stats;
-	union vxlan_addr loopback;
-	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
-	struct net_device *dev;
-	int len = skb->len;
-
-	tx_stats = this_cpu_ptr(src_vxlan->dev->tstats);
-	rx_stats = this_cpu_ptr(dst_vxlan->dev->tstats);
-	skb->pkt_type = PACKET_HOST;
-	skb->encapsulation = 0;
-	skb->dev = dst_vxlan->dev;
-	__skb_pull(skb, skb_network_offset(skb));
-
-	if (remote_ip->sa.sa_family == AF_INET) {
-		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-		loopback.sa.sa_family =  AF_INET;
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		loopback.sin6.sin6_addr = in6addr_loopback;
-		loopback.sa.sa_family =  AF_INET6;
-#endif
-	}
-
-	rcu_read_lock();
-	dev = skb->dev;
-	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
-		goto drop;
-	}
-
-	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
-		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
-
-	u64_stats_update_begin(&tx_stats->syncp);
-	tx_stats->tx_packets++;
-	tx_stats->tx_bytes += len;
-	u64_stats_update_end(&tx_stats->syncp);
-
-	if (netif_rx(skb) == NET_RX_SUCCESS) {
-		u64_stats_update_begin(&rx_stats->syncp);
-		rx_stats->rx_packets++;
-		rx_stats->rx_bytes += len;
-		u64_stats_update_end(&rx_stats->syncp);
-	} else {
-drop:
-		dev->stats.rx_dropped++;
-	}
-	rcu_read_unlock();
-}
-
-static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
-				 struct vxlan_dev *vxlan,
-				 union vxlan_addr *daddr,
-				 __be16 dst_port, int dst_ifindex, __be32 vni,
-				 struct dst_entry *dst,
-				 u32 rt_flags)
-{
-#if IS_ENABLED(CONFIG_IPV6)
-	/* IPv6 rt-flags are checked against RTF_LOCAL, but the value of
-	 * RTF_LOCAL is equal to RTCF_LOCAL. So to keep code simple
-	 * we can use RTCF_LOCAL which works for ipv4 and ipv6 route entry.
-	 */
-	BUILD_BUG_ON(RTCF_LOCAL != RTF_LOCAL);
-#endif
-	/* Bypass encapsulation if the destination is local */
-	if (rt_flags & RTCF_LOCAL &&
-	    !(rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))) {
-		struct vxlan_dev *dst_vxlan;
-
-		dst_release(dst);
-		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
-					   daddr->sa.sa_family, dst_port,
-					   vxlan->cfg.flags);
-		if (!dst_vxlan) {
-			dev->stats.tx_errors++;
-			kfree_skb(skb);
-
-			return -ENOENT;
-		}
-		vxlan_encap_bypass(skb, vxlan, dst_vxlan, vni, true);
-		return 1;
-	}
-
-	return 0;
-}
-
-static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
-			   __be32 default_vni, struct vxlan_rdst *rdst,
-			   bool did_rsc)
-{
-	struct dst_cache *dst_cache;
-	struct ip_tunnel_info *info;
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct iphdr *old_iph = ip_hdr(skb);
-	union vxlan_addr *dst;
-	union vxlan_addr remote_ip, local_ip;
-	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
-	__be16 src_port = 0, dst_port;
-	struct dst_entry *ndst = NULL;
-	__be32 vni, label;
-	__u8 tos, ttl;
-	int ifindex;
-	int err;
-	u32 flags = vxlan->cfg.flags;
-	bool udp_sum = false;
-	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
-
-	info = skb_tunnel_info(skb);
-
-	if (rdst) {
-		dst = &rdst->remote_ip;
-		if (vxlan_addr_any(dst)) {
-			if (did_rsc) {
-				/* short-circuited back to local bridge */
-				vxlan_encap_bypass(skb, vxlan, vxlan,
-						   default_vni, true);
-				return;
-			}
-			goto drop;
-		}
-
-		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
-		vni = (rdst->remote_vni) ? : default_vni;
-		ifindex = rdst->remote_ifindex;
-		local_ip = vxlan->cfg.saddr;
-		dst_cache = &rdst->dst_cache;
-		md->gbp = skb->mark;
-		if (flags & VXLAN_F_TTL_INHERIT) {
-			ttl = ip_tunnel_get_ttl(old_iph, skb);
-		} else {
-			ttl = vxlan->cfg.ttl;
-			if (!ttl && vxlan_addr_multicast(dst))
-				ttl = 1;
-		}
-
-		tos = vxlan->cfg.tos;
-		if (tos == 1)
-			tos = ip_tunnel_get_dsfield(old_iph, skb);
-
-		if (dst->sa.sa_family == AF_INET)
-			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
-		else
-			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
-		label = vxlan->cfg.label;
-	} else {
-		if (!info) {
-			WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
-				  dev->name);
-			goto drop;
-		}
-		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
-		if (remote_ip.sa.sa_family == AF_INET) {
-			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
-			local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
-		} else {
-			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
-			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
-		}
-		dst = &remote_ip;
-		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
-		vni = tunnel_id_to_key32(info->key.tun_id);
-		ifindex = 0;
-		dst_cache = &info->dst_cache;
-		if (info->key.tun_flags & TUNNEL_VXLAN_OPT) {
-			if (info->options_len < sizeof(*md))
-				goto drop;
-			md = ip_tunnel_info_opts(info);
-		}
-		ttl = info->key.ttl;
-		tos = info->key.tos;
-		label = info->key.label;
-		udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
-	}
-	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				     vxlan->cfg.port_max, true);
-
-	rcu_read_lock();
-	if (dst->sa.sa_family == AF_INET) {
-		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
-		struct rtable *rt;
-		__be16 df = 0;
-
-		if (!ifindex)
-			ifindex = sock4->sock->sk->sk_bound_dev_if;
-
-		rt = vxlan_get_route(vxlan, dev, sock4, skb, ifindex, tos,
-				     dst->sin.sin_addr.s_addr,
-				     &local_ip.sin.sin_addr.s_addr,
-				     dst_port, src_port,
-				     dst_cache, info);
-		if (IS_ERR(rt)) {
-			err = PTR_ERR(rt);
-			goto tx_error;
-		}
-
-		if (!info) {
-			/* Bypass encapsulation if the destination is local */
-			err = encap_bypass_if_local(skb, dev, vxlan, dst,
-						    dst_port, ifindex, vni,
-						    &rt->dst, rt->rt_flags);
-			if (err)
-				goto out_unlock;
-
-			if (vxlan->cfg.df == VXLAN_DF_SET) {
-				df = htons(IP_DF);
-			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
-				struct ethhdr *eth = eth_hdr(skb);
-
-				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
-				    (ntohs(eth->h_proto) == ETH_P_IP &&
-				     old_iph->frag_off & htons(IP_DF)))
-					df = htons(IP_DF);
-			}
-		} else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT) {
-			df = htons(IP_DF);
-		}
-
-		ndst = &rt->dst;
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN_HEADROOM,
-					    netif_is_any_bridge_port(dev));
-		if (err < 0) {
-			goto tx_error;
-		} else if (err) {
-			if (info) {
-				struct ip_tunnel_info *unclone;
-				struct in_addr src, dst;
-
-				unclone = skb_tunnel_info_unclone(skb);
-				if (unlikely(!unclone))
-					goto tx_error;
-
-				src = remote_ip.sin.sin_addr;
-				dst = local_ip.sin.sin_addr;
-				unclone->key.u.ipv4.src = src.s_addr;
-				unclone->key.u.ipv4.dst = dst.s_addr;
-			}
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
-			goto out_unlock;
-		}
-
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
-		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
-		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
-				      vni, md, flags, udp_sum);
-		if (err < 0)
-			goto tx_error;
-
-		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
-				    dst->sin.sin_addr.s_addr, tos, ttl, df,
-				    src_port, dst_port, xnet, !udp_sum);
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
-		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
-
-		if (!ifindex)
-			ifindex = sock6->sock->sk->sk_bound_dev_if;
-
-		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
-					label, &dst->sin6.sin6_addr,
-					&local_ip.sin6.sin6_addr,
-					dst_port, src_port,
-					dst_cache, info);
-		if (IS_ERR(ndst)) {
-			err = PTR_ERR(ndst);
-			ndst = NULL;
-			goto tx_error;
-		}
-
-		if (!info) {
-			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
-
-			err = encap_bypass_if_local(skb, dev, vxlan, dst,
-						    dst_port, ifindex, vni,
-						    ndst, rt6i_flags);
-			if (err)
-				goto out_unlock;
-		}
-
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN6_HEADROOM,
-					    netif_is_any_bridge_port(dev));
-		if (err < 0) {
-			goto tx_error;
-		} else if (err) {
-			if (info) {
-				struct ip_tunnel_info *unclone;
-				struct in6_addr src, dst;
-
-				unclone = skb_tunnel_info_unclone(skb);
-				if (unlikely(!unclone))
-					goto tx_error;
-
-				src = remote_ip.sin6.sin6_addr;
-				dst = local_ip.sin6.sin6_addr;
-				unclone->key.u.ipv6.src = src;
-				unclone->key.u.ipv6.dst = dst;
-			}
-
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
-			goto out_unlock;
-		}
-
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
-		ttl = ttl ? : ip6_dst_hoplimit(ndst);
-		skb_scrub_packet(skb, xnet);
-		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
-				      vni, md, flags, udp_sum);
-		if (err < 0)
-			goto tx_error;
-
-		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
-				     &local_ip.sin6.sin6_addr,
-				     &dst->sin6.sin6_addr, tos, ttl,
-				     label, src_port, dst_port, !udp_sum);
-#endif
-	}
-out_unlock:
-	rcu_read_unlock();
-	return;
-
-drop:
-	dev->stats.tx_dropped++;
-	dev_kfree_skb(skb);
-	return;
-
-tx_error:
-	rcu_read_unlock();
-	if (err == -ELOOP)
-		dev->stats.collisions++;
-	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
-	dst_release(ndst);
-	dev->stats.tx_errors++;
-	kfree_skb(skb);
-}
-
-static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
-			  struct vxlan_fdb *f, __be32 vni, bool did_rsc)
-{
-	struct vxlan_rdst nh_rdst;
-	struct nexthop *nh;
-	bool do_xmit;
-	u32 hash;
-
-	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
-	hash = skb_get_hash(skb);
-
-	rcu_read_lock();
-	nh = rcu_dereference(f->nh);
-	if (!nh) {
-		rcu_read_unlock();
-		goto drop;
-	}
-	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
-	rcu_read_unlock();
-
-	if (likely(do_xmit))
-		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
-	else
-		goto drop;
-
-	return;
-
-drop:
-	dev->stats.tx_dropped++;
-	dev_kfree_skb(skb);
-}
-
-/* Transmit local packets over Vxlan
- *
- * Outer IP header inherits ECN and DF from inner header.
- * Outer UDP destination is the VXLAN assigned port.
- *           source port is based on hash of flow
- */
-static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *rdst, *fdst = NULL;
-	const struct ip_tunnel_info *info;
-	bool did_rsc = false;
-	struct vxlan_fdb *f;
-	struct ethhdr *eth;
-	__be32 vni = 0;
-
-	info = skb_tunnel_info(skb);
-
-	skb_reset_mac_header(skb);
-
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
-		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
-		    info->mode & IP_TUNNEL_INFO_TX) {
-			vni = tunnel_id_to_key32(info->key.tun_id);
-		} else {
-			if (info && info->mode & IP_TUNNEL_INFO_TX)
-				vxlan_xmit_one(skb, dev, vni, NULL, false);
-			else
-				kfree_skb(skb);
-			return NETDEV_TX_OK;
-		}
-	}
-
-	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
-		eth = eth_hdr(skb);
-		if (ntohs(eth->h_proto) == ETH_P_ARP)
-			return arp_reduce(dev, skb, vni);
-#if IS_ENABLED(CONFIG_IPV6)
-		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
-			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-					    sizeof(struct nd_msg)) &&
-			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
-			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
-
-			if (m->icmph.icmp6_code == 0 &&
-			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, vni);
-		}
-#endif
-	}
-
-	eth = eth_hdr(skb);
-	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
-	did_rsc = false;
-
-	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
-	    (ntohs(eth->h_proto) == ETH_P_IP ||
-	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
-		did_rsc = route_shortcircuit(dev, skb);
-		if (did_rsc)
-			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
-	}
-
-	if (f == NULL) {
-		f = vxlan_find_mac(vxlan, all_zeros_mac, vni);
-		if (f == NULL) {
-			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
-			    !is_multicast_ether_addr(eth->h_dest))
-				vxlan_fdb_miss(vxlan, eth->h_dest);
-
-			dev->stats.tx_dropped++;
-			kfree_skb(skb);
-			return NETDEV_TX_OK;
-		}
-	}
-
-	if (rcu_access_pointer(f->nh)) {
-		vxlan_xmit_nh(skb, dev, f,
-			      (vni ? : vxlan->default_dst.remote_vni), did_rsc);
-	} else {
-		list_for_each_entry_rcu(rdst, &f->remotes, list) {
-			struct sk_buff *skb1;
-
-			if (!fdst) {
-				fdst = rdst;
-				continue;
-			}
-			skb1 = skb_clone(skb, GFP_ATOMIC);
-			if (skb1)
-				vxlan_xmit_one(skb1, dev, vni, rdst, did_rsc);
-		}
-		if (fdst)
-			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
-		else
-			kfree_skb(skb);
-	}
-
-	return NETDEV_TX_OK;
-}
-
-/* Walk the forwarding table and purge stale entries */
-static void vxlan_cleanup(struct timer_list *t)
-{
-	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
-	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
-	unsigned int h;
-
-	if (!netif_running(vxlan->dev))
-		return;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct hlist_node *p, *n;
-
-		spin_lock(&vxlan->hash_lock[h]);
-		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
-			struct vxlan_fdb *f
-				= container_of(p, struct vxlan_fdb, hlist);
-			unsigned long timeout;
-
-			if (f->state & (NUD_PERMANENT | NUD_NOARP))
-				continue;
-
-			if (f->flags & NTF_EXT_LEARNED)
-				continue;
-
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
-			if (time_before_eq(timeout, jiffies)) {
-				netdev_dbg(vxlan->dev,
-					   "garbage collect %pM\n",
-					   f->eth_addr);
-				f->state = NUD_STALE;
-				vxlan_fdb_destroy(vxlan, f, true, true);
-			} else if (time_before(timeout, next_timer))
-				next_timer = timeout;
-		}
-		spin_unlock(&vxlan->hash_lock[h]);
-	}
-
-	mod_timer(&vxlan->age_timer, next_timer);
-}
-
-static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
-{
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-
-	spin_lock(&vn->sock_lock);
-	hlist_del_init_rcu(&vxlan->hlist4.hlist);
-#if IS_ENABLED(CONFIG_IPV6)
-	hlist_del_init_rcu(&vxlan->hlist6.hlist);
-#endif
-	spin_unlock(&vn->sock_lock);
-}
-
-static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
-			     struct vxlan_dev_node *node)
-{
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	__be32 vni = vxlan->default_dst.remote_vni;
-
-	node->vxlan = vxlan;
-	spin_lock(&vn->sock_lock);
-	hlist_add_head_rcu(&node->hlist, vni_head(vs, vni));
-	spin_unlock(&vn->sock_lock);
-}
-
-/* Setup stats when device is created */
-static int vxlan_init(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	int err;
-
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
-	err = gro_cells_init(&vxlan->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
-		return err;
-	}
-
-	return 0;
-}
-
-static void vxlan_fdb_delete_default(struct vxlan_dev *vxlan, __be32 vni)
-{
-	struct vxlan_fdb *f;
-	u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, vni);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	f = __vxlan_find_mac(vxlan, all_zeros_mac, vni);
-	if (f)
-		vxlan_fdb_destroy(vxlan, f, true, true);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-}
-
-static void vxlan_uninit(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-
-	gro_cells_destroy(&vxlan->gro_cells);
-
-	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
-
-	free_percpu(dev->tstats);
-}
-
-/* Start ageing timer and join group when device is brought up */
-static int vxlan_open(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	int ret;
-
-	ret = vxlan_sock_add(vxlan);
-	if (ret < 0)
-		return ret;
-
-	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
-		ret = vxlan_igmp_join(vxlan);
-		if (ret == -EADDRINUSE)
-			ret = 0;
-		if (ret) {
-			vxlan_sock_release(vxlan);
-			return ret;
-		}
-	}
-
-	if (vxlan->cfg.age_interval)
-		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
-
-	return ret;
-}
-
-/* Purge the forwarding table */
-static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
-{
-	unsigned int h;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct hlist_node *p, *n;
-
-		spin_lock_bh(&vxlan->hash_lock[h]);
-		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
-			struct vxlan_fdb *f
-				= container_of(p, struct vxlan_fdb, hlist);
-			if (!do_all && (f->state & (NUD_PERMANENT | NUD_NOARP)))
-				continue;
-			/* the all_zeros_mac entry is deleted at vxlan_uninit */
-			if (is_zero_ether_addr(f->eth_addr) &&
-			    f->vni == vxlan->cfg.vni)
-				continue;
-			vxlan_fdb_destroy(vxlan, f, true, true);
-		}
-		spin_unlock_bh(&vxlan->hash_lock[h]);
-	}
-}
-
-/* Cleanup timer and forwarding table on shutdown */
-static int vxlan_stop(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	int ret = 0;
-
-	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
-	    !vxlan_group_used(vn, vxlan))
-		ret = vxlan_igmp_leave(vxlan);
-
-	del_timer_sync(&vxlan->age_timer);
-
-	vxlan_flush(vxlan, false);
-	vxlan_sock_release(vxlan);
-
-	return ret;
-}
-
-/* Stub, nothing needs to be done. */
-static void vxlan_set_multicast_list(struct net_device *dev)
-{
-}
-
-static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
-	bool use_ipv6 = !!(vxlan->cfg.flags & VXLAN_F_IPV6);
-
-	/* This check is different than dev->max_mtu, because it looks at
-	 * the lowerdev->mtu, rather than the static dev->max_mtu
-	 */
-	if (lowerdev) {
-		int max_mtu = lowerdev->mtu -
-			      (use_ipv6 ? VXLAN6_HEADROOM : VXLAN_HEADROOM);
-		if (new_mtu > max_mtu)
-			return -EINVAL;
-	}
-
-	dev->mtu = new_mtu;
-	return 0;
-}
-
-static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct ip_tunnel_info *info = skb_tunnel_info(skb);
-	__be16 sport, dport;
-
-	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				  vxlan->cfg.port_max, true);
-	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
-
-	if (ip_tunnel_info_af(info) == AF_INET) {
-		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
-		struct rtable *rt;
-
-		rt = vxlan_get_route(vxlan, dev, sock4, skb, 0, info->key.tos,
-				     info->key.u.ipv4.dst,
-				     &info->key.u.ipv4.src, dport, sport,
-				     &info->dst_cache, info);
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
-		ip_rt_put(rt);
-	} else {
-#if IS_ENABLED(CONFIG_IPV6)
-		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
-		struct dst_entry *ndst;
-
-		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, 0, info->key.tos,
-					info->key.label, &info->key.u.ipv6.dst,
-					&info->key.u.ipv6.src, dport, sport,
-					&info->dst_cache, info);
-		if (IS_ERR(ndst))
-			return PTR_ERR(ndst);
-		dst_release(ndst);
-#else /* !CONFIG_IPV6 */
-		return -EPFNOSUPPORT;
-#endif
-	}
-	info->key.tp_src = sport;
-	info->key.tp_dst = dport;
-	return 0;
-}
-
-static const struct net_device_ops vxlan_netdev_ether_ops = {
-	.ndo_init		= vxlan_init,
-	.ndo_uninit		= vxlan_uninit,
-	.ndo_open		= vxlan_open,
-	.ndo_stop		= vxlan_stop,
-	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
-	.ndo_set_rx_mode	= vxlan_set_multicast_list,
-	.ndo_change_mtu		= vxlan_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
-	.ndo_fdb_add		= vxlan_fdb_add,
-	.ndo_fdb_del		= vxlan_fdb_delete,
-	.ndo_fdb_dump		= vxlan_fdb_dump,
-	.ndo_fdb_get		= vxlan_fdb_get,
-	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
-	.ndo_change_proto_down  = dev_change_proto_down_generic,
-};
-
-static const struct net_device_ops vxlan_netdev_raw_ops = {
-	.ndo_init		= vxlan_init,
-	.ndo_uninit		= vxlan_uninit,
-	.ndo_open		= vxlan_open,
-	.ndo_stop		= vxlan_stop,
-	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
-	.ndo_change_mtu		= vxlan_change_mtu,
-	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
-};
-
-/* Info for udev, that this is a virtual tunnel endpoint */
-static struct device_type vxlan_type = {
-	.name = "vxlan",
-};
-
-/* Calls the ndo_udp_tunnel_add of the caller in order to
- * supply the listening VXLAN udp ports. Callers are expected
- * to implement the ndo_udp_tunnel_add.
- */
-static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
-{
-	struct vxlan_sock *vs;
-	struct net *net = dev_net(dev);
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	unsigned int i;
-
-	spin_lock(&vn->sock_lock);
-	for (i = 0; i < PORT_HASH_SIZE; ++i) {
-		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
-			unsigned short type;
-
-			if (vs->flags & VXLAN_F_GPE)
-				type = UDP_TUNNEL_TYPE_VXLAN_GPE;
-			else
-				type = UDP_TUNNEL_TYPE_VXLAN;
-
-			if (push)
-				udp_tunnel_push_rx_port(dev, vs->sock, type);
-			else
-				udp_tunnel_drop_rx_port(dev, vs->sock, type);
-		}
-	}
-	spin_unlock(&vn->sock_lock);
-}
-
-/* Initialize the device structure. */
-static void vxlan_setup(struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	unsigned int h;
-
-	eth_hw_addr_random(dev);
-	ether_setup(dev);
-
-	dev->needs_free_netdev = true;
-	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
-
-	dev->features	|= NETIF_F_LLTX;
-	dev->features	|= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
-	dev->features   |= NETIF_F_RXCSUM;
-	dev->features   |= NETIF_F_GSO_SOFTWARE;
-
-	dev->vlan_features = dev->features;
-	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
-	dev->hw_features |= NETIF_F_RXCSUM;
-	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
-	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE;
-
-	/* MTU range: 68 - 65535 */
-	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = ETH_MAX_MTU;
-
-	INIT_LIST_HEAD(&vxlan->next);
-
-	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
-
-	vxlan->dev = dev;
-
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_init(&vxlan->hash_lock[h]);
-		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
-	}
-}
-
-static void vxlan_ether_setup(struct net_device *dev)
-{
-	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	dev->netdev_ops = &vxlan_netdev_ether_ops;
-}
-
-static void vxlan_raw_setup(struct net_device *dev)
-{
-	dev->header_ops = NULL;
-	dev->type = ARPHRD_NONE;
-	dev->hard_header_len = 0;
-	dev->addr_len = 0;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
-	dev->netdev_ops = &vxlan_netdev_raw_ops;
-}
-
-static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
-	[IFLA_VXLAN_ID]		= { .type = NLA_U32 },
-	[IFLA_VXLAN_GROUP]	= { .len = sizeof_field(struct iphdr, daddr) },
-	[IFLA_VXLAN_GROUP6]	= { .len = sizeof(struct in6_addr) },
-	[IFLA_VXLAN_LINK]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_LOCAL]	= { .len = sizeof_field(struct iphdr, saddr) },
-	[IFLA_VXLAN_LOCAL6]	= { .len = sizeof(struct in6_addr) },
-	[IFLA_VXLAN_TOS]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_TTL]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_LABEL]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_LEARNING]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_AGEING]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_LIMIT]	= { .type = NLA_U32 },
-	[IFLA_VXLAN_PORT_RANGE] = { .len  = sizeof(struct ifla_vxlan_port_range) },
-	[IFLA_VXLAN_PROXY]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_RSC]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_L2MISS]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_L3MISS]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_COLLECT_METADATA]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_PORT]	= { .type = NLA_U16 },
-	[IFLA_VXLAN_UDP_CSUM]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_REMCSUM_TX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_REMCSUM_RX]	= { .type = NLA_U8 },
-	[IFLA_VXLAN_GBP]	= { .type = NLA_FLAG, },
-	[IFLA_VXLAN_GPE]	= { .type = NLA_FLAG, },
-	[IFLA_VXLAN_REMCSUM_NOPARTIAL]	= { .type = NLA_FLAG },
-	[IFLA_VXLAN_TTL_INHERIT]	= { .type = NLA_FLAG },
-	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
-};
-
-static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
-{
-	if (tb[IFLA_ADDRESS]) {
-		if (nla_len(tb[IFLA_ADDRESS]) != ETH_ALEN) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
-					    "Provided link layer address is not Ethernet");
-			return -EINVAL;
-		}
-
-		if (!is_valid_ether_addr(nla_data(tb[IFLA_ADDRESS]))) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
-					    "Provided Ethernet address is not unicast");
-			return -EADDRNOTAVAIL;
-		}
-	}
-
-	if (tb[IFLA_MTU]) {
-		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
-
-		if (mtu < ETH_MIN_MTU || mtu > ETH_MAX_MTU) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
-					    "MTU must be between 68 and 65535");
-			return -EINVAL;
-		}
-	}
-
-	if (!data) {
-		NL_SET_ERR_MSG(extack,
-			       "Required attributes not provided to perform the operation");
-		return -EINVAL;
-	}
-
-	if (data[IFLA_VXLAN_ID]) {
-		u32 id = nla_get_u32(data[IFLA_VXLAN_ID]);
-
-		if (id >= VXLAN_N_VID) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_ID],
-					    "VXLAN ID must be lower than 16777216");
-			return -ERANGE;
-		}
-	}
-
-	if (data[IFLA_VXLAN_PORT_RANGE]) {
-		const struct ifla_vxlan_port_range *p
-			= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
-
-		if (ntohs(p->high) < ntohs(p->low)) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_PORT_RANGE],
-					    "Invalid source port range");
-			return -EINVAL;
-		}
-	}
-
-	if (data[IFLA_VXLAN_DF]) {
-		enum ifla_vxlan_df df = nla_get_u8(data[IFLA_VXLAN_DF]);
-
-		if (df < 0 || df > VXLAN_DF_MAX) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_DF],
-					    "Invalid DF attribute");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-static void vxlan_get_drvinfo(struct net_device *netdev,
-			      struct ethtool_drvinfo *drvinfo)
-{
-	strlcpy(drvinfo->version, VXLAN_VERSION, sizeof(drvinfo->version));
-	strlcpy(drvinfo->driver, "vxlan", sizeof(drvinfo->driver));
-}
-
-static int vxlan_get_link_ksettings(struct net_device *dev,
-				    struct ethtool_link_ksettings *cmd)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
-
-	if (!lowerdev) {
-		cmd->base.duplex = DUPLEX_UNKNOWN;
-		cmd->base.port = PORT_OTHER;
-		cmd->base.speed = SPEED_UNKNOWN;
-
-		return 0;
-	}
-
-	return __ethtool_get_link_ksettings(lowerdev, cmd);
-}
-
-static const struct ethtool_ops vxlan_ethtool_ops = {
-	.get_drvinfo		= vxlan_get_drvinfo,
-	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= vxlan_get_link_ksettings,
-};
-
-static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
-					__be16 port, u32 flags, int ifindex)
-{
-	struct socket *sock;
-	struct udp_port_cfg udp_conf;
-	int err;
-
-	memset(&udp_conf, 0, sizeof(udp_conf));
-
-	if (ipv6) {
-		udp_conf.family = AF_INET6;
-		udp_conf.use_udp6_rx_checksums =
-		    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
-		udp_conf.ipv6_v6only = 1;
-	} else {
-		udp_conf.family = AF_INET;
-	}
-
-	udp_conf.local_udp_port = port;
-	udp_conf.bind_ifindex = ifindex;
-
-	/* Open UDP socket */
-	err = udp_sock_create(net, &udp_conf, &sock);
-	if (err < 0)
-		return ERR_PTR(err);
-
-	udp_allow_gso(sock->sk);
-	return sock;
-}
-
-/* Create new listen socket if needed */
-static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
-					      __be16 port, u32 flags,
-					      int ifindex)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	struct vxlan_sock *vs;
-	struct socket *sock;
-	unsigned int h;
-	struct udp_tunnel_sock_cfg tunnel_cfg;
-
-	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
-	if (!vs)
-		return ERR_PTR(-ENOMEM);
-
-	for (h = 0; h < VNI_HASH_SIZE; ++h)
-		INIT_HLIST_HEAD(&vs->vni_list[h]);
-
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
-	if (IS_ERR(sock)) {
-		kfree(vs);
-		return ERR_CAST(sock);
-	}
-
-	vs->sock = sock;
-	refcount_set(&vs->refcnt, 1);
-	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
-
-	spin_lock(&vn->sock_lock);
-	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
-	udp_tunnel_notify_add_rx_port(sock,
-				      (vs->flags & VXLAN_F_GPE) ?
-				      UDP_TUNNEL_TYPE_VXLAN_GPE :
-				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
-
-	/* Mark socket as an encapsulation socket. */
-	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
-	tunnel_cfg.sk_user_data = vs;
-	tunnel_cfg.encap_type = 1;
-	tunnel_cfg.encap_rcv = vxlan_rcv;
-	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
-	tunnel_cfg.encap_destroy = NULL;
-	tunnel_cfg.gro_receive = vxlan_gro_receive;
-	tunnel_cfg.gro_complete = vxlan_gro_complete;
-
-	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
-
-	return vs;
-}
-
-static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
-{
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	struct vxlan_sock *vs = NULL;
-	struct vxlan_dev_node *node;
-	int l3mdev_index = 0;
-
-	if (vxlan->cfg.remote_ifindex)
-		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
-			vxlan->net, vxlan->cfg.remote_ifindex);
-
-	if (!vxlan->cfg.no_share) {
-		spin_lock(&vn->sock_lock);
-		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
-				     vxlan->cfg.dst_port, vxlan->cfg.flags,
-				     l3mdev_index);
-		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
-			spin_unlock(&vn->sock_lock);
-			return -EBUSY;
-		}
-		spin_unlock(&vn->sock_lock);
-	}
-	if (!vs)
-		vs = vxlan_socket_create(vxlan->net, ipv6,
-					 vxlan->cfg.dst_port, vxlan->cfg.flags,
-					 l3mdev_index);
-	if (IS_ERR(vs))
-		return PTR_ERR(vs);
-#if IS_ENABLED(CONFIG_IPV6)
-	if (ipv6) {
-		rcu_assign_pointer(vxlan->vn6_sock, vs);
-		node = &vxlan->hlist6;
-	} else
-#endif
-	{
-		rcu_assign_pointer(vxlan->vn4_sock, vs);
-		node = &vxlan->hlist4;
-	}
-	vxlan_vs_add_dev(vs, vxlan, node);
-	return 0;
-}
-
-static int vxlan_sock_add(struct vxlan_dev *vxlan)
-{
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
-	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
-	bool ipv4 = !ipv6 || metadata;
-	int ret = 0;
-
-	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
-#if IS_ENABLED(CONFIG_IPV6)
-	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
-	if (ipv6) {
-		ret = __vxlan_sock_add(vxlan, true);
-		if (ret < 0 && ret != -EAFNOSUPPORT)
-			ipv4 = false;
-	}
-#endif
-	if (ipv4)
-		ret = __vxlan_sock_add(vxlan, false);
-	if (ret < 0)
-		vxlan_sock_release(vxlan);
-	return ret;
-}
-
-static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
-				 struct net_device **lower,
-				 struct vxlan_dev *old,
-				 struct netlink_ext_ack *extack)
-{
-	struct vxlan_net *vn = net_generic(src_net, vxlan_net_id);
-	struct vxlan_dev *tmp;
-	bool use_ipv6 = false;
-
-	if (conf->flags & VXLAN_F_GPE) {
-		/* For now, allow GPE only together with
-		 * COLLECT_METADATA. This can be relaxed later; in such
-		 * case, the other side of the PtP link will have to be
-		 * provided.
-		 */
-		if ((conf->flags & ~VXLAN_F_ALLOWED_GPE) ||
-		    !(conf->flags & VXLAN_F_COLLECT_METADATA)) {
-			NL_SET_ERR_MSG(extack,
-				       "VXLAN GPE does not support this combination of attributes");
-			return -EINVAL;
-		}
-	}
-
-	if (!conf->remote_ip.sa.sa_family && !conf->saddr.sa.sa_family) {
-		/* Unless IPv6 is explicitly requested, assume IPv4 */
-		conf->remote_ip.sa.sa_family = AF_INET;
-		conf->saddr.sa.sa_family = AF_INET;
-	} else if (!conf->remote_ip.sa.sa_family) {
-		conf->remote_ip.sa.sa_family = conf->saddr.sa.sa_family;
-	} else if (!conf->saddr.sa.sa_family) {
-		conf->saddr.sa.sa_family = conf->remote_ip.sa.sa_family;
-	}
-
-	if (conf->saddr.sa.sa_family != conf->remote_ip.sa.sa_family) {
-		NL_SET_ERR_MSG(extack,
-			       "Local and remote address must be from the same family");
-		return -EINVAL;
-	}
-
-	if (vxlan_addr_multicast(&conf->saddr)) {
-		NL_SET_ERR_MSG(extack, "Local address cannot be multicast");
-		return -EINVAL;
-	}
-
-	if (conf->saddr.sa.sa_family == AF_INET6) {
-		if (!IS_ENABLED(CONFIG_IPV6)) {
-			NL_SET_ERR_MSG(extack,
-				       "IPv6 support not enabled in the kernel");
-			return -EPFNOSUPPORT;
-		}
-		use_ipv6 = true;
-		conf->flags |= VXLAN_F_IPV6;
-
-		if (!(conf->flags & VXLAN_F_COLLECT_METADATA)) {
-			int local_type =
-				ipv6_addr_type(&conf->saddr.sin6.sin6_addr);
-			int remote_type =
-				ipv6_addr_type(&conf->remote_ip.sin6.sin6_addr);
-
-			if (local_type & IPV6_ADDR_LINKLOCAL) {
-				if (!(remote_type & IPV6_ADDR_LINKLOCAL) &&
-				    (remote_type != IPV6_ADDR_ANY)) {
-					NL_SET_ERR_MSG(extack,
-						       "Invalid combination of local and remote address scopes");
-					return -EINVAL;
-				}
-
-				conf->flags |= VXLAN_F_IPV6_LINKLOCAL;
-			} else {
-				if (remote_type ==
-				    (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL)) {
-					NL_SET_ERR_MSG(extack,
-						       "Invalid combination of local and remote address scopes");
-					return -EINVAL;
-				}
-
-				conf->flags &= ~VXLAN_F_IPV6_LINKLOCAL;
-			}
-		}
-	}
-
-	if (conf->label && !use_ipv6) {
-		NL_SET_ERR_MSG(extack,
-			       "Label attribute only applies to IPv6 VXLAN devices");
-		return -EINVAL;
-	}
-
-	if (conf->remote_ifindex) {
-		struct net_device *lowerdev;
-
-		lowerdev = __dev_get_by_index(src_net, conf->remote_ifindex);
-		if (!lowerdev) {
-			NL_SET_ERR_MSG(extack,
-				       "Invalid local interface, device not found");
-			return -ENODEV;
-		}
-
-#if IS_ENABLED(CONFIG_IPV6)
-		if (use_ipv6) {
-			struct inet6_dev *idev = __in6_dev_get(lowerdev);
-
-			if (idev && idev->cnf.disable_ipv6) {
-				NL_SET_ERR_MSG(extack,
-					       "IPv6 support disabled by administrator");
-				return -EPERM;
-			}
-		}
-#endif
-
-		*lower = lowerdev;
-	} else {
-		if (vxlan_addr_multicast(&conf->remote_ip)) {
-			NL_SET_ERR_MSG(extack,
-				       "Local interface required for multicast remote destination");
-
-			return -EINVAL;
-		}
-
-#if IS_ENABLED(CONFIG_IPV6)
-		if (conf->flags & VXLAN_F_IPV6_LINKLOCAL) {
-			NL_SET_ERR_MSG(extack,
-				       "Local interface required for link-local local/remote addresses");
-			return -EINVAL;
-		}
-#endif
-
-		*lower = NULL;
-	}
-
-	if (!conf->dst_port) {
-		if (conf->flags & VXLAN_F_GPE)
-			conf->dst_port = htons(4790); /* IANA VXLAN-GPE port */
-		else
-			conf->dst_port = htons(vxlan_port);
-	}
-
-	if (!conf->age_interval)
-		conf->age_interval = FDB_AGE_DEFAULT;
-
-	list_for_each_entry(tmp, &vn->vxlan_list, next) {
-		if (tmp == old)
-			continue;
-
-		if (tmp->cfg.vni != conf->vni)
-			continue;
-		if (tmp->cfg.dst_port != conf->dst_port)
-			continue;
-		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
-		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
-			continue;
-
-		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
-		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
-			continue;
-
-		NL_SET_ERR_MSG(extack,
-			       "A VXLAN device with the specified VNI already exists");
-		return -EEXIST;
-	}
-
-	return 0;
-}
-
-static void vxlan_config_apply(struct net_device *dev,
-			       struct vxlan_config *conf,
-			       struct net_device *lowerdev,
-			       struct net *src_net,
-			       bool changelink)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	unsigned short needed_headroom = ETH_HLEN;
-	bool use_ipv6 = !!(conf->flags & VXLAN_F_IPV6);
-	int max_mtu = ETH_MAX_MTU;
-
-	if (!changelink) {
-		if (conf->flags & VXLAN_F_GPE)
-			vxlan_raw_setup(dev);
-		else
-			vxlan_ether_setup(dev);
-
-		if (conf->mtu)
-			dev->mtu = conf->mtu;
-
-		vxlan->net = src_net;
-	}
-
-	dst->remote_vni = conf->vni;
-
-	memcpy(&dst->remote_ip, &conf->remote_ip, sizeof(conf->remote_ip));
-
-	if (lowerdev) {
-		dst->remote_ifindex = conf->remote_ifindex;
-
-		dev->gso_max_size = lowerdev->gso_max_size;
-		dev->gso_max_segs = lowerdev->gso_max_segs;
-
-		needed_headroom = lowerdev->hard_header_len;
-		needed_headroom += lowerdev->needed_headroom;
-
-		dev->needed_tailroom = lowerdev->needed_tailroom;
-
-		max_mtu = lowerdev->mtu - (use_ipv6 ? VXLAN6_HEADROOM :
-					   VXLAN_HEADROOM);
-		if (max_mtu < ETH_MIN_MTU)
-			max_mtu = ETH_MIN_MTU;
-
-		if (!changelink && !conf->mtu)
-			dev->mtu = max_mtu;
-	}
-
-	if (dev->mtu > max_mtu)
-		dev->mtu = max_mtu;
-
-	if (use_ipv6 || conf->flags & VXLAN_F_COLLECT_METADATA)
-		needed_headroom += VXLAN6_HEADROOM;
-	else
-		needed_headroom += VXLAN_HEADROOM;
-	dev->needed_headroom = needed_headroom;
-
-	memcpy(&vxlan->cfg, conf, sizeof(*conf));
-}
-
-static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
-			       struct vxlan_config *conf, bool changelink,
-			       struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct net_device *lowerdev;
-	int ret;
-
-	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
-	if (ret)
-		return ret;
-
-	vxlan_config_apply(dev, conf, lowerdev, src_net, changelink);
-
-	return 0;
-}
-
-static int __vxlan_dev_create(struct net *net, struct net_device *dev,
-			      struct vxlan_config *conf,
-			      struct netlink_ext_ack *extack)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct net_device *remote_dev = NULL;
-	struct vxlan_fdb *f = NULL;
-	bool unregister = false;
-	struct vxlan_rdst *dst;
-	int err;
-
-	dst = &vxlan->default_dst;
-	err = vxlan_dev_configure(net, dev, conf, false, extack);
-	if (err)
-		return err;
-
-	dev->ethtool_ops = &vxlan_ethtool_ops;
-
-	/* create an fdb entry for a valid default destination */
-	if (!vxlan_addr_any(&dst->remote_ip)) {
-		err = vxlan_fdb_create(vxlan, all_zeros_mac,
-				       &dst->remote_ip,
-				       NUD_REACHABLE | NUD_PERMANENT,
-				       vxlan->cfg.dst_port,
-				       dst->remote_vni,
-				       dst->remote_vni,
-				       dst->remote_ifindex,
-				       NTF_SELF, 0, &f, extack);
-		if (err)
-			return err;
-	}
-
-	err = register_netdevice(dev);
-	if (err)
-		goto errout;
-	unregister = true;
-
-	if (dst->remote_ifindex) {
-		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
-		if (!remote_dev) {
-			err = -ENODEV;
-			goto errout;
-		}
-
-		err = netdev_upper_dev_link(remote_dev, dev, extack);
-		if (err)
-			goto errout;
-	}
-
-	err = rtnl_configure_link(dev, NULL);
-	if (err < 0)
-		goto unlink;
-
-	if (f) {
-		vxlan_fdb_insert(vxlan, all_zeros_mac, dst->remote_vni, f);
-
-		/* notify default fdb entry */
-		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
-				       RTM_NEWNEIGH, true, extack);
-		if (err) {
-			vxlan_fdb_destroy(vxlan, f, false, false);
-			if (remote_dev)
-				netdev_upper_dev_unlink(remote_dev, dev);
-			goto unregister;
-		}
-	}
-
-	list_add(&vxlan->next, &vn->vxlan_list);
-	if (remote_dev)
-		dst->remote_dev = remote_dev;
-	return 0;
-unlink:
-	if (remote_dev)
-		netdev_upper_dev_unlink(remote_dev, dev);
-errout:
-	/* unregister_netdevice() destroys the default FDB entry with deletion
-	 * notification. But the addition notification was not sent yet, so
-	 * destroy the entry by hand here.
-	 */
-	if (f)
-		__vxlan_fdb_free(f);
-unregister:
-	if (unregister)
-		unregister_netdevice(dev);
-	return err;
-}
-
-/* Set/clear flags based on attribute */
-static int vxlan_nl2flag(struct vxlan_config *conf, struct nlattr *tb[],
-			  int attrtype, unsigned long mask, bool changelink,
-			  bool changelink_supported,
-			  struct netlink_ext_ack *extack)
-{
-	unsigned long flags;
-
-	if (!tb[attrtype])
-		return 0;
-
-	if (changelink && !changelink_supported) {
-		vxlan_flag_attr_error(attrtype, extack);
-		return -EOPNOTSUPP;
-	}
-
-	if (vxlan_policy[attrtype].type == NLA_FLAG)
-		flags = conf->flags | mask;
-	else if (nla_get_u8(tb[attrtype]))
-		flags = conf->flags | mask;
-	else
-		flags = conf->flags & ~mask;
-
-	conf->flags = flags;
-
-	return 0;
-}
-
-static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
-			 struct net_device *dev, struct vxlan_config *conf,
-			 bool changelink, struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	int err = 0;
-
-	memset(conf, 0, sizeof(*conf));
-
-	/* if changelink operation, start with old existing cfg */
-	if (changelink)
-		memcpy(conf, &vxlan->cfg, sizeof(*conf));
-
-	if (data[IFLA_VXLAN_ID]) {
-		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
-
-		if (changelink && (vni != conf->vni)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
-			return -EOPNOTSUPP;
-		}
-		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
-	}
-
-	if (data[IFLA_VXLAN_GROUP]) {
-		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
-			return -EOPNOTSUPP;
-		}
-
-		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
-		conf->remote_ip.sa.sa_family = AF_INET;
-	} else if (data[IFLA_VXLAN_GROUP6]) {
-		if (!IS_ENABLED(CONFIG_IPV6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
-			return -EPFNOSUPPORT;
-		}
-
-		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "New group address family does not match old group");
-			return -EOPNOTSUPP;
-		}
-
-		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
-		conf->remote_ip.sa.sa_family = AF_INET6;
-	}
-
-	if (data[IFLA_VXLAN_LOCAL]) {
-		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
-			return -EOPNOTSUPP;
-		}
-
-		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
-		conf->saddr.sa.sa_family = AF_INET;
-	} else if (data[IFLA_VXLAN_LOCAL6]) {
-		if (!IS_ENABLED(CONFIG_IPV6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "IPv6 support not enabled in the kernel");
-			return -EPFNOSUPPORT;
-		}
-
-		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
-			return -EOPNOTSUPP;
-		}
-
-		/* TODO: respect scope id */
-		conf->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_LOCAL6]);
-		conf->saddr.sa.sa_family = AF_INET6;
-	}
-
-	if (data[IFLA_VXLAN_LINK])
-		conf->remote_ifindex = nla_get_u32(data[IFLA_VXLAN_LINK]);
-
-	if (data[IFLA_VXLAN_TOS])
-		conf->tos  = nla_get_u8(data[IFLA_VXLAN_TOS]);
-
-	if (data[IFLA_VXLAN_TTL])
-		conf->ttl = nla_get_u8(data[IFLA_VXLAN_TTL]);
-
-	if (data[IFLA_VXLAN_TTL_INHERIT]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_TTL_INHERIT,
-				    VXLAN_F_TTL_INHERIT, changelink, false,
-				    extack);
-		if (err)
-			return err;
-
-	}
-
-	if (data[IFLA_VXLAN_LABEL])
-		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
-			     IPV6_FLOWLABEL_MASK;
-
-	if (data[IFLA_VXLAN_LEARNING]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
-				    VXLAN_F_LEARN, changelink, true,
-				    extack);
-		if (err)
-			return err;
-	} else if (!changelink) {
-		/* default to learn on a new device */
-		conf->flags |= VXLAN_F_LEARN;
-	}
-
-	if (data[IFLA_VXLAN_AGEING])
-		conf->age_interval = nla_get_u32(data[IFLA_VXLAN_AGEING]);
-
-	if (data[IFLA_VXLAN_PROXY]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_PROXY,
-				    VXLAN_F_PROXY, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_RSC]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_RSC,
-				    VXLAN_F_RSC, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_L2MISS]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L2MISS,
-				    VXLAN_F_L2MISS, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_L3MISS]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L3MISS,
-				    VXLAN_F_L3MISS, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_LIMIT]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LIMIT],
-					    "Cannot change limit");
-			return -EOPNOTSUPP;
-		}
-		conf->addrmax = nla_get_u32(data[IFLA_VXLAN_LIMIT]);
-	}
-
-	if (data[IFLA_VXLAN_COLLECT_METADATA]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_COLLECT_METADATA,
-				    VXLAN_F_COLLECT_METADATA, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_PORT_RANGE]) {
-		if (!changelink) {
-			const struct ifla_vxlan_port_range *p
-				= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
-			conf->port_min = ntohs(p->low);
-			conf->port_max = ntohs(p->high);
-		} else {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT_RANGE],
-					    "Cannot change port range");
-			return -EOPNOTSUPP;
-		}
-	}
-
-	if (data[IFLA_VXLAN_PORT]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT],
-					    "Cannot change port");
-			return -EOPNOTSUPP;
-		}
-		conf->dst_port = nla_get_be16(data[IFLA_VXLAN_PORT]);
-	}
-
-	if (data[IFLA_VXLAN_UDP_CSUM]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_UDP_CSUM],
-					    "Cannot change UDP_CSUM flag");
-			return -EOPNOTSUPP;
-		}
-		if (!nla_get_u8(data[IFLA_VXLAN_UDP_CSUM]))
-			conf->flags |= VXLAN_F_UDP_ZERO_CSUM_TX;
-	}
-
-	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-				    VXLAN_F_UDP_ZERO_CSUM6_TX, changelink,
-				    false, extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-				    VXLAN_F_UDP_ZERO_CSUM6_RX, changelink,
-				    false, extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_REMCSUM_TX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_TX,
-				    VXLAN_F_REMCSUM_TX, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_REMCSUM_RX]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_RX,
-				    VXLAN_F_REMCSUM_RX, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_GBP]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GBP,
-				    VXLAN_F_GBP, changelink, false, extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_GPE]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GPE,
-				    VXLAN_F_GPE, changelink, false,
-				    extack);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
-		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
-				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
-				    false, extack);
-		if (err)
-			return err;
-	}
-
-	if (tb[IFLA_MTU]) {
-		if (changelink) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
-					    "Cannot change mtu");
-			return -EOPNOTSUPP;
-		}
-		conf->mtu = nla_get_u32(tb[IFLA_MTU]);
-	}
-
-	if (data[IFLA_VXLAN_DF])
-		conf->df = nla_get_u8(data[IFLA_VXLAN_DF]);
-
-	return 0;
-}
-
-static int vxlan_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
-{
-	struct vxlan_config conf;
-	int err;
-
-	err = vxlan_nl2conf(tb, data, dev, &conf, false, extack);
-	if (err)
-		return err;
-
-	return __vxlan_dev_create(src_net, dev, &conf, extack);
-}
-
-static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
-			    struct nlattr *data[],
-			    struct netlink_ext_ack *extack)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct net_device *lowerdev;
-	struct vxlan_config conf;
-	struct vxlan_rdst *dst;
-	int err;
-
-	dst = &vxlan->default_dst;
-	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
-	if (err)
-		return err;
-
-	err = vxlan_config_validate(vxlan->net, &conf, &lowerdev,
-				    vxlan, extack);
-	if (err)
-		return err;
-
-	if (dst->remote_dev == lowerdev)
-		lowerdev = NULL;
-
-	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
-					     extack);
-	if (err)
-		return err;
-
-	/* handle default dst entry */
-	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
-		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
-
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
-		if (!vxlan_addr_any(&conf.remote_ip)) {
-			err = vxlan_fdb_update(vxlan, all_zeros_mac,
-					       &conf.remote_ip,
-					       NUD_REACHABLE | NUD_PERMANENT,
-					       NLM_F_APPEND | NLM_F_CREATE,
-					       vxlan->cfg.dst_port,
-					       conf.vni, conf.vni,
-					       conf.remote_ifindex,
-					       NTF_SELF, 0, true, extack);
-			if (err) {
-				spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-				netdev_adjacent_change_abort(dst->remote_dev,
-							     lowerdev, dev);
-				return err;
-			}
-		}
-		if (!vxlan_addr_any(&dst->remote_ip))
-			__vxlan_fdb_delete(vxlan, all_zeros_mac,
-					   dst->remote_ip,
-					   vxlan->cfg.dst_port,
-					   dst->remote_vni,
-					   dst->remote_vni,
-					   dst->remote_ifindex,
-					   true);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-	}
-
-	if (conf.age_interval != vxlan->cfg.age_interval)
-		mod_timer(&vxlan->age_timer, jiffies);
-
-	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
-	if (lowerdev && lowerdev != dst->remote_dev)
-		dst->remote_dev = lowerdev;
-	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
-	return 0;
-}
-
-static void vxlan_dellink(struct net_device *dev, struct list_head *head)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-
-	vxlan_flush(vxlan, true);
-
-	list_del(&vxlan->next);
-	unregister_netdevice_queue(dev, head);
-	if (vxlan->default_dst.remote_dev)
-		netdev_upper_dev_unlink(vxlan->default_dst.remote_dev, dev);
-}
-
-static size_t vxlan_get_size(const struct net_device *dev)
-{
-
-	return nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_ID */
-		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_GROUP{6} */
-		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LINK */
-		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_LOCAL{6} */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL_INHERIT */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
-		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L2MISS */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L3MISS */
-		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_COLLECT_METADATA */
-		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_AGEING */
-		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LIMIT */
-		nla_total_size(sizeof(struct ifla_vxlan_port_range)) +
-		nla_total_size(sizeof(__be16)) + /* IFLA_VXLAN_PORT */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_CSUM */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_TX */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_RX */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
-		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
-		0;
-}
-
-static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
-{
-	const struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct ifla_vxlan_port_range ports = {
-		.low =  htons(vxlan->cfg.port_min),
-		.high = htons(vxlan->cfg.port_max),
-	};
-
-	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
-		goto nla_put_failure;
-
-	if (!vxlan_addr_any(&dst->remote_ip)) {
-		if (dst->remote_ip.sa.sa_family == AF_INET) {
-			if (nla_put_in_addr(skb, IFLA_VXLAN_GROUP,
-					    dst->remote_ip.sin.sin_addr.s_addr))
-				goto nla_put_failure;
-#if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			if (nla_put_in6_addr(skb, IFLA_VXLAN_GROUP6,
-					     &dst->remote_ip.sin6.sin6_addr))
-				goto nla_put_failure;
-#endif
-		}
-	}
-
-	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
-		goto nla_put_failure;
-
-	if (!vxlan_addr_any(&vxlan->cfg.saddr)) {
-		if (vxlan->cfg.saddr.sa.sa_family == AF_INET) {
-			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
-					    vxlan->cfg.saddr.sin.sin_addr.s_addr))
-				goto nla_put_failure;
-#if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
-					     &vxlan->cfg.saddr.sin6.sin6_addr))
-				goto nla_put_failure;
-#endif
-		}
-	}
-
-	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
-	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
-		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
-	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
-	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
-	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
-		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
-		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_RSC,
-		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
-		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
-	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
-	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
-	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
-	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
-		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)))
-		goto nla_put_failure;
-
-	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
-		goto nla_put_failure;
-
-	if (vxlan->cfg.flags & VXLAN_F_GBP &&
-	    nla_put_flag(skb, IFLA_VXLAN_GBP))
-		goto nla_put_failure;
-
-	if (vxlan->cfg.flags & VXLAN_F_GPE &&
-	    nla_put_flag(skb, IFLA_VXLAN_GPE))
-		goto nla_put_failure;
-
-	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_NOPARTIAL &&
-	    nla_put_flag(skb, IFLA_VXLAN_REMCSUM_NOPARTIAL))
-		goto nla_put_failure;
-
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-static struct net *vxlan_get_link_net(const struct net_device *dev)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-
-	return vxlan->net;
-}
-
-static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
-	.kind		= "vxlan",
-	.maxtype	= IFLA_VXLAN_MAX,
-	.policy		= vxlan_policy,
-	.priv_size	= sizeof(struct vxlan_dev),
-	.setup		= vxlan_setup,
-	.validate	= vxlan_validate,
-	.newlink	= vxlan_newlink,
-	.changelink	= vxlan_changelink,
-	.dellink	= vxlan_dellink,
-	.get_size	= vxlan_get_size,
-	.fill_info	= vxlan_fill_info,
-	.get_link_net	= vxlan_get_link_net,
-};
-
-struct net_device *vxlan_dev_create(struct net *net, const char *name,
-				    u8 name_assign_type,
-				    struct vxlan_config *conf)
-{
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	int err;
-
-	memset(&tb, 0, sizeof(tb));
-
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &vxlan_link_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	err = __vxlan_dev_create(net, dev, conf, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	err = rtnl_configure_link(dev, NULL);
-	if (err < 0) {
-		LIST_HEAD(list_kill);
-
-		vxlan_dellink(dev, &list_kill);
-		unregister_netdevice_many(&list_kill);
-		return ERR_PTR(err);
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL_GPL(vxlan_dev_create);
-
-static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
-					     struct net_device *dev)
-{
-	struct vxlan_dev *vxlan, *next;
-	LIST_HEAD(list_kill);
-
-	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		struct vxlan_rdst *dst = &vxlan->default_dst;
-
-		/* In case we created vxlan device with carrier
-		 * and we loose the carrier due to module unload
-		 * we also need to remove vxlan device. In other
-		 * cases, it's not necessary and remote_ifindex
-		 * is 0 here, so no matches.
-		 */
-		if (dst->remote_ifindex == dev->ifindex)
-			vxlan_dellink(vxlan->dev, &list_kill);
-	}
-
-	unregister_netdevice_many(&list_kill);
-}
-
-static int vxlan_netdevice_event(struct notifier_block *unused,
-				 unsigned long event, void *ptr)
-{
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct vxlan_net *vn = net_generic(dev_net(dev), vxlan_net_id);
-
-	if (event == NETDEV_UNREGISTER)
-		vxlan_handle_lowerdev_unregister(vn, dev);
-	else if (event == NETDEV_UDP_TUNNEL_PUSH_INFO)
-		vxlan_offload_rx_ports(dev, true);
-	else if (event == NETDEV_UDP_TUNNEL_DROP_INFO)
-		vxlan_offload_rx_ports(dev, false);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block vxlan_notifier_block __read_mostly = {
-	.notifier_call = vxlan_netdevice_event,
-};
-
-static void
-vxlan_fdb_offloaded_set(struct net_device *dev,
-			struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *rdst;
-	struct vxlan_fdb *f;
-	u32 hash_index;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	if (!f)
-		goto out;
-
-	rdst = vxlan_fdb_find_rdst(f, &fdb_info->remote_ip,
-				   fdb_info->remote_port,
-				   fdb_info->remote_vni,
-				   fdb_info->remote_ifindex);
-	if (!rdst)
-		goto out;
-
-	rdst->offloaded = fdb_info->offloaded;
-
-out:
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-}
-
-static int
-vxlan_fdb_external_learn_add(struct net_device *dev,
-			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct netlink_ext_ack *extack;
-	u32 hash_index;
-	int err;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	extack = switchdev_notifier_info_to_extack(&fdb_info->info);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	err = vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
-			       NUD_REACHABLE,
-			       NLM_F_CREATE | NLM_F_REPLACE,
-			       fdb_info->remote_port,
-			       fdb_info->vni,
-			       fdb_info->remote_vni,
-			       fdb_info->remote_ifindex,
-			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
-			       0, false, extack);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-static int
-vxlan_fdb_external_learn_del(struct net_device *dev,
-			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
-{
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb *f;
-	u32 hash_index;
-	int err = 0;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	if (!f)
-		err = -ENOENT;
-	else if (f->flags & NTF_EXT_LEARNED)
-		err = __vxlan_fdb_delete(vxlan, fdb_info->eth_addr,
-					 fdb_info->remote_ip,
-					 fdb_info->remote_port,
-					 fdb_info->vni,
-					 fdb_info->remote_vni,
-					 fdb_info->remote_ifindex,
-					 false);
-
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-
-	return err;
-}
-
-static int vxlan_switchdev_event(struct notifier_block *unused,
-				 unsigned long event, void *ptr)
-{
-	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
-	struct switchdev_notifier_vxlan_fdb_info *fdb_info;
-	int err = 0;
-
-	switch (event) {
-	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
-		vxlan_fdb_offloaded_set(dev, ptr);
-		break;
-	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
-		fdb_info = ptr;
-		err = vxlan_fdb_external_learn_add(dev, fdb_info);
-		if (err) {
-			err = notifier_from_errno(err);
-			break;
-		}
-		fdb_info->offloaded = true;
-		vxlan_fdb_offloaded_set(dev, fdb_info);
-		break;
-	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
-		fdb_info = ptr;
-		err = vxlan_fdb_external_learn_del(dev, fdb_info);
-		if (err) {
-			err = notifier_from_errno(err);
-			break;
-		}
-		fdb_info->offloaded = false;
-		vxlan_fdb_offloaded_set(dev, fdb_info);
-		break;
-	}
-
-	return err;
-}
-
-static struct notifier_block vxlan_switchdev_notifier_block __read_mostly = {
-	.notifier_call = vxlan_switchdev_event,
-};
-
-static void vxlan_fdb_nh_flush(struct nexthop *nh)
-{
-	struct vxlan_fdb *fdb;
-	struct vxlan_dev *vxlan;
-	u32 hash_index;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(fdb, &nh->fdb_list, nh_list) {
-		vxlan = rcu_dereference(fdb->vdev);
-		WARN_ON(!vxlan);
-		hash_index = fdb_head_index(vxlan, fdb->eth_addr,
-					    vxlan->default_dst.remote_vni);
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
-		if (!hlist_unhashed(&fdb->hlist))
-			vxlan_fdb_destroy(vxlan, fdb, false, false);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-	}
-	rcu_read_unlock();
-}
-
-static int vxlan_nexthop_event(struct notifier_block *nb,
-			       unsigned long event, void *ptr)
-{
-	struct nh_notifier_info *info = ptr;
-	struct nexthop *nh;
-
-	if (event != NEXTHOP_EVENT_DEL)
-		return NOTIFY_DONE;
-
-	nh = nexthop_find_by_id(info->net, info->id);
-	if (!nh)
-		return NOTIFY_DONE;
-
-	vxlan_fdb_nh_flush(nh);
-
-	return NOTIFY_DONE;
-}
-
-static __net_init int vxlan_init_net(struct net *net)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	unsigned int h;
-
-	INIT_LIST_HEAD(&vn->vxlan_list);
-	spin_lock_init(&vn->sock_lock);
-	vn->nexthop_notifier_block.notifier_call = vxlan_nexthop_event;
-
-	for (h = 0; h < PORT_HASH_SIZE; ++h)
-		INIT_HLIST_HEAD(&vn->sock_list[h]);
-
-	return register_nexthop_notifier(net, &vn->nexthop_notifier_block,
-					 NULL);
-}
-
-static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
-{
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-	struct vxlan_dev *vxlan, *next;
-	struct net_device *dev, *aux;
-
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &vxlan_link_ops)
-			unregister_netdevice_queue(dev, head);
-
-	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		/* If vxlan->dev is in the same netns, it has already been added
-		 * to the list by the previous loop.
-		 */
-		if (!net_eq(dev_net(vxlan->dev), net))
-			unregister_netdevice_queue(vxlan->dev, head);
-	}
-
-}
-
-static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
-{
-	struct net *net;
-	LIST_HEAD(list);
-	unsigned int h;
-
-	list_for_each_entry(net, net_list, exit_list) {
-		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-
-		unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
-	}
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		vxlan_destroy_tunnels(net, &list);
-
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
-
-	list_for_each_entry(net, net_list, exit_list) {
-		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
-
-		for (h = 0; h < PORT_HASH_SIZE; ++h)
-			WARN_ON_ONCE(!hlist_empty(&vn->sock_list[h]));
-	}
-}
-
-static struct pernet_operations vxlan_net_ops = {
-	.init = vxlan_init_net,
-	.exit_batch = vxlan_exit_batch_net,
-	.id   = &vxlan_net_id,
-	.size = sizeof(struct vxlan_net),
-};
-
-static int __init vxlan_init_module(void)
-{
-	int rc;
-
-	get_random_bytes(&vxlan_salt, sizeof(vxlan_salt));
-
-	rc = register_pernet_subsys(&vxlan_net_ops);
-	if (rc)
-		goto out1;
-
-	rc = register_netdevice_notifier(&vxlan_notifier_block);
-	if (rc)
-		goto out2;
-
-	rc = register_switchdev_notifier(&vxlan_switchdev_notifier_block);
-	if (rc)
-		goto out3;
-
-	rc = rtnl_link_register(&vxlan_link_ops);
-	if (rc)
-		goto out4;
-
-	return 0;
-out4:
-	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
-out3:
-	unregister_netdevice_notifier(&vxlan_notifier_block);
-out2:
-	unregister_pernet_subsys(&vxlan_net_ops);
-out1:
-	return rc;
-}
-late_initcall(vxlan_init_module);
-
-static void __exit vxlan_cleanup_module(void)
-{
-	rtnl_link_unregister(&vxlan_link_ops);
-	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
-	unregister_netdevice_notifier(&vxlan_notifier_block);
-	unregister_pernet_subsys(&vxlan_net_ops);
-	/* rcu_barrier() is called by netns */
-}
-module_exit(vxlan_cleanup_module);
-
-MODULE_LICENSE("GPL");
-MODULE_VERSION(VXLAN_VERSION);
-MODULE_AUTHOR("Stephen Hemminger <stephen@networkplumber.org>");
-MODULE_DESCRIPTION("Driver for VXLAN encapsulated traffic");
-MODULE_ALIAS_RTNL_LINK("vxlan");
diff --git a/drivers/net/vxlan/Makefile b/drivers/net/vxlan/Makefile
new file mode 100644
index 000000000000..567266133593
--- /dev/null
+++ b/drivers/net/vxlan/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the vxlan driver
+#
+
+obj-$(CONFIG_VXLAN) += vxlan.o
+
+vxlan-objs := vxlan_core.o
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
new file mode 100644
index 000000000000..106b66570e04
--- /dev/null
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -0,0 +1,4831 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VXLAN: Virtual eXtensible Local Area Network
+ *
+ * Copyright (c) 2012-2013 Vyatta Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/udp.h>
+#include <linux/igmp.h>
+#include <linux/if_ether.h>
+#include <linux/ethtool.h>
+#include <net/arp.h>
+#include <net/ndisc.h>
+#include <net/ipv6_stubs.h>
+#include <net/ip.h>
+#include <net/icmp.h>
+#include <net/rtnetlink.h>
+#include <net/inet_ecn.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <net/tun_proto.h>
+#include <net/vxlan.h>
+#include <net/nexthop.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ip6_tunnel.h>
+#include <net/ip6_checksum.h>
+#endif
+
+#define VXLAN_VERSION	"0.1"
+
+#define PORT_HASH_BITS	8
+#define PORT_HASH_SIZE  (1<<PORT_HASH_BITS)
+#define FDB_AGE_DEFAULT 300 /* 5 min */
+#define FDB_AGE_INTERVAL (10 * HZ)	/* rescan interval */
+
+/* UDP port for VXLAN traffic.
+ * The IANA assigned port is 4789, but the Linux default is 8472
+ * for compatibility with early adopters.
+ */
+static unsigned short vxlan_port __read_mostly = 8472;
+module_param_named(udp_port, vxlan_port, ushort, 0444);
+MODULE_PARM_DESC(udp_port, "Destination UDP port");
+
+static bool log_ecn_error = true;
+module_param(log_ecn_error, bool, 0644);
+MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
+
+static unsigned int vxlan_net_id;
+static struct rtnl_link_ops vxlan_link_ops;
+
+static const u8 all_zeros_mac[ETH_ALEN + 2];
+
+static int vxlan_sock_add(struct vxlan_dev *vxlan);
+
+static void vxlan_vs_del_dev(struct vxlan_dev *vxlan);
+
+/* per-network namespace private data for this module */
+struct vxlan_net {
+	struct list_head  vxlan_list;
+	struct hlist_head sock_list[PORT_HASH_SIZE];
+	spinlock_t	  sock_lock;
+	struct notifier_block nexthop_notifier_block;
+};
+
+/* Forwarding table entry */
+struct vxlan_fdb {
+	struct hlist_node hlist;	/* linked list of entries */
+	struct rcu_head	  rcu;
+	unsigned long	  updated;	/* jiffies */
+	unsigned long	  used;
+	struct list_head  remotes;
+	u8		  eth_addr[ETH_ALEN];
+	u16		  state;	/* see ndm_state */
+	__be32		  vni;
+	u16		  flags;	/* see ndm_flags and below */
+	struct list_head  nh_list;
+	struct nexthop __rcu *nh;
+	struct vxlan_dev  __rcu *vdev;
+};
+
+#define NTF_VXLAN_ADDED_BY_USER 0x100
+
+/* salt for hash table */
+static u32 vxlan_salt __read_mostly;
+
+static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
+{
+	return vs->flags & VXLAN_F_COLLECT_METADATA ||
+	       ip_tunnel_collect_metadata();
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static inline
+bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
+{
+	if (a->sa.sa_family != b->sa.sa_family)
+		return false;
+	if (a->sa.sa_family == AF_INET6)
+		return ipv6_addr_equal(&a->sin6.sin6_addr, &b->sin6.sin6_addr);
+	else
+		return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
+}
+
+static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
+{
+	if (nla_len(nla) >= sizeof(struct in6_addr)) {
+		ip->sin6.sin6_addr = nla_get_in6_addr(nla);
+		ip->sa.sa_family = AF_INET6;
+		return 0;
+	} else if (nla_len(nla) >= sizeof(__be32)) {
+		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
+		ip->sa.sa_family = AF_INET;
+		return 0;
+	} else {
+		return -EAFNOSUPPORT;
+	}
+}
+
+static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
+			      const union vxlan_addr *ip)
+{
+	if (ip->sa.sa_family == AF_INET6)
+		return nla_put_in6_addr(skb, attr, &ip->sin6.sin6_addr);
+	else
+		return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
+}
+
+#else /* !CONFIG_IPV6 */
+
+static inline
+bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
+{
+	return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
+}
+
+static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
+{
+	if (nla_len(nla) >= sizeof(struct in6_addr)) {
+		return -EAFNOSUPPORT;
+	} else if (nla_len(nla) >= sizeof(__be32)) {
+		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
+		ip->sa.sa_family = AF_INET;
+		return 0;
+	} else {
+		return -EAFNOSUPPORT;
+	}
+}
+
+static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
+			      const union vxlan_addr *ip)
+{
+	return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
+}
+#endif
+
+/* Virtual Network hash table head */
+static inline struct hlist_head *vni_head(struct vxlan_sock *vs, __be32 vni)
+{
+	return &vs->vni_list[hash_32((__force u32)vni, VNI_HASH_BITS)];
+}
+
+/* Socket hash table head */
+static inline struct hlist_head *vs_head(struct net *net, __be16 port)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+
+	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
+}
+
+/* First remote destination for a forwarding entry.
+ * Guaranteed to be non-NULL because remotes are never deleted.
+ */
+static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
+{
+	if (rcu_access_pointer(fdb->nh))
+		return NULL;
+	return list_entry_rcu(fdb->remotes.next, struct vxlan_rdst, list);
+}
+
+static inline struct vxlan_rdst *first_remote_rtnl(struct vxlan_fdb *fdb)
+{
+	if (rcu_access_pointer(fdb->nh))
+		return NULL;
+	return list_first_entry(&fdb->remotes, struct vxlan_rdst, list);
+}
+
+/* Find VXLAN socket based on network namespace, address family, UDP port,
+ * enabled unshareable flags and socket device binding (see l3mdev with
+ * non-default VRF).
+ */
+static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
+					  __be16 port, u32 flags, int ifindex)
+{
+	struct vxlan_sock *vs;
+
+	flags &= VXLAN_F_RCV_FLAGS;
+
+	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
+		if (inet_sk(vs->sock->sk)->inet_sport == port &&
+		    vxlan_get_sk_family(vs) == family &&
+		    vs->flags == flags &&
+		    vs->sock->sk->sk_bound_dev_if == ifindex)
+			return vs;
+	}
+	return NULL;
+}
+
+static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs, int ifindex,
+					   __be32 vni)
+{
+	struct vxlan_dev_node *node;
+
+	/* For flow based devices, map all packets to VNI 0 */
+	if (vs->flags & VXLAN_F_COLLECT_METADATA)
+		vni = 0;
+
+	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
+		if (node->vxlan->default_dst.remote_vni != vni)
+			continue;
+
+		if (IS_ENABLED(CONFIG_IPV6)) {
+			const struct vxlan_config *cfg = &node->vxlan->cfg;
+
+			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
+			    cfg->remote_ifindex != ifindex)
+				continue;
+		}
+
+		return node->vxlan;
+	}
+
+	return NULL;
+}
+
+/* Look up VNI in a per net namespace table */
+static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
+					__be32 vni, sa_family_t family,
+					__be16 port, u32 flags)
+{
+	struct vxlan_sock *vs;
+
+	vs = vxlan_find_sock(net, family, port, flags, ifindex);
+	if (!vs)
+		return NULL;
+
+	return vxlan_vs_find_vni(vs, ifindex, vni);
+}
+
+/* Fill in neighbour message in skbuff. */
+static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
+			  const struct vxlan_fdb *fdb,
+			  u32 portid, u32 seq, int type, unsigned int flags,
+			  const struct vxlan_rdst *rdst)
+{
+	unsigned long now = jiffies;
+	struct nda_cacheinfo ci;
+	bool send_ip, send_eth;
+	struct nlmsghdr *nlh;
+	struct nexthop *nh;
+	struct ndmsg *ndm;
+	int nh_family;
+	u32 nh_id;
+
+	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*ndm), flags);
+	if (nlh == NULL)
+		return -EMSGSIZE;
+
+	ndm = nlmsg_data(nlh);
+	memset(ndm, 0, sizeof(*ndm));
+
+	send_eth = send_ip = true;
+
+	rcu_read_lock();
+	nh = rcu_dereference(fdb->nh);
+	if (nh) {
+		nh_family = nexthop_get_family(nh);
+		nh_id = nh->id;
+	}
+	rcu_read_unlock();
+
+	if (type == RTM_GETNEIGH) {
+		if (rdst) {
+			send_ip = !vxlan_addr_any(&rdst->remote_ip);
+			ndm->ndm_family = send_ip ? rdst->remote_ip.sa.sa_family : AF_INET;
+		} else if (nh) {
+			ndm->ndm_family = nh_family;
+		}
+		send_eth = !is_zero_ether_addr(fdb->eth_addr);
+	} else
+		ndm->ndm_family	= AF_BRIDGE;
+	ndm->ndm_state = fdb->state;
+	ndm->ndm_ifindex = vxlan->dev->ifindex;
+	ndm->ndm_flags = fdb->flags;
+	if (rdst && rdst->offloaded)
+		ndm->ndm_flags |= NTF_OFFLOADED;
+	ndm->ndm_type = RTN_UNICAST;
+
+	if (!net_eq(dev_net(vxlan->dev), vxlan->net) &&
+	    nla_put_s32(skb, NDA_LINK_NETNSID,
+			peernet2id(dev_net(vxlan->dev), vxlan->net)))
+		goto nla_put_failure;
+
+	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->eth_addr))
+		goto nla_put_failure;
+	if (nh) {
+		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
+			goto nla_put_failure;
+	} else if (rdst) {
+		if (send_ip && vxlan_nla_put_addr(skb, NDA_DST,
+						  &rdst->remote_ip))
+			goto nla_put_failure;
+
+		if (rdst->remote_port &&
+		    rdst->remote_port != vxlan->cfg.dst_port &&
+		    nla_put_be16(skb, NDA_PORT, rdst->remote_port))
+			goto nla_put_failure;
+		if (rdst->remote_vni != vxlan->default_dst.remote_vni &&
+		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
+			goto nla_put_failure;
+		if (rdst->remote_ifindex &&
+		    nla_put_u32(skb, NDA_IFINDEX, rdst->remote_ifindex))
+			goto nla_put_failure;
+	}
+
+	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->vni &&
+	    nla_put_u32(skb, NDA_SRC_VNI,
+			be32_to_cpu(fdb->vni)))
+		goto nla_put_failure;
+
+	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_confirmed = 0;
+	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_refcnt	 = 0;
+
+	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
+		goto nla_put_failure;
+
+	nlmsg_end(skb, nlh);
+	return 0;
+
+nla_put_failure:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
+static inline size_t vxlan_nlmsg_size(void)
+{
+	return NLMSG_ALIGN(sizeof(struct ndmsg))
+		+ nla_total_size(ETH_ALEN) /* NDA_LLADDR */
+		+ nla_total_size(sizeof(struct in6_addr)) /* NDA_DST */
+		+ nla_total_size(sizeof(__be16)) /* NDA_PORT */
+		+ nla_total_size(sizeof(__be32)) /* NDA_VNI */
+		+ nla_total_size(sizeof(__u32)) /* NDA_IFINDEX */
+		+ nla_total_size(sizeof(__s32)) /* NDA_LINK_NETNSID */
+		+ nla_total_size(sizeof(struct nda_cacheinfo));
+}
+
+static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
+			       struct vxlan_rdst *rd, int type)
+{
+	struct net *net = dev_net(vxlan->dev);
+	struct sk_buff *skb;
+	int err = -ENOBUFS;
+
+	skb = nlmsg_new(vxlan_nlmsg_size(), GFP_ATOMIC);
+	if (skb == NULL)
+		goto errout;
+
+	err = vxlan_fdb_info(skb, vxlan, fdb, 0, 0, type, 0, rd);
+	if (err < 0) {
+		/* -EMSGSIZE implies BUG in vxlan_nlmsg_size() */
+		WARN_ON(err == -EMSGSIZE);
+		kfree_skb(skb);
+		goto errout;
+	}
+
+	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
+	return;
+errout:
+	if (err < 0)
+		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+}
+
+static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
+			    const struct vxlan_fdb *fdb,
+			    const struct vxlan_rdst *rd,
+			    struct netlink_ext_ack *extack,
+			    struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	fdb_info->info.dev = vxlan->dev;
+	fdb_info->info.extack = extack;
+	fdb_info->remote_ip = rd->remote_ip;
+	fdb_info->remote_port = rd->remote_port;
+	fdb_info->remote_vni = rd->remote_vni;
+	fdb_info->remote_ifindex = rd->remote_ifindex;
+	memcpy(fdb_info->eth_addr, fdb->eth_addr, ETH_ALEN);
+	fdb_info->vni = fdb->vni;
+	fdb_info->offloaded = rd->offloaded;
+	fdb_info->added_by_user = fdb->flags & NTF_VXLAN_ADDED_BY_USER;
+}
+
+static int vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
+					      struct vxlan_fdb *fdb,
+					      struct vxlan_rdst *rd,
+					      bool adding,
+					      struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_vxlan_fdb_info info;
+	enum switchdev_notifier_type notifier_type;
+	int ret;
+
+	if (WARN_ON(!rd))
+		return 0;
+
+	notifier_type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE
+			       : SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE;
+	vxlan_fdb_switchdev_notifier_info(vxlan, fdb, rd, NULL, &info);
+	ret = call_switchdev_notifiers(notifier_type, vxlan->dev,
+				       &info.info, extack);
+	return notifier_to_errno(ret);
+}
+
+static int vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
+			    struct vxlan_rdst *rd, int type, bool swdev_notify,
+			    struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (swdev_notify && rd) {
+		switch (type) {
+		case RTM_NEWNEIGH:
+			err = vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
+								 true, extack);
+			if (err)
+				return err;
+			break;
+		case RTM_DELNEIGH:
+			vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd,
+							   false, extack);
+			break;
+		}
+	}
+
+	__vxlan_fdb_notify(vxlan, fdb, rd, type);
+	return 0;
+}
+
+static void vxlan_ip_miss(struct net_device *dev, union vxlan_addr *ipa)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb f = {
+		.state = NUD_STALE,
+	};
+	struct vxlan_rdst remote = {
+		.remote_ip = *ipa, /* goes to NDA_DST */
+		.remote_vni = cpu_to_be32(VXLAN_N_VID),
+	};
+
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
+}
+
+static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
+{
+	struct vxlan_fdb f = {
+		.state = NUD_STALE,
+	};
+	struct vxlan_rdst remote = { };
+
+	memcpy(f.eth_addr, eth_addr, ETH_ALEN);
+
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
+}
+
+/* Hash Ethernet address */
+static u32 eth_hash(const unsigned char *addr)
+{
+	u64 value = get_unaligned((u64 *)addr);
+
+	/* only want 6 bytes */
+#ifdef __BIG_ENDIAN
+	value >>= 16;
+#else
+	value <<= 16;
+#endif
+	return hash_64(value, FDB_HASH_BITS);
+}
+
+static u32 eth_vni_hash(const unsigned char *addr, __be32 vni)
+{
+	/* use 1 byte of OUI and 3 bytes of NIC */
+	u32 key = get_unaligned((u32 *)(addr + 2));
+
+	return jhash_2words(key, vni, vxlan_salt) & (FDB_HASH_SIZE - 1);
+}
+
+static u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni)
+{
+	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)
+		return eth_vni_hash(mac, vni);
+	else
+		return eth_hash(mac);
+}
+
+/* Hash chain to use given mac address */
+static inline struct hlist_head *vxlan_fdb_head(struct vxlan_dev *vxlan,
+						const u8 *mac, __be32 vni)
+{
+	return &vxlan->fdb_head[fdb_head_index(vxlan, mac, vni)];
+}
+
+/* Look up Ethernet address in forwarding table */
+static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
+					  const u8 *mac, __be32 vni)
+{
+	struct hlist_head *head = vxlan_fdb_head(vxlan, mac, vni);
+	struct vxlan_fdb *f;
+
+	hlist_for_each_entry_rcu(f, head, hlist) {
+		if (ether_addr_equal(mac, f->eth_addr)) {
+			if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
+				if (vni == f->vni)
+					return f;
+			} else {
+				return f;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
+					const u8 *mac, __be32 vni)
+{
+	struct vxlan_fdb *f;
+
+	f = __vxlan_find_mac(vxlan, mac, vni);
+	if (f && f->used != jiffies)
+		f->used = jiffies;
+
+	return f;
+}
+
+/* caller should hold vxlan->hash_lock */
+static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
+					      union vxlan_addr *ip, __be16 port,
+					      __be32 vni, __u32 ifindex)
+{
+	struct vxlan_rdst *rd;
+
+	list_for_each_entry(rd, &f->remotes, list) {
+		if (vxlan_addr_equal(&rd->remote_ip, ip) &&
+		    rd->remote_port == port &&
+		    rd->remote_vni == vni &&
+		    rd->remote_ifindex == ifindex)
+			return rd;
+	}
+
+	return NULL;
+}
+
+int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
+		      struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	u8 eth_addr[ETH_ALEN + 2] = { 0 };
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	int rc = 0;
+
+	if (is_multicast_ether_addr(mac) ||
+	    is_zero_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(eth_addr, mac);
+
+	rcu_read_lock();
+
+	f = __vxlan_find_mac(vxlan, eth_addr, vni);
+	if (!f) {
+		rc = -ENOENT;
+		goto out;
+	}
+
+	rdst = first_remote_rcu(f);
+	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, NULL, fdb_info);
+
+out:
+	rcu_read_unlock();
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_find_uc);
+
+static int vxlan_fdb_notify_one(struct notifier_block *nb,
+				const struct vxlan_dev *vxlan,
+				const struct vxlan_fdb *f,
+				const struct vxlan_rdst *rdst,
+				struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_vxlan_fdb_info fdb_info;
+	int rc;
+
+	vxlan_fdb_switchdev_notifier_info(vxlan, f, rdst, extack, &fdb_info);
+	rc = nb->notifier_call(nb, SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
+			       &fdb_info);
+	return notifier_to_errno(rc);
+}
+
+int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
+		     struct notifier_block *nb,
+		     struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	unsigned int h;
+	int rc = 0;
+
+	if (!netif_is_vxlan(dev))
+		return -EINVAL;
+	vxlan = netdev_priv(dev);
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		spin_lock_bh(&vxlan->hash_lock[h]);
+		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
+			if (f->vni == vni) {
+				list_for_each_entry(rdst, &f->remotes, list) {
+					rc = vxlan_fdb_notify_one(nb, vxlan,
+								  f, rdst,
+								  extack);
+					if (rc)
+						goto unlock;
+				}
+			}
+		}
+		spin_unlock_bh(&vxlan->hash_lock[h]);
+	}
+	return 0;
+
+unlock:
+	spin_unlock_bh(&vxlan->hash_lock[h]);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
+
+void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	unsigned int h;
+
+	if (!netif_is_vxlan(dev))
+		return;
+	vxlan = netdev_priv(dev);
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		spin_lock_bh(&vxlan->hash_lock[h]);
+		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
+			if (f->vni == vni)
+				list_for_each_entry(rdst, &f->remotes, list)
+					rdst->offloaded = false;
+		spin_unlock_bh(&vxlan->hash_lock[h]);
+	}
+
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_clear_offload);
+
+/* Replace destination of unicast mac */
+static int vxlan_fdb_replace(struct vxlan_fdb *f,
+			     union vxlan_addr *ip, __be16 port, __be32 vni,
+			     __u32 ifindex, struct vxlan_rdst *oldrd)
+{
+	struct vxlan_rdst *rd;
+
+	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
+	if (rd)
+		return 0;
+
+	rd = list_first_entry_or_null(&f->remotes, struct vxlan_rdst, list);
+	if (!rd)
+		return 0;
+
+	*oldrd = *rd;
+	dst_cache_reset(&rd->dst_cache);
+	rd->remote_ip = *ip;
+	rd->remote_port = port;
+	rd->remote_vni = vni;
+	rd->remote_ifindex = ifindex;
+	rd->offloaded = false;
+	return 1;
+}
+
+/* Add/update destinations for multicast */
+static int vxlan_fdb_append(struct vxlan_fdb *f,
+			    union vxlan_addr *ip, __be16 port, __be32 vni,
+			    __u32 ifindex, struct vxlan_rdst **rdp)
+{
+	struct vxlan_rdst *rd;
+
+	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
+	if (rd)
+		return 0;
+
+	rd = kmalloc(sizeof(*rd), GFP_ATOMIC);
+	if (rd == NULL)
+		return -ENOMEM;
+
+	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
+		kfree(rd);
+		return -ENOMEM;
+	}
+
+	rd->remote_ip = *ip;
+	rd->remote_port = port;
+	rd->offloaded = false;
+	rd->remote_vni = vni;
+	rd->remote_ifindex = ifindex;
+
+	list_add_tail_rcu(&rd->list, &f->remotes);
+
+	*rdp = rd;
+	return 1;
+}
+
+static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
+					  unsigned int off,
+					  struct vxlanhdr *vh, size_t hdrlen,
+					  __be32 vni_field,
+					  struct gro_remcsum *grc,
+					  bool nopartial)
+{
+	size_t start, offset;
+
+	if (skb->remcsum_offload)
+		return vh;
+
+	if (!NAPI_GRO_CB(skb)->csum_valid)
+		return NULL;
+
+	start = vxlan_rco_start(vni_field);
+	offset = start + vxlan_rco_offset(vni_field);
+
+	vh = skb_gro_remcsum_process(skb, (void *)vh, off, hdrlen,
+				     start, offset, grc, nopartial);
+
+	skb->remcsum_offload = 1;
+
+	return vh;
+}
+
+static struct sk_buff *vxlan_gro_receive(struct sock *sk,
+					 struct list_head *head,
+					 struct sk_buff *skb)
+{
+	struct sk_buff *pp = NULL;
+	struct sk_buff *p;
+	struct vxlanhdr *vh, *vh2;
+	unsigned int hlen, off_vx;
+	int flush = 1;
+	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
+	__be32 flags;
+	struct gro_remcsum grc;
+
+	skb_gro_remcsum_init(&grc);
+
+	off_vx = skb_gro_offset(skb);
+	hlen = off_vx + sizeof(*vh);
+	vh   = skb_gro_header_fast(skb, off_vx);
+	if (skb_gro_header_hard(skb, hlen)) {
+		vh = skb_gro_header_slow(skb, hlen, off_vx);
+		if (unlikely(!vh))
+			goto out;
+	}
+
+	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
+
+	flags = vh->vx_flags;
+
+	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
+		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
+				       vh->vx_vni, &grc,
+				       !!(vs->flags &
+					  VXLAN_F_REMCSUM_NOPARTIAL));
+
+		if (!vh)
+			goto out;
+	}
+
+	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		vh2 = (struct vxlanhdr *)(p->data + off_vx);
+		if (vh->vx_flags != vh2->vx_flags ||
+		    vh->vx_vni != vh2->vx_vni) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+	}
+
+	pp = call_gro_receive(eth_gro_receive, head, skb);
+	flush = 0;
+
+out:
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
+
+	return pp;
+}
+
+static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+{
+	/* Sets 'skb->inner_mac_header' since we are always called with
+	 * 'skb->encapsulation' set.
+	 */
+	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+}
+
+static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
+					 __u16 state, __be32 src_vni,
+					 __u16 ndm_flags)
+{
+	struct vxlan_fdb *f;
+
+	f = kmalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+	f->state = state;
+	f->flags = ndm_flags;
+	f->updated = f->used = jiffies;
+	f->vni = src_vni;
+	f->nh = NULL;
+	RCU_INIT_POINTER(f->vdev, vxlan);
+	INIT_LIST_HEAD(&f->nh_list);
+	INIT_LIST_HEAD(&f->remotes);
+	memcpy(f->eth_addr, mac, ETH_ALEN);
+
+	return f;
+}
+
+static void vxlan_fdb_insert(struct vxlan_dev *vxlan, const u8 *mac,
+			     __be32 src_vni, struct vxlan_fdb *f)
+{
+	++vxlan->addrcnt;
+	hlist_add_head_rcu(&f->hlist,
+			   vxlan_fdb_head(vxlan, mac, src_vni));
+}
+
+static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
+			       u32 nhid, struct netlink_ext_ack *extack)
+{
+	struct nexthop *old_nh = rtnl_dereference(fdb->nh);
+	struct nexthop *nh;
+	int err = -EINVAL;
+
+	if (old_nh && old_nh->id == nhid)
+		return 0;
+
+	nh = nexthop_find_by_id(vxlan->net, nhid);
+	if (!nh) {
+		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
+		goto err_inval;
+	}
+
+	if (nh) {
+		if (!nexthop_get(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			nh = NULL;
+			goto err_inval;
+		}
+		if (!nexthop_is_fdb(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop is not a fdb nexthop");
+			goto err_inval;
+		}
+
+		if (!nexthop_is_multipath(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop is not a multipath group");
+			goto err_inval;
+		}
+
+		/* check nexthop group family */
+		switch (vxlan->default_dst.remote_ip.sa.sa_family) {
+		case AF_INET:
+			if (!nexthop_has_v4(nh)) {
+				err = -EAFNOSUPPORT;
+				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
+				goto err_inval;
+			}
+			break;
+		case AF_INET6:
+			if (nexthop_has_v4(nh)) {
+				err = -EAFNOSUPPORT;
+				NL_SET_ERR_MSG(extack, "Nexthop group family not supported");
+				goto err_inval;
+			}
+		}
+	}
+
+	if (old_nh) {
+		list_del_rcu(&fdb->nh_list);
+		nexthop_put(old_nh);
+	}
+	rcu_assign_pointer(fdb->nh, nh);
+	list_add_tail_rcu(&fdb->nh_list, &nh->fdb_list);
+	return 1;
+
+err_inval:
+	if (nh)
+		nexthop_put(nh);
+	return err;
+}
+
+static int vxlan_fdb_create(struct vxlan_dev *vxlan,
+			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __be16 port, __be32 src_vni,
+			    __be32 vni, __u32 ifindex, __u16 ndm_flags,
+			    u32 nhid, struct vxlan_fdb **fdb,
+			    struct netlink_ext_ack *extack)
+{
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_fdb *f;
+	int rc;
+
+	if (vxlan->cfg.addrmax &&
+	    vxlan->addrcnt >= vxlan->cfg.addrmax)
+		return -ENOSPC;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	f = vxlan_fdb_alloc(vxlan, mac, state, src_vni, ndm_flags);
+	if (!f)
+		return -ENOMEM;
+
+	if (nhid)
+		rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
+	else
+		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+	if (rc < 0)
+		goto errout;
+
+	*fdb = f;
+
+	return 0;
+
+errout:
+	kfree(f);
+	return rc;
+}
+
+static void __vxlan_fdb_free(struct vxlan_fdb *f)
+{
+	struct vxlan_rdst *rd, *nd;
+	struct nexthop *nh;
+
+	nh = rcu_dereference_raw(f->nh);
+	if (nh) {
+		rcu_assign_pointer(f->nh, NULL);
+		rcu_assign_pointer(f->vdev, NULL);
+		nexthop_put(nh);
+	}
+
+	list_for_each_entry_safe(rd, nd, &f->remotes, list) {
+		dst_cache_destroy(&rd->dst_cache);
+		kfree(rd);
+	}
+	kfree(f);
+}
+
+static void vxlan_fdb_free(struct rcu_head *head)
+{
+	struct vxlan_fdb *f = container_of(head, struct vxlan_fdb, rcu);
+
+	__vxlan_fdb_free(f);
+}
+
+static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
+			      bool do_notify, bool swdev_notify)
+{
+	struct vxlan_rdst *rd;
+
+	netdev_dbg(vxlan->dev, "delete %pM\n", f->eth_addr);
+
+	--vxlan->addrcnt;
+	if (do_notify) {
+		if (rcu_access_pointer(f->nh))
+			vxlan_fdb_notify(vxlan, f, NULL, RTM_DELNEIGH,
+					 swdev_notify, NULL);
+		else
+			list_for_each_entry(rd, &f->remotes, list)
+				vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH,
+						 swdev_notify, NULL);
+	}
+
+	hlist_del_rcu(&f->hlist);
+	list_del_rcu(&f->nh_list);
+	call_rcu(&f->rcu, vxlan_fdb_free);
+}
+
+static void vxlan_dst_free(struct rcu_head *head)
+{
+	struct vxlan_rdst *rd = container_of(head, struct vxlan_rdst, rcu);
+
+	dst_cache_destroy(&rd->dst_cache);
+	kfree(rd);
+}
+
+static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
+				     union vxlan_addr *ip,
+				     __u16 state, __u16 flags,
+				     __be16 port, __be32 vni,
+				     __u32 ifindex, __u16 ndm_flags,
+				     struct vxlan_fdb *f, u32 nhid,
+				     bool swdev_notify,
+				     struct netlink_ext_ack *extack)
+{
+	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_rdst oldrd;
+	int notify = 0;
+	int rc = 0;
+	int err;
+
+	if (nhid && !rcu_access_pointer(f->nh)) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot replace an existing non nexthop fdb with a nexthop");
+		return -EOPNOTSUPP;
+	}
+
+	if (nhid && (flags & NLM_F_APPEND)) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot append to a nexthop fdb");
+		return -EOPNOTSUPP;
+	}
+
+	/* Do not allow an externally learned entry to take over an entry added
+	 * by the user.
+	 */
+	if (!(fdb_flags & NTF_EXT_LEARNED) ||
+	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
+		if (f->state != state) {
+			f->state = state;
+			f->updated = jiffies;
+			notify = 1;
+		}
+		if (f->flags != fdb_flags) {
+			f->flags = fdb_flags;
+			f->updated = jiffies;
+			notify = 1;
+		}
+	}
+
+	if ((flags & NLM_F_REPLACE)) {
+		/* Only change unicasts */
+		if (!(is_multicast_ether_addr(f->eth_addr) ||
+		      is_zero_ether_addr(f->eth_addr))) {
+			if (nhid) {
+				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
+				if (rc < 0)
+					return rc;
+			} else {
+				rc = vxlan_fdb_replace(f, ip, port, vni,
+						       ifindex, &oldrd);
+			}
+			notify |= rc;
+		} else {
+			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
+			return -EOPNOTSUPP;
+		}
+	}
+	if ((flags & NLM_F_APPEND) &&
+	    (is_multicast_ether_addr(f->eth_addr) ||
+	     is_zero_ether_addr(f->eth_addr))) {
+		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+
+		if (rc < 0)
+			return rc;
+		notify |= rc;
+	}
+
+	if (ndm_flags & NTF_USE)
+		f->used = jiffies;
+
+	if (notify) {
+		if (rd == NULL)
+			rd = first_remote_rtnl(f);
+
+		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
+				       swdev_notify, extack);
+		if (err)
+			goto err_notify;
+	}
+
+	return 0;
+
+err_notify:
+	if (nhid)
+		return err;
+	if ((flags & NLM_F_REPLACE) && rc)
+		*rd = oldrd;
+	else if ((flags & NLM_F_APPEND) && rc) {
+		list_del_rcu(&rd->list);
+		call_rcu(&rd->rcu, vxlan_dst_free);
+	}
+	return err;
+}
+
+static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
+				   const u8 *mac, union vxlan_addr *ip,
+				   __u16 state, __u16 flags,
+				   __be16 port, __be32 src_vni, __be32 vni,
+				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
+				   bool swdev_notify,
+				   struct netlink_ext_ack *extack)
+{
+	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
+	struct vxlan_fdb *f;
+	int rc;
+
+	/* Disallow replace to add a multicast entry */
+	if ((flags & NLM_F_REPLACE) &&
+	    (is_multicast_ether_addr(mac) || is_zero_ether_addr(mac)))
+		return -EOPNOTSUPP;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
+			      vni, ifindex, fdb_flags, nhid, &f, extack);
+	if (rc < 0)
+		return rc;
+
+	vxlan_fdb_insert(vxlan, mac, src_vni, f);
+	rc = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
+			      swdev_notify, extack);
+	if (rc)
+		goto err_notify;
+
+	return 0;
+
+err_notify:
+	vxlan_fdb_destroy(vxlan, f, false, false);
+	return rc;
+}
+
+/* Add new entry to forwarding table -- assumes lock held */
+static int vxlan_fdb_update(struct vxlan_dev *vxlan,
+			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __u16 flags,
+			    __be16 port, __be32 src_vni, __be32 vni,
+			    __u32 ifindex, __u16 ndm_flags, u32 nhid,
+			    bool swdev_notify,
+			    struct netlink_ext_ack *extack)
+{
+	struct vxlan_fdb *f;
+
+	f = __vxlan_find_mac(vxlan, mac, src_vni);
+	if (f) {
+		if (flags & NLM_F_EXCL) {
+			netdev_dbg(vxlan->dev,
+				   "lost race to create %pM\n", mac);
+			return -EEXIST;
+		}
+
+		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
+						 vni, ifindex, ndm_flags, f,
+						 nhid, swdev_notify, extack);
+	} else {
+		if (!(flags & NLM_F_CREATE))
+			return -ENOENT;
+
+		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
+					       port, src_vni, vni, ifindex,
+					       ndm_flags, nhid, swdev_notify,
+					       extack);
+	}
+}
+
+static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
+				  struct vxlan_rdst *rd, bool swdev_notify)
+{
+	list_del_rcu(&rd->list);
+	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, swdev_notify, NULL);
+	call_rcu(&rd->rcu, vxlan_dst_free);
+}
+
+static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
+			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
+			   __be32 *vni, u32 *ifindex, u32 *nhid)
+{
+	struct net *net = dev_net(vxlan->dev);
+	int err;
+
+	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
+	    tb[NDA_PORT]))
+		return -EINVAL;
+
+	if (tb[NDA_DST]) {
+		err = vxlan_nla_get_addr(ip, tb[NDA_DST]);
+		if (err)
+			return err;
+	} else {
+		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
+
+		if (remote->sa.sa_family == AF_INET) {
+			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
+			ip->sa.sa_family = AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			ip->sin6.sin6_addr = in6addr_any;
+			ip->sa.sa_family = AF_INET6;
+#endif
+		}
+	}
+
+	if (tb[NDA_PORT]) {
+		if (nla_len(tb[NDA_PORT]) != sizeof(__be16))
+			return -EINVAL;
+		*port = nla_get_be16(tb[NDA_PORT]);
+	} else {
+		*port = vxlan->cfg.dst_port;
+	}
+
+	if (tb[NDA_VNI]) {
+		if (nla_len(tb[NDA_VNI]) != sizeof(u32))
+			return -EINVAL;
+		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+	} else {
+		*vni = vxlan->default_dst.remote_vni;
+	}
+
+	if (tb[NDA_SRC_VNI]) {
+		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32))
+			return -EINVAL;
+		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
+	} else {
+		*src_vni = vxlan->default_dst.remote_vni;
+	}
+
+	if (tb[NDA_IFINDEX]) {
+		struct net_device *tdev;
+
+		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
+			return -EINVAL;
+		*ifindex = nla_get_u32(tb[NDA_IFINDEX]);
+		tdev = __dev_get_by_index(net, *ifindex);
+		if (!tdev)
+			return -EADDRNOTAVAIL;
+	} else {
+		*ifindex = 0;
+	}
+
+	if (tb[NDA_NH_ID])
+		*nhid = nla_get_u32(tb[NDA_NH_ID]);
+	else
+		*nhid = 0;
+
+	return 0;
+}
+
+/* Add static entry (via netlink) */
+static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
+			 struct net_device *dev,
+			 const unsigned char *addr, u16 vid, u16 flags,
+			 struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	/* struct net *net = dev_net(vxlan->dev); */
+	union vxlan_addr ip;
+	__be16 port;
+	__be32 src_vni, vni;
+	u32 ifindex, nhid;
+	u32 hash_index;
+	int err;
+
+	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
+		pr_info("RTM_NEWNEIGH with invalid state %#x\n",
+			ndm->ndm_state);
+		return -EINVAL;
+	}
+
+	if (!tb || (!tb[NDA_DST] && !tb[NDA_NH_ID]))
+		return -EINVAL;
+
+	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
+			      &nhid);
+	if (err)
+		return err;
+
+	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
+		return -EAFNOSUPPORT;
+
+	hash_index = fdb_head_index(vxlan, addr, src_vni);
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
+			       port, src_vni, vni, ifindex,
+			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
+			       nhid, true, extack);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+static int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
+			      const unsigned char *addr, union vxlan_addr ip,
+			      __be16 port, __be32 src_vni, __be32 vni,
+			      u32 ifindex, bool swdev_notify)
+{
+	struct vxlan_rdst *rd = NULL;
+	struct vxlan_fdb *f;
+	int err = -ENOENT;
+
+	f = vxlan_find_mac(vxlan, addr, src_vni);
+	if (!f)
+		return err;
+
+	if (!vxlan_addr_any(&ip)) {
+		rd = vxlan_fdb_find_rdst(f, &ip, port, vni, ifindex);
+		if (!rd)
+			goto out;
+	}
+
+	/* remove a destination if it's not the only one on the list,
+	 * otherwise destroy the fdb entry
+	 */
+	if (rd && !list_is_singular(&f->remotes)) {
+		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
+		goto out;
+	}
+
+	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
+
+out:
+	return 0;
+}
+
+/* Delete entry (via netlink) */
+static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
+			    struct net_device *dev,
+			    const unsigned char *addr, u16 vid)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	union vxlan_addr ip;
+	__be32 src_vni, vni;
+	u32 ifindex, nhid;
+	u32 hash_index;
+	__be16 port;
+	int err;
+
+	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
+			      &nhid);
+	if (err)
+		return err;
+
+	hash_index = fdb_head_index(vxlan, addr, src_vni);
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	err = __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
+				 true);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+/* Dump forwarding table */
+static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			  struct net_device *dev,
+			  struct net_device *filter_dev, int *idx)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	unsigned int h;
+	int err = 0;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		struct vxlan_fdb *f;
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(f, &vxlan->fdb_head[h], hlist) {
+			struct vxlan_rdst *rd;
+
+			if (rcu_access_pointer(f->nh)) {
+				if (*idx < cb->args[2])
+					goto skip_nh;
+				err = vxlan_fdb_info(skb, vxlan, f,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     RTM_NEWNEIGH,
+						     NLM_F_MULTI, NULL);
+				if (err < 0) {
+					rcu_read_unlock();
+					goto out;
+				}
+skip_nh:
+				*idx += 1;
+				continue;
+			}
+
+			list_for_each_entry_rcu(rd, &f->remotes, list) {
+				if (*idx < cb->args[2])
+					goto skip;
+
+				err = vxlan_fdb_info(skb, vxlan, f,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     RTM_NEWNEIGH,
+						     NLM_F_MULTI, rd);
+				if (err < 0) {
+					rcu_read_unlock();
+					goto out;
+				}
+skip:
+				*idx += 1;
+			}
+		}
+		rcu_read_unlock();
+	}
+out:
+	return err;
+}
+
+static int vxlan_fdb_get(struct sk_buff *skb,
+			 struct nlattr *tb[],
+			 struct net_device *dev,
+			 const unsigned char *addr,
+			 u16 vid, u32 portid, u32 seq,
+			 struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f;
+	__be32 vni;
+	int err;
+
+	if (tb[NDA_VNI])
+		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+	else
+		vni = vxlan->default_dst.remote_vni;
+
+	rcu_read_lock();
+
+	f = __vxlan_find_mac(vxlan, addr, vni);
+	if (!f) {
+		NL_SET_ERR_MSG(extack, "Fdb entry not found");
+		err = -ENOENT;
+		goto errout;
+	}
+
+	err = vxlan_fdb_info(skb, vxlan, f, portid, seq,
+			     RTM_NEWNEIGH, 0, first_remote_rcu(f));
+errout:
+	rcu_read_unlock();
+	return err;
+}
+
+/* Watch incoming packets to learn mapping between Ethernet address
+ * and Tunnel endpoint.
+ * Return true if packet is bogus and should be dropped.
+ */
+static bool vxlan_snoop(struct net_device *dev,
+			union vxlan_addr *src_ip, const u8 *src_mac,
+			u32 src_ifindex, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f;
+	u32 ifindex = 0;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (src_ip->sa.sa_family == AF_INET6 &&
+	    (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
+		ifindex = src_ifindex;
+#endif
+
+	f = vxlan_find_mac(vxlan, src_mac, vni);
+	if (likely(f)) {
+		struct vxlan_rdst *rdst = first_remote_rcu(f);
+
+		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
+			   rdst->remote_ifindex == ifindex))
+			return false;
+
+		/* Don't migrate static entries, drop packets */
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
+			return true;
+
+		/* Don't override an fdb with nexthop with a learnt entry */
+		if (rcu_access_pointer(f->nh))
+			return true;
+
+		if (net_ratelimit())
+			netdev_info(dev,
+				    "%pM migrated from %pIS to %pIS\n",
+				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
+
+		rdst->remote_ip = *src_ip;
+		f->updated = jiffies;
+		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
+	} else {
+		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
+
+		/* learned new entry */
+		spin_lock(&vxlan->hash_lock[hash_index]);
+
+		/* close off race between vxlan_flush and incoming packets */
+		if (netif_running(dev))
+			vxlan_fdb_update(vxlan, src_mac, src_ip,
+					 NUD_REACHABLE,
+					 NLM_F_EXCL|NLM_F_CREATE,
+					 vxlan->cfg.dst_port,
+					 vni,
+					 vxlan->default_dst.remote_vni,
+					 ifindex, NTF_SELF, 0, true, NULL);
+		spin_unlock(&vxlan->hash_lock[hash_index]);
+	}
+
+	return false;
+}
+
+/* See if multicast group is already in use by other ID */
+static bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_sock *sock4;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct vxlan_sock *sock6;
+#endif
+	unsigned short family = dev->default_dst.remote_ip.sa.sa_family;
+
+	sock4 = rtnl_dereference(dev->vn4_sock);
+
+	/* The vxlan_sock is only used by dev, leaving group has
+	 * no effect on other vxlan devices.
+	 */
+	if (family == AF_INET && sock4 && refcount_read(&sock4->refcnt) == 1)
+		return false;
+#if IS_ENABLED(CONFIG_IPV6)
+	sock6 = rtnl_dereference(dev->vn6_sock);
+	if (family == AF_INET6 && sock6 && refcount_read(&sock6->refcnt) == 1)
+		return false;
+#endif
+
+	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
+		if (!netif_running(vxlan->dev) || vxlan == dev)
+			continue;
+
+		if (family == AF_INET &&
+		    rtnl_dereference(vxlan->vn4_sock) != sock4)
+			continue;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (family == AF_INET6 &&
+		    rtnl_dereference(vxlan->vn6_sock) != sock6)
+			continue;
+#endif
+
+		if (!vxlan_addr_equal(&vxlan->default_dst.remote_ip,
+				      &dev->default_dst.remote_ip))
+			continue;
+
+		if (vxlan->default_dst.remote_ifindex !=
+		    dev->default_dst.remote_ifindex)
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
+{
+	struct vxlan_net *vn;
+
+	if (!vs)
+		return false;
+	if (!refcount_dec_and_test(&vs->refcnt))
+		return false;
+
+	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
+	spin_lock(&vn->sock_lock);
+	hlist_del_rcu(&vs->hlist);
+	udp_tunnel_notify_del_rx_port(vs->sock,
+				      (vs->flags & VXLAN_F_GPE) ?
+				      UDP_TUNNEL_TYPE_VXLAN_GPE :
+				      UDP_TUNNEL_TYPE_VXLAN);
+	spin_unlock(&vn->sock_lock);
+
+	return true;
+}
+
+static void vxlan_sock_release(struct vxlan_dev *vxlan)
+{
+	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
+#if IS_ENABLED(CONFIG_IPV6)
+	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
+
+	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
+#endif
+
+	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
+	synchronize_net();
+
+	vxlan_vs_del_dev(vxlan);
+
+	if (__vxlan_sock_release_prep(sock4)) {
+		udp_tunnel_sock_release(sock4->sock);
+		kfree(sock4);
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (__vxlan_sock_release_prep(sock6)) {
+		udp_tunnel_sock_release(sock6->sock);
+		kfree(sock6);
+	}
+#endif
+}
+
+/* Update multicast group membership when first VNI on
+ * multicast address is brought up
+ */
+static int vxlan_igmp_join(struct vxlan_dev *vxlan)
+{
+	struct sock *sk;
+	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
+	int ifindex = vxlan->default_dst.remote_ifindex;
+	int ret = -EINVAL;
+
+	if (ip->sa.sa_family == AF_INET) {
+		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
+		struct ip_mreqn mreq = {
+			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
+			.imr_ifindex		= ifindex,
+		};
+
+		sk = sock4->sock->sk;
+		lock_sock(sk);
+		ret = ip_mc_join_group(sk, &mreq);
+		release_sock(sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
+
+		sk = sock6->sock->sk;
+		lock_sock(sk);
+		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
+						   &ip->sin6.sin6_addr);
+		release_sock(sk);
+#endif
+	}
+
+	return ret;
+}
+
+/* Inverse of vxlan_igmp_join when last VNI is brought down */
+static int vxlan_igmp_leave(struct vxlan_dev *vxlan)
+{
+	struct sock *sk;
+	union vxlan_addr *ip = &vxlan->default_dst.remote_ip;
+	int ifindex = vxlan->default_dst.remote_ifindex;
+	int ret = -EINVAL;
+
+	if (ip->sa.sa_family == AF_INET) {
+		struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
+		struct ip_mreqn mreq = {
+			.imr_multiaddr.s_addr	= ip->sin.sin_addr.s_addr,
+			.imr_ifindex		= ifindex,
+		};
+
+		sk = sock4->sock->sk;
+		lock_sock(sk);
+		ret = ip_mc_leave_group(sk, &mreq);
+		release_sock(sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
+
+		sk = sock6->sock->sk;
+		lock_sock(sk);
+		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
+						   &ip->sin6.sin6_addr);
+		release_sock(sk);
+#endif
+	}
+
+	return ret;
+}
+
+static bool vxlan_remcsum(struct vxlanhdr *unparsed,
+			  struct sk_buff *skb, u32 vxflags)
+{
+	size_t start, offset;
+
+	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
+		goto out;
+
+	start = vxlan_rco_start(unparsed->vx_vni);
+	offset = start + vxlan_rco_offset(unparsed->vx_vni);
+
+	if (!pskb_may_pull(skb, offset + sizeof(u16)))
+		return false;
+
+	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
+			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
+out:
+	unparsed->vx_flags &= ~VXLAN_HF_RCO;
+	unparsed->vx_vni &= VXLAN_VNI_MASK;
+	return true;
+}
+
+static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
+				struct sk_buff *skb, u32 vxflags,
+				struct vxlan_metadata *md)
+{
+	struct vxlanhdr_gbp *gbp = (struct vxlanhdr_gbp *)unparsed;
+	struct metadata_dst *tun_dst;
+
+	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
+		goto out;
+
+	md->gbp = ntohs(gbp->policy_id);
+
+	tun_dst = (struct metadata_dst *)skb_dst(skb);
+	if (tun_dst) {
+		tun_dst->u.tun_info.key.tun_flags |= TUNNEL_VXLAN_OPT;
+		tun_dst->u.tun_info.options_len = sizeof(*md);
+	}
+	if (gbp->dont_learn)
+		md->gbp |= VXLAN_GBP_DONT_LEARN;
+
+	if (gbp->policy_applied)
+		md->gbp |= VXLAN_GBP_POLICY_APPLIED;
+
+	/* In flow-based mode, GBP is carried in dst_metadata */
+	if (!(vxflags & VXLAN_F_COLLECT_METADATA))
+		skb->mark = md->gbp;
+out:
+	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
+}
+
+static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
+				__be16 *protocol,
+				struct sk_buff *skb, u32 vxflags)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
+
+	/* Need to have Next Protocol set for interfaces in GPE mode. */
+	if (!gpe->np_applied)
+		return false;
+	/* "The initial version is 0. If a receiver does not support the
+	 * version indicated it MUST drop the packet.
+	 */
+	if (gpe->version != 0)
+		return false;
+	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
+	 * processing MUST occur." However, we don't implement OAM
+	 * processing, thus drop the packet.
+	 */
+	if (gpe->oam_flag)
+		return false;
+
+	*protocol = tun_p_to_eth_p(gpe->next_protocol);
+	if (!*protocol)
+		return false;
+
+	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
+	return true;
+}
+
+static bool vxlan_set_mac(struct vxlan_dev *vxlan,
+			  struct vxlan_sock *vs,
+			  struct sk_buff *skb, __be32 vni)
+{
+	union vxlan_addr saddr;
+	u32 ifindex = skb->dev->ifindex;
+
+	skb_reset_mac_header(skb);
+	skb->protocol = eth_type_trans(skb, vxlan->dev);
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
+
+	/* Ignore packet loops (and multicast echo) */
+	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
+		return false;
+
+	/* Get address from the outer IP header */
+	if (vxlan_get_sk_family(vs) == AF_INET) {
+		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
+		saddr.sa.sa_family = AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		saddr.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
+		saddr.sa.sa_family = AF_INET6;
+#endif
+	}
+
+	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
+	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
+		return false;
+
+	return true;
+}
+
+static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
+				  struct sk_buff *skb)
+{
+	int err = 0;
+
+	if (vxlan_get_sk_family(vs) == AF_INET)
+		err = IP_ECN_decapsulate(oiph, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	else
+		err = IP6_ECN_decapsulate(oiph, skb);
+#endif
+
+	if (unlikely(err) && log_ecn_error) {
+		if (vxlan_get_sk_family(vs) == AF_INET)
+			net_info_ratelimited("non-ECT from %pI4 with TOS=%#x\n",
+					     &((struct iphdr *)oiph)->saddr,
+					     ((struct iphdr *)oiph)->tos);
+		else
+			net_info_ratelimited("non-ECT from %pI6\n",
+					     &((struct ipv6hdr *)oiph)->saddr);
+	}
+	return err <= 1;
+}
+
+/* Callback from net/ipv4/udp.c to receive packets */
+static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_sock *vs;
+	struct vxlanhdr unparsed;
+	struct vxlan_metadata _md;
+	struct vxlan_metadata *md = &_md;
+	__be16 protocol = htons(ETH_P_TEB);
+	bool raw_proto = false;
+	void *oiph;
+	__be32 vni = 0;
+
+	/* Need UDP and VXLAN header to be present */
+	if (!pskb_may_pull(skb, VXLAN_HLEN))
+		goto drop;
+
+	unparsed = *vxlan_hdr(skb);
+	/* VNI flag always required to be set */
+	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
+		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
+			   ntohl(vxlan_hdr(skb)->vx_flags),
+			   ntohl(vxlan_hdr(skb)->vx_vni));
+		/* Return non vxlan pkt */
+		goto drop;
+	}
+	unparsed.vx_flags &= ~VXLAN_HF_VNI;
+	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
+
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		goto drop;
+
+	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
+
+	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
+	if (!vxlan)
+		goto drop;
+
+	/* For backwards compatibility, only allow reserved fields to be
+	 * used by VXLAN extensions if explicitly requested.
+	 */
+	if (vs->flags & VXLAN_F_GPE) {
+		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
+			goto drop;
+		raw_proto = true;
+	}
+
+	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
+				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
+		goto drop;
+
+	if (vs->flags & VXLAN_F_REMCSUM_RX)
+		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
+			goto drop;
+
+	if (vxlan_collect_metadata(vs)) {
+		struct metadata_dst *tun_dst;
+
+		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), TUNNEL_KEY,
+					 key32_to_tunnel_id(vni), sizeof(*md));
+
+		if (!tun_dst)
+			goto drop;
+
+		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
+
+		skb_dst_set(skb, (struct dst_entry *)tun_dst);
+	} else {
+		memset(md, 0, sizeof(*md));
+	}
+
+	if (vs->flags & VXLAN_F_GBP)
+		vxlan_parse_gbp_hdr(&unparsed, skb, vs->flags, md);
+	/* Note that GBP and GPE can never be active together. This is
+	 * ensured in vxlan_dev_configure.
+	 */
+
+	if (unparsed.vx_flags || unparsed.vx_vni) {
+		/* If there are any unprocessed flags remaining treat
+		 * this as a malformed packet. This behavior diverges from
+		 * VXLAN RFC (RFC7348) which stipulates that bits in reserved
+		 * in reserved fields are to be ignored. The approach here
+		 * maintains compatibility with previous stack code, and also
+		 * is more robust and provides a little more security in
+		 * adding extensions to VXLAN.
+		 */
+		goto drop;
+	}
+
+	if (!raw_proto) {
+		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+			goto drop;
+	} else {
+		skb_reset_mac_header(skb);
+		skb->dev = vxlan->dev;
+		skb->pkt_type = PACKET_HOST;
+	}
+
+	oiph = skb_network_header(skb);
+	skb_reset_network_header(skb);
+
+	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
+		++vxlan->dev->stats.rx_frame_errors;
+		++vxlan->dev->stats.rx_errors;
+		goto drop;
+	}
+
+	rcu_read_lock();
+
+	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
+		rcu_read_unlock();
+		atomic_long_inc(&vxlan->dev->rx_dropped);
+		goto drop;
+	}
+
+	dev_sw_netstats_rx_add(vxlan->dev, skb->len);
+	gro_cells_receive(&vxlan->gro_cells, skb);
+
+	rcu_read_unlock();
+
+	return 0;
+
+drop:
+	/* Consume bad packet */
+	kfree_skb(skb);
+	return 0;
+}
+
+/* Callback from net/ipv{4,6}/udp.c to check that we have a VNI for errors */
+static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan;
+	struct vxlan_sock *vs;
+	struct vxlanhdr *hdr;
+	__be32 vni;
+
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) + VXLAN_HLEN))
+		return -EINVAL;
+
+	hdr = vxlan_hdr(skb);
+
+	if (!(hdr->vx_flags & VXLAN_HF_VNI))
+		return -EINVAL;
+
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		return -ENOENT;
+
+	vni = vxlan_vni(hdr->vx_vni);
+	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni);
+	if (!vxlan)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct arphdr *parp;
+	u8 *arpptr, *sha;
+	__be32 sip, tip;
+	struct neighbour *n;
+
+	if (dev->flags & IFF_NOARP)
+		goto out;
+
+	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
+		dev->stats.tx_dropped++;
+		goto out;
+	}
+	parp = arp_hdr(skb);
+
+	if ((parp->ar_hrd != htons(ARPHRD_ETHER) &&
+	     parp->ar_hrd != htons(ARPHRD_IEEE802)) ||
+	    parp->ar_pro != htons(ETH_P_IP) ||
+	    parp->ar_op != htons(ARPOP_REQUEST) ||
+	    parp->ar_hln != dev->addr_len ||
+	    parp->ar_pln != 4)
+		goto out;
+	arpptr = (u8 *)parp + sizeof(struct arphdr);
+	sha = arpptr;
+	arpptr += dev->addr_len;	/* sha */
+	memcpy(&sip, arpptr, sizeof(sip));
+	arpptr += sizeof(sip);
+	arpptr += dev->addr_len;	/* tha */
+	memcpy(&tip, arpptr, sizeof(tip));
+
+	if (ipv4_is_loopback(tip) ||
+	    ipv4_is_multicast(tip))
+		goto out;
+
+	n = neigh_lookup(&arp_tbl, &tip, dev);
+
+	if (n) {
+		struct vxlan_fdb *f;
+		struct sk_buff	*reply;
+
+		if (!(n->nud_state & NUD_CONNECTED)) {
+			neigh_release(n);
+			goto out;
+		}
+
+		f = vxlan_find_mac(vxlan, n->ha, vni);
+		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+			/* bridge-local neighbor */
+			neigh_release(n);
+			goto out;
+		}
+
+		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
+				n->ha, sha);
+
+		neigh_release(n);
+
+		if (reply == NULL)
+			goto out;
+
+		skb_reset_mac_header(reply);
+		__skb_pull(reply, skb_network_offset(reply));
+		reply->ip_summed = CHECKSUM_UNNECESSARY;
+		reply->pkt_type = PACKET_HOST;
+
+		if (netif_rx_ni(reply) == NET_RX_DROP)
+			dev->stats.rx_dropped++;
+	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+		union vxlan_addr ipa = {
+			.sin.sin_addr.s_addr = tip,
+			.sin.sin_family = AF_INET,
+		};
+
+		vxlan_ip_miss(dev, &ipa);
+	}
+out:
+	consume_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct sk_buff *vxlan_na_create(struct sk_buff *request,
+	struct neighbour *n, bool isrouter)
+{
+	struct net_device *dev = request->dev;
+	struct sk_buff *reply;
+	struct nd_msg *ns, *na;
+	struct ipv6hdr *pip6;
+	u8 *daddr;
+	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
+	int ns_olen;
+	int i, len;
+
+	if (dev == NULL || !pskb_may_pull(request, request->len))
+		return NULL;
+
+	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
+		sizeof(*na) + na_olen + dev->needed_tailroom;
+	reply = alloc_skb(len, GFP_ATOMIC);
+	if (reply == NULL)
+		return NULL;
+
+	reply->protocol = htons(ETH_P_IPV6);
+	reply->dev = dev;
+	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
+	skb_push(reply, sizeof(struct ethhdr));
+	skb_reset_mac_header(reply);
+
+	ns = (struct nd_msg *)(ipv6_hdr(request) + 1);
+
+	daddr = eth_hdr(request)->h_source;
+	ns_olen = request->len - skb_network_offset(request) -
+		sizeof(struct ipv6hdr) - sizeof(*ns);
+	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
+		if (!ns->opt[i + 1]) {
+			kfree_skb(reply);
+			return NULL;
+		}
+		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
+			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
+			break;
+		}
+	}
+
+	/* Ethernet header */
+	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
+	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
+	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
+	reply->protocol = htons(ETH_P_IPV6);
+
+	skb_pull(reply, sizeof(struct ethhdr));
+	skb_reset_network_header(reply);
+	skb_put(reply, sizeof(struct ipv6hdr));
+
+	/* IPv6 header */
+
+	pip6 = ipv6_hdr(reply);
+	memset(pip6, 0, sizeof(struct ipv6hdr));
+	pip6->version = 6;
+	pip6->priority = ipv6_hdr(request)->priority;
+	pip6->nexthdr = IPPROTO_ICMPV6;
+	pip6->hop_limit = 255;
+	pip6->daddr = ipv6_hdr(request)->saddr;
+	pip6->saddr = *(struct in6_addr *)n->primary_key;
+
+	skb_pull(reply, sizeof(struct ipv6hdr));
+	skb_reset_transport_header(reply);
+
+	/* Neighbor Advertisement */
+	na = skb_put_zero(reply, sizeof(*na) + na_olen);
+	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
+	na->icmph.icmp6_router = isrouter;
+	na->icmph.icmp6_override = 1;
+	na->icmph.icmp6_solicited = 1;
+	na->target = ns->target;
+	ether_addr_copy(&na->opt[2], n->ha);
+	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
+	na->opt[1] = na_olen >> 3;
+
+	na->icmph.icmp6_cksum = csum_ipv6_magic(&pip6->saddr,
+		&pip6->daddr, sizeof(*na)+na_olen, IPPROTO_ICMPV6,
+		csum_partial(na, sizeof(*na)+na_olen, 0));
+
+	pip6->payload_len = htons(sizeof(*na)+na_olen);
+
+	skb_push(reply, sizeof(struct ipv6hdr));
+
+	reply->ip_summed = CHECKSUM_UNNECESSARY;
+
+	return reply;
+}
+
+static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct in6_addr *daddr;
+	const struct ipv6hdr *iphdr;
+	struct inet6_dev *in6_dev;
+	struct neighbour *n;
+	struct nd_msg *msg;
+
+	rcu_read_lock();
+	in6_dev = __in6_dev_get(dev);
+	if (!in6_dev)
+		goto out;
+
+	iphdr = ipv6_hdr(skb);
+	daddr = &iphdr->daddr;
+	msg = (struct nd_msg *)(iphdr + 1);
+
+	if (ipv6_addr_loopback(daddr) ||
+	    ipv6_addr_is_multicast(&msg->target))
+		goto out;
+
+	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
+
+	if (n) {
+		struct vxlan_fdb *f;
+		struct sk_buff *reply;
+
+		if (!(n->nud_state & NUD_CONNECTED)) {
+			neigh_release(n);
+			goto out;
+		}
+
+		f = vxlan_find_mac(vxlan, n->ha, vni);
+		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
+			/* bridge-local neighbor */
+			neigh_release(n);
+			goto out;
+		}
+
+		reply = vxlan_na_create(skb, n,
+					!!(f ? f->flags & NTF_ROUTER : 0));
+
+		neigh_release(n);
+
+		if (reply == NULL)
+			goto out;
+
+		if (netif_rx_ni(reply) == NET_RX_DROP)
+			dev->stats.rx_dropped++;
+
+	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+		union vxlan_addr ipa = {
+			.sin6.sin6_addr = msg->target,
+			.sin6.sin6_family = AF_INET6,
+		};
+
+		vxlan_ip_miss(dev, &ipa);
+	}
+
+out:
+	rcu_read_unlock();
+	consume_skb(skb);
+	return NETDEV_TX_OK;
+}
+#endif
+
+static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct neighbour *n;
+
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
+		return false;
+
+	n = NULL;
+	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	case ETH_P_IP:
+	{
+		struct iphdr *pip;
+
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return false;
+		pip = ip_hdr(skb);
+		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
+		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+			union vxlan_addr ipa = {
+				.sin.sin_addr.s_addr = pip->daddr,
+				.sin.sin_family = AF_INET,
+			};
+
+			vxlan_ip_miss(dev, &ipa);
+			return false;
+		}
+
+		break;
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
+	{
+		struct ipv6hdr *pip6;
+
+		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+			return false;
+		pip6 = ipv6_hdr(skb);
+		n = neigh_lookup(ipv6_stub->nd_tbl, &pip6->daddr, dev);
+		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+			union vxlan_addr ipa = {
+				.sin6.sin6_addr = pip6->daddr,
+				.sin6.sin6_family = AF_INET6,
+			};
+
+			vxlan_ip_miss(dev, &ipa);
+			return false;
+		}
+
+		break;
+	}
+#endif
+	default:
+		return false;
+	}
+
+	if (n) {
+		bool diff;
+
+		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
+		if (diff) {
+			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
+				dev->addr_len);
+			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
+		}
+		neigh_release(n);
+		return diff;
+	}
+
+	return false;
+}
+
+static void vxlan_build_gbp_hdr(struct vxlanhdr *vxh, u32 vxflags,
+				struct vxlan_metadata *md)
+{
+	struct vxlanhdr_gbp *gbp;
+
+	if (!md->gbp)
+		return;
+
+	gbp = (struct vxlanhdr_gbp *)vxh;
+	vxh->vx_flags |= VXLAN_HF_GBP;
+
+	if (md->gbp & VXLAN_GBP_DONT_LEARN)
+		gbp->dont_learn = 1;
+
+	if (md->gbp & VXLAN_GBP_POLICY_APPLIED)
+		gbp->policy_applied = 1;
+
+	gbp->policy_id = htons(md->gbp & VXLAN_GBP_ID_MASK);
+}
+
+static int vxlan_build_gpe_hdr(struct vxlanhdr *vxh, u32 vxflags,
+			       __be16 protocol)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)vxh;
+
+	gpe->np_applied = 1;
+	gpe->next_protocol = tun_p_from_eth_p(protocol);
+	if (!gpe->next_protocol)
+		return -EPFNOSUPPORT;
+	return 0;
+}
+
+static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
+			   int iphdr_len, __be32 vni,
+			   struct vxlan_metadata *md, u32 vxflags,
+			   bool udp_sum)
+{
+	struct vxlanhdr *vxh;
+	int min_headroom;
+	int err;
+	int type = udp_sum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
+	__be16 inner_protocol = htons(ETH_P_TEB);
+
+	if ((vxflags & VXLAN_F_REMCSUM_TX) &&
+	    skb->ip_summed == CHECKSUM_PARTIAL) {
+		int csum_start = skb_checksum_start_offset(skb);
+
+		if (csum_start <= VXLAN_MAX_REMCSUM_START &&
+		    !(csum_start & VXLAN_RCO_SHIFT_MASK) &&
+		    (skb->csum_offset == offsetof(struct udphdr, check) ||
+		     skb->csum_offset == offsetof(struct tcphdr, check)))
+			type |= SKB_GSO_TUNNEL_REMCSUM;
+	}
+
+	min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len
+			+ VXLAN_HLEN + iphdr_len;
+
+	/* Need space for new headers (invalidates iph ptr) */
+	err = skb_cow_head(skb, min_headroom);
+	if (unlikely(err))
+		return err;
+
+	err = iptunnel_handle_offloads(skb, type);
+	if (err)
+		return err;
+
+	vxh = __skb_push(skb, sizeof(*vxh));
+	vxh->vx_flags = VXLAN_HF_VNI;
+	vxh->vx_vni = vxlan_vni_field(vni);
+
+	if (type & SKB_GSO_TUNNEL_REMCSUM) {
+		unsigned int start;
+
+		start = skb_checksum_start_offset(skb) - sizeof(struct vxlanhdr);
+		vxh->vx_vni |= vxlan_compute_rco(start, skb->csum_offset);
+		vxh->vx_flags |= VXLAN_HF_RCO;
+
+		if (!skb_is_gso(skb)) {
+			skb->ip_summed = CHECKSUM_NONE;
+			skb->encapsulation = 0;
+		}
+	}
+
+	if (vxflags & VXLAN_F_GBP)
+		vxlan_build_gbp_hdr(vxh, vxflags, md);
+	if (vxflags & VXLAN_F_GPE) {
+		err = vxlan_build_gpe_hdr(vxh, vxflags, skb->protocol);
+		if (err < 0)
+			return err;
+		inner_protocol = skb->protocol;
+	}
+
+	skb_set_inner_protocol(skb, inner_protocol);
+	return 0;
+}
+
+static struct rtable *vxlan_get_route(struct vxlan_dev *vxlan, struct net_device *dev,
+				      struct vxlan_sock *sock4,
+				      struct sk_buff *skb, int oif, u8 tos,
+				      __be32 daddr, __be32 *saddr, __be16 dport, __be16 sport,
+				      struct dst_cache *dst_cache,
+				      const struct ip_tunnel_info *info)
+{
+	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	struct rtable *rt = NULL;
+	struct flowi4 fl4;
+
+	if (!sock4)
+		return ERR_PTR(-EIO);
+
+	if (tos && !info)
+		use_cache = false;
+	if (use_cache) {
+		rt = dst_cache_get_ip4(dst_cache, saddr);
+		if (rt)
+			return rt;
+	}
+
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.flowi4_oif = oif;
+	fl4.flowi4_tos = RT_TOS(tos);
+	fl4.flowi4_mark = skb->mark;
+	fl4.flowi4_proto = IPPROTO_UDP;
+	fl4.daddr = daddr;
+	fl4.saddr = *saddr;
+	fl4.fl4_dport = dport;
+	fl4.fl4_sport = sport;
+
+	rt = ip_route_output_key(vxlan->net, &fl4);
+	if (!IS_ERR(rt)) {
+		if (rt->dst.dev == dev) {
+			netdev_dbg(dev, "circular route to %pI4\n", &daddr);
+			ip_rt_put(rt);
+			return ERR_PTR(-ELOOP);
+		}
+
+		*saddr = fl4.saddr;
+		if (use_cache)
+			dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+	} else {
+		netdev_dbg(dev, "no route to %pI4\n", &daddr);
+		return ERR_PTR(-ENETUNREACH);
+	}
+	return rt;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
+					  struct net_device *dev,
+					  struct vxlan_sock *sock6,
+					  struct sk_buff *skb, int oif, u8 tos,
+					  __be32 label,
+					  const struct in6_addr *daddr,
+					  struct in6_addr *saddr,
+					  __be16 dport, __be16 sport,
+					  struct dst_cache *dst_cache,
+					  const struct ip_tunnel_info *info)
+{
+	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	struct dst_entry *ndst;
+	struct flowi6 fl6;
+
+	if (!sock6)
+		return ERR_PTR(-EIO);
+
+	if (tos && !info)
+		use_cache = false;
+	if (use_cache) {
+		ndst = dst_cache_get_ip6(dst_cache, saddr);
+		if (ndst)
+			return ndst;
+	}
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_oif = oif;
+	fl6.daddr = *daddr;
+	fl6.saddr = *saddr;
+	fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tos), label);
+	fl6.flowi6_mark = skb->mark;
+	fl6.flowi6_proto = IPPROTO_UDP;
+	fl6.fl6_dport = dport;
+	fl6.fl6_sport = sport;
+
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(vxlan->net, sock6->sock->sk,
+					       &fl6, NULL);
+	if (IS_ERR(ndst)) {
+		netdev_dbg(dev, "no route to %pI6\n", daddr);
+		return ERR_PTR(-ENETUNREACH);
+	}
+
+	if (unlikely(ndst->dev == dev)) {
+		netdev_dbg(dev, "circular route to %pI6\n", daddr);
+		dst_release(ndst);
+		return ERR_PTR(-ELOOP);
+	}
+
+	*saddr = fl6.saddr;
+	if (use_cache)
+		dst_cache_set_ip6(dst_cache, ndst, saddr);
+	return ndst;
+}
+#endif
+
+/* Bypass encapsulation if the destination is local */
+static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
+			       struct vxlan_dev *dst_vxlan, __be32 vni,
+			       bool snoop)
+{
+	struct pcpu_sw_netstats *tx_stats, *rx_stats;
+	union vxlan_addr loopback;
+	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
+	struct net_device *dev;
+	int len = skb->len;
+
+	tx_stats = this_cpu_ptr(src_vxlan->dev->tstats);
+	rx_stats = this_cpu_ptr(dst_vxlan->dev->tstats);
+	skb->pkt_type = PACKET_HOST;
+	skb->encapsulation = 0;
+	skb->dev = dst_vxlan->dev;
+	__skb_pull(skb, skb_network_offset(skb));
+
+	if (remote_ip->sa.sa_family == AF_INET) {
+		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+		loopback.sa.sa_family =  AF_INET;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		loopback.sin6.sin6_addr = in6addr_loopback;
+		loopback.sa.sa_family =  AF_INET6;
+#endif
+	}
+
+	rcu_read_lock();
+	dev = skb->dev;
+	if (unlikely(!(dev->flags & IFF_UP))) {
+		kfree_skb(skb);
+		goto drop;
+	}
+
+	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
+		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
+
+	u64_stats_update_begin(&tx_stats->syncp);
+	tx_stats->tx_packets++;
+	tx_stats->tx_bytes += len;
+	u64_stats_update_end(&tx_stats->syncp);
+
+	if (netif_rx(skb) == NET_RX_SUCCESS) {
+		u64_stats_update_begin(&rx_stats->syncp);
+		rx_stats->rx_packets++;
+		rx_stats->rx_bytes += len;
+		u64_stats_update_end(&rx_stats->syncp);
+	} else {
+drop:
+		dev->stats.rx_dropped++;
+	}
+	rcu_read_unlock();
+}
+
+static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
+				 struct vxlan_dev *vxlan,
+				 union vxlan_addr *daddr,
+				 __be16 dst_port, int dst_ifindex, __be32 vni,
+				 struct dst_entry *dst,
+				 u32 rt_flags)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	/* IPv6 rt-flags are checked against RTF_LOCAL, but the value of
+	 * RTF_LOCAL is equal to RTCF_LOCAL. So to keep code simple
+	 * we can use RTCF_LOCAL which works for ipv4 and ipv6 route entry.
+	 */
+	BUILD_BUG_ON(RTCF_LOCAL != RTF_LOCAL);
+#endif
+	/* Bypass encapsulation if the destination is local */
+	if (rt_flags & RTCF_LOCAL &&
+	    !(rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))) {
+		struct vxlan_dev *dst_vxlan;
+
+		dst_release(dst);
+		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
+					   daddr->sa.sa_family, dst_port,
+					   vxlan->cfg.flags);
+		if (!dst_vxlan) {
+			dev->stats.tx_errors++;
+			kfree_skb(skb);
+
+			return -ENOENT;
+		}
+		vxlan_encap_bypass(skb, vxlan, dst_vxlan, vni, true);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+			   __be32 default_vni, struct vxlan_rdst *rdst,
+			   bool did_rsc)
+{
+	struct dst_cache *dst_cache;
+	struct ip_tunnel_info *info;
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct iphdr *old_iph = ip_hdr(skb);
+	union vxlan_addr *dst;
+	union vxlan_addr remote_ip, local_ip;
+	struct vxlan_metadata _md;
+	struct vxlan_metadata *md = &_md;
+	__be16 src_port = 0, dst_port;
+	struct dst_entry *ndst = NULL;
+	__be32 vni, label;
+	__u8 tos, ttl;
+	int ifindex;
+	int err;
+	u32 flags = vxlan->cfg.flags;
+	bool udp_sum = false;
+	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
+
+	info = skb_tunnel_info(skb);
+
+	if (rdst) {
+		dst = &rdst->remote_ip;
+		if (vxlan_addr_any(dst)) {
+			if (did_rsc) {
+				/* short-circuited back to local bridge */
+				vxlan_encap_bypass(skb, vxlan, vxlan,
+						   default_vni, true);
+				return;
+			}
+			goto drop;
+		}
+
+		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
+		vni = (rdst->remote_vni) ? : default_vni;
+		ifindex = rdst->remote_ifindex;
+		local_ip = vxlan->cfg.saddr;
+		dst_cache = &rdst->dst_cache;
+		md->gbp = skb->mark;
+		if (flags & VXLAN_F_TTL_INHERIT) {
+			ttl = ip_tunnel_get_ttl(old_iph, skb);
+		} else {
+			ttl = vxlan->cfg.ttl;
+			if (!ttl && vxlan_addr_multicast(dst))
+				ttl = 1;
+		}
+
+		tos = vxlan->cfg.tos;
+		if (tos == 1)
+			tos = ip_tunnel_get_dsfield(old_iph, skb);
+
+		if (dst->sa.sa_family == AF_INET)
+			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
+		else
+			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
+		label = vxlan->cfg.label;
+	} else {
+		if (!info) {
+			WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
+				  dev->name);
+			goto drop;
+		}
+		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
+		if (remote_ip.sa.sa_family == AF_INET) {
+			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
+			local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
+		} else {
+			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
+			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
+		}
+		dst = &remote_ip;
+		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
+		vni = tunnel_id_to_key32(info->key.tun_id);
+		ifindex = 0;
+		dst_cache = &info->dst_cache;
+		if (info->key.tun_flags & TUNNEL_VXLAN_OPT) {
+			if (info->options_len < sizeof(*md))
+				goto drop;
+			md = ip_tunnel_info_opts(info);
+		}
+		ttl = info->key.ttl;
+		tos = info->key.tos;
+		label = info->key.label;
+		udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
+	}
+	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
+				     vxlan->cfg.port_max, true);
+
+	rcu_read_lock();
+	if (dst->sa.sa_family == AF_INET) {
+		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		struct rtable *rt;
+		__be16 df = 0;
+
+		if (!ifindex)
+			ifindex = sock4->sock->sk->sk_bound_dev_if;
+
+		rt = vxlan_get_route(vxlan, dev, sock4, skb, ifindex, tos,
+				     dst->sin.sin_addr.s_addr,
+				     &local_ip.sin.sin_addr.s_addr,
+				     dst_port, src_port,
+				     dst_cache, info);
+		if (IS_ERR(rt)) {
+			err = PTR_ERR(rt);
+			goto tx_error;
+		}
+
+		if (!info) {
+			/* Bypass encapsulation if the destination is local */
+			err = encap_bypass_if_local(skb, dev, vxlan, dst,
+						    dst_port, ifindex, vni,
+						    &rt->dst, rt->rt_flags);
+			if (err)
+				goto out_unlock;
+
+			if (vxlan->cfg.df == VXLAN_DF_SET) {
+				df = htons(IP_DF);
+			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
+				struct ethhdr *eth = eth_hdr(skb);
+
+				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
+				    (ntohs(eth->h_proto) == ETH_P_IP &&
+				     old_iph->frag_off & htons(IP_DF)))
+					df = htons(IP_DF);
+			}
+		} else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT) {
+			df = htons(IP_DF);
+		}
+
+		ndst = &rt->dst;
+		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
+					    netif_is_any_bridge_port(dev));
+		if (err < 0) {
+			goto tx_error;
+		} else if (err) {
+			if (info) {
+				struct ip_tunnel_info *unclone;
+				struct in_addr src, dst;
+
+				unclone = skb_tunnel_info_unclone(skb);
+				if (unlikely(!unclone))
+					goto tx_error;
+
+				src = remote_ip.sin.sin_addr;
+				dst = local_ip.sin.sin_addr;
+				unclone->key.u.ipv4.src = src.s_addr;
+				unclone->key.u.ipv4.dst = dst.s_addr;
+			}
+			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			dst_release(ndst);
+			goto out_unlock;
+		}
+
+		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
+		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
+				      vni, md, flags, udp_sum);
+		if (err < 0)
+			goto tx_error;
+
+		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
+				    dst->sin.sin_addr.s_addr, tos, ttl, df,
+				    src_port, dst_port, xnet, !udp_sum);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+
+		if (!ifindex)
+			ifindex = sock6->sock->sk->sk_bound_dev_if;
+
+		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
+					label, &dst->sin6.sin6_addr,
+					&local_ip.sin6.sin6_addr,
+					dst_port, src_port,
+					dst_cache, info);
+		if (IS_ERR(ndst)) {
+			err = PTR_ERR(ndst);
+			ndst = NULL;
+			goto tx_error;
+		}
+
+		if (!info) {
+			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
+
+			err = encap_bypass_if_local(skb, dev, vxlan, dst,
+						    dst_port, ifindex, vni,
+						    ndst, rt6i_flags);
+			if (err)
+				goto out_unlock;
+		}
+
+		err = skb_tunnel_check_pmtu(skb, ndst,
+					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
+					    netif_is_any_bridge_port(dev));
+		if (err < 0) {
+			goto tx_error;
+		} else if (err) {
+			if (info) {
+				struct ip_tunnel_info *unclone;
+				struct in6_addr src, dst;
+
+				unclone = skb_tunnel_info_unclone(skb);
+				if (unlikely(!unclone))
+					goto tx_error;
+
+				src = remote_ip.sin6.sin6_addr;
+				dst = local_ip.sin6.sin6_addr;
+				unclone->key.u.ipv6.src = src;
+				unclone->key.u.ipv6.dst = dst;
+			}
+
+			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			dst_release(ndst);
+			goto out_unlock;
+		}
+
+		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		ttl = ttl ? : ip6_dst_hoplimit(ndst);
+		skb_scrub_packet(skb, xnet);
+		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
+				      vni, md, flags, udp_sum);
+		if (err < 0)
+			goto tx_error;
+
+		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
+				     &local_ip.sin6.sin6_addr,
+				     &dst->sin6.sin6_addr, tos, ttl,
+				     label, src_port, dst_port, !udp_sum);
+#endif
+	}
+out_unlock:
+	rcu_read_unlock();
+	return;
+
+drop:
+	dev->stats.tx_dropped++;
+	dev_kfree_skb(skb);
+	return;
+
+tx_error:
+	rcu_read_unlock();
+	if (err == -ELOOP)
+		dev->stats.collisions++;
+	else if (err == -ENETUNREACH)
+		dev->stats.tx_carrier_errors++;
+	dst_release(ndst);
+	dev->stats.tx_errors++;
+	kfree_skb(skb);
+}
+
+static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
+			  struct vxlan_fdb *f, __be32 vni, bool did_rsc)
+{
+	struct vxlan_rdst nh_rdst;
+	struct nexthop *nh;
+	bool do_xmit;
+	u32 hash;
+
+	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
+	hash = skb_get_hash(skb);
+
+	rcu_read_lock();
+	nh = rcu_dereference(f->nh);
+	if (!nh) {
+		rcu_read_unlock();
+		goto drop;
+	}
+	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
+	rcu_read_unlock();
+
+	if (likely(do_xmit))
+		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
+	else
+		goto drop;
+
+	return;
+
+drop:
+	dev->stats.tx_dropped++;
+	dev_kfree_skb(skb);
+}
+
+/* Transmit local packets over Vxlan
+ *
+ * Outer IP header inherits ECN and DF from inner header.
+ * Outer UDP destination is the VXLAN assigned port.
+ *           source port is based on hash of flow
+ */
+static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *rdst, *fdst = NULL;
+	const struct ip_tunnel_info *info;
+	bool did_rsc = false;
+	struct vxlan_fdb *f;
+	struct ethhdr *eth;
+	__be32 vni = 0;
+
+	info = skb_tunnel_info(skb);
+
+	skb_reset_mac_header(skb);
+
+	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
+		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
+		    info->mode & IP_TUNNEL_INFO_TX) {
+			vni = tunnel_id_to_key32(info->key.tun_id);
+		} else {
+			if (info && info->mode & IP_TUNNEL_INFO_TX)
+				vxlan_xmit_one(skb, dev, vni, NULL, false);
+			else
+				kfree_skb(skb);
+			return NETDEV_TX_OK;
+		}
+	}
+
+	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
+		eth = eth_hdr(skb);
+		if (ntohs(eth->h_proto) == ETH_P_ARP)
+			return arp_reduce(dev, skb, vni);
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
+			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
+					    sizeof(struct nd_msg)) &&
+			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
+			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
+
+			if (m->icmph.icmp6_code == 0 &&
+			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
+				return neigh_reduce(dev, skb, vni);
+		}
+#endif
+	}
+
+	eth = eth_hdr(skb);
+	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+	did_rsc = false;
+
+	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
+	    (ntohs(eth->h_proto) == ETH_P_IP ||
+	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
+		did_rsc = route_shortcircuit(dev, skb);
+		if (did_rsc)
+			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
+	}
+
+	if (f == NULL) {
+		f = vxlan_find_mac(vxlan, all_zeros_mac, vni);
+		if (f == NULL) {
+			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
+			    !is_multicast_ether_addr(eth->h_dest))
+				vxlan_fdb_miss(vxlan, eth->h_dest);
+
+			dev->stats.tx_dropped++;
+			kfree_skb(skb);
+			return NETDEV_TX_OK;
+		}
+	}
+
+	if (rcu_access_pointer(f->nh)) {
+		vxlan_xmit_nh(skb, dev, f,
+			      (vni ? : vxlan->default_dst.remote_vni), did_rsc);
+	} else {
+		list_for_each_entry_rcu(rdst, &f->remotes, list) {
+			struct sk_buff *skb1;
+
+			if (!fdst) {
+				fdst = rdst;
+				continue;
+			}
+			skb1 = skb_clone(skb, GFP_ATOMIC);
+			if (skb1)
+				vxlan_xmit_one(skb1, dev, vni, rdst, did_rsc);
+		}
+		if (fdst)
+			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
+		else
+			kfree_skb(skb);
+	}
+
+	return NETDEV_TX_OK;
+}
+
+/* Walk the forwarding table and purge stale entries */
+static void vxlan_cleanup(struct timer_list *t)
+{
+	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
+	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
+	unsigned int h;
+
+	if (!netif_running(vxlan->dev))
+		return;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		struct hlist_node *p, *n;
+
+		spin_lock(&vxlan->hash_lock[h]);
+		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
+			struct vxlan_fdb *f
+				= container_of(p, struct vxlan_fdb, hlist);
+			unsigned long timeout;
+
+			if (f->state & (NUD_PERMANENT | NUD_NOARP))
+				continue;
+
+			if (f->flags & NTF_EXT_LEARNED)
+				continue;
+
+			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			if (time_before_eq(timeout, jiffies)) {
+				netdev_dbg(vxlan->dev,
+					   "garbage collect %pM\n",
+					   f->eth_addr);
+				f->state = NUD_STALE;
+				vxlan_fdb_destroy(vxlan, f, true, true);
+			} else if (time_before(timeout, next_timer))
+				next_timer = timeout;
+		}
+		spin_unlock(&vxlan->hash_lock[h]);
+	}
+
+	mod_timer(&vxlan->age_timer, next_timer);
+}
+
+static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
+{
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+
+	spin_lock(&vn->sock_lock);
+	hlist_del_init_rcu(&vxlan->hlist4.hlist);
+#if IS_ENABLED(CONFIG_IPV6)
+	hlist_del_init_rcu(&vxlan->hlist6.hlist);
+#endif
+	spin_unlock(&vn->sock_lock);
+}
+
+static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
+			     struct vxlan_dev_node *node)
+{
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	__be32 vni = vxlan->default_dst.remote_vni;
+
+	node->vxlan = vxlan;
+	spin_lock(&vn->sock_lock);
+	hlist_add_head_rcu(&node->hlist, vni_head(vs, vni));
+	spin_unlock(&vn->sock_lock);
+}
+
+/* Setup stats when device is created */
+static int vxlan_init(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err;
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
+
+	err = gro_cells_init(&vxlan->gro_cells, dev);
+	if (err) {
+		free_percpu(dev->tstats);
+		return err;
+	}
+
+	return 0;
+}
+
+static void vxlan_fdb_delete_default(struct vxlan_dev *vxlan, __be32 vni)
+{
+	struct vxlan_fdb *f;
+	u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, vni);
+
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	f = __vxlan_find_mac(vxlan, all_zeros_mac, vni);
+	if (f)
+		vxlan_fdb_destroy(vxlan, f, true, true);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+}
+
+static void vxlan_uninit(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	gro_cells_destroy(&vxlan->gro_cells);
+
+	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
+
+	free_percpu(dev->tstats);
+}
+
+/* Start ageing timer and join group when device is brought up */
+static int vxlan_open(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int ret;
+
+	ret = vxlan_sock_add(vxlan);
+	if (ret < 0)
+		return ret;
+
+	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
+		ret = vxlan_igmp_join(vxlan);
+		if (ret == -EADDRINUSE)
+			ret = 0;
+		if (ret) {
+			vxlan_sock_release(vxlan);
+			return ret;
+		}
+	}
+
+	if (vxlan->cfg.age_interval)
+		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
+
+	return ret;
+}
+
+/* Purge the forwarding table */
+static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
+{
+	unsigned int h;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		struct hlist_node *p, *n;
+
+		spin_lock_bh(&vxlan->hash_lock[h]);
+		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
+			struct vxlan_fdb *f
+				= container_of(p, struct vxlan_fdb, hlist);
+			if (!do_all && (f->state & (NUD_PERMANENT | NUD_NOARP)))
+				continue;
+			/* the all_zeros_mac entry is deleted at vxlan_uninit */
+			if (is_zero_ether_addr(f->eth_addr) &&
+			    f->vni == vxlan->cfg.vni)
+				continue;
+			vxlan_fdb_destroy(vxlan, f, true, true);
+		}
+		spin_unlock_bh(&vxlan->hash_lock[h]);
+	}
+}
+
+/* Cleanup timer and forwarding table on shutdown */
+static int vxlan_stop(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	int ret = 0;
+
+	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
+	    !vxlan_group_used(vn, vxlan))
+		ret = vxlan_igmp_leave(vxlan);
+
+	del_timer_sync(&vxlan->age_timer);
+
+	vxlan_flush(vxlan, false);
+	vxlan_sock_release(vxlan);
+
+	return ret;
+}
+
+/* Stub, nothing needs to be done. */
+static void vxlan_set_multicast_list(struct net_device *dev)
+{
+}
+
+static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
+							 dst->remote_ifindex);
+
+	/* This check is different than dev->max_mtu, because it looks at
+	 * the lowerdev->mtu, rather than the static dev->max_mtu
+	 */
+	if (lowerdev) {
+		int max_mtu = lowerdev->mtu - vxlan_headroom(vxlan->cfg.flags);
+		if (new_mtu > max_mtu)
+			return -EINVAL;
+	}
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct ip_tunnel_info *info = skb_tunnel_info(skb);
+	__be16 sport, dport;
+
+	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
+				  vxlan->cfg.port_max, true);
+	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
+
+	if (ip_tunnel_info_af(info) == AF_INET) {
+		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		struct rtable *rt;
+
+		rt = vxlan_get_route(vxlan, dev, sock4, skb, 0, info->key.tos,
+				     info->key.u.ipv4.dst,
+				     &info->key.u.ipv4.src, dport, sport,
+				     &info->dst_cache, info);
+		if (IS_ERR(rt))
+			return PTR_ERR(rt);
+		ip_rt_put(rt);
+	} else {
+#if IS_ENABLED(CONFIG_IPV6)
+		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+		struct dst_entry *ndst;
+
+		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, 0, info->key.tos,
+					info->key.label, &info->key.u.ipv6.dst,
+					&info->key.u.ipv6.src, dport, sport,
+					&info->dst_cache, info);
+		if (IS_ERR(ndst))
+			return PTR_ERR(ndst);
+		dst_release(ndst);
+#else /* !CONFIG_IPV6 */
+		return -EPFNOSUPPORT;
+#endif
+	}
+	info->key.tp_src = sport;
+	info->key.tp_dst = dport;
+	return 0;
+}
+
+static const struct net_device_ops vxlan_netdev_ether_ops = {
+	.ndo_init		= vxlan_init,
+	.ndo_uninit		= vxlan_uninit,
+	.ndo_open		= vxlan_open,
+	.ndo_stop		= vxlan_stop,
+	.ndo_start_xmit		= vxlan_xmit,
+	.ndo_get_stats64	= dev_get_tstats64,
+	.ndo_set_rx_mode	= vxlan_set_multicast_list,
+	.ndo_change_mtu		= vxlan_change_mtu,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_fdb_add		= vxlan_fdb_add,
+	.ndo_fdb_del		= vxlan_fdb_delete,
+	.ndo_fdb_dump		= vxlan_fdb_dump,
+	.ndo_fdb_get		= vxlan_fdb_get,
+	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
+	.ndo_change_proto_down  = dev_change_proto_down_generic,
+};
+
+static const struct net_device_ops vxlan_netdev_raw_ops = {
+	.ndo_init		= vxlan_init,
+	.ndo_uninit		= vxlan_uninit,
+	.ndo_open		= vxlan_open,
+	.ndo_stop		= vxlan_stop,
+	.ndo_start_xmit		= vxlan_xmit,
+	.ndo_get_stats64	= dev_get_tstats64,
+	.ndo_change_mtu		= vxlan_change_mtu,
+	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
+};
+
+/* Info for udev, that this is a virtual tunnel endpoint */
+static struct device_type vxlan_type = {
+	.name = "vxlan",
+};
+
+/* Calls the ndo_udp_tunnel_add of the caller in order to
+ * supply the listening VXLAN udp ports. Callers are expected
+ * to implement the ndo_udp_tunnel_add.
+ */
+static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
+{
+	struct vxlan_sock *vs;
+	struct net *net = dev_net(dev);
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	unsigned int i;
+
+	spin_lock(&vn->sock_lock);
+	for (i = 0; i < PORT_HASH_SIZE; ++i) {
+		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
+			unsigned short type;
+
+			if (vs->flags & VXLAN_F_GPE)
+				type = UDP_TUNNEL_TYPE_VXLAN_GPE;
+			else
+				type = UDP_TUNNEL_TYPE_VXLAN;
+
+			if (push)
+				udp_tunnel_push_rx_port(dev, vs->sock, type);
+			else
+				udp_tunnel_drop_rx_port(dev, vs->sock, type);
+		}
+	}
+	spin_unlock(&vn->sock_lock);
+}
+
+/* Initialize the device structure. */
+static void vxlan_setup(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	unsigned int h;
+
+	eth_hw_addr_random(dev);
+	ether_setup(dev);
+
+	dev->needs_free_netdev = true;
+	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
+
+	dev->features	|= NETIF_F_LLTX;
+	dev->features	|= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
+	dev->features   |= NETIF_F_RXCSUM;
+	dev->features   |= NETIF_F_GSO_SOFTWARE;
+
+	dev->vlan_features = dev->features;
+	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
+	dev->hw_features |= NETIF_F_RXCSUM;
+	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+	netif_keep_dst(dev);
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	/* MTU range: 68 - 65535 */
+	dev->min_mtu = ETH_MIN_MTU;
+	dev->max_mtu = ETH_MAX_MTU;
+
+	INIT_LIST_HEAD(&vxlan->next);
+
+	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
+
+	vxlan->dev = dev;
+
+	for (h = 0; h < FDB_HASH_SIZE; ++h) {
+		spin_lock_init(&vxlan->hash_lock[h]);
+		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
+	}
+}
+
+static void vxlan_ether_setup(struct net_device *dev)
+{
+	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->netdev_ops = &vxlan_netdev_ether_ops;
+}
+
+static void vxlan_raw_setup(struct net_device *dev)
+{
+	dev->header_ops = NULL;
+	dev->type = ARPHRD_NONE;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
+	dev->netdev_ops = &vxlan_netdev_raw_ops;
+}
+
+static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
+	[IFLA_VXLAN_ID]		= { .type = NLA_U32 },
+	[IFLA_VXLAN_GROUP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_VXLAN_GROUP6]	= { .len = sizeof(struct in6_addr) },
+	[IFLA_VXLAN_LINK]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_LOCAL]	= { .len = sizeof_field(struct iphdr, saddr) },
+	[IFLA_VXLAN_LOCAL6]	= { .len = sizeof(struct in6_addr) },
+	[IFLA_VXLAN_TOS]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_TTL]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_LABEL]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_LEARNING]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_AGEING]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_LIMIT]	= { .type = NLA_U32 },
+	[IFLA_VXLAN_PORT_RANGE] = { .len  = sizeof(struct ifla_vxlan_port_range) },
+	[IFLA_VXLAN_PROXY]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_RSC]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_L2MISS]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_L3MISS]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_COLLECT_METADATA]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_PORT]	= { .type = NLA_U16 },
+	[IFLA_VXLAN_UDP_CSUM]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_REMCSUM_TX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_REMCSUM_RX]	= { .type = NLA_U8 },
+	[IFLA_VXLAN_GBP]	= { .type = NLA_FLAG, },
+	[IFLA_VXLAN_GPE]	= { .type = NLA_FLAG, },
+	[IFLA_VXLAN_REMCSUM_NOPARTIAL]	= { .type = NLA_FLAG },
+	[IFLA_VXLAN_TTL_INHERIT]	= { .type = NLA_FLAG },
+	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
+};
+
+static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
+			  struct netlink_ext_ack *extack)
+{
+	if (tb[IFLA_ADDRESS]) {
+		if (nla_len(tb[IFLA_ADDRESS]) != ETH_ALEN) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
+					    "Provided link layer address is not Ethernet");
+			return -EINVAL;
+		}
+
+		if (!is_valid_ether_addr(nla_data(tb[IFLA_ADDRESS]))) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_ADDRESS],
+					    "Provided Ethernet address is not unicast");
+			return -EADDRNOTAVAIL;
+		}
+	}
+
+	if (tb[IFLA_MTU]) {
+		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
+
+		if (mtu < ETH_MIN_MTU || mtu > ETH_MAX_MTU) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
+					    "MTU must be between 68 and 65535");
+			return -EINVAL;
+		}
+	}
+
+	if (!data) {
+		NL_SET_ERR_MSG(extack,
+			       "Required attributes not provided to perform the operation");
+		return -EINVAL;
+	}
+
+	if (data[IFLA_VXLAN_ID]) {
+		u32 id = nla_get_u32(data[IFLA_VXLAN_ID]);
+
+		if (id >= VXLAN_N_VID) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_ID],
+					    "VXLAN ID must be lower than 16777216");
+			return -ERANGE;
+		}
+	}
+
+	if (data[IFLA_VXLAN_PORT_RANGE]) {
+		const struct ifla_vxlan_port_range *p
+			= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
+
+		if (ntohs(p->high) < ntohs(p->low)) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_PORT_RANGE],
+					    "Invalid source port range");
+			return -EINVAL;
+		}
+	}
+
+	if (data[IFLA_VXLAN_DF]) {
+		enum ifla_vxlan_df df = nla_get_u8(data[IFLA_VXLAN_DF]);
+
+		if (df < 0 || df > VXLAN_DF_MAX) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_DF],
+					    "Invalid DF attribute");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void vxlan_get_drvinfo(struct net_device *netdev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	strlcpy(drvinfo->version, VXLAN_VERSION, sizeof(drvinfo->version));
+	strlcpy(drvinfo->driver, "vxlan", sizeof(drvinfo->driver));
+}
+
+static int vxlan_get_link_ksettings(struct net_device *dev,
+				    struct ethtool_link_ksettings *cmd)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
+							 dst->remote_ifindex);
+
+	if (!lowerdev) {
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+		cmd->base.port = PORT_OTHER;
+		cmd->base.speed = SPEED_UNKNOWN;
+
+		return 0;
+	}
+
+	return __ethtool_get_link_ksettings(lowerdev, cmd);
+}
+
+static const struct ethtool_ops vxlan_ethtool_ops = {
+	.get_drvinfo		= vxlan_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= vxlan_get_link_ksettings,
+};
+
+static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
+					__be16 port, u32 flags, int ifindex)
+{
+	struct socket *sock;
+	struct udp_port_cfg udp_conf;
+	int err;
+
+	memset(&udp_conf, 0, sizeof(udp_conf));
+
+	if (ipv6) {
+		udp_conf.family = AF_INET6;
+		udp_conf.use_udp6_rx_checksums =
+		    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
+		udp_conf.ipv6_v6only = 1;
+	} else {
+		udp_conf.family = AF_INET;
+	}
+
+	udp_conf.local_udp_port = port;
+	udp_conf.bind_ifindex = ifindex;
+
+	/* Open UDP socket */
+	err = udp_sock_create(net, &udp_conf, &sock);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	udp_allow_gso(sock->sk);
+	return sock;
+}
+
+/* Create new listen socket if needed */
+static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
+					      __be16 port, u32 flags,
+					      int ifindex)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_sock *vs;
+	struct socket *sock;
+	unsigned int h;
+	struct udp_tunnel_sock_cfg tunnel_cfg;
+
+	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
+	if (!vs)
+		return ERR_PTR(-ENOMEM);
+
+	for (h = 0; h < VNI_HASH_SIZE; ++h)
+		INIT_HLIST_HEAD(&vs->vni_list[h]);
+
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	if (IS_ERR(sock)) {
+		kfree(vs);
+		return ERR_CAST(sock);
+	}
+
+	vs->sock = sock;
+	refcount_set(&vs->refcnt, 1);
+	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
+
+	spin_lock(&vn->sock_lock);
+	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
+	udp_tunnel_notify_add_rx_port(sock,
+				      (vs->flags & VXLAN_F_GPE) ?
+				      UDP_TUNNEL_TYPE_VXLAN_GPE :
+				      UDP_TUNNEL_TYPE_VXLAN);
+	spin_unlock(&vn->sock_lock);
+
+	/* Mark socket as an encapsulation socket. */
+	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
+	tunnel_cfg.sk_user_data = vs;
+	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_rcv = vxlan_rcv;
+	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
+	tunnel_cfg.encap_destroy = NULL;
+	tunnel_cfg.gro_receive = vxlan_gro_receive;
+	tunnel_cfg.gro_complete = vxlan_gro_complete;
+
+	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
+
+	return vs;
+}
+
+static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
+{
+	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	struct vxlan_sock *vs = NULL;
+	struct vxlan_dev_node *node;
+	int l3mdev_index = 0;
+
+	if (vxlan->cfg.remote_ifindex)
+		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
+			vxlan->net, vxlan->cfg.remote_ifindex);
+
+	if (!vxlan->cfg.no_share) {
+		spin_lock(&vn->sock_lock);
+		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
+				     vxlan->cfg.dst_port, vxlan->cfg.flags,
+				     l3mdev_index);
+		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
+			spin_unlock(&vn->sock_lock);
+			return -EBUSY;
+		}
+		spin_unlock(&vn->sock_lock);
+	}
+	if (!vs)
+		vs = vxlan_socket_create(vxlan->net, ipv6,
+					 vxlan->cfg.dst_port, vxlan->cfg.flags,
+					 l3mdev_index);
+	if (IS_ERR(vs))
+		return PTR_ERR(vs);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ipv6) {
+		rcu_assign_pointer(vxlan->vn6_sock, vs);
+		node = &vxlan->hlist6;
+	} else
+#endif
+	{
+		rcu_assign_pointer(vxlan->vn4_sock, vs);
+		node = &vxlan->hlist4;
+	}
+	vxlan_vs_add_dev(vs, vxlan, node);
+	return 0;
+}
+
+static int vxlan_sock_add(struct vxlan_dev *vxlan)
+{
+	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
+	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
+	bool ipv4 = !ipv6 || metadata;
+	int ret = 0;
+
+	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
+#if IS_ENABLED(CONFIG_IPV6)
+	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
+	if (ipv6) {
+		ret = __vxlan_sock_add(vxlan, true);
+		if (ret < 0 && ret != -EAFNOSUPPORT)
+			ipv4 = false;
+	}
+#endif
+	if (ipv4)
+		ret = __vxlan_sock_add(vxlan, false);
+	if (ret < 0)
+		vxlan_sock_release(vxlan);
+	return ret;
+}
+
+static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
+				 struct net_device **lower,
+				 struct vxlan_dev *old,
+				 struct netlink_ext_ack *extack)
+{
+	struct vxlan_net *vn = net_generic(src_net, vxlan_net_id);
+	struct vxlan_dev *tmp;
+	bool use_ipv6 = false;
+
+	if (conf->flags & VXLAN_F_GPE) {
+		/* For now, allow GPE only together with
+		 * COLLECT_METADATA. This can be relaxed later; in such
+		 * case, the other side of the PtP link will have to be
+		 * provided.
+		 */
+		if ((conf->flags & ~VXLAN_F_ALLOWED_GPE) ||
+		    !(conf->flags & VXLAN_F_COLLECT_METADATA)) {
+			NL_SET_ERR_MSG(extack,
+				       "VXLAN GPE does not support this combination of attributes");
+			return -EINVAL;
+		}
+	}
+
+	if (!conf->remote_ip.sa.sa_family && !conf->saddr.sa.sa_family) {
+		/* Unless IPv6 is explicitly requested, assume IPv4 */
+		conf->remote_ip.sa.sa_family = AF_INET;
+		conf->saddr.sa.sa_family = AF_INET;
+	} else if (!conf->remote_ip.sa.sa_family) {
+		conf->remote_ip.sa.sa_family = conf->saddr.sa.sa_family;
+	} else if (!conf->saddr.sa.sa_family) {
+		conf->saddr.sa.sa_family = conf->remote_ip.sa.sa_family;
+	}
+
+	if (conf->saddr.sa.sa_family != conf->remote_ip.sa.sa_family) {
+		NL_SET_ERR_MSG(extack,
+			       "Local and remote address must be from the same family");
+		return -EINVAL;
+	}
+
+	if (vxlan_addr_multicast(&conf->saddr)) {
+		NL_SET_ERR_MSG(extack, "Local address cannot be multicast");
+		return -EINVAL;
+	}
+
+	if (conf->saddr.sa.sa_family == AF_INET6) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG(extack,
+				       "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+		use_ipv6 = true;
+		conf->flags |= VXLAN_F_IPV6;
+
+		if (!(conf->flags & VXLAN_F_COLLECT_METADATA)) {
+			int local_type =
+				ipv6_addr_type(&conf->saddr.sin6.sin6_addr);
+			int remote_type =
+				ipv6_addr_type(&conf->remote_ip.sin6.sin6_addr);
+
+			if (local_type & IPV6_ADDR_LINKLOCAL) {
+				if (!(remote_type & IPV6_ADDR_LINKLOCAL) &&
+				    (remote_type != IPV6_ADDR_ANY)) {
+					NL_SET_ERR_MSG(extack,
+						       "Invalid combination of local and remote address scopes");
+					return -EINVAL;
+				}
+
+				conf->flags |= VXLAN_F_IPV6_LINKLOCAL;
+			} else {
+				if (remote_type ==
+				    (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL)) {
+					NL_SET_ERR_MSG(extack,
+						       "Invalid combination of local and remote address scopes");
+					return -EINVAL;
+				}
+
+				conf->flags &= ~VXLAN_F_IPV6_LINKLOCAL;
+			}
+		}
+	}
+
+	if (conf->label && !use_ipv6) {
+		NL_SET_ERR_MSG(extack,
+			       "Label attribute only applies to IPv6 VXLAN devices");
+		return -EINVAL;
+	}
+
+	if (conf->remote_ifindex) {
+		struct net_device *lowerdev;
+
+		lowerdev = __dev_get_by_index(src_net, conf->remote_ifindex);
+		if (!lowerdev) {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid local interface, device not found");
+			return -ENODEV;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (use_ipv6) {
+			struct inet6_dev *idev = __in6_dev_get(lowerdev);
+
+			if (idev && idev->cnf.disable_ipv6) {
+				NL_SET_ERR_MSG(extack,
+					       "IPv6 support disabled by administrator");
+				return -EPERM;
+			}
+		}
+#endif
+
+		*lower = lowerdev;
+	} else {
+		if (vxlan_addr_multicast(&conf->remote_ip)) {
+			NL_SET_ERR_MSG(extack,
+				       "Local interface required for multicast remote destination");
+
+			return -EINVAL;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (conf->flags & VXLAN_F_IPV6_LINKLOCAL) {
+			NL_SET_ERR_MSG(extack,
+				       "Local interface required for link-local local/remote addresses");
+			return -EINVAL;
+		}
+#endif
+
+		*lower = NULL;
+	}
+
+	if (!conf->dst_port) {
+		if (conf->flags & VXLAN_F_GPE)
+			conf->dst_port = htons(4790); /* IANA VXLAN-GPE port */
+		else
+			conf->dst_port = htons(vxlan_port);
+	}
+
+	if (!conf->age_interval)
+		conf->age_interval = FDB_AGE_DEFAULT;
+
+	list_for_each_entry(tmp, &vn->vxlan_list, next) {
+		if (tmp == old)
+			continue;
+
+		if (tmp->cfg.vni != conf->vni)
+			continue;
+		if (tmp->cfg.dst_port != conf->dst_port)
+			continue;
+		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
+		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
+			continue;
+
+		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
+		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
+			continue;
+
+		NL_SET_ERR_MSG(extack,
+			       "A VXLAN device with the specified VNI already exists");
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+static void vxlan_config_apply(struct net_device *dev,
+			       struct vxlan_config *conf,
+			       struct net_device *lowerdev,
+			       struct net *src_net,
+			       bool changelink)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *dst = &vxlan->default_dst;
+	unsigned short needed_headroom = ETH_HLEN;
+	int max_mtu = ETH_MAX_MTU;
+	u32 flags = conf->flags;
+
+	if (!changelink) {
+		if (flags & VXLAN_F_GPE)
+			vxlan_raw_setup(dev);
+		else
+			vxlan_ether_setup(dev);
+
+		if (conf->mtu)
+			dev->mtu = conf->mtu;
+
+		vxlan->net = src_net;
+	}
+
+	dst->remote_vni = conf->vni;
+
+	memcpy(&dst->remote_ip, &conf->remote_ip, sizeof(conf->remote_ip));
+
+	if (lowerdev) {
+		dst->remote_ifindex = conf->remote_ifindex;
+
+		dev->gso_max_size = lowerdev->gso_max_size;
+		dev->gso_max_segs = lowerdev->gso_max_segs;
+
+		needed_headroom = lowerdev->hard_header_len;
+		needed_headroom += lowerdev->needed_headroom;
+
+		dev->needed_tailroom = lowerdev->needed_tailroom;
+
+		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
+		if (max_mtu < ETH_MIN_MTU)
+			max_mtu = ETH_MIN_MTU;
+
+		if (!changelink && !conf->mtu)
+			dev->mtu = max_mtu;
+	}
+
+	if (dev->mtu > max_mtu)
+		dev->mtu = max_mtu;
+
+	if (flags & VXLAN_F_COLLECT_METADATA)
+		flags |= VXLAN_F_IPV6;
+	needed_headroom += vxlan_headroom(flags);
+	dev->needed_headroom = needed_headroom;
+
+	memcpy(&vxlan->cfg, conf, sizeof(*conf));
+}
+
+static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
+			       struct vxlan_config *conf, bool changelink,
+			       struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+	int ret;
+
+	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
+	if (ret)
+		return ret;
+
+	vxlan_config_apply(dev, conf, lowerdev, src_net, changelink);
+
+	return 0;
+}
+
+static int __vxlan_dev_create(struct net *net, struct net_device *dev,
+			      struct vxlan_config *conf,
+			      struct netlink_ext_ack *extack)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct net_device *remote_dev = NULL;
+	struct vxlan_fdb *f = NULL;
+	bool unregister = false;
+	struct vxlan_rdst *dst;
+	int err;
+
+	dst = &vxlan->default_dst;
+	err = vxlan_dev_configure(net, dev, conf, false, extack);
+	if (err)
+		return err;
+
+	dev->ethtool_ops = &vxlan_ethtool_ops;
+
+	/* create an fdb entry for a valid default destination */
+	if (!vxlan_addr_any(&dst->remote_ip)) {
+		err = vxlan_fdb_create(vxlan, all_zeros_mac,
+				       &dst->remote_ip,
+				       NUD_REACHABLE | NUD_PERMANENT,
+				       vxlan->cfg.dst_port,
+				       dst->remote_vni,
+				       dst->remote_vni,
+				       dst->remote_ifindex,
+				       NTF_SELF, 0, &f, extack);
+		if (err)
+			return err;
+	}
+
+	err = register_netdevice(dev);
+	if (err)
+		goto errout;
+	unregister = true;
+
+	if (dst->remote_ifindex) {
+		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
+		if (!remote_dev) {
+			err = -ENODEV;
+			goto errout;
+		}
+
+		err = netdev_upper_dev_link(remote_dev, dev, extack);
+		if (err)
+			goto errout;
+	}
+
+	err = rtnl_configure_link(dev, NULL);
+	if (err < 0)
+		goto unlink;
+
+	if (f) {
+		vxlan_fdb_insert(vxlan, all_zeros_mac, dst->remote_vni, f);
+
+		/* notify default fdb entry */
+		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
+				       RTM_NEWNEIGH, true, extack);
+		if (err) {
+			vxlan_fdb_destroy(vxlan, f, false, false);
+			if (remote_dev)
+				netdev_upper_dev_unlink(remote_dev, dev);
+			goto unregister;
+		}
+	}
+
+	list_add(&vxlan->next, &vn->vxlan_list);
+	if (remote_dev)
+		dst->remote_dev = remote_dev;
+	return 0;
+unlink:
+	if (remote_dev)
+		netdev_upper_dev_unlink(remote_dev, dev);
+errout:
+	/* unregister_netdevice() destroys the default FDB entry with deletion
+	 * notification. But the addition notification was not sent yet, so
+	 * destroy the entry by hand here.
+	 */
+	if (f)
+		__vxlan_fdb_free(f);
+unregister:
+	if (unregister)
+		unregister_netdevice(dev);
+	return err;
+}
+
+/* Set/clear flags based on attribute */
+static int vxlan_nl2flag(struct vxlan_config *conf, struct nlattr *tb[],
+			  int attrtype, unsigned long mask, bool changelink,
+			  bool changelink_supported,
+			  struct netlink_ext_ack *extack)
+{
+	unsigned long flags;
+
+	if (!tb[attrtype])
+		return 0;
+
+	if (changelink && !changelink_supported) {
+		vxlan_flag_attr_error(attrtype, extack);
+		return -EOPNOTSUPP;
+	}
+
+	if (vxlan_policy[attrtype].type == NLA_FLAG)
+		flags = conf->flags | mask;
+	else if (nla_get_u8(tb[attrtype]))
+		flags = conf->flags | mask;
+	else
+		flags = conf->flags & ~mask;
+
+	conf->flags = flags;
+
+	return 0;
+}
+
+static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
+			 struct net_device *dev, struct vxlan_config *conf,
+			 bool changelink, struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	int err = 0;
+
+	memset(conf, 0, sizeof(*conf));
+
+	/* if changelink operation, start with old existing cfg */
+	if (changelink)
+		memcpy(conf, &vxlan->cfg, sizeof(*conf));
+
+	if (data[IFLA_VXLAN_ID]) {
+		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
+
+		if (changelink && (vni != conf->vni)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
+			return -EOPNOTSUPP;
+		}
+		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
+	}
+
+	if (data[IFLA_VXLAN_GROUP]) {
+		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
+			return -EOPNOTSUPP;
+		}
+
+		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
+		conf->remote_ip.sa.sa_family = AF_INET;
+	} else if (data[IFLA_VXLAN_GROUP6]) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+
+		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "New group address family does not match old group");
+			return -EOPNOTSUPP;
+		}
+
+		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
+		conf->remote_ip.sa.sa_family = AF_INET6;
+	}
+
+	if (data[IFLA_VXLAN_LOCAL]) {
+		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
+		conf->saddr.sa.sa_family = AF_INET;
+	} else if (data[IFLA_VXLAN_LOCAL6]) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+
+		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		/* TODO: respect scope id */
+		conf->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_LOCAL6]);
+		conf->saddr.sa.sa_family = AF_INET6;
+	}
+
+	if (data[IFLA_VXLAN_LINK])
+		conf->remote_ifindex = nla_get_u32(data[IFLA_VXLAN_LINK]);
+
+	if (data[IFLA_VXLAN_TOS])
+		conf->tos  = nla_get_u8(data[IFLA_VXLAN_TOS]);
+
+	if (data[IFLA_VXLAN_TTL])
+		conf->ttl = nla_get_u8(data[IFLA_VXLAN_TTL]);
+
+	if (data[IFLA_VXLAN_TTL_INHERIT]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_TTL_INHERIT,
+				    VXLAN_F_TTL_INHERIT, changelink, false,
+				    extack);
+		if (err)
+			return err;
+
+	}
+
+	if (data[IFLA_VXLAN_LABEL])
+		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
+			     IPV6_FLOWLABEL_MASK;
+
+	if (data[IFLA_VXLAN_LEARNING]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
+				    VXLAN_F_LEARN, changelink, true,
+				    extack);
+		if (err)
+			return err;
+	} else if (!changelink) {
+		/* default to learn on a new device */
+		conf->flags |= VXLAN_F_LEARN;
+	}
+
+	if (data[IFLA_VXLAN_AGEING])
+		conf->age_interval = nla_get_u32(data[IFLA_VXLAN_AGEING]);
+
+	if (data[IFLA_VXLAN_PROXY]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_PROXY,
+				    VXLAN_F_PROXY, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_RSC]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_RSC,
+				    VXLAN_F_RSC, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_L2MISS]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L2MISS,
+				    VXLAN_F_L2MISS, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_L3MISS]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_L3MISS,
+				    VXLAN_F_L3MISS, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_LIMIT]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LIMIT],
+					    "Cannot change limit");
+			return -EOPNOTSUPP;
+		}
+		conf->addrmax = nla_get_u32(data[IFLA_VXLAN_LIMIT]);
+	}
+
+	if (data[IFLA_VXLAN_COLLECT_METADATA]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_COLLECT_METADATA,
+				    VXLAN_F_COLLECT_METADATA, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_PORT_RANGE]) {
+		if (!changelink) {
+			const struct ifla_vxlan_port_range *p
+				= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
+			conf->port_min = ntohs(p->low);
+			conf->port_max = ntohs(p->high);
+		} else {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT_RANGE],
+					    "Cannot change port range");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (data[IFLA_VXLAN_PORT]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT],
+					    "Cannot change port");
+			return -EOPNOTSUPP;
+		}
+		conf->dst_port = nla_get_be16(data[IFLA_VXLAN_PORT]);
+	}
+
+	if (data[IFLA_VXLAN_UDP_CSUM]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_UDP_CSUM],
+					    "Cannot change UDP_CSUM flag");
+			return -EOPNOTSUPP;
+		}
+		if (!nla_get_u8(data[IFLA_VXLAN_UDP_CSUM]))
+			conf->flags |= VXLAN_F_UDP_ZERO_CSUM_TX;
+	}
+
+	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_TX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
+				    VXLAN_F_UDP_ZERO_CSUM6_TX, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_UDP_ZERO_CSUM6_RX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
+				    VXLAN_F_UDP_ZERO_CSUM6_RX, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_REMCSUM_TX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_TX,
+				    VXLAN_F_REMCSUM_TX, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_REMCSUM_RX]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_RX,
+				    VXLAN_F_REMCSUM_RX, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_GBP]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GBP,
+				    VXLAN_F_GBP, changelink, false, extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_GPE]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_GPE,
+				    VXLAN_F_GPE, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
+				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
+	if (tb[IFLA_MTU]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
+					    "Cannot change mtu");
+			return -EOPNOTSUPP;
+		}
+		conf->mtu = nla_get_u32(tb[IFLA_MTU]);
+	}
+
+	if (data[IFLA_VXLAN_DF])
+		conf->df = nla_get_u8(data[IFLA_VXLAN_DF]);
+
+	return 0;
+}
+
+static int vxlan_newlink(struct net *src_net, struct net_device *dev,
+			 struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
+{
+	struct vxlan_config conf;
+	int err;
+
+	err = vxlan_nl2conf(tb, data, dev, &conf, false, extack);
+	if (err)
+		return err;
+
+	return __vxlan_dev_create(src_net, dev, &conf, extack);
+}
+
+static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
+			    struct nlattr *data[],
+			    struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+	struct vxlan_config conf;
+	struct vxlan_rdst *dst;
+	int err;
+
+	dst = &vxlan->default_dst;
+	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
+	if (err)
+		return err;
+
+	err = vxlan_config_validate(vxlan->net, &conf, &lowerdev,
+				    vxlan, extack);
+	if (err)
+		return err;
+
+	if (dst->remote_dev == lowerdev)
+		lowerdev = NULL;
+
+	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
+					     extack);
+	if (err)
+		return err;
+
+	/* handle default dst entry */
+	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
+		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
+
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		if (!vxlan_addr_any(&conf.remote_ip)) {
+			err = vxlan_fdb_update(vxlan, all_zeros_mac,
+					       &conf.remote_ip,
+					       NUD_REACHABLE | NUD_PERMANENT,
+					       NLM_F_APPEND | NLM_F_CREATE,
+					       vxlan->cfg.dst_port,
+					       conf.vni, conf.vni,
+					       conf.remote_ifindex,
+					       NTF_SELF, 0, true, extack);
+			if (err) {
+				spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+				netdev_adjacent_change_abort(dst->remote_dev,
+							     lowerdev, dev);
+				return err;
+			}
+		}
+		if (!vxlan_addr_any(&dst->remote_ip))
+			__vxlan_fdb_delete(vxlan, all_zeros_mac,
+					   dst->remote_ip,
+					   vxlan->cfg.dst_port,
+					   dst->remote_vni,
+					   dst->remote_vni,
+					   dst->remote_ifindex,
+					   true);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
+
+	if (conf.age_interval != vxlan->cfg.age_interval)
+		mod_timer(&vxlan->age_timer, jiffies);
+
+	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
+	if (lowerdev && lowerdev != dst->remote_dev)
+		dst->remote_dev = lowerdev;
+	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
+	return 0;
+}
+
+static void vxlan_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	vxlan_flush(vxlan, true);
+
+	list_del(&vxlan->next);
+	unregister_netdevice_queue(dev, head);
+	if (vxlan->default_dst.remote_dev)
+		netdev_upper_dev_unlink(vxlan->default_dst.remote_dev, dev);
+}
+
+static size_t vxlan_get_size(const struct net_device *dev)
+{
+
+	return nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_ID */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_GROUP{6} */
+		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LINK */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_LOCAL{6} */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL_INHERIT */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
+		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L2MISS */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_L3MISS */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_COLLECT_METADATA */
+		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_AGEING */
+		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LIMIT */
+		nla_total_size(sizeof(struct ifla_vxlan_port_range)) +
+		nla_total_size(sizeof(__be16)) + /* IFLA_VXLAN_PORT */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_CSUM */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_TX */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_RX */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
+		0;
+}
+
+static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	const struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_rdst *dst = &vxlan->default_dst;
+	struct ifla_vxlan_port_range ports = {
+		.low =  htons(vxlan->cfg.port_min),
+		.high = htons(vxlan->cfg.port_max),
+	};
+
+	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
+		goto nla_put_failure;
+
+	if (!vxlan_addr_any(&dst->remote_ip)) {
+		if (dst->remote_ip.sa.sa_family == AF_INET) {
+			if (nla_put_in_addr(skb, IFLA_VXLAN_GROUP,
+					    dst->remote_ip.sin.sin_addr.s_addr))
+				goto nla_put_failure;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			if (nla_put_in6_addr(skb, IFLA_VXLAN_GROUP6,
+					     &dst->remote_ip.sin6.sin6_addr))
+				goto nla_put_failure;
+#endif
+		}
+	}
+
+	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
+		goto nla_put_failure;
+
+	if (!vxlan_addr_any(&vxlan->cfg.saddr)) {
+		if (vxlan->cfg.saddr.sa.sa_family == AF_INET) {
+			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
+					    vxlan->cfg.saddr.sin.sin_addr.s_addr))
+				goto nla_put_failure;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
+					     &vxlan->cfg.saddr.sin6.sin6_addr))
+				goto nla_put_failure;
+#endif
+		}
+	}
+
+	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
+		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
+	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
+	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
+	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
+		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
+		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_RSC,
+		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
+		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
+		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
+		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
+	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
+	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
+	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
+	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
+		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
+		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
+		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
+		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
+		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)))
+		goto nla_put_failure;
+
+	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
+		goto nla_put_failure;
+
+	if (vxlan->cfg.flags & VXLAN_F_GBP &&
+	    nla_put_flag(skb, IFLA_VXLAN_GBP))
+		goto nla_put_failure;
+
+	if (vxlan->cfg.flags & VXLAN_F_GPE &&
+	    nla_put_flag(skb, IFLA_VXLAN_GPE))
+		goto nla_put_failure;
+
+	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_NOPARTIAL &&
+	    nla_put_flag(skb, IFLA_VXLAN_REMCSUM_NOPARTIAL))
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+static struct net *vxlan_get_link_net(const struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	return vxlan->net;
+}
+
+static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
+	.kind		= "vxlan",
+	.maxtype	= IFLA_VXLAN_MAX,
+	.policy		= vxlan_policy,
+	.priv_size	= sizeof(struct vxlan_dev),
+	.setup		= vxlan_setup,
+	.validate	= vxlan_validate,
+	.newlink	= vxlan_newlink,
+	.changelink	= vxlan_changelink,
+	.dellink	= vxlan_dellink,
+	.get_size	= vxlan_get_size,
+	.fill_info	= vxlan_fill_info,
+	.get_link_net	= vxlan_get_link_net,
+};
+
+struct net_device *vxlan_dev_create(struct net *net, const char *name,
+				    u8 name_assign_type,
+				    struct vxlan_config *conf)
+{
+	struct nlattr *tb[IFLA_MAX + 1];
+	struct net_device *dev;
+	int err;
+
+	memset(&tb, 0, sizeof(tb));
+
+	dev = rtnl_create_link(net, name, name_assign_type,
+			       &vxlan_link_ops, tb, NULL);
+	if (IS_ERR(dev))
+		return dev;
+
+	err = __vxlan_dev_create(net, dev, conf, NULL);
+	if (err < 0) {
+		free_netdev(dev);
+		return ERR_PTR(err);
+	}
+
+	err = rtnl_configure_link(dev, NULL);
+	if (err < 0) {
+		LIST_HEAD(list_kill);
+
+		vxlan_dellink(dev, &list_kill);
+		unregister_netdevice_many(&list_kill);
+		return ERR_PTR(err);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(vxlan_dev_create);
+
+static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
+					     struct net_device *dev)
+{
+	struct vxlan_dev *vxlan, *next;
+	LIST_HEAD(list_kill);
+
+	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
+		struct vxlan_rdst *dst = &vxlan->default_dst;
+
+		/* In case we created vxlan device with carrier
+		 * and we loose the carrier due to module unload
+		 * we also need to remove vxlan device. In other
+		 * cases, it's not necessary and remote_ifindex
+		 * is 0 here, so no matches.
+		 */
+		if (dst->remote_ifindex == dev->ifindex)
+			vxlan_dellink(vxlan->dev, &list_kill);
+	}
+
+	unregister_netdevice_many(&list_kill);
+}
+
+static int vxlan_netdevice_event(struct notifier_block *unused,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct vxlan_net *vn = net_generic(dev_net(dev), vxlan_net_id);
+
+	if (event == NETDEV_UNREGISTER)
+		vxlan_handle_lowerdev_unregister(vn, dev);
+	else if (event == NETDEV_UDP_TUNNEL_PUSH_INFO)
+		vxlan_offload_rx_ports(dev, true);
+	else if (event == NETDEV_UDP_TUNNEL_DROP_INFO)
+		vxlan_offload_rx_ports(dev, false);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vxlan_notifier_block __read_mostly = {
+	.notifier_call = vxlan_netdevice_event,
+};
+
+static void
+vxlan_fdb_offloaded_set(struct net_device *dev,
+			struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	u32 hash_index;
+
+	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
+
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+
+	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	if (!f)
+		goto out;
+
+	rdst = vxlan_fdb_find_rdst(f, &fdb_info->remote_ip,
+				   fdb_info->remote_port,
+				   fdb_info->remote_vni,
+				   fdb_info->remote_ifindex);
+	if (!rdst)
+		goto out;
+
+	rdst->offloaded = fdb_info->offloaded;
+
+out:
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+}
+
+static int
+vxlan_fdb_external_learn_add(struct net_device *dev,
+			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct netlink_ext_ack *extack;
+	u32 hash_index;
+	int err;
+
+	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	extack = switchdev_notifier_info_to_extack(&fdb_info->info);
+
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	err = vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
+			       NUD_REACHABLE,
+			       NLM_F_CREATE | NLM_F_REPLACE,
+			       fdb_info->remote_port,
+			       fdb_info->vni,
+			       fdb_info->remote_vni,
+			       fdb_info->remote_ifindex,
+			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
+			       0, false, extack);
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+static int
+vxlan_fdb_external_learn_del(struct net_device *dev,
+			     struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb *f;
+	u32 hash_index;
+	int err = 0;
+
+	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+
+	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	if (!f)
+		err = -ENOENT;
+	else if (f->flags & NTF_EXT_LEARNED)
+		err = __vxlan_fdb_delete(vxlan, fdb_info->eth_addr,
+					 fdb_info->remote_ip,
+					 fdb_info->remote_port,
+					 fdb_info->vni,
+					 fdb_info->remote_vni,
+					 fdb_info->remote_ifindex,
+					 false);
+
+	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+
+	return err;
+}
+
+static int vxlan_switchdev_event(struct notifier_block *unused,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_vxlan_fdb_info *fdb_info;
+	int err = 0;
+
+	switch (event) {
+	case SWITCHDEV_VXLAN_FDB_OFFLOADED:
+		vxlan_fdb_offloaded_set(dev, ptr);
+		break;
+	case SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE:
+		fdb_info = ptr;
+		err = vxlan_fdb_external_learn_add(dev, fdb_info);
+		if (err) {
+			err = notifier_from_errno(err);
+			break;
+		}
+		fdb_info->offloaded = true;
+		vxlan_fdb_offloaded_set(dev, fdb_info);
+		break;
+	case SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE:
+		fdb_info = ptr;
+		err = vxlan_fdb_external_learn_del(dev, fdb_info);
+		if (err) {
+			err = notifier_from_errno(err);
+			break;
+		}
+		fdb_info->offloaded = false;
+		vxlan_fdb_offloaded_set(dev, fdb_info);
+		break;
+	}
+
+	return err;
+}
+
+static struct notifier_block vxlan_switchdev_notifier_block __read_mostly = {
+	.notifier_call = vxlan_switchdev_event,
+};
+
+static void vxlan_fdb_nh_flush(struct nexthop *nh)
+{
+	struct vxlan_fdb *fdb;
+	struct vxlan_dev *vxlan;
+	u32 hash_index;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(fdb, &nh->fdb_list, nh_list) {
+		vxlan = rcu_dereference(fdb->vdev);
+		WARN_ON(!vxlan);
+		hash_index = fdb_head_index(vxlan, fdb->eth_addr,
+					    vxlan->default_dst.remote_vni);
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		if (!hlist_unhashed(&fdb->hlist))
+			vxlan_fdb_destroy(vxlan, fdb, false, false);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
+	rcu_read_unlock();
+}
+
+static int vxlan_nexthop_event(struct notifier_block *nb,
+			       unsigned long event, void *ptr)
+{
+	struct nh_notifier_info *info = ptr;
+	struct nexthop *nh;
+
+	if (event != NEXTHOP_EVENT_DEL)
+		return NOTIFY_DONE;
+
+	nh = nexthop_find_by_id(info->net, info->id);
+	if (!nh)
+		return NOTIFY_DONE;
+
+	vxlan_fdb_nh_flush(nh);
+
+	return NOTIFY_DONE;
+}
+
+static __net_init int vxlan_init_net(struct net *net)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	unsigned int h;
+
+	INIT_LIST_HEAD(&vn->vxlan_list);
+	spin_lock_init(&vn->sock_lock);
+	vn->nexthop_notifier_block.notifier_call = vxlan_nexthop_event;
+
+	for (h = 0; h < PORT_HASH_SIZE; ++h)
+		INIT_HLIST_HEAD(&vn->sock_list[h]);
+
+	return register_nexthop_notifier(net, &vn->nexthop_notifier_block,
+					 NULL);
+}
+
+static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_dev *vxlan, *next;
+	struct net_device *dev, *aux;
+
+	for_each_netdev_safe(net, dev, aux)
+		if (dev->rtnl_link_ops == &vxlan_link_ops)
+			unregister_netdevice_queue(dev, head);
+
+	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
+		/* If vxlan->dev is in the same netns, it has already been added
+		 * to the list by the previous loop.
+		 */
+		if (!net_eq(dev_net(vxlan->dev), net))
+			unregister_netdevice_queue(vxlan->dev, head);
+	}
+
+}
+
+static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+{
+	struct net *net;
+	LIST_HEAD(list);
+	unsigned int h;
+
+	list_for_each_entry(net, net_list, exit_list) {
+		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+
+		unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+	}
+	rtnl_lock();
+	list_for_each_entry(net, net_list, exit_list)
+		vxlan_destroy_tunnels(net, &list);
+
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
+
+	list_for_each_entry(net, net_list, exit_list) {
+		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+
+		for (h = 0; h < PORT_HASH_SIZE; ++h)
+			WARN_ON_ONCE(!hlist_empty(&vn->sock_list[h]));
+	}
+}
+
+static struct pernet_operations vxlan_net_ops = {
+	.init = vxlan_init_net,
+	.exit_batch = vxlan_exit_batch_net,
+	.id   = &vxlan_net_id,
+	.size = sizeof(struct vxlan_net),
+};
+
+static int __init vxlan_init_module(void)
+{
+	int rc;
+
+	get_random_bytes(&vxlan_salt, sizeof(vxlan_salt));
+
+	rc = register_pernet_subsys(&vxlan_net_ops);
+	if (rc)
+		goto out1;
+
+	rc = register_netdevice_notifier(&vxlan_notifier_block);
+	if (rc)
+		goto out2;
+
+	rc = register_switchdev_notifier(&vxlan_switchdev_notifier_block);
+	if (rc)
+		goto out3;
+
+	rc = rtnl_link_register(&vxlan_link_ops);
+	if (rc)
+		goto out4;
+
+	return 0;
+out4:
+	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
+out3:
+	unregister_netdevice_notifier(&vxlan_notifier_block);
+out2:
+	unregister_pernet_subsys(&vxlan_net_ops);
+out1:
+	return rc;
+}
+late_initcall(vxlan_init_module);
+
+static void __exit vxlan_cleanup_module(void)
+{
+	rtnl_link_unregister(&vxlan_link_ops);
+	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
+	unregister_netdevice_notifier(&vxlan_notifier_block);
+	unregister_pernet_subsys(&vxlan_net_ops);
+	/* rcu_barrier() is called by netns */
+}
+module_exit(vxlan_cleanup_module);
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION(VXLAN_VERSION);
+MODULE_AUTHOR("Stephen Hemminger <stephen@networkplumber.org>");
+MODULE_DESCRIPTION("Driver for VXLAN encapsulated traffic");
+MODULE_ALIAS_RTNL_LINK("vxlan");
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 827d91e73efa..0af0e965fb57 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -61,65 +61,32 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
 	rockchip_pcie_write(rockchip, 0,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
-	rockchip_pcie_write(rockchip, 0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(region));
-	rockchip_pcie_write(rockchip, 0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
 }
 
 static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
-					 u32 r, u32 type, u64 cpu_addr,
-					 u64 pci_addr, size_t size)
+					 u32 r, u64 cpu_addr, u64 pci_addr,
+					 size_t size)
 {
-	u64 sz = 1ULL << fls64(size - 1);
-	int num_pass_bits = ilog2(sz);
-	u32 addr0, addr1, desc0, desc1;
-	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
+	int num_pass_bits = fls64(size - 1);
+	u32 addr0, addr1, desc0;
 
-	/* The minimal region size is 1MB */
 	if (num_pass_bits < 8)
 		num_pass_bits = 8;
 
-	cpu_addr -= rockchip->mem_res->start;
-	addr0 = ((is_nor_msg ? 0x10 : (num_pass_bits - 1)) &
-		PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
-		(lower_32_bits(cpu_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
-	addr1 = upper_32_bits(is_nor_msg ? cpu_addr : pci_addr);
-	desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | type;
-	desc1 = 0;
-
-	if (is_nor_msg) {
-		rockchip_pcie_write(rockchip, 0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
-		rockchip_pcie_write(rockchip, 0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
-		rockchip_pcie_write(rockchip, desc0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
-		rockchip_pcie_write(rockchip, desc1,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
-	} else {
-		/* PCI bus address region */
-		rockchip_pcie_write(rockchip, addr0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
-		rockchip_pcie_write(rockchip, addr1,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
-		rockchip_pcie_write(rockchip, desc0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
-		rockchip_pcie_write(rockchip, desc1,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
-
-		addr0 =
-		    ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
-		    (lower_32_bits(cpu_addr) &
-		     PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
-		addr1 = upper_32_bits(cpu_addr);
-	}
+	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
+		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
+	addr1 = upper_32_bits(pci_addr);
+	desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | AXI_WRAPPER_MEM_WRITE;
 
-	/* CPU bus address region */
+	/* PCI bus address region */
 	rockchip_pcie_write(rockchip, addr0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r));
+			    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
 	rockchip_pcie_write(rockchip, addr1,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
+			    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
+	rockchip_pcie_write(rockchip, desc0,
+			    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
+	rockchip_pcie_write(rockchip, 0,
+			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
 }
 
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
@@ -258,26 +225,20 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar));
 }
 
+static inline u32 rockchip_ob_region(phys_addr_t addr)
+{
+	return (addr >> ilog2(SZ_1M)) & 0x1f;
+}
+
 static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				     phys_addr_t addr, u64 pci_addr,
 				     size_t size)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *pcie = &ep->rockchip;
-	u32 r;
-
-	r = find_first_zero_bit(&ep->ob_region_map, BITS_PER_LONG);
-	/*
-	 * Region 0 is reserved for configuration space and shouldn't
-	 * be used elsewhere per TRM, so leave it out.
-	 */
-	if (r >= ep->max_regions - 1) {
-		dev_err(&epc->dev, "no free outbound region\n");
-		return -EINVAL;
-	}
+	u32 r = rockchip_ob_region(addr);
 
-	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, AXI_WRAPPER_MEM_WRITE, addr,
-				     pci_addr, size);
+	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
 
 	set_bit(r, &ep->ob_region_map);
 	ep->ob_addr[r] = addr;
@@ -292,15 +253,11 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 r;
 
-	for (r = 0; r < ep->max_regions - 1; r++)
+	for (r = 0; r < ep->max_regions; r++)
 		if (ep->ob_addr[r] == addr)
 			break;
 
-	/*
-	 * Region 0 is reserved for configuration space and shouldn't
-	 * be used elsewhere per TRM, so leave it out.
-	 */
-	if (r == ep->max_regions - 1)
+	if (r == ep->max_regions)
 		return;
 
 	rockchip_pcie_clear_ep_ob_atu(rockchip, r);
@@ -397,7 +354,8 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 flags, mme, data, data_mask;
 	u8 msi_count;
-	u64 pci_addr, pci_addr_mask = 0xff;
+	u64 pci_addr;
+	u32 r;
 
 	/* Check MSI enable bit */
 	flags = rockchip_pcie_read(&ep->rockchip,
@@ -431,21 +389,20 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 				       ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
 				       ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
 				       PCI_MSI_ADDRESS_LO);
-	pci_addr &= GENMASK_ULL(63, 2);
 
 	/* Set the outbound region if needed. */
-	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
+	if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
 		     ep->irq_pci_fn != fn)) {
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, ep->max_regions - 1,
-					     AXI_WRAPPER_MEM_WRITE,
+		r = rockchip_ob_region(ep->irq_phys_addr);
+		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
 					     ep->irq_phys_addr,
-					     pci_addr & ~pci_addr_mask,
-					     pci_addr_mask + 1);
-		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
+					     pci_addr & PCIE_ADDR_MASK,
+					     ~PCIE_ADDR_MASK + 1);
+		ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
 		ep->irq_pci_fn = fn;
 	}
 
-	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
+	writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
 	return 0;
 }
 
@@ -527,6 +484,8 @@ static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
 	if (err < 0 || ep->max_regions > MAX_REGION_LIMIT)
 		ep->max_regions = MAX_REGION_LIMIT;
 
+	ep->ob_region_map = 0;
+
 	err = of_property_read_u8(dev->of_node, "max-functions",
 				  &ep->epc->max_functions);
 	if (err < 0)
@@ -547,7 +506,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct pci_epc *epc;
 	size_t max_regions;
-	int err;
+	struct pci_epc_mem_window *windows = NULL;
+	int err, i;
+	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -594,15 +555,27 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	err = pci_epc_mem_init(epc, rockchip->mem_res->start,
-			       resource_size(rockchip->mem_res), PAGE_SIZE);
+	windows = devm_kcalloc(dev, ep->max_regions,
+			       sizeof(struct pci_epc_mem_window), GFP_KERNEL);
+	if (!windows) {
+		err = -ENOMEM;
+		goto err_uninit_port;
+	}
+	for (i = 0; i < ep->max_regions; i++) {
+		windows[i].phys_base = rockchip->mem_res->start + (SZ_1M * i);
+		windows[i].size = SZ_1M;
+		windows[i].page_size = SZ_1M;
+	}
+	err = pci_epc_multi_mem_init(epc, windows, ep->max_regions);
+	devm_kfree(dev, windows);
+
 	if (err < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
 		goto err_uninit_port;
 	}
 
 	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
-						  SZ_128K);
+						  SZ_1M);
 	if (!ep->irq_cpu_addr) {
 		dev_err(dev, "failed to reserve memory space for MSI\n");
 		err = -ENOMEM;
@@ -611,6 +584,29 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	/*
+	 * MSI-X is not supported but the controller still advertises the MSI-X
+	 * capability by default, which can lead to the Root Complex side
+	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
+	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
+	 * the next pointer from the MSI-X entry and set that in the MSI
+	 * capability entry (which is the previous entry). This way the MSI-X
+	 * entry is skipped (left out of the linked-list) and not advertised.
+	 */
+	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
+	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
+
+	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
+
+	cfg_msi |= cfg_msix_cp;
+
+	rockchip_pcie_write(rockchip, cfg_msi,
+			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index cbd2fd25ba76..88e2bf65e433 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -139,6 +139,7 @@
 
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
+#define PCIE_EP_PF_CONFIG_REGS_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
@@ -158,10 +159,11 @@
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
+#define PCIE_ADDR_MASK			0xffffff00
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
-#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	0xffffff00
+#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
 #define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
 #define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
 #define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
@@ -169,7 +171,7 @@
 #define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
 #define PCIE_RP_IB_ADDR0		(PCIE_CORE_AXI_INBOUND_BASE + 0x0)
 #define   PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
-#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
+#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
 #define PCIE_RP_IB_ADDR1		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
 
 /* Size of one AXI Region (not Region 0) */
@@ -226,6 +228,8 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK			GENMASK(15, 8)
 #define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
@@ -233,14 +237,19 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
+#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG			0xb0
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK		GENMASK(15, 8)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
-#define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
+#define ROCKCHIP_PCIE_EP_FUNC_BASE(fn) \
+	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
+#define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
+	(PCIE_EP_PF_CONFIG_REGS_BASE + 0x10000 + (((fn) << 12) & GENMASK(19, 12)))
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
-	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
+	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
-	(PCIE_RC_RP_ATS_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
-#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
-	(PCIE_RC_RP_ATS_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
+	(PCIE_CORE_AXI_CONF_BASE + 0x082c + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
 	(((devfn) << 12) & \
@@ -248,20 +257,21 @@
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
 		(((bus) << 20) & ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
+#define PCIE_RC_EP_ATR_OB_REGIONS_1_32 (PCIE_CORE_AXI_CONF_BASE + 0x0020)
+#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0000 + ((r) & 0x1f) * 0x0020)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0004 + ((r) & 0x1f) * 0x0020)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
 		(((devfn) << 24) & ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
-#define ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r)	\
-		(PCIE_RC_RP_ATS_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
-#define ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
-#define ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0008 + ((r) & 0x1f) * 0x0020)
+#define ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r) \
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x000c + ((r) & 0x1f) * 0x0020)
+#define ROCKCHIP_PCIE_AT_OB_REGION_DESC2(r) \
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0010 + ((r) & 0x1f) * 0x0020)
 
 #define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG0(fn) \
 		(PCIE_CORE_CTRL_MGMT_BASE + 0x0240 + (fn) * 0x0008)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c58294f53fcd..3078de668f91 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -192,12 +192,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
-static bool pcie_retrain_link(struct pcie_link_state *link)
+static int pcie_wait_for_retrain(struct pci_dev *pdev)
 {
-	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
 
+	/* Wait for Link Training to be cleared by hardware */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			return 0;
+		msleep(1);
+	} while (time_before(jiffies, end_jiffies));
+
+	return -ETIMEDOUT;
+}
+
+static int pcie_retrain_link(struct pcie_link_state *link)
+{
+	struct pci_dev *parent = link->pdev;
+	int rc;
+	u16 reg16;
+
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training to
+	 * avoid LTSSM race as recommended in Implementation Note at the
+	 * end of PCIe r6.0.1 sec 7.5.3.7.
+	 */
+	rc = pcie_wait_for_retrain(parent);
+	if (rc)
+		return rc;
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
@@ -211,15 +238,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 	}
 
-	/* Wait for link training end. Break out after waiting for timeout */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		msleep(1);
-	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return pcie_wait_for_retrain(parent);
 }
 
 /*
@@ -288,15 +307,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	if (pcie_retrain_link(link))
-		return;
+	if (pcie_retrain_link(link)) {
 
-	/* Training failed. Restore common clock configurations */
-	pci_err(parent, "ASPM: Could not configure common clock\n");
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+		/* Training failed. Restore common clock configurations */
+		pci_err(parent, "ASPM: Could not configure common clock\n");
+		list_for_each_entry(child, &linkbus->devices, bus_list)
+			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+	}
 }
 
 /* Convert L0s latency encoding to ns */
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 34a6a9a1ceb2..897c6bb4cbb8 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -153,7 +153,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, &priv->ports[i]);
 		i++;
 
-		if (i > INNO_PHY_PORT_NUM) {
+		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
 			break;
 		}
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 7e61202aa234..abb926456933 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -68,23 +68,27 @@ static const char * const qcom_snps_hsphy_vreg_names[] = {
 /**
  * struct qcom_snps_hsphy - snps hs phy attributes
  *
+ * @dev: device structure
+ *
  * @phy: generic phy
  * @base: iomapped memory space for snps hs phy
  *
- * @cfg_ahb_clk: AHB2PHY interface clock
- * @ref_clk: phy reference clock
- * @iface_clk: phy interface clock
+ * @num_clks: number of clocks
+ * @clks: array of clocks
  * @phy_reset: phy reset control
  * @vregs: regulator supplies bulk data
  * @phy_initialized: if PHY has been initialized correctly
  * @mode: contains the current mode the PHY is in
+ * @update_seq_cfg: tuning parameters for phy init
  */
 struct qcom_snps_hsphy {
+	struct device *dev;
+
 	struct phy *phy;
 	void __iomem *base;
 
-	struct clk *cfg_ahb_clk;
-	struct clk *ref_clk;
+	int num_clks;
+	struct clk_bulk_data *clks;
 	struct reset_control *phy_reset;
 	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
 
@@ -92,6 +96,34 @@ struct qcom_snps_hsphy {
 	enum phy_mode mode;
 };
 
+static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
+{
+	struct device *dev = hsphy->dev;
+
+	hsphy->num_clks = 2;
+	hsphy->clks = devm_kcalloc(dev, hsphy->num_clks, sizeof(*hsphy->clks), GFP_KERNEL);
+	if (!hsphy->clks)
+		return -ENOMEM;
+
+	/*
+	 * TODO: Currently no device tree instantiation of the PHY is using the clock.
+	 * This needs to be fixed in order for this code to be able to use devm_clk_bulk_get().
+	 */
+	hsphy->clks[0].id = "cfg_ahb";
+	hsphy->clks[0].clk = devm_clk_get_optional(dev, "cfg_ahb");
+	if (IS_ERR(hsphy->clks[0].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[0].clk),
+				     "failed to get cfg_ahb clk\n");
+
+	hsphy->clks[1].id = "ref";
+	hsphy->clks[1].clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(hsphy->clks[1].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[1].clk),
+				     "failed to get ref clk\n");
+
+	return 0;
+}
+
 static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
 						u32 mask, u32 val)
 {
@@ -122,22 +154,13 @@ static int qcom_snps_hsphy_suspend(struct qcom_snps_hsphy *hsphy)
 					   0, USB2_AUTO_RESUME);
 	}
 
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
 	return 0;
 }
 
 static int qcom_snps_hsphy_resume(struct qcom_snps_hsphy *hsphy)
 {
-	int ret;
-
 	dev_dbg(&hsphy->phy->dev, "Resume QCOM SNPS PHY, mode\n");
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
-	if (ret) {
-		dev_err(&hsphy->phy->dev, "failed to enable cfg ahb clock\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -183,16 +206,16 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
+	ret = clk_bulk_prepare_enable(hsphy->num_clks, hsphy->clks);
 	if (ret) {
-		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		dev_err(&phy->dev, "failed to enable clocks, %d\n", ret);
 		goto poweroff_phy;
 	}
 
 	ret = reset_control_assert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	usleep_range(100, 150);
@@ -200,7 +223,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	ret = reset_control_deassert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to de-assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_CFG0,
@@ -246,8 +269,8 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 
 	return 0;
 
-disable_ahb_clk:
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+disable_clks:
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 poweroff_phy:
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 
@@ -259,7 +282,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
 	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
 
 	reset_control_assert(hsphy->phy_reset);
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 	hsphy->phy_initialized = false;
 
@@ -299,17 +322,15 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 	if (!hsphy)
 		return -ENOMEM;
 
+	hsphy->dev = dev;
+
 	hsphy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsphy->base))
 		return PTR_ERR(hsphy->base);
 
-	hsphy->ref_clk = devm_clk_get(dev, "ref");
-	if (IS_ERR(hsphy->ref_clk)) {
-		ret = PTR_ERR(hsphy->ref_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get ref clk, %d\n", ret);
-		return ret;
-	}
+	ret = qcom_snps_hsphy_clk_init(hsphy);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize clocks\n");
 
 	hsphy->phy_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(hsphy->phy_reset)) {
@@ -322,12 +343,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 		hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
 
 	ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulator supplies: %d\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get regulator supplies\n");
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 0e804b6c2d24..dfb4af759aa7 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -210,7 +210,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -841,15 +841,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
 static void msi_init_rfkill(struct work_struct *ignored)
 {
 	if (rfk_wlan) {
-		rfkill_set_sw_state(rfk_wlan, !wlan_s);
+		msi_rfkill_set_state(rfk_wlan, !wlan_s);
 		rfkill_wlan_set(NULL, !wlan_s);
 	}
 	if (rfk_bluetooth) {
-		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
+		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
 		rfkill_bluetooth_set(NULL, !bluetooth_s);
 	}
 	if (rfk_threeg) {
-		rfkill_set_sw_state(rfk_threeg, !threeg_s);
+		msi_rfkill_set_state(rfk_threeg, !threeg_s);
 		rfkill_threeg_set(NULL, !threeg_s);
 	}
 }
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 76f702c43cbc..ec6a544d6f52 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -147,12 +147,13 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	return pwm_set_chip_data(pwm, channel);
+	return 0;
 }
 
 static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 
 	if (channel)
 		clk_disable_unprepare(channel->clk);
@@ -161,9 +162,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -185,19 +187,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	pre_div = div64_u64(fin_freq * period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * period, NSEC_PER_SEC * (pre_div + 1));
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
+	dev_dbg(meson->chip.dev, "period=%llu pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
 	if (duty == period) {
@@ -210,14 +212,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
+		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
 
 		channel->pre_div = pre_div;
@@ -230,7 +231,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
 	u32 value;
@@ -273,8 +274,8 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	int err = 0;
 
 	if (!state)
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 7b76491f4fe9..7dad0428d73c 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -131,6 +131,7 @@ static int dasd_ioctl_resume(struct dasd_block *block)
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index de57d45ffc5c..4a5df867057b 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2705,6 +2705,9 @@ qla2x00_dev_loss_tmo_callbk(struct fc_rport *rport)
 	if (!fcport)
 		return;
 
+	ql_dbg(ql_dbg_async, fcport->vha, 0x5101,
+	       DBG_FCPORT_PRFMT(fcport, "dev_loss_tmo expiry, rport_state=%d",
+				rport->port_state));
 
 	/*
 	 * Now that the rport has been deleted, set the fcport state to
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index e674d3fb5926..83228ce822af 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -452,6 +452,15 @@ static inline be_id_t port_id_to_be_id(port_id_t port_id)
 	return res;
 }
 
+struct tmf_arg {
+	struct qla_qpair *qpair;
+	struct fc_port *fcport;
+	struct scsi_qla_host *vha;
+	u64 lun;
+	u32 flags;
+	uint8_t modifier;
+};
+
 struct els_logo_payload {
 	uint8_t opcode;
 	uint8_t rsvd[3];
@@ -531,6 +540,10 @@ struct srb_iocb {
 			uint32_t data;
 			struct completion comp;
 			__le16 comp_status;
+
+			uint8_t modifier;
+			uint8_t vp_index;
+			uint16_t loop_id;
 		} tmf;
 		struct {
 #define SRB_FXDISC_REQ_DMA_VALID	BIT_0
@@ -634,6 +647,7 @@ struct srb_iocb {
 #define SRB_SA_UPDATE	25
 #define SRB_ELS_CMD_HST_NOLOGIN 26
 #define SRB_SA_REPLACE	27
+#define SRB_MARKER	28
 
 struct qla_els_pt_arg {
 	u8 els_opcode;
@@ -2509,6 +2523,7 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
+	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2529,6 +2544,8 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
@@ -5458,4 +5475,14 @@ struct ql_vnd_tgt_stats_resp {
 #define IS_SESSION_DELETED(_fcport) (_fcport->disc_state == DSC_DELETE_PEND || \
 				      _fcport->disc_state == DSC_DELETED)
 
+#define DBG_FCPORT_PRFMT(_fp, _fmt, _args...) \
+	"%s: %8phC: " _fmt " (state=%d disc_state=%d scan_state=%d loopid=0x%x deleted=%d flags=0x%x)\n", \
+	__func__, _fp->port_name, ##_args, atomic_read(&_fp->state), \
+	_fp->disc_state, _fp->scan_state, _fp->loop_id, _fp->deleted, \
+	_fp->flags
+
+#define TMF_NOT_READY(_fcport) \
+	(!_fcport || IS_SESSION_DELETED(_fcport) || atomic_read(&_fcport->state) != FCS_ONLINE || \
+	!_fcport->vha->hw->flags.fw_started)
+
 #endif
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index f82e4a348330..9e467262c0f1 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -69,9 +69,7 @@ extern int qla2x00_async_logout(struct scsi_qla_host *, fc_port_t *);
 extern int qla2x00_async_prlo(struct scsi_qla_host *, fc_port_t *);
 extern int qla2x00_async_adisc(struct scsi_qla_host *, fc_port_t *,
     uint16_t *);
-extern int qla2x00_async_tm_cmd(fc_port_t *, uint32_t, uint32_t, uint32_t);
-extern void qla2x00_async_login_done(struct scsi_qla_host *, fc_port_t *,
-    uint16_t *);
+extern int qla2x00_async_tm_cmd(fc_port_t *, uint32_t, uint64_t, uint32_t);
 struct qla_work_evt *qla2x00_alloc_work(struct scsi_qla_host *,
     enum qla_work_type);
 extern int qla24xx_async_gnl(struct scsi_qla_host *, fc_port_t *);
@@ -278,7 +276,6 @@ extern int qla24xx_vport_create_req_sanity_check(struct fc_vport *);
 extern scsi_qla_host_t *qla24xx_create_vhost(struct fc_vport *);
 
 extern void qla2x00_sp_free_dma(srb_t *sp);
-extern char *qla2x00_get_fw_version_str(struct scsi_qla_host *, char *);
 
 extern void qla2x00_mark_device_lost(scsi_qla_host_t *, fc_port_t *, int);
 extern void qla2x00_mark_all_devices_lost(scsi_qla_host_t *);
@@ -611,7 +608,6 @@ void __qla_consume_iocb(struct scsi_qla_host *vha, void **pkt, struct rsp_que **
 /*
  * Global Function Prototypes in qla_sup.c source file.
  */
-extern void qla2x00_release_nvram_protection(scsi_qla_host_t *);
 extern int qla24xx_read_flash_data(scsi_qla_host_t *, uint32_t *,
     uint32_t, uint32_t);
 extern uint8_t *qla2x00_read_nvram_data(scsi_qla_host_t *, void *, uint32_t,
@@ -781,12 +777,6 @@ extern void qla2x00_init_response_q_entries(struct rsp_que *);
 extern int qla25xx_delete_req_que(struct scsi_qla_host *, struct req_que *);
 extern int qla25xx_delete_rsp_que(struct scsi_qla_host *, struct rsp_que *);
 extern int qla25xx_delete_queues(struct scsi_qla_host *);
-extern uint16_t qla24xx_rd_req_reg(struct qla_hw_data *, uint16_t);
-extern uint16_t qla25xx_rd_req_reg(struct qla_hw_data *, uint16_t);
-extern void qla24xx_wrt_req_reg(struct qla_hw_data *, uint16_t, uint16_t);
-extern void qla25xx_wrt_req_reg(struct qla_hw_data *, uint16_t, uint16_t);
-extern void qla25xx_wrt_rsp_reg(struct qla_hw_data *, uint16_t, uint16_t);
-extern void qla24xx_wrt_rsp_reg(struct qla_hw_data *, uint16_t, uint16_t);
 
 /* qlafx00 related functions */
 extern int qlafx00_pci_config(struct scsi_qla_host *);
@@ -871,8 +861,6 @@ extern void qla82xx_init_flags(struct qla_hw_data *);
 extern void qla82xx_set_drv_active(scsi_qla_host_t *);
 extern int qla82xx_wr_32(struct qla_hw_data *, ulong, u32);
 extern int qla82xx_rd_32(struct qla_hw_data *, ulong);
-extern int qla82xx_rdmem(struct qla_hw_data *, u64, void *, int);
-extern int qla82xx_wrmem(struct qla_hw_data *, u64, void *, int);
 
 /* ISP 8021 IDC */
 extern void qla82xx_clear_drv_active(struct qla_hw_data *);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 37cb469dc925..a97872b6350c 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1998,6 +1998,11 @@ qla2x00_tmf_iocb_timeout(void *data)
 	int rc, h;
 	unsigned long flags;
 
+	if (sp->type == SRB_MARKER) {
+		complete(&tmf->u.tmf.comp);
+		return;
+	}
+
 	rc = qla24xx_async_abort_cmd(sp, false);
 	if (rc) {
 		spin_lock_irqsave(sp->qpair->qp_lock_ptr, flags);
@@ -2015,24 +2020,131 @@ qla2x00_tmf_iocb_timeout(void *data)
 	}
 }
 
+static void qla_marker_sp_done(srb_t *sp, int res)
+{
+	struct srb_iocb *tmf = &sp->u.iocb_cmd;
+
+	if (res != QLA_SUCCESS)
+		ql_dbg(ql_dbg_taskm, sp->vha, 0x8004,
+		    "Async-marker fail hdl=%x portid=%06x ctrl=%x lun=%lld qp=%d.\n",
+		    sp->handle, sp->fcport->d_id.b24, sp->u.iocb_cmd.u.tmf.flags,
+		    sp->u.iocb_cmd.u.tmf.lun, sp->qpair->id);
+
+	sp->u.iocb_cmd.u.tmf.data = res;
+	complete(&tmf->u.tmf.comp);
+}
+
+#define  START_SP_W_RETRIES(_sp, _rval) \
+{\
+	int cnt = 5; \
+	do { \
+		_rval = qla2x00_start_sp(_sp); \
+		if (_rval == EAGAIN) \
+			msleep(1); \
+		else \
+			break; \
+		cnt--; \
+	} while (cnt); \
+}
+
+/**
+ * qla26xx_marker: send marker IOCB and wait for the completion of it.
+ * @arg: pointer to argument list.
+ *    It is assume caller will provide an fcport pointer and modifier
+ */
+static int
+qla26xx_marker(struct tmf_arg *arg)
+{
+	struct scsi_qla_host *vha = arg->vha;
+	struct srb_iocb *tm_iocb;
+	srb_t *sp;
+	int rval = QLA_FUNCTION_FAILED;
+	fc_port_t *fcport = arg->fcport;
+
+	if (TMF_NOT_READY(arg->fcport)) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8039,
+		    "FC port not ready for marker loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d.\n",
+		    fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, arg->qpair->id);
+		return QLA_SUSPENDED;
+	}
+
+	/* ref: INIT */
+	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
+	if (!sp)
+		goto done;
+
+	sp->type = SRB_MARKER;
+	sp->name = "marker";
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha), qla_marker_sp_done);
+	sp->u.iocb_cmd.timeout = qla2x00_tmf_iocb_timeout;
+
+	tm_iocb = &sp->u.iocb_cmd;
+	init_completion(&tm_iocb->u.tmf.comp);
+	tm_iocb->u.tmf.modifier = arg->modifier;
+	tm_iocb->u.tmf.lun = arg->lun;
+	tm_iocb->u.tmf.loop_id = fcport->loop_id;
+	tm_iocb->u.tmf.vp_index = vha->vp_idx;
+
+	START_SP_W_RETRIES(sp, rval);
+
+	ql_dbg(ql_dbg_taskm, vha, 0x8006,
+	    "Async-marker hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
+	    sp->handle, fcport->loop_id, fcport->d_id.b24,
+	    arg->modifier, arg->lun, sp->qpair->id, rval);
+
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x8031,
+		    "Marker IOCB send failure (%x).\n", rval);
+		goto done_free_sp;
+	}
+
+	wait_for_completion(&tm_iocb->u.tmf.comp);
+	rval = tm_iocb->u.tmf.data;
+
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x8019,
+		    "Marker failed hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
+		    sp->handle, fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, sp->qpair->id, rval);
+	}
+
+done_free_sp:
+	/* ref: INIT */
+	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+done:
+	return rval;
+}
+
 static void qla2x00_tmf_sp_done(srb_t *sp, int res)
 {
 	struct srb_iocb *tmf = &sp->u.iocb_cmd;
 
+	if (res)
+		tmf->u.tmf.data = res;
 	complete(&tmf->u.tmf.comp);
 }
 
-int
-qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
-	uint32_t tag)
+static int
+__qla2x00_async_tm_cmd(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct srb_iocb *tm_iocb;
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 
+	fc_port_t *fcport = arg->fcport;
+
+	if (TMF_NOT_READY(arg->fcport)) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8032,
+		    "FC port not ready for TM command loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d.\n",
+		    fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, arg->qpair->id);
+		return QLA_SUSPENDED;
+	}
+
 	/* ref: INIT */
-	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
+	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
 		goto done;
 
@@ -2045,15 +2157,16 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 
 	tm_iocb = &sp->u.iocb_cmd;
 	init_completion(&tm_iocb->u.tmf.comp);
-	tm_iocb->u.tmf.flags = flags;
-	tm_iocb->u.tmf.lun = lun;
+	tm_iocb->u.tmf.flags = arg->flags;
+	tm_iocb->u.tmf.lun = arg->lun;
+
+	START_SP_W_RETRIES(sp, rval);
 
 	ql_dbg(ql_dbg_taskm, vha, 0x802f,
-	    "Async-tmf hdl=%x loop-id=%x portid=%02x%02x%02x.\n",
-	    sp->handle, fcport->loop_id, fcport->d_id.b.domain,
-	    fcport->d_id.b.area, fcport->d_id.b.al_pa);
+	    "Async-tmf hdl=%x loop-id=%x portid=%06x ctrl=%x lun=%lld qp=%d rval=%x.\n",
+	    sp->handle, fcport->loop_id, fcport->d_id.b24,
+	    arg->flags, arg->lun, sp->qpair->id, rval);
 
-	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS)
 		goto done_free_sp;
 	wait_for_completion(&tm_iocb->u.tmf.comp);
@@ -2065,15 +2178,8 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 		    "TM IOCB failed (%x).\n", rval);
 	}
 
-	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw)) {
-		flags = tm_iocb->u.tmf.flags;
-		lun = (uint16_t)tm_iocb->u.tmf.lun;
-
-		/* Issue Marker IOCB */
-		qla2x00_marker(vha, vha->hw->base_qpair,
-		    fcport->loop_id, lun,
-		    flags == TCF_LUN_RESET ? MK_SYNC_ID_LUN : MK_SYNC_ID);
-	}
+	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw))
+		rval = qla26xx_marker(arg);
 
 done_free_sp:
 	/* ref: INIT */
@@ -2082,6 +2188,115 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 	return rval;
 }
 
+static void qla_put_tmf(fc_port_t *fcport)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	fcport->active_tmf--;
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+}
+
+static
+int qla_get_tmf(fc_port_t *fcport)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+	int rc = 0;
+	LIST_HEAD(tmf_elem);
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	list_add_tail(&tmf_elem, &fcport->tmf_pending);
+
+	while (fcport->active_tmf >= MAX_ACTIVE_TMF) {
+		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+		msleep(1);
+
+		spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+		if (TMF_NOT_READY(fcport)) {
+			ql_log(ql_log_warn, vha, 0x802c,
+			    "Unable to acquire TM resource due to disruption.\n");
+			rc = EIO;
+			break;
+		}
+		if (fcport->active_tmf < MAX_ACTIVE_TMF &&
+		    list_is_first(&tmf_elem, &fcport->tmf_pending))
+			break;
+	}
+
+	list_del(&tmf_elem);
+
+	if (!rc)
+		fcport->active_tmf++;
+
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+	return rc;
+}
+
+int
+qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
+		     uint32_t tag)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_qpair *qpair;
+	struct tmf_arg a;
+	int i, rval = QLA_SUCCESS;
+
+	if (TMF_NOT_READY(fcport))
+		return QLA_SUSPENDED;
+
+	a.vha = fcport->vha;
+	a.fcport = fcport;
+	a.lun = lun;
+	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
+		a.modifier = MK_SYNC_ID_LUN;
+
+		if (qla_get_tmf(fcport))
+			return QLA_FUNCTION_FAILED;
+	} else {
+		a.modifier = MK_SYNC_ID;
+	}
+
+	if (vha->hw->mqenable) {
+		for (i = 0; i < vha->hw->num_qpairs; i++) {
+			qpair = vha->hw->queue_pair_map[i];
+			if (!qpair)
+				continue;
+
+			if (TMF_NOT_READY(fcport)) {
+				ql_log(ql_log_warn, vha, 0x8026,
+				    "Unable to send TM due to disruption.\n");
+				rval = QLA_SUSPENDED;
+				break;
+			}
+
+			a.qpair = qpair;
+			a.flags = flags|TCF_NOTMCMD_TO_TARGET;
+			rval = __qla2x00_async_tm_cmd(&a);
+			if (rval)
+				break;
+		}
+	}
+
+	if (rval)
+		goto bailout;
+
+	a.qpair = vha->hw->base_qpair;
+	a.flags = flags;
+	rval = __qla2x00_async_tm_cmd(&a);
+
+bailout:
+	if (a.modifier == MK_SYNC_ID_LUN)
+		qla_put_tmf(fcport);
+
+	return rval;
+}
+
 int
 qla24xx_async_abort_command(srb_t *sp)
 {
@@ -5314,6 +5529,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
+	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 7a4298388ef1..c9a686f06d29 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -522,21 +522,25 @@ __qla2x00_marker(struct scsi_qla_host *vha, struct qla_qpair *qpair,
 		return (QLA_FUNCTION_FAILED);
 	}
 
+	mrk24 = (struct mrk_entry_24xx *)mrk;
+
 	mrk->entry_type = MARKER_TYPE;
 	mrk->modifier = type;
 	if (type != MK_SYNC_ALL) {
 		if (IS_FWI2_CAPABLE(ha)) {
-			mrk24 = (struct mrk_entry_24xx *) mrk;
 			mrk24->nport_handle = cpu_to_le16(loop_id);
 			int_to_scsilun(lun, (struct scsi_lun *)&mrk24->lun);
 			host_to_fcp_swap(mrk24->lun, sizeof(mrk24->lun));
 			mrk24->vp_index = vha->vp_idx;
-			mrk24->handle = make_handle(req->id, mrk24->handle);
 		} else {
 			SET_TARGET_ID(ha, mrk->target, loop_id);
 			mrk->lun = cpu_to_le16((uint16_t)lun);
 		}
 	}
+
+	if (IS_FWI2_CAPABLE(ha))
+		mrk24->handle = QLA_SKIP_HANDLE;
+
 	wmb();
 
 	qla2x00_start_iocbs(vha, req);
@@ -2542,7 +2546,7 @@ qla24xx_tm_iocb(srb_t *sp, struct tsk_mgmt_entry *tsk)
 	scsi_qla_host_t *vha = fcport->vha;
 	struct qla_hw_data *ha = vha->hw;
 	struct srb_iocb *iocb = &sp->u.iocb_cmd;
-	struct req_que *req = vha->req;
+	struct req_que *req = sp->qpair->req;
 
 	flags = iocb->u.tmf.flags;
 	lun = iocb->u.tmf.lun;
@@ -2558,7 +2562,8 @@ qla24xx_tm_iocb(srb_t *sp, struct tsk_mgmt_entry *tsk)
 	tsk->port_id[2] = fcport->d_id.b.domain;
 	tsk->vp_index = fcport->vha->vp_idx;
 
-	if (flags == TCF_LUN_RESET) {
+	if (flags & (TCF_LUN_RESET | TCF_ABORT_TASK_SET|
+	    TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
 		int_to_scsilun(lun, &tsk->lun);
 		host_to_fcp_swap((uint8_t *)&tsk->lun,
 			sizeof(tsk->lun));
@@ -3859,9 +3864,9 @@ int qla_get_iocbs_resource(struct srb *sp)
 	case SRB_NACK_LOGO:
 	case SRB_LOGOUT_CMD:
 	case SRB_CTRL_VP:
-		push_it_through = true;
-		fallthrough;
+	case SRB_MARKER:
 	default:
+		push_it_through = true;
 		get_exch = false;
 	}
 
@@ -3877,6 +3882,19 @@ int qla_get_iocbs_resource(struct srb *sp)
 	return qla_get_fw_resources(sp->qpair, &sp->iores);
 }
 
+static void
+qla_marker_iocb(srb_t *sp, struct mrk_entry_24xx *mrk)
+{
+	mrk->entry_type = MARKER_TYPE;
+	mrk->modifier = sp->u.iocb_cmd.u.tmf.modifier;
+	if (sp->u.iocb_cmd.u.tmf.modifier != MK_SYNC_ALL) {
+		mrk->nport_handle = cpu_to_le16(sp->u.iocb_cmd.u.tmf.loop_id);
+		int_to_scsilun(sp->u.iocb_cmd.u.tmf.lun, (struct scsi_lun *)&mrk->lun);
+		host_to_fcp_swap(mrk->lun, sizeof(mrk->lun));
+		mrk->vp_index = sp->u.iocb_cmd.u.tmf.vp_index;
+	}
+}
+
 int
 qla2x00_start_sp(srb_t *sp)
 {
@@ -3980,6 +3998,9 @@ qla2x00_start_sp(srb_t *sp)
 	case SRB_SA_REPLACE:
 		qla24xx_sa_replace_iocb(sp, pkt);
 		break;
+	case SRB_MARKER:
+		qla_marker_iocb(sp, pkt);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 665959938e5e..08d43f43995e 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3737,6 +3737,28 @@ static int qla_chk_cont_iocb_avail(struct scsi_qla_host *vha,
 	return rc;
 }
 
+static void qla_marker_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
+	struct mrk_entry_24xx *pkt)
+{
+	const char func[] = "MRK-IOCB";
+	srb_t *sp;
+	int res = QLA_SUCCESS;
+
+	if (!IS_FWI2_CAPABLE(vha->hw))
+		return;
+
+	sp = qla2x00_get_sp_from_handle(vha, func, req, pkt);
+	if (!sp)
+		return;
+
+	if (pkt->entry_status) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8025, "marker failure.\n");
+		res = QLA_COMMAND_ERROR;
+	}
+	sp->u.iocb_cmd.u.tmf.data = res;
+	sp->done(sp, res);
+}
+
 /**
  * qla24xx_process_response_queue() - Process response queue entries.
  * @vha: SCSI driver HA context
@@ -3858,9 +3880,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 					(struct nack_to_isp *)pkt);
 			break;
 		case MARKER_TYPE:
-			/* Do nothing in this case, this check is to prevent it
-			 * from falling into default case
-			 */
+			qla_marker_iocb_entry(vha, rsp->req, (struct mrk_entry_24xx *)pkt);
 			break;
 		case ABORT_IOCB_TYPE:
 			qla24xx_abort_iocb_entry(vha, rsp->req,
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 156b950ca7e7..aa8343444837 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -1080,8 +1080,6 @@ extern void qlt_81xx_config_nvram_stage2(struct scsi_qla_host *,
 	struct init_cb_81xx *);
 extern void qlt_81xx_config_nvram_stage1(struct scsi_qla_host *,
 	struct nvram_81xx *);
-extern int qlt_24xx_process_response_error(struct scsi_qla_host *,
-	struct sts_entry_24xx *);
 extern void qlt_modify_vp_config(struct scsi_qla_host *,
 	struct vp_config_entry_24xx *);
 extern void qlt_probe_one_stage1(struct scsi_qla_host *, struct qla_hw_data *);
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2045bcdfce1a..e3b52d5aa411 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -405,7 +405,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
-			ctrl->status[dev_num] = status;
+			ctrl->status[dev_num] = status & SWRM_MCP_SLV_STATUS_MASK;
 			return dev_num;
 		}
 	}
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 631ad769c3d5..8d8822c60a2b 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1584,8 +1584,10 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 			commit |= SME_WEP_FLAG;
 		}
 		if (enc->key_len) {
-			memcpy(&key->key_val[0], &enc->key[0], enc->key_len);
-			key->key_len = enc->key_len;
+			int key_len = clamp_val(enc->key_len, 0, IW_ENCODING_TOKEN_MAX);
+
+			memcpy(&key->key_val[0], &enc->key[0], key_len);
+			key->key_len = key_len;
 			commit |= (SME_WEP_VAL1 << index);
 		}
 		break;
diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index aeed5803dfb1..0031d76356c1 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -13,6 +13,7 @@ config VIDEO_ATOMISP
 	tristate "Intel Atom Image Signal Processor Driver"
 	depends on VIDEO_V4L2 && INTEL_ATOMISP
 	depends on PMIC_OPREGION
+	select V4L2_FWNODE
 	select IOSF_MBI
 	select VIDEOBUF_VMALLOC
 	select VIDEO_V4L2_SUBDEV_API
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345bad223..6353dbe554d3 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -21,6 +21,7 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
+#include <linux/usb.h>
 #include <linux/ieee80211.h>
 
 static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
@@ -55,6 +56,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	sint i;
 	struct xmit_buf *pxmitbuf;
 	struct xmit_frame *pxframe;
+	int j;
 
 	memset((unsigned char *)pxmitpriv, 0, sizeof(struct xmit_priv));
 	spin_lock_init(&pxmitpriv->lock);
@@ -117,11 +119,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto clean_up_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -129,13 +128,17 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		INIT_LIST_HEAD(&pxmitbuf->list);
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
-		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+		if (!pxmitbuf->pallocated_buf) {
+			j = 0;
+			goto clean_up_alloc_buf;
+		}
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
-		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
+			j = 1;
+			goto clean_up_alloc_buf;
+		}
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +149,28 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+clean_up_alloc_buf:
+	if (j) {
+		/* failure happened in r8712_xmit_resource_alloc()
+		 * delete extra pxmitbuf->pallocated_buf
+		 */
+		kfree(pxmitbuf->pallocated_buf);
+	}
+	for (j = 0; j < i; j++) {
+		int k;
+
+		pxmitbuf--;			/* reset pointer */
+		kfree(pxmitbuf->pallocated_buf);
+		for (k = 0; k < 8; k++)		/* delete xmit urb's */
+			usb_free_urb(pxmitbuf->pxmit_urb[k]);
+	}
+	kfree(pxmitpriv->pallocated_xmitbuf);
+	pxmitpriv->pallocated_xmitbuf = NULL;
+clean_up_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	pxmitpriv->pallocated_frame_buf = NULL;
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 90d34cf9d2ff..a820ce7cce71 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -118,6 +118,12 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
+			int k;
+
+			for (k = i - 1; k >= 0; k--) {
+				/* handle allocation errors part way through loop */
+				usb_free_urb(pxmitbuf->pxmit_urb[k]);
+			}
 			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
 			return -ENOMEM;
 		}
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 813a45887171..54173c23263c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2411,8 +2411,10 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 		gsm->has_devices = false;
 	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i])
+		if (gsm->dlci[i]) {
 			gsm_dlci_release(gsm->dlci[i]);
+			gsm->dlci[i] = NULL;
+		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 891036bd9f89..6259249b1167 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -202,8 +202,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 
 	/* Did the input worker stop? Restart it */
-	if (unlikely(ldata->no_room)) {
-		ldata->no_room = 0;
+	if (unlikely(READ_ONCE(ldata->no_room))) {
+		WRITE_ONCE(ldata->no_room, 0);
 
 		WARN_RATELIMIT(tty->port->itty == NULL,
 				"scheduling with invalid itty\n");
@@ -1661,7 +1661,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			if (overflow && room < 0)
 				ldata->read_head--;
 			room = overflow;
-			ldata->no_room = flow && !room;
+			WRITE_ONCE(ldata->no_room, flow && !room);
 		} else
 			overflow = 0;
 
@@ -1692,6 +1692,17 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	} else
 		n_tty_check_throttle(tty);
 
+	if (unlikely(ldata->no_room)) {
+		/*
+		 * Barrier here is to ensure to read the latest read_tail in
+		 * chars_in_buffer() and to make sure that read_tail is not loaded
+		 * before ldata->no_room is set.
+		 */
+		smp_mb();
+		if (!chars_in_buffer(tty))
+			n_tty_kick_worker(tty);
+	}
+
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
@@ -2100,7 +2111,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	ssize_t retval = 0;
 	long timeout;
 	bool packet;
-	size_t tail;
+	size_t old_tail;
 
 	/*
 	 * Is this a continuation of a read started earler?
@@ -2163,7 +2174,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	}
 
 	packet = tty->ctrl.packet;
-	tail = ldata->read_tail;
+	old_tail = ldata->read_tail;
 
 	add_wait_queue(&tty->read_wait, &wait);
 	while (nr) {
@@ -2252,8 +2263,14 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (tail != ldata->read_tail)
+	if (old_tail != ldata->read_tail) {
+		/*
+		 * Make sure no_room is not read in n_tty_kick_worker()
+		 * before setting ldata->read_tail in copy_from_read_buf().
+		 */
+		smp_mb();
 		n_tty_kick_worker(tty);
+	}
 	up_read(&tty->termios_rwsem);
 
 	remove_wait_queue(&tty->read_wait, &wait);
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 6d6a78eead3e..1cf229cca592 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -80,7 +80,7 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, old_dlf;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -93,9 +93,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
 	if (reg) {
 		struct dw8250_port_data *d = p->private_data;
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 5157ddffaf68..197397a98944 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1455,13 +1455,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
-	 * enabled/disabled from dev_pm_arm_wake_irq during system
-	 * suspend/resume respectively.
-	 */
-	pm_runtime_set_active(&pdev->dev);
-
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 4b0fa91e9f9a..69a32d94ec9d 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -843,7 +843,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static int __init sifive_serial_console_setup(struct console *co, char *options)
+static int sifive_serial_console_setup(struct console *co, char *options)
 {
 	struct sifive_serial_port *ssp;
 	int baud = SIFIVE_DEFAULT_BAUD_RATE;
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1dcadef933e3..69a44bd7e5d0 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3012,12 +3012,14 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
 	int total;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep->claimed && (ep->address & USB_DIR_IN))
+		priv_ep = ep_to_cdns3_ep(ep);
+		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
 			n_in++;
 	}
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 934b3d997702..15e9bd180a1d 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -436,6 +436,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* novation SoundControl XL */
 	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Focusrite Scarlett Solo USB */
+	{ USB_DEVICE(0x1235, 0x8211), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9dbea2148362..f2e841bc05c7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -275,9 +275,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -1093,22 +1093,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 84cdac33cb35..3dcb5b744f7c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -252,9 +252,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 4bcfcb98f5ec..1872de3ce98b 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -219,10 +219,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 
 			/*
 			 * A lot of BYT devices lack ACPI resource entries for
-			 * the GPIOs, add a fallback mapping to the reference
+			 * the GPIOs. If the ACPI entry for the GPIO controller
+			 * is present add a fallback mapping to the reference
 			 * design GPIOs which all boards seem to use.
 			 */
-			gpiod_add_lookup_table(&platform_bytcr_gpios);
+			if (acpi_dev_present("INT33FC", NULL, -1))
+				gpiod_add_lookup_table(&platform_bytcr_gpios);
 
 			/*
 			 * These GPIOs will turn on the USB2 PHY. Note that we have to
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 0886cff9aa1c..edce0a1bdddf 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1033,6 +1033,10 @@ int usb_add_config(struct usb_composite_dev *cdev,
 		goto done;
 
 	status = bind(config);
+
+	if (status == 0)
+		status = usb_gadget_check_config(cdev->gadget);
+
 	if (status < 0) {
 		while (!list_empty(&config->functions)) {
 			struct usb_function		*f;
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 2869bda64229..9d13f2274398 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
 	dev->eps_num = i;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	/* Matches kref_put() in gadget_unbind(). */
-	kref_get(&dev->count);
-
 	ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&gadget->dev, "failed to queue event\n");
+		set_gadget_data(gadget, NULL);
+		return ret;
+	}
 
+	/* Matches kref_put() in gadget_unbind(). */
+	kref_get(&dev->count);
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 1cb4258077bd..52996bf2cc70 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3689,15 +3689,15 @@ static int tegra_xudc_powerdomain_init(struct tegra_xudc *xudc)
 	int err;
 
 	xudc->genpd_dev_device = dev_pm_domain_attach_by_name(dev, "dev");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_device)) {
-		err = PTR_ERR(xudc->genpd_dev_device) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_device)) {
+		err = PTR_ERR(xudc->genpd_dev_device);
 		dev_err(dev, "failed to get device power domain: %d\n", err);
 		return err;
 	}
 
 	xudc->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "ss");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_ss)) {
-		err = PTR_ERR(xudc->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_ss)) {
+		err = PTR_ERR(xudc->genpd_dev_ss);
 		dev_err(dev, "failed to get SuperSpeed power domain: %d\n", err);
 		return err;
 	}
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index a24aea3d2759..e72f2e456f4a 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -652,7 +652,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index f8a63c143492..b55ddc1156cc 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -570,6 +570,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6c23b5156448..29a442b62118 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -294,10 +294,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
-		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
-	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 73f2ff83e1ad..15e44045230e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -592,11 +592,8 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	struct xhci_ring *ep_ring;
 	struct xhci_command *cmd;
 	struct xhci_segment *new_seg;
-	struct xhci_segment *halted_seg = NULL;
 	union xhci_trb *new_deq;
 	int new_cycle;
-	union xhci_trb *halted_trb;
-	int index = 0;
 	dma_addr_t addr;
 	u64 hw_dequeue;
 	bool cycle_found = false;
@@ -634,27 +631,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	hw_dequeue = xhci_get_hw_deq(xhci, dev, ep_index, stream_id);
 	new_seg = ep_ring->deq_seg;
 	new_deq = ep_ring->dequeue;
-
-	/*
-	 * Quirk: xHC write-back of the DCS field in the hardware dequeue
-	 * pointer is wrong - use the cycle state of the TRB pointed to by
-	 * the dequeue pointer.
-	 */
-	if (xhci->quirks & XHCI_EP_CTX_BROKEN_DCS &&
-	    !(ep->ep_state & EP_HAS_STREAMS))
-		halted_seg = trb_in_td(xhci, td->start_seg,
-				       td->first_trb, td->last_trb,
-				       hw_dequeue & ~0xf, false);
-	if (halted_seg) {
-		index = ((dma_addr_t)(hw_dequeue & ~0xf) - halted_seg->dma) /
-			 sizeof(*halted_trb);
-		halted_trb = &halted_seg->trbs[index];
-		new_cycle = halted_trb->generic.field[3] & 0x1;
-		xhci_dbg(xhci, "Endpoint DCS = %d TRB index = %d cycle = %d\n",
-			 (u8)(hw_dequeue & 0x1), index, new_cycle);
-	} else {
-		new_cycle = hw_dequeue & 0x1;
-	}
+	new_cycle = hw_dequeue & 0x1;
 
 	/*
 	 * We want to find the pointer, segment and cycle state of the new trb
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 32df571bb233..51eabc5e8770 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1010,15 +1010,15 @@ static int tegra_xusb_powerdomain_init(struct device *dev,
 	int err;
 
 	tegra->genpd_dev_host = dev_pm_domain_attach_by_name(dev, "xusb_host");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_host)) {
-		err = PTR_ERR(tegra->genpd_dev_host) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_host)) {
+		err = PTR_ERR(tegra->genpd_dev_host);
 		dev_err(dev, "failed to get host pm-domain: %d\n", err);
 		return err;
 	}
 
 	tegra->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "xusb_ss");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_ss)) {
-		err = PTR_ERR(tegra->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_ss)) {
+		err = PTR_ERR(tegra->genpd_dev_ss);
 		dev_err(dev, "failed to get superspeed pm-domain: %d\n", err);
 		return err;
 	}
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 6692440c1e0a..119641761c3b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -251,6 +251,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LTA		0x0123
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_EM060K_128		0x0128
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -268,6 +269,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
@@ -1197,6 +1199,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1225,6 +1230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 0x0900, 0xff, 0, 0), /* RM500U-CN */
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4c6747889a19..24b8772a345e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -38,16 +38,6 @@ static struct usb_serial_driver vendor##_device = {		\
 	{ USB_DEVICE(0x0a21, 0x8001) }	/* MMT-7305WW */
 DEVICE(carelink, CARELINK_IDS);
 
-/* ZIO Motherboard USB driver */
-#define ZIO_IDS()			\
-	{ USB_DEVICE(0x1CBE, 0x0103) }
-DEVICE(zio, ZIO_IDS);
-
-/* Funsoft Serial USB driver */
-#define FUNSOFT_IDS()			\
-	{ USB_DEVICE(0x1404, 0xcddc) }
-DEVICE(funsoft, FUNSOFT_IDS);
-
 /* Infineon Flashloader driver */
 #define FLASHLOADER_IDS()		\
 	{ USB_DEVICE_INTERFACE_CLASS(0x058b, 0x0041, USB_CLASS_CDC_DATA) }, \
@@ -55,6 +45,11 @@ DEVICE(funsoft, FUNSOFT_IDS);
 	{ USB_DEVICE(0x8087, 0x0801) }
 DEVICE(flashloader, FLASHLOADER_IDS);
 
+/* Funsoft Serial USB driver */
+#define FUNSOFT_IDS()			\
+	{ USB_DEVICE(0x1404, 0xcddc) }
+DEVICE(funsoft, FUNSOFT_IDS);
+
 /* Google Serial USB SubClass */
 #define GOOGLE_IDS()						\
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
@@ -63,16 +58,21 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* HP4x (48/49) Generic Serial driver */
+#define HP4X_IDS()			\
+	{ USB_DEVICE(0x03f0, 0x0121) }
+DEVICE(hp4x, HP4X_IDS);
+
+/* KAUFMANN RKS+CAN VCP */
+#define KAUFMANN_IDS()			\
+	{ USB_DEVICE(0x16d0, 0x0870) }
+DEVICE(kaufmann, KAUFMANN_IDS);
+
 /* Libtransistor USB console */
 #define LIBTRANSISTOR_IDS()			\
 	{ USB_DEVICE(0x1209, 0x8b00) }
 DEVICE(libtransistor, LIBTRANSISTOR_IDS);
 
-/* ViVOpay USB Serial Driver */
-#define VIVOPAY_IDS()			\
-	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
-DEVICE(vivopay, VIVOPAY_IDS);
-
 /* Motorola USB Phone driver */
 #define MOTO_IDS()			\
 	{ USB_DEVICE(0x05c6, 0x3197) },	/* unknown Motorola phone */	\
@@ -101,10 +101,10 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
-/* HP4x (48/49) Generic Serial driver */
-#define HP4X_IDS()			\
-	{ USB_DEVICE(0x03f0, 0x0121) }
-DEVICE(hp4x, HP4X_IDS);
+/* Siemens USB/MPI adapter */
+#define SIEMENS_IDS()			\
+	{ USB_DEVICE(0x908, 0x0004) }
+DEVICE(siemens_mpi, SIEMENS_IDS);
 
 /* Suunto ANT+ USB Driver */
 #define SUUNTO_IDS()			\
@@ -112,45 +112,52 @@ DEVICE(hp4x, HP4X_IDS);
 	{ USB_DEVICE(0x0fcf, 0x1009) } /* Dynastream ANT USB-m Stick */
 DEVICE(suunto, SUUNTO_IDS);
 
-/* Siemens USB/MPI adapter */
-#define SIEMENS_IDS()			\
-	{ USB_DEVICE(0x908, 0x0004) }
-DEVICE(siemens_mpi, SIEMENS_IDS);
+/* ViVOpay USB Serial Driver */
+#define VIVOPAY_IDS()			\
+	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
+DEVICE(vivopay, VIVOPAY_IDS);
+
+/* ZIO Motherboard USB driver */
+#define ZIO_IDS()			\
+	{ USB_DEVICE(0x1CBE, 0x0103) }
+DEVICE(zio, ZIO_IDS);
 
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
-	&zio_device,
-	&funsoft_device,
 	&flashloader_device,
+	&funsoft_device,
 	&google_device,
+	&hp4x_device,
+	&kaufmann_device,
 	&libtransistor_device,
-	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
-	&hp4x_device,
-	&suunto_device,
 	&siemens_mpi_device,
+	&suunto_device,
+	&vivopay_device,
+	&zio_device,
 	NULL
 };
 
 static const struct usb_device_id id_table[] = {
 	CARELINK_IDS(),
-	ZIO_IDS(),
-	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
+	FUNSOFT_IDS(),
 	GOOGLE_IDS(),
+	HP4X_IDS(),
+	KAUFMANN_IDS(),
 	LIBTRANSISTOR_IDS(),
-	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
-	HP4X_IDS(),
-	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	SUUNTO_IDS(),
+	VIVOPAY_IDS(),
+	ZIO_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d408d1dfde7c..d46a070275ff 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1201,12 +1201,23 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 
 	/*
-	 * We need to have subvol_sem write locked, to prevent races between
-	 * concurrent tasks trying to disable quotas, because we will unlock
-	 * and relock qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
+	 * We need to have subvol_sem write locked to prevent races with
+	 * snapshot creation.
 	 */
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
+	/*
+	 * Lock the cleaner mutex to prevent races with concurrent relocation,
+	 * because relocation may be building backrefs for blocks of the quota
+	 * root while we are deleting the root. This is like dropping fs roots
+	 * of deleted snapshots/subvolumes, we need the same protection.
+	 *
+	 * This also prevents races between concurrent tasks trying to disable
+	 * quotas, because we will unlock and relock qgroup_ioctl_lock across
+	 * BTRFS_FS_QUOTA_ENABLED changes.
+	 */
+	mutex_lock(&fs_info->cleaner_mutex);
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
 		goto out;
@@ -1287,6 +1298,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
+	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 642cd2b55fa0..daaed37bba9e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -840,8 +840,13 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
 				  BTRFS_RESERVE_NO_FLUSH, true);
-	if (trans == ERR_PTR(-ENOENT))
-		btrfs_wait_for_commit(root->fs_info, 0);
+	if (trans == ERR_PTR(-ENOENT)) {
+		int ret;
+
+		ret = btrfs_wait_for_commit(root->fs_info, 0);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return trans;
 }
@@ -936,6 +941,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 	}
 
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
+	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
 out:
 	return ret;
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 04d5df29bbbf..d21ff4354332 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -202,7 +202,7 @@ static void metric_delayed_work(struct work_struct *work)
 	struct ceph_mds_client *mdsc =
 		container_of(m, struct ceph_mds_client, metric);
 
-	if (mdsc->stopping)
+	if (mdsc->stopping || disable_send_metrics)
 		return;
 
 	if (!m->session || !check_session_state(m->session)) {
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index b0864da9ef43..020e71fe1454 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -258,61 +258,23 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 	goto compose_mount_options_out;
 }
 
-/**
- * cifs_dfs_do_mount - mounts specified path using DFS full path
- *
- * Always pass down @fullpath to smb3_do_mount() so we can use the root server
- * to perform failover in case we failed to connect to the first target in the
- * referral.
- *
- * @mntpt:		directory entry for the path we are trying to automount
- * @cifs_sb:		parent/root superblock
- * @fullpath:		full path in UNC format
- */
-static struct vfsmount *cifs_dfs_do_mount(struct dentry *mntpt,
-					  struct cifs_sb_info *cifs_sb,
-					  const char *fullpath)
-{
-	struct vfsmount *mnt;
-	char *mountdata;
-	char *devname;
-
-	devname = kstrdup(fullpath, GFP_KERNEL);
-	if (!devname)
-		return ERR_PTR(-ENOMEM);
-
-	convert_delimiter(devname, '/');
-
-	/* TODO: change to call fs_context_for_mount(), fill in context directly, call fc_mount */
-
-	/* See afs_mntpt_do_automount in fs/afs/mntpt.c for an example */
-
-	/* strip first '\' from fullpath */
-	mountdata = cifs_compose_mount_options(cifs_sb->ctx->mount_options,
-					       fullpath + 1, NULL, NULL);
-	if (IS_ERR(mountdata)) {
-		kfree(devname);
-		return (struct vfsmount *)mountdata;
-	}
-
-	mnt = vfs_submount(mntpt, &cifs_fs_type, devname, mountdata);
-	kfree(mountdata);
-	kfree(devname);
-	return mnt;
-}
-
 /*
  * Create a vfsmount that we can automount
  */
-static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
+static struct vfsmount *cifs_dfs_do_automount(struct path *path)
 {
+	int rc;
+	struct dentry *mntpt = path->dentry;
+	struct fs_context *fc;
 	struct cifs_sb_info *cifs_sb;
-	void *page;
+	void *page = NULL;
+	struct smb3_fs_context *ctx, *cur_ctx;
+	struct smb3_fs_context tmp;
 	char *full_path;
 	struct vfsmount *mnt;
 
-	cifs_dbg(FYI, "in %s\n", __func__);
-	BUG_ON(IS_ROOT(mntpt));
+	if (IS_ROOT(mntpt))
+		return ERR_PTR(-ESTALE);
 
 	/*
 	 * The MSDFS spec states that paths in DFS referral requests and
@@ -321,29 +283,47 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 	 * gives us the latter, so we must adjust the result.
 	 */
 	cifs_sb = CIFS_SB(mntpt->d_sb);
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS) {
-		mnt = ERR_PTR(-EREMOTE);
-		goto cdda_exit;
-	}
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS)
+		return ERR_PTR(-EREMOTE);
+
+	cur_ctx = cifs_sb->ctx;
+
+	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, mntpt);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ctx = smb3_fc2context(fc);
 
 	page = alloc_dentry_path();
 	/* always use tree name prefix */
 	full_path = build_path_from_dentry_optional_prefix(mntpt, page, true);
 	if (IS_ERR(full_path)) {
 		mnt = ERR_CAST(full_path);
-		goto free_full_path;
+		goto out;
 	}
 
-	convert_delimiter(full_path, '\\');
+	convert_delimiter(full_path, '/');
 	cifs_dbg(FYI, "%s: full_path: %s\n", __func__, full_path);
 
-	mnt = cifs_dfs_do_mount(mntpt, cifs_sb, full_path);
-	cifs_dbg(FYI, "%s: cifs_dfs_do_mount:%s , mnt:%p\n", __func__, full_path + 1, mnt);
+	tmp = *cur_ctx;
+	tmp.source = full_path;
+	tmp.UNC = tmp.prepath = NULL;
+
+	rc = smb3_fs_context_dup(ctx, &tmp);
+	if (rc) {
+		mnt = ERR_PTR(rc);
+		goto out;
+	}
+
+	rc = smb3_parse_devname(full_path, ctx);
+	if (!rc)
+		mnt = fc_mount(fc);
+	else
+		mnt = ERR_PTR(rc);
 
-free_full_path:
+out:
+	put_fs_context(fc);
 	free_dentry_path(page);
-cdda_exit:
-	cifs_dbg(FYI, "leaving %s\n" , __func__);
 	return mnt;
 }
 
@@ -354,9 +334,9 @@ struct vfsmount *cifs_dfs_d_automount(struct path *path)
 {
 	struct vfsmount *newmnt;
 
-	cifs_dbg(FYI, "in %s\n", __func__);
+	cifs_dbg(FYI, "%s: %pd\n", __func__, path->dentry);
 
-	newmnt = cifs_dfs_do_automount(path->dentry);
+	newmnt = cifs_dfs_do_automount(path);
 	if (IS_ERR(newmnt)) {
 		cifs_dbg(FYI, "leaving %s [automount failed]\n" , __func__);
 		return newmnt;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 4e4f73a90574..e65fbae9e804 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -880,8 +880,8 @@ int cifs_close(struct inode *inode, struct file *file)
 		cfile = file->private_data;
 		file->private_data = NULL;
 		dclose = kmalloc(sizeof(struct cifs_deferred_close), GFP_KERNEL);
-		if ((cinode->oplock == CIFS_CACHE_RHW_FLG) &&
-		    cinode->lease_granted &&
+		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
+		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index edce0b25cd90..f3482e936cc2 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -19,20 +19,20 @@ static struct list_head recv_list;
 static wait_queue_head_t send_wq;
 static wait_queue_head_t recv_wq;
 
-struct plock_op {
-	struct list_head list;
-	int done;
-	struct dlm_plock_info info;
-	int (*callback)(struct file_lock *fl, int result);
-};
-
-struct plock_xop {
-	struct plock_op xop;
+struct plock_async_data {
 	void *fl;
 	void *file;
 	struct file_lock flc;
+	int (*callback)(struct file_lock *fl, int result);
 };
 
+struct plock_op {
+	struct list_head list;
+	int done;
+	struct dlm_plock_info info;
+	/* if set indicates async handling */
+	struct plock_async_data *data;
+};
 
 static inline void set_version(struct dlm_plock_info *info)
 {
@@ -58,6 +58,12 @@ static int check_version(struct dlm_plock_info *info)
 	return 0;
 }
 
+static void dlm_release_plock_op(struct plock_op *op)
+{
+	kfree(op->data);
+	kfree(op);
+}
+
 static void send_op(struct plock_op *op)
 {
 	set_version(&op->info);
@@ -101,22 +107,21 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
 int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		   int cmd, struct file_lock *fl)
 {
+	struct plock_async_data *op_data;
 	struct dlm_ls *ls;
 	struct plock_op *op;
-	struct plock_xop *xop;
 	int rv;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
 		return -EINVAL;
 
-	xop = kzalloc(sizeof(*xop), GFP_NOFS);
-	if (!xop) {
+	op = kzalloc(sizeof(*op), GFP_NOFS);
+	if (!op) {
 		rv = -ENOMEM;
 		goto out;
 	}
 
-	op = &xop->xop;
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
 	op->info.pid		= fl->fl_pid;
 	op->info.ex		= (fl->fl_type == F_WRLCK);
@@ -125,35 +130,44 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
+	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
+		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
+		if (!op_data) {
+			dlm_release_plock_op(op);
+			rv = -ENOMEM;
+			goto out;
+		}
+
 		/* fl_owner is lockd which doesn't distinguish
 		   processes on the nfs client */
 		op->info.owner	= (__u64) fl->fl_pid;
-		op->callback	= fl->fl_lmops->lm_grant;
-		locks_init_lock(&xop->flc);
-		locks_copy_lock(&xop->flc, fl);
-		xop->fl		= fl;
-		xop->file	= file;
+		op_data->callback = fl->fl_lmops->lm_grant;
+		locks_init_lock(&op_data->flc);
+		locks_copy_lock(&op_data->flc, fl);
+		op_data->fl		= fl;
+		op_data->file	= file;
+
+		op->data = op_data;
+
+		send_op(op);
+		rv = FILE_LOCK_DEFERRED;
+		goto out;
 	} else {
 		op->info.owner	= (__u64)(long) fl->fl_owner;
 	}
 
 	send_op(op);
 
-	if (!op->callback) {
-		rv = wait_event_interruptible(recv_wq, (op->done != 0));
-		if (rv == -ERESTARTSYS) {
-			log_debug(ls, "dlm_posix_lock: wait killed %llx",
-				  (unsigned long long)number);
-			spin_lock(&ops_lock);
-			list_del(&op->list);
-			spin_unlock(&ops_lock);
-			kfree(xop);
-			do_unlock_close(ls, number, file, fl);
-			goto out;
-		}
-	} else {
-		rv = FILE_LOCK_DEFERRED;
+	rv = wait_event_killable(recv_wq, (op->done != 0));
+	if (rv == -ERESTARTSYS) {
+		log_debug(ls, "%s: wait killed %llx", __func__,
+			  (unsigned long long)number);
+		spin_lock(&ops_lock);
+		list_del(&op->list);
+		spin_unlock(&ops_lock);
+		dlm_release_plock_op(op);
+		do_unlock_close(ls, number, file, fl);
 		goto out;
 	}
 
@@ -173,7 +187,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 				  (unsigned long long)number);
 	}
 
-	kfree(xop);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -183,11 +197,11 @@ EXPORT_SYMBOL_GPL(dlm_posix_lock);
 /* Returns failure iff a successful lock operation should be canceled */
 static int dlm_plock_callback(struct plock_op *op)
 {
+	struct plock_async_data *op_data = op->data;
 	struct file *file;
 	struct file_lock *fl;
 	struct file_lock *flc;
 	int (*notify)(struct file_lock *fl, int result) = NULL;
-	struct plock_xop *xop = (struct plock_xop *)op;
 	int rv = 0;
 
 	spin_lock(&ops_lock);
@@ -199,10 +213,10 @@ static int dlm_plock_callback(struct plock_op *op)
 	spin_unlock(&ops_lock);
 
 	/* check if the following 2 are still valid or make a copy */
-	file = xop->file;
-	flc = &xop->flc;
-	fl = xop->fl;
-	notify = op->callback;
+	file = op_data->file;
+	flc = &op_data->flc;
+	fl = op_data->fl;
+	notify = op_data->callback;
 
 	if (op->info.rv) {
 		notify(fl, op->info.rv);
@@ -233,7 +247,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 out:
-	kfree(xop);
+	dlm_release_plock_op(op);
 	return rv;
 }
 
@@ -303,7 +317,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 
 out_free:
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	fl->fl_flags = fl_flags;
@@ -371,7 +385,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 	}
 
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -407,7 +421,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	   (the process did not make an unlock call). */
 
 	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
-		kfree(op);
+		dlm_release_plock_op(op);
 
 	if (copy_to_user(u, &info, sizeof(info)))
 		return -EFAULT;
@@ -439,7 +453,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		    op->info.owner == info.owner) {
 			list_del_init(&op->list);
 			memcpy(&op->info, &info, sizeof(info));
-			if (op->callback)
+			if (op->data)
 				do_callback = 1;
 			else
 				op->done = 1;
diff --git a/fs/file.c b/fs/file.c
index ee1c350ec58a..1501bbf6306e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1068,10 +1068,8 @@ unsigned long __fdget_pos(unsigned int fd)
 	struct file *file = (struct file *)(v & ~3);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
-		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
-			mutex_lock(&file->f_pos_lock);
-		}
+		v |= FDPUT_POS_UNLOCK;
+		mutex_lock(&file->f_pos_lock);
 	}
 	return v;
 }
diff --git a/fs/internal.h b/fs/internal.h
index ceb154583a3c..1ff8cfc94467 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,8 +58,6 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
-extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
-			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct user_namespace *mnt_userns, struct path *link);
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index fe8bb031b7d7..d2aba55833f9 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -221,20 +221,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
-		/*
-		 * The buffer may be writing back, or flushing out in the
-		 * last couple of cycles, or re-adding into a new transaction,
-		 * need to check it again until it's unlocked.
-		 */
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			goto retry;
-		}
 		if (jh->b_transaction != NULL) {
 			transaction_t *t = jh->b_transaction;
 			tid_t tid = t->t_tid;
@@ -269,7 +255,22 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 		}
-		if (!buffer_dirty(bh)) {
+		if (!trylock_buffer(bh)) {
+			/*
+			 * The buffer is locked, it may be writing back, or
+			 * flushing out in the last couple of cycles, or
+			 * re-adding into a new transaction, need to check
+			 * it again until it's unlocked.
+			 */
+			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			/* the journal_head may have gone by now */
+			BUFFER_TRACE(bh, "brelse");
+			__brelse(bh);
+			goto retry;
+		} else if (!buffer_dirty(bh)) {
+			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			/*
 			 * If the transaction was released or the checkpoint
@@ -279,6 +280,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			    !transaction->t_checkpoint_list)
 				goto out;
 		} else {
+			unlock_buffer(bh);
 			/*
 			 * We are about to write the buffer, it could be
 			 * raced by some other transaction shrink or buffer
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 52cc6a9627ed..f76acd83c294 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -19,8 +19,6 @@
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
 
-#include "../internal.h"	/* for vfs_path_lookup */
-
 #include "glob.h"
 #include "oplock.h"
 #include "connection.h"
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c062728034ad..c8729493df5c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5833,8 +5833,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index caeb08a98536..40c693525f79 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -63,6 +63,8 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
+		    unsigned int, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 725c9b784e60..c7bfa64aeb14 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -489,6 +489,11 @@ static inline int pwmchip_remove(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
+static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	return -EINVAL;
+}
+
 static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 						       unsigned int index,
 						       const char *label)
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index e3ab99f4edab..20930086b228 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -664,12 +664,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
-			    (__force u32)a->s6_addr32[2],
-			    (__force u32)a->s6_addr32[3],
-			    initval);
+	return jhash2((__force const u32 *)a->s6_addr32,
+		      ARRAY_SIZE(a->s6_addr32), initval);
 }
 
 static inline bool ipv6_addr_loopback(const struct in6_addr *a)
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 08537aa14f7c..cf1d870f7b9a 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -327,10 +327,15 @@ static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 	return features;
 }
 
-/* IP header + UDP + VXLAN + Ethernet header */
-#define VXLAN_HEADROOM (20 + 8 + 8 + 14)
-/* IPv6 header + UDP + VXLAN + Ethernet header */
-#define VXLAN6_HEADROOM (40 + 8 + 8 + 14)
+static inline int vxlan_headroom(u32 flags)
+{
+	/* VXLAN:     IP4/6 header + UDP + VXLAN + Ethernet header */
+	/* VXLAN-GPE: IP4/6 header + UDP + VXLAN */
+	return (flags & VXLAN_F_IPV6 ? sizeof(struct ipv6hdr) :
+				       sizeof(struct iphdr)) +
+	       sizeof(struct udphdr) + sizeof(struct vxlanhdr) +
+	       (flags & VXLAN_F_GPE ? 0 : ETH_HLEN);
+}
 
 static inline struct vxlanhdr *vxlan_hdr(struct sk_buff *skb)
 {
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 656a326821a2..321965feee35 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -51,13 +51,13 @@ enum blk_zone_type {
  *
  * The Zone Condition state machine in the ZBC/ZAC standards maps the above
  * deinitions as:
- *   - ZC1: Empty         | BLK_ZONE_EMPTY
+ *   - ZC1: Empty         | BLK_ZONE_COND_EMPTY
  *   - ZC2: Implicit Open | BLK_ZONE_COND_IMP_OPEN
  *   - ZC3: Explicit Open | BLK_ZONE_COND_EXP_OPEN
- *   - ZC4: Closed        | BLK_ZONE_CLOSED
- *   - ZC5: Full          | BLK_ZONE_FULL
- *   - ZC6: Read Only     | BLK_ZONE_READONLY
- *   - ZC7: Offline       | BLK_ZONE_OFFLINE
+ *   - ZC4: Closed        | BLK_ZONE_COND_CLOSED
+ *   - ZC5: Full          | BLK_ZONE_COND_FULL
+ *   - ZC6: Read Only     | BLK_ZONE_COND_READONLY
+ *   - ZC7: Offline       | BLK_ZONE_COND_OFFLINE
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d7f87157be9a..774b1ae8adf7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -7066,6 +7066,14 @@ static void io_wq_submit_work(struct io_wq_work *work)
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
+
+			/*
+			 * If REQ_F_NOWAIT is set, then don't wait or retry with
+			 * poll. -EAGAIN is final for that case.
+			 */
+			if (req->flags & REQ_F_NOWAIT)
+				break;
+
 			cond_resched();
 		} while (1);
 	}
@@ -10602,7 +10610,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 	if (!ctx)
 		return -ENOMEM;
 	ctx->compat = in_compat_syscall();
-	if (!capable(CAP_IPC_LOCK))
+	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
 		ctx->user = get_uid(current_user());
 
 	/*
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b7fa3ee3aa1d..ee5be1dda0c4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -331,21 +331,43 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 	return prio;
 }
 
+/*
+ * Update the waiter->tree copy of the sort keys.
+ */
 static __always_inline void
 waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
 {
-	waiter->prio = __waiter_prio(task);
-	waiter->deadline = task->dl.deadline;
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->tree.entry));
+
+	waiter->tree.prio = __waiter_prio(task);
+	waiter->tree.deadline = task->dl.deadline;
+}
+
+/*
+ * Update the waiter->pi_tree copy of the sort keys (from the tree copy).
+ */
+static __always_inline void
+waiter_clone_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert_held(&task->pi_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->pi_tree.entry));
+
+	waiter->pi_tree.prio = waiter->tree.prio;
+	waiter->pi_tree.deadline = waiter->tree.deadline;
 }
 
 /*
- * Only use with rt_mutex_waiter_{less,equal}()
+ * Only use with rt_waiter_node_{less,equal}()
  */
+#define task_to_waiter_node(p)	\
+	&(struct rt_waiter_node){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .tree = *task_to_waiter_node(p) }
 
-static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-						struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_less(struct rt_waiter_node *left,
+					       struct rt_waiter_node *right)
 {
 	if (left->prio < right->prio)
 		return 1;
@@ -362,8 +384,8 @@ static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	return 0;
 }
 
-static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-						 struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_equal(struct rt_waiter_node *left,
+						 struct rt_waiter_node *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -383,7 +405,7 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 				  struct rt_mutex_waiter *top_waiter)
 {
-	if (rt_mutex_waiter_less(waiter, top_waiter))
+	if (rt_waiter_node_less(&waiter->tree, &top_waiter->tree))
 		return true;
 
 #ifdef RT_MUTEX_BUILD_SPINLOCKS
@@ -391,30 +413,30 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+	if (rt_prio(waiter->tree.prio) || dl_prio(waiter->tree.prio))
 		return false;
 
-	return rt_mutex_waiter_equal(waiter, top_waiter);
+	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
 #else
 	return false;
 #endif
 }
 
 #define __node_2_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, tree_entry)
+	rb_entry((node), struct rt_mutex_waiter, tree.entry)
 
 static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct rt_mutex_waiter *aw = __node_2_waiter(a);
 	struct rt_mutex_waiter *bw = __node_2_waiter(b);
 
-	if (rt_mutex_waiter_less(aw, bw))
+	if (rt_waiter_node_less(&aw->tree, &bw->tree))
 		return 1;
 
 	if (!build_ww_mutex())
 		return 0;
 
-	if (rt_mutex_waiter_less(bw, aw))
+	if (rt_waiter_node_less(&bw->tree, &aw->tree))
 		return 0;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
@@ -432,48 +454,58 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 static __always_inline void
 rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
+	lockdep_assert_held(&lock->wait_lock);
+
+	rb_add_cached(&waiter->tree.entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->tree_entry))
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (RB_EMPTY_NODE(&waiter->tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->tree_entry, &lock->waiters);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	rb_erase_cached(&waiter->tree.entry, &lock->waiters);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 }
 
-#define __node_2_pi_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
+#define __node_2_rt_node(node) \
+	rb_entry((node), struct rt_waiter_node, entry)
 
-static __always_inline bool
-__pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+static __always_inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
 {
-	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
+	return rt_waiter_node_less(__node_2_rt_node(a), __node_2_rt_node(b));
 }
 
 static __always_inline void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
+	lockdep_assert_held(&task->pi_lock);
+
+	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->pi_tree_entry))
+	lockdep_assert_held(&task->pi_lock);
+
+	if (RB_EMPTY_NODE(&waiter->pi_tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->pi_tree_entry, &task->pi_waiters);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	rb_erase_cached(&waiter->pi_tree.entry, &task->pi_waiters);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
 }
 
-static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
+static __always_inline void rt_mutex_adjust_prio(struct rt_mutex_base *lock,
+						 struct task_struct *p)
 {
 	struct task_struct *pi_task = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert(rt_mutex_owner(lock) == p);
 	lockdep_assert_held(&p->pi_lock);
 
 	if (task_has_pi_waiters(p))
@@ -562,9 +594,14 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
  * Chain walk basics and protection scope
  *
  * [R] refcount on task
- * [P] task->pi_lock held
+ * [Pn] task->pi_lock held
  * [L] rtmutex->wait_lock held
  *
+ * Normal locking order:
+ *
+ *   rtmutex->wait_lock
+ *     task->pi_lock
+ *
  * Step	Description				Protected by
  *	function arguments:
  *	@task					[R]
@@ -579,27 +616,32 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
  *	again:
  *	  loop_sanity_check();
  *	retry:
- * [1]	  lock(task->pi_lock);			[R] acquire [P]
- * [2]	  waiter = task->pi_blocked_on;		[P]
- * [3]	  check_exit_conditions_1();		[P]
- * [4]	  lock = waiter->lock;			[P]
- * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
- *	    unlock(task->pi_lock);		release [P]
+ * [1]	  lock(task->pi_lock);			[R] acquire [P1]
+ * [2]	  waiter = task->pi_blocked_on;		[P1]
+ * [3]	  check_exit_conditions_1();		[P1]
+ * [4]	  lock = waiter->lock;			[P1]
+ * [5]	  if (!try_lock(lock->wait_lock)) {	[P1] try to acquire [L]
+ *	    unlock(task->pi_lock);		release [P1]
  *	    goto retry;
  *	  }
- * [6]	  check_exit_conditions_2();		[P] + [L]
- * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
- * [8]	  unlock(task->pi_lock);		release [P]
+ * [6]	  check_exit_conditions_2();		[P1] + [L]
+ * [7]	  requeue_lock_waiter(lock, waiter);	[P1] + [L]
+ * [8]	  unlock(task->pi_lock);		release [P1]
  *	  put_task_struct(task);		release [R]
  * [9]	  check_exit_conditions_3();		[L]
  * [10]	  task = owner(lock);			[L]
  *	  get_task_struct(task);		[L] acquire [R]
- *	  lock(task->pi_lock);			[L] acquire [P]
- * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
- * [12]	  check_exit_conditions_4();		[P] + [L]
- * [13]	  unlock(task->pi_lock);		release [P]
+ *	  lock(task->pi_lock);			[L] acquire [P2]
+ * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P2] + [L]
+ * [12]	  check_exit_conditions_4();		[P2] + [L]
+ * [13]	  unlock(task->pi_lock);		release [P2]
  *	  unlock(lock->wait_lock);		release [L]
  *	  goto again;
+ *
+ * Where P1 is the blocking task and P2 is the lock owner; going up one step
+ * the owner becomes the next blocked task etc..
+ *
+*
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
@@ -747,7 +789,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -755,13 +797,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	}
 
 	/*
-	 * [4] Get the next lock
+	 * [4] Get the next lock; per holding task->pi_lock we can't unblock
+	 * and guarantee @lock's existence.
 	 */
 	lock = waiter->lock;
 	/*
 	 * [5] We need to trylock here as we are holding task->pi_lock,
 	 * which is the reverse lock order versus the other rtmutex
 	 * operations.
+	 *
+	 * Per the above, holding task->pi_lock guarantees lock exists, so
+	 * inverting this lock order is infeasible from a life-time
+	 * perspective.
 	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
 		raw_spin_unlock_irq(&task->pi_lock);
@@ -865,17 +912,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * or
 	 *
 	 *   DL CBS enforcement advancing the effective deadline.
-	 *
-	 * Even though pi_waiters also uses these fields, and that tree is only
-	 * updated in [11], we can do this here, since we hold [L], which
-	 * serializes all pi_waiters access and rb_erase() does not care about
-	 * the values of the node being removed.
 	 */
 	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
-	/* [8] Release the task */
+	/*
+	 * [8] Release the (blocking) task in preparation for
+	 * taking the owner task in [10].
+	 *
+	 * Since we hold lock->waiter_lock, task cannot unblock, even if we
+	 * release task->pi_lock.
+	 */
 	raw_spin_unlock(&task->pi_lock);
 	put_task_struct(task);
 
@@ -899,7 +947,12 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		return 0;
 	}
 
-	/* [10] Grab the next task, i.e. the owner of @lock */
+	/*
+	 * [10] Grab the next task, i.e. the owner of @lock
+	 *
+	 * Per holding lock->wait_lock and checking for !owner above, there
+	 * must be an owner and it cannot go away.
+	 */
 	task = get_task_struct(rt_mutex_owner(lock));
 	raw_spin_lock(&task->pi_lock);
 
@@ -912,8 +965,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -928,8 +982,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -1142,6 +1197,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
+	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1175,7 +1231,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1222,6 +1278,8 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1234,7 +1292,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1471,7 +1529,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a461be2f873d..56d1938cb52a 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -437,7 +437,7 @@ void __sched rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e8361bfb5..1162e07cdaea 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -17,27 +17,44 @@
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
+
+/*
+ * This is a helper for the struct rt_mutex_waiter below. A waiter goes in two
+ * separate trees and they need their own copy of the sort keys because of
+ * different locking requirements.
+ *
+ * @entry:		rbtree node to enqueue into the waiters tree
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
+ *
+ * See rt_waiter_node_less() and waiter_*_prio().
+ */
+struct rt_waiter_node {
+	struct rb_node	entry;
+	int		prio;
+	u64		deadline;
+};
+
 /*
  * This is the control structure for tasks blocked on a rt_mutex,
  * which is allocated on the kernel stack on of the blocked task.
  *
- * @tree_entry:		pi node to enqueue into the mutex waiters tree
- * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
+ * @tree:		node to enqueue into the mutex waiters tree
+ * @pi_tree:		node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
- * @prio:		Priority of the waiter
- * @deadline:		Deadline of the waiter if applicable
  * @ww_ctx:		WW context pointer
+ *
+ * @tree is ordered by @lock->wait_lock
+ * @pi_tree is ordered by rt_mutex_owner(@lock)->pi_lock
  */
 struct rt_mutex_waiter {
-	struct rb_node		tree_entry;
-	struct rb_node		pi_tree_entry;
+	struct rt_waiter_node	tree;
+	struct rt_waiter_node	pi_tree;
 	struct task_struct	*task;
 	struct rt_mutex_base	*lock;
 	unsigned int		wake_state;
-	int			prio;
-	u64			deadline;
 	struct ww_acquire_ctx	*ww_ctx;
 };
 
@@ -105,7 +122,7 @@ static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 
-	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree.entry) == waiter;
 }
 
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
@@ -113,8 +130,10 @@ static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	if (leftmost) {
-		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree.entry);
 		BUG_ON(w->lock != lock);
 	}
 	return w;
@@ -127,8 +146,10 @@ static inline int task_has_pi_waiters(struct task_struct *p)
 
 static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
+
 	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
-			pi_tree_entry);
+			pi_tree.entry);
 }
 
 #define RT_MUTEX_HAS_WAITERS	1UL
@@ -190,8 +211,8 @@ static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	debug_rt_mutex_init_waiter(waiter);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 56f139201f24..3ad2cc4823e5 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -96,25 +96,25 @@ __ww_waiter_first(struct rt_mutex *lock)
 	struct rb_node *n = rb_first(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_next(&w->tree_entry);
+	struct rb_node *n = rb_next(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_prev(&w->tree_entry);
+	struct rb_node *n = rb_prev(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
@@ -123,7 +123,7 @@ __ww_waiter_last(struct rt_mutex *lock)
 	struct rb_node *n = rb_last(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline void
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ceeba8bf1265..e1cef097b0df 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -520,6 +520,8 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -555,6 +557,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
@@ -1931,6 +1934,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1952,12 +1957,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -4347,6 +4346,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head) {
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4800,12 +4800,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -5249,6 +5250,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1dda36c7e5eb..ae7005af78c3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5609,7 +5609,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           <type>\\[<array-size>\\]\n"
+	"\t           symstr, <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2c3d9b6ce148..43058077a4de 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -113,6 +113,12 @@ enum trace_type {
 #define MEM_FAIL(condition, fmt, ...)					\
 	DO_ONCE_LITE_IF(condition, pr_err, "ERROR: " fmt, ##__VA_ARGS__)
 
+#define FAULT_STRING "(fault)"
+
+#define HIST_STACKTRACE_DEPTH	16
+#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
+#define HIST_STACKTRACE_SKIP	5
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 160298d285c0..2a2a59999767 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -594,7 +594,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -618,6 +617,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -656,6 +657,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -695,15 +698,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1b70fc4c703f..c32a53f08922 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -315,10 +315,6 @@ DEFINE_HIST_FIELD_FN(u8);
 #define for_each_hist_key_field(i, hist_data)	\
 	for ((i) = (hist_data)->n_vals; (i) < (hist_data)->n_fields; (i)++)
 
-#define HIST_STACKTRACE_DEPTH	16
-#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
-#define HIST_STACKTRACE_SKIP	5
-
 #define HITCOUNT_IDX		0
 #define HIST_KEY_SIZE_MAX	(MAX_FILTER_STR_VAL + HIST_STACKTRACE_SIZE)
 
@@ -3431,6 +3427,9 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
+	if (strstr(hist_field->type, "long[") && field->is_stack)
+		return 0;
+
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
 		    (!field->is_string && field->is_signed != hist_field->is_signed))
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 08c7df42ade7..1e02bb431dcb 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -165,6 +165,14 @@ static int synth_field_is_string(char *type)
 	return false;
 }
 
+static int synth_field_is_stack(char *type)
+{
+	if (strstr(type, "long[") != NULL)
+		return true;
+
+	return false;
+}
+
 static int synth_field_string_size(char *type)
 {
 	char buf[4], *end, *start;
@@ -240,6 +248,8 @@ static int synth_field_size(char *type)
 		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
+	else if (synth_field_is_stack(type))
+		size = 0;
 
 	return size;
 }
@@ -284,6 +294,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
 		fmt = "%.*s";
+	else if (synth_field_is_stack(type))
+		fmt = "%s";
 
 	return fmt;
 }
@@ -363,6 +375,23 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
+		} else if (se->fields[i]->is_stack) {
+			u32 offset, data_offset, len;
+			unsigned long *p, *end;
+
+			offset = (u32)entry->fields[n_u64];
+			data_offset = offset & 0xffff;
+			len = offset >> 16;
+
+			p = (void *)entry + data_offset;
+			end = (void *)p + len - (sizeof(long) - 1);
+
+			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
+
+			for (; *p && p < end; p++)
+				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			n_u64++;
+
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -439,6 +468,43 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	return len;
 }
 
+static unsigned int trace_stack(struct synth_trace_event *entry,
+				 struct synth_event *event,
+				 long *stack,
+				 unsigned int data_size,
+				 unsigned int *n_u64)
+{
+	unsigned int len;
+	u32 data_offset;
+	void *data_loc;
+
+	data_offset = struct_size(entry, fields, event->n_u64);
+	data_offset += data_size;
+
+	for (len = 0; len < HIST_STACKTRACE_DEPTH; len++) {
+		if (!stack[len])
+			break;
+	}
+
+	/* Include the zero'd element if it fits */
+	if (len < HIST_STACKTRACE_DEPTH)
+		len++;
+
+	len *= sizeof(long);
+
+	/* Find the dynamic section to copy the stack into. */
+	data_loc = (void *)entry + data_offset;
+	memcpy(data_loc, stack, len);
+
+	/* Fill in the field that holds the offset/len combo */
+	data_offset |= len << 16;
+	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	(*n_u64)++;
+
+	return len;
+}
+
 static notrace void trace_event_raw_event_synth(void *__data,
 						u64 *var_ref_vals,
 						unsigned int *var_ref_idx)
@@ -491,6 +557,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
+		} else if (event->fields[i]->is_stack) {
+			long *stack = (long *)(long)var_ref_vals[val_idx];
+
+			len = trace_stack(entry, event, stack,
+					   data_size, &n_u64);
+			data_size += len;
 		} else {
 			struct synth_field *field = event->fields[i];
 			u64 val = var_ref_vals[val_idx];
@@ -553,6 +625,9 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		    event->fields[i]->is_dynamic)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", __get_str(%s)", event->fields[i]->name);
+		else if (event->fields[i]->is_stack)
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", __get_stacktrace(%s)", event->fields[i]->name);
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 					", REC->%s", event->fields[i]->name);
@@ -689,7 +764,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
-		if (synth_field_is_string(field->type)) {
+		if (synth_field_is_string(field->type) ||
+		    synth_field_is_stack(field->type)) {
 			char *type;
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
@@ -720,6 +796,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 
 	if (synth_field_is_string(field->type))
 		field->is_string = true;
+	else if (synth_field_is_stack(field->type))
+		field->is_stack = true;
 
 	field->is_signed = synth_field_signed(field->type);
  out:
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cb8f9fe5669a..0888f0644d25 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -64,7 +64,7 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_puts(s, "(fault)");
+		trace_seq_puts(s, FAULT_STRING);
 	else
 		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
@@ -76,9 +76,11 @@ const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
 /* Fetch type information table */
 static const struct fetch_type probe_fetch_types[] = {
 	/* Special types */
-	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
+	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
-	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1,
+	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1, 1,
+			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("symstr", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
@@ -658,16 +660,26 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	ret = -EINVAL;
 	/* Store operation */
-	if (!strcmp(parg->type->name, "string") ||
-	    !strcmp(parg->type->name, "ustring")) {
-		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
-		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
-		    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
-			trace_probe_log_err(offset + (t ? (t - arg) : 0),
-					    BAD_STRING);
-			goto fail;
+	if (parg->type->is_string) {
+		if (!strcmp(parg->type->name, "symstr")) {
+			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
+			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
+			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_SYMSTRING);
+				goto fail;
+			}
+		} else {
+			if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
+			    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
+			    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_STRING);
+				goto fail;
+			}
 		}
-		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
+		if (!strcmp(parg->type->name, "symstr") ||
+		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
 		     parg->count) {
 			/*
@@ -675,6 +687,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 * must be kept, and if parg->count != 0, this is an
 			 * array of string pointers instead of string address
 			 * itself.
+			 * For the symstr, it doesn't need to dereference, thus
+			 * it just get the value.
 			 */
 			code++;
 			if (code->op != FETCH_OP_NOP) {
@@ -686,6 +700,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		if (!strcmp(parg->type->name, "ustring") ||
 		    code->op == FETCH_OP_UDEREF)
 			code->op = FETCH_OP_ST_USTRING;
+		else if (!strcmp(parg->type->name, "symstr"))
+			code->op = FETCH_OP_ST_SYMSTR;
 		else
 			code->op = FETCH_OP_ST_STRING;
 		code->size = parg->type->size;
@@ -915,8 +931,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	for (i = 0; i < tp->nr_args; i++) {
 		parg = tp->args + i;
 		if (parg->count) {
-			if ((strcmp(parg->type->name, "string") == 0) ||
-			    (strcmp(parg->type->name, "ustring") == 0))
+			if (parg->type->is_string)
 				fmt = ", __get_str(%s[%d])";
 			else
 				fmt = ", REC->%s[%d]";
@@ -924,8 +939,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 				pos += snprintf(buf + pos, LEN_OR_ZERO,
 						fmt, parg->name, j);
 		} else {
-			if ((strcmp(parg->type->name, "string") == 0) ||
-			    (strcmp(parg->type->name, "ustring") == 0))
+			if (parg->type->is_string)
 				fmt = ", __get_str(%s)";
 			else
 				fmt = ", REC->%s";
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 84d495cbd876..0f0e5005b97a 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -99,6 +99,7 @@ enum fetch_op {
 	FETCH_OP_ST_UMEM,	/* Mem: .offset, .size */
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
+	FETCH_OP_ST_SYMSTR,	/* Kernel Symbol String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
@@ -134,7 +135,8 @@ struct fetch_insn {
 struct fetch_type {
 	const char		*name;		/* Name of type */
 	size_t			size;		/* Byte size of type */
-	int			is_signed;	/* Signed flag */
+	bool			is_signed;	/* Signed flag */
+	bool			is_string;	/* String flag */
 	print_type_func_t	print;		/* Print functions */
 	const char		*fmt;		/* Format string */
 	const char		*fmttype;	/* Name in format file */
@@ -178,16 +180,19 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 #define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
 #define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
 
-#define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
-	{.name = _name,				\
+#define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, str, _fmttype)	\
+	{.name = _name,					\
 	 .size = _size,					\
-	 .is_signed = sign,				\
+	 .is_signed = (bool)sign,			\
+	 .is_string = (bool)str,			\
 	 .print = PRINT_TYPE_FUNC_NAME(ptype),		\
 	 .fmt = PRINT_TYPE_FMT_NAME(ptype),		\
 	 .fmttype = _fmttype,				\
 	}
+
+/* Non string types can use these macros */
 #define _ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
-	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, #_fmttype)
+	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, 0, #_fmttype)
 #define ASSIGN_FETCH_TYPE(ptype, ftype, sign)			\
 	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, ptype)
 
@@ -432,6 +437,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(ARRAY_TOO_BIG,	"Array number is too big"),		\
 	C(BAD_TYPE,		"Unknown type is specified"),		\
 	C(BAD_STRING,		"String accepts only memory argument"),	\
+	C(BAD_SYMSTRING,	"Symbol String doesn't accept data/userdata"),	\
 	C(BAD_BITFIELD,		"Invalid bitfield"),			\
 	C(ARG_NAME_TOO_LONG,	"Argument name is too long"),		\
 	C(NO_ARG_NAME,		"Argument name is not specified"),	\
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 77dbd9ff9782..2da70be83831 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -2,8 +2,6 @@
 #ifndef __TRACE_PROBE_KERNEL_H_
 #define __TRACE_PROBE_KERNEL_H_
 
-#define FAULT_STRING "(fault)"
-
 /*
  * This depends on trace_probe.h, but can not include it due to
  * the way trace_probe_tmpl.h is used by trace_kprobe.c and trace_eprobe.c.
@@ -15,16 +13,8 @@ static nokprobe_inline int
 kern_fetch_store_strlen_user(unsigned long addr)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
-	int ret;
 
-	ret = strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
-	/*
-	 * strnlen_user_nofault returns zero on fault, insert the
-	 * FAULT_STRING when that occurs.
-	 */
-	if (ret <= 0)
-		return strlen(FAULT_STRING) + 1;
-	return ret;
+	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
 }
 
 /* Return the length of string -- including null terminal byte */
@@ -44,18 +34,14 @@ kern_fetch_store_strlen(unsigned long addr)
 		len++;
 	} while (c && ret == 0 && len < MAX_STRING_SIZE);
 
-	/* For faults, return enough to hold the FAULT_STRING */
-	return (ret < 0) ? strlen(FAULT_STRING) + 1 : len;
+	return (ret < 0) ? ret : len;
 }
 
-static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
+static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
 {
-	if (ret >= 0) {
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-	} else {
-		strscpy(__dest, FAULT_STRING, len);
-		ret = strlen(__dest) + 1;
-	}
+	if (ret < 0)
+		ret = 0;
+	*(u32 *)dest = make_data_loc(ret, __dest - base);
 }
 
 /*
@@ -76,7 +62,7 @@ kern_fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	set_data_loc(ret, dest, __dest, base);
 
 	return ret;
 }
@@ -107,7 +93,7 @@ kern_fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	set_data_loc(ret, dest, __dest, base);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index c293a607d536..3e2f5a43b974 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -67,6 +67,37 @@ probe_mem_read(void *dest, void *src, size_t size);
 static nokprobe_inline int
 probe_mem_read_user(void *dest, void *src, size_t size);
 
+static nokprobe_inline int
+fetch_store_symstrlen(unsigned long addr)
+{
+	char namebuf[KSYM_SYMBOL_LEN];
+	int ret;
+
+	ret = sprint_symbol(namebuf, addr);
+	if (ret < 0)
+		return 0;
+
+	return ret + 1;
+}
+
+/*
+ * Fetch a null-terminated symbol string + offset. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_symstring(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	return sprint_symbol(__dest, addr);
+}
+
 /* From the 2nd stage, routine is same */
 static nokprobe_inline int
 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
@@ -99,16 +130,22 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 stage3:
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
-		if (code->op == FETCH_OP_ST_STRING) {
+		switch (code->op) {
+		case FETCH_OP_ST_STRING:
 			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
-		} else if (code->op == FETCH_OP_ST_USTRING) {
-			ret += fetch_store_strlen_user(val + code->offset);
+		case FETCH_OP_ST_USTRING:
+			ret = fetch_store_strlen_user(val + code->offset);
 			code++;
 			goto array;
-		} else
+		case FETCH_OP_ST_SYMSTR:
+			ret = fetch_store_symstrlen(val + code->offset);
+			code++;
+			goto array;
+		default:
 			return -EILSEQ;
+		}
 	}
 
 	switch (code->op) {
@@ -129,6 +166,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		loc = *(u32 *)dest;
 		ret = fetch_store_string_user(val + code->offset, dest, base);
 		break;
+	case FETCH_OP_ST_SYMSTR:
+		loc = *(u32 *)dest;
+		ret = fetch_store_symstring(val + code->offset, dest, base);
+		break;
 	default:
 		return -EILSEQ;
 	}
@@ -206,13 +247,9 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (arg->dynamic) {
-			if (unlikely(ret < 0)) {
-				*dl = make_data_loc(0, dyndata - base);
-			} else {
-				dyndata += ret;
-				maxlen -= ret;
-			}
+		if (arg->dynamic && likely(ret > 0)) {
+			dyndata += ret;
+			maxlen -= ret;
 		}
 	}
 }
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index b29595fe3ac5..43f6fb6078db 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -18,6 +18,7 @@ struct synth_field {
 	bool is_signed;
 	bool is_string;
 	bool is_dynamic;
+	bool is_stack;
 };
 
 struct synth_event {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 78ec1c16ccf4..debc65101548 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -168,7 +168,8 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 			 */
 			ret++;
 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
-	}
+	} else
+		*(u32 *)dest = make_data_loc(0, (void *)dst - base);
 
 	return ret;
 }
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 57d043b382ed..9bf085ddbe51 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1144,6 +1144,7 @@ bool ceph_addr_is_blank(const struct ceph_entity_addr *addr)
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e0d3909172a8..0c0b7969840f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2565,12 +2565,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			ipv6_ifa_notify(0, ift);
 	}
 
-	if ((create || list_empty(&idev->tempaddr_list)) &&
-	    idev->cnf.use_tempaddr > 0) {
+	/* Also create a temporary address if it's enabled but no temporary
+	 * address currently exists.
+	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
+	 * as part of cleanup (ie. deleting the mngtmpaddr).
+	 * We don't want that to result in creating a new temporary ip address.
+	 */
+	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+		create = true;
+
+	if (create && idev->cnf.use_tempaddr > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
-		 * Also create a temporary address if it's enabled but
-		 * no temporary address currently exists.
 		 */
 		read_unlock_bh(&idev->lock);
 		ipv6_create_tempaddr(ifp, false);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e0e675313d8e..ce9f962380b7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3529,8 +3529,6 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
-			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
 		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
@@ -3543,6 +3541,9 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		return -EINVAL;
 	}
 
+	if (nft_chain_is_bound(chain))
+		return -EOPNOTSUPP;
+
 	if (nla[NFTA_RULE_HANDLE]) {
 		handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_HANDLE]));
 		rule = __nft_rule_lookup(chain, handle);
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 6b0efab4fad0..6bf1c852e8ea 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -125,15 +125,27 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
+static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
+					   struct nft_chain *chain,
+					   enum nft_trans_phase phase)
+{
+	struct nft_ctx chain_ctx;
+	struct nft_rule *rule;
+
+	chain_ctx = *ctx;
+	chain_ctx.chain = chain;
+
+	list_for_each_entry(rule, &chain->rules, list)
+		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+}
+
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 	const struct nft_data *data = &priv->data;
-	struct nft_ctx chain_ctx;
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (priv->dreg == NFT_REG_VERDICT) {
 		switch (data->verdict.code) {
@@ -143,20 +155,17 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 			if (!nft_chain_binding(chain))
 				break;
 
-			chain_ctx = *ctx;
-			chain_ctx.chain = chain;
-
-			list_for_each_entry(rule, &chain->rules, list)
-				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
-
 			switch (phase) {
 			case NFT_TRANS_PREPARE_ERROR:
 				nf_tables_unbind_chain(ctx, chain);
-				fallthrough;
+				nft_deactivate_next(ctx->net, chain);
+				break;
 			case NFT_TRANS_PREPARE:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_deactivate_next(ctx->net, chain);
 				break;
 			default:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
 				chain->table->use--;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5c05c9b990fb..8d73fffd2d09 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -217,29 +217,37 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
-			      struct nft_rbtree_elem *rbe)
+			      struct nft_rbtree_elem *rbe,
+			      u8 genmask)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
-	struct nft_rbtree_elem *rbe_prev = NULL;
+	struct nft_rbtree_elem *rbe_prev;
 	struct nft_set_gc_batch *gcb;
 
 	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
 	if (!gcb)
 		return -ENOMEM;
 
-	/* search for expired end interval coming before this element. */
+	/* search for end interval coming before this element.
+	 * end intervals don't carry a timeout extension, they
+	 * are coupled with the interval start element.
+	 */
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
-		if (nft_rbtree_interval_end(rbe_prev))
+		if (nft_rbtree_interval_end(rbe_prev) &&
+		    nft_set_elem_active(&rbe_prev->ext, genmask))
 			break;
 
 		prev = rb_prev(prev);
 	}
 
-	if (rbe_prev) {
+	if (prev) {
+		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+
 		rb_erase(&rbe_prev->node, &priv->root);
 		atomic_dec(&set->nelems);
+		nft_set_gc_batch_add(gcb, rbe_prev);
 	}
 
 	rb_erase(&rbe->node, &priv->root);
@@ -321,7 +329,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		/* perform garbage collection to avoid bogus overlap reports. */
 		if (nft_set_elem_expired(&rbe->ext)) {
-			err = nft_rbtree_gc_elem(set, priv, rbe);
+			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 50e15add6068..56d3dc5e95c7 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -130,6 +130,97 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
+static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
+			       struct nlattr *opt,
+			       struct netlink_ext_ack *extack)
+{
+	struct mqprio_sched *priv = qdisc_priv(sch);
+	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
+	struct nlattr *attr;
+	int i, rem, err;
+
+	err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
+			 sizeof(*qopt));
+	if (err < 0)
+		return err;
+
+	if (!qopt->hw) {
+		NL_SET_ERR_MSG(extack,
+			       "mqprio TCA_OPTIONS can only contain netlink attributes in hardware mode");
+		return -EINVAL;
+	}
+
+	if (tb[TCA_MQPRIO_MODE]) {
+		priv->flags |= TC_MQPRIO_F_MODE;
+		priv->mode = *(u16 *)nla_data(tb[TCA_MQPRIO_MODE]);
+	}
+
+	if (tb[TCA_MQPRIO_SHAPER]) {
+		priv->flags |= TC_MQPRIO_F_SHAPER;
+		priv->shaper = *(u16 *)nla_data(tb[TCA_MQPRIO_SHAPER]);
+	}
+
+	if (tb[TCA_MQPRIO_MIN_RATE64]) {
+		if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_MQPRIO_MIN_RATE64],
+					    "min_rate accepted only when shaper is in bw_rlimit mode");
+			return -EINVAL;
+		}
+		i = 0;
+		nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
+				    rem) {
+			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute type expected to be TCA_MQPRIO_MIN_RATE64");
+				return -EINVAL;
+			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MIN_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
+			if (i >= qopt->num_tc)
+				break;
+			priv->min_rate[i] = *(u64 *)nla_data(attr);
+			i++;
+		}
+		priv->flags |= TC_MQPRIO_F_MIN_RATE;
+	}
+
+	if (tb[TCA_MQPRIO_MAX_RATE64]) {
+		if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_MQPRIO_MAX_RATE64],
+					    "max_rate accepted only when shaper is in bw_rlimit mode");
+			return -EINVAL;
+		}
+		i = 0;
+		nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
+				    rem) {
+			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute type expected to be TCA_MQPRIO_MAX_RATE64");
+				return -EINVAL;
+			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MAX_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
+			if (i >= qopt->num_tc)
+				break;
+			priv->max_rate[i] = *(u64 *)nla_data(attr);
+			i++;
+		}
+		priv->flags |= TC_MQPRIO_F_MAX_RATE;
+	}
+
+	return 0;
+}
+
 static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 		       struct netlink_ext_ack *extack)
 {
@@ -139,9 +230,6 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *qdisc;
 	int i, err = -EOPNOTSUPP;
 	struct tc_mqprio_qopt *qopt = NULL;
-	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
-	struct nlattr *attr;
-	int rem;
 	int len;
 
 	BUILD_BUG_ON(TC_MAX_QUEUE != TC_QOPT_MAX_QUEUE);
@@ -166,55 +254,9 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 
 	len = nla_len(opt) - NLA_ALIGN(sizeof(*qopt));
 	if (len > 0) {
-		err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
-				 sizeof(*qopt));
-		if (err < 0)
+		err = mqprio_parse_nlattr(sch, qopt, opt, extack);
+		if (err)
 			return err;
-
-		if (!qopt->hw)
-			return -EINVAL;
-
-		if (tb[TCA_MQPRIO_MODE]) {
-			priv->flags |= TC_MQPRIO_F_MODE;
-			priv->mode = *(u16 *)nla_data(tb[TCA_MQPRIO_MODE]);
-		}
-
-		if (tb[TCA_MQPRIO_SHAPER]) {
-			priv->flags |= TC_MQPRIO_F_SHAPER;
-			priv->shaper = *(u16 *)nla_data(tb[TCA_MQPRIO_SHAPER]);
-		}
-
-		if (tb[TCA_MQPRIO_MIN_RATE64]) {
-			if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE)
-				return -EINVAL;
-			i = 0;
-			nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
-					    rem) {
-				if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64)
-					return -EINVAL;
-				if (i >= qopt->num_tc)
-					break;
-				priv->min_rate[i] = *(u64 *)nla_data(attr);
-				i++;
-			}
-			priv->flags |= TC_MQPRIO_F_MIN_RATE;
-		}
-
-		if (tb[TCA_MQPRIO_MAX_RATE64]) {
-			if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE)
-				return -EINVAL;
-			i = 0;
-			nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
-					    rem) {
-				if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64)
-					return -EINVAL;
-				if (i >= qopt->num_tc)
-					break;
-				priv->max_rate[i] = *(u64 *)nla_data(attr);
-				i++;
-			}
-			priv->flags |= TC_MQPRIO_F_MAX_RATE;
-		}
 	}
 
 	/* pre-allocate qdisc, attachment can't fail */
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 4243d2ab8adf..32447e8d94ac 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1971,7 +1971,8 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 
 	skb_reset_network_header(*skb);
 	skb_pull(*skb, tipc_ehdr_size(ehdr));
-	pskb_trim(*skb, (*skb)->len - aead->authsize);
+	if (pskb_trim(*skb, (*skb)->len - aead->authsize))
+		goto free_skb;
 
 	/* Validate TIPCv2 message */
 	if (unlikely(!tipc_msg_validate(skb))) {
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 5e000fde8067..a9c5b6594889 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -583,7 +583,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
+		tipc_node_put(n);
 		n = NULL;
 		goto exit;
 	}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0bc3f3f1b8a7..965720b1d1b1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9079,6 +9079,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 70260e0a8f09..3ff73367897d 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -19,6 +19,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
+const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index c61b17dc2af8..4b026e1c3fe3 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -825,13 +825,6 @@ int __maybe_unused cs42l51_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs42l51_resume);
 
-const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-EXPORT_SYMBOL_GPL(cs42l51_of_match);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 9d06cf7f8876..4f13c38484b7 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -16,7 +16,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap);
 int cs42l51_remove(struct device *dev);
 int __maybe_unused cs42l51_suspend(struct device *dev);
 int __maybe_unused cs42l51_resume(struct device *dev);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 6759ce7e09ff..7aed412b19c7 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2306,6 +2306,9 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
+	/* Fill the cache for the ADC test register */
+	regmap_read(wm8904->regmap, WM8904_ADC_TEST_0, &val);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8b5c3ba48516..5b107f2555dd 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -666,6 +666,8 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(regmap, REG_SPDIF_SCR, dmaen, 0);
 		regmap_update_bits(regmap, REG_SPDIF_SIE, intr, 0);
+		regmap_write(regmap, REG_SPDIF_STL, 0x0);
+		regmap_write(regmap, REG_SPDIF_STR, 0x0);
 		break;
 	default:
 		return -EINVAL;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 368fae525fea..a68048f1fc5a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -179,10 +179,7 @@ if iptables-legacy -V &> /dev/null; then
 elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index d5c79e4a8f1e..3432d11e0a03 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -13,13 +13,15 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 do_all_tests=1
+iptables="iptables"
+ip6tables="ip6tables"
 
 add_mark_rules()
 {
 	local ns=$1
 	local m=$2
 
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -90,14 +92,14 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+# Use the legacy version if available to support old kernel versions
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
@@ -107,10 +109,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	tables=iptables
+	tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3967184b7d62..d11c581ce9b9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3804,8 +3804,17 @@ static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
 			sizeof(vcpu->stat), user_buffer, size, offset);
 }
 
+static int kvm_vcpu_stats_release(struct inode *inode, struct file *file)
+{
+	struct kvm_vcpu *vcpu = file->private_data;
+
+	kvm_put_kvm(vcpu->kvm);
+	return 0;
+}
+
 static const struct file_operations kvm_vcpu_stats_fops = {
 	.read = kvm_vcpu_stats_read,
+	.release = kvm_vcpu_stats_release,
 	.llseek = noop_llseek,
 };
 
@@ -3826,6 +3835,9 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(vcpu->kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
@@ -4409,8 +4421,17 @@ static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
 				sizeof(kvm->stat), user_buffer, size, offset);
 }
 
+static int kvm_vm_stats_release(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = file->private_data;
+
+	kvm_put_kvm(kvm);
+	return 0;
+}
+
 static const struct file_operations kvm_vm_stats_fops = {
 	.read = kvm_vm_stats_read,
+	.release = kvm_vm_stats_release,
 	.llseek = noop_llseek,
 };
 
@@ -4429,6 +4450,9 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
