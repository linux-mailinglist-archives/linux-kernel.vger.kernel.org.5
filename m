Return-Path: <linux-kernel+bounces-159004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD878B27FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33015B23192
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75060155736;
	Thu, 25 Apr 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR1pcMVR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE091552F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068880; cv=none; b=mcWVYWd+a47n3uWNTe8CAR4wsCSh44EERcegYE5Gcw4ruGSBjAqGJUZ8QVT396RaavzqQxoTZcDFDNy6rriOQh3CVDw0WPwGFGSPXoArcKwLfKX6pE/ERVuyMSzwV6t6Vpa2ZktdcGTfbYmrbIHgwA6SiNaMb3Lc2rmG2kKecKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068880; c=relaxed/simple;
	bh=StvXIkZ3US0m9kMQ9Q9JfdVme37W4KFKyCQZH7rfLnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZuSLeg7IKMGqtWMiC1v0Kjd9tyt8o8oY2VHpkEmfXjFDRdiQDX00bLV/Ib21/WlfE/k52nB3yXrqy8kiLxsa9PmHmcXN2R3fYqxo828hBy3IPFAZ6w5hjHmRfYokhRD3A5O3inDrQtBU6vDXiRQB8LRnXeeL5VEV91GueqxV0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tR1pcMVR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b330409b7so24739497b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714068877; x=1714673677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tixZAupWcHJk0+Ih8AFgTTyczfrfxCg1OkitEmBkTm8=;
        b=tR1pcMVRF5RQPt7Ok2wl3Q6jnpVwa+q60tszFQtjusRR3CYs2XCvWZHb+1Qvrg8LAg
         USJii9a1H5/xFdrXeWM4G00bo81iRu7sVtngls9TnjUBMeXu/xKvwSs1mAPIUfyqWP+1
         89GLveFtKmVJ2DvKzfZNiBSlVpP5T1d6H4/GTJW4eDgJzDO98Ern4fQkIwElLItZzbIS
         5RtweVpkkc8QC1UIdLCMR0IKKgU+jmNYk/kov5GRT+Zyrg0jtGPiXCQL4gUS0Jedkb/6
         p1LHRusLsdGc5IQGO7rnBq1uK7fdiNn3V21b5Pym+YJtQ8319+bz3Thxx7B7KDaAWBPv
         Z3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068877; x=1714673677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tixZAupWcHJk0+Ih8AFgTTyczfrfxCg1OkitEmBkTm8=;
        b=sttj3EsLOk8Kl93YknIMbKZ/rWstKxakBI2y/Pjt8/Wt9ewC1O0Z1xOQ44OHwQz0Y1
         se18+lTGN2YjS5cL4Vfep28E3SSpPa0NE+daY6WNA78GWuzU+3IgLveKNXouJovH7nGU
         aYGxI+AmqaPQBL1J4OcktKWKyecsLV541dSiPM5sHwkr84VEV+KwPT6HyQH2bmRyh8YS
         g1WSR1jtaDJ70e8n60S2+6LWvdDPMpbpfwxVHXIUvm6cSRsHXm1a4P0tUIFghkHFsmbl
         CeEx9tZCJeFznZlT5bfbOB3B8WOE7sR/rMHYXgq5HzqPtzniEpZeJi8cH0Y+0GKJ0nLd
         RBVw==
X-Forwarded-Encrypted: i=1; AJvYcCVCNp4AlSPpmb91ncMGSFixhaBPTzA/cMMo4JnIWN3h7GGtqQgR/sbPB4SIUwBMeiquPBGf0vLOUUhrcI9qZRQ8fVGYa3qqf3PpoUj1
X-Gm-Message-State: AOJu0YzdgwXCj2Qhdr8ET2kof9bSb6PVep4vUxTZ/CiOHz8ely/DTdD2
	vuZbLqACGnL1zP2SOelaDP1Xh5NKa7z6qaafDrw7dIVBNwIPUjOY+CfzucQEnw4OdUBHs95eaHq
	oIw==
X-Google-Smtp-Source: AGHT+IGitSnpLRruha2mGLEVNnW3UwIoXpPe8MsEM+FZOOpjpgq9++sJJlL2SPUFErP7kldSMaVP1xeihoE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:cacc:0:b0:615:130a:2503 with SMTP id
 m195-20020a0dcacc000000b00615130a2503mr50202ywd.8.1714068877189; Thu, 25 Apr
 2024 11:14:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 11:14:17 -0700
In-Reply-To: <20240425181422.3250947-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425181422.3250947-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425181422.3250947-6-seanjc@google.com>
Subject: [PATCH 05/10] KVM: x86: Rename get_msr_feature() APIs to get_feature_msr()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename all APIs related to feature MSRs from get_feature_msr() to
get_feature_msr().  The APIs get "feature MSRs", not "MSR features".
And unlike kvm_{g,s}et_msr_common(), the "feature" adjective doesn't
describe the helper itself.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/svm/svm.c             |  6 +++---
 arch/x86/kvm/vmx/main.c            |  2 +-
 arch/x86/kvm/vmx/vmx.c             |  2 +-
 arch/x86/kvm/vmx/x86_ops.h         |  2 +-
 arch/x86/kvm/x86.c                 | 12 ++++++------
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 5187fcf4b610..9f25b4a49d6b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -128,7 +128,7 @@ KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
 KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
 KVM_X86_OP_OPTIONAL(vm_move_enc_context_from)
 KVM_X86_OP_OPTIONAL(guest_memory_reclaimed)
-KVM_X86_OP(get_msr_feature)
+KVM_X86_OP(get_feature_msr)
 KVM_X86_OP(check_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
 KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7d56e5a52ae3..cc04ab0c234e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1785,7 +1785,7 @@ struct kvm_x86_ops {
 	int (*vm_move_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
 	void (*guest_memory_reclaimed)(struct kvm *kvm);
 
-	int (*get_msr_feature)(u32 msr, u64 *data);
+	int (*get_feature_msr)(u32 msr, u64 *data);
 
 	int (*check_emulate_instruction)(struct kvm_vcpu *vcpu, int emul_type,
 					 void *insn, int insn_len);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 15422b7d9149..d95cd230540d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2796,7 +2796,7 @@ static int efer_trap(struct kvm_vcpu *vcpu)
 	return kvm_complete_insn_gp(vcpu, ret);
 }
 
-static int svm_get_msr_feature(u32 msr, u64 *data)
+static int svm_get_feature_msr(u32 msr, u64 *data)
 {
 	*data = 0;
 
@@ -3134,7 +3134,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_AMD64_DE_CFG: {
 		u64 supported_de_cfg;
 
-		if (svm_get_msr_feature(ecx, &supported_de_cfg))
+		if (svm_get_feature_msr(ecx, &supported_de_cfg))
 			return 1;
 
 		if (data & ~supported_de_cfg)
@@ -4944,7 +4944,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_unblocking = avic_vcpu_unblocking,
 
 	.update_exception_bitmap = svm_update_exception_bitmap,
-	.get_msr_feature = svm_get_msr_feature,
+	.get_feature_msr = svm_get_feature_msr,
 	.get_msr = svm_get_msr,
 	.set_msr = svm_set_msr,
 	.get_segment_base = svm_get_segment_base,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 7c546ad3e4c9..c670f4cf6d94 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -40,7 +40,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.vcpu_put = vmx_vcpu_put,
 
 	.update_exception_bitmap = vmx_update_exception_bitmap,
-	.get_msr_feature = vmx_get_msr_feature,
+	.get_feature_msr = vmx_get_feature_msr,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
 	.get_segment_base = vmx_get_segment_base,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 25b0a838abd6..fe2bf8f31d7c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1955,7 +1955,7 @@ static inline bool is_vmx_feature_control_msr_valid(struct vcpu_vmx *vmx,
 	return !(msr->data & ~valid_bits);
 }
 
-int vmx_get_msr_feature(u32 msr, u64 *data)
+int vmx_get_feature_msr(u32 msr, u64 *data)
 {
 	switch (msr) {
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 504d56d6837d..4b81c85e9357 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -58,7 +58,7 @@ bool vmx_has_emulated_msr(struct kvm *kvm, u32 index);
 void vmx_msr_filter_changed(struct kvm_vcpu *vcpu);
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
-int vmx_get_msr_feature(u32 msr, u64 *data);
+int vmx_get_feature_msr(u32 msr, u64 *data);
 int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg);
 void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 03e50812ab33..8f58181f2b6d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1682,7 +1682,7 @@ static u64 kvm_get_arch_capabilities(void)
 	return data;
 }
 
-static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
+static int kvm_get_feature_msr(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_ARCH_CAPABILITIES:
@@ -1695,12 +1695,12 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
-		return static_call(kvm_x86_get_msr_feature)(msr->index, &msr->data);
+		return static_call(kvm_x86_get_feature_msr)(msr->index, &msr->data);
 	}
 	return 0;
 }
 
-static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
 	struct kvm_msr_entry msr;
 	int r;
@@ -1708,7 +1708,7 @@ static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	/* Unconditionally clear the output for simplicity */
 	msr.data = 0;
 	msr.index = index;
-	r = kvm_get_msr_feature(&msr);
+	r = kvm_get_feature_msr(&msr);
 
 	if (r == KVM_MSR_RET_UNSUPPORTED && kvm_msr_ignored_check(index, 0, false))
 		r = 0;
@@ -4962,7 +4962,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_GET_MSRS:
-		r = msr_io(NULL, argp, do_get_msr_feature, 1);
+		r = msr_io(NULL, argp, do_get_feature_msr, 1);
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_GET_SUPPORTED_HV_CPUID:
@@ -7367,7 +7367,7 @@ static void kvm_probe_feature_msr(u32 msr_index)
 		.index = msr_index,
 	};
 
-	if (kvm_get_msr_feature(&msr))
+	if (kvm_get_feature_msr(&msr))
 		return;
 
 	msr_based_features[num_msr_based_features++] = msr_index;
-- 
2.44.0.769.g3c40516874-goog


