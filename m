Return-Path: <linux-kernel+bounces-136452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C68A89D430
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8803E281107
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFF7EEEC;
	Tue,  9 Apr 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XU9/E9SO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0//LYRW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB567D413;
	Tue,  9 Apr 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651200; cv=none; b=VT0K7bX9bNCAnbLkav/Gq4hmYubvurW7OERsNoF/O8hx7LjcmpIbjrrEFZMf+Dk/Hc4RrTP+evvvJqL1hrAmbQo2PhJz363amM84RsPzj1dDv/abnhht5LwDBdrd4JUejU+kBKRGkkasIn2FqX3v9DsLGJnNC4J2EVCH67RrLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651200; c=relaxed/simple;
	bh=InIQp1whWwT6ydwnHGtzG5tyKecPQwqCjTApfcrLLQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IRZitwpl+NkFGm+j+0QjG1XMH/Lc/O5sbHrLx60NZR4ZZbG2sDsxrXXtituNtkDut8jB/W+qugOHaFTvfZAPb/UeRiXtTMic6DNq1fW1e0h7UgTKbYsd4SZz7oZlHS/uq72FNX+r/vPIgzORTQjNhDrXq8OGih87oOowMo0r26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XU9/E9SO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0//LYRW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 08:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712651197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43K+m/0dcke1krUEFAUR+SeYu/GIl1D+EdDm3LrXyTs=;
	b=XU9/E9SO5OhqZDgfR8p5FMMjS9+8D+N//7Gt+XlX5Lcvjralzm9UqNjwRH4fQkmFr1ZeJo
	NrXLgAkbIrdLmlk6oOhHjUw1iBda8/bvC/aD5kopZmHJ0MsEC/Y5LG3wMkoIO5r7HXxFA3
	HuV7rhibF/BiehW/ir6t4Sho7TPSo22WDLtqPLceHxcq/6tyg7/q21SZYxE+8Ylsk74oHZ
	zbYM9ZM0s4YsvEZkdaX3bJhRFCq8OCn1UeVoff+r4ofjcYQagtEZZGKIgxZSQIew/BzKXb
	ZLQgyV8o0tD229mhMmynYxaGba46XbIBTKOMaGQBpAVj6C7sGRKySO38/QaoBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712651197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43K+m/0dcke1krUEFAUR+SeYu/GIl1D+EdDm3LrXyTs=;
	b=X0//LYRWHxRGKj8507sa43Q3aLH/dJRQ/bZtC0JMxUuzbyCmBJZt23T5XA9MHIUHEsgZCI
	1Fo1O3/r4LQFytCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Correct the definition of
 __arch_try_cmpxchg128()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240408091547.90111-2-ubizjak@gmail.com>
References: <20240408091547.90111-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265119677.10875.17196553615087020061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     929ad065ba2967be238dfdc0895b79fda62c7f16
Gitweb:        https://git.kernel.org/tip/929ad065ba2967be238dfdc0895b79fda62c7f16
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 08 Apr 2024 11:13:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Apr 2024 09:51:02 +02:00

locking/atomic/x86: Correct the definition of __arch_try_cmpxchg128()

Correct the definition of __arch_try_cmpxchg128(), introduced by:

  b23e139d0b66 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")

Fixes: b23e139d0b66 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240408091547.90111-2-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 44b08b5..c1d6cd5 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -62,7 +62,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, 
 	asm volatile(_lock "cmpxchg16b %[ptr]"				\
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*ptr),				\
+		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
 		     : "memory");					\

