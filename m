Return-Path: <linux-kernel+bounces-142426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA88A2B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DD42844BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E751C4F;
	Fri, 12 Apr 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UasBCDve"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F63524B8;
	Fri, 12 Apr 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914960; cv=none; b=DE1RascWZR1QYk6dzlaLbWCjs9Tqt4XuWsruJ4M02fSWEUIydDFVwcpmCjOmm80qWnc3wiVhmd5iWpg+lR4VvSkv8o3/89jp5olqxLb6qj9uAjZu/oZ5tFw576wdfUnoVSODkN1yObElGR0ahaXFoRSwetcLTBVbe5cI0l3tuug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914960; c=relaxed/simple;
	bh=IcWaHRJ194mVv1lnpYIKdcYMD+65IkFceSoKhHt6oVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbstuA0ncobpjKPTyPbQsTsdxZAj6m4gxva0/7Y4kNcmfnlEfZNpOMC0CGpi6YBNlmUdxf867hqVa1eZR/H2STiQ36ZchzhvdtcSJQzGBfk15/XuaW2H/oISFcDLgDgDs1Sc1rRsL/iJNUQS2a52w0sOo7zH2hPCyQ5qsAW/4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UasBCDve; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a523d4035d5so24469066b.1;
        Fri, 12 Apr 2024 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712914957; x=1713519757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Y4xl+LqXnIux4IbsGJ7yt79kUQ+FVNm4QVmOIiIw9g=;
        b=UasBCDve3gxek+ThE987C7j1rMGaIcDgaIEPlIqk9RPNFt/zkdRWbP/DlHH7x/UOj7
         4XXbTM6acdpdwhtoGUY4XiSJsBW64ObRRlO0fSg2aAaoZWKWgK0KwmCTjA5mRaK91R/V
         ySudYxNpkvav3SR5+i1I6dQ8nfcm3aajflSsd6PGcOquQaLJIMHL7+mkm4tqyW3K1gIq
         zhCLfUTr9hNyROFGR9ZRMrtAxzB2hX+U6w8ZCwL4K2RwAe8O+UeLDCpgS8z9IfVeSd6T
         z7CDmWphhCzMq2ELZa67DwtUN6IrxEPdcC3rBSQnxOsaX0ARhCElVvU1sPJq0OovOnRt
         UPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914957; x=1713519757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y4xl+LqXnIux4IbsGJ7yt79kUQ+FVNm4QVmOIiIw9g=;
        b=VFUe4dpcB+hEICiFO3y/F5skvAXqkl6LSCEHEjQ2gf4RRHe9yggFhyDXRWavvh/nhL
         4dboYbLWesPoYOWuIaNRag3weVDbHcc4BMAzfKG040TZ4laQWqNUDz8eS00o4rAvABq2
         A+Ufspm5drBM96VN0lI3xFSWrZI64dVE++9loG++XVZvK6PrkGbT//FB4EJMpKwB8sYP
         bx48FAoZBge3UpmfszJBklAPS1iLvqSQB7nWmqNEn4nd5EbzhEDlObNgZrj9bV2WmDYA
         xbTG1tQnOd2JOtXBRKoshbnWz39rvD42Ah7qAtJmfla+vQU1G3t2SLRy/DHalEQpQl8n
         4fwg==
X-Forwarded-Encrypted: i=1; AJvYcCVBkdET4i/MBDWO35hug4iUh8E9fkFw1SIK4V02uqtNLtIEvw4nYWU76S9rck+RZ6V0X2ILGecSFoWgc8OwQ1AMRzYpz5keo0SEA9VHJqi3rIQ=
X-Gm-Message-State: AOJu0YwfT7P43pLwWZTXPSvZrqHyJlrc/lv8YtBzb/lislV6vRV6t7fb
	Qy8G+OmHGMJkqX/NfZCX5bew2st6DjDBVa7lgSYn0O8E6sH9czcw
X-Google-Smtp-Source: AGHT+IHDtV5J+eSh4un8o1l03+5RwVKtX4yUZYQ7+lbSNGY6IgegM/vsThlwt74aQC9QE1CcgZOw6w==
X-Received: by 2002:a17:906:6a13:b0:a52:3eff:13f1 with SMTP id qw19-20020a1709066a1300b00a523eff13f1mr56233ejc.2.1712914956731;
        Fri, 12 Apr 2024 02:42:36 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id q23-20020a170906a09700b00a519ec0a965sm1608439ejy.49.2024.04.12.02.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:42:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Apr 2024 11:42:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>, Waiman Long <longman@redhat.com>,
	x86@kernel.org
Subject: [PATCH v2] locking/pvqspinlock: Use try_cmpxchg_acquire() in
 trylock_clear_pending()
Message-ID: <ZhkCCtzhn24tLiy+@gmail.com>
References: <20240325140943.815051-1-ubizjak@gmail.com>
 <171284242025.10875.1534973785149780371.tip-bot2@tip-bot2>
 <CAHk-=wgaxi4Sau27C5yo3vty67DHz-f4L6SSOvmx1K2fQU2B_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaxi4Sau27C5yo3vty67DHz-f4L6SSOvmx1K2fQU2B_g@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 11 Apr 2024 at 06:33, tip-bot2 for Uros Bizjak
> <tip-bot2@linutronix.de> wrote:
> >
> > Use try_cmpxchg_acquire(*ptr, &old, new) instead of
> > cmpxchg_relaxed(*ptr, old, new) == old in trylock_clear_pending().
> 
> The above commit message is horribly confusing and wrong.
> 
> I was going "that's not right", because it says "use acquire instead
> of relaxed" memory ordering, and then goes on to say "No functional
> change intended".
> 
> But it turns out the *code* was always acquire, and it's only the
> commit message that is wrong, presumably due to a bit too much
> cut-and-paste.

Yeah, the replacement is cmpxchg_acquire() => try_cmpxchg_acquire(), with 
no change to memory ordering.

> But please fix the commit message, and use the right memory ordering
> in the explanations too.

Done, find below the new patch, which a hopefully better commit message.

I also added your Reviewed-by tag optimistically :)

Thanks,

	Ingo

===========================>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 25 Mar 2024 15:09:32 +0100
Subject: [PATCH] locking/pvqspinlock: Use try_cmpxchg_acquire() in trylock_clear_pending()

Replace this pattern in trylock_clear_pending():

    cmpxchg_acquire(*ptr, old, new) == old

.. with the simpler and faster:

    try_cmpxchg_acquire(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

Also change the return type of the function to bool and streamline
the control flow in the _Q_PENDING_BITS == 8 variant a bit.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240325140943.815051-1-ubizjak@gmail.com
---
 kernel/locking/qspinlock_paravirt.h | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 169950fe1aad..77ba80bd95f9 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -116,11 +116,12 @@ static __always_inline void set_pending(struct qspinlock *lock)
  * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
  * lock just to be sure that it will get it.
  */
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
 {
+	u16 old = _Q_PENDING_VAL;
+
 	return !READ_ONCE(lock->locked) &&
-	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
-				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
+	       try_cmpxchg_acquire(&lock->locked_pending, &old, _Q_LOCKED_VAL);
 }
 #else /* _Q_PENDING_BITS == 8 */
 static __always_inline void set_pending(struct qspinlock *lock)
@@ -128,27 +129,21 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
 {
-	int val = atomic_read(&lock->val);
-
-	for (;;) {
-		int old, new;
-
-		if (val  & _Q_LOCKED_MASK)
-			break;
+	int old, new;
 
+	old = atomic_read(&lock->val);
+	do {
+		if (old & _Q_LOCKED_MASK)
+			return false;
 		/*
 		 * Try to clear pending bit & set locked bit
 		 */
-		old = val;
-		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
-		val = atomic_cmpxchg_acquire(&lock->val, old, new);
+		new = (old & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+	} while (!atomic_try_cmpxchg_acquire (&lock->val, &old, new));
 
-		if (val == old)
-			return 1;
-	}
-	return 0;
+	return true;
 }
 #endif /* _Q_PENDING_BITS == 8 */
 

