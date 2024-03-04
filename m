Return-Path: <linux-kernel+bounces-90395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620B86FE9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D2F28168B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A03BBD0;
	Mon,  4 Mar 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDZv0UmS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXY72yH0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F33B19E;
	Mon,  4 Mar 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547148; cv=none; b=oNBmChrfZaKk7qEdS+9BExCIBvSxnWfue942sO4OnfgLZFTtPaqRhrmWn9C+hZ5bfDNoMMNJdCq3G58L4W6tbmGwZPi3O831F2GjyAznwDV9xTlafnwUMQDZ9cswUaXGUXTe8gPRPXGqASTyuZkM6lI81daqx2z7GlVHPdiKcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547148; c=relaxed/simple;
	bh=enev8MrKkQFhyKy6/g0YuchRKJkUxEiVZlXysx2toMs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=t3bYCLwzomWxbkJ32x46lSCYTWXMYmPRslmi4+c31AjPpQ6bwYJxCK4nMK45aNor9BSY2AyQQqLOUY1IKn3TQBmt4TyNxFeirWSYUvpZIHmkQ7pNw4wV25AxeoKwuv/3oPUQreZjlPVl/6PU1c8rV2q01F/M0pXgadDteCR1ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDZv0UmS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXY72yH0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.677606054@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JtmrisRHZR6UF3WBSqph8+Mk5bBFqrMgy9HjBdcJVEk=;
	b=eDZv0UmS37zHGyTd0OEhoci5joGpDwnN82H8rXK16SI+p1QAQGGllTQYoU0Dln0QfVvDyu
	w54P1LhxSFAnVZonYjgam+Nwzrkp0UDkFGn92VHsMkXDG7oEWcVCndNbPkM62UJdnBSPDY
	d2I62ijiuSLpz68gc7WydSBEgC5iZUdhJNSEUP5TwJg4/tqwQfwgpzi3p/P5e8NFfk0q4a
	sAnME1arzVTX2aCz86olZKuHMSwlaFTpQiGUo3TUwTHfDKFVrdo/z0iDNjFbyvUy7V6uj4
	NpTWTDWvxQ1D1m88e7yjB8ptJaBTtFtpqMYiTlQQ2yXy7L+WI6hzq/2njaGVXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JtmrisRHZR6UF3WBSqph8+Mk5bBFqrMgy9HjBdcJVEk=;
	b=GXY72yH0oyMBAGlKJeAWMRCFXiwyVc/SK62N6NHJayvUlS1I76NnxOBgthWNkeAwjP7zd4
	r4wIKfiIhaBciDDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 6/9] x86/uaccess: Add missing __force to casts in
 __access_ok() and valid_user_address()
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:25 +0100 (CET)

sparse complains about losing the __user address space due to the cast to
long:

uaccess_64.h:88:24: sparse: warning: cast removes address space '__user' of expression

Annotate it with __force to tell sparse that this is intentional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/uaccess_64.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -54,7 +54,7 @@ static inline unsigned long __untagged_a
  * half and a user half.  When cast to a signed type, user pointers
  * are positive and kernel pointers are negative.
  */
-#define valid_user_address(x) ((long)(x) >= 0)
+#define valid_user_address(x) ((__force long)(x) >= 0)
 
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
@@ -87,8 +87,9 @@ static inline bool __access_ok(const voi
 	if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
 		return valid_user_address(ptr);
 	} else {
-		unsigned long sum = size + (unsigned long)ptr;
-		return valid_user_address(sum) && sum >= (unsigned long)ptr;
+		unsigned long sum = size + (__force unsigned long)ptr;
+
+		return valid_user_address(sum) && sum >= (__force unsigned long)ptr;
 	}
 }
 #define __access_ok __access_ok


