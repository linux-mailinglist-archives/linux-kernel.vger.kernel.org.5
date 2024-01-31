Return-Path: <linux-kernel+bounces-45918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8FA8437D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10551C25A98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68682869;
	Wed, 31 Jan 2024 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fUC2xB4o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZRvo7zji"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2F7F482;
	Wed, 31 Jan 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685692; cv=none; b=Q7UVeZefwUtoVxx18s8syfCBpio3dOqmewIKtf68HVEa5HZbKdZAuHkVWLiYLpx1JWYjCkn/83h5OQ87UcByJ0ddqMGCddJVF7DdxrMBSALlSp07X3+uyXUnXksvP2i1V83D1jwXO0mjNiJm6fwPPidMafUgfdBUiQfp57BrLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685692; c=relaxed/simple;
	bh=+pATjSzwErfM3A7JywPE5FqmSPto4bh7XvANozFZDOY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dMzczrhJn6e7eYH6W4w9T1mPfR6HLjoi4fmoktP6LBk+3cRAY010wC4zytW2DPisyaAlJSDOe8h1rrvIbWhH5rMwaqDmtYBOQ7rEqz9N3/tBb4X0bdqYs2J8u32AtWVeAZyyP9a5KpeHRL47KHCiaTKGsqeYFqQxmQUx/FB/S7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fUC2xB4o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZRvo7zji; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blkPyz8j7UfdQ2JBSA1Upp8rLU7BQRS90Sa9adYoXMU=;
	b=fUC2xB4olV3DabMwxhKlUH1Mimnr9/LpMlXcMTXboNEXUOj0d5g7h7k6tZK6sy76wLWgxJ
	pReNMgywpYZvTpwuDlrZ7xL1sSsgbN1dVI/osT9E7v0Mc7kpbTiszUSxRt1pfK9O3HV3/A
	E2hqT5ugpdtQLOa3o+xeyYhB/cY+qZPill0CTPY79iGEVU0hAGOdm3k9j37hswDdRaVmL5
	uw/f2k+TULVid2lCI4bdWOfmxJKimD7jf9T2Jz2diGdPt0suItAsVFu+eDE2kIA/NaVsDo
	UlvpVM944hLtcjlP69kE5M3ed9nQYAguQcTnBzO29sULIKnL9053nESZU98ouw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blkPyz8j7UfdQ2JBSA1Upp8rLU7BQRS90Sa9adYoXMU=;
	b=ZRvo7zjiImFVbUanN+NdS761T4FRNh89ht3YJiOAZj1/oavKsJzOku/6jhMnF6Q8t1UGUU
	fyQru09t92N6esAA==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a fred= cmdline param
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-9-xin3.li@intel.com>
References: <20231205105030.8698-9-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668568846.398.2224540814571562742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     3810da12710aaa05c6101418675c923642a80c0c
Gitweb:        https://git.kernel.org/tip/3810da12710aaa05c6101418675c923642a80c0c
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:57 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:19:20 +01:00

x86/fred: Add a fred= cmdline param

Let command line option "fred" accept multiple options to make it
easier to tweak its behavior.

Currently, two options 'on' and 'off' are allowed, and the default
behavior is to disable FRED. To enable FRED, append "fred=on" to the
kernel command line.

  [ bp: Use cpu_feature_enabled(), touch ups. ]

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-9-xin3.li@intel.com
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++-
 arch/x86/kernel/traps.c                         | 26 ++++++++++++++++-
 2 files changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25..d6ea4f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1539,6 +1539,12 @@
 			Warning: use of this parameter will taint the kernel
 			and may cause unknown problems.
 
+	fred=		[X86-64]
+			Enable/disable Flexible Return and Event Delivery.
+			Format: { on | off }
+			on: enable FRED when it's present.
+			off: disable FRED, the default setting.
+
 	ftrace=[tracer]
 			[FTRACE] will set and start the specified tracer
 			as early as possible in order to facilitate early
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c3b2f86..3c37489 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1369,8 +1369,34 @@ DEFINE_IDTENTRY_SW(iret_error)
 }
 #endif
 
+/* Do not enable FRED by default yet. */
+static bool enable_fred __ro_after_init = false;
+
+#ifdef CONFIG_X86_FRED
+static int __init fred_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		return 0;
+
+	if (!strcmp(str, "on"))
+		enable_fred = true;
+	else if (!strcmp(str, "off"))
+		enable_fred = false;
+	else
+		pr_warn("invalid FRED option: 'fred=%s'\n", str);
+	return 0;
+}
+early_param("fred", fred_setup);
+#endif
+
 void __init trap_init(void)
 {
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
 

