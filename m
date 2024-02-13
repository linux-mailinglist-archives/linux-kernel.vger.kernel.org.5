Return-Path: <linux-kernel+bounces-64263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32346853CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB0AB2159C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1E65BBB;
	Tue, 13 Feb 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqFb6sev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odwG76Tc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764662143
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858296; cv=none; b=F8merFQQ+hBSvHypWX3btt2gracsH8rffajoqPOgMk+WFurNVdZpzAL/7q3+cNFpfOVZpE+3PWgz+kKpbyBDQRQN3QNv1jGjmmHR3ovmVepSLsA5KpRsmyjuWoXorY538Ktq2tQMXBvNzPyU+FR82f3gSY6b72H29xQAAJ1asa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858296; c=relaxed/simple;
	bh=aQ/WRJcGAnYz0eB/RKTmnuv6k9d8ICuhSUt4qaFk3G4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RnDRbe9607hS3m82c/kfJ3GMHrzUMAGlkJx5VdyWlR5VQ1d6REI45laRpyKFSXRFdqnDacNvtjqi+klEhVdvAIbEYp9c5sL1CwAtSRL6J6/bnJ+t6QNheyJVit7DEPTMJgy9y2AI7DcX2vozQqI2k/sMR9v/n3sfdnmHsNK4Jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqFb6sev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odwG76Tc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154638.931617775@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GovnX+qwTLFYGp3VaSElTcFgPMe840TfSXm8J7h8Iw0=;
	b=bqFb6sev3sOxE5nF6sttxKWqRZ8DSRNz7tcMU3qQsZn4+QZOGfF84h0+1E6SrutEb2shm8
	WGgaW35OgNLXQF3ANzoG+oh1QKsaCwwZSSo8Lp369Vuc6v5eEViDUAcbbGhCelft3DJbm6
	6dAjaphyeQEvnObhFYwuECcNyR22vf8phipwLjyZQU/YeqHNg18XS6M+NdWAaTV5VXPhaV
	+rcxwKxryEZS/LjnGlqNCmfMScUg0ippwDobem+Lpt5osu+5OmDQIynh8ZCjbPbbcfepCH
	1QFCqFVwNHG3MjEut1/D+GTGHDzeIOoaBosDN4BrdfhHZkxw61IMb1P9qSR8KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GovnX+qwTLFYGp3VaSElTcFgPMe840TfSXm8J7h8Iw0=;
	b=odwG76TcjtMwQBgf5e6lBpmP7hxPGS+LbqnqYA/lkO+tfhZvx0TE5qa5vunAStz6loNjOz
	k2U1pE+4sug/mNDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 02/22] x86/platform/ce4100: Dont override
 x86_init.mpparse.setup_ioapic_ids
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:53 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is no point to do that. The ATOMs have an XAPIC for which this
function is a pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/io_apic.h    |    1 -
 arch/x86/kernel/apic/io_apic.c    |    2 +-
 arch/x86/platform/ce4100/ce4100.c |    1 -
 3 files changed, 1 insertion(+), 3 deletions(-)
---

--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -140,7 +140,6 @@ extern void mask_ioapic_entries(void);
 extern int restore_ioapic_entries(void);
 
 extern void setup_ioapic_ids_from_mpc(void);
-extern void setup_ioapic_ids_from_mpc_nocheck(void);
 
 extern int mp_find_ioapic(u32 gsi);
 extern int mp_find_ioapic_pin(int ioapic, u32 gsi);
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
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -139,7 +139,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	x86_init.mpparse.find_smp_config = x86_init_noop;
-	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc_nocheck;
 	x86_init.pci.init = ce4100_pci_init;
 	x86_init.pci.init_irq = sdv_pci_init;
 




