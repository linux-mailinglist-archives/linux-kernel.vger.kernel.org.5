Return-Path: <linux-kernel+bounces-64272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE89853CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BB91C2212D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4D6E2A2;
	Tue, 13 Feb 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLHrOvBh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NuecDBnh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036869DF6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858309; cv=none; b=bFmg4xZj7q1kQRrGYAfKbNpgJYRfyzGc6z1vyJ+j5Q/8z18S2Je5w0nPkxmb1fb+ptdBCtp+6hnNDerwerduABCZpgBDO1JUW14ekHHHWvEAOgSdfVje8PO/PX+Dsx/rHhQor5p9XwZlBGmlasK5UbFl5oW3HjrHtbH/zq7HubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858309; c=relaxed/simple;
	bh=/py/Xwe4fVOjWrl4DdrzzF4uh9lZ5bJilDGGPUdzVcE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rWswpz+Ulen6SmEFHxuJ1pndNHqCdL4ex8DTLj+6QhNfybETxcOq+vSsbWNkYt5tFsyCsTXyZMV7cmZ0ZOhCNaiAS8rD8hBf5iYYFMcpprYCIy0nISmop8TRyKbUgITQX6BI7bldvvUP+irXsVVplc6I7scbdCk45cm2edPSkeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLHrOvBh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NuecDBnh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.495992801@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WKnV8cmjnyf4puxHx+D7XpKpE60kVjCp3v5e0THf4uQ=;
	b=iLHrOvBhUiVQ+lAlywu1m0FNEbSHk9En+wXJu3GH8iICNq8mVmYmI6QITL5uXwGSnhTH4q
	LDg2C3mBlce6TI57o42y563bZiYt0oa9/1PSQgNRi6GItM8tiEWmZfAZb/ELr1Y32mffez
	TgqiAplPymAa3cgXb3uLu6ReZ06mjlvG0VAp3wmzIKU1jB09Dbn3FgMakR8N9oox/q6ECh
	zqIRB+wjh28yA2Z6ccE1E8TC1/iOvzjpPNM+5QdLSD6nwdhNdsNh0npSg/O7hyz5YEhbNv
	mudmSCXofygbH/vCSug8j0e0dZ2gtOjxvMs5h/18jji6H2aTs52h5qYtclFRiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WKnV8cmjnyf4puxHx+D7XpKpE60kVjCp3v5e0THf4uQ=;
	b=NuecDBnhFy9QlNmopDT55NyFKeD2nW5Bg1stDtJce9OjL3VpgOk2RLCJdy2p9ng+WMKtlx
	GmuBK4xR0HYq1WDA==
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
Subject: [patch V3 11/22] x86/dtb: Rename x86_dtb_init()
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:06 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

x86_dtb_init() is a misnomer and it really should be used as a SMP
configuration parser which is selected by the platform via
x86_init::mpparse:parse_smp_config().

Rename it to x86_dtb_parse_smp_config() in preparation for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/prom.h  |    4 ++--
 arch/x86/kernel/devicetree.c |    2 +-
 arch/x86/kernel/setup.c      |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
---

--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,11 +23,11 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_init(void);
+void x86_dtb_parse_smp_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_init(void) { }
+static inline void x86_dtb_parse_smp_config(void) { }
 #define of_ioapic 0
 #endif
 
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -302,7 +302,7 @@ void __init x86_flattree_get_config(void
 }
 #endif
 
-void __init x86_dtb_init(void)
+void __init x86_dtb_parse_smp_config(void)
 {
 	if (!of_have_populated_dt())
 		return;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1131,7 +1131,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
-	x86_dtb_init();
+	x86_dtb_parse_smp_config();
 
 	/*
 	 * get boot-time SMP configuration:



