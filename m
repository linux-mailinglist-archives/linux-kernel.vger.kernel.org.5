Return-Path: <linux-kernel+bounces-21632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4B829222
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE191F26BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F83D962;
	Wed, 10 Jan 2024 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHhDT1Cw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5C32C7A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f8ec09e595so40189877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704850040; x=1705454840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8AeuQcWkRA9pgk7FbubWOP5IvjNtvpXOvAA15pmUTDA=;
        b=lHhDT1CwbXWC36UqIuCIn4gJ8XofBUk0IkD8sVqCrE7hb68Z+p3yJolZgsf3cjoF8C
         KPa5D0D9nS4jgK4UYsjaJ+kQyHOHyn+98ZdnPWWAz44ZQUcFnXFvkjo7b3dTwAdQbt2H
         noix7lMxSHxG6VinmWB/kA3sldYP0uX8YXTlVEGk0LQpz2LeT7aBJqlmPmcOmWn6XPHy
         S7HdaH/rkpXy9PCbS9793+KEmUKbcqj4TUvIzDPOwgMZxZzhGAY9AFVUYbTQ2fb+bYxd
         1DWcfJNGN0O6uRu6IftVdNZlshmOuzrFtQZu0O3moTLKman2XYx/k0OlYl8hJBXupTKX
         +VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704850040; x=1705454840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AeuQcWkRA9pgk7FbubWOP5IvjNtvpXOvAA15pmUTDA=;
        b=UHZedYVEpQZ4GyeuEr6fm5bmDfumWVQi8r01pOLAljd/t8pd+m7/HyUX1nwmUvN7rD
         6GlKvS0DjO4B0X2gR6Np1IDW0MD4d8Pd/atWqhfUJQcShOfGvOuDjETApZH5KYbGw9tD
         WEqO613GH/FV6aRS6uIHJW1YMJ7qtOdD+7WozDMzR1oxo4uKRM2JsDW6D/ezVmdFshXC
         1Dfd10MeHMNeM8uk429lDZ8fstiljNGZMzJCZ007WShb1C8L8Ldt6B3dWl99QZkDwv3E
         CaRwFG1k+9l5Yf5O1vTJASgj7yyRMs84pS8szK6lC7Vf2BoOiOYh3HjKb6qxPcfOXYZ+
         8Bcg==
X-Gm-Message-State: AOJu0YzDULA4qlnzc+BNTRtew/2EhG25D0U45zScgrmB/Lpbzqwmb0E4
	IZk1dIWzQ0YLPdOWC7u1gcnVo4O+Q6JnC9RKMw==
X-Google-Smtp-Source: AGHT+IHgO4ytaqGpYEsoy7PVB0S3Folb+A80SPixRATRFBToiYI2fORWMXjnEFKVQKW+SfkEoLQb8Z5/wKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:884:b0:5f4:f576:6441 with SMTP id
 cd4-20020a05690c088400b005f4f5766441mr189750ywb.0.1704850039968; Tue, 09 Jan
 2024 17:27:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 17:27:05 -0800
In-Reply-To: <20240110012705.506918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110012705.506918-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110012705.506918-7-seanjc@google.com>
Subject: [PATCH 6/6] KVM: x86: Fully defer to vendor code to decide how to
 force immediate exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that vmx->req_immediate_exit is used only in the scope of
vmx_vcpu_run(), use force_immediate_exit to detect that KVM should usurp
the VMX preemption to force a VM-Exit and let vendor code fully handle
forcing a VM-Exit.

Opportunsitically drop __kvm_request_immediate_exit() and just have
vendor code call smp_send_reschedule() directly.  SVM already does this
when injecting an event while also trying to single-stepp an IRET, i.e.
it's not exactly secret knowledge that KVM uses a reschedule IPI to force
an exit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 ---
 arch/x86/kvm/svm/svm.c             |  7 ++++---
 arch/x86/kvm/vmx/vmx.c             | 32 +++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.h             |  2 --
 arch/x86/kvm/x86.c                 | 10 +---------
 6 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 378ed944b849..3942b74c1b75 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -103,7 +103,6 @@ KVM_X86_OP(write_tsc_multiplier)
 KVM_X86_OP(get_exit_info)
 KVM_X86_OP(check_intercept)
 KVM_X86_OP(handle_exit_irqoff)
-KVM_X86_OP(request_immediate_exit)
 KVM_X86_OP(sched_in)
 KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
 KVM_X86_OP_OPTIONAL(vcpu_blocking)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9c90664ef9fb..c48dfc142438 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1732,8 +1732,6 @@ struct kvm_x86_ops {
 			       struct x86_exception *exception);
 	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
 
-	void (*request_immediate_exit)(struct kvm_vcpu *vcpu);
-
 	void (*sched_in)(struct kvm_vcpu *vcpu, int cpu);
 
 	/*
@@ -2239,7 +2237,6 @@ extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
-void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 
 void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				     u32 size);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c32576c951ce..eabadbb4ffa3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4143,8 +4143,11 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 		 * is enough to force an immediate vmexit.
 		 */
 		disable_nmi_singlestep(svm);
+		force_immediate_exit = true;
+	}
+
+	if (force_immediate_exit)
 		smp_send_reschedule(vcpu->cpu);
-	}
 
 	pre_svm_run(vcpu);
 
@@ -4998,8 +5001,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
 
-	.request_immediate_exit = __kvm_request_immediate_exit,
-
 	.sched_in = svm_sched_in,
 
 	.nested_ops = &svm_nested_ops,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 14658e794fbd..603412e0add3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -49,6 +49,8 @@
 #include <asm/spec-ctrl.h>
 #include <asm/vmx.h>
 
+#include <trace/events/ipi.h>
+
 #include "capabilities.h"
 #include "cpuid.h"
 #include "hyperv.h"
@@ -1281,8 +1283,6 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	u16 fs_sel, gs_sel;
 	int i;
 
-	vmx->req_immediate_exit = false;
-
 	/*
 	 * Note that guest MSRs to be saved/restored can also be changed
 	 * when guest state is loaded. This happens when guest transitions
@@ -5991,7 +5991,8 @@ static int handle_pml_full(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
+static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu,
+						   bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6007,7 +6008,7 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 	 * If the timer expired because KVM used it to force an immediate exit,
 	 * then mission accomplished.
 	 */
-	if (vmx->req_immediate_exit)
+	if (force_immediate_exit)
 		return EXIT_FASTPATH_EXIT_HANDLED;
 
 	/*
@@ -7169,13 +7170,13 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 					msrs[i].host, false);
 }
 
-static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 tscl;
 	u32 delta_tsc;
 
-	if (vmx->req_immediate_exit) {
+	if (force_immediate_exit) {
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (vmx->hv_deadline_tsc != -1) {
@@ -7228,7 +7229,8 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 	barrier_nospec();
 }
 
-static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
+static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
+					     bool force_immediate_exit)
 {
 	/*
 	 * If L2 is active, some VMX preemption timer exits can be handled in
@@ -7242,7 +7244,7 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case EXIT_REASON_PREEMPTION_TIMER:
-		return handle_fastpath_preemption_timer(vcpu);
+		return handle_fastpath_preemption_timer(vcpu, force_immediate_exit);
 	default:
 		return EXIT_FASTPATH_NONE;
 	}
@@ -7385,7 +7387,9 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 		vmx_passthrough_lbr_msrs(vcpu);
 
 	if (enable_preemption_timer)
-		vmx_update_hv_timer(vcpu);
+		vmx_update_hv_timer(vcpu, force_immediate_exit);
+	else if (force_immediate_exit)
+		smp_send_reschedule(vcpu->cpu);
 
 	kvm_wait_lapic_expire(vcpu);
 
@@ -7449,7 +7453,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
-	return vmx_exit_handlers_fastpath(vcpu);
+	return vmx_exit_handlers_fastpath(vcpu, force_immediate_exit);
 }
 
 static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
@@ -7929,11 +7933,6 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
 }
 
-static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
-{
-	to_vmx(vcpu)->req_immediate_exit = true;
-}
-
 static int vmx_check_intercept_io(struct kvm_vcpu *vcpu,
 				  struct x86_instruction_info *info)
 {
@@ -8386,8 +8385,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.check_intercept = vmx_check_intercept,
 	.handle_exit_irqoff = vmx_handle_exit_irqoff,
 
-	.request_immediate_exit = vmx_request_immediate_exit,
-
 	.sched_in = vmx_sched_in,
 
 	.cpu_dirty_log_size = PML_ENTITY_NUM,
@@ -8647,7 +8644,6 @@ static __init int hardware_setup(void)
 	if (!enable_preemption_timer) {
 		vmx_x86_ops.set_hv_timer = NULL;
 		vmx_x86_ops.cancel_hv_timer = NULL;
-		vmx_x86_ops.request_immediate_exit = __kvm_request_immediate_exit;
 	}
 
 	kvm_caps.supported_mce_cap |= MCG_LMCE_P;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index e3b0985bb74a..65786dbe7d60 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -332,8 +332,6 @@ struct vcpu_vmx {
 	unsigned int ple_window;
 	bool ple_window_dirty;
 
-	bool req_immediate_exit;
-
 	/* Support for PML */
 #define PML_ENTITY_NUM		512
 	struct page *pml_pg;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e4523ca3dedf..fb9f9029ccbf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10673,12 +10673,6 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	static_call_cond(kvm_x86_set_apic_access_page_addr)(vcpu);
 }
 
-void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
-{
-	smp_send_reschedule(vcpu->cpu);
-}
-EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
-
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -10928,10 +10922,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		goto cancel_injection;
 	}
 
-	if (req_immediate_exit) {
+	if (req_immediate_exit)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-		static_call(kvm_x86_request_immediate_exit)(vcpu);
-	}
 
 	fpregs_assert_state_consistent();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-- 
2.43.0.472.g3155946c3a-goog


