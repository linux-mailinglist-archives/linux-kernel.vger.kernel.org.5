Return-Path: <linux-kernel+bounces-94818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA825874592
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27425B225F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429A6AB6;
	Thu,  7 Mar 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rx+W4kyP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E424A1E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774031; cv=none; b=jnuZIdG+BdGZ1m4biUGFwAflXC5eACXBjLQRXA6HG4u6WGTpjPeMcbZg6eqLhEHE1k1Iljnk3wophB/CqAM3wNgMgtGiz72kLvWbK8pgmzS1o7iLEKA4Pnp4WfauH5PULLjVr2rsZ9dH+xnnPvBAF856O0fjxzh97roeEj4dbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774031; c=relaxed/simple;
	bh=AVNvdObNYsvBPRRwBeScCDec7JNA2zRkhx+8VadcPaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxWKhWH/e5Cdz/CIZlz76K2xO/NvY383rVRU7r5uW8uDSXByBdWjq7Yw4xuqk7bUGBSWibYyXH1mfkINwLiyZnlMXr1h0x+EmiZ7fHw7fZIRXWmNlKaBmGUPI9vLgzolso+zcVpc05SoHdDAbBpev4anheuJ1mNsveyWbSkXFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rx+W4kyP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso6158017b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709774029; x=1710378829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=d9OkLWkUpGFKgtUTAFhUfP4KpjC4oBcPSpydtAFPWEY=;
        b=Rx+W4kyP8nbTCsQFCieZSroaLaXIGarCskUht94vg6kNKpZTE+W+gFdluMIxNo5XaT
         5EXK1AlfSWXqb0AqX41Lrq9iP/hnN9/c8HaizZWKakq8wXiiJVnD5lWBbrfBnIxJXORG
         Qi8rSuWXg5CgxuS2WZIQ78iGiVoaj2Fv0AuIlUfFtaRI3ft2Z+oVOBdNIcJIEIFr+AAj
         gB3lnLq9v6CEPd7EyNdCK1Fe49LCSM6wulwMLwT4s45hupv+goeRNXJPSPOm4d7vtMEb
         4HTCwipQBfw+P+2l+vYwxnEa/Zlw3g6UdZ24y1T0/cP/yYp5UczMfyG5QXZ1n+d/26lx
         ad5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774029; x=1710378829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9OkLWkUpGFKgtUTAFhUfP4KpjC4oBcPSpydtAFPWEY=;
        b=ZjLh+Dord9F9IYeuKzVlXfve4cgu+XUeVf9JTh631SBXxiNvp7MOD+pY/4KlYJS0JJ
         +xztw7mbgbbocZAeu3WNJhwOG4mIdU7+Hbn9wInrjSsYYTVOi35t9X5LyH0yaXVtDb7R
         uOGqUqRYFYoBLv+bkXl4mtzmNYyrGuyCLx9228ETt7pW3V0DTX3QDc4tActptlrsbz0j
         bYkQczwVGUhm2nM2h+m28se9KmTFw4T2HX1gVkmzV/euOWMhBb5s/mR1UPqyHiF4mY30
         VUpMPXOcfdTcj8VZCb+k5NDRYCv4TKDhho+ssQRItgB7FTNto0BQHXzwtavlmzfUjpYa
         6gjw==
X-Forwarded-Encrypted: i=1; AJvYcCXyNZeQ8aTirU8J+9hiX3j+JL9XZz5lxON0RrCr4Bj98qdMh517L1PutDrCBhhrL19L3jdBvXudNRL6Ayk/cqx06A6JPBrzaFMdO25d
X-Gm-Message-State: AOJu0YystaWVoIVgAbaDYSSB8qW5KjFgQYayNZ4fcm0zBUiKtHNpIRCO
	lZllf7E0mMZZSmciwIluGctUiSHVqxvjYSOqYvO+rdgCMAi0+ZSTJCNGNxU+RBeQboEnwWcEBzJ
	JTA==
X-Google-Smtp-Source: AGHT+IF9xs3HsjzFSBIAjqUyPXm38m51wM1HHA12Wsf9f2APNF16rnLMBv/VUvy/axmyL5EwvqJpcpdBut8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b9a:b0:609:6719:5660 with SMTP id
 ck26-20020a05690c0b9a00b0060967195660mr3471394ywb.9.1709774028810; Wed, 06
 Mar 2024 17:13:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 17:13:42 -0800
In-Reply-To: <20240307011344.835640-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307011344.835640-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307011344.835640-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: VMX: Snapshot LBR capabilities during module initialization
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Snapshot VMX's LBR capabilities once during module initialization instead
of calling into perf every time a vCPU reconfigures its vPMU.  This will
allow massaging the LBR capabilities, e.g. if the CPU doesn't support
callstacks, without having to remember to update multiple locations.

Opportunistically tag vmx_get_perf_capabilities() with __init, as it's
only called from vmx_set_cpu_caps().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 2 +-
 arch/x86/kvm/vmx/vmx.c       | 9 +++++----
 arch/x86/kvm/vmx/vmx.h       | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 12ade343a17e..be40474de6e4 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -535,7 +535,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
 	if (cpuid_model_is_consistent(vcpu) &&
 	    (perf_capabilities & PMU_CAP_LBR_FMT))
-		x86_perf_get_lbr(&lbr_desc->records);
+		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
 	else
 		lbr_desc->records.nr = 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7a74388f9ecf..2a7cd66988a5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -217,6 +217,8 @@ module_param(ple_window_max, uint, 0444);
 int __read_mostly pt_mode = PT_MODE_SYSTEM;
 module_param(pt_mode, int, S_IRUGO);
 
+struct x86_pmu_lbr __ro_after_init vmx_lbr_caps;
+
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_cond);
 static DEFINE_MUTEX(vmx_l1d_flush_mutex);
@@ -7844,10 +7846,9 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vmx_update_exception_bitmap(vcpu);
 }
 
-static u64 vmx_get_perf_capabilities(void)
+static __init u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
-	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -7857,8 +7858,8 @@ static u64 vmx_get_perf_capabilities(void)
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
-		x86_perf_get_lbr(&lbr);
-		if (lbr.nr)
+		x86_perf_get_lbr(&vmx_lbr_caps);
+		if (vmx_lbr_caps.nr)
 			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 65786dbe7d60..cc10df53966e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -109,6 +109,8 @@ struct lbr_desc {
 	bool msr_passthrough;
 };
 
+extern struct x86_pmu_lbr vmx_lbr_caps;
+
 /*
  * The nested_vmx structure is part of vcpu_vmx, and holds information we need
  * for correct emulation of VMX (i.e., nested VMX) on this vcpu.
-- 
2.44.0.278.ge034bb2e1d-goog


