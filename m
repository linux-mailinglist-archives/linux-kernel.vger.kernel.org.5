Return-Path: <linux-kernel+bounces-163652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5798B6E19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CC1F23FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919941A0B09;
	Tue, 30 Apr 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDToXJPd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC40199EA9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468730; cv=none; b=EknW+Xd8bFTMpsmpOxXKCYCuUwOe3Bo9rFopVY2so9IKjRPtVEND01JDOVaACsGNgw//cEVtfkPIFpkRygPQtMn7RXp3Ww3QplD9TX/UkDEbR3EIfunZvAz1nav8hEs8VsUiw0YwYlmwt8ysD6JVdZkjhF9Nq8KFynF5+8nLWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468730; c=relaxed/simple;
	bh=tJvY56fdqODF/otf5S9LFgWCFu3KQCzEmyMf/rhBdw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYnCB2EMSi6rfNXlF4YEAuX8tWwdal0y8pVTIyZNTz6S5eKwRflIqpJCdCXmK5Cyyq1LhscqSCLUIumKqKUtt73bKmoxvNqrXmBC8FyHaMmkPJyqCqA42KUEmOEVfYUlhVpnqpz3L+u5cQUkw4Utcqj6bpHoGi+QZkIBAT3UnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDToXJPd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso70692781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468727; x=1715073527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LLLnWdNElNO0slNMDGylj4O+77CAku3wah8g+GLA70=;
        b=bDToXJPdOsZWvcq0QrFSi/fFdeUMPd9bA46qdKh7q3W8ZIvbpRISvFgGcj6nFQ4D7m
         LuCzD6kaLiaF6KLMD1bTV0v0KaKHgeHTw3GG3F1QezLaow+uUjDrvP6dXBfT4GA0Pt7T
         dUX2C4xh/5bAqPLn1MuCObwhcykvtdDfqWkIv2NFjyCi9zR4z+X+kPgOHh+j++Yhh+DZ
         nfW3nZG0c1MMC3YGSAM3Jws+Dh4uwNmAkq9qjKxieASX6xXEU5/2RhILCQa9cIUMgZyQ
         rI6IBHaL2/RjL+hQ54rIYr14B2EpYbiGqzcbpBhpavRxYK9+6jXua//s/6kYaViFDNoj
         bw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468727; x=1715073527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LLLnWdNElNO0slNMDGylj4O+77CAku3wah8g+GLA70=;
        b=niDs0irTwv+YBwf3EtriAybPeVD3pZNvI/kRO2pgbcSNJF+Tq2WvXJoefrv14PZshK
         9CpEet6sr/otnwcp7l6DasGWwKP4oUFgqZ+YF+5gw8fMpd7PXCir2FHjX639rSQ5JNwr
         13Gc5OlzPY9r1aM/aihtY17hZ0T0iBV56+nRPktzrEI/34fgQxuJM89r3QFg66QAAkvA
         MM8bDeMHlKwVyCGyMb+B6hrWgYWYDhkwRuQIzQZro9MzxSn19ov6bq1xAW+w5ScWEAl4
         guoAx7Pp5BLU9O6SvyaTJGjsRM6vmqADvU74V+EJs4smcr00dFcCf46NbjOqu7jS7/EZ
         L6aw==
X-Forwarded-Encrypted: i=1; AJvYcCWdw25jKslfF1ASjM60KnR3YEY9608wxTwgR+DmQnrbpZW/sGLeUYS0aIAsKtH4HduApMta3fs++Iuc8l7mJI5GqYWFJi2jquo7Pixt
X-Gm-Message-State: AOJu0Yz5pBi8fPSlcNO5NEpYpOIGux56M3sSTf9ecBL00HJdKJ88MhwJ
	5/0TUGzH6+39/U6hFZHZzPrtKOoDL3/7x8yrTLjj75EF1gU2Fp3r
X-Google-Smtp-Source: AGHT+IEFvyqwpBpG97Zi4ez4/vfwnKNbXUtHZsS5KqoeoUJ9ngdQnLR4Vz4fNxh8wcJkV8N0r3uo/Q==
X-Received: by 2002:a05:6512:2342:b0:518:96b5:f2c5 with SMTP id p2-20020a056512234200b0051896b5f2c5mr11047336lfu.46.1714468726779;
        Tue, 30 Apr 2024 02:18:46 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c314300b0041abdaf8c6asm26324458wmo.13.2024.04.30.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:18:46 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 2/5] x86/percpu: Move some percpu macros around
Date: Tue, 30 Apr 2024 11:17:21 +0200
Message-ID: <20240430091833.196482-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430091833.196482-1-ubizjak@gmail.com>
References: <20240430091833.196482-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move some percpu macros around to make a follow-up
patch more readable.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 63 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cc40d8d9c272..08113a2e5377 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -144,6 +144,29 @@
 #define __pcpu_reg_imm_4(x) "ri" (x)
 #define __pcpu_reg_imm_8(x) "re" (x)
 
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+
+#define __raw_cpu_read(qual, pcp)					\
+({									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
+})
+
+#define __raw_cpu_write(qual, pcp, val)					\
+do {									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
+} while (0)
+
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
+
+#define percpu_from_op(size, qual, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "m" (__my_cpu_var(_var)));				\
+	(typeof(_var))(unsigned long) pfo_val__;			\
+})
+
 #define percpu_to_op(size, qual, op, _var, _val)			\
 do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
@@ -157,6 +180,17 @@ do {									\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
+#define percpu_stable_op(size, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "i" (&(_var)));					\
+	(typeof(_var))(unsigned long) pfo_val__;			\
+})
+
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
 	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
@@ -198,24 +232,6 @@ do {									\
 		percpu_binary_op(size, qual, "add", var, val);		\
 } while (0)
 
-#define percpu_from_op(size, qual, op, _var)				\
-({									\
-	__pcpu_type_##size pfo_val__;					\
-	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
-	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "m" (__my_cpu_var(_var)));				\
-	(typeof(_var))(unsigned long) pfo_val__;			\
-})
-
-#define percpu_stable_op(size, op, _var)				\
-({									\
-	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
-	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "i" (&(_var)));					\
-	(typeof(_var))(unsigned long) pfo_val__;			\
-})
-
 /*
  * Add return operation
  */
@@ -433,17 +449,6 @@ do {									\
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
-
-#define __raw_cpu_read(qual, pcp)					\
-({									\
-	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
-})
-
-#define __raw_cpu_write(qual, pcp, val)					\
-do {									\
-	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
-} while (0)
-
 #define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
 #define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
 #define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)
-- 
2.44.0


