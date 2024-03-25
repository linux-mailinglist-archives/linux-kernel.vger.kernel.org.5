Return-Path: <linux-kernel+bounces-117141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB188A7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3BB34047F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7B3DAC1A;
	Mon, 25 Mar 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wT4dj9SB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmYACl4o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374F3DAC15;
	Mon, 25 Mar 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373018; cv=none; b=pUacYKpcJ4GgkaD1DjJR8g8FZbFqnMHboCr4jTZwAf73ZHRPdSTK04MQS3/MQ0jRUr1YLw/+z0aDZHqlah1HWZuqKs+Ks+YAfuOMdEa+aRqkMZc6mRpQDs0MkTD6r98DxK920F7Wd+GZEQ7nxlVQ8Li3DYxrRJfWK1WrZ/9OLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373018; c=relaxed/simple;
	bh=onwkshrOUCQ0AAJooAtvWh0R2DTPYV6RFnrsuqdeQ/c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JXS6bNS4K6He4Em81IdW99I9RvLnlv7LZFZjFLusGq5KRqt1AcxAqtBrprX/AVjWmMl3bZPYV/+F50YLQyw6kGozEGPF3CqQ+PtyGw52pvUKuwOwMb7GrxxkFrI3bMb6ayTTZKjMyc9qQSTiUrHS1FMr4qkwXYPm8+X7QHe+fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wT4dj9SB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmYACl4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 13:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711373014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4+xfAyqNRt4fsNPmwIAmAhgXCcUHA29krOozsIzUkg=;
	b=wT4dj9SBt+0A3VAbAdU04Xnabi4Q1p0Fla7xe7UcTzEa14Cdy6BUBmpDf1HNHkZ85xCAVx
	/IrsTy9e4cQKaO5bO/Jn+fDxI7iK7xdDx1llqWSoB56mzcdfBCw8TtF4cem2xG+233s8T+
	E/kbAjLUxw5ncPGuBFSSRwbwOCHV2vnFhWa9u+IS7/W/IfFpfbN1Nerof0SsVY0luCg/nz
	fTCXWtRtXoognyNxCb+H8i5RS6eSeFyviLAdYHgxvOP3PNR+c3bSIlzpslYBCK3kX9aXY9
	D10R+Th0/F5It77dOQW6ykA+C92oaWuhrkxLhhwm/KeWPZ49cDy30KCoyhDZUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711373014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4+xfAyqNRt4fsNPmwIAmAhgXCcUHA29krOozsIzUkg=;
	b=KmYACl4oYWr95OP8y1GhftQpHbTtpyOQkgwQ2UPlk20Hrq8WH/BeY6id1kXwyqmuaSYgeB
	QCuldn3xPewWN/Cg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Improve the erratum 1386 workaround
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local>
References: <20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171137301379.10875.14695462741547112458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     29ba89f1895285f06c333546882e0c5ae9a6df23
Gitweb:        https://git.kernel.org/tip/29ba89f1895285f06c333546882e0c5ae9a6df23
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 24 Mar 2024 20:51:35 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 25 Mar 2024 14:05:24 +01:00

x86/CPU/AMD: Improve the erratum 1386 workaround

Disable XSAVES only on machines which haven't loaded the microcode
revision containing the erratum fix.

This will come in handy when running archaic OSes as guests. OSes whose
brilliant programmers thought that CPUID is overrated and one should not
query it but use features directly, ala shoot first, ask questions
later... but only if you're alive after the shooting.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lore.kernel.org/r/20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local
---
 arch/x86/include/asm/cpu_device_id.h |  8 ++++++++
 arch/x86/kernel/cpu/amd.c            | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index eb8fced..bf4e065 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -190,6 +190,14 @@ struct x86_cpu_desc {
 	.x86_microcode_rev	= (revision),			\
 }
 
+#define AMD_CPU_DESC(fam, model, stepping, revision) {		\
+	.x86_family		= (fam),			\
+	.x86_vendor		= X86_VENDOR_AMD,		\
+	.x86_model		= (model),			\
+	.x86_stepping		= (stepping),			\
+	.x86_microcode_rev	= (revision),			\
+}
+
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6d8677e..873f0fd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -13,6 +13,7 @@
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/spec-ctrl.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -802,6 +803,11 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	clear_rdrand_cpuid_bit(c);
 }
 
+static const struct x86_cpu_desc erratum_1386_microcode[] = {
+	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
+	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
+};
+
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
 {
 	/*
@@ -811,7 +817,13 @@ static void fix_erratum_1386(struct cpuinfo_x86 *c)
 	 *
 	 * Affected parts all have no supervisor XSAVE states, meaning that
 	 * the XSAVEC instruction (which works fine) is equivalent.
+	 *
+	 * Clear the feature flag only on microcode revisions which
+	 * don't have the fix.
 	 */
+	if (x86_cpu_has_min_microcode_rev(erratum_1386_microcode))
+		return;
+
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 

