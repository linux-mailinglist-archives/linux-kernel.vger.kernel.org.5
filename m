Return-Path: <linux-kernel+bounces-133899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1889AA81
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA35282744
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78F2CCB4;
	Sat,  6 Apr 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fokGcvQ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceywDiBY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B292BAE9;
	Sat,  6 Apr 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401682; cv=none; b=aJoLs20qUXUT6tw39onghH2DmjEJesX5VegX/gMMuZikIFSPKuvqFa/xLdxVvN0R/gro9IFuYaeW9HUDNfk23JID/0ajzfEHhoCr0WDg6L29fIN3euUC6+d9NHIbR8ZOgUDvGchWur1wUTxS6GMDGUyv4lWiUpXu/R+rz6R1PYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401682; c=relaxed/simple;
	bh=35iPJt2vYEXwxrqjybT/QgbF/cf5H0/aDboES+VMFk4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AtZTt42I+ftSv+6zw0inmv1/CuX0A7Sx/w8ZyMIondEFybOZ3SPzhoJtDgJ1zo4tY8G+zHePKE+Dd0vQwUiUhYIPVKhBn8bItTBYiEAsBtwctOcv4ypOd4A7UFVofMKbQmMPzfd7dbMLD7XCEZy3TzkAqfvVB57e59rq7YGaYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fokGcvQ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceywDiBY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Apr 2024 11:07:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712401678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJAn+beJLw8/tsPos9WG8VMHVJ5tgycFTzTz18XIK9Q=;
	b=fokGcvQ6AHpFP3lx/PyumYgVlQbd+3a3gLljfz7L1RLWSP/FGuvqGmjktVTQfhGfRmY5td
	e6QkPww9nhQA3/Iv8Ap0p/CGPRFHyKNyYYKl7JK4SPzICY/BdFARz3rdClV9rHEIr9bCMj
	/3tMbDkQTM68GgaHRck3eXVadMYQbDfd+Uy5TZTgACrJ+QGBcQ+Ob+2WoNjh0rJQ+R0iVF
	OhaUztszhf3sqFZFNBi8q3j32ppCK6fwDzyFvyLMOi/FA7Wmv9FTxqPRyCmJakRP2lcYQq
	O7zu5cp7bXcOv5FnMMHEewPcjiIfh2cEhEtUdlzyjPcCJ8cdH0ovhy7/mWQ70A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712401678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJAn+beJLw8/tsPos9WG8VMHVJ5tgycFTzTz18XIK9Q=;
	b=ceywDiBY7++Y+mayFKfL6l99uQINFF2+xzBPYLqGqc0hCss9gJ+13v3JgXKRo4wmI5ZcAa
	M9QFOgczCubJgBDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Fix x86_this_cpu_variable_test_bit()
 asm template
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240404094218.448963-1-ubizjak@gmail.com>
References: <20240404094218.448963-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171240167793.10875.5486559736366474315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     4c3677c077582f8665806def3f6dd35587793c69
Gitweb:        https://git.kernel.org/tip/4c3677c077582f8665806def3f6dd35587793c69
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 04 Apr 2024 11:42:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Apr 2024 12:42:17 +02:00

x86/percpu: Fix x86_this_cpu_variable_test_bit() asm template

Fix x86_this_cpu_variable_test_bit(), which is implemented with an
incorrect asm template, where argument 2 (count argument) is considered
a percpu variable. However, x86_this_cpu_test_bit() is currently
used exclusively with constant bit number argument, so the called
x86_this_cpu_variable_test_bit() function is never instantiated.

The fix introduces named assembler operands to prevent this kind
of error.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240404094218.448963-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20696df..cbfbbe8 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -586,10 +586,11 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 {
 	bool oldbit;
 
-	asm volatile("btl "__percpu_arg(2)",%1"
+	asm volatile("btl %[nr], " __percpu_arg([var])
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
-			: "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))), "Ir" (nr));
+			: [var] "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))),
+			  [nr] "Ir" (nr));
 
 	return oldbit;
 }

