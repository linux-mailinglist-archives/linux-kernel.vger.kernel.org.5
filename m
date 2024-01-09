Return-Path: <linux-kernel+bounces-21497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9E9829077
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C891C2408F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BA4437C;
	Tue,  9 Jan 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pb0f6nxz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C040C11
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f8ffd9fb8aso34880897b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704841388; x=1705446188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6nByD1PFJyVRmLMcbHkCGLijfHuueVKWkXFPS4squYI=;
        b=Pb0f6nxztz8gyKLIkCtHdNPCUnL1xh+lNJWXKBaILzAjhH//DxrqPwC6SE0p/LYyAe
         043tGOqryZfZmnLOE0SbB+4A/gxhBR7yJKK+6TrvBuWRNpy82wCY1HsvK7xcLP2CEvaY
         V+vJ4HOT/dvBKxfjZZPBrauBW3yO5nVujInDUpSJO0T/n2hyWDzT4B5w5RulWOYHYjCX
         qCrJ9Jt0NXLlRjAUy3YC861mFS90KSjjOf+/EnRNG8WXXNx11Ek+Wsq6ILuSLAuIgv7f
         QTXtyrE5K34md9dx++iAwe96i34wJNp/u6H0t/tMzTqudjpQ7qRRVzU0lFwlU7Yeaoff
         PSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841388; x=1705446188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nByD1PFJyVRmLMcbHkCGLijfHuueVKWkXFPS4squYI=;
        b=gMccruDDH03Q2uX9sdUactdJVrDzOvldXdtqqPijhEkfjjwIXxsv42pj3CkypeF93O
         M+YA0ob35jYNOwfyGeK9cet3wPYfP8vAzyYoTyC7epB3jBl1dnMO2/W8ueVWW3bGsBFO
         NAoAimlp31pkXvjANlYJYyHdGuJR85ynJDnON7Vt4WRDtiY3Y82EuDTIa4nSShfogTSu
         nPHW01GZHLJgegSVpAMW2eYQhfZvquahNb0VXPMKCoIOThLNM+9BjRrP8uNUrExYI0Lo
         ZiEpskd4d/1vxFLJar5KJwCIcRrNKwQfd6eWD49GuHgqeYouJkNW6ezKpMMC3QTNvci6
         jXIg==
X-Gm-Message-State: AOJu0Yx7E/Brb0VyFWMD9aQt2NWADJLO3Ce0lGqLmMeQ7vQMDvpKk05M
	/vm0bi+zalFO5iergdR97R80T943jUz9WzU9kQ==
X-Google-Smtp-Source: AGHT+IGs5BTluRvZj25tkv+392CfqPhlzNslbYQSF2MI+h+ruiReZ2lBW13cbmMKl//tul/toTWevKH1DTE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c9b:b0:5f0:d791:c965 with SMTP id
 cm27-20020a05690c0c9b00b005f0d791c965mr122512ywb.3.1704841388652; Tue, 09 Jan
 2024 15:03:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 15:02:28 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109230250.424295-9-seanjc@google.com>
Subject: [PATCH v10 08/29] KVM: x86/pmu: Apply "fast" RDPMC only to Intel PMUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Move the handling of "fast" RDPMC instructions, which drop bits 63:32 of
the count, to Intel.  The "fast" flag, and all modifiers for that matter,
are Intel-only and aren't supported by AMD.

Opportunistically replace open coded bit crud with proper #defines, and
add comments to try and disentangle the flags vs. values mess for
non-architectural vs. architectural PMUs.

Fixes: ca724305a2b0 ("KVM: x86/vPMU: Implement AMD vPMU code for KVM")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           |  3 +--
 arch/x86/kvm/vmx/pmu_intel.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0b0d804ee239..09b0feb975c3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -576,10 +576,9 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
-	bool fast_mode = idx & (1u << 31);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
-	u64 mask = fast_mode ? ~0u : ~0ull;
+	u64 mask = ~0ull;
 
 	if (!pmu->version)
 		return 1;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1b1f888ad32b..03bd188b5754 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -20,6 +20,15 @@
 #include "nested.h"
 #include "pmu.h"
 
+/*
+ * Perf's "BASE" is wildly misleading, architectural PMUs use bits 31:16 of ECX
+ * to encode the "type" of counter to read, i.e. this is not a "base".  And to
+ * further confuse things, non-architectural PMUs use bit 31 as a flag for
+ * "fast" reads, whereas the "type" is an explicit value.
+ */
+#define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
+#define INTEL_RDPMC_FAST	BIT(31)
+
 #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
@@ -59,11 +68,14 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 					    unsigned int idx, u64 *mask)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	bool fixed = idx & (1u << 30);
+	bool fixed = idx & INTEL_RDPMC_FIXED;
 	struct kvm_pmc *counters;
 	unsigned int num_counters;
 
-	idx &= ~(3u << 30);
+	if (idx & INTEL_RDPMC_FAST)
+		*mask &= GENMASK_ULL(31, 0);
+
+	idx &= ~(INTEL_RDPMC_FIXED | INTEL_RDPMC_FAST);
 	if (fixed) {
 		counters = pmu->fixed_counters;
 		num_counters = pmu->nr_arch_fixed_counters;
-- 
2.43.0.472.g3155946c3a-goog


