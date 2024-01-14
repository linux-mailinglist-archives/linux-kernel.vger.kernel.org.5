Return-Path: <linux-kernel+bounces-25539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79782D20B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 21:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48084281C35
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9AD12E63;
	Sun, 14 Jan 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hds7Os04"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2523101D2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705262364; bh=mIJ1kDf5bfgkPOpxk66bvJG+nTigHTLkaT19djw6SEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hds7Os04ZoOOx6f/YZHre5eeaAKqNosf35iZl34Am73oxjlXEuVvEwxXKKYfGC7yZ
	 wxQDpwFIz/9cb7P2UMUjFPlHQlfCyRZfTJcIYqpqowdrLpA1K2EH7vw6ZpzZ5/E6o5
	 RbrBxT/Sw7p3Gl/yh1foYmH+hNTjdE5F4Rjdvdls=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id ED316C15; Mon, 15 Jan 2024 03:59:19 +0800
X-QQ-mid: xmsmtpt1705262359t0vi5uqm6
Message-ID: <tencent_871D1B705162CE42D21BD1F86E0447B44709@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5+DdQxOt7Ebl9C7ZpFS3BPZWuIdJo03ot75wGberYlBdXLvqxY6
	 LulfA0H2Y/dabjKoWHWpsgLA7/7gerUxzhAHgqIslSLXqPWTyhIOz3ZWbxOs/ZvLolrj4lkt3Mh+
	 z/OB40WrVh9O03y5S1YSpKkpW8QbLdkerIhu45pjrA4f/p+YpWhq0LbN+GpO3Ke0L7VD6sQodYa5
	 p1p5K8RcszASdnff3Xeer5ay7abOg+I5ofA1F/9Fqn9eyUWmZn/h6pZliVvLwo5eetJ5QSv625bn
	 CqiNRTdwF9X06DE95WZqhPrR9qWLCRmEksA4KapQwyVDT4XN7KHv4xaBWYvcIyY/HoFaJae6DLQh
	 EUM2auf2Q9r214a+hsUC66NE/iH3TD0/jGNBxRIsFkLw1LtPbTLjB4418/pshgBdzLDX6Qyx1sF4
	 sTmjsHsV60oo4gnf4K8F44djtskkHLRrXkUuA1htNazrZLKpmj9lXuyE7KqYZ75Z4c7brS2CsDlN
	 l42BiEfIy5bBsJvq+UzrqkYi3/UxcnrA7PY41m5IWAp249dLz4fL660VSphu/Oq3eKRDkNDrfjkO
	 b9rUFL5DCWb3qcq6QTwrCQQv4T4TFn0tpJQNyRnHqoZ92KHOj0I834KptAfaeaa5MdR/45ifHWvt
	 SOhguWhNPE4HAF5XDsvebkHMStgZvqBMDuXDiTDlysRxhbEQ0f1PFPuUjxt61UDpWpId+HleceKp
	 VT1c/nkxtIdLx92witceCZgJqEJeUPw0Zp6/tLc/8++U5SenTF4quM3W1bCX2nVnNTVt6kaYY4LC
	 rNI8lRnfE0xuAJ9jMvBgNSEtjzemxY8X/dTBsyFOm/zITeIg0mvhKIsDSpgotIlkCioQ6rF8xfcN
	 AKFYOA5M0zODhKDUZ5ZJCaLAbhsizQS2WR+ag7OcAbK6CpuN4PSbVgYWI83XLGj5uS1XUDceERQ3
	 s2MDb0oIzhjf8CE295JtRrR28LMn2/NjYFzLbhdpDuhhr09ilrB9h17I4LFhLx6EmFNsPlVuv2y/
	 JFqZN/ZfSLwM4bTj5E
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 1/3] RISC-V: mm: fix mmap behavior in sv48 address space
Date: Mon, 15 Jan 2024 03:58:30 +0800
X-OQ-MSGID: <20240114195832.275982-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com>
References: <tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A commit add2cc6b6515 ("RISC-V: mm: Restrict address space for
sv39,sv48,sv57") from patch[1] restricts regular mmap return address in the
sv48 space if the address hint is not above the sv48 userspace address.
However, this commit treats the address wrong which only use sv48 if the
hint address is above sv48 user address space. Actually, it should use sv48
if the address is above sv39 user address space. Moreover, the original
patch code looks very complex in logic, we can simplify it with min marco.

[1]. https://lore.kernel.org/r/20230809232218.849726-2-charlie@rivosinc.com

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/include/asm/processor.h | 39 ++++++------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index e1944ff0757a..7ead6a3e1f12 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -9,6 +9,7 @@
 #include <linux/const.h>
 #include <linux/cache.h>
 #include <linux/prctl.h>
+#include <linux/minmax.h>
 
 #include <vdso/processor.h>
 
@@ -18,37 +19,13 @@
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE
 
-#define arch_get_mmap_end(addr, len, flags)			\
-({								\
-	unsigned long mmap_end;					\
-	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_end = VA_USER_SV48;			\
-	else							\
-		mmap_end = VA_USER_SV39;			\
-	mmap_end;						\
-})
-
-#define arch_get_mmap_base(addr, base)				\
-({								\
-	unsigned long mmap_base;				\
-	typeof(addr) _addr = (addr);				\
-	typeof(base) _base = (base);				\
-	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_base = (_base);				\
-	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
-		mmap_base = VA_USER_SV57 - rnd_gap;		\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_base = VA_USER_SV48 - rnd_gap;		\
-	else							\
-		mmap_base = VA_USER_SV39 - rnd_gap;		\
-	mmap_base;						\
-})
+#define arch_get_mmap_end(addr, len, flags) \
+	((addr) >= DEFAULT_MAP_WINDOW ? STACK_TOP_MAX :\
+	 min(DEFAULT_MAP_WINDOW, STACK_TOP_MAX))
+
+#define arch_get_mmap_base(addr, base) \
+	((addr) >= DEFAULT_MAP_WINDOW ? base :\
+	 min(base, DEFAULT_MAP_WINDOW))
 
 #else
 #define DEFAULT_MAP_WINDOW	TASK_SIZE
-- 
2.43.0


