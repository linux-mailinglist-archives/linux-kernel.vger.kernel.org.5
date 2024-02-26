Return-Path: <linux-kernel+bounces-81304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB68673CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55655286CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C3200A6;
	Mon, 26 Feb 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bWBMhZVj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PR7L31lf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD851DA37;
	Mon, 26 Feb 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948090; cv=none; b=NoP/pUYcrP5HHxvbPkdwlCu9W+jETK9iso93VXGxi2DZBSS/sMko/q4hFF+iI8QhRRJrAiYJua5CYYPIi4j8g6ca5UWxFehjT5pzid/FiOikESTSnVYauImL64jGcPsuTju+frs2HTlKJTq0BKeYw7w9kr5tiLpXr+gE8btcm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948090; c=relaxed/simple;
	bh=1AR5G2Y3CctUfpvnf3R9d3cYiYxgyB1npVkEX+6XiY4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WPZ1fo0q+WnAsjvr/RJxQzvSMSTx8bKXeUcT5bPrAaAMNOEtaPuDLcIVmpjCm8LJof2PZFX8ZmcnP756LxE/9MSq6q7lYlfG0HnfK8B10EyAzjerUhgMe7bdxXMmCsbqx4YXUEXwt4uDHUUb+vquhm8P9nVcD7CziV57fpf6kFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bWBMhZVj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PR7L31lf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 11:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708948087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lQ4oXmAnkhL90TwdJmrliUNDTZIrHrUfs5PxAHjRVBg=;
	b=bWBMhZVjC4y5RZGao6THZTfm3TGDXuYKEfjz2dQWWJecFYmT039ItX4KCr6IEn8NXny/3d
	si3Pd7sGvSjpTESdnMXm8CqQmlCz1XG4JY3LShKgAPLOYHOgro2vssJEyLB8n0DSSubCYn
	P3KPqUA8vu/JOT+DG0/biIU9bs2880T28Jfb3J42Mbu0i4d6jrGNzrvLjNBMzUHHbNyHhC
	mBEhIaCti+LMJlmTETOHeeVaYxq8lD2aP93lVIiH6xSokC8JKn4mBsUF0cDNLNiW1YmXHO
	qS6siQK809CxJFOhAM3ibMWjKBZKnHZa9WfefJeI2k+ClhwaYRSZ4UhDjdHw9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708948087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lQ4oXmAnkhL90TwdJmrliUNDTZIrHrUfs5PxAHjRVBg=;
	b=PR7L31lftixobQoItDL8d/jXi0nYvd60SisZGg9EvckRKAy8hHAlxEUv2XSM+EAm8OESfc
	QaIvDIXCrkyUWFDw==
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
Message-ID: <170894808668.398.2149303099223176501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     429bb0269058e2e1f4ab69a0d33d374933aa15b9
Gitweb:        https://git.kernel.org/tip/429bb0269058e2e1f4ab69a0d33d374933aa15b9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 26 Feb 2024 12:07:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:13:40 +01:00

smp: Provide 'setup_max_cpus' definition on UP too

This was already defined locally by init/main.c, but let's make
it generic, as arch/x86/kernel/cpu/topology.c is going to make
use of it to have more uniform code.

[ Keep it a C variable, not a define, because there's
  some namespace overlap for the 'setup_max_cpus' token
  in existing function argument names. ]

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
--
---
 include/linux/smp.h | 2 ++
 init/main.c         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520d..5a5985f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -218,6 +218,8 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
+static const unsigned int setup_max_cpus = 0;
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

