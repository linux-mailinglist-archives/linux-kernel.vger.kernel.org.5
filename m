Return-Path: <linux-kernel+bounces-68824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FB8580BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542621C21BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5D21386B1;
	Fri, 16 Feb 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMQOxqRU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CaFX6uwD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033531420DF;
	Fri, 16 Feb 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096637; cv=none; b=cRA8eZqceGp8vTuDkwM1sApVcaqZ7MCiPflJOzzDriVHtI9kKkaqJw90g0UNZyQOCRgNWueNu2wWQQFtGQVIGkWPSsmACl5XcdBwrx2hwdPZdaoJ0unAHB77ujBid2ShnhMp2ndCSMyO/vC+RhnSHoSWCcVuaKb9673lyb4CkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096637; c=relaxed/simple;
	bh=/rXxqnhGJRZg0uNuj+DZxd+WWV7yiuSaxOF8S5QgeJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O57yjx2RSqNNfVFgM4Sa2knEq1ZKA+i1SN6n5puap0vSBsKNm0/UvGLjr5n7f0uTlGS/l32QPTtySwvtqA9c6CaoJThWp0cWyjqyTizQ3bgCAgCjvrrtS/7vO/AiWWr9G8Xo0DTv0sLhNS+TR1Sby8nTXWa+p48PeVGm4uAFnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMQOxqRU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CaFX6uwD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv8bbuINHQDKNdwNpYMhL0yuOO821Wr4pZ7+LKAoM1A=;
	b=MMQOxqRUM4NKDHM4wuDnL0GvMMoJ4PUR9nJgQd9tcz1/kTxp7sBQz05VWWhYLWM7zJPtX/
	DMEChpiBp7NCUv21ig7RReG3FD/eYeiiT1byC5hbnycOY2jOsdENlZRBxCBdZErd+XJMiK
	tdkHJ5IvEqFHTczWsrZ7B7F/IUSFtcVkhlpqgkIeeKAUGTGntLU9y6Xw+COWV6zITgJYKz
	GpR2EE/PujsU8l/umX6QDccnW1/0wm/bpAkz3omJZgbslpIWzm/D99XqQKmuz1T+qToGbF
	5lyL3un/W2+LAROm/SKFffhn4E5yEjfH2XFTG4c4GsaJoYrvYKKsiMwiAZthGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv8bbuINHQDKNdwNpYMhL0yuOO821Wr4pZ7+LKAoM1A=;
	b=CaFX6uwD8ng7RojFC28/vXG0yAltLfaqeKXLTC9VoQ5uKaHrRNn9VQcoE3y9ad8vMH1NkN
	owqkxegVFMn8l9Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/mm/numa: Move early mptable evaluation into common code
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.931761608@linutronix.de>
References: <20240212154639.931761608@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663293.398.2825267015506832411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     de6aec241750a4f9d33d0e055d97fb3e0170c31a
Gitweb:        https://git.kernel.org/tip/de6aec241750a4f9d33d0e055d97fb3e0170c31a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/mm/numa: Move early mptable evaluation into common code

There is no reason to have the early mptable evaluation conditionally
invoked only from the AMD numa topology code.

Make it explicit and invoke it from setup_arch() right after the
corresponding ACPI init call. Remove the pointless wrapper and invoke
x86_init::mpparse::early_parse_smp_config() directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.931761608@linutronix.de



---
 arch/x86/include/asm/mpspec.h | 5 -----
 arch/x86/kernel/setup.c       | 2 ++
 arch/x86/mm/amdtopology.c     | 7 -------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 82480b7..b423d11 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -46,11 +46,6 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void early_get_smp_config(void)
-{
-	x86_init.mpparse.early_parse_smp_cfg();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1a3d66f..b1e52ac 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1088,7 +1088,9 @@ void __init setup_arch(char **cmdline_p)
 
 	early_platform_quirks();
 
+	/* Some platforms need the APIC registered for NUMA configuration */
 	early_acpi_boot_init();
+	x86_init.mpparse.early_parse_smp_cfg();
 
 	x86_flattree_get_config();
 
diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index 5681b99..9332b36 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -161,13 +161,6 @@ int __init amd_numa_init(void)
 	 */
 	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);
 
-	/*
-	 * Scan MPTABLE to map the local APIC and ensure that the boot CPU
-	 * APIC ID is valid. This is required because on pre ACPI/SRAT
-	 * systems IO-APICs are mapped before the boot CPU.
-	 */
-	early_get_smp_config();
-
 	apicid = boot_cpu_physical_apicid;
 	if (apicid > 0)
 		pr_info("BSP APIC ID: %02x\n", apicid);

