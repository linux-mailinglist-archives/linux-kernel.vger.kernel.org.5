Return-Path: <linux-kernel+bounces-9125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFF81C0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180911C23C46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251E177F37;
	Thu, 21 Dec 2023 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lbi4liro";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JXKVDG/8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDB77B5A;
	Thu, 21 Dec 2023 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Dec 2023 22:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703197193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EnBi2VEEYObZT5Odc1MhexcXNZyIPFiox/vVnXJJVY=;
	b=Lbi4liro45P67qg/k4Z6Xzf/JPRvQDL1tAg8vyef2ZhqdRZ/dx19yZ/t7UeEOEzdDp6isS
	V33m1R0qxqgzfISLJ2nypCuJXnE7r2C1tVoxU3+pW/pUdpIKCsAXL3+af5KCDF/B9hZ7MS
	n2VoQYxK95CXeN+XbAsgh+fqFQxfCuTgOFk0WOUD7IQWhKD7I/ETgKPRlbgnNR65g/pejg
	oqogwLX7421vzGlsfzfHlvzHJ8tBL9ruQpAkytj83KboSF6QIz3eUeloOyNks2liJlXQBc
	iZKlqsV7/wO0QqPnQ6xlALFjqtCAJrbfR0USt0VsDrXsJIMDY4bcuA4rqOgZ0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703197193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EnBi2VEEYObZT5Odc1MhexcXNZyIPFiox/vVnXJJVY=;
	b=JXKVDG/8OUYKrNFoaWDbx3VV71Uu38e6saq1ySh8+oMwQcSNGvSGWcEVGVL7zIBYO+XPYR
	EHU1LJhczoBUxYDw==
From: "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Move enter_from_user_mode() to header file
Cc: Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218074520.1998026-3-svens@linux.ibm.com>
References: <20231218074520.1998026-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170319719323.398.17191034677534745523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     caf4062e35b21cd7d3d35ac2f58f9765d02d32a0
Gitweb:        https://git.kernel.org/tip/caf4062e35b21cd7d3d35ac2f58f9765d02d32a0
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Mon, 18 Dec 2023 08:45:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 21 Dec 2023 23:12:18 +01:00

entry: Move enter_from_user_mode() to header file

To allow inlining of enter_from_user_mode(), move it to
entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231218074520.1998026-3-svens@linux.ibm.com

---
 include/linux/entry-common.h | 15 ++++++++++++++-
 kernel/entry/common.c        | 26 +++-----------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 6a6e98f..c420539 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -11,6 +11,7 @@
 #include <linux/livepatch.h>
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
+#include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
 
@@ -102,7 +103,19 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-void enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
 
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 7f8f8c1..0616f23 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,26 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/* See comment for enter_from_user_mode() in entry-common.h */
-static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
-void noinstr enter_from_user_mode(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-}
-
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -105,7 +85,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -117,7 +97,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
@@ -266,7 +246,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)

