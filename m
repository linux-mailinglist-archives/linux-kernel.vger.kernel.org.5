Return-Path: <linux-kernel+bounces-15756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8518823153
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DE22828A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEDD1CA89;
	Wed,  3 Jan 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBVV5zNH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F61CA81
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704299576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zrl9wQMm72/9gkP6lQrsUXatEy2G8nXg2opkxwrV5kI=;
	b=hBVV5zNH5bcUvVUr78BN0rJ6sSpsIXkfNcbBRCLsNKhYL50kx6xLl77Z2FS17lPx80BLSp
	k4hh6FrYR9NFcRXDNSpbL9v3IfrhE0HdOA5CKpnqMOmuj1SliVtddEhzipx0/A2fybV3UM
	JRawnwTuE7a4u0RBuet29qmiYTYNkgo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-tx-pRf50NYy0reYBYCI21g-1; Wed, 03 Jan 2024 11:32:55 -0500
X-MC-Unique: tx-pRf50NYy0reYBYCI21g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d4bc42624eso23481355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299574; x=1704904374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zrl9wQMm72/9gkP6lQrsUXatEy2G8nXg2opkxwrV5kI=;
        b=Uf800widcdWGM/e8KiMavEDaacqWQ3XPu971UpDSmGrx6Wf4sSellj+mVv9+iWZSYF
         VeIFiBxQkydsobCv4OIqYxCt8HTmBGjFMpTqKwysmlZMlhTsU1tXACfCTeYyF4CoMQ0t
         VXeLd5ixzU6VA6F02+dJpz7hVLI5sYjiWlENo0msmtciwuPQbqeDeCnBPh7WmotGYtZk
         G29BjQM6jQyZMkDX4niN6LdrUZJrRhfDqjL7VyY7XHFTMv7t/sxcFN5GVLu5hCJMMbAa
         EjvYV5d09p4T/wp+vE/Vo7V8VXLF3v1UoY7K4OnlhWrtzFyQIZg/gsy0MMrRrX4kvN/k
         PrdA==
X-Gm-Message-State: AOJu0Yw65FAXAxFTS0xqc/sF3MqHdfrakF2ZU5iF7ylzDHEdbViPkJvZ
	xLCZsrddxsEKtxhlXc9w81218ZHKIzM6+qAq29ZlyGH10serR82uU+qp66q4/mtuAlE7cgrAK81
	Nnz3MkoJ2ZBikk6E3UZA8MFeapVey/EPJPZohmiKg
X-Received: by 2002:a17:902:b213:b0:1d4:3dfd:7e31 with SMTP id t19-20020a170902b21300b001d43dfd7e31mr20225789plr.139.1704299573989;
        Wed, 03 Jan 2024 08:32:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuxxr3jzBnWJLb5k5Ijiau2Uo52Uln5XHUYl8Xl2mWgyNYjwzpHX8ACzhU950ngT5irx/v3w==
X-Received: by 2002:a17:902:b213:b0:1d4:3dfd:7e31 with SMTP id t19-20020a170902b21300b001d43dfd7e31mr20225778plr.139.1704299573733;
        Wed, 03 Jan 2024 08:32:53 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001cfca7b8ee7sm23930425pls.99.2024.01.03.08.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:32:53 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 4/5] riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
Date: Wed,  3 Jan 2024 13:32:02 -0300
Message-ID: <20240103163203.72768-6-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103163203.72768-2-leobras@redhat.com>
References: <20240103163203.72768-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmpxchg for variables of size 1-byte and 2-bytes is not yet available for
riscv, even though its present in other architectures such as arm64 and
x86. This could lead to not being able to implement some locking mechanisms
or requiring some rework to make it work properly.

Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with other
architectures.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Tested-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index e3e0ac7ba061b..ac9d0eeb74e67 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -72,6 +72,35 @@
  * indicated by comparing RETURN with OLD.
  */
 
+#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
+({									\
+	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __oldx = (ulong)(o) << __s;				\
+	ulong __retx;							\
+	ulong __rc;							\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr.w %0, %2\n"					\
+		"	and  %1, %0, %z5\n"				\
+		"	bne  %1, %z3, 1f\n"				\
+		"	and  %1, %0, %z6\n"				\
+		"	or   %1, %1, %z4\n"				\
+		"	sc.w" sc_sfx " %1, %1, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+		: "rJ" ((long)__oldx), "rJ" (__newx),			\
+		  "rJ" (__mask), "rJ" (~__mask)				\
+		: "memory");						\
+									\
+	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+})
 
 #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
@@ -98,6 +127,11 @@
 	__typeof__(*(__ptr)) __ret;					\
 									\
 	switch (sizeof(*__ptr)) {					\
+	case 1:								\
+	case 2:								\
+		__arch_cmpxchg_masked(sc_sfx, prepend, append,		\
+					__ret, __ptr, __old, __new);	\
+		break;							\
 	case 4:								\
 		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
 				__ret, __ptr, (long), __old, __new);	\
-- 
2.43.0


