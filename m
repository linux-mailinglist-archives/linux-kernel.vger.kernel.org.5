Return-Path: <linux-kernel+bounces-168036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78668BB2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516A51F21160
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41F15A48D;
	Fri,  3 May 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2YZvD7gS"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D7159919
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760339; cv=none; b=NPo4pJLlFsw+jYA7XAEuDR3LbN69htZPgyjUKznkAEkotGRrkY/haUzx4ttMFcVaPOM0ndppAh2a98yCL3EXgaXqPfbTq7VdRie3+zsS376i5YcQQpn/WCm8bWOgf3fSXr7zXn09OMCVRnznvttHLbdNTawadYzmCcdY1LQR6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760339; c=relaxed/simple;
	bh=oHywOTliEHoaGOH+p/KAB2oes75uvxzplJdN2OqqeZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvZYtSHfft2iBiYGylMyNEHVIfcaGMQc+hGrZjmwrEf7uEaZU/nThheNagUSsyOhFUvt/OBsUPTJ6TFepK+SFXVKcbN9Cltf8A4dwcswd5ps//Z0R3j7iGFOgf7NjpFt7DMhW2ErlviSd8Wv61mtBEnbRaHToR5ZyQJSzcqwSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2YZvD7gS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4472561f1so20405b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760337; x=1715365137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cH3YNCAT0dZmAgzMEs/mp+5fGn0LRaZcONh2CiROrH4=;
        b=2YZvD7gSLDcuX7PK2zJRaasqUHavLsRKnGupDaZEIJCj/xW0a935NK+95yoGSoCG4t
         IfJhACenIfl7t9jqDhqGbCik4KbbBJyyW2cW12ewDpKeJ2O9NwRRIbnHzcxNnJew2D7Y
         5/L+ZiA11Vxd86WuhJ86IB/5rjKy/vrBvqvONcrImJnYT9X4h1L1EQ68XXhn1IewBlU4
         cS6hHKvtu6u7KUNWHlwRAFHogB+U7NkA4eS0jxz/JaCVRrOQKYhaDLRHu1S8CyPKgT0J
         1D+Uzqx5qxcpg07ChAEpDKAukTXq0VgvUCOkEKXzUvpVoNNQBS8AC5Bh7XpMqEDOcSCK
         HybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760337; x=1715365137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH3YNCAT0dZmAgzMEs/mp+5fGn0LRaZcONh2CiROrH4=;
        b=JrhZKtsMWOUHevrXU0cWWxt/1H95ZSR4pu4CuoKNVOkUWFyrhvafy/JzpATH+BkSeW
         oT1A2tlGbKTlfkrsL4CnVkN+Of3jEdRzG+EJjYqEQ0mzExeOjxru63GTKyAoOiTua2j5
         Dij2Vficj7pDWkET0KDRi/xKi1nX3wINxd3rOhPrQaMqq/8pcwuSBwc3ipOAex4A/cup
         f0mwh6XZo9jAEK+V/uFGANU6S16h9U2XfEi8WeIr3bO32TQ6ubhwy+JmbtS26l5LzxNm
         8qJl+AyHxemFy2iw/j95LoURcZMRNF1RFQzqJGZHBdg+v7UZdMG+fOhFlj24NvWEa4Db
         htvA==
X-Forwarded-Encrypted: i=1; AJvYcCW6beZybOMo9RneD+WRY0k/qm8b2bKD/Ggby0jYLYZU1VHs0tLH5i4dsElHfedT4kf0hefN1a3+sDJg8zVQJj0m70AAnNyEz6hI0RwP
X-Gm-Message-State: AOJu0YwthSIXuwt6q4PnNyIncrc0zvN8CpyESTjjncdLgBGbLIpMY/L9
	Z6+2feRqQMJNWsRrbxhlZVFXmSWRiFj737fBcPwWDyBNzLLs7333c+VGanUfHu0=
X-Google-Smtp-Source: AGHT+IGZUjk8whSVM3IbmFOtPtzVfpNDmJmpbJU6d7XZ6P4ZdQPc4Z+JMmnpQ9/t0xUjKfu7KDm8VQ==
X-Received: by 2002:a05:6a20:321b:b0:1a7:9afe:2f48 with SMTP id hl27-20020a056a20321b00b001a79afe2f48mr3446861pzc.27.1714760336942;
        Fri, 03 May 2024 11:18:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:56 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:22 -0700
Subject: [PATCH v6 07/17] riscv: Introduce vendor variants of extension
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-7-cb7624e65d82@rivosinc.com>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760318; l=9175;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=oHywOTliEHoaGOH+p/KAB2oes75uvxzplJdN2OqqeZo=;
 b=KbC1XYFNhZNBKPSNnQjD1psZt+bhKOmWaPHv/jdTf/wZGgSULD+X0+D7wK/zDphb/wmo3WY/Q
 awSZL38TAKpDsC86G6cf3ajysrmwSOYgS0Ch2yRXpUwemhXb4uqF+/3
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Vendor extensions are maintained in per-vendor structs (separate from
standard extensions which live in riscv_isa). Create vendor variants for
the existing extension helpers to interface with the riscv_isa_vendor
bitmaps.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/errata/sifive/errata.c          |  3 +
 arch/riscv/errata/thead/errata.c           |  3 +
 arch/riscv/include/asm/vendor_extensions.h | 97 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c             | 32 +++++++---
 arch/riscv/kernel/vendor_extensions.c      | 40 ++++++++++++
 5 files changed, 167 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 3d9a32d791f7..b68b023115c2 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -12,6 +12,7 @@
 #include <asm/alternative.h>
 #include <asm/vendorid_list.h>
 #include <asm/errata_list.h>
+#include <asm/vendor_extensions.h>
 
 struct errata_info_t {
 	char name[32];
@@ -91,6 +92,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	u32 cpu_apply_errata = 0;
 	u32 tmp;
 
+	BUILD_BUG_ON(ERRATA_SIFIVE_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..6d5d7f8eebbc 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
 
 static bool errata_probe_pbmt(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
@@ -160,6 +161,8 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	u32 tmp;
 	void *oldptr, *altptr;
 
+	BUILD_BUG_ON(ERRATA_THEAD_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != THEAD_VENDOR_ID)
 			continue;
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index bf4dac66e6e6..a6959836f895 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -31,4 +31,101 @@ extern struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[];
 
 extern const size_t riscv_isa_vendor_ext_list_size;
 
+/*
+ * The alternatives need some way of distinguishing between vendor extensions
+ * and errata. Incrementing all of the vendor extension keys so they are at
+ * least 0x8000 accomplishes that.
+ */
+#define RISCV_VENDOR_EXT_ALTERNATIVES_BASE	0x8000
+
+#define VENDOR_EXT_ALL_CPUS			-1
+
+bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit);
+#define riscv_cpu_isa_vendor_extension_available(cpu, vendor, ext)	\
+	__riscv_isa_vendor_extension_available(cpu, vendor, RISCV_ISA_VENDOR_EXT_##ext)
+#define riscv_isa_vendor_extension_available(vendor, ext)	\
+	__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, \
+					       RISCV_ISA_VENDOR_EXT_##ext)
+
+static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
+							 const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
+
+	return true;
+l_no:
+	return false;
+}
+
+static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
+							   const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool riscv_has_vendor_extension_likely(const unsigned long vendor,
+							      const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely(vendor,
+						    ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
+	return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, ext);
+}
+
+static __always_inline bool riscv_has_vendor_extension_unlikely(const unsigned long vendor,
+								const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely(vendor,
+						      ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
+	return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_likely(const unsigned long vendor,
+								  int cpu, const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_likely(vendor, ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+		return true;
+
+	return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(const unsigned long vendor,
+								    int cpu,
+								    const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_unlikely(vendor, ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+		return true;
+
+	return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
+}
+
 #endif /* _ASM_VENDOR_EXTENSIONS_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 6019b2527c46..2a5527020d0f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -864,25 +864,41 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 {
 	struct alt_entry *alt;
 	void *oldptr, *altptr;
-	u16 id, value;
+	u16 id, value, vendor;
 
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
 	for (alt = begin; alt < end; alt++) {
-		if (alt->vendor_id != 0)
-			continue;
-
 		id = PATCH_ID_CPUFEATURE_ID(alt->patch_id);
+		vendor = PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
 
-		if (id >= RISCV_ISA_EXT_MAX) {
+		/*
+		 * Any alternative with a patch_id that is less than
+		 * RISCV_ISA_EXT_MAX is interpreted as a standard extension.
+		 *
+		 * Any alternative with patch_id that is greater than or equal
+		 * to RISCV_VENDOR_EXT_ALTERNATIVES_BASE is interpreted as a
+		 * vendor extension.
+		 */
+		if (id < RISCV_ISA_EXT_MAX) {
+			/*
+			 * This patch should be treated as errata so skip
+			 * processing here.
+			 */
+			if (alt->vendor_id != 0)
+				continue;
+
+			if (!__riscv_isa_extension_available(NULL, id))
+				continue;
+		} else if (id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
+			if (!__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, id))
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
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index 03ba7949a07f..e4ef574b7d08 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -3,6 +3,7 @@
  * Copyright 2024 Rivos, Inc
  */
 
+#include <asm/vendorid_list.h>
 #include <asm/vendor_extensions.h>
 #include <asm/vendor_extensions/thead.h>
 
@@ -16,3 +17,42 @@ struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
 };
 
 const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
+
+/**
+ * __riscv_isa_vendor_extension_available() - Check whether given vendor
+ * extension is available or not.
+ *
+ * @cpu: check if extension is available on this cpu
+ * @vendor: vendor that the extension is a member of
+ * @bit: bit position of the desired extension
+ * Return: true or false
+ *
+ * NOTE: When cpu is -1, will check if extension is available on all cpus
+ */
+bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
+{
+	unsigned long *bmap;
+	struct riscv_isainfo *cpu_bmap;
+	size_t bmap_size;
+
+	switch (vendor) {
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+	case THEAD_VENDOR_ID:
+		bmap = riscv_isa_vendor_ext_list_thead.vendor_bitmap;
+		cpu_bmap = riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
+		bmap_size = riscv_isa_vendor_ext_list_thead.bitmap_size;
+		break;
+#endif
+	default:
+		return false;
+	}
+
+	if (cpu != -1)
+		bmap = cpu_bmap[cpu].isa;
+
+	if (bit >= bmap_size)
+		return false;
+
+	return test_bit(bit, bmap) ? true : false;
+}
+EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);

-- 
2.44.0


