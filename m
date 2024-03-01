Return-Path: <linux-kernel+bounces-89117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1EB86EAA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BF21F25627
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99375676A;
	Fri,  1 Mar 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Cr4tHB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21GV2Gwi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EA535D8;
	Fri,  1 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326129; cv=none; b=AfKDetijrQDzjVLxksfPjkIxOuH13SOML5J5c5T6JYDO0ageyQn2IisJRKIXukRI8g1Ux5ZxYGOSyZiEOyZQ2KthiofbYWjnn5wnYzquKGuZVn7iDnlqoskmF0VMMv3s8h7/UBNMzi5i8dPhoPkyCuz4ZMh9LVVOLRc6siz8RvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326129; c=relaxed/simple;
	bh=/OxaSFUwbcZjdgz+qP4MfHULJH3O18mktXxiQSh+XM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WTzuKuNuxSnc+nfCcD0vrwh9x47VUKp3w6f+AkNyPnGDxWaR9ZMkFVWBvoh1g6tnTmtPke+G8u7dLULdlk/HUX3FbxWIXPDyKJ1aiKXrjSdmk/W2WdeL5bP0R3fW7bLy14kWjpNWiDGIhoN9eNvh8B0yr7kSywL3m3V1Ux7U2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Cr4tHB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21GV2Gwi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 20:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709326122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui3SYieBqqn1j62erXEiR8w6UOpmPbPxN3xpDtByAec=;
	b=3Cr4tHB9Hebi0Zn/qsazggdb+uX5Js+pXFWxBmWwWPoKQG8JWmAruDtA+C46Vvt0vBGif4
	kccw/YWUafw1SuUPSmtZZjUdh9xzw4Hs5dEL1MxlYTgPjFmcd7LgAMrSoKYinqpQWRmDw2
	p8AyqkeL/CzX5rvcW0CGjtERZJGt0mOxSTWgU4SXqtJiThvtG1yhrykrLg57dh2YuKceQi
	DcYRfTbq0OiKbKfKEqKYLJ5Cpec2NHfq3cKHdLmrLX6J64kBzp/ZxqALMJ82G7T2j4g5md
	xl13dINkgxsuFDdunpFxCUTgFtN/zLfRYqIY7oX7GZAsqKNEnwh+u/fperJjDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709326122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui3SYieBqqn1j62erXEiR8w6UOpmPbPxN3xpDtByAec=;
	b=21GV2GwiUo162b/A6Y7eW06c75dWTm+QzqMzvqdYUgud2eJM2Cv/puK0gbdEXqSfRk/Xxu
	xNdvt7fHqU7RQRCA==
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
Message-ID: <170932612188.398.908153831570095821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     695f90619cf785f8a13cbf21bbfddae103542fdf
Gitweb:        https://git.kernel.org/tip/695f90619cf785f8a13cbf21bbfddae103542fdf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:40 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Mar 2024 21:33:12 +01:00

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
index b6512f7..678d5cf 100644
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

