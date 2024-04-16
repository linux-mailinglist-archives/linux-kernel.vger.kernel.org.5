Return-Path: <linux-kernel+bounces-146209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF498A622D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F1D1F24034
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78C3FB9D;
	Tue, 16 Apr 2024 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BOH4mkpB"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D043147
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240736; cv=none; b=Xnw22bjQDbm/KM6k+f4ByxDrJ/RucxYVx7KnavdpuPw2CPoNtPmEx3PbZcJs5Abp5mtxEbf/cZjIfcAtoeGHxCApXb5thuQkOCbZXPb3DwrOEjPN2YLdFUkxrfUBaqAisRR4js5NTEnuXgSr6xaLxS1BacMNyQdVWMRS2U08A1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240736; c=relaxed/simple;
	bh=EUo/8P9TxYm5Z8gBeogX8nOGhGz5D7qWLLRReTJSe00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fo9mMJdomUB7LucqNyR4T+sFWCZLDOYFjEzaa3oWnbCwT9otAVIc5BfvKT44oYd/i2ltmMs5Y8BhU6awMHbr25EBdzwwc7qKcoi2L0O1BDLo8HPWjxd1z5pzV1DM3iAHvu1O6ws31MvQ85cK9vOvhgRZ4RKeLmSQ4odZsSvYL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BOH4mkpB; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222a9eae9a7so2191025fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240733; x=1713845533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfgEouA2o3txDoLsnSFQ1dO9dPIDHDcBgqnFwikm9Z4=;
        b=BOH4mkpB9RbrV74CfvdtZEUzs4DfbP/OYhPg7lAepAxFaDsxOy3YYfzfvFM7UyzvGd
         5iBiPFgmUrouXbmzSxIeXODSXOVd6IlIT8qFDrinxn5mAl3DTfHiVblJ1eg6LvKF5Ro7
         rLgjf1BKhRd+rZOnmUG9GijSfNN8tSfVOsGYpyuMDq2jsgx9f2IA2v8c5sBr15sTY5lr
         TAxKk1zEFsg6sreCaKMBlr6e8eyCavPAP8HWDIumsoGx3/R69mTvU9BPfW8aWEHF74tL
         X8wr17YF12l2k1RR10OUZtlqz5bzuE4fw8mswBqgSUD4ozp2ByPYPHKExY1sgQfQlFLZ
         QxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240733; x=1713845533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfgEouA2o3txDoLsnSFQ1dO9dPIDHDcBgqnFwikm9Z4=;
        b=rvoqXMBKsuDPGEOG17edjDWXjqxyKVDhcGpF9eLckgxmjrdU44eEbrBilHKNBvaUED
         Xhn2c5toJSkeIq/B6WGIdYaunbU6kEh9mkPsPPzjHTAEqEA2FY4a4hdHFqX4rDCALLBg
         EG25Deokb8AmxLkZVXxc+q8UXyTFoJ0mXDExXroreSULlDkXuihOKlNPqcntS/kB6l3e
         +1M4HWXFCgwy507bKTtUo6A35Jbz/vY2WHDay8bEdJWJA1pe/tRsmlEKEhSYYSsNMgAV
         5U112drMVDN0TVjzycPTZmJ3GJZzDOB5qp0WFDMN1vaI25myrvd5JI5lMsIMOVopbA5O
         0Grg==
X-Forwarded-Encrypted: i=1; AJvYcCWdb0l7tedM/F5j12va+tYyoPOoKF5WASmQ6g10vfX9qanOXRO9xIi5ZERRDWcEmdssEF9jqT3jE1ReOOJXrT8T8I1OstLlSlDegKYa
X-Gm-Message-State: AOJu0Yy61f/tsab7M/AriycHj08364sXe8to6j1kB5J80VXlXtoKUIJ/
	SmyIry1X8kVik8deudR3iCJSSMhctEYjzuDt4R/sWRHOqZZ1Qp7FhF/jNgplNLA=
X-Google-Smtp-Source: AGHT+IEkWKCmfS18iCDatrUQ8+gUH7AmhQlIUh3jbL94Sbp8FTPKm2WfVOtKvazKrIc/nVfvWnVHCQ==
X-Received: by 2002:a05:6870:7010:b0:22e:cc63:9b26 with SMTP id u16-20020a056870701000b0022ecc639b26mr13242263oae.15.1713240732726;
        Mon, 15 Apr 2024 21:12:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:11 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:04 -0700
Subject: [PATCH v2 07/17] riscv: Introduce vendor variants of extension
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-7-c7d68c603268@rivosinc.com>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=11791;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=EUo/8P9TxYm5Z8gBeogX8nOGhGz5D7qWLLRReTJSe00=;
 b=Q0x4Mz7P7q6WFelFlp1y5rSIZoXPi8vlvCpVUPr+N3sy5vC2A1kMHvi3EW9gb6Ay3s/PW+Mxk
 ZD4o95nKjphDcab+24J6lgRl1n0bJFwXHfQUGSW0TwWbIKaQKKIWdA2
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Vendor extensions are maintained in riscv_isa_vendor (separate from
standard extensions which live in riscv_isa). Create vendor variants for
the existing extension helpers to interface with the riscv_isa_vendor
bitmap. There is a good amount of overlap between these functions, so
the alternative checking code can be factored out.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/errata/sifive/errata.c   |   2 +
 arch/riscv/errata/thead/errata.c    |   2 +
 arch/riscv/include/asm/cpufeature.h | 142 +++++++++++++++++++++++++++---------
 arch/riscv/include/asm/hwprobe.h    |   3 +
 arch/riscv/kernel/cpufeature.c      |  53 ++++++++++++--
 arch/riscv/kernel/sys_hwprobe.c     |   4 +-
 6 files changed, 161 insertions(+), 45 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 3d9a32d791f7..847ff85cc911 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -99,6 +99,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != SIFIVE_VENDOR_ID)
 			continue;
+		if (alt->patch_id >= RISCV_ISA_VENDOR_EXT_BASE)
+			continue;
 		if (alt->patch_id >= ERRATA_SIFIVE_NUMBER) {
 			WARN(1, "This errata id:%d is not in kernel errata list", alt->patch_id);
 			continue;
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..6e3eabfe92af 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -163,6 +163,8 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != THEAD_VENDOR_ID)
 			continue;
+		if (alt->patch_id >= RISCV_ISA_VENDOR_EXT_BASE)
+			continue;
 		if (alt->patch_id >= ERRATA_THEAD_NUMBER)
 			continue;
 
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 50fa174cccb9..12dd36bafa2a 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -110,23 +110,19 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 #define riscv_isa_extension_available(isa_bitmap, ext)	\
 	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
 
+bool __riscv_isa_vendor_extension_available(const unsigned long *vendor_isa_bitmap,
+					    unsigned int bit);
+#define riscv_isa_vendor_extension_available(isa_bitmap, ext)	\
+	__riscv_isa_vendor_extension_available(isa_bitmap, RISCV_ISA_VENDOR_EXT_##ext)
+
 static __always_inline bool
-riscv_has_extension_likely(const unsigned long ext)
+__riscv_has_extension_likely_alternatives(const unsigned long vendor, const unsigned long ext)
 {
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm goto(
-		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_no);
-	} else {
-		if (!__riscv_isa_extension_available(NULL, ext))
-			goto l_no;
-	}
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
 
 	return true;
 l_no:
@@ -134,42 +130,118 @@ riscv_has_extension_likely(const unsigned long ext)
 }
 
 static __always_inline bool
-riscv_has_extension_unlikely(const unsigned long ext)
+__riscv_has_extension_unlikely_alternatives(const unsigned long vendor, const unsigned long ext)
 {
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm goto(
-		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_yes);
-	} else {
-		if (__riscv_isa_extension_available(NULL, ext))
-			goto l_yes;
-	}
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
+/* Standard extension helpers */
+
+static __always_inline bool
+riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely_alternatives(0, ext);
+	else
+		return __riscv_isa_extension_available(NULL, ext);
+}
+
+static __always_inline bool
+riscv_has_extension_unlikely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely_alternatives(0, ext);
+	else
+		return __riscv_isa_extension_available(NULL, ext);
+}
+
 static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
-		return true;
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
 
-	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_likely_alternatives(0, ext))
+		return true;
+	else
+		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
 static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_unlikely_alternatives(0, ext))
 		return true;
+	else
+		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+}
+
+/* Vendor extension helpers */
+
+static __always_inline bool
+riscv_has_vendor_extension_likely(const unsigned long vendor, const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
+			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely_alternatives(vendor, ext);
+	else
+		return __riscv_isa_vendor_extension_available(NULL, ext);
+}
 
-	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+static __always_inline bool
+riscv_has_vendor_extension_unlikely(const unsigned long vendor, const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
+			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely_alternatives(vendor, ext);
+	else
+		return __riscv_isa_vendor_extension_available(NULL, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_likely(const unsigned long vendor,
+								  int cpu, const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
+			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely_alternatives(vendor, ext);
+	else
+		return __riscv_isa_vendor_extension_available(hart_isa_vendor[cpu].isa, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(const unsigned long vendor,
+								    int cpu,
+								    const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
+			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely_alternatives(vendor, ext);
+	else
+		return __riscv_isa_vendor_extension_available(hart_isa_vendor[cpu].isa, ext);
 }
 
 #endif
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..1378c3c9401a 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_HWPROBE_H
 #define _ASM_HWPROBE_H
 
+#include <linux/cpumask.h>
 #include <uapi/asm/hwprobe.h>
 
 #define RISCV_HWPROBE_MAX_KEY 6
@@ -39,4 +40,6 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
 	return pair->value == other_pair->value;
 }
 
+void hwprobe_arch_id(struct riscv_hwprobe *pair, const struct cpumask *cpus);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d7a33e017a15..799ec2d2e9e0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
+#include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
 #include <asm/sbi.h>
@@ -82,6 +83,30 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
+/**
+ * __riscv_isa_vendor_extension_available() - Check whether given vendor
+ * extension is available or not. The vendor extension must be associated
+ * with the same vendor that was used to populate isa_bitmap.
+ *
+ * @isa_bitmap: ISA bitmap to use
+ * @bit: bit position of the desired extension
+ * Return: true or false
+ *
+ * NOTE: If isa_bitmap is NULL then Host ISA bitmap will be used.
+ */
+bool __riscv_isa_vendor_extension_available(const unsigned long *isa_bitmap, unsigned int bit)
+{
+	const unsigned long *bmap = (isa_bitmap) ? isa_bitmap : riscv_isa_vendor;
+
+	bit -= RISCV_ISA_VENDOR_EXT_BASE;
+
+	if (bit < 0 || bit >= RISCV_ISA_VENDOR_EXT_MAX)
+		return false;
+
+	return test_bit(bit, bmap) ? true : false;
+}
+EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);
+
 static bool riscv_isa_extension_check(int id)
 {
 	switch (id) {
@@ -832,25 +857,37 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 {
 	struct alt_entry *alt;
 	void *oldptr, *altptr;
-	u16 id, value;
+	u16 id, value, vendor;
 
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
-	for (alt = begin; alt < end; alt++) {
-		if (alt->vendor_id != 0)
-			continue;
+	struct riscv_hwprobe mvendorid = {
+		.key = RISCV_HWPROBE_KEY_MVENDORID,
+		.value = 0
+	};
 
+	hwprobe_arch_id(&mvendorid, cpu_possible_mask);
+
+	for (alt = begin; alt < end; alt++) {
 		id = PATCH_ID_CPUFEATURE_ID(alt->patch_id);
+		vendor = PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
 
-		if (id >= RISCV_ISA_EXT_MAX) {
+		if (id >= RISCV_ISA_VENDOR_EXT_BASE) {
+			if (vendor != mvendorid.value ||
+			    !__riscv_isa_vendor_extension_available(NULL, id))
+				continue;
+		} else if (id < RISCV_ISA_EXT_MAX) {
+			if (alt->vendor_id != 0)
+				continue;
+
+			if (!__riscv_isa_extension_available(NULL, id))
+				continue;
+		} else {
 			WARN(1, "This extension id:%d is not in ISA extension list", id);
 			continue;
 		}
 
-		if (!__riscv_isa_extension_available(NULL, id))
-			continue;
-
 		value = PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
 		if (!riscv_cpufeature_patch_check(id, value))
 			continue;
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8cae41a502dd..394f1343490c 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -13,11 +13,11 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/vector.h>
+#include <asm/vendor/thead.h>
 #include <vdso/vsyscall.h>
 
 
-static void hwprobe_arch_id(struct riscv_hwprobe *pair,
-			    const struct cpumask *cpus)
+void hwprobe_arch_id(struct riscv_hwprobe *pair, const struct cpumask *cpus)
 {
 	u64 id = -1ULL;
 	bool first = true;

-- 
2.44.0


