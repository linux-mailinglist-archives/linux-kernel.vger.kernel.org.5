Return-Path: <linux-kernel+bounces-111364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DB7886B42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C77286180
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC33EA9F;
	Fri, 22 Mar 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uAM/RFbB"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E44224F2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106796; cv=none; b=Rl+6zBpk9MNmH/oe7YpR5ZBFGPHo+4NnAr8WWbnjsuxfXwp0FYL1OYfyZVncvXnNt7/zRV30T34k1dRGg1TrvIbCI2/FsuGPaEQ/h/zh9nM4wYjenVnd2gGcnacodMeRFsql/EKzOe6mbCYQpVWxTiJ/J4+2iI5hUFDLU8C10cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106796; c=relaxed/simple;
	bh=IlHTDSMEWpoOg/OvTtf8nCD2S7XZ5hN8s2L8Abe+sXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrkJ6BanUFpjGqMoXoj/T+p6rCmGeupEF1GbgkmHoG/p7rm2jszmPdUnguSLXV7oGgnuQFCxELnFbc1i+1nu9Gkp6APt24t2dQNQne0v7FQ9jhzM0rygY8t6fs9gW178jSN61XYRMceycNDjV8VS1WFJ1yxUPjeRKT41WGDg7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uAM/RFbB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so2413233e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711106792; x=1711711592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNHkQfXINaqTHPg7WbnoP37edMIj0CzWXuWpl1CeMi4=;
        b=uAM/RFbBeE9jP6iuUnDYK37fr0kd+2e5B0B3CZVI2gC+k4zErPjF7TfMxw4kBRbD6F
         6tbI2dGP8nFfwbI3smIoU9l7yS9tlHTLu8VZky/AAylUy8YajRM8/Lp9uR6ZFzSNm88Q
         AbBUUpOPHNk6Ob2z6GS8kjUgjijMxoo4FLIaF6ITNEqLXbL52T5W6pfvOmq7bpg6L5pB
         yu4mVzDOGu7zFNGbNtK/uwtXZQ1f1ebcWwZgOiQq1U9GPCIfDoYTVEyKztSShdOgBCyu
         vdPhsmxEcxeZ8q5j7nT03ISMTSfAGcpA7tS+bTCrB4+3pws5CAymyHEWNelAojOB6jD2
         hiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711106792; x=1711711592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNHkQfXINaqTHPg7WbnoP37edMIj0CzWXuWpl1CeMi4=;
        b=JOgfpbtUxfVbZJUCy5Lf5VI/ENyIeO+w8iLYU55oRKilQSGzDZJ50gHo+da2V0ff6Z
         x4U1OJuAFqYMZnFbahpE5dCxfeRK85LTMUU+qmSEFpsu7E387VCVujERCHdHqSl0mP3v
         U3gtj/NIzQA4EhNZT5mcFcj87UiLhROhMp6qcziZi+ye+KITjFulxP5Ah8BRAN6L1iRG
         fBgDtSXnbMgWZ9EyGRT4nPlBr/quJ3v+MAGQ4a9DS6buQwUTPYZx7ANM8j2ydXbgtkzT
         OZT7RfAfiyslVIjEKbCWm4htOIsSnyME+lw+AMSPQ2pPw08JMmyvEKKNtoe5N0geKEhg
         n8rA==
X-Forwarded-Encrypted: i=1; AJvYcCX6HObFMnQG3sIwp95c5lMCylVq5tRWFG/HvOSwnoC7ah/y49MrW3m/aeh3NeI1vj3X9HJpVrcezpMPquoovZBVqcbb8rEh5WlRP5FL
X-Gm-Message-State: AOJu0YzG3rIUfM1OxdXiwTyhykSwudSgdhDPfy0pMoD1R3pXswnICs4v
	MYUNshVQuJHTeCZ2+Lskel9N6zw7LeyXc/TQJL7EoTnq6W7ay1tr2zPAMSmYwvk=
X-Google-Smtp-Source: AGHT+IEGMU4YT59y0B8pwbmoCMSuhVbnY4eGqGuqjNiZTutlx+9D16LHoVml25LKrooAH5BVoBianA==
X-Received: by 2002:a19:6910:0:b0:513:2992:bd92 with SMTP id e16-20020a196910000000b005132992bd92mr1311861lfc.11.1711106791828;
        Fri, 22 Mar 2024 04:26:31 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q12-20020a19430c000000b00513d82a8003sm317965lfa.160.2024.03.22.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:26:31 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Improve sbi_ecall() code generation by reordering arguments
Date: Fri, 22 Mar 2024 12:26:29 +0100
Message-Id: <20240322112629.68170-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sbi_ecall() function arguments are not in the same order as the
ecall arguments, so we end up re-ordering the registers before the
ecall which is useless and costly.

So simply reorder the arguments in the same way as expected by ecall.
Instead of reordering directly the arguments of sbi_ecall(), use a proxy
macro since the current ordering is more natural.

Before:

Dump of assembler code for function sbi_ecall:
   0xffffffff800085e0 <+0>: add sp,sp,-32
   0xffffffff800085e2 <+2>: sd s0,24(sp)
   0xffffffff800085e4 <+4>: mv t1,a0
   0xffffffff800085e6 <+6>: add s0,sp,32
   0xffffffff800085e8 <+8>: mv t3,a1
   0xffffffff800085ea <+10>: mv a0,a2
   0xffffffff800085ec <+12>: mv a1,a3
   0xffffffff800085ee <+14>: mv a2,a4
   0xffffffff800085f0 <+16>: mv a3,a5
   0xffffffff800085f2 <+18>: mv a4,a6
   0xffffffff800085f4 <+20>: mv a5,a7
   0xffffffff800085f6 <+22>: mv a6,t3
   0xffffffff800085f8 <+24>: mv a7,t1
   0xffffffff800085fa <+26>: ecall
   0xffffffff800085fe <+30>: ld s0,24(sp)
   0xffffffff80008600 <+32>: add sp,sp,32
   0xffffffff80008602 <+34>: ret

After:

Dump of assembler code for function __sbi_ecall:
   0xffffffff8000b6b2 <+0>:	add	sp,sp,-32
   0xffffffff8000b6b4 <+2>:	sd	s0,24(sp)
   0xffffffff8000b6b6 <+4>:	add	s0,sp,32
   0xffffffff8000b6b8 <+6>:	ecall
   0xffffffff8000b6bc <+10>:	ld	s0,24(sp)
   0xffffffff8000b6be <+12>:	add	sp,sp,32
   0xffffffff8000b6c0 <+14>:	ret

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++----
 arch/riscv/kernel/sbi.c      | 10 +++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..9041b009d3b5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -292,10 +292,12 @@ struct sbiret {
 };
 
 void sbi_init(void);
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5);
+struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
+			  unsigned long arg2, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5,
+			  int fid, int ext);
+#define sbi_ecall(e, f, a0, a1, a2, a3, a4, a5)	\
+		__sbi_ecall(a0, a1, a2, a3, a4, a5, f, e)
 
 #ifdef CONFIG_RISCV_SBI_V01
 void sbi_console_putchar(int ch);
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index e66e0999a800..5719fa03c3d1 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -24,10 +24,10 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5)
+struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
+			  unsigned long arg2, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5,
+			  int fid, int ext)
 {
 	struct sbiret ret;
 
@@ -48,7 +48,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 
 	return ret;
 }
-EXPORT_SYMBOL(sbi_ecall);
+EXPORT_SYMBOL(__sbi_ecall);
 
 int sbi_err_map_linux_errno(int err)
 {
-- 
2.39.2


