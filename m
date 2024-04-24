Return-Path: <linux-kernel+bounces-156887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038DF8B09E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C215B25851
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6449D156C68;
	Wed, 24 Apr 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpyztPFx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+mJDKLP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560B33989;
	Wed, 24 Apr 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962599; cv=none; b=CTDiaPgjdwZH499Xd+A7n2EiSeNmaBmgvN1o7vWnoHdsVDgq79AKPIg1MdU25uQ9pMz6+L2HFFuLwPNG302UlffZpZjYOnbHKNIti5k5yxYZL46GskQHnSCPv7Hkgomcxu8zgse/9IorFK9K/T2hOkD16Nd3RKTzRy2Q5IzlS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962599; c=relaxed/simple;
	bh=IRKcdmhT4sIety80BPi8y3Ndwm5wDa35FgP+JRKhwhg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SvMQQ6VyM+4QrnS0164FwVeniLr4bh7+wulhssEDkaVz6OgdmkFsG8csxq6j6s/7LVp5F17KEqvRFuCgKKd45fZKPWNPHRqarfKP9wiXMSG1wN3gLU6zJ+NqCt4VG++1a4bxZfPTjRLi0rr2CJGfOMXPIa6CZXEQLjJmXlqOSo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpyztPFx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+mJDKLP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 12:43:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713962596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUQE+acBF3dvV/ZAfvhPLXrAIWvFtQLpqbB1lud0+Cs=;
	b=EpyztPFxY+/m1m2t4kxVmUPlX9cT3It5DM8UChrA1/uJGo8ERIULz+yV7os+vVcU6iqAEr
	5YCcj4HOTN6cEURCWS68oTjFIVvbxfjxl3oGH92mgHix01NwPon9wbfztm6KcsRBicy0XX
	J6NKetpytrA8llnRQ/cL8a1Ek3oXiG4VDYRNlG88dt6Ta1xZQo9S5N7M/vmhUE1ILQw5W6
	Oer0Rmz3SAijmpsW82oq+7+f4VocoPovvJ9Pe7ZBZY4cVe5sy9nFplNn69lGYJOV7UKEEs
	gaqMoCeoqXH52N45AYULBFvNTspJsmC4PBvetZE8zIiG9E12r2jcfBKmrql5Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713962596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUQE+acBF3dvV/ZAfvhPLXrAIWvFtQLpqbB1lud0+Cs=;
	b=X+mJDKLPi0SQpfnOwPR4UuOt5CoVpydMIZ27tSlBLIm1s/XOEdcvZn+ZIYchkEqAEfKx7h
	HjVuN+uIa4K5BhCA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Fix check for RDPKRU in __show_regs()
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240421191728.32239-1-bp@kernel.org>
References: <20240421191728.32239-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171396259581.10875.10910607244661766462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b53c6bd5d271d023857174b8fd3e32f98ae51372
Gitweb:        https://git.kernel.org/tip/b53c6bd5d271d023857174b8fd3e32f98ae51372
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Sun, 21 Apr 2024 21:17:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Apr 2024 14:30:21 +02:00

x86/cpu: Fix check for RDPKRU in __show_regs()

cpu_feature_enabled(X86_FEATURE_OSPKE) does not necessarily reflect
whether CR4.PKE is set on the CPU.  In particular, they may differ on
non-BSP CPUs before setup_pku() is executed.  In this scenario, RDPKRU
will #UD causing the system to hang.

Fix by checking CR4 for PKE enablement which is always correct for the
current CPU.

The scenario happens by inserting a WARN* before setup_pku() in
identiy_cpu() or some other diagnostic which would lead to calling
__show_regs().

  [ bp: Massage commit message. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240421191728.32239-1-bp@kernel.org
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7062b84..6d3d20e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -139,7 +139,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		       log_lvl, d3, d6, d7);
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
+	if (cr4 & X86_CR4_PKE)
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 

