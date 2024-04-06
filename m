Return-Path: <linux-kernel+bounces-133896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458389AA7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909861F21B79
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C352C183;
	Sat,  6 Apr 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ic36piIz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f8fkMR4u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08810A1A;
	Sat,  6 Apr 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401646; cv=none; b=DiVMgy9RIxOAsrlUkB3ml79ivlrsVHyImQUMfUEVXhJHnRG1tvv7snAMVw0oqF8AaguypWp/WygcwqbTkQU2HOjwo1Amj6uWro41YwF9phhzhlKY5fJRA4GKpZyd/tp/HgSKBkSuEcnwX54Nng9t72lcT/oGjUcwZOrD4bnudwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401646; c=relaxed/simple;
	bh=1c/uukDs4NViT6Qhnk1duF7tfheo9SWe0nonrRG1Q6c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EWnxJSa2cu+AKmYrTz4DB029cRY4fOqii180YcijtfCBJeB6enhot2K8ITZT9uV/mPPuryXNiG2Z8APNtYvesuhvg0TV4MYMGMUGJwCx+r7ET++BGWEbPmLNiMZIuDoYB/O/TOUpjpdXbZUR6tVOHVzNcOWsEIwYDZZUssPTqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ic36piIz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f8fkMR4u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Apr 2024 11:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712401643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAc6loL2aK+HGkCP5gp1UlNwVJYoaUCxX0DydY3JV0w=;
	b=ic36piIzsbEjeYVE3xBX6wRZGcTJkZhNEIEb5EmrLjtV0ZjdUf84ggL4jtH+DwSXsOFrr0
	KJz0EGCkmaKPltBN3Ps93F1QHseG3WR4VZOjMzWIdw2Fn5RkVEIvuQCp12a51cGRZ0oMzM
	GW6v7AD2uEcQEAR9pfj1Fns0F0EEZqJkN0D2JkeVeHXdQIpcuLgVPauPpWm7/vZLt11xRh
	LH9jK+/5xzvZww5OKGRcwCACX4NemNDKjkM1VvFWf5vpYMuOl70XUFXV5QIucdP5JGRZUi
	4sL0nUDA4lVVh2JReZLfRzS1lPAYKvlRTC5tXvkd0YXh1qzYsYx1TJn/1VIDdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712401643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAc6loL2aK+HGkCP5gp1UlNwVJYoaUCxX0DydY3JV0w=;
	b=f8fkMR4ubc3/MIUhSL/3VP7wXgMi8DPINRk7QAJ6bz2DQK3gPorenK4rmR5NTrVegHuCIY
	wCFdIw/ffmWjebAQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/retpoline: Add NOENDBR annotation to the SRSO
 dummy return thunk
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240405144637.17908-1-bp@kernel.org>
References: <20240405144637.17908-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171240164189.10875.5952709598613963426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b377c66ae3509ccea596512d6afb4777711c4870
Gitweb:        https://git.kernel.org/tip/b377c66ae3509ccea596512d6afb4777711c4870
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 05 Apr 2024 16:46:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Apr 2024 13:01:50 +02:00

x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

srso_alias_untrain_ret() is special code, even if it is a dummy
which is called in the !SRSO case, so annotate it like its real
counterpart, to address the following objtool splat:

  vmlinux.o: warning: objtool: .export_symbol+0x2b290: data relocation to !ENDBR: srso_alias_untrain_ret+0x0

Fixes: 4535e1a4174c ("x86/bugs: Fix the SRSO mitigation on Zen3/4")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240405144637.17908-1-bp@kernel.org
---
 arch/x86/lib/retpoline.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 0795b34..e674ccf 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -229,6 +229,7 @@ SYM_CODE_END(srso_return_thunk)
 /* Dummy for the alternative in CALL_UNTRAIN_RET. */
 SYM_CODE_START(srso_alias_untrain_ret)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)

