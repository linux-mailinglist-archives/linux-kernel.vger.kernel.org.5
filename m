Return-Path: <linux-kernel+bounces-68840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E18580DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918BF1C22806
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCB14D456;
	Fri, 16 Feb 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyTLGa8q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C02rGb6l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8314AD17;
	Fri, 16 Feb 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096648; cv=none; b=JMo38Vt+/GV/1ijUaJugFi2b3gzlw09125pRuCUHiP0eEMztVQdqS/t3D4gYKTiwN11XifDBghAuvjt94r2VSFl1MBAqIUjp5g+E8XCkbRHdEPX7ce5dNdvwMMNl2rIbd0hxnyI7zq7GZU4ZXUmfJKj02ZhK7nnPVaUMeG8c+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096648; c=relaxed/simple;
	bh=M8q/kHpKH5Dihkqrw25gGNlgs1VbqV7RvL6J2nr1eIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bMs3dY4/PaGMFHRVF05fyCdRYaKZZrnjwfK3/ItNBtyqL3ErCiD5WLlWhdDFl+KlUs4kJzQG4DSp2n9E87I76bTha/JQ8VRCJUis/HVScmiB645+bbil9W4ldY4OY652pIdJwD8I+7O/kZDsnahl+HEz2blesPuIDBmLRB3LEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RyTLGa8q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C02rGb6l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84QFsycowCIMLQzC88Z0LJw+dXeZdzd5i38/NoYzLTA=;
	b=RyTLGa8qnD+UcIn+DjyfhNd/U/NFr7vhh6M2G0OyKvQXU/2z/Htw3FYzN5EIZsd9Advazq
	B8Fd5L50YBxI6TK8BZ/QzKo4RP1ICL2T/LZCiYt76Sk1fmsKpR2EAjAu46QSDi4vYfY1ze
	mfpkew/vhVipRnMV7A/l4Hs4FTjIJtZ+lXFtWI/vU5sOZeNYFmu9faY5j4VPQ8b+7EgI77
	YY72fYUA9XlaD+64XeMxZDGjtTjKrqI589YuqqgV6zUEusR4Z4SRd6Y3Af+ydweolzJuxf
	9MmAV43N5V3A29iP3OHgn42w1sWzSfoNtRM1dhmJflnr5DGWkdPx9XHll7FBow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84QFsycowCIMLQzC88Z0LJw+dXeZdzd5i38/NoYzLTA=;
	b=C02rGb6lIX3SEtX94HoZ/K8ZUQxvnrmtzEiUSijJ49ZQpdukMlyNdCcQOzJYBtZfkKUYJK
	b01iVmQJ9uqzGnBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/platform/ce4100: Dont override
 x86_init.mpparse.setup_ioapic_ids
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154638.931617775@linutronix.de>
References: <20240212154638.931617775@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664355.398.5355977368434853748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     490cc3c5e724502667a104a4e818dc071faf5e77
Gitweb:        https://git.kernel.org/tip/490cc3c5e724502667a104a4e818dc071faf5e77
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/platform/ce4100: Dont override x86_init.mpparse.setup_ioapic_ids

There is no point to do that. The ATOMs have an XAPIC for which this
function is a pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154638.931617775@linutronix.de



---
 arch/x86/include/asm/io_apic.h    | 1 -
 arch/x86/kernel/apic/io_apic.c    | 2 +-
 arch/x86/platform/ce4100/ce4100.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 51c7826..0d80651 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -140,7 +140,6 @@ extern void mask_ioapic_entries(void);
 extern int restore_ioapic_entries(void);
 
 extern void setup_ioapic_ids_from_mpc(void);
-extern void setup_ioapic_ids_from_mpc_nocheck(void);
 
 extern int mp_find_ioapic(u32 gsi);
 extern int mp_find_ioapic_pin(int ioapic, u32 gsi);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 40c7cf1..e71745e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1458,7 +1458,7 @@ void restore_boot_irq_mode(void)
  *
  * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
  */
-void __init setup_ioapic_ids_from_mpc_nocheck(void)
+static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
 	union IO_APIC_reg_00 reg_00;
 	physid_mask_t phys_id_present_map;
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 4074566..bbe7e91 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -139,7 +139,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	x86_init.mpparse.find_smp_config = x86_init_noop;
-	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc_nocheck;
 	x86_init.pci.init = ce4100_pci_init;
 	x86_init.pci.init_irq = sdv_pci_init;
 

