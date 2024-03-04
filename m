Return-Path: <linux-kernel+bounces-90552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439487010A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E111C213B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1D3D0A9;
	Mon,  4 Mar 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4iYpR52";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tx11dFR+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5283BB4E;
	Mon,  4 Mar 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554509; cv=none; b=RIuTt50hsZVXTsW8+wbzaTKwONnVnSpk+43Z/Njy3190251TlS9RYXzGwfGas6vSJglJ7awXOKnWn2NPmh5G/ife5OVGjTJw0n+YZZcs6pbWgqJLC5z9pjZNKtjaUvmJfbXwSuh5ijQRs7I4D6W5TO+3yNmqSVudTt1p/2TP9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554509; c=relaxed/simple;
	bh=J91416w79+PW1kXvngOkeSZwBL3MZvCwIxZhlm92TnA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=boKjsiL5swao8wjmUn1HST0YrIgjE/QVzwWcF2GG+11I4ZDUmHkOKEe3watRJDxlX+l9ibTDXVGDbjPh9juDu5zJHkOHf5nfhT5TtQj6cKe0d91PMCtZW0slUHyJXq2dXyOAyp2mFuflg9rNxm5Fd1yYQnyaLr+h7XJ8Ht0i0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4iYpR52; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tx11dFR+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctA4qWdyi6MwMlPzPSlBtEin2Jwx6ZzuLtDTliNijrs=;
	b=o4iYpR52jGEtqJ9X3xv/m30+m7W7ioRmyJ9xf7QsTNkIHD9+wvwY4WDrMx6e2Cu4oBBn4K
	fdTUyhF4ysbyfdftccanKNsU5wQLIDgnYBlbiQqkcZJNr4qbZqHkZNyzFSohpOeH4b/orI
	sfOGcHgS6Bd8hmUtaSRn6OChjAfurYUSrD/P8SZU8V1Kcy2hggf3Dtv2OYdEck1gNFaF7R
	29y43i9VtZeiXiNdKz7RVs+9lgz6yDu7/XnJaIerh5FsrHcMgnCYWvIhcceg7tCO4fs38v
	qwxaKY29nXq4jUvrS3vZKdBFoiTvbnXvHRKkGY8rD5oZ77bZAZxL/coY7yMOeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctA4qWdyi6MwMlPzPSlBtEin2Jwx6ZzuLtDTliNijrs=;
	b=tx11dFR+YtsnygEIR39hxQgoeJJO6anHFIloR3c03vYkaEZ0ssv+SvWrrH1BcyK5nP28y1
	bbp/NYED+YV4sTCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/uaccess: Add missing __force to casts in
 __access_ok() and valid_user_address()
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.677606054@linutronix.de>
References: <20240304005104.677606054@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450500.398.14236926822453915235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ae6b0195f5c503f22673a4acf21111822305c1e0
Gitweb:        https://git.kernel.org/tip/ae6b0195f5c503f22673a4acf21111822305c1e0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:09:12 +01:00

x86/uaccess: Add missing __force to casts in __access_ok() and valid_user_address()

Sparse complains about losing the __user address space due to the cast to
long:

  uaccess_64.h:88:24: sparse: warning: cast removes address space '__user' of expression

Annotate it with __force to tell sparse that this is intentional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.677606054@linutronix.de
---
 arch/x86/include/asm/uaccess_64.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4..d2a0c2a 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -54,7 +54,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
  * half and a user half.  When cast to a signed type, user pointers
  * are positive and kernel pointers are negative.
  */
-#define valid_user_address(x) ((long)(x) >= 0)
+#define valid_user_address(x) ((__force long)(x) >= 0)
 
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
@@ -87,8 +87,9 @@ static inline bool __access_ok(const void __user *ptr, unsigned long size)
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

