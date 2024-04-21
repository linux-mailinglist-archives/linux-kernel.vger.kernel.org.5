Return-Path: <linux-kernel+bounces-152412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEEC8ABE12
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7651C203F6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D41B96E;
	Sun, 21 Apr 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DscO2uiO"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E018021
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661506; cv=none; b=tiAg0wgzC3/rfQ4XVsvivAUgCypzwof7DodlkVMLVSknOK5zN/AVvjUPQ1tHSHjsqN7cqzRa1NI7rJ8MQr9xhuiPnkCDZq7D36FTAvknfEbtRMHPOlmOY/PBGjOyI+dBjxWd3xSK8Zzg+RW2qa7bD+CVwJ99QM8QHmf5gWTLOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661506; c=relaxed/simple;
	bh=m3+DhrmTElrTuGVsViFG8fA7aLZvChIonHxJQ+S+avs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQw5yUcQOarvaDX+z5mS8ntP47pnjK9j6psrPGn0nJh/gOnxtavnvjG7pdPD5KCGij/nDysVhfH/fwzwE1sb3qrwTG3vuI8ZUZCBloYBGDjl8GiMBUECrtGi0R0mDVCSAWNMe6Bl5x5HN8eptJKQ/RZltrYN52P6LU2nEIY4n8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DscO2uiO; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea128e4079so1859816a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713661503; x=1714266303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCr6cRIayCDqyRzAJ/jYSwD6dee1uWwRa+1Al1wYQqI=;
        b=DscO2uiObJyQfW2GO/LHEHNMmocFdbtywoLS/UpdPJGsAscBurFMK9+DSBGQfCQk5D
         bZJuWwfk/z7LJLoVTA1XIdOaOV4JnkQIdOIluYT+2ASTCda3JTKsUvzj0Fwt6YCxb099
         I5oJyi/wyE/TCBUbqDwhTap6GZB5699MwuP8zXIGlCcvvOkNpl3Fwr2DhSGfhVsu/Fjc
         I51lz2q0Y++6UZ4ZOgfUezsC+tq57Aw99NzJaP5reWJgAJs7K/rg48doKkLFFVoLZlNr
         GWPMaBz12iy1M5CWgG8Sga+PBkDFZlHdJnatgAZYqbwbP8VekwuGaXrL3UWpW5qWwIZJ
         zVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661503; x=1714266303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCr6cRIayCDqyRzAJ/jYSwD6dee1uWwRa+1Al1wYQqI=;
        b=CLkLi4s1bkU74ArqW1SBfNGgsN8CgmMAiguifilx+SL0Ypqp/ZJDynvsr4GbJJH2eO
         XRgYmJj6gId2KzT77v0KZiFOLO74KYE7euzi5of/qqailfTg0blrAc71eB3jdvjyLtQQ
         r/UkMmfSOqu2oKj0B/2wDL6BQU1O+Bo7J7ayj2SjFG97RYNc/Q7/zp4aUcWAPtSH4Nob
         tfAKY23yKvb9aqoGJG4ugtk37qv2c/c/z/dqvG6IZScZnbFYYPdkzKsHAkDNRCFqSWyE
         hjlHFBn4+Q8uWag8M+tZMMRz8rFrHITpGN6EPXbfyGFeRQe1H2diPzLhVukUY9t02Ayi
         5I6g==
X-Forwarded-Encrypted: i=1; AJvYcCW8O47LFXVmMjiQgK4bF9pFdeQCrI66/9ClIK9CTfxGRB3BMRLPrV1+Dlyi3fXMtRBvmPpaInFrF4z30rARs6y0tNmoS2D073Q+gSry
X-Gm-Message-State: AOJu0Yz047ebUGqa6Koc/fERVHURK+jiMEniXB43/s5hG1flyLx9Jx8l
	WB66KkqCCan7wEfSqFKRJZLafrxPbkzmsmVGhhr2kn1+5/yRmpua62BdNKaw5Sc=
X-Google-Smtp-Source: AGHT+IF6ugHXMb7qa0IeINre3J7n/IDYye5i313ljbvtiSXTUdk6AOkMktb03jK0xZo7D/SB1x5FJA==
X-Received: by 2002:a05:6830:4984:b0:6eb:8434:9a89 with SMTP id fc4-20020a056830498400b006eb84349a89mr9656367otb.1.1713661503264;
        Sat, 20 Apr 2024 18:05:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm5249627pgj.1.2024.04.20.18.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:05:02 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sat, 20 Apr 2024 18:04:41 -0700
Subject: [PATCH v3 09/17] riscv: drivers: Convert xandespmu to use the
 vendor extension framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dev-charlie-support_thead_vector_6_9-v3-9-67cff4271d1d@rivosinc.com>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713661481; l=8093;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=m3+DhrmTElrTuGVsViFG8fA7aLZvChIonHxJQ+S+avs=;
 b=77hNoZPc833RSdXrN5Anhvjoh4N9zVTSz7FrhuKqkpu5VIR+cYhPCrVB+9lkQFwsC7ikF61vl
 ASzZiJUbssuDazim4oWDV89QSGwdOs4ViW+/jsxp5o40qLm/yTzEjRA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Migrate xandespmu out of riscv_isa_ext and into a new Andes-specific
vendor namespace.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.vendor                        | 10 +++++++
 arch/riscv/include/asm/hwcap.h                   |  1 -
 arch/riscv/include/asm/vendor_extensions/andes.h | 19 +++++++++++++
 arch/riscv/kernel/cpufeature.c                   |  1 -
 arch/riscv/kernel/vendor_extensions.c            | 11 ++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |  1 +
 arch/riscv/kernel/vendor_extensions/andes.c      | 35 ++++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c                     |  8 ++++--
 8 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
index d57254f28ea6..d5555ed696fb 100644
--- a/arch/riscv/Kconfig.vendor
+++ b/arch/riscv/Kconfig.vendor
@@ -7,3 +7,13 @@ config RISCV_ISA_VENDOR_EXT_THEAD
 	  requested by hardware probing to be ignored.
 
 	  If you don't know what to do here, say Y.
+
+config RISCV_ISA_VENDOR_EXT_ANDES
+	bool "Andes vendor extension support"
+	default y
+	help
+	  Say N here if you want to disable all Andes vendor extension
+	  support. This will cause any Andes vendor extensions that are
+	  requested by hardware probing to be ignored.
+
+	  If you don't know what to do here, say Y.
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
index 000000000000..54b0ad1a409d
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
+extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes;
+
+#endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 17371887abcc..0cef08a3d891 100644
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
index eced93eec5a6..e31f16b8cec9 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -5,6 +5,7 @@
 
 #include <asm/vendorid_list.h>
 #include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
 #include <asm/vendor_extensions/thead.h>
 
 #include <linux/array_size.h>
@@ -14,6 +15,9 @@ const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
 #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
 	&riscv_isa_vendor_ext_list_thead,
 #endif
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
+	&riscv_isa_vendor_ext_list_andes,
+#endif
 };
 
 const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
@@ -42,6 +46,13 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 		cpu_bmap = riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
 		bmap_size = riscv_isa_vendor_ext_list_thead.bitmap_size;
 		break;
+#endif
+#ifdef CONFIG_RISCV_VENDOR_EXT_ANDES
+	case ANDES_VENDOR_ID:
+		bmap = riscv_isa_vendor_ext_list_andes.vendor_bitmap;
+		cpu_bmap = riscv_isa_vendor_ext_list_andes.per_hart_vendor_bitmap;
+		bmap_size = riscv_isa_vendor_ext_list_andes.bitmap_size;
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
index 000000000000..8451106d2e07
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/andes.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
+};
+
+/*
+ * The first member of this struct must be a bitmap named isa so it can be
+ * compatible with riscv_isainfo even though the sizes of the bitmaps may be
+ * different.
+ */
+struct riscv_isavendorinfo_andes {
+	DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_ANDES);
+};
+
+/* Hart specific T-Head vendor extension support */
+static struct riscv_isavendorinfo_andes hart_vendorinfo_andes[NR_CPUS];
+
+/* Set of T-Head vendor extensions supported on all harts */
+DECLARE_BITMAP(vendorinfo_andes, RISCV_ISA_VENDOR_EXT_MAX_ANDES);
+
+const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes = {
+	.ext_data = riscv_isa_vendor_ext_andes,
+	.per_hart_vendor_bitmap = (struct riscv_isainfo *)hart_vendorinfo_andes,
+	.vendor_bitmap = vendorinfo_andes,
+	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_andes),
+	.bitmap_size = RISCV_ISA_VENDOR_EXT_MAX_ANDES
+};
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..84760ce61e03 100644
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
@@ -837,7 +839,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+	} else if (riscv_isa_vendor_extension_available(-1, XANDESPMU) &&
 		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
 		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
 		riscv_pmu_use_irq = true;

-- 
2.44.0


