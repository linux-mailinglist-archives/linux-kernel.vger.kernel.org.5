Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F337E4E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbjKHAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjKHAbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:31:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0510FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:31:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0631f977bso7543817276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403509; x=1700008309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V1aBnNwJk8GR2J7q9EpiLV4j0BFKjZECzb8pGjdIuF8=;
        b=ECT3kBiHnT47vcqj67ZBkiRtuPrdVkOyqQ106DWa87K1l4jHc0gkTbSPUxX+uTKuUy
         d49jrQn43VjO2WPVmPG6OPFDnDYIgso4YyWdB2uXZf7jvNycF6zoo2wOh2v7ncSWxv1f
         Y8SSrgh1Bda5SgWT12A1MiL8+ZcnS5LJBRHPank9r+0QC0zPbZuU/cJI4h7ZVHMdAs3x
         0TdiDnj89yglCsQi3qnyUjYuUxiSsXTmVswIt/4MBPUOwFnlcS8MUfkETRzFqXm/lSsG
         7zFOhW5aMfhsWYF28DdvpwyBoxwE19CTPCSKGxqt9njYqfHhhM+s+7ck0VDXr9lRwFDv
         qDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403509; x=1700008309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1aBnNwJk8GR2J7q9EpiLV4j0BFKjZECzb8pGjdIuF8=;
        b=iLvhD3+c04hd6QezQ76XkZuSN7b5pO8iDp8B5fBNDg5Yh0rBok+JlezJMDVlFP7OIM
         Or2k+wa/fk0R4HY08NlzszHh47NRfUV8hjRDwGMR2iOsVH/IG4samvhKO/Jf9BKGF1ri
         6TyFj3k3x26CZGUQrs9k+wbtcxUPAI+e6+Fv2zoP6ykSsMqXoJKL4CJh0V+LO1C/pAMY
         jJ1Z/MmqAgjx5zf9xV/eoVwHUyKGWxtGGETQE47y3Sbgik0SGU/ZnBUyxwXhlFOrkVDS
         xE/fpGD03YkN82OMgrgAQATMLhcaMsVH4wgWUszUZJ8dTXmuGgj6QToIBCUdtpS9fDvg
         X2gw==
X-Gm-Message-State: AOJu0YyhWEyQLesnVuKji/6yyLcLGdB9Zark2xJ4t7G0rJzYY1NiEnqs
        V43y4Gol03Cf4t0xInlrxdSRiHBqzxo=
X-Google-Smtp-Source: AGHT+IFpFgpdesozaHjv4FfzuGZeZNvtK0EvXpVTarcXHPdSNJKE60f2aVyuBNbz+rubfLmfL0hDmRfgB9s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e04f:0:b0:d9b:e3f6:c8c6 with SMTP id
 x76-20020a25e04f000000b00d9be3f6c8c6mr5638ybg.4.1699403509176; Tue, 07 Nov
 2023 16:31:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:21 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-6-seanjc@google.com>
Subject: [PATCH v7 05/19] KVM: selftests: Add vcpu_set_cpuid_property() to set properties
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

From: Jinrong Liang <cloudliang@tencent.com>

Add vcpu_set_cpuid_property() helper function for setting properties, and
use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future vPMU
testcases will also need to stuff various CPUID properties.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h      |  4 +++-
 .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++++++++---
 .../x86_64/smaller_maxphyaddr_emulation_test.c    |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 25bc61dac5fb..a01931f7d954 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -994,7 +994,9 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr);
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value);
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
 void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d8288374078e..67eb82a6c754 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -752,12 +752,21 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid)
 	vcpu_set_cpuid(vcpu);
 }
 
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr)
+void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
+			     struct kvm_x86_cpu_property property,
+			     uint32_t value)
 {
-	struct kvm_cpuid_entry2 *entry = vcpu_get_cpuid_entry(vcpu, 0x80000008);
+	struct kvm_cpuid_entry2 *entry;
+
+	entry = __vcpu_get_cpuid_entry(vcpu, property.function, property.index);
+
+	(&entry->eax)[property.reg] &= ~GENMASK(property.hi_bit, property.lo_bit);
+	(&entry->eax)[property.reg] |= value << property.lo_bit;
 
-	entry->eax = (entry->eax & ~0xff) | maxphyaddr;
 	vcpu_set_cpuid(vcpu);
+
+	/* Sanity check that @value doesn't exceed the bounds in any way. */
+	TEST_ASSERT_EQ(kvm_cpuid_property(vcpu->cpuid, property), value);
 }
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function)
diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
index 06edf00a97d6..9b89440dff19 100644
--- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
@@ -63,7 +63,7 @@ int main(int argc, char *argv[])
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
 
-	vcpu_set_cpuid_maxphyaddr(vcpu, MAXPHYADDR);
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_MAX_PHY_ADDR, MAXPHYADDR);
 
 	rc = kvm_check_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE);
 	TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable");
-- 
2.42.0.869.gea05f2083d-goog

