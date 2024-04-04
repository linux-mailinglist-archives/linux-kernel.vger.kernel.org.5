Return-Path: <linux-kernel+bounces-131231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0E8984E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ABC1F22342
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D20076049;
	Thu,  4 Apr 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3+l1k1J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3PAMNuC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BB74C09;
	Thu,  4 Apr 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225811; cv=none; b=RkAXUQ1BgznKy5TCrcBZF6GXIqEAWzAd18+vLXDzbFTAc7c57LcPtie3C4MFILmgFMqwrnRaT1ghZnprAKm+0F7UUEfUBTm1zznVBEkXN84uWcol4m4+/uv6218HzGhfBzbn1i7lJ2rpi8fK8yO5rlqbV5OV4MlKVSA2qEx+51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225811; c=relaxed/simple;
	bh=/rvZj7bxbOrlLI49CZsK2iJ2J2B4oK5a0EFxZLZtOrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ihw0Ucu6KftIgEnOSV8Ay/oy2fbF0peeLNkIwS2CkftYuYyVtihJd7j4J/8NXkeFQG/XGyJGZIdQP2G6d6qRotLDo22ile72eDhUYDpxw7kNbsqN7areIC0ts5XiB7Dg0ehbXkusvywUrDE6HzuJh7CSO41JfAL3JA08NZfADyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3+l1k1J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3PAMNuC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 10:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712225803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwPVhcHeXbdd6kkMNM92NEVB2sJJlMAqj09RZ2qk5sI=;
	b=C3+l1k1JpOXUCbz3onfbgGjsXREJ26Ss/o7o2CwaKtAr1TQNgYur43nFnM6JtHzOZ6xRrd
	q/l2ns6Ak9w78aoKySd3IrwRdk1cT/mfsDQhvFPU4wle/6in7QKyUv2NpgvCjaEzHn08zL
	IwfKy0Pugg0ipVXFkWNJoWywOV6kUlcuUlw0mzkrYtIPKMKnWsWD/HRyNyvVnJtzjnlhRr
	JMueYTTaNTcq1dgR8GkAnsezwT0As4CTZ5c7VrB51IqJW58OMsWPQYjh46VWRbpiJmslTZ
	sG0plsD+TFc4W4v+a71QA5JuXAB8NsYIftN+IY+da5TIV0cbZJs4BEu7pirF6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712225803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwPVhcHeXbdd6kkMNM92NEVB2sJJlMAqj09RZ2qk5sI=;
	b=q3PAMNuCRuV8yYxD2XOq669u8ZMyir9YfSn5yQ1VkNJ9yGYPUsasKCz6O3L9Qn2fVWJMml
	9WZCAF5767rBnRCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Remove a superfluous
 newline in _static_cpu_has()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-2-bp@alien8.de>
References: <20240327154317.29909-2-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222580268.10875.13503419945199963914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f317392a317a27a78e755297505e57a6b345f4de
Gitweb:        https://git.kernel.org/tip/f317392a317a27a78e755297505e57a6b345f4de
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Apr 2024 12:04:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Apr 2024 12:09:10 +02:00

x86/alternatives: Remove a superfluous newline in _static_cpu_has()

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240327154317.29909-2-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index f95e1c8..17fd7be 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -170,8 +170,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-	asm goto(
-		ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
+	asm goto(ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
 		" testb %[bitnum], %a[cap_byte]\n"

