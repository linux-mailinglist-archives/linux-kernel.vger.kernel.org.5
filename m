Return-Path: <linux-kernel+bounces-90957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA56870794
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE341F23A27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C475FDDA;
	Mon,  4 Mar 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J8EbCuUd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJ/4HWco"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734915C5F3;
	Mon,  4 Mar 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571084; cv=none; b=he451FtbR/kAplAebiBM5CiaplCqXgO19xo1hSGqFxnrNNAnBy90yETU9ETT1MSpXCq4rauxIRNg6kfZIWpXEVkxmeCBoYoeRav0C6tSf1J0tY3qClDiI9V70A0A3VEPvDTzJCZ3xLj/S5srRp2LHQ0d+ieCK8mo2i/MQ70u4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571084; c=relaxed/simple;
	bh=i6tXfhFZ8oWrAUwmqNNUvBMQ3GzBBJepVAfqRGqOkpc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AzIg3WUAeXNHt4tCc8+6aoPpF9naZhU1wRUIiXI4Vfw35VcbAxtbCIcvKV1wG2irCQPVt3rAKgqseawBPVfItdTxsSsheJikVSYBRKjsVeDzU8lsQUWQLBFicqpmwW1COXpcjvfdr6CS1FYk8UKzGOmuN4e/3cYlXGyTXX9ThQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J8EbCuUd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NJ/4HWco; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 16:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709571075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMRuvRsyJjJ7/hjtOBdi5K1Wl1xNR00QnbHV5ji7LRA=;
	b=J8EbCuUdEOOASqeZ6b1gG+n6/tlsVJdUCApX1ZLqjQLjyRYM1Dz8CGtb+htJMR8hYXSM8/
	6mJFt3ecJMNUuMkzRDTOt4LcpmwZ53Zl6DoAQek7O5shbKBNewZqyyM9NjKB4hybb8N4t7
	Zsmws7T7OYoDa/2zqyJmZ47uJZmZGZTpCKVegUxc06mUQFsCH0latbvtNt+Dgr8mbbL2bV
	/5v0/DAyj5oLhzpPMxOnISmmGXOqySuSmTriNCKu0TT5ChjI1wUb16kdndvfonlCRCzMR/
	2w3wgIOV+FkBUGi6hg7zhZ/WyEet4IubwObyLnLOpXNiAw0t4qqwzB9JGdd4Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709571075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMRuvRsyJjJ7/hjtOBdi5K1Wl1xNR00QnbHV5ji7LRA=;
	b=NJ/4HWco4IluIqAHgUv4uiMbJGb2Z1Ygn+j9JPomi2wLl1HLBIubU31CKYF9PCcbMxEAHG
	ijha7PlNusyTBAAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Cleanup idle_setup()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240229142248.455616019@linutronix.de>
References: <20240229142248.455616019@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170957107464.398.11079468274876020463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f3d7eab7be871d948d896e7021038b092ece687e
Gitweb:        https://git.kernel.org/tip/f3d7eab7be871d948d896e7021038b092ece687e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:40 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 17:39:24 +01:00

x86/idle: Cleanup idle_setup()

Updating the static call for x86_idle() from idle_setup() is
counter-intuitive.

Let select_idle_routine() handle it like the other idle choices, which
allows to simplify the idle selection later on.

While at it rewrite comments and return a proper error code and not -1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240229142248.455616019@linutronix.de
---
 arch/x86/kernel/process.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 792394b..9709959 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -857,8 +857,8 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
-	/* User has disallowed the use of MWAIT. Fallback to HALT */
-	if (boot_option_idle_override == IDLE_NOMWAIT)
+	/* If override is enforced on the command line, fall back to HALT. */
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
 		return 0;
 
 	/* MWAIT is not supported on this platform. Fallback to HALT */
@@ -976,24 +976,14 @@ static int __init idle_setup(char *str)
 		boot_option_idle_override = IDLE_POLL;
 		cpu_idle_poll_ctrl(true);
 	} else if (!strcmp(str, "halt")) {
-		/*
-		 * When the boot option of idle=halt is added, halt is
-		 * forced to be used for CPU idle. In such case CPU C2/C3
-		 * won't be used again.
-		 * To continue to load the CPU idle driver, don't touch
-		 * the boot_option_idle_override.
-		 */
-		static_call_update(x86_idle, default_idle);
+		/* 'idle=halt' HALT for idle. C-states are disabled. */
 		boot_option_idle_override = IDLE_HALT;
 	} else if (!strcmp(str, "nomwait")) {
-		/*
-		 * If the boot option of "idle=nomwait" is added,
-		 * it means that mwait will be disabled for CPU C1/C2/C3
-		 * states.
-		 */
+		/* 'idle=nomwait' disables MWAIT for idle */
 		boot_option_idle_override = IDLE_NOMWAIT;
-	} else
-		return -1;
+	} else {
+		return -EINVAL;
+	}
 
 	return 0;
 }

