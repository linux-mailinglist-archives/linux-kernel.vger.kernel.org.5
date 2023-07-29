Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD0767AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjG2BS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjG2BRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:17:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0849F2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:17:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1bcb99b518so2503001276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690593403; x=1691198203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RivGO1zReamo45LkTKZurMbG/2NW5Na6scf+1QseqDY=;
        b=hIQtvbpt0HUSaqF39Lk9Xfa9TrQTmVjU7RALdaw1fEsbZtAiuObGnFR0Gku+I64fsr
         EVrNvlR/IQ3tigJBye53R3SEyQq9ap5sEjRS/w2ib/Nbaz6ND/a27qXUH/r81czS+i95
         +4M/PpgfVpbnHAK78VBIkHZWNOg/uMCvRhbsbRb5Hz+3PclOkZWQ3b+JNlm+EY4AMFDN
         20KHnMdzEj16XfUGCUjYSYQTHQI7CuKSHt/AuA1oUQSVbnuRFX7uwRCDJlxDMZO7lCzE
         2180eCxVHw5kgi3tfuffiJsVwm2w8dHM1viduqd8KLxmLQDiaS63Vsh1giEXn7bIp+Nv
         Jtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593403; x=1691198203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RivGO1zReamo45LkTKZurMbG/2NW5Na6scf+1QseqDY=;
        b=M3v4jlEiEsD0zGN1vM8KG5d42ZZ4N/FuuSYJLYrYA9cF8IbIylT8PQ6Hi2Z0pJsqkp
         mdDjaEvkK78Mctv+vrVkYsGMHp4V5+AR8BvkZqqZRloYqw3bCXkXDIwPDX9W4dFp9B4T
         R1z/IIbvFqlzT0QKWtGxObGE1dP1zlOJVakB3kXXClTKdpOILcQhgEr351s04zsR5eXQ
         BQVbW612m2gPneZcCmM+47UyF0ls//8Qxj2Q1eVOYxOOlRrV3l3pFvzwCUZlf3xSObRq
         PyydPwqT3ybj2RWPUzcaYKY7BNGzF5xO7i7cMEOuIQyUYQxcpUA9DmEj+UT+vux5IoLm
         YVeA==
X-Gm-Message-State: ABy/qLYt/ec3n+3ILlar3IaH3YgoNu0mBbTCc1zCiwFIaVv0uXAr4FfV
        Gt5Uh2rmSFkb0P+u20Z0Y7Z598Uj2NU=
X-Google-Smtp-Source: APBJJlFzrRMu/FipBCWOALymzRtbc31rIKvodpA1k0Hng04DLRC6eCO5Q8u++IKFWaiaXRNNRrLr5Q/WTcQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2d1a:0:b0:d0c:77a8:1f6b with SMTP id
 t26-20020a252d1a000000b00d0c77a81f6bmr20040ybt.10.1690593403726; Fri, 28 Jul
 2023 18:16:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:16:03 -0700
In-Reply-To: <20230729011608.1065019-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729011608.1065019-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729011608.1065019-17-seanjc@google.com>
Subject: [PATCH v2 16/21] KVM: nSVM: Use KVM-governed feature framework to
 track "vVM{SAVE,LOAD} enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track "virtual VMSAVE/VMLOAD exposed to L1" via a governed feature flag
instead of using a dedicated bit/flag in vcpu_svm.

Opportunistically add a comment explaining why KVM disallows virtual
VMLOAD/VMSAVE when the vCPU model is Intel.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/svm/nested.c        |  2 +-
 arch/x86/kvm/svm/svm.c           | 10 +++++++---
 arch/x86/kvm/svm/svm.h           |  1 -
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index 32c0469cf952..f01a95fd0071 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -10,6 +10,7 @@ KVM_GOVERNED_X86_FEATURE(XSAVES)
 KVM_GOVERNED_X86_FEATURE(VMX)
 KVM_GOVERNED_X86_FEATURE(NRIPS)
 KVM_GOVERNED_X86_FEATURE(TSCRATEMSR)
+KVM_GOVERNED_X86_FEATURE(V_VMSAVE_VMLOAD)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index da65948064dc..24d47ebeb0e0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -107,7 +107,7 @@ static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
 {
-	if (!svm->v_vmload_vmsave_enabled)
+	if (!guest_can_use(&svm->vcpu, X86_FEATURE_V_VMSAVE_VMLOAD))
 		return true;
 
 	if (!nested_npt_enabled(svm))
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2f7f7df5a591..39a69c1786ea 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1154,8 +1154,6 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 0, 0);
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 0, 0);
-
-		svm->v_vmload_vmsave_enabled = false;
 	} else {
 		/*
 		 * If hardware supports Virtual VMLOAD VMSAVE then enable it
@@ -4226,7 +4224,13 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	svm->lbrv_enabled = lbrv && guest_cpuid_has(vcpu, X86_FEATURE_LBRV);
 
-	svm->v_vmload_vmsave_enabled = vls && guest_cpuid_has(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+	/*
+	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
+	 * VMLOAD drops bits 63:32 of SYSENTER (ignoring the fact that exposing
+	 * SVM on Intel is bonkers and extremely unlikely to work).
+	 */
+	if (!guest_cpuid_is_intel(vcpu))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
 	svm->pause_filter_enabled = kvm_cpu_cap_has(X86_FEATURE_PAUSEFILTER) &&
 			guest_cpuid_has(vcpu, X86_FEATURE_PAUSEFILTER);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4e7332f77702..b475241df6dc 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -259,7 +259,6 @@ struct vcpu_svm {
 	bool soft_int_injected;
 
 	/* optional nested SVM features that are enabled for this guest  */
-	bool v_vmload_vmsave_enabled      : 1;
 	bool lbrv_enabled                 : 1;
 	bool pause_filter_enabled         : 1;
 	bool pause_threshold_enabled      : 1;
-- 
2.41.0.487.g6d72f3e995-goog

