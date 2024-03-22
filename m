Return-Path: <linux-kernel+bounces-111335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32E886AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392E2288628
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1B3F9E4;
	Fri, 22 Mar 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LintWMw9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uy1tiAVl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836D3F8D0;
	Fri, 22 Mar 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105163; cv=none; b=e9pO0k2UjkGQu57sw4Gd8AMKL8GfzV7WmqbKa5M8fIMWocvRRaoHpYFRdWfMQMNCDx4pIJBme7nAL4MgbcUMsVmZTsBKiD7RuqxeiynO4tGrpWwHMHZ4E4CaSaF5w5uspdoV0xbtcLp3mVNwBJDC6prexp34DzI8b4k7s5j5aYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105163; c=relaxed/simple;
	bh=AkLp40ABWaYMgBavWRCKUs3HCKelwVuAL3q6NRjOgkY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qe3xZRfgntxRPUstwObyHms1gJkZtG3eR3+7bmBgDhXjVKKUO3HZg/nsupI3oqAyot2oStAadxu5va+tSBaz99oiuWxZooPJq9SPOvy2TJhYq67ChMaF/A9BOlmt2Uee8CgxRBQ7ti7/+TsV+9FElFK+9slKObVcXi+llNlpS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LintWMw9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uy1tiAVl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68AKckIUACgysmKZaW45b9hXVGmxkpxHrUkkobtwddY=;
	b=LintWMw9LNRcIi0qMk61ghWZ0rP2vftlfnJfBrpw4kIjrD7KYzfenCTbp7zez9PxjdgWss
	ddlnDnUC7iZrNvuhbvWhUZqkqW5hiZx85fuhQGP7ZCYPqvgjk2nkkCg3XKncCFJzj+AaSg
	kThQ9L5yYxoIELwCBMf3m82ruHzJ5Isr1IL8a2hNzIB8xJaIkDqgWUB19qXufNgZ3jbR8e
	jifIgNgCDzitjLWS9JNPnn2o+21jUOz9jO37aSkFEToxUf14rgGh0aSufF+eqDx0TELZjn
	xREfdDeHx6s6CDzTWLC/PAI2NsED/lTqHnUo0nRDuefOCxH5UZuhjc8opZhzsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68AKckIUACgysmKZaW45b9hXVGmxkpxHrUkkobtwddY=;
	b=uy1tiAVlMslJCl1BFNbI3GYwny06sUWUwkrMl6VWSTerE3o2P9a7S7xfjUeAHgQR2scg7J
	Kp5w/oHN9QHvzbDw==
From: "tip-bot2 for Masami Hiramatsu (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
Cc: Qiang Zhang <zzqq0103.hey@gmail.com>, Jinghao Jia <jinghao7@illinois.edu>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <171042945004.154897.2221804961882915806.stgit@devnote2>
References: <171042945004.154897.2221804961882915806.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110515913.10875.11206445395083365696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4e51653d5d871f40f1bd5cf95cc7f2d8b33d063b
Gitweb:        https://git.kernel.org/tip/4e51653d5d871f40f1bd5cf95cc7f2d8b33d063b
Author:        Masami Hiramatsu (Google) <mhiramat@kernel.org>
AuthorDate:    Fri, 15 Mar 2024 00:17:30 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:40:56 +01:00

kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address

Read from an unsafe address with copy_from_kernel_nofault() in
arch_adjust_kprobe_addr() because this function is used before checking
the address is in text or not. Syzcaller bot found a bug and reported
the case if user specifies inaccessible data area,
arch_adjust_kprobe_addr() will cause a kernel panic.

[ mingo: Clarified the comment. ]

Fixes: cc66bb914578 ("x86/ibt,kprobes: Cure sym+0 equals fentry woes")
Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
Tested-by: Jinghao Jia <jinghao7@illinois.edu>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/171042945004.154897.2221804961882915806.stgit@devnote2
---
 arch/x86/kernel/kprobes/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 091b3ab..d0e49bd 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -373,7 +373,16 @@ out:
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	if (is_endbr(*(u32 *)addr)) {
+	u32 insn;
+
+	/*
+	 * Since 'addr' is not guaranteed to be safe to access, use
+	 * copy_from_kernel_nofault() to read the instruction:
+	 */
+	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
+		return NULL;
+
+	if (is_endbr(insn)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;

