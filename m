Return-Path: <linux-kernel+bounces-68830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56028580C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D4B22F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A9149006;
	Fri, 16 Feb 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Oacum98";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1rszmAf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88B1482E3;
	Fri, 16 Feb 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096641; cv=none; b=IKABym5QN9BGrdu+6r3G1Pt+IjrDNtwETYb/hmjtpVyCTW//v9bL7DRh4gesOK3J4z6LbEZqT8mkNWMeM6Dq0PKBTZUAaZ/7DktbQFz9uF/8Xoe6bDOzUMnVby4oJslBxWDcIrTQQLTmgk/4/zq9WDUqsSGhMtlCO4EBVRqtrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096641; c=relaxed/simple;
	bh=FkXtQ/S5R9eAYJJTDoGQOFx+437pFbPQ5NtK1qKQz44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HddHa6Wk2zlEETrIvWkeYUmPN8c7/gOQuLBVbR5OTKNDEY5eSV3I9mGNCXK4mlYnKgOSmJDZ1MyPZtt0nS1uLDigCjqKMzPtvQaRMZUXdkaYiKgF7mpeYCYUAWo4P/YK6nHuqnJn4/SAdWzuB3vZSQfBo7FY27zMMU6DnWxyUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Oacum98; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1rszmAf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjw5Gd8QL6WScQLD3qdiHU1qXyi1rIgaUkBwAm0F9ik=;
	b=3Oacum98P9V1VgP+3BE2brSh9B/5dLHgfvK3Rc9dl+FUrvLqjarqq2KUB1GjYTfk53oCsM
	IEN3Mee9iLhOZKQUDU2jpWEgGdjk1UDSrrpKOtOsU9GmDsv5cYA3FuMcZEoHDiJ/p5BiTQ
	Ft+1OnW2EOUTsR9TTsBKTqkcm+vLdIsKJEFH3FIj+ZhXWG9C6lw3Ns3KLmJazXx15M+w+o
	FPlHlwpAy6+bKwgCRHIyQ+mgacoY1U7OBXrWJKiM68V6FVsI6QHQDgcsfv11lp6ed2ZCl6
	mvYdBi5wKaN107Pi16cnhi+jLdJB17W0d3GVzTLlXAC45D4Tsojo/kY/MoYPOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjw5Gd8QL6WScQLD3qdiHU1qXyi1rIgaUkBwAm0F9ik=;
	b=L1rszmAfcsYDotB+9+/v5y+vxOrbICvAHaFqHEQgXetixFVWly1Zk1HgdaswqkOTiN5Tyn
	0CkCFillh66VupBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/platform/ce4100: Prepare for separate mpparse callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.558085053@linutronix.de>
References: <20240212154639.558085053@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663700.398.8460274450627867381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     fe280ffd7eab3dd63fd349d12b449666845e905c
Gitweb:        https://git.kernel.org/tip/fe280ffd7eab3dd63fd349d12b449666845e905c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/platform/ce4100: Prepare for separate mpparse callbacks

Select x86_dtb_parse_smp_config() as SMP configuration parser in
preparation of splitting up the get_smp_config() callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.558085053@linutronix.de



---
 arch/x86/platform/ce4100/ce4100.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index de7f1e9..6378082 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -135,12 +135,14 @@ static void sdv_pci_init(void)
  */
 void __init x86_ce4100_early_setup(void)
 {
-	x86_init.oem.arch_setup = sdv_arch_setup;
-	x86_init.resources.probe_roms = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.pci.init = ce4100_pci_init;
-	x86_init.pci.init_irq = sdv_pci_init;
+	x86_init.oem.arch_setup			= sdv_arch_setup;
+	x86_init.resources.probe_roms		= x86_init_noop;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
+	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
+	x86_init.pci.init			= ce4100_pci_init;
+	x86_init.pci.init_irq			= sdv_pci_init;
 
 	/*
 	 * By default, the reboot method is ACPI which is supported by the

