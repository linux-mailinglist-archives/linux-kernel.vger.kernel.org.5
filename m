Return-Path: <linux-kernel+bounces-137377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8189E12E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2384628638A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC8156668;
	Tue,  9 Apr 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Al8mFl4S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0h6Mfc5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03526156220;
	Tue,  9 Apr 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682696; cv=none; b=ZJuHP9FiEB2y72waSss5vyIsPlFU5fPIEEXx7xkV0bDsuIatTqn1pbCLQkj+RRh4csOo1pYXmsy6KFrUQdU8kMLfHSoLnA88e8+vYl0tvZkGeADdcJVbqThzrf7KApkP15KryVmsmMlwyESIcA18OP17vCJRRxnvPMJPEnJ/pUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682696; c=relaxed/simple;
	bh=SBwp4FIi+xGSX6fUSbg/722dbayUuOp7g15zVEiHioA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u1oZtqQcnL8lAcBN8BaL26XHvTdQhlOqYzgcZ2a2F7bj18JwjWRoDwcl7Giu4lloia/AW2+eHy05urpJmxOrIo4VcrK6bA6kezm3pbpunyM60iKi7i9FuqWdV23HLQbexHNp7wpLwf/wqmHrybIX4pxrpZjhjBXCB7Hdtk2Lo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Al8mFl4S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0h6Mfc5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 17:11:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712682693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYQWJatz/tGYxKhDty9VBTDs+ZeurAA5CNoJu77a3Ks=;
	b=Al8mFl4Ss/0ECD9JuUjeqUDc+99Sy90LLLoS53yxX/sTdUcZiKFfaOyW3a6v/TGg8qnmVO
	3p8qleL00BwWv4hH2MT+u1Z8EhHQFYeIf4k7NxqkP0FlmPc2v+BKYt89+EVCjgpywvGHWD
	Mq/tXG+Kmqvw/kAFvlmCsVK9o9w5ghHJ+0wru2qJTL0UMedBcf4GE4r7iscM+zVdjvzPoC
	D56ikrQfnhu9Wfb4BUA5VXiVkXFEFwEAeiFO79UfoJpCA5YAPP7LG7MtWqTMqFudSX7RJ+
	3Uty5hPvND/5LSfUWWZvwJaRbjtIc6vuYtEZLhX6MK72R5qJb8CGF996MmFT9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712682693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYQWJatz/tGYxKhDty9VBTDs+ZeurAA5CNoJu77a3Ks=;
	b=G0h6Mfc5N+0kDvHD8qMwa1Qqe0tniB8f652h5uNlJA7V9pUxrccofS79xEoCZJVBIGgj+W
	AoD+TMEO1SwB5VAw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Catch late X86_FEATURE modifiers
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Srikanth Aithal <sraithal@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-3-bp@alien8.de>
References: <20240327154317.29909-3-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171268269269.10875.17747775043118568657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     ee8962082a4413dba1a1b3d3d23490c5221f3b8a
Gitweb:        https://git.kernel.org/tip/ee8962082a4413dba1a1b3d3d23490c5221f3b8a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 18:03:53 +02:00

x86/alternatives: Catch late X86_FEATURE modifiers

After alternatives have been patched, changes to the X86_FEATURE flags
won't take effect and could potentially even be wrong.

Warn about it.

This is something which has been long overdue.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-3-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 8 ++++++--
 arch/x86/kernel/cpu/cpuid-deps.c  | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 686e92d..f07687d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -150,8 +150,12 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
-#define setup_force_cpu_cap(bit) do { \
-	set_cpu_cap(&boot_cpu_data, bit);	\
+#define setup_force_cpu_cap(bit) do {			\
+							\
+	if (!boot_cpu_has(bit))				\
+		WARN_ON(alternatives_patched);		\
+							\
+	set_cpu_cap(&boot_cpu_data, bit);		\
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
 } while (0)
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b717420..5dd427c 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -114,6 +114,9 @@ static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 	if (WARN_ON(feature >= MAX_FEATURE_BITS))
 		return;
 
+	if (boot_cpu_has(feature))
+		WARN_ON(alternatives_patched);
+
 	clear_feature(c, feature);
 
 	/* Collect all features to disable, handling dependencies */

