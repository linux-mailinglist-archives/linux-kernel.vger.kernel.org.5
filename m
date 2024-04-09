Return-Path: <linux-kernel+bounces-137378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC689E131
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C752862A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0FC156868;
	Tue,  9 Apr 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7/MoRa7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hw6oQfAJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444215622F;
	Tue,  9 Apr 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682697; cv=none; b=t4/ICKaLP+9ea32Y8czIt8HXQsv2xBcsIX2wIldY57gB8WIz1+9JesEnCRM2HWNJGir4GRWsTYtIZYyRbSAsgOAZ9mbxx3LGfFIoxg7pC3aVRALrAOUS9fYcX665HihZIZ7E0+RUuGJTKszIWNdHaqowoX+7HKKeoKCLh5Rnx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682697; c=relaxed/simple;
	bh=+lMudVO1KpWj8hIQyKPdZlasETmNsNY1oslBbmT25P4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ibFt7Hkn+Bk+WJdIeQxRlGP6P2TRq3cKMj7OJHTbTJ8K+vsKhEUkop0HFOJCe5QI2RugFztDHDZfyCJZIOfEx9HTzATrH+3S8Stz8PB+xFQ9t6Eu/5zIhWeLEsNFatBz+X28ywzMAzINCZJvo7BjEt149F2B6JxEj/ZN2b+0VSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7/MoRa7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hw6oQfAJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 17:11:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712682694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WXmfCgGFg1bhPyrSG6Lg0RkAm6b8W8XTVMobhwWE6s=;
	b=M7/MoRa7b5cgD3X0FoAuJrVAwFl0E6/gx21VL5S9gM/j1b12zvZyIcDFoDH4gBnX/RHzau
	cJToq0+fanD5ftpNacSeVaR3iLVD5nnI1hTAoJNeI6tsrWi4KwGywStVxYzTqwaEGgX/6E
	oMZtGkQdgOMB5khHXSjwXgCZK5e1JrIWz53FPPiad6z9X7JVPj8ORXtGZpu9DC488q/4OK
	0Fzn72C2HMTaQMNsUrM53vk+RAidlHibDb/rlbn6IVIdqVd82jnXQnAbpmDk2WahbchHfT
	+hPQkT/ygVTzXkCavKJn1fmwGD3onn1WRSkaj9XoneBHnmBWPfji9/UcOmqBkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712682694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WXmfCgGFg1bhPyrSG6Lg0RkAm6b8W8XTVMobhwWE6s=;
	b=hw6oQfAJOV1letKzP1qIIRTEpxpZhnFV0njJQ+3lMkT/yhJg9JzpsLP5JVVwyE1yHUs9sE
	Y7+AxsaTPGhc+zDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/alternatives: Remove a superfluous newline in
 _static_cpu_has()
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
Message-ID: <171268269354.10875.12889115088213385677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a0c8cf9780359376496bbd6d2be1343badf68af7
Gitweb:        https://git.kernel.org/tip/a0c8cf9780359376496bbd6d2be1343badf68af7
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Apr 2024 12:04:25 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 17:59:10 +02:00

x86/alternatives: Remove a superfluous newline in _static_cpu_has()

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240327154317.29909-2-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index daae5c6..cd90cef 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -168,8 +168,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-	asm goto(
-		ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
+	asm goto(ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
 		" testb %[bitnum], %a[cap_byte]\n"

