Return-Path: <linux-kernel+bounces-167240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452078BA649
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466921C20CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905213BAF6;
	Fri,  3 May 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="faM3eL4p"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382513B7AA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711625; cv=none; b=jCp8o8EFgZdD2lXauZTRu6s8qXbCzMlrJ9smlt5T3Idd9tDDOxquxaJGUAMayNcZt4ALYYBkMHLqGXA9Lc/ScX1GnebS84JcnqhS3h4oIevlZsg1hnHqr8fHULKWKfXCB6J5Z7+7ybBmpgaJtPHbyyxS0542KpDPKPQ+cgU6pWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711625; c=relaxed/simple;
	bh=DZJ3GWoPClZISVVtph66CwyKqt3gXaNuWiX8ul3BflE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpV1nwPpQsvH8YaO3Tp5zoiHVf2l8AGzyOg0DVCNm5I0qX+ETXiWn/IChxeN9nhAzJcye+UhIzDmgEIpVZAGFXeeZjtf/68vVEhgE8SlT07L9DIHopfeQu72XFZJC3JuUR8PK4u7pdsyF8r8rdN0KoreluTDth47WtvIa1LPdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=faM3eL4p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed0abbf706so9905405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711623; x=1715316423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/ChO0ugMJsBuhZWRctChi/3yIdq4rba+vb9ehaoLKg=;
        b=faM3eL4pNu1s5FXmG6o9Szstm4vj4kWyl5VJ5NU/4dGrN3w/QLluZebgSk+doc0Bpj
         Wrus+jK+863koGdWeLURGfFhriBwBj++WNrqYJM9i9E9qY8YolXlc6WU4cN96mVZdVyR
         NQuqJ/uVSIwozYhReS1Hha15RzyIIZz9q05Zdwt5ACv2Z7Xsup7dC1SmV/qcxcU04DK2
         tU9uWAxZdhP00gjfZK9FUboszQoxUd5CIDbi/LZWA0rlsbmvu06Lfq7St0k9qau2gIW4
         btMXJV3AmBPdxA7fEgyqg3tJhTt1MIKZYrxk5p7Ng0s4hBwVBmgFTtTCOT1A4GQRyk7I
         jB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711623; x=1715316423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/ChO0ugMJsBuhZWRctChi/3yIdq4rba+vb9ehaoLKg=;
        b=qJpKu6eLpd/AEk2rUrtyZFAt/K/v61vI0MDFfL7OhP2/esuVp7JjSWuRMVXjX9Ofd4
         Z722xHOKFZhJzD7KMc7jDgzpj2/awls+GxMVLrDI9tAjAber/tYaJz/XPlED0kG5/2nY
         ljaMD002mgri2ynKLq+4+35s+6z8sK5yoG745dI6g4Tl7xvaKz1Q+PcHTCUeR/xel73x
         /R55uMK3/Ag3kvPUVYiM2igy12BC9SA1GkMuHzbG5ixhrMW409SXNcmAC94JighfV++6
         SC4ARQdsCRtpYEl2a7AUHQ5lUJCNQK67ZMNaRu1gbOZzzBFsTUdeuWF+UeXpufCSrj2/
         ZIOw==
X-Forwarded-Encrypted: i=1; AJvYcCXd25XPlQDJZg3+u8f3r64dcRu4nLow310S53LPMOrvSb9aW6ouA72cFdowSmd2C+zX0hk8kcUlx7A/m/wM2wwilI/PPFHGyQdd4kKS
X-Gm-Message-State: AOJu0YyQ5N8oPYsh53U4PYxAvzS7V81x69iZckrFxqEVbnJZHaxK3GJm
	ACDgNcf4WbLyQ1OeXQNziZlDHY1SE4o1q5BdIG5JvV9rtiAoJiNLx79zX5sADUM=
X-Google-Smtp-Source: AGHT+IFuNoVTAaa9FIb7BDHTTGxxQmKdIuC2lpf/ubWvlA0612VmuOOWsYeCGFTXWLaz1/5KsPfFig==
X-Received: by 2002:a17:903:124b:b0:1eb:7bc7:8855 with SMTP id u11-20020a170903124b00b001eb7bc78855mr2127178plh.2.1714711623055;
        Thu, 02 May 2024 21:47:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:47:02 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:44 -0700
Subject: [PATCH v5 09/17] riscv: Convert xandespmu to use the vendor
 extension framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-9-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=8114;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=DZJ3GWoPClZISVVtph66CwyKqt3gXaNuWiX8ul3BflE=;
 b=WFXlkfnY5YiBkQNKv1DkELyxNjBMzdzQmH4ArCSPN8shDOU9Mz582HO4O/KttPxvWdS8IWTH8
 xYAdTBkzvx1C9ublzYAO0aoaVpcUTez7wkb0aLqTC9pCHPpY8I9sJmA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Migrate xandespmu out of riscv_isa_ext and into a new Andes-specific
vendor namespace.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.vendor                        | 12 ++++++++++++
 arch/riscv/errata/andes/errata.c                 |  2 ++
 arch/riscv/include/asm/hwcap.h                   |  1 -
 arch/riscv/include/asm/vendor_extensions/andes.h | 19 +++++++++++++++++++
 arch/riscv/kernel/cpufeature.c                   |  1 -
 arch/riscv/kernel/vendor_extensions.c            | 10 ++++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |  1 +
 arch/riscv/kernel/vendor_extensions/andes.c      | 18 ++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c                     |  9 ++++++---
 9 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
index 85ac30496b0e..aa5a191e659e 100644
--- a/arch/riscv/Kconfig.vendor
+++ b/arch/riscv/Kconfig.vendor
@@ -16,4 +16,16 @@ config RISCV_ISA_VENDOR_EXT_THEAD
 	  If you don't know what to do here, say Y.
 endmenu
 
+menu "Andes"
+config RISCV_ISA_VENDOR_EXT_ANDES
+	bool "Andes vendor extension support"
+	default y
+	help
+	  Say N here if you want to disable all Andes vendor extension
+	  support. This will cause any Andes vendor extensions that are
+	  requested by hardware probing to be ignored.
+
+	  If you don't know what to do here, say Y.
+endmenu
+
 endmenu
diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index f2708a9494a1..a5d96a7a4682 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -65,6 +65,8 @@ void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct al
 					      unsigned long archid, unsigned long impid,
 					      unsigned int stage)
 {
+	BUILD_BUG_ON(ERRATA_ANDES_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	if (stage == RISCV_ALTERNATIVES_BOOT)
 		errata_probe_iocp(stage, archid, impid);
 
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..1f2d2599c655 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,7 +80,6 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
-#define RISCV_ISA_EXT_XANDESPMU		74
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/vendor_extensions/andes.h b/arch/riscv/include/asm/vendor_extensions/andes.h
new file mode 100644
index 000000000000..7bb2fc43438f
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/andes.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_ANDES_H
+#define _ASM_RISCV_VENDOR_EXTENSIONS_ANDES_H
+
+#include <asm/vendor_extensions.h>
+
+#include <linux/types.h>
+
+#define RISCV_ISA_VENDOR_EXT_XANDESPMU		0
+
+/*
+ * Extension keys should be strictly less than max.
+ * It is safe to increment this when necessary.
+ */
+#define RISCV_ISA_VENDOR_EXT_MAX_ANDES			32
+
+extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes;
+
+#endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1f35564a1e0..0c9ba81600ac 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -289,7 +289,6 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
-	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index 7910890c17de..e4d58938e6ce 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -5,6 +5,7 @@
 
 #include <asm/vendorid_list.h>
 #include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
 #include <asm/vendor_extensions/thead.h>
 
 #include <linux/array_size.h>
@@ -14,6 +15,9 @@ struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
 #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
 	&riscv_isa_vendor_ext_list_thead,
 #endif
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
+	&riscv_isa_vendor_ext_list_andes,
+#endif
 };
 
 const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
@@ -40,6 +44,12 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 		bmap = &riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap;
 		cpu_bmap = &riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu];
 		break;
+#endif
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
+	case ANDES_VENDOR_ID:
+		bmap = &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
+		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
+		break;
 #endif
 	default:
 		return false;
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
index 3383066baaab..8f1c5a4dc38f 100644
--- a/arch/riscv/kernel/vendor_extensions/Makefile
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
+obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
diff --git a/arch/riscv/kernel/vendor_extensions/andes.c b/arch/riscv/kernel/vendor_extensions/andes.c
new file mode 100644
index 000000000000..ec688c88456a
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/andes.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+/* All Andes vendor extensions supported in Linux */
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
+};
+
+struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes = {
+	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_andes),
+	.ext_data = riscv_isa_vendor_ext_andes,
+};
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..d39b01372fa5 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -24,6 +24,8 @@
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
+#include <asm/vendorid_list.h>
+#include <asm/vendor_extensions/andes.h>
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
@@ -32,7 +34,7 @@ asm volatile(ALTERNATIVE_2(						\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
 	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
-		0, RISCV_ISA_EXT_XANDESPMU,				\
+		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
 		CONFIG_ANDES_CUSTOM_PMU)				\
 	: "=r" (__ovl) :						\
 	: "memory")
@@ -41,7 +43,7 @@ asm volatile(ALTERNATIVE_2(						\
 asm volatile(ALTERNATIVE(						\
 	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
 	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
-		0, RISCV_ISA_EXT_XANDESPMU,				\
+		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
 		CONFIG_ANDES_CUSTOM_PMU)				\
 	: : "r"(__irq_mask)						\
 	: "memory")
@@ -837,7 +839,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+	} else if (riscv_has_vendor_extension_unlikely(ANDES_VENDOR_ID,
+						       RISCV_ISA_VENDOR_EXT_XANDESPMU) &&
 		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
 		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
 		riscv_pmu_use_irq = true;

-- 
2.44.0


