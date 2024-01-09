Return-Path: <linux-kernel+bounces-21510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE0829098
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D3C1C24BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F64A9BC;
	Tue,  9 Jan 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw3Gr6h5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CB495EB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cde2b113e7so1217883a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704841414; x=1705446214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xaOHR9B/i9PUufPdoG9YEGW+GjjakEAYkB6Tb38apR0=;
        b=Mw3Gr6h5kL2KWYFwpjiThB470QC1nxaSMPnufjktRX/3bGMih2JjLFW1LWt41Ua2oT
         vaCxqGv4MfhfY7WDSRJvO8PC4RKCXX4lCFP4IQ+FWOrqxBU6BiGfhJQgCNgxZ1aLXPJ9
         ZF1X5LNnBjWMjBVJiXuC+faZe2jkkha8OUrNyhNQfH8PKCTc557ct6t/tKYQkMH18Uqa
         Wi/D8fakcLFDnNuX+ez4LxebU771ov6gs0QOfoVljUUWlxSmKt4YhyfpbApiRAGZsnM0
         6GA5e89FUcG58JpZivOr0yF4KwcWsg7HQPdq6WP4qX4c/557PBCEnplKaKBcWNDRcSCn
         NSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841414; x=1705446214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaOHR9B/i9PUufPdoG9YEGW+GjjakEAYkB6Tb38apR0=;
        b=HfA4JzOeC3fi3PbN7kxIPCccvRMJBX5cmGxkFw87o5KI5i4JIo8BZWDKFoc6ln0fqb
         ghbT9HYpD0e5kM7UZx7nC9xX4PXj+vFvab9y+Zfnrku8W4p+qcoOtcZxKGsJiF2ywALH
         EqzKzOuQz5Ak32IAplQJ8sxFCZK+4QG10eTPDbtLJgNQqYh4kWUb3CCBgmqxLDI21rZ4
         WnemoBJ/1P3lyVF5Qsx+xS3XV+p2axr7mjpe5z3oBFjkky6WAi7iqVfcrZl7Zs3z4pjK
         joHkLj397i4QHxdYQifdwFWWGNc6xEwLvzKnMyYlDzfc5B8qdQGHQSTiu3Q79vdxX5xD
         Ls+Q==
X-Gm-Message-State: AOJu0Yw/lqUdNzjjxZVlVpNacPFRr4lp0REBGGhCKHMQXIEtqjUUPKYC
	zaksNvrliFg8doc7COFxwf/7AdTDgYLjqhfg2Q==
X-Google-Smtp-Source: AGHT+IF9QwgswU6o0HVTB+TbwQMRDPCvyeVRdapwlQ5XkLv17/EocgeLhU1c4E+ngEN5RAJDs2jaVnzwvjY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6a4a:0:b0:5ce:98f:4492 with SMTP id
 o10-20020a656a4a000000b005ce098f4492mr202pgu.6.1704841414611; Tue, 09 Jan
 2024 15:03:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 15:02:41 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109230250.424295-22-seanjc@google.com>
Subject: [PATCH v10 21/29] KVM: selftests: Expand PMU counters test to verify
 LLC events
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Expand the PMU counters test to verify that LLC references and misses have
non-zero counts when the code being executed while the LLC event(s) is
active is evicted via CFLUSH{,OPT}.  Note, CLFLUSH{,OPT} requires a fence
of some kind to ensure the cache lines are flushed before execution
continues.  Use MFENCE for simplicity (performance is not a concern).

Suggested-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 59 +++++++++++++------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index f5dedd112471..4c7133ddcda8 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -14,9 +14,9 @@
 /*
  * Number of "extra" instructions that will be counted, i.e. the number of
  * instructions that are needed to set up the loop and then disabled the
- * counter.  2 MOV, 2 XOR, 1 WRMSR.
+ * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
  */
-#define NUM_EXTRA_INSNS		5
+#define NUM_EXTRA_INSNS		7
 #define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
 
 static uint8_t kvm_pmu_version;
@@ -107,6 +107,12 @@ static void guest_assert_event_count(uint8_t idx,
 	case INTEL_ARCH_BRANCHES_RETIRED_INDEX:
 		GUEST_ASSERT_EQ(count, NUM_BRANCHES);
 		break;
+	case INTEL_ARCH_LLC_REFERENCES_INDEX:
+	case INTEL_ARCH_LLC_MISSES_INDEX:
+		if (!this_cpu_has(X86_FEATURE_CLFLUSHOPT) &&
+		    !this_cpu_has(X86_FEATURE_CLFLUSH))
+			break;
+		fallthrough;
 	case INTEL_ARCH_CPU_CYCLES_INDEX:
 	case INTEL_ARCH_REFERENCE_CYCLES_INDEX:
 		GUEST_ASSERT_NE(count, 0);
@@ -123,29 +129,44 @@ static void guest_assert_event_count(uint8_t idx,
 	GUEST_ASSERT_EQ(_rdpmc(pmc), 0xdead);
 }
 
+/*
+ * Enable and disable the PMC in a monolithic asm blob to ensure that the
+ * compiler can't insert _any_ code into the measured sequence.  Note, ECX
+ * doesn't need to be clobbered as the input value, @pmc_msr, is restored
+ * before the end of the sequence.
+ *
+ * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
+ * start of the loop to force LLC references and misses, i.e. to allow testing
+ * that those events actually count.
+ */
+#define GUEST_MEASURE_EVENT(_msr, _value, clflush)				\
+do {										\
+	__asm__ __volatile__("wrmsr\n\t"					\
+			     clflush "\n\t"					\
+			     "mfence\n\t"					\
+			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
+			     "loop .\n\t"					\
+			     "mov %%edi, %%ecx\n\t"				\
+			     "xor %%eax, %%eax\n\t"				\
+			     "xor %%edx, %%edx\n\t"				\
+			     "wrmsr\n\t"					\
+			     :: "a"((uint32_t)_value), "d"(_value >> 32),	\
+				"c"(_msr), "D"(_msr)				\
+	);									\
+} while (0)
+
 static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature event,
 				    uint32_t pmc, uint32_t pmc_msr,
 				    uint32_t ctrl_msr, uint64_t ctrl_msr_value)
 {
 	wrmsr(pmc_msr, 0);
 
-	/*
-	 * Enable and disable the PMC in a monolithic asm blob to ensure that
-	 * the compiler can't insert _any_ code into the measured sequence.
-	 * Note, ECX doesn't need to be clobbered as the input value, @pmc_msr,
-	 * is restored before the end of the sequence.
-	 */
-	__asm__ __volatile__("wrmsr\n\t"
-			     "mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"
-			     "loop .\n\t"
-			     "mov %%edi, %%ecx\n\t"
-			     "xor %%eax, %%eax\n\t"
-			     "xor %%edx, %%edx\n\t"
-			     "wrmsr\n\t"
-			     :: "a"((uint32_t)ctrl_msr_value),
-				"d"(ctrl_msr_value >> 32),
-				"c"(ctrl_msr), "D"(ctrl_msr)
-			     );
+	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))
+		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflushopt 1f");
+	else if (this_cpu_has(X86_FEATURE_CLFLUSH))
+		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflush 1f");
+	else
+		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "nop");
 
 	guest_assert_event_count(idx, event, pmc, pmc_msr);
 }
-- 
2.43.0.472.g3155946c3a-goog


