Return-Path: <linux-kernel+bounces-76607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8885F9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BF288706
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E181339B1;
	Thu, 22 Feb 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z30xs+jw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MP0ewHAo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31A133405;
	Thu, 22 Feb 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608923; cv=none; b=oPKTt5ZEhGk7ITW9Bt2yuTrhrfmKHtRa37XnlRIDgdxeUlGsTMRT5ia///tcfGZsLxf/5tA7hXP9HuqrubFjWRObpqnFHXU9D4hK6W5hTvPS3P4qefmFojRG9jA/63U5u/iT3g58bBEFQAZURA4nmiYGgl6aqtSODOivLVG5kXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608923; c=relaxed/simple;
	bh=iC+WZvzblRSXPm5naslwgAGHQ53bsyZu97iPPWl3jPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cx7DbX4B1GbbG5PnEjd2MoGartTR4cdT0GiPZywfrkK/Fs4aHgYCthr5Hd43R2Y2gv88TTHjJiwa7TTq4QKExQPozk5xVb+P4EKsoy4QBQ9X4mLgxOgXmqX3Y86VIx3V6v3Thl7aud1UrC/vafl9lLWHAsCMGITXPx4BviJoRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z30xs+jw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MP0ewHAo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C26ED1F7B5;
	Thu, 22 Feb 2024 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708608916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7lHA0U6zldxEI+NhAVtO/n5oPtcMsWs8Sefkvk+X3ts=;
	b=Z30xs+jwNqhtX0lG9d+7Q5giIhFTe3Ozfmsanee3zyXlApgCThSUOei0gkgeyFfu4PfRni
	zHPT9ry6U0PquhxFC0zhIT41vU2Sb2B0lXpyA5w3XYwxlhann56UlEbHA7AQ6eMDDa7gRD
	8kRpFy+JW8NKqp2jGDs2CiKHUVFrunM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708608915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7lHA0U6zldxEI+NhAVtO/n5oPtcMsWs8Sefkvk+X3ts=;
	b=MP0ewHAoblyahQv6+BVCMNP/a3jNPHtKktIfURVtGbzwQtOdyZ7MFgbDgHiC1SPdSRXKjJ
	/386IlVrCQ41KsFSIa/AARWkXNgplXI50Uyoi/1sOWnafBZJ9zEeP6KS1vGnTVNgQjOgNZ
	/aMXGwnp/UcueuN+Qu38ifVUmpYFHh8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF64B13A8C;
	Thu, 22 Feb 2024 13:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 91Q6KpNN12V9OwAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Thu, 22 Feb 2024 13:35:15 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	mark.rutland@arm.com
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3] kbuild: Use -fmin-function-alignment when available
Date: Thu, 22 Feb 2024 14:35:00 +0100
Message-Id: <20240222133500.16991-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MP0ewHAo
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: C26ED1F7B5
X-Spam-Flag: NO

GCC recently added option -fmin-function-alignment, which should appear
in GCC 14. Unlike -falign-functions, this option causes all functions to
be aligned at the specified value, including the cold ones.

In particular, when an arm64 kernel is built with
DYNAMIC_FTRACE_WITH_CALL_OPS=y, the 8-byte function alignment is
required for correct functionality. This was done by -falign-functions=8
and having workarounds in the kernel to force the compiler to follow
this alignment. The new -fmin-function-alignment option directly
guarantees it.

Detect availability of -fmin-function-alignment and use it instead of
-falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
and enable __cold to work as expected when it is set.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

Changes since v2 [1]:
- Remove the conditional use of __function_aligned for abort() which resulted in
  less readable code.
- Mention in the commit message that a particular target for this change is an
  arm64 kernel with DYNAMIC_FTRACE_WITH_CALL_OPS=y.

Changes since v1 [2]:
- Check the availability of -fmin-function-alignment only in one place.

[1] https://lore.kernel.org/linux-kbuild/20240215151642.8970-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/linux-kbuild/20240212145355.1050-1-petr.pavlu@suse.com/

 Makefile                       |  7 +++++++
 arch/Kconfig                   | 12 ++++++++++++
 include/linux/compiler_types.h | 10 +++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

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

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.35.3


