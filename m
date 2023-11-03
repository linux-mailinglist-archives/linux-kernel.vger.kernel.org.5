Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622AD7E0BF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjKCXF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjKCXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:05:50 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B982D6A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:05:48 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56f75e70190so1799557a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052747; x=1699657547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MBBm7FlqrdtgkBqnXXMbaJMJAl32htix/RXmITDIFAI=;
        b=gueaNZV7Vxljy9Q/ZB6efChaUm6uV0JEKE+GkSzYs0C+5Hb2jInuMrWqWStXtvCpsj
         FIV/nOkF+TaLyFtofsUQCUscJw5TWNJNazwdeKTjzT2uXcYc+MX3n3tEFjW7UjyLeDlz
         Ba8/sno1/y4NA59qibyaIZ+4UY8/vZYJarUESnE6yZqKgb2vf8hyojXbDWS6AHyWhC93
         LT/QK7GJu/AenrGm6vl7rj7+wTbnMpLxej/hVdg84XSyGDUmeGfFgJYzFj24pvf086VK
         lHwNygVS9lQhMIRSH7iRAJk1JVnweIZ0Ct6vhTW1LxUHGPH7mEESHAuQX4PP/BCMZCcU
         K91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052747; x=1699657547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBBm7FlqrdtgkBqnXXMbaJMJAl32htix/RXmITDIFAI=;
        b=Q9oRkGMZ6gPB2ceD6ncjXN0TFmbOXZhGAeRzt+lYK4DxnGQuXpyuLS4aitD+fQp7A0
         F9Su2LLPnXujL3tCD2cPGLaT95m6gvXIk4AfR/0wK6VKTRJ9c4h4Qb79qIR2QTHLBKhc
         kZ8aInBgMM6GoCxCw5wXi0f9zdrJCz1mg5BLz3S8PFbpIvg0txmqgsgGl2Lr2p6PtCno
         G3c02TJ1Z+LnsUYQc2KcCLFAaP9Lifa3mB8wMKYV5HXa2nG/hf4Sfpot5xLHwbE3Pclh
         IhtxgTtkUSa7dqXarqzrs/hn9oXC9UexeMhqSTDM5WsIN3ldl9HkoXmEJi70ZbxVvPVH
         8sVA==
X-Gm-Message-State: AOJu0YwPB4KaDnz3rP7yTt65Eq5otgmfiqb/Xna3UAeTfzXklySRzU2Z
        yvvGxusUQdStuzwPZwE9zBgBoYC9Ou0=
X-Google-Smtp-Source: AGHT+IFxtJq6aoqhiA8nBzG/BJYd7WTpHjuZTRpBVdCBHzeUugR2TSdZ06fuNypYZHlYf/ldSoVRa3HYNVE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:3303:b0:1cc:38e0:dbab with SMTP id
 jk3-20020a170903330300b001cc38e0dbabmr336922plb.3.1699052747477; Fri, 03 Nov
 2023 16:05:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 16:05:37 -0700
In-Reply-To: <20231103230541.352265-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231103230541.352265-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103230541.352265-3-seanjc@google.com>
Subject: [PATCH v2 2/6] KVM: x86/pmu: Reset the PMU, i.e. stop counters,
 before refreshing
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop all counters and release all perf events before refreshing the vPMU,
i.e. before reconfiguring the vPMU to respond to changes in the vCPU
model.

Clear need_cleanup in kvm_pmu_reset() as well so that KVM doesn't
prematurely stop counters, e.g. if KVM enters the guest and enables
counters before the vCPU is scheduled out.

Cc: stable@vger.kernel.org
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 027e9c3c2b93..dc8e8e907cfb 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -657,25 +657,14 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
-/* refresh PMU settings. This function generally is called when underlying
- * settings are changed (such as changes of PMU CPUID by guest VMs), which
- * should rarely happen.
- */
-void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
-{
-	if (KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm))
-		return;
-
-	bitmap_zero(vcpu_to_pmu(vcpu)->all_valid_pmc_idx, X86_PMC_IDX_MAX);
-	static_call(kvm_x86_pmu_refresh)(vcpu);
-}
-
 void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 	int i;
 
+	pmu->need_cleanup = false;
+
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 
 	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
@@ -695,6 +684,26 @@ void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	static_call_cond(kvm_x86_pmu_reset)(vcpu);
 }
 
+
+/*
+ * Refresh the PMU configuration for the vCPU, e.g. if userspace changes CPUID
+ * and/or PERF_CAPABILITIES.
+ */
+void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm))
+		return;
+
+	/*
+	 * Stop/release all existing counters/events before realizing the new
+	 * vPMU model.
+	 */
+	kvm_pmu_reset(vcpu);
+
+	bitmap_zero(vcpu_to_pmu(vcpu)->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	static_call(kvm_x86_pmu_refresh)(vcpu);
+}
+
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-- 
2.42.0.869.gea05f2083d-goog

