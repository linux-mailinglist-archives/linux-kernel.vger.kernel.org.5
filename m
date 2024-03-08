Return-Path: <linux-kernel+bounces-96633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89484875F29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF131C22376
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D333524BD;
	Fri,  8 Mar 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="15ME6Br9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6R7Rhkk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85391D699;
	Fri,  8 Mar 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885428; cv=none; b=nJvcfgL2GX8lLtRJzW0XS7TY3xsRIi3anx2V4AOWuh1TQJKv9regu/o5JMM7+zlhVnXBxYVJzehuj9dBcsIHY/eEsl+qOaMaRFoOWoBb5fMy9vVbDN4YUOnu1aHLpeQuaO48ZNj0WrcyhJfzAzOZ5tv9t2FOdc8steq9pVJBZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885428; c=relaxed/simple;
	bh=wqYl+xABsF4/cjTLWzFqzpX2r2AzYBBqqzjPUy+lHfo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HeF+wLNkBBESEOpGieybZKYxotijp5EIwTp4HgHW6BS0YtscCiTMgC9JH/0uGWqcf3NO4pVWhxKZVNbdr4rEuBCDsQAmMJkFjgZW1e9aEtBIj/rzzzSbDWDEOemQEtIpJbVBihVDNids9qSTu2aQhNrgh2GH41clseTGuc6aIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=15ME6Br9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6R7Rhkk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 08 Mar 2024 08:10:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709885423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EE8cHk9aq8DGs6t4JRhIhoGf0zb9ZsCIwTSchrrkaA=;
	b=15ME6Br9sCns2yhx0wmxBSUYO5AUbdgLn4RQXmXp2qfWsyITezXchXOTOflGu3KWJiqN4V
	qs288zTCWUGbcXbErXsHp/FcHjy/dkU1jAfMICgqy9vPRSvXm+8bsTdEkg5x11oeysY08h
	5CrZtgZ4YNuHnlNi+WsMYlNANr2mGldPN/kKXqffpcudlC/ZTCE9Ol8E4Rv34Y+HQavRj5
	fT7x0x1r8FyogxAM5nacD/oY/ciGrGJFe1PObuF0K7jTcn52EGZvyqMWofPbzk2wIt+K/7
	2yM9dKAfOhwWvLz4fiU81loVSBH9gP7WAxab8sDiZBnY7/Dl/Z9PaClai6FIIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709885423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EE8cHk9aq8DGs6t4JRhIhoGf0zb9ZsCIwTSchrrkaA=;
	b=U6R7RhkkdujFeUUxLaeI0KWQ+whSJq7mYJkHnbqpJol5pF8iwgnwsaZG6ZMLV7ccbqZADn
	uJYfPIP/NO0t/QDQ==
From: "tip-bot2 for Changbin Du" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Disable KMSAN for memory encryption TUs
Cc: Changbin Du <changbin.du@huawei.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308044401.1120395-1-changbin.du@huawei.com>
References: <20240308044401.1120395-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170988542239.398.10746491684726406217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c0935fca6ba4799e5efc6daeee37887e84707d01
Gitweb:        https://git.kernel.org/tip/c0935fca6ba4799e5efc6daeee37887e84707d01
Author:        Changbin Du <changbin.du@huawei.com>
AuthorDate:    Fri, 08 Mar 2024 12:44:01 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 08 Mar 2024 08:59:22 +01:00

x86/sev: Disable KMSAN for memory encryption TUs

Instrumenting sev.c and mem_encrypt_identity.c with KMSAN will result in
a triple-faulting kernel. Some of the code is invoked too early during
boot, before KMSAN is ready.

Disable KMSAN instrumentation for the two translation units.

  [ bp: Massage commit message. ]

Signed-off-by: Changbin Du <changbin.du@huawei.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240308044401.1120395-1-changbin.du@huawei.com
---
 arch/x86/kernel/Makefile | 1 +
 arch/x86/mm/Makefile     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325..04591d0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -33,6 +33,7 @@ KASAN_SANITIZE_sev.o					:= n
 KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
+KMSAN_SANITIZE_sev.o					:= n
 
 # If instrumentation of the following files is enabled, boot hangs during
 # first second.
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc..6ec103b 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -16,6 +16,7 @@ KASAN_SANITIZE_pgprot.o		:= n
 KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
+KMSAN_SANITIZE_mem_encrypt_identity.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg

