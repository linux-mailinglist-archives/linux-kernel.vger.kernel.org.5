Return-Path: <linux-kernel+bounces-2189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9D815922
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B3F285FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB323224EE;
	Sat, 16 Dec 2023 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D8G7Gs5C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1e3LxO2b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D518EB7;
	Sat, 16 Dec 2023 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Dec 2023 12:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702731532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anal0gKvCrGV42YD75/clg9vkB6MDtNjy8h56W2p3PQ=;
	b=D8G7Gs5C8gU6AHoiYGs3G1YTToFJ+tVgZK4jDaw20+H/C6PTuxzki+2sFGHIkuDHiU8/2r
	0HiJb3TKeQ8Tndpp3jyw9mUdN9Qv1Hhq4UP8cEnk3f3OOO6dqWSAjlXQubQ1dj1F9z5tuj
	09Cj2M7PUhC5XTgP+AHCzR7+0mIeJumuFcC6pq6xbot/DmQDeQEQ1F0XcFLPVWscXBDowo
	xe+nkeHSnW60wzSjZSnX4Ykd+EPFs6TS3Qm1j4aDWonjfmeeYH2Ax5tLGWzkmZBMyGilzc
	mUrmt3R+jtBYo8ldl4LE2CiEdpHxKKMtErnx0/SKsxYLTG40R4nA3XXi6Np1sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702731532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anal0gKvCrGV42YD75/clg9vkB6MDtNjy8h56W2p3PQ=;
	b=1e3LxO2bYh4tr7rOHq+BFaJ+rQceGMayRtQL/AVtQcxEUH+yN3tvpy/UYJAeiFQ57BWosb
	7CWQvuKR3eNpiNBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/alternatives: Sync core before enabling interrupts
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,  <stable@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZT6narvE%2BLxX%2B7Be@windriver.com>
References: <ZT6narvE%2BLxX%2B7Be@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170273153128.398.15915411825430136039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3ea1704a92967834bf0e64ca1205db4680d04048
Gitweb:        https://git.kernel.org/tip/3ea1704a92967834bf0e64ca1205db4680d04048
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 07 Dec 2023 20:49:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Dec 2023 19:34:42 +01:00

x86/alternatives: Sync core before enabling interrupts

text_poke_early() does:

   local_irq_save(flags);
   memcpy(addr, opcode, len);
   local_irq_restore(flags);
   sync_core();

That's not really correct because the synchronization should happen before
interrupts are re-enabled to ensure that a pending interrupt observes the
complete update of the opcodes.

It's not entirely clear whether the interrupt entry provides enough
serialization already, but moving the sync_core() invocation into interrupt
disabled region does no harm and is obviously correct.

Fixes: 6fffacb30349 ("x86/alternatives, jumplabel: Use text_poke_early() before mm_init()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/ZT6narvE%2BLxX%2B7Be@windriver.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be393..fd44739 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1685,8 +1685,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but

