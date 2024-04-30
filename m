Return-Path: <linux-kernel+bounces-163650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE78B6E17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E421C22B49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9491A0AE6;
	Tue, 30 Apr 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW1bfw1u"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338D19DF44
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468729; cv=none; b=OYkdeP551yFooi0fP7cGL5xWftb1MqcQXhBv4WHgzLvtnLA/Fj6CDiesOnYFNlbj6+SXZWmIJT33WVbUiT3gAnHuP4FFzGInz1Pubbm5pwnZn81OiJk4MCZyTLCbww7Pw+3FmPckvHOUZdhOUtEZ1edjxctC8eSfp3evuS4m9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468729; c=relaxed/simple;
	bh=N4cOlsP6Re2OfaJYU9rp11lW6ES+Oty8vNXeNpGbJwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGyTdDjcmL8As05rLiww1Hk6xftZUIZOQ8EjOQ4U1ncSP+ATI4KqCpOClA5py7R+n1WH49g7Rgz775kjQXmD3Ah5gJAc33uZ9tJKYVDTWwf8QJ4jv+dW40Ha5Tgfff8N8pXwgwbARijUmFJvfmCM/MHa6vrb/XyTk0EGJapm3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW1bfw1u; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so23345135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468726; x=1715073526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0z6yAuUGmkHpIOif4QhFaujrdpN0zCwlr38Y//zbXA=;
        b=nW1bfw1uEvmowZFA0mOUXgFgneRho3KlVJe1NWveAEi+aQNsD+epUQS+n4OBEmDbvr
         t0bAQ3A6x6lKQYV4xqrGGAzkHsc2rWDauy5PfToQlP9/QMX8ugMMFdyF7aGUPWoUe3ze
         1DbSvW23M4cAjs2N7CAm2ky68xvUsmAfwVeI/nQyDGoqXwnuuURnS69grInk2pE/TqYz
         ZZwdFhJIbcMclz9XaVnhscjHhlCLgEcD+6dIEmiWYm2uX44Fjb6U21GQijy5OuzLjtn4
         nKCJmj6e9pR62rQ/qzKLOeRKnrD+KtFCJTxUDSk69Lfo9fLm3ZjP77EWsPPg7bu6W47P
         fY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468726; x=1715073526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0z6yAuUGmkHpIOif4QhFaujrdpN0zCwlr38Y//zbXA=;
        b=CW6R9Uhrxp/6lGfNHrPwHJHAkeU7oH0m86TgmXYqt2SjwiAMPFQgKneD4hRPSX548N
         upx0apn7k3VDr3YHVB6P+ZZK5+8x9MZ3MaAFWHGDN3M2+LWIT6i/JDoXQkGZqgSKALVz
         MGITX9mqQBIXNr/1hnpsoB3ktwr70w1/TK/H81CHWxZE1nkTuboAjxPFFZ6uVl4VzQ95
         yCNOH/QM8/dUPE9jaZjgchwMBhi0V3Dq3D9p84FUmugXdkYS9dN/1z1ST2g+K0NA1TWk
         Blk7bNDbYnBNeEiGTTo3B4THrupdy6yBqdWGdpEuZg3N9VXq4MBnfyJ+LjOURBDEWZ61
         BbQA==
X-Forwarded-Encrypted: i=1; AJvYcCVnhBWZXvvRBH9TgNkuVpX8wd98Z6ui7VussNacUhfP362NjiHmZH8C/bpznvdudb2ovxgA9O23toiF7Q/dq81Ht4SQcYbFvCNujI6r
X-Gm-Message-State: AOJu0YxrYSQjsdTGxdtVovoKWxiwc0SvpXtq9Mypf5RVlpetZ2flOa1n
	ZOs5WxJswnj8zJFUrZ66GrtX/CnLf4jIcmhEJAANy6pBuVOBBuz/
X-Google-Smtp-Source: AGHT+IFWFR2y9jNQfaimGsLlQ3wnwl6F0IRL8EyNa8aXlmNfEmeoN8mBy26u9jy6WOzZT8rbm1avlg==
X-Received: by 2002:a05:600c:cc6:b0:41a:446b:10df with SMTP id fk6-20020a05600c0cc600b0041a446b10dfmr2018175wmb.12.1714468726014;
        Tue, 30 Apr 2024 02:18:46 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c314300b0041abdaf8c6asm26324458wmo.13.2024.04.30.02.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:18:45 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 1/5] x86/percpu: Introduce pcpu_binary_op() macro
Date: Tue, 30 Apr 2024 11:17:20 +0200
Message-ID: <20240430091833.196482-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce pcpu_binary_op() macro, a copy of percpu_to_op() macro.
Update percpu binary operators to use the new macro, since
percpu_to_op() will be re-purposed as a raw percpu write accessor
in a follow-up patch.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 47 ++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 3bedee1801e2..cc40d8d9c272 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -163,6 +163,19 @@ do {									\
 	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
+#define percpu_binary_op(size, qual, op, _var, _val)			\
+do {									\
+	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+	if (0) {		                                        \
+		typeof(_var) pto_tmp__;					\
+		pto_tmp__ = (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	    : [var] "+m" (__my_cpu_var(_var))				\
+	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
+} while (0)
+
 /*
  * Generate a percpu add to memory instruction and optimize code
  * if one is added or subtracted.
@@ -182,7 +195,7 @@ do {									\
 	else if (pao_ID__ == -1)					\
 		percpu_unary_op(size, qual, "dec", var);		\
 	else								\
-		percpu_to_op(size, qual, "add", var, val);		\
+		percpu_binary_op(size, qual, "add", var, val);		\
 } while (0)
 
 #define percpu_from_op(size, qual, op, _var)				\
@@ -492,12 +505,12 @@ do {									\
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op(1, , "and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op(2, , "and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op(4, , "and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_binary_op(1, , "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_binary_op(2, , "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_binary_op(4, , "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_binary_op(1, , "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_binary_op(2, , "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_binary_op(4, , "or", (pcp), val)
 #define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
@@ -505,12 +518,12 @@ do {									\
 #define this_cpu_add_1(pcp, val)	percpu_add_op(1, volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(2, volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(4, volatile, (pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op(1, volatile, "and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op(2, volatile, "and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op(4, volatile, "and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_binary_op(1, volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_binary_op(2, volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_binary_op(4, volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_binary_op(1, volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_binary_op(2, volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_binary_op(4, volatile, "or", (pcp), val)
 #define this_cpu_xchg_1(pcp, nval)	this_percpu_xchg_op(pcp, nval)
 #define this_cpu_xchg_2(pcp, nval)	this_percpu_xchg_op(pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	this_percpu_xchg_op(pcp, nval)
@@ -543,16 +556,16 @@ do {									\
 #define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
 
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_binary_op(8, , "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_binary_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
 #define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
 #define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_binary_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_binary_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
-- 
2.44.0


