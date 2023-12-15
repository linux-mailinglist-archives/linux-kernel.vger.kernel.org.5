Return-Path: <linux-kernel+bounces-699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F438144D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BE81C22B57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4EE182CC;
	Fri, 15 Dec 2023 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExFif04X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B5168B9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so5087171fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633561; x=1703238361; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vdymqIL4YSsilHrh5VGy7v4a6vTjmyAqVMJ+Z7Xb7g=;
        b=ExFif04XfkY7+PhCciQNa2eXcGed6Azjj8RRPaW3e4PofkuXT6K0y9RzWEgLWfZVlv
         FpG2LG4/QAqq+eYR8kISW8GvpMKAZprzcfMLlBxZIkVph2ElLfn3zLfZ2SvKbWgwl4uq
         zpIPMLYiJO1NQNFR7WAdrMXJWm3+e24OV9XjCarsxgNMGbNK3fmMWDHjMakll5iCi610
         lANNTyL2twK92tC/6QVjAmc2sm+Z1nrjN7BaV+k3/rSp7j/dxn43uJqWV5nxVxD++eyy
         cLtn9h1KGSwog/MkIPp/jmxDbgXQXVkwoDDGF0qRJ/gfv2f5EdSyhXzhUDQeGk6Z+2kE
         IKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633561; x=1703238361;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vdymqIL4YSsilHrh5VGy7v4a6vTjmyAqVMJ+Z7Xb7g=;
        b=n1T4mVidrYUPRaaAl+dhvecuwGmEtuQ+tVij/J/h7L4dzIHPP+DTsfP8HIHbtai7Np
         f44lGbNaplNfxs3z/rHwgImitpg50/JYrREcjztvDUcrlt6QMu5uBm8IDnw9ob1wxjZ+
         H8/de4y0RjvaaWP75UWDpjiHZnr/Ng2aHphLwPC/pGa4Z8MW2Z625qOLQB6u6rEP8oGA
         q+428lHww+pBDT0battX/zifSsz+ebL3Gd9iMk3baej675nm+0xalBoY+fcGHNSSLjxE
         nX5dqMwgxzln0P7+wjF7thiJ+xcfOUCdIIRa+Nv7XMUj0JoPRFFjTUHEVCQP+AU8o6gB
         E3/A==
X-Gm-Message-State: AOJu0Ywe6E4dw3dvZH6GZ4ggYWXFn3q/m8RkQMXWSQMoS0cjEHd6xu6/
	MqJRy9aK1hOcRZy/Df/5+Q==
X-Google-Smtp-Source: AGHT+IEti98XeUjo9xrWivnsj6sBsN0Sy86+0txZRugPY3pH6ccQPL9GM9gmcRhXLkpnFA/yrs2mFw==
X-Received: by 2002:a2e:bc8b:0:b0:2cc:1e99:7c18 with SMTP id h11-20020a2ebc8b000000b002cc1e997c18mr7130797ljf.62.1702633560572;
        Fri, 15 Dec 2023 01:46:00 -0800 (PST)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d5c6000000b0054cc827e73dsm7915590edj.78.2023.12.15.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:45:59 -0800 (PST)
Date: Fri, 15 Dec 2023 12:45:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] selftests/x86/mm: fixup nx_stack test stability with
 SA_ONSTACK
Message-ID: <8299b17a-a730-46e5-a258-fac78ff0420b@p183>
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
reports PASS.

If there is kernel bug and some pages of userspace stack are executable,
then test can be derailed because signal stack frame contents will pass
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

