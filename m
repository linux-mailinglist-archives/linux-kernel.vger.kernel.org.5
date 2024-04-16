Return-Path: <linux-kernel+bounces-146210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB68A622C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180A7282CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB03543150;
	Tue, 16 Apr 2024 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tyYXTK8j"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C459165
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240736; cv=none; b=eD3+DDTT91MAVDlLCpjytc/OcecmhMPgUi1doY8AY0Dvfhlconpld4wzEYw8grsu4iDJPNc0r+q3+6WF2iPuEi8NH0xewPApiYLnv5K4Srm+E1zlK55koZCuF9BC65CjaBzA2nm0ckkCcLgRd4/eI3PI2YZy+GZKbANgCwl0j/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240736; c=relaxed/simple;
	bh=j7hOaHqP/gwoL4jD1U/UQdhE9yXcwGHiVrD2cYUclQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAzeXE6eJA6WKgWuQwk8MkHWtsyMZa3pC/HJ+WqqtcstZPzEWfJg7GOgwRYlUR3CpSPWEeSLqFbQ40VchW9CNAxdPIzWfkbSpsNB8OmNI+6gHWm4vrvxBCwQ8Dp5ECXZav8c78moYQ5mUowfu8gmbLitiNV+0/VV0JoFiELEhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tyYXTK8j; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c70b652154so1152513b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240734; x=1713845534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RffB0o1A20UoURN50KRa9DaryhbtpvwRES2okh3bpYE=;
        b=tyYXTK8jfuXukektX0qQqknbP8WbyCPmD3yxNHBjdVM2LsDxkBcEJXCVjL9/Lez4ft
         ldJvkkgDw9aPCGGWgTmroXmViRwUZ+7guzKhAyat75WovoYt3zyUj8hn2H09/YxPbGry
         O6SN5sGA27pD085D7/l42RUarqXDqm3rbpC5mJzuWT+cXguBq3bUZdvLTsEj41b9wYie
         yYQwmyjJxB9KVdGkRWHF8ccSKiy5KD/UQrt/Z+FAcVOyjhtdWj0iIGUnZLzGdPuKWaAc
         2Ps4GmqT+LZKdEbvicjH0U7gSFCeMWcQixyruZSrPAwQ2vDKMJ6MXSEclP60oDJWJ5uD
         rd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240734; x=1713845534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RffB0o1A20UoURN50KRa9DaryhbtpvwRES2okh3bpYE=;
        b=ltlB7KzaWcFa1hgiREr8KKCG2H2+RXzOjTbYYZe1yicaVNVqKFSmzU6ni29lZjZG3J
         a6Enc77wf0amMO+q9s+tovdvvEr6UoxDp547cMdk8jor4yb2+WuIDSbHgZ+reklqaDkq
         BCJFZs++Meo02+mBF79ye52rlGqsXSUBMAM52AQmcuIEZWZJJhxJktJCSwvO7dgLNqoH
         /y8ull929FBMyFPfby7rLRVd4OjjDSWd3jggm06NHb9MjZMReuov/kDMYrkZF6rsp5gl
         b31cWtaPsm4oIEzBuc8ktMKm6Ln32fNfeAek82VcOfXc/VBzrnHct9Ji8FixBACqTX1l
         iWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXnCDRKPZACaG6ogRqEVXu9/+kCL4ARxpOb1d0f4SP/7CMrCDnPwaIFwMa1Z9pG6sbtHOcxd4vDChrMmf7k+9tWb+wVJLH9Qb1Vc1e
X-Gm-Message-State: AOJu0Yy4ZxPEUZEQe0VK0NXZ4J82b9zBnPscG1iCvboQpfrA0+v47b5S
	TJBSt+WOh2867R5rn5gnr9dSKybCbz5Yutu5cj+UTZoVHdPhWzeb4mReesw5AK4=
X-Google-Smtp-Source: AGHT+IHx670NU+TlR/f3v9B4Qzuah3bLLv9HaSlF62K+k8e99IHEN5iKr7nVeiVqlVhKiS267JiWCQ==
X-Received: by 2002:a05:6808:199d:b0:3c7:2760:d52e with SMTP id bj29-20020a056808199d00b003c72760d52emr56390oib.52.1713240734403;
        Mon, 15 Apr 2024 21:12:14 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:13 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:05 -0700
Subject: [PATCH v2 08/17] riscv: drivers: Convert xandespmu to use the
 vendor extension framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-8-c7d68c603268@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=5822;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=j7hOaHqP/gwoL4jD1U/UQdhE9yXcwGHiVrD2cYUclQM=;
 b=0uoHwtzZ0HMjLFZ1Z0+67ZBZiFLnrjEiEVZz3A7YF2aFDJgj63u3xaTgyfzFXN4Mn1NQ/QS4Z
 dUA0C2swkhUANjDq2KpMi955RECXxD7uBiZof985lROPkNPq7hUBwOM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Migrate xandespmu out of riscv_isa_ext and into a new Andes-specific
vendor namespace.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h                         |  4 +++-
 arch/riscv/include/asm/vendor_extensions.h             |  3 +++
 arch/riscv/kernel/cpufeature.c                         |  1 -
 arch/riscv/kernel/vendor_extensions.c                  |  4 ++++
 arch/riscv/kernel/vendor_extensions/Makefile           |  1 +
 arch/riscv/kernel/vendor_extensions/andes_extensions.c | 13 +++++++++++++
 drivers/perf/riscv_pmu_sbi.c                           |  7 ++++---
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 38157be5becd..4b986e4b56f2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,7 +80,6 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
-#define RISCV_ISA_EXT_XANDESPMU		74
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -103,6 +102,9 @@
  */
 #define RISCV_ISA_VENDOR_EXT_BASE		0x8000
 
+/* Andes Vendor Extensions */
+#define RISCV_ISA_VENDOR_EXT_XANDESPMU		0x8000
+
 /* THead Vendor Extensions */
 #define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR	0x8000
 
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index 0a1955e1c900..33a430cc50cb 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -9,6 +9,9 @@
 extern const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[];
 extern const size_t riscv_isa_vendor_ext_count_thead;
 
+extern const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[];
+extern const size_t riscv_isa_vendor_ext_count_andes;
+
 bool get_isa_vendor_ext(unsigned long vendorid, const struct riscv_isa_ext_data **isa_vendor_ext,
 			size_t *count);
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 799ec2d2e9e0..949c06970c4f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -321,7 +321,6 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
-	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index 3a8a6c6dd34e..c5ca02ce1bb1 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -21,6 +21,10 @@ bool __init get_isa_vendor_ext(unsigned long vendorid,
 		*isa_vendor_ext = riscv_isa_vendor_ext_thead;
 		*count = riscv_isa_vendor_ext_count_thead;
 		break;
+	case ANDES_VENDOR_ID:
+		*isa_vendor_ext = riscv_isa_vendor_ext_andes;
+		*count = riscv_isa_vendor_ext_count_andes;
+		break;
 	default:
 		*isa_vendor_ext = NULL;
 		*count = 0;
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
index dcf3de8d4658..8014594aafa1 100644
--- a/arch/riscv/kernel/vendor_extensions/Makefile
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-y	+= andes_extensions.o
 obj-y	+= thead_extensions.o
diff --git a/arch/riscv/kernel/vendor_extensions/andes_extensions.c b/arch/riscv/kernel/vendor_extensions/andes_extensions.c
new file mode 100644
index 000000000000..b7450f99bfb5
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/andes_extensions.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/hwcap.h>
+#include <asm/vendor_extensions.h>
+
+#include <linux/array_size.h>
+
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
+};
+
+const size_t riscv_isa_vendor_ext_count_andes = ARRAY_SIZE(riscv_isa_vendor_ext_andes);
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..13e37296cb5f 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -24,6 +24,7 @@
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
+#include <asm/vendorid_list.h>
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
@@ -32,7 +33,7 @@ asm volatile(ALTERNATIVE_2(						\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
 	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
-		0, RISCV_ISA_EXT_XANDESPMU,				\
+		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
 		CONFIG_ANDES_CUSTOM_PMU)				\
 	: "=r" (__ovl) :						\
 	: "memory")
@@ -41,7 +42,7 @@ asm volatile(ALTERNATIVE_2(						\
 asm volatile(ALTERNATIVE(						\
 	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
 	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
-		0, RISCV_ISA_EXT_XANDESPMU,				\
+		ANDES_VENDOR_ID, RISCV_ISA_VENDOR_EXT_XANDESPMU,	\
 		CONFIG_ANDES_CUSTOM_PMU)				\
 	: : "r"(__irq_mask)						\
 	: "memory")
@@ -837,7 +838,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+	} else if (riscv_isa_vendor_extension_available(NULL, XANDESPMU) &&
 		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
 		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
 		riscv_pmu_use_irq = true;

-- 
2.44.0


