Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6753D8018A2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441998AbjLBAG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441975AbjLBAFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB3619B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db54c11887aso1444180276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475509; x=1702080309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dE/522iynIE4No5Iky1Auot8voCpOZvCwqs6OijcFys=;
        b=gUCaig798b2RVDgyEyXiYgLs1E3CAK9mlVmTJNs0xCeZ74lV3VljYbS5J6fb8uq62g
         cJpVQJjLoQnO5MZo+IRm2atdMJ49upR4EJck2UjQcN4tEl05NdT9zSTM25QgvUBkmGpM
         GtB2KcDfgp55jhs529nx7HGCeKPo4x5Z55fkL80EYdlGLKWih7n61NXAe9gq7LECoZya
         VhS4V/9N+d5kAS43kIn4HvX85MShforiZE7H/xz0rEq7pIG3Ir1Sxw1LE+HC12b9WdMC
         KdPJcitZgzjXUzRA/qUEiAYdBAEI66PwPKgJWw4ZWSRGyKlY5VLR41QdJbqHSAYAFoAL
         l93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475509; x=1702080309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE/522iynIE4No5Iky1Auot8voCpOZvCwqs6OijcFys=;
        b=g0FRMyKs1gzICG/tzjpUFUbSzxyH6J9CFLOk1n/5t5lnB6+7gGGFP/vAMNovW1WNDo
         TFu5CMj1xRc9SRIIYPPXXYJjjnBjbNqbBGk7f39hyr4ROlA05E7bZSEMxfRMtsWebtqe
         gwDeK9Vw5fzIZkJO2cDGRaH9O1MLgmb7cMaH7PC3YghrWMpMZ2hqEMQEtpegIkh/FYEO
         oZSZWhrMTvQKUoDP6NvEspOo2xlQI0Pz9xCaQwGbzL+UrcAEe10M3YN7hAVmJtjZEMph
         nJ90uTSRFoFDQZf5NL0bSj3U1PcHauyNvLTNoNTfsyuHlfwEzIx7FPhxIpHh3urDLrSw
         8CqA==
X-Gm-Message-State: AOJu0YwsPyQFEXFVRG47fm/0Klb3zrD14OwJiSS4E6Y3A3ErcHzx1z/i
        jBxFOApw+/mmNWmZH0FqEaBJYLVsbIc=
X-Google-Smtp-Source: AGHT+IGlIng6BwRF2Ib3Bd7XWFs1/N2/Y9k1s9wvye+szu8Qcu7oeqH3xFQjJCrkRw6d7XQv5u2LZiutEeY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d450:0:b0:db5:47c1:e82d with SMTP id
 m77-20020a25d450000000b00db547c1e82dmr182419ybf.6.1701475508883; Fri, 01 Dec
 2023 16:05:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:14 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-26-seanjc@google.com>
Subject: [PATCH v9 25/28] KVM: selftests: Test PMC virtualization with forced emulation
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

Extend the PMC counters test to use forced emulation to verify that KVM
emulates counter events for instructions retired and branches retired.
Force emulation for only a subset of the measured code to test that KVM
does the right thing when mixing perf events with emulated events.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 9e9dc4084c0d..cb808ac827ba 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -21,6 +21,7 @@
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
+static bool is_forced_emulation_enabled;
 
 static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 						  void *guest_code,
@@ -34,6 +35,7 @@ static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 	vcpu_init_descriptor_tables(*vcpu);
 
 	sync_global_to_guest(vm, kvm_pmu_version);
+	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
 	/*
 	 * Set PERF_CAPABILITIES before PMU version as KVM disallows enabling
@@ -138,37 +140,50 @@ static void guest_assert_event_count(uint8_t idx,
  * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
  * start of the loop to force LLC references and misses, i.e. to allow testing
  * that those events actually count.
+ *
+ * If forced emulation is enabled (and specified), force emulation on a subset
+ * of the measured code to verify that KVM correctly emulates instructions and
+ * branches retired events in conjunction with hardware also counting said
+ * events.
  */
-#define GUEST_MEASURE_EVENT(_msr, _value, clflush)				\
+#define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
 do {										\
 	__asm__ __volatile__("wrmsr\n\t"					\
 			     clflush "\n\t"					\
 			     "mfence\n\t"					\
 			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
-			     "loop .\n\t"					\
-			     "mov %%edi, %%ecx\n\t"				\
-			     "xor %%eax, %%eax\n\t"				\
-			     "xor %%edx, %%edx\n\t"				\
+			     FEP "loop .\n\t"					\
+			     FEP "mov %%edi, %%ecx\n\t"				\
+			     FEP "xor %%eax, %%eax\n\t"				\
+			     FEP "xor %%edx, %%edx\n\t"				\
 			     "wrmsr\n\t"					\
 			     :: "a"((uint32_t)_value), "d"(_value >> 32),	\
 				"c"(_msr), "D"(_msr)				\
 	);									\
 } while (0)
 
+#define GUEST_TEST_EVENT(_idx, _event, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
+do {										\
+	wrmsr(pmc_msr, 0);							\
+										\
+	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt 1f", FEP);	\
+	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush 1f", FEP);	\
+	else									\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
+										\
+	guest_assert_event_count(_idx, _event, _pmc, _pmc_msr);			\
+} while (0)
+
 static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature event,
 				    uint32_t pmc, uint32_t pmc_msr,
 				    uint32_t ctrl_msr, uint64_t ctrl_msr_value)
 {
-	wrmsr(pmc_msr, 0);
+	GUEST_TEST_EVENT(idx, event, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, "");
 
-	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))
-		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflushopt 1f");
-	else if (this_cpu_has(X86_FEATURE_CLFLUSH))
-		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflush 1f");
-	else
-		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "nop");
-
-	guest_assert_event_count(idx, event, pmc, pmc_msr);
+	if (is_forced_emulation_enabled)
+		GUEST_TEST_EVENT(idx, event, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, KVM_FEP);
 }
 
 #define X86_PMU_FEATURE_NULL						\
@@ -553,6 +568,7 @@ int main(int argc, char *argv[])
 
 	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	test_intel_counters();
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

