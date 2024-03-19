Return-Path: <linux-kernel+bounces-107578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8E87FE71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DF9B2433B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334480600;
	Tue, 19 Mar 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V5fR8v9T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VmzjXt2c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CF80043;
	Tue, 19 Mar 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853992; cv=none; b=itoAKu0X5fDPndik1z/qpxcwieUCsN1B/FohXu6kIuzCHIbxgYX9hSWQnTUO2F0Mu5fQc3OW3tvBNbG2RbW/UXKRmhCIvbc7pvsUdHlLGNCDCFcfjhc8sMwqAToee3KBxLGsPfSxVmO4wqZzcmTNZADm110Wyz4stL+2+wW3p4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853992; c=relaxed/simple;
	bh=UJWzszX4k7Tu1o50C+k6AFikK++LqM+CR6rmHgt2/9o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BEqDF+ndxiChPFSc2C7uUABbLTRrRA2pa3/B+fMRZ+yazNVgtRMYiP85GOUNE0tun8wiZppZ+p7Hrv4IZIlvsKkhrxQoqVfMk0zLgbtG9CFdlPd9evqD6YM0NlFAucF+kp+swlJoqK0f2ndVdAr79gE46fUNkfMQ8rTEYTsKPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V5fR8v9T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VmzjXt2c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 13:13:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710853989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tLX5ocrzguOM8mIq8xuWWjJLImdBhNoJ+/xJjK2n0o=;
	b=V5fR8v9TjDnmW74Krq1idUhsAnCwgpnPuTSHWFQ6nw68iaQ1xFg8hGdIyYygdPjpb1q2AO
	De9uZc3jxRRdUfr3fbqzVpbzeB12owPnfKrbEh4apJVvDHtK4VGxaTDDPE00T8kE4pV4p8
	oWozKCmR1wTrp0jl4vLOPZ3iBdppcfwNlZXmX2WQuINNznXH5bFc/uEz9Ft4KQnvKjNxLb
	LIpf+B7fpkRw/gJoqCAKOAl02xqRLgJiG1q3/cnlGF1uq2lHCwj+fxjJiNoM/k/qzmAtbB
	M1Qk052oYDvwxKBaJBzwmEmYmrfgQ8bUUOgqt6onlMNW8p7sbBm93kP6kNNGnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710853989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tLX5ocrzguOM8mIq8xuWWjJLImdBhNoJ+/xJjK2n0o=;
	b=VmzjXt2ccZhMgX5jNH+KJYq7gs1Pc/RYJHSw7ARGiu17LYC5WjlkY3r4SdBWhoJHVn5naz
	fTc6+VRH/K6YimCQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Fix AMD X86_BUG_FXSAVE_LEAK fixup
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240315081849.5187-1-ubizjak@gmail.com>
References: <20240315081849.5187-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171085398806.10875.10735879813080128821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5d31174f3c8c465d9dbe88f6b9d1fe5716f44981
Gitweb:        https://git.kernel.org/tip/5d31174f3c8c465d9dbe88f6b9d1fe5716f44981
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 15 Mar 2024 09:18:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Mar 2024 14:02:29 +01:00

x86/fpu: Fix AMD X86_BUG_FXSAVE_LEAK fixup

The assembly snippet in restore_fpregs_from_fpstate() that implements
X86_BUG_FXSAVE_LEAK fixup loads the value from a random variable,
preferably the one that is already in the L1 cache.

However, the access to fpinit_state via *fpstate pointer is not
implemented correctly. The "m" asm constraint requires dereferenced
pointer variable, otherwise the compiler just reloads the value
via temporary stack slot. The current asm code reflects this:

     mov    %rdi,(%rsp)
     ...
     fildl  (%rsp)

With dereferenced pointer variable, the code does what the
comment above the asm snippet says:

     fildl  (%rdi)

Also, remove the pointless %P operand modifier. The modifier is
ineffective on non-symbolic references - it was used to prevent
%rip-relative addresses in .altinstr sections, but FILDL in the
text section can use %rip-relative addresses without problems.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240315081849.5187-1-ubizjak@gmail.com
---
 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 520deb4..1209c7a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -145,8 +145,8 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 		asm volatile(
 			"fnclex\n\t"
 			"emms\n\t"
-			"fildl %P[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (fpstate));
+			"fildl %[addr]"	/* set F?P to defined value */
+			: : [addr] "m" (*fpstate));
 	}
 
 	if (use_xsave()) {

