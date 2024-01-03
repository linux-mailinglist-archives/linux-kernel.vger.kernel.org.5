Return-Path: <linux-kernel+bounces-15758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28055823155
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7B92854AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD01CF8F;
	Wed,  3 Jan 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErWqSiOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE871CF8B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704299584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Re2lmE+u9xJehZpa61KU1PY4uKcHNA9CavGcQorFlps=;
	b=ErWqSiOXjrIiPgx5l4OBqncVH3pWrzFEwMiwLuUjQva/YO67SgblparFCnw132STPqveXL
	6ib+9fvC0WLY4TsmRV1r2zQNylXnro5VvK+At/zkIBUOFgDpXheJYGAi4JvbLHYIH3Gopg
	IiUvhR8c//IW0oHCNySLDfE2rRFp7L4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-iLeJwFxfNiuF6opvArAgLw-1; Wed, 03 Jan 2024 11:33:00 -0500
X-MC-Unique: iLeJwFxfNiuF6opvArAgLw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d3e5d18308so110242555ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299579; x=1704904379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re2lmE+u9xJehZpa61KU1PY4uKcHNA9CavGcQorFlps=;
        b=Zt5ZJVcLCNOHiQJP4xvpd56iFqzkmZt1TWRhfRRUyOise1IRllWM3FcXxF0dC3cKTM
         ZZuv1RXTb9wHPcrJ0IXlmPEZr2pfAOqGyP2rjwTZgugowfKKN5hJ6S3ttYsaSPH1POYC
         A7KgdH4m6jLztigLjuJLFZbE4O8X1Re4H8vPXZl4/Xx4CxngXwQhg8uFRNGdQ/hivJjK
         rqAildZSuR9T5J/Yz07/g5Vflli0pmGTA6OQjDyfACXWy14hmpJdrD+v8GlF4nXz+a8w
         wGMEfhb+AYzE0LpDHvnGTfBmbP6a5RotQ3a+8IPjOghfpKHQbmzLRtiy319PX5wMHK0q
         zOTQ==
X-Gm-Message-State: AOJu0YzNE3MW5o1xlzlgwHzytwGXHD61IJRKypT7xliduS7cK1gsZ64b
	a6sFZX6jT44R1WQi8P8MGI978sd0OmaTseTIOSNJ959QVjCrWb3wAwmNQnbXpaPVQVNq6KOVvuO
	OaX8B0b7ElkZ/myDAVvRxH0ghsy0erhED
X-Received: by 2002:a17:902:b94c:b0:1d0:6ffe:a11 with SMTP id h12-20020a170902b94c00b001d06ffe0a11mr22000206pls.111.1704299579620;
        Wed, 03 Jan 2024 08:32:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFssUiBpWP8x7axGoljRgCI2CzrmRE+huZgi6wtwmSBGSU76WiGWvRbbX36kTz3/VUagQIV+g==
X-Received: by 2002:a17:902:b94c:b0:1d0:6ffe:a11 with SMTP id h12-20020a170902b94c00b001d06ffe0a11mr22000194pls.111.1704299579375;
        Wed, 03 Jan 2024 08:32:59 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001cfca7b8ee7sm23930425pls.99.2024.01.03.08.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:32:58 -0800 (PST)
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
Subject: [PATCH v1 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
Date: Wed,  3 Jan 2024 13:32:03 -0300
Message-ID: <20240103163203.72768-7-leobras@redhat.com>
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

xchg for variables of size 1-byte and 2-bytes is not yet available for
riscv, even though its present in other architectures such as arm64 and
x86. This could lead to not being able to implement some locking mechanisms
or requiring some rework to make it work properly.

Implement 1-byte and 2-bytes xchg in order to achieve parity with other
architectures.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Tested-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ac9d0eeb74e67..26cea2395aae8 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,31 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+#define __arch_xchg_masked(prepend, append, r, p, n)			\
+({									\
+	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __retx;							\
+	ulong __rc;							\
+									\
+	__asm__ __volatile__ (						\
+	       prepend							\
+	       "0:	lr.w %0, %2\n"					\
+	       "	and  %1, %0, %z4\n"				\
+	       "	or   %1, %1, %z3\n"				\
+	       "	sc.w %1, %1, %2\n"				\
+	       "	bnez %1, 0b\n"					\
+	       append							\
+	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+	       : "rJ" (__newx), "rJ" (~__mask)				\
+	       : "memory");						\
+									\
+	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+})
+
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
 ({									\
 	__asm__ __volatile__ (						\
@@ -27,7 +52,13 @@
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
 	__typeof__(*(__ptr)) __ret;					\
+									\
 	switch (sizeof(*__ptr)) {					\
+	case 1:								\
+	case 2:								\
+		__arch_xchg_masked(prepend, append,			\
+				   __ret, __ptr, __new);		\
+		break;							\
 	case 4:								\
 		__arch_xchg(".w" sfx, prepend, append,			\
 			      __ret, __ptr, __new);			\
-- 
2.43.0


