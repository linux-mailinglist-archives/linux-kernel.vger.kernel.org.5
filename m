Return-Path: <linux-kernel+bounces-6752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B7819CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A88B237EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98D20B11;
	Wed, 20 Dec 2023 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTmQ2Fwg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD0208C9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3b8184a84so15625425ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703068477; x=1703673277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFWsnBzn58gm3ZPzcT2FNSYLm3tXrViiUU3720enkpQ=;
        b=OTmQ2Fwg1qyh9GoELCa4DASmueGFyVWb5oCaKZimOIladaaCYiegXwTxJyyKgW+OHL
         +VCVpcb9s38jCtKrit+L5LItvVJMnDM2tw8ldqL5ylx3y2yOSDELLtXLG+mXSNGoiyCw
         R1JKw6HiOTotOrig2sUJaDs0hJKcbNIo8oo0YD893RGOgRlI92mDc2xVyqJUjmh+Mnj6
         I3WKwC5X96krDM++8jpt7OM0G2R/LlUo5s+4L9NW1kkpw56bZesHbVsBY6J346w7yWTu
         Yi8d/RVEQrhc0KKX0D28zxiFdHGR7dkuH1SdTWY/vWC6efStzHwKVAW5tZo6fAEBBBYh
         +XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703068477; x=1703673277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFWsnBzn58gm3ZPzcT2FNSYLm3tXrViiUU3720enkpQ=;
        b=nYZWvz0EDqAsyiXIJ77sKXd8zU/e7TMnO9eoogKXKI1a0aNu7BI33ULR7fYO0wb1rC
         azMIfAkQx8wRd8vVuGe8+L9lBJGnIqCkAMoWrMR0tYWPPC1MJUvrRM6AOcICaSOEEQB7
         5XEAtGdGcnSNO0ISsBw05Kp6mE1+V86v3AwX9NpKBAlT3WCJQkXFbH1j6qeXawuHSajk
         cXmf1ofBXftGXOiUfZQ/vNU1FThqM6ZJEzr5zVGOYS0B2iPq8UtF/DTIHkhjwyLTxG6W
         t9eXgR1Dibf6qpTgJu+ic9X6pwyronafGOvErsMNL/A/2h5Bw270r1dvNTN+lDfdQYvT
         LDUw==
X-Gm-Message-State: AOJu0YzeZSSbLyLU+oRK/x78otgTsDpD9CdfYj5e3cPT61spNGkH8dq2
	cKGBzRJI0U7Ku4jx7cszVm2itg==
X-Google-Smtp-Source: AGHT+IHO+ozw4UTv/+0I7mcW0/b1xzuABhT5sLWUu3zVP2een7tUqoHLOb8TRg7oPfm7mfmUlOEPog==
X-Received: by 2002:a17:903:904:b0:1d3:7c0b:d4ca with SMTP id ll4-20020a170903090400b001d37c0bd4camr6996259plb.73.1703068477268;
        Wed, 20 Dec 2023 02:34:37 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001d337b8c0b2sm15525089plh.7.2023.12.20.02.34.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 02:34:36 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	anup@brainfault.org,
	samitolvanen@google.com,
	rppt@kernel.org,
	panqinglin2020@iscas.ac.cn,
	cuiyunhui@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: put va_kernel_xip_pa_offset into CONFIG_XIP_KERNEL
Date: Wed, 20 Dec 2023 18:34:28 +0800
Message-Id: <20231220103428.61758-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opitmize the kernel_mapping_pa_to_va() and kernel_mapping_va_to_pa().

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/page.h | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 5488ecc337b6..0d2b479d02cd 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -113,8 +113,8 @@ struct kernel_mapping {
 	unsigned long va_pa_offset;
 	/* Offset between kernel mapping virtual address and kernel load address */
 	unsigned long va_kernel_pa_offset;
-	unsigned long va_kernel_xip_pa_offset;
 #ifdef CONFIG_XIP_KERNEL
+	unsigned long va_kernel_xip_pa_offset;
 	uintptr_t xiprom;
 	uintptr_t xiprom_sz;
 #endif
@@ -134,12 +134,25 @@ extern phys_addr_t phys_ram_base;
 #else
 void *linear_mapping_pa_to_va(unsigned long x);
 #endif
-#define kernel_mapping_pa_to_va(y)	({					\
-	unsigned long _y = (unsigned long)(y);					\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
-		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
-		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
-	})
+
+#ifdef CONFIG_XIP_KERNEL
+#define kernel_mapping_pa_to_va(y)							\
+	(((unsigned long)(y) < phys_ram_base) ?						\
+		(void *)((unsigned long)(y) + kernel_map.va_kernel_xip_pa_offset) :	\
+		(void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET))
+
+#define kernel_mapping_va_to_pa(y)						\
+	(((unsigned long)(y) < kernel_map.virt_addr + XIP_OFFSET) ?		\
+		((unsigned long)(y) - kernel_map.va_kernel_xip_pa_offset) :	\
+		((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET))
+#else
+#define kernel_mapping_pa_to_va(y)						\
+	((void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET))
+
+#define kernel_mapping_va_to_pa(y)						\
+	((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET)
+#endif
+
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
 #ifndef CONFIG_DEBUG_VIRTUAL
@@ -147,12 +160,6 @@ void *linear_mapping_pa_to_va(unsigned long x);
 #else
 phys_addr_t linear_mapping_va_to_pa(unsigned long x);
 #endif
-#define kernel_mapping_va_to_pa(y) ({						\
-	unsigned long _y = (unsigned long)(y);					\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
-		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
-		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
-	})
 
 #define __va_to_pa_nodebug(x)	({						\
 	unsigned long _x = x;							\
-- 
2.20.1


