Return-Path: <linux-kernel+bounces-91159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC79870A34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD361C219AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FA7C0A0;
	Mon,  4 Mar 2024 19:11:03 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92A7AE71
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579463; cv=none; b=YXn+yJYqIv8lNjZWtM0aQv141k3yt/uTOgA0NqtUABjHMuvPI4sTMafw+lT1p7ZfSMn/Iajc3Z3qS+dbaBWGMZrkWGDCmq+nNWyujQGjZGIHsgx4yhEGw17mruT9bLHiElsM+JQFtk6eAgkV6newCpx8O8/4Nf/73VwhzDaTBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579463; c=relaxed/simple;
	bh=0Qs2/gVugGzcMDJ264P/mZg1kkf7oxzK2+XqzvHvLIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igPd8nFUm8f0MMm7EcBuw2EfahmZ2OajhX5Lnv6fMVXzrdTmYSjlqMT8hcmAmbhE2d91qo5tUCKA0y8BKLpZy3kwVp9uObDIpMqAT1nCdf02UK8o1QnLqVRP+ZLmoNplIAJNLZfXMUx3DqorERvplRvDqUcH90Trg36TaM/GHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by andre.telenet-ops.be with bizsmtp
	id ujAr2B00E2qflky01jArLe; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KJt-L6;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcd-Aa;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] sh: cache: Move forward declarations to <asm/cacheflush.h>
Date: Mon,  4 Mar 2024 20:10:43 +0100
Message-Id: <f47ab87636d16db4c47bebe1bf62650045f61989.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/kernel/cpu/init.c:99:29: warning: no previous prototype for 'l2_cache_init' [-Wmissing-prototypes]
arch/sh/kernel/cpu/sh4a/setup-sh7723.c:422:6: warning: no previous prototype for 'l2_cache_init' [-Wmissing-prototypes]
arch/sh/kernel/cpu/sh4a/setup-sh7724.c:842:6: warning: no previous prototype for 'l2_cache_init' [-Wmissing-prototypes]
arch/sh/mm/cache-j2.c:48:13: warning: no previous prototype for 'j2_cache_init' [-Wmissing-prototypes]
arch/sh/mm/cache-sh2.c:85:13: warning: no previous prototype for 'sh2_cache_init' [-Wmissing-prototypes]
arch/sh/mm/cache-sh2a.c:181:13: warning: no previous prototype for 'sh2a_cache_init' [-Wmissing-prototypes]
arch/sh/mm/cache-sh3.c:90:13: warning: no previous prototype for 'sh3_cache_init' [-Wmissing-prototypes]
arch/sh/mm/cache-sh4.c:384:13: warning: no previous prototype for 'sh4_cache_init' [-Wmissing-prototypes]
arch/sh/mm/cache-shx3.c:18:13: warning: no previous prototype for 'shx3_cache_init' [-Wmissing-prototypes]
arch/sh/mm/flush-sh4.c:106:13: warning: no previous prototype for 'sh4__flush_region_init' [-Wmissing-prototypes]
arch/sh/mm/cache-sh7705.c:190:13: warning: no previous prototype for 'sh7705_cache_init' [-Wmissing-prototypes]

Fix this by moving all cache-related forward declarations to
<asm/cacheflush.h>, and by including the latter where needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/cacheflush.h       | 12 ++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  3 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  1 +
 arch/sh/mm/cache-sh4.c                 |  2 --
 arch/sh/mm/cache-shx3.c                |  1 +
 arch/sh/mm/cache.c                     | 14 --------------
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 51112f54552b329a..e6642ff148898bec 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -104,6 +104,18 @@ void kunmap_coherent(void *kvaddr);
 
 void cpu_cache_init(void);
 
+void __weak l2_cache_init(void);
+
+void __weak j2_cache_init(void);
+void __weak sh2_cache_init(void);
+void __weak sh2a_cache_init(void);
+void __weak sh3_cache_init(void);
+void __weak shx3_cache_init(void);
+void __weak sh4_cache_init(void);
+void __weak sh7705_cache_init(void);
+
+void __weak sh4__flush_region_init(void);
+
 static inline void *sh_cacheop_vaddr(void *vaddr)
 {
 	if (__in_29bit_mode())
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 83ae1ad4a86e86b7..d64d28c4f0595d60 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -14,9 +14,12 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <linux/io.h>
+
+#include <asm/cacheflush.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 #include <asm/platform_early.h>
+
 #include <cpu/sh7723.h>
 
 /* Serial */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 0d990ab1ba2a9ed7..ef4b26a4b3d6428c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/notifier.h>
 
+#include <asm/cacheflush.h>
 #include <asm/suspend.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 862046f26981b61d..195e739ee2be77d8 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -376,8 +376,6 @@ static void __flush_cache_one(unsigned long addr, unsigned long phys,
 	} while (--way_count != 0);
 }
 
-extern void __weak sh4__flush_region_init(void);
-
 /*
  * SH-4 has virtually indexed and physically tagged cache.
  */
diff --git a/arch/sh/mm/cache-shx3.c b/arch/sh/mm/cache-shx3.c
index 24c58b7dc02265c7..dec039a75664083f 100644
--- a/arch/sh/mm/cache-shx3.c
+++ b/arch/sh/mm/cache-shx3.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 
 #define CCR_CACHE_SNM	0x40000		/* Hardware-assisted synonym avoidance */
 #define CCR_CACHE_IBE	0x1000000	/* ICBI broadcast */
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 9bcaa5619eabd142..ceffd3ffc81e3ee2 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -320,30 +320,20 @@ void __init cpu_cache_init(void)
 		goto skip;
 
 	if (boot_cpu_data.type == CPU_J2) {
-		extern void __weak j2_cache_init(void);
-
 		j2_cache_init();
 	} else if (boot_cpu_data.family == CPU_FAMILY_SH2) {
-		extern void __weak sh2_cache_init(void);
-
 		sh2_cache_init();
 	}
 
 	if (boot_cpu_data.family == CPU_FAMILY_SH2A) {
-		extern void __weak sh2a_cache_init(void);
-
 		sh2a_cache_init();
 	}
 
 	if (boot_cpu_data.family == CPU_FAMILY_SH3) {
-		extern void __weak sh3_cache_init(void);
-
 		sh3_cache_init();
 
 		if ((boot_cpu_data.type == CPU_SH7705) &&
 		    (boot_cpu_data.dcache.sets == 512)) {
-			extern void __weak sh7705_cache_init(void);
-
 			sh7705_cache_init();
 		}
 	}
@@ -351,14 +341,10 @@ void __init cpu_cache_init(void)
 	if ((boot_cpu_data.family == CPU_FAMILY_SH4) ||
 	    (boot_cpu_data.family == CPU_FAMILY_SH4A) ||
 	    (boot_cpu_data.family == CPU_FAMILY_SH4AL_DSP)) {
-		extern void __weak sh4_cache_init(void);
-
 		sh4_cache_init();
 
 		if ((boot_cpu_data.type == CPU_SH7786) ||
 		    (boot_cpu_data.type == CPU_SHX3)) {
-			extern void __weak shx3_cache_init(void);
-
 			shx3_cache_init();
 		}
 	}
-- 
2.34.1


