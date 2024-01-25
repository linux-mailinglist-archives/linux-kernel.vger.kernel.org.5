Return-Path: <linux-kernel+bounces-39086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7783CAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815B2299D36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A3137C37;
	Thu, 25 Jan 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3S1+a/T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQWH+9TS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DE1339A9;
	Thu, 25 Jan 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206890; cv=none; b=b6zYTLo60wyHc5YBgsnsWpqogSd8M0BxTXTMA++kxivxEZEHcyAlnMDDam19cvs22/xE3RHNovSPqdqHhZqd3qx/q+dnigyRBNb5BEY0lVdb+EIprclhQNJT4ZBnPMs286nY3MLhGh3VIzK+kAh8phF2ija+VRKc7RoFEc8f8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206890; c=relaxed/simple;
	bh=wKvOQw1uszeL6VYYEJrbAlMBJOc3QxqgYRWGjkv4gH8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JExCPG7mVlDlyiUGEtoiSmhL+4255xB6QcoekqARZfHkORaimjtJVodcCwOjfbmfKLfGnKe6diEPMYfA0peCAggqOtH8lfpVIBAR2bCL9xkpjIqZRzFYBnlse+P0V5WWkseejfnOhZ1KPDOvXlNvUh2EO+qnMvejQq+LKSaEdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3S1+a/T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQWH+9TS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8u+Msm+yv8ypCZfws1Dj3v3kPTNmCH1FJ/UI6VO4YA=;
	b=f3S1+a/THtYtHTb61nB9F2MX+h9YaIamEDMIOi4D9GGS6z2oIvCweru0ecks+816VhvG2S
	pGiszvbldPXWcqGmUcs6cXDkq3NUKgeAQbVj4qXlM+4yIJjrRDzgV8rxZaXCjr7SraR5pb
	NXrthADy1ovrkBdd1VYeDXYlI4uGxhYwTnXkj0Gc/HbJYFHxe531O7j/0ui49UZHxagg5T
	dCdTKBVywGTq4gDi4+dq7snUmErDSkLuaInRfOAZr134jjU42TC42zmgG3DR9SZuXZRS1b
	QRnn8kPhcFf1FWyDkG3sEJhc+xEBUSIeBXWGPMbUXQ0oXxCwFVbC2vCttQ1XIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8u+Msm+yv8ypCZfws1Dj3v3kPTNmCH1FJ/UI6VO4YA=;
	b=SQWH+9TScnwKyeI+2HUXIdCJ+hnwI/21Bhj6H8Mh+FLsrOUD3o3T7tMppa4c34uoVjgmJs
	YJ1B0B/rzztn1yAw==
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
Message-ID: <170620688226.398.1635592939916863509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     4aa4dce58fb07380c5a63c1993d0478f7ee195d1
Gitweb:        https://git.kernel.org/tip/4aa4dce58fb07380c5a63c1993d0478f7ee195d1
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:14 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:32 +01:00

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

