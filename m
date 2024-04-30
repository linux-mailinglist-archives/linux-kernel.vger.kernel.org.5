Return-Path: <linux-kernel+bounces-163377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF008B6A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512B5B22841
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53C179B2;
	Tue, 30 Apr 2024 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uow9lVxo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbHNhm3s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66987C2ED;
	Tue, 30 Apr 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456773; cv=none; b=Fyqk3IFwCwk/U0mS2AoCW44obQlHl10ejZO/71Msz6TATTS44+gmDx92E8kqTxeglxYHntWH7psTbAALXu/DrQqf/hGVE5pkrLCuE6zguTVvmerM8zCVlJZXfPOlMYbt2pc7MB2GCyBIov+txE/4k/p9P4mYGZfpJDp8hFmAPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456773; c=relaxed/simple;
	bh=63pR+D8SLU0AmxY1Ig0doGdZqju8basy758ixSyNY3Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nQP9FHdgaFeA2ctzfIcS7IOpbMxNwfbd2COCBjzJWKiz63p/E8XAQQhED2aZgutF9vF80lUKLYpJvNS3dkFaXTRVzsI+NL6/Pt61MgDehCotZXMYqX9jk+494/xB7b9jLSDB75TZo8W9BL/nwWpmNR0haC4RVY3c3Sz5T1mYvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uow9lVxo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbHNhm3s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 05:59:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714456769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yuvnelorU5djLDZU8ZNp9EAchmWQCIPVhuEq9kqqtw=;
	b=Uow9lVxoZh7FPKxS/UP6fVZtcEtS7ahE9S6Bm4ahKkkxSzmyBN/gktS1yZ2ioQyHN6X/SK
	rNwM8C75B7P4BScv+VDUtPpj4oteOXW73YTR3lgWWyP8AJqf+JJlr5VvFOu3WNvhI4olCh
	iNd2H874WlOjLFRbw3eElCXryRGNuVa3aGWJBtjxh2WUyp3NCczGxqDei0T0lw/flADQLo
	ZnwL/IbybwiWPejw9ZTT/KcMsSWiNSEcRPjVNCnUR255t7WLs+6o3sBWXJPY04HthMgwXj
	MxU74oVusiK74hmqKoL6Yb02xFWDX3Z2992lm6JnMIxa72xD8ycwAnHQhAQ67w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714456769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yuvnelorU5djLDZU8ZNp9EAchmWQCIPVhuEq9kqqtw=;
	b=vbHNhm3sUI7fXtGfDZxgepkGXqpBYmr7OihyMaa1fC1nkyahXzWw46hiKkOGVmRwq7NmpJ
	tFHwDfOJQ7jauQCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/apic: Don't access the APIC when disabling x2APIC
Cc: Adrian Huang <ahuang12@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <875xw5t6r7.ffs@tglx>
References: <875xw5t6r7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171445676862.10875.4814911048680168343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     720a22fd6c1cdadf691281909950c0cbc5cdf17e
Gitweb:        https://git.kernel.org/tip/720a22fd6c1cdadf691281909950c0cbc5cdf17e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Apr 2024 00:30:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 30 Apr 2024 07:51:34 +02:00

x86/apic: Don't access the APIC when disabling x2APIC

With 'iommu=off' on the kernel command line and x2APIC enabled by the BIOS
the code which disables the x2APIC triggers an unchecked MSR access error:

  RDMSR from 0x802 at rIP: 0xffffffff94079992 (native_apic_msr_read+0x12/0x50)

This is happens because default_acpi_madt_oem_check() selects an x2APIC
driver before the x2APIC is disabled.

When the x2APIC is disabled because interrupt remapping cannot be enabled
due to 'iommu=off' on the command line, x2apic_disable() invokes
apic_set_fixmap() which in turn tries to read the APIC ID. This triggers
the MSR warning because x2APIC is disabled, but the APIC driver is still
x2APIC based.

Prevent that by adding an argument to apic_set_fixmap() which makes the
APIC ID read out conditional and set it to false from the x2APIC disable
path. That's correct as the APIC ID has already been read out during early
discovery.

Fixes: d10a904435fa ("x86/apic: Consolidate boot_cpu_physical_apicid initialization sites")
Reported-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Adrian Huang <ahuang12@lenovo.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/875xw5t6r7.ffs@tglx
---
 arch/x86/kernel/apic/apic.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c342c4a..803dcfb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1771,7 +1771,7 @@ void x2apic_setup(void)
 	__x2apic_enable();
 }
 
-static __init void apic_set_fixmap(void);
+static __init void apic_set_fixmap(bool read_apic);
 
 static __init void x2apic_disable(void)
 {
@@ -1793,7 +1793,12 @@ static __init void x2apic_disable(void)
 	}
 
 	__x2apic_disable();
-	apic_set_fixmap();
+	/*
+	 * Don't reread the APIC ID as it was already done from
+	 * check_x2apic() and the APIC driver still is a x2APIC variant,
+	 * which fails to do the read after x2APIC was disabled.
+	 */
+	apic_set_fixmap(false);
 }
 
 static __init void x2apic_enable(void)
@@ -2057,13 +2062,14 @@ void __init init_apic_mappings(void)
 	}
 }
 
-static __init void apic_set_fixmap(void)
+static __init void apic_set_fixmap(bool read_apic)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
 	apic_mmio_base = APIC_BASE;
 	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 		    apic_mmio_base, mp_lapic_addr);
-	apic_read_boot_cpu_id(false);
+	if (read_apic)
+		apic_read_boot_cpu_id(false);
 }
 
 void __init register_lapic_address(unsigned long address)
@@ -2073,7 +2079,7 @@ void __init register_lapic_address(unsigned long address)
 	mp_lapic_addr = address;
 
 	if (!x2apic_mode)
-		apic_set_fixmap();
+		apic_set_fixmap(true);
 }
 
 /*

