Return-Path: <linux-kernel+bounces-52378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CFE849767
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B06B2AB70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05B168C4;
	Mon,  5 Feb 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxeWoly3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994013FEE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127455; cv=none; b=SE0YNw4beOlux7PgSFfJzV7ZvKAkVyrUdlixKCjIx6OtnvxX3dO874nM5/4STeCSJd1GjpN9Z9mtQxcr1Jzn9uYPvMYyde+tpp9D1fxC7B2J5Nz3oOAMG/8UmXQaenYocrf3GoXHm9nFmZIn2mkOIWMbYf0jVOAr8sixEb4gVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127455; c=relaxed/simple;
	bh=bggusCXz0Mkiwli4+7jCHyqeFNY+L2lWxZPu6P7z8UU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M14VOUp6pYAHbI0b//853Og36pCHUbTBV/8EhPfZE5PYNTlt3AgNDowvhFExtgqphiCW+gk1FypDPj3Vy4FGNoxDu3B7PqR0WTFJdbkAh8xqQZp/MPrW6m+Kl4r/8EIFfl3Q8kStvyRrbbydm7Rqde1GadaX0uIBVibjxBPchIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxeWoly3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd446d520so12532565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127452; x=1707732252; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9G16G3fbuxw2JrbUxuw/p9s1DblEF6LKreyLOVSpq+s=;
        b=HxeWoly3LJhA4X7KD7hMQ4CN6A4NbZDs9r//3QfE3C8FnwciTDJXedw1vsAqRgRQQo
         VMxdFuI6oKw1c2HogR2tQs6ztIuO+ciKjRuiPnDLuLFu2EEISBpsWcrJAPxLPwq9dtS1
         J8Lw/oAxt76t97j1KvGjD7XIAlcP5ex0PG+ihUbvmsex007CVT0FgrKrlFZ6SxSPhgIo
         LRmlXauQ8iOlfwD154Ay+V5xyI5puHs0yWdT5XxUC/2nkdyHGG0M8SySJqd5cWYDUzUd
         hykcgmrmGFCYvUYXngc8hQPorSdVZ6Kpu0ys9b7V/5XKL0Nd2v9q0nC4IhSs6V8QVNO7
         661A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127452; x=1707732252;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9G16G3fbuxw2JrbUxuw/p9s1DblEF6LKreyLOVSpq+s=;
        b=uQyKVcVRp1C0c3CM13bNL26RgYoexCVVAk1HgoFQS/Y4Yk6WlDnmaLM/BYM/Qs4iiX
         u0liWnyWEJ+Stz4Q9fiwU7Zyq/dM0qXJsWf0A402WCAGAWBLFpeLV0TUUjZtL+sU6hBC
         mP+ucKDJ67jYZJN17R5OMrB9QoJjKhrrROQNVWiaTrEn6TotuwHPEyphIz52qLJJ63jX
         gbFtCpERiqZtzLKAgMNoSY6ETKCoGmvqGGCG0t0OSuArJANiAbXQbczN8fXCJkbaDU1M
         ig4Iq4ra0zDpwkrz1L7zORsAor01ltWVdIo+h7Uodq0JW1l2nAu2rL5mef+QNPB+7wJ3
         jIng==
X-Gm-Message-State: AOJu0Ywzonp1SdmiK65K+JWEg8jxYSv5tsr+SwabSY4/OQu06GhoValP
	NiaUAKKUY77f35La6KbS3giv4si6Hvinf7oZCKIw8+NaIFcLpubjDXO1jUI+pQ==
X-Google-Smtp-Source: AGHT+IHHc3YExwhz/nBXVUQRc6lfymAvUmbzwCrewD+25eJUxu82+RgtPgBOg1N21z0HltVY6Q143Q==
X-Received: by 2002:a05:600c:19d0:b0:40e:ac8f:e6c with SMTP id u16-20020a05600c19d000b0040eac8f0e6cmr3877325wmq.30.1707127451624;
        Mon, 05 Feb 2024 02:04:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2Jo0XaXupFfsvenIHOpHcEjtwzLuCwFxlJC/JOKmBnngI7lrZVE1PptnUH4UXQ5pRFlf8umlhJpp0g7OGM76CM/Zyh/OQKfo4Uoz/44QpdUQekGidypD0rtUyNb1KVObtnP+uLTR4C1U+EJBOpCHfyktGvMwArjvkjQ==
Received: from p183 ([46.53.250.163])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b0033921c383b2sm6021455wrn.67.2024.02.05.02.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:04:11 -0800 (PST)
Date: Mon, 5 Feb 2024 13:04:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND] selftests/x86/mm: fixup nx_stack test stability with
 SA_ONSTACK
Message-ID: <f9c6ed62-c5db-4b86-b5c1-b8fc8cea058d@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I forgot that using sigaltstack(2) requires opt-in with SA_ONSTACK.

If userspace stack is NX, then the test continues to work and
reports PASS and there is no breakage.

If there is kernel bug and some pages of userspace stack are executable,
then test can be derailed because signal stack frame contents may pass
as random instruction with unpredictable consequences.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/x86/nx_stack.c |   34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/tools/testing/selftests/x86/nx_stack.c
+++ b/tools/testing/selftests/x86/nx_stack.c
@@ -160,10 +160,25 @@ static void sigtrap(int _, siginfo_t *__, void *uc_)
 
 int main(void)
 {
+	{
+		/*
+		 * We don't know now much stack SIGSEGV handler uses.
+		 * Bump this by 1 page every time someone complains,
+		 * or rewrite it in assembly.
+		 */
+		const size_t len = SIGSTKSZ;
+		void *p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+		assert(p != MAP_FAILED);
+		stack_t ss = {};
+		ss.ss_sp = p;
+		ss.ss_size = len;
+		int rv = sigaltstack(&ss, NULL);
+		assert(rv == 0);
+	}
 	{
 		struct sigaction act = {};
 		sigemptyset(&act.sa_mask);
-		act.sa_flags = SA_SIGINFO;
+		act.sa_flags = SA_SIGINFO|SA_ONSTACK;
 		act.sa_sigaction = &sigsegv;
 		int rv = sigaction(SIGSEGV, &act, NULL);
 		assert(rv == 0);
@@ -171,7 +186,7 @@ int main(void)
 	{
 		struct sigaction act = {};
 		sigemptyset(&act.sa_mask);
-		act.sa_flags = SA_SIGINFO;
+		act.sa_flags = SA_SIGINFO|SA_ONSTACK;
 		act.sa_sigaction = &sigtrap;
 		int rv = sigaction(SIGTRAP, &act, NULL);
 		assert(rv == 0);
@@ -188,21 +203,6 @@ int main(void)
 		rv = setrlimit(RLIMIT_STACK, &rlim);
 		assert(rv == 0);
 	}
-	{
-		/*
-		 * We don't know now much stack SIGSEGV handler uses.
-		 * Bump this by 1 page every time someone complains,
-		 * or rewrite it in assembly.
-		 */
-		const size_t len = SIGSTKSZ;
-		void *p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
-		assert(p != MAP_FAILED);
-		stack_t ss = {};
-		ss.ss_sp = p;
-		ss.ss_size = len;
-		int rv = sigaltstack(&ss, NULL);
-		assert(rv == 0);
-	}
 	make_stack1();
 	/*
 	 * Unreachable, but if _this_ INT3 is ever reached, it's a bug somewhere.

