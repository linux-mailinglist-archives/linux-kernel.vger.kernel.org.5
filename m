Return-Path: <linux-kernel+bounces-129117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B549896535
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DB71F23DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31C55C29;
	Wed,  3 Apr 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PGGG7yAk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="daRPRkI4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2864D13B;
	Wed,  3 Apr 2024 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127596; cv=none; b=pK6vZiKZbmfi/xl3m3S/LOcyI9bfQRFdVNuiaCoVdjEfZmM1uuExCdIO3rjHzeR9JD73Alagp3ihWX3PoJdt1GTGRNI++b74E/Kp+FDLFVNc24uncbGn0q8FJmOVlSpWmQJEDVg6KkjkAE0hLdNz2jtPXIrChNHiOK/JA33bppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127596; c=relaxed/simple;
	bh=OMu4Ow82kA0QbAkpQeKmd+fAJKan59UG9MCRd1Ud31Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qUwIGUJ98Ct/Fbd4pXZjXtWIIKHXwHFwO0zapRRGib0cWxG2rwv3sA/juLL7275kkQB/tAlLkGo6c7thTmc3DqvbP8Z8iI/znWIRldY1p7w3jEWS7dvZWpOtWd9I9OOibbhe1r11XClMvxpJ/rbI2cpOiW5DsyV6LDVZRaUuzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PGGG7yAk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=daRPRkI4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 06:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712127592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ON/M2PgUF5GWdoAdKTKqNpLjfTY2s81CIZQgUzkSHrA=;
	b=PGGG7yAki2aQWFbIWDRnQ39qFoiL1oKoPyJVPwwDpeMpX4+Bp51RRgO372Z+/JIpAOPuTL
	dX9Mp4BwtOcfb+PkQVqcRCXuz1QZUt37lVfpjaAX0rmTx83ehCDUsWgn76JwmutVfO1Krx
	kWTluEtSpYvsRMPJ/rbelO5ipxPpS3e9qwxkEJACHFUlq94okhziOQS72DIe1cjYZ9eJaB
	LeGDcGhXl7VtINP563KQCuKf6rcJsaFteIkJUSQGgu7qzFkGtjC+guj+2MiuM0F5ijQDUk
	R8vUMY71uDi0Wt5fji8/Rvp5pI417HhczwD6uqEz0cYtBUYlaNJ7OEj4FQSv8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712127592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ON/M2PgUF5GWdoAdKTKqNpLjfTY2s81CIZQgUzkSHrA=;
	b=daRPRkI4tNmCsLUq9GdxeK5gBoLQyLRe9fzAU0X0PGywqdAtvPR+nD3rhG67pVFc1etTFa
	RHZsJXsAjP1Z39CA==
From: "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/of: Map NUMA node to CPUs as per DeviceTree
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712068830-4513-4-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-4-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171212759135.10875.13008794555300700297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     85900d061884de85f557a06cf56ff69dfae07e26
Gitweb:        https://git.kernel.org/tip/85900d061884de85f557a06cf56ff69dfae07e26
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Tue, 02 Apr 2024 07:40:29 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 08:49:15 +02:00

x86/of: Map NUMA node to CPUs as per DeviceTree

Currently for DeviceTree bootup, x86 code does the default mapping of
CPUs to NUMA, which is wrong. This can cause incorrect mapping and WARNs
on SMT enabled systems:

  CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
  WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
  match_smt+0xf6/0xfc
  set_cpu_sibling_map.cold+0x24f/0x512
  start_secondary+0x5c/0x110

Call the set_apicid_to_node() function in dtb_cpu_setup() for setting
the NUMA to CPU mapping for DeviceTree platforms.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1712068830-4513-4-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/kernel/devicetree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 0d3a50e..b93ce8a 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -24,6 +24,7 @@
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
 #include <asm/i8259.h>
+#include <asm/numa.h>
 #include <asm/prom.h>
 
 __initdata u64 initial_dtb;
@@ -137,6 +138,7 @@ static void __init dtb_cpu_setup(void)
 			continue;
 		}
 		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+		set_apicid_to_node(apic_id, of_node_to_nid(dn));
 	}
 }
 

