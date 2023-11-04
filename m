Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30C57E0C94
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjKDADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjKDACv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:51 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F2D49
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc281f1214so20509305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056168; x=1699660968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qddZI5QlDYzkDDGMWXMNXP2vKdkDVMrPtOHGx6AbiEs=;
        b=byDXblP4cNIdEpE/d9r52ueFTlhR93MmVW7ZYBxtIjeNwlSRrs/pWCiS6ZL0gXgZeC
         3+WyIjyee77RjBGJ5ws1LLp5hjyUWc15DqrMbDOIa4RL04oCeUauUZy1Q3JdHzRVInca
         jSlOJoygzuKi1+49VvB9fCCGjAKag1Y36mOSJqkz7njdd7U2P870wDCklI6pbd4KUjDN
         gFTc7XvR5AhSJGEqIPzn/qrGpbl/ViKg+AQ2RGpQgApggXo//rtIm5UZQ+V3tX1RG0Hy
         rldEN/EWdeJIMPtt2dUvZk86tjo8RNfqauEYpbm+yNS9l/Hdhsq3bz2MAcI6RM4MleIw
         g8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056168; x=1699660968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qddZI5QlDYzkDDGMWXMNXP2vKdkDVMrPtOHGx6AbiEs=;
        b=RtGM5sfw2i49Y8OSFUHl2qTa4vgFXI2g9D1L8F0Ywq0qd7FfTEhaT0wetvi1LqTTMF
         XI8koKhxYo/f9oqYm372v4c32vWRYXhGJFQILFR4txtMzHvlnuFJ2LsK7VppQQloLEnG
         4HCKWGeTUaUvp3VyiAPyjLGQHKd1HIDRRHM7c8+H5P2tHVw+dG2zqUxXUY7KBDcfCBjb
         dgJ1IvIjSnGkfwb+NS3eQKwN7nLrq74Ji8YLcwOKIrdJS82z6EWTDemzYaZuXd/3ndpe
         kQqyT/YXiMqw3dsdGUJXn6JeQu+ONwuAKAyduGYze09ty3lN/41M58s1rM5keQCyLKp+
         iLSw==
X-Gm-Message-State: AOJu0Yxso9NSV1l4lQwB4nQaypVfvZlTHQO1B2Vk9MZYjnjjPpPg5El/
        6PpkS5dWJjqFBDDW/BH3GnYjbOJnG0k=
X-Google-Smtp-Source: AGHT+IGx/PwxlYpOuRKdZYbE5Hej8a6OBTDWyR7ILfdU8v4Jzm6thIWMKr1A2kcm/hqxX7sahHWFkfGx6ug=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ab84:b0:1c9:b045:5a8b with SMTP id
 f4-20020a170902ab8400b001c9b0455a8bmr372275plr.6.1699056168312; Fri, 03 Nov
 2023 17:02:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:22 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-5-seanjc@google.com>
Subject: [PATCH v6 04/20] KVM: x86/pmu: Always treat Fixed counters as
 available when supported
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that KVM hides fixed counters that can't be virtualized, treat fixed
counters as available when they are supported, i.e. don't silently ignore
an enabled fixed counter just because guest CPUID says the associated
general purpose architectural event is unavailable.

KVM originally treated fixed counters as always available, but that got
changed as part of a fix to avoid confusing REF_CPU_CYCLES, which does NOT
map to an architectural event, with the actual architectural event used
associated with bit 7, TOPDOWN_SLOTS.

The commit justified the change with:

    If the event is marked as unavailable in the Intel guest CPUID
    0AH.EBX leaf, we need to avoid any perf_event creation, whether
    it's a gp or fixed counter.

but that justification doesn't mesh with reality.  The Intel SDM uses
"architectural events" to refer to both general purpose events (the ones
with the reverse polarity mask in CPUID.0xA.EBX) and the events for fixed
counters, e.g. the SDM makes statements like:

  Each of the fixed-function PMC can count only one architectural
  performance event.

but the fact that fixed counter 2 (TSC reference cycles) doesn't have an
associated general purpose architectural makes trying to apply the mask
from CPUID.0xA.EBX impossible.  Furthermore, the SDM never explicitly
says that an architectural events that's marked unavailable in EBX affects
the fixed counters.

Note, at the time of the change, KVM didn't enforce hardware support, i.e.
didn't prevent userspace from enumerating support in guest CPUID.0xA.EBX
for architectural events that aren't supported in hardware.  I.e. silently
dropping the fixed counter didn't somehow protection against counting the
wrong event, it just enforced guest CPUID.

Arguably, userspace is creating a bogus vCPU model by advertising a fixed
counter but saying the associated general purpose architectural event is
unavailable.  But regardless of the validity of the vCPU model, letting
the guest enable a fixed counter and then not actually having it count
anything is completely nonsensical.  I.e. even if all of the above is
wrong and it's illegal for a fixed counter to exist when the architectural
event is unavailable, silently doing nothing is still the wrong behavior
and KVM should instead disallow enabling the fixed counter in the first
place.

Fixes: a21864486f7e ("KVM: x86/pmu: Fix available_event_types check for REF_CPU_CYCLES event")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 8d545f84dc4a..b239e7dbdc9b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -147,11 +147,24 @@ static bool intel_hw_event_available(struct kvm_pmc *pmc)
 	u8 unit_mask = (pmc->eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >> 8;
 	int i;
 
+	/*
+	 * Fixed counters are always available if KVM reaches this point.  If a
+	 * fixed counter is unsupported in hardware or guest CPUID, KVM doesn't
+	 * allow the counter's corresponding MSR to be written.  KVM does use
+	 * architectural events to program fixed counters, as the interface to
+	 * perf doesn't allow requesting a specific fixed counter, e.g. perf
+	 * may (sadly) back a guest fixed PMC with a general purposed counter.
+	 * But if _hardware_ doesn't support the associated event, KVM simply
+	 * doesn't enumerate support for the fixed counter.
+	 */
+	if (pmc_is_fixed(pmc))
+		return true;
+
 	BUILD_BUG_ON(ARRAY_SIZE(intel_arch_events) != NR_INTEL_ARCH_EVENTS);
 
 	/*
 	 * Disallow events reported as unavailable in guest CPUID.  Note, this
-	 * doesn't apply to pseudo-architectural events.
+	 * doesn't apply to pseudo-architectural events (see above).
 	 */
 	for (i = 0; i < NR_REAL_INTEL_ARCH_EVENTS; i++) {
 		if (intel_arch_events[i].eventsel != event_select ||
-- 
2.42.0.869.gea05f2083d-goog

