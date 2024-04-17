Return-Path: <linux-kernel+bounces-148897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C78A88B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BFB1F21ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE20148836;
	Wed, 17 Apr 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhjPI/0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+gOervJP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E81411E5;
	Wed, 17 Apr 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370845; cv=none; b=WW1CDiQ7s/z7CklUkMuYbwxcX0tQgVYJMDaIko+fvh5Dkm7tw20lsA3ufxadPqjcOsT0NYX7qK5UvXUBd3LgtFqW+kxMiMSedMm7KPRuOuqAhWeY4/5RijfjdIAU0DHGRgqY253S/2W7Izt7abQK+mhZmFQ7uvvigdIU7AW7dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370845; c=relaxed/simple;
	bh=WvRqDAOGM1jvsBeaH6GT/HasZDYxKW3jTSqaapCeaOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QJ9JD8V64PdkkgL7JQzKOHmU9DPuc9syXxBv7mJGxZwuV4onEGjMzUer2EldVoGWJtNIl6OjU2kCAgqqx05fg8wqjNrLkbjJwOOztLKKkv0IBGWSbnPrpr/05j4t81xoqZM+GQ4KEoFHjGilWgwYRFpcYf3iiEnqODEO2beC1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhjPI/0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+gOervJP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 16:20:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713370842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwzTSJdCNy24smZLpTE4WljCedgTHM2JpxAfIkTwyt4=;
	b=dhjPI/0VMdBSkBl5XfFat0CCFcC2C7scN+JK4fOhgFkYZ0zMSbgBQ4nRPo4Yf9UUUUsz4O
	kA6URHBuae14lTdrU6fxY0HWnQQ7g+YHj+eJQy5T0PLHvh3WBUk/H8nt0IcNhA1uBU5K+j
	dvPxcW7esf6UN0riWxiAHY3oNliUfofRAP9jINefZdwbdHa5WBjIJUiQgtvg22IgKCyhkO
	ZOhSXjIOooA+/BS1YS+5nB5wzrpgHBxu61GIjRFc5I8uAv4hEicYYE1mlnSIx3x8FsfViG
	603m0MUCwJ481c96FnuYfU1VTVZ/0a/SKnzyC89RVuEdBEYbxy5tnWbBMkVoSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713370842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwzTSJdCNy24smZLpTE4WljCedgTHM2JpxAfIkTwyt4=;
	b=+gOervJPalJBHPT1qUYoVzl4s1Niik0HwXr76RGPGP/ibokO7i6Q3yEFXIV4sHGwl1AQ6E
	tYIizffTqQS7ctBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/retpolines: Enable the default thunk warning
 only on relevant configs
Cc: Klara Modin <klarasmodin@gmail.com>, Erhard Furtner <erhard_f@mailbox.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
References: <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171337084085.10875.15469076883683682514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6376306adde5b252ee7c73572e35d13fb13f6f18
Gitweb:        https://git.kernel.org/tip/6376306adde5b252ee7c73572e35d13fb13f6f18
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 15 Apr 2024 18:15:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 17 Apr 2024 18:02:05 +02:00

x86/retpolines: Enable the default thunk warning only on relevant configs

The using-default-thunk warning check makes sense only with
configurations which actually enable the special return thunks.

Otherwise, it fires on unrelated 32-bit configs on which the special
return thunks won't even work (they're 64-bit only) and, what is more,
those configs even go off into the weeds when booting in the
alternatives patching code, leading to a dead machine.

Fixes: 4461438a8405 ("x86/retpoline: Ensure default return thunk isn't used at runtime")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Link: https://lore.kernel.org/r/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com
Link: https://lore.kernel.org/r/20240413024956.488d474e@yea
---
 arch/x86/lib/retpoline.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index e674ccf..391059b 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -382,8 +382,15 @@ SYM_FUNC_END(call_depth_return_thunk)
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
+    defined(CONFIG_MITIGATION_SRSO) || \
+    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
 	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
 		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
+#else
+	ANNOTATE_UNRET_SAFE
+	ret
+#endif
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)

