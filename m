Return-Path: <linux-kernel+bounces-67146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE6A856709
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC258281C99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF68132C08;
	Thu, 15 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p5ITTyLw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p5ITTyLw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2181754B;
	Thu, 15 Feb 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010214; cv=none; b=WbGSlIQhsYPtNOvByLLRBLBisCZAJE+zvLUsvyFvBU47Sdy0Hh+1j9/sz4ZWgnFBRDBG+Bdv43/SrJnurLuLY+ASrQvWzhGSZiCiaBwYS5YmM4xx5U1hC9t64AQQEQZL9DSqR/zJ5PDw15ywvVpqUr/CkooywS3mwCEuoQJL0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010214; c=relaxed/simple;
	bh=+3tBwyBJQSmRLOGeAZM1Eljg7HCq/1bfTBDC7mOJlD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bp1Q2D/MYj9ldi8acAFDUx++ux8ySViZas1xKahYCFAgIUVYa9S0iYi3ZKRQVaE7q1MPV0f2OX9N/JvEH8VwLg0DW8eRMDqzGfXztL3hEvmVW0Ee5JOgVZpENrMrU3Ppnww7b0zSMtkYGj4c+JPrvtsrruDIHBpEQ+Ha6hGd33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p5ITTyLw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p5ITTyLw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86C4F1F37C;
	Thu, 15 Feb 2024 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708010207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/gYCDZUDJp0eZaNS1nrl5orvvbCUssTGKtvswvygSK8=;
	b=p5ITTyLwDBW0NP4VIkMKACXLqkMdiFBr/+Bq3TwGMyMMI2oA4li9P2Ah2Ed5WJ4y9eropB
	gEdCrBlMQHTro944inviiPswAZINtoUtFKyUNzwNU/exiIrXZkUgC9AqC3JcpK4iDSgix8
	HIMCNsj0iHPp07yQgfX30RF1s5jS2Tk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708010207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/gYCDZUDJp0eZaNS1nrl5orvvbCUssTGKtvswvygSK8=;
	b=p5ITTyLwDBW0NP4VIkMKACXLqkMdiFBr/+Bq3TwGMyMMI2oA4li9P2Ah2Ed5WJ4y9eropB
	gEdCrBlMQHTro944inviiPswAZINtoUtFKyUNzwNU/exiIrXZkUgC9AqC3JcpK4iDSgix8
	HIMCNsj0iHPp07yQgfX30RF1s5jS2Tk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7478E13A53;
	Thu, 15 Feb 2024 15:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPP6G98qzmXGcgAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Thu, 15 Feb 2024 15:16:47 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	mark.rutland@arm.com
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Date: Thu, 15 Feb 2024 16:16:42 +0100
Message-Id: <20240215151642.8970-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,gnu.org:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

GCC recently added option -fmin-function-alignment, which should appear
in GCC 14. Unlike -falign-functions, this option causes all functions to
be aligned at the specified value, including the cold ones.

Detect availability of -fmin-function-alignment and use it instead of
-falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
and make the workarounds for the broken function alignment conditional
on this setting.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

Changes since v1 [1]:
- Check the availability of -fmin-function-alignment only in one place.

[1] https://lore.kernel.org/linux-kbuild/20240212145355.1050-1-petr.pavlu@suse.com/

 Makefile                       |  7 +++++++
 arch/Kconfig                   | 12 ++++++++++++
 include/linux/compiler_types.h | 10 +++++-----
 kernel/exit.c                  |  5 ++++-
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7e0b2ad98905..6f20ab5e2e44 100644
--- a/Makefile
+++ b/Makefile
@@ -974,8 +974,15 @@ export CC_FLAGS_CFI
 endif
 
 ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
+# Set the minimal function alignment. Use the newer GCC option
+# -fmin-function-alignment if it is available, or fall back to -falign-funtions.
+# See also CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT.
+ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
+KBUILD_CFLAGS += -fmin-function-alignment=$(CONFIG_FUNCTION_ALIGNMENT)
+else
 KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
+endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc
diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..bd6c6335efac 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1507,4 +1507,16 @@ config FUNCTION_ALIGNMENT
 	default 4 if FUNCTION_ALIGNMENT_4B
 	default 0
 
+config CC_HAS_MIN_FUNCTION_ALIGNMENT
+	# Detect availability of the GCC option -fmin-function-alignment which
+	# guarantees minimal alignment for all functions, unlike
+	# -falign-functions which the compiler ignores for cold functions.
+	def_bool $(cc-option, -fmin-function-alignment=8)
+
+config CC_HAS_SANE_FUNCTION_ALIGNMENT
+	# Set if the guaranteed alignment with -fmin-function-alignment is
+	# available or extra care is required in the kernel. Clang provides
+	# strict alignment always, even with -falign-functions.
+	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
+
 endmenu
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 663d8791c871..f0152165e83c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -99,17 +99,17 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
  *
  * When -falign-functions=N is in use, we must avoid the cold attribute as
- * contemporary versions of GCC drop the alignment for cold functions. Worse,
- * GCC can implicitly mark callees of cold functions as cold themselves, so
- * it's not sufficient to add __function_aligned here as that will not ensure
- * that callees are correctly aligned.
+ * GCC drops the alignment for cold functions. Worse, GCC can implicitly mark
+ * callees of cold functions as cold themselves, so it's not sufficient to add
+ * __function_aligned here as that will not ensure that callees are correctly
+ * aligned.
  *
  * See:
  *
  *   https://lore.kernel.org/lkml/Y77%2FqVgvaJidFpYt@FVFF77S0Q05N
  *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c9
  */
-#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
+#if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || (CONFIG_FUNCTION_ALIGNMENT == 0)
 #define __cold				__attribute__((__cold__))
 #else
 #define __cold
diff --git a/kernel/exit.c b/kernel/exit.c
index dfb963d2f862..5a6fed4ad3df 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
  *
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c11
  */
-__weak __function_aligned void abort(void)
+#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
+__function_aligned
+#endif
+__weak void abort(void)
 {
 	BUG();
 

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.35.3


