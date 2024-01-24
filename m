Return-Path: <linux-kernel+bounces-36803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38883A6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF41C21F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DDD1097D;
	Wed, 24 Jan 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZFDiDgr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624DF9D8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092747; cv=none; b=VI1TIhhXBhs3CL6US+h5N3Hsi85iOK6RDr5zRJpPGS8ZAPb1irmwSUyeWpFUQ/soChUv5/HiqyzGN0jD113DzfRVDi12DdTQtE26yidAq6DJXg+qISAcrhWSSvp607g4FjHLlNJjssZAkQ4GUBU/57F2V1eujCsgcT2ocI2HgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092747; c=relaxed/simple;
	bh=jiESq4xR9OvldWIpk10iFyGXA9g6If22mzcQSmu5KPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ITT+7Qk7IPnj2K+oRq7nyBTO7YoYhBn4VDH0FzaXIamxexFRffHWSE1gin1iaZ7KRx54SJB3L6gxCkmJ4gpynbwf1YKp953N0jCAxNVBwbP5BHKlahJwL/skaCjM2Q5CvTgUoIitD5f7gIO98Ylcwncej1MDwWwGOqTAJHBiE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZFDiDgr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a309c0a5593so242662466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706092743; x=1706697543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTlKKIlgcuM6TP6i9JNElWzB/e2CBTO16ZN9E1BZjtc=;
        b=ZZFDiDgrePdF98B96RezKpp7Ln8ETF5T25fyXTDbAfWridan/mk2Z2xV7lms3+Oufp
         Ty9mfVg29zfHqW1YyiyAb4b/meQe3IwbMCQiln1Taxz+pbFJeHGbPnd2QS0s7VVQUFoP
         QQiB6SaKcsoRfV0AwR8n2Z8/h6S4SX+dEPENhqvSAQdloJUNsozSUzZoXV8kDMpwmNIy
         ybFMxzgu4kIezyuWFfmG8k+hQbYHVuHvRaS65+kk8hANBQuA3dMVeOsoNX9JOsJ3hpmB
         /CFQ07KKNinppeMZ+ZTYJh6CM1YqLMaM6tUBPLxmdONIvL92rSPKK4X04qog4BdybwQX
         HhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706092743; x=1706697543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTlKKIlgcuM6TP6i9JNElWzB/e2CBTO16ZN9E1BZjtc=;
        b=veQ6fe7jixJ9LEyWVHCiirXj+P6ihDfAJDcxbQOknFo1TnYA2JzdcmbA3ZPenhZrhg
         cvKAX28M4qjKMa8dFwsY8qfebOeWT66nnMEluLnTCEKOwf4/O6QCPLQb/sqPqy+17BR1
         gsCpItZuE8qcn7vSkoQGcLg5eeUbXQg51MdPC5t0+4JRldMJNtVUG/hDVzexVUumn36B
         g29QukKCKF2RDwD+0a3rKHfiaMCs9rv15S62ccdkbnh1rFtck++4KJzNIeYgagRTir0f
         Pft67/31XDRuK55SOVpoP7CimShVPoITTnImHkCuXQ6mtVt6zOHxdW+mCezJPHdogF2D
         pCpw==
X-Gm-Message-State: AOJu0Yzqae9NICUtp+C+Ys91QEAdl9t0sbQQDz/O0Qi+oE5vrPkSTpgD
	VLqokgvSlkpjWwItR6gFJ/Ilrr2Tq8sUthaqCZWnACBhKX8OZJjS
X-Google-Smtp-Source: AGHT+IE+ijkssgkDlSbmj69sf+O5YIUS5bvfntyQAIMQGaHj5cAWYkUwHZVBMpu8EMuveV18zbTwoA==
X-Received: by 2002:a17:906:3950:b0:a31:10f5:cf15 with SMTP id g16-20020a170906395000b00a3110f5cf15mr277113eje.196.1706092743208;
        Wed, 24 Jan 2024 02:39:03 -0800 (PST)
Received: from localhost.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ps11-20020a170906bf4b00b00a2f1888ddecsm7124755ejb.166.2024.01.24.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 02:39:03 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Use 32bit xor to clear registers
Date: Wed, 24 Jan 2024 11:38:59 +0100
Message-Id: <20240124103859.611372-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86_64 zero extends 32bit operations, so for 64bit operands,
XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
a REX prefix byte when legacy registers are used.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/head_64.S         | 6 +++---
 arch/x86/kernel/sev_verify_cbit.S | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index cc3a81852e4a..ed287170c126 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -171,7 +171,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 
 	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
-	xorq	%r15, %r15
+	xorl	%r15d, %r15d
 
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
@@ -180,7 +180,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	movq	sme_me_mask, %rax
 #else
-	xorq	%rax, %rax
+	xorl	%eax, %eax
 #endif
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
@@ -297,7 +297,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 .Llookup_AP:
 	/* EAX contains the APIC ID of the current CPU */
-	xorq	%rcx, %rcx
+	xorl	%ecx, %ecx
 	leaq	cpuid_to_apicid(%rip), %rbx
 
 .Lfind_cpunr:
diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
index 3355e27c69eb..1ab65f6c6ae7 100644
--- a/arch/x86/kernel/sev_verify_cbit.S
+++ b/arch/x86/kernel/sev_verify_cbit.S
@@ -77,7 +77,7 @@ SYM_FUNC_START(sev_verify_cbit)
 	 * The check failed, prevent any forward progress to prevent ROP
 	 * attacks, invalidate the stack and go into a hlt loop.
 	 */
-	xorq	%rsp, %rsp
+	xorl	%esp, %esp
 	subq	$0x1000, %rsp
 2:	hlt
 	jmp 2b
-- 
2.31.1


