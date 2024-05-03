Return-Path: <linux-kernel+bounces-167234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554C8BA62F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11032841EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6313A3FE;
	Fri,  3 May 2024 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IzvZCE0P"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD7139D09
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711613; cv=none; b=EOJjv25p0SOcIGk+kiTaoMS2nGG+sOZu0C5EAxvZf4bOImimBYONCOrpJcF58BasOlSEWarlzLZhIH633iYlAkE71o63iRtUJLWgYSYHRoaC19GaVXZgui+hByQjZkynXLA08AFG2+6Ji+jTAYWexrJOvxUfGl2m13CrcYVBVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711613; c=relaxed/simple;
	bh=QSPmCsydTyfxAlHhsRmBtynUay/1GAkHyHkWfpyEp+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5PhLXNr1D7I2VKslrcHZsLiduKE4nwHLfePxdVPJOQDMG92FfXNPUhvGuQm5w3MD45w3/C91k7EyxCchNjp6RD/7G9dB2RCGgUYFe5UjCTYH22soiTC4pH98EwHAU82T21pWFcbYaKggnPzHU5f0Ju9ExyFn62wnf5DX21TstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IzvZCE0P; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so6909241a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711610; x=1715316410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBQeKf9LzcGtRnlVj1F4qxhW04Ec76HXmUW+/7jQ9I4=;
        b=IzvZCE0P5wxNq2Pcz8LoK6F2FDT20fC3Y5cn0+PuSvZncBgj9g8JDRgny74CAfJe2m
         Xz/zeMxFw7UYIzvztVdV2keeVC7QPJPtwlRQQZHYUuajmS9NfIihVJKCRyOqY/G60lcH
         iqcY56fGEG5L4f2c/hpRr9B+60/JZEOwR7daIiEf/7xwLAjRHyhoIc4WipNwLy6JivI3
         O5NCQrEqtRDbGAbNXZfCrUw+4kDpBH5vQXdJbQcgaXHnYDTpxGfn/r1Hr7rF3hy0qgL4
         R78emE+HTkWuE+CVueOZLA28M6yYTeUnqLNawAIRl42+vY11hcfNUlVUabpjfk7ZNtzF
         7DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711610; x=1715316410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBQeKf9LzcGtRnlVj1F4qxhW04Ec76HXmUW+/7jQ9I4=;
        b=hNprDXqjmnwbMlOizjdCifGiGoOK8acX/zdtvzPWBbFUp4iZm8rNJQtR5796ugJGb8
         ARUVhN9Fke22425x73pZ2oZL80S3oEFL9F78Nu51P73CkberMeZQXjRYpM6WYd6Fuf24
         fsZZvZxzWa8LAPcpQMEnnm1XUFl1Cb2oGeHZO2J/78tcc8MprAf92wTaEhjQoREvhim4
         lb9nd3joULynYz4QHqsKPCvQfJEKMve3mNiS8Qt093+ROeYCoTVBDbkSuGhQztFF4DgT
         8LJNzrPkHxXgRme9udTfYYrZfr7SRuPobn/dwsvEE+xuhORrx9Tpn//4K0YZtJnKTiMa
         x4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUX2VwtRJMlQOa/Kp3dHwXV19JEcdlJNAXeQTRIajnxmyI5wkRCpIbPmslsKa3OOk3p79+J1cnschc+5GhH/zWs3hYn63DAiS3QZVsB
X-Gm-Message-State: AOJu0Ywd4OEBxyTaCG07AEjuakgO104CnLA92vnDpTa/b2hErbZ/Nwfc
	rZBXYf9RJudJJDwCduPIN7pPPZb251RB8gijovXQPbLzQxtjCjDhY6Fs12uSDc0=
X-Google-Smtp-Source: AGHT+IGeo3tyFfQWmN4U868PuLMZ0+YMJkIrotJrxO/ZNFtg1TFeJxWfdsDvQ7RmK7l3VFnQ7OcTuw==
X-Received: by 2002:a17:902:d58d:b0:1eb:d79a:c111 with SMTP id k13-20020a170902d58d00b001ebd79ac111mr2479168plh.4.1714711610364;
        Thu, 02 May 2024 21:46:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:46:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:38 -0700
Subject: [PATCH v5 03/17] riscv: vector: Use vlenb from DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-3-d1b5c013a966@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=3323;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=QSPmCsydTyfxAlHhsRmBtynUay/1GAkHyHkWfpyEp+I=;
 b=SRzVfsLTREH64/M8ifdglVwJUQFC2ReeJpmBEWGyVoZtubtxasQyLhUIbG7ZELgLUo0hrouOt
 iE6lPPvY2v6AtXy4mBIWmupBskcHMXnNjNuQXUp8s1btIVmSbd6LXzk
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If vlenb is provided in the device tree, prefer that over reading the
vlenb csr.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 43 +++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vector.c          | 12 ++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..0c4f08577015 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+extern u32 riscv_vlenb_of;
+
 void riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..12c79db0b0bb 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+u32 riscv_vlenb_of;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -648,6 +650,42 @@ static int __init riscv_isa_fallback_setup(char *__unused)
 early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
 #endif
 
+static int has_riscv_homogeneous_vlenb(void)
+{
+	int cpu;
+	u32 prev_vlenb = 0;
+	u32 vlenb;
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_node;
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node) {
+			pr_warn("Unable to find cpu node\n");
+			return -ENOENT;
+		}
+
+		if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)) {
+			of_node_put(cpu_node);
+
+			if (prev_vlenb)
+				return -ENOENT;
+			continue;
+		}
+
+		if (prev_vlenb && vlenb != prev_vlenb) {
+			of_node_put(cpu_node);
+			return -ENOENT;
+		}
+
+		prev_vlenb = vlenb;
+		of_node_put(cpu_node);
+	}
+
+	riscv_vlenb_of = vlenb;
+	return 0;
+}
+
 void __init riscv_fill_hwcap(void)
 {
 	char print_str[NUM_ALPHA_EXTS + 1];
@@ -671,6 +709,11 @@ void __init riscv_fill_hwcap(void)
 			pr_info("Falling back to deprecated \"riscv,isa\"\n");
 			riscv_fill_hwcap_from_isa_string(isa2hwcap);
 		}
+
+		if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneous_vlenb() < 0) {
+			pr_warn("Unsupported heterogeneous vlen detected, vector extension disabled.\n");
+			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
+		}
 	}
 
 	/*
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 6727d1d3b8f2..e04586cdb7f0 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
 {
 	unsigned long this_vsize;
 
-	/* There are 32 vector registers with vlenb length. */
+	/*
+	 * There are 32 vector registers with vlenb length.
+	 *
+	 * If the riscv,vlenb property was provided by the firmware, use that
+	 * instead of probing the CSRs.
+	 */
+	if (riscv_vlenb_of) {
+		this_vsize = riscv_vlenb_of * 32;
+		return 0;
+	}
+
 	riscv_v_enable();
 	this_vsize = csr_read(CSR_VLENB) * 32;
 	riscv_v_disable();

-- 
2.44.0


