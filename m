Return-Path: <linux-kernel+bounces-124265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D3891494
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011531F21A57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA93FBA9;
	Fri, 29 Mar 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hi0lZ629";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vH2do/Bw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99263BF;
	Fri, 29 Mar 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698677; cv=none; b=Kr65wmr+ADMPyOww2y+04VjjIJR7Mxc70TdnvGMXqSKmwGXmgeLtHozOc5X6vhFrsYZFzj/zT18iZDIIYeP8tOJPdYpe20iphzhuBXAEmdlKGLCSc4g97LK0QbEuLB8eBDe7g9Fwvki+4jbHmU49U+KQ5vBTKXYD6BAbm+xYMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698677; c=relaxed/simple;
	bh=DijPHlZoho/gxOYG+ypa1AJJx0OryDWb8Uwt0tqD2jc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=txnFBASfOLv8dfEhM+ly5HulBThzQ8Kr6FDJU2Ji8gR/KzUWxp+2DVLxG50rBOTCj+1SqOn/WhitLIyAL2YcD7K1qhqXCb8SR5+gfwsYcdVfow0tAmUgBoRWJCvw3L0h/sBSbGvQYgCxgMxa+Q3jg4KDj6zVg1S9jRIIXSmTuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hi0lZ629; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vH2do/Bw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Mar 2024 07:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711698674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7nYp5UyeR9UYMTm/N3FIPoXmWeeLhDWSva9Pa+3tKyc=;
	b=hi0lZ629jqnSVWKLLpu9pZSsT+3O90wWZzOuy/foKhA/2TArz2lt95QI825/9jK9T8sRdK
	oPhu9xWgKvK32JIXuzQglACqqRXn8butaB9X4qs+Q3S8LNFba3t/B7AHpTsVAQHw0ZH6TW
	dDd6AblCDNcCz2RwfMiaey6f2CNgnMbZgS3LLXiH2QveOejzHP2EnqTMa39i7qit7/lj0H
	g/GY8oZfrgfrXzM+0B+NkzCuiG8LsMniTxdwTC8vGZpe3Ii2DICPG/icUtLPEqO4QZJL7Q
	XrLj7PZ+g/NpAfy3Ak60WEx9P1GfN2e+nN8/XHuDPKXM50ztPBniqCGJrnnKtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711698674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7nYp5UyeR9UYMTm/N3FIPoXmWeeLhDWSva9Pa+3tKyc=;
	b=vH2do/Bw15M4ZoNNZSCKOhnRYpGq1e3kmfyP6fBG5Apj6cjzxg7CcL+e+6nOauN8EUaB/C
	GjdPMRiwHUkSU1Cw==
From: "tip-bot2 for Julian Stecklina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Move kernel cmdline setup earlier in the
 boot process (again)
Cc: Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171169867308.10875.15117897441999380027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4faa0e5d6d79fc4c6e1943e8b62a65744d8439a0
Gitweb:        https://git.kernel.org/tip/4faa0e5d6d79fc4c6e1943e8b62a65744d8439a0
Author:        Julian Stecklina <julian.stecklina@cyberus-technology.de>
AuthorDate:    Thu, 28 Mar 2024 16:42:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Mar 2024 08:19:12 +01:00

x86/boot: Move kernel cmdline setup earlier in the boot process (again)

When split_lock_detect=off (or similar) is specified in
CONFIG_CMDLINE, its effect is lost. The flow is currently this:

	setup_arch():
	  -> early_cpu_init()
	    -> early_identify_cpu()
	      -> sld_setup()
		-> sld_state_setup()
		  -> Looks for split_lock_detect in boot_command_line

	  -> e820__memory_setup()

	  -> Assemble final command line:
	     boot_command_line = builtin_cmdline + boot_cmdline

	  -> parse_early_param()

There were earlier attempts at fixing this in:

  8d48bf8206f7 ("x86/boot: Pull up cmdline preparation and early param parsing")

later reverted in:

  fbe618399854 ("Revert "x86/boot: Pull up cmdline preparation and early param parsing"")

.. because parse_early_param() can't be called before
e820__memory_setup().

In this patch, we just move the command line concatenation to the
beginning of early_cpu_init(). This should fix sld_state_setup(), while
not running in the same issues as the earlier attempt.

The order is now:

	setup_arch():
	  -> Assemble final command line:
	     boot_command_line = builtin_cmdline + boot_cmdline

	  -> early_cpu_init()
	    -> early_identify_cpu()
	      -> sld_setup()
		-> sld_state_setup()
		  -> Looks for split_lock_detect in boot_command_line

	  -> e820__memory_setup()

	  -> parse_early_param()

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/setup.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3e1e96e..4c35f1b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -753,6 +753,22 @@ void __init setup_arch(char **cmdline_p)
 	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
+#ifdef CONFIG_CMDLINE_BOOL
+#ifdef CONFIG_CMDLINE_OVERRIDE
+	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+#else
+	if (builtin_cmdline[0]) {
+		/* append boot loader cmdline to builtin */
+		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+#endif
+#endif
+
+	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+
 	/*
 	 * If we have OLPC OFW, we might end up relocating the fixmap due to
 	 * reserve_top(), so do this before touching the ioremap area.
@@ -832,22 +848,6 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
-	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
-	*cmdline_p = command_line;
-
 	/*
 	 * x86_configure_nx() is called before parse_early_param() to detect
 	 * whether hardware doesn't support NX (so that the early EHCI debug

