Return-Path: <linux-kernel+bounces-30587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BC832121
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFE7B25141
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077B23174A;
	Thu, 18 Jan 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="C8u3bvO7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8692EAF9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614844; cv=none; b=ULR8wSQ+Ktoa3AcavWe/AcqUgC/wVYhIS15J5Vp8hfjfCBQAHS4eiLHDLwM/TPsya4NmEj50i+8CxoSQE11wWKSxjrPBgkCKRyIA3d9HHXimufvtwouiWz9soWsWOOSCqEXwDkcl1KnGdut6qFkyYFJVc53pqcKI6qMjSSej4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614844; c=relaxed/simple;
	bh=0OLoge7JRZVK/JTs8M53rSZCOS6zKNIvbnryNlKfkNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fNUlYKFjQibfXmAYTXPDe6M9KCpz7kVIhnIXdBjTl+5sieQ+cgsO+66lMwG06lEtOJ8YCCIWUCWoJhikirZVUHCQBstVDD1RuAlraX6rBVpGTMRQTcHZbcV2VGJbf+YpedlxAlAacPs2p0xmQRFJTq9hgSaa2U3wQWLhpA6PJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=C8u3bvO7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so828399b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705614841; x=1706219641; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ykJGA57/c6XjRX+/wiozqy8iJ6Vsrt2RLKtiLpKiLM=;
        b=C8u3bvO7oxhgginUEjQzW+277qLH3R4XqiYXdi4z+KsPPXPEq7lceJzx1p1os6UKFt
         zUaGS53pZUomjlGD4JAUIcV4DQH/KW5XaF6cSOqqzxVqgTk8r09FDyKi3nE+NSCllQw7
         wueWI6E42J/rwk4Ca07/cZm7rVJ7p5NLjQxtfJOKk8dWYSPIIxGOMsbbzb2+MUru5asx
         OMq1/yJvjyHwxWe1JS80uDYOJPBckJcphpEJj5z6QLVcCKOxkyOtVbK5F/er37Rs2GaF
         TW9wNwZtHum51NvCM7HvkDUFNtPLFuuasFs4kckwwtkguU6ibJFZxpMy5Ml7ql3Zy6Oe
         NXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614841; x=1706219641;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ykJGA57/c6XjRX+/wiozqy8iJ6Vsrt2RLKtiLpKiLM=;
        b=ewXDKk4E/eIRlFrMyOqomaUfz/6w1SNTfVEbo8odr4SIXpY9DPai1bSHeLWt9XZea2
         HNK/noHBNyUvKPRfV3f5G1SCGim1Aa+/OC3Qd/HDiUgb/sSAAMRKBLG23zOazuzrNAAd
         R56G5S1qejRLyw5R+MnsPTmhO9akvgK1wdAV1sCgu378B+Zs21GIzsA7DuLjz4pB+vE/
         KV7oHnPiUPrIF+pNG7w6wlh/Z/m9xK9odjmLYxPo7uSVoGsX5TRXbFLGfbNLsKgGrpKA
         DVYL+paZdaycHmjVlwSHGFBRR5sIpDZTN0QgJGi/uxw+/HM+X3vOkjwkKVmOo5ebv0hT
         TM+Q==
X-Gm-Message-State: AOJu0Yz1mHcuGolKCQDltshopWMSsiIbkHakrcLIGFYAGqnX1wG27B/m
	jV17qEjOdaQ3x7YAgdGEEUMQgNoOghFhz8lWcm4ESE6Hylh26dq4YwIknxwMG92QahwLedICtFT
	j
X-Google-Smtp-Source: AGHT+IFmbmT0nzrJVhkhIeOG1uqqUQ5TnTG1pxSQSR5fbID+PWzb61gZ7b9wYB/SkmypR7VVqfsHEA==
X-Received: by 2002:a05:6a20:2dc:b0:19b:1da4:8dc with SMTP id 28-20020a056a2002dc00b0019b1da408dcmr18728pzb.34.1705614841620;
        Thu, 18 Jan 2024 13:54:01 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j15-20020aa78d0f000000b006d9c7f2840bsm3771459pfe.57.2024.01.18.13.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:54:01 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 18 Jan 2024 13:53:59 -0800
Subject: [PATCH] riscv: lib: Support csum on GCC <11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-csum_remove_output_operands_asm_goto-v1-1-47c672bb9d4b@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAPadqWUC/x3NQQrDIBBA0auEWVfIiNCmVylFxEzTWeiIoyEQc
 vdKl2/z/wlKlUnhOZ1QaWdlyQN4myB+Q97I8DoMdrZuRnyYqD35Skl28tJb6c1LoRryqj5o8ps
 0MW5ZrI3oMNIdRqpU+vDx37ze1/UDe5WzqHYAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705614840; l=2787;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0OLoge7JRZVK/JTs8M53rSZCOS6zKNIvbnryNlKfkNs=;
 b=dJpuJl1dFpZjTsUOyTWIxBNNNkZvncdUMycB4TzPg8EkchYbaXeZWzM0gJrYusU4KUPaoHcVO
 XLWURTe24UwBbkRTIcQdUzshBpJFlZdeoMxWOC8rVKRzmO3g1hoiBq2
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The OutputOperands field for asm goto statements is only supported
starting from GCC 11. Split the asm goto to remove the use of this
feature.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: a04c192eabfb ("riscv: Add checksum library")
---
The OutputOperands field for asm goto statements is only supported
starting from GCC 11. Split the asm goto to remove the use of this
feature.
---
 arch/riscv/lib/csum.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 06ce8e7250d9..23be289f52b6 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -177,22 +177,35 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 				  : no_zbb);
 
 #ifdef CONFIG_32BIT
-		asm_volatile_goto(".option push			\n\
+		/*
+		 * OutputOperands in asm goto is not supported until GCC 11, so
+		 * this asm has to be split to be compatible.
+		 */
+		asm (".option push				\n\
 		.option arch,+zbb				\n\
 			rori	%[fold_temp], %[csum], 16	\n\
 			andi	%[offset], %[offset], 1		\n\
 			add	%[csum], %[fold_temp], %[csum]	\n\
-			beq	%[offset], zero, %l[end]	\n\
-			rev8	%[csum], %[csum]		\n\
 		.option pop"
 			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
-			: [offset] "r" (offset)
-			:
-			: end);
+			: [offset] "r" (offset));
+
+		if (offset == 0)
+			goto end;
+
+		asm (".option push				\n\
+		.option arch, +zbb				\n\
+			rev8	%[csum], %[csum]		\n\
+		.option pop"
+			: [csum] "+r" (csum));
 
 		return (unsigned short)csum;
 #else /* !CONFIG_32BIT */
-		asm_volatile_goto(".option push			\n\
+		/*
+		 * OutputOperands in asm goto is not supported until GCC 11, so
+		 * this asm has to be split to be compatible.
+		 */
+		asm (".option push				\n\
 		.option arch,+zbb				\n\
 			rori	%[fold_temp], %[csum], 32	\n\
 			add	%[csum], %[fold_temp], %[csum]	\n\
@@ -200,13 +213,18 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 			roriw	%[fold_temp], %[csum], 16	\n\
 			addw	%[csum], %[fold_temp], %[csum]	\n\
 			andi	%[offset], %[offset], 1		\n\
-			beq	%[offset], zero, %l[end]	\n\
-			rev8	%[csum], %[csum]		\n\
 		.option pop"
 			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
-			: [offset] "r" (offset)
-			:
-			: end);
+			: [offset] "r" (offset));
+
+		if (offset == 0)
+			goto end;
+
+		asm (".option push				\n\
+		.option arch, +zbb				\n\
+			rev8	%[csum], %[csum]		\n\
+		.option pop"
+			: [csum] "+r" (csum));
 
 		return (csum << 16) >> 48;
 #endif /* !CONFIG_32BIT */

---
base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
-- 
- Charlie


