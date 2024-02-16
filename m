Return-Path: <linux-kernel+bounces-68832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF98580CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B381A1F222EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A114A0B3;
	Fri, 16 Feb 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNvhz1xT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQavSsHk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4912F58D;
	Fri, 16 Feb 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096642; cv=none; b=VdcT6PjzeFT/n+anxgkcEbJxwiQgCv2/60KtDp/4AfPCCBRXmAARsG5rbvpdE/wye9CPkJMAgRau8ojsoCyy2qmgdC90TzKpfTJuHEgDA4TwUSdNnq3x7Wna93Hrp8K1+BPhrHQ0/x5+dRD+l35ISJ2XJILPweFOSbDIowIIRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096642; c=relaxed/simple;
	bh=Dm2iZ9HLlGYd37OtAQ8x9GyVGjKS2r9PKcMY9oxKvXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oycAM9oQmqTneUaWvnZSAcram6p0f4EUszPuKHOqNFnksppBHQKTKof1FDo6iaz41ST0yLR+Grm84YUFO1Zs8dv3dsvyEGBBgCsxbtT6qrqRKYKervLHk/WjpT9scuWQjRxN+4rjLqF2WBoLPhsuuBsUVQqdKkPHBEvGhr+DC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNvhz1xT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQavSsHk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnW/7hFzJREU+amgRdoJeNGQYxeX1T9VLva7Rqt9CSk=;
	b=pNvhz1xTL41UOW++DAAcb62bl18Se5GQQmSTAdQrkRzfVt7JR3BBunR/g9bEc78VdxpNeE
	ovLXpzjipkYqd7peJT20bEnlBMJcj2lEbCYgasG4H4yZJCP7H7wVFCjq2IoYF8LKP/Pj8Z
	8buA1twE9wZl8Qf0C60BJAaVDquO+uqZEMyTPGemCfEZMcZmu77JhOZjMWWry6TTStP+u2
	zT7LNAbHnsoW+5UyyBzVUS9Dg+i+Lw9lUVSI73trWfmF7+XhMRbFRvKUDVPN6rygO3C+sp
	CLUhY8D5GpHiqBh6PS4T/bAc+aI6B/qKFg8c30af+QV6YgGY4mGw2DvSk/Cqsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnW/7hFzJREU+amgRdoJeNGQYxeX1T9VLva7Rqt9CSk=;
	b=NQavSsHkPzRq8fd9cg73GWFIjO13gZS19j23L7FjsECWpPdoZAQpkT3HVI2yErbNkahfvD
	B/7yWGEWQro/4PBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/mpparse: Prepare for callback separation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.433811243@linutronix.de>
References: <20240212154639.433811243@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663835.398.15945356152743640847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d0a85126b137598eab969e5ba283e5e70ca9c686
Gitweb:        https://git.kernel.org/tip/d0a85126b137598eab969e5ba283e5e70ca9c686
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/mpparse: Prepare for callback separation

In preparation of splitting the get_smp_config() callback, rename
default_get_smp_config() to mpparse_get_smp_config() and provide an early
and late wrapper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.433811243@linutronix.de



---
 arch/x86/include/asm/mpspec.h | 12 ++++++++----
 arch/x86/kernel/mpparse.c     | 12 +++++++++++-
 arch/x86/kernel/x86_init.c    |  2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index c154dd7..72700ae 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -60,12 +60,16 @@ static inline void early_get_smp_config(void)
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
 extern void mpparse_find_mptable(void);
-extern void default_get_smp_config(unsigned int early);
+extern void mpparse_parse_early_smp_config(void);
+extern void mpparse_parse_smp_config(void);
+extern void mpparse_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable	0
-#define mpparse_find_mptable	x86_init_noop
-#define default_get_smp_config	x86_init_uint_noop
+#define enable_update_mptable		0
+#define mpparse_find_mptable		x86_init_noop
+#define mpparse_parse_early_smp_config	x86_init_noop
+#define mpparse_parse_smp_config	x86_init_noop
+#define mpparse_get_smp_config		x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 86acccd..b22093d 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -473,7 +473,7 @@ static int __init check_physptr(struct mpf_intel *mpf, unsigned int early)
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init default_get_smp_config(unsigned int early)
+void __init mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
@@ -538,6 +538,16 @@ out:
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
+void __init mpparse_parse_early_smp_config(void)
+{
+	mpparse_get_smp_config(true);
+}
+
+void __init mpparse_parse_smp_config(void)
+{
+	mpparse_get_smp_config(false);
+}
+
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0bbef49..5d86d57 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,7 @@ struct x86_init_ops x86_init __initdata = {
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= default_get_smp_config,
+		.get_smp_config		= mpparse_get_smp_config,
 	},
 
 	.irqs = {

