Return-Path: <linux-kernel+bounces-131104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89283898321
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E47A1F2365B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8386CDA9;
	Thu,  4 Apr 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l57NwANl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630B6BFDD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219148; cv=none; b=J3WfvXTGVz88aNKaKKsnl4YXDehYw0lKKY+txGsw8I34JSOAdRMZGEJdxN0kY7r03DA5DxvX37HpOYo0B3TmcEPvv10d8dYPM4EiQOG+TQEu4Hyw/63GNc5kZXSWnfeQhdAw5dgqhVuOpKZ+egg2YVkzxzU+vIoGb+wkd+rp6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219148; c=relaxed/simple;
	bh=Ujtt7PUitT2LhlFg4hJAKIFKuLDTPhNLl5mxqkG2A1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+Bhe2sYPJ4z0gXojwS0RuL/sXwgUo3BRP8+kbtJJCElyLrBpLPVGLB0lOtBXD2hLro8u5f1AtlYw+uPfmVns+FKerf8YBkdPZmLnEoPNHGClO/+DLqaWHO+aezV98UePNLY0v2soaaCm96XN0nylEMC29/xOO4vx/CvIldo9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l57NwANl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso1022212a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712219145; x=1712823945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaRhVsW+Osi8tFbxhyHj/1j4S4hCFKuKMtMxsIQC1S4=;
        b=l57NwANlH1gaJ78b2AWCDDHvO1XLfWmWPEhi0E7pEPUOxTqPmFp/woQXPUli8opYUz
         SFDGa3bO+Rs0M1OVCKfucK14r1TVLopOJc/cCqN0OEra5IKOUtgRsVqyTH7n4OKSGsPY
         Hueswo5JBrryn6ckDaCIJm30BkXgNV6BzNY9T82R+uOQrA+xygopn24hxH+Au2ZO27sk
         67WbPwkwEStgoLV3dyx4N1alBx+LTo5ChUG67O7Vv13KoaN23/2OIMqusDw2SYJGKM2n
         IhPaNp7xLSt6oQXRxI2GBLosDz1pLFgXEEKssrByrgZKR4iAD/4X6mj/tJX72sxP7PAc
         9vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712219145; x=1712823945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaRhVsW+Osi8tFbxhyHj/1j4S4hCFKuKMtMxsIQC1S4=;
        b=rsioNP86cv3RthlnS11gFZ9qjiIImZHiYXIRaLOau7U3VNnFpQY3RH2kqvjPwFjVWQ
         MFR0SswTjR0illIPTjUrjCFOleN6Wyo9JWa3osT5YNKkSj5rrdWqnIQ2zscXIFHkDMUc
         iWP9Bdnej37lTRfQO3s6pN2M9i7tl4unHuUG4KXU4jEGhjNPgQzvl+ZyV8ACrZZEhBea
         D3CycSTALsEhA0Wys7WUVSwAjaIOnmCqs/HGByeZ+iZtuI+jtgQo5Veiw7EjI7kA6CBL
         0QWjACui60A+dnw738GAe+SH6MvI4MYnqf5kaP+DD21QYEO/NehPbpsP84Bkc/p/fQwm
         pPOg==
X-Forwarded-Encrypted: i=1; AJvYcCUoRsY9ml1tLBD+zJl+u2r9Q69wAaeWDYkkPThlvj/GwhX/TGr1XS/3rtg54bueCulwXQI5Kt3hXyoq4gyH9VMMYRG5Vf+xbnEct++g
X-Gm-Message-State: AOJu0Yxc4ajE1PU64a4RFcQp6O5GmG+fArC6GT9LLus872jdGeCS4G7L
	7fhfOAz1rA4HH/9zydjJJp5JxIovUpKSKd82ftv8AlYfhGJfprGJ
X-Google-Smtp-Source: AGHT+IGGtlkF00obLRH1UUiXKkjkyeQrkmKBv6BjEZgJNDdNIOzHVPioMqt2DJeYHfIsX/nhPec/NA==
X-Received: by 2002:a50:bac8:0:b0:56e:1128:baeb with SMTP id x66-20020a50bac8000000b0056e1128baebmr1191281ede.27.1712219144643;
        Thu, 04 Apr 2024 01:25:44 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id k3-20020a056402340300b0056e06d5a301sm1705332edc.20.2024.04.04.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:25:44 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Introduce raw_cpu_read_long() to reduce ifdeffery
Date: Thu,  4 Apr 2024 10:25:19 +0200
Message-ID: <20240404082538.357682-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce raw_cpu_read_long() macro to slightly reduce ifdeffery
in arch/x86/include/asm/percpu.h.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/percpu.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index d6ff0db32209..3bedee1801e2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -59,12 +59,6 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_X86_64
-#define __raw_my_cpu_offset	raw_cpu_read_8(this_cpu_off);
-#else
-#define __raw_my_cpu_offset	raw_cpu_read_4(this_cpu_off);
-#endif
-
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -76,7 +70,7 @@
 #ifndef BUILD_VDSO32_64
 #define arch_raw_cpu_ptr(_ptr)					\
 ({								\
-	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
+	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off); \
 	tcp_ptr__ += (__force unsigned long)(_ptr);		\
 	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
@@ -563,9 +557,13 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
+
+#define raw_cpu_read_long(pcp)		raw_cpu_read_8(pcp)
 #else
 /* There is no generic 64 bit read stable operation for 32 bit targets. */
-#define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
+#define this_cpu_read_stable_8(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+
+#define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
 #endif
 
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
-- 
2.44.0


