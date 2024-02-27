Return-Path: <linux-kernel+bounces-82939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD41868C01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6132E1F23066
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C850136660;
	Tue, 27 Feb 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pW786ZNr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK/w95Ri"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A354F95;
	Tue, 27 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025456; cv=none; b=KpWeeHXLDqocc3avMuw7qota1jzsOSWqUFq4TTgulQaVhqmC/nyxnOQFezQ5x9C1TGetL6eRyqhUr4oAfiKPW9xOEDSFQ5EkR7Zga5rZn4k9jdr7MbXM6e0caFapugm8cUVRZe1qlSUImqevw15Lqq7YpiS0mXp+DIDS8crRBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025456; c=relaxed/simple;
	bh=UfrPwCoCCnUVvRRlmmQoCX61QovK/icqyXUtDqAYUmY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sR5iC9pGFp3lxMEaDFa/tDQvNHRgAU98cJw25r03S8A4dzvNMZlbaLMx+7CIImVkB5UjPgOlUwBf5Y4ZKhQQVr1+an2sZAbO46VlwFMgCT1gaoi99jUrzH7Q+LR5gDdJ/w2X1E71T4ytYzpQyKSQNrNe5W2y5pLoakzS6e2TQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pW786ZNr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK/w95Ri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 09:17:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709025452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=82bOYWrJvFEunRWgySC5j6mQRmSHiA00j9Nwmc91GQ8=;
	b=pW786ZNroA+agB03FWQgHjxZ7vt3BtAGAeqk3Gd74VU2JAgp4xvdGH0pEJ+m7nb8ztMn3V
	n/X1/VgpsgrD3tcaemvZXR0yogYR3EtftEoNXOcc+1A2E2Gt5iibH4FiMWEoeZOYesklRf
	hoa+Xbc7Td4rKk4czhWiUWmp0AeoGRYOjtibLrrHfo9/AHNA4QIVPyz2Bb6L+HqaL1WJxy
	pmts/l990QlRWGil5M73e9PEPTurI5zErHXYFSJnwVZSHnm5YgfvbxDSGXlmQZoITRYT78
	2l0F4oxA2jOfCv4Tevy2jIhld8+wh1xtvNV7u9uVvT2heR8F90pF6TUlir3qDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709025452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=82bOYWrJvFEunRWgySC5j6mQRmSHiA00j9Nwmc91GQ8=;
	b=zK/w95RiK6F+Y6C8/RmncCmQWfXwR3+o2VuXcG3f0pLVgY1XfQ2LaON7Pkwr75jTkbT+4n
	tJACPN2CB2sFvvDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] smp: Avoid 'setup_max_cpus' namespace collision/shadowing
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170902545127.398.16793174204330570275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     4c8a49854130da0117a0fdb858551824919a2389
Gitweb:        https://git.kernel.org/tip/4c8a49854130da0117a0fdb858551824919a2389
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 27 Feb 2024 09:58:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 27 Feb 2024 10:05:32 +01:00

smp: Avoid 'setup_max_cpus' namespace collision/shadowing

bringup_nonboot_cpus() gets passed the 'setup_max_cpus'
variable in init/main.c - which is also the name of the parameter,
shadowing the name.

To reduce confusion and to allow the 'setup_max_cpus' value
to be #defined in the <linux/smp.h> header, use the 'max_cpus'
name for the function parameter name.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/cpu.h | 2 +-
 kernel/cpu.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c9..61a0ddf 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -112,7 +112,7 @@ void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
 int bringup_hibernate_cpu(unsigned int sleep_cpu);
-void bringup_nonboot_cpus(unsigned int setup_max_cpus);
+void bringup_nonboot_cpus(unsigned int max_cpus);
 
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba..023ddf8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1909,14 +1909,14 @@ static bool __init cpuhp_bringup_cpus_parallel(unsigned int ncpus)
 static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return false; }
 #endif /* CONFIG_HOTPLUG_PARALLEL */
 
-void __init bringup_nonboot_cpus(unsigned int setup_max_cpus)
+void __init bringup_nonboot_cpus(unsigned int max_cpus)
 {
 	/* Try parallel bringup optimization if enabled */
-	if (cpuhp_bringup_cpus_parallel(setup_max_cpus))
+	if (cpuhp_bringup_cpus_parallel(max_cpus))
 		return;
 
 	/* Full per CPU serialized bringup */
-	cpuhp_bringup_mask(cpu_present_mask, setup_max_cpus, CPUHP_ONLINE);
+	cpuhp_bringup_mask(cpu_present_mask, max_cpus, CPUHP_ONLINE);
 }
 
 #ifdef CONFIG_PM_SLEEP_SMP

