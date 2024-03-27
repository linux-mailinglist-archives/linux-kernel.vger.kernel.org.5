Return-Path: <linux-kernel+bounces-121291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A6D88E4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063E11F2FB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4E132809;
	Wed, 27 Mar 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zj7G/oZx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBmX0Jpu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426661327F5;
	Wed, 27 Mar 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543225; cv=none; b=MkdmgaKTNBlNmylyUt2bgyxJGDOcxw/Ch2xjznMPYazYhPwLRHsHcGVZ3yRnKBq4qHO3tcAHpYtMPONRXf07ZueQBHSDo9Foh4aQAlIr/aMRqG/tWBZQS3T9tpf0/soxuFU4Tq0rHAUrOkfdg6ron3/0tRFiRTGGnccNKBHgGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543225; c=relaxed/simple;
	bh=+sOODT5e67XLkmhCROO0EqYZhe0U9bLPRF9Y8p65EzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n9Pr8LmtcVnGq9vqn2jwaSsVxFi1IxkD0KS6KRDgiX6NoooHJ78h9R2nm6Y4Lo3kUr4KhyhHnvrBi1/UcNp8Ff3UFldkSGQQxHnJLt827dzBxg5p/M16kSS803y6DCREw1/nGmB8W1mQcipO+lost6B/v70iZZ0APKkwgujr89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zj7G/oZx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBmX0Jpu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Mar 2024 12:40:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711543222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuaxQ8kBdZjvh6Sxq71CTOnMtmfdgcLXShHxS+2xNlI=;
	b=Zj7G/oZx4wo5jAdoU5z68zbSmqhMAQWYyHVZxV+ofptMpF2cKa1/QCaGYijNRH/XJsP2/8
	aEfHMCJh9TX19ujeZDZS7WpikcPL5FKZffqYedoGVI6eYt+jL4ORjutIoX5hf8nJQ+NCw0
	iQev+NRSnqL8xZCPwmv6Pk2nAF2W/64oA8Le6GjCsW/LeleDyerTScMg/vazYyktlWz+iA
	naPLVqNDxI5sUYIf/VRlp6U5UrYJ3+1FaLhjAFovR84leysafyu3ebDSmeEYwPciLwI6fF
	BuCCNt27szyN+JX/5qJu7IFKPnV3ouX7Jjlt3MSnZatSiH7qAgudm4be8ltrIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711543222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuaxQ8kBdZjvh6Sxq71CTOnMtmfdgcLXShHxS+2xNlI=;
	b=qBmX0JpuBkmmOnnqzLRjH0EFj9uJBQf6XdyVVjG0UK0gIZANq4Zdfq6+W0bpZ4va3AM9Py
	/K3cfVlkoccXagAA==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/dumpstack: Use uniform "Oops: " prefix for die() messages
Cc: Alex Shi <alexs@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240327024419.471433-1-alexs@kernel.org>
References: <20240327024419.471433-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171154322111.10875.11693354409974160406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     f9f62a877da1e6f6e9d58bd779c1c77052eb04ab
Gitweb:        https://git.kernel.org/tip/f9f62a877da1e6f6e9d58bd779c1c77052eb04ab
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Wed, 27 Mar 2024 10:44:19 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Mar 2024 08:45:19 +01:00

x86/dumpstack: Use uniform "Oops: " prefix for die() messages

panic() prints a uniform prompt: "Kernel panic - not syncing:",
but die() messages don't have any of that, the message is the
raw user-defined message with no prefix.

There's companies that collect thousands of die() messages per week,
but w/o a prompt in dmesg, it's hard to write scripts to collect and
analize the reasons.

Add a uniform "Oops:" prefix like other architectures.

[ mingo: Rewrote changelog. ]

Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240327024419.471433-1-alexs@kernel.org
---
 arch/x86/kernel/dumpstack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 44a91ef..a7d5626 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -405,8 +405,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	printk(KERN_DEFAULT
-	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       pr,
+	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter, pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",

