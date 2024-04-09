Return-Path: <linux-kernel+bounces-137374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B82F89E128
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9051C22D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE1155746;
	Tue,  9 Apr 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvpsX8th";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43mk2Ox9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355113E3E3;
	Tue,  9 Apr 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682693; cv=none; b=P7EzFyLdPFjCS+6BNh6gQMfj0dyAZ/37GmAVM+83U6FRPpty06uMtk35pEkc0ELTv77jH5Uwrrm/T9KtptJFqg0Z7+vDaCLjxkVossakGbypmujViAskP9txV0N2/T9LkHKKSCIGW5sa17OH/2+lvz19ibJ+fJt6+Jgvns5JW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682693; c=relaxed/simple;
	bh=R5qGMOirGfZFbAaEUH30RR5x4sJCy7rmjxwpl66oPhY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WRWKC1+mdAmJBEjgfagKoifTp8xWMkvRLXq+vb1iSzbbSTp8vdkUZgfTjsWHBziCHw+fjMtaw78XjfMK7IK2aBiIJLDUoAy86vmd0ZZ2FmZYfVx2di1BhRjd1BZExbh8y/BdggxAtjMTYQwg4MO5Psxxn64zedPZ8B2d5Y1b/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvpsX8th; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43mk2Ox9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 17:11:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712682690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbpWJn4KRkKjI4s4Kh7TlAXOSa4mKT+oKrv3tSPcdRM=;
	b=IvpsX8th7Im4Bj64Nh+wJig+sc1pyu5EMP7MZGlF9u0UNCLgnVa/wu67qfEfg4NgddRekO
	hH99djYSi0j1XxB6/4zjrZUhJannk0UNspohBMxd49zrqBkNOAhGgQuDN/27vQUp/I2XFZ
	T71yO0MDW9mYMy6NPgOeOcSXE5z1macUn/8mMJGPMw6CbFtUXRonqhQXUpi8YzlGCYLVWa
	aU+P4Nkwbt/CF9LtsWhFriWxkNS5+mIuZOFItt9u5+4nA9FOrj/dVkGwdGWLQ+QA4EQL+2
	/GcMEXum0wQ4wds3O7olI6Yg0qlJdC5a822J6LVl0cwF//YxIQikFrLJLFDs9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712682690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbpWJn4KRkKjI4s4Kh7TlAXOSa4mKT+oKrv3tSPcdRM=;
	b=43mk2Ox94BGP27DP50UTaAUWgXt+/dE2BY5aWn8+Q2F2QsAjesuAxatmwTjpeZjtRW6F2e
	3BpkrjVInUFAUtCA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Optimize optimize_nops()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130105941.19707-4-bp@alien8.de>
References: <20240130105941.19707-4-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171268268951.10875.9396936465731791620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     c3a3cb5c3d893d7ca75c773ddd107832f13e7b57
Gitweb:        https://git.kernel.org/tip/c3a3cb5c3d893d7ca75c773ddd107832f13e7b57
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:40 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 18:15:03 +02:00

x86/alternatives: Optimize optimize_nops()

Return early if NOPs have already been optimized.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-4-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4b3378c..67dd7c3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -233,6 +233,10 @@ static void noinline optimize_nops(const u8 * const instr, u8 *buf, size_t len)
 		if (insn_is_nop(&insn)) {
 			int nop = i;
 
+			/* Has the NOP already been optimized? */
+			if (i + insn.length == len)
+				return;
+
 			next = skip_nops(buf, next, len);
 
 			add_nop(buf + nop, next - nop);

