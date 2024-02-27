Return-Path: <linux-kernel+bounces-82940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA6868C03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86F6B2295B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581C136989;
	Tue, 27 Feb 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxoKMq2w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQB4VY+T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553C135A6E;
	Tue, 27 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025458; cv=none; b=VeJCxno0KcQ/xJ3PoazQK/HqbI7iHqfyCqTiqt4BCqDGqMVp8yefeJWnh5Fgb/tuy6udDO21thvDlgGqBakYtHMQsC8weiF8MEo8IwJTWrFQYDDAA7Jw7/PLdnoAfMYbNIQab5ePMlK27EY8SxKoohgKZvFV4IbSS0yCCpuWXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025458; c=relaxed/simple;
	bh=OSdWc1vJMxiU3gVFNe8kfWPCENt6njYSFBj2jIbWgrw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=iWpvvpE8Wof4jVaObhO23ane+Kb5cnHfOHHEH32T4x0LJV92GHFFkDbytHpESqbrPBfD4pQBXoES3z80mWWfoGkJJ25PEqrwZu8nslEogK6P9QzZnjT7cO6pOdltAOcWJi5F1LG7yVcgac5YpPQM1ksNDZSHVuMh2mGNzwI3zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxoKMq2w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQB4VY+T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 09:17:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709025451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RYjjGm4NuN6OSTvJGHuae1Wfp0CLCSRTyqh1PX+D7kU=;
	b=hxoKMq2w9lDKy1XjGXbi1lF6dAL3MpPihSCOGjwhrUaewZ37pxQmcQ9pqTG3ACYGjdsz85
	Sl6shN2oK4nCSYBp/oJsCza4K8ipoUy9r9OjW2+G6Bq++GMg5WOCx3Qdg7NlZX1R4Pd5FI
	l8D8jK2vJ8wUz4nsKDupNE+CdRZBJ3XyTNnxnGOetcWJr7l6JiXq3tnICdb40FpwOCt10F
	ON7XCXO7HKfXV69+Y0gy7xQ/hZWs74nNzyyc56CZPxHzqgX38q+aKQxvlR+mkIkcN9zcqF
	4vIxJfVLn+5RatEHlrGnxQyy3tDxgwJU8xt91vOXujUN//2kvQalumkSv1iJSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709025451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RYjjGm4NuN6OSTvJGHuae1Wfp0CLCSRTyqh1PX+D7kU=;
	b=YQB4VY+TJmFZpOFAZMUyIu5bpqHVnPDJPmB+3nng/68+Bdkkd9g1H2174RumVg5G0UBc26
	1AY00++BV0r92uBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] smp: Provide 'setup_max_cpus' definition on UP too
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170902545035.398.17991702493246813954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3c2f8859ae1ce53f2a89c8e4ca4092101afbff67
Gitweb:        https://git.kernel.org/tip/3c2f8859ae1ce53f2a89c8e4ca4092101afbff67
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 26 Feb 2024 12:07:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 27 Feb 2024 10:05:41 +01:00

smp: Provide 'setup_max_cpus' definition on UP too

This was already defined locally by init/main.c, but let's make
it generic, as arch/x86/kernel/cpu/topology.c is going to make
use of it to have more uniform code.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/smp.h | 2 ++
 init/main.c         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520d..7a83fd2 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -218,6 +218,8 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
+#define setup_max_cpus 0
+
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
 static inline void smp_init(void) { up_late_init(); }
diff --git a/init/main.c b/init/main.c
index e24b078..5644bb1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -603,7 +603,6 @@ static int __init rdinit_setup(char *str)
 __setup("rdinit=", rdinit_setup);
 
 #ifndef CONFIG_SMP
-static const unsigned int setup_max_cpus = NR_CPUS;
 static inline void setup_nr_cpu_ids(void) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 #endif

