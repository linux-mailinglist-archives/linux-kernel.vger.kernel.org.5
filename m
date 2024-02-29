Return-Path: <linux-kernel+bounces-86833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1986CB68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AB4B254A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9C137758;
	Thu, 29 Feb 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQxTa00y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wht6X27n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4812E1CC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216624; cv=none; b=hL+UlSINz/SRVByhQwbQLO0N6X24+O1B6ErlnXts+pjIMjIblSbJMTLkv2yk8a8Ef7e1omkwHkJr+8i2h/dC39Ycew0MXa4T9FPFBBVx7fZ4d6Jmj+bQ8M9WB29LnSJmBKKxN0E2yKxBm2ieCQb+qCNxgXtuZYeGbQ2Ab3Okhss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216624; c=relaxed/simple;
	bh=4gP+iCapKlXKlht2djclMxdp9+iBcME2VXu0sjNJfdY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=TzTi13fwB0QnoqV3sHBqPCCE5pEDUvMtJGFmV4LSYWWehY3QIijt5D8/WvEYbkjOKI7VdhrnjA6gGgJwJkzU5skP3LgHmdo8V8UH2I6guh/XLR6heVxOiVT8mBEAJqBGKqeEtqsQa3RL8u6xlAfU3r8EFD7Kx0jGtwJbCyZpgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQxTa00y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wht6X27n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229142248.455616019@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5zOS4RmiqmuxETrUeHDkk2a5VYE4kSbamD+YHfMNWQI=;
	b=gQxTa00y5xXOnO+IsbeQpXwy0aF7+r804PplTpYmFwo3UCQHh2zhkCjgDXY9ylKgsECxD+
	bRq471S+WVE8Gbmhz3YjVkvMxTUPpgkde/anMmbl4FQUmNOCZRp0nvPx8nxK58V5LYTfS2
	W6CD4MnuV/99WwLbvwOEM8CQPVvmpcFWjR6JLZtJp31pQy5GscAJAzn/dNvHbBOkzgtB3U
	1yTa7uWypi16DwEEs0E8UCQfGPeFVJuei7VaP9Hc0D3cu4Ox7UfH6GP1jcKCGcJGtNF/oP
	MHs9GBcsMgnAr6AkZyjOMCag1poyYi9zdsfAsfi//A7vSmu9sqUikTQQLAR77Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5zOS4RmiqmuxETrUeHDkk2a5VYE4kSbamD+YHfMNWQI=;
	b=wht6X27nW2dY56wOgfMT4WpRGpikBJZUKKltKmZUE7iUq32/vSKbWZii1rHIT3siqAVr+r
	i1he2N7vAGxefxCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 4/6] x86/idle: Cleanup idle_setup()
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:23:40 +0100 (CET)

Updating the static call for x86_idle() from idle_setup() is counter
intuitive.

Let select_idle_routine() handle it like the other idle choices, which
allows to simplify the idle selection later on.

While at it rewrite comments and return a proper error code and not -1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/process.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -857,8 +857,8 @@ static int prefer_mwait_c1_over_halt(con
 {
 	u32 eax, ebx, ecx, edx;
 
-	/* User has disallowed the use of MWAIT. Fallback to HALT */
-	if (boot_option_idle_override == IDLE_NOMWAIT)
+	/* If override is enforced on the command line, fall back to HALT. */
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
 		return 0;
 
 	/* MWAIT is not supported on this platform. Fallback to HALT */
@@ -975,24 +975,14 @@ static int __init idle_setup(char *str)
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


