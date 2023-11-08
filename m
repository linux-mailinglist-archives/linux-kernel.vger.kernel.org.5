Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2805A7E4E09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjKHAb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjKHAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:31:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A93170F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:31:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc3130ba31so45055935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403507; x=1700008307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eOsNu1hfSZJra6BKusRtLnJPQ4S9SkH0BAaz2rzZCWg=;
        b=NoyOZ8tvKa10YQU8dxWgfxeaZ6ZN0SBerdImfyGt1C62VfoeysYKNCHcxeLufylL6d
         fsgmtPub5D1mt4DtTyfJR7Wqy5CzpdKPXEs5yYy+HKAaMCm/bsPEJ4THn4XgLl94RNP4
         33qDzj0cCAZWBrQD5diUAFVY7dsFaXYjEh6Pu46zhVM8EQQGsg5SomdBA47jfuGvq2xj
         4pHr8/j2HJCu+e90jD7z9wEXzwbJ1vwFbGKPAawDdJrBISMPnuSBzY4iC+5MKY6bJYVF
         EJF+jmbQQVgNccCAjeIhmON3YCHMFxfrEZiOVNI3lyHbs14gk+5UGCTUIEOdNo6b3OQy
         fCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403507; x=1700008307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOsNu1hfSZJra6BKusRtLnJPQ4S9SkH0BAaz2rzZCWg=;
        b=ZZ9HXB5QKql+KeyoyGWLB54bNIGPoOpto6i05RIXBov9urVuR0ExQCOTl1zoTaCSHZ
         01lCTsvQY/IXxW6EQSa5MNBHSMeJJYQ+cUU54cFmDdf9o9j42Z4xD5W9J8T3w5MIfhXe
         XT9SkNAd3gESyrVLhcqIyYDRcqPGkzlCrbllUb8S8koKmvl4cuf8aDvOBPIKkVLnQiTa
         /pO2Hg/Mn9fiwWulRVZP7U5C4kpihfsd2s/M5+kgVRBnLexTTx6PM6zbTWmduZCIloS1
         8dk/4gVBBN6UYm5zty9m7BgmNAMi4ZMmuBaYibLq/KDJUEnDsN+7GpFfRj4Lp6MDJnWy
         Kf0w==
X-Gm-Message-State: AOJu0Yz/B+2MGXHNSqY9PWVJ2V3Ue0LLRpt0lh7OIMhHOzB8I9BE0WV4
        PfldaGjfgS3kbDQCnjmThZaRvYAsdfM=
X-Google-Smtp-Source: AGHT+IFucPzlJqg7tHjMuPAfTTVqnx8AOWjcGJMPuJs/O5C3yihzxvcXC3aNBY+ndlc9GvpWGX8R4usyxo4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6b06:b0:1cc:2f2a:7d33 with SMTP id
 o6-20020a1709026b0600b001cc2f2a7d33mr10169plk.2.1699403507489; Tue, 07 Nov
 2023 16:31:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:20 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-5-seanjc@google.com>
Subject: [PATCH v7 04/19] KVM: x86/pmu: Setup fixed counters' eventsel during
 PMU initialization
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the eventsel for all fixed counters during PMU initialization, the
eventsel is hardcoded and consumed if and only if the counter is supported,
i.e. there is no reason to redo the setup every time the PMU is refreshed.

Configuring all KVM-supported fixed counter also eliminates a potential
pitfall if/when KVM supports discontiguous fixed counters, in which case
configuring only nr_arch_fixed_counters will be insufficient (ignoring the
fact that KVM will need many other changes to support discontiguous fixed
counters).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index c4f2c6a268e7..5fc5a62af428 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -409,7 +409,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  * Note, reference cycles is counted using a perf-defined "psuedo-encoding",
  * as there is no architectural general purpose encoding for reference cycles.
  */
-static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
+static u64 intel_get_fixed_pmc_eventsel(int index)
 {
 	const struct {
 		u8 eventsel;
@@ -419,17 +419,11 @@ static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
 		[1] = { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_CYCLES. */
 		[2] = { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_HW_REF_CPU_CYCLES*/
 	};
-	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) != KVM_PMC_MAX_FIXED);
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
-		int index = array_index_nospec(i, KVM_PMC_MAX_FIXED);
-		struct kvm_pmc *pmc = &pmu->fixed_counters[index];
-
-		pmc->eventsel = (fixed_pmc_events[index].unit_mask << 8) |
-				 fixed_pmc_events[index].eventsel;
-	}
+	return (fixed_pmc_events[index].unit_mask << 8) |
+		fixed_pmc_events[index].eventsel;
 }
 
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
@@ -495,7 +489,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						  kvm_pmu_cap.bit_width_fixed);
 		pmu->counter_bitmask[KVM_PMC_FIXED] =
 			((u64)1 << edx.split.bit_width_fixed) - 1;
-		setup_fixed_pmc_eventsel(pmu);
 	}
 
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
@@ -573,6 +566,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].vcpu = vcpu;
 		pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
 		pmu->fixed_counters[i].current_config = 0;
+		pmu->fixed_counters[i].eventsel = intel_get_fixed_pmc_eventsel(i);
 	}
 
 	lbr_desc->records.nr = 0;
-- 
2.42.0.869.gea05f2083d-goog

