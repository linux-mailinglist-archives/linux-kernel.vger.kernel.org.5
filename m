Return-Path: <linux-kernel+bounces-141896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3078A24D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B6A1C21051
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11B844C8F;
	Fri, 12 Apr 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="omNHnArY"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386B40BE3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895109; cv=none; b=hcWpfio3JZpAzI5w4nOQeKnmxuBqhPSNYAymi7Gt6h0iwGcEL4S1i5IVEkzSl+Pubp4vET+1hGJf4inYrB/5vocrxJpIwXKdErmb5ctK9ivm4V+eddnKrcjHjUI4LKK2Nfg4WkxWP/kK0mjB8Q20M7fVYnlIS8kOS0Y70n+43cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895109; c=relaxed/simple;
	bh=I4DbgrMsTBCO63AVmMsC/HIGAx6P8ZOknXvrmCDZIY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWWunASKfzpV0coReyt81gJW0aQjnpIJMrNTuw5re4nmUmUlufPzJLaS7yr9IXYcr5aEGJ9A2zmYM/lqAwUSJ4sJ+/vBNj2wNmeoZOeAToRhR+EbxDm7Ht+GJCr2etMqZH96DanG781EUYfjWqDiNErQqzCu5xsCg6+4fiEU6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=omNHnArY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so342635b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895106; x=1713499906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9+s4vuTW4O09tkDCg8dmEEEUenyonlJ0q5BZhMXfDU=;
        b=omNHnArYUUyH1RajCpEtoTgjc71vHdSvYv6hgQ8ZZ8OdtJnWQVE62PsZ2r/aKVlyF/
         FUWbCQLyCcXppTmtoZ3glmBtrGperqocJfOSGblmwT3yD6l6fxRbkCWgRSUkE3oQ1UVa
         A5gno18yj03aLvkpV7xve6gjNt3vkyhF4Lj8DqNFCcu6UuadYXPtTQ3xn2+p9EwRKAC3
         aSjoyQavUKQrMq+h+EVqPfPTpXmo5tizr5ebmWQB4UaccKAdVVCQRcTPoc+6z2G4zyGM
         ZdesiZFW3itjR3RUmDnzC71Xce1D5xPZG9M5rI4NhtgPc3vE77apvq5qU/Br1v5HZD25
         s4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895106; x=1713499906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9+s4vuTW4O09tkDCg8dmEEEUenyonlJ0q5BZhMXfDU=;
        b=r8nIpsPckDxcl1wNkslkxhDYuvNNECUQSzbd1TpaYBEumpht1wdJyf47JDUis1WrV+
         aIAOFBDkHo/+uwlv7MkFxFJWaLCT0EDtaGZiRufRe0SpCDGG0C1oNo9CRvo9/CBx/UL8
         Qks/egMKCqjYq/QUOFZT+JtQXa18I/cAQXPETh8wwl5r/f7uw++MrsmZkBcrxmtl8/Nw
         whsRkaKpZ8rex0dIM5rJwvIkTFivzRI0D7m2at1SiyZTUYN5NLqdV2Mktj40Wg33Ax6a
         IO00TzOoDgD88D4r5qzpb0kxNz6enPbj8Qejl7nAF9UnwTUIkDOJ6vwI4K1H7KBsIj3f
         x8KA==
X-Forwarded-Encrypted: i=1; AJvYcCWWEAPl0GTuICjFUhyxTkcg7Ef0tGLw6aymiNBrfD1uUqleF7cP+0o4hFtX1WBEUZ9Oqj2TZNDstR2EkZyd4FJxq14LaxLH4XtvNPz/
X-Gm-Message-State: AOJu0YyDaIZ5AEOex4PcgTbl1C/LAoMt2AoECvnWkWKVY5yOYUXtU1G9
	KNtghWa8PqCehbMtFTIzKD2MxCQeRqreXXOkjIhrpxRs2UO1oLGPCeh81Uwmiw8=
X-Google-Smtp-Source: AGHT+IFLbxw4GiSg/ByrR6Zcx1dkr/NaC0J9B/mADVNgKiwb6LsbkIMIsxPTTQPOOHXCd5XYh+1AKg==
X-Received: by 2002:a05:6a20:970e:b0:1a3:6f13:b11b with SMTP id hr14-20020a056a20970e00b001a36f13b11bmr1803234pzc.4.1712895105976;
        Thu, 11 Apr 2024 21:11:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:45 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:13 -0700
Subject: [PATCH 07/19] riscv: Optimize riscv_cpu_isa_extension_(un)likely()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-7-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=4166;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=I4DbgrMsTBCO63AVmMsC/HIGAx6P8ZOknXvrmCDZIY4=;
 b=EvPgOFFZdWvIqnY4Ic2o35NkUj0RQYLXh0IE5My7noLrOP062aeYS8S08JVkR8nyIb5gwvMy4
 gV06VoydcEAA98GwhTPINJxjuG2LNDmVI+M9j4labOihPcqFd7KizaX
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

When alternatives are disabled, riscv_cpu_isa_extension_(un)likely()
checks if the current cpu supports the selected extension if not all
cpus support the extension. It is sufficient to only check if the
current cpu supports the extension.

The alternatives code to handle if all cpus support an extension is
factored out into a new function to support this.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 84 +++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index b5f4eedcfa86..db2ab037843a 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -90,22 +90,13 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
 
 static __always_inline bool
-riscv_has_extension_likely(const unsigned long ext)
+__riscv_has_extension_likely_alternatives(const unsigned long ext)
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
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
+	:
+	: [ext] "i" (ext)
+	:
+	: l_no);
 
 	return true;
 l_no:
@@ -113,42 +104,63 @@ riscv_has_extension_likely(const unsigned long ext)
 }
 
 static __always_inline bool
-riscv_has_extension_unlikely(const unsigned long ext)
+__riscv_has_extension_unlikely_alternatives(const unsigned long ext)
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
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
+	:
+	: [ext] "i" (ext)
+	:
+	: l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
+static __always_inline bool
+riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely_alternatives(ext);
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
+		return __riscv_has_extension_unlikely_alternatives(ext);
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
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && __riscv_has_extension_likely_alternatives(ext))
+		return true;
+	else
+		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
 static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
-		return true;
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
+			   "ext must be < RISCV_ISA_EXT_MAX");
 
-	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && __riscv_has_extension_unlikely_alternatives(ext))
+		return true;
+	else
+		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
 #endif

-- 
2.44.0


