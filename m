Return-Path: <linux-kernel+bounces-142458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AB88A2BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC00B25EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101B54668;
	Fri, 12 Apr 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AEEEPuU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1QNn9r1g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0652F9C;
	Fri, 12 Apr 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916209; cv=none; b=uW/8Nn/9jOgTNepziTprbPYDAq67pivz514YXt2KIuKj/l96VqyXcd/4I8lzjBFeS9UD9VvEcsBnr096WUK4lCpPROPuCCmlgRWr1i1I4FPKdjNE00ZNbqcQ+jZqruBEGcrleVdgVDgr3BNVAA+R7HrgWPSHKXuT2QYgVcGbg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916209; c=relaxed/simple;
	bh=HMlfKgG+IBRbY2u0j889PwOzLC/AtJbwbVg1f7xSiVI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RzEzos2wIEYMYHZ1ryaw49vU6sInlu5uKptNsBgOOzwVKilC9LmOtyuVFxGc1nvzy7s+LhnrYZ7XO8pIbfWq4RuYaC2MXxCz3k2rImECtGiowSc/bieVwfV+BYrZ5J4JX+s5GVk2Q8VL1h1xamFHJDyBYBHhF5Mt/RnrEN4PPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AEEEPuU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1QNn9r1g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAWn/cFjvTk+aXbcVOZIgrYlc5atTEL1VmaicMWN/Gc=;
	b=AEEEPuU/evWhP3l3dk7fX9fveomKuDwqCrBb2q1E/EmNzKVBxRDYYU4AVfX5PdnP8kWXNe
	kmS9WWB7eUqtTQTIl3NVAEfN13QIOaWzWop3PiYANFOoVv9vOno/MgVeU8aDGa/ZzYLqHh
	1gB4zTBBSj+vdpDsjTXDVGkQLJt1rDvNWQb2J4KbxQZ19KCpQyX5b4STubfKr/aruExYEI
	VOot+4a8eEp6FYsL15VFiMnui/9foVvGQRVfb6M8fTZgj5YPDKyLpmU3/AT1fp5AxOt1Oj
	x4PBy3NUKmviz9MM9jYcZ4jhvc/vRrqAhwiqxaS3MgwFqSch53gSfMMYumHCWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAWn/cFjvTk+aXbcVOZIgrYlc5atTEL1VmaicMWN/Gc=;
	b=1QNn9r1gAtgR0z93SMoSDYWGvJmwl0EDm1QJ4g45IcW9TwOO+ckjI2urnCZaKFhtJ/WtlA
	EMySMYDbz3CfSmBQ==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/bpf: Remove unneeded uses_default_overflow_handler()
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-6-khuey@kylehuey.com>
References: <20240412015019.7060-6-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620418.10875.14587542569279269259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     76f6d58845829e5d6ef55532e67a323e7d30c26e
Gitweb:        https://git.kernel.org/tip/76f6d58845829e5d6ef55532e67a323e7d30c26e
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:17 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:50 +02:00

perf/bpf: Remove unneeded uses_default_overflow_handler()

Now that struct perf_event's orig_overflow_handler is gone, there's no need
for the functions and macros to support looking past overflow_handler to
orig_overflow_handler.

This patch is solely a refactoring and results in no behavior change.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-6-khuey@kylehuey.com
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 17 +++--------------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index dc0fb7a..054e919 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (uses_default_overflow_handler(bp)) {
+	if (is_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!uses_default_overflow_handler(wp))
+		if (!is_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ step:
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (uses_default_overflow_handler(wp))
+		if (is_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (uses_default_overflow_handler(bp))
+			if (is_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 2f57551..722ac45 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -655,7 +655,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (uses_default_overflow_handler(bp))
+		if (is_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -734,7 +734,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = uses_default_overflow_handler(wp);
+	int step = is_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2ce2fbc..d5ff0c1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1345,8 +1345,10 @@ extern int perf_event_output(struct perf_event *event,
 			     struct pt_regs *regs);
 
 static inline bool
-__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
+is_default_overflow_handler(struct perf_event *event)
 {
+	perf_overflow_handler_t overflow_handler = event->overflow_handler;
+
 	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
 	if (unlikely(overflow_handler == perf_event_output_backward))
@@ -1354,19 +1356,6 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 	return false;
 }
 
-#define is_default_overflow_handler(event) \
-	__is_default_overflow_handler((event)->overflow_handler)
-
-#ifdef CONFIG_BPF_SYSCALL
-static inline bool uses_default_overflow_handler(struct perf_event *event)
-{
-	return is_default_overflow_handler(event);
-}
-#else
-#define uses_default_overflow_handler(event) \
-	is_default_overflow_handler(event)
-#endif
-
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,

