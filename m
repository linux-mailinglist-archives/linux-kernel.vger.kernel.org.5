Return-Path: <linux-kernel+bounces-108844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B28810CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D077C1C2362D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42253D993;
	Wed, 20 Mar 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BUISNpuY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qq2QidLi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196D3D393;
	Wed, 20 Mar 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933705; cv=none; b=qXNmap6o5wt2iVqPoMbo1SjHeBhStFPyua+iIANBREKdjAZGyAVUEz5PjU/imezeoRoHkU/jdBRMg9JsGTpZh5XhWJ6sQ7C8Ma34nzA7oQTChUJXzFw2Abj5f2pfpDYNsJsPiEsvWu3keQfbypMJnOSjLOMj2ljZwTj6GEuYXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933705; c=relaxed/simple;
	bh=qTSQH+kuIpXgPcYL2ZM8TUPqYLz+yEedQIunOI6Z4E4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nlE4+N1tJ/KutBjfJPEbA4qlHVpsUuqhiEM5gtYnaAP8KHCVz5v3hdbDscBNbuDHG8bdPwxPr3XHEmKzef7OiHE0+0afY8/iEkBFYGqownmv0Ar5GFml4IICfcMZQS0eEs1BtYReM3p4Ysepp8lmhnBFglFC9+sB1TwtH2alzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BUISNpuY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qq2QidLi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Mar 2024 11:21:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710933701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02z2FCs7qMWp+GG5ZUZBvi97hz3ce2M8U5Y4dFmM1tM=;
	b=BUISNpuYO0GAzEvfUpTtaAiZRYnve9rZVnnKzVfCsFoJ8QDoKibvuyLsIhFxK4+awzJM3e
	YxlfQTUBr6BA9znv/uCD0vHHKuqEKBX2EHZ6JQ4J7kW6vb2W7gYi/s35P20Oig+HQKTQ7Z
	bpHHklby2eAoiSQaalFy7mvUaq3HSSj2tkNERBlqmLt/PI+vQ5EwfUg09T8KFyFM8+vSm+
	r/O5NTko2Am6J09iW61D89kQuONPOzZ7AC9+gjIxiNFnycvSNauB+3FOzP1c5wZzpeDx7T
	LzgSoZUnSGg4BcnLMjbEo5ZJ8A7ZVpYhPGWsFn4TPpTlwN20Vd597fvArNxHVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710933701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02z2FCs7qMWp+GG5ZUZBvi97hz3ce2M8U5Y4dFmM1tM=;
	b=qq2QidLiYGcy49MT4aMtrkN5xdvx+6CYXKUNmFC5yTmWorP4136iyHN2ZRLPYQOU+LIsyv
	DSHPBNxMJq6K9zAA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/asm: Use "m" operand constraint in WRUSSQ asm template
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240319171714.76342-1-ubizjak@gmail.com>
References: <20240319171714.76342-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171093370022.10875.17074986654150988256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     648337147d3550c1ca3d1b500e66dbda12e2d836
Gitweb:        https://git.kernel.org/tip/648337147d3550c1ca3d1b500e66dbda12e2d836
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Mar 2024 18:16:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Mar 2024 12:04:38 +01:00

x86/asm: Use "m" operand constraint in WRUSSQ asm template

The WRUSSQ instruction uses a memory operand, so use "m"
operand constraint instead of forcing usage of pointer
register using "r" constraint. The generated assembly
code improves from:

   6ece3:	48 8d 43 f8          	lea    -0x8(%rbx),%rax
   ...
   6eceb:	66 48 0f 38 f5 18    	wrussq %rbx,(%rax)

to:

   6ecea:	66 48 0f 38 f5 43 f8 	wrussq %rax,-0x8(%rbx)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240319171714.76342-1-ubizjak@gmail.com
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 0ee2ba5..aec6e2d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -205,9 +205,9 @@ static inline void clwb(volatile void *__p)
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 static inline int write_user_shstk_64(u64 __user *addr, u64 val)
 {
-	asm goto("1: wrussq %[val], (%[addr])\n"
+	asm goto("1: wrussq %[val], %[addr]\n"
 			  _ASM_EXTABLE(1b, %l[fail])
-			  :: [addr] "r" (addr), [val] "r" (val)
+			  :: [addr] "m" (*addr), [val] "r" (val)
 			  :: fail);
 	return 0;
 fail:

