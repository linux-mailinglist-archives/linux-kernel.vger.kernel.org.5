Return-Path: <linux-kernel+bounces-45901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7078437AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E6F285AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B9679ED;
	Wed, 31 Jan 2024 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0YA0raHr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZtj0vRl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B3605DC;
	Wed, 31 Jan 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685679; cv=none; b=m/+TsLj1amx8+6glvKBJJFqtmLAt6ji2269bgIAhxlZkY/2mTdGa487ha+GI9iLn6uedvv0jV7HeJVU8BvRdOER7EtuvrFejRVx/ucmq2GqNVAcn+zQwtNYu75ZaofLNprKbt+rvh2+1IUSS2/fmgmd9shqqiSlSQABMjO1h2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685679; c=relaxed/simple;
	bh=nfBLM8STJDhLksKnJTIYpt+YMJcC5CmwiMNhRtKeK4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nEZNHd9P6t3Csx4cqH9Pk1rdlCit2KtxIZQ2gefCEhHJr7b1XrHlAyMLS2vhwLESM+31HjAv6jm00ju0VFNn3Osa2rn9sNkScxrPCuU2dGCkRJq2Ja+YCdkiAQtjcPqosAmDqZsdPwVLM4LG7rWAhC4DKbhT1++90M26RL4QWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0YA0raHr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZtj0vRl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YD/UNyXLxeG9OGVTW3NJU79XCbFNfMNvd8KKcIQ9acI=;
	b=0YA0raHrugrQrTUufFg2MB4HcN6+rCECu73IW2jwNCLPHSA/PxjmFEXM0AAwvSyC2ajtUy
	486Z9DkmML/8EeX7zA22ft70JPsUyShBnG5KPsAnOqaMJm08FRf2d1gFfQ0uD6AGlLNtj2
	vjSTyC8b2uaDG8VqsGYF/PVndJpqYMnWrcuSBqI4Gsf8CpZpyZHt5CoS3LCn5E06CY9/wX
	GwfDVuCyYbz4zTglSKx+01XSYaKTHnMK71HJkDTHLjwP/m+EEjsm9nfZbslH9CzXnx4LYQ
	w2pGDINazaSROygMxr/FMJSstblOMJHZTQsMVfDIWNRqREzkg9DgMd8uTGP+aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YD/UNyXLxeG9OGVTW3NJU79XCbFNfMNvd8KKcIQ9acI=;
	b=JZtj0vRl4fZUtppVNs7NufdRvFDT4LOt/mwygsFP4O0WzG/lSwSZYhCjBEh4I2bvYWduSo
	PouZ1vfPeAZOvjDQ==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a machine check entry stub for FRED
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-26-xin3.li@intel.com>
References: <20231205105030.8698-26-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668567487.398.4678075359650583152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     5dd56c94ca2f8834e7689cac0045d312ef3ac9c6
Gitweb:        https://git.kernel.org/tip/5dd56c94ca2f8834e7689cac0045d312ef3ac9c6
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:14 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

x86/fred: Add a machine check entry stub for FRED

Like #DB, when occurred on different ring level, i.e., from user or kernel
context, #MCE needs to be handled on different stack: User #MCE on current
task stack, while kernel #MCE on a dedicated stack.

This is exactly how FRED event delivery invokes an exception handler: ring
3 event on level 0 stack, i.e., current task stack; ring 0 event on the
#MCE dedicated stack specified in the IA32_FRED_STKLVLS MSR. So unlike IDT,
the FRED machine check entry stub doesn't do stack switch.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-26-xin3.li@intel.com

---
 arch/x86/kernel/cpu/mce/core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252..04acdc3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -46,6 +46,7 @@
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
 
+#include <asm/fred.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -2166,6 +2167,31 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 	exc_machine_check_user(regs);
 	local_db_restore(dr7);
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * When occurred on different ring level, i.e., from user or kernel
+ * context, #MCE needs to be handled on different stack: User #MCE
+ * on current task stack, while kernel #MCE on a dedicated stack.
+ *
+ * This is exactly how FRED event delivery invokes an exception
+ * handler: ring 3 event on level 0 stack, i.e., current task stack;
+ * ring 0 event on the #MCE dedicated stack specified in the
+ * IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED machine check entry
+ * stub doesn't do stack switch.
+ */
+DEFINE_FREDENTRY_MCE(exc_machine_check)
+{
+	unsigned long dr7;
+
+	dr7 = local_db_save();
+	if (user_mode(regs))
+		exc_machine_check_user(regs);
+	else
+		exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
+}
+#endif
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_RAW(exc_machine_check)

