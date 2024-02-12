Return-Path: <linux-kernel+bounces-61847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65D85175F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33284B217F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D638B3B797;
	Mon, 12 Feb 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d4IxtPlT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d4IxtPlT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0A249E4;
	Mon, 12 Feb 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749664; cv=none; b=cgXCTVtVOuqPb4QROGB1C8bmK/a6vN6BgqGQDNx2E7BJXiz2xtyTPEGpPgv3TXuxfb1Y8a4Er9lep44Tudbi2/Lle8VDZbKP/fr6t3IdirqUIHXJdW0nLNVlKApjiy7sze/BFpmRmXGoqNgMoa+BDpyhua6W6QvJZx/0GNkBqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749664; c=relaxed/simple;
	bh=6yEa8qF58RqJDAY/wXW++BekGT5zW4Ve3GZ5PjZmjcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N9/0UeW3peceyIvcSMDaJsOA5Gk9ZDUkUDH1OqtMGjFnZDf0uqTeb4o7pTB5+L6k1W8avHXhv5RCrS3qml7r/E6cJxBXiRX/aYHWX8tyrtukkdsX/bL0k9il8/aWvYUqbFGzL08B8yIFMHS08TIv17M9fOq4yK0jXkyJGNKqKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d4IxtPlT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d4IxtPlT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47B4D22145;
	Mon, 12 Feb 2024 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707749659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V0L8pVjB7DYQ75QQe0/JW9VUxueUuR4lV4aki0t09q4=;
	b=d4IxtPlTNX3UB4UCqfsU0rbeGnJCeBbuphUD9SbFXFaWM81SDwcLybHI8GOE0OVgnojv/T
	BQmWTyhb5d+Acc2gqvPbNp19QZ4JXKKtAyMoA2MWlru0JTZeklzHuh18TvmQanrt3l/nVz
	WiTHAw9315jBhCggC/U7N1RpEXs9r4k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707749659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V0L8pVjB7DYQ75QQe0/JW9VUxueUuR4lV4aki0t09q4=;
	b=d4IxtPlTNX3UB4UCqfsU0rbeGnJCeBbuphUD9SbFXFaWM81SDwcLybHI8GOE0OVgnojv/T
	BQmWTyhb5d+Acc2gqvPbNp19QZ4JXKKtAyMoA2MWlru0JTZeklzHuh18TvmQanrt3l/nVz
	WiTHAw9315jBhCggC/U7N1RpEXs9r4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D18F12FF7;
	Mon, 12 Feb 2024 14:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9o2LChsxymWmWgAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Mon, 12 Feb 2024 14:54:19 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	mark.rutland@arm.com
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] kbuild: Use -fmin-function-alignment when available
Date: Mon, 12 Feb 2024 15:53:55 +0100
Message-Id: <20240212145355.1050-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=d4IxtPlT
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 47B4D22145
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

GCC recently added option -fmin-function-alignment, which should appear
in GCC 14. Unlike -falign-functions, this option causes all functions to
be aligned at the specified value, including the cold ones.

Detect availability of -fmin-function-alignment and use it instead of
-falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
and make the workarounds for the broken function alignment conditional
on this setting.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 Makefile                       |  7 ++++++-
 arch/Kconfig                   |  8 ++++++++
 include/linux/compiler_types.h | 10 +++++-----
 kernel/exit.c                  |  5 ++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 7e0b2ad98905..9516e43f6e45 100644
--- a/Makefile
+++ b/Makefile
@@ -974,7 +974,12 @@ export CC_FLAGS_CFI
 endif
 
 ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
-KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
+# Set the minimal function alignment. Try to use the newer GCC option
+# -fmin-function-alignment, or fall back to -falign-funtions. See also
+# CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT.
+KBUILD_CFLAGS += $(call cc-option, \
+	-fmin-function-alignment=$(CONFIG_FUNCTION_ALIGNMENT), \
+	-falign-functions=$(CONFIG_FUNCTION_ALIGNMENT))
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..e2448f927fae 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1507,4 +1507,12 @@ config FUNCTION_ALIGNMENT
 	default 4 if FUNCTION_ALIGNMENT_4B
 	default 0
 
+config CC_HAS_SANE_FUNCTION_ALIGNMENT
+	# Detect availability of the GCC option -fmin-function-alignment which
+	# guarantees minimal alignment for all functions. GCC 13 and older have
+	# only -falign-functions which the compiler ignores for cold functions
+	# and this hence requires extra care in the kernel. Clang provides
+	# strict alignment always when using -falign-functions.
+	def_bool $(cc-option, -fmin-function-alignment=8) || CC_IS_CLANG
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


