Return-Path: <linux-kernel+bounces-44923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9484291D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D87B2A23F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BFF12AAC5;
	Tue, 30 Jan 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j36Fp4vk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="in5dLDbD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC31292C9;
	Tue, 30 Jan 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631962; cv=none; b=kLBPlMDaEZ0ibx28LYRohc3zQ7rmS/er5Qb0y0kG+zOTgz2Xo0MALr6auarkE1iBIjS1hAhqe7rmEwwpfJsdlW6I7ivUCA1nSEjZgihaUGDSkZy2891Q2JCvPcq4Xlmi0LPME1M21Jc6b1iLvnU9X5jTwmT7rQPZpYsiPtUtJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631962; c=relaxed/simple;
	bh=08h/3Imr11knJ6KKFs1IepmXnyjVSHsHvFExOrnsk1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pFHvYy2TJBxNt94wakW6acXvcTY/PQmrwD7FaQMjlE47MLV/6ZtwiW7J4c1yHeoVk0Rp1lzrS+KCcZooqT8H5fQ5rSIWirjocOST2Ih9BNXI4lWz1NzWw2ZAkbk8wyaumOXjNtS8VuFAZuOPbY11Rdd8L748yESTT8hgH6t97J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j36Fp4vk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=in5dLDbD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:25:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK8jqiwrGzBAiVLcH8uX8Qv06v5HOyq56/D5AzmzIA4=;
	b=j36Fp4vkc4McvZDG80I2nMwscBjX5e4yUGsEdTBuTmVRnjuJz1M+pH8AOCQhD1tXiRH6Tn
	z3b3arpQdJzuoOB3M6v6AZwQ8UfdAkIzrA4QL31nM1Mkf8krg7gF4J86RZD+2Qo4/RmnR7
	IE6QtkYsb7F+b38IiR0gzyT87oT+2DxZg53+lU9U4JoFJZXCbom6yDS+9QGUTuuNIOL8Be
	qTUw9uNk5BnxgUrrQ4C/296MaqKYGbxpDwHo5l9QSoDRjkDwaFsuebHJtSKmbtFi0RbJS5
	u8jG/NH6+/7QjBYT2yoI9rdxLYBZQNknEku+za1wRrmwPFHXU1ztPUfNc9jOpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK8jqiwrGzBAiVLcH8uX8Qv06v5HOyq56/D5AzmzIA4=;
	b=in5dLDbDwKA16pDqiEUoe8ZazwJSlmnvQdhXzMUUNdnTDwQDeo6l4z2ak5p4QbMugXUbh9
	6lq2eB1IsCg+qvCA==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] KVM: SEV: Make AVIC backing, VMSA and VMCB memory
 allocation SNP safe
Cc: Alper Gun <alpergun@google.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Marc Orr <marcorr@google.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-22-michael.roth@amd.com>
References: <20240126041126.1927228-22-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663195844.398.12211557305714550678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     75253db41a467ab7983b62616b25ff083c28803a
Gitweb:        https://git.kernel.org/tip/75253db41a467ab7983b62616b25ff083c28803a
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:21 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:19 +01:00

KVM: SEV: Make AVIC backing, VMSA and VMCB memory allocation SNP safe

Implement a workaround for an SNP erratum where the CPU will incorrectly
signal an RMP violation #PF if a hugepage (2MB or 1GB) collides with the
RMP entry of a VMCB, VMSA or AVIC backing page.

When SEV-SNP is globally enabled, the CPU marks the VMCB, VMSA, and AVIC
backing pages as "in-use" via a reserved bit in the corresponding RMP
entry after a successful VMRUN. This is done for _all_ VMs, not just
SNP-Active VMs.

If the hypervisor accesses an in-use page through a writable
translation, the CPU will throw an RMP violation #PF. On early SNP
hardware, if an in-use page is 2MB-aligned and software accesses any
part of the associated 2MB region with a hugepage, the CPU will
incorrectly treat the entire 2MB region as in-use and signal a an RMP
violation #PF.

To avoid this, the recommendation is to not use a 2MB-aligned page for
the VMCB, VMSA or AVIC pages. Add a generic allocator that will ensure
that the page returned is not 2MB-aligned and is safe to be used when
SEV-SNP is enabled. Also implement similar handling for the VMCB/VMSA
pages of nested guests.

  [ mdr: Squash in nested guest handling from Ashish, commit msg fixups. ]

Reported-by: Alper Gun <alpergun@google.com> # for nested VMSA case
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Marc Orr <marcorr@google.com>
Signed-off-by: Marc Orr <marcorr@google.com>
Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20240126041126.1927228-22-michael.roth@amd.com
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +-
 arch/x86/include/asm/kvm_host.h    |  1 +-
 arch/x86/kvm/lapic.c               |  5 ++++-
 arch/x86/kvm/svm/nested.c          |  2 +-
 arch/x86/kvm/svm/sev.c             | 32 +++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             | 17 ++++++++++++---
 arch/x86/kvm/svm/svm.h             |  1 +-
 7 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 378ed94..ab24ce2 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -138,6 +138,7 @@ KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
+KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 
 #undef KVM_X86_OP
 #undef KVM_X86_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b5b2d0f..5c12af2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1794,6 +1794,7 @@ struct kvm_x86_ops {
 	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
+	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3242f3d..1edf93e 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2815,7 +2815,10 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
 
 	vcpu->arch.apic = apic;
 
-	apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (kvm_x86_ops.alloc_apic_backing_page)
+		apic->regs = static_call(kvm_x86_alloc_apic_backing_page)(vcpu);
+	else
+		apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 	if (!apic->regs) {
 		printk(KERN_ERR "malloc apic regs error for vcpu %x\n",
 		       vcpu->vcpu_id);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index dee6236..55b9a6d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1181,7 +1181,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	if (svm->nested.initialized)
 		return 0;
 
-	vmcb02_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	vmcb02_page = snp_safe_alloc_page(&svm->vcpu);
 	if (!vmcb02_page)
 		return -ENOMEM;
 	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 564091f..f99435b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3163,3 +3163,35 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, 1);
 }
+
+struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
+{
+	unsigned long pfn;
+	struct page *p;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+
+	/*
+	 * Allocate an SNP-safe page to workaround the SNP erratum where
+	 * the CPU will incorrectly signal an RMP violation #PF if a
+	 * hugepage (2MB or 1GB) collides with the RMP entry of a
+	 * 2MB-aligned VMCB, VMSA, or AVIC backing page.
+	 *
+	 * Allocate one extra page, choose a page which is not
+	 * 2MB-aligned, and free the other.
+	 */
+	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	if (!p)
+		return NULL;
+
+	split_page(p, 1);
+
+	pfn = page_to_pfn(p);
+	if (IS_ALIGNED(pfn, PTRS_PER_PMD))
+		__free_page(p++);
+	else
+		__free_page(p + 1);
+
+	return p;
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e90b429..8284105 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -703,7 +703,7 @@ static int svm_cpu_init(int cpu)
 	int ret = -ENOMEM;
 
 	memset(sd, 0, sizeof(struct svm_cpu_data));
-	sd->save_area = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	sd->save_area = snp_safe_alloc_page(NULL);
 	if (!sd->save_area)
 		return ret;
 
@@ -1421,7 +1421,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm = to_svm(vcpu);
 
 	err = -ENOMEM;
-	vmcb01_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	vmcb01_page = snp_safe_alloc_page(vcpu);
 	if (!vmcb01_page)
 		goto out;
 
@@ -1430,7 +1430,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 		 * SEV-ES guests require a separate VMSA page used to contain
 		 * the encrypted register state of the guest.
 		 */
-		vmsa_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		vmsa_page = snp_safe_alloc_page(vcpu);
 		if (!vmsa_page)
 			goto error_free_vmcb_page;
 
@@ -4900,6 +4900,16 @@ static int svm_vm_init(struct kvm *kvm)
 	return 0;
 }
 
+static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
+{
+	struct page *page = snp_safe_alloc_page(vcpu);
+
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
 static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
@@ -5031,6 +5041,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
+	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8ef9513..7f1fbd8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -694,6 +694,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
+struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
 
 /* vmenter.S */
 

